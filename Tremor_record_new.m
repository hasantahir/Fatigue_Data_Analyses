clc;clear;clf;close all

for i = 1 : 15
    % Create a String for the person
    
    disp('----------------------------------------')
    [i]
    matfile = sprintf('%s_%d%s','Person',i,'.xlsx');
    
    % Read the XLSX file for the person
    A = xlsread(matfile);
    
    % Get time
    t = days(A(:,1));
    t.Format = 'hh:mm:ss';
    
    seconds_t = seconds(t);
    
    markers = A(:,1);
    % size(find (markers == markers1));
    
    % Get accelerometer data
    acc.x = A(:,2);
    acc.y = A(:,3);
    acc.z = A(:,4);
    
    % Since the data is not uniform over all axes, convert to polar
    ACC = sqrt((acc.x).^2 + (acc.y ).^2 + (acc.z ).^2);
    
%     ACC = bandpass(ACC,[3 20],43); % no filter 
     ACC = bandpass(ACC,[6 20],43);
    
    % Get the event markers
    events = A(:,8);
    
    % Replace all NaNs with zeroes
    events(isnan(events)) = 0;
    
    % Find the location of all non-zero events
    idx = find(events);
    
    event_markers = events(idx);
    
    % This gives the timestamps of the events
    timestamp = t(idx);
    
    
    
    
    % This portion is just used to plot the raw data in time
    fs = 44;  % obtained from the number of samples in one second
    Ts = 1/fs; % sampling period on ts
    
    t1 = 1/fs:1/fs:length(ACC)/fs;
    
    %     figure(1)
    
    
%     plot(t1/60, acc.x)
%     hold on
%     plot(t1/60, acc.y)
%     plot(t1/60, acc.z)
    
    %     figure(i)
    %% Get the frequency content of each interval of time corresponding to
    % events
    for j = 1 : length(idx)-1 % we start from 2 as first is garbage
        
        % task stores all the events
        task{j} = idx(j):idx(j+1)-1;
        
        % The following lines compute the length of each event interval in
        % seconds as well as number of samples
        
        % Get the duration of each interval in minutes first
        event_length = seconds(t(idx(j+1)) - t(idx(j)));
        second_length = (t(j+1) - t(j));
        
        % Get a double value of duration in seconds
        interval_length{j} = event_length;
        
        ss = ACC(seconds_t >= seconds(timestamp(j+1)) & seconds_t <= seconds(timestamp(j+1)) + 15);
        
        % Get the acclerometer data of each episode
        acc_episode{j} = ACC(task{j});
        
        % Length in terms of samples
        L{j} = length(acc_episode{j});
        
        % Get the sampling frequency
        Fs{j} = L{j}/interval_length{j};
        
        % Compute FFT
        ft_acc = fft(acc_episode{j});
        
        % This may be used later if PSD required
        PSD_acc{j} = ft_acc.*conj(ft_acc)/L{j};
        
        % We only need one-sided FFT
        ft_acc = abs(ft_acc/L{j});
        f_z = ft_acc(1:fix(L{j}/2)+1);
        f_z(2:end-1) = 2*f_z(2:end-1);
        
        
        
        % Store FFT of each event
        ft_ACC{j} = f_z;
        
        % Get the frequency right
        f{j} = (0:L{j}/2)*Fs{j}/L{j};
        
        % Plot all events, for now there are ~77
                plot(f{j},ft_ACC{j}./max(abs(ft_ACC{j})))
        %
        %
        %
        %         hold on
    end
    
    Person(i).timestamps = timestamp;
    Person(i).event_label = event_markers; %name of each predictor
    Person(i).event_length = interval_length;
    Person(i).event_Fs = Fs;
    Person(i).idx_length = L;
    Person(i).acc_data = acc_episode;
    Person(i).ft_acc = ft_ACC;
    Person(i).f = f;
    
    %     Person.timestamps = timestamp;
    %     Person.event_label = event_markers; %name of each predictor
    %     Person.event_length = interval_length;
    %     Person.event_Fs = Fs;
    %     Person.idx_length = L;
    %     Person.acc_data = acc_episode;
    %     Person.ft_acc = ft_ACC;
    %     Person.f = f;
    
    clear task interval_length acc_episode f Fs L PSD_acc ft_ACC
    
    
    %     xlabel('Frequency (Hz)','interpreter','latex');
    %
    %     ylabel('fft(acc_data)','interpreter','latex'); % Add a legend
    %
    % %     Set the axes right since some have a very high DC value
    %     ylim([0 .5])
    %     xlim([0 25])
    %
    %     ax = gca;
    %     set(gcf,'Color','white'); % Set background color to white
    %
    %     set (gca,'FontName','times new roman') % Set axes fonts to Times New Roman
    %     save_file = sprintf('%s_%d','Person',i);
    %     title(save_file ,'interpreter','latex')
    %     print(gcf,save_file,'-dpng','-r900');
    
    
    
    %     clear Person
end

% matfile = sprintf('%s','Persons_2019_no_filter');
matfile = sprintf('%s','Persons_2019');
% 
save(matfile, 'Person')

