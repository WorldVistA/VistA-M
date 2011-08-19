MPIFEDIT ;BHM/RGY-Request a CMOR for patient ;FEB 20, 1998
 ;;1.0; MASTER PATIENT INDEX VISTA ;**11,22,30,34**;30 Apr 99
 ;
 ; Integration Agreements Utilized:
 ;
 ;   EXC^RGHLLOG     IA #2796
 ;   START^RGHLLOG   IA #2796
 ;   STOP^RGHLLOG    IA #2796
 ;   $$EN^VAFCPID    IA #3015
 ;
NEW ;
 ;Entry point for option: MPIF NEW REQUEST - create a new request
 ; to change CMOR.  No input or output variables.
 ;
 ;Only if the site is not the CMOR can this option be used
 N DIC,X,Y,DTOUT,DUOUT,PAT
 S DIC="^DPT(",DIC(0)="QEAMZ",DIC("A")="Select PATIENT: "
 D ^DIC
 Q:$D(DTOUT)!$D(DUOUT)!(Y=-1)
 S PAT=+Y
 I +$$GETICN^MPIF001(PAT)<0 W !!,"Patient doesn't have ICN, try again" G NEW
 I $$GETVCCI^MPIF001(PAT)<0 W !!,"Patient doesn't have a CMOR, try again" G NEW
 I $$GETVCCI^MPIF001(PAT)=$P($$SITE^VASITE(),"^",3) W !!,"You are the CMOR, to push the CMOR to another site use option: PUSH CMOR REQUEST" G NEW
 ; CHECK IF ALREADY OPEN/PENDING REQUEST
 N ENT,STOP
 S ENT=0,STOP=0 F  S ENT=$O(^MPIF(984.9,"C",PAT,ENT)) Q:ENT=""!(STOP)  D
 .I $P($G(^MPIF(984.9,ENT,0)),"^",6)<4 S STOP=1
 I STOP W !!,"Already have request for this patient" G NEW
 ;
 N N0,PHONE,DA,DIE,DR,DIR,ERROR,DIK,Y,DIRUT,REQ,CMOR,MPIFREQ,CMORI
 S DA=$$ADD^MPIFNEW()
 S DIE="^MPIF(984.9,",DR=".04///`"_PAT D ^DIE
 S REQ=$P($G(^MPIF(984.9,DA,0)),"^")
 W !,"REQUEST NUMBER:",REQ
 S CMOR=$$HL7CMOR^MPIF001($P($G(^MPIF(984.9,DA,0)),"^",4),"^")
 ;station # ^ Station Name
 S CMORI=$$IEN^XUAF4($P(CMOR,"^"))
 W !,"*** Current CMOR: "_$P(CMOR,"^",2)_" ("_$P(CMOR,"^")_") ***"
 S DIE="^MPIF(984.9,",DR=".07///`"_CMORI_";1.03///1;.09///`"_+$$SITE^VASITE() D ^DIE
 ; ^ update site, type of action, and cmor after approval
 ;
 S REQ=DA
EDIT I $D(DUZ) D
 .S PHONE=$P($G(^MPIF(984.9,+$O(^MPIF(984.9,"AD",DUZ,""),-1),0)),"^",5)
 .N DA,DIC,DIQ S DIQ="MPIFREQ",DR=".01",DIQ(0)="E",DIC="^VA(200,",DA=DUZ
 .D EN^DIQ1
 .S MPIFREQ=MPIFREQ(200,DUZ,.01,"E")
 I '$D(DUZ) S (MPIFREQ,PHONE)=""
 ;
REASON S DIR("A")="Reason for Request",DIR("?")="Answer must be 3-60 characters in length.",DIR(0)="F^3:60" D ^DIR
 I Y="" W !,"Answer must be 3-60 characters in length." G REASON
 I Y="^" S DIK="^MPIF(984.9," D ^DIK W "... Request deleted" Q
 S DIE="^MPIF(984.9,",DR="1.02///"_X D ^DIE
REQNM S DIR("A")="Requestor's Name:",DIR("B")=MPIFREQ,DIR("?")="Answer must be a valid user",DIR(0)="P^200:EQZ" D ^DIR K DIR("B")
 I Y="" W !,"Must pick valid user" G REQNM
 I Y="^" S DIK="^MPIF(984.9," D ^DIK W "... Request deleted" Q
 S DIE="^MPIF(984.9,",DR=".02///`"_+Y D ^DIE
PHONE S DIR("A")="Requestor Phone:",DIR("B")=PHONE,DIR("?")="Answer must be 4-20 charaters in length.",DIR(0)="F" D ^DIR K DIR("B")
 I Y="" W !,"Answer must be 4-20 charaters in length."  G PHONE
 I Y="^" S DIK="^MPIF(984.9," D ^DIK W "... Request deleted" Q
 S DIE="^MPIF(984.9,",DR=".05///"_X D ^DIE
 I $$CHK^MPIFEDIT(DA) W !,"This request is missing required data." G EDIT
 ;
APP S DIR("A")="Select Request Action (SEND/EDIT/DELETE)? ",DIR("B")="SEND",DIR(0)="SAO^SEND:SEND;EDIT:EDIT;DELETE:DELETE"
 D ^DIR K DIR
 I $E(Y)="D"!$D(DIRUT) D  Q
 .S DIK="^MPIF(984.9," D ^DIK W "... Request deleted"
 .Q
 I $E(Y)="E" G REASON
 S DR=".08////^S X=2;.06////^S X=2",DIE="^MPIF(984.9," D ^DIE W !,"... Request will be sent"
 ;
 I '$D(REQ) S REQ=DA
 S N0=$G(^MPIF(984.9,REQ,0)),CNT=0
 I N0="" S ERROR="Node for request #"_REQ_" is not defined" Q
 S INST=$P($$SITE^VASITE(),"^",3)
 N X,Y,DIC
 S DIC="^VA(200,",DIC(0)="MZO",X="`"_+$P(N0,"^",2)
 D ^DIC
 I $G(Y)<1 S USER=""
 I $G(Y)>0 S USER=$G(Y(0,0))
 S REASON=$P($G(^MPIF(984.9,REQ,1)),"^",2)
 S NDATE=$P(N0,"^",3)
 S ICN=$$ICN^MPIFNQ(+$P(N0,"^",4))
 S PHONE=$P(N0,"^",5)
 S ID=$P(N0,"^")
 K HLA
 D INIT^HLFNC2("MPIF CMOR REQUEST",.HL)
 I $O(HL(""))="" D START^RGHLLOG(),EXC^RGHLLOG(220,"Unable to setup HL7 for sending Change of CMOR Request # "_REQ_" FOR ICN= "_ICN,$P(N0,"^",4)),STOP^RGHLLOG() D RESET^MPIFREQ(REQ) Q
 K HLL("LINKS") N MPILK
 S MPILK=$$MPILINK^MPIFAPI ;routing all messages through the MPI
 I +MPILK<0 D  Q
 .D START^RGHLLOG()
 .D EXC^RGHLLOG(224,"No MPI link found for Change CMOR Request # "_REQ_" for ICN="_ICN,$P(N0,"^",4))
 .D STOP^RGHLLOG()
 .D RESET^MPIFREQ(REQ)
 .S ERROR="-1^No Links found"
 ;Broadcast new CMOR to MPI which will send it out to all sites
 S HLL("LINKS",1)="MPIF CMOR RESPONSE^"_MPILK
 S CNT=CNT+1,PID=$$EN^VAFCPID(+$P(N0,"^",4),"1,2,4,5,6,7,8,11,12,13,14,16,17,19")
 S HLA("HLS",CNT)=PID
 S CNT=CNT+1
 S CMOR=$P($$HL7CMOR^MPIF001($P($G(^MPIF(984.9,DA,0)),"^",4),"^"),"^")
 S HLA("HLS",CNT)="NTE"_HL("FS")_HL("FS")_"P"_HL("FS")_PHONE_HL("FS")_REASON_HL("FS")_HL("FS")_ID_HL("FS")_INST_HL("FS")_HL("FS")_CMOR
 S CNT=CNT+1
 S HLA("HLS",CNT)="EVN"_HL("FS")_"A31"_HL("FS")_NDATE_HL("FS")_HL("FS")_""_HL("FS")_USER
 N RLST
 D GENERATE^HLMA("MPIF CMOR REQUEST","LM",1,.RLST,"",.HL)
 I 'RLST D START^RGHLLOG(),EXC^RGHLLOG(220,"Unable to setup HL7 for sending Change of CMOR Request # "_REQ_" for ICN= "_ICN,$P(N0,"^",4)),STOP^RGHLLOG(),RESET^MPIFREQ(REQ)
 K CNT,ICN,INST,NDATE,PID,REASON,RGL,USER,XX,ID
 Q
 ;
CHK(IEN) ;
 N N0,X,ERROR
 S ERROR=0
 S N0=$G(^MPIF(984.9,IEN,0))
 F X=1:1:7 I $P(N0,"^",X)="" S ERROR=1 Q
 I $P($G(^MPIF(984.9,IEN,1)),"^",2)="" S ERROR=1
 Q ERROR
