SDWLE4 ;;IOFO BAY PINES/TEH - WAITING LIST-ENTER/EDIT;06/12/2002 ; 20 Aug 2002  2:10 PM  ; Compiled May 1, 2007 15:18:53
 ;;5.3;scheduling;**263,446**;AUG 13 1993;Build 77
 ;
 ;
 ;******************************************************************
 ;                             CHANGE LOG
 ;                                               
 ;   DATE                        PATCH                   DESCRIPTION
 ;   ----                        -----                   -----------  
 ;   
 ;CLINIC (409.32)
 ;
EN K DIR,DIC,DIE,DR
 I $D(SDWLSC) S X=$$EXTERNAL^DILFD(409.3,8,,SDWLSC),DIC("B")=$S($D(SDWLSC):X,1:"") I DIC("B")="" K DIC("B")
 I $D(^SDWL(409.3,SDWLDA,0)),$P(^(0),U,9) S DIC("B")=$$EXTERNAL^DILFD(409.3,8,,$P(^(0),U,9))
 S SDWLERR=0
 K X,Y
 S DIC(0)="QEMNZA",DIC("A")="Select Clinic: ",DIC("S")="I $P(^SDWL(409.32,+Y,0),U,6)=SDWLINE,'$P(^(0),U,4),$P(^(0),U,2)'=""""",DIC=409.32 D ^DIC
 I X="^" S DUOUT=1 G END
 I X="" W *7," Required" G EN
 I Y<0 S DUOUT=1 G END
 I $D(DTOUT) S DUOUT=1
 I $D(SDWLSC),Y<0 G END
 I Y<0 W " Required or ""^"" to Quit" G EN
EN1 S SDWLSC=+Y
 ;disply already created appointments
 N SDCL S SDCL=$$GET1^DIQ(409.32,SDWLSC,.01,"I") ; get pointer to 44
 N SDD,SDSP,SDORG S SDSP="",SDORG=DT S SDD=$$CHKENC^SDWLQSC1(DFN,SDORG,SDCL,SDSP,1)
 I SDD D APPTDIS N DIR,Y D  I Y["^"!'Y S DUOUT=1 Q
 .W !!,"This patient already has scheduled appointments which may match",!,"the Wait List Entry."
 .S DIR(0)="Y^A0",DIR("B")="NO",DIR("A")="Are you sure you want to continue"
 .D ^DIR
 Q:$G(DUOUT)  S DA=SDWLDA,DIE="^SDWL(409.3,",DR="8////^S X=SDWLSC" D ^DIE
 K DIR,DIC,DIE,DR
END Q
APPTDIS ;display already created appt/encounters
 ;from ^TMP($J,"APPT")
 N STR,SCNT
 Q:'$D(^TMP($J,"APPT"))
 S SCNT="" F  S SCNT=$O(^TMP($J,"APPT",SCNT)) Q:SCNT=""  D
 .S STR=^TMP($J,"APPT",SCNT)
 .N ZZ F ZZ=2,3,4,15 S SDD(ZZ)=$P($P(STR,"^",ZZ),";",2)
 .N SD S SD=$P(STR,U) D  S Y=SD D D^DIQ S SDD(1)=Y ; date conv
 ..I SDD(3)="SCHEDULED/KEPT" S SDD(3)=$S(SD<DT:"KEPT",1:"SCHEDULED")
 .;DISPLAY
 .I SCNT=1 D DPH(SCNT,.SDD)
 .D DPHD(SCNT,.SDD)
 Q
DPH(SCNT,SDD) ;display appt header
 W !!,"Appointment(s) for: "_SDD(4)
 W !?3,"Appt Date/Time",?23,"Clinic",?48,"Status",?60,"Institution",! N SDL S $P(SDL,"-",79)="" W SDL,!
 Q
DPHD(SCNT,SDD) ;
 W !,SCNT,?3,SDD(1),?23,$E(SDD(2),1,23),?48,$E(SDD(3),1,10),?60,SDD(15)
 Q 
