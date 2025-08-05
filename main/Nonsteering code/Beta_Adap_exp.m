% clc;
% clear;
% close all;
% 
% V_max = 10;
% 
% maxiter = 2000;
% k_e  = 10;
% beta = zeros(1*2000);
% x  =1:2000;
% for iter = 1:maxiter
%     beta(iter) = Beta_Adap_exp(iter,maxiter,V_max,k_e);
% end
% figure;
% plot(x, beta);
function beta = Beta_Adap_exp(iter,maxiter,V_max,k_e)
    growth = (exp(k_e * (iter/maxiter)) - 1) / (exp(k_e) - 1);  
    beta = (V_max * ( growth));   
end