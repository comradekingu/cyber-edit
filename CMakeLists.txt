cmake_minimum_required(VERSION 3.20)

project(cyber-edit)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(QT Core Quick LinguistTools)
find_package(Qt5 REQUIRED ${QT})

set(SRCS
    src/main.cpp
    src/aboutbox.cpp
    src/aboutbox.h
    src/fileoperations.h
    src/fileoperations.cpp
    src/executecommand.h
    src/executecommand.cpp)

set(RESOURCES
    src/qml.qrc
)

add_executable(cyber-edit ${SRCS} ${RESOURCES})
target_link_libraries(cyber-edit
    Qt5::Core
    Qt5::Quick
)

file(GLOB TS_FILES translations/*.ts)
qt5_create_translation(QM_FILES ${TS_FILES})
add_custom_target(translations DEPENDS ${QM_FILES} SOURCES ${TS_FILES})
add_dependencies(${PROJECT_NAME} translations)

install(TARGETS cyber-edit RUNTIME DESTINATION /usr/bin)

install(FILES
    cyber-edit.desktop
    DESTINATION /usr/share/applications/
    COMPONENT Runtime
)

install(FILES ${QM_FILES} DESTINATION /usr/share/${PROJECT_NAME}/translations)
