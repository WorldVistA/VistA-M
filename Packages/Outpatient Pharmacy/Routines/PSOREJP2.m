PSOREJP2 ;BIRM/MFR - Third Party Rejects View/Process ;04/28/05
 ;;7.0;OUTPATIENT PHARMACY;**148,247,260,287,289,358,385,403,421,427**;DEC 1997;Build 21
 ;Reference to ^PSSLOCK supported by IA #2789
 ;Reference to GETDAT^BPSBUTL supported by IA #4719
 ;Reference to ^PS(55 supported by IA #2228
 ;Reference to ^DIC(36 supported by ICR #6142
 ;
 N PSORJSRT,PSOPTFLT,PSODRFLT,PSORXFLT,PSOBYFLD,PSOSTFLT,DIR,DIRUT,DUOUT,DTOUT
 N PSOINFLT,PSODTRNG,PSOINGRP,PSOTRITG,PSOCVATG
 S PSORJASC=1,PSOINGRP=0,PSOTRITG=1,PSOCVATG=1
 ;
 ; - Division/Site selection
 D SEL^PSOREJU1("DIVISION","^PS(59,",.PSOREJST,$$GET1^DIQ(59,+$G(PSOSITE),.01)) I $G(PSOREJST)="^" G EXIT
 ;
 ; - Date range selection
 W ! S PSODTRNG=$$DTRNG("T-90","T") I PSODTRNG="^" G EXIT
 ;
SEL ; - Field Selection (Patient/Drug/Rx)
 S DIR(0)="S^P:PATIENT;D:DRUG;R:Rx;I:INSURANCE",DIR("B")="P"
 S DIR("A")="By (P)atient, (D)rug, (R)x or (I)nsurance" D ^DIR I $D(DIRUT) G EXIT
 S PSOBYFLD=Y,DIR("B")=""
 ;
 I PSOBYFLD="P" D  I $G(PSOPTFLT)="^" G SEL
 . S (PSODRFLT,PSORXFLT,PSOINFLT)="ALL",PSORJSRT="DR"
 . D SEL^PSOREJU1("PATIENT","^DPT(",.PSOPTFLT)
 ;
 I PSOBYFLD="D" D  I $G(PSODRFLT)="^" G SEL
 . S (PSOPTFLT,PSORXFLT,PSOINFLT)="ALL",PSORJSRT="PA"
 . D SEL^PSOREJU1("DRUG","^PSDRUG(",.PSODRFLT)
 ;
 I PSOBYFLD="R" D  I $D(DUOUT)!$D(DTOUT)!'$G(PSORXFLT) G SEL
 . S (PSOPTFLT,PSODRFLT,PSOINFLT)="ALL",PSORJSRT="PA"
 . N DIC,Y,X,OK K PSOSTFLT,PSORXFLT
 . S DIC=52,DIC(0)="QEZA",DIC("A")="PRESCRIPTION: "
 . F  W ! D ^DIC D  Q:$G(OK) 
 . . I $D(DUOUT)!$D(DTOUT)!(X="") S OK=1 Q
 . . I '$O(^PSRX(+Y,"REJ",0)) D  Q
 . . . W !?40,"Prescription does not have rejects!",$C(7)
 . . S PSORXFLT=+Y,OK=1
 ;
 ; Insurance Company Lookup - ICR 6142
 I PSOBYFLD="I" D  I $G(PSOINFLT)="^" G SEL
 . S (PSOPTFLT,PSODRFLT,PSORXFLT)="ALL",PSORJSRT="PA"
 . D SEL^PSOREJU1("INSURANCE","^DIC(36,",.PSOINFLT)
 ;
 ; - Status Selection (UNRESOLVED or RESOLVED)
 I $G(PSOSTFLT)="" D  I $D(DIRUT) G EXIT
 . S DIR(0)="S^U:UNRESOLVED;R:RESOLVED;B:BOTH",DIR("B")="B"
 . S DIR("A")="(U)NRESOLVED, (R)RESOLVED or (B)OTH REJECT statuses" D ^DIR
 . S PSOSTFLT=Y
 ;
 D LST^PSOREJP0("VP")
 ;
EXIT Q
 ;
CLO ; - Ignore a REJECT hidden action
 N PSOTRIC,X,PSOET
 ;
 I '$D(FILL) S FILL=$$LSTRFL^PSOBPSU1(RX)
 S PSOTRIC="",PSOTRIC=$$TRIC^PSOREJP1(RX,FILL,PSOTRIC)
 ;
 ;reference to ^XUSEC( supported by IA 10076
 ;bld, PSO*7*358
 I PSOTRIC,'$D(^XUSEC("PSO TRICARE/CHAMPVA",DUZ)) S VALMSG="Action Requires <PSO TRICARE/CHAMPVA> security key",VALMBCK="R" Q
 ;if TRICARE or CHAMPVA and user has security key, prompt to continue or not
 ;
 ;
 I PSOTRIC,'$$CONT^PSOREJU1() S VALMBCK="R" Q
 ;
 I $$CLOSED^PSOREJP1(RX,REJ) D  Q
 . S VALMSG="This Reject is marked resolved!",VALMBCK="R"
 N DIR,COM
 D FULL^VALM1
 I '$$SIG^PSOREJU1() S VALMBCK="R" Q
 W !
 S:PSOTRIC COM=$$TCOM^PSOREJP3(RX,FILL) S:'PSOTRIC COM=$$COM^PSOREJU1()
 I COM="^" S VALMBCK="R" Q
 W !
 S DIR(0)="Y",DIR("A")="     Confirm? ",DIR("B")="NO"
 S DIR("A",1)="     When you confirm this REJECT will be marked RESOLVED."
 S DIR("A",2)=" "
 D ^DIR I $G(Y)=0!$D(DIRUT) S VALMBCK="R" Q
 W ?40,"[Closing..." D CLOSE^PSOREJUT(RX,FILL,REJ,DUZ,6,COM,"","","","","",1) W "OK]",!,$C(7) H 1
 I $D(PSOSTFLT),PSOSTFLT'="B" S CHANGE=1
 ;
 I $$PTLBL(RX,FILL) D PRINT^PSOREJP3(RX,FILL)
 I PSOTRIC D
 .S PSOET=$$PSOET^PSOREJP3(RX,FILL)
 .D AUDIT^PSOTRI(RX,FILL,,COM,$S(PSOET:"N",1:"R"),$S(PSOTRIC=1:"T",PSOTRIC=2:"C",1:""))
 ;
 Q
 ;
OPN ; - Re-open a Closed/Resolved Reject
 I '$$CLOSED^PSOREJP1(RX,REJ) D  Q
 . S VALMSG="This Reject is NOT marked resolved!",VALMBCK="R"
 ;cnf, PSO*7*358, check for discontinued and not released
 ;  12 - DISCONTINUED
 ;  14 - DISCONTINUED BY PROVIDER
 ;  15 - DISCONTINUED (EDIT)
 N DCSTAT,PSOREL
 S DCSTAT=$$GET1^DIQ(52,RX,100,"I")
 S PSOREL=0 D
 . I 'FILL S PSOREL=+$$GET1^DIQ(52,RX,31,"I")
 . I FILL S PSOREL=+$$GET1^DIQ(52.1,FILL_","_RX,17,"I")
 I 'PSOREL,"/12/14/15/"[("/"_DCSTAT_"/") S VALMSG="Discontinued Rx has not been released.",VALMBCK="R" Q
 N DIR,COM,REJDATA,NEWDATA,X,REOPEN
 D FULL^VALM1
 I '$$SIG^PSOREJU1() S VALMBCK="R" Q
 W !
 S DIR(0)="Y",DIR("A")="     Confirm",DIR("B")="NO"
 S DIR("A",1)="     When you confirm this REJECT will be marked UNRESOLVED."
 S DIR("A",2)=" "
 D ^DIR I $G(Y)=0!$D(DIRUT) S VALMBCK="R" Q
 ;
 W ?40,"[Re-opening..."
 K REJDATA D GET^PSOREJU2(RX,FILL,.REJDATA,REJ,1) D SETOPN^PSOREJU2(RX,REJ)
 K NEWDATA M NEWDATA=REJDATA(REJ) S NEWDATA("PHARMACIST")=DUZ
 S REOPEN=1 D SAVE^PSOREJUT(RX,FILL,.NEWDATA,REOPEN)
 I $G(NEWDATA("REJECT IEN")),$D(REJDATA(REJ,"COMMENTS")) D
 . S COM=0 F  S COM=$O(REJDATA(REJ,"COMMENTS",COM)) Q:'COM  D
 . . S X(1)=REJDATA(REJ,"COMMENTS",COM,"COMMENTS")
 . . S X(2)=REJDATA(REJ,"COMMENTS",COM,"DATE/TIME")
 . . S X(3)=REJDATA(REJ,"COMMENTS",COM,"USER")
 . . D SAVECOM^PSOREJP3(RX,NEWDATA("REJECT IEN"),X(1),X(2),X(3))
 D RETRXF^PSOREJU2(RX,FILL,0)
 W "OK]",!,$C(7) H 1
 S CHANGE=1
 Q
 ;
SDC ; - Suspense Date Calculation
 D CHG(1)
 Q
 ;
CSD ;CSD - Change Suspense Date action entry point
 D CHG(0)
 Q
 ;
CHG(SDC) ; - Change Suspense Date action
 ;Local:
 ;  SDC - indicates if the suspense date is being manually changed or calculated. 
 ;  RX  - RX IEN
 ;  REJ - Reject indicator
 ;
 I '$G(SDC) S SDC=0
 I $$CLOSED^PSOREJP1(RX,REJ) D  Q
 . S VALMSG="This Reject is marked resolved!",VALMBCK="R" W $C(7)
 ;
 N SUSDT,PSOMSG,Y,SUSRX,%DT,DA,DIE,DR,ISSDT,EXPDT,PSOMSG,CUTDT,FILDT,RFL,COB
 ;
 S RFL=+$$GET1^DIQ(52.25,REJ_","_RX,5),SUSDT=$$RXSUDT^PSOBPSUT(RX,RFL)
 I RFL>0 S FILDT=$$GET1^DIQ(52.1,RFL_","_RX,.01,"I")
 E  S FILDT=$$GET1^DIQ(52,RX,22,"I")
 I SUSDT="" S VALMSG="Prescription is not suspended!",VALMBCK="R" W $C(7) Q
 I $$RXRLDT^PSOBPSUT(RX,RFL) S VALMSG="Prescription has been released already!",VALMBCK="R" W $C(7) Q
 ;cnf, PSO*7*358, add PSOET logic for TRICARE/CHAMPVA non-billable
 S PSOET=$$PSOET^PSOREJP3(RX,RFL)
 I PSOET S VALMSG=$S(SDC=1:"SDC",1:"CSD")_" not allowed for "_$$ELIGDISP^PSOREJP1(RX,RFL)_" Non-Billable claim.",VALMBCK="R" Q
 ;
 D PSOL^PSSLOCK(RX) I '$G(PSOMSG) S VALMSG=$P(PSOMSG,"^",2),VALMBCK="R" W $C(7) Q
 ;
 S ISSDT=$$GET1^DIQ(52,RX,1,"I"),EXPDT=$$GET1^DIQ(52,RX,26,"I")
 S SUSRX=$O(^PS(52.5,"B",RX,0))
 ;
 D FULL^VALM1
 I SDC D  I SUSDT=0 D PSOUL^PSSLOCK(RX) S VALMBCK="R" Q
 . S COB=$$GET1^DIQ(52.25,REJ_","_RX,27,"I")
 . I 'COB S COB=1
 . S SUSDT=$$CALCSD(RX,RFL,COB)
 ;
SUDT ; Asks for the new Suspense Date
 N X1,X2
 S X1=FILDT,X2=89 D C^%DTC S CUTDT=X
 S %DT("B")=$$FMTE^XLFDT(SUSDT),%DT="EA",%DT("A")=$S(SDC:"NEW ",1:"")_"SUSPENSE DATE: "
 W ! D ^%DT I Y<0!($D(DTOUT)) D PSOUL^PSSLOCK(RX) S VALMBCK="R" I (SDC) W !,"ACTION NOT TAKEN!" Q
 I Y<ISSDT D  G SUDT
 . W !!?5,"Suspense Date cannot be before Issue Date: ",$$FMTE^XLFDT(ISSDT),".",$C(7)
 I Y>EXPDT D  G SUDT
 . W !!?5,"Suspense Date cannot be after Expiration Date: ",$$FMTE^XLFDT(EXPDT),".",$C(7)
 I Y>CUTDT D  G SUDT
 . W !!?5,"Suspense Date cannot be after fill date plus 90 days: "_$$FMTE^XLFDT(CUTDT),".",$C(7)
 S SUSDT=Y
 ;
 N DIR,DIRUT W !
 S DIR("A",1)="     When you confirm, this REJECT will be marked resolved. A"
 S DIR("A",2)="     new claim will be re-submitted to the 3rd party payer"
 I $$GET1^DIQ(52.5,SUSRX,3)="" D
 . I SUSDT>DT D
 . . S DIR("A",3)="     when the prescription label for this fill is printed"
 . . S DIR("A",4)="     from suspense on "_$$FMTE^XLFDT(SUSDT)_"."
 . . S DIR("A",5)=" "
 . . S DIR("A",6)="     Note: THE LABEL FOR THIS PRESCRIPTION FILL WILL NOT BE"
 . . S DIR("A",7)="           PRINTED LOCAL FROM SUSPENSE BEFORE "_$$FMTE^XLFDT(SUSDT)_"."
 . E  D
 . . S DIR("A",3)="     the next time local labels are printed from suspense."
 E  D
 . I SUSDT>DT D
 . . S DIR("A",3)="     when the prescription is transmitted to CMOP on "
 . . S DIR("A",4)="     "_$$FMTE^XLFDT(SUSDT)_"."
 . . S DIR("A",5)=" "
 . . S DIR("A",6)="     Note: THIS PRESCRIPTION FILL WILL NOT BE TRANSMITTED TO"
 . . S DIR("A",7)="           CMOP BEFORE "_$$FMTE^XLFDT(SUSDT)_"."
 . E  D
 . . S DIR("A",3)="     when this prescription fill is transmitted to CMOP on"
 . . S DIR("A",4)="     the next CMOP transmission."
    ;
 S DIR("A",$O(DIR("A",""),-1)+1)=" "
 S DIR(0)="Y",DIR("A")="     Confirm? ",DIR("B")="YES"
 D ^DIR I $G(Y)=0!$D(DIRUT) S VALMBCK="R" D PSOUL^PSSLOCK(RX) Q
 ;
 ; - Suspense/Fill Date updates
 I SUSDT'=$$RXSUDT^PSOBPSUT(RX,RFL) D
 . N DA,DIE,DR,PSOX,SFN,INDT,DEAD
 . S DA=SUSRX,DIE="^PS(52.5,",DR=".02///"_SUSDT D ^DIE
 . S SFN=SUSRX,DEAD=0,INDT=SUSDT D CHANGE^PSOSUCH1(RX,RFL)
 ;
 ; - Flagging the prescription to be re-submitted to ECME on the next CMOP/Print from Suspense
 D RETRXF^PSOREJU2(RX,RFL,1)
 W ?40,"[Closing..."
 D CLOSE^PSOREJUT(RX,RFL,REJ,DUZ,8,"Fill Date changed to "_$$FMTE^XLFDT(SUSDT)_". A new claim will be re-submitted on this date.")
 W "OK]",!,$C(7) H 1 I $D(PSOSTFLT),PSOSTFLT'="B" S CHANGE=1
 D PSOUL^PSSLOCK(RX)
 Q
 ;
PTLBL(RX,RFL) ; Returns whether the user should be prompted for 'Print Label?' or not
 N PTLBL,CMP,LBL,REPRINT
 N PSOTRIC S PSOTRIC="",PSOTRIC=$$TRIC^PSOREJP1(RX,RFL,.PSOTRIC)
 I $$FIND^PSOREJUT(RX,RFL) Q 0       ; Has OPEN/UNRESOLVED 3rd pary payer reject
 I $$GET1^DIQ(52,RX,100,"I") Q 0     ; Rx status not ACTIVE
 I $$RXRLDT^PSOBPSUT(RX,RFL),'PSOTRIC Q 0     ; Rx Released
 ; - CMOP Rx fill?
 S PTLBL=1,CMP=0
 F  S CMP=$O(^PSRX(RX,4,CMP)) Q:'CMP  D  Q:'PTLBL
 . I +$$GET1^DIQ(52.01,CMP_","_RX,2,"I")=RFL S PTLBL=0
 I 'PTLBL Q 0
 ; - Label already printed for Rx fill?
 S LBL=0
 F  S LBL=$O(^PSRX(RX,"L",LBL)) Q:'LBL  D  Q:'PTLBL
 . I +$$GET1^DIQ(52.032,LBL_","_RX,1,"I")'=RFL Q
 . I $G(PSOTRIC)&($$RXRLDT^PSOBPSUT(RX,RFL)) S REPRINT=1 Q
 . I $$GET1^DIQ(52.032,LBL_","_RX,4,"I") Q
 . I $$GET1^DIQ(52.032,LBL_","_RX,2)["INTERACTION" Q
 . S PTLBL=0
 ;
 I PTLBL D
 . N DIR,DIRUT,Y
 . W ! S DIR(0)="Y",DIR("A")=$S('$G(REPRINT):"Print Label",1:"Reprint Label"),DIR("B")="YES"
 . D ^DIR I $G(Y)=0!$D(DIRUT) S PTLBL=0 Q
 ;
 Q PTLBL
 ;
DTRNG(BGN,END) ; Date Range Selection
 ;Input: (o) BGN - Default Begin Date 
 ;       (o) END - Default End Date 
 ;
 N %DT,DTOUT,DUOUT,DTRNG,X,Y
 S DTRNG=""
 S %DT="AEST",%DT("A")="BEGIN REJECT DATE: ",%DT("B")=$G(BGN) K:$G(BGN)="" %DT("B") D ^%DT
 I $G(DUOUT)!$G(DTOUT)!($G(Y)=-1) Q "^"
 S $P(DTRNG,U)=Y
 ;
 W ! K %DT
 S %DT="AEST",%DT("A")="END REJECT DATE: ",%DT("B")=$G(END),%DT(0)=Y K:$G(END)="" %DT("B") D ^%DT
 I $G(DUOUT)!$G(DTOUT)!($G(Y)=-1) Q "^"
 ;
 ;Define Entry
 S $P(DTRNG,U,2)=Y
 ;
 Q DTRNG
 ;
CALCSD(RX,FIL,COB) ;
 ; CALCSD - Prompt the user for Last Date of Service, Last Days Supply and
 ;   then calculate the suspense date based on these input.
 ; Input
 ;   RX - Prescription IEN
 ;   FIL - Fill Number
 ;   COB - Coordination of Benefits
 ; Return
 ;   The calculated suspense date  
 ;
 N DIR,X,Y,DUOUT,DTOUT,DIRUT,DIROUT,LDOS,LDSUP,LDS
 I '$G(RX) Q 0
 I $G(FIL)="" Q 0
 I '$G(COB) S COB=1
 ;
 D PREVRX(RX,FIL,COB,.LDOS,.LDS,1)   ; get the previous Rx last date of service and last days supply
 ; Added a parameter at end (1) to identfy that this is not a suspense related call
 ; Prompt for Last DOS
 S DIR(0)="D",DIR("A")="LAST DATE OF SERVICE"
 I LDOS S DIR("B")=$$FMTE^XLFDT($G(LDOS))
 D ^DIR
 I $D(DIRUT) W !,"ACTION NOT TAKEN!" Q 0
 S LDOS=Y W "  ("_$$FMTE^XLFDT($G(LDOS))_")"
 ;
 ; Prompt for Last Days Supply
 S LDSUP=LDS
 K DIR
 S DIR(0)="N",DIR("A")="LAST DAYS SUPPLY"
 I LDSUP]"" S DIR("B")=+LDSUP
 D ^DIR
 I $D(DIRUT) W !,"ACTION NOT TAKEN!" Q 0
 ;
 ; Calculate the suspense date to be Last DOS plus 3/4 of the Last Days Supply
 ; Fractions are rounded up
 S LDSUP=Y*.75
 S:LDSUP["." LDSUP=(LDSUP+1)\1
 Q $$FMADD^XLFDT(LDOS,LDSUP)
 ;
PREVRX(RX,RFL,COB,LDOS,LDAYS,NONSUS) ; Gather last date of service and last days supply from previous rx
 ;    input:  RX  - Current RX
 ;            RFL - Refill
 ;            COB - Coordination of benefits
 ;            NONSUS - Not suspense processing
 ;   output:  LDOS - (pass by reference). Last date of service in fileman format, or ""
 ;            LDAYS - (pass by reference). Last days supply in numeric format, or ""
 ;
 S (LDOS,LDAYS)=""
 I '$G(RX) G PREVRXQ
 I $G(RFL)="" G PREVRXQ
 I '$G(COB) S COB=1
 S NONSUS=+$G(NONSUS) ; Non-suspense processing flag
 ;
 I RFL=0 D
 . N X,Y
 . I NONSUS D
 . . S X=$$LAST120(RX,COB)   ; other Rx 120 day time window
 . . S LDOS=$P(X,U,1)        ; last date of service (older rx)
 . . S LDAYS=$P(X,U,2)       ; last days supply (older rx)
 . . Q
 . S Y=$$LASTRN(RX,COB)    ; check for a renewed prescription
 . I $P(Y,U,1)'>LDOS Q     ; if DOS from old Rx is earlier than LDOS, then quit
 . S LDOS=$P(Y,U,1)        ; last date of service (renewal)
 . S LDAYS=$P(Y,U,2)       ; last day supply (renewal)
 . Q
 ;
 ; refill - same RX. Get previous fill information
 I RFL>0 D
 . N FL
 . F FL=(RFL-1):-1:0 D  Q:LDOS           ; start with the previous fill (RFL-1)
 .. I $$STATUS^PSOBPSUT(RX,FL)="" Q      ; no ECME activity - skip
 .. I $$FIND^PSOREJUT(RX,FL,,,1) Q       ; unresolved reject on worklist - skip
 .. D GETDAT^BPSBUTL(RX,FL,COB,.LDOS,.LDAYS)    ; DBIA 4719
 .. Q
 . Q
 ;
PREVRXQ ;
 Q
 ;
LAST120(RX,COB) ;new tag PSO*7*421, cnf
 ; For the original fill, get the default DOS/Days Supply by getting most recent DOS from
 ;   the other RXs within a time window for the same patient and drug and dosage
 ;   Time window - Prescription has an expiration date that is in the future or within the last 120 days
 ; Reference to ^PS(55 supported by IA #2228
 ; Input
 ;   RX - Prescription IEN
 ;  COB - coordination of benefits indicator (defaults to 1 if not passed)
 ; Output
 ;   Last Date of Service ^ Last Days Supply
 ;
 N LDOS,LDS,PAT,DRUG,EXPDT,RX1,DRUG1,FL,X1,X2,RX0,QTY,DSUP,DOSAGE,QTY1,DSUP1,DOSAGE1
 I '$G(COB) S COB=1
 S LDOS="",LDS=""
 S RX0=$G(^PSRX(RX,0))  ; main 0 node
 S PAT=$P(RX0,U,2),DRUG=$P(RX0,U,6),QTY=+$P(RX0,U,7),DSUP=+$P(RX0,U,8),DOSAGE=""
 I 'PAT!'DRUG Q LDOS_U_LDS
 I QTY,DSUP S DOSAGE=QTY/DSUP    ; ratio of Qty to Days supply
 S EXPDT=$$FMADD^XLFDT(DT,-121)
 F  S EXPDT=$O(^PS(55,PAT,"P","A",EXPDT)) Q:'EXPDT  D
 . S RX1="" F  S RX1=$O(^PS(55,PAT,"P","A",EXPDT,RX1)) Q:'RX1  I RX'=RX1 D
 .. S DRUG1=$P($G(^PSRX(+RX1,0)),U,6)
 .. I DRUG'=DRUG1 Q     ; not the same drug
 .. S FL=$$LSTRFL^PSOBPSU1(RX1),X1="",X2=""
 .. S QTY1=$S(FL=0:+$P($G(^PSRX(RX1,0)),U,7),1:+$P($G(^PSRX(RX1,1,FL,0)),U,4))    ; Quantity of other Rx
 .. S DSUP1=$S(FL=0:+$P($G(^PSRX(RX1,0)),U,8),1:+$P($G(^PSRX(RX1,1,FL,0)),U,10))  ; Days supply of other Rx
 .. S DOSAGE1=""
 .. I QTY1,DSUP1 S DOSAGE1=QTY1/DSUP1     ; ratio of Qty to Days Supply for other Rx
 .. I DOSAGE'=DOSAGE1 Q                   ; dosage must be a match also
 .. ;
 .. I $$STATUS^PSOBPSUT(RX1,FL)="" Q      ; no ECME activity - skip
 .. I $$FIND^PSOREJUT(RX1,FL,,,1) Q       ; unresolved reject on worklist - skip
 .. D GETDAT^BPSBUTL(RX1,FL,COB,.X1,.X2)  ;IA #4719
 .. I X1>LDOS S LDOS=X1,LDS=X2
 Q LDOS_U_LDS
 ;
LASTRN(RX,COB) ;new tag PSO*7*421, cnf
 ; For a renew, get the default DOS and Days Supply from the earlier fill number of the previous prescription
 N RX1,FL,LDOS,LDS,LSTFIL
 I '$G(COB) S COB=1
 S LDOS="",LDS=""
 S RX1=$$GET1^DIQ(52,RX,39.4,"I")      ; 39.4 - previous order, rxien renewed from
 I 'RX1 G LASTRNX                      ; not a renewed prescription
 S LSTFIL=$$LSTRFL^PSOBPSU1(RX1)       ; start with last fill#
 F FL=LSTFIL:-1:0 D  Q:LDOS            ; loop backwards until we find the last date of service
 . I $$STATUS^PSOBPSUT(RX1,FL)="" Q    ; no ECME activity - skip
 . I $$FIND^PSOREJUT(RX1,FL,,,1) Q     ; unresolved reject on worklist - skip
 . D GETDAT^BPSBUTL(RX1,FL,COB,.LDOS,.LDS)   ; IA #4719
 . Q
 ;
LASTRNX ;
 Q LDOS_U_LDS
 ;
