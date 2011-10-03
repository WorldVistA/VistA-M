VASITE ;ALB/AAS - TIME SENSETIVE VA STATION NUMBER UTILITY ; 4/22/92
 ;;5.3;Registration;**134**;Aug 13, 1993
 ;
SITE(DATE,DIV) ;
 ;       -Output= Institution file pointer^Institution name^station number with suffix
 ;
 ;       -Input (optional) date for division, if undefined will use DT
 ;       -      (optional) medical center division=pointer in 40.8
 ;
 N PRIM,SITE
 S:'$D(DATE) DATE=DT
 S:'$D(DIV) DIV=$$PRIM(DATE)
 I DATE'?7N!DIV<0 Q -1
 S PRIM=$G(^VA(389.9,+$O(^(+$O(^VA(389.9,"AIVDT",DIV,$$IVDATE(DATE))),0)),0))
 S SITE=$S('$P(PRIM,"^",6)&($P(PRIM,"^",4)?3N.AN):$P(PRIM,"^",4),1:-1)
 S:SITE>0 SITE=$P(^DG(40.8,DIV,0),"^",7)_"^"_$P($G(^DIC(4,$P(^DG(40.8,DIV,0),"^",7),0)),"^")_"^"_SITE
 Q SITE
 ;
ALL(DATE) ; -returns all possible station numbers 
 ;         -input date, if date is undefined, then date will be today
 ;          - output VASITE= 1 or -1 if stations exist
 ;                   VASITE(station number)=station number
 ;
 N PRIM,DIV
 S:'$D(DATE) DATE=DT
 S VASITE=-1
 S DIV=0 F  S DIV=$O(^VA(389.9,"C",DIV)) Q:'DIV  S PRIM=$G(^VA(389.9,+$O(^(+$O(^VA(389.9,"AIVDT",DIV,$$IVDATE(DATE))),0)),0)) S:'$P(PRIM,"^",6)&($P(PRIM,"^",4)?3N) VASITE($P(PRIM,"^",4))=$P(PRIM,"^",4),VASITE=1
 Q VASITE
 ;
IVDATE(DATE) ; -- inverse date reference start
 Q -(DATE+.000001)
 ;
CHK ;  -input transform for IS PRIMARY STATION? field
 ;  -only 1 primary station number allowed per effective date
 ;
 I '$P(^VA(389.9,DA,0),"^",2) W !,"Effective Date must be entered first" K X G CHKQ
 I '$P(^VA(389.9,DA,0),"^",3) W !,"Medical Center Division must be entered first.",! K X G CHKQ
 I $D(^VA(389.9,"AIVDT1",1,-X)) W !,"Another entry Is Primary Division for this date.",! K X G CHKQ
 I 1
CHKQ I 0 Q
 ;
YN ;  -input transform for is primary facility
 I '$P(^VA(389.9,DA,0),"^",2) W !,"Effective date must be entered first!" K X Q
 I '$P(^VA(389.9,DA,0),"^",3) W !,"Medical Center Division must be entered first!" K X Q
 I $D(^VA(389.9,"AIVDT1",1,-$P(^VA(389.9,DA,0),"^",2))) W !,"Only one division can be primary division for an effective date!" K X Q
 S X=$E(X),X=$S(X=1:X,X=0:X,X="Y":1,X="y":1,X="n":0,X="N":0,1:2) I X'=2 W "  (",$S(X:"YES",1:"NO"),")" Q
 W !?4,"NOT A VALID CHOICE!",*7 K X Q
 ;
PRIM(DATE) ;  -returns medical center division of primary medical center division
 ;          - input date, if date is null then date will be today
 ;
 N PRIM
 S:'$D(DATE) DATE=DT S DATE=DATE+.24
 S PRIM=$G(^VA(389.9,+$O(^(+$O(^VA(389.9,"AIVDT1",1,$$IVDATE(DATE))),0)),0))
 Q $S($P(PRIM,"^",4)?3N:$P(PRIM,"^",3),1:-1)
 ;
NAME(DATE) ;  -returns the new name of medical centers that have integrated
 ;
 ;          -input date, if date is null then date will be today
 S:'$D(DATE) DATE=DT S DATE=DATE+.24
 Q $G(^VA(389.9,+$O(^(+$O(^VA(389.9,"AIVDT1",1,$$IVDATE(DATE))),0)),"INTEG"))
