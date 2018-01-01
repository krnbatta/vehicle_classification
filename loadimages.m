function IMGDB = loadimages()
[folder,~,~]=fileparts(which('executeMe.m'));
path=strcat(folder,'\');
%Masked Images
hatchback_folder = [path,'dataset\train\hatchback\'];  %LOCATION OF hatchback IMAGES
sedan_folder=[path,'dataset\train\sedan\']; % Location of sedan images
SUV_folder=[path,'dataset\train\SUV\']; % Location of SUV images%
%other_folder = 'C:\Users\adil\Desktop\Minor Project\dataset\train\other\'; %LOCATION OF other IMAGES



%Original Images
hatchbackO_folder = [path,'dataset\train\hatchbackO\'];  %LOCATION OF hatchback IMAGES
sedanO_folder=[path,'dataset\train\sedanO\']; % Location of sedan images
SUVO_folder=[path,'dataset\train\SUVO\']; % Location of SUV images%
%otherO_folder = 'C:\Users\adil\Desktop\Minor Project\dataset\train\otherO\'; %LOCATION OF other IMAGES

file_ext = '.png';
OUT{1}= [1;0;0];
OUT{2}= [0;1;0];
OUT{3}= [0;0;1];

%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

if exist('imgdb.mat','file')
    load imgdb;
else
    IMGDB = cell (3,[]);
end


fprintf ('\nLoading hatchback');
folder_content = dir ([hatchback_folder,'*',file_ext]);
folderO_content = dir ([hatchbackO_folder,'*',file_ext]);
nhatchback = size (folder_content,1);
h = waitbar(0,'Loading Hatchbacks...');
for k=1:nhatchback
    waitbar(k/nhatchback)
    string1 = [hatchback_folder,folder_content(k,1).name];
    string2 = [hatchbackO_folder,folderO_content(k,1).name];
    image = imread(string1);
    imageO = imread(string2);
    image=segmentGray(imageO,image);
    image=imresize(image,0.5);
    f=0;
    for i=1:length(IMGDB)
        if strcmp(IMGDB{1,i},string1)
            f=1;
        end
    end
    if f==1
        continue;
    end
    fprintf ('.');    
    IM {1} = im2vec (image);    % ORIGINAL hatchback IMAGE
    IM {2} = im2vec (fliplr(image));    % MIRROR OF THE hatchback
    IM {3} = im2vec (circshift(image,1)); 
    IM {4} = im2vec (circshift(image,-1));
    IM {5} = im2vec (circshift(image,[0 1]));
    IM {6} = im2vec (circshift(image,[0 -1]));
    IM {7} = im2vec (circshift(fliplr(image),1));
    IM {8} = im2vec (circshift(fliplr(image),-1));
    IM {9} = im2vec (circshift(fliplr(image),[0 1]));
    IM {10} = im2vec(circshift(fliplr(image),[0 -1]));
    for i=1:10
        IMGDB {1,end+1}= string1;
        IMGDB {2,end} = OUT{1};
        IMGDB (3,end) = {IM{i}};
    end    
end
close(h)
%%% how data is stored in above cell IMGDB...

%%%  cell{1,1}   cell{2,1}  cell{3,1}   .....
%%%  [name] ,    [name]      [name]     .....cell{1,1}
%%%  [1,0,0,0] , [1,0,0,0] , [1,0,0,0]  .....cell{2,1}
%%%  [im{1}] ,   [im{2}] ,     [im{2}]  .....cell{3,1}
%%%    .           .             .      .....  .
%%%    .           .             .      .....  .
%%%

fprintf ('\nLoading Sedans... ');
folder_content = dir ([sedan_folder,'*',file_ext]);
folderO_content = dir ([sedanO_folder,'*',file_ext]);
nsedan = size (folder_content,1);
h = waitbar(0,'Loading Sedans...');    
for k=1:nsedan
    waitbar(k/nsedan)
    string1 = [sedan_folder,folder_content(k,1).name];
    string2 = [sedanO_folder,folderO_content(k,1).name];
    image = imread(string1);
    imageO = imread(string2);
    image=segmentGray(imageO,image);   
    image=imresize(image,0.5);
    f=0;
    for i=1:length(IMGDB)-1
        if strcmp(IMGDB{1,i},string1)
            f=1;
        end
    end
    if f==1
        continue;
    end
    fprintf ('.');    
    IM {1} = im2vec (image);    % ORIGINAL sedan IMAGE
    IM {2} = im2vec (fliplr(image));    % MIRROR OF THE sedan
    IM {3} = im2vec (circshift(image,1)); 
    IM {4} = im2vec (circshift(image,-1));
    IM {5} = im2vec (circshift(image,[0 1]));
    IM {6} = im2vec (circshift(image,[0 -1]));
    IM {7} = im2vec (circshift(fliplr(image),1));
    IM {8} = im2vec (circshift(fliplr(image),-1));
    IM {9} = im2vec (circshift(fliplr(image),[0 1]));
    IM {10} = im2vec (circshift(fliplr(image),[0 -1]));
    for i=1:10
        IMGDB {1,end+1}= string1;
        IMGDB {2,end} = OUT{2};
        IMGDB (3,end) = {IM{i}};
    end    
end
close(h);


%%% how data is stored in above cell IMGDB...
%%%  [  nb x 10 times where nb is no of hatchbacks ]| [  nc x 10 times where nc is no of sedans ]
%%%  cell{1,1}   cell{2,1}    cell{3,1}    .....    | cell{1,1}   cell{2,1}   cell{3,1}   ..... 
%%%  [name_hb] ,[name_hb] ,[name_hb] .....          | [name_sed]  ,[name_sed] ,[name_sed] .....
%%%  [1,0,0,0]   ,[1,0,0,0]   ,[1,0,0,0]   .....    | [0,1,0,0]   ,[0,1,0,0]  ,[0,1,0,0]  .....
%%%  [im{1}]     ,[im{2}]     ,[im{3}]     .....    | [im{1}]     ,[im{2}]    ,[im{3}]    .....
%%% 


fprintf ('\nLoading SUVs ');
folder_content = dir ([SUV_folder,'*',file_ext]);
folderO_content = dir ([SUVO_folder,'*',file_ext]);
nSUV = size (folder_content,1);
h = waitbar(0,'Loading SUVs...');
for k=1:nSUV
    waitbar(k/nSUV)
    string1 = [SUV_folder,folder_content(k,1).name];
    string2 = [SUVO_folder,folderO_content(k,1).name];
    image = imread(string1);
    imageO = imread(string2);
    image=segmentGray(imageO,image);    
    image=imresize(image,0.5);
    f=0;
    for i=1:length(IMGDB)
        if strcmp(IMGDB{1,i},string1)
            f=1;
        end
    end
    if f==1
        continue;
    end
    fprintf ('.');    
    IM {1} = im2vec (image);    % ORIGINAL SUV IMAGE
    IM {2} = im2vec (fliplr(image));    % MIRROR OF THE SUV
    IM {3} = im2vec (circshift(image,1)); 
    IM {4} = im2vec (circshift(image,-1));
    IM {5} = im2vec (circshift(image,[0 1]));
    IM {6} = im2vec (circshift(image,[0 -1]));
    IM {7} = im2vec (circshift(fliplr(image),1));
    IM {8} = im2vec (circshift(fliplr(image),-1));
    IM {9} = im2vec (circshift(fliplr(image),[0 1]));
    IM {10} = im2vec (circshift(fliplr(image),[0 -1]));
    for i=1:10
        IMGDB {1,end+1}= string1;
        IMGDB {2,end} = OUT{3};
        IMGDB (3,end) = {IM{i}};
    end    
end
close(h);

%%%  how data is stored in above cell IMGDB...Similarly continued..
%%%  Thus for all images we get a  [3 * no_of_images] cell.
%%%  cell{1:end}=names of what we have data about
%%%  cell{1:end}=out put target
%%%  cell{1:end}=10 version of same image.

%%%  [  nb x 10 times where nb is no of hatchbacks ]| [  nc x 10 times where nc is no of sedans ]
%%%  cell{1,1}   cell{2,1}    cell{3,1}    .....    | cell{1,1}   cell{2,1}   cell{3,1}   ..... 
%%%  [name_hb] ,[name_hb] ,[name_hb] .....          | [name_sed]  ,[name_sed] ,[name_sed] .....
%%%  [1,0,0,0]   ,[1,0,0,0]   ,[1,0,0,0]   .....    | [0,1,0,0]   ,[0,1,0,0]  ,[0,1,0,0]  .....
%%%  [im{1}]     ,[im{2}]     ,[im{3}]     .....    | [im{1}]     ,[im{2}]    ,[im{3}]    .....

vInputs = cell2mat(IMGDB(3,:));
vTargets = cell2mat(IMGDB(2,:));

save carInputs vInputs;
save carTargets vTargets;
save imgdb IMGDB;