DGMTM ;ALB/RMO - Means Test Main Menu Driver ;7 JAN 1992 8:00 am
 ;;5.3;Registration;**45**;Aug 13, 1993
 ;
EN ;Entry point to means test menu driver
 D HOME^%ZIS G:$D(^DOPT("DGMTM",14)) A
 S ^DOPT("DGMTM",0)="Means Test Menu Options^1N^" F I=1:1 S X=$T(@(I)) Q:X=""  S ^DOPT("DGMTM",I,0)=$P(X,";;",2,99)
 S DIK="^DOPT(""DGMTM""," D IXALL^DIK K DIK
 ;
A W !! S DIC="^DOPT(""DGMTM"",",DIC(0)="AEMQ" D ^DIC K DIC Q:Y<0  D @+Y G A
 ;
1 ;;Add a New Means Test
 S DGMTYPT=1 G EN^DGMTA
 ;
2 ;;Adjudicate a Means Test
 S DGMTYPT=1 G ADJ^DGMTEO
 ;
3 ;;Change a Patient's Means Test Category
 G CAT^DGMTEO
 ;
4 ;;Complete a Required Means Test
 G COM^DGMTEO
 ;
5 ;;Edit an Existing Means Test
 S DGMTYPT=1 G EN^DGMTE
 ;
6 ;;View a Past Means Test
 S DGMTYPT=1 G EN^DGMTV
 ;
7 ;;View Means Test Editing Activity
 S DGMTYPT=1 G DIS^DGMTAUD2
 ;
8 ;;Delete a Means Test
 S DGMTYPT=1 G EN^DGMTDEL
 ;
9 ;;List Required/Pending Means Tests
 S DGMTYPT=1 G EN^DGMTOREQ
 ;
10 ;;Required Means Test At Next Appointment
 S DGMTYPT=1 G ^DGMTOFA
 ;
11 ;;Means Test w/Previous Year Threshold
 G ^DGMTOPYT
 ;
12 ;;Patients Who Have Not Agreed to Pay Deductible
 G ^DGMTO
 ;
13 ;;Hardship Review Date
 G ^DGMTOHD
 ;
14 ;;Document Comments On a Means Test
 S DGMTYPT=1 G EN^DGMTREM
