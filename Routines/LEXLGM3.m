LEXLGM3 ;ISL/KER - Lexicon Survey (Terms in PL) ;01/03/2011
 ;;2.0;LEXICON UTILITY;**73**;Sep 23, 1996;Build 10
 ;
 Q
PLPL ; Problems in Problem List
 N LEXPLS S LEXPLS=$G(^AUPNPROB(0)),LEXPLS=+($P(LEXPLS,"^",4))
 S LEXS=LEXPLS_" "_$S(LEXPLS=1:"Problem",1:"Problems")_" Found"
 D SET2^LEXLGM(LEXS)
 Q
PLT ; Problem List Title
 N LEXV S LEXV=$G(LEXVERS)
 I +LEXV=0 S LEXS="Lexicon Terms in Problem List " D SET^LEXLGM(LEXS),BL^LEXLGM Q
 I +LEXV>0 S LEXS="Lexicon v"_LEXV_" Terms in Problem List " D SET^LEXLGM(LEXS),BL^LEXLGM Q
 Q
ASOF ; As of date
 I LEXDT'="" D  Q
 . S LEXS="    As of:" D SET^LEXLGM(LEXS)
 . S LEXS="    "_LEXDT D SET2^LEXLGM(LEXS)
 . D BL^LEXLGM
 Q
PLUR ; Problem List Survey of Lexicon Terms
 N LEXN0,LEXN1,LEXDA,LEXPL,LEXUN,LEXUC,LEXCO,LEXPT
 S (LEXDA,LEXPL,LEXUN,LEXUC,LEXCO,LEXPT)=0
 S LEXPT=+($$CODEN^ICDCODE(799.9)) Q:LEXPT=0
 F  S LEXDA=$O(^AUPNPROB(LEXDA)) Q:+LEXDA=0  D
 . S LEXN0=$G(^AUPNPROB(LEXDA,0))
 . S LEXN1=$G(^AUPNPROB(LEXDA,1))
 . I +LEXN1>1,+LEXN0=LEXPT S LEXUC=LEXUC+1
 . I +LEXN1=1,+LEXN0=LEXPT S LEXUN=LEXUN+1
 . I +LEXN1>1,+LEXN0'=LEXPT S LEXCO=LEXCO+1
 . S LEXPL=LEXPL+1
 I $G(LEXTYPE)'="O" D  Q
 . S LEXS="    "_LEXPL_" "_$S(LEXPL=1:"Problem",1:"Problems")_" Found" D SET^LEXLGM(LEXS)
 . S LEXS="    "_LEXUN_" Unresolved "_$S(LEXUN=1:"Problem",1:"Problems") D SET2^LEXLGM(LEXS)
 . S LEXS="    "_LEXUC_" Uncoded "_$S(LEXUC=1:"Problem",1:"Problems") D SET^LEXLGM(LEXS)
 . S LEXS="    "_LEXCO_" Coded "_$S(LEXCO=1:"Problem",1:"Problems") D SET2^LEXLGM(LEXS)
 I $G(LEXTYPE)="O" D  Q
 . ; Problems found
 . S LEXS="    "_$S(LEXPL=1:"Problem",1:"Problems")_" Found" D SET^LEXLGM(LEXS)
 . S LEXS=$J(LEXPL,8) D SET2^LEXLGM(LEXS)
 . ; Unresolved
 . S LEXS="    Unresolved "_$S(LEXUN=1:"Problem",1:"Problems") D SET^LEXLGM(LEXS)
 . S LEXS=$J(LEXUN,8) D SET2^LEXLGM(LEXS)
 . ; Uncoded
 . S LEXS="    Uncoded "_$S(LEXUC=1:"Problem",1:"Problems") D SET^LEXLGM(LEXS)
 . S LEXS=$J(LEXUC,8) D SET2^LEXLGM(LEXS)
 . ; Coded
 . S LEXS="    Coded "_$S(LEXCO=1:"Problem",1:"Problems") D SET^LEXLGM(LEXS)
 . S LEXS=$J(LEXCO,8) D SET2^LEXLGM(LEXS)
 Q
