TIUFLLM1 ; SLC/MAM - Library; LM Related: LINEUP(INFO,TEMPLATE), UPDATE(TMPLATE,SHIFT,LASTLIN,PINFO), AINUSE(LINENO), INUSEUP(FILEDA,LINENO) ;8/27/97  18:47
 ;;1.0;TEXT INTEGRATION UTILITIES;**11**;Jun 20, 1997
 ;
LINEUP(INFO,TEMPLATE) ; Update Line +INFO.  Line must be updated, NOT added or deleted.
 ; Requires INFO,TEMPLATE
 N NODE0
 D:$D(INFO)<10 PARSE^TIUFLLM(.INFO) D:$D(NODE0)<10 NODE0ARR^TIUFLF($P(INFO,U,2),.NODE0) G:$D(DTOUT) LINEX
 D BUFENTRY^TIUFLLM2(.INFO,.NODE0,TEMPLATE)
 D UPDATE(TEMPLATE,0,INFO-1)
LINEX Q
 ;
UPDATE(TMPLATE,SHIFT,LASTLIN,PINFO) ; Update LM TMPLATE using Buffer Array.
 ; TMPLATE lines may be inserted, deleted, or reset.  Resets 1 line;
 ;inserts or deletes a continuous chunk of lines.
 ; Lines to be inserted must be in buffer array ^TMP("TIUFB", starting
 ;with line # LASTLIN+1 and running for SHIFT continuous lines.
 ; Line to be reset must be in Buffer Array at line # LASTLIN+1,
 ;with SHIFT = 0.
 ; Lines to be deleted must be continuous lines starting with line #
 ;LASTLIN+1 and running for -SHIFT lines, where SHIFT is negative.
 ; Requires TMPLATE = LM Sub/Template H, A, I, T, D, O, or P; If TMPLATE 
 ;                  = H (Hierarchy), then lines to be added/deleted
 ;                    must all be items under the same parent.
 ;          SHIFT is >0 for add; >0 for delete; =0 for reset.
 ;          |SHIFT| is Length of addition/deletion;  a reset does not
 ;            add or delete, so SHIFT is 0 for reset.
 ;          LASTLIN = Line BEFORE Insertion/del/update point as above.
 ;
 ; Requires PINFO and PINFO array IF TMPLATE = "H" AND adding/deleting
 ;          (but NOT resetting) lines AND LASTLIN'=0 (Clinical Documents
 ;            HAS NO parent).
 ;          PINFO = ^TMP("TIUF1IDX,$J,LINENO), where LINENO is LM
 ;            Lineno of LM PARENT of lines added/deleted.
 ;          PINFO Array is as set in PARSE^TIUFLLM for PINFO.
 ;          PINFO is used to:
 ;            Update ^TMP("TIUF*IDX" for ancestors of lines
 ;              added/deleted (3rd piece, XPDLCNT);
 ;            Update the + preceeding Name of parent
 ;              of lines added/deleted.
 ;          If PINFO is received, routine returns updated PINFO array.
 ;            (Updates PINFO("XPDLCNT").
 ; DOESN'T update VALMCNT. (Don't try it: may be updating template other than the one you're presently in.)
 ;do I need "DAF" for all templates?;MAM
 N LINENO,TIUI,TIUJ,OLDINFO,BEG,INC,END,BINFO,ARR,ARRIDX,ARRNO,VCNT
 N INUSE,INUSE1,INUSECOL,PLINENO
 S ARRNO=^TMP("TIUF",$J,"ARRNO"_TMPLATE)
 S ARR="TIUF"_ARRNO,ARRIDX="TIUF"_ARRNO_"IDX"
 I SHIFT'>0 D
 . ;Delete lines to be deleted/updated
 . S BEG=LASTLIN+1,END=$S(SHIFT=0:BEG,1:BEG-1-SHIFT)
 . F TIUI=BEG:1:END D
 . . S OLDINFO=^TMP(ARRIDX,$J,TIUI)
 . . K ^TMP(ARR,$J,TIUI,0),^TMP(ARR,$J,"IDX",TIUI)
 . . K ^TMP(ARRIDX,$J,"DAF",$P(OLDINFO,U,2),TIUI)
 . . I TMPLATE="T" K ^TMP(ARRIDX,$J,"DA10",$P(OLDINFO,U,6),TIUI)
 . . K ^TMP(ARRIDX,$J,TIUI)
 . . Q
 . Q
 I SHIFT'=0 D
 . ; Move lines starting w LASTLIN+1 down, creating gap to add entries 
 . ; OR Move lines after deleted lines up to fill in gap.
 . S VCNT=$O(^TMP(ARR,$J,1000000),-1)
 . I SHIFT>0 S BEG=VCNT,INC=-1,END=LASTLIN+1
 . E  S BEG=LASTLIN+1-SHIFT,INC=1,END=VCNT
 . F LINENO=BEG:INC:END Q:INC>0&(BEG>END)  Q:INC<0&(BEG<END)  D 
 . . S ^TMP(ARR,$J,LINENO+SHIFT,0)=$$SETSTR^VALM1(LINENO+SHIFT,^TMP(ARR,$J,LINENO,0),1,5) ; SETFLD doesn't work since called by nontarget template.
 . . I SHIFT>5!(SHIFT<-5) W "."
 . . I ARR'="TIUF3" S ^TMP(ARR,$J,"IDX",LINENO+SHIFT,LINENO+SHIFT)=""
 . . S OLDINFO=^TMP(ARRIDX,$J,LINENO)
 . . S $P(OLDINFO,U)=LINENO+SHIFT
 . . S PLINENO=$P(OLDINFO,U,5) I PLINENO>LASTLIN S $P(OLDINFO,U,5)=PLINENO+SHIFT
 . . S ^TMP(ARRIDX,$J,"DAF",$P(OLDINFO,U,2),LINENO+SHIFT)=""
 . . I TMPLATE="T" S ^TMP(ARRIDX,$J,"DA10",$P(OLDINFO,U,6),LINENO+SHIFT)=""
 . . S ^TMP(ARRIDX,$J,LINENO+SHIFT)=OLDINFO
 . . K ^TMP(ARR,$J,LINENO,0),^TMP(ARR,$J,"IDX",LINENO,LINENO)
 . . K ^TMP(ARRIDX,$J,LINENO),^TMP(ARRIDX,$J,"DAF",$P(OLDINFO,U,2),LINENO)
 . . I TMPLATE="T" K ^TMP(ARRIDX,$J,"DA10",$P(OLDINFO,U,6),LINENO)
 . . Q
 . Q
 I SHIFT'<0 D
 . ; Fill LM space with buffer array to add/update entries.
 . S TIUJ=0 F  S TIUJ=$O(^TMP("TIUFB",$J,TIUJ)) Q:'TIUJ  D
 . . S ^TMP(ARR,$J,TIUJ,0)=^TMP("TIUFB",$J,TIUJ,0)
 . . I SHIFT>5 W "."
 . . I ARR'="TIUF3" S ^TMP(ARR,$J,"IDX",TIUJ,TIUJ)=""
 . . S BINFO=^TMP("TIUFBIDX",$J,TIUJ)
 . . S ^TMP(ARRIDX,$J,"DAF",$P(BINFO,U,2),TIUJ)=""
 . . I TMPLATE="T" S ^TMP(ARRIDX,$J,"DA10",$P(BINFO,U,6),TIUJ)=""
 . . S ^TMP(ARRIDX,$J,TIUJ)=BINFO
 . . Q
 . K ^TMP("TIUFB",$J),^TMP("TIUFBIDX",$J)
 . Q
 I $G(PINFO),SHIFT,"HC"[TMPLATE D
 . ; For Template H or C:
 . ; Updates 3rd piece of ^TMP("TIUF1IDX",$J,LINENO) (XPDLCNT) for mutual
 . ;   parent and ancestors of entries to be added/deleted;
 . ; Updates PINFO, array PINFO;
 . ; Updates + in front of parent for template H
 . N ANCLNO,XPDLCNT,AINFO
 . S ANCLNO=+PINFO
 . F  S AINFO=$G(^TMP("TIUF1IDX",$J,ANCLNO)) Q:'AINFO  D
 . . S XPDLCNT=$P(AINFO,U,3)+SHIFT,$P(^TMP("TIUF1IDX",$J,ANCLNO),U,3)=XPDLCNT
 . . S ANCLNO=+$P(AINFO,U,5)
 . S PINFO("XPDLCNT")=$P(PINFO,U,3)+SHIFT
 . S $P(PINFO,U,3)=PINFO("XPDLCNT")
 . I TMPLATE="H" S ^TMP("TIUF1",$J,+PINFO,0)=$$PLUSUP^TIUFLLM(.PINFO,^TMP("TIUF1",$J,+PINFO,0))
UPDAX Q
 ;
