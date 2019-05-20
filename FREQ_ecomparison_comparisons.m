clear all; clc;close all

load Persons

for j = 1 : size(Person,2) 
    
    clf;close all
    f = Person(j).f;
    ft_acc = Person(j).ft_acc;
    
    % Find index of posture condition
    labels = Person(j).event_label;
    
    
    % % Posture Condition
    PC_labels = [5 ,7];
    c = ismember(labels, PC_labels);
    
    % Extract indices of PC labels.
    PC_idx = find(c);
    
    %     % Keep only first two
    %     PC_idx = PC_idx([1,2]);
    
    
    % % Resting coniditons
    % Find index of resting condition
    RC_labels = [3 ,6];
    c = ismember(labels, RC_labels);
    
    % Extract indices of rest condition labels.
    RC_idx = find(c);
    
    %     % Keep only first two
    %     RC_idx = RC_idx([1,2]);
    
    
    % % Loaded Posture condition
    % Find index of loaded posture condition
    LPC_labels = [2 ,4];
    c = ismember(labels, LPC_labels);
    
    % Extract indices of PC labels.
    LPC_idx = find(c);
    LPC_idx = LPC_idx([1 end-3:end]); % first and last four labels are LPC
    
    %     % Keep the first two
    %     LPC_idx = LPC_idx([1 2]); % first and last four labels are LPC
    %
    
    
    
    % % Pre-MVC
    % Find index of pre-MVC
    preMVC_labels = 1;
    c = ismember(labels, preMVC_labels);
    
    
    % Extract indices of pre-MVC labels.
    MVC_idx = find(c);
    
    % % only first three are pre-MVC
    % % only last three are post-MVC
    preMVC_idx = MVC_idx(1:3);
    postMVC_idx = MVC_idx(end-3:end);
    
    %     % % take only one value of pre-MVC
    %     preMVC_idx = MVC_idx(3);
    %
    %     % % take only one value of post-MVC
    %     postMVC_idx = MVC_idx(end-3);
    
    
    % 30 percent MVC
    % Non fatigued
    prefatigue = MVC_idx(4:8);
    
    
    % 30 percent MVC
    % mid fatigue
    midfatigue = MVC_idx(round(length(MVC_idx)/2):round(length(MVC_idx)/2)+5);
    
    %     % % take only one value
    %     prefatigue = MVC_idx(8);
    
    % Fatigued
    postfatigue = MVC_idx(end-7:end-4);
    
    %     % % take only one value
    %     postfatigue = MVC_idx(end-7);
    
    % Posture Condition plots
    for i = 1 : length (PC_idx)
        
        [pks , locs] = findpeaks(ft_acc{PC_idx(i)}, f{PC_idx(i)});
        rms_peaks_PC(i) = rms(pks);
        loc_peaks_PC(i) = locs(pks == max(pks));
        
    end
    
    
    
    % Resting condition plots
    for i = 1 : length (RC_idx)
        
        [pks , locs] = findpeaks(ft_acc{RC_idx(i)}, f{RC_idx(i)});
        rms_peaks_RC(i) = rms(pks);
        loc_peaks_RC(i) = locs(pks == max(pks));
        
    end
    
    % Loaded posture condition plots
    for i = 1 : length (LPC_idx) 
        
        [pks , locs] = findpeaks(ft_acc{LPC_idx(i)}, f{LPC_idx(i)});
        rms_peaks_LPC(i) = rms(pks);
        loc_peaks_LPC(i) = locs(pks == max(pks));
        
    end
    
    % preMVC condition plots
    for i = 1 : length (preMVC_idx)
        
        [pks , locs] = findpeaks(ft_acc{preMVC_idx(i)}, f{preMVC_idx(i)});
        rms_peaks_preMVC(i) = rms(pks);
        loc_peaks_preMVC(i) = locs(pks == max(pks));
        
    end
    
    % postMVC condition plots
    for i = 1 : length (postMVC_idx) 
        
        [pks , locs] = findpeaks(ft_acc{postMVC_idx(i)}, f{postMVC_idx(i)});
        rms_peaks_postMVC(i) = rms(pks);
        loc_peaks_postMVC(i) = locs(pks == max(pks));
        
    end
    
    % Pre Fatigue plots
    for i = 1 : length (prefatigue)
        
        [pks , locs] = findpeaks(ft_acc{prefatigue(i)}, f{prefatigue(i)});
        rms_peaks_prefatigue(i) = rms(pks);
        loc_peaks_prefatigue(i) = locs(pks == max(pks));
        
    end
    
    % During Fatigue plots
    for i = 1 : length (midfatigue)
        
        [pks , locs] = findpeaks(ft_acc{midfatigue(i)}, f{midfatigue(i)});
        rms_peaks_midfatigue(i) = rms(pks);
        loc_peaks_midfatigue(i) = locs(pks == max(pks));
        
    end
    
    
    % Post Fatigue plots
    for i = 1 : length (postfatigue)
        
        [pks , locs] = findpeaks(ft_acc{postfatigue(i)}, f{postfatigue(i)});
        rms_peaks_postfatigue(i) = rms(pks);
        loc_peaks_postfatigue(i) = locs(pks == max(pks));
        
    end
    
    Freq_peaks(j).PC = rms_peaks_PC;
    Freq_peaks(j).RC = rms_peaks_RC;
    Freq_peaks(j).LPC = rms_peaks_LPC;
    Freq_peaks(j).preMVC = rms_peaks_preMVC;
    Freq_peaks(j).postMVC = rms_peaks_postMVC;
    Freq_peaks(j).prefatigue = rms_peaks_prefatigue;
    Freq_peaks(j).midfatigue = rms_peaks_midfatigue;
    Freq_peaks(j).postfatigue = rms_peaks_postfatigue;
    
    Freq_locs(j).PC = loc_peaks_PC;
    Freq_locs(j).RC = loc_peaks_RC;
    Freq_locs(j).LPC = loc_peaks_LPC;
    Freq_locs(j).preMVC = loc_peaks_preMVC;
    Freq_locs(j).postMVC = loc_peaks_postMVC;
    Freq_locs(j).prefatigue = loc_peaks_prefatigue;
    Freq_locs(j).midfatigue = loc_peaks_midfatigue;
    Freq_locs(j).postfatigue = loc_peaks_postfatigue;
    
end

table_freq_peaks = struct2table(Freq_peaks);
table_freq_locs = struct2table(Freq_locs);

matfile = sprintf('%s','Freq_peaks');
save(matfile, 'Freq_peaks')

matfile = sprintf('%s','Freq_locs');
save(matfile, 'Freq_locs')

% % Post-fatigue
color = jet(15);
postfatigue = table_freq_locs.postfatigue;
for n = 1:15
    plot(postfatigue(n,:), '--o',...
        'MarkerSize', 7.5,...
        'MarkerFaceColor', color(n, :),...
        'MarkerEdgeColor','black');
    hold on
    Legend{n}=strcat('Person', num2str(n));
end


box on; grid on
ax = gca;
set(gcf,'Color','white'); % Set background color to white
set (gca,'FontName','times new roman') % Set axes fonts to Times New Roman
ax.XTick = [1,2,3,4];
ax.XTickLabel = {'0','1','5','10'};
xlabel('Minutes after exhaustion')
ylabel('Frequency Peak (Hz)')
% axP = get(gca,'Position');
legend(Legend,'Location','NorthEastOutside')
% set(gca, 'Position', axP)
title('Wrist -  Freq Peak values  - Post Fatigue')
save_file = sprintf('%s','Post-Fatigue-Freq_peaks');
print(gcf,save_file,'-dpng','-r1200');



% % Pre-fatigue
figure(2)
color = jet(15);
prefatigue = table_freq_locs.prefatigue;
for n = 1:15
    plot(prefatigue(n,:), '--o',...
        'MarkerSize', 7.5,...
        'MarkerFaceColor', color(n, :),...
        'MarkerEdgeColor','black');
    hold on
end
box on; grid on
ax = gca;
set(gcf,'Color','white'); % Set background color to white
set (gca,'FontName','times new roman') % Set axes fonts to Times New Roman
ax.XTick = [1,2,3,4];
ax.XTickLabel = {'0','0.5','1','1.5'};
xlabel('Minutes into fatigue test')
ylabel('Frequency Peak (Hz)')
title('Wrist - Freq Peak values  - Pre Fatigue')
% axP = get(gca,'Position');
legend(Legend,'Location','NorthEastOutside')
% set(gca, 'Position', axP)
save_file = sprintf('%s','Pre-Fatigue-Freq_peaks');
print(gcf,save_file,'-dpng','-r1200');


% % Mid Fatigue
figure(3)
color = jet(15);
midfatigue = table_freq_locs.midfatigue;
for n = 1:15
    plot(midfatigue(n,:), '--o',...
        'MarkerSize', 7.5,...
        'MarkerFaceColor', color(n, :),...
        'MarkerEdgeColor','black');
    hold on
end
box on; grid on
ax = gca;
set(gcf,'Color','white'); % Set background color to white
set (gca,'FontName','times new roman') % Set axes fonts to Times New Roman
ax.XTick = [1,2,3,4,5,6];
ax.XTickLabel = {'0.5','1','1.5','2','2.5','3'};
ax.TickLabelInterpreter = 'latex';
xlabel('Minutes from the middle of the squeeze session')
ylabel('Frequency Peak (Hz)')
title('Wrist - Freq Peak values  - Mid Fatigue')
% axP = get(gca,'Position');
legend(Legend,'Location','NorthEastOutside')
% set(gca, 'Position', axP)
save_file = sprintf('%s','Mid-Fatigue-Freq_peaks');
print(gcf,save_file,'-dpng','-r1200');

% % % RC
figure(4)
color = jet(15);
RC = table_freq_locs.RC;
for yy = 11 : 15
    RC{yy}(6) = [];
end
RC = cell2mat(RC);
for n = 1:15
    plot(RC(n,:), '--o', 'MarkerSize', 7.5,...
        'MarkerFaceColor', color(n, :),...
        'MarkerEdgeColor','black');
    hold on
end
box on; grid on
ax = gca;
set(gcf,'Color','white'); % Set background color to white
set (gca,'FontName','times new roman') % Set axes fonts to Times New Roman
ax.XTick = [1,2,3,4,5];
ax.XTickLabel = {'Pre-RC','Post-RC-0 min','Post-RC-1 min','Post-RC- 5 min','Post-RC- 10 min'};
ax.TickLabelInterpreter = 'latex';
ax.XTickLabelRotation = 270;
% ylim([0 31])
% xlabel('Minutes into Fatigue test')
ylabel('Frequency Peak (Hz)')
title('Wrist - Freq  - RC')
%axP = get(gca,'Position');
legend(Legend,'Location','NorthEastOutside')
% set(gca, 'Position', axP)
save_file = sprintf('%s','wrist_RC-freq_values');
print(gcf,save_file,'-dpng','-r1200');

% % % PC
figure(5)
color = jet(15);
PC = table_freq_locs.PC;
for yy = 11 : 15
    PC{yy}(6) = [];
end
PC = cell2mat(PC);
for n = 1:15
    plot(PC(n,:), '--o', 'MarkerSize', 7.5,...
        'MarkerFaceColor', color(n, :),...
        'MarkerEdgeColor','black');
    hold on
end
box on; grid on
ax = gca;
set(gcf,'Color','white'); % Set background color to white
set (gca,'FontName','times new roman') % Set axes fonts to Times New Roman
ax.XTick = [1,2,3,4,5];
ax.XTickLabel = {'Pre-PC','Post-PC-0 min','Post-PC-1 min','Post-PC- 5 min','Post-PC- 10 min'};
ax.TickLabelInterpreter = 'latex';
ax.XTickLabelRotation = 270;
% ylim([0 31])
ylabel('Frequency Peak (Hz)')
title('Wrist - Freq  - PC')
% %axP = get(gca,'Position');
legend(Legend,'Location','NorthEastOutside')
%% set(gca, 'Position', axP)
save_file = sprintf('%s','wrist_PC-freq_values');
print(gcf,save_file,'-dpng','-r1200');

% % % LPC
figure(6)
color = jet(15);
LPC = table_freq_locs.LPC;
for n = 1:15
    plot(LPC(n,:), '--o', 'MarkerSize', 7.5,...
        'MarkerFaceColor', color(n, :),...
        'MarkerEdgeColor','black');
    hold on
end
box on; grid on
ax = gca;
set(gcf,'Color','white'); % Set background color to white
set (gca,'FontName','times new roman') % Set axes fonts to Times New Roman
ax.XTick = [1,2,3,4,5];
ax.XTickLabel = {'Pre-LPC','Post-LPC-0 min','Post-LPC-1 min','Post-LPC- 5 min','Post-LPC- 10 min'};
ax.TickLabelInterpreter = 'latex';
ax.XTickLabelRotation = 270;
% ylim([0 31])
% xlabel('Minutes into Fatigue test')
ylabel('Frequency Peak (Hz)')
title('Wrist - Freq  - LPC')
%axP = get(gca,'Position');
legend(Legend,'Location','NorthEastOutside')
% set(gca, 'Position', axP)
save_file = sprintf('%s','wrist_LPC-freq_values');
print(gcf,save_file,'-dpng','-r1200');


% % % Actions together
figure(7)
color = jet(15);
% LPC(:,5) = -10;
h = {PC ; RC;LPC};

aboxplot(h,'labels',[-1,0,1,5,10]);
box on; grid on
ax = gca;
set(gcf,'Color','white'); % Set background color to white
set (gca,'FontName','times new roman') % Set axes fonts to Times New Roman
ax.XTick = [1,2,3,4,5];
ax.XTickLabel = {'Pre-','Post- 0 min','Post - 1 min','Post- 5 min','Post- 10 min'};
ax.TickLabelInterpreter = 'latex';
ax.XTickLabelRotation = 270;
ylim([3.5 17])
% xlabel('Minutes')
ylabel('Frequency Peak (Hz)')
%axP = get(gca,'Position');
legend('Post. Cond.','Rest Cond.','Loaded Post. Cond.', 'location','northwest'); % Add a legend
% set(gca, 'Position', axP)
save_file = sprintf('%s','wrist_boxplot_actions-freq_values');
print(gcf,save_file,'-dpng','-r1200');



% % Post-fatigue Boxplot
figure(8)
boxplot(postfatigue)
box on; grid on
ax = gca;
set(gcf,'Color','white'); % Set background color to white
set (gca,'FontName','times new roman') % Set axes fonts to Times New Roman
ax.XTick = [1,2,3,4];
ax.XTickLabel = {'0','1','5','10'};
xlabel('Minutes after exhaustion')
ylabel('Frequency Peak (Hz)')
% axP = get(gca,'Position');
% set(gca, 'Position', axP)
title('Wrist -  Freq Peak values  - Post Fatigue')
save_file = sprintf('%s','wrist_boxplot_Post-Fatigue-Freq_peaks');
print(gcf,save_file,'-dpng','-r1200');



% % Pre-fatigue Boxplot
figure(9)
boxplot(prefatigue)
box on; grid on
ax = gca;
set(gcf,'Color','white'); % Set background color to white
set (gca,'FontName','times new roman') % Set axes fonts to Times New Roman
ax.XTick = [1,2,3,4];
ax.XTickLabel = {'0','0.5','1','1.5'};
xlabel('Minutes into fatigue test')
ylabel('Frequency Peak (Hz)')
% axP = get(gca,'Position');
% set(gca, 'Position', axP)
title('Wrist -  Freq Peak values  - Pre Fatigue')
save_file = sprintf('%s','wrist_boxplot_Pre-Fatigue-Freq_peaks');
print(gcf,save_file,'-dpng','-r1200');


% % Mid Fatigue boxplot
figure(10)
boxplot(midfatigue)
box on; grid on
ax = gca;
set(gcf,'Color','white'); % Set background color to white
set (gca,'FontName','times new roman') % Set axes fonts to Times New Roman
ax.XTick = [1,2,3,4,5,6];
ax.XTickLabel = {'0.5','1','1.5','2','2.5','3'};
xlabel('Minutes into fatigue test')
ylabel('Frequency Peak (Hz)')
% axP = get(gca,'Position');
% set(gca, 'Position', axP)
title('Wrist -  Freq Peak values  - Mid Fatigue')
save_file = sprintf('%s','wrist_boxplot_mid-Fatigue-Freq_peaks');
print(gcf,save_file,'-dpng','-r1200');


