#!/bin/bash

# Linux下如何切割与合并大文件
# https://blog.csdn.net/fengye_csdn/article/details/121050627



# -------------------------------------------------------------------

l12_all_done(){

    # NOTE 在cloudstudio的社区版本中_小存储空间的条件下_如何精细的操作
    # cp -r /workspace /root/c06_c36_ollama_workspace/

    mkdir -p /root/c06_c36_ollama_workspace/

    # NOTE 拷贝过去
    # 这次拷贝没有带上.git目录_该目录下应该还有280M的空间占用_所有不拷贝这个
    cp -r b33_v0.1.29/ /root/c06_c36_ollama_workspace/

    # 拷贝以后_如下目录应该有282M左右的内容
    # /root/c06_c36_ollama_workspace/b33_v0.1.29/

    # NOTE 释放/workspace下面的空间
    rm -rf /workspace/b33_v0.1.29

    rm -rf /workspace/.git

    # NOTE 删除pyenv的一个设置
    rm /workspace/.python-version

    du -sh /workspace

    du -sh /root/c06_c36_ollama_workspace/



    # NOTE 建立模型的目录
    mkdir -p /root/c06_c36_ollama_workspace/d28_model_all/

    cd /root/c06_c36_ollama_workspace/b33_v0.1.29/d28_splited/

    cat x* > 30_合并恢复文件_ollama

    md5sum 30_合并恢复文件_ollama
    # 4c14b2f6a575f7e0d259a7853e836c09  30_合并恢复文件_ollama

    # NOTE 比较该文件的md5sum值与预先定义在脚本中的md5sum值是否一致

    mv 30_合并恢复文件_ollama \
        30_合并恢复文件_ollama_md5sum_4c14b2f6a575f7e0d259a7853e836c09

    mv 30_合并恢复文件_ollama_md5sum_4c14b2f6a575f7e0d259a7853e836c09 \
        ollama



    chmod +x ollama

    mv ollama /root/c06_c36_ollama_workspace/

    cd /root/c06_c36_ollama_workspace/

    du -sh /root/c06_c36_ollama_workspace/
    # 831M

    mkdir -p /root/c06_c36_ollama_workspace/d28_model_all/

    chmod +x /root/c06_c36_ollama_workspace/ollama

    # NOTE 删除如下目录下的282M的内容_释放空间
    rm -rf /root/c06_c36_ollama_workspace/b33_v0.1.29/

    # 尝试杀死可能有的ollama的进程_为了后面清理环境
    kill $(ps | grep ollama | awk '{print $1}')

    ln -s /root/c06_c36_ollama_workspace/ollama /usr/bin/ollama

    ln -s /root/c06_c36_ollama_workspace/ollama /usr/bin/o

    ln -s /root/c06_c36_ollama_workspace/ollama /workspace/o

    OLLAMA_HOST="0.0.0.0:11434" OLLAMA_MODELS=/root/c06_c36_ollama_workspace/d28_model_all/ ./ollama serve >/dev/null 2>&1 &


    sleep 3

    ps -ef | grep ollama | grep -v grep



    ollama list

    ollama pull qwen:0.5b

    du -sh /root/c06_c36_ollama_workspace/
    # 1.2G    /root/c06_c36_ollama_workspace/

    du -sh /root/c06_c36_ollama_workspace/d28_model_all/
    # 377M    /root/c06_c36_ollama_workspace/d28_model_all/

    du -sh /workspace/

    ollama list

    ollama run qwen:0.5b

    # NOTE 主要用这个_下面的是成功的运行的
    # NOTE cloudstudio社区版是成功返回信息_不是乱码
    curl http://localhost:11434/api/chat -d '{
      "model": "qwen:0.5b",
      "messages": [
        { "role": "user", "content": "写一个描述考研成功上岸的喜悦心情的诗" }
      ],
      "stream": false
    }' 2>/dev/null | jq .message.content | xargs echo -e

    # -------------------------------------------------------------------

    考研之路,漫漫长路,
    我怀揣梦想,坚定前行.
    每一次挑战,都是机遇,
    我在考研路上,寻找成功的答案.

    终于,在考研的道路上,我找到了自己的方向.
    我带着微笑,踏上新的旅程,
    我知道,只要我不放弃,我就一定能成功.

    考研成功上岸,是一种荣耀和自豪,
    我会珍惜这段经历,也会更加努力地学习,
    我相信,只要我不放弃,我就一定能成功.

    # -------------------------------------------------------------------

    # https://github.com/ollama/ollama
    # NOTE 通过流模式回复一个信息
    # Generate a response
    curl http://localhost:11434/api/generate -d '{
      "model": "qwen:0.5b",
      "prompt":"写一个描述考研成功上岸的喜悦心情的诗",
      "stream": false
    }'

    # NOTE 下面的是成功的运行的
    # https://blog.csdn.net/flystar27/article/details/125892153
    # NOTE chat模式的
    curl http://localhost:11434/api/chat -d '{
      "model": "qwen:0.5b",
      "messages": [
        { "role": "user", "content": "写一个描述考研成功上岸的喜悦心情的诗" }
      ],
      "stream": false
    }' 2>/dev/null | jq

    # -----------------------用这个----------------------------------------

    # NOTE 主要用这个_下面的是成功的运行的
    # NOTE cloudstudio社区版是成功返回信息_不是乱码
    curl http://localhost:11434/api/chat -d '{
      "model": "qwen:0.5b",
      "messages": [
        { "role": "user", "content": "写一个描述考研成功上岸的喜悦心情的诗" }
      ],
      "stream": false
    }' 2>/dev/null | jq .message.content | xargs echo -e



    return 0
}

