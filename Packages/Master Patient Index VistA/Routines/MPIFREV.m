MPIFREV ;BHM/RGY-Review CMOR request ;FEB 26, 1998
 ;;1.0; MASTER PATIENT INDEX VISTA ;**6,11**;30 Apr 99
 ;
 ; Integration Agreements Utilized:
 ;
 ;   EXC^RGHLLOG     IA #2796
 ;   START^RGHLLOG   IA #2796
 ;   STOP^RGHLLOG    IA #2796
 ;
EN ;
 ; Entry point for option MPIF REVIEW REQUEST.  This option allows the
 ; user to review CMOR Change requests and approve or deny them
 ; No input or output variables.
 N DIC
ASK S DIC="^MPIF(984.9,",DIC("A")="Select CMOR request to review: "
 S DIC(0)="QEAM",DIC("S")="I $D(^MPIF(984.9,""AC"",3,Y))"
 D ^DIC Q:+Y<0
 D EN1(+Y)
 G ASK
EN1(REQ,MSTOP) ;Review a CMOR request
 N DFN,PHONE,RESULT,RES1,DIE,DA,DR,ENT,DIC,FR,BY,TO,FLDS,L,DIR,DUTOUT,X,Y,ERR,ER
 S MSTOP=0,ER=0
 I $P($G(^MPIF(984.9,+REQ,0)),"^",6)'=3 W !,"*** Request is not pending review ***" Q
 N PAT S PAT=$P($G(^MPIF(984.9,+REQ,0)),"^",4)
 ;checking for other requests pending for this patient
 K ARRAY
 D OTHERS^MPIFAREQ(PAT,+REQ,.ARRAY)
 I $G(ARRAY(0))'=0 W !!!,"**** There are other PENDING Requests for this patient.  If you approve one the rest will automatically be disapproved. ***" H 5
 S L=0,ENT=+REQ,DIC="^MPIF(984.9,",FR=+REQ,TO=+REQ,BY="@NUMBER",FLDS="[MPIF REQUEST VIEW]",IOP="HOME" D EN1^DIP
APP S DIR("A")="Select Review Action ("_$S($P(^MPIF(984.9,+REQ,0),"^",4)]"":"APPROVE/",1:"")_"DISAPPROVE, OR '^' to Exit)? "
 S DIR(0)="SAO^"_$S($P(^MPIF(984.9,+REQ,0),"^",4)]"":"A:APPROVE;",1:"")_"D:DISAPPROVE"
 N DIRUT,DTOUT
 D ^DIR K DIR
 I $D(DIRUT) S:X="^"!$D(DTOUT) MSTOP=1 W " ... No Action!" Q
 S (RESULT,RES1)=Y
 S PHONE=$P($G(^MPIF(984.9,+$O(^MPIF(984.9,"AE",DUZ,""),-1),2)),"^",3)
 S DIE="^MPIF(984.9,",DR="[MPIF REVIEW RESULT]",DA=+REQ D ^DIE
 I $D(Y)!$D(DTOUT) S:$D(DTOUT) MSTOP=1 S DIE="^MPIF(984.9,",DR="[MPIF REVIEW RESET]",DA=+REQ D ^DIE W " ... No Action!" Q
 W !!," Processing.....",!
 S DFN=$P($G(^MPIF(984.9,+REQ,0)),"^",4)
 I $E(RESULT)="A" D
 .S ERR=$$CHANGE^MPIF001(DFN,+$P($G(^MPIF(984.9,+REQ,0)),"^",7))
 .;log exception if problem with updating CMOR
 .I +ERR<0 D  Q
 ..D START^RGHLLOG()
 ..D EXC^RGHLLOG(220,"Unable to change CMOR for Change CMOR Request for patient DFN= "_DFN_" Request # "_+REQ,DFN)
 ..D STOP^RGHLLOG(),RESET2^MPIFREQ(+REQ)
 ..W !!,"  Problem Changing CMOR, resetting status to pending approval.  May be duplicates in Institution file for new CMOR or Patient file entry was already being edited.",!!
 .I +ERR>0 D BROAD^MPIFCMOR(+REQ,.ER)
 I +ER=0 D EN^MPIFRESS(+REQ)
 I +ER=-1 W !!," Problem during Broadcast - "_$P(ER,"^",2) Q
 N ENT
 I ARRAY(0)'=0&($E(RES1)="A") D
 .S ENT=0
 .W !,"Have others to Disapprove -- automatically"
 .F  S ENT=$O(ARRAY(ENT)) Q:ENT=""  D AUTODIS^MPIFAREQ(ARRAY(ENT))
 W !!," ... Done!",!!
 Q
 ;
BATCH ;Approve in batch mode
 NEW CSITE,DIR,DIRUT,IOP,MSTOP,IEN,PIEN
 I $O(^MPIF(984.9,"AC",3,0))="" W !!,"*** No request to approve ***",! Q
 S MSTOP=0,CSITE=0
 S DIR("A")="Do you want to approve by SITE",DIR(0)="Y"
 D ^DIR K DIR
 Q:$D(DIRUT)
 S IEN=0,PIEN=0
 W !
 I Y=0 D  Q
 .F  S IEN=$O(^MPIF(984.9,"AC",3,IEN)) Q:'IEN  S IOP=ION D EN1(IEN,.MSTOP) Q:MSTOP
 .Q
SITE S DIC("A")="Select Site: ",DIC="^DIC(4,",DIC(0)="QEAM",DIC("S")="I $D(^MPIF(984.9,""AS"",Y,3))" D ^DIC Q:Y<0  S CSITE=+Y
 I $O(^MPIF(984.9,"AS",CSITE,3,0))="" W !!,"*** No requests to approve for this site ***",! G SITE
 W !
 S MSTOP=0
 F  S PIEN=$O(^MPIF(984.9,"AS",CSITE,3,PIEN)) Q:'PIEN  D
 .S IOP=ION
 .D EN1(PIEN,.MSTOP)
 .Q:MSTOP=1
 Q
