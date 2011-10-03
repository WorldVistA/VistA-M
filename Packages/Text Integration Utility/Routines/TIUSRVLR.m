TIUSRVLR ; SLC/JER - TIU RPCs ; 02/25/04
 ;;1.0;TEXT INTEGRATION UTILITIES;**112**;Jun 20, 1997
GETDOCS(TIUY,OVP,SEQUENCE) ; Get TIU Documents for a given Consult or
 ; Surgical Case
 N TIUDA,TIUI
 ;Initialize vars
 S (TIUDA,TIUI)=0,TIUY=$NA(^TMP("TIULIST",$J)) K @TIUY
 S SEQUENCE=$S($G(SEQUENCE)]"":$G(SEQUENCE),1:"D")
 ;Loop through "G" X-ref in 8925 to find associated documents
 F  S TIUDA=$O(^TIU(8925,"G",OVP,TIUDA)) Q:+TIUDA'>0  D
 . S TIUI=TIUI+1
 . ; Cross-check value of field 1405 with x-ref value
 . I OVP'=$P($G(^TIU(8925,TIUDA,14)),U,5) Q
 . ; If a document is an ID Entry, get its parent
 . ; I +$G(^TIU(8925,TIUDA,21)) S TIUDA=+$G(^TIU(8925,TIUDA,21))
 . ; Don't include entry in list more than once
 . I +$O(@TIUY@("INDX",TIUDA,0)) Q
 . ; Don't include entry in list if RETRACTED
 . I $P($G(^TIU(8925,TIUDA,0)),U,5)=15 Q
 . S @TIUY@(TIUI)=TIUDA_U_$$RESOLVE^TIUSRVLO(TIUDA)
 . S @TIUY@("INDX",TIUDA,TIUI)=""
 . I +$$HASDAD^TIUSRVLI(TIUDA) D SETDAD^TIUSRVLI(.TIUY,TIUDA,.TIUI)
 . I +$$HASKIDS^TIUSRVLI(TIUDA) D SETKIDS^TIUSRVLI(.TIUY,TIUDA,.TIUI)
 Q
