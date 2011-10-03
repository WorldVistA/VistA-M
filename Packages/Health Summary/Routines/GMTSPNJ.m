GMTSPNJ ;SLC/JER - Nightly Job to Queue HS Batch Print-by-Loc ; 08/27/2002
 ;;2.7;Health Summary;**5,56**;Oct 20, 1995
 ;
 ; External References
 ;   DBIA 10000  C^%DTC
 ;   DBIA 10000  NOW^%DTC
 ;   DBIA 10063  ^%ZTLOAD
 ;   DBIA 10006  ^DIC
 ;   DBIA  2051  FIND^DIC
 ;   DBIA 10103  $$DOW^XLFDT
 ;                   
 ; Sets GMTSSC=location pointer
 ; If clinic, sets GMTSCDT=desired appt day
 ;                   
 ; Summaries are considered ready Today if GMTSPNJ
 ; run time is today between 24:00 and 12:00, ready
 ; Tomorrow if run time is today between 12:00 and
 ; 24:00.
 ;                   
MAIN ; Controls branching
 N GMTSTYP,GMTSCL,GMW,X
 S GMTSTYP=0 F  S GMTSTYP=$O(^GMT(142,GMTSTYP)) Q:+GMTSTYP'>0  D
 . S GMTSCL=0 F  S GMTSCL=$O(^GMT(142,GMTSTYP,20,GMTSCL)) Q:+GMTSCL'>0  D QUEUE
 Q
QUEUE ; Queues HS batch print for HS Type and Location
 N DIC,GMPSAP,GMTSLOC,GMTSSC,GMTSIO,GMTSDYS,GMV,QUEQIT,X,Y,DAY,NEWDAY
 N GMTSQ,BEGDT,ENDDT,PDATE
 S QUEQIT=0
 S GMTSLOC=$G(^GMT(142,GMTSTYP,20,GMTSCL,0))
 S X=+GMTSLOC,DIC=44,DIC(0)="NXZ" D ^DIC
 I $S(+Y'>0:1,"WCOR"'[$P($G(Y(0)),U,3):1,1:0) Q
 S GMTSSC=Y_U_$P(Y(0),U,3)
 I "COR"[$P(GMTSSC,U,3) D  Q
 . S DAY=+$P(GMTSLOC,U,4)
 . ;   Don't print in advance
 . I DAY'>0 S $P(GMTSSC,U,4)=$$GETDATE(DAY) D QCONT Q
 . S BEGDT=$$GETDATE(0),ENDDT=$$GETDATE(DAY)
 . Q:$$NONWDAY(BEGDT)
 . S NEWDAY=$$WKEND(DAY,BEGDT,ENDDT)
 . ;   Get last date to be printed
 . S PDATE=$$GETDATE(+NEWDAY)
 . F  D  Q:+$G(GMTSQ)
 . . ;     Set variable before doing QCONT
 . . S $P(GMTSSC,U,4)=PDATE
 . . D QCONT
 . . ;     Decrement to get previous day
 . . S NEWDAY=NEWDAY-1
 . . ;     Quit For Loop when non-workdays data has been printed
 . . I DAY>NEWDAY S GMTSQ=1 Q
 . . ;     Get date
 . . S PDATE=$$GETDATE(+NEWDAY)
 . . ;     Quit For Loop if there's a work
 . . ;     day between Holiday and Weekend.
 . . ;     Don't print weekend data twice.
 . . I +$$NONWDAY(PDATE)'>0 S GMTSQ=1 Q
 ;                       
QCONT ; Used so following can be done for 
 ; multiple dates for Clinics and ORs.
 I $$CKPAT^GMTSPD(GMTSSC)'>0 Q
 S GMPSAP=$S($P(GMTSLOC,U,3)="Y":1,1:0)
 S ZTIO=$$GETIO($P(GMTSLOC,U,2)) Q:'$L(ZTIO)
 S ZTDTH=$H,ZTRTN="MAIN^GMTSPL",ZTDESC="Health Summary"
 F GMV="GMTSTYP","GMTSSC","GMPSAP" S ZTSAVE(GMV)=""
 D ^%ZTLOAD
 Q
 ;                       
GETDATE(DAYS) ; Gets desired Visit/Surgery date
 ;   Receives: DAYS=Print Days ahead
 ;   Returns:  FileMan Date/time
 N %,%H,%I,%T,GMTSDT,GMTSPM,X1,X2,X
 D NOW^%DTC S GMTSDT=$P(%,"."),GMTSPM=$S(+$E($P(%,".",2),1,2)>12:1,1:0)
 S X1=GMTSDT,X2=DAYS+GMTSPM D C^%DTC
 Q X
 ;                       
NONWDAY(GMTSDT) ; Determines if non work day (i.e. Sat., Sun., or Holiday) 
 ; Returns 1 if print day is weekend or holiday
 N DAYNAME
 S DAYNAME=$$DOW^XLFDT(GMTSDT)
 Q $S(DAYNAME="Saturday":1,DAYNAME="Sunday":1,$$HOLIDAY(GMTSDT):1,1:0)
 ;                       
WKEND(DAY,BEGDT,ENDDT) ; Updates days in advance for weekend and holiday dates
 N GMI,X1,X2,X,%H,DAYNAME
 F GMI=1:1 S X1=BEGDT,X2=GMI D C^%DTC Q:X>ENDDT  D
 . S DAYNAME=$$DOW^XLFDT(X)
 . I DAYNAME="Saturday"!(DAYNAME="Sunday")!($$HOLIDAY(X)) S DAY=DAY+1,ENDDT=$$GETDATE(DAY)
 . ;   If one of days is Saturday, Sunday, or holiday, 
 . ;   up days by one and recalculate ending date
 Q DAY
 ;                       
HOLIDAY(GMDT) ; Determines if a date is a Holiday.
 ;   Requires that the Holiday (#40.5) file is updated
 ;   to determine if a date is a holiday.
 N GMDATE
 D FIND^DIC(40.5,"",.01,"QX",GMDT,1,"","","","GMDATE")
 Q +$G(GMDATE("DILIST",0))
 ;                       
GETIO(X) ; Get device for queueing
 N %,%Y,C,DIC,Y
 S DIC=3.5,DIC(0)="NXZ" D ^DIC S Y=$S(+Y'>0:"",1:$P(Y(0),U))
 Q Y
