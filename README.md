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

3.修改脚本
cd config && vim one_key_install.sh
```sh
USERNAME=你的git名称
EMAIL=你的git邮箱
```

3.运行脚本
```sh
bash one_key_install.sh
```
去喝杯茶吧...

### 安装vim插件
使用vim的命令模式
```sh
:PluginInstall
```
静静等待出现左下角出现Done！

