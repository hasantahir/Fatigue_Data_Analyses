clear all; clc;close all

load Persons_3Hz_filter
% load Persons_2019_no_filter

for j = setdiff( 1 : size(Person,2), [4 6 7 11 13]) %3% 1 : size(Person,2)
    
    clf;close all
    f = Person(j).f;
    acc_data = Person(j).acc_data;
    
    % Get the labels of the events
    labels = Person(j).event_label;
    
    % Get the time duration, sampling frequency and index length of each
    % interval
    time_length = Person(j).event_length;
    idx_length = Person(j).idx_length;
    event_Fs = Person(j).event_Fs;
    
    
    % % Posture Condition
    PC_labels = [5 ,7];
    c = ismember(labels, PC_labels);
    PC_event_Fs = event_Fs(c);
    PC_idx_length = idx_length(c);
    PC_time_length = time_length(c);
    
    % Extract indices of PC labels.
    PC_idx = find(c);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % % Resting Condition
    
    % Get the time duration, sampling frequency and index length of each
    % interval
    RC_labels = [3 ,6];
    c = ismember(labels, RC_labels);
    
    % Extract indices of rest condition labels.
    RC_idx = find(c);
    RC_event_Fs = event_Fs(RC_idx);
    RC_idx_length = idx_length(RC_idx);
    RC_time_length = time_length(RC_idx);
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % % Loaded Posture condition
    % Find index of loaded posture condition
    LPC_labels = [2 ,4];
    c = ismember(labels, LPC_labels);
    
    
    % Extract indices of LPC labels.
    LPC_idx = find(c);
    
    % first and last four labels are LPC
    LPC_idx = LPC_idx([1 end-3:end]);
    
    LPC_event_Fs = event_Fs(LPC_idx);
    LPC_idx_length = idx_length(LPC_idx);
    LPC_time_length = time_length(LPC_idx);
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % % MVC
    % Find index of MVC
    MVC_labels = 1;
    c = ismember(labels, MVC_labels);
    MVC_event_Fs = event_Fs(c);
    MVC_idx_length = idx_length(c);
    MVC_time_length = time_length(c);
    
    
    % Extract indices of MVC labels.
    MVC_idx = find(c);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % % pre-MVC
    
    % % only first three are pre-MVC
    preMVC_idx = MVC_idx(1:3);
    preMVC_event_Fs = MVC_event_Fs(1:3);
    preMVC_idx_length = MVC_idx_length(1:3);
    preMVC_time_length = MVC_time_length(1:3);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % % post-MVC
    
    % % only last four are post-MVC
    postMVC_idx = MVC_idx(end-3:end);
    postMVC_event_Fs = MVC_event_Fs(end-3:end);
    postMVC_idx_length = MVC_idx_length(end-3:end);
    postMVC_time_length = MVC_time_length(end-3:end);
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % % First 4 during the fatigue test (30% MVC)
    % 30 percent MVC
    % Non fatigued
    
    prefatigue_idx = MVC_idx(5:9);
    prefatigue_event_Fs = MVC_event_Fs(5:9);
    prefatigue_idx_length = MVC_idx_length(5:9);
    prefatigue_time_length = MVC_time_length(5:9);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % % Middle 4 during the fatigue test (30% MVC)
    % 30 percent MVC
    % Fatiguing
    
    mid_idx = round(length(MVC_idx)/2):round(length(MVC_idx)/2)+5;
    fatiguing_idx = MVC_idx(mid_idx);
    fatiguing_event_Fs = MVC_event_Fs(mid_idx);
    fatiguing_idx_length = MVC_idx_length(mid_idx);
    fatiguing_time_length = MVC_time_length(mid_idx);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % % Last 4 during the fatigue test (30% MVC)
    % 30 percent MVC
    
    lastfatigue_idx = MVC_idx(end-7:end-4);
    lastfatigue_event_Fs = MVC_event_Fs(end-7:end-4);
    lastfatigue_idx_length = MVC_idx_length(end-7:end-4);
    lastfatigue_time_length = MVC_time_length(end-7:end-4);
    
    
    % Posture Condition
    for i = 1 : length (PC_idx)
        
        % Take only 15 sec of each PC episode
        Fs = cell2mat(PC_event_Fs(i));
        
        T = 13; % PC event is only 15 sec long
        L = fix(T*Fs);
        
        all_PC = acc_data{PC_idx(i)};
        
        % Correct PC interval
        if L > length(all_PC)
            
            PC{i} = all_PC;
        else
            PC{i} = all_PC(1 : L);
        end
        
        % Take FFT
        fft_PC = fft(PC{i});
        
        % We only need one-sided FFT
        fft_PC = abs(fft_PC/L);
        f_z = fft_PC(1:fix(L/2)+1);
        f_z(2:end-1) = 2*f_z(2:end-1);
        
        
        % Store FFT of each event
        ft_PC{i} = f_z;
        
        % Get the frequency right
        f{i} = (0:L/2)*Fs/L;
        
        % Get PSD
        [psd_welch{i}, fwelch{i}] = pwelch(PC{i},[],[],[], Fs);
        
        % Get the indices of frequency between 8 - 14 Hz
        f_vec = (fwelch{i});
        idx = (find(f_vec >= 8 & f_vec <= 14));
        
        % Find area under the PSD curve
        psd = (psd_welch{i});
        psd_auc = trapz(psd);
        ept_auc = trapz(psd(idx));
        
        ept_PC(i) = ept_auc/psd_auc; % Percentage power in physiological tremor region
        
        
        % Find the peaks in the RMS value
        [pks , locs] = findpeaks(PC{i});
        rms_peaks_PC(i) = rms(pks);
        
        % Find the max. frequency content
        [pks , locs] = findpeaks(ft_PC{i}, f{i});
        freq_rms_peaks_PC(i) = rms(pks);
        freq_loc_peaks_PC(i) = locs(pks == max(pks));
        
        % Find the max. PSD content
        [pks , locs] = findpeaks(psd_welch{i}, fwelch{i});
        psd_rms_peaks_PC(i) = rms(pks);
        psd_loc_peaks_PC(i) = locs(pks == max(pks));
        
        temp = locs(pks == max(pks));
        psd_loc_peaks_PC(i) = temp(1);
        
    end
    
    
    PosCon.episode = PC;
    PosCon.fft = ft_PC;
    PosCon.f = f;
    PosCon.rms_peak = rms_peaks_PC;
    PosCon.freq_peak = freq_loc_peaks_PC;
    PosCon.psd = psd_welch;
    PosCon.fwelch = fwelch;
    PosCon.psd_peak = psd_loc_peaks_PC;
    PosCon.psd_auc = psd_auc;
    PosCon.ept_auc = ept_auc;
    PosCon.ept = ept_PC;
    
    
    
    % Rest Condition
    for i = 1 : length (RC_idx)
        
        % Take only 15 sec of each PC episode
        Fs = cell2mat(RC_event_Fs(i));
        
        T = 13; % PC event is only 15 sec long
        L = fix(T*Fs);
        
        all_RC = acc_data{RC_idx(i)};
        
        % Correct RC interval
        if L > length(all_RC)
            
            RC{i} = all_RC;
        else
            RC{i} = all_RC(1 : L);
        end
        
        % Take FFT
        fft_RC = fft(RC{i});
        
        % We only need one-sided FFT
        fft_RC = abs(fft_RC/L);
        f_z = fft_RC(1:fix(L/2)+1);
        f_z(2:end-1) = 2*f_z(2:end-1);
        
        % Store FFT of each event
        ft_RC{i} = f_z;
        
        % Get the frequency right
        f{i} = (0:L/2)*Fs/L;
        
        % Get PSD
        [psd_welch{i}, fwelch{i}] = pwelch(RC{i},[],[],[], Fs);
        
        
        % Get the indices of frequency between 8 - 14 Hz
        f_vec = (fwelch{i});
        idx = (find(f_vec >= 8 & f_vec <= 14));
        
        % Find area under the PSD curve
        psd = (psd_welch{i});
        psd_auc = trapz(psd);
        ept_auc = trapz(psd(idx));
        
        ept_RC(i) = ept_auc/psd_auc;
        
        [pks, locs] = findpeaks(RC{i});
        rms_peaks_RC(i) = rms(pks);
        
        [pks , locs] = findpeaks(ft_RC{i}, f{i});
        freq_rms_peaks_RC(i) = rms(pks);
        temp = locs(pks == max(pks));
        freq_loc_peaks_RC(i) = temp(1);
        
        % Find the max. PSD content
        [pks , locs] = findpeaks(psd_welch{i}, fwelch{i});
        psd_rms_peaks_RC(i) = rms(pks);
        psd_loc_peaks_RC(i) = locs(pks == max(pks));
        
    end
    
    
    ResCon.episode = RC;
    ResCon.fft = ft_RC;
    ResCon.f = f;
    ResCon.rms_peak = rms_peaks_RC;
    ResCon.freq_peak = freq_loc_peaks_RC;
    ResCon.psd = psd_welch;
    ResCon.fwelch = fwelch;
    ResCon.psd_peak = psd_loc_peaks_RC;
    ResCon.psd_auc = psd_auc;
    ResCon.ept_auc = ept_auc;
    ResCon.ept = ept_RC;
    
    
    % Loaded Posture Condition
    for i = 1 : length (LPC_idx)
        
        % Take only 15 sec of each PC episode
        Fs = cell2mat(LPC_event_Fs(i));
        
        if j == 14
            T = 6;
        else
            T = 15; % PC event is only 13 sec long
        end
        
        L = fix(T*Fs);
        
        all_LPC = acc_data{LPC_idx(i)};
        
        % Correct PC interval
        LPC{i} = all_LPC(1 : L);
        
        % Take FFT
        fft_LPC = fft(LPC{i});
        
        % We only need one-sided FFT
        fft_LPC = abs(fft_LPC/L);
        f_z = fft_LPC(1:fix(L/2)+1);
        f_z(2:end-1) = 2*f_z(2:end-1);
        
        
        % Store FFT of each event
        ft_LPC{i} = f_z;
        
        % Get the frequency right
        f{i} = (0:L/2)*Fs/L;
        
        % Get PSD
        [psd_welch{i}, fwelch{i}] = pwelch(LPC{i},[],[],[], Fs);
        
        % Get the indices of frequency between 8 - 14 Hz
        f_vec = (fwelch{i});
        idx = (find(f_vec >= 8 & f_vec <= 14));
        
        % Find area under the PSD curve
        psd = (psd_welch{i});
        psd_auc = trapz(psd);
        ept_auc = trapz(psd(idx));
        
        ept_LPC(i) = ept_auc/psd_auc;
        
        
        [pks , locs] = findpeaks(LPC{i});
        rms_peaks_LPC(i) = rms(pks);
        
        [pks , locs] = findpeaks(ft_LPC{i}, f{i});
        freq_rms_peaks_LPC(i) = rms(pks);
        freq_loc_peaks_LPC(i) = locs(pks == max(pks));
        
        % Find the max. PSD content
        [pks , locs] = findpeaks(psd_welch{i}, fwelch{i});
        psd_rms_peaks_LPC(i) = rms(pks);
        psd_loc_peaks_LPC(i) = locs(pks == max(pks));
        
    end
    
    
    LoaPosCon.episode = LPC;
    LoaPosCon.fft = ft_LPC;
    LoaPosCon.f = f;
    LoaPosCon.rms_peak = rms_peaks_LPC;
    LoaPosCon.freq_peak = freq_loc_peaks_LPC;
    LoaPosCon.psd = psd_welch;
    LoaPosCon.fwelch = fwelch;
    LoaPosCon.psd_peak = psd_loc_peaks_LPC;
    LoaPosCon.psd_auc = psd_auc;
    LoaPosCon.ept_auc = ept_auc;
    LoaPosCon.ept = ept_LPC;
    
    
    % pre-MVC Condition
    for i = 1 : length (preMVC_idx)
        
        % Take only 13 sec of each PC episode
        Fs = cell2mat(preMVC_event_Fs(i));
        
        T = 5; % PC event is only 13 sec long
        L = fix(T*Fs);
        
        all_preMVC = acc_data{preMVC_idx(i)};
        
        % Correct PC interval
        preMVC{i} = all_preMVC(1 : L);
        
        % Take FFT
        fft_preMVC = fft(preMVC{i});
        
        % We only need one-sided FFT
        fft_preMVC = abs(fft_preMVC/L);
        f_z = fft_preMVC(1:fix(L/2)+1);
        f_z(2:end-1) = 2*f_z(2:end-1);
        
        
        % Store FFT of each event
        ft_preMVC{i} = f_z;
        
        % Get the frequency right
        f{i} = (0:L/2)*Fs/L;
        
        % Get PSD
        [psd_welch{i}, fwelch{i}] = pwelch(preMVC{i},[],[],[], Fs);
        
        % Get the indices of frequency between 8 - 14 Hz
        f_vec = (fwelch{i});
        idx = (find(f_vec >= 8 & f_vec <= 14));
        
        % Find area under the PSD curve
        psd = (psd_welch{i});
        psd_auc = trapz(psd);
        ept_auc = trapz(psd(idx));
        
        ept_preMVC(i) = ept_auc/psd_auc;
        
        [pks , locs] = findpeaks(preMVC{i});
        rms_peaks_preMVC(i) = rms(pks);
        
        [pks , locs] = findpeaks(ft_preMVC{i}, f{i});
        freq_rms_peaks_preMVC(i) = rms(pks);
        freq_loc_peaks_preMVC(i) = locs(pks == max(pks));
        
        % Find the max. PSD content
        [pks , locs] = findpeaks(psd_welch{i}, fwelch{i});
        psd_rms_peaks_preMVC(i) = rms(pks);
        psd_loc_peaks_preMVC(i) = locs(pks == max(pks));
        
    end
    
    
    pre_MVC.episode = preMVC;
    pre_MVC.fft = ft_preMVC;
    pre_MVC.f = f;
    pre_MVC.rms_peak = rms_peaks_preMVC;
    pre_MVC.freq_peak = freq_loc_peaks_preMVC;
    pre_MVC.psd = psd_welch;
    pre_MVC.fwelch = fwelch;
    pre_MVC.psd_peak = psd_loc_peaks_preMVC;
    pre_MVC.psd_auc = psd_auc;
    pre_MVC.ept_auc = ept_auc;
    pre_MVC.ept = ept_preMVC;
    
    % post-MVC Condition
    for i = 1 : length (postMVC_idx)
        
        % Take only 13 sec of each PC episode
        Fs = cell2mat(postMVC_event_Fs(i));
        
        T = 5; % PC event is only 13 sec long
        L = fix(T*Fs);
        
        all_postMVC = acc_data{postMVC_idx(i)};
        
        % Correct PC interval
        postMVC{i} = all_postMVC(1 : L);
        
        % Take FFT
        fft_postMVC = fft(postMVC{i});
        
        % We only need one-sided FFT
        fft_postMVC = abs(fft_postMVC/L);
        f_z = fft_postMVC(1:fix(L/2)+1);
        f_z(2:end-1) = 2*f_z(2:end-1);
        
        
        % Store FFT of each event
        ft_postMVC{i} = f_z;
        
        % Get the frequency right
        f{i} = (0:L/2)*Fs/L;
        
        % Get PSD
        [psd_welch{i}, fwelch{i}] = pwelch(postMVC{i},[],[],[], Fs);
        
        % Get the indices of frequency between 8 - 14 Hz
        f_vec = (fwelch{i});
        idx = (find(f_vec >= 8 & f_vec <= 14));
        
        % Find area under the PSD curve
        psd = (psd_welch{i});
        psd_auc = trapz(psd);
        ept_auc = trapz(psd(idx));
        
        ept_postMVC(i) = ept_auc/psd_auc;
        
        [pks , locs] = findpeaks(postMVC{i});
        rms_peaks_postMVC(i) = rms(pks);
        
        [pks , locs] = findpeaks(ft_postMVC{i}, f{i});
        freq_rms_peaks_postMVC(i) = rms(pks);
        freq_loc_peaks_postMVC(i) = locs(pks == max(pks));
        
        % Find the max. PSD content
        [pks , locs] = findpeaks(psd_welch{i}, fwelch{i});
        psd_rms_peaks_postMVC(i) = rms(pks);
        psd_loc_peaks_postMVC(i) = locs(pks == max(pks));
        
    end
    
    
              
    post_MVC.episode = postMVC;
    post_MVC.fft = ft_postMVC;
    post_MVC.f = f;
    post_MVC.rms_peak = rms_peaks_postMVC;
    post_MVC.freq_peak = freq_loc_peaks_postMVC;
    post_MVC.psd = psd_welch;
    post_MVC.fwelch = fwelch;
    post_MVC.psd_peak = psd_loc_peaks_postMVC;
    post_MVC.psd_auc = psd_auc;
    post_MVC.ept_auc = ept_auc;
    post_MVC.ept = ept_postMVC;
    
    
    % pre-fatigue Condition
    for i = 1 : length (prefatigue_idx)
        
        % Take only 13 sec of each PC episode
        Fs = cell2mat(prefatigue_event_Fs(i));
        
        T = 15; % PC event is only 13 sec long
        L = fix(T*Fs);
        
        all_prefatigue = acc_data{prefatigue_idx(i)};
        
        % Correct PC interval
        prefatigue{i} = all_prefatigue(1 : L);
        
        % Take FFT
        fft_prefatigue = fft(prefatigue{i});
        
        % We only need one-sided FFT
        fft_prefatigue = abs(fft_prefatigue/L);
        f_z = fft_prefatigue(1:fix(L/2)+1);
        f_z(2:end-1) = 2*f_z(2:end-1);
        
        
        % Get PSD
        [psd_welch{i}, fwelch{i}] = pwelch(prefatigue{i},[],[],[], Fs);
        
        % Get the indices of frequency between 8 - 14 Hz
        f_vec = (fwelch{i});
        idx = (find(f_vec >= 8 & f_vec <= 14));
        
        % Find area under the PSD curve
        psd = (psd_welch{i});
        psd_auc = trapz(psd);
        ept_auc = trapz(psd(idx));
        
        ept_prefatigue(i) = ept_auc/psd_auc;
        
        % Store FFT of each event
        ft_prefatigue{i} = f_z;
        
        % Get the frequency right
        f{i} = (0:L/2)*Fs/L;
        
        [pks , locs] = findpeaks(prefatigue{i});
        rms_peaks_prefatigue(i) = rms(pks);
        
        [pks , locs] = findpeaks(ft_prefatigue{i}, f{i});
        freq_rms_peaks_prefatigue(i) = rms(pks);
        freq_loc_peaks_prefatigue(i) = locs(pks == max(pks));
        
        % Find the max. PSD content
        [pks , locs] = findpeaks(psd_welch{i}, fwelch{i});
        psd_rms_peaks_prefatigue(i) = rms(pks);
        psd_loc_peaks_prefatigue(i) = locs(pks == max(pks));
        
    end
    
 
    
    pre_fatigue.episode = prefatigue;
    pre_fatigue.fft = ft_prefatigue;
    pre_fatigue.f = f;
    pre_fatigue.rms_peak = rms_peaks_prefatigue;
    pre_fatigue.freq_peak = freq_loc_peaks_prefatigue;
    pre_fatigue.psd = psd_welch;
    pre_fatigue.fwelch = fwelch;
    pre_fatigue.psd_peak = psd_loc_peaks_prefatigue;
    pre_fatigue.psd_auc = psd_auc;
    pre_fatigue.ept_auc = ept_auc;
    pre_fatigue.ept = ept_prefatigue;
    
    
    % Mid-fatigue Condition
    for i = 1 : length (fatiguing_idx)
        
        % Take only 13 sec of each PC episode
        Fs = cell2mat(fatiguing_event_Fs(i));
        
        T = 15; % PC event is only 13 sec long
        L = fix(T*Fs);
        
        all_fatiguing = acc_data{fatiguing_idx(i)};
        
        % Correct PC interval
        fatiguing{i} = all_fatiguing(1 : L);
        
        % Take FFT
        fft_fatiguing = fft(fatiguing{i});
        
        % We only need one-sided FFT
        fft_fatiguing = abs(fft_fatiguing/L);
        f_z = fft_fatiguing(1:fix(L/2)+1);
        f_z(2:end-1) = 2*f_z(2:end-1);
        
        % Get PSD
        [psd_welch{i}, fwelch{i}] = pwelch(fatiguing{i},[],[],[], Fs);
        
        % Get the indices of frequency between 8 - 14 Hz
        f_vec = (fwelch{i});
        idx = (find(f_vec >= 8 & f_vec <= 14));
        
        % Find area under the PSD curve
        psd = (psd_welch{i});
        psd_auc = trapz(psd);
        ept_auc = trapz(psd(idx));
        
        ept_midfatigue(i) = ept_auc/psd_auc;
        
        % Store FFT of each event
        ft_fatiguing{i} = f_z;
        
        % Get the frequency right
        f{i} = (0:L/2)*Fs/L;
        
        [pks , locs] = findpeaks(fatiguing{i});
        rms_peaks_fatiguing(i) = rms(pks);
        
        [pks , locs] = findpeaks(ft_fatiguing{i}, f{i});
        freq_rms_peaks_fatiguing(i) = rms(pks);
        freq_loc_peaks_fatiguing(i) = locs(pks == max(pks));
        
        % Find the max. PSD content
        [pks , locs] = findpeaks(psd_welch{i}, fwelch{i});
        psd_rms_peaks_fatiguing(i) = rms(pks);
        psd_loc_peaks_fatiguing(i) = locs(pks == max(pks));
        
    end
    
    mid_fatigue.episode = fatiguing;
    mid_fatigue.fft = ft_fatiguing;
    mid_fatigue.f = f;
    mid_fatigue.rms_peak = rms_peaks_fatiguing;
    mid_fatigue.freq_peak = freq_loc_peaks_fatiguing;
    mid_fatigue.psd = psd_welch;
    mid_fatigue.fwelch = fwelch;
    mid_fatigue.psd_peak = psd_loc_peaks_fatiguing;
    mid_fatigue.psd_auc = psd_auc;
    mid_fatigue.ept_auc = ept_auc;
    mid_fatigue.ept = ept_midfatigue;
    
    
    
    
    % Last-fatigue Condition
    for i = 1 : length (lastfatigue_idx)- 1
        
        % Take only 13 sec of each PC episode
        Fs = cell2mat(lastfatigue_event_Fs(i));
        
        T = 5; % PC event is only 13 sec long
        L = fix(T*Fs);
        
        all_lastfatigue = acc_data{lastfatigue_idx(i)};
        
        % Correct PC interval
        lastfatigue{i} = all_lastfatigue(1 : L);
        
        % Take FFT
        fft_lastfatigue = fft(lastfatigue{i});
        
        % We only need one-sided FFT
        fft_lastfatigue = abs(fft_lastfatigue/L);
        f_z = fft_lastfatigue(1:fix(L/2)+1);
        f_z(2:end-1) = 2*f_z(2:end-1);
        
        
        % Store FFT of each event
        ft_lastfatigue{i} = f_z;
        
        % Get the frequency right
        f{i} = (0:L/2)*Fs/L;
        
        % Get PSD
        [psd_welch{i}, fwelch{i}] = pwelch(lastfatigue{i},[],[],[], Fs);
        
        % Get the indices of frequency between 8 - 14 Hz
        f_vec = (fwelch{i});
        idx = (find(f_vec >= 8 & f_vec <= 14));
        
        % Find area under the PSD curve
        psd = (psd_welch{i});
        psd_auc = trapz(psd);
        ept_auc = trapz(psd(idx));
        
        ept_postfatigue(i) = ept_auc/psd_auc;
        
        [pks , locs] = findpeaks(lastfatigue{i});
        rms_peaks_lastfatigue(i) = rms(pks);
        
        [pks , locs] = findpeaks(ft_lastfatigue{i}, f{i});
        freq_rms_peaks_lastfatigue(i) = rms(pks);
        freq_loc_peaks_lastfatigue(i) = locs(pks == max(pks));
        
        % Find the max. PSD content
        [pks , locs] = findpeaks(psd_welch{i}, fwelch{i});
        psd_rms_peaks_lastfatigue(i) = rms(pks);
        psd_loc_peaks_lastfatigue(i) = locs(pks == max(pks));
        
    end
    
    last_fatigue.episode = lastfatigue;
    last_fatigue.fft = ft_lastfatigue;
    last_fatigue.f = f;
    last_fatigue.rms_peak = rms_peaks_lastfatigue;
    last_fatigue.freq_peak = freq_loc_peaks_lastfatigue;
    last_fatigue.psd = psd_welch;
    last_fatigue.fwelch = fwelch;
    last_fatigue.psd_peak = psd_loc_peaks_lastfatigue;
    last_fatigue.psd_auc = psd_auc;
    last_fatigue.ept_auc = ept_auc;
    last_fatigue.ept = ept_postfatigue;
    
    Wrist_stats(j).PC = PosCon;
    Wrist_stats(j).RC = ResCon;
    Wrist_stats(j).LPC = LoaPosCon;
    Wrist_stats(j).preMVC = pre_MVC;
    Wrist_stats(j).postMVC = post_MVC;
    Wrist_stats(j).prefatigue = pre_fatigue;
    Wrist_stats(j).fatiguing = mid_fatigue;
    Wrist_stats(j).postfatigue = last_fatigue;
    
    clearvars -except Wrist_stats j Person
    
end

% matfile = sprintf('%s','wrist_results');
% matfile = sprintf('%s','wrist_results_10_14');
% matfile = sprintf('%s','wrist_results_3_8_no_filter_fatigued');
matfile = sprintf('%s','wrist_results_8_14_no_filter_fatigued');
% matfile = sprintf('%s','wrist_results_14_22_no_filter_fatigued');
% matfile = sprintf('%s','wrist_results_12_14');
% matfile = sprintf('%s','wrist_results_n0_filter');
%
save(matfile, 'Wrist_stats')

table_stats = struct2table(Wrist_stats);

