cmake_minimum_required(VERSION 3.22)
project(cpp)

set(CMAKE_CXX_STANDARD 20)

add_library(${PROJECT_NAME} SHARED
        src/library.cpp
        src/packet.cpp

        include/library.hpp
        include/packet.hpp
        )
