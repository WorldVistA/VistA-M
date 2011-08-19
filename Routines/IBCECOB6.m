IBCECOB6 ;YMG/BP - IB COB MANAGEMENT SCREEN ;26-Dec-2007
 ;;2.0;INTEGRATED BILLING;**377**;21-MAR-94;Build 23
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
EN ; view MRA comments - entry point from MRA Worklist
 N IBDA,IBIFN
 ; we need to select a claim and set IBIFN
 D SEL^IBCECOB2(.IBDA,1) S:$O(IBDA(0)) IBIFN=+IBDA($O(IBDA(0)))
 D:$G(IBIFN) EN^VALM("IBCEM MRA COMMENTS")
 S VALMBCK="R"
 Q
 ;
HDR ; header code
 S VALMHDR(1)="MRA Claim "_$P($G(^DGCR(399,IBIFN,0)),U)
 Q
 ;
INIT ; init variables and list array
 N CMLN,CMSTR,I,IB0,IBDATE,IBDUZ,LEN,LN,MAX,POS,STR
 S LN=1
 ; check if we have any comments to display
 I '$D(^DGCR(399,IBIFN,"TXC","B")) D  Q
 .S STR="",STR=$$SETFLD^VALM1("No comments found for this claim.",STR,"MESSAGE")
 .D SET^VALM10(LN,STR),FLDCTRL^VALM10(LN,"MESSAGE",IOINHI,IOINORM)
 .S VALMCNT=LN
 .Q
 ; loop through all available comments
 S IBDATE="" F  S IBDATE=$O(^DGCR(399,IBIFN,"TXC","B",IBDATE),-1) Q:IBDATE=""  D
 .S I=$O(^DGCR(399,IBIFN,"TXC","B",IBDATE,"")),IB0=^DGCR(399,IBIFN,"TXC",I,0),IBDUZ=$P(IB0,U,2)
 .D SET^VALM10(LN,"") S LN=LN+1
 .S STR="",STR=$$SETFLD^VALM1("Entered by "_$$GET1^DIQ(200,IBDUZ,.01)_" on "_$$FMTE^XLFDT(IBDATE,"2Z"),STR,"ENTERED")
 .D SET^VALM10(LN,STR),FLDCTRL^VALM10(LN) S LN=LN+1
 .; loop through comment lines
 .S CMLN=0 F  S CMLN=$O(^DGCR(399,IBIFN,"TXC",I,1,CMLN)) Q:CMLN=""  D
 ..S CMSTR=^DGCR(399,IBIFN,"TXC",I,1,CMLN,0) ; complete comment line
 ..S MAX=$P(VALMDDF("MESSAGE"),U,3) ; max. number of characters in the "MESSAGE" field
 ..; if comment line is too long, split it into chunks that fit in the "MESSAGE" field
 ..F  D  Q:CMSTR=""
 ...S (POS,LEN)=$L(CMSTR) I LEN>MAX S POS=MAX F  Q:POS=0  Q:$E(CMSTR,POS)=" "  S POS=POS-1 ; try to make a split on a space char.
 ...S:'POS POS=MAX ; if we couldn't find a space, split at the max. number of chars
 ...; populate list manager array with this substring and remove it from the comment line
 ...S STR="",STR=$$SETFLD^VALM1($E(CMSTR,1,POS),STR,"MESSAGE") D SET^VALM10(LN,STR) S LN=LN+1,CMSTR=$E(CMSTR,POS+1,LEN)
 ...Q
 ..Q
 .Q
 S VALMCNT=LN-1,VALMBG=1
 D CLEAN^DILF
 Q
 ;
HELP ; help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; exit code
 N COL,I,LN,STR,WIDTH,Z0,Z1,Z2
 ; update status for this claim in MRW list - could have been changed from View Comments
 S (Z0,Z1)=0,Z2=""
 S Z0=$$FIND1^DIC(409.61,,"X","IBCEM MRA MANAGEMENT")
 S:+Z0 Z1=$$FIND1^DIC(409.621,","_Z0_",","X","BILL")
 S:+Z1 Z2=Z1_","_Z0_","
 I Z2'="" D
 .S COL=$$GET1^DIQ(409.621,Z2,.02)
 .S WIDTH=$$GET1^DIQ(409.621,Z2,.03)
 .Q:COL=""!(WIDTH="")
 .S LN=($O(VALMY(""))-1)*3+2,STR=$E($$BN1^PRCAFN(IBIFN)_$S($P($G(^DGCR(399,IBIFN,"TX")),U,10)=1:"*",1:" "),1,WIDTH)
 .F I=1:1:$L(STR) S $E(^TMP("IBCECOB",$J,LN,0),COL+I-1)=$E(STR,I)
 .Q
 ; clean up variables
 D CLEAR^VALM1,CLEAN^VALM10
 Q
 ;
CMNTW ; enter MRA comments - entry point from MRA Worklist screen
 ; we need to select a claim and set IBIFN
 N IBDA,IBIFN,MRAFLG
 S MRAFLG=1
 D SEL^IBCECOB2(.IBDA,1) S:$O(IBDA(0)) IBIFN=+IBDA($O(IBDA(0))) D:$G(IBIFN) CMNT
 S VALMBCK="R"
 Q
 ;
CMNTV ; enter MRA comments - entry point from View MRA Comments screen
 ; IBIFN should already be defined, only need to set a flag used to rebuild list of comments
 N MRAFLG,VCFLG
 S (MRAFLG,VCFLG)=1 D:$G(IBIFN) CMNT
 S VALMBCK="R"
 Q
 ;
CMNT ; enter MRA comments, called from entry points CMNTV and CMNTW above. Also called from ARCA^IBJTA1 (TPJI)
 N DA,DD,DIC,DIK,DLAYGO,X,Y
 W !
 ; make sure this entry is not locked already
 L +^DGCR(399,IBIFN):3 I '$T W !,*7,"Sorry, another user currently editing this entry." D PAUSE^VALM1 Q
 K DO S DIC="^DGCR(399,"_IBIFN_",""TXC"",",DIC(0)="L",DIC("DR")=".03",DA(1)=IBIFN,X=$$NOW^XLFDT,DLAYGO=399.077
 D FILE^DICN
 S DA=+Y I DA>0 D
 .; if no comment has been added, delete the created entry in comments subfile
 .I '$D(^DGCR(399,IBIFN,"TXC",DA,1)) S DIK=DIC D ^DIK Q
 .; if we got here, comment has been added successfully
 .; if called from MRA Worklist or View MRA Comments, ask if status needs to be changed
 .I $G(MRAFLG) S DIE=399,DA=IBIFN,DR="28.1//REVIEW IN PROCESS" D ^DIE D:'$G(VCFLG) BLD^IBCECOB1
 .; if action was invoked from View Comments, rebuild the list of comments
 .D:$G(VCFLG) CLEAN^VALM10,INIT
 .Q
 D CLEAN^DILF
 L -^DGCR(399,IBIFN)
 Q
 ;
STATUS ; change MRA review status
 N DA,DIE,DR,IBDA,IBIFN,SEL
 D SEL^IBCECOB2(.IBDA,1) S:$O(IBDA(0)) IBIFN=+IBDA($O(IBDA(0))) G:'$G(IBIFN) STATUSX
 W !
 ; make sure this entry is not locked already
 L +^DGCR(399,IBIFN):3 I '$T W !,*7,"Sorry, another user currently editing this entry." D PAUSE^VALM1 G STATUSX
 S DIE=399,DA=IBIFN,DR="28.1//REVIEW IN PROCESS" D ^DIE,CLEAN^DILF
 ;update list manager display
 D BLD^IBCECOB1
 L -^DGCR(399,IBIFN)
STATUSX ;
 S VALMBCK="R"
 Q
