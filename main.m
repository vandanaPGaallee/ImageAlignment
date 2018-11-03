x = dir ("images/*.jpg");  
for ii = 1:length(x)# loop over jpg files
  img = imread (strcat("images/",x(ii).name));   # read image file
  img_size_r = size(img)(1);
  img_size_c = size(img)(2);
  padding = zeros(1,img_size_c);
  img_green = img(342:683,:);
  img_blue = [padding; img(1:341,:)];
  img_red = [padding; img(684:1024,:)];
  rgbImage = zeros(342,img_size_c,3);
  rgbImage(:,:,3) = img_blue;
  rgbImage(:,:,2) = img_green;
  rgbImage(:,:,1) = img_red;
  rgbImage= uint8(rgbImage);
  imwrite (rgbImage, strcat("image",int2str(ii),"-color.jpg"));
  
  im_align1(img_red, img_green, img_blue, ii)
  im_align2(img_red, img_green, img_blue, ii)
end