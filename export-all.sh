#!/bin/bash

cat ./export.conf| sed '$s/$/\n/' | while read line
do
   echo "$line"
   if (echo "$line"|grep -q "^#")
     then
       continue;
   fi
   image_name=`echo "$line" | awk '{print $1}'`
   tag_name=`echo "$line" | awk '{print $2}'`
   tar_file_name=`echo "$line" | awk '{print $3}'`
   
   if [ ! -n "$image_name" ] || [ ! -n "$tar_file_name" ]
     then
       echo "invalidate configuration for line: $line"
       exit 0
   fi

    echo "Export : $image_name $tar_file_name"
    if (docker images|grep "$image_name")
      then
	if [ -f $tar_file_name ] && (echo "$tar_file_name"|grep -q ".tar")
	  then
	        rm -rf $tar_file_name
                rm -rf $tar_file_name.zip
        fi
          docker save $image_name:$tag_name > $tar_file_name
	  zip $tar_file_name.zip $tar_file_name
	  mv $tar_file_name.zip ./softwares/images/$tar_file_name.zip
    else
	 echo "Can not find the image $image_name"
    fi
   
done
