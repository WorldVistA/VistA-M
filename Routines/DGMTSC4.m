DGMTSC4 ;ALB/RMO/CAW,LBD - Means Test Screen Net Worth ; 11/7/03 1:44pm
 ;;5.3;Registration;**45,130,456,540,567**;Aug 13, 1993
 ;
 ; Input  -- DFN      Patient IEN
 ;           DGMTDT   Date of Test
 ;           DGMTYPT  Type of Test 1=MT 2=COPAY
 ;           DGMTPAR  Annual Means Test Parameter Array
 ;           DGVINI   Veteran Individual Annual Income IEN
 ;           DGVIRI   Veteran Income Relation IEN
 ;           DGVPRI   Veteran Patient Relation IEN
 ;           DGMTNWC  Net Worth Calculation flag
 ; Output -- None
 ;
 ;DG*5.3*540 - Skip displaying of calculated Means Test Status at the
 ;             bottom of screen 4 when in VIEW mode.
 ;DG*5.3*567 - Allow bottom to show for all except SOURCE OF TEST[IVM
 ;             for IVM display Source is IVM instead.
 ;
EN ;Entry point for previous calendar year net worth screen
 S DGMTSCI=4 D HD^DGMTSCU
 D DIS
 S DGRNG="1-5" G EN^DGMTSCR
 ;
EN1 ;Entry point for read processor return
 D ALL^DGMTU21(DFN,"S",DGMTDT,"IPR",$S($G(DGMTI):DGMTI,1:""))
 I DGX!($G(DGSELTY)["V") S DGPRI=DGVPRI,DGPRTY="V" D EDT
 I '$G(DGMTOUT)&($G(DGSEL)["S")&(DGX!($G(DGSELTY)["S")) S DGPRI=+DGREL("S"),DGPRTY="S" D EDT
Q K DGCNT,DGDEP,DGDR,DGMTOUT,DGPRI,DGPRTY,DGREL,DGSEL,DGSELTY,DGX,DGY,DTOUT,DUOUT,Y
 G EN
 ;
DIS ;Display net worth
 N DGCAT,DGDC,DGDET,DGIN0,DGIN1,DGIN2,DGINT,DGINTF,DGMTS,DGNC,DGND,DGNWT,DGNWTF,DGSP,DGTYC,DGTHA,DGTHB,DGTHG,DGVIR0,DGCNT
 D SET^DGMTSCU2 S DGCNT=1
 I DGMTYPT=1 W !,"Income Thresholds:   " W:$D(DGTHA) "MT Threshold: ",$$AMT^DGMTSCU1(DGTHA) W:$D(DGTHG) ?53,"GMT Threshold: ",$$AMT^DGMTSCU1(DGTHG)
 W ! W:$D(DGMTPAR("PREV")) "*Previous Years Thresholds*"
 W ?34,"Veteran" W:DGSP ?46,"Spouse" W ?73,"Total"
 W !?31,"-----------------------------------------------"
 D HIGH^DGMTSCU1(1,DGMTACT),FLD(.DGIN2,1,"Cash, Amts in Bank Accts")
 D HIGH^DGMTSCU1(2,DGMTACT),FLD(.DGIN2,2,"Stocks and Bonds")
 D HIGH^DGMTSCU1(3,DGMTACT),FLD(.DGIN2,3,"Real Property")
 D HIGH^DGMTSCU1(4,DGMTACT),FLD(.DGIN2,4,"Other Property or Assets")
 D HIGH^DGMTSCU1(5,DGMTACT),FLD(.DGIN2,5,"Debts")
 W !?51,"Total -->",?66,$J($$AMT^DGMTSCU1(DGNWT),12)
 I DGMTYPT=1,DGMTACT="VEW",$P($G(DGMT0),"^",14) W !!!!!!!!,"Declines to give income information makes a MT COPAY REQUIRED status." G DISQ
 ;
 ;DG*5.3*540
 ;DG*5.3*567
 I DGMTACT="VEW",DGMTI,$$GET1^DIQ(408.31,DGMTI,.23)["IVM" D  G DISQ
 . W !!!!!!!!,"Source of Test is IVM"
 W !!!!!!!! I DGMTYPT=1 W "Income of ",$J($$AMT^DGMTSCU1(DGINT-DGDET),12) W "  ",$$GETNAME^DGMTH(DGMTS)
 I DGMTYPT=1,DGTYC="M",(DGNWT-DGDET)+$S($G(DGMTNWC):0,1:DGINT)'<$P(DGMTPAR,"^",8) W !,?3,"with property of ",$J($$AMT^DGMTSCU1(DGNWT),12)," makes a ",$S(DGTHG>DGTHA:"G",1:""),"MT COPAY REQUIRED status."
 I DGTYC="M",'DGNWTF W " requires property information."
 I DGMTYPT=2,'DGNWTF,DGCAT="E" W "Requires property information."
DISQ Q
 ;
FLD(DGIN,DGPCE,DGTXT) ;Display income fields
 ;
 ;    Input -- DGIN as Individual Annual Income 0 node for vet,
 ;                  spouse, and dependents
 ;             DGRPCE as piece position wanted
 ;             DGTXT as income description
 ;
 ;             Also keeps running total if DGGTOT is defined (grand
 ;                  total)
 ;
 N DGTOT,I
 I '$D(DGBL) S $P(DGBL," ",26)=""
 W:DGCNT<10 " "
 W " ",$E(DGTXT_DGBL,1,26)
 W $J($$AMT^DGMTSCU1($P(DGIN("V"),"^",DGPCE)),10)
 W " ",$S($D(DGIN("S")):$J($$AMT^DGMTSCU1($P(DGIN("S"),"^",DGPCE)),10),1:$E(DGBL,1,10))
 W " ",$S($D(DGIN("D")):$J($$AMT^DGMTSCU1($P(DGIN("D"),"^",DGPCE)),11),1:$E(DGBL,1,11))
 S DGTOT="",I="" F  S I=$O(DGIN(I)) Q:I=""  I $P(DGIN(I),"^",DGPCE)]"" S DGTOT=DGTOT+$P(DGIN(I),"^",DGPCE)
 W "  ",$J($$AMT^DGMTSCU1(DGTOT),12)
 S DGCNT=DGCNT+1
 Q
 ;
EDT ;Edit net worth fields
 N DA,DGERR,DGFIN,DGINI,DGIN2,DGIRI,DIE,DR
 D GETIENS^DGMTU2(DFN,DGPRI,DGMTDT) G EDTQ:DGERR
 I $G(DGSEL)]"" W !!,"NAME: ",$$NAME^DGMTU1(DGPRI)
 S DGIN2=$G(^DGMT(408.21,DGINI,2))
 S DA=DGINI,DIE="^DGMT(408.21,",DR="[DGMT ENTER/EDIT NET WORTH]" D ^DIE S:'$D(DGFIN) DGMTOUT=1
 I DGIN2'=$G(^DGMT(408.21,DGINI,2)) S DR="103////^S X=DUZ;104///^S X=""NOW""" D ^DIE
EDTQ Q
