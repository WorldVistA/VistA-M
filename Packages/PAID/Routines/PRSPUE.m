PRSPUE ;HISC/MGD - UNLOCK PRIOR PP ESR ;07/21/05
 ;;4.0;PAID;**93**;Sep 21, 1995;Build 7
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;====================================================================
SUP ; Supervisor Entry
 S PRSTLV=3
T0 D TOP ; print header
 D ^PRSAUTL G:TLI<1 EX
 N DATEX,PRSIEN
T1 K DIC S DIC("A")="Select EMPLOYEE: ",DIC(0)="AEQM",DIC="^PRSPC("
 S DIC("S")="I $P(^(0),""^"",8)=TLE" S D="ATL"_TLE W ! D IX^DIC
 S (DFN,PRSIEN)=+Y K DIC G:DFN<1 EX
 S %DT="AEPX",%DT("A")="Posting Date: ",%DT(0)=-DT W ! D ^%DT
 G:Y<1 EX
 S (DATEX,D1)=Y S Y=$G(^PRST(458,"AD",D1)),PPI=$P(Y,"^",1)
 G EX:PPI<1
 S PPE=$P($G(^PRST(458,PPI,0)),U,1)
 W @IOF
 D DIS^PRSPDESR
 I 'QT D PROMPT
 ; 
 G T1 ;ask for employee again
 Q
 ;
TOP W:$E(IOST,1,2)="C-" @IOF W !?26,"VA TIME & ATTENDANCE SYSTEM"
 W !?32,"UNLOCK DAILY ESR"
 Q
 ;
DIS ; Display Memorandum
 ;
 D DIS^PRSPDESR
 Q
 ;
PROMPT ;
 ; Determine current status of ESR
 ;
 K IENS,PRSFDA
 N IENS,PRSFDA,STATUS,REMARK
 S Y=DATEX
 S PRSD=$P($G(^PRST(458,"AD",Y)),U,2)
 D DD^%DT
 S DATEX=Y
 S STATUS=$P($G(^PRST(458,PPI,"E",PRSIEN,"D",PRSD,7)),U,1)
 I STATUS<4 D  Q
 . W !!,"The date must be SIGNED, APPROVED or a DAY OFF to be eligible for unlocking."
 ;
 S DIR(0)="YAO"
 S DIR("A")="Confirm Unlock of "_DATEX_" (Y/N): "
 W !!
 D ^DIR K DIR
 Q:'Y
 ;
 S REMARK=$$GETREM^PRSPSAP3()
 Q:REMARK="^"
 S IENS=PRSD_","_PRSIEN_","_PPI_","
 S PRSFDA(458.02,IENS,148)=$G(REMARK) ; remarks
 S PRSFDA(458.02,IENS,146)=3 ; RESUBMIT
 S PRSFDA(458.02,IENS,147)="@" ; Delete PT PHYSICIAN DATE/TIME STAMP
 D UPDATE^DIE("","PRSFDA","IENS"),MSG^DIALOG()
 ; if timecard has timekeeper status then clean out TC post otherwise
 ; reapproval may require payroll to return the timecard or do 
 ; a corrected timecard first.
 N RETURN S RETURN=$$CLRTCDY^PRSPSAPU(PPI,PRSIEN,PRSD,)
 ;
 ;
 W @IOF
 D DIS^PRSPDESR
 Q
 ;
EX ; Clean up variables
 K D,D1,DASH,DATA0,DATA5,DATA6,DATA7,PRSD,DAY1,DFN,HRS,MT,PDT,PG,POP
 K PPE,PPI,PRSALST,PRSAPGM,PRSTLV,PTPRMKS,QUIT,QT,RC,RCEX,SCRTTL
 K SEG,SSN,START,STAT,STATEX,STOP,T1,T1EX,TLE,TLI,TLSCREEN,TOT,TOTEX
 K X,Y,%DT,%ZIS
 Q
