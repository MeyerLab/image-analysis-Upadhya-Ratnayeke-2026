function [image_out] = crop_cell(image, cpos ,winrad)
cx = cpos(1);
cy = cpos(2);
[height,width,channels]=size(image);

miny=cy-winrad; maxy=cy+winrad;
minx=cx-winrad; maxx=cx+winrad;
if minx<1
    minx=1; maxx=1+2*winrad;
end
if miny<1
    miny=1; maxy=1+2*winrad;
end
if maxx>width
    maxx=width; minx=width-2*winrad;
end
if maxy>height
    maxy=height; miny=height-2*winrad;
end

image_out=image(miny:maxy,minx:maxx,:);

end

