//
// Created by zxl on 2021/6/24.
//

#ifndef BHFLCAL_RECEIVER_CUH
#define BHFLCAL_RECEIVER_CUH

#include <cuda_runtime.h>

typedef enum {
    RectangularRecvType, CylinderRecvType, PolyhedronRecvType
}ReceiverType;

class Receiver{
public:

    // initialization
    virtual void CInit(float pixel_per_meter_for_receiver) = 0;
    virtual void Cset_resolution(float pixel_per_meter_for_receiver) = 0;
    virtual float3 getFocusCenter(const float3 &heliostat_position) = 0;

    // image buffer management
    void Calloc_image();
    void Cclean_image_content();
    void CClear();

    // constructor & destructor
    __device__ __host__ Receiver() : d_image_(nullptr){}
    __device__ __host__ Receiver(const Receiver &rec){
        type_ = rec.type_;
        normal_ = rec.normal_;
        pos_ = rec.pos_;
        size_ = rec.size_;
        surface_index_ = rec.surface_index_;
        pixel_length_ = rec.pixel_length_;
        d_image_ = rec.d_image_;
        resolution_ = rec.resolution_;
    }
    __device__ __host__ ~Receiver();

    // getters with setters
    int getType() const;
    void setType(int type_);
    float3 getNormal() const;
    void setNormal(float3 normal);
    float3 getPosition() const;
    void setPosition(float3 pos);
    float3 getSize() const;
    void setSize(float3 size_);
    int getSurfaceIndex() const;
    void setSurfaceIndex(int surface_index);
    float getPixelLength() const;

    // buffer getter
    __host__ __device__ float *getDeviceImage() const {
        return d_image_;
    }
    // buffer size getter
    __host__ __device__ int2 getResolution() const {
        return resolution_;
    }
protected:
    ReceiverType type_;
    float3 normal_;
    float3 position_;
    float3 size_;
    int surface_index_;
    float pixel_length_;    // size of micro receiver
    float * d_image_;   // image buffer
    int2 resolution_;   // x: column, y: row
};

#endif //BHFLCAL_RECEIVER_CUH
