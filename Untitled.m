%批量处理白底表情包，使其白底变透明，会有少量噪点与白边
folder='E:\temp';%要处理的图文件夹，文件夹只放自己要处理的png文件，不是png自己去格式工厂转，只处理白底！
result='E:\temp2';%输出文件夹
imgDir  = dir(folder); % 遍历所有文件
nPhoto=length(imgDir)-2;
M=zeros(1,nPhoto);
m=zeros(1,nPhoto);
name=strings(1,nPhoto);
for i = 1:nPhoto
    name(i)=imgDir(i+2).name;
    imgPath = [folder '\' imgDir(i+2).name]; % 组合保存路径和图片名称
    A=imread(imgPath);
    [a,b,c]=size(A);
    temp1=A(:,:,1)>245;%245可以换，越接近255图越噪声大，但删除的不该删的越少
    temp2=A(:,:,2)>245;
    temp3=A(:,:,3)>245;
    temp=temp1.*temp2.*temp3;
    Alpha=zeros(a,b);
    Alpha(temp==0)=1;
    temp=edge(rgb2gray(A),'Canny',0.15);
    temp=(imfill(temp,'holes'));
    temp = imerode(temp,strel('disk',1));
    temp = imdilate(temp,strel('disk',1));
    Alpha(temp==1)=1;
    imwrite(A,[result '\' imgDir(i+2).name],'Alpha',imdilate(Alpha,strel('disk',1))); 
    i
end
