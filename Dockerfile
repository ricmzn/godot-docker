FROM debian

ARG VERSION
ARG PLATFORM=linux
ARG ARCH=x86_64

RUN if [ -z $VERSION ]; then echo "Missing build-arg: VERSION"; exit 1; fi

RUN apt-get -q update && apt-get -yqq install wget unzip &&\
    mkdir /workdir && cd /workdir &&\
    wget https://github.com/godotengine/godot/releases/download/${VERSION}-stable/Godot_v${VERSION}-stable_${PLATFORM}.${ARCH}.zip -qO godot.zip &&\
    unzip -q godot.zip &&\
    cp Godot_v${VERSION}-stable_* /usr/bin/godot &&\
    apt-get clean &&\
    rm -r /workdir

ENTRYPOINT [ "/usr/bin/godot" ]
CMD [ "--help" ]
