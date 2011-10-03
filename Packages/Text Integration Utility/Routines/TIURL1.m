TIURL1 ; SLC/JER - List Management Library ;11/26/00
 ;;1.0;TEXT INTEGRATION UTILITIES;**100**;Jun 20, 1997
 ; New rtn created 11/14/00 by splitting TIURL
 ;
UPIDDATA(TIUDA) ; Update (or kill) ^TMP("TIUR",$J,"IDDATA",TIUDA)
 K ^TMP("TIUR",$J,"IDDATA",TIUDA)
 Q:'$D(^TIU(8925,TIUDA))
 S IDDATA=$$IDDATA^TIURECL1(TIUDA) ; =TIUDA^hasIDkid^IDdadDA^prmsort
 I IDDATA S ^TMP("TIUR",$J,"IDDATA",TIUDA)=IDDATA
 Q
 ;
UPPFIX(TIUDA,OLDPFIX) ; Returns prefix with indicators updated
 ;for changes to record TIUDA (e.g. has new addendum).
 ; Returned prefix has same level as received prefix OLDPFIX.
 ; Returned prefix is set for UNEXPANDED state of record.
 ; OLDPFIX may be that of a record at any level of the treeview,
 ;in any state of expansion.
 N ORIGPFIX,NEWPFIX
 S ORIGPFIX=$$PREFIX^TIULA2(TIUDA,0)
 I OLDPFIX["|_" S NEWPFIX=$P(OLDPFIX,"|_")_"|_"_ORIGPFIX
 E  S NEWPFIX=ORIGPFIX
 Q NEWPFIX
 ;
SETPT(LINENO) ; Set prefix_patient column of ^TMP("TIUR",$J,LINENO,0)
 ;after item prefix is changed (e.g. item has new addendum).
 ; Updated prefix is at same level of treeview as received prefix,
 ;has updated indicators, but is in UNEXPANDED state.
 N CURPFIX,TEXT,TIUDA,IDDATA,NEWPFIX,ITEMNODE
 S ITEMNODE=^TMP("TIURIDX",$J,LINENO)
 S TIUDA=$P(ITEMNODE,U,2),CURPFIX=$P(ITEMNODE,U,3)
 S NEWPFIX=$$UPPFIX(TIUDA,CURPFIX)
 S TEXT=^TMP("TIUR",$J,LINENO,0)
 S TEXT=$$SETTLPT^TIURECL1(TEXT,TIUDA,NEWPFIX)
 S ^TMP("TIUR",$J,LINENO,0)=TEXT
 S $P(^TMP("TIURIDX",$J,LINENO),U,3)=NEWPFIX
 Q
 ;
ITEM(TIUDA) ; Find which item in the list is occupied by TIUDA
 N TIUI,TIUY S (TIUI,TIUY)=0
 F  S TIUI=$O(^TMP("TIURIDX",$J,TIUI)) Q:+TIUI'>0!+TIUY  D
 . I $P(^TMP("TIURIDX",$J,TIUI),U,2)=TIUDA S TIUY=TIUI
 Q TIUY
BREATHE(ITEM,ONCE)   ; Collapse/Expand treeview on changes
 D EC1^TIURECL(ITEM,1) ; Collapse or expand once
 D:'+$D(ONCE) EC1^TIURECL(ITEM,1) ; if ONCE is not sent, do it again
 Q
