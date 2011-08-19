LEXAR4 ;ISL/KER - Look-up Response (Select Entry) ;11/30/2008
 ;;2.0;LEXICON UTILITY;**4,5,6,25,55**;Sep 23, 1996;Build 11
 ;
 ; External References
 ;   DBIA 10086  HOME^%ZIS
 ;   DBIA 10063  ^%ZTLOAD
 ;   DBIA 10018  ^DIE
 ;                    
SEL(LEXUR,LEXVDT) ; Select # on list
 K LEX("SEL") N LEXLVL,LEXMAX,LEXLF S LEXLF=1,LEXMAX=+($G(^TMP("LEXSCH",$J,"LST",0)))
 S LEX=+($G(LEX)),LEXUR=+($G(LEXUR))
 I LEXMAX=0!(LEX=0) D EDA^LEXAR G SELQ
 K LEX("ERR"),LEX("SEL") I LEXUR'>0!(LEXUR>LEXMAX) D  G SELQ
 . S LEX("ERR",0)=+($G(LEX("ERR",0)))+1
 . S LEX("ERR",LEX("ERR",0))="User response out of range"
 I '$D(^TMP("LEXHIT",$J,LEXUR)) D  G SELQ
 . S LEX("ERR",0)=+($G(LEX("ERR",0)))+1
 . S LEX("ERR",LEX("ERR",0))="Selection is either out of range or invalid"
 N LEXEXP S LEXEXP=+($P(^TMP("LEXHIT",$J,LEXUR),"^",1))
 I '$D(^LEX(757.01,LEXEXP,0)) D  G SELQ
 . S LEX("ERR",0)=+($G(LEX("ERR",0)))+1
 . S LEX("ERR",LEX("ERR",0))="Selection not found in the Lexicon"
 ; Set concept level, if modifiers are allowed build list
 S LEXLVL=+($G(LEX("LVL"))) I LEXLVL'>1,+LEXEXP>2,$D(^LEX(757.01,+LEXEXP,0)),+($G(^TMP("LEXSCH",$J,"MOD",0)))>0 D EN^LEXAMD(LEXEXP,$G(LEXVDT))
 ; Quit if modifiers found at next level
 G:+($G(LEX("LVL")))>LEXLVL SELQ
 D SET(LEXEXP,$G(LEXVDT)),EDU^LEXAR
 G SELQ
SET(LEXEXP,LEXVDT) ; Set LEX("SEL") Nodes
 K LEX("SEL") D SETEXP^LEXAR5(LEXEXP)
 N LEXMC S LEXMC=+($P(^LEX(757.01,LEXEXP,1),"^",1))
 ; If selected from the list increment frequency
 D:+($G(^TMP("LEXSCH",$J,"LST",0)))>0&(+($G(^TMP("LEXSCH",$J,"APP",0)))>1) INC(LEXMC)
 N LEXMCE S LEXMCE=+(^LEX(757,LEXMC,0))
 D SETSRC^LEXAR5(LEXEXP,$G(LEXVDT))
 D:'$D(LEX("SEL","SRC","D",LEXMCE))&(LEXMCE'=LEXEXP) SETSRC^LEXAR5(LEXMCE,$G(LEXVDT))
 D SETDEF^LEXAR5(LEXMCE)
 D SETSTY^LEXAR5(LEXMC)
 N LEXE S LEXE=0 F  S LEXE=$O(^LEX(757.01,"AMC",LEXMC,LEXE)) Q:+LEXE=0  D
 . Q:LEXE=LEXEXP  D SETEXP^LEXAR5(LEXE),SETSRC^LEXAR5(LEXE,$G(LEXVDT))
 G:+($G(LEXLF))=0 SELQ
 Q
INC(LEXMC) ; Increment frequency counter in ^LEX(757)
 N LEXF,LEXFQ S LEXMC=+($G(LEXMC)) Q:LEXMC=0  Q:'$D(^LEX(757,LEXMC))
 S ZTSAVE("LEXMC")="",ZTRTN="FQ^LEXAR4",ZTDESC="Updating Lexicon Frequencies",ZTIO="",ZTDTH=$H
 D ^%ZTLOAD,HOME^%ZIS K Y,ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN
 Q
FQ ; Edit Concept Frequency
 N LEXA,LEXM,LEXQ,LEXS,DA,DIC,DIE S:$D(ZTQUEUED) ZTREQ="@"
 S LEXM=+($G(LEXMC)) Q:LEXM=0  Q:'$D(^LEX(757,LEXM,0))
 I '$D(^LEX(757.001,LEXM,0)) D AFQ G FQQ
 S LEXQ=+($P($G(^LEX(757.001,LEXM,0)),"^",3)),LEXQ=LEXQ+1
 S DA=+($G(LEXM)) Q:+DA=0  Q:'$D(^LEX(757.001,DA,0))
 S LEXM=+($G(LEXMC)) Q:'$D(^LEX(757,LEXMC,0))  S LEXA=0
 S (DIC,DIE)="^LEX(757.001,",DR="2////^S X=LEXQ"
EFQ ; Lock record and edit frequency record
 L +^LEX(757.001,+DA):1 I '$T S LEXA=LEXA+1 H 2 G:LEXA<4 EFQ
 D:LEXA<4 ^DIE L -^LEX(757.001,+DA)
 G FQQ
 Q
AFQ ; Add frequency record
 N DIC,DA S ^LEX(757.001,LEXM,0)=LEXM_"^0^0" S DIC="^LEX(757.001,",DA=LEXM D SET^LEXNDX2 Q
 Q
FQQ ; Quit Frequency
 Q
SELQ ; Quit Selection
 D:$D(LEX("SEL")) SEL^LEXAR
 D:$D(LEX("LIST")) LST^LEXAR
 Q
