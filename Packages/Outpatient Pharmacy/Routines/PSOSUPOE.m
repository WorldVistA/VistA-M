PSOSUPOE ;BIR/RTR - Suspense pull via Listman ;3/1/96
 ;;7.0;OUTPATIENT PHARMACY;**8,21,27,34,130,148,281,287,289,358,385,403,427**;DEC 1997;Build 21
 ;External references PSOL and PSOUL^PSSLOCK supported by DBIA 2789
SEL I '$G(PSOCNT) S VALMSG="This patient has no Prescriptions!" S VALMBCK="" Q
 N PSOGETF,PSOGET,PSOGETFN,ORD,ORN,MW,PDUZ,PSLST,PSOSQ,PSOSQRTE,PSOSQMTH,PSPOP,PSOX1,PSOX2,RXLTOP,RXREC,SFN,SORD,SORN,VALMCNT
 K DIR,DUOUT,DTOUT S DIR("A")="Select Orders by number",DIR(0)="LO^1:"_PSOCNT D ^DIR K DIR I $D(DTOUT)!($D(DUOUT))!('Y) S VALMSG="Nothing pulled from suspense!",VALMBCK="" Q
 S PSLST=Y
SELQ D FULL^VALM1
 K DIR S DIR("A")="Select routing for Rx(s)",DIR(0)="S^M:MAIL;W:WINDOW",DIR("B")="WINDOW" D ^DIR K DIR I Y["^"!($D(DTOUT))!($D(DUOUT)) G END
 S PSOSQRTE=Y I $G(PSOSQRTE)="W",$P(PSOPAR,"^",12) K DIR S DIR(0)="FO^2:60",DIR("A")="METHOD OF PICK-UP" D ^DIR S PSOSQMTH=$G(Y) K DIR I Y["^"!($D(DTOUT))!($D(DUOUT)) G END
 W ! K DIR S DIR(0)="Y",DIR("A")="Pull Rx(s) and delete from suspense",DIR("B")="YES" D  D ^DIR K DIR I Y'=1 G END
 .S DIR("?",1)="Enter Yes to pull selected Rx(s) from suspense. Since(Rx(s) pulled early from",DIR("?",2)="suspense are not associated with a printed batch, these Rx(s) cannot be"
 .S DIR("?",3)="reprinted from suspense using the 'Reprint batches from suspense' option.",DIR("?")="Therefore, any Rx(s) pulled early from suspense will be deleted from suspense."
 Q:$G(PULLONE)
 F SORD=1:1:$L(PSLST,",") Q:$P(PSLST,",",SORD)']""  S SORN=$P(PSLST,",",SORD) D:+PSOLST(SORN)=52 BEG
 S VALMBCK="R"
 I '$G(PSOSQ) S VALMSG="No Rx's pulled from suspense!"
 Q
BEG ;
 S RXREC=$P(PSOLST(SORN),"^",2)
BEGQ Q:'$D(^PSRX(+$G(RXREC),0))
 D PSOL^PSSLOCK(RXREC) I '$G(PSOMSG) W !!,$S($P($G(PSOMSG),"^",2)'="":$P($G(PSOMSG),"^",2),1:"Another person is editing Rx "_$P($G(^PSRX(RXREC,0)),"^")),! K PSOMSG D DIR Q
 K PSOMSG I $P($G(^PSRX(RXREC,"STA")),"^")'=5 W !!,"Rx# ",$P(^PSRX(RXREC,0),"^")," is not on Suspense!" D DIR,ULRX Q
 S SFN=$O(^PS(52.5,"B",RXREC,0)) I 'SFN D DIR,ULRX Q
 S PDUZ=DUZ I +$G(^PS(52.5,SFN,"P")) W !,">>> Rx #",$P(^PSRX(+$P(^(0),"^"),0),"^")," ALREADY PRINTED FROM SUSPENSE.",!,?5,"USE THE REPRINT OPTION TO REPRINT LABEL." D DIR,ULRX Q
 I +$P($G(^PSRX(RXREC,2)),"^",6)<DT,+$P($G(^("STA")),"^")<11 D  S DIE=52,DA=RXREC,DR="100///11" D ^DIE S DA=SFN,DIK="^PS(52.5," D ^DIK K DIE,DA,DIK W !,"Rx # "_$P(^PSRX(RXREC,0),"^")_" has expired!" D DIR,ULRX Q
 .N PSCOU,AAA,VVV,QQQ,PSOPRT,PSOEXPI D EX^PSOSUTL
 I $D(RXRP(RXREC)) W !!,"A reprint has already been requested for Rx # ",$P($G(^PSRX(RXREC,0)),"^") D DIR,ULRX Q
 I $D(RXPR(RXREC)) W !!,"A partial has already been requested for Rx # ",$P($G(^PSRX(RXREC,0)),"^") D DIR,ULRX Q
 S PSPOP=0 I $G(PSODIV),$P($G(^PS(52.5,SFN,0)),"^",6)'=$G(PSOSITE) D CKDIV I $G(PSPOP) D DIR,ULRX Q
 ;
 ; PSO*427-Check if Label Log indicates a label was already printed.
 N PRNTED,RFL
 S RFL=$P($G(^PS(52.5,SFN,0)),"^",13)
 S PRNTED=$$PRINTED^PSOSULBL(SFN,RXREC,RFL)
 ; PSO*427-If previously printed, ask user whether to continue.  If NO (0), remove from suspense.  If NO (0) or exit (-1), unlock and quit
 I PRNTED N CONT S CONT=$$PRTQUES^PSOSUPRX(RXREC,RFL) I CONT'=1 D  Q
 . I CONT=0 D REMOVE^PSOSULBL(SFN,RXREC,RFL,DUZ,1,PRNTED)
 . I CONT=-1 W !,"This prescription will not be pulled but will be left on suspense."
 . D DIR,ULRX
 ;
 ; Submitting Rx to ECME for 3rd Party Billing and checking the outcome
 ; If there are unresolved DUR, Refill Too Soon, or TRICARE/CHAMPVA rejects, we will not add the RX to the
 ;   list of RXs that are pulled from suspense
 ; We also need to quit if the user discontinued from the reject notification screen as the RX Suspense record
 ;   is deleted by a discontinue
 N ACTION S ACTION=""
 I '$D(RXPR(RXREC)) D  I ACTION="Q"!(ACTION="D") D ULRX Q
 . N RFL S RFL=$G(RXFL(RXREC)) I RFL="" S RFL=$$LSTRFL^PSOBPSU1(RXREC)
 . D ECMESND^PSOBPSU1(RXREC,RFL,,"PP")
 . ; Quit if there is an unresolved TRICARE/CHAMPVA non-billable reject code, PSO*7*358
 . I $$PSOET^PSOREJP3(RXREC,RFL) S ACTION="Q" W !!,"Pull early cannot be done for non-billable TRICARE/CHAMPVA Rx on the worklist" D DIR Q
 . ; Check for unresolved rejects
 . I $$FIND^PSOREJUT(RXREC,RFL) S ACTION=$$HDLG^PSOREJU1(RXREC,RFL,"79,88","PP","IOQ","Q")
 . ; Check for TRICARE/CHAMPVA that are not complete
 . I $$TRIC^PSOREJP1(RXREC,RFL),$P($$STATUS^PSOBPSUT(RXREC,RFL),U)="IN PROGRESS" S ACTION="Q" W !!,"Pull early cannot be done for IN PROGRESS TRICARE/CHAMPVA Rx" D DIR Q
 ;
 S:$P(^PS(52.5,SFN,0),"^",5) RXPR(RXREC)=$P(^(0),"^",5) S:$P(^PS(52.5,SFN,0),"^",12) RXRP(RXREC)=1
 S RXFL(RXREC)=$P($G(^PS(52.5,SFN,0)),"^",13),RXRS(RXREC)=$G(PSODFN),RXLTOP=1
 S RXRS(RXREC)=$G(RXRS(RXREC))_"^"_$S($P($G(^PS(52.5,SFN,0)),"^",4)="W":"W",1:"M")_"^"_$P($G(^PSRX(RXREC,"MP")),"^") S PSOGET="M" D GETMW
 S RXRS(RXREC)=$G(RXRS(RXREC))_"^"_$G(PSOGETF)_"^"_$G(PSOGETFN)_"^"_$S($G(PSOGET)="W":"W",1:"M")
 S $P(^PS(52.5,SFN,0),"^",4)=$G(PSOSQRTE) S MW=$G(PSOSQRTE) N RR,RFCNT D MAILS^PSOSUPAT I $D(PSOSQMTH) S $P(^PSRX(RXREC,"MP"),"^")=$G(PSOSQMTH)
 S PSOSQ=1
 ;
 D ULRX K PSOGET,PSOGETF
 Q
WIND ;
 N RRT,RRTT,XXXX,JJJJ,PSINTRX,RTETEST,PSOPSO,SSSS
 S PBINGRTE=0,PSINTRX=RXREC
 I $G(RXPR(RXREC)) S RTETEST=$P($G(^PSRX(RXREC,"P",RXPR(PSINTRX),0)),"^",2) S:RTETEST="W" PBINGRTE=1 Q
 S PSOPSO=0 F SSSS=0:0 S SSSS=$O(^PSRX(PSINTRX,1,SSSS)) Q:'SSSS  S PSOPSO=SSSS
 I 'PSOPSO S RTETEST=$P($G(^PSRX(PSINTRX,0)),"^",11) S:RTETEST="W" PBINGRTE=1 Q
 I PSOPSO S RTETEST=$P($G(^PSRX(PSINTRX,1,PSOPSO,0)),"^",2) S:RTETEST="W" PBINGRTE=1 Q
 Q
DIR ;
 W ! K DIR S DIR(0)="E",DIR("A")="Press Return to Continue" D ^DIR K DIR Q
END S VALMSG="Nothing pulled from suspense!",VALMBCK="R" S:$G(PULLONE)=1 PULLONE=2 Q
ADD ;Add Rx to SPSORX array
 I $G(SPSORX("PSOL",1))']"" S SPSORX("PSOL",1)=RXREC_"," Q
 F PSOX1=0:0 S PSOX1=$O(SPSORX("PSOL",PSOX1)) Q:'PSOX1  S PSOX2=PSOX1
 I $L(SPSORX("PSOL",PSOX2))+$L(RXREC)<220 S SPSORX("PSOL",PSOX2)=SPSORX("PSOL",PSOX2)_RXREC_"," Q
 S SPSORX("PSOL",PSOX2+1)=RXREC_","
 Q
BBADD ;
 N PSOX1,PSOX2
 I $G(BBRX(1))']"" S BBRX(1)=RXREC_"," Q
 F PSOX1=0:0 S PSOX1=$O(BBRX(PSOX1)) Q:'PSOX1  S PSOX2=PSOX1
 I $L(BBRX(PSOX2))+$L(RXREC)<220 S BBRX(PSOX2)=BBRX(PSOX2)_RXREC_"," Q
 S BBRX(PSOX2+1)=RXREC_","
 Q
PPLADD ;
 ; This function will move entries from the RXRS array (which has RXs that were pulled
 ; from supense via the PP action on the Medication profile) to the list of RXs that
 ; will get a label (PPL variable and possible PSORX array).
 ;
 ; Note that arrays RXRS and PSORX and variable PPL are pre-existing
 ;
 N SZZ,SPSOX1,SPSOX2,LSFN
 I $G(PPL)'="",$E(PPL,$L(PPL))'="," S PPL=PPL_","
 ;
 ; Loop through entries in the RXRS array and process
 S SZZ=0 F  S SZZ=$O(RXRS(SZZ)) Q:'SZZ  D
 .;
 .; Check if label already printed per the RX SUSPENSE file
 .S LSFN=$O(^PS(52.5,"B",SZZ,0))
 .Q:'$G(LSFN)
 .Q:$G(^PS(52.5,LSFN,"P"))
 .;
 .; The following function checks for ECME conditions where we do not want a label
 .; This is probably redundant as the RXRS array entry should not have been created if any of these
 .;   conditions existed but things might have changed after the entry was created
 .I $$ECMECHK^PSOREJU3(SZZ) Q
 .;
 .; Add to list of RXs that should get a label
 .I $G(PPL)="" S PPL=SZZ_"," Q
 .I $L(PPL)+$L(SZZ)<220 S PPL=PPL_SZZ_"," Q
 .I $G(PSORX("PSOL",2))']"" S PSORX("PSOL",2)=SZZ_"," Q
 .F SPSOX1=1:0 S SPSOX1=$O(PSORX("PSOL",SPSOX1)) Q:'SPSOX1  S SPSOX2=SPSOX1
 .I $L(PSORX("PSOL",SPSOX2))+$L(SZZ)<220 S PSORX("PSOL",SPSOX2)=PSORX("PSOL",SPSOX2)_SZZ_"," Q
 .S PSORX("PSOL",SPSOX2+1)=SZZ_","
 Q
CKDIV ;
 I '$P($G(PSOSYS),"^",2) W !!?10,"Rx # ",$P(^PSRX(RXREC,0),"^")," is not a valid choice (Different Division)" S PSPOP=1 Q
 I $P($G(PSOSYS),"^",3) W !!?10 K DIR S DIR("A")="Rx # "_$P(^PSRX(RXREC,0),"^")_" is from another division. OK to Pull",DIR(0)="Y",DIR("B")="YES" D ^DIR K DIR I $G(DIRUT)!('Y) S PSPOP=1
 Q
SELONE ;Pull one Rx through Listman
 I $G(PSOBEDT) W $C(7),$C(7) S VALMSG="Invalid Action at this time !",VALMBCK="" Q
 N ORD,MW,PDUZ,PSLST,PSOSQ,PSOSQRTE,PSOSQMTH,PSPOP,PSOX1,PSOX2,PULLONE,RXLTOP,RXREC,SFN,SORD,SORN,VALMCNT
 S PULLONE=1
 I +PSOLST(ORN)'=52 S VALMBCK="" Q
 I +PSOLST(ORN)=52,$P($G(^PSRX($P(PSOLST(ORN),"^",2),"STA")),"^")'=5 S VALMSG="Rx is not on Suspense!",VALMBCK="" Q
 I +PSOLST(ORN)=52,$D(RXRS($P(PSOLST(ORN),"^",2))) S VALMSG="Pull early has already been requested!",VALMBCK="" Q
 N EHOLDQ,ESIEN,ERXIEN S ERXIEN=$P(PSOLST(ORN),"^",2),ESIEN="",ESIEN=$O(^PS(52.5,"B",ERXIEN,ESIEN))
 I $G(ESIEN),$$GET1^DIQ(52.5,ESIEN,10)'="" D EHOLD Q:$G(EHOLDQ)
 K EHOLDQ,ESIEN,ERXIEN
 D SELQ I $G(PULLONE)=2 S VALMSG="Rx# "_$P($G(^PSRX($P(PSOLST(ORN),"^",2),0)),"^")_" not pulled from suspense!" Q
 I +PSOLST(ORN)=52 S RXREC=$P(PSOLST(ORN),"^",2)
 D BEGQ S VALMSG="Rx# "_$P($G(^PSRX(+$G(RXREC),0)),"^")_$S($G(PSOSQ):" pulled",1:" not pulled")_" from Suspense!"
 S VALMBCK="R"
 Q
RESET ;
 N RSDA,RXMW,RXMP,RXSP,RXR,DA,RXPSRX,RXFILL,RXFILLN
 F RSDA=0:0 S RSDA=$O(RXRS(RSDA)) Q:'RSDA  D
 .S RXSP=$O(^PS(52.5,"B",RSDA,0)) Q:'RXSP
 .Q:'$D(^PS(52.5,RXSP,0))
 .S RXMW=$S($P($G(RXRS(RSDA)),"^",2)="":"M",1:$P($G(RXRS(RSDA)),"^",2)),RXMP=$P($G(RXRS(RSDA)),"^",3),RXFILL=$P($G(RXRS(RSDA)),"^",4),RXFILLN=$P($G(RXRS(RSDA)),"^",5),RXPSRX=$S($P($G(RXRS(RSDA)),"^",6)="":"M",1:$P($G(RXRS(RSDA)),"^",6))
 .I RXMW'="" S $P(^PS(52.5,RXSP,0),"^",4)=RXMW D
 ..I RXFILL="P" D  Q
 ...I $D(^PSRX(RSDA,"P",+$G(RXFILLN),0)) S $P(^PSRX(RSDA,"P",+$G(RXFILLN),0),"^",2)=$G(RXPSRX),$P(^PSRX(RSDA,"MP"),"^")=RXMP
 ..I RXFILL="R",$G(RXFILLN) S DA(1)=RSDA,DA=RXFILLN,DIE="^PSRX("_DA(1)_",1,",DR="2////"_RXPSRX D ^DIE K DIE
 ..I RXFILL="O" S DA=RSDA,DIE="^PSRX(",DR="11////"_RXPSRX D ^DIE K DIE
 ..S $P(^PSRX(RSDA,"MP"),"^")=RXMP
 Q
GETMW ;
 N GETPAR,GETRX,GETCNT
 S PSOGETF="O",PSOGETFN=""
 S GETPAR=$P($G(^PS(52.5,SFN,0)),"^",5)
 I GETPAR S PSOGET=$P($G(^PSRX(RXREC,"P",GETPAR,0)),"^",2),PSOGETF="P",PSOGETFN=GETPAR Q
 I '$O(^PSRX(RXREC,1,0)) S PSOGET=$P($G(^PSRX(RXREC,0)),"^",11) Q
 S GETRX=0 F GETCNT=0:0 S GETCNT=$O(^PSRX(RXREC,1,GETCNT)) Q:'GETCNT  S GETRX=GETCNT
 S PSOGET=$P($G(^PSRX(RXREC,1,+$G(GETRX),0)),"^",2),PSOGETF="R",PSOGETFN=+$G(GETRX)
 Q
ULRX ;
 I '$G(RXREC) Q
 D PSOUL^PSSLOCK(RXREC)
 Q
EHOLD ;
 Q:'$G(ERXIEN)
 Q:$$GET1^DIQ(52,ERXIEN,86)=""
 D FULL^VALM1
 W !,"This is an ePharmacy billable fill which is Suspended until "_$$GET1^DIQ(52.5,ESIEN,10)_", based"
 W !,"on the 3/4 Days rule.",!
 K DIR S EHOLDQ=0,DIR(0)="YA",DIR("A")="Do you wish to continue? "
 D ^DIR I $D(DIRUT)!('Y) S EHOLDQ=1 K DIR
 S VALMSG="No action taken.",VALMBCK="R"
 Q
 ;
