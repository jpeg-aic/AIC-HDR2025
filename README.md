# AIC-HDR2025: Fine-Grained HDR Image Quality Assessment Dataset

This repository accompanies the paper:

**Fine-Grained HDR Image Quality Assessment: From Noticeably Distorted to Very High Fidelity**  
*Mohsen Jenadeleh, Jon Sneyers, Davi Lazzarotto, Shima Mohammadi, Dominik Keller, Atanas Boev, Rakesh Rao Ramachandra Rao, António Pinheiro, Thomas Richter, Alexander Raake, Touradj Ebrahimi, João Ascenso, Dietmar Saupe*  
Accepted at **QoMEX 2025 – IEEE International Conference on Quality of Multimedia Experience**.

---

## Overview

The **AIC-HDR2025** dataset is the first publicly available high-fidelity HDR image quality assessment dataset designed for precise perceptual evaluation using Just Noticeable Difference (JND) scaling. It supports benchmarking of both traditional and learning-based codecs under the JPEG AIC-3 methodology.

### Key Features

- **5 source HDR images** (Rec.2100 PQ, 10-bit RGB)
- **100 compressed images**, using 4 codecs (JPEG AI, JPEG XL, AVIF, JPEG XT), each at 5 bitrate levels
- **34,560 triplet responses** from 151 participants across 4 fully controlled labs
- **Perceptual quality scores** reconstructed in JND units with high confidence (95% CI ≈ 0.27 at 1 JND)
- **Unified scale reconstruction** from both plain and boosted triplet comparisons

---

## Dataset Availability

The dataset will be **publicly released after QoMEX 2025**, which will be held in **Madrid, Spain, from September 30 to October 2, 2025**.

Upon release, this repository will include:

- HDR source images and compressed test images  
- Subjective annotations (triplet responses)  
- Reconstructed perceptual scales in JND units  
- Codec configurations and encoding recipes  

---

## Related Resources

- 📖 **Blog Post**: [AIC-3 and HDR Image Quality Assessment](https://cloudinary.com/labs/aic-3-and-hdr)  
  *Jon Sneyers (Cloudinary Research), Mohsen Jenadeleh and Dietmar Saupe (University of Konstanz), May 2025*  
  This post offers a high-level summary of the design goals, experimental setup, and perceptual insights of AIC-HDR2025. It explains how the JPEG AIC-3 methodology enables accurate JND estimation across subtle HDR distortions.

---

## Usage

A comprehensive usage guide will be provided upon dataset release.

---

## License

The dataset and accompanying tools will be released under a permissive open license (e.g., [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/)) to support academic and industrial use. Licensing details will be provided upon release.

---

## Citation

Citation details and a BibTeX entry will be added once the paper is published and the dataset is released.

---

## Contact

For questions or collaboration inquiries, please contact:

**Mohsen Jenadeleh**  
University of Konstanz  
📧 [mohsen.jenadeleh@uni-konstanz.de](mailto:mohsen.jenadeleh@uni-konstanz.de)
