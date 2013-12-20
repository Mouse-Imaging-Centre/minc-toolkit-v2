macro(build_bicgl bicgl_location install_prefix staging_prefix)
  if(CMAKE_EXTRA_GENERATOR)
    set(CMAKE_GEN "${CMAKE_EXTRA_GENERATOR} - ${CMAKE_GENERATOR}")
  else()
    set(CMAKE_GEN "${CMAKE_GENERATOR}")
  endif()
  
  set(CMAKE_OSX_EXTERNAL_PROJECT_ARGS)

  SET(BICGL_CXX_COMPILER "${CMAKE_CXX_COMPILER}" CACHE FILEPATH "C++ Compiler for BICGL")
  SET(BICGL_C_COMPILER "${CMAKE_C_COMPILER}" CACHE FILEPATH "C Compiler for BICGL")
      
  ExternalProject_Add(libbicgl
	URL "${bicgl_location}"
    UPDATE_COMMAND ""
    SOURCE_DIR bicgl
    BINARY_DIR bicgl-build
	LIST_SEPARATOR :::
    CMAKE_GENERATOR ${CMAKE_GEN}
    CMAKE_ARGS
        -DBICGL_BUILD_SHARED_LIBS:BOOL=NO
        -DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}
        -DLIBMINC_USE_FILE:FILEPATH=${LIBMINC_USE_FILE}
        -DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}
        -DLIBMINC_DIR:PATH=${CMAKE_BINARY_DIR}/libminc
        -DBICPL_DIR:PATH=${CMAKE_BINARY_DIR}/bicpl
        -DBUILD_SHARED_LIBS:BOOL=NO
        -DCMAKE_SKIP_RPATH:BOOL=YES
        -DCMAKE_INSTALL_PREFIX:PATH=${install_prefix}
        -DCMAKE_C_COMPILER:FILEPATH=${BICGL_C_COMPILER}
        -DCMAKE_C_FLAGS:STRING=${CMAKE_C_FLAGS}
        ${CMAKE_OSX_EXTERNAL_PROJECT_ARGS}
    INSTALL_COMMAND make install DESTDIR=${staging_prefix}
    INSTALL_DIR ${staging_prefix}/${install_prefix}
  )
  
  SET(BICGL_CONFIG_FILE  ${CMAKE_CURRENT_BINARY_DIR}/bicgl-build/BICGLConfig.cmake)
  #INCLUDE(${BICGL_CONFIG_FILE})
  set(BICGL_INCLUDE_DIRS "${CMAKE_CURRENT_BINARY_DIR}/bicgl/OpenGL_graphics/Include;${CMAKE_CURRENT_BINARY_DIR}/bicgl/Include;${CMAKE_CURRENT_BINARY_DIR}/bicgl/GLUT_windows/Include")
  set(BICGL_LIBRARY_DIRS "${CMAKE_CURRENT_BINARY_DIR}/bicgl-build")
  set(BICGL_LIBRARIES    "bicgl")
    
endmacro(build_bicgl)
