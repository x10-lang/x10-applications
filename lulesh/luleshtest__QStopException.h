#ifndef __LULESHTEST__QSTOPEXCEPTION_H
#define __LULESHTEST__QSTOPEXCEPTION_H

#include <x10rt.h>


#define X10_LANG_EXCEPTION_H_NODEPS
#include <x10/lang/Exception.h>
#undef X10_LANG_EXCEPTION_H_NODEPS
class luleshtest__QStopException : public x10::lang::Exception   {
    public:
    RTT_H_DECLS_CLASS
    
    virtual luleshtest__QStopException* luleshtest__QStopException____this__luleshtest__QStopException(
      );
    void _constructor();
    
    static luleshtest__QStopException* _make();
    
    
    // Serialization
    public: static const x10aux::serialization_id_t _serialization_id;
    
    public: virtual x10aux::serialization_id_t _get_serialization_id() {
         return _serialization_id;
    }
    
    public: virtual void _serialize_body(x10aux::serialization_buffer& buf);
    
    public: static x10::lang::Reference* _deserializer(x10aux::deserialization_buffer& buf);
    
    public: void _deserialize_body(x10aux::deserialization_buffer& buf);
    
};

#endif // LULESHTEST__QSTOPEXCEPTION_H

class luleshtest__QStopException;

#ifndef LULESHTEST__QSTOPEXCEPTION_H_NODEPS
#define LULESHTEST__QSTOPEXCEPTION_H_NODEPS
#ifndef LULESHTEST__QSTOPEXCEPTION_H_GENERICS
#define LULESHTEST__QSTOPEXCEPTION_H_GENERICS
#endif // LULESHTEST__QSTOPEXCEPTION_H_GENERICS
#endif // __LULESHTEST__QSTOPEXCEPTION_H_NODEPS
