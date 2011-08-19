LEXHLP ; ISL Help/input transformations              ; 05/25/1998
 ;;2.0;LEXICON UTILITY;**11**;Sep 23, 1996
 ;
EXC ; Excluded Word Help
 I '$D(X) Q
 S X=$$UP^XLFSTR(X) I $D(^LEX(757.05,"AB",$E(X,1,40))) D  Q
 . W !!,$C(7),"""",X,""""," already exist in the Replacement Words file."
 . W !,"You can not exclude a word which is to be replaced",!!
 . K X
 S X=$$UP^XLFSTR(X) I $D(^LEX(757.04,"C",$E(X,1,40))) D  Q
 . W !!,$C(7),"""",X,""""," already exist in the Replacement Words file."
 . W !,"You can not exclude a replacement word",!!
 . K X
 Q
REP ; Replacement Words Help (replace)
 I '$D(X) Q
 S X=$$UP^XLFSTR(X) I $D(^LEX(757.04,"AB",$E(X,1,40))) D  Q
 . W !!,$C(7),"""",X,""""," already exist in the Excluded Words file."
 . W !,"You can not replace an excluded word.",!!
 . K X
 I $D(^LEX(757.01,"AWRD",X)) D  Q
 . W !!,$C(7),"""",X,""""," is indexed as a key word for: ",!
 . S LEXREC=0 F  S LEXREC=$O(^LEX(757.01,"AWRD",X,LEXREC)) Q:+LEXREC=0  D
 . . W !,?2,^LEX(757.01,LEXREC,0)
 . W !!,"You can not alter this keyword/term linkage.",!!
 . K LEXREC,X
 Q
REPBY ; Replacement Words Help (insert)
 I '$D(X) Q
 S X=$$UP^XLFSTR(X) I $D(^LEX(757.04,"AB",$E(X,1,40))) D  Q
 . W !!,$C(7),"""",X,""""," already exist in the Excluded Words file."
 . W !,"You can not replace an excluded word.",!!
 . K X
 Q
APPS(X) ; Input Help for ^LEX(757.2 field 8
 N LEXOK S LEXOK=1
 I '$D(X)!('$D(DA)) Q 0
 I $L(X)>3!($L(X)<3) W !,"3 characters, please ",! Q 0
 N LEXI,LEXC F LEXI=1:1:3 S LEXC=$A($E(X,LEXI)) D
 . I ((LEXC>64)&(LEXC<91))!((LEXC>47)&(LEXC<58)) Q
 . S LEXOK=0
 K LEXI,LEXC
 I 'LEXOK K LEXOK W !,"Invalid characters detected, use any combination of uppercase or numeric ",! Q 0
 I X=$P(^LEXT(757.2,DA,0),"^",2) W !,"Cannot be the same as the Short TitLe",LEXOK,! Q 0
 Q 1
XTLK ; MTLY Help
 ;      Uses ^TMP("XTLKHITS",$J), XTLKH, XTLKI, XTLKKSCH("DSPLY"),
 ;      XTLKKSCH("GBL"), XTLKMULT, XTLKREF0 and XTLKREF1
 N LEXHLPF S LEXHLPF=1
 Q:'$D(XTLKHLP)  D XTLKONE:^TMP("XTLKHITS",$J)=1,XTLKSEL:^TMP("XTLKHITS",$J)>1 Q
XTLKONE ; Help for a single entry on the selection list
 N LEXMC,LEXLN
 S LEXMC=$S(LEXSUB="WRD":$P(^LEX(757.01,XTLKI,1),U,1),1:$P(^LEX(757.01,+(@(DIC_XTLKI_",0)")),1),U,1))
 S LEXEXP=0 S:+LEXMC>0 LEXEXP=+(^LEX(757,LEXMC,0))
 I +LEXEXP'=0,$D(^LEX(757.01,LEXEXP,3,0)) D
 . F LEXLN=1:1:$P(^LEX(757.01,LEXEXP,3,0),U,4) D
 . . I $D(^LEX(757.01,LEXEXP,3,LEXLN,0)) W !,?2,^LEX(757.01,LEXEXP,3,LEXLN,0)
 . . I '(+(LEXLN#5)) D XTLKCON
 I $D(LEXLN),(+(LEXLN#5)) D XTLKCON W !
 I +LEXEXP'=0,'$D(^LEX(757.01,LEXEXP,3,0)) W !,"Only one match found, select:  ",^LEX(757.01,$S(LEXSUB="WRD":XTLKI,1:+(@(DIC_XTLKI_",0)"))),0),!
 K LEXEXP,LEXMC,LEXLN Q
XTLKSEL ; Help for a multiple entries on the selection list
 I X?1"?"1N.N!(X?2"?"1N.N) D XTLKDEF,XTLKEND W:XTLKH<6 !! Q
 D XTLKEND,XTLKRED Q
XTLKDEF ; Display an Expression Defintion as part of the Help
 S X=$E(X,2,$L(X)) G:X["?" XTLKDEF I +X<1!(+X>XTLKH) Q
 N LEXMC,LEXLN,LEXEXP
 S LEXMC=$S(LEXSUB="WRD":$P(^LEX(757.01,^TMP("XTLKHITS",$J,+X),1),U,1),1:$P(^LEX(757.01,+(@(DIC_^TMP("XTLKHITS",$J,+X)_",0)")),1),U,1))
 S LEXEXP=0 S:+LEXMC>0 LEXEXP=+(^LEX(757,LEXMC,0)) I +LEXEXP'=0,$D(^LEX(757.01,LEXEXP,3,0)) D
 . F LEXLN=1:1:$P(^LEX(757.01,LEXEXP,3,0),U,4) D
 . . I $D(^LEX(757.01,LEXEXP,3,LEXLN,0)) D
 . . . W:LEXLN=1 ! W !,?2,^LEX(757.01,LEXEXP,3,LEXLN,0)
 . . I '(+(LEXLN#5)) D XTLKCON
 I $D(LEXLN),(+(LEXLN#5)) D XTLKCON
 ; W !
 K LEXMC,LEXLN,LEXEXP Q
XTLKCON ; End of Page
 Q:'$D(VALM)  W ! N X,Y,DTOUT,DUOUT,DIRUT,DIROUT,DIR
 S DIR("A")="Press <Return> to continue  "
 S DIR("?")="Press the <Return> key to continue  ",DIR(0)="EA" D ^DIR Q
XTLKEND ; End of Help
 W !!,"Answer with # (1-",XTLKH,"), ^ (quit), ^# (jump - ",^TMP("XTLKHITS",$J)," choices), or ?# (help on a term)" Q
XTLKRED ; Post-Help, redisplay the last segment of the list
 N LEXSTRT,LEXEND S LEXSTRT=(((XTLKH-1)\5)*5)+1,LEXEND=XTLKH
 F XTLKH=LEXSTRT:1:LEXEND D
 . S (Y,XTLKI)=^TMP("XTLKHITS",$J,XTLKH)
 . S XTLKREF0=XTLKREF1_XTLKI_",0)" W:XTLKH=1 !!
 . I $D(XTLKKSCH("DSPLY")) D @XTLKKSCH("DSPLY") Q
 . W:XTLKMULT $J(XTLKH,4),": " W $P(@(XTLKREF1_"XTLKI,0)"),"^",1),!
 W ! K LEXSTRT,LEXEND Q
SUB(LEXS) ; Subset help
 W ! N X,Y,LEXDICA,LEXDIC0,LEXDICW,LEXDIC S LEXS=""
 S:$D(DIC)#2>0 LEXDIC=DIC S:$D(DIC(0)) LEXDIC0=DIC(0) S:$D(DIC("A")) LEXDICA=DIC("A") S:$D(DIC("W")) LEXDICW=DIC("W")
 S DIC("A")="Enter the name of a vocabulary to use:  ",DIC("W")="",DIC(0)="AEQM",DIC="^LEXT(757.2," D ^DIC
 I +Y>0,$D(^LEXT(757.2,+Y,0)) D
 . I $P(^LEXT(757.2,+Y,0),"^",2)'="" S LEXS=$P(^LEXT(757.2,+Y,0),"^",2) Q
 . I $D(^LEXT(757.2,+Y,5)),$P(^LEXT(757.2,+Y,5),"^",1)'="" S LEXS=$P(^LEXT(757.2,+Y,5),"^",1) Q
 S:$D(LEXDIC) DIC=LEXDIC S:$D(LEXDICW) DIC("W")=LEXDICW S:$D(LEXDIC0) DIC(0)=LEXDIC0 S:$D(LEXDICA) DIC("A")=LEXDICA K:'$D(LEXDICA) DIC("A")
 Q LEXS
SQ(X) ; Single question mark help for DIR("?") based on DIC("S")  PCH 11
 N LEXD,LEXI,LEXA,LEXT,LEXC,LEXN,LEXJ
 I $D(^TMP("LEXSCH",$J)) D
 . S LEXD=$G(^TMP("LEXSCH",$J,"FIL",0)),LEXI=$G(^TMP("LEXSCH",$J,"IDX",0)),LEXA=$G(^TMP("LEXSCH",$J,"APP",1))
 I '$D(^TMP("LEXSCH",$J)) D
 . N LEXTNS,LEXTSS,LEXONS,LEXOSS
 . S (LEXONS,LEXTNS)=$G(LEXAP),LEXTNS=+LEXTNS S:LEXTNS=0 LEXTNS=1
 . S (LEXOSS,LEXTSS)=$G(LEXSUB) S:LEXTSS="" LEXTSS="WRD"
 . D CONFIG^LEXSET(LEXTNS,LEXTSS)
 . S LEXD=$G(^TMP("LEXSCH",$J,"FIL",0)),LEXI=$G(^TMP("LEXSCH",$J,"IDX",0)),LEXA=$G(^TMP("LEXSCH",$J,"APP",1))
 . K ^TMP("LEXSCH",$J) S:$L(LEXONS) LEXAP=LEXONS S:$L(LEXOSS) LEXSUB=LEXOSS
 S (LEXT,LEXC)="",X=""
 S:'$L($G(LEXD))&($L($G(DIC("S")))) LEXD=$G(DIC("S"))
 I $L($G(LEXI)),$G(LEXI)'["WRD" D  Q X
 . F LEXJ="DEN;Dental","IMM;Immunologic","NUR;Nursing","SOC;Social Work" S:LEXI[$P(LEXJ,";",1) LEXT=" "_$P(LEXJ,";",2)
 . S X="Enter a ""free text"""_LEXT_" term"
 I $L($G(LEXD)) D  Q X
 . I LEXD'["SRC^LEXU" D  Q
 . . F LEXJ="ICD;ICD","CPT;CPT","CPC;HCPCS","DS4;DSM","NAN;NANDA" D
 . . . S:LEXD[$P(LEXJ,";",1)&(LEXC'[$P(LEXJ,";",2)) LEXC=LEXC_", "_$P(LEXJ,";",2)
 . . . S:LEXD[$P(LEXJ,";",1)&("NAN^ICD^DSM^DS4^DS3"[$P(LEXJ,";",1))&(LEXT'["diagnosis") LEXT=LEXT_"/diagnosis"
 . . . S:LEXD[$P(LEXJ,";",1)&("CPT^CPC"[$P(LEXJ,";",1))&(LEXT'["procedure") LEXT=LEXT_"/procedure"
 . . S:$E(LEXT,1)="/" LEXT=$E(LEXT,2,$L(LEXT)) S:$E(LEXC,1,2)=", " LEXC=$E(LEXC,3,$L(LEXC))
 . . S:$L(LEXC,", ")>1 LEXC=$P(LEXC,", ",1,($L(LEXC,", ")-1))_" or "_$P(LEXC,", ",$L(LEXC,", ")) S:$L(LEXC) LEXC=$S($E(LEXC,1)="I":("an "_LEXC),1:("a "_LEXC)) S:$L(LEXC) LEXC=LEXC_" code"
 . . S X="Enter a ""free text""" S:$L(LEXT) X=X_" "_LEXT S:'$L(LEXT) X=X_" term" S:$L(LEXC) X=X_" or "_LEXC
 . I LEXD["SRC^LEXU",$L(LEXA) D  Q
 . . N LEXN1,LEXN2 S LEXN1=LEXA,LEXN2="" I LEXA[" (",$L($P($P(LEXA," (",2),")",1)) D
 . . . S LEXN1=$P(LEXA," (",1),LEXN2="("_$P(LEXA," (",2),LEXN2=$P(LEXN2,")",1)_")"
 . . S X="Enter a ""free text""" S:$L(LEXN1) X=X_" "_LEXN1 S:$L(LEXN2) X=X_" "_LEXN2 S X=X_" term"
 S X="Enter a ""free text"" term"
 Q X
