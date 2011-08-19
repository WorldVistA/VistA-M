EASECSC4 ;ALB/PHH,LBD - LTC Co-Pay Test Screen Assets ;10 AUG 2001
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**5,40**;Mar 15, 2001
 ;
 ; Input  -- DFN      Patient IEN
 ;           DGMTDT   Date of Test
 ;           DGMTYPT  Type of Test 3=LTC Co-Pay
 ;           DGMTPAR  Annual Test Parameter Array
 ;           DGVINI   Veteran Individual Annual Income IEN
 ;           DGVIRI   Veteran Income Relation IEN
 ;           DGVPRI   Veteran Patient Relation IEN
 ;           DGFORM   10-10EC Format (1=Revised; 0=Original)
 ; Output -- None
 ;
EN ;Entry point for net worth screen
 S DGMTSCI=4 D HD^EASECSCU
 D DIS
 S DGRNG=$S($G(DGFORM):"1-5",1:"1-6") G EN^EASECSCR
 ;
EN1 ;Entry point for read processor return
 D ALL^EASECU21(DFN,"S",DGMTDT,"IPR",$S($G(DGMTI):DGMTI,1:""))
 I DGX!($G(DGSELTY)["V") S DGPRI=DGVPRI,DGPRTY="V" D EDT
 I '$G(DGMTOUT)&($G(DGSEL)["S")&(DGX!($G(DGSELTY)["S")) S DGPRI=+DGREL("S"),DGPRTY="S" D EDT
Q K DGCNT,DGDEP,DGDR,DGMTOUT,DGPRI,DGPRTY,DGREL,DGSEL,DGSELTY,DGX,DGY,DTOUT,DUOUT,Y
 G EN
 ;
DIS ;Display net worth
 N DGCAT,DGDC,DGDET,DGIN0,DGIN1,DGIN2,DGINT,DGINTF,DGMTS,DGNC,DGND,DGNWT,DGNWTF,DGSP,DGTYC,DGTHA,DGTHB,DGVIR0,DGCNT
 D DEP^EASECSU3,INC^EASECSU3 S DGCNT=1
 ; Revised 10-10EC form uses separate columns for veteran and spouse
 ; added for LTC Phase IV (EAS*1*40)
 I $G(DGFORM) W !?39,"Veteran" W:DGSP ?56,"Spouse" W ?73,"Total"
 E  W !?39,"Veteran" W:DGSP " and Spouse" W ?73,"Total"
 W !?36,"------------------------------------------"
 D HIGH^DGMTSCU1(1,DGMTACT),FLD(.DGIN2,6,"Residence")
 D HIGH^DGMTSCU1(2,DGMTACT),FLD(.DGIN2,7,"Other Residences/Land/Farm/or Ranch")
 D HIGH^DGMTSCU1(3,DGMTACT),FLD(.DGIN2,8,"Vehicle(s)")
 ; Revised 10-10EC format, added for LTC IV (EAS*1*40)
 I $G(DGFORM) D
 .D HIGH^DGMTSCU1(4,DGMTACT),FLD(.DGIN2,1,"Cash, Stocks, Mutual Funds")
 .D HIGH^DGMTSCU1(5,DGMTACT),FLD(.DGIN2,9,"Other Liquid Assets")
 ; Original 10-10EC format
 I '$G(DGFORM) D
 .D HIGH^DGMTSCU1(4,DGMTACT),FLD(.DGIN2,1,"Cash")
 .D HIGH^DGMTSCU1(5,DGMTACT),FLD(.DGIN2,2,"Stocks, Bonds, Mutual Funds, SEP's")
 .D HIGH^DGMTSCU1(6,DGMTACT),FLD(.DGIN2,9,"Other Liquid Assets")
 W !?56,"Total -->",?66,$J($$AMT^DGMTSCU1(DGNWT),12)
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
 W $J($$AMT^DGMTSCU1($P(DGIN("V"),"^",DGPCE)),15)
 ; Display spouse amount if married (only applies to new 10-10EC form)
 ; Added for LTC Phase IV (EAS*1*40)
 W " ",$S($D(DGIN("S"))&($G(DGFORM)):$J($$AMT^DGMTSCU1($P(DGIN("S"),"^",DGPCE)),15),1:$E(DGBL,1,15))
 W "  "
 S DGTOT="",I="" F  S I=$O(DGIN(I)) Q:I=""  I $P(DGIN(I),"^",DGPCE)]"" S DGTOT=DGTOT+$P(DGIN(I),"^",DGPCE)
 W "  ",$J($$AMT^DGMTSCU1(DGTOT),12)
 S DGCNT=DGCNT+1
 Q
 ;
EDT ;Edit net worth fields
 N DA,DGERR,DGFIN,DGINI,DGIN2,DGIRI,DIE,DR
 D GETIENS^EASECU2(DFN,DGPRI,DGMTDT) G EDTQ:DGERR
 I $G(DGSEL)]"" W !!,"NAME: ",$$NAME^DGMTU1(DGPRI)
 S DGIN2=$G(^DGMT(408.21,DGINI,2))
 ; If this is the new 10-10EC form use the template [EASEC ENTER/EDIT
 ; ASSETS NEW].  Added for LTC IV (EAS*1*40).
 S DA=DGINI,DIE="^DGMT(408.21,",DR="[EASEC ENTER/EDIT ASSETS"_$S($G(DGFORM):" NEW]",1:"]")
 D ^DIE S:'$D(DGFIN) DGMTOUT=1
 I DGIN2'=$G(^DGMT(408.21,DGINI,2)) D
 .S DR="103////^S X=DUZ;104///^S X=""NOW"""
 .I '$G(^DGMT(408.21,DGINI,"MT")) S DR=DR_";31////^S X=$G(DGMTI)"
 .D ^DIE
EDTQ Q
