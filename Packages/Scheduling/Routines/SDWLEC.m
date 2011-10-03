SDWLEC ;;IOFO BAY PINES/ESW - CLOSED WAITING LIST-EDIT;06/12/2002 ; 20 Aug 2002  2:10 PM  ; Compiled April 16, 2007 10:48:37
 ;;5.3;scheduling;**446**;AUG 13 1993;Build 77
 ;
 ;modified SDWLE
 ;******************************************************************
 ;                             CHANGE LOG
 ;                                               
 ;   DATE                        PATCH                   DESCRIPTION
 ;   ----                        -----                   -----------
 ;   09JUN2005                   446                     Inter-Facility Transfer.
 ;                                                       
 ;   
EN ;ENTRY POINT - INTIALIZE VARIABLES
 N DTOUT,%,SDWLHDR,SDWLNAM,SDWLSSN,SDWLTEM,SDWLPOS,VADM,VA,X
 I $D(SDWLOPT),SDWLOPT G OPT
 I $D(SDWLLIST),SDWLLIST,$D(DFN),DFN<0 K SDWLLIST
 I $D(SDWLLIST),SDWLLIST,$D(DFN),DFN'="" S SDWLDFN=DFN D 1^VADPT S (SDWLTEM,SDWLPOS)=0 D HD,SB1 G EN1:'$D(DUOUT) W !,"PATIENT: ",VADM(1),?40,VA("PID") W !,*7,"PATIENT'S DATE OF DEATH HAS BEEN RECORDED" S DIR(0)="E" D ^DIR G END
 K ^TMP("SDWLD",$J) D HD
 D PAT G END:DFN<0
OPT ;
 N SDWLDFN,SDWLNEW,SDWLERR,SDWLCN,SDWLWTE,SDWLPS
 S SDWLDFN=DFN
 D 1^VADPT
 S (SDWLTEM,SDWLPOS)=0
EN1 S SDWLNEW=0,SDWLERR=0,SDWLCN=0,SDWLWTE=0
 D DIS
 I $D(^SDWL(409.3,"B",DFN)),'SDWLCN W !!,"PATIENT: ",VADM(1),?40,VA("PID")
 S SDWLPS=$S(SDWLCN>1:1,SDWLCN=1:2,1:3)
 I $D(SDWLOPT),SDWLOPT,SDWLPS=3 S X="Y" G ENO
 I SDWLPS=1 S DIR(0)="FOA^^" S DIR("A")="Select Wait List (1-"_SDWLCN_") or '^' to Quit ? ",DIR("?")="Enter a Valid Number or '^' to Quit."
 I SDWLPS=2 S DIR(0)="FOA^^" S DIR("A")="Select Wait List (1) or '^' to Quit ? ",DIR("?")="Enter a '1' or '^' to Quit."
 I SDWLPS=3 S DIR(0)="YAO^^S X=""Y""" S DIR("A")="No closed EWL entries for this range of dates. Do you wish to continue with this patient? Yes// "
 W ! D ^DIR W ! K DIR
 G END:$D(DUOUT),END:$D(DTOUT)
 I SDWLPS=1 D  G END:SDWLERR=1 I SDWLERR=2 W *7," ??" G EN1
 .S SDWLERR=$S(X="":2,X["^":1,$D(^TMP("SDWLD",$J,DFN,+X)):0,1:2) Q
 I SDWLPS=2 D  G END:SDWLERR=1 I SDWLERR=2 W *7," ??" G EN1
 .S SDWLERR=$S(X="":2,$D(DUOUT):1,X["^":1,$D(^TMP("SDWLD",$J,DFN,+X)):0,1:2) Q
ENO I SDWLPS=3 D  G EN:SDWLERR=1 I SDWLERR=2 G EN1
 .S SDWLERR=$S(X="":2,X?1"Y".E:2,X?1"y".E:2,$D(DUOUT):1,X["^":1,1:1)
 .I SDWLERR=1 K DFN Q
 N SDCAN I SDWLPS=1!(SDWLPS=2),X?1N.N D
 .N DA
 .S (DA,SDWLDA)=$P($G(^TMP("SDWLD",$J,DFN,+X)),"~",2),SDWLEDIT=""
 .;
 .;LOCK DATA FILE
 .;
 .L +^SDWL(409.3,SDWLDA):5 I '$T W !,"ANOTHER TERMINAL IS EDITING THIS ENTRY. TRY LATER." S DUOUT=1
 .I $D(DUOUT) Q
 .D EN^SDWLE10
 .D EDITC(SDWLDA,.SDCAN) L -^SDWL(409.3,SDWLDA) S SDWLERR=1 K SDWLEDIT
 .I SDCAN W !,"This process has been canceled."
 .E  W !,"The requested entry has been opened."
 D END
 Q
END ;
 D EN^SDWLKIL
 Q 
 ;
 ;
PAT ;SELECT PATIENT
 N DIC
 S DIC(0)="EMNZAQ",DIC=2 D ^DIC S (SDWLDFN,DFN)=$P(Y,U,1) G PAT1:DFN<0
 S X=$$GET1^DIQ(2,DFN_",",".351") I X'="" W !,*7,"PATIENT'S DATE OF DEATH HAS BEEN RECORDED" G PAT
 S SDWLSSN=$G(VA("PID")),SDWLNAM=$G(VA(1))
PAT1 K VADM,VAIN,VAERR,VA Q
 ;
DIS ;DISPLAY DATA FOR PATIENT
 ;
 S SDWLHDR="Wait List OPEN CLOSED ENTRY"
 D EN^SDWLD(DFN,VA("PID"),VADM(1),"C")
 D PCM^SDWLE1,PCMD^SDWLE1
 Q
 ;
EDITC(SDWLDA,SDCAN) ;edit closed entry
 N DA,DIE,DIR,DR,SDWLCM,Y
 W !,"Reopen comment required to open this entry. Reopen reason: O - Other.",!
 ; Reopen Comment
 S Y=0,SDCAN=0
 F  Q:$L(Y)>10!(Y="^")  S DIR(0)="FAOU^^",DIR("A")="Comments or '^' to cancel this process: ",DIR("B")="" D ^DIR D
 .I $L(Y)<11 W !,"At least 10 char comment required" Q
 .I X="^" Q
 I Y="^" S SDCAN=1 Q
 S SDWLCM=$E(Y,1,70)
 S DIE="^SDWL(409.3,",DA=SDWLDA,DR="23////^S X=""O""" D ^DIE
 S DR="28///^S X=$G(DUZ);29////^S X=""O""" D ^DIE ; REOPEN REASON - OTHER
 S DR="19///@;20///@;21///@;30///^S X=SDWLCM" D ^DIE
 S DR="13///@;13.1////@;13.2///@;13.3///@;13.4///@;13.5///@;13.6///@;13.8///@;13.7///@" D ^DIE ;SD/467
 Q
SB1 S X=$$GET1^DIQ(2,DFN_",",".351") I X'="" S DUOUT=""
 Q
HD W:$D(IOF) @IOF W !,?80-$L("Scheduling/PCMM Open Closed Wait Entry")\2,"Scheduling/PCMM Open Closed Wait List Entry",!!
 I $D(DFN),DFN'="",'$D(^SDWL(409.3,"B",DFN)),$D(SDWLLIST),SDWLLIST D
 .W !!,"PATIENT: ",VADM(1),?40,VA("PID")
 Q
