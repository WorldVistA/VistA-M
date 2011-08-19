PRSAPRT ; HISC/REL,WIRMFO/JAH-Return Record to TimeKeeper ;1/31/2007
 ;;4.0;PAID;**7,8,21,111**;Sep 21, 1995;Build 2
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; Comments & Modifications by JAH Washington IRMFO.
 ; Timecards are returned to Time Keeper 4 correction & 
 ; re-certification, only 4 pay period being processed & they
 ; must be returned be4 timecards have been transmitted to
 ; Austin.  Time cards 4 pay period just closed are to be 
 ; transmitted to Austin by 10 am on Wednesday of first week 
 ; of current pay period.  There may be a period in begining 
 ; of a new pay period in which an employee has been set up 
 ; with a new pay plan & their time card has not been 
 ; decomposed & transmitted.  If this is case Austin will reject 
 ; card due to conflicting pay plans.  
 ;
 N PPERIOD,OLDPP,PAYP
 ;
 ;Ask User for pay period
 S DIC="^PRST(458,",DIC(0)="AEQM"
 S DIC("A")="Select PAY PERIOD: "
 W !
 D ^DIC K DIC
 ;
 ;Quit if invalid pay period
 G:Y<1 EX
 S PPI=+Y,PPERIOD=$P(Y,"^",2)
 ;
NME ;ask for name of employee who's timecard is to be returned.
 K DIC
 S DIC("A")="Select EMPLOYEE: "
 S DIC(0)="AEQM"
 S DIC="^PRSPC("
 W !
 D ^DIC S DFN=+Y K DIC
 ;Quit if employees name not found in file 450 (PAID employee).
 G:DFN<1 EX
 ;
 I '$D(^PRST(458,PPI,"E",DFN,0)) W $C(7),!!,"No Record exists to return!" G EX
 ;
 ;Display message to payroll if employee has changed pay plans.  
 ;Austin will reject a timecard if pay plan is different.
 S GO=1
 S OLDPP=$$OLDPP^PRS8UT(PPERIOD,DFN)
 S PAYP=$P($G(^PRSPC(DFN,0)),"^",21)
 I OLDPP'=0,(OLDPP'=PAYP) D
 . W !,"PLEASE NOTE:  Employee has changed pay plans.  "
 . W !,"Current Pay Plan: ",PAYP
 . W !,"Pay Plan during Pay Period ",PPERIOD," ",OLDPP
 . S GO=$$CONTINUE^PRSAUTL
 I 'GO G EX
 ;
 S STAT=$P($G(^PRST(458,PPI,"E",DFN,0)),"^",2)
 I "T"[STAT W $C(7),!!,"TimeKeeper still has this Employee." G EX
 I STAT="P" D B W !!," . . . Returned to Timekeeper." G EX
 W $C(7),!!,"Warning! This Employee has already been Transmitted."
A R !!,"Return to Timekeeper Anyway? ",X:DTIME G:'$T!(X["^") EX S:X="" X="*" S X=$TR(X,"yesno","YESNO")
 I $P("YES",X,1)'="",$P("NO",X,1)'="" W $C(7)," Answer YES or NO" G A
 I X?1"Y".E D B W !!," . . . Returned to Timekeeper." G EX
 G EX
B S $P(^PRST(458,PPI,"E",DFN,0),"^",2)="T" K ^(5)
 D AUTOPINI^PRS8(PPI,DFN)
 Q
EX G KILL^XUSCLEAN
