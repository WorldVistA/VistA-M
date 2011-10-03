EASECSC5 ;ALB/PHH,LBD - LTC Co-Pay Test Screen Income ;13 AUG 2001
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**5,7,40**;Mar 15, 2001
 ;
 ; Input  -- DFN      Patient IEN
 ;           DGMTDT   Date of Test
 ;           DGVINI   Veteran Individual Annual Income IEN
 ;           DGVIRI   Veteran Income Relation IEN
 ;           DGVPRI   Veteran Patient Relation IEN
 ;           DGMTI    LTC Co-Pay Test IEN
 ;           DGFORM   10-10EC Format (1=Revised; 0=Original)
 ; Output -- None
 ;
EN ;Entry point for calendar year income screen
 S DGMTSCI=5 D HD^EASECSCU
 D DIS
 S DGRNG=$S($G(DGFORM):"1-3",1:"1-14") G EN^EASECSCR
 ;
EN1 ;Entry point for read processor return
 D ALL^EASECU21(DFN,"S",DGMTDT,"IPR",$S($G(DGMTI):DGMTI,1:""))
 I DGX!($G(DGSELTY)["V") S DGPRI=DGVPRI,DGPRTY="V" D EDT
 I '$G(DGMTOUT)&($G(DGSEL)["S")&(DGX!($G(DGSELTY)["S")) S DGPRI=+DGREL("S"),DGPRTY="S" D EDT
Q K DGCNT,DGDEP,DGDR,DGMTOUT,DGPRI,DGPRTY,DGREL,DGSEL,DGSELTY,DGX,DGY,DTOUT,DUOUT,Y
 G EN
 ;
DIS ;Display income
 N DGDC,DGDET,DGIN0,DGIN1,DGIN2,DGINT,DGINTF,DGNC,DGND,DGNWT,DGNWTF,DGSP,DGVIR0,DGCNT
 D DEP^EASECSU3,INC^EASECSU3 S DGCNT=1
 W !!?39,"Veteran" W:DGSP ?56,"Spouse" W ?73,"Total"
 W !?36,"------------------------------------------"
 ; Revised 10-10EC format, added for LTC IV (EAS*1*40)
 I $G(DGFORM) D
 .D HIGH^DGMTSCU1(1,DGMTACT),FLD(.DGIN0,14,"Current Employment Income")
 .D HIGH^DGMTSCU1(2,DGMTACT),FLD(.DGIN0,15,"Income from Farm/Ranch/Business")
 .D HIGH^DGMTSCU1(3,DGMTACT),FLD(.DGIN0,17,"All Other Income")
 ; Original 10-10EC format
 I '$G(DGFORM) D
 .D HIGH^DGMTSCU1(1,DGMTACT),FLD(.DGIN0,14,"Current Income")
 .D HIGH^DGMTSCU1(2,DGMTACT),FLD(.DGIN0,8,"Soc. Sec. Retire/Disabil")
 .D HIGH^DGMTSCU1(3,DGMTACT),FLD(.DGIN0,15,"Interest/Dividends")
 .D HIGH^DGMTSCU1(4,DGMTACT),FLD(.DGIN0,6,"Retirement/Pension Income")
 .D HIGH^DGMTSCU1(5,DGMTACT),FLD(.DGIN0,9,"Civil Service Retirement")
 .D HIGH^DGMTSCU1(6,DGMTACT),FLD(.DGIN0,10,"U.S. Railroad Retirement")
 .D HIGH^DGMTSCU1(7,DGMTACT),FLD(.DGIN0,7,"VA Pension")
 .D HIGH^DGMTSCU1(8,DGMTACT),FLD(.DGIN0,19,"Spouse VA Disabil/Compens")
 .D HIGH^DGMTSCU1(9,DGMTACT),FLD(.DGIN0,12,"Unemployment Benefit/Comp")
 .D HIGH^DGMTSCU1(10,DGMTACT),FLD(.DGIN0,16,"Other Compensation")
 .D HIGH^DGMTSCU1(11,DGMTACT),FLD(.DGIN0,11,"Military Retirement")
 .D HIGH^DGMTSCU1(12,DGMTACT),FLD(.DGIN0,13,"Other Retirement")
 .D HIGH^DGMTSCU1(13,DGMTACT),FLD(.DGIN0,20,"Court Mandated")
 .D HIGH^DGMTSCU1(14,DGMTACT),FLD(.DGIN0,17,"Other Income")
 W !?56,"Total -->",?66,$J($$AMT^DGMTSCU1(DGINT),12)
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
 ; Display veteran amount
 S AMT=$$AMT^DGMTSCU1($P(DGIN("V"),U,DGPCE))
 ; No amount for Spouse VA Disability/Compensation
 I DGPCE=19 S AMT="N/A"
 ; No amount for VA Pension if Receiving VA Pension is not YES
 I DGPCE=7,$P($G(^DPT(DFN,.362)),U,14)'="Y" S AMT="N/A"
 W $J(AMT,15)
 ; Display spouse amount (if married)
 W " ",$S($D(DGIN("S")):$J($$AMT^DGMTSCU1($P(DGIN("S"),"^",DGPCE)),15),1:$E(DGBL,1,15))
 W "  "
 S DGTOT="",I="" F  S I=$O(DGIN(I)) Q:I=""  I $P(DGIN(I),"^",DGPCE)]"" S DGTOT=DGTOT+$P(DGIN(I),"^",DGPCE)
 W "  ",$J($$AMT^DGMTSCU1(DGTOT),12)
 S DGCNT=DGCNT+1
 Q
 ;
EDT ;Edit income fields
 N DA,DGERR,DGFIN,DGINI,DGIN0,DGIRI,DIE,DR
 D GETIENS^EASECU2(DFN,DGPRI,DGMTDT) G EDTQ:DGERR
 I $G(DGSEL)]"" W !!,"NAME: ",$$NAME^DGMTU1(DGPRI)
 S DGIN0=$G(^DGMT(408.21,DGINI,0))
 ; If this is the new 10-10EC form use the template [EASEC ENTER/EDIT
 ; INCOME NEW].  Added for LTC IV (EAS*1*40).
 S DA=DGINI,DIE="^DGMT(408.21,",DR="[EASEC ENTER/EDIT INCOME"_$S($G(DGFORM):" NEW]",1:"]")
 D ^DIE S:'$D(DGFIN) DGMTOUT=1
 I DGIN0'=$G(^DGMT(408.21,DGINI,0)) D
 .S DR="103////^S X=DUZ;104///^S X=""NOW"""
 .I '$G(^DGMT(408.21,DGINI,"MT")) S DR=DR_";31////^S X=$G(DGMTI)"
 .D ^DIE
EDTQ Q
