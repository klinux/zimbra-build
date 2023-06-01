FROM rockylinux:8.6

## Install packages
RUN dnf install dnf-plugins-core git redhat-lsb-core -y
RUN dnf config-manager --set-enabled powertools -y
RUN dnf group install "Development Tools" -y
RUN dnf module enable javapackages-tools -y
RUN dnf install java-1.8.0-openjdk gcc-c++ ant-junit ruby git maven cpan wget rpm-build createrepo rsync -y

## Excluir ant no dnf.conf
RUN echo "exclude=ant ant-lib" >> /etc/dnf/dnf.conf

## Workdir
WORKDIR /home/git/zimbra

## Adicionando scripts
ADD build.sh .
ADD zimbra-rocky.patch .
ADD zimbra-store.patch . 

## Final build
RUN mkdir BUILDS

## Volume
VOLUME /home/git/zimbra/BUILDS

## Executar o build
ENTRYPOINT ["./build.sh"]
