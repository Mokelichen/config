### 前期必备
一台centos 7 机器并且能连通外网

### 获取脚本
用户：root
1.安装git
```sh
yum install git -y
```

2. 获取脚本
```sh
git clone https://github.com/Mokelichen/config.git
```
3.运行脚本
```sh
bash config/one_key_install.sh
```
静静等待...

### 安装vim插件
使用vim的命令模式
```sh
:PlugInstall
```
静静等待出现左下角出现Done！
