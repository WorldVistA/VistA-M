DGMTSC3 ;ALB/RMO/CAW - Means Test Screen Deductible Expense ;23 JAN 1992 11:00 am [ 10/02/92  11:31 AM ]
 ;;5.3;Registration;**624**;Aug 13, 1993
 ;
 ; Input  -- DGVINI  Veteran Individual Annual Income IEN
 ;           DGVIRI  Veteran Income Relation IEN
 ;           DGVPRI  Veteran Patient Relation IEN
 ; Output -- None
 ;
EN ;Entry point for deductible expense screen
 S DGMTSCI=3 D HD^DGMTSCU
 D DIS
 S DGRNG="1-"_$S('DGDC:1,1:2) G EN^DGMTSCR
EN1 ;Entry point for read processor return
 S DGVIR0=$G(^DGMT(408.22,DGVIRI,0)),DGIN1("V")=$G(^DGMT(408.21,DGVINI,1))
 S DA=DGVINI,DIE="^DGMT(408.21,",DR="[DGMT ENTER/EDIT EXPENSES]" D ^DIE S:'$D(DGFIN) DGMTOUT=1
 I DGIN1("V")'=$G(^DGMT(408.21,DGVINI,1)) S DR="103////^S X=DUZ;104///^S X=""NOW""" D ^DIE K DA,DIE,DR
 I '$G(DGMTOUT),DGDR["102" D EN^DGMTSC31
Q K DGDC,DGDR,DGFIN,DGIN1,DGMTOUT,DGREL,DGVIR0,DGX,DGY,DTOUT,DUOUT
 G EN
 ;
DIS ;Display deductible expenses
 N DGCNT,DGDCS,DGDEP,DGIN1,DGINC,DGINR,DGREL,DGVIR0
 S DGVIR0=$G(^DGMT(408.22,DGVIRI,0)),DGIN1("V")=$G(^DGMT(408.21,DGVINI,1))
 S DGDC=$P(DGVIR0,"^",8) I DGDC D SET^DGMTSC31 S:'$D(DGDCS) DGDC=0
 D HIGH^DGMTSCU1(1,DGMTACT) W $J("Gross Medical Expenses: ",33),$S(+$P(DGIN1("V"),"^",12)'<0:$$AMT^DGMTSCU1(+$P(DGIN1("V"),"^",12)),1:"N/A")
 W !,$J("Adjusted Medical Expenses: ",36),$S(+$P(DGIN1("V"),"^")'<0:$$AMT^DGMTSCU1(+$P(DGIN1("V"),"^")),1:"N/A")
 W !,$J("Funeral and Burial Expenses: ",36),$S('$P(DGVIR0,"^",5)&('$P(DGVIR0,"^",8)):"N/A",1:$$AMT^DGMTSCU1($P(DGIN1("V"),"^",2)))
 W !,$J("Veteran's Educational Expenses: ",36),$$AMT^DGMTSCU1($P(DGIN1("V"),"^",3))
 W ! D HIGH^DGMTSCU1(2,DGMTACT) W ?7," Child's Education Expenses: ",$S('DGDC:"N/A",1:"") D DIS^DGMTSC31:DGDC
 Q
