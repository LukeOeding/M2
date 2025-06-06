.PHONY: always
always:

BRANCH := $(shell git branch --contains | grep '^\* ' | sed -e s=^..== -e s=/=.=g )

#######################
## cmake build files ##
#######################

cmake-make-appleclang:
	echo "git branch is " $(BRANCH)
	mkdir -p builds.tmp/cmake-make-appleclang-$(BRANCH)
	cd builds.tmp/cmake-make-appleclang-$(BRANCH); cmake \
		-DCMAKE_BUILD_TYPE=RelWithDebInfo \
		-DCMAKE_INSTALL_PREFIX=`pwd`/installed \
		-DBUILD_TESTING=on \
		-DBUILD_DOCS=on \
		../../../..

cmake-appleclang:
	echo "git branch is " $(BRANCH)
	mkdir -p builds.tmp/cmake-appleclang
	cd builds.tmp/cmake-appleclang; cmake \
		-GNinja \
		-DCMAKE_BUILD_TYPE=RelWithDebInfo \
		-DBUILD_TESTING=on \
		-DCMAKE_PREFIX_PATH="`brew --prefix libffi`" \
		-DBUILD_DOCS=on \
		-DBUILD_NATIVE=off \
		../../../..

cmake-clang:
	echo "git branch is " $(BRANCH)
	mkdir -p builds.tmp/cmake-clang
	cd builds.tmp/cmake-clang; CC=/opt/homebrew/opt/llvm/bin/clang CXX=/opt/homebrew/opt/llvm/bin/clang++ cmake \
		-GNinja \
		-DCMAKE_BUILD_TYPE=RelWithDebInfo \
		-DBUILD_TESTING=on \
		-DCMAKE_PREFIX_PATH="`brew --prefix libffi`" \
		-DBUILD_DOCS=on \
		-DBUILD_NATIVE=off \
		../../../..

cmake-appleclang-notbb:
	echo "git branch is " $(BRANCH)
	mkdir -p builds.tmp/cmake-appleclang-notbb
	cd builds.tmp/cmake-appleclang-notbb; cmake \
		-GNinja \
		-DCMAKE_BUILD_TYPE=RelWithDebInfo \
		-DBUILD_TESTING=on \
		-DCMAKE_PREFIX_PATH="`brew --prefix libffi`" \
		-DBUILD_DOCS=on \
		-DBUILD_NATIVE=off \
		-DWITH_TBB=off \
		../../../..

cmake-debug-appleclang:
	mkdir -p builds.tmp/cmake-debug-appleclang
	cd builds.tmp/cmake-debug-appleclang; cmake \
		-GNinja \
		-DCMAKE_BUILD_TYPE=Debug \
		-DBUILD_TESTING=on \
		-DBUILD_DOCS=on \
		../../../..

cmake-latestclang:
	mkdir -p builds.tmp/cmake-latestclang
	cd builds.tmp/cmake-latestclang; LIBRARY_PATH=`/usr/local/opt/llvm/bin/llvm-config --libdir` cmake \
		-GNinja \
	        -DCMAKE_C_COMPILER:FILEPATH=/usr/local/opt/llvm/bin/clang \
		-DCMAKE_CXX_COMPILER:FILEPATH=/usr/local/opt/llvm/bin/clang++ \
		-DCMAKE_BUILD_TYPE=RelWithDebInfo \
		-DBUILD_TESTING=on \
		-DBUILD_DOCS=on \
		../../../..

cmake-debug-latestclang:
	mkdir -p builds.tmp/cmake-debug-latestclang
	cd builds.tmp/cmake-debug-latestclang; cmake \
		-GNinja \
	    -DCMAKE_C_COMPILER:FILEPATH=/usr/local/opt/llvm/bin/clang \
		-DCMAKE_CXX_COMPILER:FILEPATH=/usr/local/opt/llvm/bin/clang++ \
		-DCMAKE_BUILD_TYPE=Debug \
		-DBUILD_TESTING=on \
		-DBUILD_DOCS=on \
		../../../..

cmake-gcc9:
	mkdir -p builds.tmp/cmake-gcc9
	cd builds.tmp/cmake-gcc9; cmake \
		-GNinja \
	    -DCMAKE_C_COMPILER:FILEPATH=/usr/local/bin/gcc-9 \
		-DCMAKE_CXX_COMPILER:FILEPATH=/usr/local/bin/g++-9 \
		-DCMAKE_BUILD_TYPE=RelWithDebInfo \
		-DBUILD_TESTING=on \
		-DBUILD_DOCS=on \
		../../../..
# running cmake-gcc9 now: 30 May 2020.
#  build-libraries (with testing off): 22m36s
#  build-programs (with testing off): 12m19s
#  cmake -DBUILD_TESTING=on .
#  M2-core: 2m51s
#  install-packages: (running)
#  M2-unit-tests
#  check-packages
# ctest

cmake-debug-gcc9:
	mkdir -p builds.tmp/cmake-debug-gcc9
	cd builds.tmp/cmake-debug-gcc9; cmake \
		-GNinja \
	    -DCMAKE_C_COMPILER:FILEPATH=/usr/local/bin/gcc-9 \
		-DCMAKE_CXX_COMPILER:FILEPATH=/usr/local/bin/g++-9 \
		-DCMAKE_BUILD_TYPE=Debug \
		-DBUILD_TESTING=on \
		-DBUILD_DOCS=on \
		../../../..

xcode:
	mkdir -p builds.tmp/xcode
	cd builds.tmp/xcode; cmake \
		-GXcode \
		../../../..

###########################
## configure build files ##
###########################

###########
## MacOS ##
###########
# Some possibly useful configure options
# 		--build=x86_64-apple-darwin
#       --enable-build-libraries="flint ntl"

arm64-no-tbb-appleclang : always
	mkdir -p builds.tmp/arm64-no-tbb-appleclang
	cd builds.tmp/arm64-no-tbb-appleclang; ../../../../configure \
		CPPFLAGS="-I`brew --prefix`/include" \
		LDFLAGS="-L`brew --prefix`/lib" \
		--disable-tbb \
	        --with-boost-regex=boost_regex \
		--prefix="`pwd`/installed" \
		--disable-strip \
		--enable-download

darwin64-appleclang : always
	mkdir -p builds.tmp/darwin64-appleclang
	cd builds.tmp/darwin64-appleclang; ../../../../configure \
		--prefix="`pwd`/installed" \
		--disable-strip \
		--enable-download

darwin64-latestclang : always
	mkdir -p builds.tmp/darwin64-latestclang
	cd builds.tmp/darwin64-latestclang; ../../../../configure \
		CC="/usr/local/opt/llvm/bin/clang" \
		CXX="/usr/local/opt/llvm/bin/clang++" \
		LDFLAGS="-L/usr/local/opt/llvm/lib -Wl,-rpath,/usr/local/opt/llvm/lib" \
		CPPFLAGS="-I/usr/local/opt/llvm/include" \
		--prefix="`pwd`/installed" \
		--disable-strip \
		--enable-download

darwin64-gcc9 : always
	mkdir -p builds.tmp/darwin64-gcc9
	cd builds.tmp/darwin64-gcc9; ../../../../configure \
		CC=gcc-9 CXX=g++-9 \
		--prefix="`pwd`/installed" \
		--disable-strip \
		--enable-download

debug64-latestclang : always
	mkdir -p builds.tmp/debug64-latestclang
	cd builds.tmp/debug64-latestclang; ../../../../configure \
		CC="/usr/local/opt/llvm/bin/clang" \
		CXX="/usr/local/opt/llvm/bin/clang++" \
		LDFLAGS="-L/usr/local/opt/llvm/lib -Wl,-rpath,/usr/local/opt/llvm/lib" \
		CPPFLAGS="-I/usr/local/opt/llvm/include" \
		--prefix="`pwd`/installed" \
		--disable-strip \
		--enable-download \
		--enable-debug \
		--disable-optimize

debug64-appleclang : always
	mkdir -p builds.tmp/debug64-appleclang
	cd builds.tmp/debug64-appleclang; ../../../../configure \
		--prefix="`pwd`/installed" \
		--disable-strip \
		--enable-download \
		--enable-debug \
		--disable-optimize

debug64-gcc9 : always
	mkdir -p builds.tmp/debug64-gcc9
	cd builds.tmp/debug64-gcc9; ../../../../configure \
		CC=gcc-9 CXX=g++-9 \
		--prefix="`pwd`/installed" \
		--disable-strip \
		--enable-download \
		--enable-debug \
		--disable-optimize

profile64-latestclang : always
	mkdir -p builds.tmp/profile64-latestclang
	cd builds.tmp/profile64-latestclang; ../../../../configure \
		CC="/usr/local/opt/llvm/bin/clang" \
		CXX="/usr/local/opt/llvm/bin/clang++" \
		LDFLAGS="-L/usr/local/opt/llvm/lib -Wl,-rpath,/usr/local/opt/llvm/lib" \
		CPPFLAGS="-I/usr/local/opt/llvm/include" \
		--prefix="`pwd`/installed" \
		--disable-strip \
		--enable-download \
		--enable-profile

profile64-appleclang : always
	mkdir -p builds.tmp/profile64-appleclang
	cd builds.tmp/profile64-appleclang; ../../../../configure \
		--prefix="`pwd`/installed" \
		--disable-strip \
		--enable-download \
		--enable-profile

profile64-gcc9 : always
	mkdir -p builds.tmp/profile64-gcc9
	cd builds.tmp/profile64-gcc9; ../../../../configure \
		CC=gcc-9 CXX=g++-9 \
		--prefix="`pwd`/installed" \
		--disable-strip \
		--enable-download \
		--enable-profile

###################
## linux ##########
###################

linux-opt64-gcc8 : always
	mkdir -p builds.tmp/opt64-gcc8
	cd builds.tmp/opt64-gcc8; ../../../../configure \
		CC=gcc-8 CXX=g++-8 \
		--prefix="`pwd`/installed" \
		--disable-strip \
		--enable-download

linux-opt64 : always
	mkdir -p builds.tmp/opt64
	cd builds.tmp/opt64; ../../../../configure \
		--prefix="`pwd`/installed" \
		--disable-strip \
		--enable-download

linux-debug64 : always
	mkdir -p builds.tmp/debug64
	cd builds.tmp/debug64; ../../../../configure \
		--prefix="`pwd`/installed" \
		CPPFLAGS="-DENGINE_DEBUG_" \
		CXXFLAGS=" -U__GNUC_STDC_INLINE__" \
		--enable-debug \
		--disable-optimize \
		--enable-download

linux-profile64 : always
	mkdir -p builds.tmp/profile64
	cd builds.tmp/profile64; ../../../../configure \
		--prefix="`pwd`/installed" \
		--disable-strip \
		--enable-profile \
		--enable-download

######## below this line is older ######################
opt : always
	mkdir -p opt
	cd opt; ../../../configure \
		--prefix="`pwd`/installed" \
		--disable-strip \
		--enable-download

debug : always
	mkdir -p debug
	cd debug; ../../../configure \
		--prefix="`pwd`/installed" \
		--enable-debug \
		--disable-strip \
		--disable-optimize \
		--enable-download

profile : always
	mkdir -p profile
	cd profile; ../../../configure \
		--prefix="`pwd`/installed" \
		--disable-strip \
		--enable-profile \
		--enable-download \

# the following is no longer possible for me.
# TODO: work with Dan to fix that.
upload : always
	scp darwin64/*.dmg u00.math.uiuc.edu:/home/html/www/Macaulay2/Uploads

