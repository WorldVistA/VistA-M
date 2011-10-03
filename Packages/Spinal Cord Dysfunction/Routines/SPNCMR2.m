SPNCMR2 ;HIRMFO/WAA-This routine will find all valid patient ; 9/3/93
 ;;2.0;Spinal Cord Dysfunction;**7**;01/02/1997
EN1 ;Loop thru the ^SC file to find all Scheduled appointments
 Q:SPNSEL'["2"
 S SPNX=0 D LP1,UNSCH(SPNST,SPNED,"D CB^SPNCMR2(Y,Y0,.SDSTOP)")
 G EXIT
LP1 S SPNX=$O(^TMP($J,"SPNWC",SPNX)) Q:SPNX<1
 I $G(^TMP($J,"SPNWC",SPNX))'="W" D
 .;this code finds all patients who are scheduled
 .F SPNDATE=SPNST:0 S SPNDATE=$O(^SC(SPNX,"S",SPNDATE)) Q:SPNDATE<1!(SPNDATE>SPNED)  D
 ..S SPNIEN=0 F  S SPNIEN=$O(^SC(SPNX,"S",SPNDATE,1,SPNIEN)) Q:SPNIEN<1  D
 ...Q:'$D(^SC(SPNX,"S",SPNDATE,1,SPNIEN,0))  S SPNDFN=$P(^(0),U)
 ...I "I"[$P($G(^DPT(SPNDFN,"S",SPNDATE,0)),U,2) D SETPT^SPNCMR3
 ...Q
 ..Q
 .Q
 G LP1
UNSCH(SPNST,SPNED,SPNCB) ; -- find all patients who are Unscheduled
 ;   input:   SPNST := start date
 ;            SPNED := end date
 ;            SPNCB := callback code executed for each encounter in
 ;                     query's result set
 ;
 N SPNQRY
 ;
 ; -- set up scan
 D OPEN^SDQ(.SPNQRY)                     ; -- initialize query
 D INDEX^SDQ(.SPNQRY,"DATE/TIME","SET")  ; -- which index to use
 D DATE^SDQ(.SPNQRY,SPNST,SPNED,"SET")   ; -- date range
 D SCANCB^SDQ(.SPNQRY,SPNCB,"SET")       ; -- callback code to use
 D ACTIVE^SDQ(.SPNQRY,"TRUE","SET")      ; -- activate query
 ;
 D SCAN^SDQ(.SPNQRY,"FORWARD")           ; -- scan entries in query
 ;                                            result set
 D CLOSE^SDQ(.SPNQRY)                    ; -- close query
 Q
 ;
EXIT K SPNCS,SPNCS(0),SPNNUM,SPNX,SPNDFN,SPNDATE
 Q
 ;
CB(SPNOE,SPNOE0,SPNSTOP) ;     -- callback code called for each
 ;                                record in query result set
 ;
 ;  input:  SPNOE   := ien of Outpatient Encounter
 ;          SPNOE0  := zeroth node of Outpatient Encounter
 ;          SPNSTOP := tells query to stop processing by setting to 1
 ;
 N SPNX,SPNDFN,SPNDATE
 IF $P(SPNOE0,U,6) G CBQ     ; -- quit if encounter has parent
 IF $P(SPNOE0,U,8)'=2 G CBQ  ; -- quit if not standalone encounter
 ;
 S SPNDATE=+SPNOE0           ; -- encounter date
 S SPNDFN=+$P(SPNOE0,U,2)    ; -- patient
 S SPNX=+$P(SPNOE0,U,4)      ; -- clinic
 IF SPNX D SETPT^SPNCMR3
CBQ Q
 ;
