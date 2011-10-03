ENEQ1 ;WIRMFO/DH,SAB-Enter Equipment Records ;12.18.97
 ;;7.0;ENGINEERING;**14,25,29,35,47**;Aug 17, 1993
 ;
EQAD ;New Inventory Entry Point
 S END=0
 N IOINLOW,IOINHI D ZIS^ENUTL
 D ASKEDM G:END EQADX
 ;
 F  D  Q:END
 . W @IOF,!!!
 . S DIR(0)="Y",DIR("A")="Enter a new equipment inventory item"
 . S DIR("B")="NO"
 . S DIR("?")="Enter 'Y' to add a new Equipment Record."
 . W @IOF,!!! D ^DIR K DIR I 'Y S END=1 Q
 . D ASKSER Q:END  Q:'$D(ENSERIAL)
 . D ADDEQ
EQADX ;
 K DA,DIC,DIE,DIK,DIR,DIROUT,DIRUT,DR,DTOUT,DUOUT,X,Y
 K END,ENDA,ENDR,ENNXL,ENSCRN
 Q
 ;
EQMAD ;Multiple Inventory Entry Point 
 S END=0,ENMA=1
 N IOINLOW,IOINHI D ZIS^ENUTL
 W @IOF,!!!
 S DIR(0)="Y",DIR("A")="Enter multiple equipment inventory items"
 S DIR("B")="NO"
 S DIR("?",1)="This option allows a rapid entry of multiple items which"
 S DIR("?",2)="are alike; e.g. 25 new electric beds."
 S DIR("?")="Enter YES or NO"
 D ^DIR K DIR G:'Y EQMADX
 ;
 D ASKEDM G:END EQMADX
 ;
 W !!,"Proceed by entering the first item in full"
 S DIR(0)="E" D ^DIR K DIR G:$D(DIRUT) EQMADX
 ;
 D ASKSER G:END EQMADX G:'$D(ENSERIAL) EQMAD
 ;
 D ADDEQ I 'ENNXL G EQMADX
 ;
 W @IOF,!!!,"For each additional equipment entry enter:"
 W !," SERIAL #, LOCATION, VA PM NUMBER, and LOCAL IDENTIFIER (if any)."
 F  D  Q:END
 . W !!
 . S DIR(0)="Y",DIR("A")="Enter another item",DIR("B")="YES"
 . S DIR("?")="Enter YES to add another similar equipment item"
 . D ^DIR K DIR I 'Y S END=1 Q
 . S ENDAOLD=ENNXL
 . D EQMAS^ENEQ3 I 'ENNXL S ENNXL=ENDAOLD
 . K ENDAOLD
 ;
EQMADX ;
 K DA,DIC,DIE,DIK,DIR,DIROUT,DIRUT,DR,DTOUT,DUOUT,X,Y
 K END,ENDA,ENDR,ENMA,ENNXL,ENSCRN
 Q
 ;
ASKEDM ; ask edit method (screen or template)
 ; out
 ;   ENSCRN - flag: true when screen entry
 ;   ENDR   - input template when ENSCRN = 0
 ;   END    - true when timeout or '^'
 S DIR(0)="Y",DIR("A")="Screen entry",DIR("B")="YES"
 S DIR("?")="Enter 'Y' for screen handler, 'N' for standard FileMan."
 D ^DIR K DIR S:$D(DIRUT) END=1 S ENSCRN=Y
 S:ENSCRN=0 ENDR=$S($D(^DIE("B","ENZEQENTER")):"[ENZ",1:"[EN")_"EQENTER]"
 Q
 ;
ASKSER ; ask serial # and check file for duplicates
 ; out
 ;   ENSERIAL - contains entered serial # or
 ;              undefined if user did not reconfirm after a match
 ;   END - true when timeout or '^'
 N DA,ENI,ENMATCH,ENX
 ; ask serial #
 S ENSERIAL=""
 W !!,"Please enter SERIAL # if available. Otherwise press <return>."
 S DIR(0)="6914,5" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S END=1 Q
 S ENSERIAL=Y
 Q:ENSERIAL=""
 ; look for matches
 S ENX=$$UP^XLFSTR($TR(ENSERIAL," !""#$%&'()*+,-./:;<=>?@[\]^_`{|}~",""))
 S ENX=$E(ENX_" ",1,30)
 S ENI=0 F  S ENI=$O(^ENG(6914,"FC",ENX,ENI)) Q:'ENI  S ENMATCH(ENI)=""
 ; if match show list, reconfirm
 I $D(ENMATCH) D
 . W !,"List of existing equipment with a similar Serial #"
 . W !,?2,"Entry #",?14,"Manufacturer"
 . S ENI=0 F  S ENI=$O(ENMATCH(ENI)) Q:'ENI  D
 . . W !,?2,ENI,?14,$E($$GET1^DIQ(6914,ENI,1),1,60)
 . . W !,?4,"Mod: ",$$GET1^DIQ(6914,ENI,4)
 . . W ?40,"Ser #: ",$$GET1^DIQ(6914,ENI,5)
 . S DIR(0)="Y",DIR("A")="Do you still want to add this new record"
 . S DIR("B")="NO" D ^DIR K DIR S:$D(DIRUT) END=1 I 'Y K ENSERIAL
 Q
 ;
ADDEQ ; add new equipment item
 ; in
 ;   ENSERIAL (optional) contains serial #
 ;   ENMA (optional) flag, true if multiple equipment entry
 ; out
 ;   ENNXL - ien of new equipment record, 0 if unsuccessful
 ;   also when $G(ENMA) true
 ;       ENMA("FAP") - flag, true if FA Document generated
 ;       ENMA("IIWO") - flag, true if Incom. Insp. W.O. generated
 ;       also when $G(ENMA("IIWO")) true
 ;           ENMA("IIWO","DA") - ien of created w.o.
 ;           ENMA("IIWO","ION") - ION where w.o. printed
 ;           ENMA("IIWO","QDT") - queued date/time if w.o. tasked
 ; create new record
 D ENR I 'ENNXL W $C(7),!,ENERR S DIR(0)="E" D ^DIR K DIR,ENERR Q
 ; lock new record
 L +^ENG(6914,ENNXL):1 I '$T D   Q
 . W !!,$C(7),"Another user is editing Entry # ",ENNXL,". Can't proceed."
 ; populate serial #
 I $G(ENSERIAL)]"" S DIE="^ENG(6914,",DR="5////"_ENSERIAL,DA=ENNXL D ^DIE
 ; user edit new record
 I ENSCRN D
 . S DJSC="ENEQ1",(DJDN,ENDA,DA)=ENNXL
 . D EN^ENJ W IOINLOW
 . K DJD0,DJDIS,DJDN,DJLG,DJSC,DJSW2
 I 'ENSCRN S DIE="^ENG(6914,",DR=ENDR,DA=ENNXL D ^DIE
 ; enter PM schedule
 I $D(^XUSEC("ENEDPM",DUZ)) D
 . S DIR(0)="Y",DIR("B")="YES"
 . S DIR("A")="Would you like to include this item in the PM program"
 . D ^DIR K DIR Q:'Y
 . N ENXP
 . S DIE="^ENG(6914,",(DA,ENDA)=ENNXL,ENXP=1
 . I $D(^ENG(6914,DA,4)) D DINV^ENEQPMP3 Q:X="^"
 . D XNPMSE^ENEQPMP
 ; generate incoming inspection W.O.?
 S ENI=$O(^ENG(6910.2,"B","ASK INCOMING INSPECTION W.O.",0))
 I ENI,$P(^ENG(6910.2,ENI,0),U,2) D
 . S DIR(0)="Y",DIR("A")="Create an Incoming Inspection Work Order"
 . S DIR("B")=$S($P(^ENG(6910.2,ENI,0),U,2)=2:"YES",1:"NO")
 . D ^DIR K DIR S:$G(ENMA) ENMA("IIWO")=$S(Y>0:1,1:0)
 . I Y D IIWO^ENWONEW3(ENNXL) I $G(ENMA) D
 . . S ENMA("IIWO","DA")=ENDA
 . . S ENMA("IIWO","ION")=$G(ENION)
 . . S ENMA("IIWO","QDT")=$G(ENQDT)
 . . K ENDA,ENION,ENQDT
 ; generate FA Document?
 I $D(^XUSEC("ENFACS",DUZ)),$P(^ENG(6914,ENNXL,0),U,4)="NX",$P($G(^(8)),U,2) D
 . W !!,"This Equipment Record is both NONEXPENDABLE and CAPITALIZED."
 . W:$G(ENMA) !,"The same will be true of other records created using this option."
 . S DIR(0)="Y",DIR("A")="Do you wish to send an FA document to Austin"
 . S DIR("B")="YES"
 . D ^DIR K DIR S:$G(ENMA) ENMA("FAP")=$S(Y>0:1,1:0)
 . I Y  S ENEQ("DA")=ENNXL D ^ENFAACQ K ENEQ("DA")
 ; generate new equipment bulletin
 S DA=ENNXL D BULL^ENEQ3
 ; unlock entry
 L -^ENG(6914,ENNXL)
 Q
 ;
ENR ; create entry with next available ien
 ; out
 ;   DA,ENNXL - ien of new entry, 0 when unsuccessful
 ;   ENERR    - error message if unsuccessful
 S (DA,ENNXL)=0 K ENERR
 I '$D(ZTQUEUED) W !,"...Setting up new equipment record"
 N DD,DIC,DINUM,DO,X,Y
 L +^ENG(6914,0):10
 I '$T S ENERR="SORRY, CAN'T LOCK ^ENG(6914,0) GLOBAL, TRY LATER" Q
 ;
 S ENNXL=$P(^ENG(6914,0),"^",3)
 F  S ENNXL=ENNXL+1 Q:'$D(^ENG(6914,ENNXL,0))
 ;
 S DIC="^ENG(6914,",DIC(0)="LX",(DA,X,DINUM)=ENNXL
 K DD,DO D FILE^DICN
 S:Y'>0 (DA,ENNXL)=0,ENERR="Unable to add new record at this time..."
 L -^ENG(6914,0)
 Q
 ;
 ;ENEQ1
