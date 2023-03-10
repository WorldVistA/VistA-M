IBARXCRC ;ALB/CLT-CERNER RXCOPAY RECEIVE HL7 DFT-P03 MESSAGE; 30 Jan 2021
 ;;2.0;INTEGRATED BILLING;**676**;21-MAR-94;Build 34
 ;
 ; Receives from Cerner the IBARXC-RECV - DFT-P03 message with cerner transaction, 
 ; parse and save transaction 
 ; OR
 ; Receives from Cerner the IBARXC-RECV - DFT-P03 message with Cerner backbilling notice, 
 ; parse and update bill 
 ;
EN ;PRIMARY ENTRY POINT
 N DFN,TRANS,BDATE,POST,STAT,DESC,TCHRG,BILLED,UNBILLED,PATLOC,ACT,IENS,RXNUM,ACTTYPE,GOOD
 N IBD,ICN,PIEN,OBIL,BBIL,PARENT,UNITS,TRANSDT,MSG,HDR,SEG,XXX,DESC1,DESC2,DESC3,DLEN
 ;
 S XXX=$$STARTMSG^HLOPRS(.MSG,HLMSGIEN,.HDR) ;HLMSGIEN = IEN #778 passed from HL
 S XXX="" F  S XXX=$$NEXTSEG^HLOPRS(.MSG,.SEG) Q:$G(SEG("SEGMENT TYPE"))=""  D @SEG(0)  ;("SEGMENT TYPE")
 Q
 ;
PID ;PARSE THE PID SEGMENT
 S ICN=$G(SEG(3,1,1,1))
 S DFN=$$DFN^IBARXMU(ICN)
 ;Possibly need an error path if no match for ICN
 Q
EVN ;NO  SUBROUTINE
 Q
 ;
QRD ;PARSE QRD SEGMENT
 Q
 ;
FT1 ;PARSE THE FT1 SEGMENT
 S ACT=SEG(6,1,1,1)
 D:ACT="T"
 . S TRANS=$G(SEG(2,1,1,1))  ;TRANSACTION ID
 . S TRANS=$E($P(TRANS,"-",1),1,3)_"-"_$P(TRANS,"-",2)
 . S BDATE=$G(SEG(4,1,1,1))  ;trans date
 . S TRANSDT=$$HL7TFM^XLFDT(BDATE)
 . S STAT=SEG(7,1,1,1)  ;trans type
 . S DESC=$G(SEG(10,1,1,1))  D   ;Brief description
 . . ;Truncate the middle value and not the rxnum or units
 . . S DESC1=$P(DESC,"-",1),DESC2=$P(DESC,"-",2),DESC3=$P(DESC,"-",$L(DESC,"-"))  ;Desc may have more than 3 pieces
 . . S DLEN=(20-2-($L(DESC1_DESC3)))
 . . S DESC=DESC1_"-"_$E(DESC2,1,DLEN)_"-"_DESC3
 . . Q
 . S RXNUM=$G(SEG(11,1,1,1))  ;prescription number
 . S TCHRG=+$G(SEG(12,1,1,1),0)  ;total charge
 . S BILLED=+$G(SEG(13,1,1,1),0)  ;billed amount
 . S UNBILLED=+$G(SEG(14,1,1,1),0)  ;unbilled amount
 . S UNITS=$G(SEG(15,1,1,1))  ;Units
 . S PARENT=$G(SEG(17,1,1,1))  ;Parent Transaction
 . I PARENT["CRNR" S PARENT=$TR(PARENT,"CRNR","")
 . I $G(PARENT)="" S PARENT=TRANS
 . S PATLOC=SEG(18,1,1,1)  ;patient location
 . S GOOD=0 D  ;Do not file transactions with zero values
 . . S:BILLED'=0 GOOD=1
 . . S:UNBILLED'=0 GOOD=1
 . . S:TCHRG'=0 GOOD=1
 . Q:'GOOD
 . D SAVE
 . Q
 ;Check if Back billing
 D:ACT="B"
 . S BILLED=$G(SEG(13,1,1,1))  ;Billing Change Amount
 . Q:BILLED=0  ;Do not file transaction with zero value
 . S PARENT=$G(SEG(17,1,1,1))  ;Parent Transaction
 . D BILL^IBARXMB(PARENT,BILLED)   ;Backbilling utility
 Q
 ;
SAVE ;SAVE THE MESSAGE DATA
 S IBD=TRANS_"^"_DFN_"^"_TRANSDT_"^"_$G(ACTTYPE)_"^"_STAT_"^"_RXNUM_"^"_UNITS
 S IBD=IBD_"^"_+TCHRG_"^"_$E(DESC,1,20)_"^"_PARENT_"^"_+BILLED_"^"_+UNBILLED_"^"_$P(PATLOC,"^",1)
 S IENS=$$ADD^IBARXMN(DFN,IBD)
 Q
 ;
