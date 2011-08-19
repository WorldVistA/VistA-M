DGMTSC2V ;ALB/GTS - Means Test Screen Income (version 1) ;15 DEC 2005 15:45 pm
 ;;5.3;Registration;**688**;Aug 13, 1993;Build 29
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
 S DGRNG="1-3" G EN^DGMTSCR
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
 N DGDC,DGDET,DGIN0,DGIN1,DGIN2,DGINT,DGINTF,DGNC,DGND,DGNWT,DGNWTF,DGSP,DGVIR0,DGCNT,DGFV2
 S DGFV2=1
 D DEP^DGMTSCU2,INC^DGMTSCU3 S DGCNT=1
 W !!?34,"Veteran" W:DGSP ?46,"Spouse" W:DGDC ?56,"Children" W ?73,"Total"
 W !?31,"-----------------------------------------------"
 D HIGH^DGMTSCU1(1,DGMTACT) W "  Total Employment Income",!
 D FLD^DGMTSC2(.DGIN0,14,"   (Wages, Bonuses, Tips): ")
 D HIGH^DGMTSCU1(2,DGMTACT) W "  Net Income from Farm,",!
 D FLD^DGMTSC2(.DGIN0,17,"   Ranch, Property, Bus.: ")
 D HIGH^DGMTSCU1(3,DGMTACT) W "  Other Income Amounts",!
 W "     (Soc. Sec., Compensation,",!
 D FLD^DGMTSC2(.DGIN0,8,"   Pension, Interest, Div.): ")
 W !?51,"Total -->",?66,$J($$AMT^DGMTSCU1(DGINT),12)
 Q
 ;
EDT ;Edit income fields
 N DA,DGERR,DGFIN,DGINI,DGIN0,DGIRI,DIE,DR
 D GETIENS^DGMTU2(DFN,DGPRI,DGMTDT) G EDTQ:DGERR
 I $G(DGSEL)]"" W !!,"NAME: ",$$NAME^DGMTU1(DGPRI)
 S DGIN0=$G(^DGMT(408.21,DGINI,0))
 S DR="[DGMT V1 ENTER/EDIT ANNUAL INC]"
 S DA=DGINI,DIE="^DGMT(408.21," D ^DIE S:'$D(DGFIN) DGMTOUT=1
 I DGIN0'=$G(^DGMT(408.21,DGINI,0)) S DR="103////^S X=DUZ;104///^S X=""NOW""" D ^DIE
EDTQ Q
