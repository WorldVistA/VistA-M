DGMTSCU2 ;ALB/RMO,CAW,LBD,CKN - Means Test Screen Variable Utilities ;6 FEB 1992 7:45 am
 ;;5.3;Registration;**45,130,433,460,456,490**;Aug 13, 1993
 ;
SET ;Set required means test variables
 ; Input  -- DFN      Patient file IEN
 ;           DGMTDT   Date of Test
 ;           DGMTYPT  Type of Test 1=MT 2=COPAY
 ;           DGMTI    Annual Means Test IEN
 ;           DGMTPAR  Annual Means Test Parameters
 ;           DGVIRI   Veteran Income Relation IEN
 ;           DGVINI   Veteran Individual Annual Income IEN
 ; Output -- All output variables in tags DEP, INC^DGMTSCU3, CAT and STA
 D DEP,INC^DGMTSCU3,CAT,STA
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
 S DGVIR0=$G(^DGMT(408.22,DGVIRI,0)) D ALL^DGMTU21(DFN,"SC",DGMTDT,"PR",$S($G(DGMTI):DGMTI,1:""))
 S DGSP=$S('$P(DGVIR0,"^",5)!('$G(DGREL("S"))):0,$P(DGVIR0,"^",6):1,$P(DGVIR0,"^",7)>599:1,1:0)
 S DGDC=+$P(DGVIR0,"^",8) I DGDC S (DGDC,DGCNT)=0 F  S DGCNT=$O(DGINR("C",DGCNT)) Q:'DGCNT!(DGDC)  D CHK S:Y DGDC=1
 S DGNC=+$P(DGVIR0,"^",13)
 S DGND=DGSP+DGNC
 Q
 ;
CHK ;Check if child has income which is available to the veteran
 S Y=0
 I $D(^DGMT(408.22,+$G(DGINR("C",DGCNT)),0)),$P(^(0),"^",11),$P(^(0),"^",12) S Y=1
 Q
 ;
CAT ;Determine means test thresholds and category
 ; Input  -- DGMTDT   Date of Test
 ;           DGND     Total number of dependents
 ;           DGINT    Total income
 ;           DGDET    Total deductible expenses
 ;           DGMTPAR  Annual Means Test Parameters
 ;           DGMTGMT  GMT Thresholds
 ; Output -- DGTHA    MT threshold
 ;           DGTHB    Category B threshold (NO LONGER USED)
 ;           DGTHG    GMT threshold
 ;           DGCAT    Means/Copay test category code
 N DGCOST,DGCOPS,PCT S DGCAT=""
 ;  Added for LTC Copay Phase II - DG*5.3*433
 I DGMTYPT=4 D  Q
 .N Y S DGTHA=""
 .I $D(DGREF1),$D(DGREF) S DGCAT=1 Q  ;Vet declined to give income info
 .S Y=$$THRES^EASECMT(DFN,DGMTDT) Q:Y=-1
 .S DGCAT=$S(Y:0,1:1)
 I $$ACT^DGMTDD(4,DGMTDT) S DGTHA=$P(DGMTPAR,"^",2)+$S(DGND:$P(DGMTPAR,"^",3),1:0)+$S((DGND-1)>0:($P(DGMTPAR,"^",4)*(DGND-1)),1:0) S:(DGINT-DGDET)'>DGTHA DGCAT="A"
 I $$ACT^DGMTDD(5,DGMTDT) S DGTHB=$P(DGMTPAR,"^",5)+$S(DGND:$P(DGMTPAR,"^",6),1:0)+$S((DGND-1)>0:($P(DGMTPAR,"^",7)*(DGND-1)),1:0) I DGCAT']"",(DGINT-DGDET)'>DGTHB S DGCAT="B"
 ; Determine the GMT Threshold
 ; The DGMTGMT variable stores the GMT Thresholds for households of
 ; 1-8 persons.  If a household (veteran + dependents) has more than 8
 ; the GMT Threshold will be calculated.  For each person in excess of
 ; 8, 8% of the base (4-person household) will be added to the 8-person 
 ; income limit.  Income limits are rounded to the next $50.
 S DGTHG=""
 I $$ACT^DGMTDD(16,DGMTDT) D
 .I '$G(DGMTGMT) S DGTHG=0 Q
 .;If GMT Threshold already calculated, don't recalculate
 .S DGTHG="" I $G(DGMTI) S DGTHG=$P($G(^DGMT(408.31,DGMTI,0)),"^",27)
 .I 'DGTHG D
 ..I DGND+1<9 S DGTHG=$P(DGMTGMT,"^",(DGND+1))
 ..E  S PCT=((DGND+1)-8)*8+132/100,DGTHG=$P(DGMTGMT,"^",4)*PCT,DGTHG=$S(DGTHG#50=0:DGTHG,1:DGTHG+(50-(DGTHG#50)))
 .I DGTHG<DGTHA Q
 .I DGCAT="",(DGINT-DGDET)'>DGTHG S DGCAT="G"
 I DGCAT="",$$ACT^DGMTDD(6,DGMTDT) S DGCAT="C"
 I $D(DGREF),DGMTYPT=1,$D(DGREF1) S DGCAT="C"
 I DGMTYPT=2 D
 .S DGCOST=DGMTDT_U_DFN_U_U_DGINT_U_DGNWT,$P(DGCOST,U,14)=$S($D(DGREF):1,1:0),$P(DGCOST,U,15)=DGDET,$P(DGCOST,U,18)=DGND,$P(DGCOST,U,19)=2
 .S DGCOPS=$$INCDT^IBARXEU1(DGCOST)
 .S DGCAT=$S(+DGCOPS=1:"E",+DGCOPS=2:"M",+DGCOPS=3:"P",1:"I")
 .S (DGTHA,DGTHB)=""
 Q
 ;
STA ;Determine means test status and type of care
 ; Input  -- DGCAT   Means test category code
 ;           DGMTYPT Type of Test 1=MT 2=COPAY
 ; Output -- DGMTS   Means test status IEN
 ;           DGTYC   Type of care
 S DGMTS=+$O(^DG(408.32,"AC",DGMTYPT,DGCAT,0))
 S DGTYC=$P($G(^DG(408.32,DGMTS,0)),"^",3)
 Q
