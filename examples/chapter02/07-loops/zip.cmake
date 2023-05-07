cmake_minimum_required(VERSION 3.20.0)

set(L1 "one;two;three;four")
set(L2 "1;2;3;4;5")
foreach(num IN ZIP_LISTS L1 L2)
    message(STATUS "num_0=${num_0}, num_1=${num_1}")
endforeach()

# foreach(<loop_var>... IN ZIP_LISTS <lists>)
# cmake 为每个列表都创建了一个<loop_var>_<N>变量，用每个列表的项填充该变量

foreach(EngNum AlaburNum IN ZIP_LISTS L1 L2)
    message(STATUS "EngNum = ${EngNum}, AlaburNum = ${AlaburNum}")
endforeach()