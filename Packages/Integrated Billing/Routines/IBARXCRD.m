IBARXCRD ;ALB/CLT-CERNER RXCOPAY RECEIVE DSR MESSAGE ; 14 May 2021  1:31 PM
 ;;2.0;INTEGRATED BILLING;**676**;21-MAR-94;Build 34
 ;
 ; Receives from Cerner the IBARXC-QRYRESP - DSR^Q03 
 ; processes Cerner seeding data, parse and save transactions 
 ;
EN(ICN) ;PRIMARY ENTRY POINT
 ;
 N MSG,HDR,SEG,XXX,DFN
 S DFN=$$DFN^IBARXMU(ICN)
 S XXX=$$STARTMSG^HLOPRS(.MSG,HLMSGIEN,.HDR)
 S XXX="" F  S XXX=$$NEXTSEG^HLOPRS(.MSG,.SEG) Q:$G(SEG("SEGMENT TYPE"))=""  D @SEG(0)  ;("SEGMENT TYPE")
 G END
 Q
 ;
MSA ;PARSE MSA SEGMENT
 Q
QRD ;PARSE QRD SEGMENT
 Q
QRF ;PARSE QRF SEGMENT
 Q
DSP ;PARSE THE DSP SEGMENT
 N TRANSX,TRANS,X,TRANSDT,STAT,DESC,DESC1,DESC2,DESC3,DLEN,RXNUM
 N PATLOC,PARENT,I,TCHRG,BILLED,UNBILLED,UNITS,IBD,IENS,ACTTYPE,GOOD
 N CHECK,IBD1,IBX,IEN
 ;
 S I=1 F  S I=$O(SEG(3,1,I)) Q:I=""  D
 . S TRANSX=$G(SEG(3,1,2,1))  ;TRANSACTION ID
 . S TRANS=$E($P(TRANSX,"-",1),1,3)_"-"_$P(TRANSX,"-",2)
 . S X=$G(SEG(3,1,4,1))
 . S TRANSDT="3"_$E(X,3,4)_$E(X,5,8)
 . S STAT=$G(SEG(3,1,7,1))  ;trans type
 . S DESC=$G(SEG(3,1,10,1))  ;Brief description
 . I $D(DESC) D
 . . ;Truncate the middle value and not the rxnum or units
 . . S DESC1=$P(DESC,"-",1),DESC2=$P(DESC,"-",2),DESC3=$P(DESC,"-",$L(DESC,"-"))  ;DESC may have more than 3 pieces
 . . S DLEN=(20-2-($L(DESC1_DESC3)))
 . . S DESC=DESC1_"-"_$E(DESC2,1,DLEN)_"-"_DESC3
 . S RXNUM=$G(SEG(3,1,11,1))  ;prescription number
 . S TCHRG=+$G(SEG(3,1,12,1))  ;total charge
 . S BILLED=+$G(SEG(3,1,13,1))  ;billed amount
 . S UNBILLED=+$G(SEG(3,1,14,1))  ;unbilled amount
 . S GOOD=0 D  ;Do not file transactions with zero values
 . . S:BILLED'=0 GOOD=1
 . . S:UNBILLED'=0 GOOD=1
 . . S:TCHRG'=0 GOOD=1
 . Q:'GOOD
 . S UNITS=$G(SEG(3,1,15,1)) ;Units
 . S PARENT=$G(SEG(3,1,17,1))  ;Parent Transaction
 . I PARENT["CRNR" S PARENT=$TR(PARENT,"CRNR","")  ;Remove CRNR from Cerner
 . I $G(PARENT)="" S PARENT=TRANS
 . S PATLOC=$G(SEG(3,1,18,1))  ;patient location
 . S CHECK=0,CHECK=$$DBLCHK(CHECK)
 . D:'CHECK SAVE
 . Q
 Q
 ;
SAVE ;SAVE THE MESSAGE DATA TO 354.71
 S IBD=TRANS_"^"_DFN_"^"_TRANSDT_"^"_$G(ACTTYPE)_"^"_STAT_"^"_RXNUM_"^"_UNITS
 S IBD=IBD_"^"_+TCHRG_"^"_DESC_"^"_PARENT_"^"_+BILLED_"^"_+UNBILLED_"^"_$P(PATLOC,"^",1)
 S IENS=$$ADD^IBARXMN(DFN,IBD)
 Q
 ;
END ;KILL LOCAL VARIABLES AND QUIT
 Q
 ;
ESEND  ;Error response something was not passed in or didn't match
 ;This is a recieving utility. We need to change to return a message with the error
 ;Build MSH from existing MSH
 Q
 ;
DBLCHK(CHECK) ;CHECK FOR A DUPLICATE ENTRY
 S CHECK=0
 I '$D(^IBAM(354.71,"B",TRANS)) Q CHECK
 S IEN=0,IEN=$O(^IBAM(354.71,"B",TRANS,IEN))
 S IBX=$P(^IBAM(354.71,IEN,0),"^",1,8)_"^"_$P(^IBAM(354.71,$P(^IBAM(354.71,IEN,0),"^",10),0),"^",1)_"^"_$P(^IBAM(354.71,IEN,0),"^",11,12)
 S IBD1=TRANS_"^"_DFN_"^"_TRANSDT_"^"_$G(ACTTYPE)_"^"_STAT_"^"_RXNUM_"^"_UNITS
 S IBD1=IBD1_"^"_+TCHRG_"^"_PARENT_"^"_+BILLED_"^"_+UNBILLED
 S CHECK=$S(IBX=IBD1:1,1:0)
 Q CHECK
