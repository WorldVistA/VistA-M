IBCNEAME ;DAOU/ESG - IIV AUTO MATCH ENTRY/EDIT ;29-APR-2002
 ;;2.0;INTEGRATED BILLING;**184,252,595**;21-MAR-94;Build 29
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
ENTER ;
 NEW STOP,AMIEN,NEWENTRY,DUOUT,DTOUT
 D INIT
LOOP ;
 N DIR
 D LOOKUP() I STOP G EXIT   ; lookup or add an entry
 ; IB*595/HN Updates Add New Question and Delete logic
 I $G(NEWENTRY)=1 W !,$P(^IBCN(365.11,AMIEN,0),"^",1)_" is now associated with "_$P(^IBCN(365.11,AMIEN,0),"^",2),! G LOOP
 S DIR(0)="SA^E:Edit;D:Delete"
 S DIR("A")="Do you want to Edit or Delete this entry? "
 S DIR("B")="E"
 D ^DIR
 I $D(DUOUT) G LOOP
 I $D(DTOUT) G EXIT
 D @($S(Y="D":"DELETE",1:"EDIT")) I STOP G LOOP
 ;D EDIT I STOP G LOOP       ; edit the entry values
 ; IB*595 End
 D CONFIRM                  ; display a confirmation message
 G LOOP                     ; repeat
EXIT ;
 Q
 ;
 ;
INIT ; clear the screen; display the purpose of this option
 W @IOF
 W !?14,"Enter/Edit Insurance Company Name Auto Match Entries"
 W !!,"This option will allow you to enter, edit, and manage the entries in the"
 W !,"Insurance Company Auto Match file.  This file will aid in the proper selection"
 W !,"of Insurance Companies by associating together a valid, correct Insurance"
 W !,"Company name with an incorrect entry that a clerk may enter during data entry."
 W !
INITX ;
 Q
 ;
LOOKUP(DEFAULT) ; Procedure to look-up or add an entry
 ;
 ; Optional input parameter DEFAULT will be set if calling this
 ; procedure from routine IBCNEAMC.  Otherwise it will be undefined.
 ;
 NEW DA,DIC,DILN,DISYS,X,Y,DTOUT,DUOUT,DLAYGO
 S STOP=0
 S (AMIEN,NEWENTRY)=""
 S DIC="^IBCN(365.11,",DLAYGO=365.11
 S DIC(0)="AELMVZ"
 S DIC("A")="Select an Auto Match Entry: "
 I $G(DEFAULT)'="" S DIC("B")=DEFAULT
 S DIC("W")="D LIST^IBCNEAME(Y)"
 D ^DIC
 I Y=-1!$D(DTOUT)!$D(DUOUT) S STOP=1 G LOOKX
 S AMIEN=+Y
 I $P(Y,U,3) S NEWENTRY=1
LOOKX ;
 Q
 ;
EDIT ; Procedure to Edit the fields for this entry
 NEW DIE,DA,DR,DTOUT,D,D0,DDH,DI,DIC,DISYS,DQ,DZ,X,Y
 S DIE=365.11
 S DA=AMIEN
 S DR=".01;.02;.05////"_$$NOW^XLFDT_";.06////"_DUZ
 I NEWENTRY D
 . ; if this is a new entry, then stuff in all of these fields
 . ; without user interaction
 . S DR=".03////"_$$NOW^XLFDT_";.04////"_DUZ
 . S DR=DR_";.05////"_$$NOW^XLFDT_";.06////"_DUZ
 . S DR=DR_";.07////"_$P($G(^IBCN(365.11,DA,0)),U,1)
 . S DR=DR_";.08////"_$P($G(^IBCN(365.11,DA,0)),U,2)
 . Q
 D ^DIE
 I $D(Y) W ! S STOP=1 G EDITX         ; user entered up arrow
 I '$D(DA) W !!?3,"This entry has been deleted.",! S STOP=1 G EDITX
EDITX ;
 Q
 ;
CONFIRM ; Display a confirmation message indicating what was filed
 NEW DATA
 I 'AMIEN G CONFX
 S DATA=$G(^IBCN(365.11,AMIEN,0))
 W !!?3,$P(DATA,U,1)," is now associated with ",$P(DATA,U,2),".",!
CONFX ;
 Q
 ;
LIST(IEN) ; FileMan lister display
 NEW DATA,D1,D2
 ; DATA=^IBCN(365.11,IEN,0)
 S DATA=^(0)
 S D1=$P(DATA,U,1),D2=$P(DATA,U,2)
 W $$FO^IBCNEUT1("",12-$L(D1))," is associated with ",D2
LISTX ;
 Q
 ;
DELETE ; Verify Delete
 N DIK,DIR
 S DIR(0)="Y"
 S DIR("A")="Are you sure you want to delete <"_$P(^IBCN(365.11,AMIEN,0),"^")_">: "
 S DIR("B")="N"
 D ^DIR
 I $G(Y(0))'="YES" G DELETEX
 S DIK="^IBCN(365.11,",DA=AMIEN D ^DIK
 W !,"This entry has been deleted.",!
DELETEX ;
 S STOP=1
 Q
