PRSATP3 ;HISC/MGD-Timekeeper Post Absence ;01/03/06
 ;;4.0;PAID;**102**;Sep 21, 1995
 ;
HENCAP(PPI,DFN,WDAY,DBH,HOL,DAH,QUIT) ; 
 ; Check to see if there is a Holiday encapsulated by some form of non-pay.
 ; Called from Timekeeper Posting routine ^PRSATP
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
 N BACK,PPIP
 S PPIP=PPI
 ;
 ; Check Day After Holiday
 D DAH^PRSATP7(PPIP,DFN,WDAY,.DAH,.QUIT)
 I DAH="" S QUIT=1
 Q:QUIT
 ;
 ; Find Holiday
 S BACK=0
 F  D  Q:QUIT!(HOL'="")!(HOL=""&BACK=2)
 . S WDAY=WDAY-1
 . I WDAY=0 D GETPPP^PRSATP5(.PPIP,DFN,.WDAY,.BACK,.QUIT)
 . I BACK=2 S QUIT=1 Q
 . D FNDHOL^PRSATP8(PPIP,DFN,WDAY,.HOL,.QUIT)
 Q:QUIT
 ;
 ; Find Previous Work Day
 S PPIP=$P(HOL,U,1),WDAY=$P(HOL,U,2),BACK=0
 F  D  Q:QUIT!(DBH'="")!(DBH=""&BACK=2)
 . S WDAY=WDAY-1
 . I WDAY=0 D GETPPP^PRSATP5(.PPIP,DFN,.WDAY,.BACK,.QUIT)
 . I BACK=2 S QUIT=1 Q
 . D DBH^PRSATP6(PPIP,DFN,WDAY,.DBH,.QUIT)
 Q
 ;
UPDT(DFN,DBH,HOL,DAH) ; Perform final checks
 ; Input:
 ;   DFN - IEN of employee
 ;   DBH - PPI^DAY^type of non-pay
 ;   HOL - PPI^DAY^Status of timecard that contains holiday
 ;   DAH - PPI^DAY^type of non-pay
 ;
 ; Output:
 ;       Displays Holiday encapsulation message to Timekeeper and whether
 ;       or not it was able to chance the HX postings to the apppriate
 ;       form of non-pay
 ;   
 ; Holiday was encapsulated by non-pay.  Perform final checks.
 N HDAY,HIEN,HPPI,HOLEX,HOLIN,IEN4585,LSTAT,PPI,PRSIEN,SEG,TOT
 N TSTAT,PRSFDA,SEG,SOH
 S HPPI=$P(HOL,U,1),HDAY=$P(HOL,U,2),PPI=$P(DAH,U,1)
 S HOLEX=$P(^PRST(458,HPPI,2),U,HDAY) ; External date
 S HOLIN=$P(^PRST(458,HPPI,1),U,HDAY) ; Internal date
 ;
 ; Compare types of non-pay before and after
 S TOT=$S($P(DBH,U,3)'=$P(DAH,U,3):"NP",1:$P(DAH,U,3))
 ;
 ; If holiday is in the current PP, employee timecard will already
 ; be locked.  If holiday is in prior pay period try to lock it.
 ; LSTAT = 1 - Holiday in current PP and was already locked
 ;       = 2 - Holiday in prior PP and lock was obtained
 ;       = 3 - Holiday in prior PP and lock was not obtained
 ;       
 I PPI=HPPI S LSTAT=1
 I PPI'=HPPI D
 . L +^PRST(458,HPPI,"E",DFN):2
 . S LSTAT=$S($T:2,1:3)
 S SOH=$P(^PRST(458,HPPI,"E",DFN,0),U,2) ; Get current status of holiday
 ;
 ; Change HX to appropriate form of non-pay
 S HIEN=HDAY_","_DFN_","_HPPI_","
 F SEG=43:4:67 D
 . I $$GET1^DIQ(458.02,HIEN,SEG)="HX" D
 . . S PRSIEN(458.02,HIEN,SEG)=TOT
 I $D(PRSIEN),LSTAT<3,SOH="T" D UPDATE^DIE("","PRSIEN","HIEN"),MSG^DIALOG()
 ;
 ; Display appropriate message based on Lock and timecard status
 W !!,"Due to the non-pay posting on this day the holiday occurring on ",HOLEX
 W !,"was encapsulated with non-pay.  "
 ;
 ; If we could autopost non-pay
 I LSTAT<3,SOH="T" D
 . W "The HX postings were automatically updated to"
 . W !,"the appropriate form of non-pay."
 ;
 ; If we could not autopost non-pay because timecard was in a status other 
 ; than T (Timekeeper)
 I SOH'="T" D
 . W "The HX postings could not be automatically"
 . W !,"updated to the appropriate form of non-pay because the status of the holiday"
 . W !,"was not TIMEKEEPER.  You will need to manually address this issue."
 . D SET
 ;
 ; If we could not autopost non-pay because the timecard was currently locked
 ; by another user
 I LSTAT=3,SOH="T" D
 . W "The HX postings could not be automatically"
 . W !,"updated to the appropriate form of non-pay because the timecard was locked"
 . W !,"by another user.  You will need to manually address this issue."
 . D SET
 Q
 ;
SET ; Add entry to #458.5
 S PRSFDA(458.5,"+1,",.01)=DFN ;  Employee
 S PRSFDA(458.5,"+1,",1)=DFN ;  Employee
 S PRSFDA(458.5,"+1,",2)=HOLIN ; Date of exception
 S PRSFDA(458.5,"+1,",4)="HX was encapsulated by non-pay" ; Type of Exception
 D UPDATE^DIE("","PRSFDA","IEN4585"),MSG^DIALOG()
 ;
 ; Reset .01 field to sequence number
 S IEN4585=IEN4585(1)_","
 S PRSFDA(458.5,IEN4585,.01)=IEN4585(1) ; Sequence #
 D UPDATE^DIE("","PRSFDA","IEN4585"),MSG^DIALOG()
 Q
