% If our thesis ideas are helpful to you, please help us light up the stars in Github, Thank you!
% If you use these code in your research, please cite:
% @conference{
%	author = {Guofa Li,Yongjie Lin,Xingda Qu},
%	title  = {An infrared and visible image fusion method based on Multi-scale Transformation and Norm Optimization},
%	booktitle = {Information Fusion},
%	year = {2021}
% }

% Detail_1 is visible image detail，Detail_2 is infrared image detail，�? is balance parameter�?
% argmin∑（x-Detail_2）^2+λ*（x-Detail_1）^2

function Fdetail = L2( Detail_1, Detail_2, Weight )

% [H, W]=size(Detail_1);  

% Weight = Weight(:);
% Weight = sparse(1:1:H*W,1:1:H*W,Weight(1:1:H*W)',H*W,H*W);
% 
%  II=sparse(1:1:H*W,1:1:H*W,ones(1,H*W),H*W,H*W);
%公式�?39�?---------如何修改�?
% y=2*II+3*(Weight+Weight');
% y=(Detail_2 + Weight*Detail_1)/2;

% x=2*Detail_2(:)+3*(Weight+Weight')*Detail_1(:);


% Fdetail = reshape( y, H,W);

Fdetail = (Detail_2 + Weight.*Detail_1)/2;
% Fdetail = (Detail_2 - Weight.*Detail_2 + Weight.*Detail_1)/2;
end