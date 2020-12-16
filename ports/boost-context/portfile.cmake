# Automatically generated by scripts/boost/generate-ports.ps1

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO boostorg/context
    REF boost-1.74.0
    SHA512 23a4a7fa9c993f0d88ebc4fdad765c63ba96d66a07e553e3d304725c2c38d70d2083a65eec7940522f8b61f6deddea18081cd3aca5bcf080fbc448768b44a6ee
    HEAD_REF master
    PATCHES fix_exports_for_32bit_GNU_asm_for_windows.patch
)

file(READ "${SOURCE_PATH}/build/Jamfile.v2" _contents)
string(REPLACE "import ../../config/checks/config" "import config/checks/config" _contents "${_contents}")
file(WRITE "${SOURCE_PATH}/build/Jamfile.v2" "${_contents}")
file(COPY "${CURRENT_INSTALLED_DIR}/share/boost-config/checks" DESTINATION "${SOURCE_PATH}/build/config")

include(${CURRENT_INSTALLED_DIR}/share/boost-build/boost-modular-build.cmake)
boost_modular_build(SOURCE_PATH ${SOURCE_PATH})
include(${CURRENT_INSTALLED_DIR}/share/boost-vcpkg-helpers/boost-modular-headers.cmake)
boost_modular_headers(SOURCE_PATH ${SOURCE_PATH})

# boost-context removed all.hpp, which is used by FindBoost to determine that context is installed
if(NOT EXISTS ${CURRENT_PACKAGES_DIR}/include/boost/context/all.hpp)
    file(WRITE ${CURRENT_PACKAGES_DIR}/include/boost/context/all.hpp
        "#error \"#include <boost/context/all.hpp> is no longer supported by boost_context.\"")
endif()
