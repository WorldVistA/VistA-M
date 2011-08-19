PRCAFBD ;WASH-ISC@ALTOONA,PA/CLH-Build FMS Billing Document ;8/2/95  3:14 PM
V ;;4.5;Accounts Receivable;**16,48,86,90,119,165,204,203,173,220,184,270**;Mar 20, 1995;Build 25
 ;;Per VHA Directive 2004-038, this routine should not be modified.
EN(BILL,ERR) ;Process NEW BILL to FMS
 S ERR=-1
 Q:$D(RCONVERT)
 I '$D(^PRCA(430,BILL,11)) S ERR="1^ACCOUNTING INFORMATION MISSING.  CANNOT PROCESS BILL" Q
 ;
 ;  funds 5014 (old), 2431 (old), 528701,03,04,09 and 4032 should not create a BD
 S %=$P($G(^PRCA(430,BILL,11)),"^",17)
 I %=5014!(%=2431)!(%=4032) Q
 I %[5287 Q:$$PTACCT^PRCAACC(%)
 ;
 I '$D(PRCA("SITE")) S PRCA("SITE")=$S($G(BILL):$P($P($G(^PRCA(430,BILL,0)),"^"),"-"),1:$$SITE^RCMSITE)
 K ^TMP("PRCABD",$J)
 I $G(BILL)="" S ERR="1^Missing Bill Number"
 I $D(^PRCA(430,BILL,0)),$P(^(0),U,9)="" S ERR="1^No debtor for bill" Q
 N GECSFMS,REC,REC11,VENCODE,BFY,EFY,LINEFUND,%,%I,%H,X,VEN,CAT,CP,ADDR,AC,RJ,FMSNUM,FMSNUM1,VENDORID,ADD,DA,Y
 D NOW^%DTC
 I '$G(PRCA("AUTO_AUDIT")) W !,"Building FMS Billing Document. Please hold...",!
 S REC=$G(^PRCA(430,BILL,0)),REC11=$G(^PRCA(430,BILL,11)),FMSNUM=$P($P(REC,U),"-")_$P($P(REC,U),"-",2)
 ;gather vendor information
 S VENCODE=$$VENDORID^RCXFMSUV(BILL)
 I VENCODE="UNKNOWN" S ERR="1^Need FMS Vendor ID for BD Document" Q
 I VENCODE="LINK" S ERR="1^Debtor must be linked to vendor file" Q
 S ADD=$$SADD^RCFN01(5)
 I (VENCODE="PERSONOTH")!(VENCODE="XEMPL")!(VENCODE="CUREMPL")!($E(VENCODE,1,4)="CHMP")!($E(VENCODE,1,3)="TRI")!(VENCODE="INELIG") D
  . N I F I=1:1:6 S ADDR(I)=$P(ADD,U,I)
  . I ADDR(6)["-" S ADDR(7)=$P(ADDR(6),"-",2),ADDR(6)=$P(ADDR(6),"-")
  . Q
 ; PRCA*4.5*270 Doc# not unique for corrected claims, remove from file 347 before creating new one to send
 I '$G(REFMS),$$GSTAT^RCFMFN02("BD-"_FMSNUM_" ")>-1 D DEL^RCFMFN02("BD-"_FMSNUM_" ")
 N FMSDT S FMSDT=$$FMSDATE^RCBEUTRA(DT)
 S ^TMP("PRCABD",$J,1)="BD2^"_$E(FMSDT,4,5)_U_$E(FMSDT,6,7)_U_$E(FMSDT,2,3)_"^^^^^^E^"_$E(VENCODE,1,9)_U_$E(VENCODE,10,11)_U_$J($P(REC,U,3),0,2)_"^^^^"_$E($G(ADDR(1)),1,30)_U_$E($G(ADDR(2)),1,30)_U_$E($G(ADDR(3)),1,30)
 S ^TMP("PRCABD",$J,1)=^TMP("PRCABD",$J,1)_U_$E($G(ADDR(4)),1,19)_U_$G(ADDR(5))_U_$G(ADDR(6))_U_$G(ADDR(7))_"^N^^^^^^W^~"
 S ^TMP("PRCABD",$J,2)="LIN^~"
 ;accouting information - stored on 11th node file 430
 S ^TMP("PRCABD",$J,3)="BDA^"_$$LINE^RCXFMSC1(BILL)_"^"_$P(REC11,U,15)_U_$P(REC11,U,16)_U_$P(REC11,U,17)_U_$P(REC11,U,8)_U_$P(REC11,U,11)_U_$P(REC11,U,20)_U_$P(REC11,U,6)_U_$P(REC11,U,7)_U_$P(REC11,U,21)_U_$P(REC11,U,5)
 S ^TMP("PRCABD",$J,3)=^TMP("PRCABD",$J,3)_U_$P(REC11,U,12)_U_$P(REC11,U,14)_"^^"_$J($P(REC,U,3),0,2)_"^I^AR_INTERFACE^^^^"
 S ^TMP("PRCABD",$J,3)=^TMP("PRCABD",$J,3)_$P(REC11,U,10)_"^^^^^^^^"_$P(REC11,U,2)_U_$P(REC11,U,3)_"^~"
 I $E($P(REC11,U,17),1,4)=5287 S $P(^TMP("PRCABD",$J,3),U,3)="05"
 ;build control segment
 D CONTROL^GECSUFMS("A",PRCA("SITE"),FMSNUM,"BD",10,"","","Billing Document")
 S FMSNUM1=$P($G(GECSFMS("DOC")),U,3)_"-"_$P($G(GECSFMS("DOC")),U,4)
 ;build and send document to FTH
 S DA=0 F  S DA=$O(^TMP("PRCABD",$J,DA)) Q:'DA  D SETCS^GECSSTAA(GECSFMS("DA"),^(DA))
 D OPEN^RCFMDRV1(FMSNUM1,6,"B"_BILL,.ENT,.ERR,BILL) I ERR]"" D
 . S ERR=-1
 . N Z S Z="Unable to create an entry in AR Document file."
 . I '$G(PRCA("AUTO_AUDIT")) W !!,Z,! Q
 . D SETERR^PRCAUDT("BILL: "_$$BILL^PRCAUDT(BILL)),SETERR^PRCAUDT(Z)
 D SETCODE^GECSSDCT(GECSFMS("DA"),"D RETN^RCFMFN02")
 D SETSTAT^GECSSTAA(GECSFMS("DA"),"Q")
 D SSTAT^RCFMFN02(FMSNUM1,1)
 I '$G(PRCA("AUTO_AUDIT")) D
 . S Y=FMSDT D DD^%DT
 . W !!,"FMS document, # ",GECSFMS("DA"),", built and queued for transmission on "_Y,!!
 Q
 ;
