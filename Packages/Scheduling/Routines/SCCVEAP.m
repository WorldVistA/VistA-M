SCCVEAP ;ALB/RMO,TMP - Appointment Conversion; [ 03/31/95  11:23 AM ]
 ;;5.3;Scheduling;**211**;Aug 13, 1993
 ;
EN(SCCVEVT,SCSTDT,SCENDT,SCLOG,SCREQ,SCDFN,SCSTOPF) ;Entry point to loop through all appointments for a specified date range
 ; Input  -- SCCVEVT  Conversion event
 ;                    0 = Estimate   1 = Convert   2 = Re-convert
 ;           SCSTDT   Start date
 ;           SCENDT   End date
 ;           SCLOG    Scheduling conversion log IEN
 ;           SCREQ    Scheduling conversion request IEN
 ;           SCDFN    If restarting, the DFN to start with
 ; Output -- SCSTOPF  Conversion stop flag
 ;Loop through all patients
 I '$G(SCSTOPF) D ALLPAT(SCCVEVT,SCSTDT,SCENDT,SCLOG,SCREQ,+$G(SCDFN),.SCSTOPF)
 Q
 ;
ALLPAT(SCCVEVT,SCSTDT,SCENDT,SCLOG,SCREQ,SCDFN,SCSTOPF) ;Loop through all patients
 ; Input  -- SCCVEVT  Conversion event
 ;           SCSTDT   Start date
 ;           SCENDT   End date
 ;           SCLOG    Scheduling conversion log IEN
 ;           SCREQ    Scheduling conversion request IEN
 ;           SCDFN    If restarting, the DFN to start with
 ; Output -- SCSTOPF  Conversion stop flag
 N DFN
 S DFN=$S($G(SCDFN):SCDFN-1,1:0)
 F  S DFN=$O(^DPT(DFN)) Q:'DFN!($G(SCSTOPF))  D PAT(SCCVEVT,DFN,SCSTDT,SCENDT,SCLOG,SCREQ,.SCSTOPF)
 Q
 ;
PAT(SCCVEVT,DFN,SCSTDT,SCENDT,SCLOG,SCREQ,SCSTOPF) ;Loop through a patient's appointments
 ; Input  -- SCCVEVT  Conversion event
 ;           DFN      Patient IEN
 ;           SCSTDT   Start date
 ;           SCENDT   End date
 ;           SCLOG    Scheduling conversion log IEN
 ;           SCREQ    Scheduling conversion request IEN
 ; Output -- SCSTOPF  Conversion stop flag
 N SCCLN,SCDTM
 IF SCCVEVT D ZERO(DFN)
 F SCDTM=SCSTDT:0 S SCDTM=$O(^DPT(DFN,"S",SCDTM)) Q:'SCDTM!($P(SCDTM,".")>SCENDT)!($G(SCSTOPF))  I $D(^(SCDTM,0)) S SCCLN=^(0) I $P(SCCLN,U,2)=""!($P(SCCLN,U,2)="I")!($P(SCCLN,U,2)="NT"),$P($G(^SC(+SCCLN,0)),U,3)="C" D
 . S SCCLN=+SCCLN
 . D EN^SCCVEAP1(SCCVEVT,DFN,SCDTM,SCCLN,"",SCLOG)
 . D STOP^SCCVLOG(SCLOG,SCREQ,.SCSTOPF)
PATQ K SCDA
 Q
 ;
ZERO(DFN) ; -- fix zeroth node if missing
 IF '$D(^DPT(DFN,"S",0)),$O(^DPT(DFN,"S",0)) S ^DPT(DFN,"S",0)="^2.98P^^"
 Q
 ;
