ORKCHK2 ; slc/CLA - Order Checking support routine to do OCX-related order checks ;8/8/96 [ 04/02/97  1:08 PM ]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**6,32,74,123**;Dec 17, 1997
 Q
 ;
MLM(ORKS,ORKDFN,ORKA,ENT,ORKMODE) ;perform expert system-based order checking
 ;ORKS - return sort array of order checks
 ;ORKDFN - patient id
 ;ORKA - order information
 ;ENT - entity for parameter calls
 ;ORKMODE - ordering mode
 N ORKRTN,OCN,DNGR,ORKMSG,ORKTENT,ORNUM
 S ORKTENT=ENT
 S ORNUM=$P(ORKA,"|",5)
 D EN^OCXOEPS(.ORKRTN,ORKDFN,ORKA,ORKMODE)
 N ORKJ S ORKJ=""
 F  S ORKJ=$O(ORKRTN(ORKJ)) Q:ORKJ=""  D
 .S OCN=$P(ORKRTN(ORKJ),U,2)
 .Q:+$G(OCN)<1
 .S ENT=ORKTENT
 .I $$GET^XPAR(ENT,"ORK PROCESSING FLAG",OCN,"I")'="D" D
 ..I ORKMODE="DISPLAY" S DNGR=""
 ..E  S DNGR=$$GET^XPAR("DIV^SYS^PKG","ORK CLINICAL DANGER LEVEL",OCN,"I")
 ..I ($P($G(^ORD(100.8,OCN,0)),U)="ERROR MESSAGE"),(ORKMODE="DISPLAY") D
 ...S ORKMSG="CPRS Expert System disabled. Some order checks cannot be performed."
 ..I $P($G(^ORD(100.8,OCN,0)),U)'="ERROR MESSAGE" S ORKMSG=$P(ORKRTN(ORKJ),U,4)
 ..Q:'$L($G(ORKMSG))
 ..S ORKS("ORK",DNGR_","_$G(ORNUM)_","_$E(ORKMSG,1,225))=ORNUM_U_OCN_U_DNGR_U_ORKMSG
 Q
 ;
OISESS(OI) ;check for Lab OI match in order array (ORA)
 N ORI,LRID,LRIDX,LRIDY,LROI,ORQ,X
 S ORQ=""
 ;get lab id from orderable item (OI):
 S LRID=$G(^ORD(101.43,OI,0)) Q:'$L(LRID) ORQ
 S LRID=$P(LRID,U,2),LRID=$P(LRID,";")
 S X=0 F  S X=$O(^TMP("ORKA",$J,X)) Q:X=""  D
 .S ORI=^TMP("ORKA",$J,X)
 .I $P(ORI,"|",2)="LR" D  ;lab order
 ..S LRIDX=$P($P(ORI,"|",3),U,4) I LRIDX=LRID S ORQ=1 Q  ;match
 ..S LROI=$P(ORI,"|")
 ..;get children lab ids and check against ordered array  ORL
 ..S LRIDY="" F  S LRIDY=$O(^ORD(101.43,LROI,10,"AID",LRIDY)) Q:LRIDY=""  D
 ...S LRIDX=$P(LRIDY,";") I LRIDX=LRID S ORQ=1 Q  ;match
 Q ORQ
