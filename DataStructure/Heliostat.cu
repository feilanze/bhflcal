//
// Created by zxl on 2021/6/24.
//

#include "Heliostat.cuh"

/**
 * Calculate the normal of the heliostat.
 * @param focus_center : the center of the belonging receiver
 * @param sunray_dir : the sun ray direction after normalized
 */
void Heliostat::CSetNormal(const float3 &focus_center, const float3 &sunray_dir){
    float3 local_center = make_float3(pos_.x, pos_.y, pos_.z);
    float3 reflect_dir1 = focus_center - local_center;
    float3 reflect_dir = normalize(reflect_dir1);
    normal_ = normalize(reflect_dir - sunray_dir);
}

/**
 * Transform the local vertexs to world coordinate system.
 */
void Heliostat::CSetWorldVertex() {
    vertex_[0] = make_float3(-size_.x/2, size_.y/2, -size_.z/2);
    vertex_[1] = make_float3(0, 0, size_.z) + vertex_[0];
    vertex_[2] = make_float3(size_.x, 0, size_.z) + vertex_[0];
    vertex_[3] = make_float3(size_.x, 0, 0) + vertex_[0];
    //First step: rotate
    vertex_[0] = global_func::local2world_rotate(vertex_[0], normal_);
    vertex_[1] = global_func::local2world_rotate(vertex_[1], normal_);
    vertex_[2] = global_func::local2world_rotate(vertex_[2], normal_);
    vertex_[3] = global_func::local2world_rotate(vertex_[3], normal_);
    //Second step: translate
    vertex_[0] = global_func::translate(vertex_[0], pos_);
    vertex_[1] = global_func::translate(vertex_[1], pos_);
    vertex_[2] = global_func::translate(vertex_[2], pos_);
    vertex_[3] = global_func::translate(vertex_[3], pos_);
}

/**
 * 1) Set normal
 * 2)change vertexes from local to world
 * @param focus_center
 * @param sunray_dir
 */
void Heliostat::CSetNormalAndRotate(const float3 &focus_center, const float3 &sunray_dir) {
    CSetNormal(focus_center, sunray_dir);
    CSetWorldVertex();
}

float3 Heliostat::getPosition() const {
    return pos_;
}

void Heliostat::setPosition(float3 pos) {
    pos_ = pos;
}

float3 Heliostat::getSize() const {
    return size_;
}

float3 Heliostat::getNormal() const {
    return normal_;
}

void Heliostat::setNormal(float3 normal) {
    normal_ = normal;
}

float2 Heliostat::getGap() const {
    return gap_;
}

void Heliostat::setGap(float2 gap) {
    gap_ = gap;
}