P_1 = [3 2 1 0; 2 2 3 0; 2 2 2 -1];
R1 = P_1(:,1:3);
t1 = P_1(:,4);

P_2 = [2 4 3 3; 1 2 0 -2; 1 1 3 0];
R2 = P_2(:,1:3);
t2 = P_2(:,4);

F = [-3 3 6; 6 -31 9; -8 -42 58];

a_1 = [1 2 0];
a_2 = [16 10 0];
a_3 = [4 2 0];

b_1 = [1 1 0];
b_2 = [3 2 0];
b_3 = [3 -2 0];

a1r = R1*a_1' + t1;
a2r = R1*a_2' + t1;
a3r = R1*a_3' + t1;

b1r = R2*b_1' + t2;
b2r = R2*b_2' + t2;
b3r = R2*b_3' + t2;

a1r'*F*b1r
a1r'*F*b2r
a1r'*F*b3r

a2r'*F*b1r
a2r'*F*b2r
a2r'*F*b3r

a3r'*F*b1r
a3r'*F*b2r
a3r'*F*b3r
