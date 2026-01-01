clc; clear; close all;
colo = [255,123,36]/255;
L = 1000;          
Pf = 0.1;          
SNR_dB = -20:2:0;   
SNR_linear = 10.^(SNR_dB./10); 
Monte_Carlo = 10000; 

Pd = zeros(1, length(SNR_dB));

threshold = (qfuncinv(Pf) * sqrt(2*L)) + L;

for i = 1:length(SNR_dB)
    detected_count = 0;
    for j = 1:Monte_Carlo
    
        noise = randn(1, L);
        
        
        signal = sqrt(SNR_linear(i)) * randn(1, L);
        

        received_signal = signal + noise;
        
        energy = sum(abs(received_signal).^2);
        

        if (energy > threshold)
            detected_count = detected_count + 1;
        end
    end
    Pd(i) = detected_count / Monte_Carlo;
end

figure;
plot(SNR_dB, Pd, '-bo', 'LineWidth', 2, 'MarkerSize', 8,'color',colo);
grid on;
xlabel('SNR (dB)');
ylabel('Probability of Detection (Pd)');
title('Energy Detection: Pd vs SNR');
legend(['P_f = ', num2str(Pf)]);