LEXQD ;ISL/KER - Query - Defaults ;10/30/2008
 ;;2.0;LEXICON UTILITY;**62**;Sep 23, 1996;Build 16
 ;               
 ; Global Variables
 ;    ^%ZOSF("TEST")      ICR  10096
 ;    ^XTMP(              SACC 2.3.2.5.2
 ;               
 ; External References
 ;    ^DIM                ICR  10016
 ;    $$GET1^DIQ          ICR   2056
 ;    $$DT^XLFDT          ICR  10103
 ;    $$FMADD^XLFDT       ICR  10103
 ;               
 ; Save/Retrieve Defaults
 ;               
 ;    X       Routine Name
 ;    Y       Routine Tag
 ;    LEXN    Number (DUZ)
 ;    LEXC    Comment
 ;    LEXV    Value (default to save)
 ;    LEXRTN  Routine Name (X)
 ;    LEXTAG  Routine Tag (Y)
 ;    LEXKEY  $E(COM,1,13)
 ;    LEXID   LEXRTN_LEXN_LEXKEY
 ;    
 ;    ^XTMP(LEXID,0)=FUTURE DATE^TODAY'S DATE^LEXC
 ;    ^XTMP(LEXID,LEXTAG)=LEXV
 ;               
SAV(X,Y,LEXN,LEXC,LEXV) ; Save Defaults
 N LEXRTN,LEXTAG,LEXUSR,LEXCOM,LEXVAL,LEXNM,LEXID,LEXTD,LEXFD,LEXKEY S LEXRTN=$G(X) Q:+($$ROK(LEXRTN))'>0  S LEXTAG=$G(Y) Q:+($$TAG((LEXTAG_"^"_LEXRTN)))'>0
 S LEXUSR=+($G(LEXN)),LEXVAL=$G(LEXV) Q:LEXUSR'>0  Q:'$L(LEXVAL)  S LEXCOM=$G(LEXC) Q:'$L(LEXCOM)  S LEXKEY=$E(LEXCOM,1,13) F  Q:$L(LEXKEY)>12  S LEXKEY=LEXKEY_" "
 S LEXNM=$$GET1^DIQ(200,(LEXUSR_","),.01) Q:'$L(LEXNM)  S LEXTD=$$DT^XLFDT,LEXFD=$$FMADD^XLFDT(LEXTD,30),LEXID=LEXRTN_" "_LEXUSR_" "_LEXKEY
 S ^XTMP(LEXID,0)=LEXFD_"^"_LEXTD_"^"_LEXCOM,^XTMP(LEXID,LEXTAG)=LEXVAL
 Q
RET(X,Y,LEXN,LEXC) ; Retrieve Defaults
 N LEXRTN,LEXTAG,LEXUSR,LEXCOM,LEXNM,LEXID,LEXTD,LEXFD,LEXKEY S LEXRTN=$G(X) Q:+($$ROK(LEXRTN))'>0 ""
 S LEXTAG=$G(Y) Q:+($$TAG((LEXTAG_"^"_LEXRTN)))'>0 ""  S LEXUSR=+($G(LEXN)) Q:LEXUSR'>0 ""
 S LEXCOM=$G(LEXC) Q:'$L(LEXCOM) ""  S LEXKEY=$E(LEXCOM,1,13) F  Q:$L(LEXKEY)>12  S LEXKEY=LEXKEY_" "
 S LEXNM=$$GET1^DIQ(200,(LEXUSR_","),.01) Q:'$L(LEXNM) ""  S LEXTD=$$DT^XLFDT,LEXFD=$$FMADD^XLFDT(LEXTD,30),LEXID=LEXRTN_" "_LEXUSR_" "_LEXKEY
 S X=$G(^XTMP(LEXID,LEXTAG))
 Q X
 ;               
 ; Miscellaneous
PUR ;   Purge Defaults
 N LEXID S LEXID="LEXP~" F  S LEXID=$O(^XTMP(LEXID)) Q:'$L(LEXID)  Q:$E(LEXID,1,4)'="LEXQ"  K:$E(LEXID,1,4)="LEXQ" ^XTMP(LEXID)
 Q
SDF ;   Show Defaults
 N LEXN,LEXC S LEXN="^XTMP(""LEXQ"")",LEXC="^XTMP(""LEXQ" F  S LEXN=$Q(@LEXN) Q:'$L(LEXN)!(LEXN'[LEXC)  W !,LEXN,"=",@LEXN
 Q
ROK(X) ;   Routine OK
 S X=$G(X) Q:'$L(X) 0  Q:$L(X)>8 0  X ^%ZOSF("TEST") Q:$T 1  Q 0
TAG(X) ;   Sub-Routine OK
 N LEXT,LEXE,LEXL S X=$G(X) Q:'$L(X) 0  Q:X'["^" 0
 Q:'$L($P(X,"^",1)) 0  Q:$L($P(X,"^",1))>8 0  Q:$E($P(X,"^",1),1)'?1U 0
 Q:'$L($P(X,"^",2)) 0  Q:$L($P(X,"^",2))>8 0  Q:$E($P(X,"^",2),1)'?1U 0
 S LEXL=0,LEXT=X,(LEXE,X)="S LEXL=$L($T("_X_"))" D ^DIM X:$D(X) LEXE
 S X=$S(LEXL>0:1,1:0)
 Q X
