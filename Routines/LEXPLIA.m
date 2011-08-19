LEXPLIA ;ISL/KER - Problem List In-Active ICD Codes ;01/03/2011
 ;;2.0;LEXICON UTILITY;**73**;Sep 23, 1996;Build 10
 ;
 ; Fixes ICD pointers in the Problem List to In-Active ICD Codes
 ; or 6 Digit ICD Codes where the Lexicon pointer is greater 
 ; than 2 (source of pointer is the Lexicon) to a valid ICD and
 ; active ICD Code.
 ;
 ; EN^LEXPLIA         Entry point to fix in-active ICD
 ;
 ; EN2^LEXPLIA(X)     Entry point to fix in-active ICD and
 ;                    return the number of in-active codes fixed
 ;
 ; EN3^LEXPLIA        Entry point to to Task EN^LEXPLIA
 ;
 Q
EN ; Entry to fix exact match
 N LEXCNT S LEXCNT=0 D EM S:$D(ZTQUEUED) ZTREQ="@" Q
EN2(X) ; Entry to fix exact match and return # fixed
 N LEXCNT S LEXCNT=0 D EM S X=LEXCNT Q X
EN3 ; Task EN^LEXPLIA
 S ZTRTN="EN^LEXPLIA",ZTDESC="In-Active ICD Codes in Prob List # 9000011",ZTIO="",ZTDTH=$H D ^%ZTLOAD,HOME^%ZIS K Y,ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN Q
EM ; Exact match 
 N DA,DIC,DIE,DR,DTOUT,LEXAT,LEXICD,LEXIIA,LEXISO,LEXLEX,LEXNIC,LEXNIP
 S DA=0 F  S DA=$O(^AUPNPROB(DA)) Q:+DA=0  D
 . N LEXTMP,LEXSTA
 . S LEXICD=+($P($G(^AUPNPROB(DA,0)),"^",1)) S LEXTMP=$$ICDDX^ICDCODE(+LEXICD),LEXSTA=$P(LEXTMP,"^",10)
 . Q:LEXICD'>0  S LEXIIA=$S(+LEXSTA>0:0,1:1),LEXISO=$P(LEXTMP,"^",2) Q:'$L(LEXISO)  S LEXLEX=+($P($G(^AUPNPROB(DA,1)),"^",1)) Q:LEXLEX'>2
 . I $L($P(LEXISO,".",2))>2!(LEXIIA=1) D
 . . S LEXNIC=$$ICDONE^LEXU(+LEXLEX) Q:LEXNIC=""  S LEXNIP=0 S:$L(LEXNIC) LEXNIP=+($$CODEN^ICDCODE(LEXNIC))
 . . Q:LEXNIP=0  Q:$P($$ICDDX^ICDCODE(+LEXNIP),"^",10)'>0  D EDIT
 Q
EDIT ; Edit Problem
 N LEXAT S LEXAT=0 S DA=+($G(DA)) Q:'$D(^AUPNPROB(DA,0))  S LEXNIP=+($G(LEXNIP)) Q:'$D(^ICD9(LEXNIP,0))  S (DIE,DIC)="^AUPNPROB(",DR=".01////^S X=LEXNIP"
ED2 ; Record is Locked
 L +^AUPNPROB(DA):1 I '$T,LEXAT'>5 S LEXAT=LEXAT+1 H 2 G ED2
 G:LEXAT>5 EDQ D ^DIE L -^AUPNPROB(DA)
EDQ ; Edit Quit
 I $P($G(^AUPNPROB(DA,0)),"^",1)=LEXNIP S LEXCNT=+($G(LEXCNT))+1
 Q
