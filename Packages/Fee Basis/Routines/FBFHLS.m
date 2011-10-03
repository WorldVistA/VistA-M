FBFHLS ;OIFO/SAB-BUILD HL7 MESSAGE SEGMENTS ;11/21/2003
 ;;3.5;FEE BASIS;**61,68**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
EN ;
 ; input
 ; HLFS  - HL7 field separator
 ; HLECH - HL7 encoding characters
 ; FBAAIN - invoice number
 ; FBD( array containing the invoice data
 ;  Applicablity of a FBD node for a given transaction type (C,L, or X)
 ;  is indicated by the presence of the transaction type code at the
 ;  beginning of the line in the following table.
 ;
 ;   Claim Level Data
 ; CL   FBD(0,"AMT")  = Amount Disbursed^Amount Interest 
 ;   X  FBD(0,"CAN")  = Cancel Date^Cancel Reason^Cancel Activity
 ; C    FBD(0,"DAYS") = Covered Days
 ; C    FBD(0,"DRG")  = DRG Code^DRG Weight
 ; CL   FBD(0,"DT")   = Invoice Date
 ; CLX  FBD(0,"FPPS") = FPPS Claim ID
 ; CLX  FBD(0,"INV")  = Invoice #^Transaction Type^Station #
 ;
 ;   Line Level Data (# is a sequential number)
 ; CL   FBD(#,"ADJ")  = AdjReas1^AdjGrp1^AdjAmt1^AdjReas2^AdjGrp2^AdjAmt2
 ;       note: ADJ node is only defined when there is an adjustment
 ;       note: only 1 adjustment for C type
 ; CL   FBD(#,"AMT")  = Amount Claimed^Amount Paid
 ; CL   FBD(#,"CK")   = Check Number^Check Date^Payment Method
 ; CL   FBD(#,"DT")   = Date of Service/Start Date^End Date
 ;       note: End Date only applicable for C type
 ; CL   FBD(#,"FPPS") = FPPS Line Item
 ; CL   FBD(#,"RMK")  = Remittance Remark1,Remittance Remark2
 ;  L   FBD(#,"SVC")  = Service Code^Qualifier^Mod1,Mod2,Mod3,Mod4^Units
 ;       note: SVC node is not defined for pharmacy invoices
 ;
 ; If existing exceptions for invoice
 ;   ^TMP($J,"FBE",FBAAIN,seq number)=message
 ; If existing warnings for invoice
 ;   ^TMP($J,"FBW",FBAAIN,seq number)=message
 ;
 ; output
 ;   ^TMP("HLS",$J) = HL global array for invoice
 ;   If new exceptions for invoice
 ;     ^TMP($J,"FBE",FBAAIN,seq number)=message
 ;   If new warnings for invoice
 ;     ^TMP($J,"FBW",FBAAIN,seq number)=message
 ;
 ; initialize variables
 N FBTTYP
 K ^TMP("HLS",$J)
 ;
 ; determine transaction type
 S FBTTYP=$P($G(FBD(0,"INV")),U,2)
 ;
 I '$D(HLFS) D  I '$D(HLFS) Q
 . N FBHL
 . D INIT^HLFNC2("FB FEE TO FPPS EVENT",.FBHL)
 . I $G(FBHL) Q
 . S HLFS=FBHL("FS")
 . S HLECH=FBHL("ECH")
 ;
 ; check for required fields
 D CHKREQ^FBFHLS1
 ;
 ; quit if exceptions
 Q:$D(^TMP($J,"FBE",FBAAIN))
 ;
 ; build segments for invoice in ^TMP("HLS",$J,
 I FBTTYP="C" D CL
 I FBTTYP="L" D CL
 I FBTTYP="X" D X
 ;
 Q
 ;
CL ; Claim or Line Transaction
 N FBCOMP,FBFLD,FBFT1,FBI,FBL,FBORC,FBX
 S FBL=0 ; line counter for HL7 lines in ^TMP("HLS",$J,line
 ; loop thru line items (Claim Transaction must have just 1 line)
 S FBI=0 F  S FBI=$O(FBD(FBI)) Q:'FBI  D
 . S FBORC="ORC"
 . ; transaction type (005)
 . S $P(FBORC,HLFS,6)=$P(FBD(0,"INV"),U,2)
 . ;
 . I FBTTYP="C" D
 . . ; covered days (007.3)
 . . S FBFLD=$P(FBORC,HLFS,8)
 . . S $P(FBFLD,$E(HLECH,1),3)=$P(FBD(0,"DAYS"),U)
 . . S $P(FBORC,HLFS,8)=FBFLD
 . ;
 . ; date of service/start date (007.4.1)
 . S FBFLD=$P(FBORC,HLFS,8)
 . S FBCOMP=$P(FBFLD,$E(HLECH,1),4)
 . S $P(FBCOMP,$E(HLECH,2),1)=$$FMTHL7^XLFDT($P(FBD(FBI,"DT"),U))
 . S $P(FBFLD,$E(HLECH,1),4)=FBCOMP
 . S $P(FBORC,HLFS,8)=FBFLD
 . ;
 . I FBTTYP="C" D
 . . ; end date (007.5.1)
 . . S FBFLD=$P(FBORC,HLFS,8)
 . . S FBCOMP=$P(FBFLD,$E(HLECH,1),5)
 . . S $P(FBCOMP,$E(HLECH,2),1)=$$FMTHL7^XLFDT($P(FBD(FBI,"DT"),U,2))
 . . S $P(FBFLD,$E(HLECH,1),5)=FBCOMP
 . . S $P(FBORC,HLFS,8)=FBFLD
 . ;
 . ; invoice date (009.1)
 . S FBFLD=$P(FBORC,HLFS,10)
 . S $P(FBFLD,$E(HLECH,1),1)=$$FMTHL7^XLFDT($P(FBD(0,"DT"),U))
 . S $P(FBORC,HLFS,10)=FBFLD
 . ;
 . ; station number (013.4.2)
 . S FBFLD=$P(FBORC,HLFS,14)
 . S FBCOMP=$P(FBFLD,$E(HLECH,1),4)
 . S $P(FBCOMP,$E(HLECH,2),2)=$P(FBD(0,"INV"),U,3)
 . S $P(FBFLD,$E(HLECH,1),4)=FBCOMP
 . S $P(FBORC,HLFS,14)=FBFLD
 . ;
 . ; store HL ORC segment for the line item
 . S FBX=FBORC D TMPHL
 . ;
 . S FBFT1="FT1"
 . ;
 . ; FPPS CLAIM-LINE (002)
 . S $P(FBFT1,HLFS,3)=$P(FBD(0,"FPPS"),U)_"-"_$$EXPLIST($P(FBD(FBI,"FPPS"),U))
 . ;
 . ; INVOICE # (003)
 . S $P(FBFT1,HLFS,4)=$P(FBD(0,"INV"),U)
 . ;
 . ; CHECK DATE (004)
 . S $P(FBFT1,HLFS,5)=$$FMTHL7^XLFDT($P(FBD(FBI,"CK"),U,2))
 . ;
 . ; PAYMENT METHOD (006)
 . S $P(FBFT1,HLFS,7)=$P(FBD(FBI,"CK"),U,3)
 . ;
 . I FBTTYP="L" D
 . . ; UNITS PAID (010)
 . . S $P(FBFT1,HLFS,11)=$P($G(FBD(FBI,"SVC")),U,4)
 . ;
 . ; REMITTANCE REMARKS (013)
 . S $P(FBFT1,HLFS,14)=$P(FBD(FBI,"RMK"),U)
 . ;
 . I FBTTYP="L" D
 . . ; SERVICE QUALIFIER (019)
 . . S $P(FBFT1,HLFS,20)=$P($G(FBD(FBI,"SVC")),U,2)
 . ;
 . ; CHECK NUMBER (023)
 . S $P(FBFT1,HLFS,24)=$P(FBD(FBI,"CK"),U)
 . ;
 . I FBTTYP="L" D
 . . ; SERVICE PROVIDED (025)
 . . S $P(FBFT1,HLFS,26)=$P($G(FBD(FBI,"SVC")),U)
 . ;
 . I FBTTYP="C" D
 . . ; DRG (025)
 . . S $P(FBFT1,HLFS,26)=$P(FBD(0,"DRG"),U)
 . ;
 . I FBTTYP="L" D
 . . ; MODIFIERS (026)
 . . S $P(FBFT1,HLFS,27)=$P($G(FBD(FBI,"SVC")),U,3)
 . ;
 . I FBTTYP="C" D
 . . ; DRG WEIGHT (026)
 . . S $P(FBFT1,HLFS,27)=$P(FBD(0,"DRG"),U,2)
 . ;
 . ; generate and store FT1s for each of the different $ amounts
 . ; amount claimed
 . S FBX=$$FT1(1,$P(FBD(FBI,"AMT"),U)) D TMPHL
 . ; amount paid
 . S FBX=$$FT1(2,$P(FBD(FBI,"AMT"),U,2)) D TMPHL
 . ; interest amount (conditional)
 . I $P(FBD(0,"AMT"),U,2)>0 S FBX=$$FT1(3,$P(FBD(0,"AMT"),U,2)) D TMPHL
 . ; disbursed amount
 . S FBX=$$FT1(4,$P(FBD(0,"AMT"),U)) D TMPHL
 . ; adjustment amount 1 (conditional)
 . I +$P($G(FBD(FBI,"ADJ")),U,3)'=0 S FBX=$$FT1(5,$P(FBD(FBI,"ADJ"),U,1,3)) D TMPHL
 . I FBTTYP="L" D
 . . ; adjustment amount 2 (conditional)
 . . I +$P($G(FBD(FBI,"ADJ")),U,6)'=0 S FBX=$$FT1(5,$P(FBD(FBI,"ADJ"),U,4,6)) D TMPHL
 ;
 Q
 ;
X ; Cancel Transaction
 N FBCOMP,FBFLD,FBFT1,FBL,FBORC
 S FBL=0 ; line counter for HL7 lines in ^TMP("HLS",$J,line
 S FBORC="ORC"
 ; transaction type (005)
 S $P(FBORC,HLFS,6)=$P(FBD(0,"INV"),U,2)
 ;
 ; cancel date (009.1)
 S FBFLD=$P(FBORC,HLFS,10)
 S $P(FBFLD,$E(HLECH,1),1)=$$FMTHL7^XLFDT($P(FBD(0,"CAN"),U))
 S $P(FBORC,HLFS,10)=FBFLD
 ;
 ; station number (013.4.2)
 S FBFLD=$P(FBORC,HLFS,14)
 S FBCOMP=$P(FBFLD,$E(HLECH,1),4)
 S $P(FBCOMP,$E(HLECH,2),2)=$P(FBD(0,"INV"),U,3)
 S $P(FBFLD,$E(HLECH,1),4)=FBCOMP
 S $P(FBORC,HLFS,14)=FBFLD
 ;
 S FBFT1="FT1"
 ;
 ; FPPS CLAIM (002)
 S $P(FBFT1,HLFS,3)=$P(FBD(0,"FPPS"),U)
 ;
 ; INVOICE # (003)
 S $P(FBFT1,HLFS,4)=$P(FBD(0,"INV"),U)
 ;
 ; CANCEL ACTIVITY CODE (006)
 S $P(FBFT1,HLFS,7)="F"_$P(FBD(0,"CAN"),U,3)
 ;
 ; CANCEL REASON (017)
 S $P(FBFT1,HLFS,18)=$P(FBD(0,"CAN"),U,2)
 ;
 ; store HL segments for line item
 S FBX=FBORC D TMPHL
 S FBX=FBFT1 D TMPHL
 ;
 Q
 ;
EXPLIST(FBLIST) ; expand ranges in a list
 ; input FBIST - list or range or "ALL"
 ; result expanded list (e.g. "1-3" returned as "1,2,3")
 ;
 N FBER,FBRET,FBLIST2,FBI,FBX,FBY
 S FBRET=$G(FBLIST)
 I FBRET["-" D
 . S FBLIST2="" ; init new list
 . ; loop thru comma pieces in original list
 . F FBI=1:1 S FBX=$P(FBLIST,",",FBI) Q:FBX=""  D
 . . I FBX'["-" S FBLIST2=FBLIST2_FBX_"," Q  ; not range - put in new
 . . ; expand range then put in new
 . . S FBER=""
 . . F FBY=$P(FBX,"-"):1:$P(FBX,"-",2) S FBER=FBER_FBY_","
 . . ; append expanded range to new list
 . . S FBLIST2=FBLIST2_FBER
 . ; replace return value with expanded list
 . S FBRET=FBLIST2
 ;
 ; remove trailing comma
 I $E(FBRET,$L(FBRET))="," S FBRET=$E(FBRET,1,$L(FBRET)-1)
 ;
 Q FBRET
 ;
FT1(FBTYAMT,FBX) ; add amount to FT1 segment
 ; input
 ;   FBTYAMT - type of amount (1,2,3,4,5)
 ;   FBX - if type 1-4 then amount
 ;       - if type 5 then adj reason^adjustment group^adj amount
 ;   FBFT1 - FT1 segment without an amount
 ; result (string)
 ;   FT1 segment with amount (and reason, group) inserted
 N FBRET
 S FBRET=FBFT1
 ;
 ; TYPE AMOUNT (007)
 S $P(FBRET,HLFS,8)=FBTYAMT
 ;
 ; AMOUNT (011)
 I FBTYAMT<5 S $P(FBRET,HLFS,12)=$FN($P(FBX,U),"",2)
 I FBTYAMT=5 S $P(FBRET,HLFS,12)=$FN($P(FBX,U,3),"",2)
 ;
 ; ADJUSTMENT REASON (017)
 I FBTYAMT=5 S $P(FBRET,HLFS,18)=$P(FBX,U)
 ;
 ; ADJUSTMENT GROUP (018)
 I FBTYAMT=5 S $P(FBRET,HLFS,19)=$P(FBX,U,2)
 ;
 Q FBRET
 ;
TMPHL ; Place HL7 segment in ^TMP
 ; input
 ;   FBL - last line written to ^TMP
 ;   FBX - HL7 segment
 ; output
 ;   FBL - will be incremented by 1
 ;   stores FBX in ^TMP("HLS",$J,FBL+1)
 ;   if length of FBX exceeds 244 then continuation lines will be used
 ;     example ^TMP($J,"HLS",$J,FBL+1,1)
 N FBLS
 S FBL=FBL+1
 I $L(FBX)<245 S ^TMP("HLS",$J,FBL)=FBX Q
 S ^TMP("HLS",$J,FBL)=$E(FBX,1,244)
 F FBLS=1:1 Q:$E(FBX,(FBLS*244)+1,(FBLS*244)+244)=""  D
 . S ^TMP("HLS",$J,FBL,FBLS)=$E(FBX,(FBLS*244)+1,(FBLS*244)+244)
 Q
 ;
 ;FBFHLS
