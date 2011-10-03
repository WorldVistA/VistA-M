EASECSC6 ;ALB/PHH,LBD - LTC Co-Pay Test Screen Deductible Expense ;13 AUG 2001
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**5,7,34**;Mar 15, 2001
 ;
 ; Input  -- DFN      Patient IEN
 ;           DGMTDT   Date of Test
 ;           DGVINI   Veteran Individual Annual Income IEN
 ;           DGVIRI   Veteran Income Relation IEN
 ;           DGVPRI   Veteran Patient Relation IEN
 ;           DGMTI    LTC Co-Pay Test IEN
 ; Output -- None
 ;
EN ;Entry point for expense screen
 S DGMTSCI=6 D HD^EASECSCU
 D DIS
 S DGRNG="1-10" G EN^EASECSCR
 ;
EN1 ;Entry point for read processor return
 D ALL^EASECU21(DFN,"CS",DGMTDT,"IPR",$S($G(DGMTI):DGMTI,1:""))
 I DGX!($G(DGSELTY)["V") S DGPRI=DGVPRI,DGPRTY="V" D EDT
Q K DGCNT,DGDEP,DGDR,DGMTOUT,DGPRI,DGPRTY,DGREL,DGSEL,DGSELTY,DGX,DGY,DTOUT,DUOUT,Y
 G EN
 ;
DIS ;Display deductible expenses
 N DGDC,DGDET,DGIN0,DGIN1,DGIN2,DGINT,DGINTF,DGNC,DGND,DGNWT,DGNWTF,DGSP,DGVIR0,DGCNT
 D DEP^EASECSU3,INC^EASECSU3 S DGCNT=1
 W !!?39,"Veteran" W:DGSP " and Spouse" W ?73,"Total"
 W !?36,"------------------------------------------"
 D HIGH^DGMTSCU1(1,DGMTACT),FLD(.DGIN1,3,"Education")
 D HIGH^DGMTSCU1(2,DGMTACT),FLD(.DGIN1,2,"Funeral and Burial")
 D HIGH^DGMTSCU1(3,DGMTACT),FLD(.DGIN1,4,"Rent/Mortgage")
 D HIGH^DGMTSCU1(4,DGMTACT),FLD(.DGIN1,5,"Utilities")
 D HIGH^DGMTSCU1(5,DGMTACT),FLD(.DGIN1,6,"Car Payment Only")
 D HIGH^DGMTSCU1(6,DGMTACT),FLD(.DGIN1,7,"Food")
 D HIGH^DGMTSCU1(7,DGMTACT),FLD(.DGIN1,1,"Non-reimbursed Medical Expenses")
 D HIGH^DGMTSCU1(8,DGMTACT),FLD(.DGIN1,8,"Court-ordered Payments")
 D HIGH^DGMTSCU1(9,DGMTACT),FLD(.DGIN1,9,"Insurance")
 D HIGH^DGMTSCU1(10,DGMTACT),FLD(.DGIN1,10,"Taxes")
 W !?56,"Total -->",?66,$J($$AMT^DGMTSCU1(DGDET),12)
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
 N DGTOT,I,AMT
 I '$D(DGBL) S $P(DGBL," ",26)=""
 W:DGCNT<10 " "
 W " ",$E(DGTXT_DGBL,1,26)
 S AMT=$$AMT^DGMTSCU1($P(DGIN("V"),U,DGPCE))
 W $J(AMT,15)
 W "                  "
 S DGTOT="",I="" F  S I=$O(DGIN(I)) Q:I=""  I $P(DGIN(I),"^",DGPCE)]"" S DGTOT=DGTOT+$P(DGIN(I),"^",DGPCE)
 W "  ",$J($$AMT^DGMTSCU1(DGTOT),12)
 S DGCNT=DGCNT+1
 Q
 ;
EDT ;Edit income fields
 N DA,DGERR,DGFIN,DGINI,DGIN0,DGIRI,DGVIR0,DIE,DR
 D GETIENS^EASECU2(DFN,DGPRI,DGMTDT) G EDTQ:DGERR
 I $G(DGSEL)]"" W !!,"NAME: ",$$NAME^DGMTU1(DGPRI)
 S DGVIR0=$G(^DGMT(408.22,DGVIRI,0))
 S DGIN1=$G(^DGMT(408.21,DGINI,1))
 S DA=DGINI,DIE="^DGMT(408.21,",DR="[EASEC ENTER/EDIT EXPENSES]" D ^DIE S:'$D(DGFIN) DGMTOUT=1
 I DGIN1'=$G(^DGMT(408.21,DGINI,1)) D
 .S DR="103////^S X=DUZ;104///^S X=""NOW"""
 .I '$G(^DGMT(408.21,DGINI,"MT")) S DR=DR_";31////^S X=$G(DGMTI)"
 .D ^DIE
EDTQ Q
