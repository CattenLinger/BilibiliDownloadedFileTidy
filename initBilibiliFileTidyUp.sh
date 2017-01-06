#!/bin/bash

#strict2="-strict -2";
strict2="";

workdir=`pwd`; echo "Current working dir : $workdir";
outputFile="${workdir}/startTidy.sh"; echo "Script outputing file : $outputFile";

if [ ! -f "$outputFile" ]; then touch $outputFile; echo "Outputing file created."; fi
chmod +x $outputFile;

echo '#!/bin/bash' > $outputFile;
echo >> $outputFile;

sourcedir="${workdir}/${1}"; echo "Source dir is : $sourcedir";

for dir in `ls -F $sourcedir | grep "/$"`; do
	videoIndex=`jq .ep.index ${sourcedir}/${dir}/entry.json | tr -d \"`;
	videoTitle=`jq .ep.index_title ${sourcedir}/${dir}/entry.json | tr -d \"`;
	videoSerial=`jq .title ${sourcedir}/${dir}/entry.json | tr -d \"`;
	echo "Sub-dir : ${dir}";
	echo " |- The ${videoIndex} video of ${videoSerial} : ${videoTitle}";

	videoName="${videoIndex}.${videoTitle}.mp4";
	if [ ! -d "${workdir}/${videoSerial}" ]; then mkdir "${workdir}/${videoSerial}"; echo "Serial directory created : ${workdir}/${videoSerial}"; fi;

	_dir=`ls -F $sourcedir$dir | grep "/$"`;
	videoFileList=(`find ${sourcedir}${dir}${_dir} -name "*.mp4"`);
	echo " |- Found ${#videoFileList[@]} video file(s) in directory";

	if [ ${#videoFileList[@]} -eq "1" ]; then
		echo "pv \"${videoFileList[0]}\" >> \"${workdir}/${videoSerial}/${videoName}\"" >> $outputFile;
		echo " |- Marked the video for copy.";
	else
		vlist="";
		for item in ${videoFileList[@]}; do
			vlist="${vlist} -i \"${item}\"";
		done;
		echo "ffmpeg${vlist} ${strict2} -vcodec copy -acodec copy \"$workdir/${videoSerial}/${videoName}\"" >> $outputFile;
		echo " |- Marked the video for convert.";
	fi;

	echo;
done;