SROA38A ;BIR/ADM-Preinitialization Process for SR*3*38 ; [ 05/18/95  1:50 PM ]
 ;;3.0; Surgery ;**38**;24 Jun 93
 I $G(SR38DONE) G END
LOOP ; loop through each case and update anesthesia techniques to ABA list
 W !!,"Converting anesthesia techniques..." S (CNT,SRTN)=0
 F  S SRTN=$O(^SRF(SRTN)) Q:'SRTN  S CNT=CNT+1 W:'(CNT#100) "." I $O(^SRF(SRTN,6,0)) S SRANES=0 F  S SRANES=$O(^SRF(SRTN,6,SRANES)) Q:'SRANES  S X=$P($G(^SRF(SRTN,6,SRANES,0)),"^") I X'="" D
 .S SRCASE=SRTN_"^"_SRANES_"^"_X
 .S SRFLG=0 F SRTECH="INH","IV","S","E","INF","N","F","T","O" I X=SRTECH S SRFLG=1 Q
 .I 'SRFLG,$D(SRATECH(X)) D ALTER Q
 .I 'SRFLG D NONSTD Q
 .I X="E"!(X="S") Q
 .I X="INH" S Y="G" D SET Q
 .I X="IV" S MAC=$P($G(^SRF(SRTN,6,SRANES,8)),"^") S Y=$S(MAC="Y":"M",1:"G") D SET Q
 .S Z=$P($G(^SRF(SRTN,.3)),"^",8),CAT=$S(Z="A":1,Z="N":1,1:0)
 .I X="INF"!(X="N")!(X="F")!(X="T")!(X="O") S Y=$S(CAT:"O",1:"L") D SET
 W !,"Conversion of anesthesia techniques is finished.",!
STATUS ; change assessments with a status of COMPLETE to INCOMPLETE
 F SRS="C","N" S DFN=0 F  S DFN=$O(^SRF("ARS",SRS,"C",DFN)) Q:'DFN  S SRTN=0 F  S SRTN=$O(^SRF("ARS",SRS,"C",DFN,SRTN)) Q:'SRTN  D
 .I $P($G(^SRF(SRTN,"RA")),"^",6)="N" Q
 .K ^SRF("ARS",SRS,"C",DFN,SRTN),DA,DIE,DR S DA=SRTN,DIE=130,DR="235////I;272///@" D ^DIE
DELDD ; delete DD for modified fields
 K DIE,DR,DIK,DA S DIK="^DD(130,",DA(1)=130 F DA=102,218,235,256,259,287,339,340,404,411 D ^DIK
 K DIK,DA
 ; delete DD's of sub-files with changed names
 F SRSUB=130.053,130.534,130.0126,130.13,130.21,130.22,130.224 K DIU S DIU=SRSUB,DIU(0)="S" D EN^DIU2
 K SRSUB,DIU
 ; delete occurrence categories in file 136.5
END K ^SRO(136.5)
 W !!,"Preinit process is finished.",! K CAT,CNT,DFN,I,MAC,SR38DONE,SRA,SRANES,SRATECH,SRCASE,SRFLG,SRNON,SRS,SRSOUT,SRTECH,SRTN,SRW,SRX,SRX1,SRY,SRZ,X,Y,Z
 Q
SET S $P(^SRF(SRTN,6,SRANES,0),"^")=Y
 Q
NONSTD ; convert non-standard anesthesia technique
 S Z=$P($G(^SRF(SRTN,.3)),"^",8),CAT=$S(Z="A":1,Z="N":1,1:0),Y=$S(CAT:"O",1:"L")
 W !!,"Non-standard technique code "_X_" on case #"_SRTN_" converted to "_$S(Y="O":"OTHER",1:"LOCAL")_".",!
 D SET
 Q
ALTER S Y=SRATECH(X) D SET
 Q
