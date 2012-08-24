PRCAFBDM ;WASH-ISC@ALTOONA,PA/CLH-Build MODIFIED FMS Billing Document ;9/16/94  12:11 PM
 ;;4.5;Accounts Receivable;**60,90,204,203,220,270,275**;Mar 20, 1995;Build 72
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; PRCA*4.5*270 add CRD flag to send X record to FMS
EN(BILL,AMT,ADJTYP,PRCADJD,TN,ERR,CRD) ;Process NEW BILL to FMS
 ; EN(BILL,AMT,ADJTYP,PRCADJD,TN,ERR) ;Process NEW BILL to FMS
 Q:$D(RCONVERT)
 N GECSFMS,REC,FMSNUM,FMSTA
 K ^TMP("PRCABD",$J)
 I $G(BILL)="" S ERR="1^Missing Bill Number" Q
 ;
 ;  funds 5014 (old), 2431 (old), 528701,03,04,09 and 4032 should not create a BD
 S %=$P($G(^PRCA(430,BILL,11)),"^",17)
 I %=5014!(%=2431)!(%=4032) Q
 I %[5287 Q:$$PTACCT^PRCAACC(%)
 ;
 I +PRCADJD<1 S PRCADJD=DT
 I AMT<0 S AMT=-AMT
 I '$D(^PRCA(430,BILL,0)) S ERR="1^Unable to locate bill" Q
 S REC=$G(^PRCA(430,BILL,0)),FMSNUM=$P($P(REC,U),"-")_$P($P(REC,U),"-",2)
 ; PRCA*4.5*270 if the new CRD function is being performed, don't send the modified BD if the original BD has not yet been sent to FMS
 ; set REFMS = 1 so that CRD records will transmit immediately (sets hold date to today)
 I $G(CRD) N RCQ,REFMS S RCQ=0,REFMS=1 D  Q:RCQ
 .; - BD accepted by FMS - need to cancel (send X record)
 .S FMSTA=$$GSTAT^RCFMFN02("B"_BILL) Q:FMSTA=2
 .I FMSTA=1,$E($$STATUS^GECSSGET("BD-"_FMSNUM))="T" Q  ; - BD transmitted to FMS - need to cancel (send X record)
 .S RCQ=1 ; - set flag to quit, don't send FMS M or X records for CRD if we can still delete the E record
 .; delete event in #347, delete code sheet (only) from GECS stack
 .D DEL^RCFMFN02("B"_BILL)
 W !!,"Creating FMS Modified Billing Document..."
 N FMSDT S FMSDT=$$FMSDATE^RCBEUTRA(DT)
 ; PRCA*4.5*275 X record (corrected claim) does not need LIN and BDA section or amount, M still does
 I $G(CRD)="" D
 .S ^TMP("PRCABD",$J,1)="BD2^"_$E(FMSDT,4,5)_U_$E(FMSDT,6,7)_U_$E(FMSDT,2,3)_"^^^^^^M^^^"_$J(AMT,0,2)_"^~"
 .S ^TMP("PRCABD",$J,2)="LIN^~"
 .S ^TMP("PRCABD",$J,3)="BDA^"_$$LINE^RCXFMSC1(BILL)_"^^^^^^^^^^^^^^"_$J(AMT,0,2)_"^"_$S(ADJTYP=35:"D",ADJTYP=1:"I",1:"")_"^AR_INTERFACE^~"
 S:$G(CRD)'="" ^TMP("PRCABD",$J,1)="BD2^"_$E(FMSDT,4,5)_U_$E(FMSDT,6,7)_U_$E(FMSDT,2,3)_"^^^^^^X^^^^^~"
 ;build control segment, indicate whether this is an M or X record
 ;D CONTROL^GECSUFMS("A",$P(REC,U,12),FMSNUM,"BD",10,"1","","Modified Billing Document")
 D CONTROL^GECSUFMS("A",$P(REC,U,12),FMSNUM,"BD",10,"1","",$S($G(CRD):"Cancelled",1:"Modified")_" Billing Document")
 S FMSNUM1=$P($G(GECSFMS("DOC")),U,3)_"-"_$P($G(GECSFMS("DOC")),U,4)_"-"_$P($G(GECSFMS("BAT")),U,3)
 D OPEN^RCFMDRV1(FMSNUM1,7,"T"_TN,.ENT,.ERR,BILL,TN) I ERR]"" W !!,"Unable to create entry in AR Document File.",! S ERR=-1
 ;build and send document to FTH
 S DA=0 F  S DA=$O(^TMP("PRCABD",$J,DA)) Q:'DA  D SETCS^GECSSTAA(GECSFMS("DA"),^(DA))
 D SETCODE^GECSSDCT(GECSFMS("DA"),"D RETN^RCFMFN02")
 ; PRCA*4.5*270 if this is a CRD record, mark it for immediate transmission, otherwise put it in the queue
 ;D SETSTAT^GECSSTAA(GECSFMS("DA"),"Q")
 D SETSTAT^GECSSTAA(GECSFMS("DA"),$S($G(CRD):"M",1:"Q"))
 D SSTAT^RCFMFN02("T"_TN,1)
 W !,"Document #",GECSFMS("DA")," Created.",!
 Q
 ;
