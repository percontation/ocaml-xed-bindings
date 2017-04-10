type 'a fn = 'a Ctypes.fn
type 'a return = 'a

let (@->) = Ctypes.(@->)
let returning = Ctypes.returning

type 'a result = 'a
let foreign x y z = Foreign.foreign x y z
let foreign_value x y = Foreign.foreign_value x y

