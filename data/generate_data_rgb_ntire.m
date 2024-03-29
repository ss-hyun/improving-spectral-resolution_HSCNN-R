function   generate_data_rgb_ntire(label_tag, input_channel, output_channel, amount_train_img, amount_valid_image)
% close all, clear all, clc


%% global variable              
global FILE_COUNT;
global TOTALCT;
global CREATED_FLAG;


%% Initialization the patch and stride
size_input=50;
size_label=50;
label_dimension=output_channel;
data_dimension=input_channel;
stride=80;


prefix = ['train'; 'valid'];
% type = 'clean';
output_dir = './hdf5_data/';
label = label_tag;
    
%% For loop  RGB-HS-HD5
for p=1:1:size(prefix,1)
    pre = prefix(p,:);
    %% Initialization the hdf5 parameters
    chunksz=9;
    TOTALCT=0;
    FILE_COUNT=0;
    CREATED_FLAG=false;

    input_dir = [ pre '_data/' ];
    if strcmp(pre, 'train') == 1
        amount_hd5_image=amount_train_img;  % 한 h5 file 에 들어가는 image num
    else
        amount_hd5_image=amount_valid_image;
    end
    input_data = dir(fullfile(input_dir, '*.mat'));
    order= randperm(size(input_data,1));
    filename = [ output_dir Get_filename(label, pre) ];

    for i=1:size(input_data,1)
        name_label=strcat(input_dir,input_data(order(i)).name);
        Filtered_data=cell2mat(struct2cell(load(name_label,'Filtered_data')));
        GT_data=cell2mat(struct2cell(load(name_label,'GT_data')));

        ConvertHStoHD5_31channel_31dim(Filtered_data,GT_data,size_input,size_label,label_dimension,data_dimension,stride,chunksz,amount_hd5_image,filename)

     end
end


