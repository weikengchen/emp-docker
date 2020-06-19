FROM ubuntu:groovy

RUN apt update \
	&& apt install -y software-properties-common \
	&& apt install -y cmake git build-essential libssl-dev libgmp-dev python \
	&& apt install -y libboost-dev \
	&& apt install -y libboost-chrono-dev libboost-log-dev libboost-program-options-dev libboost-date-time-dev libboost-thread-dev libboost-system-dev libboost-filesystem-dev libboost-regex-dev libboost-test-dev

# relic
WORKDIR ~
RUN git clone https://github.com/relic-toolkit/relic.git
WORKDIR relic
RUN	cmake -DALIGN=16 -DARCH=X64 -DARITH=curve2251-sse -DCHECK=off -DFB_POLYN=251 -DFB_METHD="INTEG;INTEG;QUICK;QUICK;QUICK;QUICK;LOWER;SLIDE;QUICK" -DFB_PRECO=on -DFB_SQRTF=off -DEB_METHD="PROJC;LODAH;COMBD;INTER" -DEC_METHD="CHAR2" -DCOMP="-O3 -funroll-loops -fomit-frame-pointer -march=native -msse4.2 -mpclmul" -DTIMER=CYCLE -DWITH="MD;DV;BN;FB;EB;EC" -DWSIZE=64 . \
	&& make \
	&& make install

# emp-tool
WORKDIR ~
RUN git clone https://github.com/emp-toolkit/emp-tool.git
WORKDIR emp-tool
RUN cmake . \
	&& make \ 
	&& make install

# emp-ot
WORKDIR ~
RUN git clone https://github.com/emp-toolkit/emp-ot.git
WORKDIR emp-ot
RUN cmake . \
	&& make \
	&& make install