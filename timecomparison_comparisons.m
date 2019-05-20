clear all; clc;close all

load Persons

for j = 1 : 1
    
    clf;close all
    f = Person(j).f;
    acc_data = Person(j).acc_data;
    
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
    
    %     % % take only one value
    %     prefatigue = MVC_idx(8);
    
    % 30 percent MVC
    % Fatiguing
    
    fatiguing = MVC_idx(round(length(MVC_idx)/2):round(length(MVC_idx)/2)+5);
    
    % Fatigued
    postfatigue = MVC_idx(end-7:end-4);
    
    %     % % take only one value
    %     postfatigue = MVC_idx(end-7);
    
    % Posture Condition plots
    for i = 1 : length (PC_idx)
        
        [pks , locs] = findpeaks(acc_data{PC_idx(i)});
        rms_peaks_PC(i) = rms(pks);
        
    end
    
    
    
    % Resting condition plots
    for i = 1 : length (RC_idx)
        
        [pks , locs] = findpeaks(acc_data{RC_idx(i)});
        rms_peaks_RC(i) = rms(pks);
        
    end
    
    % Loaded posture condition plots
    for i = 1 : length (LPC_idx) 
        
        [pks , locs] = findpeaks(acc_data{LPC_idx(i)});
        rms_peaks_LPC(i) = rms(pks);
        
    end
    
    % preMVC condition plots
    for i = 1 : length (preMVC_idx)
        
        [pks , locs] = findpeaks(acc_data{preMVC_idx(i)});
        rms_peaks_preMVC(i) = rms(pks);
        
    end
    
    % postMVC condition plots
    for i = 1 : length (postMVC_idx) 
        
        [pks , locs] = findpeaks(acc_data{postMVC_idx(i)});
        rms_peaks_postMVC(i) = rms(pks);
        
    end
    
    % Pre Fatigue plots
    for i = 1 : length (prefatigue)
        
        [pks , locs] = findpeaks(acc_data{prefatigue(i)});
        rms_peaks_prefatigue(i) = rms(pks);
        
    end
    
    % During Fatigue plots
    for i = 1 : length (fatiguing)
        
        [pks , locs] = findpeaks(acc_data{fatiguing(i)});
        rms_peaks_fatiguing(i) = rms(pks);
        
    end
    
    
    % Post Fatigue plots
    for i = 1 : length (postfatigue)
        
        [pks , locs] = findpeaks(acc_data{postfatigue(i)});
        rms_peaks_postfatigue(i) = rms(pks);
        
    end
    
    RMS_peaks(j).PC = rms_peaks_PC;
    RMS_peaks(j).RC = rms_peaks_RC;
    RMS_peaks(j).LPC = rms_peaks_LPC;
    RMS_peaks(j).preMVC = rms_peaks_preMVC;
    RMS_peaks(j).postMVC = rms_peaks_postMVC;
    RMS_peaks(j).prefatigue = rms_peaks_prefatigue;
    RMS_peaks(j).fatiguing = rms_peaks_fatiguing;
    RMS_peaks(j).postfatigue = rms_peaks_postfatigue;
    
end

table_rms = struct2table(RMS_peaks);
% matfile = sprintf('%s','RMS_peaks');
% 
% save(matfile, 'RMS_peaks')

% 
% % % Post-fatigue
% % % Post-fatigue
% color = jet(15);
% postfatigue = table_rms.postfatigue;
% for n = 1:15
%     plot(postfatigue(n,:), '--s', 'MarkerSize', 7.5,...
%         'MarkerFaceColor', color(n, :),...
%         'MarkerEdgeColor','black');
%     hold on
%     Legend{n}=strcat('Person ', num2str(n));
% end
% box on; grid on
% ax = gca;
% set(gcf,'Color','white'); % Set background color to white
% set (gca,'FontName','times new roman') % Set axes fonts to Times New Roman
% ax.XTick = [1,2,3,4];
% ax.XTickLabel = {'0','1','5','10'};
% % ylim([0 20])
% xlabel('Minutes after exhaustion')
% ylabel('RMS value (a.u.)')
% title('Wrist - RMS values  - Post Fatigue')
% %axP = get(gca,'Position');
% legend(Legend,'Location','NorthEastOutside')
% % set(gca, 'Position', axP)
% save_file = sprintf('%s','wrist_Post-Fatigue-rms_values');
% print(gcf,save_file,'-dpng','-r1200');
% 
% figure(2)
% % % Females
% females = [1 2 4 5 9 10 11];
% N = length(females);
% color = jet(N);
% postfatigue = table_rms.postfatigue;
% female_postfatigue = postfatigue(females,:);
% for n = 1:N
%     plot(female_postfatigue(n,:), '--s', 'MarkerSize', 7.5,...
%         'MarkerFaceColor', color(n, :),...
%         'MarkerEdgeColor','black');
%     hold on
% end
% box on; grid on
% ax = gca;
% set(gcf,'Color','white'); % Set background color to white
% set (gca,'FontName','times new roman') % Set axes fonts to Times New Roman
% ax.XTick = [1,2,3,4];
% ax.XTickLabel = {'0','1','5','10'};
% % ylim([4 25])
% xlabel('Minutes after exhaustion')
% ylabel('RMS value (a.u.)')
% title('Wrist - Females - RMS values  - Post Fatigue')
% % %axP = get(gca,'Position');
% % legend(Legend,'Location','NorthEastOutside')
% % % set(gca, 'Position', axP)
% save_file = sprintf('%s','wrist_Females-Post-Fatigue-rms_values');
% print(gcf,save_file,'-dpng','-r1200');
% 
% 
% figure(3)
% % % Females
% males = [3 6 7 8 13:15];
% N = length(females);
% color = jet(N);
% postfatigue = table_rms.postfatigue;
% male_postfatigue = postfatigue(males,:);
% 
% for n = 1:length(male_postfatigue)
%     plot(male_postfatigue(n,:), '--s', 'MarkerSize', 7.5,...
%         'MarkerFaceColor', color(n, :),...
%         'MarkerEdgeColor','black');
%     hold on
% end
% box on; grid on
% ax = gca;
% set(gcf,'Color','white'); % Set background color to white
% set (gca,'FontName','times new roman') % Set axes fonts to Times New Roman
% ax.XTick = [1,2,3,4];
% ax.XTickLabel = {'0','1','5','10'};
% % ylim([1 12])
% xlabel('Minutes after exhaustion')
% ylabel('RMS value (a.u.)')
% title('Wrist - Males - RMS values  - Post Fatigue')
% % %axP = get(gca,'Position');
% % legend(Legend,'Location','NorthEastOutside')
% % % set(gca, 'Position', axP)
% save_file = sprintf('%s','wrist_Males-Post-Fatigue-rms_values');
% print(gcf,save_file,'-dpng','-r1200');
% 
% 
% % % % Pre - Fatigue
% figure(4)
% color = jet(15);
% prefatigue = table_rms.prefatigue;
% for n = 1:15
%     plot(prefatigue(n,:), '--s', 'MarkerSize', 7.5,...
%         'MarkerFaceColor', color(n, :),...
%         'MarkerEdgeColor','black');
%     hold on
% end
% box on; grid on
% ax = gca;
% set(gcf,'Color','white'); % Set background color to white
% set (gca,'FontName','times new roman') % Set axes fonts to Times New Roman
% ax.XTick = [1,2,3,4,5];
% ax.XTickLabel = {'$0.5$','$1$','1.5','2','2.5'};
% ax.TickLabelInterpreter = 'latex';
% % ylim([0 20])
% xlabel('Minutes into Fatigue test')
% ylabel('RMS value (a.u.)')
% title('Wrist - RMS values  - Pre Fatigue')
% %axP = get(gca,'Position');
% legend(Legend,'Location','NorthEastOutside')
% % set(gca, 'Position', axP)
% save_file = sprintf('%s','wrist_Pre-Fatigue-rms_values');
% print(gcf,save_file,'-dpng','-r1200');
% 
% 
% 
% % % % During - Fatigue
% figure(5)
% color = jet(15);
% fatiguing = table_rms.fatiguing;
% for n = 1:15
%     plot(fatiguing(n,:), '--s', 'MarkerSize', 7.5,...
%         'MarkerFaceColor', color(n, :),...
%         'MarkerEdgeColor','black');
%     hold on
% end
% box on; grid on
% ax = gca;
% set(gcf,'Color','white'); % Set background color to white
% set (gca,'FontName','times new roman') % Set axes fonts to Times New Roman
% ax.XTick = [1,2,3,4,5,6];
% ax.XTickLabel = {'3','3.5','4','4.5','5','5.5'};
% ax.TickLabelInterpreter = 'latex';
% % ylim([0 31])
% xlabel('Minutes into Fatigue test')
% ylabel('RMS value (a.u.)')
% title('Wrist - RMS values  - During Fatigue')
% %axP = get(gca,'Position');
% legend(Legend,'Location','NorthEastOutside')
% % set(gca, 'Position', axP)
% save_file = sprintf('%s','wrist_During-Fatigue-rms_values');
% print(gcf,save_file,'-dpng','-r1200');
% 
% 
% % % % RC
% figure(6)
% color = jet(15);
% RC = table_rms.RC;
% for yy = 11 : 15
%     RC{yy}(6) = [];
% end
% RC = cell2mat(RC);
% for n = 1:15
%     plot(RC(n,:), '--s', 'MarkerSize', 7.5,...
%         'MarkerFaceColor', color(n, :),...
%         'MarkerEdgeColor','black');
%     hold on
% end
% box on; grid on
% ax = gca;
% set(gcf,'Color','white'); % Set background color to white
% set (gca,'FontName','times new roman') % Set axes fonts to Times New Roman
% ax.XTick = [1,2,3,4,5];
% ax.XTickLabel = {'Pre-RC','Post-RC-0 min','Post-RC-1 min','Post-RC- 5 min','Post-RC- 10 min'};
% ax.TickLabelInterpreter = 'latex';
% ax.XTickLabelRotation = 270;
% % ylim([0 31])
% % xlabel('Minutes into Fatigue test')
% ylabel('RMS value (a.u.)')
% title('Wrist - RMS values  - RC')
% %axP = get(gca,'Position');
% legend(Legend,'Location','NorthEastOutside')
% % set(gca, 'Position', axP)
% save_file = sprintf('%s','wrist_RC-rms_values');
% print(gcf,save_file,'-dpng','-r1200');
% 
% % % % PC
% figure(7)
% color = jet(15);
% PC = table_rms.PC;
% for yy = 11 : 15
%     PC{yy}(6) = [];
% end
% PC = cell2mat(PC);
% for n = 1:15
%     plot(PC(n,:), '--s', 'MarkerSize', 7.5,...
%         'MarkerFaceColor', color(n, :),...
%         'MarkerEdgeColor','black');
%     hold on
% end
% box on; grid on
% ax = gca;
% set(gcf,'Color','white'); % Set background color to white
% set (gca,'FontName','times new roman') % Set axes fonts to Times New Roman
% ax.XTick = [1,2,3,4,5];
% ax.XTickLabel = {'Pre-PC','Post-PC-0 min','Post-PC-1 min','Post-PC- 5 min','Post-PC- 10 min'};
% ax.TickLabelInterpreter = 'latex';
% ax.XTickLabelRotation = 270;
% % ylim([0 31])
% % xlabel('Minutes into Fatigue test')
% ylabel('RMS value (a.u.)')
% title('Wrist - RMS values  - PC')
% % %axP = get(gca,'Position');
% legend(Legend,'Location','NorthEastOutside')
% %% set(gca, 'Position', axP)
% save_file = sprintf('%s','wrist_PC-rms_values');
% print(gcf,save_file,'-dpng','-r1200');
% 
% % % % LPC
% figure(8)
% color = jet(15);
% LPC = table_rms.LPC;
% for n = 1:15
%     plot(LPC(n,:), '--s', 'MarkerSize', 7.5,...
%         'MarkerFaceColor', color(n, :),...
%         'MarkerEdgeColor','black');
%     hold on
% end
% box on; grid on
% ax = gca;
% set(gcf,'Color','white'); % Set background color to white
% set (gca,'FontName','times new roman') % Set axes fonts to Times New Roman
% ax.XTick = [1,2,3,4,5];
% ax.XTickLabel = {'Pre-LPC','Post-LPC-0 min','Post-LPC-1 min','Post-LPC- 5 min','Post-LPC- 10 min'};
% ax.TickLabelInterpreter = 'latex';
% ax.XTickLabelRotation = 270;
% % ylim([0 31])
% % xlabel('Minutes into Fatigue test')
% ylabel('RMS value (a.u.)')
% title('Wrist - RMS values  - LPC')
% %axP = get(gca,'Position');
% legend(Legend,'Location','NorthEastOutside')
% % set(gca, 'Position', axP)
% save_file = sprintf('%s','wrist_LPC-rms_values');
% print(gcf,save_file,'-dpng','-r1200');
% 
% 
% % % % Actions together
% figure(9)
% color = jet(15);
% h = {PC ; RC; LPC};
% 
% aboxplot(h,'labels',[-1,0,1,5,10]);
% box on; grid on
% ax = gca;
% set(gcf,'Color','white'); % Set background color to white
% set (gca,'FontName','times new roman') % Set axes fonts to Times New Roman
% ax.XTick = [1,2,3,4,5];
% ax.XTickLabel = {'Pre-','Post- 0 min','Post - 1 min','Post- 5 min','Post- 10 min'};
% ax.TickLabelInterpreter = 'latex';
% ax.XTickLabelRotation = 270;
% ylim([0 4])
% % xlabel('Minutes')
% ylabel('RMS value (a.u.)')
% %axP = get(gca,'Position');
% legend('Post. Cond.','Rest Cond.','Loaded Post. Cond.'); % Add a legend
% % set(gca, 'Position', axP)
% save_file = sprintf('%s','wrist_boxplot_actions-rms_values');
% print(gcf,save_file,'-dpng','-r1200');
% 
% 
% 
