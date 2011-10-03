TIUFLF5 ; SLC/MAM - Library; File 8925.1 Related: STATSCRN(),STATLIST(FILEDA,PFILEDA,NEWSTAT,STATMSG,STATLIST), ANCSTAT(FILEDA), POSSSTAT(TYPE), STATOK(TYPE,NEWSTAT), SELSTAT(FILEDA,PFILEDA,DEFLT),STATWORD(PIECE7) ;4/17/97  23:35
 ;;1.0;TEXT INTEGRATION UTILITIES;**5**;Jun 20, 1997
 ;
STATSCRN() ; Function returns DD Status Screen for Status Field .07:
 ;Permits only Statuses which apply to Document Definitions.
 ; Used only as an additional safeguard for persons using FILEMAN.
 ;INACTIVE, TEST, ACTIVE.
 Q "I ($P(^(0),U,4)=""DEF"")"
 ;
STATOK(TYPE,NEWSTAT) ; Function returns 1/0 if NEWSTAT is/isn't permissible for TYPE.
 ; Requires internal Type e.g. CL; Requires NEWSTAT= I, T, or A.
 N ANS,STAT,MSG
 S STAT=$$POSSSTAT(TYPE)
 I STAT[NEWSTAT S ANS=1 G STOKX
 S MSG=" Status Limited to "_$S(STAT="ITA":"I, T, or A: ",STAT="IA":"I or A: ",1:"I: ")_$S(STAT="I":"No Type/Bad Type",1:^TMP("TIUF",$J,"TYPE"_TYPE))
 W !!,MSG,!
 S ANS=0
STOKX Q ANS
 ;
STATLIST(FILEDA,PFILEDA,NEWSTAT,STATMSG,STATLIST) ; Module sets List of possible Statuses, sets msg explaining any limitations on Status
 ; Requires FILEDA of 8925.1 entry whose Status is being edited, as set in ASKSTAT^TIUFLF6.
 ; Requires PFILEDA if FILEDA has an actual or prospective parent
 ;(as in Create, Add Items).
 ; Optional NEWSTAT = I, T, or A for anticipated new status.  If entry hs bad status but user is correcting it, don't tell them it's bad.
 ; Optional STATLIST: Returns STATLIST = subset of "AIT", representing acceptable Statuses.
 ; STATLIST is called BEFORE user edits status of particular entry.
 N NODE0,TYPE,POSSSTAT,ANCSTAT,STATUS
 S PFILEDA=+$G(PFILEDA),STATMSG=""
 S NODE0=^TIU(8925.1,FILEDA,0),TYPE=$P(NODE0,U,4),POSSSTAT=$$POSSSTAT(TYPE)
 N TIUFCK D CHECK^TIUFLF3(FILEDA,PFILEDA,1,.TIUFCK) G:$D(DTOUT) STATX
 ;            Problem with Check:
 I 'TIUFCK D  I $L($G(STATMSG)) G STATX
 . ;          Problem with Check is Wrong Status:
 . I $D(TIUFCK("S")) D  Q
 . . S STATLIST=POSSSTAT
 . . ;        If going to change Status to permissable one, and Status is the ONLY problem, don't set msg:
 . . I $D(NEWSTAT),POSSSTAT[$E(NEWSTAT) K TIUFCK("S") I $D(TIUFCK)'>9 Q
 . . ;        If present Status is wrong set msg:
 . . I TYPE="CL"!(TYPE="DC")!(TYPE="O") S STATMSG="  Status Limited to A or I: "_^TMP("TIUF",$J,"TYPE"_TYPE) Q
 . K TIUFCK("S") I $D(TIUFCK)'>9 Q
 . ;          Problem with Check is not Status:
 . I $G(NEWSTAT)'="I" S STATLIST="I",STATMSG=" Status Limited to I: "_$P(TIUFCK,U,2)
 ;            Inactive Ancestor Problem:
 I 'PFILEDA G STATX
 S ANCSTAT=$$ANCSTAT(FILEDA,PFILEDA)
 I ANCSTAT D  S STATLIST="I" G STATX
 . ; Limits STATLIST to I if entry has inactive (or no status) ancestor.
 . ;Sets Ancestor msg only if inactive ancestor AND user has mistakenly chosen something other than inactive on the first try at editing
 . S STATUS=$S($G(Y):$E($G(^TMP("TIUF",$J,"STAT"_Y))),1:$G(NEWSTAT))
 . I STATUS'="I" S STATMSG=" Status Limited to I: Inactive Ancestor"
STATX I '$D(STATLIST) D
 . I POSSSTAT="I" S STATLIST="I" Q:$G(NEWSTAT)="I"
 . I POSSSTAT="A" S STATLIST="A" Q:$G(NEWSTAT)="A"
 . I POSSSTAT="IA" S STATLIST="IA" Q:"IA"[$G(NEWSTAT)
 . I '$D(STATLIST) S STATLIST="ITA" Q
 . I TYPE="CL"!(TYPE="DC")!(TYPE="O") S STATMSG=" Status Limited to A or I: "_^TMP("TIUF",$J,"TYPE"_TYPE) Q
 Q
 ;
ANCSTAT(FILEDA,PFILEDA) ; Function returns 1 if any Ancestor is Inactive [or has no status];
 N PNODE0,PANCEST,ANSTAT,TIUI,PANCSTAT
 ;Check parent separately since item may have only PROSPECTIVE parent:
 S ANSTAT=0,PNODE0=^TIU(8925.1,PFILEDA,0),PANCSTAT=$P(PNODE0,U,7)
 I PANCSTAT=+^TMP("TIUF",$J,"STATI")!'PANCSTAT S ANSTAT=1 G ANCSX
 D ANCESTOR^TIUFLF4(PFILEDA,PNODE0,.PANCEST)
 F TIUI=1:1 Q:'$G(PANCEST(TIUI))  D  Q:ANSTAT
 . S PANCSTAT=$P(^TIU(8925.1,PANCEST(TIUI),0),U,7)
 . I PANCSTAT=+^TMP("TIUF",$J,"STATI")!'PANCSTAT S ANSTAT=1
ANCSX Q ANSTAT
 ;
POSSSTAT(TYPE) ; Function returns permissible Statuses for Type
 ; Permissible Statuses is string subset of ITA: (Inactive, Test, Active)
 ; Requires internal Type e.g. CL
 N POSSSTAT
 S POSSSTAT=$S(TYPE="CL":"IA",TYPE="DC":"IA",TYPE="DOC":"ITA",TYPE="CO":"ITA",TYPE="O":"IA",1:"I") ; Inactive for bad or no Type.
 Q POSSSTAT
 ;
SELSTAT(FILEDA,PFILEDA,DEFLT) ; Function Prompts for Status, Returns Selected Status: ActiveIFN^ACTIVE, InactiveIFN^INACTIVE, TestIFN^TEST,  "" if nothing selected or @ entered.
 ; Optional FILEDA: not received for Edit Status.
 ; Optional PFILEDA
 ; Optional DEFLT = 'INACTIVE', etc.
 ; FILEDA, PFILEDA,DEFLT are needed when editing Status under Edit Basics
 ;NOT needed when selecting Status for Edit Status. 
 ; 
 ; Requires TIUFXNOD
 ; NOTE: In order to write reasons for limits on status when editing status, edit is done with a FREE TEXT reader call, a list of permissible statuses, and a check of the result.  So don't look for a screen on the status field.
 N DIR,X,Y,DA,STATUS,AOK,INACTOK,TOK,CHOICE,STATSCRN,TIUFSMSG
 N TIUFSLST,STATOK
 I '$G(FILEDA) S FILEDA=0
 S DIR(0)=$S(TIUFXNOD["Status...":"FAO^1:9",1:"FA^1:9"),(DIR("?"),DIR("??"))="^D STATUS^TIUFXHLX"
 I $D(DEFLT) S DIR("B")=DEFLT
 ;TIUFSMSG, TIUFSLST set by STATLIST; used in Xecut help
 I FILEDA D STATLIST(FILEDA,+$G(PFILEDA),0,.TIUFSMSG,.TIUFSLST) G:$D(DTOUT) SELSX D
 . S (AOK,INACTOK,TOK)=0
 . S:TIUFSLST["A" AOK=1 S:TIUFSLST["I" INACTOK=1 S:TIUFSLST["T" TOK=1
 . S CHOICE=""
 . I AOK S CHOICE=CHOICE_$S(CHOICE'="":"/A",1:"A")
 . I INACTOK S CHOICE=CHOICE_$S(CHOICE'="":"/I",1:"I")
 . I TOK S CHOICE=CHOICE_$S(CHOICE'="":"/T",1:"T")
 . S CHOICE="("_CHOICE_")"
 I 'FILEDA D
 . I TIUFXNOD["Status..." D
 . . I $P($G(TIUFATTR),U)="T",$P($G(TIUFAVAL),U)="O" S CHOICE="(A/I)",TIUFSLST="AI",TIUFSMSG="Status limited to A or I: OBJECT" Q
 . . S CHOICE="(A/I/T)",TIUFSLST="AIT"
 S DIR("A")=$S('FILEDA:"Select STATUS",1:"STATUS")_": "_CHOICE_": "
AGAIN D ^DIR I $D(DTOUT)!$D(DUOUT) S STATUS="" G SELSX
 S STATUS=$$UPPER^TIULS(Y)
 D  I 'STATOK G AGAIN
 . S STATOK=1
 . I $E(STATUS)="A","ACTIVE"[STATUS W:(STATUS'="ACTIVE") "  ACTIVE" S STATUS=^TMP("TIUF",$J,"STATA") Q  ;11^ACTIVE
 . I $E(STATUS)="I","INACTIVE"[STATUS W:(STATUS'="INACTIVE") "  INACTIVE" S STATUS=^TMP("TIUF",$J,"STATI") Q
 . I $E(STATUS)="T","TEST"[STATUS W:(STATUS'="TEST") "  TEST" S STATUS=^TMP("TIUF",$J,"STATT") Q
 . I STATUS'="" W "  ??  Enter '^' to exit" S STATOK=0 Q
 I FILEDA,STATUS,TIUFSLST'[$E($P(STATUS,U,2)) S STATUS="" W "  ??" G AGAIN ; User entered something that doesn't pass screen.
SELSX S:$D(DTOUT) STATUS=""
 Q STATUS
 ;
STATWORD(PIECE7) ; Function returns Status as a word: ACTIVE, TEST, INACTIVE or NO/BAD
 ; NO/BAD if no status or status is missing from 8925.6 status file, or status is not entry active, test or inactive in 8925.6.
 ; Requires PIECE7= fld .07 of 8925.1 entry, could be null
 N STATANS
 I '$D(^TMP("TIUF",$J,"STATI")) D SETUP^TIUFL
 S STATANS=$G(^TMP("TIUF",$J,"STAT"_+PIECE7))
 I (STATANS'="ACTIVE"),(STATANS'="TEST"),(STATANS'="INACTIVE") S STATANS="NO/BAD"
 Q STATANS
 ;
