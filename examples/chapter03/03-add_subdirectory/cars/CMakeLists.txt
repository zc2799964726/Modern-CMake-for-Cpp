add_library(cars OBJECT
    car.cpp
#   car_maintenance.cpp
)
target_include_directories(cars PUBLIC .)

# 使用add_library()生成了全局可见的目标cars，
# 并使用target_include_ directories()将cars目录添加到其公共包括目录中。
# 这允许main.cpp包含cars.h文件而不提供相对路径:
# include "car.h"

# 使用了OBJECT关键字，这表示只对生成目标文件感兴趣(正如在前面的示例中所做的那样)，
# 只是将它们归类到一个逻辑目标(汽车)下
# 可以对比02-include的build 目录