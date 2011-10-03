LEXEDF1 ; ISL Edit/Display a Definition (Part 1)   ; 05/14/2003
 ;;2.0;LEXICON UTILITY;**3,25**;Sep 23, 1996
 ;
 N DIC,DIE,DIR,DIROUT,DIRUT,DLAYGO,DR,DTOUT,DUOUT,DA,X,Y
 N LEX,LEXAID,LEXC,LEXDIC0,LEXE,LEXI,LEXL,LEXLC
 N LEXMC,LEXME,LEXMP,LEXS,LEXSAV,LEXST,LEXTY,LEXX
 K X I $D(DUZ)#2=0 G EXIT
ASK ; Ask user to select an expression to edit the definition
 N LEXAP S DIC("A")="Enter a concept to edit definition:  "
 S:'$D(DIC(0)) DIC(0)="QEAM" S LEXAP=1 D ^LEXA1 I X=""!(+Y'>0) G EXIT
 I +Y<3,+Y>0 D  G EXIT
 . W !,"The definition for ",^LEX(757.01,+Y,0)," is not editable"
 S LEXE=$$EXP^LEXEDF2(+Y) G:'$D(LEXE) EXIT
 ;
 I LEXE="" D  G:'$D(LEXE) ASK G:LEXE="" EXIT
 . W !!,"No selection made, try again using the same concept"
AGAIN . ; Ask user to try again using the same expression
 . S %=2 D YN^DICN S DIC(0)=$S(%=1:"QEM",1:"QEAM")
 . S LEXE=$S(%=-1:"",%=2:"",1:%) K:LEXE=% LEXE W:%=1 ! Q:%'=0
 . I '% D  G AGAIN
 . . W !!,"You were given various forms of an expression "
 . . W "(concept, synonyms and"
 . . W !,"lexical variants) to select from.  "
 . . W "Do you wish to try again using"
 . . W !,"the same concept"
 D:+($G(LEXE))>1&($D(^LEX(757.01,+($G(LEXE)),0))) EDIT(LEXE) G EXIT  ; PCH 3
EDIT(LEXE) ; Edit the expression definition
 W !,$E(^LEX(757.01,LEXE,0),1,78),! K ^TMP("LEXDEF",$J)
 G:'$D(LEXE) EDITQ
 S LEXMP=0 I $D(^LEX(757.01,LEXE,3,0)) D
 . S ^TMP("LEXDEF",$J,4)="Old Definition:"
 . S ^TMP("LEXDEF",$J,5)=^LEX(757.01,LEXE,3,0),(LEXMP,LEXLC)=0
 . F  S LEXLC=$O(^LEX(757.01,LEXE,3,LEXLC)) Q:+LEXLC=0  D
 . . S LEXMP=LEXLC+5
 . . S ^TMP("LEXDEF",$J,LEXMP)=^LEX(757.01,LEXE,3,LEXLC,0)
 N LEXDIC0 S DA=+LEXE,DIE="^LEX(757.01,",DR="6"
 S:DIC(0)'["L" DIC(0)=DIC(0)_"L" S LEXDIC0=DIC(0),DLAYGO=757
 L +^LEX(757.01,LEXE):1
 I '$T D  G EDITQ
 . W !,"This record is being edited by "
 . W "another user, try again later"
 S LEXSAV=0 D SNAP^LEXEDF2(+LEXE),^DIE,SHOT^LEXEDF2(+LEXE)
 S LEX=$$CHANGE^LEXEDF2
 I +LEX>0 S LEXSAV=$$SAVE^LEXEDF2
 I 'LEXSAV,+LEX>0 D RESTORE^LEXEDF2(+LEXE)
 K DLAYGO,LEXDIC0 L -^LEX(757.01,LEXE) G:+LEX=0!(+LEXSAV=0) RESULTS
 I $D(^LEX(757.01,LEXE,3,0)) D
 . S ^TMP("LEXDEF",$J,1)="TXT:  "_^LEX(757.01,LEXE,0)
 . S ^TMP("LEXDEF",$J,2)="IFN:  "_LEXE,^TMP("LEXDEF",$J,3)=""
 S:LEXMP=0 LEXMP=2
 I $D(^LEX(757.01,LEXE,3,0)) D
 . S ^TMP("LEXDEF",$J,(LEXMP+1))=""
 . S ^TMP("LEXDEF",$J,LEXMP+2)="New Definition:"
 . S ^TMP("LEXDEF",$J,LEXMP+3)=^LEX(757.01,LEXE,3,0)
 . S LEXMP=LEXMP+4
 . S LEXLC=0 F  S LEXLC=$O(^LEX(757.01,LEXE,3,LEXLC)) Q:+LEXLC=0  D
 . . S ^TMP("LEXDEF",$J,LEXMP)=^LEX(757.01,LEXE,3,LEXLC,0)
 . . S LEXMP=LEXMP+1
 D:+LEX>0&(+LEXSAV>0) SENDDEF
RESULTS ; Display results of edit
 I +LEXSAV=0 D
 . I +LEX W !,"Changes to the definition were not saved" Q
 . W !,"No changes made"
 I +LEXSAV>0 W !,$P(LEX,U,2)
EDITQ ; Quit edit
 K DIC,DIE,DIR,DLAYGO,DR,LEX,LEXAID,LEXC,LEXDIC0
 K LEXE,LEXI,LEXL,LEXLC,LEXMC,LEXME,LEXMP,LEXS
 K LEXSAV,LEXST,LEXTY,LEXX,^TMP("LEXDEF",$J) Q
DISP(LEXX) ; Display a definition
 Q:+($G(LEXX))=0  I '$D(^LEX(757.01,LEXX,3,1,0)) Q
 N X S X=0 F  S X=$O(^LEX(757.01,LEXX,3,X)) Q:+X=0  D
 . W:X=1 !!,"Definition:  ",! W !,^LEX(757.01,LEXX,3,X,0)
 Q
EXIT ; Clean up and exit
 K DIC,DIE,DIR,DLAYGO,DR,DA,X,Y,LEX,LEXAID,LEXC,LEXDIC0
 K LEXE,LEXI,LEXL,LEXLC,LEXMC,LEXME,LEXMP,LEXS
 K LEXSAV,LEXST,LEXTY,LEXX,^TMP("LEXDEF",$J) Q
SENDDEF ; Send edited definition to ISC
 N DIFROM,LEXADR K XMZ Q:'$D(^TMP("LEXDEF",$J))  S LEXADR=$$ADR^LEXU Q:'$L(LEXADR)
 S XMSUB=$P(LEX,U,2)_" in Expression File (#757.01)"
 S XMY(("G.LEXICON@"_LEXADR))=""
 S XMTEXT="^TMP(""LEXDEF"",$J,",XMDUZ=.5 D ^XMD
 K ^TMP("LEXDEF",$J),XCNP,XMDUZ,XMY("G.LEXICON@ISC-SLC.VA.GOV"),XMZ
 K XMSUB,XMY,XMTEXT
 Q
