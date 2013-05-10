#ifndef __LULESHTEST__VOLUMEEXCEPTION_H
#define __LULESHTEST__VOLUMEEXCEPTION_H

#include <x10rt.h>


#define X10_LANG_EXCEPTION_H_NODEPS
#include <x10/lang/Exception.h>
#undef X10_LANG_EXCEPTION_H_NODEPS
class luleshtest__VolumeException : public x10::lang::Exception   {
    public:
    RTT_H_DECLS_CLASS
    
    virtual luleshtest__VolumeException* luleshtest__VolumeException____this__luleshtest__VolumeException(
      );
    void _constructor();
    
    static luleshtest__VolumeException* _make();
    
    
    // Serialization
    public: static const x10aux::serialization_id_t _serialization_id;
    
    public: virtual x10aux::serialization_id_t _get_serialization_id() {
         return _serialization_id;
    }
    
    public: virtual void _serialize_body(x10aux::serialization_buffer& buf);
    
    public: static x10::lang::Reference* _deserializer(x10aux::deserialization_buffer& buf);
    
    public: void _deserialize_body(x10aux::deserialization_buffer& buf);
    
};

#endif // LULESHTEST__VOLUMEEXCEPTION_H

class luleshtest__VolumeException;

#ifndef LULESHTEST__VOLUMEEXCEPTION_H_NODEPS
#define LULESHTEST__VOLUMEEXCEPTION_H_NODEPS
#ifndef LULESHTEST__VOLUMEEXCEPTION_H_GENERICS
#define LULESHTEST__VOLUMEEXCEPTION_H_GENERICS
#endif // LULESHTEST__VOLUMEEXCEPTION_H_GENERICS
#endif // __LULESHTEST__VOLUMEEXCEPTION_H_NODEPS
