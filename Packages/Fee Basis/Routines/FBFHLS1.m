FBFHLS1 ;OIFO/SAB-BUILD HL7 MESSAGE SEGMENTS (CONTINUED) ;9/9/2003
 ;;3.5;FEE BASIS;**61**;JULY 18, 2003
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
CHKREQ ; Check for required fields
 ; input
 ;   FBAAIN - invoice number (or 0 if number not known)
 ;   FBTTYP - transaction type (C,L, or X)
 ;   FBD( array of invoice data - see FBFHLS for more info
 ; output
 ;   if problems found
 ;   ^TMP($J,"FBE",invoice number,seq number)=error text
 ;
 ; CLX  transaction type
 ; CLX  station number
 ; CLX  FPPS claim
 ; CL   invoice date
 ;   X  cancellation date
 ; CL   FPPS line
 ;
 N FBI
 ;
 ; check for required claim level data
 I "^C^L^X^"'[(U_$P($G(FBD(0,"INV")),U,2)_U) D POST^FBFHLU(FBAAIN,"E","INVALID TRANSACTION TYPE")
 I $P($G(FBD(0,"INV")),U)="" D POST^FBFHLU(FBAAIN,"E","MISSING INVOICE NUMBER")
 I $P($G(FBD(0,"FPPS")),U)="" D POST^FBFHLU(FBAAIN,"E","MISSING FPPS CLAIM ID")
 I "^C^L^"[(U_FBTTYP_U),$P($G(FBD(0,"DT")),U)="" D POST^FBFHLU(FBAAIN,"E","MISSING INVOICE DATE")
 I "^X^"[(U_FBTTYP_U),$P($G(FBD(0,"CAN")),U)="" D POST^FBFHLU(FBAAIN,"E","MISSING CANCELLATION DATE")
 ;
 ; check for required line level data
 I "^C^L^"[(U_FBTTYP_U) D
 . S FBI=0 F  S FBI=$O(FBD(FBI)) Q:'FBI  D
 . . I $P($G(FBD(FBI,"FPPS")),U)="" D POST^FBFHLU(FBAAIN,"E","MISSING FPPS LINE ITEM")
 . . I $P($G(FBD(FBI,"AMT")),U,2)>0,$P($G(FBD(FBI,"CK")),U)="" D POST^FBFHLU(FBAAIN,"E","MISSING CHECK NUMBER")
 ;
 Q
 ;
 ;FBFHLS1
