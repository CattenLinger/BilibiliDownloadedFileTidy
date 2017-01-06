#Bilibilli 下载文件整理脚本

用于整理 Bilibili 下载好之后的文件，比较适用于番剧

运行脚本后会生成一个 startTidy.sh 脚本文件，运行后将会把文件夹的视频该合并的合并该 copy 的 copy 并重命名成集名

##运行环境

Linux Bash

依赖 pv（用于拷贝文件，可以修改脚本用 cp 或者 cat 代替）、 jq（分析 json 文件用，必须）、 ffmpeg （合并分段文件，必须）

##用法

在需要整理的文件夹的父目录运行

	./initBilibiliFileTidyUp.sh s_1294 && startTidy.sh
	
其中的 s_1294 替换成要整理的文件夹。如果不想生成好整理用脚本后立马执行整理可以去掉 `&& startTidy.sh`

##其他事项

脚本比较简单，如果 ffmpeg 因为下载的视频格式有点特殊、要用实验性 feature （例如 aac 编码问题），请修改脚本开头的 strict2 变量的值

运行的时候确保你的 ffmpeg 是全功能的，否则很容易出问题。

如果中途转换除了问题请删了生成的文件重新再来。