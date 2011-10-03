DGMTSC2 ;ALB/RMO/CAW - Means Test Screen Income ; 8/1/08 1:15pm
 ;;5.3;Registration;**45,688**;Aug 13, 1993;Build 29
 ;
 ; Input  -- DFN      Patient IEN
 ;           DGMTDT   Date of Test
 ;           DGVINI   Veteran Individual Annual Income IEN
 ;           DGVIRI   Veteran Income Relation IEN
 ;           DGVPRI   Veteran Patient Relation IEN
 ;           DGMTI    Means Test IEN
 ; Output -- None
 ;
EN ;Entry point for previous calendar year income screen
 S DGMTSCI=2 D HD^DGMTSCU
 D DIS
 S DGRNG="1-10" G EN^DGMTSCR
 ;
EN1 ;Entry point for read processor return
 D ALL^DGMTU21(DFN,"CS",DGMTDT,"IPR",$S($G(DGMTI):DGMTI,1:""))
 I DGX!($G(DGSELTY)["V") S DGPRI=DGVPRI,DGPRTY="V" D EDT
 I '$G(DGMTOUT)&($G(DGSEL)["S")&(DGX!($G(DGSELTY)["S")) S DGPRI=+DGREL("S"),DGPRTY="S" D EDT
 I '$G(DGMTOUT)&($G(DGSEL)["C")&(DGX!($G(DGSELTY)["C")) S DGPRTY="C",DGCNT=0 F  S DGCNT=$O(DGREL("C",DGCNT)) Q:'DGCNT!($G(DGMTOUT))  D
 .D CHK^DGMTSCU2 I Y S DGPRI=+DGREL("C",DGCNT) D EDT
Q K DGCNT,DGDEP,DGDR,DGMTOUT,DGPRI,DGPRTY,DGREL,DGSEL,DGSELTY,DGX,DGY,DTOUT,DUOUT,Y
 G EN
 ;
DIS ;Display income
 N DGDC,DGDET,DGIN0,DGIN1,DGIN2,DGINT,DGINTF,DGNC,DGND,DGNWT,DGNWTF,DGSP,DGVIR0,DGCNT
 D DEP^DGMTSCU2,INC^DGMTSCU3 S DGCNT=1
 W !!?35,"Veteran" W:DGSP ?47,"Spouse" W:DGDC ?57,"Children" W ?73,"Total"
 W !?31,"-----------------------------------------------"
 D HIGH^DGMTSCU1(1,DGMTACT),FLD(.DGIN0,8,"Social Security (Not SSI)")
 D HIGH^DGMTSCU1(2,DGMTACT),FLD(.DGIN0,9,"U.S. Civil Service")
 D HIGH^DGMTSCU1(3,DGMTACT),FLD(.DGIN0,10,"U.S. Railroad Retirement")
 D HIGH^DGMTSCU1(4,DGMTACT),FLD(.DGIN0,11,"Military Retirement")
 D HIGH^DGMTSCU1(5,DGMTACT),FLD(.DGIN0,12,"Unemployment Compensation")
 D HIGH^DGMTSCU1(6,DGMTACT),FLD(.DGIN0,13,"Other Retirement")
 D HIGH^DGMTSCU1(7,DGMTACT),FLD(.DGIN0,14,"Total Employment Income")
 D HIGH^DGMTSCU1(8,DGMTACT),FLD(.DGIN0,15,"Interest,Dividend,Annuity")
 D HIGH^DGMTSCU1(9,DGMTACT),FLD(.DGIN0,16,"Workers Comp or Black Lung")
 D HIGH^DGMTSCU1(10,DGMTACT),FLD(.DGIN0,17,"All Other Income")
 W !?52,"Total -->",?67,$J($$AMT^DGMTSCU1(DGINT),12)
 Q
 ;
FLD(DGIN,DGPCE,DGTXT) ;Display income fields
 ;
 ;    Input -- DGIN as Individual Annual Income 0 node for vet,
 ;                  spouse, and dependents
 ;             DGPCE as piece position wanted
 ;             DGTXT as income description
 ;
 ;             Also keeps running total if DGGTOT is defined (grand
 ;                  total)
 ;
 N DGTOT,I
 I '$D(DGBL) S $P(DGBL," ",28)=""
 W:DGCNT<10 " "
 W " ",$E(DGTXT_DGBL,1,28)
 W:$D(DGFV2) $J($$AMT^DGMTSCU1($P(DGIN("V"),"^",DGPCE)),11)
 W:'$D(DGFV2) $J($$AMT^DGMTSCU1($P(DGIN("V"),"^",DGPCE)),9)
 W " ",$S($D(DGIN("S")):$J($$AMT^DGMTSCU1($P(DGIN("S"),"^",DGPCE)),10),1:$E(DGBL,1,10))
 W " ",$S($D(DGIN("C")):$J($$AMT^DGMTSCU1($P(DGIN("C"),"^",DGPCE)),11),1:$E(DGBL,1,11))
 S DGTOT="",I="" F  S I=$O(DGIN(I)) Q:I=""  I $P(DGIN(I),"^",DGPCE)]"" S DGTOT=DGTOT+$P(DGIN(I),"^",DGPCE)
 W "  ",$J($$AMT^DGMTSCU1(DGTOT),12)
 S DGCNT=DGCNT+1
 Q
 ;
EDT ;Edit income fields
 N DA,DGERR,DGFIN,DGINI,DGIN0,DGIRI,DIE,DR
 D GETIENS^DGMTU2(DFN,DGPRI,DGMTDT) G EDTQ:DGERR
 I $G(DGSEL)]"" W !!,"NAME: ",$$NAME^DGMTU1(DGPRI)
 S DGIN0=$G(^DGMT(408.21,DGINI,0))
 S DR="[DGMT ENTER/EDIT ANNUAL INCOME]"
 S DA=DGINI,DIE="^DGMT(408.21," D ^DIE S:'$D(DGFIN) DGMTOUT=1
 I DGIN0'=$G(^DGMT(408.21,DGINI,0)) S DR="103////^S X=DUZ;104///^S X=""NOW""" D ^DIE
EDTQ Q
