fid = fopen('.\marche9_edited.trc');
tline = fgetl(fid);


i = 1;
rows  = cell(1,508);
while ischar(tline)
    
    rows{i} = tline;
    tline = fgetl(fid);
    i = i +1;
end
fclose(fid);

keys_m = rows{5};

m_cols = [];
for i= 1:170
    
    col = [];
    for j = 7: 506
        
        row = split(rows{j});
        col = [ col; str2double(row(i))  ];
    end
    m_cols = [ m_cols col];
end
ground_X = [];
ground_Y = [];
ground_Z = [];

ground_XX = [];
ground_YY = [];
ground_ZZ = [];

ground_XXX = [];
ground_YYY = [];
ground_ZZZ = [];

%motion line
for g = -3000:3000
    ground_X = [ground_X g];
    ground_Y = [ground_Y 0];
    ground_Z = [ground_Z -250];
end
% side to side line
for gg = -1000:1000
    ground_XX = [ground_XX 0];
    ground_YY = [ground_YY 0];
    ground_ZZ = [ground_ZZ gg];
end
% height line
for ggg = 0:2000
    ground_XXX = [ground_XXX 0];
    ground_YYY = [ground_YYY ggg];
    ground_ZZZ = [ground_ZZZ -250];
end


framesPerSecond = 60;
r = robotics.Rate(framesPerSecond);
t = (0:1/200:2.10)';
count = length(t);

%for view = 1:3
for i = 1:5:count

    hold on;
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    daspect([1 1 1]);
    grid on;
    set(gcf, 'Position', get(0, 'Screensize'));


%         %top view
%         if views == 1
%             set(gca, 'CameraPosition', [1000 10000 -250]);
%             camroll(180);
%         end
%         
%         %side view
%         if views == 2
%             set(gca, 'CameraPosition', [1000 1000 10000]);
%             camroll(135);
%         end

    %front view
    %if views == 3
    set(gca, 'CameraPosition', [10000 1000 0]);
    camroll(90);
    %end

%         if views == 4
% 
%         end
%         
%         if views == 5
%             set(gca, 'CameraPosition', [0 10000 -250]);
%             camroll(90);
%         end


    %ground 

    plot3(ground_X',ground_Y',ground_Z','--');
    plot3(ground_XX',ground_YY',ground_ZZ','--');
    plot3(ground_XXX',ground_YYY',ground_ZZZ','--');

    % torso C7_T10_SUP_STRN

    torso_X = [m_cols(i,15) m_cols(i,27) m_cols(i,18) m_cols(i,24) m_cols(i,15) m_cols(i,18) m_cols(i,15) m_cols(i,27) m_cols(i,24)]*1000;
    torso_Y = [m_cols(i,16) m_cols(i,28) m_cols(i,19) m_cols(i,25) m_cols(i,16) m_cols(i,19) m_cols(i,16) m_cols(i,28) m_cols(i,25)]*1000;
    torso_Z = [m_cols(i,17) m_cols(i,29) m_cols(i,20) m_cols(i,26) m_cols(i,17) m_cols(i,20) m_cols(i,17) m_cols(i,29) m_cols(i,26)]*1000;

    plot3(torso_X',torso_Y',torso_Z');

    % pelvis LASIS_LPSIS_RPSIS_RASIS (LGT RGT)

    pelvis_X = [m_cols(i,30) m_cols(i,33) m_cols(i,36) m_cols(i,39) m_cols(i,30) m_cols(i,36) m_cols(i,30) m_cols(i,33) m_cols(i,39)]*1000;
    pelvis_Y = [m_cols(i,31) m_cols(i,34) m_cols(i,37) m_cols(i,40) m_cols(i,31) m_cols(i,37) m_cols(i,31) m_cols(i,34) m_cols(i,40)]*1000;
    pelvis_Z = [m_cols(i,32) m_cols(i,35) m_cols(i,38) m_cols(i,41) m_cols(i,32) m_cols(i,38) m_cols(i,32) m_cols(i,35) m_cols(i,41)]*1000;

    plot3(pelvis_X',pelvis_Y',pelvis_Z');


    % left knee LLFE_LATT_LMFE		  
    l_knee_X  = [m_cols(i,87) m_cols(i,90) m_cols(i,93) m_cols(i,87)]*1000;
    l_knee_Y  = [m_cols(i,88) m_cols(i,91) m_cols(i,94) m_cols(i,88)]*1000;
    l_knee_Z  = [m_cols(i,89) m_cols(i,92) m_cols(i,95) m_cols(i,89)]*1000;

    plot3(l_knee_X',l_knee_Y',l_knee_Z');

    % right knee RLFE_RATT_RMFE
    r_knee_X  = [m_cols(i,99) m_cols(i,102) m_cols(i,105) m_cols(i,99)]*1000;
    r_knee_Y  = [m_cols(i,100) m_cols(i,103) m_cols(i,106) m_cols(i,100)]*1000;
    r_knee_Z  = [m_cols(i,101) m_cols(i,104) m_cols(i,107) m_cols(i,101)]*1000;

    plot3(r_knee_X',r_knee_Y',r_knee_Z');

    % letf foot POST LSPH_LLM_LCAL
    l_foot_P_X  = [m_cols(i,108) m_cols(i,111) m_cols(i,120) m_cols(i,108)]*1000;
    l_foot_P_Y  = [m_cols(i,109) m_cols(i,112) m_cols(i,121) m_cols(i,109)]*1000;
    l_foot_P_Z  = [m_cols(i,110) m_cols(i,113) m_cols(i,122) m_cols(i,110)]*1000;

    plot3(l_foot_P_X',l_foot_P_Y',l_foot_P_Z');

    % left foot ANT LMFH5_LTT2_LMFH1
    l_foot_A_X  = [m_cols(i,123) m_cols(i,126) m_cols(i,129) m_cols(i,123)]*1000;
    l_foot_A_Y  = [m_cols(i,124) m_cols(i,127) m_cols(i,130) m_cols(i,124)]*1000;
    l_foot_A_Z  = [m_cols(i,125) m_cols(i,128) m_cols(i,131) m_cols(i,125)]*1000;

    plot3(l_foot_A_X',l_foot_A_Y',l_foot_A_Z');

    % left foot connections LMFH5_LSPH LMFH1_LLM

    l_foot_LMFH5_LSPH_X = [m_cols(i,123) m_cols(i,108)]*1000;
    l_foot_LMFH5_LSPH_Y = [m_cols(i,124) m_cols(i,109)]*1000;
    l_foot_LMFH5_LSPH_Z = [m_cols(i,125) m_cols(i,110)]*1000;

    l_foot_LMFH1_LLM_X = [m_cols(i,129) m_cols(i,111)]*1000;
    l_foot_LMFH1_LLM_Y = [m_cols(i,130) m_cols(i,112)]*1000;
    l_foot_LMFH1_LLM_Z = [m_cols(i,131) m_cols(i,113)]*1000;

    plot3(l_foot_LMFH5_LSPH_X',l_foot_LMFH5_LSPH_Y',l_foot_LMFH5_LSPH_Z');
    plot3(l_foot_LMFH1_LLM_X',l_foot_LMFH1_LLM_Y',l_foot_LMFH1_LLM_Z');



    % right foot POST RLM_RSPH_RCAL
    r_foot_P_X  = [m_cols(i,114) m_cols(i,117) m_cols(i,132) m_cols(i,114)]*1000;
    r_foot_P_Y  = [m_cols(i,115) m_cols(i,118) m_cols(i,133) m_cols(i,115)]*1000;
    r_foot_P_Z  = [m_cols(i,116) m_cols(i,119) m_cols(i,134) m_cols(i,116)]*1000;

    plot3(r_foot_P_X',r_foot_P_Y',r_foot_P_Z');

    % right foot ANT RMFH5_RTT2_RMFH1
    r_foot_A_X  = [m_cols(i,135) m_cols(i,138) m_cols(i,141) m_cols(i,135)]*1000;
    r_foot_A_Y  = [m_cols(i,136) m_cols(i,139) m_cols(i,142) m_cols(i,136)]*1000;
    r_foot_A_Z  = [m_cols(i,137) m_cols(i,140) m_cols(i,143) m_cols(i,137)]*1000;

    plot3(r_foot_A_X',r_foot_A_Y',r_foot_A_Z');

    % right foot connections RMFH5_RSPH RMFH1_RLM

    r_foot_RMFH5_RSPH_X = [m_cols(i,135) m_cols(i,117)]*1000;
    r_foot_RMFH5_RSPH_Y = [m_cols(i,136) m_cols(i,118)]*1000;
    r_foot_RMFH5_RSPH_Z = [m_cols(i,137) m_cols(i,119)]*1000;

    r_foot_RMFH1_RLM_X = [m_cols(i,141) m_cols(i,114)]*1000;
    r_foot_RMFH1_RLM_Y = [m_cols(i,142) m_cols(i,115)]*1000;
    r_foot_RMFH1_RLM_Z = [m_cols(i,143) m_cols(i,116)]*1000;

    plot3(r_foot_RMFH1_RLM_X',r_foot_RMFH1_RLM_Y',r_foot_RMFH1_RLM_Z');
    plot3(r_foot_RMFH5_RSPH_X',r_foot_RMFH5_RSPH_Y',r_foot_RMFH5_RSPH_Z');


    % left calf RAJC_LMFE_LLFE

    l_calf_X  = [m_cols(i,150) m_cols(i,93) m_cols(i,87) m_cols(i,150)]*1000;
    l_calf_Y  = [m_cols(i,151) m_cols(i,94) m_cols(i,88) m_cols(i,151)]*1000;
    l_calf_Z  = [m_cols(i,152) m_cols(i,95) m_cols(i,89) m_cols(i,152)]*1000;

    plot3(l_calf_X',l_calf_Y',l_calf_Z');


    % right calf CD_RMFE_RLFE

    r_calf_X  = [m_cols(i,147) m_cols(i,105) m_cols(i,99) m_cols(i,147)]*1000;
    r_calf_Y  = [m_cols(i,148) m_cols(i,106) m_cols(i,100) m_cols(i,148)]*1000;
    r_calf_Z  = [m_cols(i,149) m_cols(i,107) m_cols(i,101) m_cols(i,149)]*1000;

    plot3(r_calf_X',r_calf_Y',r_calf_Z');

    % left quad LGT_LASIS_LATT

    l_quad_X  = [m_cols(i,84) m_cols(i,30) m_cols(i,90) m_cols(i,84)]*1000;
    l_quad_Y  = [m_cols(i,85) m_cols(i,31) m_cols(i,91) m_cols(i,85)]*1000;
    l_quad_Z  = [m_cols(i,86) m_cols(i,32) m_cols(i,92) m_cols(i, 86)]*1000;

    plot3(l_quad_X',l_quad_Y',l_quad_Z');

    % right quad RGT_RASIS_RATT

    r_quad_X  = [m_cols(i,96) m_cols(i,39) m_cols(i,102) m_cols(i,96)]*1000;
    r_quad_Y  = [m_cols(i,97) m_cols(i,40) m_cols(i,103) m_cols(i,97)]*1000;
    r_quad_Z  = [m_cols(i,98) m_cols(i,41) m_cols(i,104) m_cols(i,98)]*1000;

    plot3(r_quad_X',r_quad_Y',r_quad_Z');

    % left amstring LMFE_LASIS_LPSIS

    l_amstring_X  = [m_cols(i,87) m_cols(i,30) m_cols(i,33) m_cols(i,87)]*1000;
    l_amstring_Y  = [m_cols(i,88) m_cols(i,31) m_cols(i,34) m_cols(i,88)]*1000;
    l_amstring_Z  = [m_cols(i,89) m_cols(i,32) m_cols(i,35) m_cols(i, 89)]*1000;

    plot3(l_amstring_X',l_amstring_Y',l_amstring_Z');

    % right amstring RMFE_RASIS_RPSIS

    r_amstring_X  = [m_cols(i,99) m_cols(i,39) m_cols(i,36) m_cols(i,99)]*1000;
    r_amstring_Y  = [m_cols(i,100) m_cols(i,40) m_cols(i,37) m_cols(i,100)]*1000;
    r_amstring_Z  = [m_cols(i,101) m_cols(i,41) m_cols(i,38) m_cols(i,101)]*1000;

    plot3(r_amstring_X',r_amstring_Y',r_amstring_Z'); 

    % full markers plotting 
    for c = 3:3:167

        X = m_cols(i,c)*1000;
        Y = m_cols(i,c+1)*1000;
        Z = m_cols(i,c+2)*1000;

        plot3(X',Y',Z','o');
    end
    
    break
    waitfor(r);
    %clf;
end

%end

%close;
