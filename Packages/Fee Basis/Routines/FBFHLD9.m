FBFHLD9 ;OIFO/SAB-GET DATA FOR INPATIENT INVOICE ;9/9/2003
 ;;3.5;FEE BASIS;**61**;JULY 18, 2003
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
EN ;
 ; input
 ;   FBAAIN - invoice number
 ; output
 ;   If transaction type = "X" then only * items are output
 ;   Claim Level Data
 ;   FBD(0,"AMT") = Amount Disbursed^Amount Interest 
 ;  *FBD(0,"CAN") = Cancel Date^Cancel Reason^Cancel Activity
 ;   FBD(0,"DAYS) = Covered Days
 ;   FBD(0,"DRG") = DRG^DRG Weight
 ;   FBD(0,"DT") = Invoice Date
 ;  *FBD(0,"FPPS") = FPPS Claim ID
 ;  *FBD(0,"INV") = Invoice #^Transaction Type^Station #
 ;
 ;   Line Level Data
 ;   FBD(1,"ADJ") = AdjReason1^AdjGrp1^AdjAmt1
 ;   FBD(1,"AMT") = Amount Claimed^Amount Paid
 ;   FBD(1,"CK") = Check Number^Check Date^Payment Method
 ;   FBD(1,"DT") = Start Date^End Date
 ;   FBD(1,"FPPS") = FPPS Line Item
 ;   FBD(1,"RMK") = Remittance Remark1,Remittance Remark2
 ;
 ;   If exceptions for invoice
 ;   ^TMP($J,"FBE",FBAAIN,seq number)=message
 ;   If warnings for invoice
 ;   ^TMP($J,"FBW",FBAAIN,seq number)=message
 ;
 ; initialize variables
 N DA,FBC,FBI,FBIENS,FBSTA,FBTTYP,FBY
 K FBD
 ;
 S DA=FBAAIN
 S FBIENS=DA_","
 F FBI=0,2,3,"FBREJ" S FBY(FBI)=$G(^FBAAI(DA,FBI))
 Q:'$$CKLNST()  ; skip line if status not OK to transmit
 S FBC=1
 D INVOICE
 I FBTTYP="C" D LINE
 Q
 ;
INVOICE ; determine invoice data
 ;   FBD(0,"AMT") = Amount Disbursed^Amount Interest 
 ;   FBD(0,"CAN") = Cancel Date^Cancel Reason^Cancel Activity
 ;   FBD(0,"DAYS")
 ;   FBD(0,"DRG")
 ;   FBD(0,"DT") = Invoice Date
 ;   FBD(0,"FPPS") = FPPS Claim ID
 ;   FBD(0,"INV") = Invoice #^Transaction Type^Station #
 ;   FBSTA = station number
 ;   FBTTYP = transaction type (C or X)
 ;
 N FBDT,FBOB,FBX
 ; determine Transaction Type (based on CANCELLATION DATE)
 S FBTTYP=$S($P(FBY(2),U,5)]"":"X",1:"C")
 ;
 ; determine station number
 S FBSTA=$$STANO^FBFHLU($P(FBY(0),U,17))
 ;
 ;INV
 S FBD(0,"INV")=FBAAIN_U_FBTTYP_U_FBSTA
 ;
 ;FPPS
 S FBD(0,"FPPS")=$P(FBY(3),U)
 ;
 ;CAN
 ; if cancel then get cancel data
 I FBTTYP="X" D  Q
 . S FBD(0,"CAN")=$P(FBY(2),U,5)_U_$$GET1^DIQ(162.5,FBIENS,"50:1")_U_$P(FBY(2),U,7)
 ;
 ;AMT
 S FBD(0,"AMT")="0^0" ; initialize sums
 ;
 ;DT
 ; determine invoice date
 ;   (date finalized or date paid or date supervisor closed batch)
 S FBDT=$P(FBY(0),U,16) ; date finalized
 I FBDT="" S FBDT=$P(FBY(2),U) ; date paid
 I FBDT="",$P(FBY(0),U,17) S FBDT=$P(^FBAA(161.7,$P(FBY(0),U,17),0),U,6) ; date supv closed
 S FBD(0,"DT")=FBDT
 ;
 ;DAYS
 S FBD(0,"DAYS")=+$P(FBY(2),U,10)
 ;
 ;DRG
 S FBX=$$GET1^DIQ(162.5,FBIENS,24)
 I $E(FBX,1,3)="DRG" S FBX=$E(FBX,4,999)
 S FBD(0,"DRG")=FBX_U_$P(FBY(2),U,12)
 ;
 Q
 ;
LINE ;   FBC
 ;   FBD(#,"ADJ") = AdjReason1^AdjGrp1^AdjAmt1
 ;   FBD(#,"AMT") = Amount Claimed^Amount Paid
 ;   FBD(#,"CK") = Check Number^Check Date^Payment Method
 ;   FBD(#,"DT") = Start Date^End Date
 ;   FBD(#,"FPPS") = FPPS Line Item
 ;   FBD(#,"RMK") = Remittance Remark1^Remittance Remark2
 ;
 N FBADJ
 ;
 ;FPPS
 S FBD(FBC,"FPPS")=$P(FBY(3),U,2)
 ;
 ;DT
 S FBD(FBC,"DT")=$P(FBY(0),U,6)_U_$P(FBY(0),U,7)
 ;
 ;AMT
 S FBD(FBC,"AMT")=$P(FBY(0),U,8)_U_$P(FBY(0),U,9)
 ;
 ;ADJ
 D LOADADJ^FBCHFA(FBIENS,.FBADJ)
 I $D(FBADJ) S FBD(FBC,"ADJ")=$$ADJL^FBUTL2(.FBADJ)
 ;
 ;RMK
 S FBD(FBC,"RMK")=$$RRL^FBCHFR(FBIENS)
 ;
 ;CK
 S FBD(FBC,"CK")=$P(FBY(2),U,4)_U_$P(FBY(2),U)_U_$$PAYMETH^FBFHLU($P(FBY(2),U,4))
 ;
 ;CAMT ; add disbursed and interest amounts to claim (0) level
 ; note - disbursed amount on file includes the interest
 ;        since FPPS wants it w/o interest - interest is subtracted
 S $P(FBD(0,"AMT"),U)=$P(FBD(0,"AMT"),U)+($P(FBY(2),U,8)-$P(FBY(2),U,9))
 S $P(FBD(0,"AMT"),U,2)=$P(FBD(0,"AMT"),U,2)+$P(FBY(2),U,9)
 Q
 ;
CKLNST() ; check line status extrinsic function
 ; result (0 or 1)
 ;   0 when line should not be sent to FPPS
 ;   1 when line should be sent to FPPS
 N FBRET
 S FBRET=1
 ;
 ; check if rejected line
 I $P(FBY("FBREJ"),U)]"" S FBRET=0
 ;
 Q FBRET
 ;
 ;FBFHLD9
