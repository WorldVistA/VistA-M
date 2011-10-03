TIULM ; SLC/JER - List Manager Library: RESIZE, REMOVE Elmt, PICK List Elmt ; 3/9/01
 ;;1.0;TEXT INTEGRATION UTILITIES;**100**;Jun 20, 1997
RESIZE(LONG,SHORT,SHRINK) ; Resizes list area
 N TIUBM S TIUBM=$S(VALMMENU:SHORT,+$G(SHRINK):SHORT,1:LONG)
 I VALM("BM")'=TIUBM S VALMBCK="R" D
 . S VALM("BM")=TIUBM,VALM("LINES")=(TIUBM-VALM("TM"))+1
 . I +$G(VALMCC) D RESET^VALM4
 Q
PICK(TIUITEM) ; Highlight selected list elements, add to VALMY(ITEM) array
 N TIUI,ITEM,LINE
 ; **100** 4/11/00:
 F TIUI=1:1:$L(TIUITEM,",") S ITEM=$P(TIUITEM,",",TIUI) Q:+ITEM'>0  D
 . S LINE=+$O(@VALMAR@("PICK",+ITEM,0)) I '+LINE S LINE=ITEM
 . I '$D(VALMY(ITEM)) D  I 1
 . . D RESTORE^VALM10(LINE),CNTRL^VALM10(LINE,6,VALM("RM"),IORVON,IORVOFF)
 . . D WRITE^VALM10(LINE)
 . . S VALMY(ITEM)=""
 . . ;**100**
 . . I $G(TIUGLINK) D
 . . . I $L(TIUITEM,",")>2 D
 . . . . W !!,"You are now selecting ONE interdisciplinary parent note."
 . . . . W !,"Acting on line ",+TIUITEM
 . . . . W " as your parent note selection." H 5
 . . . . S TIUITEM=+TIUITEM ; only want 1 ID parent
 . . . D LKDAD^TIUGR2(TIUGLINK)
 . . . K VALMY
 . E  D
 . . D RESTORE^VALM10(LINE),WRITE^VALM10(LINE)
 . . K VALMY(ITEM)
 ; D RE^VALM4 ; P100 took out, redundant
 Q
FIXLST ; Restore video attributes to entire list
 N TIUI S TIUI=0
 Q:'$D(VALMAR)
 F  S TIUI=$O(^TMP("TIUR",$J,TIUI)) Q:+TIUI'>0  D
 . I TIUI=$P($G(TIUGLINK),U,2) Q  ; See TIURL
 . D RESTORE(TIUI)
 Q
FIXLSTNW ; Restore video attributes to entire list
 ; New: Don't bold the list #
 N TIUI S TIUI=0
 Q:'$D(VALMAR)
 F  S TIUI=$O(^TMP("TIUR",$J,TIUI)) Q:+TIUI'>0  D
 . I TIUI=$P($G(TIUGLINK),U,2) Q  ; See TIURL
 . D RESTORE^VALM10(TIUI)
 Q
RESTORE(ITEM) ; Restore video attributes for a single list element
 D RESTORE^VALM10(ITEM),FLDCTRL^VALM10(ITEM,"NUMBER",IOINHI,IOINORM)
 Q
RESTOREG(TIUGLINK) ; Update video attributes after changing view,
 ;for ID entry being attached, which probably moved to a different line.
 N LINENO,NLINENO
 Q:'$G(TIUGLINK)
 S LINENO=$P(TIUGLINK,U,2)
 S NLINENO=+$O(^TMP("TIUR",$J,"IEN",+TIUGLINK,0))
 S $P(TIUGLINK,U,2)=NLINENO
 I $D(^TMP("TIUR",$J,LINENO)) D RESTORE^VALM10(LINENO)
 I $D(^TMP("TIUR",$J,NLINENO)) D
 . D RESTORE^VALM10(NLINENO)
 . D CNTRL^VALM10(NLINENO,6,VALM("RM"),IORVON,IORVOFF)
 Q
 ;
REMOVE(ITEM) ; Remove an element from the list
 ; No longer used since patch 100
 ; Now called only by rtn TIUPPAC, an obsolete patient postings rtn.
 N TIUREC S TIUREC=$G(^TMP("TIUR",$J,+ITEM,0))
 S TIUREC=$$SETFLD^VALM1("deleted",TIUREC,"STATUS")
 S ^TMP("TIUR",$J,+ITEM,0)=TIUREC
 D RESTORE^VALM10(+ITEM),CNTRL^VALM10(+ITEM,6,VALM("RM"),IOINHI,IOINORM)
 I $P(ITEM,U,2) D UPIDDATA^TIURL1($P(ITEM,U,2))
 Q
