IBTRH7 ;ALB/JWS - HCSR Manually Create 278 Request ;15-MAY-2015
 ;;2.0;INTEGRATED BILLING;**517**;21-MAR-94;Build 240
 ;;Per VA Directive 6402, this routine should not be modified.
 ;;
 Q
EN ;EP
 ; Main entry point for IBT HCSR MANUAL 278 ADD protocol
 ; Input: None
 K ^TMP($J,"IBTRH7")
 N PATIEN,HCSR,SDATE1,SDATE2,FRDATE
 D FULL^VALM1
 S VALMBCK="R"
 S PATIEN=$$ASKPAT()
 I PATIEN<0 Q
 S HCSR=$G(^IBE(350.9,1,62))               ; HCSR Site Parameters
 ;
 D DT^DILF("E","T-"_$P(HCSR,"^",3),.SDATE1)
 D DT^DILF("E","T+"_$P(HCSR,"^",13),.SDATE2)
 S FRDATE=$$ASKDATE("Date",SDATE1(0),SDATE2(0)) Q:FRDATE=""
 ;
 ; First find all of the scheduled appointments that match the filter criteria
 N ADATE,AINS,AINSIX,CLINIC,SDCOUNT,SFILT,NODE0
 K ^TMP($J,"SDAMA301")
 D SETFILTS^IBTRHDE(HCSR,.SFILT)           ; Set Appointment filters
 S SFILT(1)=$TR(FRDATE,"^",";")
 S SFILT(4)=PATIEN
 S SDCOUNT=$$SDAPI^SDAMA301(.SFILT)        ; Find the appointments, DBIA4433
 ;Q:SDCOUNT<1                               ; No appointments returned
 ;
 ; Check the active insurance for every found filter against the HCSR Site 
 ; parameter list of insurance companies to exclude
 ; loop through Appointment Date/time
 S ADATE=$P(FRDATE,"^")-1
 F  S ADATE=$O(^TMP($J,"SDAMA301",PATIEN,ADATE)) Q:ADATE=""  Q:$P(ADATE,".")>$P(FRDATE,"^",2)  D
 . D CKAFINS^IBTRHDE(HCSR,PATIEN,$P(ADATE,"."),65,.AINS,1) ; Check for valid Insurance(s)
 . S AINSIX="" F  S AINSIX=$O(AINS(AINSIX)) Q:AINSIX=""  D
 .. S CLINIC=$P($P(^TMP($J,"SDAMA301",PATIEN,ADATE),U,2),";",1)
 .. ; check for clinic inclusion
 .. ;I $O(^IBE(350.9,1,63,"B",CLINIC,""))="" Q
 .. ;I '$$CHKLIST^IBTRHDE(63,$O(^IBE(350.9,1,63,"B",CLINIC,"")),$P(AINS(AINSIX),U)) Q
 .. ; File the event
 .. ; Appointment Date/Time is the 'IEN' of the appointment
 .. S NODE0="Appointment^"_$$NOW^XLFDT()_U_PATIEN_U_AINSIX_"^O^^"_CLINIC_U_ADATE_U_ADATE_"^"_$P(AINS(AINSIX),"^")
 .. ;save off NODE0 by entry in list
 .. D SAVE(NODE0)
 .. Q
 . Q
 ; Finds all admissions that match the filter criteria. Each found
 ; admission is then further filtered using the HCSR Site Parameters. 
 ; Admissions that match the filter criteria are then filed into the HCS 
 ; Review Transmission file (356.22)
 ; Input:   HSCR    - HCSR Site Parameter filters
 ; Output:  Filtered admissions filed into 356.22
 N DA,DATEC,DATEE,DATES,DFN,IBWARD,XX,YY
 K AINS,AINSIX,NODE0
 ;D GETDAYS2^IBTRHDE(HCSR,.DATES,.DATEE)
 ;D DT^DILF("","T-"_(DATES-1),.DATEC)             ; Past Admission Search date
 ;D DT^DILF("","T+"_DATEE,.DATEE)                 ; Future Admission Search date
 ;
 ; First check past/present admissions
 S DATEC=$P(FRDATE,"^")-1
 F  S DATEC=$O(^DGPM("AMV1",DATEC)) Q:(DATEC="")!($P(DATEC,".")>$P(FRDATE,"^",2))  D  ; DBIA419
 . S DA="" F  S DA=$O(^DGPM("AMV1",DATEC,PATIEN,DA)) Q:DA=""  D
 .. S IBWARD=$$GET1^DIQ(405,DA_",",.06,"I")
 .. D CKAFINS^IBTRHDE(HCSR,PATIEN,$P(DATEC,"."),66,.AINS,1)  ; Check for valid Insurance(s)
 .. S AINSIX="" F  S AINSIX=$O(AINS(AINSIX)) Q:AINSIX=""  D
 ... ; check for ward exclusion
 ... ;I '$$CHKLIST^IBTRHDE(64,$O(^IBE(350.9,1,64,"B",IBWARD,"")),$P(AINS(AINSIX),U)) Q
 ... ; File the event
 ... S XX=DATEC
 ... S YY=$$GET1^DIQ(405,DA_",",.17,"I")    ; Is there a Discharge
 ... I YY'="" D                             ; Get External Discharge Date
 .... S YY=$$GET1^DIQ(405,DA_",",.01,"I")   ; Discharge Date/Time
 .... S XX=XX_"-"_YY
 .... Q
 ... S NODE0="Admission^"_$$NOW^XLFDT()_U_PATIEN_U_AINSIX_"^I^"_IBWARD_"^^"_XX_U_$P(DATEC,".",1)_"^"_$P(AINS(AINSIX),"^")
 ... D SAVE(NODE0)
 ... Q
 .. Q
 . Q
 ;
 ; Next check future admissions
 ;D DT^DILF("","T-"_(DATES-1),.DATEC)             ; Past Admission Search date
 S DATEC=$P(FRDATE,"^")-1
 F  S DATEC=$O(^DGS(41.1,"C",DATEC)) Q:(DATEC="")!($P(DATEC,".")>$P(FRDATE,"^",2))  D  ; DBIA429
 . S DA="" F  S DA=$O(^DGS(41.1,"C",DATEC,DA)) Q:DA=""  D
 .. Q:$P($G(^DGS(41.1,DA,0)),U,13)'=""            ; Future Admission was cancelled
 .. S IBWARD=$$GET1^DIQ(41.1,DA_",",8,"I")
 .. S DFN=$$GET1^DIQ(41.1,DA_",",.01,"I")         ; Patient DFN
 .. I DFN'=PATIEN Q  ;filter based on what patient user selected
 .. D CKAFINS^IBTRHDE(HCSR,DFN,$P(DATEC,"."),66,.AINS,1)    ; Check for valid Insurance(s)
 .. S AINSIX="" F  S AINSIX=$O(AINS(AINSIX)) Q:AINSIX=""  D
 ... ; check for ward exclusion
 ... ;I '$$CHKLIST^IBTRHDE(64,$O(^IBE(350.9,1,64,"B",IBWARD)),$P(AINS(AINSIX),U)) Q
 ... ; File the event
 ... S NODE0="Admission^"_$$NOW^XLFDT()_U_DFN_U_AINSIX_"^I^"_IBWARD_"^^"_DATEC_U_$P(DATEC,".",1)_"^"_$P(AINS(AINSIX),"^")
 ... D SAVE(NODE0)
 ... Q
 .. Q
 . Q
 I '$O(^TMP($J,"IBTRH7","")) W !,"No open appointments or admissions found for that patient",! D PAUSE^VALM1 Q
 ;
 ; display list of options and then add entry to 356.22
 N CNT,DIR,DIROUT,DIRUT,DTOUT,DUOUT,TMP,X
 S CNT=+$G(^TMP($J,"IBTRH7"))
 S X="" F  S X=$O(^TMP($J,"IBTRH7",X)) Q:X=""  D
 . N X1,X2
 . S X1=^TMP($J,"IBTRH7",X)
 . S Y=$P(X1,"^",8) X ^DD("DD")
 . S X2=$E(X_"    ",1,4)_$E($P(X1,"^"),1,3)_"  "_Y_"    "
 . I $P(X1,"^",7) S X2=X2_$$GET1^DIQ(44,$P(X1,"^",7),.01)
 . I $P(X1,"^",6) S X2=X2_$$GET1^DIQ(42,$P(X1,"^",6),.01)
 . S X2=X2_$J(" ",40-$L(X2))
 . S X2=X2_" "_$E($$GET1^DIQ(2.312,$P(X1,"^",4)_","_$P(X1,"^",3)_",",.2),1,3)_": "_$E($$GET1^DIQ(36,$P(X1,"^",10)_",",.01),1,26)
 . ;S LINE=$G(LINE)+1
 . S TMP("DIMSG",X)=X2
 D MSG^DIALOG("WM",,,,"TMP")
 S DIR(0)="NA^1:"_CNT_":0"
 S DIR("A")="Select a scheduled Admission or Appointment for the selected Patient: "
 S DIR("?",1)="Choose an admission or appointment."
 S DIR("?")="Valid responses are 1 thru "_CNT_" or ^ to exit."
 D ^DIR
 I ($G(DTOUT))!($G(DUOUT))!($G(DIRUT))!($G(DIROUT)) Q
 I +$G(Y)<1 Q
 ; add entry to 356.22 file
 S NODE0=$P(^TMP($J,"IBTRH7",Y),"^",2,9)
 D SETEVENT^IBTRHDE(NODE0)
 ;D SORT^IBTRH1(1)
 D INIT^IBTRH1
 D HDR^IBTRH1
 Q
 ;
ASKPAT()    ; Get the Patient Name
 ; Init vars
 N DIC,DTOUT,DUOUT,X,Y
 ; Patient lookup
 W !
 S DIC(0)="AEQM"  ;,DIC("S")="I $D(^IBT(356.22,""D"",Y))"
 S DIC("A")=$$FO^IBCNEUT1("Select PATIENT NAME: ",21,"R")
 S DIC="^DPT("
 D ^DIC
 Q +Y
 ;
ASKDATE(PROMPT,DEFAULT1,DEFAULT2) ; get the from and thru dates
 N %DT,X,Y,DT1,DT2,IB1,IB2
 S DT1="",IB1="Start Date: ",IB2="End Date: "
 I $G(PROMPT)'="" S IB1="Start with "_PROMPT_": ",IB2="Go to "_PROMPT_": "
FM1 ;
 S %DT="AEX",%DT("A")=IB1,%DT("B")=DEFAULT1
 D ^%DT K %DT I Y<0!($P(Y,".",1)'?7N) G FM1E:(Y<0&(X="")),FMDQ
 S (%DT(0),DT2)=$P(Y,".",1) I DT2'>SDATE2 S %DT("B")=DEFAULT2
FM2 ;
 S %DT="AEX",%DT("A")=IB2 D ^%DT K %DT I Y<0!($P(Y,".",1)'?7N) G FM2E:(Y<0&(X="")),FMDQ
 S DT1=DT2_"^"_$P(Y,".",1)
FMDQ ;
 Q DT1
FM1E ;
 W !,"A date must be entered." G FM1
FM2E ;
 W !,"A date must be entered." G FM2
 Q
 Q X
 ;
SAVE(NODE0) ; save entry in temporary ^TMP($J) global for list display
 N VAL,ERR,XCT
 S VAL(1)=$P(NODE0,"^",3)
 S VAL(2)=$P(NODE0,"^",5)
 S VAL(3)=$P(NODE0,"^",4)
 S VAL(4)=$P(NODE0,"^",9)
 I $$FIND1^DIC(356.22,,"Q",.VAL,"E","","ERR") Q
 I $D(ERR) Q
 S XCT=$G(^TMP($J,"IBTRH7")),XCT=XCT+1,^TMP($J,"IBTRH7")=XCT,^("IBTRH7",XCT)=NODE0
 Q
 ;
FILE ; save selected entry into 356.22 file
 D SETEVENT^IBTRHDE(NODE0)
 Q 
