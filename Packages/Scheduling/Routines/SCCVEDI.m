SCCVEDI ;ALB/RMO,TMP - Disposition Conversion; [ 03/28/95  9:18 AM ]
 ;;5.3;Scheduling;**211**;Aug 13, 1993
 ;
EN(SCCVEVT,SCSTDT,SCENDT,SCLOG,SCREQ,SCSTOP) ;Entry point to loop through all dispositions for a specified date range
 ; Input  -- SCCVEVT  Conversion event
 ;           SCSTST   Start date
 ;           SCENDT   End date
 ;           SCLOG    Scheduling conversion log IEN
 ;           SCREQ    Scheduling conversion request IEN
 ; Output -- SCSTOPF  Conversion stop flag
 N SCDTM
 S SCDTM=0
 F SCDTM=SCSTDT:0 S SCDTM=$O(^DPT("ADIS",SCDTM)) Q:'SCDTM!($P(SCDTM,".")>SCENDT)!($G(SCSTOPF))  D PAT(SCCVEVT,SCDTM,SCLOG,SCREQ,.SCSTOPF)
ENQ Q
 ;
PAT(SCCVEVT,SCDTM,SCLOG,SCREQ,SCSTOPF) ;Loop through patient dispositions for a specified date range
 ; Input  -- SCCVEVT  Conversion event
 ;           SCDTM    Disposition date/time
 ;           SCLOG    Scheduling conversion log IEN
 ;           SCREQ    Scheduling conversion request IEN
 ; Output -- SCSTOPF  Conversion stop flag
 N DFN
 F DFN=0:0 S DFN=$O(^DPT("ADIS",SCDTM,DFN)) Q:'DFN!($G(SCSTOPF))  I $D(^DPT(DFN,"DIS",+$O(^(DFN,0)),0)),$P(^(0),U,2)'=2 D
 . IF SCCVEVT D ZERO(DFN)
 . D EN^SCCVEDI1(SCCVEVT,DFN,SCDTM,SCLOG)
 . D STOP^SCCVLOG(SCLOG,SCREQ,.SCSTOPF)
PATQ Q
 ;
ZERO(DFN) ; -- fix zeroth if missing
 IF '$D(^DPT(DFN,"DIS",0)),$O(^DPT(DFN,"DIS",0)) S ^DPT(DFN,"DIS",0)="^2.101D^^"
 Q
