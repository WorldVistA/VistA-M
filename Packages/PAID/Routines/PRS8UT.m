PRS8UT ;HISC/MRL,JAH/WIRMFO-DECOMPOSITION, UTILITIES ;3/5/93  15:24
 ;;4.0;PAID;**21,45**;Sep 21, 1995
 ;
 ;This routine contains utility functions associated with the
 ;decomposition process such as device selection.
 ;
 ;Called by Routines:  PRS8, PRS8TL
 ;
DEV ; --- device selection
 K IOP,%ZIS S %ZIS="NQM",%ZIS("A")="Output DEVICE:  ",%ZIS("B")="HOME"
 D ^%ZIS K %ZIS
 I POP W !,"Process Terminated.  No Device Specified!",*7 G END
 S IOP=ION_";"_IOST_$S($D(IO("DOC")):";"_IO("DOC"),1:";"_IOM_";"_IOSL)
 I IO=IO(0),"C"[$E(IOST),$D(IO("Q"))#2 W !,"I can't permit you to QUEUE this output to a CRT!",*7 G DEV
 I IO'=IO(0),'$D(IO("Q")) W !,"Output QUEUED to run on DEVICE ",IO S IO("Q")=1,ZTDTH=$H
 I '$D(IO("Q")) D ^%ZIS U IO G @PRS8("PGM")
 S ZTRTN=PRS8("PGM"),ZTIO=IOP,ZTDESC=PRS8("DES")
 F I=1:1 S J=$P(PRS8("VAR"),"^",I) Q:J=""  S ZTSAVE(J)=""
 K IO("Q") D ^%ZTLOAD,HOME^%ZIS
 ;
END ; --- all done here
 K ZTSK,IOP,%IS Q
HOLIDAY(PY,DFN,DY) ; PAY_PERIOD , EMPLOYEE , DAY_NUMBER
 ; Returns 1 if holiday excused/worked (HX/HW) is found for this employee
 N X S X=$G(^PRST(458,+PY,"E",+DFN,"D",+DY,2))
 Q (X["HX")!(X["HW")
 ;
 ;= = = = = = = = = = = = = = = = = = = = = = = = = = = = =
 ;
OLDENT(PP2Y,EMP450) ;
 ; Return employee entitlement from a pay period.  Entitlement is 
 ; normally built from employee's master record (FILE 450), but 
 ; it is also stored in file 458 (which is historical) and may
 ; be different than the employee's current entitlement.
 ;
 N DIC,X,Y,PPI,DA
 S ENT=0
 S DIC="^PRST(458,",DIC(0)="MZ",X=PP2Y
 D ^DIC
 Q:'+Y ENT
 ;
 S DA(1)=+Y
 S DIC=DIC_DA(1)_","_"""E"""_","
 S X=EMP450 D ^DIC
 Q:'+Y ENT
 ;
 S ENT=$P($G(^PRST(458,DA(1),"E",+Y,0)),"^",5)
 Q ENT
 ;
 ;= = = = = = = = = = = = = = = = = = = = = = = = = = = = =
 ;
OLDPP(PYPERIOD,EMP450NO) ;OLD PAY PERIOD LOOKUP
 ;  Look up information about an employee from an old pay period.
 ;  return PAYPLAN if the lookup is successful and a pay plan is found.
 ;  return 0 if the lookup fails for any reason.
 ;  fill OLDPP array with pay run info.
 ;VARS:
 ; PYPERIOD = Pay period that we are looking up.  yy-pp format (96-01).
 ; EMP450NO = Employees internal entry number from file 450.
 ; PAYPDIEN = Internal entry number of PYPERIOD
 ; RTN      = Return 1 for success 0 otherwise
 ; OLDPYDAT = Payrun data in file 459.  Data is pertinant to employee 
 ;            being looked up during that pay period.
 ; PAYPLAN  = Employees old pay plan.  returned if found.
 ;
 S RTN=0,U="^"
 ;ensure params are reasonable
 I $G(PYPERIOD)?2N1"-"2N,($G(EMP450NO)>0) D
 .  S PAYPDIEN=$O(^PRST(459,"B",$G(PYPERIOD),""))
 .  I $G(PAYPDIEN) D
 ..    S OLDPYDAT=$G(^PRST(459,PAYPDIEN,"P",EMP450NO,0))
 ..    S PAYPLAN=$P(OLDPYDAT,U,3)
 ..    I PAYPLAN'="" D
 ...      D SETOLDPP(OLDPYDAT)
 ...      S RTN=PAYPLAN
 Q RTN
SETOLDPP(EMPDATA) ;set up array with info from an employees record 
 ;in the payrun download file (#459)
 ;
 S U="^"
 S OLDPP("PAYPLN")=$P(EMPDATA,U,3)
 S OLDPP("GRADE")=$P(EMPDATA,U,4)
 S OLDPP("STEP")=$P(EMPDATA,U,5)
 S OLDPP("DUTYBS")=$P(EMPDATA,U,6)
 S OLDPP("8BNHRS")=$P(EMPDATA,U,7)
 S OLDPP("TLUNIT")=$P(EMPDATA,U,13)
 S OLDPP("NRMHRS")=$P(EMPDATA,U,12)
 Q
