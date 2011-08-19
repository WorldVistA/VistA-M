EASECSU3 ;ALB/LBD - LTC Co-Pay Test Screen Variable Utilities Cont. ;14 AUG 2001
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**5,7,40**;Mar 15, 2001
 ;
INC ;Determine income, expense and net worth
 ; Input  -- DFN      Patient file IEN
 ;           DGCOMF   LTC Co-Pay Test Completion Flag  (Optional)
 ;                    (1 if completing LTC co-pay test)
 ;           DGMTDT   Date of Test
 ;           DGMTI    Annual Means Test IEN
 ;           DGVINI   Veteran Individual Annual Income IEN
 ;           DGSP     Spouse 1=YES and 0=NO (mt income)
 ;           DGDC     Dependent children 1=YES and 0=NO (mt income)
 ;           DGMTPAR  Annual Means Test Parameters
 ; Output -- DGIN0    Annual Income 0th node array (income)
 ;           DGIN1    Annual Income 1 node array (expense)
 ;           DGIN2    Annual Income 2 node array (net worth)
 ;           DGINT    Total income
 ;           DGDET    Total deductible expenses
 ;           DGNWT    Total net worth
 ;           DGINTF   Income flag
 ;           DGNWTF   Net worth flag
 N DGCNT,DGINC,DGINR,I,J,Y
 D ALL^EASECU21(DFN,"VCS",DGMTDT,"IR",$S($G(DGMTI):DGMTI,1:""))
 S DGIN0("V")=$G(^DGMT(408.21,DGVINI,0)),DGIN1("V")=$G(^(1)),DGIN2("V")=$G(^(2))
 S DGINT=$$TOT^DGMTSCU1(DGIN0("V"),6,17)+$$TOT^DGMTSCU1(DGIN0("V"),19,20)
 S DGDET=$$TOT^DGMTSCU1(DGIN1("V"),1,10)
 S DGNWT=$$TOT^DGMTSCU1(DGIN2("V"),1,4)+$$TOT^DGMTSCU1(DGIN2("V"),6,9)
 I $G(DGCOMF) D MT(DGINR("V"),DGMTI)
 I DGSP S (DGIN0("S"),DGIN1("S"),DGIN2("S"))="" D SPOUSE:$D(DGINC("S"))
 ; dependent child income is not included for LTC co-pay test
 ;I DGDC S (DGIN0("C"),DGIN1("C"))="",DGCNT=0 F  S DGCNT=$O(DGINC("C",DGCNT)) Q:'DGCNT  D CHK^DGMTSCU2,CHILD:Y
 S DGINTF=$S(DGINT:1,1:0)
 S DGNWTF=$S(DGNWT:1,1:0)
 Q
 ;
SPOUSE ;Determine spouse income and net worth
 S DGIN0("S")=$G(^DGMT(408.21,DGINC("S"),0)),DGIN1("S")=$G(^(1)),DGIN2("S")=$G(^(2))
 S DGINT=DGINT+$$TOT^DGMTSCU1(DGIN0("S"),6,17)+$$TOT^DGMTSCU1(DGIN0("S"),19,20)
 ; Added next line for LTC Phase IV (EAS*1*40)
 S DGNWT=DGNWT+$$TOT^DGMTSCU1(DGIN2("S"),1,4)+$$TOT^DGMTSCU1(DGIN2("S"),6,9)
 I $G(DGCOMF) D MT(DGINR("S"),DGMTI)
SPOUSEQ Q
 ;
CHILD ;Determine total dependent children(s) income and expense
 N DGCE,DGEMP,I,X
 S X=$G(^DGMT(408.21,DGINC("C",DGCNT),0)) F I=8:1:17 I $P(X,"^",I)]"" S $P(DGIN0("C"),"^",I)=$P(DGIN0("C"),"^",I)+$P(X,"^",I)
 S DGEMP=$P(X,"^",14),DGINT=DGINT+$$TOT^DGMTSCU1(X,8,17)
 S X=$G(^DGMT(408.21,DGINC("C",DGCNT),1)) I $P(X,"^",3)]"" S $P(DGIN1("C"),"^",3)=$P(DGIN1("C"),"^",3)+$P(X,"^",3)
 S DGCE=(DGEMP-$P(DGMTPAR,"^",17))-$P(X,"^",3)
 S DGDET=DGDET+DGEMP-$S($G(DGCE)>0:DGCE,1:0)
 I $G(DGCOMF) D MT(DGINR("C",DGCNT),DGMTI)
CHILDQ Q
 ;
MT(DGINR,DGMTI) ;Update Income Relation file with Means Test IEN
 ;         Input  -- DGINR  Income Relation IEN
 ;                   DGMTI  Annual Means Test IEN
 ;         Output -- Update Means Test IEN
 N DA,DIE,DR
 S DA=DGINR,DIE="^DGMT(408.22,",DR="31////^S X="_DGMTI D ^DIE
 Q
 ;
DEP ;Determine dependent data
 ; Input  -- DFN     Patient file IEN
 ;           DGMTDT  Date of Test
 ;           DGVIRI  Veteran Income Relation IEN
 ; Output -- DGVIR0  Veteran Income Relation 0th node
 ;           DGSP    Spouse 1=YES and 0=NO (mt income)
 ;           DGDC    Dependent children 1=YES and 0=NO (mt income)
 ;           DGNC    Number of dependent children
 ;           DGND    Total number of dependents
 N DGCNT,DGDEP,DGINR,DGREL,Y
 S DGVIR0=$G(^DGMT(408.22,DGVIRI,0)) D ALL^EASECU21(DFN,"SC",DGMTDT,"PR",$S($G(DGMTI):DGMTI,1:""))
 ;Include spouse's income for LTC co-pay if vet is married
 ;If vet is legally separated, do not include spouse's income. Added for
 ;LTC Phase IV (EAS*1*40)
 S DGSP=$S('$P(DGVIR0,U,14):0,$P(DGVIR0,U,17):0,'$G(DGREL("S")):0,1:1)
 ;Child's income is not included for LTC co-pay test
 S DGDC=0
 S DGNC=+$P(DGVIR0,"^",13)
 S DGND=DGSP+DGNC
 Q
