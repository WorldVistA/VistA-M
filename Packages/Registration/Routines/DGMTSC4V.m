DGMTSC4V ;ALB/AMA,HM,JAM - Means Test Screen Net Worth For MT Version 1 ;11/7/03 1:44pm
 ;;5.3;Registration;**688,1014,1064**;Aug 13, 1993;Build 41
 ;Copied from DGMTSC4
 ;
 ; Input  -- DFN      Patient IEN
 ;           DGMTDT   Date of Test
 ;           DGMTYPT  Type of Test 1=MT 2=COPAY
 ;           DGMTPAR  Annual Means Test Parameter Array
 ;           DGVINI   Veteran Individual Annual Income IEN
 ;           DGVIRI   Veteran Income Relation IEN
 ;           DGVPRI   Veteran Patient Relation IEN
 ;           DGMTNWC  Net Worth Calculation flag
 ;           DGMTACT  Global variable, Means test action being perfomed, set when DGMTE, DGMTA, or DGMTEO is called
 ; Output -- None
 ;
EN ;Entry point for previous calendar year net worth screen
 I DGMTACT'="EDT"&(DGMTACT'="ADD")&(DGMTACT'="COM") D  G EN^DGMTSCR ;DG*5.3*1014 check if entry point in screen was from edit, add, or complete a means test and skip screen 4
 .D DEP^DGMTSCU2,INC^DGMTSCU3 ;DG*5.3*1014 set variable for screen 4 display
 .N DGVET,DGSPD S (DGVET,DGSPD)=""
 .S DGVET(1)=$P($G(DGIN2("V")),U),DGVET(2)=$P($G(DGIN2("V")),U,3),DGVET(3)=$P($G(DGIN2("V")),U,4)
 .S DGSPD(1)=$P($G(DGIN2("S")),U),DGSPD(2)=$P($G(DGIN2("S")),U,3),DGSPD(3)=$P($G(DGIN2("S")),U,4)
 .S DGMTSCI=4 I DGVET(1)'=""!(DGVET(2)'="")!(DGVET(3)'="")!(DGSPD(1)'="")!(DGSPD(2)'="")!(DGSPD(3)'="") D HD^DGMTSCU
 .I DGVET(1)=""&(DGVET(2)="")&(DGVET(3)="") S DGSCR1=1
 .I DGSPD(1)=""&(DGSPD(2)="")&(DGSPD(3)="") S DGSCR1=1
 .I $$GETNAME^DGMTH(DGMTSCI)'="MT COPAY EXEMPT",DGVET(1)'=""!(DGVET(2)'="")!(DGVET(3)'="")!(DGSPD(1)'="")!(DGSPD(2)'="")!(DGSPD(3)'="") D DIS  ;DG*5.3*1014 do screen 4 if not MT COPAY EXEMPT
 .I $$GETNAME^DGMTH(DGMTSCI)="MT COPAY EXEMPT"&(DGMTACT'="EDT")&(DGMTACT'="ADD")&(DGMTACT'="COM") D  ;DG*5.3*1014 do screen 4 if not edit, add, or complete and status is MT COPAY EXEMPT
 ..I DGVET(1)'=""!(DGVET(2)'="")!(DGVET(3)'="")!(DGSPD(1)'="")!(DGSPD(2)'="")!(DGSPD(3)'="") D DIS ;if financial data exists for screen 4 display
 .S DGRNG="1-3"
 .I $G(DGSCR1),DGSCR1=1 D MTMSG ;DG*5.3*1014 display MT status message
 I DGMTACT="EDT"!(DGMTACT="ADD")!(DGMTACT="COM") S DGRNG="1-3",DGMTSCI=4 D FEED^DGMTSCR,EN1^DGMTSCR Q  ;DG*5.3*1014 do not rewrite bottom of screen
 ;
EN1 ;Entry point for read processor return
 D ALL^DGMTU21(DFN,"CS",DGMTDT,"IPR",$S($G(DGMTI):DGMTI,1:""))
 I DGX!($G(DGSELTY)["V") S DGPRI=DGVPRI,DGPRTY="V" D EDT
 I '$G(DGMTOUT)&($G(DGSEL)["S")&(DGX!($G(DGSELTY)["S")) S DGPRI=+DGREL("S"),DGPRTY="S" D EDT
 ;*Patch DG*5.3*688
 I '$G(DGMTOUT)&($G(DGSEL)["C")&(DGX!($G(DGSELTY)["C")) S DGPRTY="C",DGCNT=0 F  S DGCNT=$O(DGREL("C",DGCNT)) Q:'DGCNT!($G(DGMTOUT))  D
 .D CHK^DGMTSCU2 I Y S DGPRI=+DGREL("C",DGCNT) D EDT
Q K DGCNT,DGDEP,DGDR,DGMTOUT,DGPRI,DGPRTY,DGREL,DGSEL,DGSELTY,DGX,DGY,DTOUT,DUOUT,Y
 G EN
 ;
DIS ;Display net worth
 N DGCAT,DGDC,DGDET,DGIN0,DGIN1,DGIN2,DGINT,DGINTF,DGMTS,DGNC,DGND,DGNWT,DGNWTF,DGSP,DGTYC,DGTHA,DGTHB,DGTHG,DGVIR0,DGCNT
 D SET^DGMTSCU2 S DGCNT=1
 I DGMTYPT=1 W !,"Income Thresholds:   " W:$D(DGTHA) "MT Threshold: ",$$AMT^DGMTSCU1(DGTHA) W:$D(DGTHG) ?53,"GMT Threshold: ",$$AMT^DGMTSCU1(DGTHG)
 W ! W:$D(DGMTPAR("PREV")) "*Previous Years Thresholds*"
 W ?34,"Veteran" W:DGSP ?47,"Spouse" W:DGDC ?57,"Children" W ?73,"Total"
 W !?31,"-----------------------------------------------"
 D HIGH^DGMTSCU1(1,DGMTACT) W "  Cash, Amts in Bank Accts"
 D FLD(.DGIN2,1,"(CDs,IRAs,Stocks,Bonds):")
 D HIGH^DGMTSCU1(2,DGMTACT) W "  Land,Bldgs Less Mortgage,"
 D FLD(.DGIN2,3,"Liens (Not Primary Home):")
 D HIGH^DGMTSCU1(3,DGMTACT) W "  Other Prop.(Farm,Bus.) Or"
 W !?5,"Assets (Art,Collectibles)"
 D FLD(.DGIN2,4,"Less Amount Owed:")
 W !?51,"Total -->",?66,$J($$AMT^DGMTSCU1(DGNWT),12)
 I DGMTYPT=1,DGMTACT="VEW",$P($G(DGMT0),"^",14) W !!!!!!,"Declines to give income information makes a MT COPAY REQUIRED status." G DISQ
 ;
 I DGMTACT="VEW",DGMTI,$$GET1^DIQ(408.31,DGMTI,.23)["IVM" D  G DISQ
 . W !!!!!!,"Source of Test is IVM"
 K DGSCR1 ;DG*5.3*1014 kill variable to not display repeating info
MTMSG ;DG*5.3*1014 only display for view a past means test
 I DGMTACT="VEW" D
 .D DEP^DGMTSCU2,INC^DGMTSCU3
 .S DGCAT=$P(^DGMT(408.31,DGMTI,0),"^",3),DGCAT=$P(^DG(408.32,DGCAT,0),"^",2) D STA^DGMTSCU2 S DGCNT=1
 .W !!!!!! I DGMTYPT=1 W "Income of ",$J($$AMT^DGMTSCU1(DGINT-DGDET),12) W "  ",$$GETNAME^DGMTH(DGMTS)
 .;jam; DG*5.3*1064
 .I $$INDSTATUS^DGENELA2(DFN) D
 . . D BLD^DIALOG(261134,"","","","F")
 . . D MSG^DIALOG("WM","","","")
 .;
 .;I DGMTYPT=1,DGTYC="M",(DGNWT-DGDET)+$S($G(DGMTNWC):0,1:DGINT)'<$P(DGMTPAR,"^",8) W !,?3,"with property of ",$J($$AMT^DGMTSCU1(DGNWT),12)," makes a ",$S(DGTHG>DGTHA:"G",1:""),"MT COPAY REQUIRED status."
 .;I DGTYC="M",'DGNWTF W " requires property information."
 .;I DGMTYPT=2,'DGNWTF,DGCAT="E" W "Requires property information."
DISQ Q
 ;
FLD(DGIN,DGPCE,DGTXT)   ;Display income fields
 ;
 ;  Input -- DGIN as Individual Annual Income 0 node for vet,
 ;                spouse, and dependents
 ;           DGRPCE as piece position wanted
 ;           DGTXT as income description
 ;
 ;  Also keeps running total if DGGTOT is defined (grand total)
 ;
 N DGTOT,I
 I '$D(DGBL) S $P(DGBL," ",26)=""
 W !?5,$E(DGTXT_DGBL,1,26)
 W $J($$AMT^DGMTSCU1($P(DGIN("V"),"^",DGPCE)),10)
 W " ",$S($D(DGIN("S")):$J($$AMT^DGMTSCU1($P(DGIN("S"),"^",DGPCE)),10),1:$E(DGBL,1,10))
 W " ",$S($D(DGIN("C")):$J($$AMT^DGMTSCU1($P(DGIN("C"),"^",DGPCE)),11),1:$E(DGBL,1,11))
 S DGTOT="",I="" F  S I=$O(DGIN(I)) Q:I=""  I $P(DGIN(I),"^",DGPCE)]"" S DGTOT=DGTOT+$P(DGIN(I),"^",DGPCE)
 W "  ",$J($$AMT^DGMTSCU1(DGTOT),12)
 S DGCNT=DGCNT+1
 Q
 ;
EDT ;Edit net worth fields
 N DA,DGERR,DGFIN,DGINI,DGIN2,DGIRI,DIE,DR,DGMTVR
 D GETIENS^DGMTU2(DFN,DGPRI,DGMTDT) G EDTQ:DGERR
 I $G(DGSEL)]"" W !!,"NAME: ",$$NAME^DGMTU1(DGPRI)
 S DGIN2=$G(^DGMT(408.21,DGINI,2))
 S DGMTVR=$P($G(^DGMT(408.31,$G(DGMTI),2)),"^",11)
 S DR="[DGMT V1 ENTER/EDIT NET WORTH]"
 S DA=DGINI,DIE="^DGMT(408.21," D ^DIE S:'$D(DGFIN) DGMTOUT=1
 I DGIN2'=$G(^DGMT(408.21,DGINI,2)) S DR="103////^S X=DUZ;104///^S X=""NOW""" D ^DIE
EDTQ Q
