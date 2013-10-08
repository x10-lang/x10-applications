/*************************************************/
/* START of Grid */
#include <Grid.h>

#include <x10/lang/Double.h>
#include <x10/lang/Int.h>
#include <x10/lang/Rail.h>

//#line 3 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Grid.x10": x10.ast.X10FieldDecl_c

//#line 4 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Grid.x10": x10.ast.X10FieldDecl_c

//#line 5 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Grid.x10": x10.ast.X10FieldDecl_c

//#line 6 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Grid.x10": x10.ast.X10FieldDecl_c

//#line 8 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Grid.x10": x10.ast.X10ConstructorDecl_c
void Grid::_constructor() {
    
    //#line 8 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Grid.x10": polyglot.ast.Empty_c
    ;
    
    //#line 8 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Grid.x10": x10.ast.AssignPropertyCall_c
    
    //#line 2 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Grid.x10": Eval of x10.ast.X10Call_c
    this->Grid::__fieldInitializers_Grid();
    
    //#line 9 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Grid.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(size) = x10::lang::Rail<x10_double >::_make(((x10_long)3ll));
    
    //#line 10 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Grid.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(coords) = x10::lang::Rail<x10_double >::_make(((x10_long)6ll));
    
    //#line 11 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Grid.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(nabes) = x10::lang::Rail<x10_int >::_make(((x10_long)6ll));
    
    //#line 12 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Grid.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(proc_coords) = x10::lang::Rail<x10_int >::_make(((x10_long)3ll));
}
Grid* Grid::_make() {
    Grid* this_ = new (memset(x10aux::alloc<Grid>(), 0, sizeof(Grid))) Grid();
    this_->_constructor();
    return this_;
}



//#line 2 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Grid.x10": x10.ast.X10MethodDecl_c
Grid* Grid::Grid____this__Grid() {
    
    //#line 2 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Grid.x10": x10.ast.X10Return_c
    return this;
    
}

//#line 2 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Grid.x10": x10.ast.X10MethodDecl_c
void Grid::__fieldInitializers_Grid() {
    
    //#line 2 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Grid.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(size) = (x10aux::class_cast_unchecked<x10::lang::Rail<x10_double >*>(reinterpret_cast<x10::lang::NullType*>(X10_NULL)));
    
    //#line 2 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Grid.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(coords) = (x10aux::class_cast_unchecked<x10::lang::Rail<x10_double >*>(reinterpret_cast<x10::lang::NullType*>(X10_NULL)));
    
    //#line 2 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Grid.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(nabes) = (x10aux::class_cast_unchecked<x10::lang::Rail<x10_int >*>(reinterpret_cast<x10::lang::NullType*>(X10_NULL)));
    
    //#line 2 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Grid.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(proc_coords) = (x10aux::class_cast_unchecked<x10::lang::Rail<x10_int >*>(reinterpret_cast<x10::lang::NullType*>(X10_NULL)));
}
const x10aux::serialization_id_t Grid::_serialization_id = 
    x10aux::DeserializationDispatcher::addDeserializer(Grid::_deserializer, x10aux::CLOSURE_KIND_NOT_ASYNC);

void Grid::_serialize_body(x10aux::serialization_buffer& buf) {
    buf.write(this->FMGL(size));
    buf.write(this->FMGL(coords));
    buf.write(this->FMGL(nabes));
    buf.write(this->FMGL(proc_coords));
    
}

x10::lang::Reference* Grid::_deserializer(x10aux::deserialization_buffer& buf) {
    Grid* this_ = new (memset(x10aux::alloc<Grid>(), 0, sizeof(Grid))) Grid();
    buf.record_reference(this_);
    this_->_deserialize_body(buf);
    return this_;
}

void Grid::_deserialize_body(x10aux::deserialization_buffer& buf) {
    FMGL(size) = buf.read<x10::lang::Rail<x10_double >*>();
    FMGL(coords) = buf.read<x10::lang::Rail<x10_double >*>();
    FMGL(nabes) = buf.read<x10::lang::Rail<x10_int >*>();
    FMGL(proc_coords) = buf.read<x10::lang::Rail<x10_int >*>();
}

x10aux::RuntimeType Grid::rtt;
void Grid::_initRTT() {
    if (rtt.initStageOne(&rtt)) return;
    const x10aux::RuntimeType** parents = NULL; 
    rtt.initStageTwo("Grid",x10aux::RuntimeType::class_kind, 0, parents, 0, NULL, NULL);
}

/* END of Grid */
/*************************************************/
