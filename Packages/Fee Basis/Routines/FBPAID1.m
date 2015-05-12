FBPAID1 ;WOIFO/SAB - SERVER ROUTINE TO UPDATE PAYMENTS CON'T ;1/11/2012
 ;;3.5;FEE BASIS;**19,107,121,132,123**;JAN 30, 1995;Build 51
 ;;Per VA Directive 6402, this routine should not be modified.
PARSE ;set-up variables for payment record called from FBPAID
 ;  FBPROG = 3 for Outpatient (file 162)
 ;         = T for Travel (file 162)
 ;         = 5 for Pharmacy (file 162.1)
 ;         = 9 for Inpatient (file 162.5)
 ;         = $E(XMRG,7)      fee program and effected file
 ;  FBACT  = $E(XMRG,8)      type of activity                
 ;  FBIEN(x)=$E(XMRG,9,38)   IEN for payment record to update
 ;  FBCKNUM= $E(XMRG,39,46)  check number
 ;  old format (when total length = 77)
 ;  FBCKDT = $E(XMRG,47,52)  check date
 ;  FBINAMT= $E(XMRG,53,60)  interest amount
 ;  FBXDT  = $E(XMRG,61,66)  cancel date
 ;  FBRCOD = $E(XMRG,67)     reason code
 ;  FBXCOD = $E(XMRG,68)     cancel code
 ;  FBDAMT = $E(XMRG,69,76)  disbursed amount
 ;  new format (when total length = 82)
 ;  FBCKDT = $E(XMRG,47,54)  check date
 ;  FBINAMT= $E(XMRG,55,62)  interest amount
 ;  FBXDT  = $E(XMRG,63,70)  cancel date
 ;  FBRCOD = $E(XMRG,71)     reason code
 ;  FBXCOD = $E(XMRG,72)     cancel code
 ;  FBDAMT = $E(XMRG,73,81)  disbursed amount
 ;  FBBRTG = $E(XMRG,82,90)  bank routing number ;HIPAA 5010 P121
 ;  FBBACC = $E(XMRG,91,107) bank account number ;HIPAA 5010 P121
 ;  FBBNAM = $E(XMRG,108,138)bank name           ;HIPAA 5010 P121
 ;  FBAMT  = Amount paid out of payment record
 Q:$G(FBERR)
 S FBPROG=$E(XMRG,7) I $S(FBPROG=3:0,FBPROG=5:0,FBPROG=9:0,FBPROG="T":0,1:1) S FBERR=1 Q
 S FBACT=$E(XMRG,8) I $S(FBACT="C":0,FBACT="B":0,FBACT="X":0,1:1) S FBERR=1 Q
 S FBIEN=$E(XMRG,9,38) D  Q:$G(FBERR)
 . I FBPROG=3 D  Q:$G(FBERR)
 ..S FBIEN(3)=+$P(FBIEN,U),FBIEN(2)=+$P(FBIEN,U,2),FBIEN(1)=+$P(FBIEN,U,3),FBIEN=+$P(FBIEN,U,4)
 ..I '$D(^FBAAC(FBIEN(3),1,FBIEN(2),1,FBIEN(1),1,FBIEN,0)) D CHKMOVE
 ..I '$D(^FBAAC(FBIEN(3),1,FBIEN(2),1,FBIEN(1),1,FBIEN,0)) S FBERR=1,^TMP("FBERR",$J,3,I)=""
 . ;
 . I FBPROG=5 D  Q:$G(FBERR)
 ..S FBIEN(1)=+$P(FBIEN,U),FBIEN=+$P(FBIEN,U,2)
 ..I '$D(^FBAA(162.1,FBIEN(1),"RX",FBIEN,0)) S FBERR=1,^TMP("FBERR",$J,3,I)=""
 . ;
 . I FBPROG=9 D  Q:$G(FBERR)
 ..S FBIEN=+FBIEN I '$D(^FBAAI(FBIEN,0)) S FBERR=1,^TMP("FBERR",$J,3,I)=""
 . ;
 . I FBPROG="T" D  Q:$G(FBERR)
 ..S FBIEN(1)=+$P(FBIEN,U),FBIEN=+$P(FBIEN,U,2)
 ..I '$D(^FBAAC(FBIEN(1),3,FBIEN,0)) D CHKMOVE
 ..I '$D(^FBAAC(FBIEN(1),3,FBIEN,0)) S FBERR=1,^TMP("FBERR",$J,3,I)=""
 ;
 ; esg - FB*3.5*123 - for IPAC payments, the check# is the IPAC document reference#. Don't strip leading zeros for IPAC.
 S FBCKNUM=$E(XMRG,39,46)
 I '$$IPACCHK(FBPROG,.FBIEN) S FBCKNUM=$$EXTRL^FBMRASVR(FBCKNUM,1)
 ;
 S FBCKDT=$$DATE4^FBPAID1($E(XMRG,47,54))
 S FBINAMT=$S(+$E(XMRG,55,62):+$E(XMRG,55,60)_"."_$E(XMRG,61,62),1:0)
 S FBINAMT=$S(FBINAMT=0:0,$P(FBINAMT,".",2)'>0:$P(FBINAMT,"."),1:+FBINAMT)
 S FBXDT=$$DATE4^FBPAID1($E(XMRG,63,70))
 S FBRCOD=$E(XMRG,71),FBXCOD=$E(XMRG,72)
 S FBRCOD=$O(^FB(162.95,"C",FBRCOD,0))
 S FBDAMT=$S(+$E(XMRG,73,81):+$E(XMRG,73,79)_"."_$E(XMRG,80,81),1:0)
 S FBDAMT=$S(FBDAMT=0:0,$P(FBDAMT,".",2)'>0:$P(FBDAMT,"."),1:+FBDAMT)
 I $L(XMRG)=138 D  ; process new format with bank fields HIPAA 5010 P121
 . S FBBRTG=$$TRIM^XLFSTR($E(XMRG,82,90),"LR") ;bank routing number
 . S FBBACC=$$TRIM^XLFSTR($E(XMRG,91,107),"LR") ;bank account number
 . S FBBNAM=$$TRIM^XLFSTR($E(XMRG,108,137),"LR") ;bank name
 Q
 ;
BUL ;create server bulletin message
 S ^TMP("FBPAID",$J,0)=FBMCNT
 Q
DATE(X) ;pass in 'X'=date in yymmdd format and return date in
 ;fileman format.
 N Y I '$G(X) Q ""
 S %DT="",X=$E(X,3,7)_$E(X,1,2) D ^%DT K %DT
 Q $S(Y=-1:"",1:Y)
DATE4(X) ;pass in 'X'=date in yyyymmdd format and return date in
 ;fileman format.
 N Y I '$G(X) Q ""
 S %DT="",X=$E(X,5,6)_"/"_$E(X,7,8)_"/"_$E(X,1,4) D ^%DT K %DT
 Q $S(Y=-1:"",1:Y)
CHKMOVE ;check if payment line item was moved by patient merge process
 ; input
 ;   FBPROG - fee program (3 or "T")
 ;   FBIEN - ien of payment (from austin)
 ;   FBIEN() - ien(s) of higher level entries (1 for next higher, etc.)
 ; output
 ;   FBIEN   may be changed to reflect current value
 ;   FBIEN() may be changed to reflect current value
 N FBDA,FBFILE,FBNIENS,FBCIENS,FBSIENS
 ;
 ; determine file
 S FBFILE=$S(FBPROG=3:162.03,FBPROG="T":162.04,1:"")
 Q:FBFILE=""
 ;
 ; determine starting IEN string
 I FBPROG="3" S FBSIENS=FBIEN_","_FBIEN(1)_","_FBIEN(2)_","_FBIEN(3)_","
 I FBPROG="T" S FBSIENS=FBIEN_","_FBIEN(1)_","
 Q:FBSIENS=""
 ;
 S FBCIENS=FBSIENS ; init current IEN string as starting IEN string
 ;
 ; loop thru moves for current IENs until no more moves are found
 F  D  Q:FBNIENS=""
 . S FBNIENS="" ; init new IENs value for a move
 . S FBDA=$O(^FBAA(161.45,"C",FBFILE,FBCIENS,0))
 . Q:'FBDA  ; no more moves
 . S FBNIENS=$P($G(^FBAA(161.45,FBDA,0)),U,3) ; new IENs
 . ; if new IEN is same as starting IEN, break out of the endless loop
 . I FBNIENS=FBSIENS S FBNIENS="" Q
 . ; set current IENs to the new value
 . S:FBNIENS'="" FBCIENS=FBNIENS
 ;
 ; if current IENs is different from starting IENs update outputs
 I FBCIENS'=FBSIENS D
 . I FBPROG="3" D
 . . S FBIEN=$P(FBCIENS,",",1)
 . . S FBIEN(1)=$P(FBCIENS,",",2)
 . . S FBIEN(2)=$P(FBCIENS,",",3)
 . . S FBIEN(3)=$P(FBCIENS,",",4)
 . I FBPROG="T" D
 . . S FBIEN=$P(FBCIENS,",",1)
 . . S FBIEN(1)=$P(FBCIENS,",",2)
 Q
 ;
IPACCHK(FBPROG,FBIEN) ; check if payment is an IPAC payment (FB*3.5*123)
 ; Function value is 1 if the payment is an IPAC payment, 0 otherwise
 ; This is determined by the existence of a pointer value to file 161.95.
 ;
 N RES,FBFILE,FBSIENS,FBFIELD
 S RES=0
 I '$F(".3.5.9.","."_+$G(FBPROG)_".") G IPACKX
 ;
 ; get variables by type
 I FBPROG=3 S FBFILE=162.03,FBSIENS=FBIEN_","_FBIEN(1)_","_FBIEN(2)_","_FBIEN(3)_",",FBFIELD=.05   ; outpat/ancil
 I FBPROG=5 S FBFILE=162.1,FBSIENS=FBIEN(1)_",",FBFIELD=14                                         ; pharmacy (top level)
 I FBPROG=9 S FBFILE=162.5,FBSIENS=FBIEN_",",FBFIELD=87                                            ; inpatient
 ;
 I +$$GET1^DIQ(FBFILE,FBSIENS,FBFIELD,"I") S RES=1     ; IPAC payment found
IPACKX ;
 Q RES
 ;
