clear all; close all;clc

matfile = sprintf('%s','wrist_results_14_22_no_filter');
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
    PC_cat = horzcat(PC_cat, PC{n}.episode);
    RC_cat = horzcat(RC_cat, RC{n}.episode);
    LPC_cat = horzcat(LPC_cat, LPC{n}.episode);
    preMVC_cat = horzcat(preMVC_cat, preMVC{n}.episode);
    postMVC_cat = horzcat(postMVC_cat, postMVC{n}.episode);
    first_cat = horzcat(first_cat, first{n}.episode);
    last_cat = horzcat(last_cat, last{n}.episode);
    
end

PC_cat = transpose(reshape(PC_cat, 5, 13));
RC_cat = transpose(reshape(RC_cat, 5, 13));
LPC_cat = transpose(reshape(LPC_cat, 5, 13));
preMVC_cat = transpose(reshape(preMVC_cat, 3, 13));
postMVC_cat = transpose(reshape(postMVC_cat, 4, 13));

first_cat = transpose(reshape(first_cat, 5, 13));
last_cat = transpose(reshape(last_cat, 3, 13));

for i = 1 : size(PC_cat, 1)
    for j = 1 : size(PC_cat, 2)
        PC_entropy(i, j) = sampen(cell2mat(PC_cat(i,j)),1,0.2);
        RC_entropy(i, j) = sampen(cell2mat(RC_cat(i,j)),1,0.2);
        LPC_entropy(i, j) = sampen(cell2mat(LPC_cat(i,j)),1,0.2);
        first_entropy(i, j) = sampen(cell2mat(first_cat(i,j)),1,0.2);
    end
end

for i = 1 : size(preMVC_cat, 1)
    for j = 1 : size(preMVC_cat, 2)
        
        preMVC_entropy(i, j) = sampen(cell2mat(preMVC_cat(i,j)),1,0.2);
        last_entropy(i, j) = sampen(cell2mat(last_cat(i,j)),1,0.2);
    end
end

for i = 1 : size(postMVC_cat, 1)
    for j = 1 : size(postMVC_cat, 2)
        postMVC_entropy(i, j) = sampen(cell2mat(postMVC_cat(i,j)),1,0.2);
    end
end
% % Posture condition

figure(1)
%
y=PC_entropy; 
x=(1:size(PC_entropy,2));

shadedErrorBar(x, y, {@mean,@std}, 'lineprops', '-r')

hold on

box on; grid on
ax = gca;
set(gcf,'Color','white'); % Set background color to white
set (gca,'FontName','times new roman') % Set axes fonts to Times New Roman
ax.XTick = [1,2,3,4,5];
ax.XTickLabel = {'Pre-','0 min','1 min','5 min','10 min'};
ax.XTickLabelRotation = 270;
ylim([0 3])
xlim([1 5])
% xlabel('Minutes after exhaustion')
ylabel('Amplitude (a.u.)')
title('Wrist - Sample Entropy  - Posture Condition')
axP = get(gca,'Position');
set(gca, 'Position', axP)
save_file = sprintf('%s','wrist_Posture_condition-sa_entropy_shaded_fatigued');
print(gcf,save_file,'-dpng','-r1200');
matlab2tikz('filename',sprintf('wrist_Posture_condition-sa_entropy_shaded_fatigued.tex'));
savefig('wrist_Posture_condition-sa_entropy_shaded_fatigued.fig')


figure(2)
% % Rest Condition
%
y=RC_entropy; 
x=(1:size(RC_entropy,2));

shadedErrorBar(x, y, {@mean,@std}, 'lineprops', '-g')

box on; grid on
ax = gca;
set(gcf,'Color','white'); % Set background color to white
set (gca,'FontName','times new roman') % Set axes fonts to Times New Roman
ax.XTick = [1,2,3,4,5];
ax.XTickLabel = {'Pre-','0 min','1 min','5 min','10 min'};
ax.XTickLabelRotation = 270;
ylim([0 3])
xlim([1 5])
% xlabel('Minutes after exhaustion')
ylabel('Amplitude (a.u.)')
title('Wrist - Sample Entropy  - Rest Condition')
axP = get(gca,'Position');
set(gca, 'Position', axP)
save_file = sprintf('%s','wrist_Rest_condition-sa_entropy_shaded_fatigued');
print(gcf,save_file,'-dpng','-r1200');
matlab2tikz('filename',sprintf('wrist_Rest_condition-sa_entropy_shaded_fatigued.tex'));
savefig('wrist_Rest_condition-sa_entropy_shaded_fatigued.fig')


figure(3)
% % Loaded  Posture Condition
y=LPC_entropy; 
x=(1:size(LPC_entropy,2));

shadedErrorBar(x, y, {@mean,@std}, 'lineprops', '-b')
box on; grid on
ax = gca;
set(gcf,'Color','white'); % Set background color to white
set (gca,'FontName','times new roman') % Set axes fonts to Times New Roman
ax.XTick = [1,2,3,4,5];
ax.XTickLabel = {'Pre-','0 min','1 min','5 min','10 min'};
ax.XTickLabelRotation = 270;
ylim([0 3])
xlim([1 5])
% xlabel('Minutes after exhaustion')
ylabel('Amplitude (a.u.)')
title('Wrist - Sample Entropy  - Loaded Posture Condition')
axP = get(gca,'Position');
set(gca, 'Position', axP)
save_file = sprintf('%s','wrist_loaded_condition-sa_entropy_shaded_fatigued');
print(gcf,save_file,'-dpng','-r1200');
matlab2tikz('filename',sprintf('wrist_loaded_condition-sa_entropy_shaded_fatigued.tex'));
savefig('wrist_loaded_condition-sa_entropy_shaded_fatigued.fig')


figure(4)
% % PRE MVC
y=preMVC_entropy; 
x=(1:size(preMVC_entropy,2));

shadedErrorBar(x, y, {@mean,@std}, 'lineprops', '-b')
box on; grid on
ax = gca;
set(gcf,'Color','white'); % Set background color to white
set (gca,'FontName','times new roman') % Set axes fonts to Times New Roman
ax.XTick = [1,2,3];
ax.XTickLabel = {'Pre-1','Pre-2','Pre-3'};
ax.XTickLabelRotation = 270;
ylim([0 3])
xlim([1 3])
% xlabel('Minutes after exhaustion')
ylabel('Amplitude (a.u.)')
title('Wrist - Sample Entropy  - Pre MVC')
axP = get(gca,'Position');
set(gca, 'Position', axP)
save_file = sprintf('%s','wrist_preMVC-sa_entropy_shaded_fatigued');
print(gcf,save_file,'-dpng','-r1200');
matlab2tikz('filename',sprintf('wrist_preMVC-sa_entropy_shaded_fatigued.tex'));
savefig('wrist_preMVC-sa_entropy_shaded_fatigued.fig')




figure(5)
% % POST MVC
y=postMVC_entropy; 
x=(1:size(postMVC_entropy,2));

shadedErrorBar(x, y, {@mean,@std}, 'lineprops', '-o')
box on; grid on
ax = gca;
set(gcf,'Color','white'); % Set background color to white
set (gca,'FontName','times new roman') % Set axes fonts to Times New Roman
ax.XTick = [1,2,3,4];
ax.XTickLabel = {'0 min','1 min','5 min', '10 min'};
ax.XTickLabelRotation = 270;
ylim([0 3])
xlim([1 4])
% xlabel('Minutes after exhaustion')
ylabel('Amplitude (a.u.)')
title('Wrist - Sample Entropy  - Post MVC')
axP = get(gca,'Position');
set(gca, 'Position', axP)
save_file = sprintf('%s','wrist_postMVC-sa_entropy_shaded_fatigued');
print(gcf,save_file,'-dpng','-r1200');
matlab2tikz('filename',sprintf('wrist_postMVC-sa_entropy_shaded_fatigued.tex'));
savefig('wrist_postMVC-sa_entropy_shaded_fatigued.fig')


figure(6)
% % Pre and Post Together MVC
CAT = [preMVC_entropy, postMVC_entropy];
x=(1:size(CAT,2));
shadedErrorBar(x, CAT, {@mean,@std}, 'lineprops',{'-or','markerfacecolor',[1,0.2,0.2]})
box on; grid on
ax = gca;
set(gcf,'Color','white'); % Set background color to white
set (gca,'FontName','times new roman') % Set axes fonts to Times New Roman
ax.XTick = [1,2,3,4,5,6,7];
ax.XTickLabel = {'Pre-1','Pre-2','Pre-3','Post - 0 min','Post - 1 min','Post - 5 min', 'Post - 10 min'};
ax.XTickLabelRotation = 270;
ylim([0 3])
xlim([1 7])
% xlabel('Minutes after exhaustion')
ylabel('Amplitude (a.u.)')
title('Wrist - Sample Entropy  - Pre and Post MVC')
axP = get(gca,'Position');
set(gca, 'Position', axP)
save_file = sprintf('%s','wrist_pre_and_postMVC-sa_entropy_shaded_fatigued');
print(gcf,save_file,'-dpng','-r1200');
matlab2tikz('filename',sprintf('wrist_pre_and_postMVC-sa_entropy_shaded_fatigued.tex'));
savefig('wrist_pre_and_postMVC-sa_entropy_shaded_fatigued.fig')

figure(7)
% % First and last four during the fatigue test
color = jet(15);
first = first_entropy;
last = last_entropy;

CAT = horzcat(first, last);
x=(1:size(CAT,2));
shadedErrorBar(x, CAT, {@mean,@std}, 'lineprops', {'-ob','markerfacecolor',[1,0.2,0.2]})
box on; grid on
ax = gca;
set(gcf,'Color','white'); % Set background color to white
set (gca,'FontName','times new roman') % Set axes fonts to Times New Roman
ax.XTick = [1,2,3,4,5,6,7,8];
ax.XTickLabel = {'Pre - 1','Pre - 2','Pre - 3','Pre - 4','Pre - 5','Post - 1','Post - 2','Post - 3'};
ax.XTickLabelRotation = 270;
ylim([0 3])
xlim([1 8])
% xlabel('Minutes after exhaustion')
ylabel('Amplitude (a.u.)')
title('Wrist - Sample Entropy  - First five and last three 30 % MVC')
axP = get(gca,'Position');
set(gca, 'Position', axP)
save_file = sprintf('%s','wrist_first_and_last_30_MVC-sa_entropy_shaded_fatigued');
print(gcf,save_file,'-dpng','-r1200');
matlab2tikz('filename',sprintf('wrist_first_and_last_30_MVC-sa_entropy_shaded_fatigued.tex'));
savefig('wrist_first_and_last_30_MVC-sa_entropy_shaded_fatigued.fig')


