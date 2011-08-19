SDWLE111 ;;IOFO BAY PINES/TEH - WAITING LIST-ENTER/EDIT - WAIT LIST TYPE/INSTUTITION;20 Aug 2002
 ;;5.3;scheduling;**263,273,280,394,417,485**;AUG 13 1993;Build 2
 ;
 ;
 ;
 ;******************************************************************
 ;                         CHANGE LOG
 ;                                         
 ;   DATE                      PATCH              DESCRIPTION
 ;   ----                      -----              -----------
 ;10/01/2002                                     263        Logical Order Change   
 ;12/02/2002                 273           line EN2+19 add '/' 
 ;12/10/2004                                     SD*5.3*394     Add Service Connection prompts   
 ;01/11/2005                 417           Permit MultiplePanels      
 ;02/16/2005                 417           New logic for WAIT LIST TYPE Prompt. See Table in Release Notes.
 ;
 ;ASK WAIT LIST TYPE
 ;
EN ;
 N SDWLPRP S (SDWLFLG,SDWLPRP)=0
 D GETTM
 I 'SDWLTEM S SDWLPRP=1
 I SDWLTEM,'SDWLPOS S SDWLPRP=0
 I $D(SDWLTY) W !,"Wait List Type: ",$$EXTERNAL^DILFD(409.3,4,,SDWLTY) W "//  (No Editing)" S SDWLTYE=SDWLTY G EN10
 ;10/01/2002 - TEH
EN0 ;
 I 'SDWLPRP D
 .S DIR(0)="SO^1:PCMM TEAM ASSIGNMENT;2:PCMM POSITION ASSIGNMENT;3:SERVICE/SPECIALTY;4:SPECIFIC CLINIC"
 .S DIR("L",1)="     Select Wait List Type: "
 .S DIR("L",2)=""
 .S DIR("L",3)="   1. PCMM TEAM ASSIGNMENT"
 .S DIR("L",4)="   2. PCMM POSITION ASSIGNMENT"
 .S DIR("L",5)="   3. SERVICE/SPECIALTY"
 .S DIR("L")="   4. SPECIFIC CLINIC"
 .S SDWLFLG=1
 G EN9:SDWLFLG
EN1 I SDWLPRP D
 .S DIR(0)="SO^1:PCMM TEAM ASSIGNMENT;2:SERVICE/SPECIALTY;3:SPECIFIC CLINIC"
 .S DIR("L",1)="     Select Wait List Type: "
 .S DIR("L",2)=""
 .S DIR("L",3)="   1. PCMM TEAM ASSIGNMENT"
 .S DIR("L",4)="   2. SERVICE/SPECIALTY"
 .S DIR("L")="   3. SPECIFIC CLINIC"
 .S SDWLFLG=0
EN9 D ^DIR I X="" W " Required or '^' to Quit" G EN
 I $D(DUOUT) S SDWLERR=1 G END
 S SDWLTYE=+Y I 'SDWLFLG D
 .S SDWLTYE=$S(+Y=1:1,+Y=2:3,+Y=3:4,1:0)
 I 'SDWLTYE W "  Invalid Entry." G EN
 S DIE="^SDWL(409.3,",DR="4///^S X=SDWLTYE" D ^DIE
 ;
EN10 ;SERVICE CONNECTION - SD*5.3*394
 ;
 D ^SDWLSC
 ;
 ;ASK INSTITUTION (FILE 4)
 ;
 I SDWLTYE=2,$D(SDWLCPT),SDWLCPT S (SDWLINE,SDWLIN)=$P($G(^SCTM(404.51,+SDWLCPT,0)),U,7) G END
 I SDWLTYE=2 S SDWLI=0 F  S SDWLI=$O(^SCTM(404.57,SDWLI)) Q:SDWLI<1  D  G END
 .S SDWLL=+$P($G(^SCTM(404.57,SDWLI,0)),U,2),SDWLINL=+$P($G(^SCTM(404.51,+SDWLL,0)),U,7),SDWLINL(+SDWLINL)=""
 K DUOUT S SDWLERR=0 W !
 I $D(SDWLIN) D
 .S X=$S($D(SDWLIN):$$EXTERNAL^DILFD(409.32,.02,,SDWLIN),1:""),SDWLINE=SDWLIN D
 ..W !,"Select Institution: ",X," //  (No Editing)" S SDWLERR=1
 I SDWLERR S SDWLERR=0 G END
 I SDWLTYE=1 S DIC("S")="I $D(^SCTM(404.51,""AINST"",+Y))"
 I SDWLTYE=2 S DIC("S")="I $D(SDWLINL(+Y))"
 I SDWLTYE=4 S DIC("S")="I $D(^SDWL(409.32,""ACT"",+Y))"
 I SDWLTYE=3 S DIC("S")="I $D(^SDWL(409.31,""E"",+Y))"
 S DIC("S")=DIC("S")_",$$GET1^DIQ(4,+Y_"","",11,""I"")=""N"",$$TF^XUAF4(+Y)"
 S DIC(0)="AEQNM",DIC="4",DIC("A")="Select Institution: " D ^DIC I Y<0,'$D(DUOUT) S SDWLERR=1 W "Required or '^' to Quit."
 I $D(DUOUT) S SDWLERR=1 Q
 G EN10:SDWLERR
 I Y>0 D 
 .K DIC,DIC("A"),DIC("S"),DIC(0),DIC("B") S (SDWLIN,SDWLINE)=+Y,DIE="^SDWL(409.3,"
 .I '$D(DUOUT),Y>0 S DR="2////^S X=SDWLIN",DIE="^SDWL(409.3,",DA=SDWLDA D ^DIE
 I $D(DUOUT) S SDWLERR=1
END Q
 ;
 ;
GETTM ;CHECK WAIT LIST FOR TEAM ASSIGNMENT.
 Q:SDWLTEM  Q:'$D(SDWLDFN)  N SDWLDA1,SDWLX
 S SDWLDA1=0 F  S SDWLDA1=$O(^SDWL(409.3,"B",SDWLDFN,SDWLDA1)) Q:SDWLDA1<1  D
 .S SDWLX=$G(^SDWL(409.3,SDWLDA1,0)) I $P(SDWLX,U,17)="O",$P(SDWLX,U,6) S SDWLTEM=1
 K SDWLDA1
