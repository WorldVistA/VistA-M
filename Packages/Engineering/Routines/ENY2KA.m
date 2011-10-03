ENY2KA ;;(WIRMFO)/DH-Equipment Y2K Management ;5.12.98
 ;;7.0;ENGINEERING;**51**;August 17, 1993
 ;  extension of ENY2K
 ;
MEN ; data entry by MANUFACTURER EQUIPMENT NAME
 ; menu option disabled at request of Technical Advisory Group
 ; thought to be too confusing and of limited utility
 N MEN,DIC,DIE,DA,DR,COUNT,ENY2K,ESCAPE
 F  D MEN1 D  Q:$G(ESCAPE)
 . I $G(ESCAPE),$G(MEN)]"" L -^ENG("MEN",MEN)
 . Q:$G(ESCAPE)
 . D:$G(ENY2K("CONT")) DATA^ENY2K1
 . I $G(ESCAPE) L -^ENG("MEN",MEN) Q
 . D UPDATE^ENY2K1
 . L -^ENG("MEN",MEN) S MEN=""
 G EXIT
 ;
MEN1 K ^TMP($J)
 R !!,"Please enter MANUFACTURER EQUIPMENT NAME: ",X:DTIME I '$T!($E(X)="^")!(X="") S ESCAPE=1 Q
 I $E(X)="?" W !!,"Please enter a MANUFACTURER EQUIPMENT NAME, of the form" F J="A","F","P" W !,?10,$O(^ENG(6914,"H",J)) G MEN1
 S MEN=$$UP^XLFSTR(X)
 I '$D(^ENG(6914,"H",MEN)) D  G:MEN="" MEN1 W "  ("_MEN_")"
 . S L=$L(MEN),MEN(1)=$O(^ENG(6914,"H",MEN))
 . I $E(MEN(1),1,L)=MEN S MEN=MEN(1) Q
 . S MEN=""
 L +^ENG("MEN",MEN):10 I '$T W !,"Another user is editing this MANUFACTURER EQUIPMENT NAME. Can't proceed." S MEN="" G MEN1
 F J="PRE","FC","NC","CC","NA" S COUNT(J)=0
 S (DA,COUNT)=0 F  S DA=$O(^ENG(6914,"H",MEN,DA)) Q:'DA  D
 . I $D(^ENG(6914,DA,0)),"^4^5^"'[(U_$P($G(^(3)),U)_U) S COUNT=COUNT+1,^TMP($J,DA)="",X=$P($G(^ENG(6914,DA,11)),U) I X]"" S COUNT("PRE")=COUNT("PRE")+1,COUNT(X)=COUNT(X)+1,^TMP($J,X,DA)=""
 I 'COUNT W !!,"There are no active equipment records whose MANUFACTURER EQUIPMENT NAME",!,"is "_MEN_"." L -^ENG("MEN",MEN) S MEN="" G MEN1
 W !!,"There are "_COUNT_" active equipment records whose MANUFACTURER EQUIPMENT",!,"NAME is "_MEN_". Do you wish to proceed?"
 S DIR(0)="Y",DIR("B")="YES"
 D ^DIR K DIR I $D(DIRUT) S ESCAPE=1 Q
 I COUNT("PRE"),'$D(CRITER) D OVERWRT^ENY2K8 Q:$G(ESCAPE)
 S ENY2K("CONT")=Y I 'ENY2K("CONT") L -^ENG("MEN",MEN) S MEN="" G MEN1
 Q
 ;
EXIT K ^TMP($J)
 Q
 ;ENY2KA
