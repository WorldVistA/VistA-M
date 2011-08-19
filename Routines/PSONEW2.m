PSONEW2 ;BIR/DSD - displays new rx information for edit ;7/17/06 6:59pm
 ;;7.0;OUTPATIENT PHARMACY;**32,37,46,71,94,124,139,157,143,226,237,239,225,251,375**;DEC 1997;Build 17
 ;External reference to ^PSDRUG supported by DBIA 221
 ;External reference to ^DPT supported by DBIA 10035
 ;External reference to PSOUL^PSSLOCK supported by DBIA 2789
 ;External reference VADPT supported by DBIA 10061
 ; This routine displays the entered new rx information and
 ; asks if correct, if not allows editing of the data.
 ;------------------------------------------------------------
 ;PSO*237 issue expired error message
 ;
START ;
 S (PSONEW("DFLG"),PSONEW2("QFLG"))=0
 D STOP
 D DISPLAY ; Displays information
 ;Copay exemption checks
 D SCP^PSORN52D
 S PSONEWFF=1,PSOFLAG=1 K PSOANSQ,PSOANSQD S PSOCPZ("DFLG")=0,PSONEW("NEWCOPAY")=0
 ;can't check PSOSCA for <50 here because of PSOBILL check in PSOCPB
 I (PSOSCP<50&($P($G(^PS(53,+$G(PSONEW("PATIENT STATUS")),0)),"^",7)'=1)),$G(DUZ("AG"))="V" D COPAY^PSOCPB W !
 I PSOSCA&(PSOSCP>49)!((PSOSCA!(PSOBILL=2))&($P($G(^PS(53,+$G(PSONEW("PATIENT STATUS")),0)),"^",7)=1))!(PSOSCP>49&(PSOBILL=2)) D SC^PSOMLLD2
 I $G(PSOCPZ("DFLG")) K PSONEWFF,PSOANSQD,PSOCPZ("DFLG"),PSONEW("NEWCOPAY") S DIRUT="",PSONEW("DFLG")=1 D ASKX G END
 ;IF MILL BILL, AND COPAY (*******TEST THE COPAY CHECK)
 I $$DT^PSOMLLDT D  I $G(PSOCPZ("DFLG")) K PSONEWFF,PSOANSQD,PSOANSQ,PSOCPZ("DFLG"),PSONEW("NEWCOPAY") S DIRUT="",PSONEW("DFLG")=1 D ASKX G END
 .;New prompts Quit after first '^'
 .I $D(PSOIBQS(PSODFN,"CV")) D CV^PSOMLLDT I $G(PSOCPZ("DFLG"))!($G(PSOANSQ("CV"))) K PSONEW("NEWCOPAY")
 .I $D(PSOIBQS(PSODFN,"VEH")) D VEH^PSOMLLDT I $G(PSOCPZ("DFLG"))!($G(PSOANSQ("VEH"))) K PSONEW("NEWCOPAY")
 .I $D(PSOIBQS(PSODFN,"RAD")) D RAD^PSOMLLDT I $G(PSOCPZ("DFLG"))!($G(PSOANSQ("RAD"))) K PSONEW("NEWCOPAY")
 .I $D(PSOIBQS(PSODFN,"PGW")) D PGW^PSOMLLDT I $G(PSOCPZ("DFLG"))!($G(PSOANSQ("PGW"))) K PSONEW("NEWCOPAY")
 .I $D(PSOIBQS(PSODFN,"SHAD")) D SHAD^PSOMLLD2 I $G(PSOCPZ("DFLG"))!($G(PSOANSQ("SHAD"))) K PSONEW("NEWCOPAY")
 .I $D(PSOIBQS(PSODFN,"MST")) D MST^PSOMLLDT I $G(PSOCPZ("DFLG"))!($G(PSOANSQ("MST"))) K PSONEW("NEWCOPAY")
 .I $D(PSOIBQS(PSODFN,"HNC")) D HNC^PSOMLLDT I $G(PSOCPZ("DFLG"))!($G(PSOANSQ("HNC"))) K PSONEW("NEWCOPAY")
 K PSOCPZ("DFLG"),PSONEWFF
 D ASK K:$G(PSONEW("DFLG")) PSOANSQ G:PSONEW2("QFLG")!PSONEW("DFLG") END
 S PSORX("EDIT")=1 D EN^PSOORNE1(.PSONEW),FULL^VALM1 G:$G(PSORX("FN")) END  I '$G(PSORX("FN")) S PSONEW("DFLG")=1 K PSOANSQ G END ;D EDIT
 G:'$G(PSONEW("DFLG")) START
 S PSONEW("QFLG")=1,PSONEW("DFLG")=0
END D EOJ
 Q
 ;------------------------------------------------------------
STOP K PSEXDT,X,%DT S PSON52("QFLG")=0
 S X1=PSOID,X2=PSONEW("DAYS SUPPLY")*(PSONEW("# OF REFILLS")+1)\1
 S X2=$S(PSONEW("DAYS SUPPLY")=X2:X2,+$G(PSONEW("CS")):184,1:366)
 I X2<30 D
 . N % S %=$P($G(PSORX("PATIENT STATUS")),"^"),X2=30
 . S:%?.N %=$P($G(^PS(53,+%,0)),"^") I %["AUTH ABS" S X2=5
 D C^%DTC I PSONEW("FILL DATE")>$P(X,".") S PSEXDT=1_"^"_$P(X,".")
 K X1,X2,X,%DT
 Q
DISPLAY ;
 W !!,"Rx # ",PSONEW("RX #")
 W ?23,$E(PSONEW("FILL DATE"),4,5),"/",$E(PSONEW("FILL DATE"),6,7),"/",$E(PSONEW("FILL DATE"),2,3),!,$G(PSORX("NAME")),?30,"#",PSONEW("QTY")
 I $G(SIGOK),$O(SIG(0)) D  K D G TRN
 .F D=0:0 S D=$O(SIG(D)) W !,SIG(D) Q:'$O(SIG(D))
 E  S X=PSONEW("SIG") D SIGONE^PSOHELP W !,$G(INS1)
TRN ;I $G(PSOPRC) F I=0:0 S I=$O(PRC(I)) Q:'I  W !,PRC(I)
 W !!,$S($G(PSODRUG("TRADE NAME"))]"":PSODRUG("TRADE NAME"),1:PSODRUG("NAME"))
 W !,PSONEW("PROVIDER NAME"),?25,PSORX("CLERK CODE"),!,"# of Refills: ",PSONEW("# OF REFILLS"),!
 Q
 ;
ASK ;
 K DIR,X,Y S DIR("A")="Is this correct"
 S DIR(0)="Y",DIR("B")="YES" D ^DIR K DIR I $D(DIRUT) S PSONEW("DFLG")=1 G ASKX
ASK1 I Y D  S PSONEW2("QFLG")=1
 .S:$G(PSONEW("MAIL/WINDOW"))["W" BINGCRT=Y,BINGRTE="W"
 .D:+$G(PSEXDT)
 ..S Y=PSONEW("FILL DATE") X ^DD("DD") W !!,$C(7),Y_" fill date is greater than possible expiration date of " S Y=$P(PSEXDT,"^",2) X ^DD("DD") W Y_"."
 .D DCORD K RORD,^TMP("PSORXDC",$J)
ASKX I $D(DIRUT) D
 .I +$G(PSEXDT) K DIRUT S (PSONEW2("QFLG"),PSONEW2("DFLG"),PSONEW("DFLG"),Y)=1
 K X,Y,DIRUT,DTOUT,DUOUT
 D:+$G(PSEXDT) PAUSE^VALM1
 Q
DCORD ;dc rxs and pending orders after new order is entered
 I $G(PSORX("DFLG")) K ^TMP("PSORXDC",$J) Q
 F RORD=0:0 S RORD=$O(^TMP("PSORXDC",$J,RORD)) Q:'RORD  D @$S($P(^TMP("PSORXDC",$J,RORD,0),"^")="P":"PEN",1:"RX52")
 I $G(PSORX("FN")) S VALMBCK="Q",PSOFROM="NEW"
 K RORD,PSOTECCK H 2
 Q
PEN ;pending ^tmp("psorxdc",$j,rord,0)="p^"_rord_"^"_msg
 N PSOR,DNM S PSOR=^PS(52.41,RORD,0) S $P(^PS(52.41,RORD,0),"^",3)="DC",^PS(52.41,RORD,4)=$P(^TMP("PSORXDC",$J,RORD,0),"^",3)
 K ^PS(52.41,"AOR",PSODFN,+$P($G(^PS(52.41,RORD,"INI")),"^"),RORD)
 S DNM=$S($P(PSOR,"^",9):$P($G(^PSDRUG($P(PSOR,"^",9),0)),"^"),1:$P(^PS(50.7,$P(PSOR,"^",8),0),"^")_" "_$P(^PS(50.606,$P(^PS(50.7,$P(PSOR,"^",8),0),"^",2),0),"^"))
 D EN^PSOHLSN($P(^PS(52.41,RORD,0),"^"),"OC",$P(^TMP("PSORXDC",$J,RORD,0),"^",3),"D")
 I $G(PSOTECCK),'$D(^XUSEC("PSORPH",DUZ)) G PENX
 W $C(7),! K ^UTILITY($J,"W") S DIWL=1,DIWR=75,DIWF=""
 S X=" Duplicate "_$S($P(^TMP("PSORXDC",$J,RORD,0),"^",10):"Therapy",1:"Drug")_" Pending Order "_DNM_" has been discontinued..." D ^DIWP
 F ZX=0:0 S ZX=$O(^UTILITY($J,"W",1,ZX)) Q:'ZX  W !,^UTILITY($J,"W",1,ZX,0)
PENX K ^UTILITY($J,"W"),X,DIWL,DIWR,DIWF W !
 D PSOUL^PSSLOCK(RORD_"S") K ^TMP("PSORXDC",$J,RORD,0)
 Q
RX52 ;rxs in file 52 ^tmp("psorxdc",$j,rord,0)=52^rord^msg^rea^act^sta^dnm
 S PSCAN($P(^PSRX(RORD,0),"^"))=RORD_"^"_$P(^TMP("PSORXDC",$J,RORD,0),"^",4)
 S MSG=$P(^TMP("PSORXDC",$J,RORD,0),"^",3),REA=$P(^(0),"^",4),ACT=$P(^(0),"^",5)
 N PSONOOR S PSONOOR="D",DUP=1,DA=RORD D CAN^PSOCAN K PSONOOR
 I $G(PSOTECCK),'$D(^XUSEC("PSORPH",DUZ)) G RX52X
 W $C(7),! K ^UTILITY($J,"W") S DIWL=1,DIWR=75,DIWF=""
 S X=" Duplicate "_$S($P(^TMP("PSORXDC",$J,RORD,0),"^",10):"Therapy",1:"Drug")_" Rx #"_$P(^PSRX(RORD,0),"^")_" "_$P(^TMP("PSORXDC",$J,RORD,0),"^",7)_" has been discontinued..." D ^DIWP
 F ZX=0:0 S ZX=$O(^UTILITY($J,"W",1,ZX)) Q:'ZX  W !,^UTILITY($J,"W",1,ZX,0)
RX52X K ^UTILITY($J,"W"),X,DIWL,DIWR,DIWF W !
 K PSOSD($P(^TMP("PSORXDC",$J,RORD,0),"^",6),$P(^TMP("PSORXDC",$J,RORD,0),"^",7))
 D PSOUL^PSSLOCK(RORD) K ^TMP("PSORXDC",$J,RORD,0)
 Q
 ;
EDIT ;
 S PSORX("EDIT")=1
 D ^PSONEW3
 S PSONEW("DFLG")=$S($G(PSORX("DFLG")):1,1:0)
 Q
 ;
EOJ ;
 K PSONEW2,PSORX("EDIT"),PSORX("DFLG"),PSOEDIT,PSOSCA
 Q
 ;
EN1(PSONEW2) ; Entry point to just display and ask if okay
 S PSONEW("DFLG")=0
 I $G(^PSRX(PSONEW2("IRXN"),0))']"" S PSONEW("DFLG")=1 G EN1X
 S PSOX=^PSRX(PSONEW2("IRXN"),0),PSONEW("TRADE NAME")=$G(^("TN")),PSONEW("FILL DATE")=$P($G(^(2)),"^",2)
 S PSONEW("RX #")=$P(PSOX,"^"),PSORX("NAME")=$P(^DPT($P(PSOX,"^",2),0),"^")
 S PSONEW("QTY")=$P(PSOX,"^",7),PSODRUG("NAME")=$P(^PSDRUG($P(PSOX,"^",6),0),"^"),PSONEW("# OF REFILLS")=$P(PSOX,"^",9)
 S PSORX("CLERK CODE")=$P(^VA(200,$P(PSOX,"^",16),0),"^")
 S:$G(PSONEW("PROVIDER NAME"))="" PSONEW("PROVIDER NAME")=$P(^VA(200,$P(PSOX,"^",4),0),"^")
 S PSONEW("SIG")=$P($G(^PSRX(PSONEW2("IRXN"),"SIG")),"^")
 D DISPLAY
 D ASK
 I PSONEW("DFLG")=1 S PSONEW2("DFLG")=1
EN1X ;
 Q
 ;
EXPR ;Display Expired error message                               ;PSO*237
 S PSONEW("DFLG")=1
 W $C(7)
 S VALMSG="Order is older than 365 days and can't be finished"
 S XQORM("B")="DC"
 Q
