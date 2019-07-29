%% Implement HRead in matlab version
clc; clear all; close all;


fid=fopen('C:\Users\Admin\Downloads\for_virendra\for_virendra\in_wav_file.txt','r');
fid_mfcc=fopen('C:\Users\Admin\Downloads\for_virendra\for_virendra\out_mfcc_file.txt','r');
fid_prof=fopen('C:\Users\Admin\Downloads\for_virendra\for_virendra\pros_feats_file.txt','r');

for i=1:2195;
   
   tline=fgetl(fid);
   tline1=fgetl(fid_mfcc);
   tline2=fgetl(fid_prof);
   
   if ~ischar(tline),break,end;
   [ado,fs]=audioread(tline);
   ado=ado(:,1);
   ado=ado./max(abs(ado));
   [ml,f]=MFCC(ado,fs,'z0Mp',12,23,20e-3*fs,10e-3*fs,0,0.5,0.97);
   zeroth_ml=ml(:,1);ml=ml(:,2:13); t=1:1:12;T=repmat(1*(t),size(ml,1),1);ml=T.*ml;ml=[12*zeroth_ml ml];
   PROm = dlmread(tline2);
   disp(PROm);
   Pros = PROm(1:f,[3,4,5,6]);
   disp(Pros)
   %Pros =transpose(test);
   %disp(Pros);
   TMFCCs = transpose(ml);
   MFPro = [TMFCCs Pros];
   TMFPro = transpose(MFPro);
   writehtk(tline1,TMFPro,0.010,8198);
end

fclose(fid);
fclose(fid_mfcc);
fclose(fid_prof);
