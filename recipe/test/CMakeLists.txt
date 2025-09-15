cmake_minimum_required (VERSION 3.16)

set (CMAKE_BUILD_TYPE "Release" CACHE STRING "build type")

project (qtdeclarative-test CXX)

find_package (Qt6 CONFIG REQUIRED COMPONENTS Qml)

add_executable (test_qtdeclarative test_qtdeclarative.cpp)
target_link_libraries (test_qtdeclarative Qt6::Qml)

enable_testing ()
add_test (NAME test_qtdeclarative COMMAND test_qtdeclarative)
