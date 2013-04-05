ANRVPOST ;BHAM/MAM - POST-INIT FOR VERSION 4.0 ; 09 Jun 98 / 8:28 AM
 ;;4.0; Visual Impairment Service Team ;;12 Jun 98
EN ; update Entry in the PACKAGE file
 K DIC,X S X="VISUAL IMPAIRMENT SERVICE",DIC(0)="XZ",DIC="^DIC(9.4," D ^DIC K DIC S X=+Y
 I X>0,$P(^DIC(9.4,X,0),"^",1)'="VISUAL IMPAIRMENT SERVICE TEAM" S ANRVNM="VISUAL IMPAIRMENT SERVICE TEAM" D NAME
 K ANRVNM,X,Y,DIC,DA,DR,DIE
 ;Check to see if data has already been moved
 I $O(^ANRV(2040,0)) W !!,"It appears that the Visual Impairment Service Team softare V. 4.0 has",!,"already been installed and files have been updated.",! D CLEAN Q
VIRGIN ;Check for virgin install
 I '$D(^DIZ(623158,0))  Q
CONVERT ; convert data from ^DIZ( to ^ANRV(
 ; VIST Letter
 S %X="^DIZ(623033,",%Y="^ANRV(2043," D %XY^%RCR S $P(^ANRV(2043,0),"^",2)=2043
 S ANRVEN=0 F  S ANRVEN=$O(^ANRV(2043,ANRVEN)) Q:'ANRVEN  S:$D(^ANRV(2043,ANRVEN,1,0)) $P(^(0),"^",2)=2043.01
 ; VARO Claims
 S %X="^DIZ(623036,",%Y="^ANRV(2043.5," D %XY^%RCR S $P(^ANRV(2043.5,0),"^",2)="2043.5P"
 S ANRVEN=0 F  S ANRVEN=$O(^ANRV(2043.5,ANRVEN)) Q:'ANRVEN  S:$D(^ANRV(2043.5,ANRVEN,1,0)) $P(^(0),"^",2)="2043.51D"
 ; VIST Eye Diagnosis
 S %X="^DIZ(623049,",%Y="^ANRV(2041.5," D %XY^%RCR S $P(^ANRV(2041.5,0),"^",2)=2041.5
 ; VIST Parameters
 S %X="^DIZ(623050,",%Y="^ANRV(2041," D %XY^%RCR S $P(^ANRV(2041,0),"^",2)="2041P"
 ; VIST Checklist Options
 S %X="^DIZ(623053,",%Y="^ANRV(2041.6," D %XY^%RCR S $P(^ANRV(2041.6,0),"^",2)=2041.6
 ; VIST Benefits and Services Checklist
 S %X="^DIZ(623061,",%Y="^ANRV(2041.7," D %XY^%RCR S $P(^ANRV(2041.7,0),"^",2)="2041.7P"
 S ANRVEN=0 F  S ANRVEN=$O(^ANRV(2041.7,ANRVEN)) Q:'ANRVEN  S:$D(^ANRV(2041.7,ANRVEN,2,0)) $P(^(0),"^",2)="2041.732P"
 ; VIST Local Benefits and Services
 S %X="^DIZ(623064,",%Y="^ANRV(2044," D %XY^%RCR S $P(^ANRV(2044,0),"^",2)="2044P"
 ; VIST Roster
 S %X="^DIZ(623158,",%Y="^ANRV(2040," D %XY^%RCR S $P(^ANRV(2040,0),"^",2)="2040IP"
 S ANRVEN=0 F  S ANRVEN=$O(^ANRV(2040,ANRVEN)) Q:'ANRVEN  D
 .S:$D(^ANRV(2040,ANRVEN,1,0)) $P(^(0),"^",2)=2040.02
 .S:$D(^ANRV(2040,ANRVEN,3,0)) $P(^(0),"^",2)="2040.04D"
 .S:$D(^ANRV(2040,ANRVEN,4,0)) $P(^(0),"^",2)=2040.05
 .S:$D(^ANRV(2040,ANRVEN,6,0)) $P(^(0),"^",2)="2040.06D"
 .S:$D(^ANRV(2040,ANRVEN,8,0)) $P(^(0),"^",2)="2040.014DA"
 .S:$D(^ANRV(2040,ANRVEN,10,0)) $P(^(0),"^",2)="2040.03D"
 .S:$D(^ANRV(2040,ANRVEN,11,0)) $P(^(0),"^",2)=2040.012
 .S:$D(^ANRV(2040,ANRVEN,12,0)) $P(^(0),"^",2)=2040.013
 .S:$D(^ANRV(2040,ANRVEN,14,0)) $P(^(0),"^",2)="2040.07D"
 .S:$D(^ANRV(2040,ANRVEN,15,0)) $P(^(0),"^",2)="2040.01P"
 .S:$D(^ANRV(2040,ANRVEN,16,0)) $P(^(0),"^",2)=2040.08
 .S:$D(^ANRV(2040,ANRVEN,17,0)) $P(^(0),"^",2)=2040.09
 .S:$D(^ANRV(2040,ANRVEN,18,0)) $P(^(0),"^",2)=2040.1
 .S:$D(^ANRV(2040,ANRVEN,19,0)) $P(^(0),"^",2)=2040.11
 .S:$D(^ANRV(2040,ANRVEN,20,0)) $P(^(0),"^",2)=2040.12
 ; VIST Referral Roster
 S %X="^DIZ(623160,",%Y="^ANRV(2042.5," D %XY^%RCR S $P(^ANRV(2042.5,0),"^",2)="2042.5P"
 S ANRVEN=0 F  S ANRVEN=$O(^ANRV(2042.5,ANRVEN)) Q:'ANRVEN  S:$D(^ANRV(2042.5,ANRVEN,1,0)) $P(^(0),"^",2)="2042.51D"
 ; VIST Referral Facility
 S %X="^DIZ(623165,",%Y="^ANRV(2042," D %XY^%RCR S $P(^ANRV(2042,0),"^",2)=2042
 K ANRVEN
DELETE ; delete files in ^DIZ(623000 numberspace
 F ANRVI=623033,623036,623049,623050,623053,623061,623064,623158,623160,623165 S DIU="^DIZ("_ANRVI_",",DIU(0)="DT" D EN^DIU2 K DIU
 ;
CLEAN ;Cleanup old entries in 2041.7 which have no corresponding entry in 2040.
 S ANRVP=0 F  S ANRVP=$O(^ANRV(2041.7,ANRVP)) Q:'ANRVP  S ANRVP2=+$G(^ANRV(2041.7,+ANRVP,0)) I '$D(^ANRV(2040,+ANRVP2,0)) S DIK="^ANRV(2041.7,",DA=+ANRVP D ^DIK K DIK,DA
 ;Cleanup old entries in 2042.5 which have no corresponding entry in 2040.
 S ANRVP=0 F  S ANRVP=$O(^ANRV(2042.5,ANRVP)) Q:'ANRVP  S ANRVP2=+$G(^ANRV(2042.5,+ANRVP,0)) I '$D(^ANRV(2040,+ANRVP2,0)) S DIK="^ANRV(2042.5,",DA=+ANRVP D ^DIK K DIK,DA
 ;Cleanup old entries in 2043.5 which have no corresponding entry in 2040.
 S ANRVP=0 F  S ANRVP=$O(^ANRV(2043.5,ANRVP)) Q:'ANRVP  S ANRVP2=+$G(^ANRV(2043.5,+ANRVP,0)) I '$D(^ANRV(2040,+ANRVP2,0)) S DIK="^ANRV(2043.5,",DA=+ANRVP D ^DIK K DIK,DA
 K ANRVP
QUIT K ANRVI
 Q
 ;
NAME ; reset NAME in PACKAGE file
 S DIE=9.4,DA=X,DR=".01///"_ANRVNM D ^DIE
 Q
