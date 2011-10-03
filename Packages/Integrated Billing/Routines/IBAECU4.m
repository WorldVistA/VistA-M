IBAECU4 ;WOIFO/SS-LTC PHASE 2 UTILITIES ; 20-FEB-02
 ;;2.0;INTEGRATED BILLING;**171,176**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;** LTC Clock related utilities **
 ;Makes FM date from any date of month or YEAR_MONTH and Day #
MKDATE(IBYM,IBD) ;
 Q $E(IBYM,1,5)_$S(IBD<10:"0"_IBD,1:IBD)
 ;substracts (CHNG<0) or adds (CHNG>0) days to date
 ;DATE - date in FM format
CHNGDATE(DATE,CHNG) ;
 N X,X1,X2
 S X1=DATE,X2=CHNG D C^%DTC
 Q X
 ;adjusts clocks
 ; "C" - cancel it
 ; "P" - 1) mark patient as "processed" i.e. we should 
 ;     set CURRENT EVENTS DATE="" 
 ;    or to 1st day of the next month if the patient is not disharged yet
 ;    2)adjust 180 days clocks
 ;.IBCLKADJ - array with info regarding clock adjustment
 ;IBCLKIEN - ien of file 351.81
 ;IBDFN - dfn of the  patient
 ;IBINPLD - returned value of $$ISINPAT^IBAECU2 for the last date of the month
 ;   if "^" - no admission for the last day of  the 
 ;   processed month, set CURRENT EVENTS DATE=""
 ;   if "number^" then we have inpatient LTC on the last day,
 ;   set CURRENT EVENTS DATE=1st day of the following month
 ;IBEND the last date of the month
CLCKADJ(IBCLKADJ,IBCLIEN,IBDFN,IBINPLD,IBEND) ;
 N IBNEWDT
 ;check if it is the 1st MJ then do not cancel clock and do not clear CURRENT EVENTS field
 I $G(IBMJ1ST)="MJ1ST" Q:IBCLKADJ="C"  Q:+IBINPLD=0
 S IBNEWDT=""
 ;"C": cancel clock
 I IBCLKADJ="C" D  Q
 . L +^IBA(351.81,0):10 I '$T D  Q  ;quit
 . . D ERRLOG^IBAECU5(+$G(IBDFN),+$G(IBCLIEN),"Clocks","Lock error: not cancelled")
 . D CANCCLCK(IBCLIEN,IBDFN) ;cancel clock
 . D CLKSTAMP(IBCLIEN,IBDFN)
 . L -^IBA(351.81,0)
 ;"P": mark that the patient has been processed succesfully
 I IBCLKADJ="P" D  Q
 . L +^IBA(351.81,0):10 I '$T D  Q  ;quit
 . . D ERRLOG^IBAECU5(+$G(IBDFN),+$G(IBCLIEN),"Clocks","Lock error: no current event change")
 . I +IBINPLD>0 S IBNEWDT=$$CHNGDATE(IBEND,+1)
 . D CHNGEVEN(IBCLIEN,IBDFN,IBNEWDT)
 . D CLKSTAMP(IBCLIEN,IBDFN)
 . L -^IBA(351.81,0)
 ;
 Q
 ;if there are free days then:
 ; returns 1 
 ;otherwise:
 ; returns 0
EXEMPT21(IBCLIEN) ;
 Q $P($G(^IBA(351.81,IBCLIEN,0)),"^",6)>0
 ;returns a new expiration date
 ;which is = the same day next year - 1 day
 ;example : for 3000401 it is 3010331
GETEXPDT(IBDATE) ;
 N IBY,IBMD
 S IBMD=$E(IBDATE,4,7)
 S IBY=$E(IBDATE,1,3)
 I IBMD="0229" S IBMD="0228"
 S IBY=IBY+1
 Q $$CHNGDATE(+(IBY_IBMD),-1)
 ;sets #350.81 fields 4.03 USER LAST UPDATING and 4.04 DATE LAST UPDATED 
 ;Note: use outside LOCK
CLKSTAMP(IBIENCL,IBDFN1) ;
 N IBIENS,IBFDA,IBD,IBERR
 S IBIENS=IBIENCL_","
 S IBFDA(351.81,IBIENS,4.03)=+$G(DUZ)
 D NOW^%DTC S IBD=%
 S IBFDA(351.81,IBIENS,4.04)=IBD
 D FILE^DIE("","IBFDA","IBERR")
 I $D(IBERR) D
 . D ERRLOG^IBAECU5(+$G(IBDFN1),+$G(IBIENCL),"Clocks","stamp error:"_$G(IBERR("DIERR",1,"TEXT",1)))
 Q
 ;resets fields .03 (CLOCK BEGIN DATE) and .04 (CLOCK EXPIRATION DATE) of LTC clock file
 ;INPUT:
 ;IBIENCL - ien of #351.81
 ;IBDATE - date in FM format
 ;Note: use outside LOCK
RESET21(IBIENCL,IBDATE,IBDFN1) ;
 N IBIENS,IBFDA,IBERR
 S IBIENS=IBIENCL_"," ; "D0,"
 S IBFDA(351.81,IBIENS,.03)=IBDATE ;begin date (file#,IENS,field#)
 S IBFDA(351.81,IBIENS,.04)=$$GETEXPDT(IBDATE) ;expiration date (file#,IENS,field#)
 D FILE^DIE("","IBFDA","IBERR")
 I $D(IBERR) D
 . D ERRLOG^IBAECU5(+$G(IBDFN1),+$G(IBIENCL),"Clocks",$G(IBERR("DIERR",1,"TEXT",1)))
 Q
 ;Adds a new exempt day to multiple in #351.81
 ;Set EXEMPT DAYS REMAINING to appropriate value
 ;INPUT:
 ;IBCLIEN - ien in file #351.81
 ;DATE - new exempt date 
 ;Note: use outside LOCK
ADDEXDAY(IBIENCL,IBDATE,IBDFN1) ;
 N IBIENS,IBFDA,IBDAY,IBERR,IBSSI
 S IBDAY=+$P($G(^IBA(351.81,IBIENCL,1,0)),"^",4)
 Q:IBDAY=21
 S IBDAY=IBDAY+1
 ;-add day
 S IBIENS="+1,"_IBIENCL_"," ; "+1,D0,"
 S IBFDA(351.811,IBIENS,.01)=IBDAY ;(file#,IENS,field#)
 S IBFDA(351.811,IBIENS,.02)=IBDATE ;(file#,IENS,field#)
 D UPDATE^DIE("","IBFDA","IBSSI","IBERR")
 I $D(IBERR) D
 . D ERRLOG^IBAECU5(+$G(IBDFN1),+$G(IBIENCL),"Clocks",$G(IBERR("DIERR",1,"TEXT",1)))
 ;-decrease DAYS REMAINING
 S IBIENS=IBIENCL_"," ; "D0,"
 S IBFDA(351.81,IBIENS,.06)=21-IBDAY ;Expiration date (file#,IENS,field#)
 D FILE^DIE("","IBFDA","IBERR")
 I $D(IBERR) D
 . D ERRLOG^IBAECU5(+$G(IBDFN1),+$G(IBIENCL),"Clocks",$G(IBERR("DIERR",1,"TEXT",1)))
 Q
 ;check for 21 days errors 
 ;run once before start to process all days of the month for the patient
 ;check correct number of days
 ;IBIEN- ien of #351.81
 ;if no days returns 0
 ;if an error then files into ERRLOG and returns -1 or  -2
 ;if OK returns number of exempted days
CHKDSERR(IBIENCL,IBDFN1) ;
 N IBDAT,IBDS
 S IBDAT=$G(^IBA(351.81,IBIENCL,1,0))
 Q:IBDAT="" 0
 S IBDS=$P($G(^IBA(351.81,IBIENCL,0)),"^",6)
 I +$P(IBDAT,"^",3)'=+$P(IBDAT,"^",4) D  Q -1
 . D ERRLOG^IBAECU5(+$G(IBDFN1),+$G(IBIENCL),"Clocks","total number of entries and last EXEMPT DAY NUMBER are not equal in #351.811")
 I IBDS'=(21-$P(IBDAT,"^",3)) D  Q -2
 . D ERRLOG^IBAECU5(+$G(IBDFN1),+$G(IBIENCL),"Clocks","DAYS REMAINING'=21-last EXEMPT DAY NUMBER")
 I IBDS'=(21-$P(IBDAT,"^",4)) D  Q -3
 . D ERRLOG^IBAECU5(+$G(IBDFN1),+$G(IBIENCL),"Clocks","DAYS REMAINING'=21-total number of #351.811 entries")
 Q +$P(IBDAT,"^",4)
 ;closes entry in file #351.81
 ; set STATUS = CLOSED
 ;Note: use outside LOCK
CLOSECLK(IBIENCL,IBDFN1) ;
 D CHNGSTAT(IBIENCL,IBDFN1,2)
 Q
 ;Cancels clock entry
 ; set STATUS = CANCEL
 ;Note: use outside LOCK
CANCCLCK(IBIENCL,IBDFN1) ;
 D CHNGSTAT(IBIENCL,IBDFN1,3)
 Q
 ;resets CURRENT EVENTS DATE field
 ;INPUT:
 ;IBIENCL - ien of #351.81
 ;IBDFN1 - dfn of the patient 
 ;IBDATE - new date or ""
 ;Note: use outside LOCK
CHNGEVEN(IBIENCL,IBDFN1,IBDATE) ;
 N IBIENS,IBFDA,IBERR
 S IBIENS=IBIENCL_"," ; "D0,"
 S IBFDA(351.81,IBIENS,.07)=IBDATE ;status (file#,IENS,field#)
 D FILE^DIE("","IBFDA","IBERR")
 I $D(IBERR) D
 . D ERRLOG^IBAECU5(+$G(IBDFN1),+$G(IBIENCL),"Clocks","change current event="_$G(IBDATE)_" "_$G(IBERR("DIERR",1,"TEXT",1)))
 Q
 ;resets STATUS field
 ;INPUT:
 ;IBIENCL - ien of #351.81
 ;Note: use outside LOCK
CHNGSTAT(IBIENCL,IBDFN1,IBNEWST) ;
 N IBIENS,IBFDA,IBERR
 S IBIENS=IBIENCL_"," ; "D0,"
 S IBFDA(351.81,IBIENS,.05)=IBNEWST ;status (file#,IENS,field#)
 D FILE^DIE("","IBFDA","IBERR")
 I $D(IBERR) D
 . D ERRLOG^IBAECU5(+$G(IBDFN1),+$G(IBIENCL),"Clocks","change status="_$G(IBNEWST)_" "_$G(IBERR("DIERR",1,"TEXT",1)))
 Q
 ;creates a new entry in file #351.81
 ;sets adds (#.01),(#.02),(#.03),(#.05),(#4.01),(#4.02)
 ;DOES NOT set EXPIRATION date (use RESET21)
 ;returns new ien in file #351.81
NEWCLK(IBDFN,IBDT) ;
 N IBIEN
 I '$D(DUZ) N DUZ S DUZ=0
 S:'$D(U) U="^"
 S IBIEN=$$ADDCL^IBAECU(IBDFN,IBDT)
 Q:IBIEN<0 0  ;if was not created
 Q IBIEN
 ;run once to fix everything before start to process all days of the month for the patient
 ;fix 21 days clock if CHKDSERR returns IBERCOD<0
 ;IBIEN- ien of #351.81
 ;Note: use outside LOCK
FIX21CLK(IBIEN) ;
 N IBV1,IBV2,IBARR,IBDFN1,IBDEL,IBIENS,IBERR,IBFDA,IBDATA,IBBEG,IBEXP
 S (IBV1,IBARR,IBDEL)=0
 S IBDATA=$G(^IBA(351.81,IBIEN,0))
 S IBDFN1=+$P(IBDATA,"^",2)
 S IBBEG=+$P(IBDATA,"^",3)
 S IBEXP=+$P(IBDATA,"^",4)
 I +IBEXP=0 D
 . S IBIENS=IBIEN_"," ; "D0,"
 . S IBFDA(351.81,IBIENS,.04)=$$GETEXPDT(IBBEG) ;expiration date
 . D FILE^DIE("","IBFDA","IBERR")
 . I $D(IBERR) D
 . . D ERRLOG^IBAECU5(+$G(IBDFN1),+$G(IBIEN),"Clocks",$G(IBERR("DIERR",1,"TEXT",1)))
 . S IBEXP=+$P($G(^IBA(351.81,IBIEN,0)),"^",4)
 ;
 Q:+IBDFN1=0
 F  S IBV1=$O(^IBA(351.81,IBIEN,1,IBV1)) Q:+IBV1=0  D
 . S IBV2=+$P($G(^IBA(351.81,IBIEN,1,IBV1,0)),"^",2)
 . I IBV2<IBBEG!(IBV2>IBEXP) D
 . . D ERRLOG^IBAECU5(+$G(IBDFN1),+$G(IBIEN),"Clocks","Exempt day is out of clock range")
 . S IBARR(+$P($G(^IBA(351.81,IBIEN,1,IBV1,0)),"^",2))=""
 . S IBDEL(IBV1)=""
 ;- DAYS REMAINING
 S IBIENS=IBIEN_"," ; "D0,"
 S IBFDA(351.81,IBIENS,.06)=21 ; (file#,IENS,field#)
 D FILE^DIE("","IBFDA","IBERR")
 I $D(IBERR) D
 . D ERRLOG^IBAECU5(+$G(IBDFN1),+$G(IBIEN),"Clocks",$G(IBERR("DIERR",1,"TEXT",1)))
 S IBV1=0
 F  S IBV1=$O(IBDEL(IBV1)) Q:+IBV1=0  D
 . D DELEXDAY(IBIEN,IBV1)
 S IBV1=0
 F  S IBV1=$O(IBARR(IBV1)) Q:+IBV1=0  D
 . D ADDEXDAY(IBIEN,IBV1,IBDFN1)
 Q
 ;Delete exempt day from multiple
 ;INPUT:
 ;IBIEN - ien in file #351.81
 ;IBN - ien of exempt date entry
 ;Note: use outside LOCK
DELEXDAY(IBIEN,IBN) ;
 N IBIENS,IBFDA
 S IBIENS=IBN_","_IBIEN_","
 S IBFDA(351.811,IBIENS,.01)="@"
 D FILE^DIE("","IBFDA")
 Q
