RMPOPIN1 ;HINCIOFO/RVD - POST INIT (CONVERSION ROUTINE) ;01/05/00
 ;;3.0;PROSTHETICS;**44,46**;Feb 09, 1996
 ;
 W !,"INVALID ENTRY POINT...."
 Q
START ;conversion of 442 ien and po
 W !!,"***Converting file 442 IEN and PO. Please be patient.***"
 F RSI=0:0 S RSI=$O(^RMPO(665.72,RSI)) Q:RSI'>0  F RDA=0:0 S RDA=$O(^RMPO(665.72,RSI,1,RDA)) Q:RDA'>0  F REN=0:0 S REN=$O(^RMPO(665.72,RSI,1,RDA,2,REN)) Q:REN'>0  D
 . S RMDAT0=$G(^RMPO(665.72,RSI,1,RDA,2,REN,0))
 . Q:$P(RMDAT0,U,2)
 . S RMIEN=$P(RMDAT0,U,3)
 . S RMPO=$P(RMDAT0,U,4)
 . Q:RMIEN=""  ;nothing to convert
 . Q:$D(^PRC(442,RMIEN,0))  ;entry already been converted
 . S X1=$P(RMDAT0,U,5),X2=REN,X=RMIEN D DE^XUSHSHP I X D
 . .S $P(^RMPO(665.72,RSI,1,RDA,2,REN,0),U,3)=X
 . .S:X'="" ^RMPO(665.72,RSI,1,RDA,2,"C",X,REN)=""
 . .W !,RDA," ",REN," ",X
 . S X1=$P(RMDAT0,U,5),X2=REN,X=RMPO D DE^XUSHSHP D
 . .S $P(^RMPO(665.72,RSI,1,RDA,2,REN,0),U,4)=X
 . .S:X'="" ^RMPO(665.72,RSI,1,RDA,2,"D",X,REN)=""
 . .W !,RDA," ",REN," ",X
 W !!,"***Done Converting file 442 IEN and PO***"
DES ;remove duplicate/extra HCPCS description 'B' cross-reference &
 ;clean-up the 'F' cross-reference.
 W !!,"***Starting clean-up of HCPCS Description***"
 K ^RMPR(661.1,"F") S DIK(1)=".01^F"
 F RI=0:0 S RI=$O(^RMPR(661.1,RI)) Q:RI'>0  K ^RMPR(661.1,RI,2,"B") F RJ=0:0 S RJ=$O(^RMPR(661.1,RI,2,RJ)) Q:RJ'>0  D
 .S RD=$G(^RMPR(661.1,RI,2,RJ,0)) I $L(RD)>30 S RD=$E(RD,1,30)
 .S ^RMPR(661.1,RI,2,"B",RD,RJ)=""
 .S DA(1)=RI,DA=RJ,DIK="^RMPR(661.1,"_DA(1)_",2,"
 .D EN1^DIK
 W !!,"***Done clean-up of HCPCS Description***"
 S $P(^RMPR(661.1,128,0),"^",7)="900 E"
EXIT ;Kill variables
 K RMIEN,RMPO,RMDAT0,X1,X2,REN,RSI,RDA,RI,RJ,RD,DIK,DA,X
 Q
46 ;deletes 'AD' cross-ref of file #665
 S RADX="AD" D DELIX^DDMOD(665,19.2,RADX)
 K DIK,RADX
 Q
POST46 ;re-index the field #10,19.2
 W !!,"*** Reindexing 'AHO & AD' cross reference of file #665....."
 K ^RMPR(665,"AD")
 S DIK="^RMPR(665,",DIK(1)="19.2^AHO" D ENALL^DIK
 F I=0:0 S I=$O(^RMPR(665,I)) Q:I'>0  F J=0:0 S J=$O(^RMPR(665,I,1,J)) Q:J'>0  S DIK="^RMPR(665,",DA(1)=I,DA=J,DIK=DIK_DA(1)_",1,",DIK(1)="10^AD" D EN1^DIK
 K DIK,RADX,DA,I,J
 Q
