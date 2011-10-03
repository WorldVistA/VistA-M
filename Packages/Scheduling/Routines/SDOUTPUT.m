SDOUTPUT ;ALB/TMP - SCHEDULING OUTPUTS DRIVER ROUTINE ; 10 APR 86
 ;;5.3;Scheduling;**132**;Aug 13, 1993
 D DT^DICRW S DIK="^DOPT(""SDOUTPUT"","
 G O:$D(^DOPT("SDOUTPUT",15)) S ^(0)="Scheduling Output Option^1N" F I=1:1 S X=$T(@I) Q:X']""  S ^DOPT("SDOUTPUT",I,0)=$P(X,";",3)
 D IXALL^DIK
O W !! S DIC=DIK,DIC(0)="EQAM" D ^DIC I Y>0 D @+Y G SDOUTPUT
 Q
1 ;;AMIS 223 Report
 W !,"The AMIS 223 Report is obsolete!" Q
2 ;;Appointment List
 G ^SDAL
3 ;;Cancellation Letters
 W !,"THIS OPTION HAS BEEN REPLACED WITH THE PRINT SCHEDULING LETTERS OPTION!" Q
4 ;;Clinic Workload Report
 G ^SDCWL
5 ;;Clinic Assignment List
 G ^SDCLAS
6 ;;Clinic List (Day of Week)
 G ^SDCLDOW
7 ;;Clinic Profile
 S:'$D(DTIME) DTIME=300 I '$D(DT) D DT^SDUTL
 G ^SDCP
8 ;;File Room List
 G ^SDF
9 ;;Inpatient Appointments
 G ^SDWARD
10 ;;Letter Pre-Appointment
 W !,"THIS OPTION HAS BEEN REPLACED WITH THE PRINT SCHEDULING LETTERS OPTION!" Q
11 ;;Patient Profile
 G ^SDPP
111 S DIC="^DPT(",DR="0;.36;.11;.13;.321;.1;.101;DE;S;SDVD" U IO W @IOF K DX(0) D EN^DIQ,CLOSE^DGUTQ Q
12 ;;Radiology Pull List
 G ^SDRFC
13 ;;Routing Slips
 G ^SDROUT
14 ;;No-Show Letters
 W !,"THIS OPTION HAS BEEN REPLACED WITH THE PRINT SCHEDULING LETTERS OPTION!" Q
15 ;;Enrollments > X Days
 G ^SDST
16 ;;Print Scheduling Letters
 G ^SDLTP
