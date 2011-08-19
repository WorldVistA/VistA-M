ORMBLDVB ;SLC/MKB - Build outgoing Blood Bank ORM msgs ;2/11/08  11:04
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**212,309**;Dec 17, 1997;Build 26
 ;
 ; Use of $$GETICN^MPIF001 supported by DBIA #2701
 ;
HL7DATE(DATE) ; -- FM -> HL7 format
 Q $$FMTHL7^XLFDT(DATE)
 ;
NW(ORIFN) ; -- Send new VBECS orders [from ORCSEND2]
 ;    Uses ORNOW if defined
 N HLA,HL,OR0,OR3,ORR,ORDT,ORVAL,ORI,OROK,HLMTIEN
 S OR0=$G(^OR(100,ORIFN,0)),OR3=$G(^(3))
 D INIT^HLFNC2("OR OMG SERVER",.HL),GETVALS(ORIFN)
 S ORDT=$S($G(ORNOW):ORNOW,1:+$E($$NOW^XLFDT,1,12))
 S ORR=$G(ORVAL("REASON")),ORDT=$$HL7DATE(ORDT)
 ;S ORMSH="MSH|^~\&|ORDER ENTRY|"_$G(DUZ(2))_"|VBECS|"_$G(DUZ(2))_"|"_ORDT_"||OMG^O19||P|2.4||||AL" ;for testing
 S HLA("HLS",1)=$$PID(+$P(OR0,U,2)),HLA("HLS",2)=$$PV1
 S HLA("HLS",3)=$$ORC("NW","",ORR),HLA("HLS",4)=$$OBR(""),ORI=4
 S:$L($G(ORVAL("COMMENT"))) HLA("HLS",5)=$$NTE,ORI=5
 S ORI=ORI+1,HLA("HLS",ORI)=$$DG1(+$P(OR0,U,2))
 ;W ! ZW HLA D STATUS^ORCSAVE2(ORIFN,5) ;for testing 
 D DIRECT^HLMA("OR OMG SERVER","LM",1,.OROK)
 I $P(OROK,U,2) D SNDERR($P(OROK,U,3)),GENERATE^HLMA("OR OMG SERVER","LM",1,.OROK) Q  ;queue
 ; S ^OR(100,ORIFN,8,1,1)=$P(OROK,U,3),$P(^(0),U,15)=13 Q
 I HLMTIEN D ACK^ORMVBEC(+ORIFN_";1") ;successful, process ACK message
 Q
 ;
GETVALS(IFN) ; -- Return ORVAL(ID)=value for child order IFN
 N ID,ITM S ID="" K ORVAL
 F  S ID=$O(^OR(100,IFN,4.5,"ID",ID)) Q:ID=""  S ITM=$O(^(ID,0)),ORVAL(ID)=$G(^OR(100,IFN,4.5,ITM,1))
 Q
 ;
RESULTS(ORDER) ; -- Send PR messages with Lab results [from EN]
 ;    where ORDER = parent#
 N ORP,ORI,ORTST,ORTMP,ORTDT,ORX,OROK,HLA
 S ORDER=+$G(ORDER),OR0=$G(^OR(100,ORDER,0)),ORI=0
 F  S ORI=$O(^OR(100,ORDER,4.5,"ID","RESULTS",ORI)) Q:ORI<1  D
 . S ORX=$G(^OR(100,ORDER,4.5,ORI,1)),ORTDT=$P(ORX,U,7)
 . Q:'ORX  ;no data or error
 . S ORTST=+ORX_U_$P($G(^LAB(60,+ORX,0)),U) K HLA,OROK
 . S HLA("HLS",1)=$$PID(+$P(OR0,U,2)),HLA("HLS",2)=$$PV1
 . S HLA("HLS",3)="ORC|PR|||"_ORDER_"^OR"
 . S HLA("HLS",4)="OBR||"_$P(ORX,U,17)_"^LRCH||"_ORTST_"^99LRT"
 . S HLA("HLS",5)="OBX|1||"_ORTST_"^99LRT||"_$P(ORX,U,2)_"|"_$P(ORX,U,4)_"|"_$P(ORX,U,5)_"|"_$P(ORX,U,3)_"|||"_$P(ORX,U,6)_"|||"_$$HL7DATE(ORTDT)
 . ;W ! ZW HLA ;for testing
 . D DIRECT^HLMA("OR OMG SERVER","LM",1,.OROK) ;GENERATE
 . I $P(OROK,U,2) D SNDERR($P(OROK,U,3)),GENERATE^HLMA("OR OMG SERVER","LM",1,.OROK) Q  ;queue
 . 
 Q
 ;
CA(ORDER,REASON) ; -- Cancel VBEC orders (ORDER=child)
 ;    [from DC^ORCSEND/MSG^ORMBLD - Uses ORNOW if defined]
 N ORIFN,ORDA,ORDT,OR0,OR3,PKGIFN,HL,HLA,ORVAL,OROK,HLMTIEN
 S ORDT=$S($G(ORNOW):ORNOW,1:+$E($$NOW^XLFDT,1,12))
 S ORIFN=+$G(ORDER),ORDA=+$P($G(ORDER),";",2),ORDT=$$HL7DATE(ORDT)
 S OR0=$G(^OR(100,ORIFN,0)),OR3=$G(^(3)),PKGIFN=$G(^(4))_"^VBEC"
 S REASON=$S($G(REASON):$P($G(^ORD(100.03,+REASON,0)),U),1:"")
 D INIT^HLFNC2("OR OMG SERVER",.HL),GETVALS(ORIFN)
 ;S ORMSH="MSH|^~\&|ORDER ENTRY|"_$G(DUZ(2))_"|VBECS|"_$G(DUZ(2))_"|"_ORDT_"||OMG^O19||P|2.4||||AL" ;for now
 S HLA("HLS",1)=$$PID(+$P(OR0,U,2)),HLA("HLS",2)=$$PV1
 S HLA("HLS",3)=$$ORC("CA",PKGIFN,REASON),HLA("HLS",4)=$$OBR(PKGIFN)
 D DIRECT^HLMA("OR OMG SERVER","LM",1,.OROK) ;GENERATE^HLMA
 I $P(OROK,U,2) D  Q
 . S:ORDA ^OR(100,ORIFN,8,ORDA,1)=$P(OROK,U,3),$P(^(0),U,15)=13
 . D SNDERR($P(OROK,U,3)),GENERATE^HLMA("OR OMG SERVER","LM",1,.OROK) Q
 I HLMTIEN D ACK^ORMVBEC(ORDER) ;successful, process ACK message
 Q
 ;
SNDERR(MSG) ; -- Send Error message to VBECS Mail Group
 ; Input - MSG = Error message string
 N OREMSG,XMSUB,XMTEXT,XMDUZ,XMY,XMZ
 S OREMSG(1,0)="An Error occurred trying to send an HL7 message to VBECS."
 S OREMSG(2,0)=" "
 S OREMSG(3,0)="Error Message Text:  "_$S($L(MSG)>60:$E(MSG,1,60),1:MSG)
 S XMY("G."_$P($$GETAPP^HLCS2("VBECS"),"^"))=""
 S XMTEXT="OREMSG(",XMSUB="OERR-VBECS HL7 Failure",XMDUZ="OERR-VBECS Logical Link" D XMZ^XMA2
 S DIE=3.9,DA=XMZ,DR="1.7////P" D ^DIE
 D EN1^XMD
 Q
 ;
PID(DFN) ; -- PID segment
 N ORPT0,ORICN,NAME,DOB,Y S DFN=+$G(DFN)
 S ORPT0=$G(^DPT(DFN,0))
 S ORICN=$$GETICN^MPIF001(DFN) I +$G(ORICN)<1 S ORICN=""
 S NAME=$$HLNAME^HLFNC($P(ORPT0,U),"^~\&"),DOB=$$HL7DATE($P(ORPT0,U,3))
 S Y="PID|||"_ORICN_"^^^^NI~"_$P(ORPT0,U,9)_"^^^^SS~"_DFN_"^^^^PI||"_NAME_"||"_DOB_"|"_$P(ORPT0,U,2)
 Q Y
 ;
PV1() ; -- PV1 segment (expects OR0)
 N Y,DFN,LOC,TYPE,SPEC,RB,ATTD
 S DFN=+$P(OR0,U,2),LOC=$P(OR0,U,10),TYPE=$P(OR0,U,12),SPEC=$P(OR0,U,13)
 S LOC=$S(LOC:$P($G(^SC(+LOC,0)),U),1:""),RB=""
 S:TYPE="I" RB=$P($G(^DPT(DFN,.101)),U)
 S SPEC=$S(SPEC:"VA"_$$GET1^DIQ(45.7,SPEC_",",1,"I"),1:"") ;DBIA 1154
 S ATTD=+$G(^DPT(DFN,.1041)) S:'ATTD ATTD="" I ATTD D      ;DBIA 10035
 . N NM S NM=$P($G(^VA(200,ATTD,0)),U)
 . S ATTD=ATTD_U_$$HLNAME^HLFNC(NM,"^~\&")
 S Y="PV1||"_TYPE_"|"_LOC_$S($L(RB):U_RB,1:"")_"||||"_ATTD_"|||"_SPEC
 Q Y
 ;
ORC(CODE,FILLER,REASON) ; -- ORC segment (expects OR0, OR3, ORDT)
 N Y,USR,PROV,NM,ORI,DAD,YN,X13,PHONE
 S USR=+$P(OR0,U,6),PROV=+$P(OR0,U,4),X13=$G(^VA(200,PROV,.13))
 S PHONE=$S($L($P(X13,U,7)):$P(X13,U,7),1:$P(X13,U,8))
 F ORI="USR","PROV" S NM=$P($G(^VA(200,@ORI,0)),U),@ORI=@ORI_U_$$HLNAME^HLFNC(NM,"^~\&")
 S DAD=+$P(OR3,U,9) ;,DIV=$$DIV(+$P(OR0,U,10))
 S Y="ORC|"_CODE_"|"_ORIFN_"^OR|"_$G(FILLER)_"|"_DAD_"^OR|||||"_ORDT_"|"_USR_"||"_PROV_"||"_PHONE_"||^"_$G(REASON)_"|"_$$DIV
 S YN=$G(ORVAL("YN")),YN=$S(YN="":"",YN:"1^YES",YN=0:"0^NO",1:"U^UNKNOWN")
 S Y=Y_"|||"_YN
 Q Y
 ;
OBR(FILLER) ; -- OBR segment
 N Y,OI,MOD,TYPE,X,SPCACT,SPCUID
 S OI=$$USID(ORIFN),MOD=$G(ORVAL("MODIFIER"))
 I $L(MOD) S MOD=$S(MOD="W":"WASHED",MOD="I":"IRRADIATED",MOD="L":"LEUKO-POOR",MOD="V":"VOLUME-REDUCED",MOD="D":"DIVIDED",MOD="E":"LEUKO-POOR/IRRADIATED",1:MOD)
 S TYPE=$G(ORVAL("COLLECT")),TYPE=$$TYPE(TYPE)
 S X=$G(ORVAL("SPECSTS")),SPCACT=$S('X:"O",$L($P(X,U,3)):"A",1:"L")
 S SPCUID=$S(SPCACT="A":$P(X,U,3),1:"")
 S Y="OBR|1|"_ORIFN_"^OR|"_$G(FILLER)_"|"_OI_"^^"_MOD_"|||||||"_SPCACT_"||"_$G(ORLAB)_"||"_SPCUID_"^^"_TYPE_"||||||||||||"_$$QT
 Q Y
 ;
USID(IFN) ; -- Return USID for order IFN
 N OI,OI0,OID,OIX,Y S Y=""
 S OI=+$O(^OR(100,+$G(IFN),.1,"B",0)) I OI D
 . S OI0=$G(^ORD(101.43,OI,0)),OID=$P(OI0,U,2)
 . S OIX=$P(OI0,U,8) I OIX["&" S OIX=$P(OIX,"&")_"\T\"_$P(OIX,"&",2)
 . S Y=+OID_U_OIX_U_$P(OID,";",2)
 Q Y
 ;
NTE() ; -- NTE segment
 N Y S Y="NTE|1||"_$G(ORVAL("COMMENT"))
 Q Y
 ;
DG1(DFN) ; -- DG1 segment
 N VAIP,VAERR,Y
 S DFN=+$G(DFN) D IN5^VADPT
 S Y="DG1|1||^^^^"_$G(VAIP(9))_"^|||A"
 Q Y
 ;
QT() ; -- Build and return Quantity/Timing field
 N X,Y,%DT,X1,X4,X5,X6,X8,ORI
 S X=$G(ORVAL("QTY")),X1=$S(X:+X_$S(X["ML":"&ML",1:""),1:"")
 S (X4,X5)="" F ORI="START^4","DATETIME^5" D
 . S X=$G(ORVAL($P(ORI,U))),%DT="TX" D ^%DT Q:Y<1
 . S X=$$HL7DATE(Y),@("X"_$P(ORI,U,2))=X
 S X=$G(ORVAL("URGENCY")),X6=$P($G(^ORD(101.42,+X,0)),U,2)
 ;S X=$G(ORVAL("XFUSION")),X7=$S(X="H":"HOLD",X="I":"IMMEDIATE",1:"")
 S X8=$G(ORVAL("MISC"))
 S Y=X1_U_U_U_X4_U_X5_U_X6_U_U_X8
 Q Y
 ;
DIV() ; -- Return Institution file #4 ptr for LOC
 N X,Y S X=+$G(DUZ(2))
 S Y=$P($G(^DIC(4,X,99)),U)_U_$P($G(^DIC(4,X,0)),U)
 Q Y
 ;
ZDIV(LOC) ; -- Return Institution file #4 ptr for LOC
 N X0,Y S X0=$G(^SC(+LOC,0))
 I $P(X0,U,15) S X=$$SITE^VASITE(DT,$P(X0,U,15)),Y=$P(X,U,3)_U_$P(X,U,2)
 I '$P(X0,U,15) S X=$S($P(X0,U,4):$P(X0,U,4),1:+$G(DUZ(2))),Y=X_U_$P($G(^DIC(4,+X,0)),U) ;look up #40.8 ptr??
 Q Y
 ;
TYPE(X) ; -- Expands collection type code into text
 Q:'$L($G(X)) ""
 I X="SP" Q "SEND PATIENT"
 S X=$E(X),X=$S(X="L":"LAB",X="I":"IMMEDIATE",1:"WARD")
 Q X_" COLLECT"
