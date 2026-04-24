%% eigenvalue
 [lambda1,lambda2,lambda3]= eigenmag(element);
%% Nss,INVARIANTS
[mu,phi,I1,I2,I]=Nss (lambda1,lambda2,lambda3);
 ZI = griddata(X,Y,mu,x1,y1);
 FF=[x1, y1,ZI,tmi, igrf,(tmi-igrf)];
 xlswrite('nss_grd10_up20.xlsx', FF);
xf = linspace(min(x), max(x), 4*numel(x));
yf = linspace(min(y), max(y), 4*numel(y));
[Xf,Yf] = meshgrid(xf,yf);
muf = interp2(X,Y,mu,Xf,Yf,'cubic');
%% Derivatives of Inavraints,Lambda and Nss
[I1x,I1y, I2x, I2y]=divI (I1, I2 ,deltax, deltay);
[I1z,I2z]=divIz(element,deltax,deltay);
[Divlamz]=divlam(lambda1,lambda2,lambda3,I1,I1x,I1y,I1z,I2x,I2y,I2z);
[Divmu]=divmu(lambda1,lambda2,lambda3,mu,Divlamz);
mux=Divmu.mux;
muy=Divmu.muy;
muz=Divmu.muz;
muAbs = abs(mu(:)); muAbs = muAbs(isfinite(muAbs));
fprintf('mu: min=%g | median=%g | max=%g\n', min(muAbs), median(muAbs), max(muAbs));
[n1,n2]=max(mu);
%[n3,n4]=min(mu);
disp(n1);
disp(n2);
