# A detail preservation fusion framework for infrared-visible images via Bayesian and MDLatLRR
### We sincerely appreciate your interest and support. The README will be further improved after acceptance.
## 1. Progect Overview
Despite advancements in image fusion methods, existing techniques often fail to effectively preserve high-resolution details, especially in complex images. In this paper, we propose a novel method based on Bayesian pre-fusion and multi-scale transformations to address this challenge and enhance detail preservation.The method first uses a Bayesian-based pre-fusion technique to create a pre-fused image, preserving the main structure and information, providing a solid foundation for subsequent steps. Next, infrared and visible images are decomposed with the Multi-layer Decomposition Latent Low-Rank Representation (MDLatLRR) method to extract the base layers, which are fused using a multi-level optimal fusion algorithm. MDLatLRR aims to maximize key information retention by decomposing low-rank features and detail layers. Then, using the pre-fused image, a visible light factor derived from the Structural Similarity Index (SSIM) is introduced in an L2-norm optimization to generate the final detail fusion layer. SSIM ensures structural similarity, preserving critical details and minimizing fusion errors. Finally, inverse transformations are applied to the fused base and detail layers to obtain the final fused image. Experimental results validate the effectiveness of our method, demonstrating superior performance in high-resolution detail preservation and edge contour clarity compared to 11 state-of-the-art fusion methods across four public datasets.
## 2. Framework


#### Requirements :
MATLAB Version: Ensure you have MATLAB installed. We recommend version R2018b or higher.
    

#### Installation Steps:

* Download the project files to your local machine.
* Launch MATLAB and open the project folder.
* Before running the project scripts in MATLAB, make sure the correct working directory is set.

#### Running the Project：
* Place the dataset in the input folder.
* Run the test.m script to process the data.
* The fused results will be saved in the output folder.

#### Datasets :
* The TNO dataset can be downloaded at the following address: https://figshare.com/articles/dataset/TNO_Image_Fusion_Dataset/13475045
* The Roadscene dataset can be downloaded at the following address: https://github.com/duzhan/RoadScene
* The LLVIP dataset can be downloaded at the following address: https://bupt-ai-cz.github.io/LLVIP/
* The M3FD dataset can be downloaded at the following address:https://universe.roboflow.com/rgbi/m3fd-tlj7u

#### Evaluation:
You can run the evaluation script to calculate these metrics：https://github.com/thfylsty/Objective-evaluation-for-image-fusion
