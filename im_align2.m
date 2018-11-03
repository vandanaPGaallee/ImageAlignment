function im_align2(img_red, img_green, img_blue, ii)
  printf("Image%d - NCC offset\n", ii);
  row_size = int32(size(img_blue)(1));
  col_size = int32(size(img_blue)(2));
  filter = img_green(100:150, 100:150);
  rgbProcImage = zeros(row_size-79,col_size-79,3);
  ind = NCC(filter, img_blue);
  offset_x = ind(1);
  offset_y = ind(2);
  printf("%d %d ", offset_x, offset_y);
  rgbProcImage(:,:,2) = img_green(40+offset_x:row_size-40+offset_x,40+offset_y:col_size-40+offset_y);
  filter = img_red(100:150, 100:150);
  ind = NCC(filter, img_blue);
  offset_x = ind(1);
  offset_y = ind(2);
  printf("%d %d\n", offset_x, offset_y);
  rgbProcImage(:,:,1) = img_red(40+offset_x:row_size-40+offset_x,40+offset_y:col_size-40+offset_y);
  rgbProcImage(:,:,3) = img_blue(40:end-40, 40:end-40);
  rgbProcImage= uint8(rgbProcImage);
  imwrite (rgbProcImage, strcat("image",int2str(ii),"-ncc.jpg"));
  
  function img_pad = ImagePadding(o_x, o_y, s_x, s_y, img)
    img_pad = zeros(s_x,s_y);
    a_o_x = abs(o_x)
    a_o_y = abs(o_y)
    if o_x >=0 && o_y >= 0
      img_pad(a_o_x+1:end,a_o_y+1:end) = img(1:end-a_o_x,1:end-a_o_y);
    elseif o_x >=0 && o_y < 0
      img_pad(a_o_x+1:end,1:end-a_o_y) = img(1:end-a_o_x,a_o_y+1:end);
    elseif o_x < 0 && o_y >= 0
      img_pad(1:end-a_o_x,a_o_y+1:end) = img(a_o_x + 1:end,1:end-a_o_y);
    elseif o_x < 0 && o_y < 0
      img_pad(1:end-a_o_x,1:end-a_o_y) = img(a_o_x + 1:end,a_o_y+1:end);
    endif
  endfunction

  function ret_offset = NCC(filter, img)
    f_row_size = size(filter)(1);
    f_col_size = size(filter)(2);
    cc = normxcorr2 (filter, img);
    [Y_peak, X_peak] = find (cc == max (cc(:)));
    xoffSet = 100 - Y_peak + size(filter,1);
    yoffSet = 100 - X_peak + size(filter,2);
    ret_offset = [xoffSet, yoffSet];
  endfunction

endfunction