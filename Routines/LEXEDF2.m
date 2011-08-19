LEXEDF2 ; ISL Edit/Display a Definition (Part 2)   ; 09-23-96
 ;;2.0;LEXICON UTILITY;;Sep 23, 1996
 ;
EXP(LEXX) ; Select an expression
 N Y,LEXS,LEXC,LEXMC,LEXE,LEXI,LEXME S Y=LEXX,(LEXS,LEXC)=0
 S LEXMC=$P($G(^LEX(757.01,+Y,1)),U,1),LEXME=$P(^LEX(757,LEXMC,0),U,1)
 S ^TMP("LEXE",$J,0)=1,^TMP("LEXE",$J,1)=LEXME,(LEXI,LEXE)=0
 F  S LEXI=$O(^LEX(757.01,"AMC",LEXMC,LEXI)) Q:+LEXI=0  D
 . I +($P($G(^LEX(757.01,LEXI,1)),U,2))>1,+($P($G(^LEX(757.01,LEXI,1)),U,2))<4 D
 . . S ^TMP("LEXE",$J,0)=^TMP("LEXE",$J,0)+1
 . . S ^TMP("LEXE",$J,^TMP("LEXE",$J,0))=LEXI
 W ! W $S(^TMP("LEXE",$J,0)>1:"",1:"Only "),^TMP("LEXE",$J,0)
 W $S(^TMP("LEXE",$J,0)>1:" expressions were ",1:" expression was ")
 W "found representing the selected concept:"
 W:^TMP("LEXE",$J,0)=1 !
 I $D(^TMP("LEXE",$J,0)),^TMP("LEXE",$J,0)>1 D
MULTI . ; Multiple expression found
 . K LEXE
 . F LEXC=1:1:^TMP("LEXE",$J,0) Q:((LEXS>0)&(LEXS<LEXC+1))  D
 . . W:LEXC#5=1 ! W !,$J(LEXC,4),": "
 . . N LEXTY S LEXTY=$$TYPE(^TMP("LEXE",$J,LEXC)) W LEXTY
 . . W $E(^LEX(757.01,^TMP("LEXE",$J,LEXC),0),1,64)
 . . W:LEXC#5=0 ! S:LEXC#5=0 LEXS=$$SEL
 . . I LEXS>0&(LEXS<LEXC+1) S LEXE=^TMP("LEXE",$J,LEXS) Q
 . I LEXC#5'=0,+LEXS=0 D
 . . W ! S LEXS=$$SEL
 . . I LEXS>0&(LEXS<LEXC+1) S LEXE=^TMP("LEXE",$J,LEXS)
 I $D(^TMP("LEXE",$J,0)),^TMP("LEXE",$J,0)=1 D
ONE . ; One expression found
 . K LEXE N LEXTY
 . S LEXTY=$$TYPE(^TMP("LEXE",$J,1)) W LEXTY
 . W $E(^LEX(757.01,^TMP("LEXE",$J,1),0),1,69)
 . W !," OK" S %=1 D YN^DICN D:'% EXPHLP G:'% ONE
 . S:%=1 LEXE=^TMP("LEXE",$J,1) S:%=-1!(%=2) LEXE="" K %,%Y
 S:'$D(LEXE) LEXE=0 K ^TMP("LEXE",$J),LEXC,LEXS,LEXMC
 S LEXX=LEXE Q LEXX
SEL(X) ; Select expression
 N Y,DTOUT,DUOUT,DIRUT,DIROUT S DIR("A")="Select 1-"_LEXC_":  "
 S DIR("?")="Answer must be from 1 to "_LEXC_", or <Return> to continue"
 S DIR("??")="^D EXPHLP^LEXEDF2"
 S DIR(0)="NAO^1:"_LEXC_":0" D ^DIR S:$D(DTOUT)!(X[U) X=U K DIR Q X
EXPHLP ; Selection help
 W !!,"There are several types of expressions "
 W "which can represent a concept:"
 W !!,"    Major Concept"
 W !,"    Synonym of the Concept"
 W !,"    Lexical Variant of the Concept"
 W !,"    Lexical Variant of a Synonym of the Concept"
 I $D(^TMP("LEXE",$J,0)),^TMP("LEXE",$J,0)>1 D
 . W !!,"You may edit any of these forms of expressions.",!
 . N LEXST,LEXI S:LEXC#5<1 LEXST=1
 . S:LEXC#5>0 LEXST=(((LEXC\5)*5)+1)
 . F LEXI=LEXST:1:LEXC D
 . . W !,$J(LEXI,4),": "
 . . N LEXTY S LEXTY=$$TYPE(^TMP("LEXE",$J,LEXI)) W LEXTY
 . . W $E(^LEX(757.01,^TMP("LEXE",$J,LEXI),0),1,64)
 I $D(^TMP("LEXE",$J,0)),^TMP("LEXE",$J,0)=1 D
 . W !!,"In this case, there are no Synonyms or "
 . W "Lexical Variants to select from,"
 . W !,"you can only edit the Concept",!
 Q
TYPE(LEXX) ; Expression type
 S LEXX=$P(^LEX(757.01,LEXX,1),U,2)
 S:LEXX=1 LEXX="Concept  - " S:LEXX=2 LEXX="Synonym  - " S:LEXX=3 LEXX="Variant  - "
 S:LEXX=991 LEXX="Related  - " S:LEXX=992 LEXX="Modified - " S:LEXX'["-" LEXX="Other    - "
 Q LEXX
SNAP(LEXX) ; Picture of definition before edit
 Q:+($G(LEXX))'>2  S LEXX=+LEXX
 S:'$D(LEXAID) LEXAID="SNAP" K LEX(LEXAID)
 I '$D(^LEX(757.01,LEXX,3,0)) K LEXAID Q
 N LEXC,LEXL S (LEXC,LEXL)=0
 S:$D(^LEX(757.01,LEXX,3,0)) LEX(LEXAID)=^LEX(757.01,LEXX,3,0)
 F  S LEXC=$O(^LEX(757.01,LEXX,3,LEXC)) Q:+LEXC=0  D
 . S LEXL=LEXL+1,LEX(LEXAID,LEXL)=^LEX(757.01,LEXX,3,LEXC,0)
 S:+LEXL>0 LEX(LEXAID,0)=LEXL K LEXAID
 Q
SHOT(LEXX) ; Picture of definition after edit
 S LEXAID="SHOT" D SNAP(LEXX) K LEXAID Q
CHANGE(LEXX) ; Detect change in definition before/after edit
 S LEXX=""
 I '$D(LEX("SNAP")),'$D(LEX("SHOT")) Q "0^Definition not Change"
 I '$D(LEX("SNAP")),$D(LEX("SHOT")) Q "1^Definition Added"
 I $D(LEX("SNAP")),'$D(LEX("SHOT")) Q "1^Definition Deleted"
 I LEX("SNAP",0)'=LEX("SHOT",0) Q "1^Definition Changed"
 N LEXC F LEXC=1:1:LEX("SNAP",0) Q:+LEXC=0!($L($G(LEXX),"^")>1)  D
 . I LEX("SNAP",LEXC)'=LEX("SHOT",LEXC) D
 . . S LEXX="1^Definition Changed"
 I $L($G(LEXX),"^")'>1 S LEXX="0^Definition not Changed"
 Q LEXX
RESTORE(LEXX) ; Restore original definition
 I '$D(LEX("SNAP")) K ^LEX(757.01,LEXX,3) Q
 N LEXC S LEXC=0 K ^LEX(757.01,LEXX,3)
 S ^LEX(757.01,LEXX,3,0)=LEX("SNAP")
 F  S LEXC=$O(LEX("SNAP",LEXC)) Q:+LEXC=0  D
 . S ^LEX(757.01,LEXX,3,LEXC,0)=LEX("SNAP",LEXC)
 Q
SAVE(LEXX) ; Save the edit
 N DTOUT,DUOUT,DIR S DIR(0)="Y^AO"
 S DIR("?",1)="By answering ""Yes"" the proposed changes you have made to"
 S DIR("?")="the definition during this edit session will be stored."
 S DIR("A")="Make changes permanent",DIR("B")="YES"
 D ^DIR K DIR S LEXX=+Y S:$D(DTOUT)!($D(DUOUT)) LEXX=0 Q LEXX
