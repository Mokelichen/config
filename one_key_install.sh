#!/bin/bash

#修改yum源
function Modify_yum(){
        yum install -y wget 
	mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup 
	wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
	yum makecache
}
#安装常用软件
function Install_Software(){
    yum install -y curl gcc g++ gdb make python3 net-tools tree traceroute dnstils zip unzip git yum-utils ctags ncurses-devel bind-utils
    #下载vim
    git clone https://github.com/vim/vim.git
    #编译安装
    cd vim/src
    ./configure --prefix=/usr/local
    make
    make install

    cd ../..
    #下载Vundle插件
    mkdir -p ~/.vim/bundle
    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

}

#安装go语言
function Install_GO(){
    wget https://go.dev/dl/go1.19.1.linux-amd64.tar.gz
    rm -rf /usr/local/go && tar -C /usr/local -xzf go1.19.1.linux-amd64.tar.gz
    export PATH=$PATH:/usr/local/go/bin
    go version
}

#安装docker
function Install_Docker(){
    yum remove docker  docker-client  docker-client-latest docker-common  docker-latest docker-latest-logrotate docker-logrotate docker-engine
    yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
    yum -y install docker-ce docker-ce-cli containerd.io
    #启动docker
    systemctl start docker
    #设置开机自启
    systemctl enable docker
    #关闭防火墙
    systemctl stop firewalld
    #关闭selinux
    setenforce 0
}

#配置vim
function Config_Vim(){    
    cp -f config/.bashrc ~/.bashrc
    cp -f config/.vimrc ~/.vimrc

    go env -w GO111MODULE=on
    go env -w GOPROXY=https://goproxy.cn,direct
    go install github.com/jstemmer/gotags@latest
    
}


#配置git
function Config_Git(){
    echo -e "[user] \n \
    username=mokelichen \n \
    email=1569089678@qq.com \n " > .gitconfig
}

#配置docker启动mysql
function Config_DockerMysql(){
    mkdir -p /mydata/mysql/conf/
    mkdir -p /mydata/mysql/data/
    mkdir -p /mydata/mysql/log/

    cp -f config/my.cnf /mydata/mysql/conf/my.cnf
    docker pull mysql:5.7
    docker run -p 3306:3306 --name mysql -v /mydata/mysql/log:/var/log/mysql -v /mydata/mysql/data:/var/lib/mysql -v /mydata/mysql/conf:/etc/mysql/conf.d -e MYSQL_ROOT_PASSWORD=root -d mysql:5.7
    sleep 2
    docker exec -it mysql mysql -uroot -proot -e "grant all privileges on *.* to 'root'@'%' identified by 'root' with grant option;"
    docker exec -it mysql mysql -uroot -proot -e "flush privileges;"
    
}

#配合docker启动redis
function Config_DockerRedis(){
    mkdir -p /mydata/redis/conf
    mkdir -p /mydata/redis/data

    cp -f config/redis.conf /mydata/redis/conf/redis.conf
    docker pull redis
    docker run -p 6379:6379 --name redis -v /mydata/redis/data:/data -v /mydata/redis/conf/redis.conf:/etc/redis/redis.conf -d redis redis-server /etc/redis/redis.conf --appendonly yes

}

#main方法
function Main(){    
    Modify_yum
    Install_Software
    Install_GO
    Install_Docker
    Config_Vim
    Config_Git
    Config_DockerMysql
    Config_DockerRedis
}

Main
