LEXILGO ; ISL Rename Options                       ; 09-23-96
 ;;2.0;LEXICON UTILITY;;Sep 23, 1996
 Q
RE ; Entry point to rename GMPT Options to LEX namespace
 N LEX,LEXR,LEXI,LEXT,LEXC,LEXON,LEXOD,LEXNN,LEXND,LEXNP,LEXNPE
 I '$D(^DIC(9.4,"C","LEX")) D SPL,OPT,KPL Q
OPT ; Rename Options
 W !,?2,"Old Name",?40,"New Name"
 S (LEXC,LEXNP)=0,LEXR="NAM"
 F LEXI=1:1 S LEXT=$T(@LEXR+LEXI) Q:$P(LEXT,";",2)=""  D
 . K LEXO S LEXO(99)=0,LEXO(1,0)=$P(LEXT,";",2),LEXO(1,1)=$P(LEXT,";",3),LEXO(2,0)=$P(LEXT,";",4),LEXO(2,1)=$P(LEXT,";",5)
 . S LEXO(0)=$O(^DIC(19,"B",$E(LEXO(1,0),1,30),0)) S:LEXO(0)="" LEXO(0)=$O(^DIC(19,"B",$E(LEXO(2,0),1,30),0))
 . Q:+($G(LEXO(0)))=0  S LEXO(3,0)=$P(^DIC(19,LEXO(0),0),"^",1),LEXO(3,1)=$P(^DIC(19,LEXO(0),0),"^",2)
 . I $G(LEXO(1,0))=$G(LEXO(3,0)),$G(LEXO(1,1))=$G(LEXO(3,1)) S LEXO(99)=1
 . I $G(LEXO(2,0))=$G(LEXO(3,0)),$G(LEXO(2,1))=$G(LEXO(3,1)) S LEXO(99)=2
 . I $L($G(LEXOPT)),$E(LEXO(1,0),1,$L(LEXOPT))'=LEXOPT Q
 . I LEXO(99)=1 D ED(LEXO(0),LEXO(1,0),LEXO(1,1),LEXO(2,0),LEXO(2,1))
 . I LEXO(99)=2 D ED(LEXO(0),LEXO(2,0),LEXO(2,1),LEXO(1,0),LEXO(1,1))
 K LEXO Q
RP ; Rename GMPL only
 S LEXOPT="GMPL" D OPT Q
ED(LEXIEN,LEXON,LEXOD,LEXNN,LEXND) ; Edit Option file
 S LEXC=+($G(LEXC))+1
 W !!,?2,LEXON,?40,LEXNN
 W !,?2,LEXOD,?40,LEXND
 N DA,DR,DIE,DIC S (DIE,DIC)="^DIC(19,",DA=+LEXIEN Q:'$D(@(DIC_DA_",0)"))
ED2 ; Record is Locked
 L +^DIC(19,DA):1 I '$T W:'$D(ZTQUEUED) "." H 2 G ED2
 S DR=".01///^S X=LEXNN;1///^S X=LEXND" D ^DIE L -^DIC(19,DA) Q
SPL ; Set Temporary Package file entry for LEX
 N DIE,DIC,DA,X,DR,LEX1,LEX2 K DD,DO S DIC="^DIC(9.4,",DIC(0)="EQLM",X="Lexicon Utility",LEX1="LEX",LEX2="Clinical/Non-Clinical Terminology System"
 S DIC("DR")="1///^S X=LEX1;2///^S X=LEX2" D FILE^DICN S LEXNP=Y,LEXNPE=+Y Q
KPL ; Kill Temporary Package file entry for LEX
 S LEXNPE=+($G(LEXNPE)) Q:LEXNPE=0  N DIK,DIC,DA S (DIK,DIC)="^DIC(9.4,",DA=LEXNPE D ^DIK Q
DG ; Delete GMPT Package Entry
 N DA S DA=$O(^DIC(9.4,"C","GMPT",0))
 I +DA>0,$D(^DIC(9.4,+(DA),0)) D  H 1 Q
 . W !,?4,"GMPT Package File entry was found"
 . W !!,?6,"The GMPT namespace was used by the Clinical Lexicon"
 . W !,?6,"Utility version 1.0.  The GMPT Package File entry may"
 . W !,?6,"be deleted.  ",!
 I +DA=0!('$D(^DIC(9.4,+(DA),0))) D  H 1 Q
 . W !,?4,"GMPT Package File entry was not found",!
 ;N DIK,DIC S (DIK,DIC)="^DIC(9.4," D ^DIK
 Q
NAM ; Options - ;old name;old display text;new name;new display text
 ;GMPT CLINICAL LEXICON MGT MENU;Clinical Lexicon Management Menu;LEX MGT MENU;Lexicon Management Menu
 ;GMPT MGR EDIT TERM;Edit a term;LEX MGR EDIT LEXICON;Edit Lexicon
 ;GMPT MGR DEFAULTS;Defaults;LEX MGR DEFAULTS;Defaults
 ;GMPT CLINICAL LEXICON UTILITY;Clinical Lexicon Utility;LEX UTILITY;Lexicon Utility
 ;GMPT CLINICAL LEXICON LOOK-UP;Clinical Lexicon Look-up;LEX LOOK-UP;Look-up Term
 ;GMPT USER DEFAULTS;Lexicon Look-up Defaults;LEX USER DEFAULTS;User Defaults
 ;GMPT MGR USER DEFAULTS;Edit User/User Group Defaults;LEX MGR USER DEFAULTS;Edit User/User Group Defaults
 ;GMPT MGR LIST DEFAULTS;List User/User Group Defaults;LEX MGR LIST DEFAULTS;List User/User Group Defaults
 ;GMPT MGR EDIT DEFN;Edit Term Definition;LEX MGR EDIT DEFN;Edit Term Definition
 ;GMPL USER SCREEN;Problem Look-up Defaults;GMPL USER LOOK-UP DEFAULTS;Problem Look-up Defaults
 ;;;
