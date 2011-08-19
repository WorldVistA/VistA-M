DGMTSC31 ;ALB/RMO,ERC - Means Test Screen Deductible Expenses Cont. ; 13 MAR 92
 ;;5.3;Registration;**45,688**;Aug 13, 1993;Build 29
 ;
 ; Input  -- DFN      Patient IEN
 ;           DGMTDT   Date of Test
 ;           DGMTPAR  Annual Means Test Parameter Array
 ; Output -- None
 ;
EN ;Entry point for dependent children
 S DGFL=0 K DGDCS D SET
 W !!,"Enter:  R to REDISPLAY information on dependent children"
 I DGDEP W !?8,"1-",DGDEP," to edit information for the child listed after that number"
 R !,"Enter CHOICE: ",X:DTIME I '$T!(X["^") S DGFL=$S(X["^":-1,1:-2) G Q
 G:X']"" Q I X["?" G EN
 ;DG*5.3*688 - removing code to set X to $E(X), as we can
 ;have >9 dependent children now
 D UP^DGHELP
 I X="R" D DIS G EN:'DGFL,Q
 I 'X!'$D(DGDCS(X)) G EN ; not numeric or bad answer
 S DGINI=+$G(DGINC("C",DGDCS(X)))
 I $G(^DGMT(408.21,DGINI,0)),($P(^(0),"^",14)-$P(DGMTPAR,"^",17))'>0 W !!?8,"Post-secondary education expenses are not applicable for this child." G EN
 D EDT:DGINI G EN:'DGFL
Q I DGFL<0 S DGMTOUT=1
 K DGDCS,DGDEP,DGFL,DGINC,DGINR,DGINI,DGREL,DTOUT,DUOUT,X
 Q
 ;
SET ;Set variables for selectable dependent children ;DGMTP also calls
 N DGCNT,Y
 D ALL^DGMTU21(DFN,"C",DGMTDT,"IPR",$S($G(DGMTI):DGMTI,1:""))
 I $P(DGMTPAR,"^",17)']"" G SETQ ;quit if no child's income exclusion
 S (DGCNT,DGDEP)=0 F  S DGCNT=$O(DGREL("C",DGCNT)) Q:'DGCNT  D
 .D CHK I Y S DGDEP=DGDEP+1,DGDCS(DGDEP)=DGCNT
SETQ Q
 ;
DIS ;Display dependent children with employment income
 N DGLP
 W !!?8,"Child's",?24,"Employment",?36,"Post-secondary"
 W !?8,"First Name",?24,"Income",?36,"Education Expenses"
 W !?8,"------------",?24,"----------",?36,"------------------"
 S DGLP=0 F  S DGLP=$O(DGDCS(DGLP)) Q:'DGLP  S DGCNT=DGDCS(DGLP) D CHILD
 Q
 ;
CHILD ;Display employment income and expenses for a dependent child
 N DGIN0,DGIN1
 S DGIN0=$G(^DGMT(408.21,+$G(DGINC("C",DGCNT)),0)),DGIN1=$G(^(1))
 W !?4,DGLP,".",?8,$E($P($$NAME^DGMTU1(+DGREL("C",DGCNT)),",",2),1,12)
 W ?24,$J($$AMT^DGMTSCU1($P(DGIN0,"^",14)),10)
 W ?44,$J($S(($P(DGIN0,"^",14)-$P(DGMTPAR,"^",17))>0:$$AMT^DGMTSCU1($P(DGIN1,"^",3)),1:"N/A"),10)
 Q
 ;
CHK ;Check if child has income available to the veteran and his/her own
 ;employment income
 S Y=0
 I $D(^DGMT(408.22,+$G(DGINR("C",DGCNT)),0)),$P(^(0),"^",11),$P(^(0),"^",12),$P($G(^DGMT(408.21,+$G(DGINC("C",DGCNT)),0)),"^",14) S Y=1
 Q
 ;
EDT ;Edit dependent child expenses
 N DA,DGFIN,DGIN1,DIE,DR
 S DGIN1=$G(^DGMT(408.21,DGINI,1))
 S DA=DGINI,DIE="^DGMT(408.21,",DR="[DGMT ENTER/EDIT CHILD EXPENSES]" D ^DIE
 S:'$D(DGFIN) DGFL=$S($D(DTOUT):-2,$D(DUOUT):-1,1:0)
 I DGIN1'=$G(^DGMT(408.21,DGINI,1)) S DR="103////^S X=DUZ;104///^S X=""NOW""" D ^DIE
 Q
