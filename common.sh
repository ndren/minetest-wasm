BASE_DIR="$(dirname -- "$(readlink -f -- "$0")")"

cd "$BASE_DIR"
mkdir -p sources build install
SRC_DIR="$BASE_DIR/sources"
BUILD_DIR="$BASE_DIR/build"
INSTALL_DIR="$BASE_DIR/install"
WWW_DIR="$BASE_DIR/www"

test -d "$SRC_DIR"
test -d "$BUILD_DIR"
test -d "$INSTALL_DIR"

# Debug / Release
export BUILD_KIND=Release

case $BUILD_KIND in
  Debug)
    export COMMON_CFLAGS="-O0 -g -gsource-map --source-map-base=/dev/"
    export COMMON_LDFLAGS="-sSAFE_HEAP=1 -sASSERTIONS=2 -sDEMANGLE_SUPPORT=1"
    ;;
  Profile)
    export BUILD_KIND="Release"
    export COMMON_CFLAGS="--profiling -O2 -g -gsource-map --source-map-base=/dev/"
    export COMMON_LDFLAGS=""
    ;;
  Release)
    export COMMON_CFLAGS="-O2"
    export COMMON_LDFLAGS=""
    ;;
  *)
    echo "Unknown build: $BUILD_KIND"
    exit 1
esac

export CFLAGS="$COMMON_CFLAGS -pthread -sUSE_PTHREADS=1 -fexceptions"
export CXXFLAGS="$COMMON_CFLAGS -pthread -sUSE_PTHREADS=1 -fexceptions"
export LDFLAGS="$COMMON_LDFLAGS -pthread -sUSE_PTHREADS=1 -fexceptions -sEXIT_RUNTIME"

export EMSDK_ROOT="$HOME/emsdk"
export EMSDK_SYSLIB="${EMSDK_ROOT}/upstream/emscripten/cache/sysroot/lib/wasm32-emscripten"
export EMSDK_SYSINCLUDE="${EMSDK_ROOT}/upstream/emscripten/cache/sysroot/include"

export MINETEST_REPO="$BASE_DIR/minetest"
export IRRLICHT_REPO="$BASE_DIR/minetest/lib/irrlichtmt"
