PSORXL1 ;BIR/SAB - action to be taken on prescriptions ; 7/5/12 12:04pm
 ;;7.0;OUTPATIENT PHARMACY;**36,46,148,260,274,287,289,358,251,385,403,409**;DEC 1997;Build 2
 ;External reference to $$DS^PSSDSAPI supported by DBIA 5424
S S SPPL="",PPL1=1 S:'$G(PPL) PPL=$G(PSORX("PSOL",PPL1)) G:$G(PPL)']"" D1
S1 F PI=1:1 Q:$P(PPL,",",PI)=""  S DA=$P(PPL,",",PI) D
 .S PSORFD1=0 F PSOX7=0:0 S PSOX7=$O(^PSRX(DA,1,PSOX7)) Q:'$G(PSOX7)  S (PSORFD1)=PSOX7
 .I 'PSORFD1,$$DS^PSSDSAPI,($G(^PS(52.4,DA,1))>0)&('$D(^XUSEC("PSORPH",DUZ))) S SPPL=SPPL_DA_"," Q
 .I 'PSORFD1,$P(^PSRX(DA,"STA"),"^")=4!($D(^PSRX(DA,"DRI"))&('$D(^XUSEC("PSORPH",DUZ)))) S SPPL=SPPL_DA_"," Q
 .I $P(^PSRX(DA,"STA"),"^")<10,$P(^("STA"),"^")'=4 D SUS Q
 .K PSORFD1,PSOX7
 I $G(SPPL)]"" D  K DIR S DIR(0)="E",DIR("A")="Press Return to Continue" D ^DIR K DIR,DUOUT,DTOUT,DIRUT
 .W !!,$C(7),"Drug Interaction Rx(s) and/or Dose Warning: " F I=1:1 Q:$P(SPPL,",",I)=""  W $P(^PSRX($P(SPPL,",",I),0),"^")_", "
 .I $G(PSOLAP)=""!($G(PSOLAP)=$G(ION)) W !,"Label device must be selected for Drug Interaction or dose warning label!"
 .S PPL=SPPL,DG=1 N PPL1 D Q^PSORXL K DG,SPPL
 S SUSPT="SUSPENSE" G D1
 Q
SUS S ACT=1,RXN=DA,RX0=^PSRX(DA,0),SD=$S($G(ZD(DA)):$E(ZD(DA),1,7),1:$P(^(3),"^")),RXS=$O(^PS(52.5,"B",DA,0)) I RXS S RXCMOP=$P($G(^PS(52.5,RXS,0)),"^",7) D  Q:$G(DFLG)!($G(PSOWFLG))
 .;checks to see if future fill exists
 .S PSOWFLG=0 I '$G(RXPR(DA)),$P($G(^PS(52.5,RXS,"P")),"^")=0,$P($G(^PSRX(DA,"STA")),"^")=5 D SWARN Q:$G(PSOWFLG)
 .K PSOWFLG I $G(RXPR(DA)),'$P($G(^PS(52.5,RXS,"P")),"^") D WARN Q:$G(DFLG)
 .S DA=RXS,DIK="^PS(52.5," D ^DIK S DA=RXN I $P($G(^PSRX(RXN,"STA")),"^")=5 S $P(^("STA"),"^")=0
 G:$G(RXRP(DA))!($G(RXPR(DA))) LOCK
 I $G(PSXSYS) D SUS1^PSOCMOP I $G(XFLAG)=1 K XFLAG Q
LOCK I $P($G(^PSRX(RXN,"STA")),"^")=3 G SUSQ
 ; The PSOSITE variable will not be set by the code that processes the CMOP release message - PSO*7*403
 I '$G(PSOSITE) N PSOSITE S PSOSITE=$$RXSITE^PSOBPSUT(RXN,$G(RXFL(RXN)))
 S RXP=+$G(RXPR(DA)),DIC="^PS(52.5,",DIC(0)="L",X=RXN,DIC("DR")=".02///"_SD_";.03////"_$P(^PSRX(DA,0),"^",2)_";.04///M;.05///"_RXP_";.06////"_PSOSITE_";2///0" K DD,DO D FILE^DICN D  I +Y,'$G(RXP),$G(RXRP(RXN)) S $P(^PS(52.5,+Y,0),"^",12)=1
 .K DD,DO I +Y,$G(PSOEXREP) S $P(^PS(52.5,+Y,0),"^",12)=1
 .I +Y S $P(^PS(52.5,+Y,0),"^",13)=$G(RXFL(RXN))
 S $P(^PSRX(RXN,"STA"),"^")=5,LFD=$E(SD,4,5)_"-"_$E(SD,6,7)_"-"_$E(SD,2,3) D ACT
 W !!,$S(RXP:"Partial ",1:"")_"RX# ",$P(^PSRX(RXN,0),"^")_" has been suspended until "_LFD_"."
 S VALMSG=$S(RXP:"Partial ",1:"")_"Rx# "_$P(^PSRX(RXN,0),"^")_" Has Been Suspended Until "_LFD_"."_$S($G(RXRP(RXN))&('$G(RXP)):" (Reprint)",1:"")
 S COMM=$S(RXP:"Partial ",1:"")_"Rx# "_$P(^PSRX(RXN,0),"^")_" Has Been Suspended Until "_LFD_"."_$S($G(RXRP(RXN))&('$G(RXP)):" (Reprint)",1:"")
 D:'$D(^TMP("PSORXN",$J,RXN)) EN^PSOHLSN1(RXN,"SC","ZS",COMM)
 S:$D(^TMP("PSORXN",$J,RXN)) $P(^TMP("PSORXN",$J,RXN),"^",4)=COMM
 ;
 ; - If not a PARTIAL, reverse ECME Claim, if necessary
 I '$G(RXFL(RXN)) S RXFL(RXN)=$$LSTRFL^PSOBPSU1(RXN)
 I '$G(RXP),'$G(PSONPROG) D REVERSE^PSOBPSU1(RXN,,"DC",3)  ;PSONPROG - TRICARE or CHAMPVA in progress, don't reverse
 K COMM
 ;
 ;Telephone refill does not use list manager
 K:$G(VEXPSORX)!($G(VEXANS2)]"") VALMSG ;PSO*7*409
 ;
SUSQ Q
 ;PSO*7*274 always recalculate RXF
ACT S RXF=0 F I=0:0 S I=$O(^PSRX(DA,1,I)) Q:'I  S RXF=I S:I>5 RXF=I+1
 S IR=0 F FDA=0:0 S FDA=$O(^PSRX(DA,"A",FDA)) Q:'FDA  S IR=FDA
 S IR=IR+1,^PSRX(DA,"A",0)="^52.3DA^"_IR_"^"_IR
 D NOW^%DTC S ^PSRX(DA,"A",IR,0)=%_"^S^"_DUZ_"^"_RXF_"^"_$S(RXP:"Partial ",1:"")_"RX "_$S($G(RXRP(DA))&('$G(RXP)):"Reprint ",1:"")_"Placed on Suspense until "_LFD K RXF,I,FDA,DIC,DIE,DR,Y,X,%,%H,%I
 Q
D1 I $O(PSORX("PSOL",$G(PPL1))) S PPL1=$O(PSORX("PSOL",$G(PPL1))),PPL=PSORX("PSOL",PPL1) G S1
 G:$D(RXRS) RXS^PSORXL
 K LBL,PPL1,PPL,DIR,%DT,%,SD,COUNT,EXDT,L,PDUZ,REF,REPRINT,RFDATE,RFL1,RFLL,RXN,WARN,ZY,FLD,PI,ZD,ACT,X,Y,DIRUT,DUOUT,DTOUT,DIROUT,DFLG,RXPD,PSOWFLG
 Q
WARN W ! K DIR,DIRUT,DUOUT,DTOUT,DFLG S Y=$P(^PS(52.5,RXS,0),"^",2) X ^DD("DD") S RXPD=Y,DIR(0)="SA^S:SUSPEND;Q:QUEUE;E:EXIT"
 S DIR("A",1)="Rx #"_$P(^PSRX(DA,0),"^")_" is suspended "_$S($G(RXCMOP)]"":"for CMOP ",1:"")_"until "_RXPD
 I $G(RXCMOP)]"" D  G WARN1
 .W !!,"A partial entered for this Rx cannot be suspended."
 .W !,"You may pull this fill from suspense or print the label now.",!!
 .S DIR("A",2)=" ",DIR("A",3)="   Do you want to Queue to print",DIR("A")="                or Exit: "
 S DIR("A",2)=" ",DIR("A",3)="   Do you want to: Suspend Partial",DIR("A",4)="                   Queue to print",DIR("A")="                or Exit:  "
WARN1 S DIR("B")="EXIT",DIR("?")="^D HLP^PSORXL1" D ^DIR K DIR
 I Y="E"!($D(DIRUT))!(Y="S"&($G(RXCMOP)]"")) S DA(1)=DA,DA=RXPR(DA),DIK="^PSRX("_DA(1)_",""P""," D ^DIK S ^PSRX(DA(1),"TYPE")=0,DFLG=1 W $C(7)," Partial Removed!" Q
 I Y="Q" S DPPL=PPL,HOLDPPL1=$G(PPL1),DPI=PI,RXLTOP=1 S PPL=$G(RXN)_"," S PSPARTXX=1 D Q^PSORXL K PSPARTXX S DFLG=1,PPL=DPPL,PI=DPI,PPL1=$G(HOLDPPL1) K HOLDPPL1,DPPL,DPPI,DPI,RXLTOP Q
 Q
HLP I $G(RXCMOP)']"" W !!,"If you choose to suspend this partial Rx, the current suspended fill will",!,"be replaced by the partial.  You may want to pull this fill early instead.",!
 I $G(RXCMOP)]"" W !!,"You cannot suspend a partial when a CMOP fill is in suspense, because the partial will replace the CMOP fill in suspense."
 W !,"If you choose to queue this partial, the label will printout on the previous",!,"selected label printer.",!
 W !,"You may exit without printing or suspending this partial.  This will also delete",!,"the partial Rx entered."
 Q
SWARN ;
 S PSORXLDA=$G(DA),PSORXZD=$P($G(^PS(52.5,RXS,0)),"^",2)
 W $C(7),!!,"Rx "_$P($G(^PSRX(DA,0)),"^")_" is already suspended "_$S($G(RXCMOP)]"":"for CMOP ",1:"")_"until "_$E(PSORXZD,4,5)_"-"_$E(PSORXZD,6,7)_"-"_$E(PSORXZD,2,3)_"." K PSORXZD
 W !,"By suspending this fill, the fill that is already suspended will be overwritten",!,"and a label will not print for that fill!",!
 N PSORF,PSOTRIC D TRIC(DA)
 I PSOTRIC,$$STATUS^PSOBPSUT(DA,PSORF)'["PAYABLE" S PSOQFLAG=1 Q
 K DIR S DIR(0)="SA^Q:QUEUE;S:SUSPEND",DIR("B")="Q",DIR("A")="Do you want to Queue to print or Suspend Rx "_$P($G(^PSRX(DA,0)),"^")_": " D ^DIR K DIR
 I $G(Y)="S" K RXFL(PSORXLDA) G SWARNQ
 I $G(Y)="Q" D  G SWARNQ
 . S PSOKSPPL=$G(PPL),PSOZXPPL=$G(PPL1),PSOZXPI=$G(PI),RXLTOP=1
 . S PPL=$G(RXN)_"," D SWARS D Q^PSORXL S PSOWFLG=1,PPL=PSOKSPPL
 . S PI=PSOZXPI,PPL1=PSOZXPPL K PSOKSPPL,PSOZXPPL,PSOZXPI,RXLTOP,RXFL(+$G(PSORXLDA))
 W !!,"Nothing queued to print for Rx "_$P($G(^PSRX(PSORXLDA,0)),"^"),! S PSOWFLG=1
SWARNQ ;
 S DA=$G(PSORXLDA) K PSORXLDA
 Q
SWARS ;
 S PSOZXFL(PSORXLDA)=+$P($G(^PS(52.5,+$G(RXS),0)),"^",13) I '$G(PSOZXFL(PSORXLDA)) K PSOZXFL Q
 S PSOZXFPL=$P(PSOKSPPL,",",+$G(PI),99)
 S PSOZXFPN=$L(PSOZXFPL,PPL)-1
 I $G(PSOZXFL(PSORXLDA)),$G(PSOZXFPN) S RXFL(PSORXLDA)=$G(PSOZXFL(PSORXLDA))-$G(PSOZXFPN)
 K PSOZXFL,PSOZXFPL,PSOZXFPN
 Q
TRIC(PSORX) ;
 S PSORF=$$LSTRFL^PSOBPSU1(PSORX)
 S PSOTRIC="",PSOTRIC=$$TRIC^PSOREJP1(PSORX,PSORF,.PSOTRIC)
 Q
ECME ; - Looks for DUR/79 REJECTS and send Mail Rx's to ECME that have not been SUSPENDED
 N PSOI,PSOJ,PSORX,PSORF,PSOACT,BWH,PPLTMP,PSOSTA,PSOTRIC,ESTAT,EACTION
 S PPLTMP=$G(PPL)
 F PSOI=1:1 S PSORX=+$P($G(PPLTMP),",",PSOI) Q:'PSORX  D
 . D TRIC(PSORX) S ESTAT=$P($$STATUS^PSOBPSUT(PSORX,PSORF),"^")
 . I PSOTRIC S EACTION=$S(ESTAT["PAYABLE":1,ESTAT="":1,1:0)
 . I $G(PSOCKDC) D  Q  ;PSOCKDC variable is set in PSORXL and is used to eliminate label print for DC'ed Rx's
 . . S PSOSTA=$$GET1^DIQ(52,PSORX,100,"I") I PSOSTA=12!(PSOSTA=11),'$G(RXPR(PSORX)),$G(PPL) D RMV(PSORX,.PPL)
 . I $G(RXPR(PSORX)) Q
 . S PSOACT="",BWH=$S(PSORF:"RF",1:"OF")
 . I $$FIND^PSOREJUT(PSORX,PSORF) D  I PSOACT="Q" D RMV(PSORX,.PPL) Q
 . . S PSOACT=$$HDLG^PSOREJU1(PSORX,PSORF,"79,88",BWH,"OIQ","Q")
 Q
RMV(RX,PPL) ; Remove the Rx from the label print queue
 N XPPL,I
 S XPPL=PPL,PPL="" F I=1:1:$L(XPPL,",") I $P(XPPL,",",I)'="",$P(XPPL,",",I)'=RX S PPL=PPL_$P(XPPL,",",I)_","
 I PPL="" K PPL
 Q
