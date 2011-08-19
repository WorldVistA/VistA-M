FBFHLD3 ;OIFO/SAB-GET DATA FOR OUT/ANC INVOICE ;9/9/2003
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
 ;   FBD(#,"DT") = Date of Service
 ;   FBD(#,"FPPS") = FPPS Line Item
 ;   FBD(#,"RMK") = Remittance Remark1,Remittance Remark2
 ;   FBD(#,"SVC") = Service Code^Qualifier^Mod1,Mod2,Mod3,Mod4^Units
 ;
 ;   If exceptions for invoice
 ;   ^TMP($J,"FBE",FBAAIN,seq number)=message
 ;   If warnings for invoice
 ;   ^TMP($J,"FBW",FBAAIN,seq number)=message
 ;
 ; initialize variables
 N DA,FBC,FBI,FBIENS,FBSTA,FBTTYP,FBY
 K FBD
 S FBC=0 ; line count
 ;
 ; loop thru lines on invoice
 S DA(3)=0
 F  S DA(3)=$O(^FBAAC("C",FBAAIN,DA(3))) Q:'DA(3)  D
 .S DA(2)=0
 .F  S DA(2)=$O(^FBAAC("C",FBAAIN,DA(3),DA(2))) Q:'DA(2)  D
 ..S DA(1)=0
 ..F  S DA(1)=$O(^FBAAC("C",FBAAIN,DA(3),DA(2),DA(1))) Q:'DA(1)  D
 ...S DA=0
 ...F  S DA=$O(^FBAAC("C",FBAAIN,DA(3),DA(2),DA(1),DA)) Q:'DA  D
 ....S FBIENS=DA_","_DA(1)_","_DA(2)_","_DA(3)_","
 ....F FBI=0,2,3,"FBREJ" S FBY(FBI)=$G(^FBAAC(DA(3),1,DA(2),1,DA(1),1,DA,FBI))
 ....Q:'$$CKLNST()  ; skip line if status not OK to transmit
 ....S FBC=FBC+1
 ....; if 1st line then get invoice level data
 ....I FBC=1 D INVOICE
 ....I FBTTYP="L" D LINE
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
 S FBTTYP=$S($P(FBY(2),U,4)]"":"X",1:"L")
 ;
 ; determine station number
 S FBSTA=$$STANO^FBFHLU($P(FBY(0),U,8))
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
 . S FBD(0,"CAN")=$P(FBY(2),U,4)_U_$$GET1^DIQ(162.03,FBIENS,"37:1")_U_$P(FBY(2),U,6)
 ;
 ;AMT
 S FBD(0,"AMT")="0^0" ; initialize sums
 ;
 ;DT
 ; determine invoice date
 ;   (date finalized or date paid or date supervisor closed batch)
 S FBDT=$P(FBY(0),U,6) ; date finalized
 I FBDT="" S FBDT=$P(FBY(0),U,14) ; date paid
 I FBDT="",$P(FBY(0),U,8) S FBDT=$P(^FBAA(161.7,$P(FBY(0),U,8),0),U,6) ; date supv closed batch (for 0.00 invoices)
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
 N FBAARCE,FBADJ,FBMODLE
 ; compare invoice transaction type (L,X) with line cancel status
 I ((FBTTYP="X")&($P(FBY(2),U,4)=""))!((FBTTYP="L")&($P(FBY(2),U,4)]"")) D POST^FBFHLU(FBAAIN,"E","ALL LINES DO NOT HAVE SAME CANCEL STATUS") Q
 ;
 ; SVC
 S FBAARCE=$$GET1^DIQ(162.03,FBIENS,48)
 I FBAARCE]"" S FBD(FBC,"SVC")=FBAARCE_U_"NU"
 E  D
 . S FBD(FBC,"SVC")=$$GET1^DIQ(162.03,FBIENS,.01)_U_"HC"
 . S FBMODLE=$$MODL^FBAAUTL4("^FBAAC("_DA(3)_",1,"_DA(2)_",1,"_DA(1)_",1,"_DA_",""M"")","E")
 . I $L(FBMODLE,",")>4 S FBMODLE=$P(FBMODLE,",",1,4)
 . S $P(FBD(FBC,"SVC"),U,3)=FBMODLE
 S $P(FBD(FBC,"SVC"),U,4)=$P(FBY(2),U,14) ; units paid
 ;
 ;FPPS
 S FBD(FBC,"FPPS")=$P(FBY(3),U,2)
 ;
 ;DT
 S FBD(FBC,"DT")=$P($G(^FBAAC(DA(3),1,DA(2),1,DA(1),0)),U)
 ;
 ;AMT
 S FBD(FBC,"AMT")=$P(FBY(0),U,2)_U_$P(FBY(0),U,3)
 ;
 ;ADJ
 D LOADADJ^FBAAFA(FBIENS,.FBADJ)
 I $D(FBADJ) S FBD(FBC,"ADJ")=$$ADJL^FBUTL2(.FBADJ)
 ;
 ;RMK
 S FBD(FBC,"RMK")=$$RRL^FBAAFR(FBIENS)
 ;
 ;CK
 S FBD(FBC,"CK")=$P(FBY(2),U,3)_U_$P(FBY(0),U,14)_U_$$PAYMETH^FBFHLU($P(FBY(2),U,3))
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
 ;FBFHLD3
