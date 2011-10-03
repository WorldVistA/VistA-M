FBPAID1 ;WOIFO/SAB - SERVER ROUTINE TO UPDATE PAYMENTS CON'T ;2/10/2009
 ;;3.5;FEE BASIS;**19,107**;JAN 30, 1995;Build 3
 ;;Per VHA Directive 2004-038, this routine should not be modified.
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
 ;
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
 S FBCKNUM=$$EXTRL^FBMRASVR($E(XMRG,39,46),1)
 I $L(XMRG)=77 D  ; process old format
 . S FBCKDT=$$DATE^FBPAID1($E(XMRG,47,52))
 . S FBINAMT=$S(+$E(XMRG,53,60):+$E(XMRG,53,58)_"."_$E(XMRG,59,60),1:0)
 . S FBINAMT=$S(FBINAMT=0:0,$P(FBINAMT,".",2)'>0:$P(FBINAMT,"."),1:+FBINAMT)
 . S FBXDT=$$DATE^FBPAID1($E(XMRG,61,66))
 . S FBRCOD=$E(XMRG,67),FBXCOD=$E(XMRG,68)
 . S FBRCOD=$O(^FB(162.95,"C",FBRCOD,0))
 . S FBDAMT=$S(+$E(XMRG,69,76):+$E(XMRG,69,74)_"."_$E(XMRG,75,76),1:0)
 . S FBDAMT=$S(FBDAMT=0:0,$P(FBDAMT,".",2)'>0:$P(FBDAMT,"."),1:+FBDAMT)
 I $L(XMRG)=82 D  ; process new format
 . S FBCKDT=$$DATE4^FBPAID1($E(XMRG,47,54))
 . S FBINAMT=$S(+$E(XMRG,55,62):+$E(XMRG,55,60)_"."_$E(XMRG,61,62),1:0)
 . S FBINAMT=$S(FBINAMT=0:0,$P(FBINAMT,".",2)'>0:$P(FBINAMT,"."),1:+FBINAMT)
 . S FBXDT=$$DATE4^FBPAID1($E(XMRG,63,70))
 . S FBRCOD=$E(XMRG,71),FBXCOD=$E(XMRG,72)
 . S FBRCOD=$O(^FB(162.95,"C",FBRCOD,0))
 . S FBDAMT=$S(+$E(XMRG,73,81):+$E(XMRG,73,79)_"."_$E(XMRG,80,81),1:0)
 . S FBDAMT=$S(FBDAMT=0:0,$P(FBDAMT,".",2)'>0:$P(FBDAMT,"."),1:+FBDAMT)
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
CHKMOVE ;check if payment moved
 ; input
 ;   FBPROG - fee program
 ;   FBIEN - ien of payment (from austin)
 ;   FBIEN() - ien(s) of higher level entries (1 for next higher, etc.)
 ; output
 ;   FBIEN   may be changed
 ;   FBIEN() may be changed
 N FBDA,FBFILE,FBNIENS,FBOIENS
 S FBFILE=$S(FBPROG=3:162.03,FBPROG="T":162.04,1:"")
 Q:FBFILE=""
 I FBPROG=3 D
 . S FBOIENS=FBIEN_","_FBIEN(1)_","_FBIEN(2)_","_FBIEN(3)_","
 . S FBDA=$O(^FBAA(161.45,"C",FBFILE,FBOIENS,0))
 . Q:'FBDA  ; not moved
 . S FBNIENS=$P($G(^FBAA(161.45,FBDA,0)),U,3)
 . Q:FBNIENS=""  ; don't know new iens
 . S FBIEN=$P(FBNIENS,",",1)
 . S FBIEN(1)=$P(FBNIENS,",",2)
 . S FBIEN(2)=$P(FBNIENS,",",3)
 . S FBIEN(3)=$P(FBNIENS,",",4)
 I FBPROG="T" D
 . S FBOIENS=FBIEN_","_FBIEN(1)_","
 . S FBDA=$O(^FBAA(161.45,"C",FBFILE,FBOIENS,0))
 . Q:'FBDA  ; not moved
 . S FBNIENS=$P($G(^FBAA(161.45,FBDA,0)),U,3)
 . Q:FBNIENS=""  ; don't known new iens
 . S FBIEN=$P(FBNIENS,",",1)
 . S FBIEN(1)=$P(FBNIENS,",",2)
 Q
