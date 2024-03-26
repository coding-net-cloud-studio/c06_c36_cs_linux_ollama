#!/bin/bash

# NOTE 这里是切割llama的部分

# -------------------------------------------------------------------

cd /home/aia/9028/w33_ollama

aia@aia-cka:~/9028/w33_ollama$ md5sum ollama 
4c14b2f6a575f7e0d259a7853e836c09  ollama

mv ollama 20_原始文件_ollama_md5sum_4c14b2f6a575f7e0d259a7853e836c09

# NOTE 把名字改回来
mv \
    20_原始文件_ollama_md5sum_4c14b2f6a575f7e0d259a7853e836c09 \
    ollama

chmod +x ollama

# -------------------------------------------------------------------

split -b 1m 20_原始文件_ollama_md5sum_4c14b2f6a575f7e0d259a7853e836c09

# 切割为282个文件
ls | wc -l
282


# -------------------------------------------------------------------
# NOTE 开始合并与恢复

cd /home/aia/9028/w33_ollama/kk
cat x* > 30_合并恢复文件_ollama

md5sum 30_合并恢复文件_ollama
4c14b2f6a575f7e0d259a7853e836c09  30_合并恢复文件_ollama

mv 30_合并恢复文件_ollama \
    30_合并恢复文件_ollama_md5sum_4c14b2f6a575f7e0d259a7853e836c09

mv 30_合并恢复文件_ollama_md5sum_4c14b2f6a575f7e0d259a7853e836c09 ollama

chmod +x ollama


# -------------------------------------------------------------------

orun 

./ollama list 

# ==================================================================
