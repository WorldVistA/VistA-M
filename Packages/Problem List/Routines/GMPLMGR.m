GMPLMGR ; SLC/MKB/AJB -- Problem List VALM Utilities ;3/1/00  12:28
 ;;2.0;Problem List;**21,28**;Aug 25, 1994
 ; 28 Feb 00 - MA added view comments accross Divisions
INIT ; -- init variables, list array
 S:'$G(GMPDFN) GMPDFN=$$PAT^GMPLX1 I +GMPDFN'>0 K GMPDFN S VALMQUIT=1 Q
 S GMPROV=$$REQPROV^GMPLX1 I +GMPROV'>0 K GMPDFN,GMPROV S VALMQUIT=1 Q
IN1 S GMPVA=$S($G(DUZ("AG"))="V":1,1:0),GMPVAMC=+$G(DUZ(2))
 S (GMPSC,GMPAGTOR,GMPION,GMPGULF)=0 D:GMPVA VADPT^GMPLX1(+GMPDFN) ;reset
 S GMPLVIEW("ACT")="A",GMPLVIEW("PROV")=0
 S GMPLVIEW("VIEW")=$$VIEW^GMPLX1(DUZ)
 S X=$G(^GMPL(125.99,1,0)),GMPARAM("VER")=+$P(X,U,2),GMPARAM("PRT")=+$P(X,U,3),GMPARAM("CLU")=+$P(X,U,4),GMPARAM("REV")=$S($P(X,U,5)="R":1,1:0) K X
 D GETPLIST^GMPLMGR1(.GMPLIST,.GMPTOTAL,.GMPLVIEW),BUILD(.GMPLIST)
 D:$E(GMPLVIEW("VIEW"))="S" CHGCAP^VALM("CLINIC","Service/Provider")
 S VALMSG=$$MSG^GMPLX
 Q
 ;
BUILD(PLIST) ; -- build list array
 N I D CLEAN^VALM10 K ^TMP("GMPLIDX",$J) S (I,GMPCOUNT,VALMCNT)=0
 D:$D(XRTL) T0^%ZOSV ; Start RT Monitor
 F  S I=$O(PLIST(I)) Q:I'>0  D:$D(GMPLUSER) BLDPROB(+PLIST(I)) D:'$D(GMPLUSER) BLDPROB^GMPLMGR2(+PLIST(I))
 S ^TMP("GMPL",$J,0)=+$G(GMPCOUNT)_U_+$G(VALMCNT) ; # entries^# lines
 S:$D(XRT0) XRTN=$T(+0) D:$D(XRT0) T1^%ZOSV ; Stop RT Monitor
 I $G(GMPCOUNT)'>0 S ^TMP("GMPL",$J,1,0)="   ",^TMP("GMPL",$J,2,0)="    No data available meeting criteria."
 Q
BLDPROB(IFN) ; Add problem line
 N GMPL0,GMPL1,DATE,TEXT,NAME,LINE,ACTIVE,I,NOTE,FAC,PROBLEM,NIFN,DELETED
 S GMPL0=$G(^AUPNPROB(IFN,0)),GMPL1=$G(^(1)) Q:'$L(GMPL0)
 S DELETED=$S($P(GMPL1,U,2)="H":1,1:0) ; flag if prob was deleted
 S ACTIVE=$P(GMPL0,U,12),DATE=$J($$EXTDT^GMPLX($P(GMPL0,U,3)),8)
 S PROBLEM=$S(DELETED:"< DELETED >",1:$$PROBTEXT^GMPLX(IFN))
 I ACTIVE="A",$P(GMPL0,U,13),'DELETED S PROBLEM=PROBLEM_", Onset "_$$EXTDT^GMPLX($P(GMPL0,U,13))
 I ACTIVE="I",$P(GMPL1,U,7),'DELETED S PROBLEM=PROBLEM_", Resolved "_$$EXTDT^GMPLX($P(GMPL1,U,7))
 D WRAP^GMPLX(PROBLEM,40,.TEXT) ; format text to 41 chr
 I $E(GMPLVIEW("VIEW"))="S" S NAME=$$SERV^GMPLX1($P(GMPL1,U,6))_$$NAME^GMPLX1($P(GMPL1,U,5))
 E  S NAME=$P($G(^SC(+$P(GMPL1,U,8),0)),U)
BLD1 S GMPCOUNT=+$G(GMPCOUNT)+1
 S LINE=$$SETFLD^VALM1(GMPCOUNT,"","NUMBER")
 S:ACTIVE="A" ACTIVE=$S($P(GMPL1,U,14)="A":"*",1:"") ; reset for priority
 S LINE=$$SETFLD^VALM1(ACTIVE,LINE,"STATUS")
 S LINE=$$SETFLD^VALM1(TEXT(1),LINE,"PROBLEM")
 S LINE=$$SETFLD^VALM1(DATE,LINE,"DATE")
 S LINE=$$SETFLD^VALM1(NAME,LINE,"CLINIC"),VALMCNT=+$G(VALMCNT)+1
 S ^TMP("GMPL",$J,VALMCNT,0)=LINE,^TMP("GMPL",$J,"IDX",VALMCNT,GMPCOUNT)=""
 S ^TMP("GMPLIDX",$J,GMPCOUNT)=VALMCNT_U_IFN
 I GMPARAM("VER"),$P(GMPL1,U,2)="T",'DELETED S LINE=$E(LINE,1,4)_"$"_$E(LINE,6,79),^TMP("GMPL",$J,VALMCNT,0)=LINE D CNTRL^VALM10(VALMCNT,5,1,IOINHI,IOINORM)
 ; added for Code Set Versioning (CSV) - annotates inactive ICD code with #
 I '$$CODESTS^GMPLX(IFN,DT) S LINE=$E(LINE,1,4)_"#"_$E(LINE,6,79),^TMP("GMPL",$J,VALMCNT,0)=LINE D CNTRL^VALM10(VALMCNT,5,1,IOINHI,IOINORM)
 Q:DELETED
BLD2 I TEXT>1 F I=2:1:TEXT D
 . S LINE="",LINE=$$SETFLD^VALM1(TEXT(I),LINE,"PROBLEM")
 . S VALMCNT=VALMCNT+1,^TMP("GMPL",$J,VALMCNT,0)=LINE
 . S ^TMP("GMPL",$J,"IDX",VALMCNT,GMPCOUNT)=""
 ;Q:'$D(^AUPNPROB(IFN,11,"B",+GMPVAMC))  ; display current user's notes
 ; Routine has been changed to show all Problem List Comments for
 ; Divisions per Clinical Workgroup decision 26 Jan 2000
 F FAC=0:0 S FAC=$O(^AUPNPROB(IFN,11,FAC)) Q:+FAC'>0  D
 . F NIFN=0:0  S NIFN=$O(^AUPNPROB(IFN,11,FAC,11,NIFN)) Q:+NIFN'>0  D
 . . S NOTE=$P($G(^AUPNPROB(IFN,11,FAC,11,NIFN,0)),U,3)
 . . S VALMCNT=VALMCNT+1,^TMP("GMPL",$J,"IDX",VALMCNT,GMPCOUNT)=""
 . . S ^TMP("GMPL",$J,VALMCNT,0)="        "_NOTE
 Q
 ;
HDR ; -- header code
 N HDR,LNM,FNM,PAT,NUM
 S PAT=$P(GMPDFN,U,2)_"  ("_$P(GMPDFN,U,3)_")"
 S NUM=GMPCOUNT S:GMPTOTAL>GMPCOUNT NUM=NUM_" of "_GMPTOTAL
 S NUM=NUM_$S(GMPLVIEW("ACT")="A":" active",GMPLVIEW("ACT")="I":" inactive",1:"")_" problems"
 S VALMHDR(1)=PAT_$J(NUM,79-$L(PAT))
 S HDR=$S(GMPLVIEW("ACT")="I":"INACTIVE",GMPLVIEW("ACT")="A":"ACTIVE",1:"ALL")
 I $L(GMPLVIEW("VIEW"))>2 S HDR=HDR_$S($E(GMPLVIEW("VIEW"))="S":" SERVICE",1:" CLINIC") ; screened
 S HDR=HDR_" PROBLEMS"
 S:GMPLVIEW("PROV") LNM=$P($P(GMPLVIEW("PROV"),U,2),","),FNM=$P($P(GMPLVIEW("PROV"),U,2),",",2),HDR=HDR_" BY "_FNM_" "_LNM
 S VALMHDR(2)=$J(HDR,$L(HDR)\2+41)
 Q
 ;
HELP ; -- help code
 N X
 W !!?4,"To update the problem list first select from Add, Remove, Edit,"
 W !?4 W:GMPARAM("VER") "Verify, "
 W "Inactivate, or Comment, then enter the problem number(s)."
 W !?4,"If you need more information on a problem, select Detailed"
 W !?4,"Display; to change whether all or only selected problems for this"
 W !?4,"patient are listed, choose Select View.  Enter ?? to see more"
 W !?4,"actions for facilitating navigation of the list."
 W !?4,"Problem statuses: *-Acute I-Inactive #-Inactive ICD Code"
 W:GMPARAM("VER") " $-Unverified"
 W !!,"Press <return> to continue ... " R X:DTIME
 S VALMSG=$$MSG^GMPLX,VALMBCK=$S(VALMCC:"",1:"R")
 Q
