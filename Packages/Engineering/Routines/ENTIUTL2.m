ENTIUTL2 ;WOIFO/SAB - Find and Sort Equipment Utilities ;2/14/2008
 ;;7.0;ENGINEERING;**87**;Aug 17, 1993;Build 16
 ;
ASKEQSM(ENAML,ENDM) ; Ask Equipment Selection Method
 ; input
 ;   ENAML = allowed method list, may contain the following characters
 ;           A = all equipment
 ;           E = by Entry #
 ;           C = by CMR
 ;           U = by using service
 ;           L = by location
 ;           S = by service of location
 ;        example "ECULS"
 ;   ENDM = (optional) default method 
 ; returns null if no method selected or
 ;         piece 1 = A, E, C, U, L, or S if a method was selected
 ;         piece 2 = specified value when method is C, U, L, or S
 ;         e.g.  "C^12" for CMR with internal entry number = 12 
 ;
 N DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,ENRET,ENVAL,X,Y
 S ENRET="",ENVAL=""
 ;
 ; ask method
 S DIR(0)="S^"
 I ENAML["A" S DIR(0)=DIR(0)_"A:ALL TRACKED IT EQUIPMENT;"
 I ENAML["E" S DIR(0)=DIR(0)_"E:ENTRY #;"
 I ENAML["C" S DIR(0)=DIR(0)_"C:CMR;"
 I ENAML["U" S DIR(0)=DIR(0)_"U:USING SERVICE;"
 I ENAML["L" S DIR(0)=DIR(0)_"L:LOCATION;"
 I ENAML["S" S DIR(0)=DIR(0)_"S:SERVICE OF LOCATION;"
 Q:DIR(0)="S^" ENRET
 ; remove trailing ;
 I $E(DIR(0),$L(DIR(0)))=";" S DIR(0)=$E(DIR(0),1,$L(DIR(0))-1)
 S DIR("A")="Specify method to select equipment by"
 I $G(ENDM)]"" S DIR("B")=ENDM
 S DIR("?")="Enter a code from the list."
 S DIR("?",1)="The system considers tracked IT equipment to be"
 S DIR("?",2)="equipment that is on a CMR with IT TRACKING = YES."
 S DIR("?",3)=" "
 D ^DIR
 I '$D(DIRUT) S ENRET=Y
 ;
 ; ask a value for applicable methods
 ;
 ; method C - by CMR
 I ENRET="C" D
 . ; ask CMR
 . S DIC("S")="I $P($G(^(0)),U,9)=1" ; screen IT TRACKING = YES
 . S DIC="^ENG(6914.1,"
 . S DIC(0)="AQEM"
 . D ^DIC K DIC I Y<1 S ENRET="" Q
 . S ENVAL=+Y
 ;
 ; method U - by using service
 I ENRET="U" D
 . ; ask USING SERVICE
 . S DIC("S")="I $D(^ENG(6914,""AC"",+Y))" ; screen services with equip
 . S DIC="^DIC(49,"
 . S DIC(0)="AQEM"
 . D ^DIC K DIC I Y<1 S ENRET="" Q
 . S ENVAL=+Y
 ;
 ; method L - by location
 I ENRET="L" D
 . ; ask LOCATION
 . S DIC("S")="I $D(^ENG(6914,""D"",+Y))" ; screen locations with equip
 . S DIC="^ENG(""SP"","
 . S DIC(0)="AQEM"
 . D ^DIC K DIC I Y<1 S ENRET="" Q
 . S ENVAL=+Y
 ;
 ; method S - by service of location
 I ENRET="S" D
 . ; ask SERVICE
 . S DIC("S")="I $D(^ENG(""SP"",""D"",+Y))" ; screen services with space
 . S DIC="^DIC(49,"
 . S DIC(0)="AQEM"
 . D ^DIC K DIC I Y<1 S ENRET="" Q
 . S ENVAL=+Y
 ;
 I ENVAL]"" S ENRET=ENRET_"^"_ENVAL
 Q ENRET
 ;
ASKIAEQ() ; Ask Include Assigned Equipment
 ;
 ; returns null if time-out or uparrorw
 ;         1 if assigned equipment should be included
 ;         0 if not
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,ENRET,X,Y
 S ENRET=""
 S DIR(0)="Y"
 S DIR("A")="Include equipment with an existing active assignment"
 S DIR("B")="NO"
 D ^DIR
 I '$D(DIRUT) S ENRET=Y
 Q ENRET
 ;
ASKEQSRT(ENSM,ENDM) ; Ask Equipment Sort
 ; input ENSM = (optional) selection method
 ;              if method is E then sort is set to E
 ;       ENDM = (optional) default sort method
 ;
 ; returns null if no sort selected
 ;         E, C, U, L, or S if a sort was selected
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,ENRET,X,Y
 S ENRET=""
 I $G(ENSM)="E" S ENRET="E"
 E  D
 . S DIR(0)="S^E:ENTRY #;C:CMR;U:USING SERVICE;L:LOCATION;S:SERVICE OF LOCATION"
 . S DIR("A")="Sort equipment by"
 . I $G(ENDM)]"" S DIR("B")=ENDM
 . D ^DIR K DIR
 . I '$D(DIRUT) S ENRET=Y
 Q ENRET
 ;
GETEQ(ENSM,ENVAL,ENSRT,ENIA) ; Get Equipment
 ; input ENSM  = selection method (A, E, C, U, L, or S)
 ;               NOTE: E method is interactive, while the others are not
 ;       ENVAL = value when method is C, U, L, or S (e.g. ien of CMR) 
 ;       ENSRT = sort by (E, C, U, L, or S) - must be E for method E
 ;       ENIA  = 1 (include) or 0 (don't include) equip w/active assign
 ;               this does not apply to method E 
 ;               optional, default = 1
 ; output
 ;   ^TMP($J,"ENITEQ",0)=count^method^specified value^sort
 ;   ^TMP($J,"ENITEQ",sort value,equip ien)="" list of equipment
 ;
 N ENCMR,ENCNT,END,ENDA
 K ^TMP($J,"ENITEQ")
 S ENVAL=$G(ENVAL)
 S ENSRT=$G(ENSRT,"E")
 S ENIA=$G(ENIA,1)
 S ENCNT=0,END=0
 ;
 ; method A - all tracked equipment
 I ENSM="A" D
 . ; loop thru CMRs with IT TRACKING = YES
 . S ENCMR=0 F  S ENCMR=$O(^ENG(6914.1,"AIT",1,ENCMR)) Q:'ENCMR  D
 . . ; loop thru equipment on CMR
 . . S ENDA=0 F  S ENDA=$O(^ENG(6914,"AD",ENCMR,ENDA)) Q:'ENDA  D
 . . . I 'ENIA,$D(^ENG(6916.3,"AEA",ENDA)) Q  ; chose to excl. assigned
 . . . D SETTMP
 ;
 ; method E - by individual equipment (interactive)
 I ENSM="E" D
 . N DA,DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,ENSCR,X,Y
 . ; screen by CMR:IT TRACKING
 . S ENSCR="N ENCMR S ENCMR=$P($G(^(2)),U,9) I ENCMR,$D(^ENG(6914.1,""AIT"",1,ENCMR))"
 . ; ask equipment in loop
 . F  S DIC("S")=ENSCR D GETEQ^ENUTL Q:Y<1  D  Q:END
 . . S ENDA=+Y
 . . ; display equip
 . . W @(IOF)
 . . D DISEQ^ENTIUTL(ENDA)
 . . W !
 . . D DISASGN^ENTIUTL(ENDA)
 . . ;
 . . ; check if already selected (sort is always "E" for this method)
 . . I $D(^TMP($J,"ENITEQ","NA",ENDA)) D  Q
 . . . W !!,"This equipment item has already been selected."
 . . . W !,"If all desired equipment has been selected then press RETURN"
 . . . W !,"at the equipment selection prompt."
 . . ;
 . . ; ask confirmation
 . . W !
 . . S DIR(0)="Y",DIR("A")="Do you want to select this item"
 . . D ^DIR I $D(DIRUT) S END=1 Q
 . . I 'Y Q
 . . ;
 . . ; user confirmed
 . . D SETTMP
 ;
 ; method C - by CMR
 I ENSM="C" D
 . ; loop thru equipment on the CMR
 . S ENDA=0 F  S ENDA=$O(^ENG(6914,"AD",ENVAL,ENDA)) Q:'ENDA  D
 . . I 'ENIA,$D(^ENG(6916.3,"AEA",ENDA)) Q  ; chose to exclude assigned
 . . D SETTMP
 ;
 ; method U - by using service
 I ENSM="U" D
 . ; loop thru equipment with this using service
 . S ENDA=0 F  S ENDA=$O(^ENG(6914,"AC",ENVAL,ENDA)) Q:'ENDA  D
 . . S ENCMR=$P($G(^ENG(6914,ENDA,2)),U,9)
 . . Q:'ENCMR  ; not on a cmr
 . . Q:$P($G(^ENG(6914.1,ENCMR,0)),U,9)'=1  ; IT tracking not yes
 . . I 'ENIA,$D(^ENG(6916.3,"AEA",ENDA)) Q  ; chose to exclude assigned
 . . D SETTMP
 ;
 ; method L - by location
 I ENSM="L" D
 . ; loop thru equipment in this location
 . S ENDA=0 F  S ENDA=$O(^ENG(6914,"D",ENVAL,ENDA)) Q:'ENDA  D
 . . S ENCMR=$P($G(^ENG(6914,ENDA,2)),U,9)
 . . Q:'ENCMR  ; not on a cmr
 . . Q:$P($G(^ENG(6914.1,ENCMR,0)),U,9)'=1  ; IT tracking not yes
 . . I 'ENIA,$D(^ENG(6916.3,"AEA",ENDA)) Q  ; chose to exclude assigned
 . . D SETTMP
 ;
 ; method S - by service of location
 I ENSM="S" D
 . N ENSP
 . ; loop thru locations with this service
 . S ENSP=0 F  S ENSP=$O(^ENG("SP","D",ENVAL,ENSP)) Q:'ENSP  D
 . . ; loop thru equipment with this location
 . . S ENDA=0 F  S ENDA=$O(^ENG(6914,"D",ENSP,ENDA)) Q:'ENDA  D
 . . . S ENCMR=$P($G(^ENG(6914,ENDA,2)),U,9)
 . . . Q:'ENCMR  ; not on a cmr
 . . . Q:$P($G(^ENG(6914.1,ENCMR,0)),U,9)'=1  ; IT tracking not yes
 . . . I 'ENIA,$D(^ENG(6916.3,"AEA",ENDA)) Q  ; chose to exclude assigned
 . . . D SETTMP
 ;
 ; set output header node
 S ^TMP($J,"ENITEQ",0)=ENCNT_U_ENSM_U_ENVAL_ENSRT
 ;
 Q
 ;
SETTMP ; save equipment in sorted TMP global
 N ENSRTV
 S ENSRTV=""
 I ENSRT="E" S ENSRTV="NA"
 I ENSRT="C" S ENSRTV=$$GET1^DIQ(6914,ENDA,19) ; cmr
 I ENSRT="U" S ENSRTV=$$GET1^DIQ(6914,ENDA,21) ; service
 I ENSRT="L" S ENSRTV=$$GET1^DIQ(6914,ENDA,24) ; location
 I ENSRT="S" S ENSRTV=$$GET1^DIQ(6914,ENDA,"24:1.5") ; svc of loc
 I ENSRTV="" S ENSRTV=" <null>"
 S ^TMP($J,"ENITEQ",ENSRTV,ENDA)=""
 S ENCNT=ENCNT+1
 Q
 ;
 ;ENTIUTL2
