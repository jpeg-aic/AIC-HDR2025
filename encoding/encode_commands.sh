#!/bin/bash
# Exact encoder invocations used to produce the compressed images (run from the repository root).
# Encoder versions: libavif 1.1.1 + libaom 3.11.0, libjxl 0.11.1, libjpeg (Thomas Richter) 1.70.
# cjxl and jpeg were fed the original 10-bit PPM; recreate it losslessly from the 16-bit PNG:
set -e
mkdir -p sources_ppm out
for i in 1 2 3 4 5; do p=HDR_PTC_0000${i}_0ref_00; magick images/$p.png -depth 10 sources_ppm/$p.ppm; done

# HDR_PTC_00001_JPEG-AI_01: JPEG AI VM 7.0, -target_bpps 90 (see README)
# HDR_PTC_00001_JPEG-AI_02: JPEG AI VM 7.0, -target_bpps 70 (see README)
# HDR_PTC_00001_JPEG-AI_03: JPEG AI VM 7.0, -target_bpps 50 (see README)
# HDR_PTC_00001_JPEG-AI_04: JPEG AI VM 7.0, -target_bpps 40 (see README)
# HDR_PTC_00001_JPEG-AI_05: JPEG AI VM 7.0, -target_bpps 30 (see README)
# HDR_PTC_00002_JPEG-AI_01: JPEG AI VM 7.0, -target_bpps 80 (see README)
# HDR_PTC_00002_JPEG-AI_02: JPEG AI VM 7.0, -target_bpps 60 (see README)
# HDR_PTC_00002_JPEG-AI_03: JPEG AI VM 7.0, -target_bpps 40 (see README)
# HDR_PTC_00002_JPEG-AI_04: JPEG AI VM 7.0, -target_bpps 30 (see README)
# HDR_PTC_00002_JPEG-AI_05: JPEG AI VM 7.0, -target_bpps 20 (see README)
# HDR_PTC_00003_JPEG-AI_01: JPEG AI VM 7.0, -target_bpps 70 (see README)
# HDR_PTC_00003_JPEG-AI_02: JPEG AI VM 7.0, -target_bpps 50 (see README)
# HDR_PTC_00003_JPEG-AI_03: JPEG AI VM 7.0, -target_bpps 40 (see README)
# HDR_PTC_00003_JPEG-AI_04: JPEG AI VM 7.0, -target_bpps 30 (see README)
# HDR_PTC_00003_JPEG-AI_05: JPEG AI VM 7.0, -target_bpps 20 (see README)
# HDR_PTC_00004_JPEG-AI_01: JPEG AI VM 7.0, -target_bpps 70 (see README)
# HDR_PTC_00004_JPEG-AI_02: JPEG AI VM 7.0, -target_bpps 50 (see README)
# HDR_PTC_00004_JPEG-AI_03: JPEG AI VM 7.0, -target_bpps 40 (see README)
# HDR_PTC_00004_JPEG-AI_04: JPEG AI VM 7.0, -target_bpps 30 (see README)
# HDR_PTC_00004_JPEG-AI_05: JPEG AI VM 7.0, -target_bpps 20 (see README)
# HDR_PTC_00005_JPEG-AI_01: JPEG AI VM 7.0, -target_bpps 90 (see README)
# HDR_PTC_00005_JPEG-AI_02: JPEG AI VM 7.0, -target_bpps 60 (see README)
# HDR_PTC_00005_JPEG-AI_03: JPEG AI VM 7.0, -target_bpps 50 (see README)
# HDR_PTC_00005_JPEG-AI_04: JPEG AI VM 7.0, -target_bpps 30 (see README)
# HDR_PTC_00005_JPEG-AI_05: JPEG AI VM 7.0, -target_bpps 20 (see README)
avifenc --autotiling -q 45 images/HDR_PTC_00002_0ref_00.png out/HDR_PTC_00002_AVIF_05.avif --ignore-icc --cicp 9/16/9 -d 10
avifenc --autotiling -q 45 images/HDR_PTC_00005_0ref_00.png out/HDR_PTC_00005_AVIF_05.avif --ignore-icc --cicp 9/16/9 -d 10
avifenc --autotiling -q 51 images/HDR_PTC_00001_0ref_00.png out/HDR_PTC_00001_AVIF_05.avif --ignore-icc --cicp 9/16/9 -d 10
avifenc --autotiling -q 54 images/HDR_PTC_00002_0ref_00.png out/HDR_PTC_00002_AVIF_04.avif --ignore-icc --cicp 9/16/9 -d 10
avifenc --autotiling -q 54 images/HDR_PTC_00003_0ref_00.png out/HDR_PTC_00003_AVIF_05.avif --ignore-icc --cicp 9/16/9 -d 10
avifenc --autotiling -q 55 images/HDR_PTC_00001_0ref_00.png out/HDR_PTC_00001_AVIF_04.avif --ignore-icc --cicp 9/16/9 -d 10
avifenc --autotiling -q 55 images/HDR_PTC_00004_0ref_00.png out/HDR_PTC_00004_AVIF_05.avif --ignore-icc --cicp 9/16/9 -d 10
avifenc --autotiling -q 57 images/HDR_PTC_00005_0ref_00.png out/HDR_PTC_00005_AVIF_04.avif --ignore-icc --cicp 9/16/9 -d 10
avifenc --autotiling -q 60 images/HDR_PTC_00001_0ref_00.png out/HDR_PTC_00001_AVIF_03.avif --ignore-icc --cicp 9/16/9 -d 10
avifenc --autotiling -q 61 images/HDR_PTC_00002_0ref_00.png out/HDR_PTC_00002_AVIF_03.avif --ignore-icc --cicp 9/16/9 -d 10
avifenc --autotiling -q 61 images/HDR_PTC_00003_0ref_00.png out/HDR_PTC_00003_AVIF_04.avif --ignore-icc --cicp 9/16/9 -d 10
avifenc --autotiling -q 61 images/HDR_PTC_00004_0ref_00.png out/HDR_PTC_00004_AVIF_04.avif --ignore-icc --cicp 9/16/9 -d 10
avifenc --autotiling -q 66 images/HDR_PTC_00003_0ref_00.png out/HDR_PTC_00003_AVIF_03.avif --ignore-icc --cicp 9/16/9 -d 10
avifenc --autotiling -q 70 images/HDR_PTC_00001_0ref_00.png out/HDR_PTC_00001_AVIF_02.avif --ignore-icc --cicp 9/16/9 -d 10
avifenc --autotiling -q 70 images/HDR_PTC_00003_0ref_00.png out/HDR_PTC_00003_AVIF_02.avif --ignore-icc --cicp 9/16/9 -d 10
avifenc --autotiling -q 70 images/HDR_PTC_00004_0ref_00.png out/HDR_PTC_00004_AVIF_03.avif --ignore-icc --cicp 9/16/9 -d 10
avifenc --autotiling -q 70 images/HDR_PTC_00005_0ref_00.png out/HDR_PTC_00005_AVIF_03.avif --ignore-icc --cicp 9/16/9 -d 10
avifenc --autotiling -q 73 images/HDR_PTC_00002_0ref_00.png out/HDR_PTC_00002_AVIF_02.avif --ignore-icc --cicp 9/16/9 -d 10
avifenc --autotiling -q 73 images/HDR_PTC_00003_0ref_00.png out/HDR_PTC_00003_AVIF_01.avif --ignore-icc --cicp 9/16/9 -d 10
avifenc --autotiling -q 73 images/HDR_PTC_00004_0ref_00.png out/HDR_PTC_00004_AVIF_02.avif --ignore-icc --cicp 9/16/9 -d 10
avifenc --autotiling -q 76 images/HDR_PTC_00001_0ref_00.png out/HDR_PTC_00001_AVIF_01.avif --ignore-icc --cicp 9/16/9 -d 10
avifenc --autotiling -q 76 images/HDR_PTC_00005_0ref_00.png out/HDR_PTC_00005_AVIF_02.avif --ignore-icc --cicp 9/16/9 -d 10
avifenc --autotiling -q 79 images/HDR_PTC_00004_0ref_00.png out/HDR_PTC_00004_AVIF_01.avif --ignore-icc --cicp 9/16/9 -d 10
avifenc --autotiling -q 81 images/HDR_PTC_00002_0ref_00.png out/HDR_PTC_00002_AVIF_01.avif --ignore-icc --cicp 9/16/9 -d 10
avifenc --autotiling -q 85 images/HDR_PTC_00005_0ref_00.png out/HDR_PTC_00005_AVIF_01.avif --ignore-icc --cicp 9/16/9 -d 10
cjxl -q 12 sources_ppm/HDR_PTC_00005_0ref_00.ppm -x color_space=Rec2100PQ out/HDR_PTC_00005_JPEG-XL_05.jxl
cjxl -q 18 sources_ppm/HDR_PTC_00003_0ref_00.ppm -x color_space=Rec2100PQ out/HDR_PTC_00003_JPEG-XL_05.jxl
cjxl -q 18 sources_ppm/HDR_PTC_00004_0ref_00.ppm -x color_space=Rec2100PQ out/HDR_PTC_00004_JPEG-XL_05.jxl
cjxl -q 20 sources_ppm/HDR_PTC_00002_0ref_00.ppm -x color_space=Rec2100PQ out/HDR_PTC_00002_JPEG-XL_05.jxl
cjxl -q 23 sources_ppm/HDR_PTC_00005_0ref_00.ppm -x color_space=Rec2100PQ out/HDR_PTC_00005_JPEG-XL_04.jxl
cjxl -q 24 sources_ppm/HDR_PTC_00001_0ref_00.ppm -x color_space=Rec2100PQ out/HDR_PTC_00001_JPEG-XL_05.jxl
cjxl -q 30 sources_ppm/HDR_PTC_00004_0ref_00.ppm -x color_space=Rec2100PQ out/HDR_PTC_00004_JPEG-XL_04.jxl
cjxl -q 39 sources_ppm/HDR_PTC_00002_0ref_00.ppm -x color_space=Rec2100PQ out/HDR_PTC_00002_JPEG-XL_04.jxl
cjxl -q 39 sources_ppm/HDR_PTC_00003_0ref_00.ppm -x color_space=Rec2100PQ out/HDR_PTC_00003_JPEG-XL_04.jxl
cjxl -q 41 sources_ppm/HDR_PTC_00001_0ref_00.ppm -x color_space=Rec2100PQ out/HDR_PTC_00001_JPEG-XL_04.jxl
cjxl -q 49 sources_ppm/HDR_PTC_00004_0ref_00.ppm -x color_space=Rec2100PQ out/HDR_PTC_00004_JPEG-XL_03.jxl
cjxl -q 54 sources_ppm/HDR_PTC_00005_0ref_00.ppm -x color_space=Rec2100PQ out/HDR_PTC_00005_JPEG-XL_03.jxl
cjxl -q 55 sources_ppm/HDR_PTC_00001_0ref_00.ppm -x color_space=Rec2100PQ out/HDR_PTC_00001_JPEG-XL_03.jxl
cjxl -q 58 sources_ppm/HDR_PTC_00002_0ref_00.ppm -x color_space=Rec2100PQ out/HDR_PTC_00002_JPEG-XL_03.jxl
cjxl -q 58 sources_ppm/HDR_PTC_00003_0ref_00.ppm -x color_space=Rec2100PQ out/HDR_PTC_00003_JPEG-XL_03.jxl
cjxl -q 61 sources_ppm/HDR_PTC_00004_0ref_00.ppm -x color_space=Rec2100PQ out/HDR_PTC_00004_JPEG-XL_02.jxl
cjxl -q 64 sources_ppm/HDR_PTC_00005_0ref_00.ppm -x color_space=Rec2100PQ out/HDR_PTC_00005_JPEG-XL_02.jxl
cjxl -q 67 sources_ppm/HDR_PTC_00003_0ref_00.ppm -x color_space=Rec2100PQ out/HDR_PTC_00003_JPEG-XL_02.jxl
cjxl -q 70 sources_ppm/HDR_PTC_00001_0ref_00.ppm -x color_space=Rec2100PQ out/HDR_PTC_00001_JPEG-XL_02.jxl
cjxl -q 73 sources_ppm/HDR_PTC_00004_0ref_00.ppm -x color_space=Rec2100PQ out/HDR_PTC_00004_JPEG-XL_01.jxl
cjxl -q 75 sources_ppm/HDR_PTC_00002_0ref_00.ppm -x color_space=Rec2100PQ out/HDR_PTC_00002_JPEG-XL_02.jxl
cjxl -q 76 sources_ppm/HDR_PTC_00001_0ref_00.ppm -x color_space=Rec2100PQ out/HDR_PTC_00001_JPEG-XL_01.jxl
cjxl -q 76 sources_ppm/HDR_PTC_00003_0ref_00.ppm -x color_space=Rec2100PQ out/HDR_PTC_00003_JPEG-XL_01.jxl
cjxl -q 79 sources_ppm/HDR_PTC_00005_0ref_00.ppm -x color_space=Rec2100PQ out/HDR_PTC_00005_JPEG-XL_01.jxl
cjxl -q 82 sources_ppm/HDR_PTC_00002_0ref_00.ppm -x color_space=Rec2100PQ out/HDR_PTC_00002_JPEG-XL_01.jxl
jpeg -h -qt 3 -oz -R 2 -q 21 sources_ppm/HDR_PTC_00003_0ref_00.ppm out/HDR_PTC_00003_JPEG-XT_05.jpg
jpeg -h -qt 3 -oz -R 2 -q 21 sources_ppm/HDR_PTC_00005_0ref_00.ppm out/HDR_PTC_00005_JPEG-XT_05.jpg
jpeg -h -qt 3 -oz -R 2 -q 24 sources_ppm/HDR_PTC_00004_0ref_00.ppm out/HDR_PTC_00004_JPEG-XT_05.jpg
jpeg -h -qt 3 -oz -R 2 -q 27 sources_ppm/HDR_PTC_00002_0ref_00.ppm out/HDR_PTC_00002_JPEG-XT_05.jpg
jpeg -h -qt 3 -oz -R 2 -q 33 sources_ppm/HDR_PTC_00005_0ref_00.ppm out/HDR_PTC_00005_JPEG-XT_04.jpg
jpeg -h -qt 3 -oz -R 2 -q 35 sources_ppm/HDR_PTC_00003_0ref_00.ppm out/HDR_PTC_00003_JPEG-XT_04.jpg
jpeg -h -qt 3 -oz -R 2 -q 41 sources_ppm/HDR_PTC_00001_0ref_00.ppm out/HDR_PTC_00001_JPEG-XT_05.jpg
jpeg -h -qt 3 -oz -R 2 -q 41 sources_ppm/HDR_PTC_00004_0ref_00.ppm out/HDR_PTC_00004_JPEG-XT_04.jpg
jpeg -h -qt 3 -oz -R 2 -q 42 sources_ppm/HDR_PTC_00002_0ref_00.ppm out/HDR_PTC_00002_JPEG-XT_04.jpg
jpeg -h -qt 3 -oz -R 2 -q 49 sources_ppm/HDR_PTC_00003_0ref_00.ppm out/HDR_PTC_00003_JPEG-XT_03.jpg
jpeg -h -qt 3 -oz -R 2 -q 57 sources_ppm/HDR_PTC_00001_0ref_00.ppm out/HDR_PTC_00001_JPEG-XT_04.jpg
jpeg -h -qt 3 -oz -R 2 -q 58 sources_ppm/HDR_PTC_00002_0ref_00.ppm out/HDR_PTC_00002_JPEG-XT_03.jpg
jpeg -h -qt 3 -oz -R 2 -q 58 sources_ppm/HDR_PTC_00004_0ref_00.ppm out/HDR_PTC_00004_JPEG-XT_03.jpg
jpeg -h -qt 3 -oz -R 2 -q 61 sources_ppm/HDR_PTC_00003_0ref_00.ppm out/HDR_PTC_00003_JPEG-XT_02.jpg
jpeg -h -qt 3 -oz -R 2 -q 61 sources_ppm/HDR_PTC_00005_0ref_00.ppm out/HDR_PTC_00005_JPEG-XT_03.jpg
jpeg -h -qt 3 -oz -R 2 -q 67 sources_ppm/HDR_PTC_00001_0ref_00.ppm out/HDR_PTC_00001_JPEG-XT_03.jpg
jpeg -h -qt 3 -oz -R 2 -q 69 sources_ppm/HDR_PTC_00004_0ref_00.ppm out/HDR_PTC_00004_JPEG-XT_02.jpg
jpeg -h -qt 3 -oz -R 2 -q 70 sources_ppm/HDR_PTC_00005_0ref_00.ppm out/HDR_PTC_00005_JPEG-XT_02.jpg
jpeg -h -qt 3 -oz -R 2 -q 73 sources_ppm/HDR_PTC_00003_0ref_00.ppm out/HDR_PTC_00003_JPEG-XT_01.jpg
jpeg -h -qt 3 -oz -R 2 -q 76 sources_ppm/HDR_PTC_00002_0ref_00.ppm out/HDR_PTC_00002_JPEG-XT_02.jpg
jpeg -h -qt 3 -oz -R 2 -q 79 sources_ppm/HDR_PTC_00001_0ref_00.ppm out/HDR_PTC_00001_JPEG-XT_02.jpg
jpeg -h -qt 3 -oz -R 2 -q 79 sources_ppm/HDR_PTC_00004_0ref_00.ppm out/HDR_PTC_00004_JPEG-XT_01.jpg
jpeg -h -qt 3 -oz -R 2 -q 84 sources_ppm/HDR_PTC_00002_0ref_00.ppm out/HDR_PTC_00002_JPEG-XT_01.jpg
jpeg -h -qt 3 -oz -R 2 -q 84 sources_ppm/HDR_PTC_00005_0ref_00.ppm out/HDR_PTC_00005_JPEG-XT_01.jpg
jpeg -h -qt 3 -oz -R 2 -q 85 sources_ppm/HDR_PTC_00001_0ref_00.ppm out/HDR_PTC_00001_JPEG-XT_01.jpg
