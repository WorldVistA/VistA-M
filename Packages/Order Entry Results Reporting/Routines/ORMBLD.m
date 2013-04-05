ORMBLD ; SLC/MKB/JDL - Build outgoing ORM msgs ;4/12/04  12:33
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**3,33,26,45,79,97,133,168,187,190,195,215**;Dec 17, 1997
 ;
NEW(IFN,CODE) ; -- Send NW order message to pkg
 ;I $P($G(^ORD(101.42,+$$VALUE^ORCSAVE2(IFN,"URGENCY"),0)),U)="DONE" D STATUS^ORCSAVE2(IFN,2) Q  ; complete -> don't send to pkg
 N ORPKG,ORMSG,DGQUIET K ^TMP("ORWORD",$J)
 S DGQUIET=1 D  Q:'$O(ORMSG(0))  ;build msg, ORDIALOG gone when posted
 . N OR0,OR3,OR8,ORVP,ORDG,ORDIALOG,ORPARENT S:'$D(CODE) CODE="NW"
 . S OR0=$G(^OR(100,IFN,0)) Q:'$L(OR0)  S OR3=$G(^(3)),OR8=$G(^(8,1,0))
 . S ORVP=$P(OR0,U,2),ORDG=$P(OR0,U,11),ORPKG=$$NMSP^ORCD($P(OR0,U,14))
 . Q:"^GMRA^GMRC^FH^LR^PS^RA^OR^"'[(U_ORPKG_U)
 . S ORDIALOG=+$P(OR0,U,5) Q:'ORDIALOG
 . D GETDLG1^ORCD(ORDIALOG),GETORDER^ORCD(IFN)
 . S ORMSG(1)=$$MSH("ORM",ORPKG),ORMSG(2)=$$PID(ORVP)
 . S ORMSG(3)=$$PV1(ORVP,$P(OR0,U,12),+$P(OR0,U,10),"",$P(OR0,U,18))
 . S ORPARENT=$P(OR3,U,9) I ORPARENT,$G(ORDIALOG($$PTR^ORCD("OR GTX SCHEDULE"),1))="NOW"!'$O(^OR(100,+ORPARENT,4.5,"ID","CONJ",0)) S ORPARENT="" ;no parent if NOW or only child
 . S ORMSG(4)="ORC|"_CODE_"|"_+OR0_";1^OR||||||"_ORPARENT_"|"_$$HL7DATE($P(OR0,U,7))_"|"_+$P(OR0,U,6)_"||"_+$P(OR0,U,4)_"|||"_$$HL7DATE($$NOW^XLFDT)_"|"_$$NATURE($P(OR8,U,12))_"^^^"
 . D @ORPKG K ^TMP("ORWORD",$J)
 I $G(ORZTEST) M ORZTEST=ORMSG Q  ;testing only
 D MSG^XQOR("OR EVSEND "_ORPKG,.ORMSG)
 Q
 ;
MSG(IFN,CODE,REASON) ; -- Send all other order msgs
 N ORPKG,ORMSG,DGQUIET K ^TMP("ORWORD",$J)
 S DGQUIET=1 D  Q:'$O(ORMSG(0))  ; build message
 . N OR0,OR8,DG,PKGID,I,TYPE,DA,PROV,NATR,STS,OI
 . S OR0=$G(^OR(100,+IFN,0)),PKGID=$G(^(4)),STS=$P($G(^(3)),U,3)
 . S ORPKG=$$NMSP^ORCD($P(OR0,U,14))
 . I ORPKG="VBEC" D:$L($T(CA^ORMBLDVB)) CA^ORMBLDVB(IFN,$G(REASON)) Q
 . Q:"^GMRA^GMRC^FH^LR^PS^RA^OR^"'[(U_ORPKG_U)
 . I ORPKG="LR" S ORPKG="LRCH" S:CODE="DC" CODE="CA" ;DC if VBEC child
 . S DA=+$P(IFN,";",2),OR8=$G(^OR(100,+IFN,8,DA,0))
 . S PROV=$P(OR8,U,3),NATR=$P(OR8,U,12) S:'PROV PROV=$G(ORNP)
 . S TYPE=$S(CODE="NA"!(CODE="DE"):"ORR",1:"ORM")
 . S ORMSG(1)=$$MSH(TYPE,ORPKG),ORMSG(2)=$$PID($P(OR0,U,2)),I=2
 . I ORPKG="PS"!(ORPKG="FH"&($P(OR0,U,12)="O")) S I=I+1,ORMSG(I)=$$PV1($P(OR0,U,2),$P(OR0,U,12),+$P(OR0,U,10))
 . S I=I+1,ORMSG(I)="ORC|"_CODE_"|"_IFN_"^OR|"_PKGID_U_ORPKG_"||||||"_$S($G(DGPMA):$$HL7DATE($P(DGPMA,U)),1:"")_"|"_DUZ_"||"_PROV_"|||"_$$HL7DATE($$NOW^XLFDT)_"|"_$$REASON(+$G(REASON),NATR)
 . I ORPKG="FH",CODE="SS" S $P(ORMSG(I),"|",6)=$S(STS=8:"SC",STS=6:"IP",1:"")
 . I $E(ORPKG,1,2)="LR" S OI=+$O(^OR(100,+IFN,.1,0)),OI=+$G(^(OI,0)) S:OI I=I+1,ORMSG(I)="OBR||||"_$$USID(OI)
 . I $P(^ORD(100.98,$P(OR0,U,11),0),U)="NON-VA MEDICATIONS" D
 . . I (CODE="CA")!(CODE="DC") S I=I+1,ORMSG(I)="ZRN|N"
 . K ^TMP("ORWORD",$J)
 D MSG^XQOR("OR EVSEND "_ORPKG,.ORMSG)
 Q
 ;
BHS(PAT) ; -- Send batch header segment/message to Lab
 N ORMSG S ORMSG(1)="BHS|^~\&|ORDER ENTRY|"_$G(DUZ(2))_"|LABORATORY|"_$G(DUZ(2))_"|"_$$HL7DATE($$NOW^XLFDT)
 S ORMSG(2)=$$PID($G(PAT))
 D MSG^XQOR("OR EVSEND LRCH",.ORMSG)
 Q
 ;
BTS(PAT) ; -- Send batch trailer segment/message to Lab
 N ORMSG S ORMSG(1)="BTS",ORMSG(2)=$$PID($G(PAT))
 D MSG^XQOR("OR EVSEND LRCH",.ORMSG)
 Q
 ;
MSH(TYPE,TO) ; -- MSH segment
 N MSH
 S MSH="MSH|^~\&|ORDER ENTRY|"_$G(DUZ(2))_"|"_$$NAME(TO)_"|"_$G(DUZ(2))_"|"_$$HL7DATE($$NOW^XLFDT)_"||"_TYPE
 Q MSH
 ;
NAME(NMSP) ; -- Returns name of pkg NMSP
 I NMSP="GMRA" Q "ALLERGIES"
 I NMSP="GMRC" Q "CONSULTS"
 I NMSP="FH" Q "DIETETICS"
 I NMSP?1"LR".E Q "LABORATORY"
 I NMSP="PS" Q "PHARMACY"
 I NMSP="RA" Q "RADIOLOGY"
 I NMSP="OR" Q "ORDER ENTRY"
 Q ""
 ;
PID(DFN) ; -- PID segment
 N PID,PTR,ROOT
 S PTR=+$P(DFN,";"),ROOT=$P(DFN,";",2),PID="PID|||"
 I ROOT="DPT(" S PID=PID_PTR_"||"_$P($G(^DPT(PTR,0)),U)
 E  S PID=PID_"|"_DFN_"|"_$S($L(ROOT):$P($G(@(U_ROOT_PTR_",0)")),U),1:"")
 Q PID
 ;
PV1(OBJ,TYPE,LOC,VISIT,APPTDT) ; -- PV1 segment
 N PV1,RB,PACH S RB=""
 S:$G(APPTDT) APPTDT=$$FMTHL7^XLFDT(APPTDT)
 I TYPE="I",+OBJ,$P(OBJ,";",2)="DPT(" S RB=$P($G(^DPT(+OBJ,.101)),U)
 S PACH=$$PATCH^XPDUTL("PSJ*5.0*111")
 S:PACH PV1="PV1||"_TYPE_"|"_LOC_$S($L(RB):U_RB,1:"")_"||||||||||||||||"_$G(VISIT)_"|||||||||||||||||||||||||"_$G(APPTDT)
 S:'PACH PV1="PV1||"_TYPE_"|"_LOC_$S($L(RB):U_RB,1:"")_"||||||||||||||||"_$G(VISIT)
 Q PV1
 ;
HL7DATE(DATE) ; -- FM -> HL7 format
 Q $$FMTHL7^XLFDT(DATE)  ;**97
 ;
USID(OI) ; -- Returns Univ Serv ID for Orderable Item
 N OITEM,NATL,LOCAL S OITEM=$G(^ORD(101.43,+OI,0))
 S NATL=$P(OITEM,U,3)_U_U_$P(OITEM,U,4)
 S LOCAL=$P($P(OITEM,U,2),";")_U_$P(OITEM,U)_U_$P($P(OITEM,U,2),";",2)
 Q NATL_U_LOCAL
 ;
NATURE(X) ; -- Returns 3 ^-piece identifier for nature X
 N ORN,Y S ORN=$G(^ORD(100.02,+$G(X),0))
 S Y=$P(ORN,U,2)_U_$P(ORN,U)_"^99ORN"
 Q Y
 ;
REASON(X,N) ; -- Returns 6 ^-piece format of reason X
 ;    N ^ NATURE ^ 99ORN ^ # ^ Reason ^ 99ORR
 N Y,ORR S ORR=$G(^ORD(100.03,+$G(X),0))
 S:'$G(N) N=+$P(ORR,U,7) S Y=$$NATURE(N)
 S:$G(X) Y=Y_U_$S(ORPKG'="RA":+X,1:"")_U_$P(ORR,U)_"^99ORR"
 Q Y
 ;
IP() ; -- Returns ORIFN^Type if pt has active isolation order (or 0 if not)
 N TYPE,START,ORIFN,Y
 S TYPE=$O(^ORD(100.98,"B","PREC",0)),START=$$NOW^XLFDT,Y=0
 F  S START=$O(^OR(100,"AW",ORVP,TYPE,START),-1) Q:START'>0  S ORIFN=$O(^(START,0)) I $P($G(^OR(100,ORIFN,3)),U,3)=6 S Y=ORIFN Q
 I Y S TYPE=$$VALUE^ORCSAVE2(ORIFN,"ISOLATION"),Y=Y_U_$$GET1^DIQ(119.4,+TYPE_",",.01)
 Q Y
 ;
OR ; -- new Generic order
 I ORDG=$O(^ORD(100.98,"B","M.A.S.",0)) D ADT^ORMBLDOR Q
 D EN^ORMBLDOR
 Q
 ;
GMRA ; -- new Allergy order
 Q:$$PATCH^XPDUTL("OR*3.0*216")  ;195 quit if patch 216 is in
 D:$L($T(ALG^ORMBLDAL)) ALG^ORMBLDAL
 Q
 ;
GMRC ; -- new Consult order
 D CSLT^ORMBLDGM
 Q
 ;
FH ; -- new Diet order
 N ORPARAM D EN^FHWOR8(+ORVP,.ORPARAM) ; set parameters
 S:'$L($G(ORPARAM(3))) ORPARAM(3)="T"
 I ORDG=$O(^ORD(100.98,"B","PRECAUTIONS",0)) D IP^ORMBLDFH Q
 I ORDG=$O(^ORD(100.98,"B","EARLY/LATE TRAYS",0)) D TRAY^ORMBLDFH Q
 I ORDG=$O(^ORD(100.98,"B","TUBEFEEDINGS",0)) D TF^ORMBLDFH Q
 I ORDG=$O(^ORD(100.98,"B","DIET ADDITIONAL ORDERS",0)) D ADDN^ORMBLDFH Q
 D DIET^ORMBLDFH
 Q
 ;
LR ; -- new Lab order
 I CODE="XO" D XO^ORMBLDLR Q  ; change
 D CH^ORMBLDLR S ORPKG="LRCH" Q  ;no difference by subscript at this time
 N SUB S SUB=$P($G(^ORD(100.98,ORDG,0)),U,3)
 S:(SUB="SP")!(SUB="EM")!(SUB="AU")!(SUB="CY") SUB="AP"
 S:(SUB="LAB")!(SUB="MI")!(SUB="HEMA") SUB="CH"
 D @(SUB_"^ORMBLDLR") S ORPKG=ORPKG_SUB
 Q
 ;
PS ; -- new Pharmacy order
 ;I ORDG=$O(^ORD(100.98,"B","OUTPATIENT MEDICATIONS",0)) D OUT^ORMBLDPS Q
 ;D UD^ORMBLDPS
 N IVDLG S IVDLG=+$P(OR0,U,5) ;JD
 N PKG S PKG=$P(OR0,U,14),PKG=$$GET1^DIQ(9.4,+PKG_",",1)
 I +$$VALUE^ORCSAVE2(IFN,"URGENCY")=99,$P(OR3,U,11)'="B" D  Q  ;only send DONE orders from BCMA
 . D STATUS^ORCSAVE2(IFN,2) K ORMSG
 . I $P(OR3,U,11)=1,$P($G(^OR(100,+$P(OR3,U,5),3)),U,3)=5 D MSG(+$P(OR3,U,5),"CA") ;cancel original instead
 I ORDG=$O(^ORD(100.98,"B","IV RX",0))!(ORDG=$O(^ORD(100.98,"B","TPN",0)))!(IVDLG=$O(^ORD(101.41,"B","PSJI OR PAT FLUID OE",0))) D IV^ORMBLDPS Q
 D @($S(PKG="PSIV":"IV",PKG="PSO":"OUT",PKG="PSH":"NVA",1:"UD")_"^ORMBLDPS")
 Q
 ;
RA ; -- new Radiology order
 D EN^ORMBLDRA
 Q
 ;
TEST(ORIFN) ; -- Build/display HL7 msgs w/o sending
 K ORZTEST S ORZTEST=1 D NEW(ORIFN) ; leaves msg in ORZTEST() on exit
 Q
