clear all; close all;clc

matfile = sprintf('%s','wrist_results_10_14');

%
load(matfile, 'Wrist_stats')

table_stats = struct2table(Wrist_stats);



% % Posture Condition
color = jet(15);
PC = table_stats.PC;
for n = setdiff( 1 : 15, [4 7])
    plot(100*PC{n}.ept, '--s', 'MarkerSize', 7.5,...
        'MarkerFaceColor', color(n, :),...
        'MarkerEdgeColor','black');
    hold on
end
for i = 1 : 15
    Legend{i}=strcat('Person ', num2str(i));
end
box on; grid on
ax = gca;
set(gcf,'Color','white'); % Set background color to white
set (gca,'FontName','times new roman') % Set axes fonts to Times New Roman
ax.XTick = [1,2,3,4,5];
ax.XTickLabel = {'Pre-','0 min','1 min','5 min','10 min'};
ax.XTickLabelRotation = 270;
% ylim([0 10])
xlim([1 5])
% xlabel('Minutes after exhaustion')
ylabel('PSD %')
title('Wrist - PSD Distribution in 10-14 Hz  - Posture Condition')
%axP = get(gca,'Position');
legend(Legend,'Location','NorthEastOutside')
% set(gca, 'Position', axP)
save_file = sprintf('%s','wrist_Posture_condition-psd_auc_10_14');
print(gcf,save_file,'-dpng','-r1200');
%


figure(2)
% % Rest Condition
color = jet(15);
RC = table_stats.RC;
for n = setdiff( 1 : 15, [4 7])
    plot(100*RC{n}.ept, '--s', 'MarkerSize', 7.5,...
        'MarkerFaceColor', color(n, :),...
        'MarkerEdgeColor','black');
    hold on
end
for i = 1 : 15
    Legend{i} = strcat('Person ', num2str(i));
end
box on; grid on
ax = gca;
set(gcf,'Color','white'); % Set background color to white
set (gca,'FontName','times new roman') % Set axes fonts to Times New Roman
ax.XTick = [1,2,3,4,5];
ax.XTickLabel = {'Pre-','0 min','1 min','5 min','10 min'};
ax.XTickLabelRotation = 270;
% ylim([0 10])
xlim([1 5])
% xlabel('Minutes after exhaustion')
ylabel('PSD %')
title('Wrist - PSD Distribution in 10-14 Hz  - Rest Condition')
%axP = get(gca,'Position');
legend(Legend,'Location','NorthEastOutside')
% set(gca, 'Position', axP)
save_file = sprintf('%s','wrist_Rest_condition-psd_auc_10_14');
print(gcf,save_file,'-dpng','-r1200');


figure(3)
% % Loaded  Posture Condition
color = jet(15);
LPC = table_stats.LPC;
for n = setdiff( 1 : 15, [4 7])
    plot(100*LPC{n}.ept, '--s', 'MarkerSize', 7.5,...
        'MarkerFaceColor', color(n, :),...
        'MarkerEdgeColor','black');
    hold on
end
for i = 1 : 15
    Legend{i} = strcat('Person ', num2str(i));
end
box on; grid on
ax = gca;
set(gcf,'Color','white'); % Set background color to white
set (gca,'FontName','times new roman') % Set axes fonts to Times New Roman
ax.XTick = [1,2,3,4,5];
ax.XTickLabel = {'Pre-','0 min','1 min','5 min','10 min'};
ax.XTickLabelRotation = 270;
% ylim([0 4])
xlim([1 5])
% xlabel('Minutes after exhaustion')
ylabel('PSD %')
title('Wrist - PSD Distribution in 10-14 Hz  - Loaded Posture Condition')
%axP = get(gca,'Position');
legend(Legend,'Location','NorthEastOutside')
% set(gca, 'Position', axP)
save_file = sprintf('%s','wrist_LPC-psd_auc_10_14');
print(gcf,save_file,'-dpng','-r1200');


figure(4)
% % PRE MVC
color = jet(15);
pre_MVC = table_stats.preMVC;
preMVC_cat = [];
for n = setdiff( 1 : 15, [4 7])
    plot(100*pre_MVC{n}.ept, '--s', 'MarkerSize', 7.5,...
        'MarkerFaceColor', color(n, :),...
        'MarkerEdgeColor','black');
    hold on
    preMVC_cat = horzcat(preMVC_cat, pre_MVC{n}.ept);
end
% preMVC_cat = transpose(reshape(preMVC_cat, 3, 13));

for i = 1 : 15
    Legend{i} = strcat('Person ', num2str(i));
end
box on; grid on
ax = gca;
set(gcf,'Color','white'); % Set background color to white
set (gca,'FontName','times new roman') % Set axes fonts to Times New Roman
ax.XTick = [1,2,3];
ax.XTickLabel = {'Pre-1','Pre-2','Pre-3'};
ax.XTickLabelRotation = 270;
% ylim([0 4])
xlim([1 3])
% xlabel('Minutes after exhaustion')
ylabel('PSD %')
title('Wrist - PSD Distribution in 10-14 Hz  - Pre MVC')
%axP = get(gca,'Position');
legend(Legend,'Location','NorthEastOutside')
% set(gca, 'Position', axP)
save_file = sprintf('%s','wrist_preMVC-psd_auc_10_14');
print(gcf,save_file,'-dpng','-r1200');




figure(5)
% % POST MVC
color = jet(15);
post_MVC = table_stats.postMVC;
postMVC_cat = [];
for n = setdiff( 1 : 15, [4 7])
    plot(100*post_MVC{n}.ept, '--s', 'MarkerSize', 7.5,...
        'MarkerFaceColor', color(n, :),...
        'MarkerEdgeColor','black');
    postMVC_cat = horzcat(postMVC_cat, post_MVC{n}.ept);
    hold on
end
% postMVC_cat = transpose(reshape(postMVC_cat, 4, 13));
for i = 1 : 15
    Legend{i} = strcat('Person ', num2str(i));
end
box on; grid on
ax = gca;
set(gcf,'Color','white'); % Set background color to white
set (gca,'FontName','times new roman') % Set axes fonts to Times New Roman
ax.XTick = [1,2,3,4];
ax.XTickLabel = {'0 min','1 min','5 min', '10 min'};
ax.XTickLabelRotation = 270;
% ylim([0 4])
xlim([1 4])
% xlabel('Minutes after exhaustion')
ylabel('PSD %')
title('Wrist - PSD Distribution in 10-14 Hz  - Post MVC')
%axP = get(gca,'Position');
legend(Legend,'Location','NorthEastOutside')
% set(gca, 'Position', axP)
save_file = sprintf('%s','wrist_postMVC-psd_auc_10_14');
print(gcf,save_file,'-dpng','-r1200');



% figure(6)
% % % Pre and Post Together MVC
% color = jet(15);
% CAT = [preMVC_cat, postMVC_cat];
% for n = 1 : 13
%     plot(100*CAT(n,:), '--s', 'MarkerSize', 7.5,...
%         'MarkerFaceColor', color(n, :),...
%         'MarkerEdgeColor','black');
%     hold on
%     Legend{n} = strcat('Person ', num2str(n));
% end
% 
% box on; grid on
% ax = gca;
% set(gcf,'Color','white'); % Set background color to white
% set (gca,'FontName','times new roman') % Set axes fonts to Times New Roman
% ax.XTick = [1,2,3,4,5,6,7];
% ax.XTickLabel = {'Pre-1','Pre-2','Pre-3','Post - 0 min','Post - 1 min','Post - 5 min', 'Post - 10 min'};
% ax.XTickLabelRotation = 270;
% % ylim([0 20])
% xlim([1 7])
% % xlabel('Minutes after exhaustion')
% ylabel('PSD %')
% title('Wrist - PSD Distribution in 10-14 Hz  - Pre and Post MVC')
% %axP = get(gca,'Position');
% legend(Legend,'Location','NorthEastOutside')
% % set(gca, 'Position', axP)
% save_file = sprintf('%s','wrist_pre_and_postMVC-psd_auc');
% print(gcf,save_file,'-dpng','-r1200');


figure(7)
% % First and last four during the fatigue test
color = jet(15);
first = table_stats.prefatigue;
last = table_stats.postfatigue;
for n = setdiff( 1 : 15, [4 7])
    first1 = first{n}.ept;
    last1 = last{n}.ept;
    fatigue = horzcat(first1, last1);
    plot(100*fatigue, '--s', 'MarkerSize', 7.5,...
        'MarkerFaceColor', color(n, :),...
        'MarkerEdgeColor','black');
    hold on
end
for n = 1 : 13
    Legend{n} = strcat('Person ', num2str(n));
end

box on; grid on
ax = gca;
set(gcf,'Color','white'); % Set background color to white
set (gca,'FontName','times new roman') % Set axes fonts to Times New Roman
ax.XTick = [1,2,3,4,5,6,7,8];
ax.XTickLabel = {'Pre - 1','Pre - 2','Pre - 3','Pre - 4','Post - 1','Post - 2','Post - 3','Post - 4'};
ax.XTickLabelRotation = 270;
% ylim([0 12])
xlim([1 8])
% xlabel('Minutes after exhaustion')
ylabel('PSD %')
title('Wrist - PSD Distribution in 10-14 Hz  - First and last four 30 % MVC')
%axP = get(gca,'Position');
legend(Legend,'Location','NorthEastOutside')
% set(gca, 'Position', axP)
save_file = sprintf('%s','wrist_first_and_last_30_MVC-psd_auc_10_14');
print(gcf,save_file,'-dpng','-r1200');
