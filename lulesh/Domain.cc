/*************************************************/
/* START of Domain */
#include <Domain.h>

#include <x10/lang/Double.h>
#include <x10/lang/Int.h>
#include <x10/array/Array.h>
#include <x10/array/RectRegion1D.h>
#include <x10/array/Region.h>
#include <x10/util/IndexedMemoryChunk.h>
#include <x10/lang/IntRange.h>
#include <x10/lang/Boolean.h>
#include <x10/array/Array__LayoutHelper.h>

//#line 8 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
void Domain::AllocateNodalPersistent(x10_int size) {
    
    //#line 10 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31784 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size94663 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95535 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95509 = ((x10_int) ((size94663) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95535)->::x10::array::RectRegion1D::_constructor(t95509);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95510 = reinterpret_cast<x10::array::Region*>(myReg95535);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31784->FMGL(region) = t95510;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31784->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31784->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31784->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31784->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31784->FMGL(size) = size94663;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95536 = alloc31784->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95537 = alloc31784->FMGL(layout_stride1) = t95536;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31784->FMGL(layout_min0) = t95537;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31784->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95538 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size94663, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31784->FMGL(raw) = t95538;
    
    //#line 10 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_x) = alloc31784;
    
    //#line 11 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31785 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size94668 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95539 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95511 = ((x10_int) ((size94668) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95539)->::x10::array::RectRegion1D::_constructor(t95511);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95512 = reinterpret_cast<x10::array::Region*>(myReg95539);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31785->FMGL(region) = t95512;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31785->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31785->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31785->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31785->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31785->FMGL(size) = size94668;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95540 = alloc31785->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95541 = alloc31785->FMGL(layout_stride1) = t95540;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31785->FMGL(layout_min0) = t95541;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31785->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95542 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size94668, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31785->FMGL(raw) = t95542;
    
    //#line 11 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_y) = alloc31785;
    
    //#line 12 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31786 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size94673 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95543 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95513 = ((x10_int) ((size94673) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95543)->::x10::array::RectRegion1D::_constructor(t95513);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95514 = reinterpret_cast<x10::array::Region*>(myReg95543);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31786->FMGL(region) = t95514;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31786->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31786->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31786->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31786->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31786->FMGL(size) = size94673;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95544 = alloc31786->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95545 = alloc31786->FMGL(layout_stride1) = t95544;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31786->FMGL(layout_min0) = t95545;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31786->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95546 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size94673, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31786->FMGL(raw) = t95546;
    
    //#line 12 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_z) = alloc31786;
    
    //#line 14 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31787 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size94678 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95547 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95515 = ((x10_int) ((size94678) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95547)->::x10::array::RectRegion1D::_constructor(t95515);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95516 = reinterpret_cast<x10::array::Region*>(myReg95547);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31787->FMGL(region) = t95516;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31787->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31787->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31787->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31787->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31787->FMGL(size) = size94678;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95548 = alloc31787->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95549 = alloc31787->FMGL(layout_stride1) = t95548;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31787->FMGL(layout_min0) = t95549;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31787->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95550 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size94678, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31787->FMGL(raw) = t95550;
    
    //#line 14 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_xd) = alloc31787;
    
    //#line 15 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31788 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size94683 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95551 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95517 = ((x10_int) ((size94683) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95551)->::x10::array::RectRegion1D::_constructor(t95517);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95518 = reinterpret_cast<x10::array::Region*>(myReg95551);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31788->FMGL(region) = t95518;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31788->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31788->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31788->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31788->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31788->FMGL(size) = size94683;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95552 = alloc31788->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95553 = alloc31788->FMGL(layout_stride1) = t95552;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31788->FMGL(layout_min0) = t95553;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31788->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95554 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size94683, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31788->FMGL(raw) = t95554;
    
    //#line 15 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_yd) = alloc31788;
    
    //#line 16 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31789 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size94688 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95555 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95519 = ((x10_int) ((size94688) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95555)->::x10::array::RectRegion1D::_constructor(t95519);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95520 = reinterpret_cast<x10::array::Region*>(myReg95555);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31789->FMGL(region) = t95520;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31789->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31789->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31789->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31789->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31789->FMGL(size) = size94688;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95556 = alloc31789->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95557 = alloc31789->FMGL(layout_stride1) = t95556;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31789->FMGL(layout_min0) = t95557;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31789->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95558 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size94688, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31789->FMGL(raw) = t95558;
    
    //#line 16 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_zd) = alloc31789;
    
    //#line 18 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31790 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size94693 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95559 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95521 = ((x10_int) ((size94693) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95559)->::x10::array::RectRegion1D::_constructor(t95521);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95522 = reinterpret_cast<x10::array::Region*>(myReg95559);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31790->FMGL(region) = t95522;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31790->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31790->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31790->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31790->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31790->FMGL(size) = size94693;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95560 = alloc31790->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95561 = alloc31790->FMGL(layout_stride1) = t95560;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31790->FMGL(layout_min0) = t95561;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31790->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95562 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size94693, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31790->FMGL(raw) = t95562;
    
    //#line 18 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_xdd) = alloc31790;
    
    //#line 19 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31791 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size94698 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95563 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95523 = ((x10_int) ((size94698) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95563)->::x10::array::RectRegion1D::_constructor(t95523);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95524 = reinterpret_cast<x10::array::Region*>(myReg95563);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31791->FMGL(region) = t95524;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31791->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31791->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31791->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31791->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31791->FMGL(size) = size94698;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95564 = alloc31791->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95565 = alloc31791->FMGL(layout_stride1) = t95564;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31791->FMGL(layout_min0) = t95565;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31791->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95566 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size94698, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31791->FMGL(raw) = t95566;
    
    //#line 19 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_ydd) = alloc31791;
    
    //#line 20 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31792 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size94703 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95567 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95525 = ((x10_int) ((size94703) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95567)->::x10::array::RectRegion1D::_constructor(t95525);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95526 = reinterpret_cast<x10::array::Region*>(myReg95567);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31792->FMGL(region) = t95526;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31792->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31792->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31792->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31792->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31792->FMGL(size) = size94703;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95568 = alloc31792->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95569 = alloc31792->FMGL(layout_stride1) = t95568;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31792->FMGL(layout_min0) = t95569;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31792->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95570 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size94703, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31792->FMGL(raw) = t95570;
    
    //#line 20 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_zdd) = alloc31792;
    
    //#line 22 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31793 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size94708 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95571 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95527 = ((x10_int) ((size94708) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95571)->::x10::array::RectRegion1D::_constructor(t95527);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95528 = reinterpret_cast<x10::array::Region*>(myReg95571);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31793->FMGL(region) = t95528;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31793->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31793->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31793->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31793->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31793->FMGL(size) = size94708;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95572 = alloc31793->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95573 = alloc31793->FMGL(layout_stride1) = t95572;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31793->FMGL(layout_min0) = t95573;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31793->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95574 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size94708, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31793->FMGL(raw) = t95574;
    
    //#line 22 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_fx) = alloc31793;
    
    //#line 23 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31794 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size94713 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95575 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95529 = ((x10_int) ((size94713) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95575)->::x10::array::RectRegion1D::_constructor(t95529);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95530 = reinterpret_cast<x10::array::Region*>(myReg95575);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31794->FMGL(region) = t95530;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31794->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31794->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31794->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31794->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31794->FMGL(size) = size94713;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95576 = alloc31794->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95577 = alloc31794->FMGL(layout_stride1) = t95576;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31794->FMGL(layout_min0) = t95577;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31794->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95578 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size94713, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31794->FMGL(raw) = t95578;
    
    //#line 23 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_fy) = alloc31794;
    
    //#line 24 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31795 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size94718 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95579 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95531 = ((x10_int) ((size94718) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95579)->::x10::array::RectRegion1D::_constructor(t95531);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95532 = reinterpret_cast<x10::array::Region*>(myReg95579);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31795->FMGL(region) = t95532;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31795->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31795->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31795->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31795->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31795->FMGL(size) = size94718;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95580 = alloc31795->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95581 = alloc31795->FMGL(layout_stride1) = t95580;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31795->FMGL(layout_min0) = t95581;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31795->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95582 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size94718, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31795->FMGL(raw) = t95582;
    
    //#line 24 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_fz) = alloc31795;
    
    //#line 26 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31796 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size94723 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95583 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95533 = ((x10_int) ((size94723) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95583)->::x10::array::RectRegion1D::_constructor(t95533);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95534 = reinterpret_cast<x10::array::Region*>(myReg95583);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31796->FMGL(region) = t95534;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31796->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31796->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31796->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31796->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31796->FMGL(size) = size94723;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95584 = alloc31796->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95585 = alloc31796->FMGL(layout_stride1) = t95584;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31796->FMGL(layout_min0) = t95585;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31796->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95586 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size94723, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31796->FMGL(raw) = t95586;
    
    //#line 26 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_nodalMass) = alloc31796;
}

//#line 30 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
void Domain::AllocateElemPersistent(x10_int size) {
    
    //#line 32 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_int>* alloc31797 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_int> >(), 0, sizeof(x10::array::Array<x10_int>))) x10::array::Array<x10_int>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size94728 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95640 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95587 = ((x10_int) ((size94728) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95640)->::x10::array::RectRegion1D::_constructor(t95587);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95588 = reinterpret_cast<x10::array::Region*>(myReg95640);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31797->FMGL(region) = t95588;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31797->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31797->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31797->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31797->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31797->FMGL(size) = size94728;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95641 = alloc31797->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95642 = alloc31797->FMGL(layout_stride1) = t95641;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31797->FMGL(layout_min0) = t95642;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31797->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_int > t95643 = x10::util::IndexedMemoryChunk<void>::allocate<x10_int >(size94728, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31797->FMGL(raw) = t95643;
    
    //#line 32 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_matElemlist) = alloc31797;
    
    //#line 33 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_int>* alloc31798 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_int> >(), 0, sizeof(x10::array::Array<x10_int>))) x10::array::Array<x10_int>()))
    ;
    
    //#line 33 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_int t95157 = size;
    
    //#line 33 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_int t95158 = ((x10_int) ((t95157) - (((x10_int)1))));
    
    //#line 33 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::lang::IntRange t95159 = x10::lang::IntRange::_make(((x10_int)0), t95158);
    
    //#line 33 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::lang::IntRange t95160 = x10::lang::IntRange::_make(((x10_int)0), ((x10_int)7));
    
    //#line 123 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* reg94733 = t95159->x10::lang::IntRange::__times(t95160);
    
    //#line 125 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95589 = reg94733;
    
    //#line 125 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31798->FMGL(region) = t95589;
    
    //#line 125 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95590 = x10aux::nullCheck(reg94733)->FMGL(rank);
    
    //#line 125 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31798->FMGL(rank) = t95590;
    
    //#line 125 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_boolean t95591 = x10aux::nullCheck(reg94733)->FMGL(rect);
    
    //#line 125 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31798->FMGL(rect) = t95591;
    
    //#line 125 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_boolean t95592 = x10aux::nullCheck(reg94733)->FMGL(zeroBased);
    
    //#line 125 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31798->FMGL(zeroBased) = t95592;
    
    //#line 125 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_boolean t95593 = x10aux::nullCheck(reg94733)->FMGL(rail);
    
    //#line 125 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31798->FMGL(rail) = t95593;
    
    //#line 125 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95594 = x10aux::nullCheck(reg94733)->size();
    
    //#line 125 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31798->FMGL(size) = t95594;
    
    //#line 126 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Array__LayoutHelper crh95644 =  x10::array::Array__LayoutHelper::_alloc();
    
    //#line 126 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (crh95644)->::x10::array::Array__LayoutHelper::_constructor(reg94733);
    
    //#line 127 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95645 = crh95644->FMGL(min0);
    
    //#line 127 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31798->FMGL(layout_min0) = t95645;
    
    //#line 128 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95646 = crh95644->FMGL(stride1);
    
    //#line 128 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31798->FMGL(layout_stride1) = t95646;
    
    //#line 129 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95647 = crh95644->FMGL(min1);
    
    //#line 129 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31798->FMGL(layout_min1) = t95647;
    
    //#line 130 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_int>* t95648 = crh95644->FMGL(layout);
    
    //#line 130 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31798->FMGL(layout) = t95648;
    
    //#line 131 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int n95649 = crh95644->FMGL(size);
    
    //#line 132 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_int > t95650 = x10::util::IndexedMemoryChunk<void>::allocate<x10_int >(n95649, 8, false, true);
    
    //#line 132 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31798->FMGL(raw) = t95650;
    
    //#line 33 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_nodelist) = alloc31798;
    
    //#line 35 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_int>* alloc31799 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_int> >(), 0, sizeof(x10::array::Array<x10_int>))) x10::array::Array<x10_int>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size94737 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95651 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95595 = ((x10_int) ((size94737) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95651)->::x10::array::RectRegion1D::_constructor(t95595);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95596 = reinterpret_cast<x10::array::Region*>(myReg95651);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31799->FMGL(region) = t95596;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31799->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31799->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31799->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31799->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31799->FMGL(size) = size94737;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95652 = alloc31799->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95653 = alloc31799->FMGL(layout_stride1) = t95652;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31799->FMGL(layout_min0) = t95653;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31799->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_int > t95654 = x10::util::IndexedMemoryChunk<void>::allocate<x10_int >(size94737, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31799->FMGL(raw) = t95654;
    
    //#line 35 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_lxim) = alloc31799;
    
    //#line 36 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_int>* alloc31800 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_int> >(), 0, sizeof(x10::array::Array<x10_int>))) x10::array::Array<x10_int>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size94742 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95655 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95597 = ((x10_int) ((size94742) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95655)->::x10::array::RectRegion1D::_constructor(t95597);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95598 = reinterpret_cast<x10::array::Region*>(myReg95655);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31800->FMGL(region) = t95598;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31800->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31800->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31800->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31800->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31800->FMGL(size) = size94742;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95656 = alloc31800->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95657 = alloc31800->FMGL(layout_stride1) = t95656;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31800->FMGL(layout_min0) = t95657;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31800->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_int > t95658 = x10::util::IndexedMemoryChunk<void>::allocate<x10_int >(size94742, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31800->FMGL(raw) = t95658;
    
    //#line 36 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_lxip) = alloc31800;
    
    //#line 37 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_int>* alloc31801 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_int> >(), 0, sizeof(x10::array::Array<x10_int>))) x10::array::Array<x10_int>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size94747 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95659 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95599 = ((x10_int) ((size94747) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95659)->::x10::array::RectRegion1D::_constructor(t95599);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95600 = reinterpret_cast<x10::array::Region*>(myReg95659);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31801->FMGL(region) = t95600;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31801->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31801->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31801->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31801->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31801->FMGL(size) = size94747;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95660 = alloc31801->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95661 = alloc31801->FMGL(layout_stride1) = t95660;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31801->FMGL(layout_min0) = t95661;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31801->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_int > t95662 = x10::util::IndexedMemoryChunk<void>::allocate<x10_int >(size94747, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31801->FMGL(raw) = t95662;
    
    //#line 37 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_letam) = alloc31801;
    
    //#line 38 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_int>* alloc31802 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_int> >(), 0, sizeof(x10::array::Array<x10_int>))) x10::array::Array<x10_int>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size94752 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95663 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95601 = ((x10_int) ((size94752) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95663)->::x10::array::RectRegion1D::_constructor(t95601);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95602 = reinterpret_cast<x10::array::Region*>(myReg95663);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31802->FMGL(region) = t95602;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31802->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31802->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31802->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31802->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31802->FMGL(size) = size94752;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95664 = alloc31802->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95665 = alloc31802->FMGL(layout_stride1) = t95664;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31802->FMGL(layout_min0) = t95665;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31802->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_int > t95666 = x10::util::IndexedMemoryChunk<void>::allocate<x10_int >(size94752, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31802->FMGL(raw) = t95666;
    
    //#line 38 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_letap) = alloc31802;
    
    //#line 39 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_int>* alloc31803 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_int> >(), 0, sizeof(x10::array::Array<x10_int>))) x10::array::Array<x10_int>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size94757 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95667 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95603 = ((x10_int) ((size94757) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95667)->::x10::array::RectRegion1D::_constructor(t95603);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95604 = reinterpret_cast<x10::array::Region*>(myReg95667);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31803->FMGL(region) = t95604;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31803->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31803->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31803->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31803->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31803->FMGL(size) = size94757;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95668 = alloc31803->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95669 = alloc31803->FMGL(layout_stride1) = t95668;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31803->FMGL(layout_min0) = t95669;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31803->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_int > t95670 = x10::util::IndexedMemoryChunk<void>::allocate<x10_int >(size94757, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31803->FMGL(raw) = t95670;
    
    //#line 39 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_lzetam) = alloc31803;
    
    //#line 40 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_int>* alloc31804 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_int> >(), 0, sizeof(x10::array::Array<x10_int>))) x10::array::Array<x10_int>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size94762 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95671 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95605 = ((x10_int) ((size94762) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95671)->::x10::array::RectRegion1D::_constructor(t95605);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95606 = reinterpret_cast<x10::array::Region*>(myReg95671);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31804->FMGL(region) = t95606;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31804->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31804->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31804->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31804->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31804->FMGL(size) = size94762;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95672 = alloc31804->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95673 = alloc31804->FMGL(layout_stride1) = t95672;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31804->FMGL(layout_min0) = t95673;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31804->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_int > t95674 = x10::util::IndexedMemoryChunk<void>::allocate<x10_int >(size94762, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31804->FMGL(raw) = t95674;
    
    //#line 40 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_lzetap) = alloc31804;
    
    //#line 42 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_int>* alloc31805 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_int> >(), 0, sizeof(x10::array::Array<x10_int>))) x10::array::Array<x10_int>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size94767 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95675 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95607 = ((x10_int) ((size94767) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95675)->::x10::array::RectRegion1D::_constructor(t95607);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95608 = reinterpret_cast<x10::array::Region*>(myReg95675);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31805->FMGL(region) = t95608;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31805->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31805->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31805->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31805->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31805->FMGL(size) = size94767;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95676 = alloc31805->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95677 = alloc31805->FMGL(layout_stride1) = t95676;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31805->FMGL(layout_min0) = t95677;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31805->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_int > t95678 = x10::util::IndexedMemoryChunk<void>::allocate<x10_int >(size94767, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31805->FMGL(raw) = t95678;
    
    //#line 42 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_elemBC) = alloc31805;
    
    //#line 44 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31806 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size94772 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95679 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95609 = ((x10_int) ((size94772) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95679)->::x10::array::RectRegion1D::_constructor(t95609);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95610 = reinterpret_cast<x10::array::Region*>(myReg95679);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31806->FMGL(region) = t95610;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31806->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31806->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31806->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31806->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31806->FMGL(size) = size94772;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95680 = alloc31806->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95681 = alloc31806->FMGL(layout_stride1) = t95680;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31806->FMGL(layout_min0) = t95681;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31806->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95682 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size94772, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31806->FMGL(raw) = t95682;
    
    //#line 44 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_e) = alloc31806;
    
    //#line 46 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31807 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size94777 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95683 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95611 = ((x10_int) ((size94777) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95683)->::x10::array::RectRegion1D::_constructor(t95611);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95612 = reinterpret_cast<x10::array::Region*>(myReg95683);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31807->FMGL(region) = t95612;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31807->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31807->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31807->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31807->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31807->FMGL(size) = size94777;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95684 = alloc31807->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95685 = alloc31807->FMGL(layout_stride1) = t95684;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31807->FMGL(layout_min0) = t95685;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31807->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95686 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size94777, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31807->FMGL(raw) = t95686;
    
    //#line 46 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_p) = alloc31807;
    
    //#line 47 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31808 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size94782 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95687 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95613 = ((x10_int) ((size94782) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95687)->::x10::array::RectRegion1D::_constructor(t95613);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95614 = reinterpret_cast<x10::array::Region*>(myReg95687);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31808->FMGL(region) = t95614;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31808->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31808->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31808->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31808->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31808->FMGL(size) = size94782;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95688 = alloc31808->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95689 = alloc31808->FMGL(layout_stride1) = t95688;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31808->FMGL(layout_min0) = t95689;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31808->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95690 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size94782, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31808->FMGL(raw) = t95690;
    
    //#line 47 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_q) = alloc31808;
    
    //#line 48 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31809 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size94787 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95691 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95615 = ((x10_int) ((size94787) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95691)->::x10::array::RectRegion1D::_constructor(t95615);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95616 = reinterpret_cast<x10::array::Region*>(myReg95691);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31809->FMGL(region) = t95616;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31809->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31809->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31809->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31809->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31809->FMGL(size) = size94787;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95692 = alloc31809->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95693 = alloc31809->FMGL(layout_stride1) = t95692;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31809->FMGL(layout_min0) = t95693;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31809->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95694 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size94787, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31809->FMGL(raw) = t95694;
    
    //#line 48 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_ql) = alloc31809;
    
    //#line 49 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31810 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size94792 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95695 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95617 = ((x10_int) ((size94792) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95695)->::x10::array::RectRegion1D::_constructor(t95617);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95618 = reinterpret_cast<x10::array::Region*>(myReg95695);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31810->FMGL(region) = t95618;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31810->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31810->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31810->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31810->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31810->FMGL(size) = size94792;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95696 = alloc31810->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95697 = alloc31810->FMGL(layout_stride1) = t95696;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31810->FMGL(layout_min0) = t95697;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31810->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95698 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size94792, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31810->FMGL(raw) = t95698;
    
    //#line 49 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_qq) = alloc31810;
    
    //#line 51 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31811 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 335 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size94797 = size;
    
    //#line 335 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double init94798 = ((x10_double) (((x10_int)1)));
    
    //#line 337 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95699 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 337 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95625 = ((x10_int) ((size94797) - (((x10_int)1))));
    
    //#line 337 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95699)->::x10::array::RectRegion1D::_constructor(t95625);
    
    //#line 338 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95626 = reinterpret_cast<x10::array::Region*>(myReg95699);
    
    //#line 338 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31811->FMGL(region) = t95626;
    
    //#line 338 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31811->FMGL(rank) = ((x10_int)1);
    
    //#line 338 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31811->FMGL(rect) = true;
    
    //#line 338 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31811->FMGL(zeroBased) = true;
    
    //#line 338 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31811->FMGL(rail) = true;
    
    //#line 338 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31811->FMGL(size) = size94797;
    
    //#line 340 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95700 = alloc31811->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 340 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95701 = alloc31811->FMGL(layout_stride1) = t95700;
    
    //#line 340 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31811->FMGL(layout_min0) = t95701;
    
    //#line 341 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31811->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 342 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > r95702 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size94797, 8, false, false);
    
    //#line 343 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i36730max95627 = ((x10_int) ((size94797) - (((x10_int)1))));
    
    //#line 343 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95622 = ((x10_int)0);
    
    //#line 343 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": polyglot.ast.For_c
    {
        for (; true; ) {
            
            //#line 343 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
            x10_int t95623 = i95622;
            
            //#line 343 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
            x10_boolean t95624 = ((t95623) <= (i36730max95627));
            
            //#line 343 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10If_c
            if (!(t95624)) {
                
                //#line 343 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": polyglot.ast.Branch_c
                break;
            }
            
            //#line 343 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
            x10_int i95619 = i95622;
            
            //#line 344 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10Call_c
            (r95702)->__set(i95619, init94798);
            
            //#line 343 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
            x10_int t95620 = i95622;
            
            //#line 343 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
            x10_int t95621 = ((x10_int) ((t95620) + (((x10_int)1))));
            
            //#line 343 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
            i95622 = t95621;
        }
    }
    
    //#line 346 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31811->FMGL(raw) = r95702;
    
    //#line 51 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_v) = alloc31811;
    
    //#line 52 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31812 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size94808 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95703 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95628 = ((x10_int) ((size94808) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95703)->::x10::array::RectRegion1D::_constructor(t95628);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95629 = reinterpret_cast<x10::array::Region*>(myReg95703);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31812->FMGL(region) = t95629;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31812->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31812->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31812->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31812->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31812->FMGL(size) = size94808;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95704 = alloc31812->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95705 = alloc31812->FMGL(layout_stride1) = t95704;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31812->FMGL(layout_min0) = t95705;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31812->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95706 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size94808, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31812->FMGL(raw) = t95706;
    
    //#line 52 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_volo) = alloc31812;
    
    //#line 53 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31813 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size94813 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95707 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95630 = ((x10_int) ((size94813) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95707)->::x10::array::RectRegion1D::_constructor(t95630);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95631 = reinterpret_cast<x10::array::Region*>(myReg95707);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31813->FMGL(region) = t95631;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31813->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31813->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31813->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31813->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31813->FMGL(size) = size94813;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95708 = alloc31813->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95709 = alloc31813->FMGL(layout_stride1) = t95708;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31813->FMGL(layout_min0) = t95709;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31813->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95710 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size94813, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31813->FMGL(raw) = t95710;
    
    //#line 53 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_delv) = alloc31813;
    
    //#line 54 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31814 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size94818 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95711 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95632 = ((x10_int) ((size94818) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95711)->::x10::array::RectRegion1D::_constructor(t95632);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95633 = reinterpret_cast<x10::array::Region*>(myReg95711);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31814->FMGL(region) = t95633;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31814->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31814->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31814->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31814->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31814->FMGL(size) = size94818;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95712 = alloc31814->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95713 = alloc31814->FMGL(layout_stride1) = t95712;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31814->FMGL(layout_min0) = t95713;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31814->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95714 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size94818, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31814->FMGL(raw) = t95714;
    
    //#line 54 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_vdov) = alloc31814;
    
    //#line 56 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31815 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size94823 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95715 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95634 = ((x10_int) ((size94823) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95715)->::x10::array::RectRegion1D::_constructor(t95634);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95635 = reinterpret_cast<x10::array::Region*>(myReg95715);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31815->FMGL(region) = t95635;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31815->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31815->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31815->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31815->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31815->FMGL(size) = size94823;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95716 = alloc31815->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95717 = alloc31815->FMGL(layout_stride1) = t95716;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31815->FMGL(layout_min0) = t95717;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31815->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95718 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size94823, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31815->FMGL(raw) = t95718;
    
    //#line 56 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_arealg) = alloc31815;
    
    //#line 58 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31816 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size94828 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95719 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95636 = ((x10_int) ((size94828) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95719)->::x10::array::RectRegion1D::_constructor(t95636);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95637 = reinterpret_cast<x10::array::Region*>(myReg95719);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31816->FMGL(region) = t95637;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31816->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31816->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31816->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31816->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31816->FMGL(size) = size94828;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95720 = alloc31816->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95721 = alloc31816->FMGL(layout_stride1) = t95720;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31816->FMGL(layout_min0) = t95721;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31816->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95722 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size94828, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31816->FMGL(raw) = t95722;
    
    //#line 58 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_ss) = alloc31816;
    
    //#line 60 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31817 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size94833 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95723 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95638 = ((x10_int) ((size94833) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95723)->::x10::array::RectRegion1D::_constructor(t95638);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95639 = reinterpret_cast<x10::array::Region*>(myReg95723);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31817->FMGL(region) = t95639;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31817->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31817->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31817->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31817->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31817->FMGL(size) = size94833;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95724 = alloc31817->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95725 = alloc31817->FMGL(layout_stride1) = t95724;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31817->FMGL(layout_min0) = t95725;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31817->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95726 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size94833, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31817->FMGL(raw) = t95726;
    
    //#line 60 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_elemMass) = alloc31817;
}

//#line 65 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
void Domain::AllocateElemTemporary(x10_int size) {
    
    //#line 67 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31818 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size94838 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95747 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95727 = ((x10_int) ((size94838) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95747)->::x10::array::RectRegion1D::_constructor(t95727);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95728 = reinterpret_cast<x10::array::Region*>(myReg95747);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31818->FMGL(region) = t95728;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31818->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31818->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31818->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31818->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31818->FMGL(size) = size94838;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95748 = alloc31818->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95749 = alloc31818->FMGL(layout_stride1) = t95748;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31818->FMGL(layout_min0) = t95749;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31818->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95750 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size94838, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31818->FMGL(raw) = t95750;
    
    //#line 67 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_dxx) = alloc31818;
    
    //#line 68 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31819 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size94843 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95751 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95729 = ((x10_int) ((size94843) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95751)->::x10::array::RectRegion1D::_constructor(t95729);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95730 = reinterpret_cast<x10::array::Region*>(myReg95751);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31819->FMGL(region) = t95730;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31819->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31819->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31819->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31819->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31819->FMGL(size) = size94843;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95752 = alloc31819->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95753 = alloc31819->FMGL(layout_stride1) = t95752;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31819->FMGL(layout_min0) = t95753;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31819->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95754 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size94843, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31819->FMGL(raw) = t95754;
    
    //#line 68 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_dyy) = alloc31819;
    
    //#line 69 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31820 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size94848 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95755 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95731 = ((x10_int) ((size94848) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95755)->::x10::array::RectRegion1D::_constructor(t95731);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95732 = reinterpret_cast<x10::array::Region*>(myReg95755);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31820->FMGL(region) = t95732;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31820->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31820->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31820->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31820->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31820->FMGL(size) = size94848;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95756 = alloc31820->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95757 = alloc31820->FMGL(layout_stride1) = t95756;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31820->FMGL(layout_min0) = t95757;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31820->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95758 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size94848, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31820->FMGL(raw) = t95758;
    
    //#line 69 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_dzz) = alloc31820;
    
    //#line 71 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31821 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size94853 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95759 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95733 = ((x10_int) ((size94853) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95759)->::x10::array::RectRegion1D::_constructor(t95733);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95734 = reinterpret_cast<x10::array::Region*>(myReg95759);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31821->FMGL(region) = t95734;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31821->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31821->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31821->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31821->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31821->FMGL(size) = size94853;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95760 = alloc31821->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95761 = alloc31821->FMGL(layout_stride1) = t95760;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31821->FMGL(layout_min0) = t95761;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31821->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95762 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size94853, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31821->FMGL(raw) = t95762;
    
    //#line 71 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_delv_xi) = alloc31821;
    
    //#line 72 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31822 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size94858 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95763 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95735 = ((x10_int) ((size94858) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95763)->::x10::array::RectRegion1D::_constructor(t95735);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95736 = reinterpret_cast<x10::array::Region*>(myReg95763);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31822->FMGL(region) = t95736;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31822->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31822->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31822->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31822->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31822->FMGL(size) = size94858;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95764 = alloc31822->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95765 = alloc31822->FMGL(layout_stride1) = t95764;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31822->FMGL(layout_min0) = t95765;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31822->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95766 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size94858, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31822->FMGL(raw) = t95766;
    
    //#line 72 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_delv_eta) = alloc31822;
    
    //#line 73 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31823 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size94863 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95767 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95737 = ((x10_int) ((size94863) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95767)->::x10::array::RectRegion1D::_constructor(t95737);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95738 = reinterpret_cast<x10::array::Region*>(myReg95767);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31823->FMGL(region) = t95738;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31823->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31823->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31823->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31823->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31823->FMGL(size) = size94863;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95768 = alloc31823->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95769 = alloc31823->FMGL(layout_stride1) = t95768;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31823->FMGL(layout_min0) = t95769;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31823->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95770 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size94863, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31823->FMGL(raw) = t95770;
    
    //#line 73 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_delv_zeta) = alloc31823;
    
    //#line 75 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31824 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size94868 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95771 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95739 = ((x10_int) ((size94868) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95771)->::x10::array::RectRegion1D::_constructor(t95739);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95740 = reinterpret_cast<x10::array::Region*>(myReg95771);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31824->FMGL(region) = t95740;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31824->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31824->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31824->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31824->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31824->FMGL(size) = size94868;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95772 = alloc31824->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95773 = alloc31824->FMGL(layout_stride1) = t95772;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31824->FMGL(layout_min0) = t95773;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31824->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95774 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size94868, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31824->FMGL(raw) = t95774;
    
    //#line 75 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_delx_xi) = alloc31824;
    
    //#line 76 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31825 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size94873 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95775 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95741 = ((x10_int) ((size94873) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95775)->::x10::array::RectRegion1D::_constructor(t95741);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95742 = reinterpret_cast<x10::array::Region*>(myReg95775);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31825->FMGL(region) = t95742;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31825->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31825->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31825->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31825->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31825->FMGL(size) = size94873;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95776 = alloc31825->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95777 = alloc31825->FMGL(layout_stride1) = t95776;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31825->FMGL(layout_min0) = t95777;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31825->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95778 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size94873, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31825->FMGL(raw) = t95778;
    
    //#line 76 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_delx_eta) = alloc31825;
    
    //#line 77 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31826 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size94878 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95779 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95743 = ((x10_int) ((size94878) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95779)->::x10::array::RectRegion1D::_constructor(t95743);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95744 = reinterpret_cast<x10::array::Region*>(myReg95779);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31826->FMGL(region) = t95744;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31826->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31826->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31826->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31826->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31826->FMGL(size) = size94878;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95780 = alloc31826->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95781 = alloc31826->FMGL(layout_stride1) = t95780;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31826->FMGL(layout_min0) = t95781;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31826->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95782 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size94878, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31826->FMGL(raw) = t95782;
    
    //#line 77 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_delx_zeta) = alloc31826;
    
    //#line 79 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31827 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size94883 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95783 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95745 = ((x10_int) ((size94883) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95783)->::x10::array::RectRegion1D::_constructor(t95745);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95746 = reinterpret_cast<x10::array::Region*>(myReg95783);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31827->FMGL(region) = t95746;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31827->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31827->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31827->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31827->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31827->FMGL(size) = size94883;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95784 = alloc31827->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95785 = alloc31827->FMGL(layout_stride1) = t95784;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31827->FMGL(layout_min0) = t95785;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31827->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95786 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size94883, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31827->FMGL(raw) = t95786;
    
    //#line 79 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_vnew) = alloc31827;
}

//#line 82 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
void Domain::AllocateNodesets(x10_int size) {
    
    //#line 84 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_int>* alloc31828 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_int> >(), 0, sizeof(x10::array::Array<x10_int>))) x10::array::Array<x10_int>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size94888 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95793 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95787 = ((x10_int) ((size94888) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95793)->::x10::array::RectRegion1D::_constructor(t95787);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95788 = reinterpret_cast<x10::array::Region*>(myReg95793);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31828->FMGL(region) = t95788;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31828->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31828->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31828->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31828->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31828->FMGL(size) = size94888;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95794 = alloc31828->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95795 = alloc31828->FMGL(layout_stride1) = t95794;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31828->FMGL(layout_min0) = t95795;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31828->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_int > t95796 = x10::util::IndexedMemoryChunk<void>::allocate<x10_int >(size94888, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31828->FMGL(raw) = t95796;
    
    //#line 84 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_symmX) = alloc31828;
    
    //#line 85 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_int>* alloc31829 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_int> >(), 0, sizeof(x10::array::Array<x10_int>))) x10::array::Array<x10_int>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size94893 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95797 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95789 = ((x10_int) ((size94893) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95797)->::x10::array::RectRegion1D::_constructor(t95789);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95790 = reinterpret_cast<x10::array::Region*>(myReg95797);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31829->FMGL(region) = t95790;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31829->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31829->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31829->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31829->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31829->FMGL(size) = size94893;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95798 = alloc31829->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95799 = alloc31829->FMGL(layout_stride1) = t95798;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31829->FMGL(layout_min0) = t95799;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31829->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_int > t95800 = x10::util::IndexedMemoryChunk<void>::allocate<x10_int >(size94893, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31829->FMGL(raw) = t95800;
    
    //#line 85 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_symmY) = alloc31829;
    
    //#line 86 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_int>* alloc31830 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_int> >(), 0, sizeof(x10::array::Array<x10_int>))) x10::array::Array<x10_int>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size94898 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95801 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95791 = ((x10_int) ((size94898) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95801)->::x10::array::RectRegion1D::_constructor(t95791);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95792 = reinterpret_cast<x10::array::Region*>(myReg95801);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31830->FMGL(region) = t95792;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31830->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31830->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31830->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31830->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31830->FMGL(size) = size94898;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95802 = alloc31830->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95803 = alloc31830->FMGL(layout_stride1) = t95802;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31830->FMGL(layout_min0) = t95803;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31830->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_int > t95804 = x10::util::IndexedMemoryChunk<void>::allocate<x10_int >(size94898, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31830->FMGL(raw) = t95804;
    
    //#line 86 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_symmZ) = alloc31830;
}

//#line 95 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::x(x10_int idx) {
    
    //#line 95 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this94904 = this->FMGL(m_x);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i94903 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret94905;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95805 = x10aux::nullCheck(this94904)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95806 = (t95805)->__apply(i94903);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret94905 = t95806;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95338 = ret94905;
    
    //#line 95 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95338;
    
}

//#line 96 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::y(x10_int idx) {
    
    //#line 96 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this94908 = this->FMGL(m_y);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i94907 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret94909;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95807 = x10aux::nullCheck(this94908)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95808 = (t95807)->__apply(i94907);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret94909 = t95808;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95341 = ret94909;
    
    //#line 96 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95341;
    
}

//#line 97 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::z(x10_int idx) {
    
    //#line 97 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this94912 = this->FMGL(m_z);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i94911 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret94913;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95809 = x10aux::nullCheck(this94912)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95810 = (t95809)->__apply(i94911);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret94913 = t95810;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95344 = ret94913;
    
    //#line 97 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95344;
    
}

//#line 99 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::xd(x10_int idx) {
    
    //#line 99 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this94916 = this->FMGL(m_xd);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i94915 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret94917;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95811 = x10aux::nullCheck(this94916)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95812 = (t95811)->__apply(i94915);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret94917 = t95812;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95347 = ret94917;
    
    //#line 99 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95347;
    
}

//#line 100 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::yd(x10_int idx) {
    
    //#line 100 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this94920 = this->FMGL(m_yd);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i94919 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret94921;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95813 = x10aux::nullCheck(this94920)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95814 = (t95813)->__apply(i94919);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret94921 = t95814;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95350 = ret94921;
    
    //#line 100 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95350;
    
}

//#line 101 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::zd(x10_int idx) {
    
    //#line 101 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this94924 = this->FMGL(m_zd);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i94923 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret94925;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95815 = x10aux::nullCheck(this94924)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95816 = (t95815)->__apply(i94923);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret94925 = t95816;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95353 = ret94925;
    
    //#line 101 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95353;
    
}

//#line 103 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::xdd(x10_int idx) {
    
    //#line 103 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this94928 = this->FMGL(m_xdd);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i94927 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret94929;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95817 = x10aux::nullCheck(this94928)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95818 = (t95817)->__apply(i94927);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret94929 = t95818;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95356 = ret94929;
    
    //#line 103 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95356;
    
}

//#line 104 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::ydd(x10_int idx) {
    
    //#line 104 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this94932 = this->FMGL(m_ydd);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i94931 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret94933;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95819 = x10aux::nullCheck(this94932)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95820 = (t95819)->__apply(i94931);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret94933 = t95820;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95359 = ret94933;
    
    //#line 104 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95359;
    
}

//#line 105 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::zdd(x10_int idx) {
    
    //#line 105 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this94936 = this->FMGL(m_zdd);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i94935 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret94937;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95821 = x10aux::nullCheck(this94936)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95822 = (t95821)->__apply(i94935);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret94937 = t95822;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95362 = ret94937;
    
    //#line 105 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95362;
    
}

//#line 107 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::fx(x10_int idx) {
    
    //#line 107 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this94940 = this->FMGL(m_fx);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i94939 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret94941;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95823 = x10aux::nullCheck(this94940)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95824 = (t95823)->__apply(i94939);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret94941 = t95824;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95365 = ret94941;
    
    //#line 107 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95365;
    
}

//#line 108 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::fy(x10_int idx) {
    
    //#line 108 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this94944 = this->FMGL(m_fy);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i94943 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret94945;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95825 = x10aux::nullCheck(this94944)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95826 = (t95825)->__apply(i94943);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret94945 = t95826;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95368 = ret94945;
    
    //#line 108 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95368;
    
}

//#line 109 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::fz(x10_int idx) {
    
    //#line 109 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this94948 = this->FMGL(m_fz);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i94947 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret94949;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95827 = x10aux::nullCheck(this94948)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95828 = (t95827)->__apply(i94947);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret94949 = t95828;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95371 = ret94949;
    
    //#line 109 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95371;
    
}

//#line 111 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::nodalMass(x10_int idx) {
    
    //#line 111 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this94952 = this->FMGL(m_nodalMass);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i94951 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret94953;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95829 = x10aux::nullCheck(this94952)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95830 = (t95829)->__apply(i94951);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret94953 = t95830;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95374 = ret94953;
    
    //#line 111 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95374;
    
}

//#line 113 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_int Domain::symmX(x10_int idx) {
    
    //#line 113 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_int>* this94956 = this->FMGL(m_symmX);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i94955 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int ret94957;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_int > t95831 = x10aux::nullCheck(this94956)->
                                                       FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95832 = (t95831)->__apply(i94955);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret94957 = t95832;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95377 = ret94957;
    
    //#line 113 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95377;
    
}

//#line 114 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_int Domain::symmY(x10_int idx) {
    
    //#line 114 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_int>* this94960 = this->FMGL(m_symmY);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i94959 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int ret94961;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_int > t95833 = x10aux::nullCheck(this94960)->
                                                       FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95834 = (t95833)->__apply(i94959);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret94961 = t95834;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95380 = ret94961;
    
    //#line 114 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95380;
    
}

//#line 115 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_int Domain::symmZ(x10_int idx) {
    
    //#line 115 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_int>* this94964 = this->FMGL(m_symmZ);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i94963 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int ret94965;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_int > t95835 = x10aux::nullCheck(this94964)->
                                                       FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95836 = (t95835)->__apply(i94963);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret94965 = t95836;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95383 = ret94965;
    
    //#line 115 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95383;
    
}

//#line 119 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_int Domain::matElemlist(x10_int idx) {
    
    //#line 119 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_int>* this94968 = this->FMGL(m_matElemlist);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i94967 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int ret94969;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_int > t95837 = x10aux::nullCheck(this94968)->
                                                       FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95838 = (t95837)->__apply(i94967);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret94969 = t95838;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95386 = ret94969;
    
    //#line 119 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95386;
    
}

//#line 120 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10::array::Array<x10_int>* Domain::nodelist() {
    
    //#line 120 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_int>* t95387 = this->FMGL(m_nodelist);
    
    //#line 120 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95387;
    
}

//#line 122 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_int Domain::lxim(x10_int idx) {
    
    //#line 122 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_int>* this94972 = this->FMGL(m_lxim);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i94971 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int ret94973;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_int > t95839 = x10aux::nullCheck(this94972)->
                                                       FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95840 = (t95839)->__apply(i94971);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret94973 = t95840;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95390 = ret94973;
    
    //#line 122 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95390;
    
}

//#line 123 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_int Domain::lxip(x10_int idx) {
    
    //#line 123 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_int>* this94976 = this->FMGL(m_lxip);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i94975 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int ret94977;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_int > t95841 = x10aux::nullCheck(this94976)->
                                                       FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95842 = (t95841)->__apply(i94975);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret94977 = t95842;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95393 = ret94977;
    
    //#line 123 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95393;
    
}

//#line 124 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_int Domain::letam(x10_int idx) {
    
    //#line 124 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_int>* this94980 = this->FMGL(m_letam);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i94979 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int ret94981;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_int > t95843 = x10aux::nullCheck(this94980)->
                                                       FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95844 = (t95843)->__apply(i94979);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret94981 = t95844;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95396 = ret94981;
    
    //#line 124 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95396;
    
}

//#line 125 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_int Domain::letap(x10_int idx) {
    
    //#line 125 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_int>* this94984 = this->FMGL(m_letap);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i94983 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int ret94985;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_int > t95845 = x10aux::nullCheck(this94984)->
                                                       FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95846 = (t95845)->__apply(i94983);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret94985 = t95846;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95399 = ret94985;
    
    //#line 125 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95399;
    
}

//#line 126 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_int Domain::lzetam(x10_int idx) {
    
    //#line 126 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_int>* this94988 = this->FMGL(m_lzetam);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i94987 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int ret94989;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_int > t95847 = x10aux::nullCheck(this94988)->
                                                       FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95848 = (t95847)->__apply(i94987);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret94989 = t95848;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95402 = ret94989;
    
    //#line 126 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95402;
    
}

//#line 127 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_int Domain::lzetap(x10_int idx) {
    
    //#line 127 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_int>* this94992 = this->FMGL(m_lzetap);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i94991 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int ret94993;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_int > t95849 = x10aux::nullCheck(this94992)->
                                                       FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95850 = (t95849)->__apply(i94991);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret94993 = t95850;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95405 = ret94993;
    
    //#line 127 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95405;
    
}

//#line 129 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_int Domain::elemBC(x10_int idx) {
    
    //#line 129 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_int>* this94996 = this->FMGL(m_elemBC);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i94995 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int ret94997;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_int > t95851 = x10aux::nullCheck(this94996)->
                                                       FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95852 = (t95851)->__apply(i94995);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret94997 = t95852;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95408 = ret94997;
    
    //#line 129 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95408;
    
}

//#line 131 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::dxx(x10_int idx) {
    
    //#line 131 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this95000 = this->FMGL(m_dxx);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i94999 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret95001;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95853 = x10aux::nullCheck(this95000)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95854 = (t95853)->__apply(i94999);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95001 = t95854;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95411 = ret95001;
    
    //#line 131 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95411;
    
}

//#line 132 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::dyy(x10_int idx) {
    
    //#line 132 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this95004 = this->FMGL(m_dyy);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95003 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret95005;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95855 = x10aux::nullCheck(this95004)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95856 = (t95855)->__apply(i95003);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95005 = t95856;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95414 = ret95005;
    
    //#line 132 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95414;
    
}

//#line 133 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::dzz(x10_int idx) {
    
    //#line 133 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this95008 = this->FMGL(m_dzz);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95007 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret95009;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95857 = x10aux::nullCheck(this95008)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95858 = (t95857)->__apply(i95007);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95009 = t95858;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95417 = ret95009;
    
    //#line 133 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95417;
    
}

//#line 135 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::delv_xi(x10_int idx) {
    
    //#line 135 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this95012 = this->FMGL(m_delv_xi);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95011 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret95013;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95859 = x10aux::nullCheck(this95012)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95860 = (t95859)->__apply(i95011);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95013 = t95860;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95420 = ret95013;
    
    //#line 135 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95420;
    
}

//#line 136 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::delv_eta(x10_int idx) {
    
    //#line 136 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this95016 = this->FMGL(m_delv_eta);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95015 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret95017;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95861 = x10aux::nullCheck(this95016)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95862 = (t95861)->__apply(i95015);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95017 = t95862;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95423 = ret95017;
    
    //#line 136 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95423;
    
}

//#line 137 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::delv_zeta(x10_int idx) {
    
    //#line 137 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this95020 = this->FMGL(m_delv_zeta);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95019 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret95021;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95863 = x10aux::nullCheck(this95020)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95864 = (t95863)->__apply(i95019);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95021 = t95864;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95426 = ret95021;
    
    //#line 137 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95426;
    
}

//#line 139 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::delx_xi(x10_int idx) {
    
    //#line 139 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this95024 = this->FMGL(m_delx_xi);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95023 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret95025;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95865 = x10aux::nullCheck(this95024)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95866 = (t95865)->__apply(i95023);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95025 = t95866;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95429 = ret95025;
    
    //#line 139 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95429;
    
}

//#line 140 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::delx_eta(x10_int idx) {
    
    //#line 140 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this95028 = this->FMGL(m_delx_eta);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95027 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret95029;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95867 = x10aux::nullCheck(this95028)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95868 = (t95867)->__apply(i95027);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95029 = t95868;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95432 = ret95029;
    
    //#line 140 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95432;
    
}

//#line 141 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::delx_zeta(x10_int idx) {
    
    //#line 141 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this95032 = this->FMGL(m_delx_zeta);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95031 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret95033;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95869 = x10aux::nullCheck(this95032)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95870 = (t95869)->__apply(i95031);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95033 = t95870;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95435 = ret95033;
    
    //#line 141 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95435;
    
}

//#line 143 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::e(x10_int idx) {
    
    //#line 143 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this95036 = this->FMGL(m_e);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95035 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret95037;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95871 = x10aux::nullCheck(this95036)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95872 = (t95871)->__apply(i95035);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95037 = t95872;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95438 = ret95037;
    
    //#line 143 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95438;
    
}

//#line 145 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::p(x10_int idx) {
    
    //#line 145 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this95040 = this->FMGL(m_p);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95039 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret95041;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95873 = x10aux::nullCheck(this95040)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95874 = (t95873)->__apply(i95039);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95041 = t95874;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95441 = ret95041;
    
    //#line 145 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95441;
    
}

//#line 146 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::q(x10_int idx) {
    
    //#line 146 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this95044 = this->FMGL(m_q);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95043 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret95045;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95875 = x10aux::nullCheck(this95044)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95876 = (t95875)->__apply(i95043);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95045 = t95876;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95444 = ret95045;
    
    //#line 146 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95444;
    
}

//#line 147 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::ql(x10_int idx) {
    
    //#line 147 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this95048 = this->FMGL(m_ql);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95047 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret95049;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95877 = x10aux::nullCheck(this95048)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95878 = (t95877)->__apply(i95047);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95049 = t95878;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95447 = ret95049;
    
    //#line 147 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95447;
    
}

//#line 148 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::qq(x10_int idx) {
    
    //#line 148 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this95052 = this->FMGL(m_qq);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95051 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret95053;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95879 = x10aux::nullCheck(this95052)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95880 = (t95879)->__apply(i95051);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95053 = t95880;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95450 = ret95053;
    
    //#line 148 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95450;
    
}

//#line 150 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::v(x10_int idx) {
    
    //#line 150 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this95056 = this->FMGL(m_v);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95055 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret95057;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95881 = x10aux::nullCheck(this95056)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95882 = (t95881)->__apply(i95055);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95057 = t95882;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95453 = ret95057;
    
    //#line 150 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95453;
    
}

//#line 151 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::volo(x10_int idx) {
    
    //#line 151 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this95060 = this->FMGL(m_volo);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95059 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret95061;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95883 = x10aux::nullCheck(this95060)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95884 = (t95883)->__apply(i95059);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95061 = t95884;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95456 = ret95061;
    
    //#line 151 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95456;
    
}

//#line 152 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::vnew(x10_int idx) {
    
    //#line 152 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this95064 = this->FMGL(m_vnew);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95063 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret95065;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95885 = x10aux::nullCheck(this95064)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95886 = (t95885)->__apply(i95063);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95065 = t95886;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95459 = ret95065;
    
    //#line 152 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95459;
    
}

//#line 153 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::delv(x10_int idx) {
    
    //#line 153 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this95068 = this->FMGL(m_delv);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95067 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret95069;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95887 = x10aux::nullCheck(this95068)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95888 = (t95887)->__apply(i95067);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95069 = t95888;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95462 = ret95069;
    
    //#line 153 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95462;
    
}

//#line 154 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::vdov(x10_int idx) {
    
    //#line 154 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this95072 = this->FMGL(m_vdov);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95071 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret95073;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95889 = x10aux::nullCheck(this95072)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95890 = (t95889)->__apply(i95071);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95073 = t95890;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95465 = ret95073;
    
    //#line 154 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95465;
    
}

//#line 156 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::arealg(x10_int idx) {
    
    //#line 156 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this95076 = this->FMGL(m_arealg);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95075 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret95077;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95891 = x10aux::nullCheck(this95076)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95892 = (t95891)->__apply(i95075);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95077 = t95892;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95468 = ret95077;
    
    //#line 156 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95468;
    
}

//#line 158 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::ss(x10_int idx) {
    
    //#line 158 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this95080 = this->FMGL(m_ss);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95079 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret95081;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95893 = x10aux::nullCheck(this95080)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95894 = (t95893)->__apply(i95079);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95081 = t95894;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95471 = ret95081;
    
    //#line 158 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95471;
    
}

//#line 160 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::elemMass(x10_int idx) {
    
    //#line 160 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this95084 = this->FMGL(m_elemMass);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95083 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret95085;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95895 = x10aux::nullCheck(this95084)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95896 = (t95895)->__apply(i95083);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95085 = t95896;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95474 = ret95085;
    
    //#line 160 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95474;
    
}

//#line 164 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::dtfixed() {
    
    //#line 164 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_double t95475 = this->FMGL(m_dtfixed);
    
    //#line 164 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95475;
    
}

//#line 165 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::time() {
    
    //#line 165 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_double t95476 = this->FMGL(m_time);
    
    //#line 165 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95476;
    
}

//#line 166 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::deltatime() {
    
    //#line 166 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_double t95477 = this->FMGL(m_deltatime);
    
    //#line 166 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95477;
    
}

//#line 167 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::deltatimemultlb() {
    
    //#line 167 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_double t95478 = this->FMGL(m_deltatimemultlb);
    
    //#line 167 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95478;
    
}

//#line 168 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::deltatimemultub() {
    
    //#line 168 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_double t95479 = this->FMGL(m_deltatimemultub);
    
    //#line 168 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95479;
    
}

//#line 169 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::stoptime() {
    
    //#line 169 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_double t95480 = this->FMGL(m_stoptime);
    
    //#line 169 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95480;
    
}

//#line 171 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::u_cut() {
    
    //#line 171 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_double t95481 = this->FMGL(m_u_cut);
    
    //#line 171 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95481;
    
}

//#line 172 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::hgcoef() {
    
    //#line 172 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_double t95482 = this->FMGL(m_hgcoef);
    
    //#line 172 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95482;
    
}

//#line 173 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::qstop() {
    
    //#line 173 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_double t95483 = this->FMGL(m_qstop);
    
    //#line 173 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95483;
    
}

//#line 174 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::monoq_max_slope() {
    
    //#line 174 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_double t95484 = this->FMGL(m_monoq_max_slope);
    
    //#line 174 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95484;
    
}

//#line 175 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::monoq_limiter_mult() {
    
    //#line 175 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_double t95485 = this->FMGL(m_monoq_limiter_mult);
    
    //#line 175 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95485;
    
}

//#line 176 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::e_cut() {
    
    //#line 176 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_double t95486 = this->FMGL(m_e_cut);
    
    //#line 176 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95486;
    
}

//#line 177 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::p_cut() {
    
    //#line 177 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_double t95487 = this->FMGL(m_p_cut);
    
    //#line 177 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95487;
    
}

//#line 178 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::ss4o3() {
    
    //#line 178 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_double t95488 = this->FMGL(m_ss4o3);
    
    //#line 178 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95488;
    
}

//#line 179 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::q_cut() {
    
    //#line 179 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_double t95489 = this->FMGL(m_q_cut);
    
    //#line 179 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95489;
    
}

//#line 180 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::v_cut() {
    
    //#line 180 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_double t95490 = this->FMGL(m_v_cut);
    
    //#line 180 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95490;
    
}

//#line 181 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::qlc_monoq() {
    
    //#line 181 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_double t95491 = this->FMGL(m_qlc_monoq);
    
    //#line 181 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95491;
    
}

//#line 182 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::qqc_monoq() {
    
    //#line 182 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_double t95492 = this->FMGL(m_qqc_monoq);
    
    //#line 182 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95492;
    
}

//#line 183 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::qqc() {
    
    //#line 183 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_double t95493 = this->FMGL(m_qqc);
    
    //#line 183 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95493;
    
}

//#line 184 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::eosvmax() {
    
    //#line 184 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_double t95494 = this->FMGL(m_eosvmax);
    
    //#line 184 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95494;
    
}

//#line 185 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::eosvmin() {
    
    //#line 185 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_double t95495 = this->FMGL(m_eosvmin);
    
    //#line 185 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95495;
    
}

//#line 186 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::pmin() {
    
    //#line 186 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_double t95496 = this->FMGL(m_pmin);
    
    //#line 186 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95496;
    
}

//#line 187 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::emin() {
    
    //#line 187 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_double t95497 = this->FMGL(m_emin);
    
    //#line 187 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95497;
    
}

//#line 188 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::dvovmax() {
    
    //#line 188 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_double t95498 = this->FMGL(m_dvovmax);
    
    //#line 188 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95498;
    
}

//#line 189 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::refdens() {
    
    //#line 189 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_double t95499 = this->FMGL(m_refdens);
    
    //#line 189 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95499;
    
}

//#line 191 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::dtcourant() {
    
    //#line 191 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_double t95500 = this->FMGL(m_dtcourant);
    
    //#line 191 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95500;
    
}

//#line 192 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::dthydro() {
    
    //#line 192 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_double t95501 = this->FMGL(m_dthydro);
    
    //#line 192 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95501;
    
}

//#line 193 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::dtmax() {
    
    //#line 193 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_double t95502 = this->FMGL(m_dtmax);
    
    //#line 193 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95502;
    
}

//#line 195 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_int Domain::cycle() {
    
    //#line 195 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_int t95503 = this->FMGL(m_cycle);
    
    //#line 195 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95503;
    
}

//#line 197 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_int Domain::sizeX() {
    
    //#line 197 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_int t95504 = this->FMGL(m_sizeX);
    
    //#line 197 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95504;
    
}

//#line 198 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_int Domain::sizeY() {
    
    //#line 198 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_int t95505 = this->FMGL(m_sizeY);
    
    //#line 198 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95505;
    
}

//#line 199 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_int Domain::sizeZ() {
    
    //#line 199 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_int t95506 = this->FMGL(m_sizeZ);
    
    //#line 199 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95506;
    
}

//#line 200 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_int Domain::numElem() {
    
    //#line 200 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_int t95507 = this->FMGL(m_numElem);
    
    //#line 200 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95507;
    
}

//#line 201 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_int Domain::numNode() {
    
    //#line 201 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_int t95508 = this->FMGL(m_numNode);
    
    //#line 201 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95508;
    
}

//#line 209 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c
/******************/

//#line 210 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 211 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 213 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 214 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 215 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 217 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 218 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 219 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 221 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 222 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 223 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 225 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 227 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 228 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 229 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 233 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 234 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 236 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 237 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 238 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 239 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 240 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 241 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 243 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 245 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 246 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 247 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 249 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 250 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 251 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 253 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 254 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 255 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 257 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 259 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 260 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 261 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 262 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 264 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 265 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 266 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 267 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 268 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 270 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 272 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 274 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 277 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 278 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 279 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 280 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 281 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 282 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 284 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 285 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 286 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 287 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 288 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 289 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 290 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 291 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 292 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 293 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 294 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 295 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 296 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 297 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 298 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 299 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 300 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 301 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 302 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 304 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 305 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 306 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 308 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 310 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 311 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 312 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 314 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 315 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10FieldDecl_c

//#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
Domain* Domain::Domain____this__Domain() {
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return this;
    
}

//#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10ConstructorDecl_c
void Domain::_constructor() {
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.AssignPropertyCall_c
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10Call_c
    this->Domain::__fieldInitializers31772();
}
Domain* Domain::_make() {
    Domain* this_ = new (memset(x10aux::alloc<Domain>(), 0, sizeof(Domain))) Domain();
    this_->_constructor();
    return this_;
}



//#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
void Domain::__fieldInitializers31772() {
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_x) = (x10aux::class_cast_unchecked<x10::array::Array<x10_double>*>(X10_NULL));
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_y) = (x10aux::class_cast_unchecked<x10::array::Array<x10_double>*>(X10_NULL));
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_z) = (x10aux::class_cast_unchecked<x10::array::Array<x10_double>*>(X10_NULL));
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_xd) = (x10aux::class_cast_unchecked<x10::array::Array<x10_double>*>(X10_NULL));
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_yd) = (x10aux::class_cast_unchecked<x10::array::Array<x10_double>*>(X10_NULL));
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_zd) = (x10aux::class_cast_unchecked<x10::array::Array<x10_double>*>(X10_NULL));
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_xdd) = (x10aux::class_cast_unchecked<x10::array::Array<x10_double>*>(X10_NULL));
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_ydd) = (x10aux::class_cast_unchecked<x10::array::Array<x10_double>*>(X10_NULL));
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_zdd) = (x10aux::class_cast_unchecked<x10::array::Array<x10_double>*>(X10_NULL));
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_fx) = (x10aux::class_cast_unchecked<x10::array::Array<x10_double>*>(X10_NULL));
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_fy) = (x10aux::class_cast_unchecked<x10::array::Array<x10_double>*>(X10_NULL));
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_fz) = (x10aux::class_cast_unchecked<x10::array::Array<x10_double>*>(X10_NULL));
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_nodalMass) = (x10aux::class_cast_unchecked<x10::array::Array<x10_double>*>(X10_NULL));
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_symmX) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_symmY) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_symmZ) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_matElemlist) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_nodelist) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_lxim) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_lxip) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_letam) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_letap) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_lzetam) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_lzetap) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_elemBC) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_dxx) = (x10aux::class_cast_unchecked<x10::array::Array<x10_double>*>(X10_NULL));
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_dyy) = (x10aux::class_cast_unchecked<x10::array::Array<x10_double>*>(X10_NULL));
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_dzz) = (x10aux::class_cast_unchecked<x10::array::Array<x10_double>*>(X10_NULL));
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_delv_xi) = (x10aux::class_cast_unchecked<x10::array::Array<x10_double>*>(X10_NULL));
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_delv_eta) = (x10aux::class_cast_unchecked<x10::array::Array<x10_double>*>(X10_NULL));
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_delv_zeta) = (x10aux::class_cast_unchecked<x10::array::Array<x10_double>*>(X10_NULL));
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_delx_xi) = (x10aux::class_cast_unchecked<x10::array::Array<x10_double>*>(X10_NULL));
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_delx_eta) = (x10aux::class_cast_unchecked<x10::array::Array<x10_double>*>(X10_NULL));
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_delx_zeta) = (x10aux::class_cast_unchecked<x10::array::Array<x10_double>*>(X10_NULL));
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_e) = (x10aux::class_cast_unchecked<x10::array::Array<x10_double>*>(X10_NULL));
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_p) = (x10aux::class_cast_unchecked<x10::array::Array<x10_double>*>(X10_NULL));
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_q) = (x10aux::class_cast_unchecked<x10::array::Array<x10_double>*>(X10_NULL));
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_ql) = (x10aux::class_cast_unchecked<x10::array::Array<x10_double>*>(X10_NULL));
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_qq) = (x10aux::class_cast_unchecked<x10::array::Array<x10_double>*>(X10_NULL));
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_v) = (x10aux::class_cast_unchecked<x10::array::Array<x10_double>*>(X10_NULL));
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_volo) = (x10aux::class_cast_unchecked<x10::array::Array<x10_double>*>(X10_NULL));
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_vnew) = (x10aux::class_cast_unchecked<x10::array::Array<x10_double>*>(X10_NULL));
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_delv) = (x10aux::class_cast_unchecked<x10::array::Array<x10_double>*>(X10_NULL));
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_vdov) = (x10aux::class_cast_unchecked<x10::array::Array<x10_double>*>(X10_NULL));
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_arealg) = (x10aux::class_cast_unchecked<x10::array::Array<x10_double>*>(X10_NULL));
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_ss) = (x10aux::class_cast_unchecked<x10::array::Array<x10_double>*>(X10_NULL));
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_elemMass) = (x10aux::class_cast_unchecked<x10::array::Array<x10_double>*>(X10_NULL));
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_dtfixed) = 0.0;
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_time) = 0.0;
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_deltatime) = 0.0;
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_deltatimemultlb) = 0.0;
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_deltatimemultub) = 0.0;
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_stoptime) = 0.0;
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_u_cut) = 0.0;
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_hgcoef) = 0.0;
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_qstop) = 0.0;
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_monoq_max_slope) = 0.0;
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_monoq_limiter_mult) = 0.0;
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_e_cut) = 0.0;
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_p_cut) = 0.0;
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_ss4o3) = 0.0;
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_q_cut) = 0.0;
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_v_cut) = 0.0;
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_qlc_monoq) = 0.0;
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_qqc_monoq) = 0.0;
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_qqc) = 0.0;
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_eosvmax) = 0.0;
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_eosvmin) = 0.0;
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_pmin) = 0.0;
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_emin) = 0.0;
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_dvovmax) = 0.0;
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_refdens) = 0.0;
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_dtcourant) = 0.0;
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_dthydro) = 0.0;
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_dtmax) = 0.0;
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_cycle) = ((x10_int)0);
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_sizeX) = ((x10_int)0);
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_sizeY) = ((x10_int)0);
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_sizeZ) = ((x10_int)0);
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_numElem) = ((x10_int)0);
    
    //#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_numNode) = ((x10_int)0);
}
const x10aux::serialization_id_t Domain::_serialization_id = 
    x10aux::DeserializationDispatcher::addDeserializer(Domain::_deserializer, x10aux::CLOSURE_KIND_NOT_ASYNC);

void Domain::_serialize_body(x10aux::serialization_buffer& buf) {
    buf.write(this->FMGL(m_x));
    buf.write(this->FMGL(m_y));
    buf.write(this->FMGL(m_z));
    buf.write(this->FMGL(m_xd));
    buf.write(this->FMGL(m_yd));
    buf.write(this->FMGL(m_zd));
    buf.write(this->FMGL(m_xdd));
    buf.write(this->FMGL(m_ydd));
    buf.write(this->FMGL(m_zdd));
    buf.write(this->FMGL(m_fx));
    buf.write(this->FMGL(m_fy));
    buf.write(this->FMGL(m_fz));
    buf.write(this->FMGL(m_nodalMass));
    buf.write(this->FMGL(m_symmX));
    buf.write(this->FMGL(m_symmY));
    buf.write(this->FMGL(m_symmZ));
    buf.write(this->FMGL(m_matElemlist));
    buf.write(this->FMGL(m_nodelist));
    buf.write(this->FMGL(m_lxim));
    buf.write(this->FMGL(m_lxip));
    buf.write(this->FMGL(m_letam));
    buf.write(this->FMGL(m_letap));
    buf.write(this->FMGL(m_lzetam));
    buf.write(this->FMGL(m_lzetap));
    buf.write(this->FMGL(m_elemBC));
    buf.write(this->FMGL(m_dxx));
    buf.write(this->FMGL(m_dyy));
    buf.write(this->FMGL(m_dzz));
    buf.write(this->FMGL(m_delv_xi));
    buf.write(this->FMGL(m_delv_eta));
    buf.write(this->FMGL(m_delv_zeta));
    buf.write(this->FMGL(m_delx_xi));
    buf.write(this->FMGL(m_delx_eta));
    buf.write(this->FMGL(m_delx_zeta));
    buf.write(this->FMGL(m_e));
    buf.write(this->FMGL(m_p));
    buf.write(this->FMGL(m_q));
    buf.write(this->FMGL(m_ql));
    buf.write(this->FMGL(m_qq));
    buf.write(this->FMGL(m_v));
    buf.write(this->FMGL(m_volo));
    buf.write(this->FMGL(m_vnew));
    buf.write(this->FMGL(m_delv));
    buf.write(this->FMGL(m_vdov));
    buf.write(this->FMGL(m_arealg));
    buf.write(this->FMGL(m_ss));
    buf.write(this->FMGL(m_elemMass));
    buf.write(this->FMGL(m_dtfixed));
    buf.write(this->FMGL(m_time));
    buf.write(this->FMGL(m_deltatime));
    buf.write(this->FMGL(m_deltatimemultlb));
    buf.write(this->FMGL(m_deltatimemultub));
    buf.write(this->FMGL(m_stoptime));
    buf.write(this->FMGL(m_u_cut));
    buf.write(this->FMGL(m_hgcoef));
    buf.write(this->FMGL(m_qstop));
    buf.write(this->FMGL(m_monoq_max_slope));
    buf.write(this->FMGL(m_monoq_limiter_mult));
    buf.write(this->FMGL(m_e_cut));
    buf.write(this->FMGL(m_p_cut));
    buf.write(this->FMGL(m_ss4o3));
    buf.write(this->FMGL(m_q_cut));
    buf.write(this->FMGL(m_v_cut));
    buf.write(this->FMGL(m_qlc_monoq));
    buf.write(this->FMGL(m_qqc_monoq));
    buf.write(this->FMGL(m_qqc));
    buf.write(this->FMGL(m_eosvmax));
    buf.write(this->FMGL(m_eosvmin));
    buf.write(this->FMGL(m_pmin));
    buf.write(this->FMGL(m_emin));
    buf.write(this->FMGL(m_dvovmax));
    buf.write(this->FMGL(m_refdens));
    buf.write(this->FMGL(m_dtcourant));
    buf.write(this->FMGL(m_dthydro));
    buf.write(this->FMGL(m_dtmax));
    buf.write(this->FMGL(m_cycle));
    buf.write(this->FMGL(m_sizeX));
    buf.write(this->FMGL(m_sizeY));
    buf.write(this->FMGL(m_sizeZ));
    buf.write(this->FMGL(m_numElem));
    buf.write(this->FMGL(m_numNode));
    
}

x10::lang::Reference* Domain::_deserializer(x10aux::deserialization_buffer& buf) {
    Domain* this_ = new (memset(x10aux::alloc<Domain>(), 0, sizeof(Domain))) Domain();
    buf.record_reference(this_);
    this_->_deserialize_body(buf);
    return this_;
}

void Domain::_deserialize_body(x10aux::deserialization_buffer& buf) {
    FMGL(m_x) = buf.read<x10::array::Array<x10_double>*>();
    FMGL(m_y) = buf.read<x10::array::Array<x10_double>*>();
    FMGL(m_z) = buf.read<x10::array::Array<x10_double>*>();
    FMGL(m_xd) = buf.read<x10::array::Array<x10_double>*>();
    FMGL(m_yd) = buf.read<x10::array::Array<x10_double>*>();
    FMGL(m_zd) = buf.read<x10::array::Array<x10_double>*>();
    FMGL(m_xdd) = buf.read<x10::array::Array<x10_double>*>();
    FMGL(m_ydd) = buf.read<x10::array::Array<x10_double>*>();
    FMGL(m_zdd) = buf.read<x10::array::Array<x10_double>*>();
    FMGL(m_fx) = buf.read<x10::array::Array<x10_double>*>();
    FMGL(m_fy) = buf.read<x10::array::Array<x10_double>*>();
    FMGL(m_fz) = buf.read<x10::array::Array<x10_double>*>();
    FMGL(m_nodalMass) = buf.read<x10::array::Array<x10_double>*>();
    FMGL(m_symmX) = buf.read<x10::array::Array<x10_int>*>();
    FMGL(m_symmY) = buf.read<x10::array::Array<x10_int>*>();
    FMGL(m_symmZ) = buf.read<x10::array::Array<x10_int>*>();
    FMGL(m_matElemlist) = buf.read<x10::array::Array<x10_int>*>();
    FMGL(m_nodelist) = buf.read<x10::array::Array<x10_int>*>();
    FMGL(m_lxim) = buf.read<x10::array::Array<x10_int>*>();
    FMGL(m_lxip) = buf.read<x10::array::Array<x10_int>*>();
    FMGL(m_letam) = buf.read<x10::array::Array<x10_int>*>();
    FMGL(m_letap) = buf.read<x10::array::Array<x10_int>*>();
    FMGL(m_lzetam) = buf.read<x10::array::Array<x10_int>*>();
    FMGL(m_lzetap) = buf.read<x10::array::Array<x10_int>*>();
    FMGL(m_elemBC) = buf.read<x10::array::Array<x10_int>*>();
    FMGL(m_dxx) = buf.read<x10::array::Array<x10_double>*>();
    FMGL(m_dyy) = buf.read<x10::array::Array<x10_double>*>();
    FMGL(m_dzz) = buf.read<x10::array::Array<x10_double>*>();
    FMGL(m_delv_xi) = buf.read<x10::array::Array<x10_double>*>();
    FMGL(m_delv_eta) = buf.read<x10::array::Array<x10_double>*>();
    FMGL(m_delv_zeta) = buf.read<x10::array::Array<x10_double>*>();
    FMGL(m_delx_xi) = buf.read<x10::array::Array<x10_double>*>();
    FMGL(m_delx_eta) = buf.read<x10::array::Array<x10_double>*>();
    FMGL(m_delx_zeta) = buf.read<x10::array::Array<x10_double>*>();
    FMGL(m_e) = buf.read<x10::array::Array<x10_double>*>();
    FMGL(m_p) = buf.read<x10::array::Array<x10_double>*>();
    FMGL(m_q) = buf.read<x10::array::Array<x10_double>*>();
    FMGL(m_ql) = buf.read<x10::array::Array<x10_double>*>();
    FMGL(m_qq) = buf.read<x10::array::Array<x10_double>*>();
    FMGL(m_v) = buf.read<x10::array::Array<x10_double>*>();
    FMGL(m_volo) = buf.read<x10::array::Array<x10_double>*>();
    FMGL(m_vnew) = buf.read<x10::array::Array<x10_double>*>();
    FMGL(m_delv) = buf.read<x10::array::Array<x10_double>*>();
    FMGL(m_vdov) = buf.read<x10::array::Array<x10_double>*>();
    FMGL(m_arealg) = buf.read<x10::array::Array<x10_double>*>();
    FMGL(m_ss) = buf.read<x10::array::Array<x10_double>*>();
    FMGL(m_elemMass) = buf.read<x10::array::Array<x10_double>*>();
    FMGL(m_dtfixed) = buf.read<x10_double>();
    FMGL(m_time) = buf.read<x10_double>();
    FMGL(m_deltatime) = buf.read<x10_double>();
    FMGL(m_deltatimemultlb) = buf.read<x10_double>();
    FMGL(m_deltatimemultub) = buf.read<x10_double>();
    FMGL(m_stoptime) = buf.read<x10_double>();
    FMGL(m_u_cut) = buf.read<x10_double>();
    FMGL(m_hgcoef) = buf.read<x10_double>();
    FMGL(m_qstop) = buf.read<x10_double>();
    FMGL(m_monoq_max_slope) = buf.read<x10_double>();
    FMGL(m_monoq_limiter_mult) = buf.read<x10_double>();
    FMGL(m_e_cut) = buf.read<x10_double>();
    FMGL(m_p_cut) = buf.read<x10_double>();
    FMGL(m_ss4o3) = buf.read<x10_double>();
    FMGL(m_q_cut) = buf.read<x10_double>();
    FMGL(m_v_cut) = buf.read<x10_double>();
    FMGL(m_qlc_monoq) = buf.read<x10_double>();
    FMGL(m_qqc_monoq) = buf.read<x10_double>();
    FMGL(m_qqc) = buf.read<x10_double>();
    FMGL(m_eosvmax) = buf.read<x10_double>();
    FMGL(m_eosvmin) = buf.read<x10_double>();
    FMGL(m_pmin) = buf.read<x10_double>();
    FMGL(m_emin) = buf.read<x10_double>();
    FMGL(m_dvovmax) = buf.read<x10_double>();
    FMGL(m_refdens) = buf.read<x10_double>();
    FMGL(m_dtcourant) = buf.read<x10_double>();
    FMGL(m_dthydro) = buf.read<x10_double>();
    FMGL(m_dtmax) = buf.read<x10_double>();
    FMGL(m_cycle) = buf.read<x10_int>();
    FMGL(m_sizeX) = buf.read<x10_int>();
    FMGL(m_sizeY) = buf.read<x10_int>();
    FMGL(m_sizeZ) = buf.read<x10_int>();
    FMGL(m_numElem) = buf.read<x10_int>();
    FMGL(m_numNode) = buf.read<x10_int>();
}

x10aux::RuntimeType Domain::rtt;
void Domain::_initRTT() {
    if (rtt.initStageOne(&rtt)) return;
    const x10aux::RuntimeType** parents = NULL; 
    rtt.initStageTwo("Domain",x10aux::RuntimeType::class_kind, 0, parents, 0, NULL, NULL);
}

/* END of Domain */
/*************************************************/
