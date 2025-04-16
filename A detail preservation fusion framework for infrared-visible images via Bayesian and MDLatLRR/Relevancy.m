
% If our thesis ideas are helpful to you, please help us light up the stars in Github, Thank you!
% If you use these code in your research, please cite:
% @conference{
%	author = {Guofa Li,Yongjie Lin,Xingda Qu},
%	title  = {An infrared and visible image fusion method based on Multi-scale Transformation and Norm Optimization},
%	booktitle = {Information Fusion},
%	year = {2021}
% }

function [ca,cb] = Relevancy(img1,img2,img3)

AImg = padarray(img1,[7,7 ],'symmetric','both');%visible
BImg = padarray(img2,[7,7],'symmetric','both');%infrared
CImg = padarray(img3,[7,7],'symmetric','both');%pre-fusion

[M,N]= size(AImg);

%15 * 15 ��ͼ��顣

i = 1:M-15+1;
j = 1:N-15+1;
[I,J] = meshgrid(i,j);

fprintf('M:%d\tN:%d\n',M,N);
fprintf('I:%d\n',numel(I));
fprintf('i:%d\tj:%d\n',length(i),length(j));

for i = 1:numel(I)              %9
        %  Local relevancy score
        A1 = AImg( (I(i)-1)*1+1:(I(i)-1)*1+15, (J(i)-1)*1+1:(J(i)-1)*1+15 );
        B1 = BImg( (I(i)-1)*1+1:(I(i)-1)*1+15, (J(i)-1)*1+1:(J(i)-1)*1+15 );
        C1 = CImg( (I(i)-1)*1+1:(I(i)-1)*1+15, (J(i)-1)*1+1:(J(i)-1)*1+15 );
        Cascore(i) = ssim(A1,C1);
        Cbscore(i) = ssim(C1,B1);
end

[W,H]=size(Cbscore);
fprintf('W:%d\tH:%d\n',W,H);

cbscore = reshape(Cbscore,N-14,M-14);
cb = transpose(cbscore);
cascore = reshape(Cascore,N-14,M-14);
ca = transpose(cascore);

end