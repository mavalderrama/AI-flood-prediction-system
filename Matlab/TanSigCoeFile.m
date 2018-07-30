%Tangen Sigmoid ROM Coefficient generator
numBits = 12;
AFWIDTH = 2^numBits;
AFWIDTH2 = 2^(numBits - 1);
fileID = fopen('coe.h','w');
fprintf(fileID,'static ap_fixed<32,16,AP_RND_CONV> coeTanSig[%d] = {',AFWIDTH);

for i=-AFWIDTH2:AFWIDTH2-1
    if i < AFWIDTH2-1
        fprintf(fileID,'%f,\n',tansig(((i*5)/AFWIDTH2)));
    else
        fprintf(fileID,'%f};\n',tansig(((i*5)/AFWIDTH2)));
    end
end
% fprintf(fileID,'\n');
% fprintf(fileID,'static ap_fixed<32,16,AP_RND_CONV> coeLogSig[%d] = {',AFWIDTH);
% 
% for i=-AFWIDTH2:AFWIDTH2-1
%     if i < AFWIDTH2-1
%         fprintf(fileID,'%f,\n',logsig(((i*5)/AFWIDTH2)));
%     else
%         fprintf(fileID,'%f};\n',logsig(((i*5)/AFWIDTH2)));
%     end
% end

fclose(fileID);