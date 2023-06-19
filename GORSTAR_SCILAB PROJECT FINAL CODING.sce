//Full coding of Scilab Project (MKEL1233 : ADVANCED IMAGE PROCESSING)
//Group: GORSTAR
//The original image that we are using to tested our program is consist of two images;
//Image A = zebra image on land ("Image A.jpg")
//Image B = lion image on land ("Image B.jpeg")

clear //clear all the variable (to make the coding run smoothly)
clc // clear all program inside the console

//______________________________________________________________________________
//           SECTION 1: Image Enhancement Steps (to focus on the object)
//______________________________________________________________________________


//Step 1: read the image// 
OI = imread ("Image A.jpeg"); 

//Step 2: contrast of the original image//
CI = imadjust(OI,[0.4 .8],[]); 
f1=scf(1);subplot(221);imshow(CI); title("Contrast Image");

//Step 3: Convert image from integer to double precision//
db = im2double(CI); 

//Step 4: adding a noise to the image(Pixel-specific variance (Zero-mean Gaussian))//
imn = imnoise( db(:,:,1), 'localvar', [0:0.55:1], [0:0.55:1].^15); 
f1=scf(1);subplot(222); imshow(imn); title("Noise filter: localvar");

//Step 5: adding a motion blurred filter to the image//
h = fspecial('motion',25,45);
S2 = imfilter(imn,h,'circular');
f1=scf(1);subplot(223); imshow(S2); title("Motion Blurred filter");

//Step 6: adding a 'salt & pepper' noise to the image//
imn2 = imnoise(S2(:,:,1), 'salt & pepper', 0.2);
f1=scf(1);subplot(224); imshow(imn2); title("Salt & Pepper Noise");

//Step 7: adding a median filter (to remove S&P noise)//
S3 = immedian(imn2,85); 
f2=scf(2); subplot(221); imshow(S3); title("Median Filter");

//_____________________________________________________________________________
//        SECTION 2: Image Segmentation Steps & Morphological technique
//______________________________________________________________________________


//Step 8: Using segmented by global thresholding (Otsu's method)//
level= imgraythresh(S3);
c = im2bw(S3,level);
f2=scf(2); subplot(222); imshow(c); title("Thresholded by Otsu Method");

//Step 9: Using morpholgical operations (image gradient technique)//
se = imcreatese('ellipse',13,13);
d = imgradient(c,se);
f2=scf(2); subplot(223); imshow(d); title("Morphological: Gradient");

//Step 10: Using morpholgical operations(Hole filled technique)//
filld = imfill (d);
f2=scf(2); subplot(224); imshow(filld); title("Morphological: Hole Filling");

//Step 11: Labelling the image//
[labelobj,n] = imlabel(filld);
f3=scf();imshow(labelobj,jetcolormap(n));title("Output Image");

//Step 12: Calculate number of object from the labeled image//
[Area,BB,ctr] = imblobprop(labelobj);
imrects(BB,[255,0,0]);


//______________________________________________________________________________
//                              THE END
//          ~ designed by: Nurul Sabrina Razali on 28 Jan 2022 ~
//______________________________________________________________________________


//(final value setting)

//line 26 
//imn = imnoise( db(:,:,1), 'localvar', [0:0.55:1], [0:0.55:1].^15); 

//line 30
//h = fspecial('motion',25,45);

//line 35 
//imn2 = imnoise(S2(:,:,1), 'salt & pepper', 0.2);

//line 39
//S3 = immedian(imn2,85); 

//line 53
//se = imcreatese('ellipse',13,13);
//d = imgradient(c,se);
