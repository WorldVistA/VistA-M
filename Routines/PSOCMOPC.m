PSOCMOPC ;BIR/HTW-Utility for CMOP/OP Edit ;8/30/96
 ;;7.0;OUTPATIENT PHARMACY;**2,30,43**;DEC 1997
 ;External reference to ^PS(55 supported by DBIA 2228
 ;External reference to ^PSDRUG supported by DBIA 221
EN(XDA) N A,A1,CMOP,PSOA,PSOB,PSOCK,T,T1,DA
 ;
 S DA=XDA
 D ^PSOCMOPA
 ;                Q:If not in suspense file, set status to 0 - active
 I '$G(CMOP("52.5")) D  Q
 . S:+$P($G(PSOLST(ORN)),"^",2) ^PSRX($P(PSOLST(ORN),"^",2),"STA")=0
 ;
 D CHECK
 I $G(CMOP("S"))']"",($G(CMOP)) D ACT D   G QUIT
 .K ^PS(52.5,"AC",$P(^PSRX(XDA,0),"^",2),$P(^PS(52.5,CMOP("52.5"),0),"^",2),CMOP("52.5"))
 .S DIE="^PS(52.5,",DR="3////Q",DA=CMOP("52.5") D ^DIE K DIE
 .S T=$P(^PSRX(XDA,3),"^")
 .S T1=$E(T,4,5)_"-"_$E(T,6,7)_"-"_$E(T,2,3)
 .S $P(^PSRX(XDA,"A",0),"^",3)=A,$P(^PSRX(XDA,"A",0),"^",4)=A1
 .D NOW^%DTC
 .S ^PSRX(XDA,"A",PSOB,0)=%_"^S^"_DUZ_"^"_$S($G(CMOP("L"))<6:$G(CMOP("L")),1:$G(CMOP("L"))+1)_"^ Placed on Suspense for CMOP until "_T1
 .K T,T1,%
UNSUS ; If Rx is suspended and is not CMOP, ensure is not suspended as CMOP
 I $G(CMOP("S"))["Q",('$G(CMOP)) D  G QUIT
 .S DIE="^PS(52.5,",DR="3////@",DA=CMOP("52.5") D ^DIE K DIE,DR
 .S ^PS(52.5,"AC",$P(^PSRX(XDA,0),"^",2),$P(^PS(52.5,DA,0),"^",2),DA)=""
 .D ACT
 .S T=$P(^PSRX(XDA,3),"^")
 .S T1=$E(T,4,5)_"-"_$E(T,6,7)_"-"_$E(T,2,3)
 .S $P(^PSRX(XDA,"A",0),"^",3)=A,$P(^PSRX(XDA,"A",0),"^",4)=A1
 .D NOW^%DTC
 .S ^PSRX(XDA,"A",PSOB,0)=%_"^S^"_DUZ_"^"_$S($G(CMOP("L"))<6:$G(CMOP("L")),1:$G(CMOP("L"))+1)_"^ Removed from CMOP Suspense, returned to OP Suspense. "_T1
 .S DA=XDA
QUIT K A,A1,CMOP,PSOA,PSOB,PSOCK,T,T1,XDA Q
ACT ;  If no act node, make one .... determine last entry
 S:'$D(^PSRX(XDA,"A",0)) ^(0)="^52.3XDA^^"
 S PSOA="" F  S PSOA=$O(^PSRX(XDA,"A",PSOA)) Q:PSOA']""  S PSOB=PSOA+1
 S A=$P(^PSRX(XDA,"A",0),"^",3),A1=$P(^PSRX(XDA,"A",0),"^",4),A=A+1,A1=A1+1
 K PSOA
 Q
CHECK S CMOP=0 Q:'$G(PSXSYS)
 ;           Q:Partial or Reprint
 S PSOCMSUS=$O(^PS(52.5,"B",XDA,0))
 I $G(PSOCMSUS) I $P($G(^PS(52.5,PSOCMSUS,0)),"^",5)!($P($G(^(0)),"^",12)) K PSOCMSUS Q
 K PSOCMSUS
 ;           Q:Do not Mail
 S PSOCMPAT=+$P($G(^PSRX(XDA,0)),"^",2),PSOCMDT=$P($G(^PS(55,PSOCMPAT,0)),"^",5),PSOCMMAI=$P($G(^PS(55,PSOCMPAT,0)),"^",3)
 I $G(PSOCMMAI)>1,$S($G(PSOCMDT)=""!($G(PSOCMDT)>DT):1,1:0) D KMAIL Q
 D KMAIL
 ;          Get drug IEN and check if CMOP
 S PSOCK=$P($G(^PSRX(XDA,0)),"^",6) Q:'$D(^PSDRUG("AQ",PSOCK))
 I $P($G(^PSDRUG(+$G(PSOCK),2)),"^",3)'["O" Q
 Q:$G(PSOFROM)="PARTIAL"
 ;           Q:If tradename
 Q:$G(^PSRX(XDA,"TN"))]""
 ;           Q: If Cancelled, Expired, Deleted
 Q:$P($G(^PSRX(XDA,"STA")),"^")>10
 ;           Q: If pending
 Q:$P($G(^PSRX(XDA,"STA")),"^")=4
 ;           Q:If not "Mail"
 S PSOMW=$S($G(CMOP("L"))>0:$P(^PSRX(XDA,1,CMOP("L"),0),"^",2),1:$P(^PSRX(XDA,0),"^",11)) I $G(PSOMW)="W"  K CMOP("L") Q
 ;           Q:If fill was CMOPed and other than '3' 'not dispensed'
 Q:'$$FILTRAN^PSOCMOP(XDA,CMOP("L"))
 S CMOP=1
 Q
KMAIL K PSOCMPAT,PSOCMDT,PSOCMMAI Q
