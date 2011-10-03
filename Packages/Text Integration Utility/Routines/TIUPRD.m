TIUPRD ; SLC/JER - Single patient print ;5/19/04
 ;;1.0;TEXT INTEGRATION UTILITIES;**1,100,121,182**;Jun 20, 1997
 ;
REPLACE(TIUDA) ; Populate TMP array w records received,
 ;replacing ID kids w ID parents; replacing addenda with their parents
 ;or grandparents.
 ; Requires TIUDA. 
 ; Sets ^TMP("TIUREPLACE",$J,IFN)=1 or 1^TIUDA, or 0
 ;where IFN is TIUDA or parent or grandparent of TIUDA.
 ; If TIUDA is replaced, then ^TMP("TIUREPLACE",$J,IFN)=1^TIUDA,
 ;to know what child the parent was included in the list for.
 ; Sets & passes back ^TMP("TIUREPLACE",$J) = # of elements in array.
 N IDPRNT,ADDPRNT,ADDGPNT
 S ^TMP("TIUREPLACE",$J)=+$G(^TMP("TIUREPLACE",$J))
 S IDPRNT=+$G(^TIU(8925,TIUDA,21)) ; ID parent
 ; -- If kid has parent that doesn't exist,
 ;    treat kid as stand-alone:
 I '$D(^TIU(8925,IDPRNT,0)) S IDPRNT=0
 S ADDPRNT=$P(^TIU(8925,TIUDA,0),U,6)
 I ADDPRNT,'$D(^TIU(8925,ADDPRNT,0)) Q
 I ADDPRNT S ADDGPNT=+$G(^TIU(8925,ADDPRNT,21))
 I $G(ADDGPNT),'$D(^TIU(8925,ADDGPNT,0)) S ADDGPNT=0
 ;============================================
 ; -- If TIUDA is not an ID kid & not addm, just put it
 ;    in array and quit: --
 I 'IDPRNT,'ADDPRNT D  G REPX
 . ; -- If TIUDA is already in array (as parent/gpa of previous kid),
 . ;    and is now received on its own merit, forget the original
 . ;    child.  If not already in array, put it in.  Quit.
 . I $D(^TMP("TIUREPLACE",$J,TIUDA)) S $P(^TMP("TIUREPLACE",$J,TIUDA),U,2)="" Q
 . S ^TMP("TIUREPLACE",$J,TIUDA)=1
 . S ^TMP("TIUREPLACE",$J)=$G(^TMP("TIUREPLACE",$J))+1
 ; ==========================================
 ; -- If TIUDA is an ID kid, put its parent in array and track
 ;    original child:
 I IDPRNT D  G REPX
 . S ^TMP("TIUREPLACE",$J,IDPRNT)=1_U_TIUDA
 . S ^TMP("TIUREPLACE",$J)=$G(^TMP("TIUREPLACE",$J))+1
 ; ===========================================
 ; -- If TIUDA is an addm to standalone note, put parent in
 ;    array and track orig addm:
 I ADDPRNT,'ADDGPNT D  G REPX
 . S ^TMP("TIUREPLACE",$J,ADDPRNT)=1_U_TIUDA
 . S ^TMP("TIUREPLACE",$J)=$G(^TMP("TIUREPLACE",$J))+1
 ; ===========================================
 ; -- If TIUDA is an addm to ID kid, put ID parent in
 ;    array and track orig addm:
 I ADDPRNT,ADDGPNT D  G REPX
 . S ^TMP("TIUREPLACE",$J,ADDGPNT)=1_U_TIUDA
 . S ^TMP("TIUREPLACE",$J)=$G(^TMP("TIUREPLACE",$J))+1
REPX Q
 ;
MAIN(TIUTYP) ; Control Branching
 N DFN,TIU,TIUOUT,TIUREL,TIUCHK,TIUA,TIUSEE,ACT,TIUY,TIUFLAG
 N TIUDAT,TIUOUT,TIUSEE,TIUI,TIUQUIT,TIUDEV
 I '$D(TIUPRM0) D SETPARM^TIULE
 S:$D(ORVP) DFN=+ORVP S TIUTYP=$G(TIUTYP,38)
 D SELPAT^TIULA2(.TIUDAT,TIUTYP,+$G(DFN))
 I +$G(TIUDAT)'>0,($D(TIUDAT)'>9) S TIUOUT=1 Q
 S TIUFLAG=$$FLAG^TIUPRPN3
 S TIUDEV=$$DEVICE^TIUDEV(.IO) ; Get Device/allow queueing
 I IO']"" G PRINTX
 I $D(IO("Q")) D QUE^TIUDEV("PRINTN^TIUPRD",TIUDEV) G PRINTX
 D PRINTN
PRINTX D ^%ZISC
 K ^TMP("TIUPR",$J)
 Q
PRINTN ; Loop through selected doc's & invoke print code as appropriate
 N TIUI,TIUTYP,TIUDARR,DFN,TIULNO,DIROUT
 K ^TMP("TIUREPLACE",$J)
 U IO
 S TIUI=0
 F  S TIUI=$O(TIUDAT(TIUI)) Q:+TIUI'>0  D  Q:$D(DIROUT)
 . N TIUPGRP,TIUPMTHD,TIUPFHDR,TIUPFNBR,ORIGCHLD
 . S TIUDA=+$G(TIUDAT(TIUI))
 . I '+$G(^TIU(8925,+TIUDA,0)) Q
 . ; -- Set ^TMP("TIUREPLACE",$J),
 . ;    with ID kids & adda replaced by parents:
 . D REPLACE(TIUDA)
 . S TIULNO(TIUDA)=TIUI
 ; -- Set TIUDARR w info needed to print TIUDA:
 S TIUDA=0 F  S TIUDA=$O(^TMP("TIUREPLACE",$J,TIUDA)) Q:'TIUDA  D
 . S TIUTYP=$P(^TIU(8925,TIUDA,0),U),DFN=$P(^(0),U,2)
 . I +TIUTYP D
 . . S TIUPMTHD=$$PRNTMTHD^TIULG(+TIUTYP)
 . . S TIUPGRP=$$PRNTGRP^TIULG(+TIUTYP)
 . . S TIUPFHDR=$$PRNTHDR^TIULG(+TIUTYP)
 . . S TIUPFNBR=$$PRNTNBR^TIULG(+TIUTYP)
 . Q:$G(TIUPMTHD)']""
 . S TIUI=$G(TIULNO(TIUDA))
 . I '$G(TIUI) D
 . . S ORIGCHLD=$P(^TMP("TIUREPLACE",$J,TIUDA),U,2),TIUI=$G(TIULNO(ORIGCHLD))
 . ;I +$G(TIUPGRP),($G(TIUPFHDR)]""),($G(TIUPFNBR)]"") S TIUDARR(TIUPMTHD,$G(TIUPGRP)_"$"_TIUPFHDR_";"_DFN,TIUI,TIUDA)=TIUPFNBR
 . ;E  S TIUDARR(TIUPMTHD,DFN,TIUI,TIUDA)=""
 . ; -- P182: Set array same whether or not flds are defined, with
 . ;    TIUPGRP piece possibly 0, TIUPFHDR piece possibly null, and
 . ;    array value TIUPFNBR possibly null.
 . S TIUDARR(TIUPMTHD,+$G(TIUPGRP)_"$"_$G(TIUPFHDR)_";"_DFN,TIUI,TIUDA)=$G(TIUPFNBR)
 K ^TMP("TIUREPLACE",$J)
 ; -- Sort printout by printmethod (prints similar docmts together):
 S TIUPMTHD="" F  S TIUPMTHD=$O(TIUDARR(TIUPMTHD)) Q:TIUPMTHD=""  D
 . D PRNTDOC^TIURA(TIUPMTHD,.TIUDARR)
 Q
