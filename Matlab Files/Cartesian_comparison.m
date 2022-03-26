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

m_cols_S = [];
for i= 1:170;
    
    col = [];
    for j = 7: 506
        
        row = split(rows{j});
        col = [ col; str2double(row(i))  ];
    end
    m_cols_S = [ m_cols_S col];
end



fid = fopen('C:\Users\lorenzo\Desktop\MR_project\Kinematic_Data.txt');
tline = fgetl(fid);

i = 1;
rows  = cell(1,444);
while ischar(tline)
    
    rows{i} = tline;
    tline = fgetl(fid);
    i = i +1;
end
fclose(fid);

keys_k = rows{15};

k_cols = [];
for i= 1:87
    
    col = [];
    for j = 16: 444
        
        row = split(rows{j});
        col = [ col; str2double(row(i))  ];
    end
    k_cols = [ k_cols col];
end



fid = fopen('C:\Users\lorenzo\Desktop\MR_project\Raw_Data.txt');
tline = fgetl(fid);


i = 1;
rows  = cell(1,433);
while ischar(tline)
    
    rows{i} = tline;
    tline = fgetl(fid);
    i = i +1;
end
fclose(fid);

keys_m = rows{3};

m_cols = [];
for i= 1:93
    
    col = [];
    for j = 4: 432
        
        row = split(rows{j});
        col = [ col; str2double(row(i))  ];
    end
    m_cols = [ m_cols col];
end

hold on;

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

for views = 1:3
    for i = 1:5:count

        hold on;
        xlabel('X');
        ylabel('Y');
        zlabel('Z');
        daspect([1 1 1]);
        grid on;
        set(gcf, 'Position', get(0, 'Screensize'));
        
        
        %top view
        if views == 1
            set(gca, 'CameraPosition', [1000 10000 -250]);
            camroll(180);
        end
        
        %side view
        if views == 2
            set(gca, 'CameraPosition', [1000 1000 10000]);
            camroll(135);
        end
        
        %front view
        if views == 3
            set(gca, 'CameraPosition', [10000 1000 0]);
            camroll(90);
        end
        
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

        torso_X = [m_cols_S(i,15) m_cols_S(i,27) m_cols_S(i,18) m_cols_S(i,24) m_cols_S(i,15) m_cols_S(i,18) m_cols_S(i,15) m_cols_S(i,27) m_cols_S(i,24)]*1000;
        torso_Y = [m_cols_S(i,16) m_cols_S(i,28) m_cols_S(i,19) m_cols_S(i,25) m_cols_S(i,16) m_cols_S(i,19) m_cols_S(i,16) m_cols_S(i,28) m_cols_S(i,25)]*1000;
        torso_Z = [m_cols_S(i,17) m_cols_S(i,29) m_cols_S(i,20) m_cols_S(i,26) m_cols_S(i,17) m_cols_S(i,20) m_cols_S(i,17) m_cols_S(i,29) m_cols_S(i,26)]*1000;

        plot3(torso_X',torso_Y',torso_Z');

        % pelvis LASIS_LPSIS_RPSIS_RASIS (LGT RGT)

        pelvis_X = [m_cols_S(i,30) m_cols_S(i,33) m_cols_S(i,36) m_cols_S(i,39) m_cols_S(i,30) m_cols_S(i,36) m_cols_S(i,30) m_cols_S(i,33) m_cols_S(i,39)]*1000;
        pelvis_Y = [m_cols_S(i,31) m_cols_S(i,34) m_cols_S(i,37) m_cols_S(i,40) m_cols_S(i,31) m_cols_S(i,37) m_cols_S(i,31) m_cols_S(i,34) m_cols_S(i,40)]*1000;
        pelvis_Z = [m_cols_S(i,32) m_cols_S(i,35) m_cols_S(i,38) m_cols_S(i,41) m_cols_S(i,32) m_cols_S(i,38) m_cols_S(i,32) m_cols_S(i,35) m_cols_S(i,41)]*1000;

        plot3(pelvis_X',pelvis_Y',pelvis_Z');


        % left knee LLFE_LATT_LMFE		  
        l_knee_X  = [m_cols_S(i,87) m_cols_S(i,90) m_cols_S(i,93) m_cols_S(i,87)]*1000;
        l_knee_Y  = [m_cols_S(i,88) m_cols_S(i,91) m_cols_S(i,94) m_cols_S(i,88)]*1000;
        l_knee_Z  = [m_cols_S(i,89) m_cols_S(i,92) m_cols_S(i,95) m_cols_S(i,89)]*1000;

        plot3(l_knee_X',l_knee_Y',l_knee_Z');

        % right knee RLFE_RATT_RMFE
        r_knee_X  = [m_cols_S(i,99) m_cols_S(i,102) m_cols_S(i,105) m_cols_S(i,99)]*1000;
        r_knee_Y  = [m_cols_S(i,100) m_cols_S(i,103) m_cols_S(i,106) m_cols_S(i,100)]*1000;
        r_knee_Z  = [m_cols_S(i,101) m_cols_S(i,104) m_cols_S(i,107) m_cols_S(i,101)]*1000;

        plot3(r_knee_X',r_knee_Y',r_knee_Z');

        % letf foot POST LSPH_LLM_LCAL
        l_foot_P_X  = [m_cols_S(i,108) m_cols_S(i,111) m_cols_S(i,120) m_cols_S(i,108)]*1000;
        l_foot_P_Y  = [m_cols_S(i,109) m_cols_S(i,112) m_cols_S(i,121) m_cols_S(i,109)]*1000;
        l_foot_P_Z  = [m_cols_S(i,110) m_cols_S(i,113) m_cols_S(i,122) m_cols_S(i,110)]*1000;

        plot3(l_foot_P_X',l_foot_P_Y',l_foot_P_Z');

        % left foot ANT LMFH5_LTT2_LMFH1
        l_foot_A_X  = [m_cols_S(i,123) m_cols_S(i,126) m_cols_S(i,129) m_cols_S(i,123)]*1000;
        l_foot_A_Y  = [m_cols_S(i,124) m_cols_S(i,127) m_cols_S(i,130) m_cols_S(i,124)]*1000;
        l_foot_A_Z  = [m_cols_S(i,125) m_cols_S(i,128) m_cols_S(i,131) m_cols_S(i,125)]*1000;

        plot3(l_foot_A_X',l_foot_A_Y',l_foot_A_Z');

        % left foot connections LMFH5_LSPH LMFH1_LLM

        l_foot_LMFH5_LSPH_X = [m_cols_S(i,123) m_cols_S(i,108)]*1000;
        l_foot_LMFH5_LSPH_Y = [m_cols_S(i,124) m_cols_S(i,109)]*1000;
        l_foot_LMFH5_LSPH_Z = [m_cols_S(i,125) m_cols_S(i,110)]*1000;

        l_foot_LMFH1_LLM_X = [m_cols_S(i,129) m_cols_S(i,111)]*1000;
        l_foot_LMFH1_LLM_Y = [m_cols_S(i,130) m_cols_S(i,112)]*1000;
        l_foot_LMFH1_LLM_Z = [m_cols_S(i,131) m_cols_S(i,113)]*1000;

        plot3(l_foot_LMFH5_LSPH_X',l_foot_LMFH5_LSPH_Y',l_foot_LMFH5_LSPH_Z');
        plot3(l_foot_LMFH1_LLM_X',l_foot_LMFH1_LLM_Y',l_foot_LMFH1_LLM_Z');



        % right foot POST RLM_RSPH_RCAL
        r_foot_P_X  = [m_cols_S(i,114) m_cols_S(i,117) m_cols_S(i,132) m_cols_S(i,114)]*1000;
        r_foot_P_Y  = [m_cols_S(i,115) m_cols_S(i,118) m_cols_S(i,133) m_cols_S(i,115)]*1000;
        r_foot_P_Z  = [m_cols_S(i,116) m_cols_S(i,119) m_cols_S(i,134) m_cols_S(i,116)]*1000;

        plot3(r_foot_P_X',r_foot_P_Y',r_foot_P_Z');

        % right foot ANT RMFH5_RTT2_RMFH1
        r_foot_A_X  = [m_cols_S(i,135) m_cols_S(i,138) m_cols_S(i,141) m_cols_S(i,135)]*1000;
        r_foot_A_Y  = [m_cols_S(i,136) m_cols_S(i,139) m_cols_S(i,142) m_cols_S(i,136)]*1000;
        r_foot_A_Z  = [m_cols_S(i,137) m_cols_S(i,140) m_cols_S(i,143) m_cols_S(i,137)]*1000;

        plot3(r_foot_A_X',r_foot_A_Y',r_foot_A_Z');

        % right foot connections RMFH5_RSPH RMFH1_RLM

        r_foot_RMFH5_RSPH_X = [m_cols_S(i,135) m_cols_S(i,117)]*1000;
        r_foot_RMFH5_RSPH_Y = [m_cols_S(i,136) m_cols_S(i,118)]*1000;
        r_foot_RMFH5_RSPH_Z = [m_cols_S(i,137) m_cols_S(i,119)]*1000;

        r_foot_RMFH1_RLM_X = [m_cols_S(i,141) m_cols_S(i,114)]*1000;
        r_foot_RMFH1_RLM_Y = [m_cols_S(i,142) m_cols_S(i,115)]*1000;
        r_foot_RMFH1_RLM_Z = [m_cols_S(i,143) m_cols_S(i,116)]*1000;

        plot3(r_foot_RMFH1_RLM_X',r_foot_RMFH1_RLM_Y',r_foot_RMFH1_RLM_Z');
        plot3(r_foot_RMFH5_RSPH_X',r_foot_RMFH5_RSPH_Y',r_foot_RMFH5_RSPH_Z');


        % left calf RAJC_LMFE_LLFE

        l_calf_X  = [m_cols_S(i,150) m_cols_S(i,93) m_cols_S(i,87) m_cols_S(i,150)]*1000;
        l_calf_Y  = [m_cols_S(i,151) m_cols_S(i,94) m_cols_S(i,88) m_cols_S(i,151)]*1000;
        l_calf_Z  = [m_cols_S(i,152) m_cols_S(i,95) m_cols_S(i,89) m_cols_S(i,152)]*1000;

        plot3(l_calf_X',l_calf_Y',l_calf_Z');


        % right calf CD_RMFE_RLFE

        r_calf_X  = [m_cols_S(i,147) m_cols_S(i,105) m_cols_S(i,99) m_cols_S(i,147)]*1000;
        r_calf_Y  = [m_cols_S(i,148) m_cols_S(i,106) m_cols_S(i,100) m_cols_S(i,148)]*1000;
        r_calf_Z  = [m_cols_S(i,149) m_cols_S(i,107) m_cols_S(i,101) m_cols_S(i,149)]*1000;

        plot3(r_calf_X',r_calf_Y',r_calf_Z');

        % left quad LGT_LASIS_LATT

        l_quad_X  = [m_cols_S(i,84) m_cols_S(i,30) m_cols_S(i,90) m_cols_S(i,84)]*1000;
        l_quad_Y  = [m_cols_S(i,85) m_cols_S(i,31) m_cols_S(i,91) m_cols_S(i,85)]*1000;
        l_quad_Z  = [m_cols_S(i,86) m_cols_S(i,32) m_cols_S(i,92) m_cols_S(i, 86)]*1000;

        plot3(l_quad_X',l_quad_Y',l_quad_Z');

        % right quad RGT_RASIS_RATT

        r_quad_X  = [m_cols_S(i,96) m_cols_S(i,39) m_cols_S(i,102) m_cols_S(i,96)]*1000;
        r_quad_Y  = [m_cols_S(i,97) m_cols_S(i,40) m_cols_S(i,103) m_cols_S(i,97)]*1000;
        r_quad_Z  = [m_cols_S(i,98) m_cols_S(i,41) m_cols_S(i,104) m_cols_S(i,98)]*1000;

        plot3(r_quad_X',r_quad_Y',r_quad_Z');
        
        % left amstring LMFE_LASIS_LPSIS

        l_amstring_X  = [m_cols_S(i,87) m_cols_S(i,30) m_cols_S(i,33) m_cols_S(i,87)]*1000;
        l_amstring_Y  = [m_cols_S(i,88) m_cols_S(i,31) m_cols_S(i,34) m_cols_S(i,88)]*1000;
        l_amstring_Z  = [m_cols_S(i,89) m_cols_S(i,32) m_cols_S(i,35) m_cols_S(i, 89)]*1000;

        plot3(l_amstring_X',l_amstring_Y',l_amstring_Z');

        % right amstring RMFE_RASIS_RPSIS

        r_amstring_X  = [m_cols_S(i,99) m_cols_S(i,39) m_cols_S(i,36) m_cols_S(i,99)]*1000;
        r_amstring_Y  = [m_cols_S(i,100) m_cols_S(i,40) m_cols_S(i,37) m_cols_S(i,100)]*1000;
        r_amstring_Z  = [m_cols_S(i,101) m_cols_S(i,41) m_cols_S(i,38) m_cols_S(i,101)]*1000;

        plot3(r_amstring_X',r_amstring_Y',r_amstring_Z');       

        % plot markers 
    %     for c = 3:3:170
    %     
    %         X = m_cols_S(i,c)*1000;
    %         Y = m_cols_S(i,c+1)*1000;
    %         Z = m_cols_S(i,c+2)*1000;
    % 
    %         plot3(X',Y',Z','o');
    %     end
    
         % plot kin data 
    
        
    %     tk_pl_X = [k_cols(i,1) k_cols(i,4)];
    %     tk_pl_Y = [k_cols(i,2) k_cols(i,5)];
    %     tk_pl_Z = [k_cols(i,3) k_cols(i,6)];
    % 
    %     pl_rfm_X = [k_cols(i,4) k_cols(i,7)];
    %     pl_rfm_Y = [k_cols(i,5) k_cols(i,8)];
    %     pl_rfm_Z = [k_cols(i,6) k_cols(i,9)];
    % 
    %     pl_lfm_X = [k_cols(i,4) k_cols(i,10)];
    %     pl_lfm_Y = [k_cols(i,5) k_cols(i,11)];
    %     pl_lfm_Z = [k_cols(i,6) k_cols(i,12)];
    % 
    %     rfm_rtb_X = [k_cols(i,7) k_cols(i,13)];
    %     rfm_rtb_Y = [k_cols(i,8) k_cols(i,14)];
    %     rfm_rtb_Z = [k_cols(i,9) k_cols(i,15)];
    % 
    %     lfm_ltb_X = [k_cols(i,10) k_cols(i,16)];
    %     lfm_ltb_Y = [k_cols(i,11) k_cols(i,17)];
    %     lfm_ltb_Z = [k_cols(i,12) k_cols(i,18)];
    % 
    %     rtb_rft_X = [k_cols(i,13) k_cols(i,19)];
    %     rtb_rft_Y = [k_cols(i,14) k_cols(i,20)];
    %     rtb_rft_Z = [k_cols(i,15) k_cols(i,21)];
    % 
    %     ltb_lft_X = [k_cols(i,16) k_cols(i,22)];
    %     ltb_lft_Y = [k_cols(i,17) k_cols(i,23)];
    %     ltb_lft_Z = [k_cols(i,18) k_cols(i,24)];
    % 
    % 
    %     plot3(tk_pl_X',tk_pl_Y',tk_pl_Z','--');
    %     plot3(pl_rfm_X',pl_rfm_Y',pl_rfm_Z','--');
    %     plot3(pl_lfm_X',pl_lfm_Y',pl_lfm_Z','--');
    %     plot3(rfm_rtb_X',rfm_rtb_Y',rfm_rtb_Z','--');
    %     plot3(lfm_ltb_X',lfm_ltb_Y',lfm_ltb_Z','--');
    %     plot3(rtb_rft_X',rtb_rft_Y',rtb_rft_Z','--');
    %     plot3(ltb_lft_X',ltb_lft_Y',ltb_lft_Z','--');

        
        % markers data
        
        %torso C7_T10_clav_strn
        torso_X = [m_cols(i,1) m_cols(i,4) m_cols(i,7) m_cols(i,10) m_cols(i,1) m_cols(i,7) m_cols(i,1) m_cols(i,4) m_cols(i,10)] - 250;
        torso_Y = [m_cols(i,2) m_cols(i,5) m_cols(i,8) m_cols(i,11) m_cols(i,2) m_cols(i,8) m_cols(i,2) m_cols(i,5) m_cols(i,11)];
        torso_Z = [m_cols(i,3) m_cols(i,6) m_cols(i,9) m_cols(i,12) m_cols(i,3) m_cols(i,9) m_cols(i,3) m_cols(i,6) m_cols(i,12)] - 500;

%         C7_rbak_T10_X = [m_cols(i,1) m_cols(i,13) m_cols(i,4)];
%         C7_rbak_T10_Y = [m_cols(i,2) m_cols(i,14) m_cols(i,5)];
%         C7_rbak_T10_Z = [m_cols(i,3) m_cols(i,15) m_cols(i,6)];

        plot3(-torso_Z',torso_Y',-torso_X');
%         plot3(-C7_rbak_T10_Z',C7_rbak_T10_Y',C7_rbak_T10_X');


%         %left arm 
%         clav_lsho_X = [ m_cols(i,7) m_cols(i,16)];
%         clav_lsho_Y = [ m_cols(i,8) m_cols(i,17)];
%         clav_lsho_Z = [ m_cols(i,9) m_cols(i,18)];
% 
%         lsho_lelb_X = [ m_cols(i,16) m_cols(i,19)];
%         lsho_lelb_Y = [ m_cols(i,17) m_cols(i,20)];
%         lsho_lelb_Z = [ m_cols(i,18) m_cols(i,21)];
% 
%         lelb_lwra_X = [ m_cols(i,19) m_cols(i,22)];
%         lelb_lwra_Y = [ m_cols(i,20) m_cols(i,23)];
%         lelb_lwra_Z = [ m_cols(i,21) m_cols(i,24)];
% 
%         lelb_lwrb_X = [ m_cols(i,19) m_cols(i,25)];
%         lelb_lwrb_Y = [ m_cols(i,20) m_cols(i,26)];
%         lelb_lwrb_Z = [ m_cols(i,21) m_cols(i,27)];
% 
%         lwra_lwrb_lfin_X = [ m_cols(i,22) m_cols(i,25) m_cols(i,28) m_cols(i,22)];
%         lwra_lwrb_lfin_Y = [ m_cols(i,23) m_cols(i,26) m_cols(i,29) m_cols(i,23)];
%         lwra_lwrb_lfin_Z = [ m_cols(i,24) m_cols(i,27) m_cols(i,30) m_cols(i,24)];
% 
%         plot3(-clav_lsho_Z',clav_lsho_Y',clav_lsho_X');
%         plot3(-lsho_lelb_Z',lsho_lelb_Y',lsho_lelb_X');
%         plot3(-lelb_lwra_Z',lelb_lwra_Y',lelb_lwra_X');
%         plot3(-lelb_lwrb_Z',lelb_lwrb_Y',lelb_lwrb_X');
%         plot3(-lwra_lwrb_lfin_Z',lwra_lwrb_lfin_Y',lwra_lwrb_lfin_X');
% 
%         %right arm 
%         clav_rsho_X = [ m_cols(i,7) m_cols(i,31)];
%         clav_rsho_Y = [ m_cols(i,8) m_cols(i,32)];
%         clav_rsho_Z = [ m_cols(i,9) m_cols(i,33)];
% 
%         rsho_relb_X = [ m_cols(i,31) m_cols(i,34)];
%         rsho_relb_Y = [ m_cols(i,32) m_cols(i,35)];
%         rsho_relb_Z = [ m_cols(i,33) m_cols(i,36)];
% 
%         relb_rwra_X = [ m_cols(i,34) m_cols(i,37)];
%         relb_rwra_Y = [ m_cols(i,35) m_cols(i,38)];
%         relb_rwra_Z = [ m_cols(i,36) m_cols(i,39)];
% 
%         relb_rwrb_X = [ m_cols(i,34) m_cols(i,40)];
%         relb_rwrb_Y = [ m_cols(i,35) m_cols(i,41)];
%         relb_rwrb_Z = [ m_cols(i,36) m_cols(i,42)];
% 
%         rwra_rwrb_rfin_X = [ m_cols(i,37) m_cols(i,40) m_cols(i,43) m_cols(i,37)];
%         rwra_rwrb_rfin_Y = [ m_cols(i,38) m_cols(i,41) m_cols(i,44) m_cols(i,38)];
%         rwra_rwrb_rfin_Z = [ m_cols(i,39) m_cols(i,42) m_cols(i,45) m_cols(i,39)];
% 
%         plot3(-clav_rsho_Z',clav_rsho_Y',clav_rsho_X');
%         plot3(-rsho_relb_Z',rsho_relb_Y',rsho_relb_X');
%         plot3(-relb_rwra_Z',relb_rwra_Y',relb_rwra_X');
%         plot3(-relb_rwrb_Z',relb_rwrb_Y',relb_rwrb_X');
%         plot3(-rwra_rwrb_rfin_Z',rwra_rwrb_rfin_Y',rwra_rwrb_rfin_X');


        %pelvis lasi_rasi_lpsi_rpsi

        pelvis_X = [m_cols(i,46) m_cols(i,49) m_cols(i,52) m_cols(i,55) m_cols(i,46) m_cols(i,52) m_cols(i,46) m_cols(i,49) m_cols(i,55)] - 250;
        pelvis_Y = [m_cols(i,47) m_cols(i,50) m_cols(i,53) m_cols(i,56) m_cols(i,47) m_cols(i,53) m_cols(i,47) m_cols(i,50) m_cols(i,56)];
        pelvis_Z = [m_cols(i,48) m_cols(i,51) m_cols(i,54) m_cols(i,57) m_cols(i,48) m_cols(i,54) m_cols(i,48) m_cols(i,51) m_cols(i,57)] - 500;;

        plot3(-pelvis_Z',pelvis_Y',-pelvis_X');

        %left leg 

        lasi_lthb_X = [ m_cols(i,46) m_cols(i,58) ] - 250;
        lasi_lthb_Y = [ m_cols(i,47) m_cols(i,59) ];
        lasi_lthb_Z = [ m_cols(i,48) m_cols(i,60) ] - 500;

        lasi_lkne_X = [ m_cols(i,46) m_cols(i,61) ] - 250;
        lasi_lkne_Y = [ m_cols(i,47) m_cols(i,62) ];
        lasi_lkne_Z = [ m_cols(i,48) m_cols(i,63) ] - 500;

        lthb_lkne_X = [ m_cols(i,58) m_cols(i,61) ] - 250;
        lthb_lkne_Y = [ m_cols(i,59) m_cols(i,62) ];
        lthb_lkne_Z = [ m_cols(i,60) m_cols(i,63) ] - 500;

        lpsi_lkne_X = [ m_cols(i,52) m_cols(i,61) ] - 250;
        lpsi_lkne_Y = [ m_cols(i,53) m_cols(i,62) ];
        lpsi_lkne_Z = [ m_cols(i,54) m_cols(i,63) ] - 500;

        lkne_ltib_X = [ m_cols(i,61) m_cols(i,64) ] - 250;
        lkne_ltib_Y = [ m_cols(i,62) m_cols(i,65) ];
        lkne_ltib_Z = [ m_cols(i,63) m_cols(i,66) ] - 500;

        lkne_lank_X = [ m_cols(i,61) m_cols(i,67) ] - 250;
        lkne_lank_Y = [ m_cols(i,62) m_cols(i,68) ];
        lkne_lank_Z = [ m_cols(i,63) m_cols(i,69) ] - 500;

        ltib_lank_X = [ m_cols(i,64) m_cols(i,67) ] - 250;
        ltib_lank_Y = [ m_cols(i,65) m_cols(i,68) ];
        ltib_lank_Z = [ m_cols(i,66) m_cols(i,69) ] - 500;

        lank_lhee_ltoe_X = [ m_cols(i,67) m_cols(i,70) m_cols(i,73) m_cols(i,67)] - 250;
        lank_lhee_ltoe_Y = [ m_cols(i,68) m_cols(i,71) m_cols(i,74) m_cols(i,68)];
        lank_lhee_ltoe_Z = [ m_cols(i,69) m_cols(i,72) m_cols(i,75) m_cols(i,69)] - 500;

        plot3(-lasi_lthb_Z',lasi_lthb_Y',-lasi_lthb_X');
        plot3(-lasi_lkne_Z',lasi_lkne_Y',-lasi_lkne_X');
        plot3(-lthb_lkne_Z',lthb_lkne_Y',-lthb_lkne_X');
        plot3(-lpsi_lkne_Z',lpsi_lkne_Y',-lpsi_lkne_X');
        plot3(-lkne_ltib_Z',lkne_ltib_Y',-lkne_ltib_X');
        plot3(-lkne_lank_Z',lkne_lank_Y',-lkne_lank_X');
        plot3(-ltib_lank_Z',ltib_lank_Y',-ltib_lank_X');
        plot3(-lank_lhee_ltoe_Z',lank_lhee_ltoe_Y',-lank_lhee_ltoe_X');

        %left leg 

        rasi_rthb_X = [ m_cols(i,49) m_cols(i,76) ] - 250;
        rasi_rthb_Y = [ m_cols(i,50) m_cols(i,77) ];
        rasi_rthb_Z = [ m_cols(i,51) m_cols(i,78) ] - 500;

        rasi_rkne_X = [ m_cols(i,49) m_cols(i,79) ] - 250;
        rasi_rkne_Y = [ m_cols(i,50) m_cols(i,80) ];
        rasi_rkne_Z = [ m_cols(i,51) m_cols(i,81) ] - 500;

        rthb_rkne_X = [ m_cols(i,76) m_cols(i,79) ] - 250;
        rthb_rkne_Y = [ m_cols(i,77) m_cols(i,80) ];
        rthb_rkne_Z = [ m_cols(i,78) m_cols(i,81) ] - 500;

        rpsi_rkne_X = [ m_cols(i,55) m_cols(i,79) ] - 250;
        rpsi_rkne_Y = [ m_cols(i,56) m_cols(i,80) ];
        rpsi_rkne_Z = [ m_cols(i,57) m_cols(i,81) ] - 500;

        rkne_rtib_X = [ m_cols(i,79) m_cols(i,82) ] - 250;
        rkne_rtib_Y = [ m_cols(i,80) m_cols(i,83) ];
        rkne_rtib_Z = [ m_cols(i,81) m_cols(i,84) ] - 500;

        rkne_rank_X = [ m_cols(i,79) m_cols(i,85) ] - 250;
        rkne_rank_Y = [ m_cols(i,80) m_cols(i,86) ];
        rkne_rank_Z = [ m_cols(i,81) m_cols(i,87) ] - 500;

        rtib_rank_X = [ m_cols(i,82) m_cols(i,85) ] - 250;
        rtib_rank_Y = [ m_cols(i,83) m_cols(i,86) ];
        rtib_rank_Z = [ m_cols(i,84) m_cols(i,87) ] - 500;

        rank_rhee_rtoe_X = [ m_cols(i,85) m_cols(i,88) m_cols(i,91) m_cols(i,85)] - 250;
        rank_rhee_rtoe_Y = [ m_cols(i,86) m_cols(i,89) m_cols(i,92) m_cols(i,86)];
        rank_rhee_rtoe_Z = [ m_cols(i,87) m_cols(i,90) m_cols(i,93) m_cols(i,87)] - 500;

        plot3(-rasi_rthb_Z',rasi_rthb_Y',-rasi_rthb_X');
        plot3(-rasi_rkne_Z',rasi_rkne_Y',-rasi_rkne_X');
        plot3(-rthb_rkne_Z',rthb_rkne_Y',-rthb_rkne_X');
        plot3(-rpsi_rkne_Z',rpsi_rkne_Y',-rpsi_rkne_X');
        plot3(-rkne_rtib_Z',rkne_rtib_Y',-rkne_rtib_X');
        plot3(-rkne_rank_Z',rkne_rank_Y',-rkne_rank_X');
        plot3(-rtib_rank_Z',rtib_rank_Y',-rtib_rank_X');
        plot3(-rank_rhee_rtoe_Z',rank_rhee_rtoe_Y',-rank_rhee_rtoe_X');

    %     for c = 1:3:93
    %     
    %         X = m_cols(i,c);
    %         Y = m_cols(i,c+1);
    %         Z = m_cols(i,c+2);
    %         plot3(X,Y,Z,'o');
    % 
    %     end
        waitfor(r);
        clf;


    end
end
close;

