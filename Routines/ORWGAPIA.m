ORWGAPIA ; SLC/STAFF - Graph Application Calls ;2/22/07  11:16
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**215,251,260,243**;Dec 17, 1997;Build 242
 ;
ADMITX(DFN) ; $$(dfn) -> 1 if patient has data else 0
 Q $O(^DGPM("C",+$G(DFN),0))>0
 ;
ALLERGYX(DFN) ; $$(dfn) -> 1 if patient has data else 0
 Q $O(^GMR(120.8,"B",+$G(DFN),0))>0
 ;
ALLG(IEN) ; $$(ien) -> external display of allergies
 I IEN Q $P($G(^GMRD(120.83,IEN,0)),U) ; this is for rxn, allergy is free text
 Q IEN
 ;
CPT(NODE,ORVALUE,VALUES) ; from ORWGAPI4
 D VCPT^PXPXRM(NODE,.ORVALUE)
 S VALUES=$$DATA^ORWGAPIW(.ORVALUE) ;*****************************
 Q
 ;
DISCH(IEN) ; $$(pt movement ien) -> discharge date
 Q $P($G(^DGPM(+$P($G(^DGPM(+$G(IEN),0)),U,17),0)),U)
 ;
DOCCLASS(DOCTYPE) ; $$(doc type) -> ien of tiu doc class
 N CONSULTS
 S DOCTYPE=$E(DOCTYPE,1)
 I DOCTYPE="P" Q 3
 I DOCTYPE="D" Q 244
 I DOCTYPE="C" D CNSLCLAS^TIUSRVD(.CONSULTS) Q CONSULTS
 Q 0
 ;
EDU(NODE,ORVALUE,VALUES) ; from ORWGAPI4
 D VPEDU^PXPXRM(NODE,.ORVALUE)
 S VALUES=$$DATA^ORWGAPIW(.ORVALUE) ;*****************************
 Q
 ;
EXAM(NODE,ORVALUE,VALUES) ; from ORWGAPI4
 D VXAM^PXPXRM(NODE,.ORVALUE)
 S VALUES=$$DATA^ORWGAPIW(.ORVALUE) ;*****************************
 Q
 ;
GETTIU(ORDATA,IEN) ; from ORWGAPID
 D TGET^TIUSRVR1(.ORDATA,IEN)
 Q
 ;
HF(NODE,ORVALUE,VALUES) ; from ORWGAPI4
 D VHF^PXPXRM(NODE,.ORVALUE)
 S VALUES=$$DATA^ORWGAPIW(.ORVALUE) ;*****************************
 Q
 ;
ICD0(IEN) ; $$(ien) -> external display of IDC0
 Q $P($G(^ICD0(IEN,0)),U)_" "_$P($G(^ICD0(IEN,0)),U,4)
 ;
ICD9(IEN) ; $$(ien) -> external display of IDC9
 Q $P($G(^ICD9(IEN,0)),U)_" "_$P($G(^ICD9(IEN,0)),U,3)
 ;
ICPT(IEN,CSD) ; $$(ien) -> external display of CPT
 N X S X=$$CPT^ICPTCOD($G(IEN),$G(CSD))
 Q $P(X,U,2)_" "_$E($P(X,U,3),1,30)
 ;
IMM(NODE,ORVALUE,VALUES) ; from ORWGAPI4
 D VIMM^PXPXRM(NODE,.ORVALUE)
 S VALUES=$$DATA^ORWGAPIW(.ORVALUE) ;*****************************
 Q
 ;
ISA(USER,CLASS,ORERR) ; $$(user,user class,err) -> 1 if user in class, else 0
 Q $$ISA^USRLM(USER,CLASS,.ORERR)
 ;
LOS(DGPMIFN) ; $$(pt movement ien) -> length of stay
 N X D ^DGPMLOS
 Q +$P($G(X),U,5)
 ;
MEDICINE(ARRAY,DFN) ;
 N DATE,FILE,IEN,NAME,NUM,REF,VALUES,XREF
 K ARRAY,^TMP("MCAR",$J),^TMP("OR",$J,"MCAR")
 D FILE^ORWGAPIU(690,.REF,.XREF)
 I '$L(REF) Q
 I $E(REF,$L(REF))="," S REF=$E(REF,1,$L(REF)-1)_")"
 I $E(REF,$L(REF))="(" S REF=$P(REF,"(")
 D EN^MCARPS2(DFN)
 S NUM=0
 F  S NUM=$O(^TMP("OR",$J,"MCAR","OT",NUM)) Q:NUM<1  D
 . S VALUES=^TMP("OR",$J,"MCAR","OT",NUM)
 . S DATE=$$DATETFM^ORWGAPIW($P(VALUES,U,6))
 . S NAME=$P(VALUES,U) I '$L(NAME) Q
 . S IEN=+$O(@REF@(XREF,NAME,""))
 . I DATE,IEN S ARRAY(IEN,DATE)=NAME
 K ^TMP("MCAR",$J),^TMP("OR",$J,"MCAR")
 Q
 ;
MEDVAL(VAL) ;
 N IEN,NAME,NAMES,REF,SEQ,XREF K NAMES,VAL
 D FILE^ORWGAPIU(690,.REF,.XREF)
 I '$L(REF) Q
 I $E(REF,$L(REF))="," S REF=$E(REF,1,$L(REF)-1)_")"
 I $E(REF,$L(REF))="(" S REF=$P(REF,"(")
 S NAME=""
 F  S NAME=$O(@REF@(XREF,NAME)) Q:NAME=""  D
 . S IEN=0
 . F  S IEN=$O(@REF@(XREF,NAME,IEN)) Q:IEN<1  D
 .. S NAMES(IEN)=NAME
 S SEQ=0
 S IEN=0
 F  S IEN=$O(NAMES(IEN)) Q:IEN<1  D
 . S SEQ=SEQ+1
 . S VAL(SEQ)=690_U_IEN_U_NAMES(IEN)
 Q
 ;
MH(ORVALUE,NODE,VALUES) ; from ORWGAPI4
 D ENDAS^YTAPI10(.ORVALUE,NODE)
 S VALUES=$$DATA^ORWGAPIW(.ORVALUE) ;*****************************
 Q
 ;
NOTEX(DFN) ; $$(dfn) -> 1 if patient has data else 0
 Q $$HASDOCMT^TIULX($G(DFN))
 ;
OITEM(DATA) ; API - get order display groups   -  from ORWGAPI
 N CNT,IEN,RESULT,TMP,ZERO
 D RETURN^ORWGAPIW(.TMP,.DATA)
 S CNT=0
 S IEN=0
 F  S IEN=$O(^ORD(100.98,IEN)) Q:IEN<1  D
 . S ZERO=$G(^ORD(100.98,IEN,0)) I '$L(ZERO) Q
 . S RESULT="100.98^"_IEN_U_$P(ZERO,U)_U_$P(ZERO,U,3)
 . D SETUP^ORWGAPIW(.DATA,RESULT,TMP,.CNT)
 Q
 ;
POV(NODE,ORVALUE,VALUES) ; from ORWGAPI4
 D VPOV^PXPXRM(NODE,.ORVALUE)
 S VALUES=$$DATA^ORWGAPIW(.ORVALUE) ;*****************************
 Q
 ;
PROB(GMPLLEX,GMPLSTAT,GMPLICD,GMPLODAT,GMPLXDAT,NODE) ; from ORWGAPI4
 N GMPLPNAM,GMPLDLM,GMPLTXT,GMPLCOND,GMPLPRV,GMPLPRIO
 D CALL2^GMPLUTL3(NODE)
 Q
 ;
PTF(NODE,ORVALUE,VALUES) ; from ORWGAPI3, ORWGAPI4
 D PTF^DGPTPXRM(NODE,.ORVALUE)
 S VALUES=$$DATA^ORWGAPIW(.ORVALUE) ;*****************************
 Q
 ;
RAD(NODE,ORVALUE,VALUES) ; from ORWGAPI3
 D EN1^RAPXRM(NODE,.ORVALUE)
 S VALUES=$$DATA^ORWGAPIW(.ORVALUE) ;*****************************
 Q
 ;
SKIN(NODE,ORVALUE,VALUES) ; from ORWGAPI4
 D VSKIN^PXPXRM(NODE,.ORVALUE)
 S VALUES=$$DATA^ORWGAPIW(.ORVALUE) ;*****************************
 Q
 ;
SURG(ORSURG,DFN,VALUES) ; from ORWGAPI2, ORWGAPI4
 D GET^SROGTSR(.ORSURG,DFN)
 S VALUES=$$DATA^ORWGAPIW(.ORSURG) ;*****************************
 Q
 ;
SURGX(DFN) ; $$(dfn) -> 1 if patient has data else 0
 Q $O(^SRF("B",+$G(DFN),0))>0
 ;
TAX(IEN) ; $$(ien) -> external display of reminder taxonomy
 Q $P($G(^PXD(811.2,+$G(IEN),0)),U)
 ;
TITLE(DOCTYPE) ; $$(document type) -> parent ien^parent^parent abbrev
 N IEN,RESULTS K RESULTS
 S DOCTYPE=+$G(^TIU(8925,+$G(DOCTYPE),0))
 S IEN=+$$DOCCLASS^TIULC1(DOCTYPE) I 'IEN Q ""
 D GETDATA^ORWGAPIX(.RESULTS,8925.1,".01;.02",IEN)
 I '$L($G(RESULTS(.01))) Q ""
 Q IEN_U_"note - "_RESULTS(.01)_U_$G(RESULTS(.02))
 ;
TIU(ORVALUE,DOCIEN,ONE,DFN,OLDEST,NEWEST) ; from ORWGAPI1, ORWGAPI3
 D CONTEXT^TIUSRVLO(.ORVALUE,DOCIEN,ONE,DFN,$G(OLDEST),$G(NEWEST))
 Q
 ;
TIUTITLE(DATA) ; API - get tiu document titles   - from ORWGAPI
 N CNT,IEN,RESULT,RESULTS,TMP K ^TMP("TIUTLS",$J)
 D RETURN^ORWGAPIW(.TMP,.DATA)
 S CNT=0
 D TITLIENS^TIULX
 S IEN=0
 F  S IEN=$O(^TMP("TIUTLS",$J,IEN)) Q:IEN<1  D
 . K RESULTS
 . D GETDATA^ORWGAPIX(.RESULTS,8925.1,".01;.02",IEN)
 . I '$L($G(RESULTS(.01))) Q
 . S RESULT="8925.1^"_IEN_U_RESULTS(.01)_U_$G(RESULTS(.02))
 . D SETUP^ORWGAPIW(.DATA,RESULT,TMP,.CNT)
 K ^TMP("TIUTLS",$J)
 Q
 ;
VISITX(DFN) ; $$(dfn) -> 1 if patient has data else 0
 Q $O(^AUPNVSIT("AET",+$G(DFN),0))>0
 ;
VITAL(ORVALUE,NODE,VALUES) ; from ORWGAPI4
 D EN^GMVPXRM(.ORVALUE,NODE)
 S VALUES=$$DATA^ORWGAPIW(.ORVALUE) ;*****************************
 Q
 ;
