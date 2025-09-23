#!/bin/bash
cd ..
rm -rf build
mkdir build
cd build

# 设置Android和第三方库的路径变量
ANDROID_LIBS_PATH="/Users/xuchengpu/Desktop/Project/huanxin/publish/4.16.0/debug/emclient-android/hyphenatechatsdk/libs/arm64-v8a"
LIBEVENT_INCLUDE="/Users/xuchengpu/Desktop/Project/huanxin/publish/4.16.0/debug/emclient-linux/3rd_party/libevent/include"
BORINGSSL_INCLUDE="/Users/xuchengpu/Desktop/Project/huanxin/publish/4.16.0/debug/emclient-linux/3rd_party/boringssl/include"

# 添加 ZLIB 路径
NDK_PATH="/Users/xuchengpu/Library/Android/sdk/ndk/21.1.6352462"
ZLIB_INCLUDE="${NDK_PATH}/sysroot/usr/include"
ZLIB_LIB="${NDK_PATH}/sysroot/usr/lib/aarch64-linux-android/libz.a"

rm -f CMakeCache.txt && \
cmake .. -DCMAKE_TOOLCHAIN_FILE=../contrib/cross-aarch64-android.cmake \
-DCMAKE_C_FLAGS="-Wno-error=shorten-64-to-32 -Wno-error=sign-conversion -Wno-error=sign-compare" \
-DCMAKE_CXX_FLAGS="-Wno-error=shorten-64-to-32 -Wno-error=sign-conversion -Wno-error=sign-compare" \
-DLWS_WITH_SHARED=0 \
-DLWS_WITH_STATIC=1 \
-DLWS_WITH_HTTP2=0 \
-DLWS_WITH_LIBEVENT=1 \
-DLWS_WITH_BORINGSSL=1 \
-DLIBEVENT_INCLUDE_DIRS="${LIBEVENT_INCLUDE}" \
-DLIBEVENT_LIBRARIES="${ANDROID_LIBS_PATH}/libevent.a;${ANDROID_LIBS_PATH}/libevent_core.a;${ANDROID_LIBS_PATH}/libevent_extra.a" \
-DOPENSSL_INCLUDE_DIRS="${BORINGSSL_INCLUDE}" \
-DOPENSSL_LIBRARIES="${ANDROID_LIBS_PATH}/libssl.a;${ANDROID_LIBS_PATH}/libcrypto.a" \
-DLWS_WITHOUT_EXTENSIONS=OFF \
-DLWS_WITH_ZLIB=ON \
-DLWS_ZLIB_INCLUDE_DIRS="${ZLIB_INCLUDE}" \
-DLWS_ZLIB_LIBRARIES="${ZLIB_LIB}" \
-DLWS_WITHOUT_TESTAPPS=1 && \
make && \
cmake --install .