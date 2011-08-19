SPNCMR5 ;HIRMFO/WAA-PATIENT NOT ASKED ABOUT ALLERGIES ; 10/1/92
 ;;2.0;Spinal Cord Dysfunction;;01/02/1997
IDMARK(DFN,SPNDATE,SPNIEN) ;
 ; Find if an IDBAND has been mark for a date range
 ; Input Variable List
 ;    SPNDATE = The date of the event
 ;    DFN      = Patient DFN
 ;    SPNIEN  = IEN for reaction to check
 ;
 ; Extrinsic Function Variable List
 ;    SPNID   = Return value of extrinsic function
 ;                 1 means ID Band was marked for this admission.
 ;                 0 means ID Band was not marked.
 ;    SPNDM   = Admission Date
 ;    SPND    = Patient Movement IEN for discharge
 ;    SPNDIS  = Discharge Date
 ;    SPNX    = Scratch Variable
 ;    VAINDT   = Admission date (used for ADM^VADPT2 call)
 ;    VADMVT   = Patient Movement IEN for admission
 ;
 N SPNDM,SPNDIS,SPND,SPNID,SPNX,VAINDT,VADMVT
 S SPNID=0
 S:SPNDATE'="CURRENT" VAINDT=SPNDATE D ADM^VADPT2
 S SPNDM=$P($G(^DGPM(VADMVT,0)),U) ; ADM MOVEMENT DATE
 S SPND=$P($G(^DGPM(VADMVT,0)),U,17) ; GET DISCHARGE IEN
 S SPNDIS=$P($G(^DGPM(+SPND,0)),U) ; GET DISCHARGE DATE
 I SPNDIS="" S SPNDIS=$$NOW^XLFDT ; IF NO DISCHARGE DATE SET TO TODAY
 S SPNX=$O(^GMR(120.8,SPNIEN,14,"B",SPNDM)) ; GRAB THE DATE FROM ART
 I SPNX'="",SPNX<SPNDIS S SPNID=1 ;VERIFY IT IS BETWEEN THE DATES
 Q SPNID
