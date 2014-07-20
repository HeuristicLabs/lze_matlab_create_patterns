function gen_random_patterns(outpath,N)

    height = 848;
    width = 480;
    p = 0.25; % proportion of pixels to be "on"

    for i=1:N
        img = uint8(255*( rand(height,width,3) < p )); % binary image for each color, converted to uint8 RGB
        outfilename = fullfile(outpath,sprintf('pattern%02d.png',i));
        imwrite(img,outfilename);
        fprintf('Wrote %s\n', outfilename);
    end

end