macro(build_zlib install_prefix staging_prefix)
  
  
  #SET(CFLAGS ${CMAKE_C_FLAGS})
  #LIST(APPEND CFLAGS -fPIC)
set(ENV{CFLAGS} "${CMAKE_C_FLAGS} -fPIC")

ExternalProject_Add(ZLIB
  SOURCE_DIR ZLIB
  URL  "http://www.hdfgroup.org/ftp/lib-external/CMake/ZLib.tar.gz"
  URL_MD5 "645f5d0b7434e1f12bd0b2ae2b976f4b"
  UPDATE_COMMAND ""
  SOURCE_DIR ZLIB
  BINARY_DIR ZLIB-build
  LIST_SEPARATOR :::  
  CMAKE_GENERATOR ${CMAKE_GEN}
  CMAKE_ARGS
      -DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}
      -DBUILD_SHARED_LIBS:BOOL=OFF
      -DBUILD_STATIC_EXECS:BOOL=ON
      -DCMAKE_SKIP_RPATH:BOOL=ON
      -DCMAKE_INSTALL_PREFIX:PATH=${install_prefix}
      -DCMAKE_CXX_FLAGS:STRING=${CMAKE_CXX_FLAGS} -fPIC
      -DCMAKE_C_FLAGS:STRING=${CMAKE_C_FLAGS} -fPIC
      -DCMAKE_EXE_LINKER_FLAGS=${CMAKE_EXE_LINKER_FLAGS}  -fPIC
      -DCMAKE_MODULE_LINKER_FLAGS=${CMAKE_MODULE_LINKER_FLAGS}  -fPIC
      -DCMAKE_SHARED_LINKER_FLAGS=${CMAKE_SHARED_LINKER_FLAGS}  -fPIC
  INSTALL_COMMAND make install DESTDIR=${staging_prefix}
  INSTALL_DIR ${staging_prefix}/${install_prefix}
)

SET(ZLIB_INCLUDE_DIR ${staging_prefix}/${install_prefix}/include )
SET(ZLIB_LIBRARY     ${staging_prefix}/${install_prefix}/lib/libz.a )
SET(ZLIB_DIR         ${staging_prefix}/${install_prefix}/share/cmake/ZLIB/ )
SET(ZLIB_FOUND ON)

endmacro(build_zlib)
