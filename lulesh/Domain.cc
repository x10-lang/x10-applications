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
    x10::array::Array<x10_double>* alloc31862 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size94960 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95832 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95806 = ((x10_int) ((size94960) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95832)->::x10::array::RectRegion1D::_constructor(t95806);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95807 = reinterpret_cast<x10::array::Region*>(myReg95832);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31862->FMGL(region) = t95807;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31862->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31862->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31862->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31862->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31862->FMGL(size) = size94960;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95833 = alloc31862->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95834 = alloc31862->FMGL(layout_stride1) = t95833;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31862->FMGL(layout_min0) = t95834;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31862->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95835 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size94960, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31862->FMGL(raw) = t95835;
    
    //#line 10 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_x) = alloc31862;
    
    //#line 11 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31863 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size94965 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95836 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95808 = ((x10_int) ((size94965) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95836)->::x10::array::RectRegion1D::_constructor(t95808);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95809 = reinterpret_cast<x10::array::Region*>(myReg95836);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31863->FMGL(region) = t95809;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31863->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31863->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31863->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31863->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31863->FMGL(size) = size94965;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95837 = alloc31863->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95838 = alloc31863->FMGL(layout_stride1) = t95837;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31863->FMGL(layout_min0) = t95838;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31863->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95839 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size94965, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31863->FMGL(raw) = t95839;
    
    //#line 11 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_y) = alloc31863;
    
    //#line 12 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31864 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size94970 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95840 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95810 = ((x10_int) ((size94970) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95840)->::x10::array::RectRegion1D::_constructor(t95810);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95811 = reinterpret_cast<x10::array::Region*>(myReg95840);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31864->FMGL(region) = t95811;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31864->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31864->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31864->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31864->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31864->FMGL(size) = size94970;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95841 = alloc31864->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95842 = alloc31864->FMGL(layout_stride1) = t95841;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31864->FMGL(layout_min0) = t95842;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31864->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95843 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size94970, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31864->FMGL(raw) = t95843;
    
    //#line 12 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_z) = alloc31864;
    
    //#line 14 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31865 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size94975 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95844 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95812 = ((x10_int) ((size94975) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95844)->::x10::array::RectRegion1D::_constructor(t95812);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95813 = reinterpret_cast<x10::array::Region*>(myReg95844);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31865->FMGL(region) = t95813;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31865->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31865->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31865->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31865->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31865->FMGL(size) = size94975;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95845 = alloc31865->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95846 = alloc31865->FMGL(layout_stride1) = t95845;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31865->FMGL(layout_min0) = t95846;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31865->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95847 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size94975, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31865->FMGL(raw) = t95847;
    
    //#line 14 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_xd) = alloc31865;
    
    //#line 15 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31866 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size94980 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95848 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95814 = ((x10_int) ((size94980) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95848)->::x10::array::RectRegion1D::_constructor(t95814);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95815 = reinterpret_cast<x10::array::Region*>(myReg95848);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31866->FMGL(region) = t95815;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31866->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31866->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31866->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31866->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31866->FMGL(size) = size94980;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95849 = alloc31866->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95850 = alloc31866->FMGL(layout_stride1) = t95849;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31866->FMGL(layout_min0) = t95850;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31866->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95851 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size94980, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31866->FMGL(raw) = t95851;
    
    //#line 15 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_yd) = alloc31866;
    
    //#line 16 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31867 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size94985 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95852 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95816 = ((x10_int) ((size94985) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95852)->::x10::array::RectRegion1D::_constructor(t95816);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95817 = reinterpret_cast<x10::array::Region*>(myReg95852);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31867->FMGL(region) = t95817;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31867->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31867->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31867->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31867->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31867->FMGL(size) = size94985;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95853 = alloc31867->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95854 = alloc31867->FMGL(layout_stride1) = t95853;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31867->FMGL(layout_min0) = t95854;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31867->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95855 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size94985, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31867->FMGL(raw) = t95855;
    
    //#line 16 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_zd) = alloc31867;
    
    //#line 18 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31868 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size94990 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95856 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95818 = ((x10_int) ((size94990) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95856)->::x10::array::RectRegion1D::_constructor(t95818);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95819 = reinterpret_cast<x10::array::Region*>(myReg95856);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31868->FMGL(region) = t95819;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31868->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31868->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31868->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31868->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31868->FMGL(size) = size94990;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95857 = alloc31868->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95858 = alloc31868->FMGL(layout_stride1) = t95857;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31868->FMGL(layout_min0) = t95858;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31868->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95859 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size94990, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31868->FMGL(raw) = t95859;
    
    //#line 18 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_xdd) = alloc31868;
    
    //#line 19 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31869 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size94995 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95860 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95820 = ((x10_int) ((size94995) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95860)->::x10::array::RectRegion1D::_constructor(t95820);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95821 = reinterpret_cast<x10::array::Region*>(myReg95860);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31869->FMGL(region) = t95821;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31869->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31869->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31869->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31869->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31869->FMGL(size) = size94995;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95861 = alloc31869->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95862 = alloc31869->FMGL(layout_stride1) = t95861;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31869->FMGL(layout_min0) = t95862;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31869->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95863 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size94995, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31869->FMGL(raw) = t95863;
    
    //#line 19 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_ydd) = alloc31869;
    
    //#line 20 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31870 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size95000 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95864 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95822 = ((x10_int) ((size95000) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95864)->::x10::array::RectRegion1D::_constructor(t95822);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95823 = reinterpret_cast<x10::array::Region*>(myReg95864);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31870->FMGL(region) = t95823;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31870->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31870->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31870->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31870->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31870->FMGL(size) = size95000;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95865 = alloc31870->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95866 = alloc31870->FMGL(layout_stride1) = t95865;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31870->FMGL(layout_min0) = t95866;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31870->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95867 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size95000, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31870->FMGL(raw) = t95867;
    
    //#line 20 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_zdd) = alloc31870;
    
    //#line 22 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31871 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size95005 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95868 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95824 = ((x10_int) ((size95005) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95868)->::x10::array::RectRegion1D::_constructor(t95824);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95825 = reinterpret_cast<x10::array::Region*>(myReg95868);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31871->FMGL(region) = t95825;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31871->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31871->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31871->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31871->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31871->FMGL(size) = size95005;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95869 = alloc31871->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95870 = alloc31871->FMGL(layout_stride1) = t95869;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31871->FMGL(layout_min0) = t95870;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31871->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95871 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size95005, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31871->FMGL(raw) = t95871;
    
    //#line 22 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_fx) = alloc31871;
    
    //#line 23 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31872 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size95010 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95872 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95826 = ((x10_int) ((size95010) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95872)->::x10::array::RectRegion1D::_constructor(t95826);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95827 = reinterpret_cast<x10::array::Region*>(myReg95872);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31872->FMGL(region) = t95827;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31872->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31872->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31872->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31872->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31872->FMGL(size) = size95010;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95873 = alloc31872->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95874 = alloc31872->FMGL(layout_stride1) = t95873;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31872->FMGL(layout_min0) = t95874;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31872->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95875 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size95010, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31872->FMGL(raw) = t95875;
    
    //#line 23 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_fy) = alloc31872;
    
    //#line 24 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31873 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size95015 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95876 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95828 = ((x10_int) ((size95015) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95876)->::x10::array::RectRegion1D::_constructor(t95828);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95829 = reinterpret_cast<x10::array::Region*>(myReg95876);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31873->FMGL(region) = t95829;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31873->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31873->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31873->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31873->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31873->FMGL(size) = size95015;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95877 = alloc31873->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95878 = alloc31873->FMGL(layout_stride1) = t95877;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31873->FMGL(layout_min0) = t95878;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31873->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95879 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size95015, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31873->FMGL(raw) = t95879;
    
    //#line 24 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_fz) = alloc31873;
    
    //#line 26 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31874 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size95020 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95880 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95830 = ((x10_int) ((size95020) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95880)->::x10::array::RectRegion1D::_constructor(t95830);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95831 = reinterpret_cast<x10::array::Region*>(myReg95880);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31874->FMGL(region) = t95831;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31874->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31874->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31874->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31874->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31874->FMGL(size) = size95020;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95881 = alloc31874->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95882 = alloc31874->FMGL(layout_stride1) = t95881;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31874->FMGL(layout_min0) = t95882;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31874->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95883 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size95020, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31874->FMGL(raw) = t95883;
    
    //#line 26 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_nodalMass) = alloc31874;
}

//#line 30 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
void Domain::AllocateElemPersistent(x10_int size) {
    
    //#line 32 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_int>* alloc31875 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_int> >(), 0, sizeof(x10::array::Array<x10_int>))) x10::array::Array<x10_int>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size95025 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95937 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95884 = ((x10_int) ((size95025) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95937)->::x10::array::RectRegion1D::_constructor(t95884);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95885 = reinterpret_cast<x10::array::Region*>(myReg95937);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31875->FMGL(region) = t95885;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31875->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31875->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31875->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31875->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31875->FMGL(size) = size95025;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95938 = alloc31875->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95939 = alloc31875->FMGL(layout_stride1) = t95938;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31875->FMGL(layout_min0) = t95939;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31875->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_int > t95940 = x10::util::IndexedMemoryChunk<void>::allocate<x10_int >(size95025, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31875->FMGL(raw) = t95940;
    
    //#line 32 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_matElemlist) = alloc31875;
    
    //#line 33 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_int>* alloc31876 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_int> >(), 0, sizeof(x10::array::Array<x10_int>))) x10::array::Array<x10_int>()))
    ;
    
    //#line 33 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_int t95454 = size;
    
    //#line 33 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_int t95455 = ((x10_int) ((t95454) - (((x10_int)1))));
    
    //#line 33 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::lang::IntRange t95456 = x10::lang::IntRange::_make(((x10_int)0), t95455);
    
    //#line 33 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::lang::IntRange t95457 = x10::lang::IntRange::_make(((x10_int)0), ((x10_int)7));
    
    //#line 123 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* reg95030 = t95456->x10::lang::IntRange::__times(t95457);
    
    //#line 125 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95886 = reg95030;
    
    //#line 125 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31876->FMGL(region) = t95886;
    
    //#line 125 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95887 = x10aux::nullCheck(reg95030)->FMGL(rank);
    
    //#line 125 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31876->FMGL(rank) = t95887;
    
    //#line 125 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_boolean t95888 = x10aux::nullCheck(reg95030)->FMGL(rect);
    
    //#line 125 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31876->FMGL(rect) = t95888;
    
    //#line 125 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_boolean t95889 = x10aux::nullCheck(reg95030)->FMGL(zeroBased);
    
    //#line 125 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31876->FMGL(zeroBased) = t95889;
    
    //#line 125 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_boolean t95890 = x10aux::nullCheck(reg95030)->FMGL(rail);
    
    //#line 125 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31876->FMGL(rail) = t95890;
    
    //#line 125 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95891 = x10aux::nullCheck(reg95030)->size();
    
    //#line 125 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31876->FMGL(size) = t95891;
    
    //#line 126 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Array__LayoutHelper crh95941 =  x10::array::Array__LayoutHelper::_alloc();
    
    //#line 126 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (crh95941)->::x10::array::Array__LayoutHelper::_constructor(reg95030);
    
    //#line 127 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95942 = crh95941->FMGL(min0);
    
    //#line 127 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31876->FMGL(layout_min0) = t95942;
    
    //#line 128 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95943 = crh95941->FMGL(stride1);
    
    //#line 128 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31876->FMGL(layout_stride1) = t95943;
    
    //#line 129 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95944 = crh95941->FMGL(min1);
    
    //#line 129 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31876->FMGL(layout_min1) = t95944;
    
    //#line 130 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_int>* t95945 = crh95941->FMGL(layout);
    
    //#line 130 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31876->FMGL(layout) = t95945;
    
    //#line 131 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int n95946 = crh95941->FMGL(size);
    
    //#line 132 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_int > t95947 = x10::util::IndexedMemoryChunk<void>::allocate<x10_int >(n95946, 8, false, true);
    
    //#line 132 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31876->FMGL(raw) = t95947;
    
    //#line 33 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_nodelist) = alloc31876;
    
    //#line 35 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_int>* alloc31877 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_int> >(), 0, sizeof(x10::array::Array<x10_int>))) x10::array::Array<x10_int>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size95034 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95948 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95892 = ((x10_int) ((size95034) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95948)->::x10::array::RectRegion1D::_constructor(t95892);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95893 = reinterpret_cast<x10::array::Region*>(myReg95948);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31877->FMGL(region) = t95893;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31877->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31877->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31877->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31877->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31877->FMGL(size) = size95034;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95949 = alloc31877->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95950 = alloc31877->FMGL(layout_stride1) = t95949;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31877->FMGL(layout_min0) = t95950;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31877->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_int > t95951 = x10::util::IndexedMemoryChunk<void>::allocate<x10_int >(size95034, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31877->FMGL(raw) = t95951;
    
    //#line 35 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_lxim) = alloc31877;
    
    //#line 36 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_int>* alloc31878 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_int> >(), 0, sizeof(x10::array::Array<x10_int>))) x10::array::Array<x10_int>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size95039 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95952 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95894 = ((x10_int) ((size95039) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95952)->::x10::array::RectRegion1D::_constructor(t95894);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95895 = reinterpret_cast<x10::array::Region*>(myReg95952);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31878->FMGL(region) = t95895;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31878->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31878->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31878->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31878->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31878->FMGL(size) = size95039;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95953 = alloc31878->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95954 = alloc31878->FMGL(layout_stride1) = t95953;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31878->FMGL(layout_min0) = t95954;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31878->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_int > t95955 = x10::util::IndexedMemoryChunk<void>::allocate<x10_int >(size95039, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31878->FMGL(raw) = t95955;
    
    //#line 36 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_lxip) = alloc31878;
    
    //#line 37 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_int>* alloc31879 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_int> >(), 0, sizeof(x10::array::Array<x10_int>))) x10::array::Array<x10_int>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size95044 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95956 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95896 = ((x10_int) ((size95044) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95956)->::x10::array::RectRegion1D::_constructor(t95896);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95897 = reinterpret_cast<x10::array::Region*>(myReg95956);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31879->FMGL(region) = t95897;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31879->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31879->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31879->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31879->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31879->FMGL(size) = size95044;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95957 = alloc31879->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95958 = alloc31879->FMGL(layout_stride1) = t95957;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31879->FMGL(layout_min0) = t95958;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31879->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_int > t95959 = x10::util::IndexedMemoryChunk<void>::allocate<x10_int >(size95044, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31879->FMGL(raw) = t95959;
    
    //#line 37 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_letam) = alloc31879;
    
    //#line 38 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_int>* alloc31880 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_int> >(), 0, sizeof(x10::array::Array<x10_int>))) x10::array::Array<x10_int>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size95049 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95960 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95898 = ((x10_int) ((size95049) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95960)->::x10::array::RectRegion1D::_constructor(t95898);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95899 = reinterpret_cast<x10::array::Region*>(myReg95960);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31880->FMGL(region) = t95899;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31880->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31880->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31880->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31880->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31880->FMGL(size) = size95049;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95961 = alloc31880->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95962 = alloc31880->FMGL(layout_stride1) = t95961;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31880->FMGL(layout_min0) = t95962;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31880->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_int > t95963 = x10::util::IndexedMemoryChunk<void>::allocate<x10_int >(size95049, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31880->FMGL(raw) = t95963;
    
    //#line 38 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_letap) = alloc31880;
    
    //#line 39 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_int>* alloc31881 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_int> >(), 0, sizeof(x10::array::Array<x10_int>))) x10::array::Array<x10_int>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size95054 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95964 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95900 = ((x10_int) ((size95054) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95964)->::x10::array::RectRegion1D::_constructor(t95900);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95901 = reinterpret_cast<x10::array::Region*>(myReg95964);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31881->FMGL(region) = t95901;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31881->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31881->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31881->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31881->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31881->FMGL(size) = size95054;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95965 = alloc31881->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95966 = alloc31881->FMGL(layout_stride1) = t95965;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31881->FMGL(layout_min0) = t95966;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31881->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_int > t95967 = x10::util::IndexedMemoryChunk<void>::allocate<x10_int >(size95054, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31881->FMGL(raw) = t95967;
    
    //#line 39 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_lzetam) = alloc31881;
    
    //#line 40 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_int>* alloc31882 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_int> >(), 0, sizeof(x10::array::Array<x10_int>))) x10::array::Array<x10_int>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size95059 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95968 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95902 = ((x10_int) ((size95059) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95968)->::x10::array::RectRegion1D::_constructor(t95902);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95903 = reinterpret_cast<x10::array::Region*>(myReg95968);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31882->FMGL(region) = t95903;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31882->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31882->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31882->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31882->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31882->FMGL(size) = size95059;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95969 = alloc31882->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95970 = alloc31882->FMGL(layout_stride1) = t95969;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31882->FMGL(layout_min0) = t95970;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31882->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_int > t95971 = x10::util::IndexedMemoryChunk<void>::allocate<x10_int >(size95059, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31882->FMGL(raw) = t95971;
    
    //#line 40 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_lzetap) = alloc31882;
    
    //#line 42 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_int>* alloc31883 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_int> >(), 0, sizeof(x10::array::Array<x10_int>))) x10::array::Array<x10_int>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size95064 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95972 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95904 = ((x10_int) ((size95064) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95972)->::x10::array::RectRegion1D::_constructor(t95904);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95905 = reinterpret_cast<x10::array::Region*>(myReg95972);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31883->FMGL(region) = t95905;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31883->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31883->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31883->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31883->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31883->FMGL(size) = size95064;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95973 = alloc31883->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95974 = alloc31883->FMGL(layout_stride1) = t95973;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31883->FMGL(layout_min0) = t95974;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31883->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_int > t95975 = x10::util::IndexedMemoryChunk<void>::allocate<x10_int >(size95064, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31883->FMGL(raw) = t95975;
    
    //#line 42 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_elemBC) = alloc31883;
    
    //#line 44 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31884 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size95069 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95976 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95906 = ((x10_int) ((size95069) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95976)->::x10::array::RectRegion1D::_constructor(t95906);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95907 = reinterpret_cast<x10::array::Region*>(myReg95976);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31884->FMGL(region) = t95907;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31884->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31884->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31884->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31884->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31884->FMGL(size) = size95069;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95977 = alloc31884->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95978 = alloc31884->FMGL(layout_stride1) = t95977;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31884->FMGL(layout_min0) = t95978;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31884->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95979 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size95069, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31884->FMGL(raw) = t95979;
    
    //#line 44 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_e) = alloc31884;
    
    //#line 46 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31885 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size95074 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95980 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95908 = ((x10_int) ((size95074) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95980)->::x10::array::RectRegion1D::_constructor(t95908);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95909 = reinterpret_cast<x10::array::Region*>(myReg95980);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31885->FMGL(region) = t95909;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31885->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31885->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31885->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31885->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31885->FMGL(size) = size95074;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95981 = alloc31885->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95982 = alloc31885->FMGL(layout_stride1) = t95981;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31885->FMGL(layout_min0) = t95982;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31885->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95983 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size95074, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31885->FMGL(raw) = t95983;
    
    //#line 46 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_p) = alloc31885;
    
    //#line 47 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31886 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size95079 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95984 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95910 = ((x10_int) ((size95079) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95984)->::x10::array::RectRegion1D::_constructor(t95910);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95911 = reinterpret_cast<x10::array::Region*>(myReg95984);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31886->FMGL(region) = t95911;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31886->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31886->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31886->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31886->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31886->FMGL(size) = size95079;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95985 = alloc31886->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95986 = alloc31886->FMGL(layout_stride1) = t95985;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31886->FMGL(layout_min0) = t95986;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31886->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95987 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size95079, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31886->FMGL(raw) = t95987;
    
    //#line 47 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_q) = alloc31886;
    
    //#line 48 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31887 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size95084 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95988 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95912 = ((x10_int) ((size95084) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95988)->::x10::array::RectRegion1D::_constructor(t95912);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95913 = reinterpret_cast<x10::array::Region*>(myReg95988);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31887->FMGL(region) = t95913;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31887->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31887->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31887->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31887->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31887->FMGL(size) = size95084;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95989 = alloc31887->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95990 = alloc31887->FMGL(layout_stride1) = t95989;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31887->FMGL(layout_min0) = t95990;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31887->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95991 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size95084, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31887->FMGL(raw) = t95991;
    
    //#line 48 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_ql) = alloc31887;
    
    //#line 49 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31888 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size95089 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95992 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95914 = ((x10_int) ((size95089) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95992)->::x10::array::RectRegion1D::_constructor(t95914);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95915 = reinterpret_cast<x10::array::Region*>(myReg95992);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31888->FMGL(region) = t95915;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31888->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31888->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31888->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31888->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31888->FMGL(size) = size95089;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95993 = alloc31888->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95994 = alloc31888->FMGL(layout_stride1) = t95993;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31888->FMGL(layout_min0) = t95994;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31888->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t95995 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size95089, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31888->FMGL(raw) = t95995;
    
    //#line 49 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_qq) = alloc31888;
    
    //#line 51 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31889 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 335 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size95094 = size;
    
    //#line 335 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double init95095 = ((x10_double) (((x10_int)1)));
    
    //#line 337 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg95996 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 337 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95922 = ((x10_int) ((size95094) - (((x10_int)1))));
    
    //#line 337 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg95996)->::x10::array::RectRegion1D::_constructor(t95922);
    
    //#line 338 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95923 = reinterpret_cast<x10::array::Region*>(myReg95996);
    
    //#line 338 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31889->FMGL(region) = t95923;
    
    //#line 338 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31889->FMGL(rank) = ((x10_int)1);
    
    //#line 338 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31889->FMGL(rect) = true;
    
    //#line 338 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31889->FMGL(zeroBased) = true;
    
    //#line 338 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31889->FMGL(rail) = true;
    
    //#line 338 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31889->FMGL(size) = size95094;
    
    //#line 340 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95997 = alloc31889->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 340 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95998 = alloc31889->FMGL(layout_stride1) = t95997;
    
    //#line 340 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31889->FMGL(layout_min0) = t95998;
    
    //#line 341 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31889->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 342 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > r95999 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size95094, 8, false, false);
    
    //#line 343 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i36808max95924 = ((x10_int) ((size95094) - (((x10_int)1))));
    
    //#line 343 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95919 = ((x10_int)0);
    
    //#line 343 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": polyglot.ast.For_c
    {
        for (; true; ) {
            
            //#line 343 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
            x10_int t95920 = i95919;
            
            //#line 343 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
            x10_boolean t95921 = ((t95920) <= (i36808max95924));
            
            //#line 343 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10If_c
            if (!(t95921)) {
                
                //#line 343 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": polyglot.ast.Branch_c
                break;
            }
            
            //#line 343 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
            x10_int i95916 = i95919;
            
            //#line 344 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10Call_c
            (r95999)->__set(i95916, init95095);
            
            //#line 343 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
            x10_int t95917 = i95919;
            
            //#line 343 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
            x10_int t95918 = ((x10_int) ((t95917) + (((x10_int)1))));
            
            //#line 343 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
            i95919 = t95918;
        }
    }
    
    //#line 346 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31889->FMGL(raw) = r95999;
    
    //#line 51 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_v) = alloc31889;
    
    //#line 52 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31890 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size95105 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg96000 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95925 = ((x10_int) ((size95105) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg96000)->::x10::array::RectRegion1D::_constructor(t95925);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95926 = reinterpret_cast<x10::array::Region*>(myReg96000);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31890->FMGL(region) = t95926;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31890->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31890->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31890->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31890->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31890->FMGL(size) = size95105;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t96001 = alloc31890->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t96002 = alloc31890->FMGL(layout_stride1) = t96001;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31890->FMGL(layout_min0) = t96002;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31890->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t96003 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size95105, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31890->FMGL(raw) = t96003;
    
    //#line 52 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_volo) = alloc31890;
    
    //#line 53 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31891 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size95110 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg96004 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95927 = ((x10_int) ((size95110) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg96004)->::x10::array::RectRegion1D::_constructor(t95927);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95928 = reinterpret_cast<x10::array::Region*>(myReg96004);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31891->FMGL(region) = t95928;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31891->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31891->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31891->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31891->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31891->FMGL(size) = size95110;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t96005 = alloc31891->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t96006 = alloc31891->FMGL(layout_stride1) = t96005;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31891->FMGL(layout_min0) = t96006;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31891->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t96007 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size95110, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31891->FMGL(raw) = t96007;
    
    //#line 53 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_delv) = alloc31891;
    
    //#line 54 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31892 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size95115 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg96008 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95929 = ((x10_int) ((size95115) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg96008)->::x10::array::RectRegion1D::_constructor(t95929);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95930 = reinterpret_cast<x10::array::Region*>(myReg96008);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31892->FMGL(region) = t95930;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31892->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31892->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31892->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31892->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31892->FMGL(size) = size95115;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t96009 = alloc31892->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t96010 = alloc31892->FMGL(layout_stride1) = t96009;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31892->FMGL(layout_min0) = t96010;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31892->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t96011 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size95115, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31892->FMGL(raw) = t96011;
    
    //#line 54 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_vdov) = alloc31892;
    
    //#line 56 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31893 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size95120 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg96012 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95931 = ((x10_int) ((size95120) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg96012)->::x10::array::RectRegion1D::_constructor(t95931);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95932 = reinterpret_cast<x10::array::Region*>(myReg96012);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31893->FMGL(region) = t95932;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31893->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31893->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31893->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31893->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31893->FMGL(size) = size95120;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t96013 = alloc31893->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t96014 = alloc31893->FMGL(layout_stride1) = t96013;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31893->FMGL(layout_min0) = t96014;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31893->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t96015 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size95120, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31893->FMGL(raw) = t96015;
    
    //#line 56 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_arealg) = alloc31893;
    
    //#line 58 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31894 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size95125 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg96016 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95933 = ((x10_int) ((size95125) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg96016)->::x10::array::RectRegion1D::_constructor(t95933);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95934 = reinterpret_cast<x10::array::Region*>(myReg96016);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31894->FMGL(region) = t95934;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31894->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31894->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31894->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31894->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31894->FMGL(size) = size95125;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t96017 = alloc31894->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t96018 = alloc31894->FMGL(layout_stride1) = t96017;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31894->FMGL(layout_min0) = t96018;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31894->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t96019 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size95125, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31894->FMGL(raw) = t96019;
    
    //#line 58 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_ss) = alloc31894;
    
    //#line 60 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31895 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size95130 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg96020 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95935 = ((x10_int) ((size95130) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg96020)->::x10::array::RectRegion1D::_constructor(t95935);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t95936 = reinterpret_cast<x10::array::Region*>(myReg96020);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31895->FMGL(region) = t95936;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31895->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31895->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31895->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31895->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31895->FMGL(size) = size95130;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t96021 = alloc31895->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t96022 = alloc31895->FMGL(layout_stride1) = t96021;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31895->FMGL(layout_min0) = t96022;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31895->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t96023 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size95130, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31895->FMGL(raw) = t96023;
    
    //#line 60 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_elemMass) = alloc31895;
}

//#line 65 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
void Domain::AllocateElemTemporary(x10_int size) {
    
    //#line 67 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31896 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size95135 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg96044 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t96024 = ((x10_int) ((size95135) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg96044)->::x10::array::RectRegion1D::_constructor(t96024);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t96025 = reinterpret_cast<x10::array::Region*>(myReg96044);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31896->FMGL(region) = t96025;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31896->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31896->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31896->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31896->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31896->FMGL(size) = size95135;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t96045 = alloc31896->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t96046 = alloc31896->FMGL(layout_stride1) = t96045;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31896->FMGL(layout_min0) = t96046;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31896->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t96047 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size95135, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31896->FMGL(raw) = t96047;
    
    //#line 67 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_dxx) = alloc31896;
    
    //#line 68 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31897 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size95140 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg96048 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t96026 = ((x10_int) ((size95140) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg96048)->::x10::array::RectRegion1D::_constructor(t96026);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t96027 = reinterpret_cast<x10::array::Region*>(myReg96048);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31897->FMGL(region) = t96027;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31897->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31897->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31897->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31897->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31897->FMGL(size) = size95140;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t96049 = alloc31897->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t96050 = alloc31897->FMGL(layout_stride1) = t96049;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31897->FMGL(layout_min0) = t96050;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31897->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t96051 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size95140, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31897->FMGL(raw) = t96051;
    
    //#line 68 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_dyy) = alloc31897;
    
    //#line 69 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31898 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size95145 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg96052 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t96028 = ((x10_int) ((size95145) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg96052)->::x10::array::RectRegion1D::_constructor(t96028);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t96029 = reinterpret_cast<x10::array::Region*>(myReg96052);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31898->FMGL(region) = t96029;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31898->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31898->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31898->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31898->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31898->FMGL(size) = size95145;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t96053 = alloc31898->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t96054 = alloc31898->FMGL(layout_stride1) = t96053;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31898->FMGL(layout_min0) = t96054;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31898->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t96055 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size95145, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31898->FMGL(raw) = t96055;
    
    //#line 69 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_dzz) = alloc31898;
    
    //#line 71 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31899 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size95150 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg96056 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t96030 = ((x10_int) ((size95150) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg96056)->::x10::array::RectRegion1D::_constructor(t96030);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t96031 = reinterpret_cast<x10::array::Region*>(myReg96056);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31899->FMGL(region) = t96031;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31899->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31899->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31899->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31899->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31899->FMGL(size) = size95150;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t96057 = alloc31899->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t96058 = alloc31899->FMGL(layout_stride1) = t96057;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31899->FMGL(layout_min0) = t96058;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31899->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t96059 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size95150, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31899->FMGL(raw) = t96059;
    
    //#line 71 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_delv_xi) = alloc31899;
    
    //#line 72 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31900 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size95155 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg96060 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t96032 = ((x10_int) ((size95155) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg96060)->::x10::array::RectRegion1D::_constructor(t96032);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t96033 = reinterpret_cast<x10::array::Region*>(myReg96060);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31900->FMGL(region) = t96033;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31900->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31900->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31900->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31900->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31900->FMGL(size) = size95155;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t96061 = alloc31900->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t96062 = alloc31900->FMGL(layout_stride1) = t96061;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31900->FMGL(layout_min0) = t96062;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31900->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t96063 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size95155, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31900->FMGL(raw) = t96063;
    
    //#line 72 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_delv_eta) = alloc31900;
    
    //#line 73 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31901 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size95160 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg96064 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t96034 = ((x10_int) ((size95160) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg96064)->::x10::array::RectRegion1D::_constructor(t96034);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t96035 = reinterpret_cast<x10::array::Region*>(myReg96064);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31901->FMGL(region) = t96035;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31901->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31901->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31901->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31901->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31901->FMGL(size) = size95160;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t96065 = alloc31901->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t96066 = alloc31901->FMGL(layout_stride1) = t96065;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31901->FMGL(layout_min0) = t96066;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31901->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t96067 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size95160, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31901->FMGL(raw) = t96067;
    
    //#line 73 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_delv_zeta) = alloc31901;
    
    //#line 75 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31902 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size95165 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg96068 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t96036 = ((x10_int) ((size95165) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg96068)->::x10::array::RectRegion1D::_constructor(t96036);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t96037 = reinterpret_cast<x10::array::Region*>(myReg96068);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31902->FMGL(region) = t96037;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31902->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31902->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31902->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31902->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31902->FMGL(size) = size95165;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t96069 = alloc31902->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t96070 = alloc31902->FMGL(layout_stride1) = t96069;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31902->FMGL(layout_min0) = t96070;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31902->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t96071 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size95165, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31902->FMGL(raw) = t96071;
    
    //#line 75 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_delx_xi) = alloc31902;
    
    //#line 76 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31903 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size95170 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg96072 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t96038 = ((x10_int) ((size95170) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg96072)->::x10::array::RectRegion1D::_constructor(t96038);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t96039 = reinterpret_cast<x10::array::Region*>(myReg96072);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31903->FMGL(region) = t96039;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31903->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31903->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31903->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31903->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31903->FMGL(size) = size95170;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t96073 = alloc31903->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t96074 = alloc31903->FMGL(layout_stride1) = t96073;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31903->FMGL(layout_min0) = t96074;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31903->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t96075 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size95170, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31903->FMGL(raw) = t96075;
    
    //#line 76 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_delx_eta) = alloc31903;
    
    //#line 77 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31904 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size95175 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg96076 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t96040 = ((x10_int) ((size95175) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg96076)->::x10::array::RectRegion1D::_constructor(t96040);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t96041 = reinterpret_cast<x10::array::Region*>(myReg96076);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31904->FMGL(region) = t96041;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31904->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31904->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31904->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31904->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31904->FMGL(size) = size95175;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t96077 = alloc31904->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t96078 = alloc31904->FMGL(layout_stride1) = t96077;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31904->FMGL(layout_min0) = t96078;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31904->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t96079 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size95175, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31904->FMGL(raw) = t96079;
    
    //#line 77 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_delx_zeta) = alloc31904;
    
    //#line 79 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* alloc31905 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_double> >(), 0, sizeof(x10::array::Array<x10_double>))) x10::array::Array<x10_double>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size95180 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg96080 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t96042 = ((x10_int) ((size95180) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg96080)->::x10::array::RectRegion1D::_constructor(t96042);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t96043 = reinterpret_cast<x10::array::Region*>(myReg96080);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31905->FMGL(region) = t96043;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31905->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31905->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31905->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31905->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31905->FMGL(size) = size95180;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t96081 = alloc31905->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t96082 = alloc31905->FMGL(layout_stride1) = t96081;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31905->FMGL(layout_min0) = t96082;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31905->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t96083 = x10::util::IndexedMemoryChunk<void>::allocate<x10_double >(size95180, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31905->FMGL(raw) = t96083;
    
    //#line 79 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_vnew) = alloc31905;
}

//#line 82 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
void Domain::AllocateNodesets(x10_int size) {
    
    //#line 84 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_int>* alloc31906 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_int> >(), 0, sizeof(x10::array::Array<x10_int>))) x10::array::Array<x10_int>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size95185 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg96090 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t96084 = ((x10_int) ((size95185) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg96090)->::x10::array::RectRegion1D::_constructor(t96084);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t96085 = reinterpret_cast<x10::array::Region*>(myReg96090);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31906->FMGL(region) = t96085;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31906->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31906->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31906->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31906->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31906->FMGL(size) = size95185;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t96091 = alloc31906->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t96092 = alloc31906->FMGL(layout_stride1) = t96091;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31906->FMGL(layout_min0) = t96092;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31906->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_int > t96093 = x10::util::IndexedMemoryChunk<void>::allocate<x10_int >(size95185, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31906->FMGL(raw) = t96093;
    
    //#line 84 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_symmX) = alloc31906;
    
    //#line 85 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_int>* alloc31907 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_int> >(), 0, sizeof(x10::array::Array<x10_int>))) x10::array::Array<x10_int>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size95190 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg96094 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t96086 = ((x10_int) ((size95190) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg96094)->::x10::array::RectRegion1D::_constructor(t96086);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t96087 = reinterpret_cast<x10::array::Region*>(myReg96094);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31907->FMGL(region) = t96087;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31907->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31907->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31907->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31907->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31907->FMGL(size) = size95190;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t96095 = alloc31907->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t96096 = alloc31907->FMGL(layout_stride1) = t96095;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31907->FMGL(layout_min0) = t96096;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31907->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_int > t96097 = x10::util::IndexedMemoryChunk<void>::allocate<x10_int >(size95190, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31907->FMGL(raw) = t96097;
    
    //#line 85 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_symmY) = alloc31907;
    
    //#line 86 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_int>* alloc31908 =  ((new (memset(x10aux::alloc<x10::array::Array<x10_int> >(), 0, sizeof(x10::array::Array<x10_int>))) x10::array::Array<x10_int>()))
    ;
    
    //#line 268 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int size95195 = size;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::RectRegion1D* myReg96098 =  ((new (memset(x10aux::alloc<x10::array::RectRegion1D>(), 0, sizeof(x10::array::RectRegion1D))) x10::array::RectRegion1D()))
    ;
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t96088 = ((x10_int) ((size95195) - (((x10_int)1))));
    
    //#line 270 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10ConstructorCall_c
    (myReg96098)->::x10::array::RectRegion1D::_constructor(t96088);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::array::Region* t96089 = reinterpret_cast<x10::array::Region*>(myReg96098);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31908->FMGL(region) = t96089;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31908->FMGL(rank) = ((x10_int)1);
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31908->FMGL(rect) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31908->FMGL(zeroBased) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31908->FMGL(rail) = true;
    
    //#line 271 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31908->FMGL(size) = size95195;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t96099 = alloc31908->FMGL(layout_min1) = ((x10_int)0);
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t96100 = alloc31908->FMGL(layout_stride1) = t96099;
    
    //#line 273 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31908->FMGL(layout_min0) = t96100;
    
    //#line 274 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31908->FMGL(layout) = (x10aux::class_cast_unchecked<x10::array::Array<x10_int>*>(X10_NULL));
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_int > t96101 = x10::util::IndexedMemoryChunk<void>::allocate<x10_int >(size95195, 8, false, true);
    
    //#line 275 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10FieldAssign_c
    alloc31908->FMGL(raw) = t96101;
    
    //#line 86 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m_symmZ) = alloc31908;
}

//#line 95 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::x(x10_int idx) {
    
    //#line 95 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this95201 = this->FMGL(m_x);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95200 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret95202;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t96102 = x10aux::nullCheck(this95201)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t96103 = (t96102)->__apply(i95200);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95202 = t96103;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95635 = ret95202;
    
    //#line 95 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95635;
    
}

//#line 96 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::y(x10_int idx) {
    
    //#line 96 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this95205 = this->FMGL(m_y);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95204 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret95206;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t96104 = x10aux::nullCheck(this95205)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t96105 = (t96104)->__apply(i95204);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95206 = t96105;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95638 = ret95206;
    
    //#line 96 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95638;
    
}

//#line 97 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::z(x10_int idx) {
    
    //#line 97 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this95209 = this->FMGL(m_z);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95208 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret95210;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t96106 = x10aux::nullCheck(this95209)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t96107 = (t96106)->__apply(i95208);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95210 = t96107;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95641 = ret95210;
    
    //#line 97 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95641;
    
}

//#line 99 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::xd(x10_int idx) {
    
    //#line 99 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this95213 = this->FMGL(m_xd);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95212 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret95214;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t96108 = x10aux::nullCheck(this95213)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t96109 = (t96108)->__apply(i95212);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95214 = t96109;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95644 = ret95214;
    
    //#line 99 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95644;
    
}

//#line 100 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::yd(x10_int idx) {
    
    //#line 100 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this95217 = this->FMGL(m_yd);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95216 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret95218;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t96110 = x10aux::nullCheck(this95217)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t96111 = (t96110)->__apply(i95216);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95218 = t96111;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95647 = ret95218;
    
    //#line 100 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95647;
    
}

//#line 101 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::zd(x10_int idx) {
    
    //#line 101 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this95221 = this->FMGL(m_zd);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95220 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret95222;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t96112 = x10aux::nullCheck(this95221)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t96113 = (t96112)->__apply(i95220);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95222 = t96113;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95650 = ret95222;
    
    //#line 101 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95650;
    
}

//#line 103 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::xdd(x10_int idx) {
    
    //#line 103 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this95225 = this->FMGL(m_xdd);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95224 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret95226;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t96114 = x10aux::nullCheck(this95225)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t96115 = (t96114)->__apply(i95224);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95226 = t96115;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95653 = ret95226;
    
    //#line 103 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95653;
    
}

//#line 104 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::ydd(x10_int idx) {
    
    //#line 104 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this95229 = this->FMGL(m_ydd);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95228 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret95230;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t96116 = x10aux::nullCheck(this95229)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t96117 = (t96116)->__apply(i95228);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95230 = t96117;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95656 = ret95230;
    
    //#line 104 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95656;
    
}

//#line 105 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::zdd(x10_int idx) {
    
    //#line 105 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this95233 = this->FMGL(m_zdd);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95232 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret95234;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t96118 = x10aux::nullCheck(this95233)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t96119 = (t96118)->__apply(i95232);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95234 = t96119;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95659 = ret95234;
    
    //#line 105 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95659;
    
}

//#line 107 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::fx(x10_int idx) {
    
    //#line 107 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this95237 = this->FMGL(m_fx);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95236 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret95238;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t96120 = x10aux::nullCheck(this95237)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t96121 = (t96120)->__apply(i95236);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95238 = t96121;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95662 = ret95238;
    
    //#line 107 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95662;
    
}

//#line 108 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::fy(x10_int idx) {
    
    //#line 108 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this95241 = this->FMGL(m_fy);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95240 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret95242;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t96122 = x10aux::nullCheck(this95241)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t96123 = (t96122)->__apply(i95240);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95242 = t96123;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95665 = ret95242;
    
    //#line 108 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95665;
    
}

//#line 109 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::fz(x10_int idx) {
    
    //#line 109 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this95245 = this->FMGL(m_fz);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95244 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret95246;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t96124 = x10aux::nullCheck(this95245)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t96125 = (t96124)->__apply(i95244);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95246 = t96125;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95668 = ret95246;
    
    //#line 109 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95668;
    
}

//#line 111 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::nodalMass(x10_int idx) {
    
    //#line 111 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this95249 = this->FMGL(m_nodalMass);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95248 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret95250;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t96126 = x10aux::nullCheck(this95249)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t96127 = (t96126)->__apply(i95248);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95250 = t96127;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95671 = ret95250;
    
    //#line 111 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95671;
    
}

//#line 113 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_int Domain::symmX(x10_int idx) {
    
    //#line 113 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_int>* this95253 = this->FMGL(m_symmX);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95252 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int ret95254;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_int > t96128 = x10aux::nullCheck(this95253)->
                                                       FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t96129 = (t96128)->__apply(i95252);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95254 = t96129;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95674 = ret95254;
    
    //#line 113 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95674;
    
}

//#line 114 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_int Domain::symmY(x10_int idx) {
    
    //#line 114 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_int>* this95257 = this->FMGL(m_symmY);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95256 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int ret95258;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_int > t96130 = x10aux::nullCheck(this95257)->
                                                       FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t96131 = (t96130)->__apply(i95256);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95258 = t96131;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95677 = ret95258;
    
    //#line 114 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95677;
    
}

//#line 115 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_int Domain::symmZ(x10_int idx) {
    
    //#line 115 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_int>* this95261 = this->FMGL(m_symmZ);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95260 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int ret95262;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_int > t96132 = x10aux::nullCheck(this95261)->
                                                       FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t96133 = (t96132)->__apply(i95260);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95262 = t96133;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95680 = ret95262;
    
    //#line 115 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95680;
    
}

//#line 119 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_int Domain::matElemlist(x10_int idx) {
    
    //#line 119 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_int>* this95265 = this->FMGL(m_matElemlist);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95264 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int ret95266;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_int > t96134 = x10aux::nullCheck(this95265)->
                                                       FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t96135 = (t96134)->__apply(i95264);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95266 = t96135;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95683 = ret95266;
    
    //#line 119 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95683;
    
}

//#line 120 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10::array::Array<x10_int>* Domain::nodelist() {
    
    //#line 120 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_int>* t95684 = this->FMGL(m_nodelist);
    
    //#line 120 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95684;
    
}

//#line 122 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_int Domain::lxim(x10_int idx) {
    
    //#line 122 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_int>* this95269 = this->FMGL(m_lxim);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95268 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int ret95270;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_int > t96136 = x10aux::nullCheck(this95269)->
                                                       FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t96137 = (t96136)->__apply(i95268);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95270 = t96137;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95687 = ret95270;
    
    //#line 122 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95687;
    
}

//#line 123 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_int Domain::lxip(x10_int idx) {
    
    //#line 123 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_int>* this95273 = this->FMGL(m_lxip);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95272 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int ret95274;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_int > t96138 = x10aux::nullCheck(this95273)->
                                                       FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t96139 = (t96138)->__apply(i95272);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95274 = t96139;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95690 = ret95274;
    
    //#line 123 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95690;
    
}

//#line 124 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_int Domain::letam(x10_int idx) {
    
    //#line 124 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_int>* this95277 = this->FMGL(m_letam);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95276 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int ret95278;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_int > t96140 = x10aux::nullCheck(this95277)->
                                                       FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t96141 = (t96140)->__apply(i95276);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95278 = t96141;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95693 = ret95278;
    
    //#line 124 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95693;
    
}

//#line 125 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_int Domain::letap(x10_int idx) {
    
    //#line 125 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_int>* this95281 = this->FMGL(m_letap);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95280 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int ret95282;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_int > t96142 = x10aux::nullCheck(this95281)->
                                                       FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t96143 = (t96142)->__apply(i95280);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95282 = t96143;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95696 = ret95282;
    
    //#line 125 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95696;
    
}

//#line 126 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_int Domain::lzetam(x10_int idx) {
    
    //#line 126 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_int>* this95285 = this->FMGL(m_lzetam);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95284 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int ret95286;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_int > t96144 = x10aux::nullCheck(this95285)->
                                                       FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t96145 = (t96144)->__apply(i95284);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95286 = t96145;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95699 = ret95286;
    
    //#line 126 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95699;
    
}

//#line 127 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_int Domain::lzetap(x10_int idx) {
    
    //#line 127 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_int>* this95289 = this->FMGL(m_lzetap);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95288 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int ret95290;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_int > t96146 = x10aux::nullCheck(this95289)->
                                                       FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t96147 = (t96146)->__apply(i95288);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95290 = t96147;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95702 = ret95290;
    
    //#line 127 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95702;
    
}

//#line 129 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_int Domain::elemBC(x10_int idx) {
    
    //#line 129 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_int>* this95293 = this->FMGL(m_elemBC);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95292 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int ret95294;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_int > t96148 = x10aux::nullCheck(this95293)->
                                                       FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t96149 = (t96148)->__apply(i95292);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95294 = t96149;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int t95705 = ret95294;
    
    //#line 129 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95705;
    
}

//#line 131 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::dxx(x10_int idx) {
    
    //#line 131 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this95297 = this->FMGL(m_dxx);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95296 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret95298;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t96150 = x10aux::nullCheck(this95297)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t96151 = (t96150)->__apply(i95296);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95298 = t96151;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95708 = ret95298;
    
    //#line 131 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95708;
    
}

//#line 132 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::dyy(x10_int idx) {
    
    //#line 132 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this95301 = this->FMGL(m_dyy);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95300 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret95302;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t96152 = x10aux::nullCheck(this95301)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t96153 = (t96152)->__apply(i95300);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95302 = t96153;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95711 = ret95302;
    
    //#line 132 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95711;
    
}

//#line 133 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::dzz(x10_int idx) {
    
    //#line 133 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this95305 = this->FMGL(m_dzz);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95304 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret95306;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t96154 = x10aux::nullCheck(this95305)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t96155 = (t96154)->__apply(i95304);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95306 = t96155;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95714 = ret95306;
    
    //#line 133 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95714;
    
}

//#line 135 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::delv_xi(x10_int idx) {
    
    //#line 135 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this95309 = this->FMGL(m_delv_xi);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95308 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret95310;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t96156 = x10aux::nullCheck(this95309)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t96157 = (t96156)->__apply(i95308);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95310 = t96157;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95717 = ret95310;
    
    //#line 135 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95717;
    
}

//#line 136 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::delv_eta(x10_int idx) {
    
    //#line 136 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this95313 = this->FMGL(m_delv_eta);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95312 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret95314;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t96158 = x10aux::nullCheck(this95313)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t96159 = (t96158)->__apply(i95312);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95314 = t96159;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95720 = ret95314;
    
    //#line 136 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95720;
    
}

//#line 137 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::delv_zeta(x10_int idx) {
    
    //#line 137 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this95317 = this->FMGL(m_delv_zeta);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95316 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret95318;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t96160 = x10aux::nullCheck(this95317)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t96161 = (t96160)->__apply(i95316);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95318 = t96161;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95723 = ret95318;
    
    //#line 137 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95723;
    
}

//#line 139 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::delx_xi(x10_int idx) {
    
    //#line 139 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this95321 = this->FMGL(m_delx_xi);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95320 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret95322;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t96162 = x10aux::nullCheck(this95321)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t96163 = (t96162)->__apply(i95320);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95322 = t96163;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95726 = ret95322;
    
    //#line 139 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95726;
    
}

//#line 140 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::delx_eta(x10_int idx) {
    
    //#line 140 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this95325 = this->FMGL(m_delx_eta);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95324 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret95326;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t96164 = x10aux::nullCheck(this95325)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t96165 = (t96164)->__apply(i95324);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95326 = t96165;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95729 = ret95326;
    
    //#line 140 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95729;
    
}

//#line 141 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::delx_zeta(x10_int idx) {
    
    //#line 141 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this95329 = this->FMGL(m_delx_zeta);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95328 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret95330;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t96166 = x10aux::nullCheck(this95329)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t96167 = (t96166)->__apply(i95328);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95330 = t96167;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95732 = ret95330;
    
    //#line 141 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95732;
    
}

//#line 143 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::e(x10_int idx) {
    
    //#line 143 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this95333 = this->FMGL(m_e);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95332 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret95334;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t96168 = x10aux::nullCheck(this95333)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t96169 = (t96168)->__apply(i95332);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95334 = t96169;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95735 = ret95334;
    
    //#line 143 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95735;
    
}

//#line 145 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::p(x10_int idx) {
    
    //#line 145 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this95337 = this->FMGL(m_p);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95336 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret95338;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t96170 = x10aux::nullCheck(this95337)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t96171 = (t96170)->__apply(i95336);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95338 = t96171;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95738 = ret95338;
    
    //#line 145 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95738;
    
}

//#line 146 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::q(x10_int idx) {
    
    //#line 146 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this95341 = this->FMGL(m_q);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95340 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret95342;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t96172 = x10aux::nullCheck(this95341)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t96173 = (t96172)->__apply(i95340);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95342 = t96173;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95741 = ret95342;
    
    //#line 146 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95741;
    
}

//#line 147 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::ql(x10_int idx) {
    
    //#line 147 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this95345 = this->FMGL(m_ql);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95344 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret95346;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t96174 = x10aux::nullCheck(this95345)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t96175 = (t96174)->__apply(i95344);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95346 = t96175;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95744 = ret95346;
    
    //#line 147 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95744;
    
}

//#line 148 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::qq(x10_int idx) {
    
    //#line 148 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this95349 = this->FMGL(m_qq);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95348 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret95350;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t96176 = x10aux::nullCheck(this95349)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t96177 = (t96176)->__apply(i95348);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95350 = t96177;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95747 = ret95350;
    
    //#line 148 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95747;
    
}

//#line 150 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::v(x10_int idx) {
    
    //#line 150 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this95353 = this->FMGL(m_v);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95352 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret95354;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t96178 = x10aux::nullCheck(this95353)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t96179 = (t96178)->__apply(i95352);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95354 = t96179;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95750 = ret95354;
    
    //#line 150 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95750;
    
}

//#line 151 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::volo(x10_int idx) {
    
    //#line 151 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this95357 = this->FMGL(m_volo);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95356 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret95358;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t96180 = x10aux::nullCheck(this95357)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t96181 = (t96180)->__apply(i95356);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95358 = t96181;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95753 = ret95358;
    
    //#line 151 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95753;
    
}

//#line 152 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::vnew(x10_int idx) {
    
    //#line 152 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this95361 = this->FMGL(m_vnew);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95360 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret95362;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t96182 = x10aux::nullCheck(this95361)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t96183 = (t96182)->__apply(i95360);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95362 = t96183;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95756 = ret95362;
    
    //#line 152 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95756;
    
}

//#line 153 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::delv(x10_int idx) {
    
    //#line 153 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this95365 = this->FMGL(m_delv);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95364 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret95366;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t96184 = x10aux::nullCheck(this95365)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t96185 = (t96184)->__apply(i95364);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95366 = t96185;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95759 = ret95366;
    
    //#line 153 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95759;
    
}

//#line 154 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::vdov(x10_int idx) {
    
    //#line 154 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this95369 = this->FMGL(m_vdov);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95368 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret95370;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t96186 = x10aux::nullCheck(this95369)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t96187 = (t96186)->__apply(i95368);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95370 = t96187;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95762 = ret95370;
    
    //#line 154 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95762;
    
}

//#line 156 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::arealg(x10_int idx) {
    
    //#line 156 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this95373 = this->FMGL(m_arealg);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95372 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret95374;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t96188 = x10aux::nullCheck(this95373)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t96189 = (t96188)->__apply(i95372);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95374 = t96189;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95765 = ret95374;
    
    //#line 156 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95765;
    
}

//#line 158 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::ss(x10_int idx) {
    
    //#line 158 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this95377 = this->FMGL(m_ss);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95376 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret95378;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t96190 = x10aux::nullCheck(this95377)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t96191 = (t96190)->__apply(i95376);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95378 = t96191;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95768 = ret95378;
    
    //#line 158 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95768;
    
}

//#line 160 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::elemMass(x10_int idx) {
    
    //#line 160 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10::array::Array<x10_double>* this95381 = this->FMGL(m_elemMass);
    
    //#line 453 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_int i95380 = idx;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double ret95382;
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10::util::IndexedMemoryChunk<x10_double > t96192 = x10aux::nullCheck(this95381)->
                                                          FMGL(raw);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t96193 = (t96192)->__apply(i95380);
    
    //#line 456 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": Eval of x10.ast.X10LocalAssign_c
    ret95382 = t96193;
    
    //#line 452 "/Users/daperlmu/Desktop/x10/stdlib/x10.jar:x10/array/Array.x10": x10.ast.X10LocalDecl_c
    x10_double t95771 = ret95382;
    
    //#line 160 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95771;
    
}

//#line 164 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::dtfixed() {
    
    //#line 164 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_double t95772 = this->FMGL(m_dtfixed);
    
    //#line 164 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95772;
    
}

//#line 165 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::time() {
    
    //#line 165 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_double t95773 = this->FMGL(m_time);
    
    //#line 165 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95773;
    
}

//#line 166 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::deltatime() {
    
    //#line 166 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_double t95774 = this->FMGL(m_deltatime);
    
    //#line 166 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95774;
    
}

//#line 167 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::deltatimemultlb() {
    
    //#line 167 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_double t95775 = this->FMGL(m_deltatimemultlb);
    
    //#line 167 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95775;
    
}

//#line 168 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::deltatimemultub() {
    
    //#line 168 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_double t95776 = this->FMGL(m_deltatimemultub);
    
    //#line 168 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95776;
    
}

//#line 169 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::stoptime() {
    
    //#line 169 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_double t95777 = this->FMGL(m_stoptime);
    
    //#line 169 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95777;
    
}

//#line 171 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::u_cut() {
    
    //#line 171 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_double t95778 = this->FMGL(m_u_cut);
    
    //#line 171 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95778;
    
}

//#line 172 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::hgcoef() {
    
    //#line 172 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_double t95779 = this->FMGL(m_hgcoef);
    
    //#line 172 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95779;
    
}

//#line 173 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::qstop() {
    
    //#line 173 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_double t95780 = this->FMGL(m_qstop);
    
    //#line 173 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95780;
    
}

//#line 174 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::monoq_max_slope() {
    
    //#line 174 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_double t95781 = this->FMGL(m_monoq_max_slope);
    
    //#line 174 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95781;
    
}

//#line 175 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::monoq_limiter_mult() {
    
    //#line 175 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_double t95782 = this->FMGL(m_monoq_limiter_mult);
    
    //#line 175 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95782;
    
}

//#line 176 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::e_cut() {
    
    //#line 176 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_double t95783 = this->FMGL(m_e_cut);
    
    //#line 176 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95783;
    
}

//#line 177 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::p_cut() {
    
    //#line 177 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_double t95784 = this->FMGL(m_p_cut);
    
    //#line 177 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95784;
    
}

//#line 178 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::ss4o3() {
    
    //#line 178 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_double t95785 = this->FMGL(m_ss4o3);
    
    //#line 178 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95785;
    
}

//#line 179 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::q_cut() {
    
    //#line 179 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_double t95786 = this->FMGL(m_q_cut);
    
    //#line 179 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95786;
    
}

//#line 180 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::v_cut() {
    
    //#line 180 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_double t95787 = this->FMGL(m_v_cut);
    
    //#line 180 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95787;
    
}

//#line 181 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::qlc_monoq() {
    
    //#line 181 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_double t95788 = this->FMGL(m_qlc_monoq);
    
    //#line 181 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95788;
    
}

//#line 182 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::qqc_monoq() {
    
    //#line 182 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_double t95789 = this->FMGL(m_qqc_monoq);
    
    //#line 182 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95789;
    
}

//#line 183 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::qqc() {
    
    //#line 183 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_double t95790 = this->FMGL(m_qqc);
    
    //#line 183 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95790;
    
}

//#line 184 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::eosvmax() {
    
    //#line 184 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_double t95791 = this->FMGL(m_eosvmax);
    
    //#line 184 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95791;
    
}

//#line 185 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::eosvmin() {
    
    //#line 185 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_double t95792 = this->FMGL(m_eosvmin);
    
    //#line 185 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95792;
    
}

//#line 186 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::pmin() {
    
    //#line 186 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_double t95793 = this->FMGL(m_pmin);
    
    //#line 186 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95793;
    
}

//#line 187 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::emin() {
    
    //#line 187 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_double t95794 = this->FMGL(m_emin);
    
    //#line 187 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95794;
    
}

//#line 188 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::dvovmax() {
    
    //#line 188 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_double t95795 = this->FMGL(m_dvovmax);
    
    //#line 188 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95795;
    
}

//#line 189 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::refdens() {
    
    //#line 189 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_double t95796 = this->FMGL(m_refdens);
    
    //#line 189 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95796;
    
}

//#line 191 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::dtcourant() {
    
    //#line 191 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_double t95797 = this->FMGL(m_dtcourant);
    
    //#line 191 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95797;
    
}

//#line 192 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::dthydro() {
    
    //#line 192 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_double t95798 = this->FMGL(m_dthydro);
    
    //#line 192 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95798;
    
}

//#line 193 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_double Domain::dtmax() {
    
    //#line 193 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_double t95799 = this->FMGL(m_dtmax);
    
    //#line 193 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95799;
    
}

//#line 195 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_int Domain::cycle() {
    
    //#line 195 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_int t95800 = this->FMGL(m_cycle);
    
    //#line 195 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95800;
    
}

//#line 197 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_int Domain::sizeX() {
    
    //#line 197 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_int t95801 = this->FMGL(m_sizeX);
    
    //#line 197 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95801;
    
}

//#line 198 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_int Domain::sizeY() {
    
    //#line 198 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_int t95802 = this->FMGL(m_sizeY);
    
    //#line 198 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95802;
    
}

//#line 199 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_int Domain::sizeZ() {
    
    //#line 199 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_int t95803 = this->FMGL(m_sizeZ);
    
    //#line 199 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95803;
    
}

//#line 200 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_int Domain::numElem() {
    
    //#line 200 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_int t95804 = this->FMGL(m_numElem);
    
    //#line 200 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95804;
    
}

//#line 201 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
x10_int Domain::numNode() {
    
    //#line 201 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10LocalDecl_c
    x10_int t95805 = this->FMGL(m_numNode);
    
    //#line 201 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10Return_c
    return t95805;
    
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
    this->Domain::__fieldInitializers31850();
}
Domain* Domain::_make() {
    Domain* this_ = new (memset(x10aux::alloc<Domain>(), 0, sizeof(Domain))) Domain();
    this_->_constructor();
    return this_;
}



//#line 3 "/Users/daperlmu/Desktop/luleshtest/serial/Domain.x10": x10.ast.X10MethodDecl_c
void Domain::__fieldInitializers31850() {
    
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
