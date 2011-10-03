PSIVRQ ;BIR/PR,MLM,MV-REPORT DRIVER ; 9/25/08 12:31pm
 ;;5.0; INPATIENT MEDICATIONS ;**196**;16 DEC 97;Build 13
DTS ;Get start and stop dates for all reports
 I '$D(STSRPT),'$D(PSIVRC) S (Y,X2)=$S($D(^PS(50.8,1,.2)):^(.2),1:0) I Y X ^DD("DD") W !!,"The IV BACKGROUND JOB [PSJI BACKGROUND JOB] that compiles IV cost data",!,"was last successfully run on: ",Y
 I '$D(STSRPT),'$D(PSIVRC) S X1=DT D ^%DTC I X>1 W !!,$C(7),"**WARNING** that was <",X,"> days ago. PLEASE contact your site manager.",!?12,"Cost data is probably not accurate because of this."
 I '$D(STSRPT),$D(^PS(50.8,0)) F Z=0:0 S Z=$O(^PS(50.8,Z)) Q:'Z  I $D(^(Z,2)) S DATA=$O(^PS(50.8,Z,2,0)) W !!,$C(7),$C(7),"The oldest cost data for room: ",$P($G(^PS(59.5,Z,0)),U)," goes back to: " S Y=DATA X ^DD("DD") W $S(Y'="":Y,1:"??")
 K BRIEF,SMO S %DT="AXE",%DT(0)="-T",%DT("A")="Enter Start Date: " W ! D ^%DT G:Y<0 K S I7=+Y
 S %DT("A")="Enter End Date: " W ! D ^%DT G:Y<0 K S I8=+Y
 I I8<I7 W !!,$C(7),$C(7),"End date must be GREATER than start date." G DTS
 ;
 Q:$D(STSRPT)
RECOM ;Recompile IV cost data for date range
 I $D(PSIVRC) K PSIVRC G ^PSIVREC
 ;
 ;
LS ;Ask for long or short report if user is running the drug cost report.
 ;Set variable BRIEF if a condensed report is requested
 K BRIEF,DIR
 I $D(PSIVPCR) S DIR(0)="SO^C:Condensed;R:Regular",DIR("A")="(R)egular or (C)ondensed",DIR("B")="Regular",DIR("?")="Enter ""R"" to include drug data, or ""C"" to list only the drug total per provider" D ^DIR K DIR S:X="C" BRIEF=1
 G:'$D(PSIVDCR) IV
 S DIR(0)="SO^C:Condensed;R:Regular",DIR("A")="(R)egular or (C)ondensed",DIR("B")="Regular",DIR("?")="Enter ""R"" to include ward data, or ""C"" to exclude ward data",DIR("??")="^S HELP=""CON"" D ^PSIVHLP2" D ^DIR K DIR
 ;PSJ*5*196
 I $TR(X,"c","C")["C" S BRIEF=1 K PQ
 G:X="^" K
 ;
IV ;Ask user for IV room to run reports for.
 ;Only for the drug cost, ward cost, and provider cost reports.
 I $D(PSIVPAT)!($D(PSIVAMIS)) G ^PSIVRQ1
 S DIR(0)="P0^59.5",DIR("A")="Select IV room",DIR("B")="^ALL",DIR("?")="Enter the name of the IV room, or ^ALL for all IV rooms",DIR("??")="^S HELP=""IVR"" D ^PSIVHLP2" D ^DIR K DIR
 G:X="^" K I $P("^ALL",X)="" W $P("^ALL",X,2) S I4=0,I15="ALL IV ROOMS"
 E  W $P(Y,X,2) S I4=+Y,I15="IV ROOM: "_$P(Y,U,2)
 G ^PSIVRQ1
K ;Kill variables
 K %DT,%T,BRIEF,D,DATA,DFN,DIC,DIRUT,DUOUT,G,HELP,I1,I10,I11,I2,I3,I4,I5,I6,I7,I8,I9,I15,JJ,LCO,NU,POP,PQ,PSIVDCR,PSIVPAT,PSIVPCR,PSIVPCR
 K PSIVRC,PSIVWCR,Q,UCO,X,Y,PQ,SMO,VAERR,Y,Z,ZTSK D ENIVKV^PSGSETU S:$D(ZTQUEUED) ZTREQ="@"
 Q
