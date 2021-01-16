
function [Filtered_Signal] = Moving_Filter_Signal(Signal,t,Window_Size,Type)

clf;
%Evaluating signal and window specific parameters%
Sampling_Period = t(2) - t(1);
Signal_Range = max(Signal) - min(Signal);
Window_Radius = round(Window_Size/2);
Window_Size_In_Time_Units = Window_Size*Sampling_Period;
Signal_Length = length(Signal);

%Pre-allocating values array that will hold filtered signal%
Filtered_Signal = zeros(1,Signal_Length);

%Creating animated rectangle representing sliding window (top subplot)%
subplot(2,1,1); Rectangle = rectangle('EdgeColor','r'); 
hold on

%Plotting unfiltered signal (top subplot)%
subplot(2,1,1); plot(t,Signal,'.-','Color','#0072BD');
title("Original Signal");
xlabel("Time (s)"); ylabel("Amplitude");
xlim([min(t) max(t)+Window_Size_In_Time_Units/2]);
ylim([1.2*min(Signal) 1.2*max(Signal)]);

%Creating animated line to plot filtered signal (bottom subplot)%
subplot(2,1,2); Animated_Plot = animatedline('Color','#0072BD','Marker','.','LineStyle','-');
title(Type + ": Filtered Signal");
xlabel("Time (s)"); ylabel("Amplitude");
xlim([min(t) max(t)+Window_Size_In_Time_Units/2]);
ylim([1.2*min(Signal) 1.2*max(Signal)]);
hold on


%Looping through samples and moving/traversing filter across entire signal%
for Sample_Index = 1: Signal_Length
    
    %Window start and end points in terms of sample index%
    Window_Start = Sample_Index - Window_Radius;
    Window_End = Sample_Index + Window_Radius;
    
    %Window overflow gaurd statements%
    if Window_Start < 1
        Window_Start = 1;
    end
    if Window_End > Signal_Length
        Window_End = Signal_Length;
    end
   
    Window = Signal(Window_Start:Window_End);
    
    switch Type
        case "Max"
            Window_Result = max(Window);
        case "Min"
            Window_Result = min(Window);
        case "Average"
            Window_Result = sum(Window)/Window_Size;   
        otherwise
            disp('Invalid type: must be "Max","Min" or "Average"');
            break;
    end
    
    %Moving filter window, rectangle (top subplot)%
    Filtered_Signal(Sample_Index) = Window_Result;
    subplot(2,1,1); Rectangle.Position = [t(Window_Start) 1.1*min(Signal) Window_Size*(Sampling_Period) 1.1*Signal_Range];
    drawnow
    hold on
    
    %Adding to filtered signal (bottom subplot)%
    subplot(2,1,2); addpoints(Animated_Plot,t(Sample_Index),Window_Result);
    drawnow
    hold on
    
end

end
