fid = fopen('.\Kinematic_Data.txt');
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

a_cols = [];
for i= 25:87
    
    col = [];
    for j = 16: 444
        
        row = split(rows{j});
        col = [ col; str2double(row(i))  ];
    end
    a_cols = [ a_cols col];
end



% for c = 1:3:87
%     
%     X = cols(:,c);
%     Y = cols(:,c+1);
%     Z = cols(:,c+2);
%     plot3(X',Y',Z')
%     
% end


fid = fopen('C:\Users\Utente\Desktop\Raw_Data.txt');
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

% for c = 1:3:93
%     
%     X = cols(:,c);
%     Y = cols(:,c+1);
%     Z = cols(:,c+2);
%     plot3(X',Y',Z')
%     
% end


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
for g = -200:300
    ground_X = [ground_X g];
    ground_Y = [ground_Y 0];
    ground_Z = [ground_Z -250];
end
% side to side line
for gg = -2000:2000
    ground_XX = [ground_XX 0];
    ground_YY = [ground_YY 0];
    ground_ZZ = [ground_ZZ gg];
end
% height line
for ggg = 0:1500
    ground_XXX = [ground_XXX 0];
    ground_YYY = [ground_YYY ggg];
    ground_ZZZ = [ground_ZZZ -250];
end


framesPerSecond = 60;
r = robotics.Rate(framesPerSecond);
time = (0.01:1/200:2.15)';
count = length(time);


% %front view
% set(gca, 'CameraPosition', [250 750 -10000]);
% camroll(19);

% % left side view
% set(gca, 'CameraPosition', [-10000 0 0]);
% camroll(-90);

% % right side view
% set(gca, 'CameraPosition', [10000 0 0]);
% camroll(90);


% % perspective right front view 
% set(gca, 'CameraPosition', [7000 10000 -10000]);
% camroll(45);

% % perspective right back view 
% set(gca, 'CameraPosition', [7000 10000 10000]);
% camroll(125);

% % perspective right front view 
% set(gca, 'CameraPosition', [-7000 5000 -10000]);
% camroll(-60);




% modify the step to downsample
for views = 1:2
    for i = 1:count

        hold on;
        xlabel('X');
        ylabel('Y');
        zlabel('Z');
        daspect([1 1 1]);
        set(gcf, 'Position', get(0, 'Screensize'));
        
        % perspective right front view 
        if views == 1
            set(gca, 'CameraPosition', [7000 10000 -10000]);
            camroll(45);
        end
        
        % right side view 
        if views == 2

            set(gca, 'CameraPosition', [10000 0 0]);
            camroll(90);

        end

        %ground
        plot3(ground_X',ground_Y',ground_Z','--');
        plot3(ground_XX',ground_YY',ground_ZZ','--');
        plot3(ground_XXX',ground_YYY',ground_ZZZ','--');


        tk_pl_X = [k_cols(i,1) k_cols(i,4)];
        tk_pl_Y = [k_cols(i,2) k_cols(i,5)];
        tk_pl_Z = [k_cols(i,3) k_cols(i,6)];

        pl_rfm_X = [k_cols(i,4) k_cols(i,7)];
        pl_rfm_Y = [k_cols(i,5) k_cols(i,8)];
        pl_rfm_Z = [k_cols(i,6) k_cols(i,9)];

        pl_lfm_X = [k_cols(i,4) k_cols(i,10)];
        pl_lfm_Y = [k_cols(i,5) k_cols(i,11)];
        pl_lfm_Z = [k_cols(i,6) k_cols(i,12)];

        rfm_rtb_X = [k_cols(i,7) k_cols(i,13)];
        rfm_rtb_Y = [k_cols(i,8) k_cols(i,14)];
        rfm_rtb_Z = [k_cols(i,9) k_cols(i,15)];

        lfm_ltb_X = [k_cols(i,10) k_cols(i,16)];
        lfm_ltb_Y = [k_cols(i,11) k_cols(i,17)];
        lfm_ltb_Z = [k_cols(i,12) k_cols(i,18)];

        rtb_rft_X = [k_cols(i,13) k_cols(i,19)];
        rtb_rft_Y = [k_cols(i,14) k_cols(i,20)];
        rtb_rft_Z = [k_cols(i,15) k_cols(i,21)];

        ltb_lft_X = [k_cols(i,16) k_cols(i,22)];
        ltb_lft_Y = [k_cols(i,17) k_cols(i,23)];
        ltb_lft_Z = [k_cols(i,18) k_cols(i,24)];


        plot3(tk_pl_X',tk_pl_Y',tk_pl_Z','--');
        plot3(pl_rfm_X',pl_rfm_Y',pl_rfm_Z','--');
        plot3(pl_lfm_X',pl_lfm_Y',pl_lfm_Z','--');
        plot3(rfm_rtb_X',rfm_rtb_Y',rfm_rtb_Z','--');
        plot3(lfm_ltb_X',lfm_ltb_Y',lfm_ltb_Z','--');
        plot3(rtb_rft_X',rtb_rft_Y',rtb_rft_Z','--');
        plot3(ltb_lft_X',ltb_lft_Y',ltb_lft_Z','--');


        % pelvis frame point parallel to x y z - origin
        X_x = [k_cols(i,4) k_cols(i,4)-100];
        X_y = [k_cols(i,5) k_cols(i,5)];
        X_z = [k_cols(i,6) k_cols(i,6)];

        Y_x = [k_cols(i,4) k_cols(i,4)];
        Y_y = [k_cols(i,5) k_cols(i,5)-100];
        Y_z = [k_cols(i,6) k_cols(i,6)];

        Z_x = [k_cols(i,4) k_cols(i,4)];
        Z_y = [k_cols(i,5) k_cols(i,5)];
        Z_z = [k_cols(i,6) k_cols(i,6)-100];

        % axis
        plot3(X_x',X_y',X_z','r','LineWidth', 2);
        plot3(Y_x',Y_y',Y_z','b','LineWidth', 2);
        plot3(Z_x',Z_y',Z_z','g','LineWidth', 2);


        X = [ 100 0 0 ];
        Y = [ 0 100 0 ];
        Z = [ 0 0 100 ];

        f = 1;
        R_tk_pl = [[a_cols(i,f) a_cols(i,f+1) a_cols(i,f+2)];[a_cols(i,f+3) a_cols(i,f+4) a_cols(i,f+5)];[a_cols(i,f+6) a_cols(i,f+7) a_cols(i,f+8)]];


        % rotated frame
        X_tk = (R_tk_pl*X')';
        Y_tk = (R_tk_pl*Y')';
        Z_tk = (R_tk_pl*Z')';

        % trunk frame point parallel to x y z - origin

        X_x = [k_cols(i,1) k_cols(i,1)+X_tk(1)];
        X_y = [k_cols(i,2) k_cols(i,2)+X_tk(2)];
        X_z = [k_cols(i,3) k_cols(i,3)+X_tk(3)];

        Y_x = [k_cols(i,1) k_cols(i,1)+Y_tk(1)];
        Y_y = [k_cols(i,2) k_cols(i,2)+Y_tk(2)];
        Y_z = [k_cols(i,3) k_cols(i,3)+Y_tk(3)];

        Z_x = [k_cols(i,1) k_cols(i,1)+Z_tk(1)];
        Z_y = [k_cols(i,2) k_cols(i,2)+Z_tk(2)];
        Z_z = [k_cols(i,3) k_cols(i,3)+Z_tk(3)];



        %axis
        plot3(X_x',X_y',X_z','r','LineWidth', 2);
        plot3(Y_x',Y_y',Y_z','b','LineWidth', 2);
        plot3(Z_x',Z_y',Z_z','g','LineWidth', 2);



        f = 10;
        R_rfm_pl = [[a_cols(i,f) a_cols(i,f+1) a_cols(i,f+2)];[a_cols(i,f+3) a_cols(i,f+4) a_cols(i,f+5)];[a_cols(i,f+6) a_cols(i,f+7) a_cols(i,f+8)]];
        

        % rotated frame
        X_rmf = (R_rfm_pl*X')';
        Y_rmf = (R_rfm_pl*Y')';
        Z_rmf = (R_rfm_pl*Z')';

        % trunk frame point parallel to x y z - origin

        X_x = [k_cols(i,10) k_cols(i,10)+X_rmf(1)];
        X_y = [k_cols(i,11) k_cols(i,11)+X_rmf(2)];
        X_z = [k_cols(i,12) k_cols(i,12)+X_rmf(3)];

        Y_x = [k_cols(i,10) k_cols(i,10)+Y_rmf(1)];
        Y_y = [k_cols(i,11) k_cols(i,11)+Y_rmf(2)];
        Y_z = [k_cols(i,12) k_cols(i,12)+Y_rmf(3)];

        Z_x = [k_cols(i,10) k_cols(i,10)+Z_rmf(1)];
        Z_y = [k_cols(i,11) k_cols(i,11)+Z_rmf(2)];
        Z_z = [k_cols(i,12) k_cols(i,12)+Z_rmf(3)];



        %axis
        plot3(X_x',X_y',X_z','r','LineWidth', 2);
        plot3(Y_x',Y_y',Y_z','b','LineWidth', 2);
        plot3(Z_x',Z_y',Z_z','g','LineWidth', 2);

        f = 19;
        R_lfm_pl = [[a_cols(i,f) a_cols(i,f+1) a_cols(i,f+2)];[a_cols(i,f+3) a_cols(i,f+4) a_cols(i,f+5)];[a_cols(i,f+6) a_cols(i,f+7) a_cols(i,f+8)]];


            % rotated frame
        X_lmf = (R_lfm_pl*X')';
        Y_lmf = (R_lfm_pl*Y')';
        Z_lmf = (R_lfm_pl*Z')';

        % trunk frame point parallel to x y z - origin

        X_x = [k_cols(i,7) k_cols(i,7)+X_lmf(1)];
        X_y = [k_cols(i,8) k_cols(i,8)+X_lmf(2)];
        X_z = [k_cols(i,9) k_cols(i,9)+X_lmf(3)];

        Y_x = [k_cols(i,7) k_cols(i,7)+Y_lmf(1)];
        Y_y = [k_cols(i,8) k_cols(i,8)+Y_lmf(2)];
        Y_z = [k_cols(i,9) k_cols(i,9)+Y_lmf(3)];

        Z_x = [k_cols(i,7) k_cols(i,7)+Z_lmf(1)];
        Z_y = [k_cols(i,8) k_cols(i,8)+Z_lmf(2)];
        Z_z = [k_cols(i,9) k_cols(i,9)+Z_lmf(3)];



        %axis
        plot3(X_x',X_y',X_z','r','LineWidth', 2);
        plot3(Y_x',Y_y',Y_z','b','LineWidth', 2);
        plot3(Z_x',Z_y',Z_z','g','LineWidth', 2);


        f = 28;
        R_rtb_rfm = [[a_cols(i,f) a_cols(i,f+1) a_cols(i,f+2)];[a_cols(i,f+3) a_cols(i,f+4) a_cols(i,f+5)];[a_cols(i,f+6) a_cols(i,f+7) a_cols(i,f+8)]];


                % rotated frame
        X_rtb = (R_rtb_rfm*X_rmf')';
        Y_rtb = (R_rtb_rfm*Y_rmf')';
        Z_rtb = (R_rtb_rfm*Z_rmf')';

        % trunk frame point parallel to x y z - origin

        X_x = [k_cols(i,13) k_cols(i,13)+X_rtb(1)];
        X_y = [k_cols(i,14) k_cols(i,14)+X_rtb(2)];
        X_z = [k_cols(i,15) k_cols(i,15)+X_rtb(3)];

        Y_x = [k_cols(i,13) k_cols(i,13)+Y_rtb(1)];
        Y_y = [k_cols(i,14) k_cols(i,14)+Y_rtb(2)];
        Y_z = [k_cols(i,15) k_cols(i,15)+Y_rtb(3)];

        Z_x = [k_cols(i,13) k_cols(i,13)+Z_rtb(1)];
        Z_y = [k_cols(i,14) k_cols(i,14)+Z_rtb(2)];
        Z_z = [k_cols(i,15) k_cols(i,15)+Z_rtb(3)];



        %axis
        plot3(X_x',X_y',X_z','r','LineWidth', 2);
        plot3(Y_x',Y_y',Y_z','b','LineWidth', 2);
        plot3(Z_x',Z_y',Z_z','g','LineWidth', 2);

        f = 37;
        R_ltb_lfm = [[a_cols(i,f) a_cols(i,f+1) a_cols(i,f+2)];[a_cols(i,f+3) a_cols(i,f+4) a_cols(i,f+5)];[a_cols(i,f+6) a_cols(i,f+7) a_cols(i,f+8)]];

                % rotated frame
        X_ltb = (R_ltb_lfm*X_lmf')';
        Y_ltb = (R_ltb_lfm*Y_lmf')';
        Z_ltb = (R_ltb_lfm*Z_lmf')';

        % trunk frame point parallel to x y z - origin

        X_x = [k_cols(i,16) k_cols(i,16)+X_ltb(1)];
        X_y = [k_cols(i,17) k_cols(i,17)+X_ltb(2)];
        X_z = [k_cols(i,18) k_cols(i,18)+X_ltb(3)];

        Y_x = [k_cols(i,16) k_cols(i,16)+Y_ltb(1)];
        Y_y = [k_cols(i,17) k_cols(i,17)+Y_ltb(2)];
        Y_z = [k_cols(i,18) k_cols(i,18)+Y_ltb(3)];

        Z_x = [k_cols(i,16) k_cols(i,16)+Z_ltb(1)];
        Z_y = [k_cols(i,17) k_cols(i,17)+Z_ltb(2)];
        Z_z = [k_cols(i,18) k_cols(i,18)+Z_ltb(3)];



        %axis
        plot3(X_x',X_y',X_z','r','LineWidth', 2);
        plot3(Y_x',Y_y',Y_z','b','LineWidth', 2);
        plot3(Z_x',Z_y',Z_z','g','LineWidth', 2);

        f = 46;
        R_rft_rtb = [[a_cols(i,f) a_cols(i,f+1) a_cols(i,f+2)];[a_cols(i,f+3) a_cols(i,f+4) a_cols(i,f+5)];[a_cols(i,f+6) a_cols(i,f+7) a_cols(i,f+8)]];

                % rotated frame
        X_rft = (R_rft_rtb*X_rtb')';
        Y_rft = (R_rft_rtb*Y_rtb')';
        Z_rft = (R_rft_rtb*Z_rtb')';

        % trunk frame point parallel to x y z - origin

        X_x = [k_cols(i,19) k_cols(i,19)+X_rft(1)];
        X_y = [k_cols(i,20) k_cols(i,20)+X_rft(2)];
        X_z = [k_cols(i,21) k_cols(i,21)+X_rft(3)];

        Y_x = [k_cols(i,19) k_cols(i,19)+Y_rft(1)];
        Y_y = [k_cols(i,20) k_cols(i,20)+Y_rft(2)];
        Y_z = [k_cols(i,21) k_cols(i,21)+Y_rft(3)];

        Z_x = [k_cols(i,19) k_cols(i,19)+Z_rft(1)];
        Z_y = [k_cols(i,20) k_cols(i,20)+Z_rft(2)];
        Z_z = [k_cols(i,21) k_cols(i,21)+Z_rft(3)];



        %axis
        plot3(X_x',X_y',X_z','r','LineWidth', 2);
        plot3(Y_x',Y_y',Y_z','b','LineWidth', 2);
        plot3(Z_x',Z_y',Z_z','g','LineWidth', 2);

        f = 55;
        R_lft_ltb = [[a_cols(i,f) a_cols(i,f+1) a_cols(i,f+2)];[a_cols(i,f+3) a_cols(i,f+4) a_cols(i,f+5)];[a_cols(i,f+6) a_cols(i,f+7) a_cols(i,f+8)]];

                % rotated frame
        X_lft = (R_lft_ltb*X_ltb')';
        Y_lft = (R_lft_ltb*Y_ltb')';
        Z_lft = (R_lft_ltb*Z_ltb')';

        % trunk frame point parallel to x y z - origin

        X_x = [k_cols(i,22) k_cols(i,22)+X_lft(1)];
        X_y = [k_cols(i,23) k_cols(i,23)+X_lft(2)];
        X_z = [k_cols(i,24) k_cols(i,24)+X_lft(3)];

        Y_x = [k_cols(i,22) k_cols(i,22)+Y_lft(1)];
        Y_y = [k_cols(i,23) k_cols(i,23)+Y_lft(2)];
        Y_z = [k_cols(i,24) k_cols(i,24)+Y_lft(3)];

        Z_x = [k_cols(i,22) k_cols(i,22)+Z_lft(1)];
        Z_y = [k_cols(i,23) k_cols(i,23)+Z_lft(2)];
        Z_z = [k_cols(i,24) k_cols(i,24)+Z_lft(3)];



        %axis
        plot3(X_x',X_y',X_z','r','LineWidth', 2);
        plot3(Y_x',Y_y',Y_z','b','LineWidth', 2);
        plot3(Z_x',Z_y',Z_z','g','LineWidth', 2);


            %torso C7_T10_clav_strn
        torso_X = [m_cols(i,1) m_cols(i,4) m_cols(i,7) m_cols(i,10) m_cols(i,1) m_cols(i,7) m_cols(i,1) m_cols(i,4) m_cols(i,10)];
        torso_Y = [m_cols(i,2) m_cols(i,5) m_cols(i,8) m_cols(i,11) m_cols(i,2) m_cols(i,8) m_cols(i,2) m_cols(i,5) m_cols(i,11)];
        torso_Z = [m_cols(i,3) m_cols(i,6) m_cols(i,9) m_cols(i,12) m_cols(i,3) m_cols(i,9) m_cols(i,3) m_cols(i,6) m_cols(i,12)];

        C7_rbak_T10_X = [m_cols(i,1) m_cols(i,13) m_cols(i,4)];
        C7_rbak_T10_Y = [m_cols(i,2) m_cols(i,14) m_cols(i,5)];
        C7_rbak_T10_Z = [m_cols(i,3) m_cols(i,15) m_cols(i,6)];

        plot3(torso_X',torso_Y',torso_Z');
%         plot3(C7_rbak_T10_X',C7_rbak_T10_Y',C7_rbak_T10_Z');


        %left arm 
        clav_lsho_X = [ m_cols(i,7) m_cols(i,16)];
        clav_lsho_Y = [ m_cols(i,8) m_cols(i,17)];
        clav_lsho_Z = [ m_cols(i,9) m_cols(i,18)];

        lsho_lelb_X = [ m_cols(i,16) m_cols(i,19)];
        lsho_lelb_Y = [ m_cols(i,17) m_cols(i,20)];
        lsho_lelb_Z = [ m_cols(i,18) m_cols(i,21)];

        lelb_lwra_X = [ m_cols(i,19) m_cols(i,22)];
        lelb_lwra_Y = [ m_cols(i,20) m_cols(i,23)];
        lelb_lwra_Z = [ m_cols(i,21) m_cols(i,24)];

        lelb_lwrb_X = [ m_cols(i,19) m_cols(i,25)];
        lelb_lwrb_Y = [ m_cols(i,20) m_cols(i,26)];
        lelb_lwrb_Z = [ m_cols(i,21) m_cols(i,27)];

        lwra_lwrb_lfin_X = [ m_cols(i,22) m_cols(i,25) m_cols(i,28) m_cols(i,22)];
        lwra_lwrb_lfin_Y = [ m_cols(i,23) m_cols(i,26) m_cols(i,29) m_cols(i,23)];
        lwra_lwrb_lfin_Z = [ m_cols(i,24) m_cols(i,27) m_cols(i,30) m_cols(i,24)];

%         plot3(clav_lsho_X',clav_lsho_Y',clav_lsho_Z');
%         plot3(lsho_lelb_X',lsho_lelb_Y',lsho_lelb_Z');
%         plot3(lelb_lwra_X',lelb_lwra_Y',lelb_lwra_Z');
%         plot3(lelb_lwrb_X',lelb_lwrb_Y',lelb_lwrb_Z');
%         plot3(lwra_lwrb_lfin_X',lwra_lwrb_lfin_Y',lwra_lwrb_lfin_Z');

        %right arm 
        clav_rsho_X = [ m_cols(i,7) m_cols(i,31)];
        clav_rsho_Y = [ m_cols(i,8) m_cols(i,32)];
        clav_rsho_Z = [ m_cols(i,9) m_cols(i,33)];

        rsho_relb_X = [ m_cols(i,31) m_cols(i,34)];
        rsho_relb_Y = [ m_cols(i,32) m_cols(i,35)];
        rsho_relb_Z = [ m_cols(i,33) m_cols(i,36)];

        relb_rwra_X = [ m_cols(i,34) m_cols(i,37)];
        relb_rwra_Y = [ m_cols(i,35) m_cols(i,38)];
        relb_rwra_Z = [ m_cols(i,36) m_cols(i,39)];

        relb_rwrb_X = [ m_cols(i,34) m_cols(i,40)];
        relb_rwrb_Y = [ m_cols(i,35) m_cols(i,41)];
        relb_rwrb_Z = [ m_cols(i,36) m_cols(i,42)];

        rwra_rwrb_rfin_X = [ m_cols(i,37) m_cols(i,40) m_cols(i,43) m_cols(i,37)];
        rwra_rwrb_rfin_Y = [ m_cols(i,38) m_cols(i,41) m_cols(i,44) m_cols(i,38)];
        rwra_rwrb_rfin_Z = [ m_cols(i,39) m_cols(i,42) m_cols(i,45) m_cols(i,39)];

%         plot3(clav_rsho_X',clav_rsho_Y',clav_rsho_Z');
%         plot3(rsho_relb_X',rsho_relb_Y',rsho_relb_Z');
%         plot3(relb_rwra_X',relb_rwra_Y',relb_rwra_Z');
%         plot3(relb_rwrb_X',relb_rwrb_Y',relb_rwrb_Z');
%         plot3(rwra_rwrb_rfin_X',rwra_rwrb_rfin_Y',rwra_rwrb_rfin_Z');


        %pelvis lasi_rasi_lpsi_rpsi

        pelvis_X = [m_cols(i,46) m_cols(i,49) m_cols(i,52) m_cols(i,55) m_cols(i,46) m_cols(i,52) m_cols(i,46) m_cols(i,49) m_cols(i,55)];
        pelvis_Y = [m_cols(i,47) m_cols(i,50) m_cols(i,53) m_cols(i,56) m_cols(i,47) m_cols(i,53) m_cols(i,47) m_cols(i,50) m_cols(i,56)];
        pelvis_Z = [m_cols(i,48) m_cols(i,51) m_cols(i,54) m_cols(i,57) m_cols(i,48) m_cols(i,54) m_cols(i,48) m_cols(i,51) m_cols(i,57)];

        plot3(pelvis_X',pelvis_Y',pelvis_Z');

        %left leg 

        lasi_lthb_X = [ m_cols(i,46) m_cols(i,58) ];
        lasi_lthb_Y = [ m_cols(i,47) m_cols(i,59) ];
        lasi_lthb_Z = [ m_cols(i,48) m_cols(i,60) ];

        lasi_lkne_X = [ m_cols(i,46) m_cols(i,61) ];
        lasi_lkne_Y = [ m_cols(i,47) m_cols(i,62) ];
        lasi_lkne_Z = [ m_cols(i,48) m_cols(i,63) ];

        lthb_lkne_X = [ m_cols(i,58) m_cols(i,61) ];
        lthb_lkne_Y = [ m_cols(i,59) m_cols(i,62) ];
        lthb_lkne_Z = [ m_cols(i,60) m_cols(i,63) ];

        lpsi_lkne_X = [ m_cols(i,52) m_cols(i,61) ];
        lpsi_lkne_Y = [ m_cols(i,53) m_cols(i,62) ];
        lpsi_lkne_Z = [ m_cols(i,54) m_cols(i,63) ];

        lkne_ltib_X = [ m_cols(i,61) m_cols(i,64) ];
        lkne_ltib_Y = [ m_cols(i,62) m_cols(i,65) ];
        lkne_ltib_Z = [ m_cols(i,63) m_cols(i,66) ];

        lkne_lank_X = [ m_cols(i,61) m_cols(i,67) ];
        lkne_lank_Y = [ m_cols(i,62) m_cols(i,68) ];
        lkne_lank_Z = [ m_cols(i,63) m_cols(i,69) ];

        ltib_lank_X = [ m_cols(i,64) m_cols(i,67) ];
        ltib_lank_Y = [ m_cols(i,65) m_cols(i,68) ];
        ltib_lank_Z = [ m_cols(i,66) m_cols(i,69) ];

        lank_lhee_ltoe_X = [ m_cols(i,67) m_cols(i,70) m_cols(i,73) m_cols(i,67)];
        lank_lhee_ltoe_Y = [ m_cols(i,68) m_cols(i,71) m_cols(i,74) m_cols(i,68)];
        lank_lhee_ltoe_Z = [ m_cols(i,69) m_cols(i,72) m_cols(i,75) m_cols(i,69)];

        plot3(lasi_lthb_X',lasi_lthb_Y',lasi_lthb_Z');
        plot3(lasi_lkne_X',lasi_lkne_Y',lasi_lkne_Z');
        plot3(lthb_lkne_X',lthb_lkne_Y',lthb_lkne_Z');
        plot3(lpsi_lkne_X',lpsi_lkne_Y',lpsi_lkne_Z');
        plot3(lkne_ltib_X',lkne_ltib_Y',lkne_ltib_Z');
        plot3(lkne_lank_X',lkne_lank_Y',lkne_lank_Z');
        plot3(ltib_lank_X',ltib_lank_Y',ltib_lank_Z');
        plot3(lank_lhee_ltoe_X',lank_lhee_ltoe_Y',lank_lhee_ltoe_Z');

        %left leg 

        rasi_rthb_X = [ m_cols(i,49) m_cols(i,76) ];
        rasi_rthb_Y = [ m_cols(i,50) m_cols(i,77) ];
        rasi_rthb_Z = [ m_cols(i,51) m_cols(i,78) ];

        rasi_rkne_X = [ m_cols(i,49) m_cols(i,79) ];
        rasi_rkne_Y = [ m_cols(i,50) m_cols(i,80) ];
        rasi_rkne_Z = [ m_cols(i,51) m_cols(i,81) ];

        rthb_rkne_X = [ m_cols(i,76) m_cols(i,79) ];
        rthb_rkne_Y = [ m_cols(i,77) m_cols(i,80) ];
        rthb_rkne_Z = [ m_cols(i,78) m_cols(i,81) ];

        rpsi_rkne_X = [ m_cols(i,55) m_cols(i,79) ];
        rpsi_rkne_Y = [ m_cols(i,56) m_cols(i,80) ];
        rpsi_rkne_Z = [ m_cols(i,57) m_cols(i,81) ];

        rkne_rtib_X = [ m_cols(i,79) m_cols(i,82) ];
        rkne_rtib_Y = [ m_cols(i,80) m_cols(i,83) ];
        rkne_rtib_Z = [ m_cols(i,81) m_cols(i,84) ];

        rkne_rank_X = [ m_cols(i,79) m_cols(i,85) ];
        rkne_rank_Y = [ m_cols(i,80) m_cols(i,86) ];
        rkne_rank_Z = [ m_cols(i,81) m_cols(i,87) ];

        rtib_rank_X = [ m_cols(i,82) m_cols(i,85) ];
        rtib_rank_Y = [ m_cols(i,83) m_cols(i,86) ];
        rtib_rank_Z = [ m_cols(i,84) m_cols(i,87) ];

        rank_rhee_rtoe_X = [ m_cols(i,85) m_cols(i,88) m_cols(i,91) m_cols(i,85)];
        rank_rhee_rtoe_Y = [ m_cols(i,86) m_cols(i,89) m_cols(i,92) m_cols(i,86)];
        rank_rhee_rtoe_Z = [ m_cols(i,87) m_cols(i,90) m_cols(i,93) m_cols(i,87)];

        plot3(rasi_rthb_X',rasi_rthb_Y',rasi_rthb_Z');
        plot3(rasi_rkne_X',rasi_rkne_Y',rasi_rkne_Z');
        plot3(rthb_rkne_X',rthb_rkne_Y',rthb_rkne_Z');
        plot3(rpsi_rkne_X',rpsi_rkne_Y',rpsi_rkne_Z');
        plot3(rkne_rtib_X',rkne_rtib_Y',rkne_rtib_Z');
        plot3(rkne_rank_X',rkne_rank_Y',rkne_rank_Z');
        plot3(rtib_rank_X',rtib_rank_Y',rtib_rank_Z');
        plot3(rank_rhee_rtoe_X',rank_rhee_rtoe_Y',rank_rhee_rtoe_Z');

        for c = 1:3:93

            X = m_cols(i,c);
            Y = m_cols(i,c+1);
            Z = m_cols(i,c+2);
            plot3(X,Y,Z,'o');

        end
        waitfor(r);
        clf;

    end
end
close;
