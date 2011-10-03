SDWLE2 ;;IOFO BAY PINES/TEH - WAITING LIST-ENTER/EDIT;06/12/2002 ; 20 Aug 2002  2:10 PM  ; Compiled May 25, 2007 16:37:21
 ;;5.3;scheduling;**263,397,424,446**;AUG 13 1993;Build 77
 ;
 ;
 ;******************************************************************
 ;                             CHANGE LOG
 ;                                               
 ;   DATE                        PATCH                   DESCRIPTION
 ;   ----                        -----                   -----------
 ;   06/06/06                    SD*5.3*446              Allow selection of a clinic after specialty is entered
 ;   
 ;   
 ;      
 ;Service/Specialty sub-routine
 ;
EN ;
 N SDWLSSX  ; sd/446
 K DIR,DIC,DR I $D(SDWLSS) S X=$$EXTERNAL^DILFD(409.3,7,,SDWLSS)
 S SDWLERR=0 I $D(SDWLSS) S DIC("B")=$S($D(SDWLSS):X,1:"") I DIC("B")="" K DIC("B")
 S DIC(0)="AEQ",DIC=409.31,DIC("A")="Select Service/Specialty: "
 S DIC("S")="I $D(^SDWL(409.31,""E"",SDWLINE,+Y)),$D(^SDWL(409.31,+Y,""I"")),$P(^SDWL(409.31,+Y,""I"",($O(^SDWL(409.31,+Y,""I"",""B"",SDWLINE,""""))),0),U,4)=""""" D ^DIC
 I X["^" S DUOUT=1 G END
 I Y<0 W *7," Required" G EN
 S SDWLSSX=+Y  ; sd/446
 N SDSP S SDSP=$$GET1^DIQ(409.31,SDWLSSX,.01,"I") ; get pointer to 40.7
 N SDD,SDCL,SDORG S SDCL="",SDORG=DT S SDD=$$CHKENC^SDWLQSC1(DFN,SDORG,SDCL,SDSP,1)
 I SDD D APPTDIS N DIR,Y D  I Y["^"!'Y S DUOUT=1 Q
 .W !!,"This patient already has scheduled appointments which may match",!,"the Wait List Entry."
 .S DIR(0)="Y^A0",DIR("B")="NO",DIR("A")="Are you sure you want to continue"
 .D ^DIR
 ;
 I '$$CLIN() Q:$G(DUOUT)  S DIE="^SDWL(409.3,",DR="7////^S X=SDWLSSX" D ^DIE  ; sd/446
 K DIR,DIC,DIE,DR,Y,DUOUT
END Q
APPTDIS ;display already created appt/encounters
 ;from ^TMP($J,"APPT")
 N STR,SCNT
 Q:'$D(^TMP($J,"APPT"))
 S SCNT="" F  S SCNT=$O(^TMP($J,"APPT",SCNT)) Q:SCNT=""  D
 .S STR=^TMP($J,"APPT",SCNT)
 .N ZZ F ZZ=2,3,4,10,15 S SDD(ZZ)=$P($P(STR,"^",ZZ),";",2)
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
 W !,SCNT,?3,SDD(1),?23,$E(SDD(2),1,23),?48,$E(SDD(10),1,10),?60,SDD(15)
 Q
 ;
CLIN() ; sd/446
 N DA,DIC,DIE,DIK,DR,SDWLCL,SDWLEST,X,Y
 S DIC=409.32,DIC(0)="AEQ",DIC("A")="WL SPECIFIC CLINIC related to this SPECIALTY (optional): ",DIC("S")="I $$VAL^SDWLE2(+Y)"
 D ^DIC
 I X["^" S DUOUT=1 Q 0
 Q:X="" 0
 S SDWLCL=+Y
 ; Need to delete the old entry and create anew to change the wait list type
 S SDWLEST=$$GET1^DIQ(409.3,SDWLDA,27,"I")
 S DIK="^SDWL(409.3,",DA=SDWLDA
 D ^DIK
 S DIC(0)="LX",X=SDWLDFN,DIC="^SDWL(409.3," D FILE^DICN
 L:DA'=SDWLDA +^SDWL(409.3,DA),-^SDWL(409.3,SDWLDA)
 S SDWLDA=DA
 S DIE="^SDWL(409.3,",DR="1////^S X=DT;2////^S X=SDWLINE;4////^S X=4;8////^S X=SDWLCL;9////^S X=DUZ;27////^S X=SDWLEST"
 S:$G(SDWLACA) DR=DR_";33////^S X=""Y"""  ; 446
 D ^DIE
 Q 1
VAL(Y) ; sd/446
 N TMP
 D GETS^DIQ(409.32,Y,".01;.02;2;4","I","TMP")
 Q:TMP(409.32,Y_",",.02,"I")'=SDWLINE 0  ; Wrong institution
 Q:TMP(409.32,Y_",",2,"I")="" 0  ; No activation date entered
 Q:TMP(409.32,Y_",",4,"I")'="" 0  ; Inactivation date entered
 Q $$GET1^DIQ(44,TMP(409.32,Y_",",.01,"I"),8,"I")=$$GET1^DIQ(409.31,SDWLSSX,.01,"I")  ; Does the clinic have the right stop code?
