clf; clear all;close all;clc; 

load Persons

event_label = Person(1).event_label;

% Collect Posture Condition events
posture_idx = find(event_label == 5);

% Get acc data of posture condition
PC_acc_data = Person(1).acc_data{1,posture_idx};

% Length in terms of samples
L_posture = Person(1).idx_length{1,posture_idx};

% Compute FFT
fft_PC_acc = fft(PC_acc_data);

% We only need one-sided FFT
fft_PC_acc = abs(fft_PC_acc/L_posture);
f_z = fft_PC_acc(1:fix(L_posture/2)+1);
f_z(2:end-1) = 2*f_z(2:end-1);

% Get the sampling frequency
Fs = Person(1).event_Fs{1,posture_idx};

% Finally store
fft_PC_acc = f_z;

% Get the frequency right
f1 = (0:L_posture/2)*Fs/L_posture;

% Plot FFT of posture condition
h = plot(f1,fft_PC_acc);
hold on


%%
% Collect Posture Condition events
fat_posture_idx = find(event_label == 7);

% Length in terms of samples
L_pf_posture = {Person(1).idx_length{1,fat_posture_idx}};

% Get the sampling frequency
Fs_pf_posture = {Person(1).event_Fs{1,fat_posture_idx}};


% Get acc data of post-fatigue posture condition
PF_PC_acc_data = {Person(1).acc_data{1,fat_posture_idx}};


for i = 1 : length(PF_PC_acc_data)
    
    L = cell2mat(L_pf_posture(i));
    Fs = cell2mat(Fs_pf_posture(i));
    % Compute FFT
    fft_fp_pc_acc = fft(cell2mat(PF_PC_acc_data(i)));
    
    % We only need one-sided FFT
    fft_fp_pc_acc = abs(fft_fp_pc_acc/L);
    f_z = fft_fp_pc_acc(1:fix(L/2)+1);
    f_z(2:end-1) = 2*f_z(2:end-1);
    
    % Finally store
    fft_FP_PC_acc{i} = f_z;
    
    % Get the frequency right
    f{i} = (0:L/2)*Fs/L;
    
    d(i) =plot(f{i},fft_FP_PC_acc{i});
    
    
end

    xlabel('Frequency (Hz)','interpreter','latex');
    
    ylabel('fft(acc_data)','interpreter','latex'); % Add a legend
    
%     Set the axes right since some have a very high DC value
    ylim([0 .5])
    xlim([0 25])
    
    ax = gca;
    set(gcf,'Color','white'); % Set background color to white
    legend([h d(1) d(2) d(3) d(4)], 'PC', 'FPC-1','FPC-2','FPC-3','FPC-4')
    set (gca,'FontName','times new roman') % Set axes fonts to Times New Roman
%     save_file = sprintf('%s_%d','Person',i);
%     title(save_file ,'interpreter','latex')
%     print(gcf,save_file,'-dpng','-r900');
