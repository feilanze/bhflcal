//
// Created by zxl on 2021/6/24.
//

#ifndef BHFLCAL_HELIOSTAT_CUH
#define BHFLCAL_HELIOSTAT_CUH

#include <cuda_runtime.h>
#include <vector>

typedef enum{
    Rectangular, Paraboloid
} HelioType;

typedef enum{
    HFLCAL, Garcia, iHFLCAL, bHFLCAL
}ModelType;

class Heliostat{
public:
    Heliostat(const HelioType& _type) : helio_type_(type), sd_bk_ratio_(0), energy_(0){};
    virtual void CSetNormalAndRotate(const float3 &focus_center, const float3 &sunray_dir);

    float3 getPosition() const;
    void setPosition(float3 pos_);

    float3 getSize() const;
    virtual void setSize(float3 size_) = 0;

    float3 getNormal() const;
    void setNormal(float3 normal_);

    float2 getGap() const;
    void setGap(float2 gap_);

protected:
    HelioType helio_type_;
    float3 vertex_[4], inter_v_[4]; // heliostat's vertex, vertex on image plane
    float3 position_;
    float3 size_;
    float2 gap_;        // heliostat's slice gap: x, z
    float sd_bk_ratio_; // shadow block ratio
    float3 focus_center_;
    float mAA_; // atomospheric attenuation factor
    float diagnoal_length_;
    float surface_area_; // S
    float3 bHFLCAL_params_; // sigma1(x), sigma2(y), rho
    float distance_; // distance between heliostat's center and focus center
    float3 center_bias_;
    float rotate_theta_, distortion_theta_;
    float flux_param_; // flux_param = 0.5 * S * mAA / pi
    float energy_;
private:
    void CSetWorldVertex();
    void CSetNormal(const float3 &focus_center, const float3 &sunray_dir);
};

#endif //BHFLCAL_HELIOSTAT_CUH
