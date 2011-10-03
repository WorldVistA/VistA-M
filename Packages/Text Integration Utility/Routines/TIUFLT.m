TIUFLT ; SLC/MAM - Library; Template T (Items) Related: BUFITEMS(CONTENT,EINFO,LASTLIN), ITEMS(FILEDA) ;4/6/95  11:02
 ;;1.0;TEXT INTEGRATION UTILITIES;;Jun 20, 1997
 ;
BUFITEMS(CONTENT,EINFO,LASTLIN) ; Set items of Entry EINFO into
 ;Buffer array in proper order.
 ; Requires CONTENT = String containing some or all of: 80, H, C, A, D, T, W.  See BUFENTRY^TIUFLLM2.
 ; Requires EINFO, where EINFO is either as set in NINFO^TIUFLLM or
 ;is = ^TMP("TIUFIDX,$J,LINENO).
 ; Requires LASTLIN=LM array line before item insertion point.
 ; Requires all of the entry's items to exist in the file: check before calling this module.
 ; Updates LASTLIN to last line set in buffer array, ie 
 ;buffer array starts with line [received LASTLIN+1] and ends with
 ;line [returned LASTLIN].
 N FILEDA,TIUFITEM,LINENO,TIUFI,IFILEDA,ITENDA,INFO,INODE0
 S FILEDA=$P(EINFO,U,2)
 I TIUFTMPL="C",TIUFCLPS S TIUFITEM(1)=TIUFCDA_U_TIUFCTDA
 E  D ITEMS(FILEDA)
 K ^TMP("TIUFB",$J),^TMP("TIUFBIDX",$J)
 S LINENO=LASTLIN
 F TIUFI=1:1 Q:'$G(TIUFITEM(TIUFI))  D  Q:$D(DTOUT)
 . S IFILEDA=$P(TIUFITEM(TIUFI),U),ITENDA=$P(TIUFITEM(TIUFI),U,2) Q:'IFILEDA  Q:'ITENDA
 . S LINENO=LINENO+1 ;Needed by NINFO.
 . D NINFO^TIUFLLM(LINENO,IFILEDA,.INFO,EINFO,ITENDA),PARSE^TIUFLLM(.INFO)
 . D NODE0ARR^TIUFLF(IFILEDA,.INODE0,FILEDA) Q:$D(DTOUT)
 . I INODE0="" S LINENO=LINENO-1 Q
 . D BUFENTRY^TIUFLLM2(.INFO,.INODE0,CONTENT,FILEDA) I TIUFI>5 W "."
 . Q
 S LASTLIN=LINENO
 Q
 ;
ITEMS(FILEDA) ; Sets items of FILEDA into array TIUFITEM in proper order.
 ; TIUFITEM(TIUFI)=Item's 8925.1 IFN^Item's IFN in Item multiple
 ; Requires FILEDA = Entry's 8925.1 IFN
 N TIUFI,SEQ,TENDA,TENODE0,NAME
 S (TIUFI,SEQ,TENDA)=0
 F  S SEQ=$O(^TIU(8925.1,FILEDA,10,"AC",SEQ)) Q:'SEQ  D
 . ; Set items having sequence into TIUFITEM in sequence order
 . F  S TENDA=$O(^TIU(8925.1,FILEDA,10,"AC",SEQ,TENDA)) Q:'TENDA  D
 . . S TENODE0=^TIU(8925.1,FILEDA,10,TENDA,0) Q:'TENODE0
 . . S TIUFI=TIUFI+1,TIUFITEM(TIUFI)=+TENODE0_"^"_TENDA
 S NAME=""
 F  S NAME=$O(^TIU(8925.1,FILEDA,10,"C",NAME)) Q:NAME=""  D
 . ; Set items with no sequence into TIUFITEM in alpha order by Display Name.
 . S TENDA=0
 . F  S TENDA=$O(^TIU(8925.1,FILEDA,10,"C",NAME,TENDA)) Q:'TENDA  D
 . . S TENODE0=^TIU(8925.1,FILEDA,10,TENDA,0) Q:'TENODE0
 . . Q:$P(TENODE0,U,3)  ;If has sequence, already in TIUFITEM.
 . . S TIUFI=TIUFI+1,TIUFITEM(TIUFI)=+TENODE0_"^"_TENDA
 S TENDA=0
 F  S TENDA=$O(^TIU(8925.1,FILEDA,10,TENDA)) Q:'TENDA  D
 . ; Set items with no sequence, no display name into buffer in item order
 . S TENODE0=^TIU(8925.1,FILEDA,10,TENDA,0) Q:'TENODE0
 . Q:$P(TENODE0,U,3)  ;If has sequence, already in TIUFITEM.
 . Q:$P(TENODE0,U,4)'=""  ;If has Display Name, already in TIUFITEM.
 . S TIUFI=TIUFI+1,TIUFITEM(TIUFI)=+TENODE0_"^"_TENDA
 Q
 ;
