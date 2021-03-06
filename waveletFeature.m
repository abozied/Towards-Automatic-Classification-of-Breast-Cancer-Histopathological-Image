function [Features] = waveletFeature(image)

%================ prepare image  ==========================================
imgGray = double(rgb2gray(image))/255;
%===============================CLBP=======================================
%mapping=getmapping(8,'ri');%(8,'u2')%(8,'riu2'); 
%[CLBP_SH,CLBP_MH]=clbp(image,1,8,mapping,'h'); %CLBP histogram in (8,1) neighborhood
%CLBP_Feature =[CLBP_SH CLBP_MH];
%======================= Apply Wavelet Transform===========================
wname = 'sym4';
[CA,CH,CV,CD] = dwt2(imgGray,wname,'mode','per');
mapping=getmapping(8,'u2');%(8,'ri')%(8,'u2')%(8,'riu2'); 
[CLBP_SHA,CLBP_MHA]=clbp(CA,1,8,mapping,'h'); %CLBP histogram in (8,1) neighborhood
mapping=getmapping(8,'u2');%(8,'ri')%(8,'u2')%(8,'riu2'); 
[CLBP_SHH,CLBP_MHH]=clbp(CH,1,8,mapping,'h'); %CLBP histogram in (8,1) neighborhood
mapping=getmapping(8,'u2');%(8,'ri')%(8,'u2')%(8,'riu2'); 
[CLBP_SHV,CLBP_MHV]=clbp(CV,1,8,mapping,'h'); %CLBP histogram in (8,1) neighborhood
mapping=getmapping(8,'u2');%(8,'ri')%(8,'u2')%(8,'riu2'); 
[CLBP_SHD,CLBP_MHD]=clbp(CD,1,8,mapping,'h'); %CLBP histogram in (8,1) neighborhood
WavletFeature=[CLBP_SHA CLBP_MHA CLBP_SHH CLBP_MHH CLBP_SHV CLBP_MHV CLBP_SHD CLBP_MHD];
%======================= ApplyGabor Transform==============================
%wavelength = 4;
%orientation = 90;
%[mag1,phase1] = imgaborfilt(imgGray,wavelength,orientation);
wavelength = 4;
orientation =100;
[mag2,phase2] = imgaborfilt(imgGray,wavelength,orientation);
%mapping=getmapping(8,'u2');
%[CLBP_SHGp1,CLBP_MHGp1]=clbp(phase1,1,8,mapping,'h');    %CLBP histogram in (8,1) neighborhood
%[CLBP_SHGm1,CLBP_MHGm1]=clbp(mag1,1,8,mapping,'h');    %CLBP histogram in (8,1) neighborhood
mapping=getmapping(8,'u2');
[CLBP_SHGp2,CLBP_MHGp2]=clbp(phase2,1,8,mapping,'h');    %CLBP histogram in (8,1) neighborhood
[CLBP_SHGm2,CLBP_MHGm2]=clbp(mag2,1,8,mapping,'h');    %CLBP histogram in (8,1) neighborhood
GaborFeature=[CLBP_SHGm2 CLBP_MHGm2 CLBP_SHGp2 CLBP_MHGp2];
%================= Combined All Features ==================================
%Features =[CLBP_SHA CLBP_MHA CLBP_SHH CLBP_MHH CLBP_SHV CLBP_MHV CLBP_SHD CLBP_MHD CLBP_SHGp CLBP_MHGp CLBP_SHGm CLBP_MHGm];
%Features =[CLBP_SHA CLBP_MHA CLBP_SHH CLBP_MHH CLBP_SHV CLBP_MHV CLBP_SHD CLBP_MHD CLBP_SHGm2,CLBP_MHGm2 CLBP_SHGp2 CLBP_MHGp2];
%=================================================================================================================

%=======================  SVD Features ====================================
Segma = (double(svds(imgGray,200)))' ;
%==========================================================================

%======================= Extract All features  ============================
%Features =[CLBP_Feature WavletFeature GaborFeature Segma];
Features =[WavletFeature GaborFeature Segma];
end





%==========================================================================
%==========================================================================
%Display the vertical detail image and the lowpass approximation.
%subplot(221)
%imagesc(CA); title('Approximation Image');
%colormap gray;
%subplot(222)
%imagesc(CV); title('Vertical Detail Image');
%colormap gray;
%subplot(223)
%imagesc(CH); title('Horizontal Detail Image');
%colormap gray;
%subplot(224)
%imagesc(CD); title('Diagonal Detail Image');
%colormap gray;
%mapping=getmapping(8,'u2');%(8,'ri')%(8,'u2')%(8,'riu2'); 
%[CLBP_SH,CLBP_MH]=clbp(CA,1,8,mapping,'h'); %CLBP histogram in (8,1) neighborhood
