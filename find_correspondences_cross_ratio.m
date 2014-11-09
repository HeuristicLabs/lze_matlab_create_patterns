
% Given binary images img1 and img2,
% 
% returns matrix C, same size as img1, which gives for each pixel in img1
% the pixel coords of the corresponding point in img2
function C = find_correspondences_cross_ratio(img1,img2)
    assert( all(size(img1)==size(img2)) );
    assert( ndims(img1) == 2 );
    assert( ndims(img2) == 2 );
    assert( all( img1(:)==0 | img1(:)==1 ) );
    assert( all( img2(:)==0 | img2(:)==1 ) );
    
    [F,X,Y] = im2surface(img);
    [nr,nc] = size(img1);
    
    % first, build the cross-ratio look-up table
    
    XR = nan(nr,nc);
    JJJ = nan(nr,nc,4);
    for ii=1:nr
        idxs = find(img1(ii,:));
        for kk=1:length(idxs)-3 % the k'th point in this line
            jj = idxs(kk); % coord
            subset_idxs = idxs(kk:kk+3);
            X_subset = X(ii,subset_idxs);
            Y_subset = Y(ii,subset_idxs);
            JJJ(ii,jj,:) = subset_idxs;
            XR(ii,jj) = cross_ratio([X_subset;Y_subset]');
        end
    end
    
    XR_lookup = XR(XR>0);
    JJJ_lookup = JJJ(repmat(XR,[1,1,4])>0);
    % hist(XR(XR>0),100) % viz

    % compute cross-ratios in second image, performing look-up
    XR2 = nan(nr,nc);
    JJJ2 = nan(nr,nc,4);
    [nr,nc] = size(img2);
    for ii=1:nr
        idxs = find(img2(ii,:));
        for kk=1:length(idxs)-3 % the k'th point in this line
            jj = idxs(kk); % coord
            subset_idxs = idxs(kk:kk+3);
            X_subset = X(ii,subset_idxs);
            Y_subset = Y(ii,subset_idxs);
            JJJ2(ii,jj,:) = subset_idxs;
            XR2(ii,jj) = cross_ratio([X_subset;Y_subset]');
        end
    end

    XR_lookup2 = XR2(XR2>0);
    JJJ_lookup2 = JJJ2(repmat(XR2,[1,1,4])>0);

    % perform lookup within each row

    dispImg = nan(size(img1));
    C = nan(size(img1));
    [nr,nc] = size(img2);
    for ii=1:nr
        % compute all-pairs distance
        % TODO: replace by knnsearch or radsearch
        M1 = repmat(XR(ii,:),[size(XR2,2),1]);
        M2 = repmat(XR2(ii,:),[size(XR,2),1])';
        D = abs(M1-M2); % all pairs distance matrix    
        [minVals,minIdxs] = min(D);
        %figure(32); plot(sort(D(~isnan(D)))); % viz, for sanity
        %figure(83); plot(sort(minVals)); % viz, for sanity
        % TODO: plot entropy, or ratio of best hit to next best hit, or something
        validInd = ~isnan(minVals);
        C(ii,validInd) = minIdxs(validInd);
        assert( all( ~isnan(XR(ii,validInd)) ) ); % sanity
        assert( all( ~isnan(XR2(ii,minIdxs(validInd))) ) ); % sanity
        dispImg(ii,validInd) = X(ii,minIdxs(validInd)) - X(ii,validInd);
    end
    
    figure(21); imagesc(dispImg); % viz
        
end