clear all; clc;close all

load Persons

for j = 1 : size(Person,2) - 1
    
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
    
    % Keep only first two
    PC_idx = PC_idx([1,2]);
    
    
    % % Resting coniditons
    % Find index of resting condition
    RC_labels = [3 ,6];
    c = ismember(labels, RC_labels);
    
    % Extract indices of rest condition labels.
    RC_idx = find(c);
    
    % Keep only first two
    RC_idx = RC_idx([1,2]);
    
    
    % % Loaded Posture condition
    % Find index of loaded posture condition
    LPC_labels = [2 ,4];
    c = ismember(labels, LPC_labels);
    
    % Extract indices of PC labels.
    LPC_idx = find(c);
    LPC_idx = LPC_idx([1 end-3:end]); % first and last four labels are LPC
    
    % Keep the first two
    LPC_idx = LPC_idx([1 2]); % first and last four labels are LPC
    
    
    
    
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
    
    % % take only one value of pre-MVC
    preMVC_idx = MVC_idx(3);
    
    % % take only one value of post-MVC
    postMVC_idx = MVC_idx(end-3);
    
    
    % 30 percent MVC
    % Non fatigued
    
    prefatigue = MVC_idx(4:8);
    
    % % take only one value
    prefatigue = MVC_idx(8);
    
    % Fatigued
    postfatigue = MVC_idx(end-7:end-4);
    
    % % take only one value
    postfatigue = MVC_idx(end-7);
    
    % Posture Condition plots
    for i = 1 : length (PC_idx)
        figure(1)
        %         plot(f{PC_idx(i)}, ft_acc{PC_idx(i)})
        hold on
        sgf_sm{i} = sgolayfilt(ft_acc{PC_idx(i)}, 5, 21);% Create ‘sgolayfilt’ Filtered FFT
        plot(f{PC_idx(i)}, sgf_sm{i}, 'LineWidth',1.1)
        %         ylim([0 .2])
        xlim([3 22])
        title('Posture Condition')
        xlabel('Frequency (Hz)','interpreter','latex');
        ylabel('fft(acc_data)','interpreter','latex'); % Add a legend
        box on; grid on
        legend('pre-MVC', 'post-MVC')
        ax = gca;
        set(gcf,'Color','white'); % Set background color to white
        
        set (gca,'FontName','times new roman') % Set axes fonts to Times New Roman
        
    end
    save_file = sprintf('%s%s_%d','PC','Person',j);
    print(gcf,save_file,'-dpng','-r900');
    savefig(strcat(save_file,'.fig'))
    
    
    % Resting condition plots
    for i = 1 : length (RC_idx)
        figure(2)
        %         plot(f{rpc_idx(i)}, ft_acc{rpc_idx(i)})
        hold on
        sgf_sm{i} = sgolayfilt(ft_acc{RC_idx(i)}, 5, 21);% Create ‘sgolayfilt’ Filtered FFT
        plot(f{RC_idx(i)}, sgf_sm{i}, 'LineWidth',1.1)
        %         ylim([0 1])
        xlim([3 22])
        title('Resting Condition')
        xlabel('Frequency (Hz)','interpreter','latex');
        
        ylabel('fft(acc_data)','interpreter','latex'); % Add a legend
        legend('pre-MVC', 'post-MVC')
        ax = gca;
        set(gcf,'Color','white'); % Set background color to white
        box on; grid on
        set (gca,'FontName','times new roman') % Set axes fonts to Times New Roman
        
    end
    save_file = sprintf('%s%s_%d','RPC','Person',j);
    print(gcf,save_file,'-dpng','-r900');
    savefig(strcat(save_file,'.fig'))
    
    % Loaded posture condition plots
    for i = 1 : length (LPC_idx)
        figure(3)
        %         plot(f{lpc_idx(i)}, ft_acc{lpc_idx(i)})
        hold on
        
        sgf_sm{i} = sgolayfilt(ft_acc{LPC_idx(i)}, 5, 21);% Create ‘sgolayfilt’ Filtered FFT
        plot(f{LPC_idx(i)}, sgf_sm{i}, 'LineWidth',1.1)
        %         ylim([0 .25])
        xlim([3 22])
        title('Loaded Posture Condition')
        xlabel('Frequency (Hz)','interpreter','latex');
        ylabel('fft(acc_data)','interpreter','latex'); % Add a legend
        legend('pre-MVC', 'post-MVC')
        ax = gca;
        set(gcf,'Color','white'); % Set background color to white
        box on; grid on
        set (gca,'FontName','times new roman') % Set axes fonts to Times New Roman
        
    end
    save_file = sprintf('%s%s_%d','LPC','Person',j);
    print(gcf,save_file,'-dpng','-r900');
    savefig(strcat(save_file,'.fig'))
    
    % MVC condition plots
    for i = 1 : length (preMVC_idx)
        figure(4)
        %         plot(f{preMVC_idx(i)}, ft_acc{preMVC_idx(i)})
        hold on
        sgf_sm{i} = sgolayfilt(ft_acc{preMVC_idx(i)}, 5, 21);% Create ‘sgolayfilt’ Filtered FFT
        plot(f{preMVC_idx(i)}, sgf_sm{i}, 'LineWidth',1.1)
        
        sgf_sm{i} = sgolayfilt(ft_acc{postMVC_idx(i)}, 5, 21);% Create ‘sgolayfilt’ Filtered FFT
        plot(f{postMVC_idx(i)}, sgf_sm{i}, 'LineWidth',1.1)
        %         ylim([0 .4])
        xlim([3 22])
        title('Pre MVC')
        xlabel('Frequency (Hz)','interpreter','latex');
        
        ylabel('fft(acc_data)','interpreter','latex'); % Add a legend
        
        legend('pre-MVC', 'post-MVC')
        ax = gca;
        set(gcf,'Color','white'); % Set background color to white
        box on; grid on
        set (gca,'FontName','times new roman') % Set axes fonts to Times New Roman
        
    end
    
    save_file = sprintf('%s%s_%d','MVC','Person',j);
    print(gcf,save_file,'-dpng','-r900');
    savefig(strcat(save_file,'.fig'))
    
    % Fatigue plots
    for i = 1 : length (postfatigue)
        figure(5)
        
        sgf_sm{i} = sgolayfilt(ft_acc{prefatigue(i)}, 5, 21);% Create ‘sgolayfilt’ Filtered FFT
        plot(f{prefatigue(i)}, sgf_sm{i}, 'LineWidth',1.1)
                plot(f{postfatigue(i)}, ft_acc{postfatigue(i)})
        hold on
        sgf_sm{i} = sgolayfilt(ft_acc{postfatigue(i)}, 5, 21);% Create ‘sgolayfilt’ Filtered FFT
        plot(f{postfatigue(i)}, sgf_sm{i}, 'LineWidth',1.1)
        %         ylim([0 .6])
        xlim([3 22])
        title('Post Fatigue')
        xlabel('Frequency (Hz)','interpreter','latex');
        legend('pre-Fatigue','post-Fatigue')
        ylabel('fft(acc_data)','interpreter','latex'); % Add a legend
        
        ax = gca;
        set(gcf,'Color','white'); % Set background color to white
        box on; grid on
        set (gca,'FontName','times new roman') % Set axes fonts to Times New Roman
        
    end
    save_file = sprintf('%s%s_%d','fatigue','Person',j);
    print(gcf,save_file,'-dpng','-r900');
    savefig(strcat(save_file,'.fig'))
    
    
end