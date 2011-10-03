DGANHD1 ;ALB/RMO - Calculate NHCU and DOM AMIS's 345-346 ; 29 AUG 90 10:40 am
 ;;5.3;Registration;;Aug 13, 1993
 ;==============================================================
 ;NHCU and DOM AMIS segments are calculated by looping through the
 ;Ward Location file.
 ;
 ;Input:
 ; DGMYR   -Month/Year being calculated in internal date format
 ; DGEOM   -Last day of Month/Year in internal date format
 ; DGPEOM  -Last day of Prior Month/Year in internal date format
 ;==============================================================
 I $D(^DGAM(345,DGMYR,"SE")) F DGSEG=0:0 S DGSEG=$O(^DGAM(345,DGMYR,"SE",DGSEG)) Q:'DGSEG  D DEL
 F DGWI=0:0 S DGWI=$O(^DIC(42,DGWI)) Q:'DGWI  I $D(^(DGWI,0)) S DGW0=^(0) D CEN I DGSEG,'DGERRFLG D CAL,UTL
 D ^DGANHD2,^DGANHD4
 ;
Q K DGAA,DGABO,DGADE,DGADI,DGAM,DGAO,DGAR,DGAS,DGBO,DGCE0,DGCE1,DGCP0,DGDE,DGDI,DGDIV,DGEND,DGFA,DGFE,DGERRFLG,DGOB,DGPD,DGSEG,DGSTR,DGTA,DGTI,DGTO,DGW0,DGWI,I,X
 Q
 ;
DEL ;Delete Previous AMIS Statistics
 S DA(1)=DGMYR,DA=DGSEG,DIK="^DGAM(345,"_DGMYR_",""SE""," D ^DIK K DA,DIK
 Q
 ;
CEN ;AMIS statistics are Calculated using data for Ward from Census File
 S DGERRFLG=0,X=$P(DGW0,"^",3),DGSEG=$S(X="NH":345,X="D":346,1:0) Q:'DGSEG
 S DGDIV=$S($P(DGW0,"^",11):+$P(DGW0,"^",11),$D(^DG(43,1,"GL")):+$P(^("GL"),"^",3),1:0)
 S DGCP0=$S($E(DGPEOM,4,5)="09":0,$D(^DG(41.9,DGWI,"C",DGPEOM,0)):^(0),1:"") ;Last day of prior month
 S DGCE0=$S($D(^DG(41.9,DGWI,"C",DGEOM,0)):^(0),1:""),DGCE1=$S($D(^DG(41.9,DGWI,"C",DGEOM,1)):^(1),1:"") ;Last day of selected month
 I DGCP0=""!(DGCE0="") W !!,$S(DGCP0="":"Beginning",1:"End")," of month statistics are missing for ward ",$P(DGW0,"^"),".",!,"Ward not included in AMIS ",DGSEG," calculations." S DGERRFLG=1
 Q
 ;
CAL ;Actual Calculations for AMIS Fields
 S DGAR=$P(DGCE0,"^",18)-$P(DGCP0,"^",18) ;           Adm Reh >30
 S DGAO=($P(DGCE0,"^",17)-$P(DGCP0,"^",17))-DGAR ;    Adm All Oth
 S DGTI=$P(DGCE0,"^",13)-$P(DGCP0,"^",13) ;           Trf In
 S DGAO=DGAO-DGTI
 S DGFA=$P(DGCE0,"^",19)-$P(DGCP0,"^",19) ;           From ASIH
 S DGTO=$P(DGCE0,"^",14)-$P(DGCP0,"^",14) ;           Trf Out
 S DGDE=$P(DGCE0,"^",15)-$P(DGCP0,"^",15) ;           Deaths
 S DGDI=($P(DGCE0,"^",5)-$P(DGCP0,"^",5))-DGDE-DGTO ; Discharges
 S DGTA=$P(DGCE0,"^",20)-$P(DGCP0,"^",20) ;           To ASIH
 S DGBO=$P(DGCE0,"^",2) ;                             BO Rem EOM
 S DGABO=$P(DGCE1,"^",6)+$P(DGCE1,"^",7) ;            ABO Rem EOM
 S DGAS=$P(DGCE1,"^",8) ;                             ASIH Rem EOM
 S DGFE=$P(DGCE1,"^") ;                               Fem Rem EOM
 S DGADI=$P(DGCE0,"^",21)-$P(DGCP0,"^",21) ;          ASIH Dis
 S DGADE=$P(DGCE0,"^",22)-$P(DGCP0,"^",22) ;          ASIH Deaths
 S DGDI=DGDI-DGADI-DGADE
 S DGPD=$P(DGCE0,"^",3)-$P(DGCP0,"^",3) ;             Pat Day Care
 S DGAA=$P(DGCE0,"^",9)-$P(DGCP0,"^",9) ;             AA <96 Hrs
 S DGOB=$P(DGCE1,"^",2) ;                             Op Bed EOM
 Q
 ;
UTL ;Save AMIS Statistics in the Utility Global
 S DGAM=$S($D(^UTILITY($J,"DGANHD",DGMYR,DGSEG,DGDIV)):^(DGDIV),1:"")
 S DGSTR=DGAR_"^"_DGAO_"^"_DGTI_"^"_DGFA_"^"_DGDI_"^"_DGDE_"^"_DGTO_"^"_DGTA_"^"_DGBO_"^"_DGABO_"^"_DGAS_"^"_DGFE_"^"_DGADI_"^"_DGADE_"^"_DGPD_"^"_DGAA_"^"_DGOB
 S DGEND=17 F I=1:1:DGEND S $P(DGAM,"^",I)=$P(DGAM,"^",I)+$P(DGSTR,"^",I)
 S ^UTILITY($J,"DGANHD",DGMYR,DGSEG,DGDIV)=DGAM
 Q
