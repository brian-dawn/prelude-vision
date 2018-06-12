FROM nvidia/cuda:9.2-devel-ubuntu18.04

RUN apt-get update

RUN DEBIAN_FRONTEND=noninteractive \
  apt-get install -y \
  cmake \
  libeigen3-dev \
  libboost-filesystem-dev \
  libboost-thread-dev \
  libpcl-dev \
  libeigen3-dev \
  libceres-dev \
  libgtest-dev \
  gcc-5 \
  gcc-7 \ 
  g++-5 \
  g++-7

# Opencv
RUN \ 
    apt-get install --assume-yes wget unzip libopencv-dev && \

    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \

    wget https://github.com/opencv/opencv_contrib/archive/3.4.1.tar.gz && \
    tar zxf 3.4.1.tar.gz && \
    rm 3.4.1.tar.gz && \
    mv opencv_contrib-3.4.1 opencv_contrib && \

    wget https://github.com/opencv/opencv/archive/3.4.1.zip && \
    unzip 3.4.1.zip && \
    cd opencv-3.4.1 && \
    mkdir build && \
    cd build && \

    cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D INSTALL_PYTHON_EXAMPLES=OFF \
    -D INSTALL_C_EXAMPLES=OFF \
    -D WITH_OPENGL=OFF \
    -D WITH_CUDA=ON \
    -D ENABLE_FAST_MATH=1 \
    -D CUDA_FAST_MATH=1 \
    -D WITH_CUBLAS=1 \
    -D BUILD_opencv_ximgproc=ON \
    -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
    -D BUILD_EXAMPLES=OFF .. && \

    make -j4 && \
    make install && \
    cd ../../ && \
    rm -rf opencv* && \
    rm -rf 3.4.1*


RUN apt-get update && apt-get install -y curl git libvtk6-dev \
  && curl -sL https://deb.nodesource.com/setup_9.x | bash \
  && apt-get install -y nodejs \
  && npm install -g quicktype@9.0.23 \
  && npm install -g yarn \
  && yarn global add elm-format create-elm-app elm 

RUN git clone https://github.com/google/googletest.git \
    && cd googletest \
    && mkdir build \
    && cd build \
    && cmake .. \
    && make -j4 \
    && make install \
    && cd ../.. \
    && rm -r googletest

