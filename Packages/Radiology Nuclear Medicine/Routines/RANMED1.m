RANMED1 ;HISC/SWM-Nuclear Medicine Enter/Edit Routine ;1/21/97  11:07
 ;;5.0;Radiology/Nuclear Medicine;**65**;Mar 16, 1998;Build 8
 ;
 ;Supported IA #10142 reference to EN^DDIOL
 ;DBIA: 4551  DIC^PSSDI  looks up & screens records from file #50
ROUTE ; Enter/Edit file 71.6
 W ! N RA1,RA2 S RA1=0
 S DIC="^RAMIS(71.6,",DIC(0)="AEQLMZ" D ^DIC
 G:+Y<1 EXIT S DA=+Y,DIE=DIC,DR=".01;100" D ^DIE
 W !!?5,"Current parameters for entry of sites for this route :"
 W !!?5,"PROMPT FOR FREE TEXT SITE?    = ",$P(^RAMIS(71.6,DA,0),U,3)
 W !?5,"VALID SITES OF ADMINISTRATION = " F  S RA1=$O(^RAMIS(71.6,DA,"SITE",RA1)) Q:'RA1  I +^(RA1,0) S RA2=$P(^RAMIS(71.7,+^(0),0),U) W:($L(RA2)+2+$X)>80 !?10 W RA2 W:$O(^RAMIS(71.6,DA,"SITE",RA1)) ";" W "  "
 W !!?21,"-- NOTE -- ",!?10,"If 'PROMPT FOR FREE TEXT SITE?' is 'Y',",!?10,"then users will not be given a selection",!?10,"of predefined 'VALID SITES'"
 S DIR(0)="SO^P:PROMPT FOR FREE TEXT SITE?;V:VALID SITES OF ADMINISTRATION"
 S DIR("A")="Edit which field"
 D ^DIR
 G:$G(DIRUT) ROUTE
 S DR=$S(X="V":2,X="P":3,1:"") G:'DR ROUTE
 D ^DIE
 G ROUTE
SITE ; Enter/Edit file 71.7
 W !
 S DIC="^RAMIS(71.7,",DIC(0)="AEQLMZ" D ^DIC
 G:+Y<1 EXIT S DA=+Y S DIE=DIC,DR=".01:999" D ^DIE
 G SITE
SOURCE ; Enter/Edit file 71.8
 W !
 S DIC="^RAMIS(71.8,",DIC(0)="AEQLMZ" D ^DIC
 G:+Y<1 EXIT S DA=+Y S DIE=DIC,DR=".01:999" D ^DIE
 G SOURCE
LOT ; Enter/Edit file 71.9
 ;RA*5*65 SG
 N DA,DIC,DIDEL,DIE,DINUM,DLAYGO,DR,DTOUT,DUOUT,EXIT,TMP,X,Y
 S EXIT=0
 F  D  Q:EXIT
 . ;--- Select a record
 . S DIC="^RAMIS(71.9,",DIC(0)="AEQLMSZ"
 . W !  D ^DIC
 . I Y'>0  S EXIT=1  Q
 . ;--- Edit the record
 . S DA=+Y,DIE=DIC
 . S DR=".01:4;5///^S X=$$RXEDIT^RAPSAPI3(""R"","""_DA_","",71.9,5,DT);6"
 . D ^DIE
 Q
WARN ; Warn if dose is out-of-range, called from [RA EXAM EDIT]
 Q:'$D(RADTI)!('$D(RADFN))
 N RA1,RAXDIV,RADOT S RA1=0 ; RAXDIV=exam's division
 S $P(RADOT,"o ",40)=""
 S RAXDIV=+$P(^RADPT(RADFN,"DT",RADTI,0),U,3)
 I '$O(^RA(79,RAXDIV,"RWARN",0)) W !!,RADOT,!?14,"This dose level requires a written, dated and signed",!?27,"directive by a physician.",!,RADOT,! Q
 W !,RADOT
 F  S RA1=$O(^RA(79,RAXDIV,"RWARN",RA1)) Q:'RA1  W !?((80-$L(^(RA1,0)))/2),^(0)
 W !,RADOT,!
 Q
EXIT K DIC,DIE,DIR,DA,DR,DIRUT
 K C,D,D0,DDH,DG,DI,DISYS,DQ,DST,DUOUT,I,POP
 K RA719IEN,RAFDA,DIE,DA,DR,RAVACL,RAYN,RAENTRY,RA50IEN,RANODEL,RASTUFF
 K RAHLP3,RAFIN
 Q
DUPL ;check for duplicate entry into file 71.9
 Q:'$O(^RAMIS(71.9,"B",X,0))
 Q:'$D(RAOPT("NM EDIT LOT"))  ;prevent msg appearing in other options
 N RA
 S RA(1)="**WARNING** An entry already exists for LOT NUMBER/ID = "_X
 S RA(1,"F")="!!?7,*7"
 S RA(2)="If you want to add another LOT NUMBER/ID with the same value"
 S RA(2,"F")="!!?7"
 S RA(3)="then put "" "" around the value, eg. """_X_""""
 S RA(3,"F")="!?7"
 S RA(4)=""
 S RA(4,"F")="!!"
 D EN^DDIOL(.RA)
 Q
