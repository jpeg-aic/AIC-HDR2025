# AIC-HDR2025: Fine-Grained HDR Image Quality Assessment Dataset

This repository accompanies the paper:

**Fine-Grained HDR Image Quality Assessment: From Noticeably Distorted to Very High Fidelity**  
*Mohsen Jenadeleh, Jon Sneyers, Davi Lazzarotto, Shima Mohammadi, Dominik Keller, Atanas Boev, Rakesh Rao Ramachandra Rao, António Pinheiro, Thomas Richter, Alexander Raake, Touradj Ebrahimi, João Ascenso, Dietmar Saupe*  
QoMEX 2025 – IEEE International Conference on Quality of Multimedia Experience, Madrid, Spain.  
Preprint: [arXiv:2506.12505](https://arxiv.org/abs/2506.12505)

---

## Overview

**AIC-HDR2025** is an HDR image quality assessment dataset for the high-fidelity range. Quality is reported in just-noticeable-difference (JND) units and was measured with the JPEG AIC-3 methodology (ISO/IEC 29170-3), which combines plain and boosted triplet comparisons.

- **5 source HDR images**, 840×944 pixels, Rec. 2100 PQ, 10 bits per sample.
- **100 compressed images**: 4 codecs (AVIF, JPEG AI, JPEG XL, JPEG XT) × 5 distortion levels per source.
- **JND scores** per image, based on 34,560 triplet comparisons by 151 participants in 4 controlled labs (half plain, half boosted). They were reconstructed with a unified PTC/BTC Thurstonian model and given with 95% bootstrap confidence intervals. The average CI width is about 0.27 JND at 1 JND.
- **Objective metric scores** for 29 metric variants. The paper evaluates these in Table II.

## Repository layout

```
images/               105 PNG stimuli (5 references + 100 distorted), exactly as shown in the experiment
data/
  jnd_scores.csv      one row per image: codec, level, bitrate, encoder setting, JND + 95% CI
  rd_curves.csv       fitted rate–distortion curves (100 points per source/codec) with 95% CI
  metric_scores.csv   objective metric scores for the 100 distorted images
encoding/
  encode_commands.sh  exact encoder command line for every compressed image
  make_distorted.sh   original script (bitrate-matching search over quality settings)
  Rec2100PQ.icc       ICC profile used to tag the PNGs
```

### File naming

Images use the names from the subjective experiment:

```
HDR_PTC_<source_id>_<codec>_<level>.png
HDR_PTC_00001_0ref_00.png       reference (source) image of source 1
HDR_PTC_00001_JPEG-XL_03.png    source 1, JPEG XL, distortion level 3
```

- `codec` is one of `AVIF`, `JPEG-AI`, `JPEG-XL`, `JPEG-XT`.
- `level` runs from `01`, the highest bitrate and least distorted, to `05`, the lowest bitrate and most distorted.
- The same images were used in both the PTC and BTC experiments, despite the `PTC` in the name.

### Source images

| id | name | content |
|----|------|---------|
| 00001 | alps-sunset | landscape |
| 00002 | building | night scene |
| 00003 | flower | nature |
| 00004 | p29-crop | portrait |
| 00005 | room1 | architecture |

The sources were developed from camera raw files in Adobe Lightroom. Most of the content lies within the SDR range, with highlights about 2 stops above SDR white and some details reaching about 4 stops. They were cropped and rescaled to 840×944 so that two zoomed images fit side by side on the test display.

## Data files

### `data/jnd_scores.csv`

| column | description |
|--------|-------------|
| `image` | file name in `images/` |
| `source_id`, `source` | source image (1–5) and its short name |
| `codec` | `reference`, `AVIF`, `JPEG-AI`, `JPEG-XL` or `JPEG-XT` |
| `level` | distortion level 1–5 (0 for the reference) |
| `encoder_setting` | quality parameter passed to the encoder: `-q` for avifenc, cjxl and jpeg, or `-target_bpps` for JPEG AI |
| `target_bpp` | bitrate the setting was chosen to match |
| `bpp` | actual bitrate in bits per pixel (compressed file size × 8 / (840 × 944)) |
| `jnd` | reconstructed distortion in JND units (0 = indistinguishable from the reference) |
| `jnd_ci95_low`, `jnd_ci95_high` | 95% confidence interval from 1000 bootstrap resamples, linearly interpolated from `rd_curves.csv` at the image's bitrate |
| `original_filename` | internal working name (it encodes target bpp and quality setting) |

### `data/rd_curves.csv`

This file holds the fitted model per source and codec: an exponential rate–distortion function for PTC, with a quadratic boosting transform for BTC. It is evaluated at 100 bitrates spanning the tested range, with 95% bootstrap confidence intervals. Columns are `source_id`, `source`, `codec`, `bpp`, `jnd`, `jnd_ci95_low` and `jnd_ci95_high`.

### `data/metric_scores.csv`

This file has one row per distorted image, with the same identifying columns as above (`image`, `source_id`, `source`, `codec`, `level`, `bpp`, `jnd`) followed by the objective metric scores. Column names match Table II of the paper.

- **"(PQ)"** columns were computed directly on the PQ-encoded signal.
- **"after TM"** columns were computed after tone mapping to SDR (ITU-R BT.2390 EETF followed by gamut mapping to sRGB).
- **"PU2-"** columns use PU21 encoding.

The metrics are PSNR-Y, SSIM, MS-SSIM, PSNR-HVS, IW-PSNR, IW-SSIM, VMAF, VMAF-neg, LGFM, PU2-PSNR, PU2-IW-PSNR, PU2-SSIM, PU2-MS-SSIM, PU2-IW-SSIM, HDR-VDP-2, HDR-VDP-3 (detect), CVVDP, Butteraugli (max and 3-norm), SSIMULACRA 1 and SSIMULACRA 2.

## Image format

All images are 16-bit RGB PNGs carrying an ICC profile for Rec. 2100 PQ (`encoding/Rec2100PQ.icc`). The ICC profile is authoritative: some PNGs also contain a `cHRM` chunk written by ImageMagick, and it should be ignored.

The reference images are exact 16-bit expansions of the 10-bit originals. You can recover the 10-bit data losslessly with `magick image.png -depth 10 image.ppm`.

## Encoding

Each codec's quality setting was chosen by binary search to match a per-source target bitrate. The JPEG XT targets are set higher, at twice the other codecs' target plus 0.1–0.3 bpp, so that its quality range roughly matches the other codecs.

| codec | encoder | command |
|-------|---------|---------|
| AVIF | libavif 1.1.1 with libaom 3.11.0 | `avifenc --autotiling -q Q --ignore-icc --cicp 9/16/9 -d 10` |
| JPEG XL | libjxl 0.11.1 | `cjxl -q Q -x color_space=Rec2100PQ` |
| JPEG XT | libjpeg 1.70 (Thomas Richter) | `jpeg -h -qt 3 -oz -R 2 -q Q` |
| JPEG AI | Verification Model 7.0, 10-bit YUV 4:4:4 | `python -m src.reco.scripts.eval --use_yuv 1 --cfg ./cfg/tools_on.json ./cfg/oper_point/hop.json ./cfg/BRM/regen_list.json --coding_type enc_dec -target_bpps <BPP×100>` |

JPEG XT settings in more detail:

- Optimized Huffman coding, ImageMagick-suggested quantization tables, trellis quantization, 2 refinement bits, 4:4:4.
- The second residual layer was omitted and the bit depth of the first layer was extended.

The JPEG AI VM assumes BT.709 and was trained on SDR content only, so it is not expected to perform optimally on HDR input.

`encoding/encode_commands.sh` lists the exact command line for every AVIF, JPEG XL and JPEG XT image. With the encoder versions above, decoding the resulting files reproduces the PNGs in `images/`:

- AVIF and JPEG XT decode bit-exactly.
- JPEG XL decodes to within one 10-bit code value, depending on the libjxl version.

## Subjective experiment

**Display and viewing conditions:**

- 16-inch MacBook Pro (Liquid Retina XDR) in three labs, and a Sony BVM-HX310 in one lab.
- 1000 cd/m² peak luminance, with SDR white (D65) at 100 cd/m².
- Ambient illumination of 5 lux.
- Viewing distance of 3.1× the stimulus height for PTC and 1.5× for BTC.

**Protocols:**

- **PTC (plain triplet comparison):** two distorted images are shown side by side at 1:1, each with in-place toggling to the reference.
- **BTC (boosted triplet comparison):** images are shown at 2× zoom and flicker against the reference at 10 Hz.

**Responses and screening:**

- Each of the 720 PTC and 720 BTC triplet questions received 24 responses.
- A batch was excluded if its combined accuracy and consistency score fell below 0.7. This removed 2 of 144 BTC batches and 10 of 144 PTC batches.

## Licenses and image credits

The annotations (JND scores, curves and metric scores) are released under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/).

The source images carry their own terms, which also apply to the compressed versions derived from them:

- **alps-sunset** and **flower** were created by Jon Sneyers and are released under CC0.
- **building** and **room1** were created by Sami Boukortt and are released under CC0.
- **p29-crop** is based on photo P29 from the Microsoft Research reference photo library (Canon EOS-1DS, photographer Bill Crow, Malibu, CA, 2004):

  > Copyright © 2003-2007 Microsoft Corporation. Individuals and organizations using photos or portions of photos from this archive ("Content") agree that all intellectual property rights therein remain the property of Microsoft Corporation. Microsoft grants you the right to use all or part of this content for any purpose. You agree to display a copyright notice sufficient to protect Microsoft's copyright in the Content. The Content is provided to you "AS IS" without warranty of any kind and Microsoft disclaims all warranties, whether express, implied or statutory including but not limited to, the implied warranties of merchantability and fitness for a particular purpose, and warranties of title and noninfringement.

## Related resources

- **Blog post:** [AIC-3 and HDR Image Quality Assessment](https://cloudinary.com/labs/aic-3-and-hdr), by Jon Sneyers, Mohsen Jenadeleh and Dietmar Saupe (May 2025). It gives a high-level summary of the design goals, experimental setup and results.

## Citation

```bibtex
@inproceedings{jenadeleh2025hdr,
  title     = {Fine-Grained {HDR} Image Quality Assessment: From Noticeably Distorted to Very High Fidelity},
  author    = {Jenadeleh, Mohsen and Sneyers, Jon and Lazzarotto, Davi and Mohammadi, Shima and Keller, Dominik and Boev, Atanas and Ramachandra Rao, Rakesh Rao and Pinheiro, Ant{\'o}nio and Richter, Thomas and Raake, Alexander and Ebrahimi, Touradj and Ascenso, Jo{\~a}o and Saupe, Dietmar},
  booktitle = {International Conference on Quality of Multimedia Experience (QoMEX)},
  year      = {2025},
  eprint    = {2506.12505},
  archivePrefix = {arXiv}
}
```

## Contact

**Mohsen Jenadeleh**, University of Konstanz: [mohsen.jenadeleh@uni-konstanz.de](mailto:mohsen.jenadeleh@uni-konstanz.de)
