MPIFCMRP ;BPCIO/CMC-PUSHING CMOR TO ANOTHER SITE ;NOV 15, 2000
 ;;1.0; MASTER PATIENT INDEX VISTA ;**11,21,30,32**;30 Apr 99
 ;
 ; Integration Agreements Utilized:
 ;
 ; ^DGCN(391.91   IA #2751
 ;
 ;Entry point for option: PUSH CMOR REQUEST - create a new request
 ; to change CMOR when your site is the CMOR.
 ; No input or output variables.
 ;
 ;Only if the site is the CMOR can this option be used
 ; note: code here is very similar to MPIFEDIT
NEW ;
 N DIC,X,Y,DTOUT,DUOUT,PAT
 S DIC="^DPT(",DIC(0)="QEAMZ",DIC("A")="Select PATIENT: "
 D ^DIC
 Q:$D(DTOUT)!$D(DUOUT)!(Y=-1)
 S PAT=+Y
 D LM(PAT)
 Q
LM(PAT) ; list manager entry point to push a change of CMOR with PAT set to the DFN
 I +$$GETICN^MPIF001(PAT)<0 W !,"Patient doesn't have ICN, try again" G NEW
 I $E($$GETICN^MPIF001(PAT),1,3)=$P($$SITE^VASITE(),"^",3) W !,"Patient has a Local ICN, try again" G NEW
 I $$GETVCCI^MPIF001(PAT)<0 W !,"Patient doesn't have a CMOR, try again" G NEW
 I $$GETVCCI^MPIF001(PAT)'=$P($$SITE^VASITE(),"^",3) W !,"You are NOT the CMOR, to request to be the CMOR, use option: Create a New CMOR Change Request" G NEW
 N TMP,TCNT
 S TMP=$O(^DGCN(391.91,"APAT",PAT,"")) I $O(^DGCN(391.91,"APAT",PAT,TMP))="" W !,"Patient isn't SHARED - CAN'T change CMOR" Q
 ;Pt is shared, but are they shared with another VAMC?
 S TMP="",TCNT=0 F  S TMP=$O(^DGCN(391.91,"APAT",PAT,TMP)) Q:TMP=""  D
 .;I $$GET1^DIQ(4,TMP_",",13)'="VAMC" Q
 .N TP S TP=$$GET1^DIQ(4,TMP_",",13)
 .Q:TP'="VAMC"&(TP'="OC")&(TP'="M&ROC")&(TP'="RO-OC")
 .; ^ only valid types of TFs that can be a CMOR 
 .S TCNT=TCNT+1
 I TCNT<2 W !,"Patient isn't SHARED with another VAMC - CAN'T change CMOR" Q
 ; CHECK IF ALREADY OPEN/PENDING REQUEST
 N ENT,STOP,MPIFNM,REQNM
 S ENT=0,STOP=0 F  S ENT=$O(^MPIF(984.9,"C",PAT,ENT)) Q:ENT=""!(STOP)  D
 .I $P($G(^MPIF(984.9,ENT,0)),"^",6)<4 S STOP=1
 I STOP W !!,"Already have request for this patient" G NEW
 N N0,PHONE,DA,DIE,DR,DIR,ERROR,DIK,Y,DIRUT,REQ,TDA,PERS
 S DA=$$ADD^MPIFNEW(),TDA=DA,PHONE=""
 S DIE="^MPIF(984.9,",DR=".04///`"_PAT D ^DIE
 S REQ=$P($G(^MPIF(984.9,DA,0)),"^")
 W !,"REQUEST NUMBER:",REQ
EDIT I $D(DUZ) D
 .S PHONE=$P($G(^MPIF(984.9,+$O(^MPIF(984.9,"AD",DUZ,""),-1),0)),"^",5)
 .N DA,DIC,DIQ S DIQ="MPIFNM",DR=".01;.132",DIQ(0)="E",DIC="^VA(200,",DA=DUZ
 .D EN^DIQ1
 .S REQNM=MPIFNM(200,DUZ,.01,"E")
 I '$D(DUZ) S (PHONE,REQNM)=""
 ;
REASON S DIR("A")="Reason for Request",DIR("?")="Answer must be 3-60 characters in length.",DIR(0)="F^3:60" D ^DIR
 I Y="" W !,"Answer must be 3-60 characters in length." G REASON
 I X="^" S DIK="^MPIF(984.9," D ^DIK W "... Request deleted" Q
 S DIE="^MPIF(984.9,",DR="1.02///"_X D ^DIE
REQNM S DIR("A")="Requestor's Name",DIR("B")=REQNM,DIR("?")="Answer must be a valid user",DIR(0)="P^200:EQZ" D ^DIR K DIR("B")
 I Y="" W !,"Must pick valid user" G REQNM
 I X="^" S DIK="^MPIF(984.9," D ^DIK W "... Request deleted" Q
 S PERS=+Y
 S DIE="^MPIF(984.9,",DR=".02///`"_+Y D ^DIE
PHONE S DIR("A")="Requestor's Phone",DIR("B")=PHONE,DIR("?")="Answer must be 4-20 charaters in length.",DIR(0)="F" D ^DIR K DIR("B")
 I Y="" W !,"Answer must be 4-20 charaters in length."  G PHONE
 I X="^" S DIK="^MPIF(984.9," D ^DIK W "... Request deleted" Q
 S DIE="^MPIF(984.9,",DR=".05///"_X D ^DIE
 ;
CMOR S DIC("A")="Select Site to Be CMOR: ",DIC="^DIC(4,",DIC(0)="QEAM"
 S DIC("S")="I $D(^DGCN(391.91,""APAT"",PAT,Y)) I +$$SITE^VASITE'=+Y N TYPE S TYPE=$$GET1^DIQ(4,+Y_"","",13) I TYPE=""VAMC""!(TYPE=""RO-OC"")!(TYPE=""OC"")!(TYPE=""M&ROC"")"
 D ^DIC
 I X="^" S DIK="^MPIF(984.9," D ^DIK W "... Request deleted" Q
 N TSITE S TSITE=+Y
 S DIE="^MPIF(984.9,",DR=".07///`"_TSITE_";1.03///3;.09///`"_TSITE D ^DIE
 ;update site, type of action and cmor after approval
 ;
 I $$CHK^MPIFEDIT(DA) W !,"This request is missing required data." G EDIT
 ;
APP S DIR("A")="Select Request Action (SEND/EDIT/DELETE)? ",DIR("B")="SEND",DIR(0)="SAO^SEND:SEND;EDIT:EDIT;DELETE:DELETE"
 D ^DIR K DIR
 S DA=TDA
 I $E(Y)="D"!$D(DIRUT) D  Q
 .S DIK="^MPIF(984.9," D ^DIK W "... Request deleted"
 .Q
 I $E(Y)="E" G REASON
 S DR=".08////^S X=2;.06////^S X=2",DIE="^MPIF(984.9," D ^DIE W !,"... Request will be sent"
 ; removed event queue due to delivery issues - this msg must be sent first followed by the actual change cmor msg.
 N ERR,MPIFHL7 S ERR="ERRS",MPIFHL7=""
 D EN^MPIFREQ("CMOR CHANGE REQUEST",DA,.ERR,MPIFHL7)
 ;
 ;NOW CHANGE CMOR AND SEND CHANGE CMOR MESSAGE
 N TEXT,DIR,DR,CMOR,TMP,ERROR
 S TEXT="Auto change - pushed CMOR",ERROR=0
 S DIE="^MPIF(984.9,",DA=TDA,DR=".06///^S X=4;3.01///^S X=TEXT"
 D ^DIE
 S CMOR=$P($G(^MPIF(984.9,TDA,0)),"^",7)
 I CMOR="" D  Q
 .W !,"New CMOR Not Defined, edit request"
 .S ^DIE="^MPIF(984.9,",DA=TDA,DR=".06///^S X=1" D ^DIE
 S TMP=$$CHANGE^MPIF001(PAT,CMOR)
 I +TMP<0 S ^DIE="^MPIF(984.9,",DA=TDA,DR=".06///^S X=1" D ^DIE Q
 D BROAD^MPIFCMOR(DA,.ERROR)
 Q
