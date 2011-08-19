DGAINP1 ;ALB/RMO - Calculate Inpatient AMIS's 334-341 ; 27 DEC 89 1:37 pm
 ;;5.3;Registration;;Aug 13, 1993
 ;==============================================================
 ;Inpatient AMIS segments are calculated by looping through the
 ;Ward Location file.
 ;
 ;Input:
 ; DGMYR   -Month/Year being calculated in internal date format
 ; DGEOM   -Last day of Month/Year in internal date format
 ; DGPEOM  -Last day of Prior Month/Year in internal date format
 ;==============================================================
 I $D(^DGAM(334,DGMYR,"SE")) F DGSEG=0:0 S DGSEG=$O(^DGAM(334,DGMYR,"SE",DGSEG)) Q:'DGSEG  D DEL
 F DGWI=0:0 S DGWI=$O(^DIC(42,DGWI)) Q:'DGWI  I $D(^(DGWI,0)) S DGW0=^(0) D CEN I DGSEG,'DGERRFLG D CAL,UTL
 D PSY,^DGAINP2,^DGAINP4
 ;
Q K DGAA,DGAM,DGABO,DGBO,DGCE0,DGCE1,DGCP0,DGDA,DGDE,DGDO,DGDIV,DGEND,DGERRFLG,DGFE,DGGB,DGL45,DGLB,DGOB,DGPD,DGSEG,DGSTR,DGTA,DGTI,DGTO,DGW0,DGWI,I,X
 Q
 ;
DEL ;Delete Previous AMIS Statistics
 S DA(1)=DGMYR,DA=DGSEG,DIK="^DGAM(334,"_DGMYR_",""SE""," D ^DIK K DA,DIK
 Q
 ;
CEN ;AMIS Statistics are Calculated using data for Ward from Census File
 S DGERRFLG=0,X=$P(DGW0,"^",3),DGSEG=$S(X="P":334,X="I":335,X="M":336,X="NE":337,X="R":338,X="B":339,X="SCI":340,X="S":341,1:0) Q:'DGSEG
 S DGDIV=$S($P(DGW0,"^",11):+$P(DGW0,"^",11),$D(^DG(43,1,"GL")):+$P(^("GL"),"^",3),1:0)
 S DGCP0=$S($E(DGPEOM,4,5)="09":0,$D(^DG(41.9,DGWI,"C",DGPEOM,0)):^(0),1:"") ;Last day of prior month
 S DGCE0=$S($D(^DG(41.9,DGWI,"C",DGEOM,0)):^(0),1:""),DGCE1=$S($D(^DG(41.9,DGWI,"C",DGEOM,1)):^(1),1:"") ;Last day of selected month
 I DGCP0=""!(DGCE0="") W !!,$S(DGCP0="":"Beginning",1:"End")," of month statistics are missing for ward ",$P(DGW0,"^"),".",!,"Ward not included in AMIS ",DGSEG," calculations." S DGERRFLG=1
 Q
 ;
CAL ;Actual Calculations for AMIS Fields
 S DGTI=$P(DGCE0,"^",13)-$P(DGCP0,"^",13) ;               Trf In
 S DGTA=($P(DGCE0,"^",17)-$P(DGCP0,"^",17))-DGTI ;        Tot Adm
 S DGGB=$P(DGCE0,"^",23)-$P(DGCP0,"^",23) ;               Gain Bed Sec
 S DGDE=$P(DGCE0,"^",15)-$P(DGCP0,"^",15) ;               Deaths
 S DGDO=($P(DGCE0,"^",16)-$P(DGCP0,"^",16)) ;             Dis OPT/NSC
 S DGTO=$P(DGCE0,"^",14)-$P(DGCP0,"^",14) ;               Trf Out
 S DGDA=($P(DGCE0,"^",5)-$P(DGCP0,"^",5))-DGDE-DGDO-DGTO ;Dis All Oth
 S DGLB=$P(DGCE0,"^",8)-$P(DGCP0,"^",8) ;                 Loss Bed Sec
 S DGBO=$P(DGCE0,"^",2) ;                                 BO Rem EOM
 S DGABO=$P(DGCE1,"^",6)+$P(DGCE1,"^",7) ;                ABO Rem EOM
 S DGPD=$P(DGCE0,"^",3)-$P(DGCP0,"^",3) ;                 Pat Day Care
 S DGAA=$P(DGCE0,"^",9)-$P(DGCP0,"^",9) ;                 AA <96 Hrs
 S DGOB=$P(DGCE1,"^",2) ;                                 Op Bed EOM
 S DGFE=$P(DGCE1,"^") ;                                   Fem Rem EOM
 Q
 ;
UTL ;Save AMIS Statistics in the Utility Global
 ;Note:  Dial Op Beds set to 0 for Austin
 S DGAM=$S($D(^UTILITY($J,"DGAINP",DGMYR,DGSEG,DGDIV)):^(DGDIV),1:"")
 S DGSTR=DGTA_"^"_DGTI_"^"_DGGB_"^"_DGDE_"^"_DGDO_"^"_DGDA_"^"_DGTO_"^"_DGLB_"^"_DGBO_"^"_DGABO_"^"_$S(DGSEG>334:DGPD,1:"0^"_DGPD)_"^"_DGAA_"^"_DGOB_"^"_DGFE_$S(DGSEG=336:"^0",1:"")
 S DGEND=$S(DGSEG=334!(DGSEG=336):15,1:14) F I=1:1:DGEND S $P(DGAM,"^",I)=$P(DGAM,"^",I)+$P(DGSTR,"^",I)
 S ^UTILITY($J,"DGAINP",DGMYR,DGSEG,DGDIV)=DGAM
 Q
 ;
PSY ;Set Utility GLobal for Psych 1-45 PDC
 D ^DGAINP0
 F DGDIV=0:0 S DGDIV=$O(^UTILITY($J,"DGAINP",DGMYR,334,DGDIV)) Q:'DGDIV  S:$D(DGL45(DGDIV)) $P(^(DGDIV),"^",11,12)=DGL45(DGDIV)_"^"_$S($P(^(DGDIV),"^",12)<DGL45(DGDIV):0,1:$P(^(DGDIV),"^",12)-DGL45(DGDIV))
 Q
