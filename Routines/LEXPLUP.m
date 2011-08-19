LEXPLUP ;ISL/KER - Problem List Update 799.9 ;01/03/2011
 ;;2.0;LEXICON UTILITY;**73**;Sep 23, 1996;Build 10
 ;
 ; Fixes ICD code 799.9 for Problems which have a Lexicon pointer
 ; greater than 2, and which may have been updated in a later version
 ; (Lexicon term exported without ICD, and later assigned an ICD)
 ;
 ; EN^LEXPLUP         Entry point to fix updated 799.9s
 ;
 ; EN2^LEXPLUP(X)     Entry point to fix updated 799.9s and 
 ;                    returns the number of updated 799.9s fixed
 ;
 ; EN3^LEXPLUP        Entry point to to Task EN^LEXPLUP
 ;
 Q
EN ; Entry to fix exact match
 S:$D(ZTQUEUED) ZTREQ="@"
 N LEXCNT S LEXCNT=0 D UP Q
EN2(X) ; Entry to fix exact match and return # fixed
 N LEXCNT S LEXCNT=0 D UP S X=LEXCNT Q X
EN3 ; Task EN^LEXPLUP
 S ZTRTN="EN^LEXPLUP",ZTDESC="Update 799.9s in Prob List # 9000011",ZTIO="",ZTDTH=$H D ^%ZTLOAD,HOME^%ZIS K Y,ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN Q
UP ; Exact match 
 N DA,DIC,DIE,DR,DTOUT,LEXAT,LEXICD,LEXISO,LEXLEX,LEXNIC,LEXNIP,LEXUNP,X,Y
 S LEXUNP=+($$CODEN^ICDCODE(799.9,80)) Q:LEXUNP=0  S DA=0 F  S DA=$O(^AUPNPROB(DA)) Q:+DA=0  D
 . N LEXTMP,LEXSTA S LEXICD=$P($G(^AUPNPROB(DA,0)),"^",1) Q:LEXICD'=LEXUNP  S LEXTMP=$$ICDDX^ICDCODE(+LEXICD),LEXSTA=$P(LEXTMP,"^",10)
 . S LEXISO=$P(LEXTMP,"^",2) Q:LEXISO'=799.9  S LEXLEX=$P($G(^AUPNPROB(DA,1)),"^",1) Q:LEXLEX'>2
 . S LEXNIC=$$ICDONE^LEXU(+LEXLEX) Q:LEXNIC=""  S LEXNIP=0 S:$L(LEXNIC) LEXNIP=+($$CODEN^ICDCODE(LEXNIC,80)) Q:LEXNIP=0
 . I +LEXLEX>2,$D(^LEX(757.01,+LEXLEX,0)),+LEXNIP>0 D EDIT
 Q
EDIT ; Edit Problem
 N LEXAT S LEXAT=0,DA=+($G(DA)) Q:'$D(^AUPNPROB(DA,0))  Q:'$D(^AUPNPROB(DA,1))  S LEXNIP=+($G(LEXNIP)) Q:LEXNIP'>0
 S (DIE,DIC)="^AUPNPROB(",DR=".01////^S X=LEXNIP"
ED2 ; Record is Locked
 L +^AUPNPROB(DA):1 I '$T,LEXAT'>5 S LEXAT=LEXAT+1 H 2 G ED2
 G:LEXAT>5 EDQ D ^DIE L -^AUPNPROB(DA)
EDQ ; Edit Quit
 I $P($G(^AUPNPROB(DA,0)),"^",1)=LEXNIP S LEXCNT=+($G(LEXCNT))+1
 Q
