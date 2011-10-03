TIURECL2 ; SLC/MAM - Expand/collapse LM views ;1/22/01
 ;;1.0;TEXT INTEGRATION UTILITIES;**100**;Jun 20, 1997
 ; 7/6 Split TIURECL into TIURECL & TIURECL1, move RESOLVE to TIURECL1
 ; 7/10 Move INSID, INSADD, VEXREQ, ISSUB to TIURECL1
 ; 9/7 Move INSKIDS, INSADD & associated mods from TIURECL1 TO ECL2
 ;=======================================================================
INSKIDS(TSTART,TIUDA,PRNTPFIX,SORTBY) ;Insert ID kids
 ;of parent TIUDA into array ^TMP("TMPLIST",$J) in SORTBY order
 ;  Receives TSTART, TIUDA, PRNTPFIX, SORTBY
 ;       TIUDA = ID parent
 ;    PRNTPFIX = prefix of parent, updated for current expand action.
 ;      SORTBY = "REFDT" or "TITLE"
 N KIDDATA,KIDDA,TEXT,FRSTPFIX,ORIGPFIX,NEWPFIX,KIDLIST,TIUK
 ; -- If ID parent has addenda at the parent level,
 ;    as well as ID kids, then first insert addenda: --
 I $$HASADDEN^TIULC1(TIUDA) S TSTART=$$INSADD(TSTART,TIUDA,PRNTPFIX)
 ; -- Get list of ID kids in ref date or title order: --
 D GETIDKID(TIUDA,SORTBY)
 ; -- Set LIST(TSTART)=TEXT_U_KIDDA_U_NEWPFIX and
 ;    ^TMP("TMPLIST",$J,"IDDATA",KIDDA)
 S TIUK=0
 F  S TIUK=$O(^TMP("TIUIDKID",$J,TIUDA,TIUK)) Q:'TIUK  D
 . S KIDDA=^TMP("TIUIDKID",$J,TIUDA,TIUK)
 . S TSTART=TSTART+1
 . S ^TMP("TMPLIST",$J,TSTART)=$$GETLINE(KIDDA,PRNTPFIX,TSTART,.KIDDATA)
 . S ^TMP("TMPLIST",$J,"IDDATA",KIDDA)=KIDDATA
 K ^TMP("TIUIDKID",$J)
 Q TSTART
 ;
GETIDKID(TIUDA,SORTBY) ; Set ^TMP("TIUIDKID",$J,TIUDA,TIUK) = KIDDA,
 ; array of ID kids of TIUDA, in SORTBY order
 N KIDDA,REFDT,TITLE,TIUJ,LIST,TIUK
 S KIDDA=0,TIUJ=0
 F  S KIDDA=$O(^TIU(8925,"GDAD",TIUDA,KIDDA)) Q:+KIDDA'>0  D
 . S TIUJ=TIUJ+1
 . S REFDT=$P(^TIU(8925,KIDDA,13),U)
 . I SORTBY="REFDT" S LIST("HOLDER",REFDT,TIUJ)=KIDDA
 . I SORTBY="TITLE" S TITLE=$$PNAME^TIULC1(+^TIU(8925,KIDDA,0)),LIST(TITLE,REFDT,TIUJ)=KIDDA
 ; -- Flatten the list: --
 S TITLE="",REFDT=0,TIUJ=0,TIUK=0
 F  S TITLE=$O(LIST(TITLE)) Q:TITLE=""  D
 . F  S REFDT=$O(LIST(TITLE,REFDT)) Q:'REFDT  D
 . . F  S TIUJ=$O(LIST(TITLE,REFDT,TIUJ)) Q:'TIUJ  D
 . . . S TIUK=TIUK+1
 . . . S ^TMP("TIUIDKID",$J,TIUDA,TIUK)=LIST(TITLE,REFDT,TIUJ)
 Q
 ;
GETLINE(KIDDA,PRNTPFIX,LINENO,TIUGDATA) ; Return LINE=TEXT_U_KIDDA_U_NEWPFIX
 ; Find & pass back TIUGDATA
 N LINE,ORIGPFIX,NEWPFIX,TEXT,FRSTPFIX
 S ORIGPFIX=$$PREFIX^TIULA2(KIDDA)
 S FRSTPFIX=$$FRSTPFIX(PRNTPFIX)
 S TEXT=$$RESOLVE^TIURECL1(KIDDA,LINENO,FRSTPFIX,.TIUGDATA)
 S NEWPFIX=FRSTPFIX_ORIGPFIX
 S LINE=TEXT_U_KIDDA_U_NEWPFIX
 Q LINE
 ;
FRSTPFIX(PRNTPFIX) ; Return first part of Prefix for Inserted addm
 ;or ID kid of parent.
 ;    Receives PRNTPFIX; returns FRSTPFIX.
 ;    PRNTPFIX = prefix of parent, updated for current expand action.
 ; -- Build first part of kid prefix using PRNTPFIX: --
 ;    EX: if updated prefix of parent is "  |_- ",
 ;        then build FRSTPFIX from left to right:
 ;        Take beginning spaces "  ", keep the "|", replace the _
 ;        with a space, replace INDicators (& the following space)
 ;        with spaces, and tack on "|_" to get: "  |   |_"
 ;     Prefix of kid is then FRSTPFIX_(Original prefix of kid).
 N INDLNGTH,INDSPACE,FRSTPFIX
 I PRNTPFIX["|_" S INDLNGTH=$L($P(PRNTPFIX,"|_",2)) I 1
 E  S INDLNGTH=$L(PRNTPFIX)
 S INDSPACE="",$P(INDSPACE," ",INDLNGTH+1)=""
 I PRNTPFIX["|_" S FRSTPFIX=$P(PRNTPFIX,"|_")_"| "_INDSPACE_"|_" I 1
 E  S FRSTPFIX=INDSPACE_"|_"
 Q FRSTPFIX
 ;
INSADD(TSTART,TIUDA,PRNTPFIX) ;Insert addenda of parent TIUDA into ^TMP("TMPLIST",$J).
 ;  Receives TSTART, TIUDA, PRNTPFIX
 ;    PRNTPFIX = prefix of parent, updated for current expand action.
 N KIDDA,TEXT,FIRSTPFX,ORIGPFIX,NEWPFIX
 S KIDDA=0
 F  S KIDDA=$O(^TIU(8925,"DAD",TIUDA,KIDDA)) Q:+KIDDA'>0  D
 . I '+$$ISADDNDM^TIULC1(+KIDDA) Q
 . S TSTART=TSTART+1
 . S ^TMP("TMPLIST",$J,TSTART)=$$GETLINE(KIDDA,PRNTPFIX,TSTART)
 Q TSTART
