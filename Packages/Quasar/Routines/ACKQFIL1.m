ACKQFIL1 ;BIR/PTD-Update A&SP Files per CO Directive - CONTINUED ; 04/24/96 15:08
 ;;3.0;QUASAR;**1**;Feb 11, 2000
 ;Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
 ;Variables defined upon entry: ACKFNAM (file name), ACKFNUM (file number).
 W !!,"All fields MUST be answered.  Otherwise a new entry",!,"is considered incomplete and will be deleted.",!
ADD ;User wants to add new file entries.
 S (DIC,DIE)="^ACK("_ACKFNUM_",",DIC(0)="QEALM",DIC("A")="Enter "_$S(ACKFNUM=509850:"Account Number",1:"Code")_": ",ACKLAYGO="",DLAYGO=ACKFNUM D ^DIC K DIC I Y<0 D EXIT^ACKQFIL G FILE^ACKQFIL
 S (ACKIEN,DA)=+Y
 I ACKFNUM="509850.4" D LONG^ACKQUTL6(ACKIEN,"1")
 S ACKNEW=$P(Y,"^",3) L +^ACK(ACKFNUM,ACKIEN):5 I '$T W !,"Another user is editing this entry...try again later." D EXIT^ACKQFIL G FILE^ACKQFIL
ORIG ; For an existing entry, get the original zero node field values.
 S:'ACKNEW ACKORIG=^ACK(ACKFNUM,ACKIEN,0)
CDR I ACKFNUM=509850 S DR="1T;2T~d;3T~d;4T~d" D ^DIE K DA,DIE,DR G CHECK
ICD I ACKFNUM=509850.1 S DR=".04///SA;.06T~d" D ^DIE D  G:$D(DIRUT) CHECK S DR=".05///^S X=ACKHRLOS" D ^DIE ;Logic falls down to MOD.
 .K DIR,X,Y S DIR(0)="Y",DIR("A")="Is this a hearing loss code which requires audiology data",DIR("?")="Enter YES to require audiology questions for this code."
 .S DIR("B")=$S($P(^ACK(ACKFNUM,ACKIEN,0),"^",5)=1:"YES",1:"NO")
 .S DIR("??")="^D HRLOS^ACKQHLP1" W ! D ^DIR K DIR Q:$D(DIRUT)  S ACKHRLOS=+Y
CPT I ACKFNUM=509850.4 S DR=".02///SA;.04T~d;.06T" D ^DIE
MOD ; Does this code have mofifiers?
 ; K DIR,X,Y S DIR(0)="Y",DIR("A")="Does this code have modifiers",DIR("?")="Answer YES to add code modifiers; answer NO if there are no modifiers."
 ; I ACKFNUM=509850.1 S DIR("B")=$S($P(^ACK(509850.1,ACKIEN,0),"^",2)=1:"YES",1:"NO")
 ; I ACKFNUM=509850.4 S DIR("B")=$S($P(^ACK(509850.4,ACKIEN,0),"^",5)=1:"YES",1:"NO")
 ; S DIR("??")="^D MOD^ACKQHLP1" W ! D ^DIR K DIR G:$D(DIRUT) CHECK S ACKMOD=+Y
 ; S DR=$S(ACKFNUM=509850.4:".05",1:".02")_"///^S X=ACKMOD" D ^DIE
 ; I ACKMOD=0 G CHECK ;Code does not have modifiers.
SUBFL ; Selected code has modifiers, subfile fields must be answered.
 ; S (DIC,DIE)="^ACK("_ACKFNUM_","_ACKIEN_",1,",DIC(0)="QEALM",DLAYGO=ACKFNUM,DA(1)=ACKIEN,DIC("P")=$P(^DD(ACKFNUM,1,0),"^",2) D ^DIC K DIC I Y<0 G CHECK
 ; S (ACKSUB,DA)=+Y,DR=".01T;.02T"_$S(ACKFNUM=509850.4:";.03T",1:"") D ^DIE K DA,DIE,DR G SUBFL
 ;
CHECK ;   Determine if all fields have been answered.
 ; ACKCOMP equals: 1 if all fields answered.
 ; 0 if zero node fields not answered.
 ; -1 if subfile fields not answered.
 S ACKZNODE=^ACK(ACKFNUM,ACKIEN,0),ACKCOMP=1
CKCDR ; Examine CDR ACCOUNT file.
 I ACKFNUM=509850 D
 .F PC=1:1:5 I $P(ACKZNODE,"^",PC)="" S ACKCOMP=0 D RESET
CKICD ;  Examine A&SP DIAGNOSTIC CONDITION file.
 I ACKFNUM=509850.1 D
 .F PC=1,4,5,6 I $P(ACKZNODE,"^",PC)="" S ACKCOMP=0 D RESET
 ; . I $P(^ACK(ACKFNUM,ACKIEN,0),"^",2)=1 D  I ($P(^ACK(ACKFNUM,ACKIEN,0),"^",2)=1),('$O(^ACK(ACKFNUM,ACKIEN,1,0))) S ACKCOMP=-1
 ; .. S ACKSUB=0 F  S ACKSUB=$O(^ACK(ACKFNUM,ACKIEN,1,ACKSUB)) Q:'ACKSUB  F PC=1,2 I $P(^ACK(ACKFNUM,ACKIEN,1,ACKSUB,0),"^",PC)="" S ACKCOMP=-1
CKCPT ; Examine A&SP PROCEDURE CODE file.
 I ACKFNUM=509850.4 D
 .F PC=1,2,4,6 I $P(ACKZNODE,"^",PC)="" S ACKCOMP=0 D RESET
 ; . I $P(^ACK(ACKFNUM,ACKIEN,0),"^",5)=1 D  I ($P(^ACK(ACKFNUM,ACKIEN,0),"^",5)=1),('$O(^ACK(ACKFNUM,ACKIEN,1,0))) S ACKCOMP=-1
 ; .. S ACKSUB=0 F  S ACKSUB=$O(^ACK(ACKFNUM,ACKIEN,1,ACKSUB)) Q:'ACKSUB  F PC=1,2,3 I $P(^ACK(ACKFNUM,ACKIEN,1,ACKSUB,0),"^",PC)="" S ACKCOMP=-1
 ;
 ; All fields answered for CDR.
 ;
 I (ACKFNUM=509850)&(ACKCOMP=1) W !! D CNTR^ACKQUTL("<<FILE ENTRY IS COMPLETE.>>") W ! G UNLK
 ; New entry requires all fields to be answered, else entry is deleted.
 I (ACKNEW)&(ACKCOMP'=1) K ACKZNODE,ACKSUB,PC D DIK G UNLK
 ; Existing entry. Blank fields on zero node restored to original value.
 I ('ACKNEW)&(ACKCOMP=0) W !! D CNTR^ACKQUTL("<<AN EXISTING ENTRY CAN ONLY BE INACTIVATED.>>") W ! G UNLK
 ; Existing entry. Blank fields left in subfile.
 I ('ACKNEW)&(ACKCOMP=-1) W !! D CNTR^ACKQUTL("<<YOU DID NOT ANSWER ALL FIELDS FOR THE MODIFIERS.>>") W ! D CNTR^ACKQUTL("<<PLEASE RE-EDIT THIS ENTRY TO PRESERVE DATA INTEGRITY.>>") W ! G UNLK
 ; All fields answered for ICD9 and CPT.
 I ACKCOMP=1 W !! D CNTR^ACKQUTL("<<FILE ENTRY IS COMPLETE.>>") W !
UNLK L -^ACK(ACKFNUM,ACKIEN)
 D KVAR G ADD
 ;
DIK ; All fields not answered for new entry, so delete it.
 W !!,$C(7) D CNTR^ACKQUTL("<<INCOMPLETE RECORD DELETED!>>") W !
 S DIK="^ACK("_ACKFNUM_",",DA=ACKIEN D ^DIK
 Q
 ;
KVAR ; Kill selected variables.
 K ACKCOMP,ACKHRLOS,ACKLAYGO,ACKMOD,ACKNEW,ACKORIG,ACKZNODE,DA,DIC,DIE,DIK,DIR,DIRUT,DLAYGO,X,Y
 Q
 ;
RESET ; Existing entry edited, leaving blank fields.
 ; Restore original value for any blank field on zero node.
 I 'ACKNEW S $P(^ACK(ACKFNUM,ACKIEN,0),"^",PC)=$P(ACKORIG,"^",PC)
 Q
 ;
