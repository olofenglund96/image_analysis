function [up, r] = face_projection(img, basis)
   up = zeros(size(img));
   for i = 1:size(basis, 3)
    coeff = sum(sum(img .* basis(:,:,i)));
    up = up + coeff*basis(:,:,i);
   end
   
   r = norm(abs(img-up), 'fro');
end