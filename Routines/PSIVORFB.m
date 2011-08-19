PSIVORFB ;BIR/MLM-FILE/RETRIEVE ORDERS IN ^PS(55 ;25 Sep 98 / 2:24 PM
 ;;5.0; INPATIENT MEDICATIONS ;**3,18,28,68,58,85,110,111,120,134,213,161,181**;16 DEC 97;Build 190
 ;
 ; Reference to ^PS(50.7 is supported by DBIA #2180.
 ; Reference to ^PS(51.2 is supported by DBIA #2178.
 ; Reference to ^PS(52.6 is supported by DBIA #1231.
 ; Reference to ^PS(52.7 is supported by DBIA #2173.
 ; Reference to ^PS(55 is supported by DBIA #2191.
 ; Reference to ^PS(51.1 is supported by DBIA #2177.
 ; Reference to ^PSUHL is supported by DBIA #4803.
 ; 
NEW55 ; Get new order number in 55.
 N DA,DD,DO,DIC,DLAYGO,X,Y,PSIVLIM,MINS,PSJDSTP1,PSJDSTP2,A,PSJCLIN,PSJDNM,PSJPROV,PSJWARD,PSJPAO,PSJALRT
 I $D(^PS(55,+DFN)),'$D(^PS(55,+DFN,0)) D ENSET0^PSGNE3(+DFN)
 I $G(PSJORD)["V"!($G(PSJORD)["P"),$G(P(2))]"" D LIMSTOP(.PSJDSTP1,.PSJDSTP2)
 I ($G(PSJORD)["P"!($G(PSJORD)["V"))&$G(PSIVLIM) I $$CMPLIM(PSJORD,PSJDSTP1,PSJDSTP2) D
 . D
 .. S PSJPROV=DUZ I PSJORD["P" S PSJPROV=$P($G(^PS(53.1,+PSJORD,0)),"^",2)
 .. I PSJORD["V" S PSJPROV=$P($G(^PS(55,DFN,"IV",+PSJORD,0)),"^",6)
 .. D NOW^%DTC S XQA(PSJPROV)="",XQAID="PSJ,"_DFN_";"_PSJPROV_";"_%,XQADATA=""
 .. D
 ... I PSJORD["P" S A=$G(^PS(53.1,+PSJORD,"DSS"))
 ... I PSJORD["V" S A=$G(^PS(55,PSGP,"IV",+PSJORD,"DSS"))
 ... S PSJCLIN=$P(A,"^") I PSJCLIN]"" S PSJCLIN=$P(^SC(PSJCLIN,0),"^")
 .. S A=$G(^DPT(DFN,0)),PSJWARD=$G(^(.1))
 .. S XQAMSG=$P(A,"^")_" ("_$E($P(A,"^"))_$E($P(A,"^",9),6,9)_"): ["_$S(PSJWARD]"":$E(PSJWARD,1,10),$G(PSJCLIN)]"":$E(PSJCLIN,1,10),1:"UNKNOWN")_"] "
 .. S A=$O(DRG("AD",0)) I A]"" S A=DRG("AD",A)
 .. I A="" S A=$O(DRG("SOL",0)) I A]"" S A=DRG("SOL",A)
 .. S PSJDNM=$P(^PS(50.7,+$P(A,"^",6),0),"^")
 .. S XQAMSG=XQAMSG_PSJDNM_" your DURATION not used for stop date/time"
 .. D SETUP^XQALERT
 .. S PSJALRT=$$FMTDUR^PSJLIVMD($S(PSJORD["P":$P($G(^PS(53.1,+PSJORD,2.5)),"^",4),PSJORD["IV":$P($G(^PS(55,DFN,"IV",+PSJORD,2.5)),"^",4),1:"UNK"))
 S DIC="^PS(55,",DIC(0)="LN",DLAYGO=55,(DINUM,X)=+DFN D ^DIC Q:Y<0
LOCK0 F  L +^PS(55,DFN,"IV",0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
 S ND=$S($D(^PS(55,DFN,"IV",0)):^(0),1:"^55.01") F DA=$P(ND,"^",3)+1:1 W "." I '$D(^PS(55,DFN,"IV",DA)) S $P(ND,"^",3)=DA,$P(ND,"^",4)=$P(ND,"^",4)+1,^PS(55,DFN,"IV",0)=ND Q
 L +^PS(55,DFN,"IV",+DA):$S($G(DILOCKTM)>0:DILOCKTM,1:3) E  G LOCK0
 S ^PS(55,DFN,"IV",+DA,0)=+DA,^PS(55,DFN,"IV","B",+DA,+DA)=""
 L -^PS(55,DFN,"IV",0) S ON55=+DA_"V"
 I $G(PSJALRT)]"" S PSIVAL="IV LIMIT OVERRIDDEN ("_$G(PSJALRT)_"): ALERT SENT",PSIVALT="",PSIVREA="E" D
 .D LOG^PSIVORAL S P("LIMIT")="",P("OVRIDE")=1 K IVLIM,IVLIMIT
 .S $P(^PS(55,DFN,"IV",+ON55,2.5),"^",4)="" S:$G(PSJORD)["P" $P(^PS(53.1,+PSJORD,2.5),"^",4)=""
 .K PSIVAL,PSIVREA,PSIVALT
 Q
SET55 ; Move data from local variables to 55.
 I '$D(ON55) W !,"*** Can't create this order at this time ***" Q
 N DA,DIK,ND,PSIVACT,PSIVDUR
 S:'$D(P(21)) (P(21),P("21FLG"))="" S ND(0)=+ON55,P(22)=$S(VAIN(4):+VAIN(4),1:.5) F X=2:1:23 I $D(P(X)) S $P(ND(0),U,X)=P(X)
 S ND(.3)=$G(P("INS")),ND(2.5)="" N X S X=$S($G(PSGORD):PSGORD,1:$G(ON)) I X D
 .N PKG S PKG=$E(X,$L(X)) S PKG=$S(PKG="V":"""IV""",PKG="U":5,PKG="P":"P",1:"") Q:PKG=""
 .S PSIVDUR=$$GETDUR^PSJLIVMD(DFN,+X,$E(X,$L(X)),1) Q:PSIVDUR=""
 .I $G(IVLIMIT) S ND(2.5)="^^^"_PSIVDUR K IVLIMIT Q
 S $P(ND(0),U,17)="A",ND(1)=P("REM"),ND(3)=P("OPI"),ND(.2)=$P($G(P("PD")),U)_U_$G(P("DO"))_U_+P("MR")_U_$G(P("PRY"))_U_$G(P("NAT"))_U_U_U_$G(P("PRNTON"))
 F X=0,1,2.5,3,.2,.3 S ^PS(55,DFN,"IV",+ON55,X)=ND(X)
 ; PSJ*5*213 - if Piggyback, intermittent syringe, or
 ; intermittent chemotherapy, and frequency is null, attempt to
 ; set frequency again based on P(15),PSGS0XT, and piece 3 of ZZND if they exist.
 ; If this still is null, attempt to re-set based upon the schedule name.
 I $G(P("IVCAT"))="I"!($P($G(ND(0)),U,4)?1(1"P",1"S",1"C"))&($P($G(ND(0)),U,15)="") D
 . I $P($G(ND(0)),U,4)="S",$P($G(ND(0)),U,5)'=1 Q  ;Not intermittent syringe
 . I $P($G(ND(0)),U,4)="C",$P($G(ND(0)),U,23)?1(1"A",1"H") Q  ;Not chemo piggyback or syringe
 . I $P($G(ND(0)),U,4)="C",$P($G(ND(0)),U,23)="S",$P($G(ND(0)),U,5)'=1 Q  ;Not intermitent chemo syringe
 . S $P(^PS(55,DFN,"IV",+ON55,0),U,15)=$S($G(P(15))'="":P(15),$G(PSGS0XT)'="":PSGS0XT,$P($G(ZZND),"^",3)'="":$P(ZZND,"^",3),1:$$GETFRQ($P($G(ND(0)),U,9))) K PSJFRQ,PSJSKED
 S $P(^PS(55,DFN,"IV",+ON55,2),U,1,4)=P("LOG")_U_+P("IVRM")_U_U_P("SYRS"),$P(^(2),U,8,10)=P("RES")_U_$G(P("FRES"))_U_$S($G(VAIN(4)):+VAIN(4),1:"")
 S X=^PS(55,DFN,0) I $P(X,"^",7)="" S $P(X,"^",7)=$P($P(P("LOG"),"^"),"."),$P(X,"^",8)="A",^(0)=X D LOGDFN^PSUHL(DFN)
 S $P(^PS(55,DFN,"IV",+ON55,2),U,11)=+P("CLRK")
 S:+$G(P("CLIN")) $P(^PS(55,DFN,"IV",+ON55,"DSS"),"^")=P("CLIN")
 S:+$G(P("APPT")) $P(^PS(55,DFN,"IV",+ON55,"DSS"),"^",2)=P("APPT")
 S:+$G(P("NINIT")) ^PS(55,DFN,"IV",+ON55,4)=P("NINIT")_U_P("NINITDT")
 I '$G(PSIVCHG)!($G(PSJREN)&($G(PSIVCHG)=2)) I $G(P("PON")),P("PON")'=ON55 D
 . N X S X=$S(P("PON")["P":"^PS(53.1,+P(""PON""),12,0)",P("PON")["V"&$G(PSJREN):"^PS(55,DFN,""IV"",+P(""PON""),5,0)",1:"") Q:X=""
 . I $O(@X) S %X=X,%Y="^PS(55,"_DFN_",""IV"","_+ON55_",5," D %XY^%RCR
 F DRGT="AD","SOL" D PUTD55
 K DA,DIK S DA(1)=DFN,DA=+ON55,DIK="^PS(55,"_DA(1)_",""IV"",",PSIVACT=1 D IX^DIK
 I $G(PSJCOM),$G(PSJCOMSI),$G(PSJORD)["V" K PSJCOMSI N PSJCHILD,PSJOEORD S PSJOEORD=0 F  S PSJOEORD=$O(^PS(55,"ACX",PSJCOM,PSJOEORD)) Q:'PSJOEORD  D
 . N PSJCHILD S PSJCHILD=0 F  S PSJCHILD=$O(^PS(55,"ACX",PSJCOM,PSJOEORD,PSJCHILD)) Q:'PSJCHILD  S PSJCHILD(+PSJCHILD)=PSJCOM
 . S PSJCHILD=0 F  S PSJCHILD=$O(PSJCHILD(PSJCHILD)) Q:'PSJCHILD  D
 .. Q:PSJCHILD=PSJORD  K DR,DA,DIE,ORD S DR="31////"_$P($G(P("OPI")),"^",1,2),DA(1)=DFN
 .. N ON,ON55 S (ON,ON55)=+PSJCHILD_"V" S:+$G(PSJPINIT)'>0 PSJPINIT=DUZ S PSIVALT=1,PSIVAL="COMPLEX ORDER" D ENTACT^PSIVAL D
 ... I $P($G(^PS(55,DFN,"IV",+ON55,3)),"^")'=$P(P("OPI"),"^") S P("FC")="OTHER PRINT INFO^"_$P($G(^(3)),"^")_U_$P(P("OPI"),"^") D GTFC^PSIVORAL
 ... I $D(^PS(55,DFN,"IV",+ON55,0)) S ^PS(55,DFN,"IV",+ON55,3)=P("OPI") D EN1^PSJHL2(DFN,"XX",ON55)
 Q
 ;
PUTD55 ; Move drug data from local array into 55
 K ^PS(55,DFN,"IV",+ON55,DRGT) S ^PS(55,DFN,"IV",+ON55,DRGT,0)=$S(DRGT="AD":"^55.02PA",1:"^55.11IPA")
 F X=0:0 S X=$O(DRG(DRGT,X)) Q:'X  D
 .S Y=^PS(55,DFN,"IV",+ON55,DRGT,0),$P(Y,U,3)=$P(Y,U,3)+1,DRG=$P(Y,U,3),$P(Y,U,4)=$P(Y,U,4)+1
 .S ^PS(55,DFN,"IV",+ON55,DRGT,0)=Y,Y=$P(DRG(DRGT,X),U)_U_$P(DRG(DRGT,X),U,3) S:DRGT="AD" $P(Y,U,3)=$P(DRG(DRGT,X),U,4) S ^PS(55,DFN,"IV",+ON55,DRGT,+DRG,0)=Y
 Q
GT55 ; Retrieve data from 55 into local array
 K DRG,DRGN,P S:'$D(ON55) ON55=ON S P("REN")="",Y=$G(^PS(55,DFN,"IV",+ON55,0)) F X=1:1:25 S P(X)=$P(Y,U,X)
 S P("21FLG")=P(21)
 S P("PON")=ON55,PSJORIFN=P(21),P(6)=P(6)_U_$P($G(^VA(200,+P(6),0)),U),(DRG,DRGN)="",P("REM")=$G(^PS(55,DFN,"IV",+ON55,1))
 S Y=$G(^PS(55,DFN,"IV",+ON55,2)),P("LOG")=$P(Y,U),P("IVRM")=$P(Y,U,2)_U_$P($G(^PS(59.5,+$P(Y,U,2),0)),U)
 S P("CLRK")=$P(Y,U,11)_U_$P($G(^VA(200,+$P(Y,U,11),0)),U),P("RES")=$P(Y,U,8),P("FRES")=$P(Y,U,9),P("SYRS")=$P(Y,U,4),P("OPI")=$G(^PS(55,DFN,"IV",+ON55,3))
 S P("INS")=$G(^PS(55,DFN,"IV",+ON55,.3))
 S P("CLIN")=$P($G(^PS(55,DFN,"IV",+ON55,"DSS")),"^"),P("APPT")=$P($G(^PS(55,DFN,"IV",+ON55,"DSS")),"^",2)
 S P("DTYP")=$S(P(4)="":0,P(4)="P"!(P(23)="P")!(P(5)):1,P(4)="H":2,1:3)
 D:'$D(PSJLABEL) GTPC(ON55) S ND=$G(^PS(55,DFN,"IV",+ON55,.2)),P("PD")=$S($P(ND,U):$P(ND,U)_U_$$OIDF^PSJLMUT1(+ND)_U_$P($G(^PS(50.7,+ND,0)),U),1:""),P("DO")=$P(ND,U,2),P("PRY")=$P(ND,U,4),P("NAT")=$P(ND,U,5),(PSJCOM,P("PRNTON"))=$P(ND,U,8)
 I P("PRY")="D",'+P("IVRM") S P("IVRM")=+$G(PSIVSN)_U_$P($G(^PS(59.5,+$G(PSIVSN),0)),U)
 S P("MR")=$P(ND,U,3),ND=$G(^PS(51.2,+P("MR"),0)),P("MR")=P("MR")_U_$S($P(ND,U,3)]"":$P(ND,U,3),1:$P(ND,U)) D GTCUM
 D GTDRG,GTOT^PSIVUTL(P(4))
 N ND2P5 S ND2P5=$G(^PS(55,DFN,"IV",+ON55,2.5)) D
 .S P("DUR")=$P(ND2P5,"^",2)
 .S P("LIMIT")=$P(ND2P5,"^",4)
 .S P("IVCAT")=$P(ND2P5,"^",5)
K ; Kill and exit.
 K FIL,ND
 Q
GTDRG ; Get drug info and place in DRG(.
 F DRGT="AD","SOL" S FIL=$S(DRGT="AD":52.6,1:52.7) F Y=0:0 S Y=$O(^PS(55,DFN,"IV",+ON55,DRGT,Y)) Q:'Y  D
 .; naked ref below refers to line above
 .S DRG=$G(^(Y,0)),ND=$G(^PS(FIL,+DRG,0)),(DRGI,DRG(DRGT,0))=$G(DRG(DRGT,0))+1
 .S DRG(DRGT,+DRGI)=+DRG_U_$P(ND,U)_U_$P(DRG,U,2)_U_$P(DRG,U,3)_U_$P(ND,U,13)_U_$P(ND,U,11)
 Q
 ;
GTCUM ; Retrieve dispensing info.
 S ND=$G(^PS(55,DFN,"IV",+ON55,9)),P("LF")=$P(ND,U),P("LFA")=$P(ND,U,2),P("CUM")=$P(ND,U,3)
 Q
 ;
GTPC(ON) ; Retrieve Provider Comments and create "scratch" fields to edit
 Q
 ;
SETNEW ; Create new order and set
 D NEW55,SET55
 Q
 ;
CMPLIM(PSJORD,PSJDSTP1,PSJDSTP2) ; Compare stop date of order against IV Limit
 I $P($G(^PS(53.1,+PSJORD,0)),"^",25)]"" D CHKD Q:PSJPAO 0
 I $G(PSJDSTP1),$E(+PSJDSTP1,1,11)'=$E(+P(3),1,11),+PSJDSTP2'=+P(3) Q 1
 Q 0
 ;
LIMSTOP(PSJDSTP1,PSJDSTP2) ; Calculate default stop date using IV Limit
 ;      Output: PSJDSTP1 - Default stop using duration only
 ;              PSJDSTP2 - Default stop using duration and IV parameters for time
 S PSIVLIM=$$GETLIM^PSIVCAL(DFN,PSJORD)
 I 'PSIVLIM,PSIVLIM]"" S PSIVLIM=$$GETMIN^PSIVCAL(PSIVLIM,DFN,PSJORD)
 I PSIVLIM]"" D
 . S MINS=$$GETMIN^PSIVCAL(PSIVLIM,DFN,PSJORD),PSJDSTP1=$$FMADD^XLFDT(P(2),,,MINS)
 . S X=$P(PSJDSTP1,"."),PSJDSTP2=X_$S($P(PSIVSITE,"^",14)="":.2359,1:"."_$P(PSIVSITE,"^",14))
 Q
 ;
GETFRQ(PSJSKED) ;Get frequency using name of schedule
 I PSJSKED="" K PSJSKED Q ""
 S (PSJCNTX,PSJFRQ)=""
 I $D(^PS(51.1,"APPSJ",PSJSKED)) F  S PSJCNTX=$O(^PS(51.1,"APPSJ",PSJSKED,PSJCNTX)) Q:PSJCNTX=""  D  Q:$G(PSJFRQ)'=""
 . I $P($G(^PS(51.1,PSJCNTX,0)),U,3)'="" S PSJFRQ=$P(^PS(51.1,PSJCNTX,0),U,3)
 K PSJCNTX
 Q PSJFRQ
 ;
CHKD ;Check for a previous active order and compare the duration
 N PSJPO,A,PSJDUR
 S PSJDUR=$$GETLIM^PSIVCAL(DFN,PSJORD)
 S PSJPAO=0,PSJPO=PSJORD
CHKDR S PSJPO=$P($G(^PS(53.1,+PSJPO,0)),"^",25) Q:PSJPO=""
 I PSJPO["P" G CHKDR
 I PSJPO["V" S PSIVLIM=$$GETLIM^PSIVCAL(DFN,PSJPO) I PSJDUR'=PSIVLIM S PSJPAO=1 Q
 G CHKDR
