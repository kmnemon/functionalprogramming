package copy

func DeepCopy[T any](src T) T {
	if src == nil {
		var zero T
		return zero
	}

	visited := make(map[uintptr]reflect.Value)
	v := reflect.ValueOf(src)
	cpy := deepCopy(v, visited)
	return cpy.Interface().(T)
}

func deepCopy(v reflect.Value, visited map[uintptr]reflect.Value) reflect.Value {
	if !v.IsValid() {
		return v
	}

	switch v.Kind() {
	case reflect.Bool, reflect.Int, reflect.Int8, reflect.Int16, reflect.Int32, reflect.Int64,
		reflect.Uint, reflect.Uint8, reflect.Uint16, reflect.Uint32, reflect.Uint64, reflect.Uintptr,
		reflect.Float32, reflect.Float64, reflect.Complex64, reflect.Complex128, reflect.String:
		return v

	case reflect.Array:
		cpy := reflect.New(v.Type()).Elem()
		for i := 0; i < v.Len(); i++ {
			cpy.Index(i).Set(deepCopy(v.Index(i), visited))
		}
		return cpy

	case reflect.Slice:
		if v.IsNil() {
			return reflect.Zero(v.Type())
		}
		cpy := reflect.MakeSlice(v.Type(), v.Len(), v.Cap())
		visited[v.Pointer()] = cpy
		for i := 0; i < v.Len(); i++ {
			cpy.Index(i).Set(deepCopy(v.Index(i), visited))
		}
		return cpy

	case reflect.Map:
		if v.IsNil() {
			return reflect.Zero(v.Type())
		}
		cpy := reflect.MakeMapWithSize(v.Type(), v.Len())
		visited[v.Pointer()] = cpy
		for iter := v.MapRange(); iter.Next(); {
			key := deepCopy(iter.Key(), visited)
			value := deepCopy(iter.Value(), visited)
			cpy.SetMapIndex(key, value)
		}
		return cpy

	case reflect.Ptr:
		if v.IsNil() {
			return reflect.Zero(v.Type())
		}
		ptr := v.Pointer()
		if cpy, exists := visited[ptr]; exists {
			return cpy
		}
		cpy := reflect.New(v.Type().Elem())
		visited[ptr] = cpy
		cpy.Elem().Set(deepCopy(v.Elem(), visited))
		return cpy

	case reflect.Interface:
		if v.IsNil() {
			return reflect.Zero(v.Type())
		}
		concrete := v.Elem()
		if concrete.Kind() == reflect.Ptr {
			ptr := concrete.Pointer()
			if cpy, exists := visited[ptr]; exists {
				return cpy
			}
		}
		cpy := deepCopy(concrete, visited)
		return cpy.Convert(v.Type())

	case reflect.Struct:
		cpy := reflect.New(v.Type()).Elem()
		for i := 0; i < v.NumField(); i++ {
			if !v.Type().Field(i).IsExported() {
				continue
			}
			field := v.Field(i)
			cpy.Field(i).Set(deepCopy(field, visited))
		}
		return cpy

	case reflect.Chan:
		if v.IsNil() {
			return reflect.Zero(v.Type())
		}
		cpy := reflect.MakeChan(v.Type(), v.Cap())
		return cpy

	default:
		panic(fmt.Sprintf("unsupported type: %s", v.Kind()))
	}
}