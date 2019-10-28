load classletters

imagesc(class1)
figure()
imagesc([class1 class2 class3 test])

%%
p1 = 0.8;
p2 = 0.15;
p3 = 0.05;
eps = 0.4;

%%
diff1 = class1-test;
diff2 = class2-test;
diff3 = class3-test;

diff1_right = length(find(diff1 == 0));
diff2_right = length(find(diff2 == 0));
diff3_right = length(find(diff3 == 0));

diff1_wrong = length(find(diff1 == 1)) + length(find(diff1 == -1));
diff2_wrong = length(find(diff2 == 1)) + length(find(diff2 == -1));
diff3_wrong = length(find(diff3 == 1)) + length(find(diff3 == -1));

format long g
map1 = eps^diff1_wrong*(1-eps)^diff1_right
map2 = eps^diff2_wrong*(1-eps)^diff2_right
map3 = eps^diff3_wrong*(1-eps)^diff3_right

%%
d3r = diff1_right - diff3_right;
d3w = diff1_wrong - diff3_wrong;

m3 = eps^d3w*(1-eps)^d3r;

