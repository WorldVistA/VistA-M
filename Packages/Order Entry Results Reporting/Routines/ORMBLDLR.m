ORMBLDLR ; SLC/MKB - Build outgoing Lab ORM msgs ;11/17/00  11:10
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**97,190,195**;Dec 17, 1997
HL7DATE(DATE) ; -- FM -> HL7 format
 Q $$FMTHL7^XLFDT(DATE)  ;**97
 ;
PTR(NAME) ; -- Returns ptr value of prompt in Dialog file
 Q $O(^ORD(101.41,"AB",$E(NAME,1,63),0))
 ;
AP ; -- new Lab AP order
 ;    fall through to CH - no difference at this time
CH ; -- new Lab CH order
 N IP,OI,START,STOP,URG,CMMT,INST,I,J,X
 S START=$P($G(^OR(100,IFN,0)),U,8),STOP=$P($G(^(0)),U,9)
 S OI=$$PTR("OR GTX ORDERABLE ITEM"),URG=$$PTR("OR GTX LAB URGENCY")
 S CMMT=$$PTR("OR GTX WORD PROCESSING 1")
 S IP="" ;$S($D(^OR(100,<ISOLATION ORDER FOR DFN>)):1,1:0)
 S $P(ORMSG(4),"|",8)="^^^"_$$HL7DATE(START)_U_$$HL7DATE(STOP)
 S I=4,INST=0 F  S INST=$O(ORDIALOG(OI,INST)) Q:INST'>0  D
 . S X=+$G(ORDIALOG(URG,INST)),X=$P($G(^LAB(62.05,X,0)),U,4)_";"_X
 . S I=I+1,ORMSG(I)="OBR||||"_$$USID^ORMBLD(ORDIALOG(OI,INST))_"|||||||"_$$COLLTYPE_"|"_IP_"|||"_$$SPEC_"||||||||||||^^^^^"_X
 . S J=$O(^TMP("ORWORD",$J,CMMT,INST,0)) Q:'J  ; no comments for test
 . S I=I+1,ORMSG(I)="NTE|"_INST_"|P|"_^TMP("ORWORD",$J,CMMT,INST,J,0)
 . S L=0 F  S J=$O(^TMP("ORWORD",$J,CMMT,INST,J)) Q:J'>0  S L=L+1,ORMSG(I,L)=^(J,0)
 ; Add DG1 & ZCL segment(s) for Billing Aware
 D DG1^ORWDBA3($G(IFN),"I",I)
 Q
 ;
BB ; -- new Lab BB order
 N START,QUAN,WP,I,J
 S QUAN=+$G(ORDIALOG($$PTR("OR GTX QUANTITY"),1))
 S START=$P(^OR(100,IFN,0),U,8),WP=$$PTR("OR GTX WORD PROCESSING 1")
 S $P(ORMSG(4),"|",8)=QUAN_"^^^"_$$HL7DATE(START)
 S ORMSG(5)="OBR||||"_$G(ORDIALOG($$PTR("OR GTX ORDERABLE ITEM"),1))
 S I=$O(^TMP("ORWORD",$J,WP,1,0)) Q:'I
 S ORMSG(6)="NTE|1|P|"_$G(^TMP("ORWORD",$J,WP,1,I,0)),J=0
 F  S I=$O(^TMP("ORWORD",$J,WP,1,I)) Q:I'>0  S J=J+1,ORMSG(6,J)=$G(^(I,0))
 Q
 ;
COLLTYPE() ; -- Returns collection type for current INST
 N TYPE,X
 S TYPE=$G(ORDIALOG($$PTR("OR GTX COLLECTION TYPE"),INST))
 S X=$S(TYPE="LC":"L",TYPE="WC":"O",TYPE="SP":1,TYPE="I":2,1:"")
 Q X
 ;
SPEC() ; -- Returns specimen/sample string for current INST
 N SAMP,SPEC,X,X0
 S SPEC=+$G(ORDIALOG($$PTR("OR GTX SPECIMEN"),INST))
 S X0=$G(^LAB(61,SPEC,0)),X=$P(X0,U,2)_";"_$P(X0,U)_";SNM"
 S SAMP=+$G(ORDIALOG($$PTR("OR GTX COLLECTION SAMPLE"),INST))
 S X=X_";"_SAMP_";"_$P($G(^LAB(62,+SAMP,0)),U)_";99LRS^^^"_SPEC_";"_$P(X0,U)_";99LRX"
 Q X
 ;
XO ; -- Send XO message to Lab
 N OR0,DG,ORMSG,ORNEW,OI,URG,I,CNT,INST,ORDIALOG,TEST,CMMT,J,L,OROLD
 S OR0=$G(^OR(100,+IFN,0)),DG=$P($G(^ORD(100.98,+$P(OR0,U,11),0)),U,3)
 S DG="LR"_$S(DG="AP":"AP",DG="BB":"BB",1:"CH"),ORDIALOG=+$P(OR0,U,5)
 S OROLD=+$P(^OR(100,IFN,3),U,5),$P(ORMSG(4),"|",4)=$G(^OR(100,+OROLD,4))_U_DG
 S OI=$$PTR("OR GTX ORDERABLE ITEM"),URG=$$PTR("OR GTX URGENCY")
 S CMMT=$$PTR("OR GTX WORD PROCESSING 1"),CNT=3
 S I=0 F  S I=$O(^OR(100,+IFN,4.5,I)) Q:I'>0  I $P($G(^(I,0)),U,2)=OI S TEST=$G(^(1)),ORNEW(TEST)=^(0) ; new set of tests
 S I=0 F  S I=$O(^OR(100,OROLD,4.5,I)) Q:I'>0  I $P($G(^(I,0)),U,2)=OI S TEST=$G(^(1)),OROLD(TEST)=^(0) ; orig set of tests
XO1 D GETDLG1^ORCD(ORDIALOG),GETORDER^ORCD(+IFN)
 S I=0 F  S I=$O(ORNEW(I)) Q:I'>0  I '$D(OROLD(I)) D
 . S CNT=CNT+1,TEST=I,INST=$P(ORNEW(I),U,3)
 . S ORMSG(CNT)="OBR|"_(CNT-3)_"|||"_$$USID^ORMBLD(TEST)_"|||||||A||||"_$$SPEC_"||||||||||||^^^^^"_$P($G(^ORD(101.42,+$G(ORDIALOG(URG,INST)),0)),U,2)
 . S J=$O(^TMP("ORWORD",$J,CMMT,INST,0)) Q:'J  ; no comments for test
 . S CNT=CNT+1,ORMSG(CNT)="NTE|"_INST_"|L|"_^TMP("ORWORD",$J,CMMT,INST,J,0)
 . S L=0 F  S J=$O(^TMP("ORWORD",$J,CMMT,INST,J)) Q:J'>0  S L=L+1,ORMSG(CNT,L)=^(J,0)
 S I=ORDIALOG K ORDIALOG S ORDIALOG=I
 D GETDLG1^ORCD(ORDIALOG),GETORDER^ORCD(OROLD)
 S I=0 F  S I=$O(OROLD(I)) Q:I'>0  I '$D(ORNEW(I)) D
 . S CNT=CNT+1,TEST=I,INST=$P(OROLD(I),U,3)
 . S ORMSG(CNT)="OBR|"_(CNT-3)_"|||"_$$USID^ORMBLD(TEST)_"|||||||3||||"_$$SPEC_"||||||||||||^^^^^"_$P($G(^ORD(101.42,+$G(ORDIALOG(URG,INST)),0)),U,2)
 . S J=$O(^TMP("ORWORD",$J,CMMT,INST,0)) Q:'J  ; no comments for test
 . S CNT=CNT+1,ORMSG(CNT)="NTE|"_INST_"|L|"_^TMP("ORWORD",$J,CMMT,INST,J,0)
 . S L=0 F  S J=$O(^TMP("ORWORD",$J,CMMT,INST,J)) Q:J'>0  S L=L+1,ORMSG(CNT,L)=^(J,0)
 D MSG^XQOR("OR EVSEND "_DG,.ORMSG)
 Q
