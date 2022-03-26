
clear all; clc


fid = fopen('.\marche3_ik.mot');
tline = fgetl(fid);
i = 1;
rows  = cell(1,512);
while ischar(tline)
    
    rows{i} = tline;
    tline = fgetl(fid);
    i = i +1;
end
fclose(fid);

keys_s = rows{11};

s_angles = [];
for i= 1:25
    
    col = [];
    for j = 12: 511
        
        row = split(rows{j});
        col = [ col; str2double(row(i))  ];
    end
    s_angles = [ s_angles col];
end



fid = fopen('C:\Users\lorenzo\Desktop\MR_Project\Kinematic_Data.txt');
tline = fgetl(fid);

i = 1;
rows  = cell(1,444);
while ischar(tline)
    
    rows{i} = tline;
    tline = fgetl(fid);
    i = i +1;
end
fclose(fid);

keys_a = rows{15};

k_cols = [];
for i= 1:87
    
    col = [];
    for j = 16: 444
        
        row = split(rows{j});
        col = [ col; str2double(row(i))  ];
    end
    k_cols = [ k_cols col];
end


a_cols = [];
for i= 25:87
    
    col = [];
    for j = 16: 444
        
        row = split(rows{j});
        col = [ col; str2double(row(i))  ];
    end
    a_cols = [ a_cols col];
end

a_angles = [];

for i= 1:9:63
    
    x_a = atan2(a_cols(:,i+3),a_cols(:,i))*180/pi;
    y_a = asin( -a_cols(:,i+6))*180/pi;
    z_a = atan2(a_cols(:,i+7),a_cols(:,i+8))*180/pi;
    
    a_angles = [ a_angles x_a y_a z_a];

end


hold on;

A_RHIP = true;
A_LHIP = true;
A_RKNE = false;
A_LKNE = false;
A_RFOOT = false;
A_LFOOT = false;


t = (0.01:1/200:2.15)';

if ( A_RHIP )
    x_rhip = a_angles(:,4);
    y_rhip = a_angles(:,5);
    z_rhip = a_angles(:,6);
    %plot(t,x_rhip,'DisplayName','rhip x angle');
    plot(t,-y_rhip,'DisplayName','rhip adult angle');
    %plot(t,z_rhip,'DisplayName','rhip z angle');
end

if ( A_LHIP )

    x_lhip = a_angles(:,7);
    y_lhip = a_angles(:,8);
    z_lhip = a_angles(:,9);
    %plot(t,x_lhip,'DisplayName','lhip x angle');
    plot(t,-y_lhip,'DisplayName','lhip adult angle');
    %plot(t,z_lhip,'DisplayName','lhip z angle');
end


if ( A_RKNE )

    x_rknee = a_angles(:,10);
    y_rknee = a_angles(:,11);
    z_rknee = a_angles(:,12);
    %plot(t,x_rknee,'DisplayName','rknee x angle');
    plot(t,-y_rknee,'DisplayName','rknee adult angle');
    %plot(t,z_rknee,'DisplayName','rknee z angle');
end

if( A_LKNE )
    x_lknee = a_angles(:,13);
    y_lknee = a_angles(:,14);
    z_lknee = a_angles(:,15);
    %plot(t,x_lknee,'DisplayName','lknee x angle');
    plot(t,-y_lknee,'DisplayName','lknee adult angle');
    %plot(t,z_lknee,'DisplayName','lknee z angle');
end

if ( A_RFOOT )

    x_rfoot = a_angles(:,16);
    y_rfoot = a_angles(:,17);
    z_rfoot = a_angles(:,18);
    %plot(t,x_rfoot,'DisplayName','rfoot x angle');
    plot(t,y_rfoot,'DisplayName','rfoot adult angle');
    %plot(t,z_rfoot,'DisplayName','rfoot z angle');
end

if( A_LFOOT )
    x_lfoot = a_angles(:,19);
    y_lfoot = a_angles(:,20);
    z_lfoot = a_angles(:,21);
    %plot(t,x_lfoot,'DisplayName','lfoot x angle');
    plot(t,y_lfoot,'DisplayName','lfoot adult angle');
    %plot(t,z_lfoot,'DisplayName','lfoot z angle');
end


PELVIS = false;

RHIP = true;
LHIP = true;
LUMBAR = false;

KNEE = false;
ANKLE = false;
SUBTALAR = false;
MTP = false;

t = (0.0050:1/200:2.50)';

if ( PELVIS )
    pelvis_tilt = s_angles(:,3);
    pelvis_list = s_angles(:,4);
    pelvis_rotation = s_angles(:,5);

    plot(t,pelvis_tilt,'DisplayName','pelvis tilt');
    plot(t,pelvis_list,'DisplayName','pelvis list');
    plot(t,pelvis_rotation,'DisplayName','pelvis rotation');
end

if ( RHIP )
    hip_flexion_r = s_angles(:,9);
    hip_adduction_r = s_angles(:,10);
    hip_rotation_r = s_angles(:,11);

    plot(t,hip_flexion_r,'DisplayName','right hip sirine flexion','LineWidth',2);
    %plot(t,hip_adduction_r,'DisplayName','right hip adduction');
    %plot(t,hip_rotation_r,'DisplayName','right hip rotation');
end

if ( LHIP )
    hip_flexion_l = s_angles(:,16);
    hip_adduction_l = s_angles(:,17);
    hip_rotation_l = s_angles(:,18);

    plot(t,hip_flexion_l,'DisplayName','left hip sirine  flexion','LineWidth',2);
    %plot(t,hip_adduction_l,'DisplayName','left hip adduction');
    %plot(t,hip_rotation_l,'DisplayName','left hip rotation');
end

if ( LUMBAR )
    lumbar_flexion = s_angles(:,23);
    lumbar_bending = s_angles(:,24);
    lumbar_rotation = s_angles(:,25);

    plot(t,lumbar_flexion,'DisplayName','lumbar flexion');
    plot(t,lumbar_bending,'DisplayName','lumbar bending');
    plot(t,lumbar_rotation,'DisplayName','lumbar rotation');
end

if ( KNEE )
    knee_angle_r = s_angles(:,12);
    knee_angle_l = s_angles(:,19);

    plot(t,knee_angle_r,'DisplayName','right knee sirine angle','LineWidth',2);
    plot(t,knee_angle_l,'DisplayName','left knee sirine angle','LineWidth',2);
end

if ( ANKLE )
    ankle_angle_r = s_angles(:,13);
    ankle_angle_l = s_angles(:,20);

    plot(t,ankle_angle_r,'DisplayName','right ankle sirine angle','LineWidth',2);
    plot(t,ankle_angle_l,'DisplayName','left ankle sirine angle','LineWidth',2);
end

if ( SUBTALAR )
    subtal_angle_r = s_angles(:,14);
    subtal_angle_l = s_angles(:,21);

    plot(t,subtal_angle_r,'DisplayName','right subtalr angle');
    plot(t,subtal_angle_l,'DisplayName','left subtalar angle');
end

if ( MTP )
    mtp_angle_r = s_angles(:,15);
    mtp_angle_l = s_angles(:,22);

    %plot(t,mtp_angle_r,'DisplayName','right mtp angle');
    plot(t,mtp_angle_l,'DisplayName','left mtp angle');
end




legend;

