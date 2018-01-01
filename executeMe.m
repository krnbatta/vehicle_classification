
clear all;
close all;
clc;


if exist('imgdb.mat','file')
    load imgdb;
else
    IMGDB = loadimages();
end

if exist('net.mat','file')
    load net;
else
load carInputs;
load carTargets;
    net=create_pr_net(vInputs,vTargets);
end




while (1)
    choice=menu('Car Classification','Create Database','Train Network','Test on Photos','Check Efficiency','Exit');
    if (choice ==1)
        fprintf('\nCreating Database..');
        IMGDB = loadimages();
    end
    
    if (choice == 2)
        fprintf('\nInitializing and Training network..');
            load carInputs;
            load carTargets;
            net=create_pr_net(vInputs,vTargets);

    end    
    
    if (choice == 3)
        
        [file_name,file_patho] = uigetfile ('*.png');
        file_pathm=strrep(file_patho,'o\','m\');
        file_paths=strrep(file_patho,'o\','s\');
            
        if file_patho ~= 0
             
            s_name=file_name;
            o_name=file_name;
            m_name=file_name;
                
            simg = imread ([file_paths,s_name]);
            oimg = imread ([file_patho,o_name]);
            mimg = imread ([file_pathm,m_name]);
            simg=imresize(simg,0.5);
            value=testim(net,simg);
            
            if (value==1)
                try
                    drawBoundry(oimg,mimg,'Hatchback');
                    fprintf('\nImage is Hatchback');
                catch err
                    fprintf('\nImage Preview not available!!!Sorry for in convienence\nImage is Hatchback');
                end
                
            elseif(value==2)
                try
                    drawBoundry(oimg,mimg,'Sedan');
                    fprintf('\nImage is Sedan' );
                catch err
                    fprintf('\nImage Preview not available!!!Sorry for in convienence\nImage is Sedan');
                end
                
            elseif(value==3)
                 try
                     drawBoundry(oimg,mimg,'SUV');
                     fprintf('\nImage is SUV');
                catch err
                    fprintf('\nImage Preview not available!!!Sorry for in convienence\nImage is SUV');
                end
                
            else
                fprintf('\nImage is Other');
            end
        end
    end
    if(choice==4)
        EfficiencyPlot(net);
    end
    if (choice == 5)
        clear all;
        clc;
        close all;
        return;
    end    
end