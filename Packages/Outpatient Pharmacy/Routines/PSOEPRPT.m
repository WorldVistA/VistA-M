PSOEPRPT ;BIR/TJL - ePCS Reports RPC Entry Points ;9/27/22  08:48
 ;;7.0;OUTPATIENT PHARMACY;**545**;8 May 96;Build 270
 ;
 ;Added reports to ePCS GUI v 2.0 - Summer 2021.
REQCHK(EPCSVV) ;Required data check
 N I,C
 S C=1
 F I=1:1:$L(EPCSV,U) I '$D(@$P(EPCSV,U,I)) D
 . S ^TMP("EPCSMSG",$J,C)="0^Required data missing "_$P(EPCSV,U,I)
 . S C=C+1,EPCSERR=1
 Q
DATECHK(EPCSSD,EPCSED) ;Check human-friendly date and convert to FileMan format
 ;    Input  EPCSSD  - Start Date (ex. 10/9/01)
 ;           EPCSED  - End Date
 N EPCSI,X,Y
 S %DT="X" F EPCSI="EPCSSD","EPCSED" S X=@EPCSI D ^%DT S @EPCSI=Y
 S EPCSSD=$S(EPCSSD=-1:DT,1:EPCSSD),EPCSED=$S(EPCSED=-1:DT,1:EPCSED)
 S EPCSDATE=$$FMTE^XLFDT(EPCSSD)_"^"_$$FMTE^XLFDT(EPCSED)
 Q
QUEUE ;Queues report to printer
 N ZTIO,ZTDESC,ZTRTN,ZTDTH,ZTSAVE,%ZIS,I,IOP,POP
 S IOP="Q;`"_EPCSDEV,%ZIS="Q" D ^%ZIS I POP D  Q
 . S ^TMP("EPCSMSG",$J,1)="0^Device selection unsuccessful"
 S ZTIO=ION,ZTDESC=EPCSDESC,ZTRTN=EPCSROU
 S ZTDTH=$$FMTH^XLFDT(EPCSQDT)
 ;D NOW^%DTC S ZTDTH=$S(%'<EPCSQDT:%+.0002,1:EPCSQDT)
 F I=1:1:$L(EPCSV,U) I $D(@$P(EPCSV,U,I)) S ZTSAVE($P(EPCSV,U,I))=""
 M ZTSAVE=EPCSSAVE
 D ^%ZTLOAD,HOME^%ZIS,^%ZISC ;K IO("Q")
 I $D(ZTSK) S ^TMP("EPCSMSG",$J)="1^Report queued. Task #"_ZTSK Q
 S ^TMP("EPCSMSG",$J)="0^Task Rejected"
 Q
 ;
EPCSEXP ;DEA Expiration Date Report for RPC Call
 ;  Variables passed in
 ;    EPCSCPRS - System Access to CPRS - Include:
 ;               (A)ctive, (D)isusered or (B)oth
 ;    EPCSTYPE - Type of System Access:
 ;               (C)PRS Active Users Only or (A)ll Active Users
 ;    EPCSSTAT - Expiration Date Status:
 ;               (E)xpired, (N)o expiration date, <= (3)0 days, <= (9)0 days
 ;    EPCSPTYP - Send output to:
 ;               (P)rinter, (D)evice or screen
 ;
 ;  Variable return
 ;       ^TMP($J,"EPCSRPT",n)=report output or to print device.
 N EPCSV,EPCSROU,EPCSDESC
 S EPCSV="EPCSCPRS^EPCSTYPE^EPCSSTAT" D REQCHK(EPCSV) I EPCSERR Q
 I EPCSPTYP="P" D  Q
 . S EPCSROU="GUI^PSODEARP"
 . S EPCSDESC="EPCS DEA EXPIRATION DATE REPORT"
 . D QUEUE
 D GUI^PSODEARP
 Q
EPCSPPP ;Print Prescribers with Privileges [PSO EPCS PRIVS]
 ;
 ;  Variables passed in
 ;    EPCSPTYP - Send output to:
 ;               (P)rinter, (D)evice or screen
 ;
 ;  Variable return
 ;    ^TMP($J,"EPCSRPT",n)=report output or to print device.
 ;
 N EPCSV,EPCSROU,EPCSDESC
 S EPCSV="EPCSPPP"
 I EPCSPTYP="P" D  Q
 . S EPCSROU="GUI^PSODEARA"
 . S EPCSDESC="PRINT PRESCRIBERS WITH PRIVILEGES"
 . D QUEUE
 D GUI^PSODEARA
 Q
EPCSDIS ;Print DISUSER Prescriber with Privileges [PSO EPCS DISUSER PRIVS]
 ;
 ;  Variables passed in
 ;    EPCSPTYP - Send output to:
 ;               (P)rinter, (D)evice or screen
 ;
 ;  Variable return
 ;    ^TMP($J,"EPCSRPT",n)=report output or to print device.
 ;
 N EPCSV,EPCSROU,EPCSDESC
 S EPCSV="EPCSDIS"
 I EPCSPTYP="P" D  Q
 . S EPCSROU="GUI^PSODEARB"
 . S EPCSDESC="PRINT DISUSER PRESCRIBER WITH PRIVILEGES"
 . D QUEUE
 D GUI^PSODEARB
 Q
EPCSAUD ;Changes to DEA Prescribing Privileges Report RPC Call [PSO EPCS LOGICAL ACCESS REPORT]
 ;
 ;  Variables passed in
 ;    EPCSSD   - Start Date of Report
 ;    EPCSED   - End Date of Report
 ;    EPCSPTYP - Send output to:
 ;               (P)rinter, (E)xport, (D)evice or screen
 ;
 ;  Variable return
 ;    ^TMP($J,"EPCSRPT",n)=report output or to print device.
 ;
 N EPCSV,EPCSSAVE,EPCSDESC,EPCSROU
 S EPCSV="EPCSSD^EPCSED" D REQCHK(EPCSV) I EPCSERR Q
 D DATECHK(.EPCSSD,.EPCSED)
 S EPCSSD=EPCSSD-.0001,EPCSED=EPCSED+.9999
 I EPCSPTYP="P" D  Q
 . S EPCSV="EPCSSD^EPCSED"
 . S EPCSROU="GUI^PSODEART"
 . S EPCSDESC="CHANGES TO DEA PRESCRIBING PRIVILEGES REPORT"
 . D QUEUE
 U IO D GUI^PSODEART
 Q
EPCSLACA ;Logical Access Control Audit Report RPC Call [PSO EPCS LOGICAL ACCESS CONTROL AUDIT]
 ;
 ;  Variables passed in
 ;    EPCSSD   - Start Date or Report
 ;    EPCSED   - End Date or Report
 ;    EPCSPTYP - Send output to:
 ;
 ;  Variable returned
 ;    ^TMP($J,"EPCSRPT",n)=report output or to print device.
 ;
 N EPCSV,EPCSSAVE,EPCSDESC,EPCSROU
 S EPCSV="EPCSSD^EPCSED" D REQCHK(EPCSV) I EPCSERR Q
 D DATECHK(.EPCSSD,.EPCSED)
 S EPCSSD=EPCSSD-.0001,EPCSED=EPCSED+.9999
 I EPCSPTYP="P" D  Q
 . S EPCSV="EPCSSD^EPCSED",EPCSROU="GUI^PSODEARL"
 . S EPCSDESC="LOGICAL ACCESS CONTROL AUDIT REPORT"
 . D QUEUE
 U IO D GUI^PSODEARL
 Q
