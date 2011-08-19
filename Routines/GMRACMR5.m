GMRACMR5 ;HIRMFO/WAA-PATIENT NOT ASKED ABOUT ALLERGIES ; 10/1/92
 ;;4.0;Adverse Reaction Tracking;;Mar 29, 1996
IDMARK(DFN,GMRADATE,GMRAIEN) ;
 ; Find if an IDBAND has been mark for a date range
 ; Input Variable List
 ;    GMRADATE = The date of the event
 ;    DFN      = Patient DFN
 ;    GMRAIEN  = IEN for reaction to check
 ;
 ; Extrinsic Function Variable List
 ;    GMRAID   = Return value of extrinsic function
 ;                 1 means ID Band was marked for this admission.
 ;                 0 means ID Band was not marked.
 ;    GMRADM   = Admission Date
 ;    GMRAD    = Patient Movement IEN for discharge
 ;    GMRADIS  = Discharge Date
 ;    GMRAX    = Scratch Variable
 ;    VAINDT   = Admission date (used for ADM^VADPT2 call)
 ;    VADMVT   = Patient Movement IEN for admission
 ;
 N GMRADM,GMRADIS,GMRAD,GMRAID,GMRAX,VAINDT,VADMVT
 S GMRAID=0
 S:GMRADATE'="CURRENT" VAINDT=GMRADATE D ADM^VADPT2
 S GMRADM=$P($G(^DGPM(VADMVT,0)),U) ; ADM MOVEMENT DATE
 S GMRAD=$P($G(^DGPM(VADMVT,0)),U,17) ; GET DISCHARGE IEN
 S GMRADIS=$P($G(^DGPM(+GMRAD,0)),U) ; GET DISCHARGE DATE
 I GMRADIS="" S GMRADIS=$$NOW^XLFDT ; IF NO DISCHARGE DATE SET TO TODAY
 S GMRAX=$O(^GMR(120.8,GMRAIEN,14,"B",GMRADM)) ; GRAB THE DATE FROM ART
 I GMRAX'="",GMRAX<GMRADIS S GMRAID=1 ;VERIFY IT IS BETWEEN THE DATES
 Q GMRAID
