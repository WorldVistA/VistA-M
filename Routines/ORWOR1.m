ORWOR1 ; slc/dcm - PKI RPC functions
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**132,141,163**;Dec 17, 1997
SIG(RET,ID,X1,X2,X3,X4,ORX5,X6) ;Store the signature.
 ;ID = orifn;action
 ;X1 = Hash
 ;X2 = Length of the array
 ;X3 = Datafile (100)
 ;X4 = Provider DUZ
 ;ORX5 = Array for the sig
 ;X6 = CRLURL
 N Y1,ORIFN,ACT
 S Y1=$$STORESIG^XUSSPKI(X1,X2,.ORX5,X4,X3)
 I +Y1>0,$L($G(X6)) S Y1=$$CRLURL^XUSSPKI(X6)
 I +Y1>0 D
 . S ORIFN=+ID,ACT=$P(ID,";",2)
 . S $P(^OR(100,ORIFN,8,+ACT,2),"^",3)=X1
 S RET=Y1
 Q
CRLURL(RET,X1) ;Store the URL's
 S RET=$$CRLURL^XUSSPKI(X1)
 Q
VERIFY(RET,ORDER,DFN)       ;Verify PKI Data
 ;DBIA #3750
 ;ORDER = ORIFN;ACTION - NOTE: if no ACTION then 1 (new order) is assumed
 ;Returned values: "1" if digital signature verifies
 ;                 "-1^error message" if DS fails during initial parameter checking
 ;                 "898020xx^message" if DS fails during verification
 N ORIFN,ORACTION,HASH,DATE
 K ^TMP("ORPKIDATA",$J)
 I '$G(ORDER) S RET="-1^No order number passed" Q
 I '$G(DFN) S RET="-1^No DFN passed" Q
 S ORIFN=$P(ORDER,";"),ORACTION=$P(ORDER,";",2)
 I 'ORACTION S ORACTION=1
 I '$D(^OR(100,ORIFN,0)) S RET="-1^Invalid order number" Q
 I DFN'=+$P(^OR(100,ORIFN,0),"^",2) S RET="-1^DFN does not match patient on order" Q
 I '$D(^OR(100,ORIFN,8,ORACTION)) S RET="-1^Invalid order action passed" Q
 S HASH=$P($G(^OR(100,ORIFN,8,ORACTION,2)),"^",3)
 I '$L(HASH) S RET="-1^Order has no PKI Hash" Q
 I '$O(^OR(100,ORIFN,8,ORACTION,.2,0)) S RET="-1^Order has no PKI Data" Q
 S DATE=$P($G(^OR(100,ORIFN,8,ORACTION,.2,1,0)),"^")
 I '$L(DATE) S RET="-1^No date associated with PKI Data" Q
 S DATE=$$HL7TFM^XLFDT(DATE),I=0
 F  S I=$O(^OR(100,ORIFN,8,ORACTION,.2,I)) Q:'I  S ^TMP("ORPKIDATA",$J,I)=^(I,0)
 S RET=$$VERIFY^XUSSPKI(HASH,$NA(^TMP("ORPKIDATA",$J)),DATE)
 I RET="OK" S RET=1 Q
 I $E(RET,1,7)="-898020" S RET=$E(RET,2,99)
 Q
CHKDIG(REQ,ORDER)       ;Check if Digital Signature is required
 N IFN,ACTION
 S REQ=0,IFN=+ORDER,ACTION=$P(ORDER,";",2)
 I +$P($G(^OR(100,+IFN,8,+ACTION,2)),U,5) S REQ=1
 Q
GETDTEXT(TEXT,ORDER)    ;Get External Text
 N IFN,ACTION
 S IFN=+ORDER,ACTION=$P(ORDER,";",2),I=0
 F  S I=$O(^OR(100,+IFN,8,+ACTION,.2,I)) Q:'I  S TEXT(I)=^(I,0)
 Q
GETDSIG(SIG,ORDER)      ;Get Digital Signature
 N IFN,ACTION
 S SIG=0,IFN=+ORDER,ACTION=$P(ORDER,";",2)
 I +$P($G(^OR(100,+IFN,8,+ACTION,2)),U,3) S SIG=$P(^(2),"^",3)
 Q
GETDEA(Y,ORUSER)        ;Get user DEA
 S Y=$$DEA^XUSER(,$G(ORUSER))
 Q
GETDSCH(Y,ORDER)       ;Check if Drug Schedule
 N IFN,ACTION
 S IFN=+ORDER,ACTION=$P(ORDER,";",2)
 S Y=$P($G(^OR(100,+IFN,8,+ACTION,2)),U,4)
 Q
SETDTEXT(Y,ORDER,ORDEA,ORSIGNER)        ;Set Digital Text data into file 100 & return the array
 ;ORDER = ORIFN;ACTION
 ;ORDEA = Schedule of Drug (2-5)
 ;ORSIGNER = DUZ of signer
 N ORSET,IFN,ACT,I
 S Y="-1^Digital Text failed to build",IFN=+ORDER,ACT=$P(ORDER,";",2)
 I '$G(ORDEA) Q
 I '$G(ORSIGNER) S ORSIGNER=DUZ
 D DIGTEXT^ORCSAVE1(IFN,ORDEA,ORSIGNER)
 S Y=0
 I '$G(ORSET) Q
 K ^OR(100,IFN,8,ACT,.2)
 F I=1:1:ORSET S (Y(I),^OR(100,IFN,8,ACT,.2,I,0))=ORSET(I)
 S ^OR(100,IFN,8,ACT,.2,0)="^^"_ORSET_"^"_ORSET_"^"_DT_"^",Y=ORSET
 Q
GETDATA(Y,ORDER,DFN)    ;Get PKI Data
 ;DBIA #3750
 ;On error: Y = -1^Error message
 ;Else: Y = 1^ Order # ^ Nature of order ^ Order Status ^ Date Signed
 ;Y(1) = Patient name ^ Street1 ^ Street2 ^ Street3 ^ City ^ State ^ Zip
 ;Y(2) = Drug name_strength_dosage form (Dispense drug) ^ Drug IEN (file 50) ^ Drug quantity prescribed ^ Schedule of medication ^ DEA Schedule
 ;Y(3) = Directions for use (SIG)
 ;Y(4) = Practitioner's name ^ DUZ ^ Practitioner's (DEA) registration number
 ;Y(5) = SiteName ^ SiteStreet1  ^ SiteStreet2 ^ SiteCity  ^ SiteState ^ SiteZip
 ;Y(6) = Orderable Item ^ Orderable Item IEN (file 101.43)
 N X0,X1,X2,X3,X4,X5,X6,ORNAT,ORSTAT
 I '$D(^OR(100,+$G(ORDER),0)) S Y="-1^INVALID ORDER #" Q
 I $G(DFN)'=+$P(^OR(100,ORDER,0),"^",2) S Y="-1^INVALID PATIENT ID" Q
 I '$D(^OR(100,ORDER,8,1,.2,0)) S Y="-1^MISSING DIGITAL SIGNATURE TEXT" Q
 S X0=$G(^OR(100,ORDER,8,1,0))
 I $P($G(^OR(100,ORDER,8,1,0)),"^",4)'=7 S Y="-1^ORDER HAS NOT BEEN DIGITALLY SIGNED" Q
 S X1=$G(^OR(100,ORDER,8,1,.2,1,0))
 I DFN'=$P(X1,"^",4) S Y="-1^PKI PATIENT ID DOES NOT MATCH DFN" Q
 S ORNAT=$P(X0,"^",12),ORSTAT=$P($G(^OR(100,ORDER,3)),"^",3)
 I ORNAT S ORNAT=$P($G(^ORD(100.02,ORNAT,0)),"^")
 I ORSTAT S ORSTAT=ORSTAT_";"_$P(^ORD(100.01,ORSTAT,0),"^")
 S Y="1^"_ORDER_"^"_ORNAT_"^"_ORSTAT_"^"_$P(X0,"^",6)
 S X2=$G(^OR(100,ORDER,8,1,.2,2,0)),X3=$G(^OR(100,ORDER,8,1,.2,3,0)),X4=$G(^OR(100,ORDER,8,1,.2,4,0)),X5=$G(^OR(100,ORDER,8,1,.2,5,0)),X6=$G(^OR(100,ORDER,8,1,.2,6,0))
 S X3=$$VALUE^ORX8(ORDER,"DRUG",,"E")_"^"_$$VALUE^ORX8(ORDER,"DRUG",,"I")_"^"_$P(X3,"^",3,99)
 S Y(1)=$P(X1,"^",2)_"^"_X2
 S Y(2)=X3,Y(3)=X4,Y(4)=X5,Y(5)=X6
 S Y(6)=$$VALUE^ORX8(ORDER,"ORDERABLE",,"E")_"^"_$$VALUE^ORX8(ORDER,"ORDERABLE",,"I")
 Q
