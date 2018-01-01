function []=EfficiencyPlot(net)

if exist('effimage.mat','file')
    load effimage;
else
    [folder,~,~]=fileparts(which('executeMe.m'));
    file_patho=[folder,'\dataset\test\o\'];
    file_paths=strrep(file_patho,'o\','s\');
    hhimg=imread([file_paths,'h16.png']);
    ssimg=imread([file_paths,'s27.png']);
    xximg=imread([file_paths,'x8.png']);
    imgdatabase{1}=hhimg;
    imgdatabase{2}=ssimg;
    imgdatabase{3}=xximg;
    save effimage imgdatabase;
end

if exist('eff.mat','file')
    load eff;
else
    [folder,~,~]=fileparts(which('executeMe.m'));
    file_patho=[folder,'\dataset\test\o\'];
    file_paths=strrep(file_patho,'o\','s\'); 
    if file_paths ~= 0
        s_c=0;
        h_c=0;
        x_c=0;
        s_ic=0;
        h_ic=0;
        x_ic=0;
        t_c=0;
        t_ic=0;
    
        %Efficiency for Hatchbacks
        fprintf('\nTesting for Hatchbacks');
        h = waitbar(0,'Calculating Accuracy for Hatchbacks...');
        for i=1:38
            waitbar(i/38);
            s_name=['h',num2str(i),'.png'];
            simg = imread ([file_paths,s_name]);
            simg=imresize(simg,0.5);
            value=testim(net,simg); 
            if value==1
                h_c=h_c+1;
                t_c=t_c+1;
            else
                h_ic=h_ic+1;
                t_ic=t_ic+1;
            end
            fprintf('.');
        end
        close(h);
    
    
        %Efficiency for Sedans
        fprintf('\nTesting for Sedans');
        h = waitbar(0,'Calculating Accuracy for Sedans...');
        for i=1:46
            waitbar(i/46);
            s_name=['s',num2str(i),'.png'];
            simg = imread ([file_paths,s_name]);
            simg=imresize(simg,0.5);
            value=testim(net,simg); 
            if value==2
                s_c=s_c+1;
                t_c=t_c+1;
            else
                s_ic=s_ic+1;
                t_ic=t_ic+1;
            end
            fprintf('.');
        end
        close(h);
    
    
        %Efficiency for SUVs
        fprintf('\nTesting for SUVs');
        h=waitbar(0,'Calculating Accuracy for SUVs...');
        for i=1:16
            waitbar(i/16);
            s_name=['x',num2str(i),'.png'];
            simg = imread ([file_paths,s_name]);
            simg=imresize(simg,0.5);
            value=testim(net,simg); 
            if value==3
                x_c=x_c+1;
                t_c=t_c+1;
            else
                x_ic=x_ic+1;
                t_ic=t_ic+1;
            end
            fprintf('.');
        end
        close(h);
        
        efficiency(1)=h_c;
        efficiency(2)=h_ic;
        efficiency(3)=s_c;
        efficiency(4)=s_ic;
        efficiency(5)=x_c;
        efficiency(6)=x_ic;
        efficiency(7)=t_c;
        efficiency(8)=t_ic;
        
        save eff efficiency;
    
    end
end
    
figure;
%set(findall(figure,'type','text'),'fontSize',14,'fontWeight','bold')
subplot(1,3,1),imshow(imgdatabase{1}),title({' Hatchbacks :',['Correctly Classified:'] ,[num2str((efficiency(1)/38*100)),' %']},'FontSize',18);
subplot(1,3,2),imshow(imgdatabase{2}),title({' Sedans :',['Correctly Classified:'] ,[num2str((efficiency(3)/46*100)),' %']},'FontSize',18);
subplot(1,3,3),imshow(imgdatabase{3}),title({' SUVs :',['Correctly Classified:'] ,[num2str((efficiency(5)/16*100)),' %']},'FontSize',18);



fprintf('\n***********************************************************************************************************************************');

fprintf(['\nHatchbacks: Correctly classified= ',num2str(efficiency(1)),' Incorrectly Classified= ',num2str(efficiency(2)),' =>Accuracy:-',num2str((efficiency(1)/38)*100),' %']);

fprintf(['\nSedans: Correctly classified= ',num2str(efficiency(1)),' Incorrectly Classified= ',num2str(efficiency(4)),' =>Accuracy:-',num2str((efficiency(3)/46)*100),' %']);

fprintf(['\nSUVs: Correctly classified= ',num2str(efficiency(5)),' Incorrectly Classified= ',num2str(efficiency(6)),' =>Accuracy:-',num2str((efficiency(5)/16)*100),' %']);

fprintf(['\nOverAll Accuracy is= ',num2str(efficiency(7))]);

fprintf('\n***********************************************************************************************************************************');