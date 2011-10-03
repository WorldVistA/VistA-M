ENWOD ;(WIRMFO)/DLM/DH/SAB-Formatted Work Order Display ;5/11/2000
 ;;7.0;ENGINEERING;**35,43,65**;Aug 17, 1993
EDIT ;  Work order display/edit (screen) option
 D WO^ENWOUTL G:Y'>0 EXIT S DA=+Y
 D EDIT1
 G EDIT
 ;
EDIT1 ; display/edit one work order
 ; input DA (ien of work order), DUZ (user number)
 N ENBARCD,ENDSTAT,ENEDIT,ENINV,ENJ,ENREOPEN,ENWO,ENWOCLOD,ENX
 S ENEDIT=0 ; flag, true if user edited work order
 S ENREOPEN=0 ; flag, true if closed work order reopened for edit
 D D F  D READ Q:ENX=""  D ACTION Q:$P($G(^ENG(6920,DA,5)),U,2)]""&ENEDIT
 I ENEDIT D
 . ; work order edited by user
 . N DIE,DR
 . S DIE="^ENG(6920,"
 . I ENREOPEN,$P($G(^ENG(6920,DA,5)),U,2)']"" S DR="36//^S X=ENWOCLOD" D ^DIE
 . I $P($G(^ENG(6920,DA,5)),U,2)]"" D
 . . ; work order was closed
 . . I "^5^6^"'[(U_$P($G(^ENG(6920,DA,4)),U,3)_U) D
 . . . ; status was not set to Completed or Disapproved
 . . . S DR="32///^S X=""COMPLETED""" D ^DIE
 . . I $E($P($G(^ENG(6920,DA,0)),U),1,3)="PM-" D
 . . . ; post PM hours for PM work order
 . . . N ENPMDT,PMTOT,X
 . . . D PMHRS^ENEQPMR4 Q:'$D(PMTOT)
 . . . S X=$P($P(^ENG(6920,DA,0),U),"-",2)
 . . . F I=1:1:$L(X) S:$E(X,I)?1N ENPMDT=$G(ENPMDT)_$E(X,I)
 . . . S ENPMDT=$E(ENPMDT,1,4)
 . . . D COUNT^ENBCPM8
 . ; unlock
 . L -^ENG(6920,DA)
 Q
 ;
READ ;User interaction
 D HOME^%ZIS W !,"ENTER/EDIT (1-33), D(DISPLAY), AC(ACCOUNT), P(PRINT)): EXIT// " R ENX:DTIME
 I ENX=10 W !,"Uneditable field.",*7 G READ
 I ENX=11 W !,"A transfer option must be used to change SHOP.",*7 G READ
 I $E(ENX)="^"!($E(ENX)="E") S ENX=""
 Q:ENX=""  I ENX?1.2N S ENX=+ENX I ENX<1!(ENX>33) W " ??",*7 G READ
 Q:ENX?1.2N  S ENX=$TR(ENX,"dap","DAP") I "DAP"'[$E(ENX) W " ??",*7 G READ
 Q
 ;
ACTION ;Edit or display
 I ENX'?1.2N N TAG S TAG=$E(ENX) D @TAG Q
 ; try to prepare work order for editing (if not already done)
 I 'ENEDIT D  I 'ENEDIT L -^ENG(6920,DA) Q
 . L +^ENG(6920,DA):5 I '$T W !,"This work order is being edited by another user.  Please try again later." Q
 . I $P($G(^ENG(6920,DA,5)),U,2)]"" D  I 'ENREOPEN  Q
 . . W $C(7),!,"NOTE: This work order has been closed."
 . . I '$D(^XUSEC("ENEDCLWO",DUZ)) W !,"Security key ENEDCLWO is needed to edit closed work orders." Q
 . . S DIR("A")="Are you sure you want to edit this work order",DIR(0)="Y",DIR("B")="NO"
 . . D ^DIR K DIR Q:Y'>0
 . . I $P($G(^ENG(6920,DA,3)),U,8)>0 D KILLHS^ENEQHS Q:$G(R)="^"
 . . S ENWOCLOD=$P(^ENG(6920,DA,5),U,2)
 . . S $P(^ENG(6920,DA,5),U,2)="" D TEST^ENWOCOMP
 . . I $E($P($G(^ENG(6920,DA,0)),U),1,3)="PM-" D
 . . . ; since reopening PM work order we must back out the PM hours
 . . . N ENPMDT,PMTOT,X
 . . . D PMHRS^ENEQPMR4 Q:'$D(PMTOT)
 . . . S X=$P($P(^ENG(6920,DA,0),U),"-",2)
 . . . F I=1:1:$L(X) S:$E(X,I)?1N ENPMDT=$G(ENPMDT)_$E(X,I)
 . . . S ENPMDT=$E(ENPMDT,1,4)
 . . . D UNPOST^ENBCPM8
 . . S ENREOPEN=1 ; reopen of closed work order completed
 . S ENEDIT=1 ; work order ready for editing
 N DIE,DR,ENDA
 S DR=$P("16^1^2^3^4^STAT^6^7^8^^9^10^17^18^19^21^EQ53^21.9^22.3^22.5^23^20^31^35^35.5^37^38^37.5^47^16.5^36^39^40",U,ENX) S:DR="STAT" DR=ENDSTAT
 I $E(DR,1,2)="EQ" S ENDA=DA D  S DA=ENDA Q
 . S DIE="^ENG(6914,",DR=$E(DR,3,99),DA=$P($G(^ENG(6920,DA,3)),U,8)
 . I DA D
 . . L +^ENG(6914,DA):5 I '$T W $C(7),!,"Another user is editing this equipment. Try editing the condition later." Q
 . . D ^DIE
 . . L -^ENG(6914,DA)
 S DIE="^ENG(6920,"
 I DR=36 D
 . W !!,"Entry of a date will close this work order. Do this last."
 . I $D(ENWOCLOD) S DR="36//^S X=ENWOCLOD"
 D ^DIE
 Q
 ;
D ;Display WO to CRT
 W:$E(IOST,1,2)="C-" @IOF D ST^ENWOD1,TOP^ENWOD2
 Q
 ;
A ;Display Accounting Data
 S X="PRCSP13" X ^%ZOSF("TEST") I $T D
 . S ENFLG=0 I $D(^ENG(6920,DA,4)),$P(^(4),U,2)]"" D
 . . S ENWOACN=$P(^ENG(6920,DA,4),U,2),ENFLG=1
 . . I $D(^PRCS(410,ENWOACN,0)) D
 . . . S ENWOOR=DA,DA=ENWOACN
 . . . D ^PRCSP13
 . . . S DA=ENWOOR K ENWOOR
 . . K ENWOACN
 . W:'ENFLG !,"No procurement request on file for this work order."
 . K ENFLG
 Q
 ;
P ;Print work order
 I '$D(ENBARCD) S ENBARCD=0 I $D(^ENG(6910.2,"B","PRINT BAR CODES ON W.O.")) S I=$O(^("PRINT BAR CODES ON W.O.",0)) I I>0,$P(^ENG(6910.2,I,0),U,2)="Y" S ENBARCD=1
 D DEV^ENLIB Q:POP  I $D(IO("Q")) N X S ZTRTN="PRT1^ENWOD",ZTSAVE("EN*")="",ZTSAVE("DA")="",ZTDESC="Print Work Order" D ^%ZTLOAD K ZTSK D HOME^%ZIS Q
PRT1 U IO W:$E(IOST,1,2)="C-" @IOF
 D:$E(IOST,1,2)'="C-" PSET^%ZISP
 D ST^ENWOD1,TOP^ENWOD2
 D:ENBARCD BAR
 I $E(IOST,1,2)'="C-" W @IOF D PKILL^%ZISP
 N DA ; to protect DA when W.O. printed to P-MESSAGE
 D ^%ZISC
 Q
 ;
BAR ; print barcode of w.o. #
 I $G(IOBARON)]"",$G(IOBAROFF)]"" W !,@IOBARON W ENWO W @IOBAROFF W !
 Q
EXIT ;
 Q
 ;ENWOD
