
%Window result is relative to centre% 
Sampling_Frequency = 25;
Sampling_Period = 1/Sampling_Frequency;

%Creating the time vector that the signal is defined for%
Start_Time = 0; End_Time = 10;
t = (Start_Time:Sampling_Period:End_Time);

f = 1; %Frequency of the sinusoid%
Signal = sin(2*pi*f*t);

Window_Size = 30; %Window size is in terms of number of samples%
Type = "Average"; %Type: "Average","Max" or "Min"%
[Filtered_Signal] = Moving_Filter_Signal(Signal,t,Window_Size,Type);


%%
%Window result is relative to centre% 
Sampling_Frequency = 10;
Sampling_Period = 1/Sampling_Frequency;

%Creating the time vector that the signal is defined for%
Start_Time = 0; End_Time = 20;
t = (Start_Time:Sampling_Period:End_Time);


Pulse_Duration = 2; %Pulse duration%
u = @(t) 1.0.*(t > 0 & t < Pulse_Duration); %Creating a unit pulse of width pulse duration%
Pulse_Train = @(t) 0; %Giving the pulse train initial conditions of 0%

Offset_Factor = 4; %The offset of each following pulse%

%Creating a pulse train by offsetting the original pulse and aggragating%
for Offset = 0: +Offset_Factor: End_Time
Pulse_Train = @(t) u(t - Offset) + Pulse_Train(t);
end

Signal = Pulse_Train(t);
Window_Size = 10; %Window size is in terms of number of samples%
Type = "Max"; %Type: "Average","Max" or "Min"%
[Filtered_Signal] = Moving_Filter_Signal(Signal,t,Window_Size,Type);





