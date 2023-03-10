PSORXED ;IHS/DSD/JCM - edit rx utility ;Dec 03, 2020@10:39:54
 ;;7.0;OUTPATIENT PHARMACY;**2,16,21,26,56,71,125,201,246,289,298,366,385,403,421,482,512,621,441**;DEC 1997;Build 208
 ;External reference to ^PSXEDIT supported by DBIA 2209
 ;External reference to ^DD(52 supported by DBIA 999
 ;External reference to ^PSDRUG supported by DBIA 221
 ;External reference to ^PS(55 supported by DBIA 2228
 ;
START ;this entry point is no longer used.
 ;D INIT,LKUP G:PSORXED("QFLG") END D PARSE,EOJ G START
 ;
END D EOJ
 Q
 ;
INIT S PSORXED("QFLG")=0 Q
 ;
LKUP ; this line of code is no longer used S PSONUM="RX",PSONUM("A")="EDIT",PSOQFLG=0 D EN1^PSONUM I PSOQFLG!($Q(PSOLIST)']"") S PSORXED("QFLG")=1
 K PSOQFLG Q
 ;
PARSE F PSORXED("LIST")=1:1 Q:'$D(PSOLIST(PSORXED("LIST")))!PSORXED("QFLG")  F PSORXED("I")=1:1:$L(PSOLIST(PSORXED("LIST"))) S PSORXED("IRXN")=$P(PSOLIST(PSORXED("LIST")),",",PSORXED("I")) D:+PSORXED("IRXN") PROCESS
 Q
 ;
PROCESS S PSORXED("DFLG")=0 G:$G(^PSRX(PSORXED("IRXN"),0))']"" PROCESSX
 ;*298 Track PI and Oth Lang PI
 S PSORXED("RX0")=^PSRX(PSORXED("IRXN"),0),PSORXED("RX2")=^(2),PSORXED("RX3")=^(3)
 S PSOSIG=$G(^PSRX(PSORXED("IRXN"),"SIG"))
 S PSODAYS=$P(PSORXED("RX0"),"^",8)
 S PSOPINS=$G(^PSRX(PSORXED("IRXN"),"INS"))
 S PSOOINS=$G(^PSRX(PSORXED("IRXN"),"INSS"))
 S (I,RFED,RFDT)=0
 F  S I=$O(^PSRX(PSORXED("IRXN"),1,I)) Q:'I  D
 . S RFED=I
 . S PSORXED("RX1")=^PSRX(PSORXED("IRXN"),1,I,0),RFDT=$P(^(0),"^"),PSODAYS=$P(^(0),"^",10) S:$P(^(0),"^",17) PSONEW("PROVIDER NAME")=$P(^VA(200,$P(^(0),"^",17),0),"^")
 S PSORXST=+$P($G(^PS(53,+$P(PSORXED("RX0"),"^",3),0)),"^",7)
 N DA
 S DA=PSORXED("IRXN")
 D EN^PSORXPR
 D CHECK G:PSORXED("DFLG") PROCESSX
 N X
 S X="PSXEDIT" X ^%ZOSF("TEST") K X I $T D ^PSXEDIT I $G(PSXOUT) K PSXOUT G L1
 D DIE^PSORXED1
 ;
L1 D LOG,POST
 ;
PROCESSX Q
 ;
CHECK Q  L +^PSRX(PSORXED("IRXN")):$S(+$G(^DD("DILOCKTM"))>0:+^DD("DILOCKTM"),1:3) I '$T W $C(7),!!,"Rx Number is Locked by Another User!",! S PSORXED("DFLG")=1 H 5 Q
 I $G(^PSDRUG($P(PSORXED("RX0"),"^",6),"I"))]"",^("I")<DT D  G CHECKX
 . W !,$C(7),"This drug has been inactivated. ",! S PSORXED("DFLG")=1 Q
 ;
 K PSPOP I $G(PSODIV),$P(PSORXED("RX2"),"^",9)'=PSOSITE S PSPRXN=PSORXED("IRXN") D CHK1^PSOUTLA I $G(PSPOP)=1 S PSORXED("DFLG")=1 G CHECKX
 ;
 I $P(^PSRX(PSORXED("IRXN"),"STA"),"^")=14!($P(^("STA"),"^")=15) S PSORXED("DFLG")=1 W !!,$C(7),"Discontinued prescriptions cannot be edited.",! G CHECKX
 I $D(^PS(52.4,"B",PSORXED("IRXN"))) S PSORXED("DFLG")=1 W !!,$C(7),"Non-verified prescriptions cannot be edited.",!
 ;
CHECKX K PSPOP,DIR,DTOUT,DUOUT,Y,X Q
 ;
LOG K PSFROM S DA=PSORXED("IRXN"),(PSRX0,RX0)=PSORXED("RX0"),QTY=$P(RX0,"^",7),QTY=QTY-$P(^PSRX(DA,0),"^",7) K ZD(DA) S:'$O(^PSRX(DA,1,0)) ZD(DA)=$P(^PSRX(DA,2),"^",2)
 ;
 ; PSOBPS and PSOTRIC are used to check eligibility. Eligibility checking
 ; is only needed for non-billable Rxs (ie PSOBPS'="e")
 N PSOBPS,PSOTRIC
 S PSOBPS=$$ECME^PSOBPSUT(PSORXED("IRXN"))
 S PSOTRIC=$$TRIC^PSOREJP1(PSORXED("IRXN"),0,.PSOTRIC)
 ;
 S COM="" F I=3,4,5:1:13,17 I $P(PSRX0,"^",I)'=$P(^PSRX(DA,0),"^",I) S PSI=$S(I=13:1,1:I),COM=COM_$P(^DD(52,PSI,0),"^")_" ("_$P(PSRX0,"^",I)_"),"
 ;
 N PSOFILDAT
 S PSOFILDAT=0   ; fill date edit flag
 ;
 I $P(PSORXED("RX2"),"^",2)'=$P(^PSRX(DA,2),"^",2) S COM=COM_$P(^DD(52,22,0),"^")_" ("_$P(PSORXED("RX2"),"^",2)_"),",PSOFILDAT=1     ; set flag indicating the original fill date was edited
 I $P(PSORXED("RX3"),"^",7)'=$P(^PSRX(DA,3),"^",7) S COM=COM_$P(^DD(52,12,0),"^")_" ("_$P(PSORXED("RX3"),"^",7)_"),"
 I PSOSIG'=$P($G(^PSRX(DA,"SIG")),"^") S COM=COM_$P(^DD(52,10,0),"^")_" ("_PSOSIG_"),"
 ;*298 Track PI and Oth Lang PI
 I PSOPINS'=$G(^PSRX(DA,"INS")) S COM=COM_$P(^DD(52,114,0),"^")_" ("_PSOPINS_"),"
 I PSOOINS'=$G(^PSRX(DA,"INSS")) S COM=COM_$P(^DD(52,114.1,0),"^")_" ("_PSOOINS_"),"
 I PSOPIND'=$P($G(^PSRX(DA,"IND")),"^") S COM=COM_$P(^DD(52,128,0),"^")_" ("_PSOPIND_")," ;*441-IND
 I PSOPINDF'=$P($G(^PSRX(DA,"IND")),"^",2) S COM=COM_$P(^DD(52,129,0),"^")_" ("_PSOPINDF_")," ;*441-IND
 I PSOTRN'=$G(^PSRX(DA,"TN")) S COM=COM_$P(^DD(52,6.5,0),"^")_" ("_PSOTRN_"),"
 D FILL
 I '$$RXRLDT^PSOBPSUT(PSORXED("IRXN"),PSOEDITF),COM="",PSOBPS="e" D LBLCHK G:'PSOEDITL LOGX G LOG1
 I PSOTRIC&('$$RXRLDT^PSOBPSUT(PSORXED("IRXN"),PSOEDITF)),COM="",PSOBPS'="e" D LBLCHK G LOGX ; labels for unreleased TRICARE/CHAMPVA resolved claims; when COM'="" label always printed
 I PSOTRIC&(COM=""),PSOBPS'="e" D LBL D ASKL:PSOEDITL G:'PSOEDITL LOGX G LOG1
 I COM="" S RX0=^PSRX(DA,0),RX2=^(2),J=DA,OEXDT=+$P(RX2,"^",6) D ^PSOEXDT G LOGX
  K PSRX0 S X=$S($D(PSOCLC):PSOCLC,1:DUZ)
 S K=1,D1=0 F Z=0:0 S Z=$O(^PSRX(DA,"A",Z)) Q:'Z  S D1=Z,K=K+1
 S D1=D1+1 S:'($D(^PSRX(DA,"A",0))#2) ^(0)="^52.3DA^^^" S ^(0)=$P(^(0),"^",1,2)_"^"_D1_"^"_K
 ;
 ;PSO*7*366
 D NOW^%DTC S ^PSRX(DA,"A",D1,0)=%_"^E^"_$G(DUZ)_"^0^"_COM
 ;
LOG1 ;
 I QTY,$P(^PSRX(DA,2),"^",13) S ^PSDRUG($P(^PSRX(DA,0),"^",6),660.1)=$S($D(^PSDRUG(+$P(^PSRX(DA,0),"^",6),660.1)):^(660.1)+QTY,1:QTY)
 S:$P(RX0,"^",6)'=$P(^PSRX(DA,0),"^",6) ^PSDRUG(+$P(^PSRX(DA,0),"^",6),660.1)=$S($D(^PSDRUG(+$P(RX0,"^",6),660.1)):^(660.1)+$P(RX0,"^",7),1:$P(RX0,"^",7))
 S RX0=^PSRX(DA,0),RX2=^(2),J=DA,OEXDT=+$P(RX2,"^",6) D ^PSOEXDT S NEXDT=+$P(RX2,"^",6) I OEXDT'=NEXDT D
 .K ^PSRX("AG",OEXDT,DA) S ^PSRX("AG",NEXDT,DA)=""
 .S D=+$P(RX0,"^",2) K ^PS(55,D,"P","A",OEXDT,DA) S ^PS(55,D,"P","A",NEXDT,DA)=""
 K D,OEXDT,NEXDT
 ;
 ; Do not add RX to the label list when there are:
 ;   1) Unresolved DUR/Refill Too Soon/RRR rejects
 ;   2) Unresolved TRICARE/CHAMPVA rejects
 ;   3) TRICARE/CHAMPVA claims that are IN PROGRESS
 ;   4) Being edited from Mail or Window to Park  ;ADDED PAPI LINE OF CODE
 ; But if the Fill Date was modified then bypass these checks and allow to update the label list  - PSO*7*403
 I 'PSOFILDAT,$$ECMECHK^PSOREJU3(DA,$G(PSOEDITF)) G LOGX
 ;
 ; If Rx is non-billable
 I PSOBPS'="e" G:+$P(^PSRX(J,"STA"),"^")!($G(PSOEDITL)=1&('$G(PSOTRIC))) LOGX S RXFL(PSORXED("IRXN"))=$S($G(PSOEDITF):$G(PSOEDITF),1:0) I $G(PSORX("PSOL",1))']"",'$G(PSOTOPK) S PSORX("PSOL",1)=PSORXED("IRXN")_"," D SETRP G LOGX
 I PSOBPS'="e" G:$G(PSOEDITL)=1&('$G(PSOTRIC)) LOGX
 ;
 ; If Rx is billable
 I PSOBPS="e",$$RXRLDT^PSOBPSUT(DA,$G(PSOEDITF)) G LOGX
 I PSOBPS="e" D  I 'PTLBL G LOGX
 . S PTLBL=1,PSOACT=0
 . F  S PSOACT=$O(^PSRX(DA,"A",PSOACT)) Q:'PSOACT  D  Q:'PTLBL
 . . I $$GET1^DIQ(52.3,PSOACT_","_DA,.05,"E")["CMOP Suspense Label Printed" S PTLBL=0
 I $G(PSOTOPK) G LOGX  ;ADDED PAPI
 ;
 I PSOBPS="e" G:+$P(^PSRX(J,"STA"),"^")!($G(PSOEDITL)=1&('$G(PSOTRIC))) LOGX S RXFL(PSORXED("IRXN"))=$S($G(PSOEDITF):$G(PSOEDITF),1:0) I $G(PSORX("PSOL",1))']"" I '$G(PSOTOPK) S PSORX("PSOL",1)=PSORXED("IRXN")_"," D SETRP G LOGX
 ;
 F PSOX1=0:0 S PSOX1=$O(PSORX("PSOL",PSOX1)) Q:'PSOX1  S PSOX2=PSOX1
 I $L(PSORX("PSOL",PSOX2))+$L(PSORXED("IRXN"))<220 D  G LOGX
 .I PSORX("PSOL",PSOX2)'[PSORXED("IRXN")_"," S PSORX("PSOL",PSOX2)=PSORX("PSOL",PSOX2)_PSORXED("IRXN")_"," D SETRP
 E  I $G(PSORX("PSOL",PSOX2+1))'[PSORXED("IRXN")_"," S PSORX("PSOL",PSOX2+1)=PSORXED("IRXN")_"," D SETRP   ;;PSO*7*246
 ;
LOGX K PSOEDITF,PSOEDITR,PSOEDITL D:$G(RFED) ^PSORXED1
 K PSOTOPK,PSOFRPK   ;ADDED PAPI LINE OF CODE
 Q
 ;
POST ; D NEXT D:$G(^PSRX(PSORXED("IRXN"),"IB"))]"" COPAY K PSODAYS,PSORXST
 D NEXT D COPAY K PSODAYS,PSORXST
 Q
 ;
COPAY S DA=PSORXED("IRXN") I 'RFD,PSODAYS'=+$P(^PSRX(DA,0),"^",8) I +$G(^PSRX(DA,"IB"))!($P($G(^PSRX(DA,"PFS")),"^",2)) D CPCK G RXST
 I RFD,+$G(^PSRX(DA,1,RFD,0)),PSODAYS'=$P($G(^PSRX(DA,1,RFD,0)),"^",10) I +$G(^PSRX(DA,"IB"))!($P($G(^PSRX(DA,1,RFD,"PFS")),"^",2)) D CPCK
 ;
RXST G:PSORXST=+$P($G(^PS(53,+$P(^PSRX(DA,0),"^",3),0)),"^",7) COPAYX
 W !,$C(7),"Patient Status field for this Rx has been changed from a ",$S(PSORXST=0:"COPAYMENT ELIGIBLE",PSORXST=1:"COPAYMENT EXEMPT",1:"")
 W !,"patient status."
 W "  The copay status for this Rx will be automatically adjusted."
 W !,"If action needs to be taken to adjust charges you MUST use the"
 W !,"Reset Copay Status/Cancel Charges option."
 W ! K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR
 I +$P($G(^PS(53,+$P(^PSRX(DA,0),"^",3),0)),"^",7)=1 D  ; SET TO NO COPAY AND AUDIT CHANGE
 . I '$D(^PSRX(DA,"IB")) S ^PSRX(DA,"IB")=""
 . S $P(^PSRX(DA,"IB"),"^",1)=""
 . S PSODA=DA
 . S PSOREF=RFD
 . S PSOCOMM="Rx Patient Status Change"
 . S PSOOLD="Copay"
 . S PSONW="No Copay"
 . S PREA="R"
 . D ACTLOG^PSOCPA
 ;
COPAYX K DA,PSODAYS,PSO,PSODA,PSOFLAG,PSORXST,RFD,PSOREF,PSOCOMM,PSOOLD,PSONW
 Q
 ;
CPCK ;update COPAY
 I 'RFD,'$D(^PSRX(DA,"PFS")) G CPCK1
 I RFD,'$D(^PSRX(DA,1,RFD,"PFS")) G CPCK1
 N PSOPFS S PSOPFS=$P($S('RFD:^PSRX(DA,"PFS"),1:^PSRX(DA,1,RFD,"PFS")),"^",1,2)
 I +$G(PSOPFS)>0&('$P($G(PSOPFS),"^",2)) K PSOPFS Q
 I +$G(PSOPFS)<1 K PSOPFS
 E  S PSOPFS="1^"_PSOPFS
 ;
CPCK1 N TYPE S PSO=2,PSODA=DA,PSOFLAG=1,PSOPAR7=$G(^PS(59,PSOSITE,"IB")),TYPE=RFD D RXED^PSOCPA K TYPE
 Q
 ;
NEXT D NEXT^PSOUTIL(.PSORXED) K DIE,DR,DA S DIE="^PSRX(",DA=PSORXED("IRXN")
 S DR="101///"_$P(PSORXED("RX3"),"^")_";102///"_$P(PSORXED("RX3"),"^",2) D ^DIE K DIE,DR,DA,X,Y
 Q
 ;
EOJ K PSOSIG,PSORXED,PSOLIST,END,PSRX0,PSOPINS,PSOOINS
 D EX^PSORXED1
 Q
 ;
FILL ;
 K PSOEDITF,PSOEDITR,PSOERF
 F PSOEZ=0:0 S PSOEZ=$O(^PSRX(DA,1,PSOEZ)) Q:'PSOEZ  S:$D(^PSRX(DA,1,PSOEZ,0)) PSOERF=PSOEZ
 S PSOEDITF=$S($G(PSOERF):+$G(PSOERF),1:0)
 I PSOEDITF S PSOEDITR=$S($P($G(^PSRX(DA,1,PSOEDITF,0)),"^",18):1,1:0) G FILLX
 S PSOEDITR=$S($P($G(^PSRX(DA,2)),"^",13):1,1:0)
 ;
FILLX K PSOERF,PSOEZ
 Q
 ;
LBL ;
 S PSOEDITL=0 N PSOECMES S PSOECMES="",PSOECMES=$$STATUS^PSOBPSUT(PSORXED("IRXN"),PSOEDITF)
 I PSOTRIC D  Q:'PSOEDITL
 . I PSOECMES["IN PROGRESS"!(PSOECMES["REJECTED") S PSOEDITL=0 Q
 . I $$FIND^PSOREJUT(PSORXED("IRXN"),PSOEDITF,,,1) S PSOEDITL=0 Q
 . I ",12,14,15,"[(","_$P($G(^PSRX(PSORXED("IRXN"),"STA")),"^")_",") S PSOEDITL=0 Q
 . I COM="" S:'$G(PSOEDITF)&$G(PSOEDITR) PSOEDITL=2 Q
 Q:PSOEDITL=2&($G(PSOTRIC))&(COM="")
 I COM["PROV"!(COM["QTY")!(COM["DAYS")!(COM["MAIL")!(COM["UNIT")!(COM["FILL DATE")!(COM["REMARKS") I COM'["STATUS",COM'["CLINIC",COM'["DRUG",COM'["REFILLS",COM'["ISSUE",COM'["SIG",COM'["TRADE" D  Q
 .I $G(PSOEDITF) S PSOEDITL=1 Q
 .I '$G(PSOEDITF),'$G(PSOEDITR),PSOTRIC S PSOEDITL=2 Q
 .I '$G(PSOEDITF),$G(PSOEDITR) S PSOEDITL=2
 I '$G(PSOEDITF),$G(PSOEDITR) S PSOEDITL=2 Q
 I '$G(PSOEDITF),'$G(PSOEDITR) S PSOEDITL=0 Q
 I $G(RXRP(DA)) S PSOEDITL=1 Q
 I '$G(RXRP(DA)),$G(PSOEDITR) S PSOEDITL=2 Q
 S PSOEDITL=0
 Q
 ;
LBLCHK ;
 ;
 ; If Rx is non-billable perform checks and quit
 I PSOBPS'="e" D  Q
 . I '$$RXRLDT^PSOBPSUT(PSORXED("IRXN"),PSOEDITF) D
 . . I $$PTLBL^PSOREJP2(PSORXED("IRXN"),PSOEDITF) D PRINT^PSOREJP3(PSORXED("IRXN"),PSOEDITF)
 ;
 ; Rx is billable
 ;
 ; If the PSOEDITL flag is set to 1, the user will be given the QUEUE
 ; prompt; if set to 0, the QUEUE prompt is suppressed.
 ; PSORX("NOLABEL") is used to determine if the Label Prompt should
 ; be displayed to the user by calling routine.
 ;
 S PSOEDITL=0
 S PSORX("NOLABEL")=1
 ;
 I $$RXRLDT^PSOBPSUT(PSORXED("IRXN"),PSOEDITF) Q
 ;
 I $$PTLBL^PSOREJP2(PSORXED("IRXN"),PSOEDITF) D
 . S PSORX("NOLABEL")=0
 . I $D(PSORX("QFLG")) S PSOEDITL=1
 . E  D PRINT^PSOREJP3(PSORXED("IRXN"),PSOEDITF)
 Q
 ;
ASKL ;
 W ! K DIR S DIR("?",1)="You have edited a fill that has already been released. Do you want to",DIR("?",2)="include this prescription as one of the prescriptions to be acted upon",DIR("?",3)="at the label prompt."
 S DIR("?")="Enter 'Yes' to generate a reprint label request."
 S DIR(0)="Y",DIR("A")="The last fill has been released, do you want a reprint label",DIR("B")="Y" D ^DIR K DIR I Y'=1 S PSOEDITL=0 Q  ; User did not reply as "YES" - don't prompt for label device
 S PSOEDITL=1
 Q
 ;
SETRP I '$G(PSOTOPK),$P($G(^PSRX(PSORXED("IRXN"),"STA")),"^")'=5,$G(PSOEDITL)=0 S RXRP(PSORXED("IRXN"))="1^^^1",VALMSG="Label will reprint due to Edit"
 Q
