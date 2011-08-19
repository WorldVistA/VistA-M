QAOSUPL1 ;HISC/DAD-GENERATE SUMMARY OF OS UPLOAD BULLETIN ;5/11/93  08:15
 ;;3.0;Occurrence Screen;;09/14/1993
EN ;
 W @IOF
 W !!,"5.  Facility Workload Data (Should be readily available from Medical"
 W !,"Administration Service)"
 W !!,"   a.  Number of Admissions to Acute Care during Reporting Period:"
 K DIR S DIR(0)="NOA^0:99999:0"
 ;
 S DIR("?",1)="Reference : RCS 10-0021 (8ZD1) VA Inpatient Care"
 S DIR("?",2)="  Under the ""Gains"" Section; Line ""Total - Adm & Trans"""
 S DIR("?",3)="  List for each Bed Section:"
 S DIR("?")="Enter a number from 0 to 99999"
 S DIR("A")="      Medicine (Include Neurology, exclude Intermediate Med.): "
 D HELP(4) W ! D REF(3)
 W ! D ^DIR G:$D(DTOUT)!$D(DUOUT)!$D(DIROUT) EXIT S QAOSWORK(1)=Y
 S DIR("A")="      Surgery: "
 W ! D ^DIR G:$D(DTOUT)!$D(DUOUT)!$D(DIROUT) EXIT S QAOSWORK(2)=Y
 S DIR("A")="      Psychiatry: "
 W ! D ^DIR G:$D(DTOUT)!$D(DUOUT)!$D(DIROUT) EXIT S QAOSWORK(3)=Y
 ;
 W @IOF
 S DIR("?",1)="Reference: RCS 10-0004 (BPA1) Outpatient Health Service Workload"
 S DIR("?",2)="  Section 8.  ""Purpose of Visit""; Line B ""10-10 Visits"" and Line D"
 S DIR("?",3)="  ""Unscheduled Visits"""
 S DIR("?")="Enter a number from 0 to 99999"
 S DIR("A",1)="   b.  Number of ""Unscheduled"" and ""10-10"" Ambulatory Care"
 S DIR("A")="Visits During Reporting Period: "
 D HELP(4) W ! D REF(3)
 W ! D ^DIR G:$D(DTOUT)!$D(DUOUT)!$D(DIROUT) EXIT S QAOSWORK(4)=Y
 ;
 S (QAOSWORK(5),QAOSWORK(6))=""
 ;
 W @IOF
 S DIR("?",1)="Reference: VA Form 10-7396d Annual Report of Surgical Procedures"
 S DIR("?",2)="  Sum the Total Reported at the Bottom of each Part that is compiled"
 S DIR("?",3)="  for each Surgical Section.",DIR("?")="Enter a number from 0 to 99999"
 K DIR("A") S DIR("A")="   c.  Number of Surgical Procedures Performed: "
 W ! D REF(3)
 W ! D ^DIR G:$D(DTOUT)!$D(DUOUT)!$D(DIROUT) EXIT S QAOSWORK(7)=Y
 ;
 G EN^QAOSUPL2
EXIT ;
 G EXIT^QAOSUPL2
HELP(Y) ;
 S DIR("?",Y)=""
 S DIR("?",Y+1)="NOTE: The reports cited for Medicine, Surgery, Psychiatry, and Ambulatory Care"
 S DIR("?",Y+2)="are cumulative.  March's cumulative totals are the data to be reported for the"
 S DIR("?",Y+3)="first semi-annual report of the fiscal year.  Data for the second semi-annual"
 S DIR("?",Y+4)="report are derived by subtracting March's figures from September's totals."
 Q
REF(Y) ;
 N QA F QA=1:1:Y W !,DIR("?",QA)
 Q
