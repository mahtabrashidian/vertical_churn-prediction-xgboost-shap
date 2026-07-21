preemtion_ExitRate.m

clear all
clc
close all
testName='Exit Rate';
tests=0.01:0.01:0.05;
blockR=zeros(1,numel(tests));
dropR=zeros(1,numel(tests));
for tid=1:numel(tests)
    clearvars -except tests tid blockR dropR testName
    mu=180;
    pt=20;
    l=28.7;
    n=3.7;
    R1=1; R2=8; R3=24; R4=48;
    rssi_trigger=-80;
    rssi_mid=-88;
    rssi_mid2=-98;
    rssi_disconnect=-100;
    call_block=0;
    call_drop=0;
    call_succ=0;
    call_total=0;
    call_handoffs=0;
    call_preempt=0;
    ap.x=0;
    ap.y=0;
    ap.busy_channel=[0 0 0];
    ap.free_channel=[48 48 48];
    
    node.x=0;
    node.y=0;
    node.channel=[0 0 0];
    node.active=0;
    node.duration=0;
    node.v=0;
    node.teta=0;
    node.handoff_active=0;
    node.t_vho=0;
    
    landa=0.4;
    h=tests(tid);
    users=200;
    v_max=10;
    v_min=1;
    
    for i=1:users
        ms{i}=node;
    end
    
    for time=1:2000
        clc
        fprintf('time= %d(s) , %s=%d, preempitions=%d',time,testName,tests(tid),call_preempt)
        m=rand;
        %new calls
        if m<=landa
            if ap.free_channel(1)>=R1
                found=0;
                i=1;
                while (found==0)
preemtion_ExitRate.m
clear all
clc
close all
testName='Exit Rate';
tests=0.01:0.01:0.05;
blockR=zeros(1,numel(tests));
dropR=zeros(1,numel(tests));
for tid=1:numel(tests)
    clearvars -except tests tid blockR dropR testName
    mu=180;
    pt=20;
    l=28.7;
    n=3.7;
    R1=1; R2=8; R3=24; R4=48;
    rssi_trigger=-80;
    rssi_mid=-88;
    rssi_mid2=-98;
    rssi_disconnect=-108;
    call_block=0;
    call_drop=0;
    call_succ=0;
    call_total=0;
    call_handoffs=0;
    call_preempt=0;
    ap.x=0;
    ap.y=0;
    ap.busy_channel=[0 0 0];
    ap.free_channel=[48 48 48];
    
    node.x=0;
    node.y=0;
    node.channel=[0 0 0];
    node.active=0;
    node.duration=0;
    node.v=0;
    node.teta=0;
    node.handoff_active=0;
    node.t_vho=0;
    
    landa=0.4;
    h=tests(tid);
    users=200;
    v_max=10;
    v_min=1;
    
    for i=1:users
        ms{i}=node;
    end
    
    for time=1:2000
        clc
        fprintf('time= %d(s) , %s=%d,
preemptions=%d',time,testName,tests(tid),call_preempt)
        m=rand;
        %new calls
        if m<=landa
            if ap.free_channel(1)>=R1
                found=0;
                i=1;
                while (found==0)
   preemtion_ExitRate.m
            if ms{i}.active==0  && ms{i}.x==0  && ms{i}.y==0
                ms{i}.active=1;
                ms{i}.channel=[R1 0 0];
                ap.free_channel=ap.free_channel-ms{i}.channel;
                data = exprnd(mu,100,1); % Simulated data
                [muhat,muci] = expfit(data);
                ms{i}.duration=muhat;
                found=1;
                call_total=call_total+1;
            end
            i=i+1;
        end
    else
        call_block=call_block+1;
    end
end
%movement
for i=1:users
    if ms{i}.active==1 && ms{i}.x==0  && ms{i}.y==0
        m=rand;
        if m<=h
            ms{i}.x=0;
            ms{i}.y=50;
            ms{i}.teta=pi*rand;
            ms{i}.v=v_min+(v_max-v_min)*rand;
            ms{i}.t_vho=0;
            ms{i}.handoff_active=0;
        end
    end
end

%network operations
for j=1:20
    %end of calls
    for i=1:users
        if ms{i}.active==1
            ms{i}.duration=ms{i}.duration-0.05;
            
            if ms{i}.duration<=0
                ms{i}.x=0;
                ms{i}.y=0;
                ms{i}.duration=0;
                ms{i}.active=0;
                ms{i}.t_vho=0;
                ms{i}.handoff_active=0;
                ap.free_channel=ap.free_channel+ms{i}.channel;
                ms{i}.channel=[0 0 0];
                call_succ=call_succ+1;
            end
        end
    end

    %handling active handoffs(10s)
    for i=1:users
        if ms{i}.handoff_active==1
            ms{i}.t_vho=ms{i}.t_vho-0.05;
            if ms{i}.t_vho<=0
                ms{i}.x=0;
                ms{i}.y=0;
                ms{i}.duration=0;
                ms{i}.active=0;
ms{i}.t_vho=0;
ms{i}.Handoff_active=0;
ap.free_channel=ap.free_channel+ms{i}.channel;
ms{i}.channel=[0 0 0];
call_succ=call_succ+1;
            end
        end
    end
end
%sampling of RSSI
for i=1:users
    d=sqrt(ms{i}.x^2+ms{i}.y^2);
    if d>=50
        Sum=0;
        for k=1:5
            fz=7*randn;
            ms{i}.x=ms{i}.x+ms{i}.v*0.01*cos(ms{i}.teta);
            ms{i}.y=ms{i}.y+ms{i}.v*0.01*sin(ms{i}.teta);
            d=sqrt(ms{i}.x^2+ms{i}.y^2);
            Sum=Sum+(pt-1-10*n*log10(d)+fz);
        end
        ms{i}.rssi=Sum/5;
    end
end

%failed handoffs (MS exits coverage area)
for i=1:users
    d=sqrt(ms{i}.x^2+ms{i}.y^2);
    if d>=50
        if ms{i}.rssi<=rssi_disconnect && ms{i}.t_vho>0
            call_drop=call_drop+1;
            ms{i}.x=0;
            ms{i}.y=0;
            ms{i}.duration=0;
            ms{i}.active=0;
            ms{i}.t_vho=0;
            ms{i}.handoff_active=0;
            ap.free_channel=ap.free_channel+ms{i}.channel;
            ms{i}.channel=[0 0 0];
        end
    end
end

%check for start of handoff (R2 Area-8CH)
for i=1:users
    d=sqrt(ms{i}.x^2+ms{i}.y^2);
    if d>=50
        if ms{i}.rssi<=rssi_trigger && ms{i}.handoff_active==0 && ...
           ms{i}.active==1 && ms{i}.rssi>rssi_mid
            if ap.free_channel(2)>=R2-R1
                ms{i}.t_vho=10;
                ms{i}.handoff_active=1;
                ms{i}.channel=ms{i}.channel+[0 R2-R1 0];
                ap.free_channel=ap.free_channel-[0 R2-R1 0];
                call_handoffs=call_handoffs+1;
            else
                call_drop=call_drop+1;
                ms{i}.x=0;
                ms{i}.y=0;
                ms{i}.duration=0;
                ms{i}.active=0;
                ms{i}.t_vho=0;
                ms{i}.handoff_active=0;
 preemtion_ExitRate.m
                ap.free_channel=ap.free_channel+ms{i}.channe
                ms{i}.channel=[0 0 0];
            end
        end
    end
%check for start of handoff (R3 Area-24CH)
for i=1:users
    d=sqrt(ms{i}.x^2+ms{i}.y^2);
    if d>=50
        if ms{i}.rssi<=rssi_mid && ms{i}.handoff_active==0 &&
ms{i}.active==1 && ms{i}.rssi>rssi_mid2
            if ap.free_channel(3)>=R3-R1
                ms{i}.t_vho=10;
                ms{i}.handoff_active=1;
                ms{i}.channel=ms{i}.channel+[0 0 R3-R1];
                ap.free_channel=ap.free_channel-[0 0 R3-R1];
                call_handoffs=call_handoffs+1;
            else
                call_drop=call_drop+1;
                ms{i}.x=0;
                ms{i}.y=0;
                ms{i}.duration=0;
                ms{i}.active=0;
                ms{i}.t_vho=0;
                ms{i}.handoff_active=0;
                ap.free_channel=ap.free_channel+ms{i}.channel;
                ms{i}.channel=0;
            end
        end
    end
end

%check for start of handoff (R4 Area-48CH)
for i=1:users
    d=sqrt(ms{i}.x^2+ms{i}.y^2);
    if d>=50
        if ms{i}.rssi<=rssi_mid2 && ms{i}.handoff_active==0 &&
ms{i}.active==1 && ms{i}.rssi>rssi_disconnect
            if ap.free_channel(3)>=R4-R1
                ms{i}.t_vho=10;
                ms{i}.handoff_active=1;
                ms{i}.channel=ms{i}.channel+[0 0 R4-R1];
                ap.free_channel=ap.free_channel-[0 0 R4-R1];
                call_handoffs=call_handoffs+1;
            else
                call_drop=call_drop+1;
                ms{i}.x=0;
                ms{i}.y=0;
                ms{i}.duration=0;
                ms{i}.active=0;
                ms{i}.t_vho=0;
                ms{i}.handoff_active=0;
                ap.free_channel=ap.free_channel+ms{i}.channel;
                ms{i}.channel=0;
            end
        end
    end
end

%check for continuing handoff (when user in R2 area reaches R3)
for i=1:users
    d=sqrt(ms{i}.x^2+ms{i}.y^2);
if d>=50
    if ms{i}.rssi<rssi_mid && ms{i}.handoff_active==1 &&
ms{i}.active==1 && sum(ms{i}.channel)==8
        if ap.free_channel(3)>=R3-R2
            ms{i}.channel=ms{i}.channel+[0 0 R3-R2];
            ap.free_channel=ap.free_channel-[0 0 R3-R2];
        else
            %preemtion
            needed=R3-R2;
            selection=[];
            for jc=1:users
                if ms{jc}.active==1 && ms{jc}.t_vho>ms{i}.t_vho &&
ms{jc}.handoff_active==1 && sum(ms{jc}.channel)>=needed
                selection=[ selection;
                            jc ms{jc}.t_vho-ms{i}.t_vho];
                end
            end
            if numel(selection)>0
                %select best user for preemption
                [~,ix]=max(selection(:,2));
                selection=selection(ix,1);
                %get channels of selected user
                ms{i}.channel=ms{i}.channel+ms{selection}.channel;
                call_preempt=call_preempt+1;
                %disconnect selected user
                call_drop=call_drop+1;
                ms{selection}.x=0;
                ms{selection}.y=0;
                ms{selection}.duration=0;
                ms{selection}.active=0;
                ms{selection}.t_vho=0;
                ms{selection}.handoff_active=0;
                ms{selection}.channel=[0 0 0];
            else
                %can not preempt. drop call
                call_drop=call_drop+1;
                ms{i}.x=0;
                ms{i}.y=0;
                ms{i}.duration=0;
                ms{i}.active=0;
                ms{i}.t_vho=0;
                ms{i}.handoff_active=0;
                ap.free_channel=ap.free_channel+ms{i}.channel;
                ms{i}.channel=[0 0 0];
            end
        end
    end
end
    end
        end
    end
end

%check for continuing handoff (when user in R3 area reaches R4)
for i=1:users
    d=sqrt(ms{i}.x^2+ms{i}.y^2);
    if d>=50
        if ms{i}.rssi<rssi_mid2 && ms{i}.handoff_active==1 &&
ms{i}.active==1 && sum(ms{i}.channel)==24
            if ap.free_channel(3)>=R4-R3
                ms{i}.channel=ms{i}.channel+[0 0 R4-R3];
                ap.free_channel=ap.free_channel-[0 0 R4-R3];
            else
                %preemtion
                needed=R4-R3;
                selection=[];
% ادامه حلقه برای انتخاب کاربر مناسب جهت Preemption
for jc=1:users
    if ms{jc}.active==1 && ms{jc}.t_vho>ms{i}.t_vho && ...
       ms{jc}.handoff_active==1 && sum(ms{jc}.channel)>=needed
        selection=[selection;
                   jc ms{jc}.t_vho-ms{i}.t_vho];
    end
end
end

if numel(selection)>0
    % select best user for preemption
    [~,ix]=max(selection(:,2));
    selection=selection(ix,1);
    
    % get channels of selected user
    ms{i}.channel=ms{i}.channel+ms{selection}.channel;
    call_preempt=call_preempt+1;
    
    % disconnect selected user
    call_drop=call_drop+1;
    ms{selection}.x=0;
    ms{selection}.y=0;
    ms{selection}.duration=0;
    ms{selection}.active=0;
    ms{selection}.t_vho=0;
    ms{selection}.handoff_active=0;
    ms{selection}.channel=[0 0 0];
else
    % can not preempt. drop call
    call_drop=call_drop+1;
    ms{i}.x=0;
    ms{i}.y=0;
    ms{i}.duration=0;
    ms{i}.active=0;
    ms{i}.t_vho=0;
    ms{i}.handoff_active=0;
    ap.free_channel=ap.free_channel+ms{i}.channel;
    ms{i}.channel=[0 0 0];
end
end
end
end
end
end
end

% محاسبه نرخ‌ها
blockR(tid)=call_block/call_total;
dropR(tid)=call_drop/call_total;
end

% ترسیم نمودارها
figure;
plot(tests,dropR,'r^-','linewidth',2)
xlabel(testName);
ylabel('Drop Rate');
grid on

figure;
plot(tests,blockR,'r^-','linewidth',2)
xlabel(testName);
ylabel('Drop Rate');
grid on
