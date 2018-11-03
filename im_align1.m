function im_align1(img_red, img_green, img_blue, ii)
  row_size = int32(size(img_blue)(1));
  col_size = int32(size(img_blue)(2));
  filter = img_red((30):row_size-30,30:col_size-30);
  f_row_size = size(filter)(1);
  f_col_size = size(filter)(2);
  rgbProcImage = zeros(f_row_size,f_col_size,3);
  rgbProcImage(:,:,1) = filter;
  printf("Image%d - SSD offset\n",ii);
  rgbProcImage(:,:,2) = FindImage(filter, img_green);
  rgbProcImage(:,:,3) = FindImage(filter, img_blue);
  printf("\n");
  rgbProcImage= uint8(rgbProcImage);
  imwrite (rgbProcImage, strcat("image",int2str(ii),"-ssd.jpg"));
  
  function ret_img = FindImage (filter, img_green)
    min = 9999;
    f_row_size = size(filter)(1);
    f_col_size = size(filter)(2);
    c_row_size = size(img_green)(1);
    c_col_size = size(img_green)(2);
    offset_x = 0;
    offset_y = 0;
    for i = 30:c_row_size-(f_row_size-1)
      for j = 30:c_col_size-(f_col_size-1)
        dif = sum(filter - img_green(i:i+f_row_size-1,j:j+f_col_size-1).^2);
        sumofsquares = sum(sumsq(dif,1),2);
        ssd = sqrt(sumofsquares);
        if ssd < min
          min = ssd;
          offset_x = i;
          offset_y = j;
          match = img_green(i:i+f_row_size-1,j:j+f_col_size-1);
        endif
      endfor
    endfor
    printf("%d %d ", 30 - offset_x, 30 - offset_y);
    ret_img = img_green(offset_x:offset_x+f_row_size-1,offset_y:offset_y+f_col_size-1);
    fil = size(filter);
    siz = size(ret_img);
  endfunction

endfunction



  