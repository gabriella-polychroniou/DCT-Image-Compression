clear; clc; close all;

%1
f = imread('cameraman.tif');

%2
e = entropy(f);
fprintf('Entropy of original image = %.4f bits/symbol \n',e)

fprintf('\n--Q=Q1--\n')

%3,4,5
block = 8;
[row column] = size(f);

Q1 = [  [16 11 10 16 24 40 51 61];
       [12 12 14 19 26 58 60 55];
       [14 13 16 24 40 57 69 56];
       [14 17 22 29 51 87 80 62];
       [18 22 37 56 68 109 103 77];
       [24 35 55 64 81 104 113 92];
       [49 64 78 87 103 121 120 101];
       [72 92 95 98 112 100 103 99] ];

dct_array = zeros(row,column);
F_quantized = zeros(row,column);

for i = 1 : block : row
  for j = 1 : block : column

    current_block = f(i:(i+7), j:(j+7));

    %4
    dct_array(i:(i+7), j:(j+7)) = dct2(current_block);

    %5
    F_quantized(i:(i+7), j:(j+7)) = round(dct_array(i:(i+7), j:(j+7)) ./ Q1);

  endfor
endfor

%6
en = entropy(abs(F_quantized));
fprintf('Entropy = %.4f bits/symbol \n',en)


%7
total_zeros_coefficients = sum(F_quantized(:) == 0);
fprintf('Total zeros coefficients = %.f \n',total_zeros_coefficients)

%8
for i = 1 : block : row
  for j = 1 : block : column
    F_inv_quant(i:(i+7), j:(j+7)) = F_quantized(i:(i+7), j:(j+7)) .* Q1;
  endfor
endfor

%9
for i = 1 : block : row
  for j = 1 : block : column
    idct_array(i:(i+7), j:(j+7)) = idct2(F_inv_quant(i:(i+7), j:(j+7)));
  endfor
endfor

%10
f_uint8 = uint8(min(max(idct_array,0),255));

%11
MSE = sum(sum((double(f)-double(f_uint8)).^2))/(row*column);
PSNR = 10*log10(255^2/MSE)

figure;
imagesc(f);
colormap(gray);
title("Original image");

figure;
imagesc(f_uint8);
colormap(gray);
title("Reconstructed image");


%Q2 = 2*Q
fprintf('\n--Q=2*Q1--\n')
Q2 = 2*Q1;
dct_array = zeros(row,column);
F_quantized = zeros(row,column);

for i = 1 : block : row
  for j = 1 : block : column

    current_block = f(i:(i+7), j:(j+7));

    %4
    dct_array(i:(i+7), j:(j+7)) = dct2(current_block);

    %5
    F_quantized(i:(i+7), j:(j+7)) = round(dct_array(i:(i+7), j:(j+7)) ./ Q2);

  endfor
endfor

%6
en = entropy(abs(F_quantized));
fprintf('Entropy = %.4f bits/symbol \n',en)


%7
total_zeros_coefficients = sum(F_quantized(:) == 0);
fprintf('Total zeros coefficients = %.f \n',total_zeros_coefficients)

%8
for i = 1 : block : row
  for j = 1 : block : column
    F_inv_quant(i:(i+7), j:(j+7)) = F_quantized(i:(i+7), j:(j+7)) .* Q2;
  endfor
endfor

%9
for i = 1 : block : row
  for j = 1 : block : column
    idct_array(i:(i+7), j:(j+7)) = idct2(F_inv_quant(i:(i+7), j:(j+7)));
  endfor
endfor

%10
f_uint8 = uint8(min(max(idct_array,0),255));

%11
MSE = sum(sum((double(f)-double(f_uint8)).^2))/(row*column);
PSNR = 10*log10(255^2/MSE)

figure;
imagesc(f_uint8);
colormap(gray);
title("Reconstructed image");


%Q3 = 3*Q
fprintf('\n--Q=3*Q1--\n')
Q3 = 3*Q1;

dct_array = zeros(row,column);
F_quantized = zeros(row,column);

for i = 1 : block : row
  for j = 1 : block : column

    current_block = f(i:(i+7), j:(j+7));

    %4
    dct_array(i:(i+7), j:(j+7)) = dct2(current_block);

    %5
    F_quantized(i:(i+7), j:(j+7)) = round(dct_array(i:(i+7), j:(j+7)) ./ Q3);

  endfor
endfor

%6
en = entropy(abs(F_quantized));
fprintf('Entropy = %.4f bits/symbol \n',en)


%7
total_zeros_coefficients = sum(F_quantized(:) == 0);
fprintf('Total zeros coefficients = %.f \n',total_zeros_coefficients)

%8
for i = 1 : block : row
  for j = 1 : block : column
    F_inv_quant(i:(i+7), j:(j+7)) = F_quantized(i:(i+7), j:(j+7)) .* Q3;
  endfor
endfor

%9
for i = 1 : block : row
  for j = 1 : block : column
    idct_array(i:(i+7), j:(j+7)) = idct2(F_inv_quant(i:(i+7), j:(j+7)));
  endfor
endfor

%10
f_uint8 = uint8(min(max(idct_array,0),255));

%11
MSE = sum(sum((double(f)-double(f_uint8)).^2))/(row*column);
PSNR = 10*log10(255^2/MSE)

figure;
imagesc(f_uint8);
colormap(gray);
title("Reconstructed image");


