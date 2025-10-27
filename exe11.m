%% Lab Exercise 11: FIR Filter Types (I, II, III, IV)
% Course: Mathematical Algorithms (DSP) — Image Processing Labs
%
% This script analyzes the Magnitude, Unwrapped Phase, and Pole-Zero
% diagrams for four different types of FIR filters to demonstrate their
% linear-phase characteristics and zero placement patterns.
% -------------------------------------------------------------------------

close all; clear; clc;

% --- 1. Define Filter Impulse Responses (h) ---
% Note: FIR filters are always stable, having only poles at the origin (z=0).
filters(1).h = [1 2 3 4 4 3 2 1]; 
filters(1).type = 'Type I'; % M even, Symmetric
filters(2).h = [1 2 3 4 3 2 1]; 
filters(2).type = 'Type II'; % M odd, Symmetric
filters(3).h = [-1 -2 -3 -4 3 3 2 1]; 
filters(3).type = 'Type III'; % M even, Antisymmetric
filters(4).h = [-1 -2 -3 0 3 2 1]; 
filters(4).type = 'Type IV'; % M odd, Antisymmetric

% --- 2. Initialize Figure and Title ---
figure('units','normalized','outerposition',[0 0 1 1]); % Maximize figure window
sgtitle('Frequency and Pole-Zero Analysis of Four FIR Filter Types (I–IV)');

% --- 3. Column Headers (for reference) ---
annotation('textbox', [0.15 0.95 0.1, 0.03], 'String', 'Magnitude Response', 'EdgeColor', 'none', 'FontSize', 14, 'FontWeight', 'bold');
annotation('textbox', [0.45 0.95 0.1, 0.03], 'String', 'Unwrapped Phase', 'EdgeColor', 'none', 'FontSize', 14, 'FontWeight', 'bold');
annotation('textbox', [0.75 0.95 0.1, 0.03], 'String', 'Pole-Zero Diagram', 'EdgeColor', 'none', 'FontSize', 14, 'FontWeight', 'bold');


% --- 4. Loop Through Filters and Plot ---
for k = 1:4
    h = filters(k).h;
    type = filters(k).type;
    
    % Calculate Frequency Response (H)
    % 1 is used for the denominator (a=1) as FIR filters have no poles other than z=0
    [H, w] = freqz(h, 1, 512); 
    
    % --- Row k, Column 1: Magnitude Response ---
    subplot(4, 3, (k-1)*3 + 1);
    plot(w/pi, abs(H), 'LineWidth', 1.5, 'Color', [0.1 0.5 0.8]);
    title([type ' Magnitude']);
    xlabel('\omega / \pi');
    if k == 1, ylabel('|H(\omega)|'); end
    grid on;

    % --- Row k, Column 2: Unwrapped Phase Response ---
    subplot(4, 3, (k-1)*3 + 2);
    plot(w/pi, unwrap(angle(H)), 'LineWidth', 1.5, 'Color', [0.8 0.1 0.1]);
    title([type ' Unwrapped Phase']);
    xlabel('\omega / \pi');
    if k == 1, ylabel('Phase (rad)'); end
    grid on;
    
    % --- Row k, Column 3: Pole-Zero Diagram ---
    subplot(4, 3, (k-1)*3 + 3);
    zplane(h, 1); 
    title([type ' Pole-Zero Plot']);
    
end

disp('The 4x3 plot has been generated and maximized.');
disp('Examine the straight-line phase plots (Linear Phase) and the zero patterns for each type.');