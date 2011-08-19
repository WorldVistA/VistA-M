RAPM4 ;HOIFO/TH-Radiology Performance Monitors/Indicator; ;8/05/05  14:06
 ;;5.0;Radiology/Nuclear Medicine;**63**;Mar 16, 1998
CKMONTH ; If requested an entire month's data, ask if output goes to OQP
 N RAM,RAMINT
 S RAM=$E(RABDATE,4,5)
 Q:RAM'=$E(RAEDATE,4,5)  ;diff months
 ; find min total days for the requested month
 S RAMINT=31 S:RAM="02" RAMINT=28 I "04^06^09^11"[RAM S RAMINT=30
 S X1=RAEDATE,X2=RABDATE D ^%DTC
 I (X+1)'<RAMINT D HQASK
 Q
HQASK ;
 N DIR
 S DIR("A",1)=" "
 S:'$D(RALASTM) DIR("A",2)="  You have requested an entire month's data."
 S DIR("A",3)="  Do you want to include the OQP Performance Management staff"
 S DIR("A")="  as a recipient of this output"
 S DIR(0)="Y",DIR("B")="NO"
 S DIR("?",1)="   Normally, the OQP Performance Management (Headquarters) only receive"
 S DIR("?",2)="   the automatic mid-month report.  However, if they missed the report"
 S DIR("?",3)="   for the month specified above, and you want them to receive it,"
 S DIR("?")="   answer ""Y""."
 D ^DIR I Y S RAUTOM=1
 Q
