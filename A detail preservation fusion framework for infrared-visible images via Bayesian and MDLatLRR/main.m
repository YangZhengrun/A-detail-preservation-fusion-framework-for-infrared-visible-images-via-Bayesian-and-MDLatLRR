 
% If our thesis ideas are helpful to you, please help us light up the stars in Github, Thank you!
% If you use these code in your research, please cite:
% @conference{
%	author = {Guofa Li,Yongjie Lin,Xingda Qu},
%	title  = {An infrared and visible image fusion method based on Multi-scale Transformation and Norm Optimization},
%	booktitle = {Information Fusion},
%	year = {2021}
% }
function [fusion] = main(ImgIr, ImgVis,FusionPath,PreFusionPath,WeightFusionPath,num)
    disp([num2str(num),'th fusion begin']);
    % Parameter Description
    % ImgIr:  Infrared image to be fused
    % ImgVis: Visible image to be fused
    % FusionPath: Fusion image storage path
    % BalanceParameters: Controls the balance of infrared image contrast fidelity and infrared visible gradient
    ImgVis1 = im2double(ImgVis);    %   Visible image
    ImgIr1 = im2double(ImgIr);     %   Infrared image
   
    
    %% Prefusion
    [H,W] = size(ImgIr);
    %%%%�޸�Ԥ�ںϷ���---ʹ��bayes�ں�
    disp(['prefusion begin']);
    PreFusion = BayesFusion(ImgIr1,ImgVis1); 
%     % Modify the image shape to fit the function requirements
%     Vis = shrink(H,W,ImgVis,2);
%     
%     % From 'https://www.mathworks.com/matlabcentral/fileexchange/36278-split-bregman-method-for-total-variation-denoising?s_tid=srchtitle'
%     % Modify function input port
%     BalanceParameters = 175;
%     PreFusion = Bregman(-Vis,BalanceParameters); 
% 
%     % Inverse transformation back to original shape
%     PreFusion = reshape(PreFusion,[max(H,W),max(H,W)]);
%     PreFusion = shrink(H,W,PreFusion,3); 
%     
%     PreFusion = PreFusion+double(ImgIr)+double(ImgVis);
%    PreFusion = mat2gray(PreFusion);
    
    % Save and read
    imwrite(PreFusion,PreFusionPath);
    disp(['prefusion over']);
    %PreFusion = double(imread(PreFusionPath));


    %% Decompose infrared image, visible image and pre-fusion image

    A=cell(1,3);
    A{1} = ImgVis1;    %   Visible image
    A{2} = ImgIr1;     %   Infrared image
    A{3} = PreFusion; %   Pre-fusion of the image for two purposes
                      %   1��The low frequency layer is decomposed from MDLatLRR as the low frequency layer of the final fusion image.
                      %   2��Assisted final image detail layer fusion (SSIM).

    % Decomposition of 4 scale: One Base layer and Four Detail layers

    Lrr_img=cell(1,3);
    Sal_img=cell(1,3);
    
    disp(['begin MDLatLRR']);
    % From 'https://github.com/hli1221/imagefusion_mdlatlrr'
    for i = 1:3
        [Lrr_img{i},Sal_img{i}] = MDLatLRR(A{i});
    end
    %% Fusion of base layer%%%%----�޸Ļ������ں�---�ο��������¡�
    %%%%%From 'https://github.com/ChingCheTu/A-Multi-level-Optimal-Fusion-Algorithm-for-Infrared-and-Visible-Image'
    % @article{jian2023multi,
    %   title={Multi-level optimal fusion algorithm for infrared and visible image},
    %   author={Jian, Bo-Lin and Tu, Ching-Che},
    %   journal={Signal, Image and Video Processing},
    %   pages={1--9},
    %   year={2023},
    %   publisher={Springer}
    % }
%       Lrr = Lrr_img{3};
    out1 = g_Weight_Map(Lrr_img{1,1});
    out2 = g_Weight_Map(Lrr_img{1,2});
    Lrr = 0.5*(Lrr_img{1,1}-Lrr_img{1,2}).*(out1-out2)+0.5*(Lrr_img{1,1}+Lrr_img{1,2});
    %% Fusion of detail layers
    
    [CAscore,CBscore] = Relevancy(A{1}, A{2}, A{3});
    
    disp(['weight calculating']);

    %Weaken the interfering information and enhance the effective information
    % weight = CAscore - CBscore;
    % weight_normalized = 0.5 + atan(weight)/pi;
    % Weight = weight_normalized;
    Weight = CAscore ./ (CAscore + CBscore); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
%     w =  0.5 + CAscore - CBscore;
%     [W_w,H_w] = size(w);
%     w_vector = reshape(w,1,W_w*H_w);
%     w_vector_normalized = normalize(w_vector,"range");
%     w_stretch=(1-cos(pi*w_vector_normalized))/2;
%     Weight = reshape(w_stretch,W_w,H_w);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Weight = 0.5 + offset;
    %Weight(Weight>1) = 1;
    %Weight(Weight<0) = 0;
    imwrite(mat2gray(Weight),WeightFusionPath);

    SalImg_A = Sal_img{1};% Visible image datail
    SalImg_B = Sal_img{2};% Infared image datail
%     SalImg_Pre = Sal_img{3};% Infared image datail
    %�޸�ʽ��22����1��(�˷�������)ֱ�ӽ�weight������Ԥ�ںϡ����⡢�ɼ���ͼ��ķ����ϣ���D_F=prefusion(Weight = 0.5);D_F=vis(Weight > 0.5);D_F=IR(Weight< 0.5);
   %2��
    disp(['begin detail fusion']);
    Sal1 = detail_fusion( SalImg_A, SalImg_B, Weight );
%     Sal1 = detail_fusion_weight_selection( SalImg_A, SalImg_B,SalImg_Pre,Weight );
    %% Inverse transformation
      
    X = Lrr+Sal1;
    %maxP = max(max(image));
    %minP = min(min(image));
    %image_normalized = (image - minP) * 255 / (maxP - minP);
    %fusion = image_normalized;
    %%%%%%%%%%%%%
    % imwrite(round(uint8(image_normalized)),'nor.jpg');
    % c = 255/log(256);
    % fusion = c * log(1 + image_normalized);
    %disp(fusion);
    X = X .* 255;
    X(X<0)=0;
    X(X>255)=255;
    fusion=round(uint8(X));
    
    disp(['fusion completed']);
    
    imwrite(fusion,FusionPath);

end