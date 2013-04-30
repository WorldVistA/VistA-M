PSOPOST ;BIR/SAB-post init for v7 ;07/29/96  9:17 AM
 ;;7.0;OUTPATIENT PHARMACY;**30,56,73**;DEC 1997
 ;External reference to ^PS(59.7 supported by DBIA 694
 ;External reference to ^ORD(101 supported by DBIA 872
 ;External reference ^PS(55 supported by DBIA 2228
 ;External reference ^PSDRUG( supported by DBIA 221
 ;External reference to STATUS^ORQOR2 supported by DBIA 3458
 ;External reference to ^OR(100 supported by DBIA 3463
 D BMES^XPDUTL("...Setting up Outpatient Pharmacy's protocols...")
 S MENU="OR EVSEND PS",ITEM="PS RECEIVE OR" D  D SETUP1:MENUP
 .S MENUP=$O(^ORD(101,"B",MENU,0)) I 'MENUP D
 ..D BMES^XPDUTL("Cannot find the protocol menu '"_MENU_"'.")
 ..D MES^XPDUTL("You need to add the protocol '"_ITEM_"' to this protocol menu.")
 K MENU,ITEM,MENUP
 S MENU="PS EVSEND OR",ITEM="OR RECEIVE",MENUP=$O(^ORD(101,"B",MENU,0)) D SETUP1
 S XQABT4=$H,$P(^PS(59.7,1,49.99),"^")="7.0",$P(^(49.99),"^",4)=DT
 S XQABT5=$H
 D BMES^XPDUTL("Initialization Completed in "_($P($H,",",2)-PSOIT)_" seconds.") K PSOIT
 Q
SETUP1 ;
 S X=$O(^ORD(101,"B",ITEM,0)) I 'X D  Q
 .D BMES^XPDUTL("Cannot find the protocol '"_ITEM_"'.")
 .D MES^XPDUTL("You need to add this protocol to the protocol menu '"_MENU_"'.")
 I $D(^ORD(101,MENUP,10,"B",X)) D  Q
 .D BMES^XPDUTL("Protocol '"_ITEM_"' is already set up under protocol menu '"_MENU_"'.")
 I $D(^ORD(101,MENUP,10,0))[0 S ^ORD(101,MENUP,10,0)="^"_"101.01PA"
 K DA,DD,DO,DIC S DIC="^ORD(101,"_MENUP_",10,",DIC(0)="L",DLAYGO=101.01,DA(1)=MENUP D FILE^DICN K DD,DO
 D BMES^XPDUTL("Protocol '"_ITEM_"' "_$S($P(Y,"^",3):"",1:"NOT ")_"added to the protocol menu '"_MENU_"'.")
 Q
POST ;
 S $P(^PS(59.7,1,49.99),"^",6)=""
 D NOW^%DTC S $P(^PS(59.7,1,49.99),"^",7)=% K %,%H,%I,X
 F PSOPT="PSO PNDRPT","PSO PNDLBL","PSO PNDRX" D OUT^XPDMENU(PSOPT,"Unavailable - Under Construction")
 K PSOPT,DA,DIE,DR
 S IFN=0 F  S IFN=$O(^PSRX(IFN)) Q:'IFN  D:$G(^PSRX(IFN,0))]""&($P($G(^PSRX(IFN,0)),"^",2))  S:$P($G(^PSRX(IFN,0)),"^",2) $P(^PSRX(IFN,0),"^",19)=1
 .Q:$P(^PSRX(IFN,0),"^",19)
 .S X1=DT,X2=-120 D C^%DTC S CUTOFF=X
 .I $P($G(^PSRX(IFN,"OR1")),"^")']"",+$G(^PSDRUG(+$P(^PSRX(IFN,0),"^",6),2)) S $P(^PSRX(IFN,"OR1"),"^")=+$G(^PSDRUG($P(^PSRX(IFN,0),"^",6),2))
 .;moves sig from 0;10 to sig;1 and status from 0;15 to sta;1
 .I $G(^PSRX(IFN,"SIG"))']"" S ^PSRX(IFN,"SIG")=$P($G(^PSRX(IFN,0)),"^",10)_"^"_0 S $P(^PSRX(IFN,0),"^",10)=""
 .I $P($G(^PSRX(IFN,2)),"^",6)'<CUTOFF,'$P($G(^("SIG")),"^",2) D POP^PSOSIGNO(IFN)
 .I $G(^PSRX(IFN,"STA"))']"" S ^PSRX(IFN,"STA")=$P($G(^PSRX(IFN,0)),"^",15) S $P(^PSRX(IFN,0),"^",15)=""
 .I $P($G(^PSRX(IFN,2)),"^",6)<DT,$P(^("STA"),"^")<11 S $P(^PSRX(IFN,"STA"),"^")=11 D ECAN^PSOUTL(IFN)
 .S PR=0 F  S PR=$O(^PSRX(IFN,"P",PR)) Q:'PR  D
 ..I '$P($G(^PSRX(IFN,"P",PR,0)),"^") K ^PSRX(IFN,"P",PR,0) Q
 ..S ^PSRX("ADP",$E($P(^PSRX(IFN,"P",PR,0),"^"),1,7),IFN,PR)=""
 N SPAT,SDATE,SCT,SZZ,SLAST,SCMOP
 F PSO=0:0 S PSO=$O(^PS(52.5,PSO)) Q:'PSO  S PNODE=$P($G(^PS(52.5,PSO,"P")),"^"),SFLAG=1 D
 .S PSOINRX=+$P($G(^PS(52.5,PSO,0)),"^") D:PNODE&(PSOINRX)
 ..I $P($G(^PS(52.5,PSO,0)),"^",7)'="L" D  S SFLAG=0 S:$P($G(^PSRX(PSOINRX,"STA")),"^")=5 $P(^("STA"),"^")=0
 ...S SDATE=$P($G(^PS(52.5,PSO,0)),"^",2),SPAT=$P($G(^(0)),"^",3)
 ...I SDATE'="" K ^PS(52.5,"C",SDATE,PSO) I $G(PNODE)=2 K ^PS(52.5,"AC",+$G(SPAT),SDATE,PSO)
 ...K ^PS(52.5,"AF",+$G(SPAT),PSO)
 ...I $P($G(^DPT(+$G(SPAT),0)),"^")'="" K ^PS(52.5,"D",$P(^(0),"^"),PSO)
 ...K ^PS(52.5,"B",PSOINRX,PSO)
 ...S SCMOP=$P($G(^PS(52.5,PSO,0)),"^",7) I SCMOP'="" D
 ....I SCMOP="Q"!(SCMOP="X")!(SCMOP="P") I SDATE'="" K ^PS(52.5,$S(SCMOP="Q":"AQ",SCMOP="X":"AX",1:"AP"),$G(SDATE),+$G(SPAT),PSO)
 ....I SCMOP="P"!(SCMOP="Q") K ^PS(52.5,"AG",+$G(SPAT),PSO)
 ...K ^PS(52.5,PSO,"P"),^PS(52.5,PSO,0)
 .I SFLAG,$P($G(^PSRX(PSOINRX,0)),"^",6) S $P(^PS(52.5,PSO,0),"^",10)=$P($G(^PSDRUG($P($G(^PSRX(PSOINRX,0)),"^",6),0)),"^",3)
 S SCT=0 F SZZ=0:0 S SZZ=$O(^PS(52.5,SZZ)) Q:'SZZ  S SCT=SCT+1 S:'$O(^PS(52.5,SZZ)) SLAST=SZZ
 S ^PS(52.5,0)="RX SUSPENSE^52.5PI^"_+$G(SLAST)_"^"_SCT
 K DIK,PNODE,PSO,SFLAG,PSOINRX,IFN,PR
 F PSOPT="PSO PNDRPT","PSO PNDLBL","PSO PNDRX" D OUT^XPDMENU(PSOPT,"")
 D NOW^%DTC S $P(^PS(59.7,1,49.99),"^",6)=% K %,%H,%I,X,DA,DR,DIE,PSOPT
 S ZTQUEUED="@" Q
RESTART ;
 I $P(^PS(59.7,1,49.99),"^")'="7.0" S $P(^PS(59.7,1,49.99),"^")="7.0"
 I $S($D(DUZ)[0:1,'$D(^VA(200,$G(DUZ),0)):1,$D(DUZ(0))[0:1,1:0) W !!,$C(7),"DUZ and DUZ(0) must be defined as an active user.",!!
 S ZTDTH=$H,ZTRTN="POST^PSOPOST",ZTIO="",ZTDESC="Outpatient Pharmacy version 7.0 background conversion restart." D ^%ZTLOAD
 W !,"Background Job queued to run.",!
 Q
CLOZ ;
 N DFN,XX
 F DFN=0:0 S DFN=$O(^PS(55,"ASAND",DFN)) Q:'DFN  D:$D(^PS(55,DFN,"SAND"))
 .S XX=$P(^PS(55,DFN,"SAND"),"^",2)
 .I $L(XX)>1 S $P(^PS(55,DFN,"SAND"),"^",2)=$S("A,D,H,P,"[($E(XX)_","):$E(XX),1:"")
 Q
PCLO S ZTDTH=$H,ZTRTN="CLOZ^PSOPOST",ZTIO="",ZTDESC="Outpatient Pharmacy clozapine patient status correction starts" D ^%ZTLOAD
 W !,"Background Job queued to run.",!
 Q
 ;
AGF ;PSO*7*73 - AG x-ref fix
 I $D(^XTMP("PSO73")) W !!,"Use the entry point BEG^PSOPOST to restart - quitting " Q
 S P73=1
BEG W !!,?10,"*** 'AG' CROSS-REFERENCE CLEANUP PROCESS ***",!
 I '$D(DUZ) W !!,"DUZ NOT DEFINED - QUITTING",!! Q
 S TY="PSO73"
 I '$G(P73) D  Q:$G(PQ)
 .I $G(^XTMP(TY,"A"))]"" S EXD=$P(^XTMP(TY,"A"),"^") D:EXD
 ..W !,"Cleanup was done up to "_$E(EXD,4,5)_"-"_$E(EXD,6,7)_"-"_$E(EXD,2,3)_" of phase "_$P(^XTMP(TY,"A"),"^",2)_"."
 ..W !,"It will continue from this date forward."
 .E  S IDT=$S($P($G(^PS(59.7,1,49.99)),"^",7):$P(^PS(59.7,1,49.99),"^",7),1:$P($G(^PS(59.7,1,49.99)),"^",4)) D
 ..I 'IDT S PQ=1 W !,"Outpatient Pharmacy V. 7.0 not installed" Q
 ..E  W !,"Cleanup will start from "_$E(IDT,4,5)_"-"_$E(IDT,6,7)_"-"_$E(IDT,2,3)_" (Outpatient Pharmacy V. 7.0 installed date)." K ^XTMP(TY)
 .Q:$G(PQ)
 .D W
 I $G(P73) K ^XTMP(TY),P73 D
 .W !,"To the following prompt you can respond with the date/time to queue the"
 .W !,"cleanup background job or enter '^' to skip scheduling." D W
 K %DT D NOW^%DTC S %DT="RAEX",%DT(0)=%,%DT("A")="Select the Date/Time to queue the cleanup background job: "
 D ^%DT K %DT
 I $D(DTOUT)!(Y<0) W !!!?10,"Cleanup job not queued.." Q
 S ZTDTH=$G(Y),ZTRTN="AGC^PSOPOST",ZTIO="",ZTDESC="Outpatient Pharmacy AG cross-reference correction has started"
 D ^%ZTLOAD W:$D(ZTSK) !!,"Task Queued To Run!",!
 Q
W W !,"A mail message will be sent to the installer upon completion of this job.",!
 Q
AGC ;
 S TY="PSO73" I '$G(DT) S DT=$$DT^XLFDT
 S IDT=$S($P($G(^PS(59.7,1,49.99)),"^",7):$P(^PS(59.7,1,49.99),"^",7),1:$P($G(^PS(59.7,1,49.99)),"^",4))
 I 'IDT S ^XTMP(TY,1)="Outpatient Pharmacy V. 7.0 not installed" G SND
 S X1=IDT,X2=-121 D C^%DTC S IDT=X
 S EXD=IDT D NOW^%DTC S Y=% X ^DD("DD")
 I '$D(^XTMP(TY)) S X1=DT,X2=+30 D C^%DTC S ^XTMP(TY,0)=$G(X)_"^"_DT,^XTMP(TY,"A")=EXD G EN0
 I $D(^XTMP(TY,"A")) D  I EXD S YY="EN"_PH G @YY
 .S EXD=$P(^XTMP(TY,"A"),"^") S:'EXD EXD=IDT
 .S PH=$P(^XTMP(TY,"A"),"^",2) S:'PH PH=0
 .I EXD>IDT D
 ..S ^XTMP(TY,1)="Scanning the 'AG' cross-reference from date: "_$E(EXD,4,5)_"-"_$E(EXD,6,7)_"-"_$E(EXD,2,3)_$S(PH:" (Phase "_PH_")",1:""),^XTMP(TY,2)=""
 ..S ^XTMP(TY,3)="Cleanup Start Date/Time: "_Y,^XTMP(TY,4)=""
 Q
EN0 S $P(^XTMP(TY,"A"),"^",2)=0
 S ^XTMP(TY,1)="Scanning the 'AG' cross-reference from date: "_$E(EXD,4,5)_"-"_$E(EXD,6,7)_"-"_$E(EXD,2,3),^XTMP(TY,2)=""
 S ^XTMP(TY,3)="Cleanup Start Date/Time: "_Y,^XTMP(TY,4)=""
 S EXD=EXD-1
 F  S EXD=$O(^PSRX("AG",EXD)) Q:'EXD  S $P(^XTMP(TY,"A"),"^")=EXD,RX=0 F  S RX=$O(^PSRX("AG",EXD,RX)) Q:'RX  D
 .I '$D(^PSRX(RX))!('$D(^PSRX(RX,0)))!('$D(^PSRX(RX,2))) K ^PSRX("AG",EXD,RX) Q
 .S X=$P($G(^PSRX(RX,2)),"^",6) Q:X'?7N
 .I X'=EXD K ^PSRX("AG",EXD,RX) S ^PSRX("AG",X,RX)=""
 S EXD=IDT
EN1 S EXD=EXD-1 S $P(^XTMP(TY,"A"),"^",2)=1
 F  S EXD=$O(^PSRX("AD",EXD)) Q:'EXD  S $P(^XTMP(TY,"A"),"^")=EXD,RX=0 F  S RX=$O(^PSRX("AD",EXD,RX)) Q:'RX  S RF="" F  S RF=$O(^PSRX("AD",EXD,RX,RF)) Q:RF=""!(RF)  D
 .Q:'$D(^PSRX(RX,0))!('$P($G(^PSRX(RX,0)),"^",2))!('$D(^PSRX(RX,2)))
 .S X=$P($G(^PSRX(RX,2)),"^",6) Q:X'?7N
 .Q:$D(^PSRX("AG",X,RX))
 .S ^PSRX("AG",X,RX)=""
 S EXD=IDT
EN2 S EXD=EXD-1 S $P(^XTMP(TY,"A"),"^",2)=2
 F  S EXD=$O(^PSRX("AG",EXD)) Q:'EXD!(EXD'<DT)  S $P(^XTMP(TY,"A"),"^")=EXD,RX=0 F  S RX=$O(^PSRX("AG",EXD,RX)) Q:'RX  D
 .Q:'$D(^PSRX(RX))!('$D(^PSRX(RX,0)))!('$D(^PSRX(RX,2)))!('$D(^PSRX(RX,"STA"))) 
 .S ST=+$P($G(^PSRX(RX,"STA")),"^") I ST,ST=12!(ST=14)!(ST=15) D:$P($G(^("OR1")),"^",2)
 ..S ORN=$P(^PSRX(RX,"OR1"),"^",2) I +$$STATUS^ORQOR2(ORN)=7 D
 ...S (II,JJ)=0 F  S II=$O(^PSRX(RX,"A",II)) Q:'II  S:$P($G(^(II,0)),"^",2)="C"!($P($G(^(0)),"^",2)="L") JJ=II
 ...D:JJ MSG
 D NOW^%DTC S Y=% X ^DD("DD") S ^XTMP(TY,5)="Cleanup End Date/Time: "_Y,^XTMP(TY,6)=""
SND S XMY(DUZ)="",XMDUZ="Patch PSO*7*73"
 S XMSUB="PATCH PSO*7*73 - 'AG' Cross-reference Cleanup Information"
 S XMTEXT="^XTMP(TY," D ^XMD K XMY,^XTMP(TY)
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
MSG ;
 S ACR=$G(^PSRX(RX,"A",JJ,0)),PHR=$P(ACR,"^",3),AL=$P(ACR,"^",5),ADT=$P(ACR,"^")
 S (PNO,COM)=""
 I AL["Renewed" S COM="Renewed by Pharmacy"
 I AL["Auto Discontinued" S PHR="",PNO="A",COM=$E($P(AL,".",2),2,99) S:COM="" COM=AL
 I AL["Discontinued During" S COM="Discontinued by Pharmacy"
 S ZZDU=DUZ S:PHR DUZ=PHR D EN^PSOHLSN1(RX,"OD",$S(ST=15:"RP",1:""),COM,PNO) S DUZ=ZZDU
 I 'ADT S ADT=$E(DT_".2200",1,12)
 I $D(^OR(100,ORN,6)) S $P(^(6),"^",3)=$E(ADT,1,12)
 I $D(^OR(100,ORN,3)) S $P(^(3),"^")=ADT
 Q
