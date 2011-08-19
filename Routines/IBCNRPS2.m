IBCNRPS2 ;BHAM ISC/ALA - Plan Match ListMan ;13-NOV-2003
 ;;2.0;INTEGRATED BILLING;**276**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;;
EN ; -- main entry point for IBCNR PLAN MATCH
 D EN^VALM("IBCNR PLAN STATUS INQUIRY")
 Q
 ;
HDR ; -- header code
 N IBCNS0,IBCNS11,IBCNS13,IBLEAD,X,X1,X2
 S IBCNS0=$G(^DIC(36,+IBCNSP,0))
 S IBCNS11=$G(^DIC(36,+IBCNSP,.11))
 S IBCNS13=$G(^DIC(36,+IBCNSP,.13))
 S IBLEAD="All Plans for: "
 S X="Phone: "_$S($P(IBCNS13,"^")]"":$P(IBCNS13,"^"),1:"<not filed>")
 S VALMHDR(1)=$$SETSTR^VALM1(X,IBLEAD_$P(IBCNS0,"^"),81-$L(X),40)
 S X1="Precerts: "_$S($P(IBCNS13,"^",3)]"":$P(IBCNS13,"^",3),1:"<not filed>")
 S X=$TR($J("",$L(IBLEAD)),""," ")_$S($P(IBCNS11,"^")]"":$P(IBCNS11,"^"),1:"<no street address>")
 S VALMHDR(2)=$$SETSTR^VALM1(X1,X,81-$L(X1),40)
 S X=$S($P(IBCNS11,"^",4)]"":$P(IBCNS11,"^",4),1:"<no city>")_", "
 S X=X_$S($P(IBCNS11,"^",5):$P($G(^DIC(5,$P(IBCNS11,"^",5),0)),"^",2),1:"<no state>")_"  "_$E($P(IBCNS11,"^",6),1,5)_$S($E($P(IBCNS11,"^",6),6,9)]"":"-"_$E($P(IBCNS11,"^",6),6,9),1:"")
 S VALMHDR(3)=$$SETSTR^VALM1(X,"",$L(IBLEAD)+1,80)
 S X="For:  ",X=$E(X_$J("",23),1,23)_$S(IBCNTYP="A":"All",IBCNTYP="P":"Pharmacy Covered",1:"Matched")_" Group Plans."
 S VALMHDR(4)=$$SETSTR^VALM1(" ",X,64,17)
 Q
 ;
INIT ; -- init variables and create list array or report array
 N IBGP0,IBCPOLD,X,IBCPD6,IBCNRPP,IBCOV,IBCVRD,LIM
 K ^TMP("IBCNR",$J)
 S VALMCNT=0,VALMBG=1,IBCNGP=0
 F  S IBCNGP=$O(^IBA(355.3,"B",IBCNSP,IBCNGP)) Q:'IBCNGP  D
 . ; if we want all plans, let it pass
 . I IBCNTYP="A" D  Q
 . . D SETPLAN(IBCNGP)
 . ; if we want Pharmacy plans, check for pharms
 . I IBCNTYP="P" D  Q
 . . S IBCOV=$O(^IBE(355.31,"B","PHARMACY",""))
 . . S LIM="",IBCVRD=0
 . . F  S LIM=$O(^IBA(355.32,"B",IBCNGP,LIM)) Q:LIM=""  D
 . . . I $P(^IBA(355.32,LIM,0),U,2)=IBCOV S IBCVRD=$P(^IBA(355.32,LIM,0),U,4)
 . . I IBCVRD D SETPLAN(IBCNGP)
 . ; if we want Matched plans, check for existence of Plan ID
 . I IBCNTYP="M" D  Q
 . . I $P($G(^IBA(355.3,IBCNGP,6)),U)'="" D SETPLAN(IBCNGP)
 I VALMCNT=0 D
 . S ^TMP("IBCNR",$J,"SI",1,0)="No Plans Available"
 . S ^TMP("IBCNR",$J,"SI","IDX",1,1)=IBCNGP
 Q
 ;
SETPLAN(IBCNGP) ;
 ; create text
 N IBGPZ,I,IBPLN,IBPLNA
 S VALMCNT=VALMCNT+1
 S IBGPZ=^IBA(355.3,+IBCNGP,0)
 ; if creating report and not a list 
 I $G(IBCNRRPT) D  Q
 . ; Group Name, Group #, Group Type, Plan ID, Plan Status
 . S X=$$FO^IBCNEUT1($P(IBGPZ,U,3),18)
 . S X=X_" "_$$FO^IBCNEUT1($P(IBGPZ,U,4),17)
 . S X=X_" "_$$FO^IBCNEUT1($$EXPAND^IBTRE(355.3,.09,$P(IBGPZ,U,9)),13)
 . S IBPLN=$P($G(^IBA(355.3,+IBCNGP,6)),U)
 . ; check for plan
 . I IBPLN="" D  Q
 . . S ^TMP("IBCNR",$J,"DSPDATA",VALMCNT)=X
 . . S VALMCNT=VALMCNT+1,^TMP("IBCNR",$J,"DSPDATA",VALMCNT)="No Plan Found."
 . ; check plan status information
 . S IBPLNA=$P($G(^IBCNR(366.03,IBPLN,0)),U)
 . S X=X_" "_$$FO^IBCNEUT1(IBPLNA,13)
 . ;
 . N ARRAY D STCHK^IBCNRU1(IBPLN,.ARRAY)
 . S X=X_"      "_$$FO^IBCNEUT1($S($G(ARRAY(1))="I":"INACTIVE",1:"ACTIVE"),8)
 . S ^TMP("IBCNR",$J,"DSPDATA",VALMCNT)=X
 . I $G(ARRAY(6)) D
 . . N STATAR
 . . D STATAR^IBCNRU1(.STATAR)
 . . F I=1:1:$L(ARRAY(6),",") D
 . . . S VALMCNT=VALMCNT+1
 . . . S ^TMP("IBCNR",$J,"DSPDATA",VALMCNT)="       "_$G(STATAR($P(ARRAY(6),",",I)))
 ;
 S X=$$SETFLD^VALM1(VALMCNT,"","NUMBER")
 ;
 I '$P(IBGPZ,U,2) S $E(X,4)="+"
 S X=$$SETFLD^VALM1($P(IBGPZ,U,3),X,"GNAME")
 ;
 I '$P(IBGPZ,U,11) S $E(X,24)="*"
 S X=$$SETFLD^VALM1($P(IBGPZ,U,4),X,"GNUM")
 ; 
 S X=$$SETFLD^VALM1($$EXPAND^IBTRE(355.3,.09,$P(IBGPZ,U,9)),X,"TYPE")
 ; matched plan active or not
 S IBPLN=$P($G(^IBA(355.3,+IBCNGP,6)),U)
 I IBPLN'="" D
 . S IBPLNA=$P($G(^IBCNR(366.03,+IBPLN,0)),U)
 . S X=$$SETFLD^VALM1(IBPLNA,X,"PHARM")
 . N ARRAY
 . D STCHK^IBCNRU1(IBPLN,.ARRAY)
 . S X=$$SETFLD^VALM1($S($G(ARRAY(1))="A":"ACTIVE",1:"INACTIVE"),X,"COV")
 S ^TMP("IBCNR",$J,"SI",VALMCNT,0)=X
 S ^TMP("IBCNR",$J,"SI","IDX",VALMCNT,VALMCNT)=IBCNGP
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K ^TMP("IBCNR",$J),VALMBCK,VALMY
 D CLEAN^VALM10,CLEAR^VALM1
 Q
 ;
SEL ; -- select plan
 N IBSEL,IBX
 D S1
 I 'IBX Q  ; no group selected
 ;
 D 
 . N IBCNRRPT,IBCNGP,VALMCNT,LST,IBCNRDEV
 . S VALMCNT=0,IBCNRRPT=1,IBCNRDEV=0,IBCNGP=IBSEL
 . K ^TMP("IBCNR",$J,"DSPDATA")
 . D SETPLAN(IBSEL)
 . D PRINT^IBCNRPSI
 D SPQ
 Q
S1 ;
 N DIR,DIRUT,DUOUT,DTOUT,DIROUT,IBOK,IBQUIT,Y
 D EN^VALM2($G(XQORNOD(0)),"S"),FULL^VALM1
 S IBX=$O(VALMY(0)),VALMBCK="R"
 ;
 I 'IBX W !!,"No group selected!" G SPQ
 S IBSEL=+$G(^TMP("IBCNR",$J,"SI","IDX",IBX,IBX))
 Q
 ;
SPQ ;
 I '$O(IBSEL(0)),VALMBCK="R" D PAUSE^VALM1
 Q
