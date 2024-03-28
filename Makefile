#! /usr/bin/make -f

# makefile中使用echo -e引发的思考(涉及dash和bash)
# https://blog.csdn.net/benkaoya/article/details/12410295
SHELL=/bin/bash

# 下述都是makefile的伪目标
.PHONY: default wmtask_runonce_set_env clean docker

# ---------------------------------------------------------------------------------------

# 这是缺省运行make会被执行的目标
default: wmtask_runonce_set_env
	@echo "我啥都不做_怕出错"
	@echo "使用帮助信息"
	@echo "make               : 尝试用ollam运行千问qwen:0.5b模型"
	@echo "make show          : 展示几个不同的目录下_占用的存储情况"

# ---------------------------------------------------------------------------------------

# 本目标运行一次时间很长的,系统环境设置脚本
# NOTE 被.vscode/preview.yml所调用
# NOTE 尝试用ollam运行千问qwen:0.5b模型
wmtask_runonce_set_env:
	@# TODO runonce适合安装韩俊大神的coderunner扩展.
	@# 这样,保证不运行很重的all构建目标,就可以用coderunner去工作了.
	@echo -e "$$(pwd)/Makefile wmtask_runonce_set_env_目标_被运行\n"
	@bash 10.wmscript_init_this.sh c10_wmtask_runonce_set_env 2nd参数 3rd参数

# ---------------------------------------------------------------------------------------

help:
	@echo "我啥都不做_怕出错"
	@echo "使用帮助信息"
	@echo "make               : 尝试用ollam运行千问qwen:0.5b模型"
	@echo "make show          : 展示几个不同的目录下_占用的存储情况"
