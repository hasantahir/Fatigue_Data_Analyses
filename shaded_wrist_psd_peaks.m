clear all; close all;clc

matfile = sprintf('%s','wrist_results');
%
load(matfile, 'Wrist_stats')

table_stats = struct2table(Wrist_stats);


PC = table_stats.PC;
RC = table_stats.RC;
LPC = table_stats.LPC;
preMVC = table_stats.preMVC;
postMVC = table_stats.postMVC;
first = table_stats.prefatigue;
last = table_stats.postfatigue;

PC_cat = [];
RC_cat = [];
LPC_cat = [];
preMVC_cat = [];
postMVC_cat = [];
first_cat = [];
last_cat = [];

for n = setdiff( 1 : 15, [4 7])
    PC_cat = horzcat(PC_cat, PC{n}.psd_peak);
    RC_cat = horzcat(RC_cat, RC{n}.psd_peak);
    LPC_cat = horzcat(LPC_cat, LPC{n}.psd_peak);
    preMVC_cat = horzcat(preMVC_cat, preMVC{n}.psd_peak);
    postMVC_cat = horzcat(postMVC_cat, postMVC{n}.psd_peak);
    first_cat = horzcat(first_cat, first{n}.psd_peak);
    last_cat = horzcat(last_cat, last{n}.psd_peak);
    
end

PC_cat = transpose(reshape(PC_cat, 5, 13));
RC_cat = transpose(reshape(RC_cat, 5, 13));
LPC_cat = transpose(reshape(LPC_cat, 5, 13));
preMVC_cat = transpose(reshape(preMVC_cat, 3, 13));
postMVC_cat = transpose(reshape(postMVC_cat, 4, 13));

first_cat = transpose(reshape(first_cat, 5, 13));
last_cat = transpose(reshape(last_cat, 3, 13));

for i = 1 : 15
    Legend{i}=strcat('Person ', num2str(i));
end


% % Posture condition

figure(1)
%
y=PC_cat; 
x=(1:size(PC_cat,2));

shadedErrorBar(x, y, {@mean,@std}, 'lineprops', '-r')

hold on

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
ylabel('PSD (Hz)')
title('Wrist - PSD Peak  - Posture Condition')
%axP = get(gca,'Position');
% set(gca, 'Position', axP)
save_file = sprintf('%s','wrist_Posture_condition-psd_peak_shaded');
print(gcf,save_file,'-dpng','-r1200');



figure(2)
% % Rest Condition
%
y=RC_cat; 
x=(1:size(RC_cat,2));

shadedErrorBar(x, y, {@mean,@std}, 'lineprops', '-g')

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
ylabel('PSD (Hz)')
title('Wrist - PSD Peak  - Rest Condition')
%axP = get(gca,'Position');
% set(gca, 'Position', axP)
save_file = sprintf('%s','wrist_Rest_condition-psd_peak_shaded');
print(gcf,save_file,'-dpng','-r1200');


figure(3)
% % Loaded  Posture Condition
y=LPC_cat; 
x=(1:size(LPC_cat,2));

shadedErrorBar(x, y, {@mean,@std}, 'lineprops', '-y')
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
ylabel('PSD (Hz)')
title('Wrist - PSD Peak  - Loaded Posture Condition')
%axP = get(gca,'Position');
% set(gca, 'Position', axP)
save_file = sprintf('%s','wrist_loaded_condition-psd_peak_shaded');
print(gcf,save_file,'-dpng','-r1200');


figure(4)
% % PRE MVC
y=preMVC_cat; 
x=(1:size(preMVC_cat,2));

shadedErrorBar(x, y, {@mean,@std}, 'lineprops', '-b')
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
ylabel('PSD (Hz)')
title('Wrist - PSD Peak  - Pre MVC')
%axP = get(gca,'Position');
% set(gca, 'Position', axP)
save_file = sprintf('%s','wrist_preMVC-psd_peak_shaded');
print(gcf,save_file,'-dpng','-r1200');




figure(5)
% % POST MVC
y=postMVC_cat; 
x=(1:size(postMVC_cat,2));

shadedErrorBar(x, y, {@mean,@std}, 'lineprops', '-o')
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
ylabel('PSD (Hz)')
title('Wrist - PSD Peak  - Post MVC')
%axP = get(gca,'Position');
% set(gca, 'Position', axP)
save_file = sprintf('%s','wrist_postMVC-psd_peak_shaded');
print(gcf,save_file,'-dpng','-r1200');



figure(6)
% % Pre and Post Together MVC
CAT = [preMVC_cat, postMVC_cat];
x=(1:size(CAT,2));
shadedErrorBar(x, CAT, {@mean,@std}, 'lineprops', '-r')
box on; grid on
ax = gca;
set(gcf,'Color','white'); % Set background color to white
set (gca,'FontName','times new roman') % Set axes fonts to Times New Roman
ax.XTick = [1,2,3,4,5,6,7];
ax.XTickLabel = {'Pre-1','Pre-2','Pre-3','Post - 0 min','Post - 1 min','Post - 5 min', 'Post - 10 min'};
ax.XTickLabelRotation = 270;
% ylim([0 20])
xlim([1 7])
% xlabel('Minutes after exhaustion')
ylabel('PSD (Hz)')
title('Wrist - PSD Peak  - Pre and Post MVC')
%axP = get(gca,'Position');
% set(gca, 'Position', axP)
save_file = sprintf('%s','wrist_pre_and_postMVC-psd_peak_shaded');
print(gcf,save_file,'-dpng','-r1200');


figure(7)
% % First and last four during the fatigue test
color = jet(15);
first = first_cat;
last = last_cat;

CAT = horzcat(first, last);
x=(1:size(CAT,2));
shadedErrorBar(x, CAT, {@mean,@std}, 'lineprops', '-r')
box on; grid on
ax = gca;
set(gcf,'Color','white'); % Set background color to white
set (gca,'FontName','times new roman') % Set axes fonts to Times New Roman
ax.XTick = [1,2,3,4,5,6,7,8];
ax.XTickLabel = {'Pre - 1','Pre - 2','Pre - 3','Pre - 4','Pre - 5','Post - 1','Post - 2','Post - 3'};
ax.XTickLabelRotation = 270;
% ylim([0 12])
xlim([1 8])
% xlabel('Minutes after exhaustion')
ylabel('PSD (Hz)')
title('Wrist - PSD Peak  - First five and last three 30 % MVC')
%axP = get(gca,'Position');
% set(gca, 'Position', axP)
save_file = sprintf('%s','wrist_first_and_last_30_MVC-psd_peak_shaded');
print(gcf,save_file,'-dpng','-r1200');



