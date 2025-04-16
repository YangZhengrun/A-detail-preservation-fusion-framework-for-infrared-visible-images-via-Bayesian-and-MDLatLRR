
% If our thesis ideas are helpful to you, please help us light up the stars in Github, Thank you!
% If you use these code in your research, please cite:
% @conference{
%	author = {Guofa Li,Yongjie Lin,Xingda Qu},
%	title  = {An infrared and visible image fusion method based on Multi-scale Transformation and Norm Optimization},
%	booktitle = {Information Fusion},
%	year = {2021}
% }

function D_F = weight_selection( vis_detail, ir_detail,ImgPrefusion_detail,Weight )
[height,width]=size(vis_detail);
for j=1:height
    for i=1:width
        if Weight(j,i)==0.5
            D_F(j,i,:)=ImgPrefusion_detail(j,i,:);
        elseif Weight(j,i)>0.5
            D_F(j,i,:)=vis_detail(j,i,:);
        elseif Weight(j,i)<0.5
             D_F(j,i,:)=ir_detail(j,i,:);
        end
    end
end

end



