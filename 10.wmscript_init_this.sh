#!/bin/bash

# Linux下如何切割与合并大文件
# https://blog.csdn.net/fengye_csdn/article/details/121050627


# -------------------------------------------------------------------

pause_60_second(){
	if read -t 60 -p "暂停60秒,按回车继续运行: "
	then
		# echo "hello $REPLY,welcome to cheng du"
		printf "\n";
	else
		# echo "sorry, Output timeout, please execute the command again !"
		printf "\n时间已到,继续运行\n";
	fi
}

# -------------------------------------------------------------------

# NOTE 非常特殊的一个案例
# NOTE 当用club社区版_单独验证_本ollama与千问0.5b模型时候_才会执行本函数
# NOTE cloudstudio的社区版club_把本c06_c36_cs_linux_ollama在创建工作空间的时候_放到了/workspace
# git clone https://github.com/coding-net-cloud-studio/c06_c36_cs_linux_ollama.git /workspace
g20_if_git_clone_c06_c36_to_workspace(){
  # NOTE 在cloudstudio的社区版本中_小存储空间的条件下_如何精细的操作
  # cp -r /workspace /root/c06_c36_ollama_workspace/

  # mkdir -p /root/c06_c36_ollama_workspace/

  # NOTE 拷贝过去
  # 这次拷贝没有带上.git目录_该目录下应该还有280M的空间占用_所有不拷贝这个

  if [[ -d ./b33_v0.1.29/ ]]; then
    if [[ ! -d /root/c06_c36_ollama_workspace/b33_v0.1.29/ ]]; then
    cp -r b33_v0.1.29/ /root/c06_c36_ollama_workspace/
    fi
  fi

  # 拷贝以后_如下目录应该有282M左右的内容
  # /root/c06_c36_ollama_workspace/b33_v0.1.29/

  # NOTE 释放/workspace下面的空间

  if [[ -d /workspace/b33_v0.1.29 ]]; then
      # NOTE 把b33_v0.1.29当做特征标志_必须确认_位于_c06_c36_cs_linux_ollama_这个git仓库下面
      if [[ -d /workspace/.git ]]
        rm -rf /workspace/.git
      fi
      if [[ -f /workspace/.python-version ]]; then
        rm /workspace/.python-version
      fi
    rm -rf /workspace/b33_v0.1.29
  fi

  # NOTE 删除pyenv的一个设置

  # du -sh /workspace

  # du -sh /root/c06_c36_ollama_workspace/

  return 0
}


# -------------------------------------------------------------------
# NOTE 把大约282个文件切片_恢复为_ollama可执行文件
l36_meld_splited_chunk_to_ollama(){

    if [[ -d /root/c06_c36_ollama_workspace/b33_v0.1.29/d28_splited/ ]]; then
      cd /root/c06_c36_ollama_workspace/b33_v0.1.29/d28_splited/

      cat x* > 30_合并恢复文件_ollama

      if [[ -f 30_合并恢复文件_ollama ]]; then
        # md5sum 30_合并恢复文件_ollama
        # 4c14b2f6a575f7e0d259a7853e836c09  30_合并恢复文件_ollama

        # NOTE 比较该文件的md5sum值与预先定义在脚本中的md5sum值是否一致
        export v28_md5sum_30=$(md5sum 30_合并恢复文件_ollama | awk '{print $1}')

        if [[ "${v28_md5sum_30}" == "4c14b2f6a575f7e0d259a7853e836c09" ]]; then
          echo "正常_新合并282个片段文件_获得的_ollama_文件的md5sum计算值_与预留值_相同"
        else
          # NOTE 出错_退出本函数的执行
          echo "错误_新合并282个片段文件_获得的_ollama_文件的md5sum计算值_与预留值_不相同"
          return -1
        fi

      fi

    fi # 合并文件_ollama

    mv 30_合并恢复文件_ollama \
        30_合并恢复文件_ollama_md5sum_4c14b2f6a575f7e0d259a7853e836c09

    mv 30_合并恢复文件_ollama_md5sum_4c14b2f6a575f7e0d259a7853e836c09 \
        ollama

    chmod +x ollama

    mv ollama /root/c06_c36_ollama_workspace/

    return 0

}

# NOTE 清理与释放空间
# root/c06_c36_ollama_workspace/b33_v0.1.29/目录下有282M左右的空间_给删除_释放空间
l38_clean_root_c06_free_storage_space(){

  if [[ -f /root/c06_c36_ollama_workspace/ollama ]];
    cd /root/c06_c36_ollama_workspace/

    # du -sh /root/c06_c36_ollama_workspace/
    # 831M

    mkdir -p /root/c06_c36_ollama_workspace/d28_model_all/

    chmod +x /root/c06_c36_ollama_workspace/ollama

    if [[ -d /root/c06_c36_ollama_workspace/b33_v0.1.29/ ]]; then
      # NOTE 删除如下目录下的282M的内容_释放空间
      rm -rf /root/c06_c36_ollama_workspace/b33_v0.1.29/
    fi
  then

  return 0
}

# NOTE 有可能ollama的进程已经运行起来了_需要终止或杀死该进程
# 创建ollama的快捷链接_方便运行
l42_stop_potentialed_running_process_and_make_link(){
  if [[ -f /root/c06_c36_ollama_workspace/ollama ]]; then

    if [[ $(ps | grep ollama | wc -l) -gt 0 ]]; then
      # 尝试杀死可能有的ollama的进程_为了后面清理环境
      kill $(ps | grep ollama | awk '{print $1}')
    fi

    [ ! -e "/usr/bin/ollama" ] && ln -s /root/c06_c36_ollama_workspace/ollama /usr/bin/ollama
    [ ! -e "/usr/bin/o" ]      && ln -s /root/c06_c36_ollama_workspace/ollama /usr/bin/o
    [ ! -e "/workspace/o" ]    && ln -s /root/c06_c36_ollama_workspace/ollama /workspace/o

  fi

  return 0
}

# NOTE 启动ollama进程运行起来
l46_run_ollama_serve(){

  if [[ -f /root/c06_c36_ollama_workspace/ollama ]]; then
    # NOTE 建立模型的目录
    mkdir -p /root/c06_c36_ollama_workspace/d28_model_all/

    OLLAMA_HOST="0.0.0.0:11434" OLLAMA_MODELS=/root/c06_c36_ollama_workspace/d28_model_all/ ./ollama serve >/dev/null 2>&1 &
    sleep 3
  fi

  return 0
}

# NOTE ollama下拉千问0.5b这样一个_具有较少参数_体积很小的_模型
l50_ollama_pull_model_qwen_0_5_b(){

    if [[ -f /root/c06_c36_ollama_workspace/ollama ]]; then
      if [[ $(ps | grep ollama | wc -l) -gt 0 ]]; then
        # NOTE 判断ollam服务已经启动起来了_才会继续进行到这个位置
        #  ps -ef | grep ollama | grep -v grep
        ollama list
        # NOTE 建立模型的目录
        mkdir -p /root/c06_c36_ollama_workspace/d28_model_all/

        ollama pull qwen:0.5b
        # TODO 这里需要增加判断ollama下拉_千文_0.5b模型是否成功的语句
      fi
    fi

    # NOTE 下拉的千问0.5b模型大约377M
    # du -sh /root/c06_c36_ollama_workspace/d28_model_all/
    # 377M    /root/c06_c36_ollama_workspace/d28_model_all/

    # TODO 下面的数值需要重新测量
    # du -sh /root/c06_c36_ollama_workspace/
    # 1.2G    /root/c06_c36_ollama_workspace/

    return 0
}

# NOTE ollama运行_模型_千问_0.5b
l54_ollama_run_model_qwen_0_5_b(){

    if [[ -f /root/c06_c36_ollama_workspace/ollama ]]; then
      if [[ $(ps | grep ollama | wc -l) -gt 0 ]]; then
        # NOTE 判断ollam服务已经启动起来了_才会继续进行到这个位置
        #  ps -ef | grep ollama | grep -v grep
        ollama list
        ollama run qwen:0.5b
        # TODO 这里需要增加判断ollama_运行_千文_0.5b模型是否成功的语句
      fi
    fi

    return 0
}

# -------------------------------------------------------------------
# REVIEW 如下的函数没被有调用
l60_get_message_from_ollama_run_model_qwen_0_5_b(){

    if [[ -f /root/c06_c36_ollama_workspace/ollama ]]; then
      if [[ $(ps | grep ollama | wc -l) -gt 0 ]]; then
        # NOTE 判断ollam服务已经启动起来了_才会继续进行到这个位置

          # https://github.com/ollama/ollama
          # NOTE 10_通过流模式回复一个信息
          # Generate a response
          curl http://localhost:11434/api/generate -d '{
            "model": "qwen:0.5b",
            "prompt":"写一个描述考研成功上岸的喜悦心情的诗",
            "stream": false
          }'

          # NOTE 下面的是成功的运行的
          # https://blog.csdn.net/flystar27/article/details/125892153
          # NOTE 20_chat模式的
          curl http://localhost:11434/api/chat -d '{
            "model": "qwen:0.5b",
            "messages": [
              { "role": "user", "content": "写一个描述考研成功上岸的喜悦心情的诗" }
            ],
            "stream": false
          }' 2>/dev/null | jq

          # -----------------------用这个----------------------------------------

          # NOTE 主要用这个_下面的是成功的运行的
          # NOTE 30_cloudstudio社区版是成功返回信息_不是乱码
          curl http://localhost:11434/api/chat -d '{
            "model": "qwen:0.5b",
            "messages": [
              { "role": "user", "content": "写一个描述考研成功上岸的喜悦心情的诗" }
            ],
            "stream": false
          }' 2>/dev/null | jq .message.content | xargs echo -e
      fi
    fi

    return 0
}

# -------------------------------------------------------------------

# NOTE 测试ollama运行_模型_千问_0.5b_是否可以返回信息
l68_get_message_from_ollama_run_model_qwen_0_5_b(){

    if [[ -f /root/c06_c36_ollama_workspace/ollama ]]; then
      if [[ $(ps | grep ollama | wc -l) -gt 0 ]]; then
        # NOTE 判断ollam服务已经启动起来了_才会继续进行到这个位置
          # NOTE 主要用这个_下面的是成功的运行的
          # NOTE cloudstudio社区版是成功返回信息_不是乱码
          curl http://localhost:11434/api/chat -d '{
            "model": "qwen:0.5b",
            "messages": [
              { "role": "user", "content": "写一个描述考研成功上岸的喜悦心情的诗" }
            ],
            "stream": false
          }' 2>/dev/null | jq .message.content | xargs echo -e
      fi
    fi

    return 0
}

# -------------------------------------------------------------------
# NOTE 返回的信息类似如下
# 考研之路,漫漫长路,
# 我怀揣梦想,坚定前行.
# 每一次挑战,都是机遇,
# 我在考研路上,寻找成功的答案.

# 终于,在考研的道路上,我找到了自己的方向.
# 我带着微笑,踏上新的旅程,
# 我知道,只要我不放弃,我就一定能成功.

# 考研成功上岸,是一种荣耀和自豪,
# 我会珍惜这段经历,也会更加努力地学习,
# 我相信,只要我不放弃,我就一定能成功.

# -------------------------------------------------------------------

# NOTE 合并282个片段文件为ollama可执行文件.
# NOTE ollama 下拉 千问_qwen_0.5b的模型大约377M
# NOTE ollama运行上述模型
# NOTE 从上述ollama运行的模型中获得_生成的返回信息
# 需要运行比较长的时间.
f92_2828_main(){

  # NOTE 非常特殊的一个案例
  # NOTE 当用club社区版_单独验证_本ollama与千问0.5b模型时候_才会执行本函数
  # NOTE cloudstudio的社区版club_把本c06_c36_cs_linux_ollama在创建工作空间的时候_放到了/workspace
  # git clone https://github.com/coding-net-cloud-studio/c06_c36_cs_linux_ollama.git /workspace
  g20_if_git_clone_c06_c36_to_workspace

  # NOTE 把大约282个文件切片_恢复为_ollama可执行文件
  l36_meld_splited_chunk_to_ollama

  # NOTE 清理与释放空间
  # root/c06_c36_ollama_workspace/b33_v0.1.29/目录下有282M左右的空间_给删除_释放空间
  l38_clean_root_c06_free_storage_space

  # NOTE 有可能ollama的进程已经运行起来了_需要终止或杀死该进程
  # 创建ollama的快捷链接_方便运行
  l42_stop_potentialed_running_process_and_make_link

  # NOTE 启动ollama进程运行起来
  l46_run_ollama_serve

  # NOTE ollama下拉千问0.5b这样一个_具有较少参数_体积很小的_模型
  l50_ollama_pull_model_qwen_0_5_b

  # NOTE ollama运行_模型_千问_0.5b
  l54_ollama_run_model_qwen_0_5_b

  # NOTE 测试ollama运行_模型_千问_0.5b_是否可以返回信息
  l68_get_message_from_ollama_run_model_qwen_0_5_b

  return 0
}


# =================================================================

# f92_2828_main的便捷名称
main(){
  f92_2828_main
  return 0
}

# =================================================================

# 下面是_正式_的入口
[ -z "$1" ] && eval main || eval $1 $*