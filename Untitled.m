folder='E:\temp';%Ҫ�����ͼ�ļ��У��ļ���ֻ���Լ�Ҫ�����png�ļ�������png�Լ�ȥ��ʽ����ת��ֻ����׵ף�
result='E:\temp2';%����ļ���
imgDir  = dir(folder); % ���������ļ�
nPhoto=length(imgDir)-2;
M=zeros(1,nPhoto);
m=zeros(1,nPhoto);
name=strings(1,nPhoto);
for i = 1:nPhoto
    name(i)=imgDir(i+2).name;
    imgPath = [folder '\' imgDir(i+2).name]; % ��ϱ���·����ͼƬ����
    A=imread(imgPath);
    [a,b,c]=size(A);
    temp1=A(:,:,1)>245;%245���Ի���Խ�ӽ�255ͼԽ�����󣬵�ɾ���Ĳ���ɾ��Խ��
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