FBUCED ;ALBISC/TET - EDIT UNAUTHORIZED CLAIM FILES ;10/16/2001
 ;;3.5;FEE BASIS;**32,38**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
EDT ;edit unauthorized claim with order less than 40 (not dispositioned
 ;or order = 40 if action is reopen (called by REO tag)
 S:'$D(FBACT) FBACT="EDT" S FBO=$S(FBACT="EDT":"5^10^20^30^",1:"40^")
 D LOOKUP^FBUCUTL3(FBO) I 'FBOUT S FBDR="[FB UNAUTHORIZED EDIT]" D EDIT^FBUCED0(FBDR,FBACT,.FBOUT,FBARY)
 G END Q
REO ;reopen a dispositioned claim (order of 40)
 S FBACT="REO" G EDT
 Q
APL ;appeal a dispostioned claim (order of 40)
 S FBACT="APL",FBO="40^" D LOOKUP^FBUCUTL3(FBO) I 'FBOUT S FBDR="[FB UNAUTHORIZED APPEAL]" D EDIT^FBUCED0(FBDR,FBACT,.FBOUT,FBARY)
 G END Q
AED ;edit an appeal to an unauthorized claim
 S FBACT="AED",FBO="50^55^60^70^" D LOOKUP^FBUCUTL3(FBO) I 'FBOUT S FBDR="[FB UNAUTHORIZED APPEAL EDIT]" D EDIT^FBUCED0(FBDR,FBACT,.FBOUT,FBARY)
 G END Q
COVA ;enter/edit a COVA appeal
 S FBACT="COVA",FBO="70^80^90^" D LOOKUP^FBUCUTL3(FBO) I 'FBOUT S FBDR="[FB UNAUTHORIZED COVA APPEAL]" D EDIT^FBUCED0(FBDR,FBACT,.FBOUT,FBARY)
 G END Q
DIS ;disposition an appeal
 S FBACT="DIS",FBO=0 D LOOKUP^FBUCUTL3(FBO) I 'FBOUT S FBDR="[FB UNAUTHORIZED DISPOSITION]" D EDIT^FBUCED0(FBDR,FBACT,.FBOUT,FBARY)
 G END Q
REC ;receive information which was requested
 S FBACT="REC",FBO="5^10^50^55^" D LOOKUP^FBUCUTL3(FBO) I 'FBOUT,+$G(FBARY) H:+FBARY=1 1 D EDIT8
 G END
REQ ;request information
 S FBACT="REQ",FBO="5^10^20^30^50^55^" D LOOKUP^FBUCUTL3(FBO) I 'FBOUT,+$G(FBARY) D EDIT8
 G:$G(FBOUT) END D END W !! G REQ
LET ;to update date letter printed without printing letter
 N FBLETDT D DISPNP^FBUCUTL3 ;set array of letters which are waiting to be printed
 D DISPX^FBUCUTL1(1) ;display array for selection
 I 'FBOUT,+$G(FBARY) D LETDATE^FBUCUTL3 I 'FBOUT D
 .N FBDA,FBEXP,FBI,FBLET,FBNODE,FBPL,FBUCA D PARSE^FBUCUTL4(FBARY) S FBI=0,FBLET="@" S FBLETDT=$S('+FBLETDT:DT,1:FBLETDT)
 .F  S FBI=$O(^TMP("FBARY",$J,FBI)) Q:'FBI  S FBNODE=$G(^(FBI)),FBDA=+FBNODE,FBUCA=$G(^FB583(FBDA,0)),FBEXP=$$EXPIRE^FBUCUTL8(FBDA,FBLETDT,FBUCA,$$ORDER^FBUCUTL($P(FBUCA,U,24))) D EDITL(FBDA,FBEXP,FBLET,FBLETDT)
 G END
EXT ;enter extensions for incomplete Mill Bill claims
 ;
 ; select mill bill claim(s) with an appropriate status
 S FBACT="EXT",FBO="5^10^" D LOOKUP^FBUCUTL3(FBO,,"M")
 Q:'+$G(FBARY)!FBOUT
 N FBDA,FBI,FBNODE,FBPL,FBW
 D PARSE^FBUCUTL4(FBARY)
 ;
 ; loop through all selected claims
 S FBI=0 F  S FBI=$O(^TMP("FBARY",$J,FBI)) Q:'FBI  D  Q:FBOUT
 . S FBNODE=$G(^TMP("FBARY",$J,FBI))
 . S FBDA=+$P(FBNODE,";")
 . N DA,DIE,DIR,DR,FBEXP,FBEXT,FBEXTD,FBUCA,FBY,Y
 . ; if more than one claim selected then display current one
 . I +$G(FBARY)>1 D LINE^FBUCUTL4(FBNODE,FBI,FBPL,FBW)
 . ; lock claim
 . D LOCK^FBUCUTL("^FB583(",FBDA) Q:'FBLOCK
 . ;
 . S FBUCA=$G(^FB583(FBDA,0))
 . ;
 . ; get current expiration date (if any)
 . S FBEXP=$P(FBUCA,U,26)
 . ;
 . ; get most recent extension (if any)
 . S FBEXT=$$EXT^FBUCUTL8(FBDA,10)
 . I FBEXT W !,"Current extension date is "_$$FMTE^XLFDT($P(FBEXT,U,2))
 . ;
 . ; prompt for new extension date
 . S FBEXTD="" F  D  Q:FBEXTD]""!FBOUT
 . . K DA
 . . I FBEXT S DA(1)=FBDA,DA=+FBEXT ; use existing value as the default
 . . S DIR(0)="162.701,.04"
 . . D ^DIR K DIR I $D(DIRUT) S FBOUT=1 Q
 . . S FBEXTD=Y
 . . ; confirm
 . . S DIR(0)="Y"
 . . S DIR("A")="Confirm entry of "_$$FMTE^XLFDT(FBEXTD)_" as the new extension date for the claim"
 . . D ^DIR K DIR I $D(DIRUT) S FBOUT=1 Q
 . . I 'Y S FBEXTD=""  ; prompt again
 . . I FBEXTD=$P(FBEXT,U,2) W !,"New extension date is equal to existing extension date. No change made." S FBEXTD=0
 . ;
 . I FBEXTD,'FBOUT D
 . . ; save extension
 . . K DA,DD,DO,DIC,DIE
 . . S DA(1)=FBDA
 . . S DIC="^FB583(DA(1),3,",DIC(0)="L",X=$$NOW^XLFDT()
 . . S DIC("DR")=".02////^S X=DUZ;.03///INCOMPLETE UNAUTHORIZED CLAIM;.04///^S X=FBEXTD"
 . . D FILE^DICN I Y'>0 W !,"ERROR ADDING EXTENSION" Q
 . . S DA=+Y
 . . ;
 . . ; prompt for optional comments
 . . S DIE="^FB583(DA(1),3,",DR=".05" D ^DIE
 . . ;
 . . ; recompute expiration date if one already exists and update claim
 . . I FBEXP D
 . . . N FBLETDT,FBORDER
 . . . S FBLETDT=$P(FBUCA,U,19)
 . . . S FBORDER=$$ORDER^FBUCUTL($P(FBUCA,U,24))
 . . . S FBEXP=$$EXPIRE^FBUCUTL8(FBDA,FBLETDT,FBUCA,FBORDER)
 . . . D EDITL^FBUCED(FBDA,FBEXP)
 . ;
 . ; unlock claim
 . L -^FB583(FBDA)
 ;
 G END
REQENT ;enter/edit requested information file, 162.93
 S DLAYGO=162.93,DIC(0)="AELMQZ",DIC="^FB(162.93," D ^DIC K DLAYGO I +Y>0 S DIE=DIC,DA=+Y,FBDA=DA,DR=".01:1" D LOCK^FBUCUTL(DIE,FBDA,0) I FBLOCK D ^DIE L -^FB(162.93,FBDA) K DIE,DE,DA,DQ,DR,FBDA,FBLOCK W ! G REQENT
 G END
DISENT ;enter/edit disapproval reasons file 162.94
 S DLAYGO=162.94,DIC(0)="AELMQZ",DIC="^FB(162.94," D ^DIC K DLAYGO I +Y>0 S DIE=DIC,DA=+Y,FBDA=DA,DR=".01:1" D LOCK^FBUCUTL(DIE,FBDA,0) I FBLOCK D ^DIE L -^FB(162.94,FBDA) K DIE,DE,DA,DQ,DR,FBDA,FBLOCK W ! G DISENT
 G END
DSPENT ;edit disposition file 162.91
 S DIC(0)="AEMQZ",DIC="^FB(162.91," D ^DIC I +Y>0 S DIE=DIC,DA=+Y,FBDA=DA,DR="1:3" D LOCK^FBUCUTL(DIE,FBDA,0) I FBLOCK D ^DIE L -^FB(162.91,FBDA) K DIE,DE,DA,DQ,DR,FBDA,FBLOCK W ! G DSPENT
END ;kill and quit
 K DA,DE,DIC,DIE,DQ,DR,DTOUT,DUOUT,FBACT,FBAR,FBARY,FBDR,FBIEN,FBIX,FBLOCK,FBO,FBOUT,FBUCPDX,X,Y
 K ^TMP("FBAR",$J),^TMP("FBARY",$J),^TMP("FBPARY",$J) Q
EDIT8 ;edit file 162.8, call before/after & update
 N FBDA,FBI,FBNODE,FBP,FBPL,FBUCA,FBUCAA,FBUCP,FBUCPA,FBW D PARSE^FBUCUTL4(FBARY) S %X="^TMP(""FBARY"",$J,",%Y="^TMP(""FBPARY"",$J," D %XY^%RCR K %X,%Y
 S FBI=0 F  S FBI=$O(^TMP("FBPARY",$J,FBI)) Q:'FBI  S FBNODE=$G(^(FBI)),FBDA=+FBNODE,FBNODE=$P(FBNODE,";",2) D  G:FBOUT END
 .I +$G(FBPARY)>1 W !! F FBP=1:1:FBPL W ?($P(FBW,U,FBP)),$P(FBNODE,U,FBP)
 .D PRIOR^FBUCEVT(FBDA,FBACT)
 .N FBARY D REQ^FBUCPEND:FBACT="REQ",REC^FBUCPEND:FBACT="REC" Q:FBOUT  D FREQ^FBUCPEND:FBACT="REQ",FREC^FBUCPEND:FBACT="REC"
 .D AFTER^FBUCEVT(FBDA,FBACT),^FBUCUPD(FBUCP,FBUCPA,FBUCA,FBUCAA,FBDA,FBACT)
 Q
EDITL(FBDA,FBEXP,FBLET,FBLETDT,FBTAMT) ;edit letter sent info,
 ;may be called to just update expiration, or update print flag, date letter sent &/or expiration, or amount approved
 ;INPUT:  FBDA = ien of unauthorized claim (# 162.7)
 ;        FBEXP = expiration date (optional)
 ;        FBLET = flag for letter printed (optional)
 ;        FBLETDT = date letter sent (optional)
 ;        FBLET = '@' to delete letter flag
 ;        FBEXP = expiration date or 0
 ;        FBTAMT = amount approved (optional)
 ;OUTPUT: nothing -  update all or some flds in 162.7:  19,19.5,26,14
 Q:'+$G(FBDA)
 S FBEXP=+$G(FBEXP),FBLET=$G(FBLET),FBLETDT=+$G(FBLETDT)
 S FBTAMT=$G(FBTAMT)
 I 'FBEXP,FBLET']"",'FBLETDT,FBTAMT']"" Q
 N FBLOCK,DIE,DA,DR
 S DIE="^FB583(",DR="[FB UNAUTHORIZED LETTER UPDATE]",DA=FBDA
 D LOCK^FBUCUTL(DIE,DA,1) I FBLOCK D ^DIE L -^FB583(FBDA) K FBLOCK
 Q
