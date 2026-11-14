#!/bin/bash

echo "#!/bin/bash" > encode_all_jpegs.sh
echo "#!/bin/bash" > encode_all_jxls.sh
echo "#!/bin/bash" > encode_all_avifs.sh

cd sources
for input in *.ppm; do
    i=$(basename $input .ppm).png

    # produce equivalent PNG files with proper colorspace tagging
    convert $input -profile ../Rec2100PQ.icc $i

    mkdir -p ../distorted/$i ../compressed/$i

    jpeg_extra="0.3"
    if [[ $i == "alps-sunset.png" ]]; then bpps="0.3 0.4 0.5 0.7 0.9"; jpeg_extra="0.2"; fi
    if [[ $i == "building.png" ]]; then bpps="0.2 0.3 0.4 0.6 0.8"; jpeg_extra="0.3"; fi
    if [[ $i == "flower.png" ]]; then bpps="0.2 0.3 0.4 0.5 0.7"; jpeg_extra="0.1"; fi
    if [[ $i == "p29-crop.png" ]]; then bpps="0.2 0.3 0.4 0.5 0.7"; jpeg_extra="0.1"; fi
    if [[ $i == "room1.png" ]]; then bpps="0.2 0.3 0.5 0.6 0.9"; jpeg_extra="0.2"; fi

    for j in $bpps ; do
       fs=$(echo "scale=0; ($j * 840 * 944)/8" | bc) #"
       j_jpeg=$(echo "$j * 2 + $jpeg_extra" | bc)
       fs_jpeg=$(echo "scale=0; ($j_jpeg * 840 * 944)/8" | bc) #"
       echo "$i, bpp=$j, target filesize=$fs, jpeg bpp=$j_jpeg, jpeg target filesize=$fs_jpeg"

       # binary search for JPEG quality setting to match bitrate
       qmin=1
       qmax=99
       tfs=$fs_jpeg
       jpeg_fn="../compressed/$i/$i-jpeg-bpp-$j_jpeg"
       while true;
       do
        if [[ $((qmax - qmin)) -lt 2 ]]; then
            jpeg_fn=$jpeg_fn-q$q
            mv ../tmpout.jpg $jpeg_fn.jpg
            echo "./jpeg -h -qt 3 -oz -R 2 -q $q sources/$input tmpout.jpg" >> ../encode_all_jpegs.sh
            break
        fi
        q=$(( (qmin+qmax)/2 ))
        time ../jpeg -h -qt 3 -oz -R 2 -q $q $input ../tmpout.jpg
        cfs=$(stat -f "%z" ../tmpout.jpg)
        echo "Tried q=$q, size=$cfs, target=$tfs, range=$qmin..$qmax"
        if [[ $cfs -lt $tfs ]]; then qmin=$q; else qmax=$q; fi
       done
       ../jpeg $jpeg_fn.jpg ../tmpout.ppm
       convert ../tmpout.ppm -profile ../Rec2100PQ.icc ../distorted/$i/$(basename $jpeg_fn).png



       # binary search for JPEG XL quality setting to match bitrate
       qmin=1
       qmax=99
       tfs=$fs
       jxl_fn="../compressed/$i/$i-jxl-bpp-$j"
       while true;
       do
        if [[ $((qmax - qmin)) -lt 2 ]]; then
            jxl_fn=$jxl_fn-q$q
            mv ../tmpout.jxl $jxl_fn.jxl
            echo "cjxl -q $q sources/$input -x color_space=Rec2100PQ tmpout.jxl" >> ../encode_all_jxls.sh
            break
        fi
        q=$(( (qmin+qmax)/2 ))
        time cjxl -q $q $input -x color_space=Rec2100PQ ../tmpout.jxl
        cfs=$(stat -f "%z" ../tmpout.jxl)
        echo "Tried q=$q, size=$cfs, target=$tfs, range=$qmin..$qmax"
        if [[ $cfs -lt $tfs ]]; then qmin=$q; else qmax=$q; fi
       done
       djxl $jxl_fn.jxl ../tmpout.ppm
       convert ../tmpout.ppm -profile ../Rec2100PQ.icc ../distorted/$i/$(basename $jxl_fn).png


       # binary search for AVIF quality setting to match bitrate
       qmin=1
       qmax=99
       tfs=$fs
       avif_fn="../compressed/$i/$i-avif-bpp-$j"
       while true;
       do
        if [[ $((qmax - qmin)) -lt 2 ]]; then
            avif_fn=$avif_fn-q$q
            mv ../tmpout.avif $avif_fn.avif
            echo "avifenc --autotiling -q $q sources/$i tmpout.avif --ignore-icc --cicp 9/16/9 -d 10" >> ../encode_all_avifs.sh
            break
        fi
        q=$(( (qmin+qmax)/2 ))
        time avifenc --autotiling -q $q $i ../tmpout.avif --ignore-icc --cicp 9/16/9 -d 10
        cfs=$(stat -f "%z" ../tmpout.avif)
        echo "Tried q=$q, size=$cfs, target=$tfs, range=$qmin..$qmax"
        if [[ $cfs -lt $tfs ]]; then qmin=$q; else qmax=$q; fi
       done

       avifdec $avif_fn.avif ../tmpout.png
       convert ../tmpout.png -profile ../Rec2100PQ.icc ../distorted/$i/$(basename $avif_fn).png


       # JPEG AI images were produced separately

    done
done
cd ..

optipng compressed/*/*.png sources/*.png
