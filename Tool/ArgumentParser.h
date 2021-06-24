//
// Created by zxl on 2021/6/21.
//

#ifndef BHFLCAL_ARGUMENTPARSER_H
#define BHFLCAL_ARGUMENTPARSER_H

#include <string>
class ArgumentParser{
private:
    std::string scene_path; // 镜场文件位置
    std::string output_path; // 输出文件位置
    std::string helio_index_path; // 测试定日镜序号文件位置
    // void initialize();
    // 验证文件是否为指定格式
    void check_valid_file(std::string path, std::string suffix);
    // 验证目录是否存在
    void check_valid_directory(std::string path);

public:
    // 对命令行参数进行处理
    bool parser(int argc, char ** argv);

    // 获取/设置镜场文件路径
    const std::string &getScenePath() const;
    bool setScenePath(const std::string &scene_path);

    // 获取/设置测试定日镜序号文件路径
    const std::string &getHeliostatIndexLoadPath() const;
    void setHeliostatIndexLoadPath(const std::string &helio_index_path);

    const std::string &getOutputPath() const;
    void setOutputPath(const std::string &output_path);
};

#endif //BHFLCAL_ARGUMENTPARSER_H
