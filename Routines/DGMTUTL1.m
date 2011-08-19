DGMTUTL1 ;ALB/RMM - Means Test Consistency Checker ; 04/28/2005
 ;;5.3;Registration;**463,542,610,655**;Aug 13, 1993
 ;
 ;
 Q
 ; Apply Consistency Checks to the Income Test Processes: ADD,
 ; EDIT, and COMPLETE.
 ;
INCON(DFN,DGMTDT,DGMTI,IVMTYPE,IVMERR) ;
 ;
 ; Check Income Test before applying consistency checks
 ; - If AGREED TO PAY DEDUCTIBLE is NO
 ; - or DECLINES TO GIVE INCOME INFO and AGREED TO PAY DEDUCTIBLE are YES
 ; Quit, the consistency checks are unnecessary.
 N NODE0,APD,DTGII
 S NODE0=$G(^DGMT(408.31,DGMTI,0)),APD=$P(NODE0,U,11),DTGII=$P(NODE0,U,14)
 I APD=0!(APD=1&(DTGII=1)) Q
 ;
 ; Build the data strings for the veteran, and apply consistency checks
 ; Get information and initialize variables
 N CNT,HLFS,IEN,ARRAY,SPOUSE,DEP,DGDEP,DGINC,DGREL,DGINR,ZIR,ZIC,ZMT,ARRAY,DIEN
 S CNT=1,HLFS=U,SPOUSE=0,ZIC=""
 ;
 ; Build Individual Annual Income and Income Relation Arrays
 D ALL^DGMTU21(DFN,"VSC",DGMTDT)
 ;
 ; Build ZMT array for CC's
 S $P(ARRAY("ZMT"),U,2)=$P($G(^DGMT(408.31,DGMTI,0)),U,1)
 S $P(ARRAY("ZMT"),U,2)=$E($P(ARRAY("ZMT"),U,2),1,3)+1700_$E($P(ARRAY("ZMT"),U,2),4,7)
 S $P(ARRAY("ZMT"),U,3)=$P($G(^DGMT(408.31,DGMTI,0)),U,3)
 S $P(ARRAY("ZMT"),U,3)=$P(^DG(408.32,$P(ARRAY("ZMT"),U,3),0),U,2)
 ;
 ; Build Spouse ZIC Arrays
 I $D(DGREL("S")) S SPOUSE=1,ARRAY(SPOUSE,"ZIC")=$$ZIC^DGMTUTL2(DGINC("S"),SPOUSE),ARRAY(SPOUSE,"ZIR")=$$ZIR^DGMTUTL2(DGINR("S")),ARRAY(SPOUSE,"ZDP")=$$ZDP^DGMTUTL2(DGREL("S"),SPOUSE)
 I SPOUSE D ZDP^IVMCMF2(ARRAY(SPOUSE,"ZDP"))
 ;
 ; Build Dependent ZDP, ZIC & ZIR Arrays
 F IEN=1:1:DGDEP S DIEN=IEN+SPOUSE,ARRAY(DIEN,"ZDP")=$$ZDP^DGMTUTL2(DGREL("C",IEN),DIEN),ARRAY(DIEN,"ZIC")=$$ZIC^DGMTUTL2(DGINC("C",IEN),DIEN),ARRAY(DIEN,"ZIR")=$$ZIR^DGMTUTL2(DGINR("C",IEN),DIEN)
 S DEP=DGDEP+SPOUSE
 ;
 ; Perform the inconsistency Checks for the Veteran
 I $D(DGINR("V")) D
 .S ZIC=$$ZIC^DGMTUTL2(DGINC("V"))
 .S ZIR=$$ZIR^DGMTUTL2(DGINR("V"),DGMTDT)
 .D ZIR^IVMCMF1(ZIR,"")
 ;
 I "^1^2^4^"[("^"_IVMTYPE_"^"),(ZIC'="") D 
 .S ZMT=$$ZMT^DGMTUTL2(DGMTI)
 .M ARRAY("ZIC")=ZIC
 .D ZMT^IVMCMF2(ZMT)
 ;
 ; Perform the Consistency Checks for the dependent(s)
 F IEN=(SPOUSE+1):1:DEP D ZDP^IVMCMF2(ARRAY(IEN,"ZDP")),ZIR^IVMCMF1(ARRAY(IEN,"ZIR"),IEN),ZIC^IVMCMF1(ARRAY(IEN,"ZIC"),IEN)
 ;
 Q
