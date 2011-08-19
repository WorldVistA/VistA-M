PRSATP4 ;HISC/MGD-Timekeeper Post Absence ;12/07/05
 ;;4.0;PAID;**102**;Sep 21, 1995
 ;
HENCAP(PPI,DFN,WDAY,DBH,HOL,DAH,QUIT) ; 
 ; Check to see if there is a Holiday encapsulated by some form of non-pay.
 ; Called from Supervisor's Pay Period Certification option.
 ; 
 ; Test #1            | DBH  HOL  DAH
 ; Test #2        DBH | HOL  DAH
 ; Test #3   DBH  HOL | DAH
 ; Test #4  DBH | HOL | DAH
 ;
 ;  Input:
 ;    PPI - IEN of current pay period
 ;    DFN - IEN of employee
 ;   WDAY - Day to begin testing
 ;    DBH - null
 ;    HOL - null
 ;    DAH - null
 ;   QUIT - null
 ;
 ; Output: If set these variables will contain the following
 ;    DAH - PPI^DAY^type of non-pay
 ;    DBH - PPI^DAY^type of non-pay
 ;    HOL - PPI^DAY^Status of timecard that contains holiday
 ;   QUIT - Will be set to 1 when holiday encapsulation test fails
 ;          and no additional checks need to be made.
 ;          
 N BACK,HIEN,HOLEX,LSTAT,NEXT,PPIP,SET,TOT,TSTAT,PPIP
 ; Kill ordered arrays before starting
 K HT,HE,HO,HC,NT,NE,NO,NC,PT,PE,PO,PC
 S PPIP=PPI
 ;
 ; Determine if current day is a holiday
 D FNDHOL^PRSATP8(PPIP,DFN,WDAY,.HOL,.QUIT)
 I HOL="" S QUIT=1
 Q:QUIT
 ;
 ; Find Day After Holiday
 S NEXT=0
 F  D  Q:QUIT!(DAH'="")!(DAH=""&NEXT=2)
 . S WDAY=WDAY+1
 . I WDAY=15 D GETNPP^PRSATP5(.PPIP,DFN,.WDAY,.NEXT,.QUIT)
 . I NEXT=2 S QUIT=1 Q
 . D DAH^PRSATP7(PPIP,DFN,WDAY,.DAH,.QUIT)
 Q:QUIT
 ;
 ; Find Day Before Holiday
 S PPIP=$P(HOL,U,1),WDAY=$P(HOL,U,2),BACK=0
 F  D  Q:QUIT!(DBH'="")!(DBH=""&BACK=2)
 . S WDAY=WDAY-1
 . I WDAY=0 D GETPPP^PRSATP5(.PPIP,DFN,.WDAY,.BACK,.QUIT)
 . I BACK=2 S QUIT=1 Q
 . D DBH^PRSATP6(PPIP,DFN,WDAY,.DBH,.QUIT)
 Q
