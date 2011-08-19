ORCACT03 ;SLC/MKB-Validate order actions cont ;02/06/2007
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**243**;Dec 17, 1997;Build 242
 ;
INACTIVE() ; -- Returns 1 or 0, if OI is now inactive
 N I,OI,PREOI,PREOIX,X,Y,ORNOW,DD,PSOI S Y=0,ORNOW=$$NOW^XLFDT
 S I=0 F  S I=+$O(^OR(100,+IFN,4.5,"ID","ORDERABLE",I)) Q:I'>0  D  Q:Y
 . S OI=+$G(^OR(100,+IFN,4.5,I,1))
 . I OI S X=$G(^ORD(101.43,OI,.1)) I X,X<ORNOW S Y=1
 I Y,PKG="PS",DG'="IV RX" D  ;replacement OI?
 . S I=+$O(^OR(100,+IFN,4.5,"ID","DRUG",0)) Q:I'>0  ;first
 . S DD=+$G(^OR(100,+IFN,4.5,I,1)) Q:DD'>0  Q:$G(OI)'>0
 . S PSOI=+$P($G(^ORD(101.43,OI,0)),U,2),X=$$ITEM^PSSUTIL1(PSOI,DD)
 . Q:X'>0  S X=+$O(^ORD(101.43,"ID",+$P(X,U,2)_";99PSP",0)) Q:X'>0
 . I $G(^ORD(101.43,X,.1)),$G(^(.1))<ORNOW Q  ;make sure new OI is active
 . S I=+$O(^OR(100,+IFN,4.5,"ID","ORDERABLE",0))
 . IF I D
 . . S PREOI=$G(^OR(100,+IFN,4.5,I,1))
 . . S PREOIX=$O(^OR(100,+IFN,.1,"B",PREOI,0))
 . . K ^OR(100,+IFN,.1,"B",PREOI,PREOIX)
 . . S ^OR(100,+IFN,.1,"B",X,PREOIX)=""
 . . S ^OR(100,+IFN,.1,PREOIX,0)=X
 . . S ^OR(100,+IFN,4.5,I,1)=X
 . . S Y=0 ;reset
 Q Y
 ;
MEDOK() ; -- Returns 1 or 0, if med OI usage=Y
 N Y,OI,ORPS,X S Y=1,X=$P(OR0,U,12)
 I (DG="SPLY")!(DG="O RX")!(DG="I RX")!(DG="UD RX") D
 . S OI=+$O(^OR(100,+IFN,4.5,"ID","ORDERABLE",0))
 . S OI=+$G(^OR(100,+IFN,4.5,OI,1))
 . S ORPS=$G(^ORD(101.43,OI,"PS"))
 I DG="SPLY",'$P(ORPS,U,5) S Y=0
 I DG="O RX",'(X="O"&$P(ORPS,U,2)),'(X="I"&($P(ORPS,U)=2)) S Y=0
 I DG="I RX"!(DG="UD RX"),'$P(ORPS,U) S Y=0
 I DG="IV RX" D
 . N I,X0,X1 S I=0
 . F  S I=+$O(^OR(100,+IFN,4.5,"ID","ORDERABLE",I)) Q:I<1  D  Q:Y<1
 .. S X0=$G(^OR(100,+IFN,4.5,I,0)),X1=+$G(^(1))
 .. I $P($G(^ORD(101.41,+$P(X0,U,2),0)),U)["ADDITIVE" S:'$P($G(^ORD(101.43,X1,"PS")),U,4) Y=0 Q
 .. S:'$P($G(^ORD(101.43,X1,"PS")),U,3) Y=0
 Q Y
 ;
IV() ; -- IV order, either Inpt or Fluid?
 I DG="IV RX" Q 1
 N I,OI,X S I=+$O(^OR(100,IFN,4.5,"ID","ORDERABLE",0))
 S OI=+$G(^OR(100,IFN,4.5,+I,1)),X=$P($G(^ORD(101.43,+OI,"PS")),U)
 Q (X>1)
 ;
NTBG(ORIFN) ; -- Inpt order marked as 'Not to be Given'?
 N PSIFN,Y,ORI,ORCH S Y=""
 S PSIFN=$G(^OR(100,+ORIFN,4)) I PSIFN>0 Q $$ENNG^PSJORUT2(+ORVP,PSIFN)
 S ORI=0 F  S ORI=$O(^OR(100,+ORIFN,2,ORI)) Q:ORI'>0  S ORCH=+$G(^(ORI,0)),PSIFN=$G(^OR(100,ORCH,4)) I PSIFN>0 S Y=$$ENNG^PSJORUT2(+ORVP,PSIFN) Q:Y
 Q Y
 ;
RESET(IFN,NEWOI)   ; -- Update OI if changed before renewing
 Q:'$G(IFN)  Q:'$D(^OR(100,+IFN,0))  Q:'$G(NEWOI)
 N I,ORIT S ORIT=+$O(^ORD(101.43,"ID",NEWOI_";99PSP",0)) Q:ORIT'>0
 S I=$O(^OR(100,+IFN,4.5,"ID","ORDERABLE",0))
 S:I ^OR(100,+IFN,4.5,I,1)=ORIT
 Q
