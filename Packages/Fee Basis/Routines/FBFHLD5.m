FBFHLD5 ;OIFO/SAB-GET DATA FOR PHARMACY INVOICE ;10/9/2003
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
 ;   FBD(0,"DT") = Invoice Date
 ;  *FBD(0,"FPPS") = FPPS Claim ID
 ;  *FBD(0,"INV") = Invoice #^Transaction Type^Station #
 ;
 ;   Line Level Data (# is a sequential number)
 ;   FBD(#,"ADJ") = AdjReason1^AdjGrp1^AdjAmt1^AdjReason2^AdjGrp2^AdjAmt2
 ;   FBD(#,"AMT") = Amount Claimed^Amount Paid
 ;   FBD(#,"CK") = Check Number^Check Date^Payment Method
 ;   FBD(#,"DT") = Date Prescription Filled
 ;   FBD(#,"FPPS") = FPPS Line Item
 ;   FBD(#,"RMK") = Remittance Remark1,Remittance Remark2
 ;
 ;   If exceptions for invoice
 ;   ^TMP($J,"FBE",FBAAIN,seq number)=message
 ;   If warnings for invoice
 ;   ^TMP($J,"FBW",FBAAIN,seq number)=message
 ;
 ; initialize variables
 N DA,FBC,FBI,FBIENS,FBRXY,FBSTA,FBTTYP,FBY
 K FBD
 S FBC=0 ; line count
 ;
 S DA(1)=FBAAIN
 S FBY(0)=$G(^FBAA(162.1,DA(1),0))
 ; loop thru prescriptions on invoice
 S DA=0 F  S DA=$O(^FBAA(162.1,DA(1),"RX",DA)) Q:'DA  D
 . S FBIENS=DA_","_DA(1)_","
 . F FBI=0,2,3,"FBREJ" S FBRXY(FBI)=$G(^FBAA(162.1,DA(1),"RX",DA,FBI))
 . Q:'$$CKLNST()  ; skip line if status not OK to transmit
 . S FBC=FBC+1
 . ; if 1st line then get invoice level data
 . I FBC=1 D INVOICE
 . I FBTTYP="L" D LINE
 Q
 ;
INVOICE ; determine invoice data from 1st line item
 ;   FBD(0,"AMT") = Amount Disbursed^Amount Interest 
 ;   FBD(0,"CAN") = Cancel Date^Cancel Reason^Cancel Activity
 ;   FBD(0,"DT") = Invoice Date
 ;   FBD(0,"FPPS") = FPPS Claim ID
 ;   FBD(0,"INV") = Invoice #^Transaction Type^Station #
 ;   FBSTA = station number
 ;   FBTTYP = transaction type (L or X)
 ;
 N FBDT,FBOB,FBX
 ; determine Transaction Type (based on CANCELLATION DATE)
 S FBTTYP=$S($P(FBRXY(2),U,11)]"":"X",1:"L")
 ;
 ; determine station number
 S FBSTA=$$RXSTA(FBAAIN,$P(FBRXY(0),U,17))
 ;
 ;INV
 S FBD(0,"INV")=FBAAIN_U_FBTTYP_U_FBSTA
 ;
 ;FPPS
 S FBD(0,"FPPS")=$P(FBY(0),U,13)
 ;
 ;CAN
 ; if cancel then get cancel data
 I FBTTYP="X" D  Q
 . S FBD(0,"CAN")=$P(FBRXY(2),U,11)_U_$$GET1^DIQ(162.11,FBIENS,"32:1")_U_$P(FBRXY(2),U,13)
 ;
 ;AMT
 S FBD(0,"AMT")="0^0" ; initialize sums
 ;
 ;DT
 ; determine invoice date
 ;   (date certified or date paid or date supervisor closed batch)
 S FBDT=$P(FBRXY(0),U,19) ; date certified for payment (lines may differ)
 I FBDT="" S FBDT=$P(FBRXY(2),U,8) ; date paid
 I FBDT="",$P(FBRXY(0),U,17) S FBDT=$P(^FBAA(161.7,$P(FBRXY(0),U,17),0),U,6) ; date supv closed batch (for 0.00 lines)
 S FBD(0,"DT")=FBDT
 ;
 Q
 ;
LINE ; FBC
 ;   FBD(#,"ADJ") = AdjReason1^AdjGrp1^AdjAmt1^AdjReason2^AdjGrp2^AdjAmt2
 ;   FBD(#,"AMT") = Amount Claimed^Amount Paid
 ;   FBD(#,"CK") = Check Number^Check Date^Payment Method
 ;   FBD(#,"DT") = Date of Service
 ;   FBD(#,"FPPS") = FPPS Line Item
 ;   FBD(#,"RMK") = Remittance Remark1^Remittance Remark2
 ;   FBD(#,"SVC") = Service Code^Qualifier^Mod1,Mod2,Mod3,Mod4^Units
 ;
 N FBADJ
 ; compare invoice transaction type (L,X) with line cancel status
 I ((FBTTYP="X")&($P(FBRXY(2),U,11)=""))!((FBTTYP="L")&($P(FBRXY(2),U,11)]"")) D POST^FBFHLU(FBAAIN,"E","ALL LINES DO NOT HAVE SAME CANCEL STATUS") Q
 ;
 ;FPPS
 S FBD(FBC,"FPPS")=$P(FBRXY(3),U)
 ;
 ;DT
 S FBD(FBC,"DT")=$P(FBRXY(0),U,3)
 ;
 ;AMT
 S FBD(FBC,"AMT")=$P(FBRXY(0),U,4)_U_$P(FBRXY(0),U,16)
 ;
 ;ADJ
 D LOADADJ^FBRXFA(FBIENS,.FBADJ)
 I $D(FBADJ) S FBD(FBC,"ADJ")=$$ADJL^FBUTL2(.FBADJ)
 ;
 ;RMK
 S FBD(FBC,"RMK")=$$RRL^FBRXFR(FBIENS)
 ;
 ;CK
 S FBD(FBC,"CK")=$P(FBRXY(2),U,10)_U_$P(FBRXY(2),U,8)_U_$$PAYMETH^FBFHLU($P(FBRXY(2),U,10))
 ;
 ;CAMT ; add disbursed and interest amounts to claim (0) level
 ; note - disbursed amount on file includes the interest
 ;        since FPPS wants it w/o interest - interest is subtracted
 S $P(FBD(0,"AMT"),U)=$P(FBD(0,"AMT"),U)+($P(FBRXY(2),U,14)-$P(FBRXY(2),U,15))
 S $P(FBD(0,"AMT"),U,2)=$P(FBD(0,"AMT"),U,2)+$P(FBRXY(2),U,15)
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
 I $P(FBRXY("FBREJ"),U)]"" S FBRET=0
 ;
 Q FBRET
 ;
RXSTA(FBAAIN,FBBATCH) ; determine station number for pharmacy
 ; input
 ;   FBAAIN - invoice number in FEE BASIS PHARMACY INVOICE file
 ;   FBBATCH - ien of entry in FEE BASIS BATCH (#161.7) file
 ; returns station number or NULL value
 N FBRET
 ; if batch not input then check all line items for a batch
 I 'FBBATCH D
 . N DA
 . S DA(1)=FBAAIN
 . S DA=0 F  S DA=$O(^FBAA(162.1,DA(1),"RX",DA)) Q:'DA  D  Q:FBBATCH
 . . S FBBATCH=$P($G(^FBAA(162.1,DA(1),"RX",DA,0)),U,17)
 ;
 ; if batch known then call API to get station number
 I FBBATCH S FBRET=$$STANO^FBFHLU(FBBATCH)
 ; if batch not known then get station number based on fee site param.
 I 'FBBATCH S FBRET=$$GET1^DIQ(161.4,"1,","27:99")
 ;
 Q FBRET
 ;
 ;FBFHLD5
