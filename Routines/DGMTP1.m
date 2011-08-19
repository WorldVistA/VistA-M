DGMTP1 ;ALB/RMO - Print Means Test 10-10F Cont. ;7 APR 1992 11:00 am
 ;;5.3;Registration;;Aug 13, 1993
 ;
EN ;Entry point to print demograpic, marital status and dependents
 D DEM,MAR,DEP,EN^DGMTP2
Q Q
 ;
DEM ;Print demographic portion of form
 W @IOF,?116,"VA FORM 10-10F",!,DGLNE,!,"DEPARTMENT OF VETERANS AFFAIRS",?111,"FINANCIAL WORKSHEET",!,DGLNE
 W !?30,"THE LAW PROVIDES SEVERE PENALTIES FOR WILLFUL SUBMISSION OF FALSE INFORMATION",!?39,"SEE PAGE 3 FOR PRIVACY ACT AND PAPERWORK REDUCTION ACT INFORMATION",!,DGLNE
 W !?1,"Applicant's Name:  ",$$NAME^DGMTU1(DGVPRI),?72,"| Social Security Number:  ",$$SSN^DGMTU1(DGVPRI)
 Q
 ;
MAR ;Print marital status
 W !,DGLNE,!!?61,"A. Marital Status",$$UL^DGMTSCU1(DGUL,DGLNE1)
 W !?1,"1. Were you married last calendar year.",?41,"| 2. Did you live with your spouse",?78,"| 3. If you did not live with your spouse, show the"
 W !?4,"(If ""NO"", go to Section B).",?41,"| last calendar year. (If ""YES"", go",?78,"| amount you contributed to your spouse's support"
 W !?6,$$YN^DGMTSCU1($P(DGVIR0,"^",5))
 W ?41,"| to Section B).    ",$S($P(DGVIR0,"^",5)=0:"NOT APPLICABLE",1:$$YN^DGMTSCU1($P(DGVIR0,"^",6)))
 W ?78,"| last calendar year    ",$S($P(DGVIR0,"^",5)=0!($P(DGVIR0,"^",6)):"NOT APPLICABLE",1:$$AMT^DGMTSCU1($P(DGVIR0,"^",7)))
 Q
 ;
DEP ;Print dependent children
 W $$UL^DGMTSCU1(DGUL,DGLNE1),!!?60,"B. Dependent Children",$$UL^DGMTSCU1(DGUL,DGLNE1)
 W !?2,"During last calendar year, did you have any UNMARRIED children or stepchildren who are under the age of 18 or between the ages"
 W !?2,"of 18 and 23 and attending school?  OR did you have any unmarried children over the age of 17 who became permanently incapable"
 W !?2,"of self-support before reaching the age of 18?    ",$$YN^DGMTSCU1($P(DGVIR0,"^",8)),"    (If ""NO"", go to Section C)"
 W $$UL^DGMTSCU1(DGUL,DGLNE1),!?6,"Child's Name",?30,"| Permanently",?50,"| Did the child",?72,"| Did you contribute",?93,"| Did the",?109,"| Was the child's"
 W !?30,"| incapable of",?50,"| live with you",?72,"| to the child's",?93,"| child have",?109,"| income available"
 W !?30,"| self-support",?50,"|",?72,"| support?",?93,"| any income?",?109,"| to you?"
 W !?6,"       (1)",?30,"|        (2)",?50,"|          (3)",?72,"|         (4)",?93,"|      (5)",?109,"|         (6)"
 I '$P(DGVIR0,"^",8) W $$UL^DGMTSCU1(DGUL,DGLNE1),!?6,"NOT APPLICABLE",?30,"|",?50,"|",?72,"|",?93,"|",?109,"|"
 I $P(DGVIR0,"^",8) S DGCNT=0 F  S DGCNT=$O(DGREL("C",DGCNT)) Q:'DGCNT  D CHILD
 Q
 ;
CHILD ;Print data collected for a dependent child
 N DGIR0
 S DGIR0=$G(^DGMT(408.22,+$G(DGINR("C",DGCNT)),0))
 W $$UL^DGMTSCU1(DGUL,DGLNE1),!?1,$$NAME^DGMTU1(+DGREL("C",DGCNT))
 W ?30,"|  ",$$YN^DGMTSCU1($P(DGIR0,"^",9))
 W ?50,"|  ",$$YN^DGMTSCU1($P(DGIR0,"^",6))
 W ?72,"|  ",$S($P(DGIR0,"^",6):"NOT APPLICABLE",1:$$YN^DGMTSCU1($P(DGIR0,"^",10)))
 W ?93,"|  ",$$YN^DGMTSCU1($P(DGIR0,"^",11))
 W ?109,"|  ",$S($P(DGIR0,"^",11)=0:"NOT APPLICABLE",1:$$YN^DGMTSCU1($P(DGIR0,"^",12)))
CHILDQ Q
