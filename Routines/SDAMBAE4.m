SDAMBAE4 ;ALB/BOK/MJK - ADD/EDIT CON'T ; 3 FEB 1988@1210
 ;;5.3;Scheduling;**111,132**;Aug 13, 1993
 ;
COUNT ; how many procs in a visit
 N SDSCI,SDAMB,Y
 S X=0 F SDSCI=0:0 S SDSCI=$O(^SDV(D0,"CS",SDSCI)) Q:'SDSCI  I $D(^(SDSCI,"PR")) S Y=^("PR") F SDAMB=1:1:5 S:$P(Y,U,SDAMB) X=X+1
 Q
 ;
TOTAL ; -- reimbursement for a visit
 ;  RAM REIMB not used, file deleted w/ CPT 6.0/ SD*5.3*111
 S X=""
 Q
 ;
LOCAL ; -- local cost for visit ; same as TOTAL but uses 'local cost' where
 ;    available
 ;  RAM REIMB not used, file deleted w/ CPT 6.0/ SD*5.3*111
 S X=""
 Q
 ;
STATUS ; -- amb proc status
 ;    X = proc ; X1 = date
 N % S %=""
 S %=$$CPT^ICPTCOD(+X,+X1)
 I %<0 S X="" Q  ; if error returned
 S %=$P(%,U,7) ; pull status from string
 S X=$S('%:"INACTIVE",1:"ACTIVE")
 Q
