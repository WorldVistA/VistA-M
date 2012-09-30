PSOCAN4 ;BIR/SAB - rx speed dc listman ;10/23/06 11:50am
 ;;7.0;OUTPATIENT PHARMACY;**20,24,27,63,88,117,131,259,268,225,358,385**;DEC 1997;Build 27
 ;External reference to File #200 supported by DBIA 224
 ;External reference NA^ORX1 supported by DBIA 2186
 ;External references to L, UL, PSOL, and PSOUL^PSSLOCK supported by DBIA 2789
 ;External reference to PSDRUG supported by DBIA 221
 ;External reference to PS(50.7 supported by DBIA 2223
 ;External reference to PS(50.606 supported by DBIA 2174
 ;External reference to ELIG^VADPT supported by DBIA 10061
SEL I '$D(^XUSEC("PSORPH",DUZ)) S VALMSG="Unauthorized Action Selection.",VALMBCK="" Q
 N VALMCNT I '$G(PSOCNT) S VALMSG="This patient has no Prescriptions!" S VALMBCK="" Q
 S DFNHLD=PSODFN
 S PSOPLCK=$$L^PSSLOCK(PSODFN,0) I '$G(PSOPLCK) D LOCK^PSOORCPY S VALMSG=$S($P($G(PSOPLCK),"^",2)'="":$P($G(PSOPLCK),"^",2)_" is working on this patient.",1:"Another person is entering orders for this patient.") K PSOPLCK S VALMBCK="" Q
 K PSOPLCK S RXCNT=0 K PSOFDR,DIR,DUOUT,DIRUT S DIR("A")="Select Orders by number",DIR(0)="LO^1:"_PSOCNT D ^DIR S LST=Y I $D(DTOUT)!($D(DUOUT)) K DIR,DIRUT,DTOUT,DUOUT S VALMBCK="" D ULP Q
 K DIR,DIRUT,DTOUT,PSOOELSE,DTOUT I +LST S (SPEED,PSOOELSE)=1 D  D KCAN^PSOCAN3
 .S PSOCANRA=1 D RQTEST
 .; The PSOTRIC variable is needed by NOOR, which is called by COM^PSOCAN1, to determine the default Nature of Order.
 .N PSOTRIC S PSOTRIC=$$ELIG(PSODFN)
 .D FULL^VALM1,COM^PSOCAN1 I '$D(INCOM)!($D(DIRUT)) K SPEED S VALMBCK="R" Q
 .D FULL^VALM1 F ORD=1:1:$L(LST,",") Q:$P(LST,",",ORD)']""  S ORN=$P(LST,",",ORD) D @$S(+PSOLST(ORN)=52:"RX",1:"PEN")
 .S VALMBCK="R"
 I '$G(PSOOELSE) S VALMBCK=""
 D ^PSOBUILD,BLD^PSOORUT1,RV^PSOORFL K PSOMSG,RXCNT,DIR,DIRUT,DTOUT,DUOUT,LST,ORD,IEN,ORN,RPH,ST,REFL,REF,PSOACT,ORSV,PSORNW,PSORENW,PSONO,PSOCO,PSOCU,PSODIR,DSMSG,SAVORD,SAVORN,SPEED,DIRUT,PSONOOR
 D INVALD^PSOCAN1 K PSINV,PSOOELSE,INCOM,COM S PSODFN=DFNHLD K DFNHLD D ULP
 Q
ULP D UL^PSSLOCK(+$G(PSODFN)) Q
 ;
RX Q:'$D(^XUSEC("PSORPH",DUZ))
 D PSOL^PSSLOCK($P(PSOLST(ORN),"^",2)) I '$G(PSOMSG) D  D PAUSE^VALM1 K PSOMSG Q
 .I $P($G(PSOMSG),"^",2)'="" W $C(7),!!,$P($G(PSOMSG),"^",2),!,"Rx "_$P(^PSRX($P(PSOLST(ORN),"^",2),0),"^"),! Q
 .W $C(7),!!,"Another person is editing Rx "_$P(^PSRX($P(PSOLST(ORN),"^",2),0),"^"),!
 S RXSP=1 K PSCAN S (EN,X)=$P(^PSRX($P(PSOLST(ORN),"^",2),0),"^") S Y=$P(PSOLST(ORN),"^",2)_"^"_X,Y(0,0)=X,Y(0)=$G(^PSRX($P(PSOLST(ORN),"^",2),0)) D
 .I $P(^PSRX(+Y,"STA"),"^")=1!($P(^("STA"),"^")=4) D  Q
 ..I $P($G(^PSRX(+Y,"PKI")),"^") N PKI,PKI1,PKIR,PKIE,DA S DA=+Y D CER^PSOPKIV1
 ..S:$G(PSONOOR)'="" PSONOORA=$G(PSONOOR) D DEL S:$G(PSONOORA)'="" PSONOOR=$G(PSONOORA) K PSONOORA Q
 .S YY=Y,YY(0,0)=Y(0,0),(PSODFN,DFN)=$P(Y(0),"^",2) D:$G(DFN) CHK^PSOCAN I DEAD!($P(^PSRX(+YY,"STA"),"^")>11),$P(^("STA"),"^")<16 S PSINV(EN)="" Q
 .S DA=+YY I $P($G(^PSRX(DA,"STA")),"^")=11!($P($G(^(2)),"^",6)<DT) D EXP^PSOCAN
 .S RX=YY(0,0) D:$D(^PSRX(DA,0)) SPEED1^PSOCAN1
 K YY I '$D(PSCAN) D PSOUL^PSSLOCK($P(PSOLST(ORN),"^",2)) Q
 S RX="",RXCNT=0 F  S RX=$O(PSCAN(RX)) Q:RX=""  S DA=+PSCAN(RX),REA=$P(PSCAN(RX),"^",2),RXCNT=RXCNT+1 D SHOW^PSOCAN1
 S RX="" F  S RX=$O(PSCAN(RX)) Q:RX=""  D ACT
 D PSOUL^PSSLOCK($P(PSOLST(ORN),"^",2))
 Q
ACT S DA=+PSCAN(RX),REA=$P(PSCAN(RX),"^",2),II=RX,PSODFN=$P(^PSRX(DA,0),"^",2) I REA="R" D REINS^PSOCAN2 Q
 D CAN1^PSOCAN3 Q
PEN ;discontinue pending orders
 S SAVORD=ORD,SAVORN=ORN
 S ORD=$P(PSOLST(ORN),"^",2) D PSOL^PSSLOCK(+ORD_"S") I '$G(PSOMSG) D  D MEDDIS K PSOMSG G OK
 .I $P($G(PSOMSG),"^",2)'="" W $C(7),!!,$P($G(PSOMSG),"^",2)_"  (Pending order)",! Q
 .W $C(7),!!,"Another person is editing this Pending order.",!
 I $P(^PS(52.41,ORD,0),"^",3)="RF" S DA=ORD,DIK="^PS(52.41," D ^DIK K DA,DIK D PSOUL^PSSLOCK(ORD_"S") Q
 K ^PS(52.41,"AOR",$P(^PS(52.41,ORD,0),"^",2),+$P($G(^PS(52.41,ORD,"INI")),"^"),ORD) S $P(^PS(52.41,ORD,0),"^",3)="DC"
 D EN^PSOHLSN(+^PS(52.41,ORD,0),"OC",INCOM,PSONOOR)
 D PSOUL^PSSLOCK(ORD_"S")
OK S ORD=SAVORD,ORN=SAVORN Q
NOOR ;ask nature of order
 N RX
 I '$D(PSOTRIC),$G(ORN) S RX=+$P($G(PSOLST(ORN)),U,2) I RX N PSOTRIC S PSOTRIC=$$TRIC^PSOREJP1(RX)
 D FULL^VALM1
 K DIR,DTOUT,DTOUT,DIRUT I $T(NA^ORX1)]"" D  Q:$D(DIRUT)  G NOORXP
 .S PSONOOR=$$NA^ORX1($S($G(PSOTRIC):"R",1:"S"),0,"B","Nature of Order",0,"WPSDIVR"_$S(+$G(^VA(200,DUZ,"PS")):"E",1:""))
 .I +PSONOOR S PSONOOR=$P(PSONOOR,"^",3) Q
 .S DIRUT=1 K PSONOOR
 ;cnf, PSO*7*358, default to "SERVICE REJECTED" if TRICARE or CHAMPVA
 S DIR("A")="Nature of Order: ",DIR("B")=$S($G(PSOTRIC):"SERVICE REJECTED",$G(DODR):"SERVICE CORRECTED",1:"WRITTEN")
 S DIR(0)="SA^W:WRITTEN;V:VERBAL;P:TELEPHONE;S:SERVICE CORRECTED;D:DUPLICATE;I:POLICY;R:SERVICE REJECTED"_$S(+$G(^VA(200,DUZ,"PS")):";E:PROVIDER ENTERED",1:"")
 D ^DIR K DIR,DTOUT,DTOUT Q:$D(DIRUT)  S PSONOOR=Y
NOORXP I $G(PSOCANRA),'$G(PSOCANRZ) D REQ
NOORX S:$D(DIRUT)&($G(SPEED)) VALMBCK="Q"
 Q
DEL ;deletes non-verified Rxs
 D FULL^VALM1
 W ! K DIR,DIRUT,DUOUT S DIR(0)="Y",DIR("B")="No",DIR("A",1)="Rx # "_$P(^PSRX($P(PSOLST(ORN),"^",2),0),"^")_" is in a Non-Verified Status.",DIR("A")="Are sure you want to mark the Rx as deleted" D ^DIR I 'Y!($D(DIRUT)) S VALMBCK="R" G EX
 I '$G(SPEED) D  I $D(DIRUT) G EX
 .D NOOR I $D(DIRUT) S VALMSG="No Action Taken!",VALMBCK="R" Q
 .K DIR S DIR("A")="Comments",DIR("B")="Per Pharmacy Request",DIR(0)="F^5:100" D ^DIR K DIR I $D(DIRUT) S VALMSG="No Action Taken!" Q
 K PSDEL,PSORX("INTERVENE") S PSOZVER=1,DA=$P(PSOLST(ORN),"^",2)
 I $G(PKI1) N INCOM S INCOM=Y D DCV^PSOPKIV1 Q
 D ENQ^PSORXDL
EX Q
REQ ;prompt for requesting provider
 I '$G(PSOCANRD),$G(PSOCANRP),$G(ORD),$D(^PS(52.41,ORD,0)) S PSOCANRD=+$P($G(^PS(52.41,ORD,0)),"^",5)
 I $G(PSOCANRD) D
 .I $D(^VA(200,PSOCANRD,"PS")),$P($G(^("PS")),"^"),$S('$P(^("PS"),"^",4):1,1:$P(^("PS"),"^",4)'<DT) Q
 .K PSOCANRD
 W ! K DIC S DIC=200,DIC(0)="AEQMZ",DIC("A")="Requesting PROVIDER: ",DIC("S")="I $D(^(""PS"")),$P(^(""PS""),""^""),$S('$P(^(""PS""),""^"",4):1,1:$P(^(""PS""),""^"",4)'<DT)" I $G(PSOCANRD) S DIC("B")=PSOCANRD
 D ^DIC K DIC S:$G(Y)<0!($D(DTOUT))!($D(DUOUT)) DIRUT=1 I $G(Y) S PSOCANRC=+$G(Y),PSOCANRN=$P($G(Y),"^",2),PSOCANRZ=1
 Q
RQTEST ;
 N PMIN,PMINZ,PMINFLAG
 S PMINFLAG=0 F PMIN=1:1:$L(LST,",") Q:$P(LST,",",PMIN)']""  S PMINZ=$P(LST,",",PMIN) D
 .I $P($G(PSOLST(PMINZ)),"^")=52 I $P($G(^PSRX(+$P($G(PSOLST(PMINZ)),"^",2),"STA")),"^")'=12,'$G(PMINFLAG) S PSOCANRD=+$P($G(^PSRX(+$P($G(PSOLST(PMINZ)),"^",2),0)),"^",4) S PMINFLAG=1
 .I $P($G(PSOLST(PMINZ)),"^")=52.41,'$G(PMINFLAG) S PSOCANRD=$P($G(^PS(52.41,+$P($G(PSOLST(PMINZ)),"^",2),0)),"^",5) S PMINFLAG=1
 I '$G(PMINFLAG) S PSOCANRZ=1
 Q
MEDDIS ;
 N PSOFMMD
 Q:'$G(ORD)
 Q:'$D(^PS(52.41,ORD,0))
 I $P(^PS(52.41,ORD,0),"^",9) W "Drug: "_$P($G(^PSDRUG(+$P(^PS(52.41,ORD,0),"^",9),0)),"^") D PAUSE^VALM1 Q
 I $P(^PS(52.41,ORD,0),"^",8) S PSOFMMD=$P(^(0),"^",8) W "Orderable Item: "_$P($G(^PS(50.7,PSOFMMD,0)),"^")_"  "_$P($G(^PS(50.606,+$P($G(^PS(50.7,PSOFMMD,0)),"^",2),0)),"^") D PAUSE^VALM1
 Q
 ;
REF ;CONT. FROM REF^PSOCAN2; PSO*7*259
 N PSOSIEN S PSOSIEN=0
 F  S PSOSIEN=$O(^PS(52.5,"B",DA,PSOSIEN)) Q:'PSOSIEN  D  Q:PSONODEL
 .I $P($G(^PS(52.5,PSOSIEN,0)),"^",13)'=IFN Q  ;NOT SAME REFILL
 .I '$P($G(^PS(52.5,PSOSIEN,"P")),"^") Q  ;SUSPENSE LABEL PRINT
 .S PSONODEL=1   ;REFILL NODE SHOULD NOT BE DELETED
 Q
 ;
ELIG(DFN) ; Return primary eligibility
 ; Input:
 ;   DFN: Patient IEN (required)
 ; Output:
 ;   "": No DFN passed in, 0: Veteran, 1: TRICARE, 2: CHAMPVA
 I '$G(DFN) Q ""
 ; Variables VAEL, VAERR, and I are modified by ELIG^VADPT
 N VAEL,VAERR,I,ELIG
 ; ELIG^VADPT assumes DFN is defined and returns arrays VAEL and VAERR
 D ELIG^VADPT ; Supported by IA 10061
 ; VAEL(1) contains the primary eligibility
 S ELIG=$P($G(VAEL(1)),U,2)
 Q $S(ELIG="TRICARE"!(ELIG="SHARING AGREEMENT"):1,ELIG="CHAMPVA":2,1:0)
