PSXEDIT ;BIR/HTW-CMOP Edit Routine for Outpatient Pharmacy ; [ 03/30/98  12:03 PM ]
 ;;2.0;CMOP;**4,14**;11 Apr 97
EDITCK ;  Called from PROCESS+9^PSORXED to prevent editing CMOP Rx's
 N PPL
 S ZRX=PSORXED("IRXN"),PSXFILL=0,PSXTN=$G(^PSRX(ZRX,"TN"))
 S PSXFROM="EDIT"
 ;  IF CMOP drug PSXYES=1
DRUG I $D(^PSDRUG("AQ",$P(^PSRX(ZRX,0),"^",6))) S (PSXOUT,PSXYES)=1
 G:'$G(PSXYES) PSXDIEX
GETCMOP ; Any CMOP nodes?
 F PSX=0:0 S PSX=$O(^PSRX(ZRX,4,PSX)) Q:(+PSX<1)  D
 .S PSXSTAT=$P($G(^PSRX(ZRX,4,PSX,0)),"^",4)
 .S:$G(PSXSTAT)]"" PSXFLAGG=1
 .S ZFILL=$P($G(^PSRX(ZRX,4,PSX,0)),"^",3)
 .S PSX(ZFILL)=PSXSTAT
 I $G(PSXSTAT)=0!($G(PSXSTAT)=2) S PSXFLAG=1
 Q:$G(PSXHLD)
 ;Check if in suspense...
 I $D(^PS(52.5,"B",ZRX)) S PSXST=$O(^(ZRX,"")) D
 .S PSXSUSDT=$P(^PS(52.5,PSXST,0),"^",2),PSXST1=$P($G(^(0)),"^",7)
 .I $G(PSXST1)="L" S PSXFLAG=1
 .F ZZ=0:0 S ZZ=$O(^PSRX(ZRX,1,ZZ)) Q:(ZZ'>0)  I $P(^(ZZ,0),"^")=PSXSUSDT S PSXFILL=ZZ,PSX(ZZ)=$G(PSX(ZZ))_PSXST1
 .I '$O(^PSRX(ZRX,1,0)) S PSX(0)=$G(PSX(0))_$G(PSXST1)
 .S PSXM=$S(PSXFILL=0:$P(^PSRX(ZRX,0),"^",11),1:$P(^PSRX(ZRX,1,PSXFILL,0),"^",2))
PSXDIE ;
 I $G(PSXFLAG) D  S PSORXED("DFLG")=1 G PSXDIEX
 .W !!,"This prescription cannot be edited during CMOP processing."
 W !,"Now Editing Rx # ",$P(PSORXED("RX0"),"^")
 K DIE,DIC,DR,MSG
 S DIE="^PSRX(",DA=ZRX
 S PSX50=$P(^PSRX(PSORXED("IRXN"),0),"^",6)
 S MSG=$P($G(^PSDRUG(PSX50,5)),"^")
 I $G(MSG)'="" S MSG=$TR(MSG,";",","),MSG=$TR(MSG,":",","),MSG=$TR(MSG,"^",",")
 ;  PSXIDT=ISSUE DT, PSXFDT=FILL DT
 S PSXIDT=$P(^PSRX(ZRX,0),"^",13),Y=PSXIDT X ^DD("DD") S PSXIDT=Y
 S PSXFDT=$P(^PSRX(ZRX,2),"^",2),Y=PSXFDT X ^DD("DD") S PSXFDT=Y
 I $G(PSX(0))[1 W !,"ISSUE DATE: ",PSXIDT,"  (No editing)",!,"FILL DATE: ",PSXFDT,"  (No editing)"
 I $G(PSXFLAGG)!('$P(PSOPAR,"^",3)) W !,"DRUG: ",$P(^PSDRUG($P(^PSRX(PSORXED("IRXN"),0),"^",6),0),"^"),"  (No editing)"
 S DR=$S(+$G(PSX(0))'[1:"1;22R;",1:"")_"3;4;5"
 S DR=DR_$S($G(PSXFLAGG):"",'$P(PSOPAR,"^",3):"",1:";6")_";6.5;7QTY ( "_MSG_" )"
 S DR=DR_";8;17;9:11;"_$S($P(PSOPAR,"^",12):"35;",1:"")_"12;20;23;24"
 ;D ^DIE G:$D(Y)!($D(DTOUT)) UNLOCK
REFILL I $G(RFD)>0 S DR=DR_";52"
 I  S DR(2,52.1)="D CHECK^PSXEDIT;.01;@1;1"_"QTY ("_MSG_" )"_";1.1:5;8;15"
 D ^DIE K DIE,DR,X
 G:$D(Y)!($G(PSXEXIT)) UNLOCK I $D(DTOUT) S PSORXED("QFLG")=1 G PSXDIEX
UNLOCK K DRG,PSXRFL D EN1^PSONEW2(.PSORXED)
 I PSORXED("DFLG") S PSORXED("QFLG")=1 G PSXDIEX
 G:'PSORXED("QFLG") PSXDIE
 S PSORXED("QFLG")=0
TRADE ; Did tradename change?
 I $G(PSXTN)'=$P($G(^PSRX(ZRX,"TN")),"^") S PSXTN1=1 D ACT D
 .S $P(^PSRX(ZRX,"A",0),"^",3)=A,$P(^PSRX(ZRX,"A",0),"^",4)=A1
 .S ^PSRX(ZRX,"A",PSXB,0)=DT_"^E^"_DUZ_"^0^ Trade Name  "_$G(PSXTN)
 .Q
 S:'$D(^PSDRUG("AQ",$P(^PSRX(ZRX,0),"^",6))) PSXYES=0
 I PSXFILL>0,('$D(^PSRX(ZRX,1,PSXFILL,0))) G PSXDIEX
 S PSXM1=$S(PSXFILL=0:$P(^PSRX(ZRX,0),"^",11),1:$P(^PSRX(ZRX,1,PSXFILL,0),"^",2))
 I '$G(PSXTN1),($G(PSXM)=$G(PSXM1)),($G(PSXYES))!('$G(PSXST)) G PSXDIEX
 S PSXFROM="EDIT"
 S PSXPPL=ZRX D TEST^PSXNEW
SUS ; If Rx is suspended and checks out to be CMOP suspend as CMOP
 N DA
 Q:'$G(PSXSYS)
 I '$G(PPL),($G(PSXST)) D ACT D  G PSXDIEX
 .K ^PS(52.5,"AC",$P(^PSRX(ZRX,0),"^",2),$P(^PS(52.5,PSXST,0),"^",2),PSXST)
 .S DIE="^PS(52.5,",DR="3////Q",DA=PSXST D ^DIE K DIE
 .S T=$P(^PSRX(ZRX,3),"^")
 .S T1=$E(T,4,5)_"-"_$E(T,6,7)_"-"_$E(T,2,3)
 .S $P(^PSRX(ZRX,"A",0),"^",3)=A,$P(^PSRX(ZRX,"A",0),"^",4)=A1
 .D NOW^%DTC
 .I $G(PSXFILL)>5 S PSXFILL=PSXFILL+1 ; Accomodating 1 yr patch
 .S ^PSRX(ZRX,"A",PSXB,0)=%_"^S^"_DUZ_"^"_$G(PSXFILL)_"^ Suspended for CMOP "_T1
 .K T,T1,%
UNSUS ; If Rx is suspended and is not CMOP, ensure is not suspended as CMOP
 I $G(PSXST) D
 .S DIE="^PS(52.5,",DR="3////@",DA=PSXST D ^DIE K DIE
 .S ^PS(52.5,"AC",$P(^PSRX(ZRX,0),"^",2),$P(^PS(52.5,PSXST,0),"^",2),PSXST)=""
PSXDIEX ;
 K PSX,PSXA,PSXB,PSXREL,PSXST,PSXST1,ZRX,PSXIDT,PSXFROM,PSXTN1,PSX50
 K PSXFDT,PSXRXF,PSXFILL,PSXFLAG,PSXM,PSXM1,PSXSTAT,PSXSUSDT,PSXTN,ZZ
 K PSXHLD,PSXREL1,PSXSTAT,ZZ1,A,A1,ACT,PSXYES,PSXFLAGG,DIE,DR,ZPPL,MSG
 Q
ACT ;  If no act node, make one .... determine last entry
 S:'$D(^PSRX(ZRX,"A",0)) ^(0)="^52.3DA^^"
 S PSXA="" F  S PSXA=$O(^PSRX(ZRX,"A",PSXA)) Q:PSXA']""  S PSXB=PSXA+1
 S A=$P(^PSRX(ZRX,"A",0),"^",3),A1=$P(^PSRX(ZRX,"A",0),"^",4),A=A+1,A1=A1+1
 K PSXA
 Q
CHECK ;
 I $G(PSX(D1))[1 S Y="@1"
 Q
