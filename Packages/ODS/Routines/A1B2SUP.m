A1B2SUP ;ALB/MJK - ODS Supervisor Options; JAN 13,1991
 ;;Version 1.55 (local for MAS v5 sites);;
 ;
 ;
EN D DT^DICRW S X=$T(+1),DIK="^DOPT(""A1B2SUP"","
 G A:$D(^DOPT("A1B2SUP",5))
 S ^DOPT("A1B2SUP",0)="ODS Supervisor Options^1N^"
 F I=1:1 S Y=$T(@I) Q:Y=""  S ^DOPT("A1B2SUP",I,0)=$P(Y,";",3,99)
 D IXALL^DIK
 ;
A W !! S DIC="^DOPT(""A1B2SUP"",",DIC(0)="IQEAM"
 D ^DIC Q:Y<0  D @+Y G A
 ;
1 ;;Activate ODS Software
 D ASK G Q1:'Y
 D FAC^A1B2UTL
 S A1B2POS=+$O(^DIC(21,"D",6,0)) S:'$D(^DIC(21,A1B2POS,0)) A1B2POS=0
 I 'A1B2POS!('A1B2FN) D MES G Q1
 D BOS^A1B2PST W !
 S DR="[A1B2 PARAMETERS]",DIE="^A1B2(11500.5,",DA=1 D ^DIE G Q1:'$P(^A1B2(11500.5,1,0),U,2)
 I $P(^DIC(21,A1B2POS,0),U,8) S DIE="^DIC(21,",DR=".08///@",DA=A1B2POS D ^DIE
 D OPT
Q1 K A1B2POS,A1B2FN,A1B2FNE,DQ,DE,DR,DIE,DQ Q
 ;
OPT ; -- ask questins to set-up background job to run nightly
 W !!,">>> Please enter date/time for the 'A1B2 BACKGROUND JOB' option to run:"
 S DA=$O(^DIC(19,"B","A1B2 BACKGROUND JOB",0)),DR="200//T+1@2AM;202///1D",DIE="^DIC(19," D ^DIE
 W !,">>> This job does NOT require an output device."
 Q
 ;
2 ;;Compile and Transmit ODS Data
 D QUEUE^A1B2BGJ
 Q
 ;
3 ;;ODS System Inquiry
 D ^A1B2STAT
 Q
 ;
MES ;; -- can't swith on software
 W !!,*7,">>>> ODS software CANNOT be activated:"
 W:'A1B2FN !,"       o  Medical Center Division file entry '",$O(^DG(40.8,0)),"' does not point"
 W:'A1B2FN !,"          to an Institution file entry that has a Facility number"
 W:'A1B2FN !,"          defined."
 W:'A1B2POS !!,"       o  ODS Period of Service does NOT exist on your system."
 Q
 ;
ASK ; -- ask are they sure
 ; -- don't show message if flag is already on
 I '$D(^A1B2(11500.5,1,0)) S Y=0 G ASKQ
 S Y=$P(^A1B2(11500.5,1,0),U,2) G ASKQ:Y
 W !!?20,"******* P L E A S E    N O T E *******"
 W !!?5,"Do NOT activate this Operation Desert Shield (ODS) software"
 W !?5,"until directed to by Central Office in Washington D.C."
 W !?5,"This software will only be activated in the event that it becomes"
 W !?5,"necessary for the VA to track ODS casualties."
 W !!?5,"With the software deactivated, the MAS application will"
 W !?5,"operate normally.  When activated, various ODS related"
 W !?5,"questions will appear during the registration, admit and"
 W !?5,"discharge processes.",!
 S DIR("A")="Are you sure you wish to continue",DIR(0)="Y",DIR("B")="NO"
 D ^DIR K DIR Q
ASKQ Q
