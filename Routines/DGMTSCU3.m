DGMTSCU3 ;ALB/RMO - Means Test Screen Variable Utilities Cont. ;4 MAY 1992 7:45 am
 ;;5.3;Registration;**45,688**;Aug 13, 1993;Build 29
 ;
INC ;Determine income, expense and net worth
 ; Input  -- DFN      Patient file IEN
 ;           DGCOMF   Means Test Completion Flag  (Optional)
 ;                    (1 if completing means test)
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
 D ALL^DGMTU21(DFN,"VCS",DGMTDT,"IR",$S($G(DGMTI):DGMTI,1:""))
 S DGIN0("V")=$G(^DGMT(408.21,DGVINI,0)),DGIN1("V")=$G(^(1)),DGIN2("V")=$G(^(2))
 S DGINT=$$TOT^DGMTSCU1(DGIN0("V"),8,17)
 S DGDET=$$TOT^DGMTSCU1(DGIN1("V"),1,3)
 S DGNWT=$$TOT^DGMTSCU1(DGIN2("V"),1,4)-$P(DGIN2("V"),"^",5)
 I $G(DGCOMF) D MT(DGINR("V"),DGMTI)
 I DGSP S (DGIN0("S"),DGIN1("S"),DGIN2("S"))="" D SPOUSE:$D(DGINC("S"))
 I DGDC S (DGIN0("C"),DGIN1("C"))="",DGIN2("C")="",DGCNT=0 F  S DGCNT=$O(DGINC("C",DGCNT)) Q:'DGCNT  D CHK^DGMTSCU2,CHILD:Y
 S DGINTF=$S(DGINT:1,1:0) I 'DGINTF S J="" F  S J=$O(DGIN0(J)) Q:J=""!(DGINTF)  F I=8:1:17 Q:DGINTF  S:$P(DGIN0(J),"^",I)]"" DGINTF=1
 S DGNWTF=$S(DGNWT:1,1:0) I 'DGNWTF S J="" F  S J=$O(DGIN2(J)) Q:J=""!(DGNWTF)  F I=1:1:5 Q:DGNWTF  S:$P(DGIN2(J),"^",I)]"" DGNWTF=1
 Q
 ;
SPOUSE ;Determine spouse income and net worth
 S DGIN0("S")=$G(^DGMT(408.21,DGINC("S"),0)),DGIN1("S")=$G(^(1)),DGIN2("S")=$G(^(2))
 S DGINT=DGINT+$$TOT^DGMTSCU1(DGIN0("S"),8,17)
 S DGNWT=DGNWT+($$TOT^DGMTSCU1(DGIN2("S"),1,4)-$P(DGIN2("S"),"^",5))
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
 S X=$G(^DGMT(408.21,DGINC("C",DGCNT),2))
 F I=1:1:9 I $P(X,"^",I)]"" S $P(DGIN2("C"),"^",I)=$P(DGIN2("C"),"^",I)+$P(X,"^",I)
 S DGNWT=DGNWT+($$TOT^DGMTSCU1(X,1,4)-$P(X,"^",5))
CHILDQ Q
 ;
MT(DGINR,DGMTI) ;Update Means Test IEN in Individual Annual Income file
 ;         Input  -- DGINR  Income Relation IEN
 ;                   DGMTI  Annual Means Test IEN
 ;         Output -- Update Means Test IEN
 N DA,DIE,DR
 S DA=DGINR,DIE="^DGMT(408.22,",DR="31////^S X="_DGMTI D ^DIE
 Q
