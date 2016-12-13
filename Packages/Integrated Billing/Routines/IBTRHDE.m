IBTRHDE ;ALB/FA - HCSR Patient Events Search ;06-JUN-2014
 ;;2.0;INTEGRATED BILLING;**517**;21-MAR-94;Build 240
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
EN(NOMSG) ;EP
 ; Called from menu option: IBT HCSR NIGHTLY PROCESS designed to be scheduled
 ; in TaskMan to be executed once a day during off-peak hours
 ; Use HCSR Site Parameters to set appointment search criteria and filter
 ; appointments.  File any appointments that match the criteria into 356.22,
 ; the HCS Review Transmission file
 ; Input:   NOMSG       - 1 to not display locked message. Only set to 1 when
 ;                          called from REFRESH^IBTRH1A to refresh the worklist
 ;                          screen.
 ;                          Optional, defaults to 0
 N $ES,$ET,HCSR
 S:'$D(NOMSG) NOMSG=0
 S $ET="D ER^IBTRHDE"
 ;
 ; Check lock
 L +^TMP("IBTRHDE"):1
 I '$T D  Q
 . I '$D(ZTSK),'NOMSG D
 . . W !!,"The IBT HCSR Nightly Process is already running, please retry later."
 . . D PAUSE^VALM1
 . D ENX
 ;
 ; Check to see if background process has been stopped, if so quit.
 I $G(ZTSTOP) D ENX Q
 S HCSR=$G(^IBE(350.9,1,62))                    ; HCSR Site Parameters
 ; First find all of the scheduled appointments that match the filter criteria
 ;;D FAPPTS(HCSR) ;3/21/16 JWS commented out background job creation of worklist entries
 ;
 ; Check to see if background process has been stopped, if so quit.
 I $G(ZTSTOP) D ENX Q
 ;
 ; Next find all of the admissions that match the filter criteria
 ;;D FADMS(HCSR)  ;3/21/16 JWS commented out background job creation of worklist entries
 ;
 ; Check to see if background process has been stopped, if so quit.
 I $G(ZTSTOP) D ENX Q
 ; JWS 10/13/14 add 278x215 auto create
 ; perform auto 278x215 Inquiry generation
 ;;I $P(HCSR,"^",10)!($P(HCSR,"^",11)) D TRIG278^IBTRHDE1  ;3/21/16 JWS commented out auto-generated 278x215s
 ; Check to see if background process has been stopped, if so quit.
 I $G(ZTSTOP) D ENX Q
 ;
 ; Finally automatically purge events
 D PURGE(HCSR)
 D ENX
 Q
 ;
ENX ; Purge task record - if queued
 I $D(ZTQUEUED) S ZTREQ="@"
 L -^TMP("IBTRHDE")
 Q
 ;
FAPPTS(HCSR)    ; Finds all appointments that match the filter criteria. Each
 ; found appointment is then further filtered using the HCSR Site Parameters.
 ; Appointments that match the filter criteria are then filed into the HCS 
 ; Review Transmission file (356.22)
 ; Input:   HSCR    - HCSR Site Parameter filters
 ; Output:  Filtered appointments filed into 356.22
 N ADATE,AINS,AINSIX,CLINIC,DFN,INSIEN,SDATE,SDCOUNT,SFILT,XX,NODE0
 K ^TMP($J,"SDAMA301")
 D SETFILTS(HCSR,.SFILT)                        ; Set Appointment filters
 S SDCOUNT=$$SDAPI^SDAMA301(.SFILT)             ; Find the appointments, DBIA4433
 Q:SDCOUNT<1                                    ; No appointments returned
 ;
 ; Check the active insurance for every found filter against the HCSR Site 
 ; parameter list of insurance companies to exclude
 S DFN="" F  S DFN=$O(^TMP($J,"SDAMA301",DFN)) Q:DFN=""  D
 .; loop through Appointment Date/time
 .S ADATE="" F  S ADATE=$O(^TMP($J,"SDAMA301",DFN,ADATE)) Q:ADATE=""  D
 ..D CKAFINS(HCSR,DFN,ADATE,65,.AINS)         ; Check for valid Insurance(s)
 ..S AINSIX="" F  S AINSIX=$O(AINS(AINSIX)) Q:AINSIX=""  D
 ...S CLINIC=$P($P(^TMP($J,"SDAMA301",DFN,ADATE),U,2),";",1)
 ...; check for clinic inclusion
 ...; 8/20/15 jws - if clinic is not defined
 ...I '$O(^IBE(350.9,1,63,"B",CLINIC,"")) Q
 ...I '$$CHKLIST(63,$O(^IBE(350.9,1,63,"B",CLINIC,"")),$P(AINS(AINSIX),U)) Q
 ...; File the event
 ...; Appointment Date/Time is the 'IEN' of the appointment
 ...S NODE0=$$NOW^XLFDT()_U_DFN_U_AINSIX_"^O^^"_CLINIC_U_ADATE_U_ADATE
 ...D SETEVENT(NODE0)
 ...Q
 ..Q
 .Q
 K ^TMP($J,"SDAMA301")
 Q
 ;
FADMS(HCSR)    ; Finds all admissions that match the filter criteria. Each found
 ; admission is then further filtered using the HCSR Site Parameters. 
 ; Admissions that match the filter criteria are then filed into the HCS 
 ; Review Transmission file (356.22)
 ; Input:   HSCR    - HCSR Site Parameter filters
 ; Output:  Filtered admissions filed into 356.22
 N AINS,AINSIX,DA,DATEC,DATEE,DATES,DFN,IBWARD,NODE0,XX,YY
 D GETDAYS2(HCSR,.DATES,.DATEE)
 D DT^DILF("","T-"_(DATES-1),.DATEC)             ; Past Admission Search date
 D DT^DILF("","T+"_DATEE,.DATEE)                 ; Future Admission Search date
 ;
 ; First check past/present admissions
 F  S DATEC=$O(^DGPM("AMV1",DATEC)) Q:(DATEC="")!($P(DATEC,".")>DATEE)  D  ; DBIA419
 .S DFN="" F  S DFN=$O(^DGPM("AMV1",DATEC,DFN)) Q:DFN=""  D
 ..S DA="" F  S DA=$O(^DGPM("AMV1",DATEC,DFN,DA)) Q:DA=""  D
 ...S IBWARD=$$GET1^DIQ(405,DA_",",.06,"I")
 ...D CKAFINS(HCSR,DFN,DATEC,66,.AINS)       ; Check for valid Insurance(s)
 ...S AINSIX="" F  S AINSIX=$O(AINS(AINSIX)) Q:AINSIX=""  D
 ....; check for ward inclusion
 ....; 8/20/15 jws - if ward is not defined
 ....I '$O(^IBE(350.9,1,64,"B",IBWARD,"")) Q
 ....I '$$CHKLIST(64,$O(^IBE(350.9,1,64,"B",IBWARD,"")),$P(AINS(AINSIX),U)) Q
 ....; File the event
 ....S XX=DATEC
 ....S YY=$$GET1^DIQ(405,DA_",",.17,"I")    ; Is there a Discharge
 ....I YY'="" D                             ; Get External Discharge Date
 .....S YY=$$GET1^DIQ(405,DA_",",.01,"I")   ; Discharge Date/Time
 .....S XX=XX_"-"_YY
 .....Q
 ....S NODE0=$$NOW^XLFDT()_U_DFN_U_AINSIX_"^I^"_IBWARD_"^^"_XX_U_$P(DATEC,".",1)
 ....D SETEVENT(NODE0)
 ....Q
 ...Q
 ..Q
 .Q
 ;
 ; Next check future admissions
 D DT^DILF("","T-"_(DATES-1),.DATEC)             ; Past Admission Search date
 F  S DATEC=$O(^DGS(41.1,"C",DATEC)) Q:(DATEC="")!($P(DATEC,".")>DATEE)  D  ; DBIA429
 .S DA="" F  S DA=$O(^DGS(41.1,"C",DATEC,DA)) Q:DA=""  D
 ..Q:$P($G(^DGS(41.1,DA,0)),U,13)'=""            ; Future Admission was cancelled
 ..S IBWARD=$$GET1^DIQ(41.1,DA_",",8,"I")
 ..S DFN=$$GET1^DIQ(41.1,DA_",",.01,"I")         ; Patient DFN
 ..D CKAFINS(HCSR,DFN,DATEC,66,.AINS)            ; Check for valid Insurance(s)
 ..S AINSIX="" F  S AINSIX=$O(AINS(AINSIX)) Q:AINSIX=""  D
 ...; check for ward inclusion
 ...I '$$CHKLIST(64,$O(^IBE(350.9,1,64,"B",IBWARD,"")),$P(AINS(AINSIX),U)) Q
 ...; File the event
 ...S NODE0=$$NOW^XLFDT()_U_DFN_U_AINSIX_"^I^"_IBWARD_"^^"_DATEC_U_$P(DATEC,".",1)
 ...D SETEVENT(NODE0)
 ...Q
 ..Q
 .Q
 Q
 ;
PURGE(HCSR)    ; Purge events that were created based upon the HCSR purge
 ; parameter
 ; Input:   HSCR    - HCSR Site Parameter filters
 ; Output:  Events are deleted from into 356.22
 N DA,DIK,PDATE,PDAYS,TDATE
 S PDAYS=$P(HCSR,"^",9)                         ; Purge Days Parameter
 D DT^DILF("","T-"_PDAYS,.PDATE)                ; Purge events up to PDATE
 S DIK="^IBT(356.22,"
 S TDATE=PDATE
 F  D  Q:(TDATE="")!(TDATE'<PDATE)
 . S TDATE=$O(^IBT(356.22,"B",TDATE),-1)
 . Q:(TDATE="")!(TDATE'<PDATE)
 . S DA=""
 . F  D  Q:DA=""
 . . S DA=$O(^IBT(356.22,"B",TDATE,DA))
 . . Q:DA=""
 . . D ^DIK
 Q
 ;
SETFILTS(HCSR,SFILT) ; Set the Appointment Search filters
 ; Input:   HCSR    - HCSR Site Parameters
 ; Output:  SFILT() - Array of Appointment Search filters
 N DATEE,DATES,SDATE,IX,IEN
 ;
 ; Determine the maximum date range to be searched
 D GETDAYS1(HCSR,.DATES,.DATEE)
 D DT^DILF("","T-"_DATES,.SDATE)                ; Past Appt Search date
 S SFILT(1)=SDATE
 D DT^DILF("","T+"_DATEE,.SDATE)                ; Future Appt Search date
 S $P(SFILT(1),";",2)=SDATE
 S SFILT(3)="R;I;NT"                            ; Schedule/Kept Appointment filter
 S SFILT("FLDS")="1;2;3;4;10;12"                ; list of fields to return
 S SFILT("SORT")="P"                            ; Sort by Patient DFN only
 Q
 ;
GETDAYS1(HCSR,DATES,DATEE)    ; Checks the HCSR Site Parameters to get the 
 ; maximum date range to be use when search for appointments
 ; Input:       HCSR    - HCSR Site Parameters
 ; Output:      DATES   - Internal fileman date to begin start search on
 ;              DATEE   - Internal fileman date to end search after
 ;
 ; Find the site parameter with the greatest number of days
 S DATES=$P(HCSR,"^",3)                         ; Past Appointment Search Days
 S:$P(HCSR,"^",7)>DATES DATES=$P(HCSR,"^",7)    ; TRICARE Past Appt Search Days
 ;
 ; Find the site parameter with the greatest number of days
 S DATEE=$P(HCSR,"^",13)                        ; Future Appointment Search Days
 S:$P(HCSR,"^",5)>DATEE DATEE=$P(HCSR,"^",5)    ; TRICARE Future Appt Search Days
 Q
 ;
GETDAYS2(HCSR,DATES,DATEE)    ; Checks the HCSR Site Parameters to get the 
 ; maximum date range to use when searching for admissions
 ; Input:       HCSR    - HCSR Site Parameters
 ; Output:      DATES   - Internal fileman date to begin start search on
 ;              DATEE   - Internal fileman date to end search after
 ;
 ; Find the site parameter with the greatest number of days
 S DATES=$P(HCSR,"^",4)                         ; Past Admission Search Days
 S:$P(HCSR,"^",8)>DATES DATES=$P(HCSR,"^",8)    ; TRICARE Past Admission Search Days
 ;
 ; Find the site parameter with the greatest number of days
 S DATEE=$P(HCSR,"^",2)                         ; Future Admission Search Days
 S:$P(HCSR,"^",6)>DATEE DATEE=$P(HCSR,"^",6)    ; TRICARE future Admission Search Days
 Q
 ;
CKAFINS(HCSR,DFN,ADATE,WHICH,AINS,DATECHK)    ; Checks to see if the selected patient
 ; has active insurance(S) that are valid for HCSR Site Parameter filter 
 ; criteria
 ; Input:       HCSR    - HCSR Site Parameters
 ;              DFN     - Internal Patient IEN
 ;              ADATE   - Internal Fileman date to check for 'active'
 ;              WHICH   - 65 - Checking for an appointment
 ;                        66 - Checking for an admission
 ; Output:      AINS()  - Array of all of the active insurances that are valid
 N COB,IBWARD,INSDATA,INSIEN,INSIX,INSNAME,STOP,TDATE,TRICARE,XX
 K AINS
 D ALL^IBCNS1(DFN,"INSDATA",1,ADATE)
 ;
 ; No active insurance for specified date
 I '$G(INSDATA(0)) Q 0
 S INSIX=0
 F  D  Q:+INSIX=0
 . S INSIX=$O(INSDATA(INSIX))
 . Q:+INSIX=0
 . S TRICARE=0,STOP=0
 . S INSIEN=$P(INSDATA(INSIX,0),"^",1)
 . S COB=$P(INSDATA(INSIX,0),"^",20)
 . S INSNAME=$$GET1^DIQ(36,INSIEN_",",.01)      ; Insurance Company Name
 . S INSNAME=$$UP^XLFSTR(INSNAME)
 . I (INSNAME["TRICARE")!(INSNAME["CHAMPVA") D
 . . S TRICARE=1
 . ; 
 . ; Check if the Insurance is TRICARE or CHAMPVA and then make sure that the
 . ; date being checked is valid for the type of insurance
 . I WHICH=65,'+$G(DATECHK) D  Q:STOP
 . . I 'TRICARE D  Q
 . . . S XX=$P(HCSR,"^",3)                      ; Past Appt Days
 . . . D DT^DILF("","T-"_XX,.TDATE)             ; Past Appt Search date
 . . . I ADATE<TDATE S STOP=1 Q                 ; Date<Past Appt Date
 . . . S XX=$P(HCSR,"^",13)                     ; Future Appt Days
 . . . D DT^DILF("","T+"_XX,.TDATE)             ; Future Appt Search date
 . . . I ADATE>TDATE S STOP=1 Q                 ; Date>Future Appt Date
 . . S XX=$P(HCSR,"^",7)                        ; TRICARE Past Appt Days
 . . D DT^DILF("","T-"_XX,.TDATE)               ; TRICARE Past Appt Search date
 . . I ADATE<TDATE S STOP=1 Q                   ; Date<Past TRICARE Appt Date
 . . S XX=$P(HCSR,"^",5)                        ; TRICARE Future Appt Days
 . . D DT^DILF("","T+"_XX,.TDATE)               ; TRICARE Future Appt Search date
 . . I ADATE>TDATE S STOP=1 Q                   ; Date>Future TRICARE Appt Date
 . ;
 . I WHICH=66,'+$G(DATECHK) D  Q:STOP
 . . I 'TRICARE D  Q
 . . . S XX=$P(HCSR,"^",4)                      ; Past Admission Days
 . . . D DT^DILF("","T-"_XX,.TDATE)             ; Past Admission Search date
 . . . I ADATE<TDATE S STOP=1 Q                 ; Date<Past Admission Date
 . . . S XX=$P(HCSR,"^",2)                      ; Future Admission Days
 . . . D DT^DILF("","T+"_XX,.TDATE)             ; Future Admission Search date
 . . . I ADATE>TDATE S STOP=1 Q                 ; Date>Future Admission Date
 . . S XX=$P(HCSR,"^",8)                        ; TRICARE Past Admission Days
 . . D DT^DILF("","T-"_XX,.TDATE)               ; TRICARE Past Admission Search date
 . . I ADATE<TDATE S STOP=1 Q                   ; Date<Past TRICARE Admission Date
 . . S XX=$P(HCSR,"^",6)                        ; TRICARE Future Admission Days
 . . D DT^DILF("","T+"_XX,.TDATE)               ; TRICARE Future Admission Search date
 . . I ADATE>TDATE S STOP=1 Q                   ; Date>Future TRICARE Admission Date
 . ;
 . I $D(^IBE(350.9,1,WHICH,"B",INSIEN)) D       ; On the inclusion list
 . . S AINS(INSIX)=INSIEN_"^"_COB
 Q
 ;
SETEVENT(NODE0) ; Set Events into the HCS Review Transmission file (356.22)
 ; Input:   NODE0 - A1^A2^...^An Where:
 ;                    A1  - External date of when event was filed
 ;                    A2  - Internal Patient DFN event is for
 ;                    A3  - Insurance multiple IEN
 ;                    A4  - Status. 'I' for Admission, 'O' for appointment
 ;                    A5  - Internal Ward IEN (file 42) if event is an 
 ;                          admission, null otherwise
 ;                    A6  - Internal Clinic IEN (file 44) if event is an 
 ;                          appointment, null otherwise
 ;                    A7  - Internal fileman date (or date range) of the event
 ;                          (appointment or admission date)
 ;                          NOTE: if admission, this is B1-B2 Where:
 ;                                  B1 - Internal Admission Start Date
 ;                                  B2 - Internal Admission Discharge Date
 ;                    A8  - Source identifier - Internal fileman date/time of
 ;                          the appointment or the Internal fileman date of the
 ;                          admission that caused the event creation.  Used in
 ;                          Conjunction with the patient's DFN and Insurance IEN
 ;                          to prevent the creation of 'duplicate' entries
 ; Output:  Event is filed into the HCS Review Transmission file (356.22)
 N DFN,FDA,IEN,INSMIEN,SOURCE,STATUS
 S DFN=$P(NODE0,"^",2)
 S STATUS=$P(NODE0,"^",4)
 S SOURCE=$P(NODE0,"^",8)
 S INSMIEN=$P(NODE0,"^",3)
 ;
 ; Quit if we already have an event for this Status, Ins IEN and Source IEN
 Q:$D(^IBT(356.22,"E",DFN,STATUS,INSMIEN,SOURCE))
 ;
 S FDA(356.22,"+1,",.01)=$P(NODE0,"^",1)
 S FDA(356.22,"+1,",.02)=DFN
 S FDA(356.22,"+1,",.03)=INSMIEN
 S FDA(356.22,"+1,",.04)=STATUS
 S FDA(356.22,"+1,",.05)=$P(NODE0,"^",5)
 S FDA(356.22,"+1,",.06)=$P(NODE0,"^",6)
 S FDA(356.22,"+1,",.08)=0   ; Set initial status to 0
 S FDA(356.22,"+1,",.07)=$P($P(NODE0,U,7),"-")  ; force single date
 ; IF $P($P(NODE0,"^",7),"-",2)'="" S FDA(356.22,"+1,",2.22)=$P($P($P(NODE0,"^",7),"-",2),".")
 S FDA(356.22,"+1,",.16)=SOURCE
 ; JWS 4/2/15 added check for service line data, then if HSD 01 and HSD 02 values do not exist for 2000E loop, default
 ; them to HSD01='VS' and HSD02=1 for outpatient, HSD01='DY' and HSD02=1 for inpatient
 S FDA(356.22,"+1,",4.01)=$$FIND1^DIC(365.016,,,$S(STATUS="I":"DY",1:"VS"))  ; quantity qualifier
 S FDA(356.22,"+1,",4.02)=1  ; unit count
 D UPDATE^DIE("","FDA")
 Q
 ;
ER ; Unlock the IBT HCSR Nightly Process and return to log error
 L -^TMP("IBTRHDE")
 D ^%ZTER
 D UNWIND^%ZTER
 Q
 ;
CHKLIST(NODE,LISTIEN,INSIEN) ; check site parameters and determine if clinic/ward + payer combination is on the list
 ;
 ; NODE = 63 - for Clinic Search inclusion list
 ;        64 - for Ward Search inclusion list
 ;
 ; LISTIEN - IEN in sub-file 350.963 for clinics or 350.964 for wards
 ;
 ; INSIEN - IEN in file 36
 ;
 ; returns 1 if clinic + payer or ward + payer should be included, 0 otherwise
 ;
 N PYRIEN,RES,Z
 S RES=0
 I +$G(LISTIEN),+$G(INSIEN) D
 .; file event if clinic / ward is associated with all payers
 .I $$ISALL^IBJPC3(NODE,LISTIEN) S RES=1 Q
 .; don't file event if clinic / ward is associated with zero payers
 .I $$GETTOT^IBJPC3(NODE,LISTIEN)'>0 S RES=0 Q
 .S PYRIEN=+$$GET1^DIQ(36,INSIEN_",",3.1,"I") I PYRIEN'>0 Q
 .; if payer associated with this ins. co. is on the list - file event
 .I +$O(^IBE(350.9,1,NODE,LISTIEN,1,"B",PYRIEN,""))>0 S RES=1
 .Q
 Q RES
