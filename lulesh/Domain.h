#ifndef __DOMAIN_H
#define __DOMAIN_H

#include <x10rt.h>


#define X10_LANG_DOUBLE_H_NODEPS
#include <x10/lang/Double.h>
#undef X10_LANG_DOUBLE_H_NODEPS
#define X10_LANG_INT_H_NODEPS
#include <x10/lang/Int.h>
#undef X10_LANG_INT_H_NODEPS
#define X10_LANG_DOUBLE_H_NODEPS
#include <x10/lang/Double.h>
#undef X10_LANG_DOUBLE_H_NODEPS
#define X10_LANG_INT_H_NODEPS
#include <x10/lang/Int.h>
#undef X10_LANG_INT_H_NODEPS
namespace x10 { namespace array { 
template<class TPMGL(T)> class Array;
} } 
namespace x10 { namespace array { 
class RectRegion1D;
} } 
namespace x10 { namespace array { 
class Region;
} } 
namespace x10 { namespace util { 
template<class TPMGL(T)> class IndexedMemoryChunk;
} } 
namespace x10 { namespace lang { 
class IntRange;
} } 
namespace x10 { namespace lang { 
class Boolean;
} } 
namespace x10 { namespace array { 
class Array__LayoutHelper;
} } 
class Domain : public x10::lang::X10Class   {
    public:
    RTT_H_DECLS_CLASS
    
    virtual void AllocateNodalPersistent(x10_int size);
    virtual void AllocateElemPersistent(x10_int size);
    virtual void AllocateElemTemporary(x10_int size);
    virtual void AllocateNodesets(x10_int size);
    virtual x10_double x(x10_int idx);
    virtual x10_double y(x10_int idx);
    virtual x10_double z(x10_int idx);
    virtual x10_double xd(x10_int idx);
    virtual x10_double yd(x10_int idx);
    virtual x10_double zd(x10_int idx);
    virtual x10_double xdd(x10_int idx);
    virtual x10_double ydd(x10_int idx);
    virtual x10_double zdd(x10_int idx);
    virtual x10_double fx(x10_int idx);
    virtual x10_double fy(x10_int idx);
    virtual x10_double fz(x10_int idx);
    virtual x10_double nodalMass(x10_int idx);
    virtual x10_int symmX(x10_int idx);
    virtual x10_int symmY(x10_int idx);
    virtual x10_int symmZ(x10_int idx);
    virtual x10_int matElemlist(x10_int idx);
    virtual x10::array::Array<x10_int>* nodelist();
    virtual x10_int lxim(x10_int idx);
    virtual x10_int lxip(x10_int idx);
    virtual x10_int letam(x10_int idx);
    virtual x10_int letap(x10_int idx);
    virtual x10_int lzetam(x10_int idx);
    virtual x10_int lzetap(x10_int idx);
    virtual x10_int elemBC(x10_int idx);
    virtual x10_double dxx(x10_int idx);
    virtual x10_double dyy(x10_int idx);
    virtual x10_double dzz(x10_int idx);
    virtual x10_double delv_xi(x10_int idx);
    virtual x10_double delv_eta(x10_int idx);
    virtual x10_double delv_zeta(x10_int idx);
    virtual x10_double delx_xi(x10_int idx);
    virtual x10_double delx_eta(x10_int idx);
    virtual x10_double delx_zeta(x10_int idx);
    virtual x10_double e(x10_int idx);
    virtual x10_double p(x10_int idx);
    virtual x10_double q(x10_int idx);
    virtual x10_double ql(x10_int idx);
    virtual x10_double qq(x10_int idx);
    virtual x10_double v(x10_int idx);
    virtual x10_double volo(x10_int idx);
    virtual x10_double vnew(x10_int idx);
    virtual x10_double delv(x10_int idx);
    virtual x10_double vdov(x10_int idx);
    virtual x10_double arealg(x10_int idx);
    virtual x10_double ss(x10_int idx);
    virtual x10_double elemMass(x10_int idx);
    virtual x10_double dtfixed();
    virtual x10_double time();
    virtual x10_double deltatime();
    virtual x10_double deltatimemultlb();
    virtual x10_double deltatimemultub();
    virtual x10_double stoptime();
    virtual x10_double u_cut();
    virtual x10_double hgcoef();
    virtual x10_double qstop();
    virtual x10_double monoq_max_slope();
    virtual x10_double monoq_limiter_mult();
    virtual x10_double e_cut();
    virtual x10_double p_cut();
    virtual x10_double ss4o3();
    virtual x10_double q_cut();
    virtual x10_double v_cut();
    virtual x10_double qlc_monoq();
    virtual x10_double qqc_monoq();
    virtual x10_double qqc();
    virtual x10_double eosvmax();
    virtual x10_double eosvmin();
    virtual x10_double pmin();
    virtual x10_double emin();
    virtual x10_double dvovmax();
    virtual x10_double refdens();
    virtual x10_double dtcourant();
    virtual x10_double dthydro();
    virtual x10_double dtmax();
    virtual x10_int cycle();
    virtual x10_int sizeX();
    virtual x10_int sizeY();
    virtual x10_int sizeZ();
    virtual x10_int numElem();
    virtual x10_int numNode();
    x10::array::Array<x10_double>* FMGL(m_x);
    
    x10::array::Array<x10_double>* FMGL(m_y);
    
    x10::array::Array<x10_double>* FMGL(m_z);
    
    x10::array::Array<x10_double>* FMGL(m_xd);
    
    x10::array::Array<x10_double>* FMGL(m_yd);
    
    x10::array::Array<x10_double>* FMGL(m_zd);
    
    x10::array::Array<x10_double>* FMGL(m_xdd);
    
    x10::array::Array<x10_double>* FMGL(m_ydd);
    
    x10::array::Array<x10_double>* FMGL(m_zdd);
    
    x10::array::Array<x10_double>* FMGL(m_fx);
    
    x10::array::Array<x10_double>* FMGL(m_fy);
    
    x10::array::Array<x10_double>* FMGL(m_fz);
    
    x10::array::Array<x10_double>* FMGL(m_nodalMass);
    
    x10::array::Array<x10_int>* FMGL(m_symmX);
    
    x10::array::Array<x10_int>* FMGL(m_symmY);
    
    x10::array::Array<x10_int>* FMGL(m_symmZ);
    
    x10::array::Array<x10_int>* FMGL(m_matElemlist);
    
    x10::array::Array<x10_int>* FMGL(m_nodelist);
    
    x10::array::Array<x10_int>* FMGL(m_lxim);
    
    x10::array::Array<x10_int>* FMGL(m_lxip);
    
    x10::array::Array<x10_int>* FMGL(m_letam);
    
    x10::array::Array<x10_int>* FMGL(m_letap);
    
    x10::array::Array<x10_int>* FMGL(m_lzetam);
    
    x10::array::Array<x10_int>* FMGL(m_lzetap);
    
    x10::array::Array<x10_int>* FMGL(m_elemBC);
    
    x10::array::Array<x10_double>* FMGL(m_dxx);
    
    x10::array::Array<x10_double>* FMGL(m_dyy);
    
    x10::array::Array<x10_double>* FMGL(m_dzz);
    
    x10::array::Array<x10_double>* FMGL(m_delv_xi);
    
    x10::array::Array<x10_double>* FMGL(m_delv_eta);
    
    x10::array::Array<x10_double>* FMGL(m_delv_zeta);
    
    x10::array::Array<x10_double>* FMGL(m_delx_xi);
    
    x10::array::Array<x10_double>* FMGL(m_delx_eta);
    
    x10::array::Array<x10_double>* FMGL(m_delx_zeta);
    
    x10::array::Array<x10_double>* FMGL(m_e);
    
    x10::array::Array<x10_double>* FMGL(m_p);
    
    x10::array::Array<x10_double>* FMGL(m_q);
    
    x10::array::Array<x10_double>* FMGL(m_ql);
    
    x10::array::Array<x10_double>* FMGL(m_qq);
    
    x10::array::Array<x10_double>* FMGL(m_v);
    
    x10::array::Array<x10_double>* FMGL(m_volo);
    
    x10::array::Array<x10_double>* FMGL(m_vnew);
    
    x10::array::Array<x10_double>* FMGL(m_delv);
    
    x10::array::Array<x10_double>* FMGL(m_vdov);
    
    x10::array::Array<x10_double>* FMGL(m_arealg);
    
    x10::array::Array<x10_double>* FMGL(m_ss);
    
    x10::array::Array<x10_double>* FMGL(m_elemMass);
    
    x10_double FMGL(m_dtfixed);
    
    x10_double FMGL(m_time);
    
    x10_double FMGL(m_deltatime);
    
    x10_double FMGL(m_deltatimemultlb);
    
    x10_double FMGL(m_deltatimemultub);
    
    x10_double FMGL(m_stoptime);
    
    x10_double FMGL(m_u_cut);
    
    x10_double FMGL(m_hgcoef);
    
    x10_double FMGL(m_qstop);
    
    x10_double FMGL(m_monoq_max_slope);
    
    x10_double FMGL(m_monoq_limiter_mult);
    
    x10_double FMGL(m_e_cut);
    
    x10_double FMGL(m_p_cut);
    
    x10_double FMGL(m_ss4o3);
    
    x10_double FMGL(m_q_cut);
    
    x10_double FMGL(m_v_cut);
    
    x10_double FMGL(m_qlc_monoq);
    
    x10_double FMGL(m_qqc_monoq);
    
    x10_double FMGL(m_qqc);
    
    x10_double FMGL(m_eosvmax);
    
    x10_double FMGL(m_eosvmin);
    
    x10_double FMGL(m_pmin);
    
    x10_double FMGL(m_emin);
    
    x10_double FMGL(m_dvovmax);
    
    x10_double FMGL(m_refdens);
    
    x10_double FMGL(m_dtcourant);
    
    x10_double FMGL(m_dthydro);
    
    x10_double FMGL(m_dtmax);
    
    x10_int FMGL(m_cycle);
    
    x10_int FMGL(m_sizeX);
    
    x10_int FMGL(m_sizeY);
    
    x10_int FMGL(m_sizeZ);
    
    x10_int FMGL(m_numElem);
    
    x10_int FMGL(m_numNode);
    
    virtual Domain* Domain____this__Domain();
    void _constructor();
    
    static Domain* _make();
    
    virtual void __fieldInitializers31850();
    
    // Serialization
    public: static const x10aux::serialization_id_t _serialization_id;
    
    public: virtual x10aux::serialization_id_t _get_serialization_id() {
         return _serialization_id;
    }
    
    public: virtual void _serialize_body(x10aux::serialization_buffer& buf);
    
    public: static x10::lang::Reference* _deserializer(x10aux::deserialization_buffer& buf);
    
    public: void _deserialize_body(x10aux::deserialization_buffer& buf);
    
};

#endif // DOMAIN_H

class Domain;

#ifndef DOMAIN_H_NODEPS
#define DOMAIN_H_NODEPS
#ifndef DOMAIN_H_GENERICS
#define DOMAIN_H_GENERICS
#endif // DOMAIN_H_GENERICS
#endif // __DOMAIN_H_NODEPS
