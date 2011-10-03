LEXPLEM ;ISL/KER - Problem List Exact Match URs ;01/03/2011
 ;;2.0;LEXICON UTILITY;**73**;Sep 23, 1996;Build 10
 ;
 ; Fixes unresolved narratives which have an exact match in the
 ; Lexicon by changing the Lexicon pointer from 1 (unresolved)
 ; to point to the exact match term.
 ;
 ; EN^LEXPLEM         Entry point to fix exact match unresolved 
 ;                    narratives
 ;
 ; EN2^LEXPLEM(X)     Entry point to fix exact match unresolved 
 ;                    narratives and return the number of exact
 ;                    match terms fixed.
 ;
 ; EN3^LEXPLEM        Entry point to to Task EN^LEXPLEM
 ;
 Q
EN ; Entry to fix exact match
 N LEXCNT S LEXCNT=0 D EM S:$D(ZTQUEUED) ZTREQ="@" Q
EN2(X) ; Entry to fix exact match and return # fixed
 N LEXCNT S LEXCNT=0 D EM S X=LEXCNT Q X
EN3 ; Task EN^LEXPLEM
 S ZTRTN="EN^LEXPLEM",ZTDESC="Exact Match URs in Prob List # 9000011",ZTIO="",ZTDTH=$H D ^%ZTLOAD,HOME^%ZIS K Y,ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN Q
EM ; Exact match on a term
 N DA,DIC,DIE,DR,DTOUT,LEXAT,LEXDA,LEXEX,LEXEXM,LEXICD,LEXISO
 N LEXLEX,LEXNAR,LEXNIC,LEXNIP,LEXO,LEXOD,LEXOS,LEXPOV,LEXUNP
 N LEXX,LEXXU,X,Y
 S LEXEXM=0,LEXUNP=+($$CODEN^ICDCODE(799.9,80)) Q:LEXUNP=0  S DA=0
 F  S DA=$O(^AUPNPROB(DA)) Q:+DA=0  D
 . N LEXDAT,LEXTMP,LEXII,LEXSTA,LEXNSO S LEXICD=$P($G(^AUPNPROB(DA,0)),"^",1),LEXDAT=$$ICDDX^ICDCODE(+LEXICD,$G(DT)),LEXISO=$P(LEXDAT,"^",2)
 . S LEXLEX=$P($G(^AUPNPROB(DA,1)),"^",1) Q:LEXLEX'=1
 . S LEXPOV=+($P($G(^AUPNPROB(DA,0)),"^",5)) Q:LEXPOV=0
 . S LEXNAR=$P($G(^AUTNPOV(LEXPOV,0)),"^",1) Q:'$L(LEXNAR)
 . S LEXNSO=$E($P(LEXNAR," ",1),1,8),LEXII=$$CODEN^ICDCODE(LEXNSO),LEXTMP="" S:LEXII>0 LEXTMP=$$ICDDX^ICDCODE(LEXNSO,$G(DT))
 . I LEXLEX=1,+LEXII>0,$P(LEXTMP,"^",10)>0 D  Q
 . . S LEXEXM=$$FC(LEXNAR) Q:+LEXEXM'>2  S LEXNIC=$$ICDONE^LEXU(+LEXEXM)
 . . S LEXNIP=0 S:$L(LEXNIC) LEXNIP=+($$CODEN^ICDCODE(LEXNIC,80)) I +LEXEXM>2,$D(^LEX(757.01,+LEXEXM,0)) D EDIT
 . S LEXEXM=$$FE(LEXNAR)
 . Q:+LEXEXM'>2  S LEXNIC=$$ICDONE^LEXU(+LEXEXM)
 . S LEXNIP=0 S:$L(LEXNIC) LEXNIP=+($$CODEN^ICDCODE(LEXNIC,80))
 . I +LEXEXM>2,$D(^LEX(757.01,+LEXEXM,0)) D EDIT Q
 Q
EDIT ; Edit Problem
 N LEXAT S LEXAT=0,DA=+($G(DA))
 Q:'$D(^AUPNPROB(DA,0))  Q:'$D(^AUPNPROB(DA,1))
 S LEXEXM=+($G(LEXEXM))
 Q:'$D(^LEX(757.01,LEXEXM,0))
 S LEXNIP=+($G(LEXNIP))
 S (DIE,DIC)="^AUPNPROB(" S DR="1.01////^S X=LEXEXM"
 I +LEXNIP>0,$D(^ICD9(+LEXNIP,0)),LEXICD=LEXUNP S DR=".01////^S X=LEXNIP;1.01////^S X=LEXEXM"
ED2 ; Record is Locked
 L +^AUPNPROB(DA):1 I '$T,LEXAT'>5 S LEXAT=LEXAT+1 H 2 G ED2
 G:LEXAT>5 EDQ D ^DIE L -^AUPNPROB(DA)
EDQ ; Edit Quit
 I $P($G(^AUPNPROB(DA,0)),"^",1)=LEXNIP,$P($G(^AUPNPROB(DA,1)),"^",1)=LEXEXM S LEXCNT=+($G(LEXCNT))+1
 Q
FE(X) ; Find Exact Match on a term return IEN
 S X=$G(X) Q:'$L(X) -1  N LEXX S LEXX=$G(X),X=-1 Q:'$L(LEXX) -1
 N LEXO,LEXOD,LEXOS,LEXDA,LEXEX,LEXXU S X=-1,LEXXU=$$UP(LEXX),LEXOD=$$UP($E(LEXX,1,60)),LEXO=0 I $L(LEXOD) D
 . Q:'$D(^LEX(757.01,"B",LEXOD))&($E($O(^LEX(757.01,"B",LEXOD)),1,$L(LEXOD))'=LEXOD)  S LEXOS=$$SCH(LEXOD) F  S LEXOS=$O(^LEX(757.01,"B",LEXOS)) Q:LEXOS=""!($E(LEXOS,1,$L(LEXOD))'=LEXOD)  D
 . . S LEXDA=0 F  S LEXDA=$O(^LEX(757.01,"B",LEXOS,LEXDA)) Q:+LEXDA=0!($$UP($G(^LEX(757.01,+LEXDA,0)))'[LEXOD)  S LEXEX=$G(^LEX(757.01,+LEXDA,0)) I $$UP(LEXEX)=LEXXU S LEXO=LEXDA_"^"_LEXEX
 S LEXO=+($G(LEXO)) I LEXO>0 S:'$D(^LEX(757.01,LEXO,0)) X=-1 S:$D(^LEX(757.01,LEXO,0)) X=LEXO_"^"_$G(^LEX(757.01,LEXO,0))
 Q X
FC(X) ; Find Exact Match on an ICD Code return IEN
 S X=$G(X) Q:'$L(X) -1  N LEXX,LEXII,LEXTMP S LEXX=$E($G(X),1,9),X=-1 Q:'$L(LEXX) -1
 S LEXII=+($$CODEN^ICDCODE(LEXX,80)) Q:+LEXII'>0 -1  S LEXTMP=$$ICDDX^ICDCODE(+LEXII,$G(DT)) Q:+($P(LEXTMP,"^",10))'>0 -1
 ;
 N LEXSD,LEXEX,LEXI,LEXP
 S LEXSD=0
 F  S LEXSD=$O(^LEX(757.02,"ACODE",(LEXX_" "),LEXSD)) Q:+LEXSD=0  D
 . S LEXEX=+($P($G(^LEX(757.02,LEXSD,0)),"^",1)) Q:'$D(^LEX(757.01,LEXEX,0))
 . Q:$$ICDONE^LEXU(LEXEX)=""
 . Q:$P($G(^LEX(757.02,LEXSD,0)),"^",2)'=LEXX  Q:+($P($G(^LEX(757.02,LEXSD,0)),"^",3))'=1
 . S LEXI(0)=+($G(LEXI(0)))+1,LEXI(LEXI(0))=LEXEX
 . I +($P($G(^LEX(757.02,LEXSD,0)),"^",5))=1 D
 . . S LEXP(0)=+($G(LEXP(0)))+1,LEXP(LEXP(0))=LEXEX
 I $D(LEXP),+($G(LEXP(0)))=1 S LEXX=+($G(LEXP(1))) S:+LEXX>2&($D(^LEX(757.01,+LEXX,0))) X=LEXX Q X
 I $D(LEXI),+($G(LEXI(0)))=1 S LEXX=+($G(LEXI(1))) S:+LEXX>2&($D(^LEX(757.01,+LEXX,0))) X=LEXX Q X
 Q X
SCH(LEXX) ; Create $O variable
 S LEXX=$E(LEXX,1,($L(LEXX)-1))_$C($A($E(LEXX,$L(LEXX)))-1)_"~" Q LEXX
UP(LEXX) ; Uppercase
 Q $TR($G(LEXX),"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
