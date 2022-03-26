% here it is provided a side walk visualization, invert Sirine or Adult x
% coordinates and the motion will overlap
% 
% XY plane is a side view 
% XZ plane top view
% YZ plane back view

clear all; clc

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

s_cols = [];
for i= 1:170
    
    col = [];
    for j = 7: 505
        
        row = split(rows{j});
        col = [ col; str2double(row(i))  ];
    end
    s_cols = [ s_cols col];
end

fid = fopen('.\Raw_Data.txt');
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

a_cols = [];
for i= 1:93
    
    col = [];
    for j = 4: 432
        
        row = split(rows{j});
        col = [ col; str2double(row(i))  ];
    end
    a_cols = [ a_cols col];
end
%Control variables for visualization

% control variable for removing the offset / overlap motion 

OFFSET = false;

% upper body
% control vars for Sirine torso
C7_S = false;
T10_S = false;
SUP_S = false;
STRN_S = false;

% control vars for Adult torso
C7_A = false;
T10_A = false;
SUP_A = false;  %actually CLAV
STRN_A = false;


% central body
% control vars for Sirine pelvis
LASIS_S = false;
LPSIS_S = false;
RPSIS_S = false;
RASIS_S = false;

% control vars for Adult pelvis
LASIS_A = false;
LPSIS_A = false;
RPSIS_A = false;
RASIS_A = false;


% lower body
% control vars for sirine knees
LLFE_S = false;
LATT_S = false;
LMFE_S = false;

RLFE_S = false;
RATT_S = false;
RMFE_S = false;

% control vars for adult knees
lknee_A = false;
rknee_A = false;


% control vars for Sirine feet
LSPH_S = false;
LLM_S = false;
LCAL_S = false;
LMFH5_S = false;
LMFH1_S = false;

RLM_S = false;
RSPH_S = false;
RCAL_S = false;
RMFH5_S = false;
RMFH1_S = false;

% equivalent for adult RTOE LTOE
LTT2_S = false;
RTT2_S = false;

% equivalent for rank lank
LAJC_S = false;
RAJC_S = false;


% control vars for Adult feet
lank_A = false;
ltoe_A = false;
lhee_A = false;

rhee_A = false;
rank_A = false;
rtoe_A = false;



hold on;
xlabel('X')
ylabel('Y')
zlabel('Z')

% ground frame

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
for g = -2000:2000
    ground_X = [ground_X g];
    ground_Y = [ground_Y 0];
    ground_Z = [ground_Z -100];
end
% side to side line
for gg = -1000:1000
    ground_XX = [ground_XX 0];
    ground_YY = [ground_YY 0];
    ground_ZZ = [ground_ZZ gg];
end
% height line
for ggg = 0:1500
    ground_XXX = [ground_XXX 0];
    ground_YYY = [ground_YYY ggg];
    ground_ZZZ = [ground_ZZZ -100];
end
plot3(ground_X',ground_Y',ground_Z','--','DisplayName','X'); 
plot3(ground_XX',ground_YY',ground_ZZ','--','DisplayName','Z'); 
plot3(ground_XXX',ground_YYY',ground_ZZZ','--','DisplayName','Y'); 



%Sirine

%torso C7_T10_SUP_STRN

C7_X = s_cols(:,15)*1000  ;
C7_Y = s_cols(:,16)*1000  ;
C7_Z = s_cols(:,17)*1000  ;

T_10_X = s_cols(:,27)*1000  ;
T_10_Y = s_cols(:,28)*1000  ;
T_10_Z = s_cols(:,29)*1000  ; 

SUP_X = s_cols(:,18)*1000  ; 
SUP_Y = s_cols(:,19)*1000  ; 
SUP_Z = s_cols(:,20)*1000  ; 

STRN_X = s_cols(:,24)*1000  ;
STRN_Y = s_cols(:,25)*1000  ;
STRN_Z = s_cols(:,26)*1000  ;

if C7_S plot3(C7_X',C7_Y',C7_Z','DisplayName','C7 Sirine', 'Color', [128, 0, 128] / 255, 'LineWidth', 2); end
if T10_S plot3(T_10_X',T_10_Y',T_10_Z','DisplayName','T10 Sirine', 'Color', [220, 20, 60] / 255, 'LineWidth', 2); end
if STRN_S plot3(STRN_X',STRN_Y',STRN_Z','DisplayName','STRN Sirine', 'Color', [50, 205, 50] / 255, 'LineWidth', 2); end
if SUP_S plot3(SUP_X',SUP_Y',SUP_Z','DisplayName','SUP Sirine', 'Color', [0, 0, 255] / 255, 'LineWidth', 2); end


%pelvis LASIS_LPSIS_RPSIS_RASIS (LGT RGT)

LASIS_X = s_cols(:,30)*1000  ; 
LASIS_Y = s_cols(:,31)*1000  ;  
LASIS_Z = s_cols(:,32)*1000  ;  
    
LPSIS_X = s_cols(:,33)*1000  ; 
LPSIS_Y = s_cols(:,34)*1000  ;  
LPSIS_Z = s_cols(:,35)*1000  ; 

RPSIS_X = s_cols(:,36)*1000  ;
RPSIS_Y = s_cols(:,37)*1000  ;
RPSIS_Z = s_cols(:,38)*1000  ;

RASIS_X = s_cols(:,39)*1000  ;
RASIS_Y = s_cols(:,40)*1000  ;
RASIS_Z = s_cols(:,41)*1000  ;

if RPSIS_S plot3(RPSIS_X',RPSIS_Y',RPSIS_Z','DisplayName','RPSIS Sirine', 'Color', [128, 0, 128] / 255, 'LineWidth', 2); end
if LPSIS_S plot3(LPSIS_X',LPSIS_Y',LPSIS_Z','DisplayName','LPSIS Sirine', 'Color', [220, 20, 60] / 255, 'LineWidth', 2); end
if RASIS_S plot3(RASIS_X',RASIS_Y',RASIS_Z','DisplayName','RASIS Sirine', 'Color', [50, 205, 50] / 255, 'LineWidth', 2); end
if LASIS_S plot3(LASIS_X',LASIS_Y',LASIS_Z','DisplayName','LASIS Sirine', 'Color', [0, 0, 255] / 255, 'LineWidth', 2); end


% letf foot POST LSPH_LLM_LCAL
LSPH_X  = s_cols(:,108)*1000  ; 
LSPH_Y  = s_cols(:,109)*1000  ;
LSPH_Z  = s_cols(:,110)*1000  ;

LLM_X = s_cols(:,111)*1000  ;
LLM_Y = s_cols(:,112)*1000  ;
LLM_Z = s_cols(:,113)*1000  ;

LCAL_X = s_cols(:,120)*1000  ;
LCAL_Y = s_cols(:,121)*1000  ;
LCAL_Z = s_cols(:,122)*1000  ; 


% left foot ANT LMFH5_LTT2_LMFH1

LMFH5_X  = s_cols(:,123)*1000  ; 
LMFH5_Y  = s_cols(:,124)*1000  ;
LMFH5_Z  = s_cols(:,125)*1000  ;

LTT2_X = s_cols(:,126)*1000  ;
LTT2_Y = s_cols(:,127)*1000  ;
LTT2_Z = s_cols(:,128)*1000  ;

LMFH1_X = s_cols(:,129)*1000  ;
LMFH1_Y = s_cols(:,130)*1000  ;
LMFH1_Z = s_cols(:,131)*1000  ; 

if LCAL_S plot3(LCAL_X',LCAL_Y',LCAL_Z','DisplayName','LCAL Sirine','LineWidth',3); end
if LLM_S plot3(LLM_X',LLM_Y',LLM_Z','DisplayName','LLM Sirine','LineWidth',3); end
if LSPH_S plot3(LSPH_X',LSPH_Y',LSPH_Z','DisplayName','LSPH_ Sirine','LineWidth',3); end
if LMFH5_S plot3(LMFH5_X',LMFH5_Y',LMFH5_Z','DisplayName','LMFH5 Sirine','LineWidth',3); end
if LTT2_S plot3(LTT2_X',LTT2_Y',LTT2_Z','DisplayName','LTT2 Sirine','LineWidth',3); end
if LMFH1_S plot3(LMFH1_X',LMFH1_Y',LMFH1_Z','DisplayName','LMFH1 Sirine','LineWidth',3); end

% left knee LLFE_LATT_LMFE		  
LLFE_X  = s_cols(:,87)*1000  ;
LLFE_Y  = s_cols(:,88)*1000  ;
LLFE_Z  = s_cols(:,89)*1000  ;

LATT_X =  s_cols(:,90)*1000  ;
LATT_Y =  s_cols(:,91)*1000  ;
LATT_Z =  s_cols(:,92)*1000  ;

LMFE_X = s_cols(:,93)*1000  ;
LMFE_Y = s_cols(:,94)*1000  ;
LMFE_Z = s_cols(:,95)*1000  ;

if LLFE_S plot3(LLFE_X',LLFE_Y',LLFE_Z','DisplayName','LLFE Sirine','LineWidth',3); end
if LATT_S plot3(LATT_X',LATT_Y',LATT_Z','DisplayName','LATT Sirine','Color', [128, 0, 128] / 255, 'LineWidth', 2); end
if LMFE_S plot3(LMFE_X',LMFE_Y',LMFE_Z','DisplayName','LMFE Sirine','LineWidth',3); end

% right knee RLFE_RATT_RMFE		  
RLFE_X  = s_cols(:,99)*1000  ;
RLFE_Y  = s_cols(:,100)*1000  ;
RLFE_Z  = s_cols(:,101)*1000  ;

RATT_X =  s_cols(:,102)*1000  ;
RATT_Y =  s_cols(:,103)*1000  ;
RATT_Z =  s_cols(:,104)*1000  ;

RMFE_X = s_cols(:,105)*1000  ;
RMFE_Y = s_cols(:,106)*1000  ;
RMFE_Z = s_cols(:,107)*1000  ;

if RLFE_S plot3(RLFE_X',RLFE_Y',RLFE_Z','DisplayName','RLFE Sirine','LineWidth',3); end
if RATT_S plot3(RATT_X',RATT_Y',RATT_Z','DisplayName','RATT Sirine','Color', [220, 20, 60] / 255, 'LineWidth', 2); end
if RMFE_S plot3(RMFE_X',RMFE_Y',RMFE_Z','DisplayName','RMFE Sirine','LineWidth',3); end



% right foot POST RLM_RSPH_RCAL

RLM_X  = s_cols(:,114)*1000  ; 
RLM_Y  = s_cols(:,115)*1000  ; 
RLM_Z  = s_cols(:,116)*1000  ;
    
RSPH_X = s_cols(:,117)*1000  ; 
RSPH_Y = s_cols(:,118)*1000  ;
RSPH_Z = s_cols(:,119)*1000  ; 

RCAL_X = s_cols(:,132)*1000  ;
RCAL_Y = s_cols(:,133)*1000  ;
RCAL_Z = s_cols(:,134)*1000  ;


% right foot ANT RMFH5_RTT2_RMFH1
RMFH5_X  = s_cols(:,135)*1000  ;
RMFH5_Y  = s_cols(:,136)*1000; 
RMFH5_Z  = s_cols(:,137)*1000;

RTT2_X = s_cols(:,138)*1000;
RTT2_Y = s_cols(:,139)*1000; 
RTT2_Z = s_cols(:,140)*1000;

RMFH1_X = s_cols(:,141)*1000 ; 
RMFH1_Y = s_cols(:,142)*1000 ; 
RMFH1_Z = s_cols(:,143)*1000 ;

if RCAL_S plot3(RCAL_X',RCAL_Y',RCAL_Z','DisplayName','RCAL Sirine','LineWidth',3); end
if RSPH_S plot3(RSPH_X',RSPH_Y',RSPH_Z','DisplayName','RSPH_S Sirine','LineWidth',3); end
if RLM_S plot3(RLM_X',RLM_Y',RLM_Z','DisplayName','RLM Sirine','LineWidth',3); end
if RMFH5_S plot3(RMFH5_X',RMFH5_Y',RMFH5_Z','DisplayName','RMFH5 Sirine','LineWidth',3); end
if RTT2_S plot3(RTT2_X',RTT2_Y',RTT2_Z','DisplayName','RTT2 Sirine','LineWidth',3); end
if RMFH1_S plot3(RMFH1_X',RMFH1_Y',RMFH1_Z','DisplayName','RMFH1 Sirine','LineWidth',3); end


% right foot center sirine 

RAJC_X = s_cols(:,150)*1000;
RAJC_Y = s_cols(:,151)*1000;
RAJC_Z = s_cols(:,152)*1000;

if RAJC_S plot3(RAJC_X',RAJC_Y',RAJC_Z','DisplayName','RAJC Sirine','LineWidth',3); end

% left foot center sirine 

LAJC_X = s_cols(:,147)*1000;
LAJC_Y = s_cols(:,148)*1000;
LAJC_Z = s_cols(:,149)*1000;
if LAJC_S plot3(LAJC_X',LAJC_Y',LAJC_Z','DisplayName','LAJC Sirine','LineWidth',3); end



% Adult

%torso C7_T10_clav_strn

C7_X = a_cols(:,1) -250;
C7_Y = a_cols(:,2);
C7_Z = a_cols(:,3) -500;
 
T_10_X = a_cols(:,4) -250;
T_10_Y = a_cols(:,5);
T_10_Z = a_cols(:,6) -500 ; 

SUP_X = a_cols(:,7) -250 ; 
SUP_Y = a_cols(:,8); 
SUP_Z = a_cols(:,9) -500; 

STRN_X = a_cols(:,10) -250;
STRN_Y = a_cols(:,11);
STRN_Z = a_cols(:,12) -500;

% offsets
C7_STRN_Aoffset_X = a_cols(1,1) - a_cols(1,10);
C7_STRN_Aoffset_Y = a_cols(1,2) - a_cols(1,11); 
C7_STRN_Aoffset_Z = a_cols(1,3) - a_cols(1,12);

T10_SUP_Aoffset_X = a_cols(1,4) -  a_cols(1,7);
T10_SUP_Aoffset_Y = a_cols(1,5) -  a_cols(1,8);
T10_SUP_Aoffset_Z = a_cols(1,6) -  a_cols(1,9);

if OFFSET
    
    C7_X = C7_X + C7_STRN_Aoffset_X;
    C7_Y = C7_Y - C7_STRN_Aoffset_Y;
    C7_Z = C7_Z - C7_STRN_Aoffset_Z;

    T_10_X = T_10_X + T10_SUP_Aoffset_X;
    T_10_Y = T_10_Y - T10_SUP_Aoffset_Y;
    T_10_Z = T_10_Z - T10_SUP_Aoffset_Z; 

end


if C7_A plot3(-C7_Z',C7_Y',-C7_X','DisplayName','C7 Adult', 'Color', [128, 0, 128] / 255, 'LineWidth', 1); end
if T10_A plot3(-T_10_Z',T_10_Y',-T_10_X','DisplayName','T10 Adult',  'Color', [220, 20, 60] / 255, 'LineWidth', 1); end
if STRN_A plot3(-STRN_Z',STRN_Y',-STRN_X','DisplayName','STRN Adult', 'Color', [50, 205, 50] / 255, 'LineWidth', 1); end
if SUP_A plot3(-SUP_Z',SUP_Y',-SUP_X','DisplayName','CLAV Adult',  'Color', [0, 0, 255] / 255, 'LineWidth', 1); end

%pelvis lasi_rasi_lpsi_rpsi

LASIS_X = a_cols(:,46) -250; 
LASIS_Y = a_cols(:,47);  
LASIS_Z = a_cols(:,48) -500;  
  
LPSIS_X = a_cols(:,52) -250; 
LPSIS_Y = a_cols(:,53);  
LPSIS_Z = a_cols(:,54) -500; 

RPSIS_X = a_cols(:,55) -250;
RPSIS_Y = a_cols(:,56);
RPSIS_Z = a_cols(:,57) -500;

RASIS_X = a_cols(:,49) -250;
RASIS_Y = a_cols(:,50);
RASIS_Z = a_cols(:,51) -500;

% offsets
hip_Aoffset_X = a_cols(1,55) - a_cols(1,49);
hip_Aoffset_Y = a_cols(1,56) - a_cols(1,50); 
hip_Aoffset_Z = a_cols(1,57) - a_cols(1,51);

if OFFSET
    
    LASIS_X = LASIS_X - hip_Aoffset_X;
    LASIS_Y = LASIS_Y + hip_Aoffset_Y;
    LASIS_Z = LASIS_Z + hip_Aoffset_Z;
  

    RASIS_X = RASIS_X - hip_Aoffset_X;
    RASIS_Y = RASIS_Y + hip_Aoffset_Y;
    RASIS_Z = RASIS_Z + hip_Aoffset_Z;
end

if RPSIS_A plot3(-RPSIS_Z',RPSIS_Y',-RPSIS_X','DisplayName','RPSI Adult', 'Color', [128, 0, 128] / 255, 'LineWidth', 1); end
if LPSIS_A plot3(-LPSIS_Z',LPSIS_Y',-LPSIS_X','DisplayName','LPSI Adult', 'Color', [220, 20, 60] / 255, 'LineWidth', 1); end
if RASIS_A plot3(-RASIS_Z',RASIS_Y',-RASIS_X','DisplayName','RASI Adult', 'Color', [50, 205, 50] / 255, 'LineWidth', 1); end
if LASIS_A plot3(-LASIS_Z',LASIS_Y',-LASIS_X','DisplayName','LASI Adult', 'Color', [0, 0, 255] / 255, 'LineWidth', 1); end

% knees

lkne_X = a_cols(:,61) -250;
lkne_Y = a_cols(:,62);
lkne_Z = a_cols(:,63) -500;

rkne_X = a_cols(:,79) -250;
rkne_Y = a_cols(:,80);
rkne_Z = a_cols(:,81) -500;

% offsets
knee_Aoffset_X = a_cols(1,79) - a_cols(1,61);

if OFFSET 
    lkne_X = lkne_X - knee_Aoffset_X ;
end


if lknee_A plot3(-lkne_Z',lkne_Y',-lkne_X','DisplayName','LKNE Adult', 'Color', [128, 0, 128] / 255, 'LineWidth', 1); end
if rknee_A plot3(-rkne_Z',rkne_Y',-rkne_X','DisplayName','RKNE Adult', 'Color', [220, 20, 60] / 255, 'LineWidth', 1); end


% feet
lank_X = a_cols(:,67) -250;
lank_Y = a_cols(:,68);
lank_Z = a_cols(:,69) -500;

lhee_X = a_cols(:,70) -250;
lhee_Y = a_cols(:,71);
lhee_Z = a_cols(:,72) -500;

ltoe_X = a_cols(:,73) -250;
ltoe_Y = a_cols(:,74);
ltoe_Z = a_cols(:,75) -500;

rank_X = a_cols(:,85) -250; 
rank_Y = a_cols(:,86); 
rank_Z = a_cols(:,87) -500;

rtoe_X = a_cols(:,91) -250; 
rtoe_Y = a_cols(:,92); 
rtoe_Z = a_cols(:,93) -500;

rhee_X = a_cols(:,88) -250;
rhee_Y = a_cols(:,89);
rhee_Z = a_cols(:,90) -500;

if rhee_A plot3(-rhee_Z',rhee_Y',-rhee_X','DisplayName','rhee Adult'); end
if rtoe_A plot3(-rtoe_Z',rtoe_Y',-rtoe_X','DisplayName','rtoe Adult'); end
if rank_A plot3(-rank_Z',rank_Y',-rank_X','DisplayName','rank Adult'); end
if ltoe_A plot3(-ltoe_Z',ltoe_Y',-ltoe_X','DisplayName','ltoe Adult'); end
if lhee_A plot3(-lhee_Z',lhee_Y',-lhee_X','DisplayName','lhee Adult'); end
if lank_A plot3(-lank_Z',lank_Y',-lank_X','DisplayName','lank Adult'); end



legend;
