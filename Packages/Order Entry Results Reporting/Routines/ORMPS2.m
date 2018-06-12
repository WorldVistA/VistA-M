ORMPS2 ;SLC/MKB - Process Pharmacy ORM msgs cont ; 2/22/18 9:00am
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**94,116,129,134,186,190,195,215,265,243,280,363,350,462**;Dec 17, 1997;Build 6
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; External References:
 ; ^VA(200,
 ; ^DIE     ICR #2053
 ;
FINISHED() ; -- new order [SN^ORMPS] due to finishing?
 N Y,ORIG,TYPE,ORIG4 S Y=0
 S ORIG=+$P(ZRX,"|",2),TYPE=$P(ZRX,"|",4),ORIG4=$G(^OR(100,ORIG,4))
 I ORIG,TYPE="E",ORIG4?1.N1"P"!(ORIG4?1.N1"S") S ORIFN=+ORIG,Y=1
 Q Y
 ;
WPX() ; -- Compare comments in @ORMSG@(NTE) with order ORIFN
 ;     Returns 1 if different, or 0 if same
 N NTE,SPINST,Y,X S Y=0
 S NTE=+$$NTE^ORMPS3(21),SPINST=$S(NTE:$$NTXT^ORMPS3(NTE),1:"")
 S X=$$VALTXT^ORMPS3(+ORIFN,"COMMENT")
 I $TR(X," ")'=$TR(SPINST," ") S Y=1 ;comp text w/o spaces
WQ Q Y
 ;
IVX() ; -- Compare ORMSG to Inpt order ORIFN if IV, return 0 if 'diff or 'IV
 N Y,ADDFREQ,RXC,DG,OI,PSOI,XC,X,RATE,RXR,ORA,ORB,ORX,I,J,OI0,INST,VOL,STR,UNT
 S RXC=$$RXC^ORMPS,Y=0 I RXC'>0 Q Y  ;not IV of any kind
 S DG=+$P($G(^OR(100,+ORIFN,0)),U,11),DG=$P($G(^ORD(100.98,DG,0)),U,3)
 I DG'="IV RX",DG'="TPN" D  Q Y  ;not fluid
 . I $P(ZRX,"|",7)'="" S Y=1 Q
 . I $$NUMADDS^ORMPS3>1 S Y=1 Q
 . S OI=$$VALUE("ORDERABLE"),PSOI=+$P($G(^ORD(101.43,+OI,0)),U,2)
 . S XC=@ORMSG@(RXC) I PSOI'=$P(XC,U,4) S Y=1 Q
 . N X1,X2,X3 S X1=$P(XC,"|",4),X2=$P($P(XC,"|",5),U,5)
 . S X3=$$VALUE("INSTR") I (X1_X2)'=X3,(X1_" "_X2)'=X3 S Y=1 Q
IV1 S RATE=$$FIND^ORM(+RXE,24),UNT=$P($$FIND^ORM(+RXE,25),U,5)
 S:$L(UNT) RATE=RATE_" "_UNT S X=$$VALUE("RATE") I RATE'=X D  Q:Y Y
 . S:RATE["@" RATE=$P(RATE,"@") S:X["@" X=$P(X,"@") ;rate@labels
 . I RATE'=X S Y=1 Q
 I $P(ZRX,"|",7)'=$$VALUE("TYPE") S Y=1 Q Y
 S RXR=$$RXR^ORMPS
 I $P($P(RXR,"|",2),U,4)'=$$VALUE("ROUTE") S Y=1 Q Y
 S ORB=+$$PTR("ORDERABLE ITEM"),ORA=+$$PTR("ADDITIVE"),I=+RXC
 F  S XC=@ORMSG@(I) Q:$E(XC,1,3)'="RXC"  D  S I=$O(@ORMSG@(I)) Q:I'>0
 . S ORX($P(XC,"|",2),+$P(XC,U,4))=$P(XC,"|",4)_U_$P($P(XC,"|",5),U,5)_U_$P(XC,"|",6)
 . ;ORX("A",PSOI)=str^units^bag or ORX("B",PSOI)=volume^units^null
 F I="STRENGTH","UNITS","VOLUME","ADDFREQ" D  ;ORX(I,inst)=value
 . S J=0 F  S J=$O(^OR(100,+ORIFN,4.5,"ID",I,J)) Q:J'>0  D
 .. S INST=+$P($G(^OR(100,+ORIFN,4.5,J,0)),U,3)
 .. S:INST ORX(I,INST)=$G(^OR(100,+ORIFN,4.5,J,1))
 S I=0 F  S I=$O(^OR(100,+ORIFN,4.5,"ID","ORDERABLE",I)) Q:I'>0  D  Q:Y
 . S OI0=$G(^OR(100,+ORIFN,4.5,I,0)),OI=+$G(^(1))
 . S PSOI=+$P($G(^ORD(101.43,OI,0)),U,2)
 . I $P(OI0,U,2)=ORA,$G(ORX("A",PSOI)) D  Q
 .. S INST=$P(OI0,U,3),STR=+ORX("A",PSOI),UNT=$P(ORX("A",PSOI),U,2)
 .. S ADDFREQ=$P(ORX("A",PSOI),U,3)
 .. I STR'=$G(ORX("STRENGTH",INST)) S Y=1 Q
 .. I UNT'=$G(ORX("UNITS",INST)) S Y=1 Q
 .. I $$ADDFRQCV^ORMBLDP1(ADDFREQ,"I")'=$G(ORX("ADDFREQ",INST)) S Y=1 Q
 .. K ORX("A",PSOI) ;same
 . I $P(OI0,U,2)=ORB,$G(ORX("B",PSOI)) D  Q
 .. S INST=$P(OI0,U,3),VOL=+$G(ORX("B",PSOI))
 .. I VOL'=$G(ORX("VOLUME",INST)) S Y=1 Q
 .. K ORX("B",PSOI) ;same
 . S Y=1
 I $O(ORX("A",0))!$O(ORX("B",0)) S Y=1 ;leftover items - changed
 Q Y
 ;
CHANGED() ; -- Compare ORMSG to order ORIFN, return 1 if different
 N I,X,Y,X1,NTE,SIG,PI,TRXO S Y=0
 I +$P($$FIND^ORM(+RXE,3),U,4)'=+$$VALUE("DRUG") S Y=1 G CHQ ;p.363 dispense drug change check
 I $G(ORCAT)="I" D  G CHQ
 . I $$WPX S Y=1 Q  ;Special Instructions
 . S X=$$VALUE("DAYS") ;duration
 . I $G(X)'="" D  I $G(X)'=X1 S Y=1 Q
 . .S X=$$HL7IVLMT^ORMBLDP1(X)
 . .S TRXO=$$RXO^ORMPS,X1=$P($P($G(TRXO),"|",2),U,3)
 . .;S X1=$$DURATION^ORMPS3($P($P(TRXO,"|",2),U,3))
 . I $$IVX S Y=1 Q  ;IV fields
 ;S X=+$P($P(RXE,"|",3),U,4) I X'=+$$VALUE("DRUG") S Y=1 G CHQ
 I +$$FIND^ORM(+RXE,11)'=+$$VALUE("QTY") S Y=1 G CHQ ;p.363 changed to $$FIND^ORM api
 I +$$FIND^ORM(+RXE,13)'=+$$VALUE("REFILLS") S Y=1 G CHQ ;p.363 changed to $$FIND^ORM api
 ;S X=$P(RXE,"|",23) S:$E(X)="D" X=+$E(X,2,99) I X'=+$$VALUE("SUPPLY") S Y=1 G CHQ
 ;I $P(ZRX,"|",5)'=$$VALUE("PICKUP") S Y=1 G CHQ
 S NTE=$$NTE^ORMPS3(21),SIG=+$O(^OR(100,+ORIFN,4.5,"ID","SIG",0)) ;verb
 I NTE,SIG,$P($P(@ORMSG@(NTE),"|",4)," ")'=$P($G(^OR(100,+ORIFN,4.5,SIG,2,1,0))," ") S Y=1 G CHQ
 S NTE=$$NTE^ORMPS3(7),PI=+$O(^OR(100,+ORIFN,4.5,"ID","PI",0))
 I (NTE&'PI)!('NTE&PI) Q 1 ;added or deleted
 I NTE,PI D  G CHQ ;compare text
 . S PI=$$VALTXT^ORMPS3(+ORIFN,PI)_$$VALTXT^ORMPS3(+ORIFN,"COMMENT")
 . S NTE=$$NTXT^ORMPS3(NTE)
 . I $TR(NTE," ")'=$TR(PI," ") S Y=1 Q  ;comp text w/o spaces
CHQ Q Y
 ;
VALUE(ID) ; -- Return value of ID in ^OR(100,+ORIFN,4.5,"ID")
 N I,Y I '$L($G(ID)) Q ""
 S I=+$O(^OR(100,+ORIFN,4.5,"ID",ID,0))
 S Y=$G(^OR(100,+ORIFN,4.5,I,1))
 Q Y
 ;
PTR(X) ; -- Return ptr to prompt OR GTX X
 Q +$O(^ORD(101.41,"AB","OR GTX "_X,0))
 ;
RO ; -- Replacement order (finished)
 N RXO,RXC,ORDIALOG,ORDG,ORPKG,ORDA,ORX,ORSIG,ORP,ZSC,NEWSTS
 N ADMIN,IVTYPE
 K ^TMP("ORWORD",$J)
 I '$D(^VA(200,ORNP,0)) S ORERR="Missing or invalid ordering provider" Q
 I 'RXE S ORERR="Missing or invalid RXE segment" Q
 S RXO=$$RXO^ORMPS,RXC=$$RXC^ORMPS,ORIFN=+$G(ORIFN)
 I ORIFN'>0 S ORERR="Missing or invalid order number" Q
 D @($S(RXC:"IV",$G(ORCAT)="I":"UDOSE",1:"OUT")_"^ORMPS1") Q:$D(ORERR)
 ;Check keep Admin Time with order if not define in the RXE segment on
 ;verify
 I RXC,$$VALUE("TYPE")="I" S ORDIALOG($$PTR("ADMIN TIMES"),1)=$$VALUE("ADMIN")
 S ORDA=$$ACTION^ORCSAVE("XX",ORIFN,ORNP,"",ORNOW,ORWHO)
 I ORDA'>0 S ORERR="Cannot create new order action" Q
 ; DRM - 462 - 2017/7/24 - if original action flagged, carry flag forward
 I ORDA>1 D
 . N PREV
 . S PREV=$O(^OR(100,ORIFN,8,ORDA),-1)
 . I $P($G(^OR(100,ORIFN,8,PREV,3)),U,1) S ^OR(100,ORIFN,8,ORDA,3)=^OR(100,ORIFN,8,PREV,3) K ^OR(100,ORIFN,8,PREV,3)
 ; DRM - 462 ---
RO1 ; -Update sts of order to active, last action to dc/edit:
 S ORX=ORDA F  S ORX=+$O(^OR(100,ORIFN,8,ORX),-1) Q:ORX'>0  I $D(^(ORX,0)),$P(^(0),U,15)="" Q  ;ORX=last released action
 S:ORX $P(^OR(100,ORIFN,8,ORX,0),U,15)=12 ;dc/edit
 S $P(^OR(100,ORIFN,3),U,7)=ORDA,NEWSTS=$S('$G(ORSTS):0,ORSTS=$P(^(3),U,3):0,1:1) K ^(6)
 D STATUS^ORCSAVE2(ORIFN,ORSTS):NEWSTS,SETALL^ORDD100(ORIFN):'NEWSTS
 D DATES^ORCSAVE2(ORIFN,ORSTRT,ORSTOP)
 D RELEASE^ORCSAVE2(ORIFN,ORDA,ORNOW,ORWHO,ORNATR)
 ; -If unsigned edit, leave XX unsigned & mark ORX as Sig Not Req'd
 S ORSIG=$S($P($G(^OR(100,ORIFN,8,ORX,0)),U,4)'=2:1,1:0)
 D SIGSTS^ORCSAVE2(ORIFN,ORDA):ORSIG,SIGN^ORCSAVE2(ORIFN,,,5,ORX):'ORSIG
RO2 ; -Update responses, get/save new order text:
 K ^OR(100,ORIFN,4.5) D RESPONSE^ORCSAVE,ORDTEXT^ORCSAVE1(ORIFN_";"_ORDA)
 S $P(^OR(100,ORIFN,0),U,5)=ORDIALOG_";ORD(101.41,",$P(^(0),U,14)=ORPKG
 I $P(^OR(100,ORIFN,0),U,11)'=ORDG D
 . N DA,DR,DIE
 . S DA=ORIFN,DR="23////"_ORDG,DIE="^OR(100," D ^DIE
 S ^OR(100,ORIFN,4)=PKGIFN,$P(^(8,ORDA,0),U,14)=ORDA
 S ORIFN=ORIFN_";"_ORDA,ORDCNTRL="SN" ;to send NA msg back
 I $G(ORL) S ORP(1)=ORIFN_"^1" D PRINTS^ORWD1(.ORP,+ORL)
 I $G(ORCAT)="O" S ZSC=$$ZSC^ORMPS3 I ZSC,$P(ZSC,"|",2)'?2.3U S ^OR(100,+ORIFN,5)=$TR($P(ZSC,"|",2,9),"|","^") ;1 or 0 instead of [N]SC in #100
 Q
IVLIM(IVDUR) ;
 I $L(IVDUR) D
 . N DURU,DURV S DURU="",DURV=0
 . S DURU=$E(IVDUR,1),DURV=$E(IVDUR,2,$L(IVDUR))
 . I IVDUR["dose" S DURV=$E(IVDUR,6,$L(IVDUR)),IVDUR="for a total of "_+DURV_$S(+DURV=1:" doses",+DURV>1:" doses",1:" dose") Q
 . I (DURU="D")!(DURU="d") S IVDUR="for "_+DURV_$S(+DURV=1:" day",+DURV>1:" days",1:" day")
 . I (DURU="H")!(DURU="h") S IVDUR="for "_+DURV_$S(+DURV=1:" hours",+DURV>1:" hours",1:" hour")
 . I (DURU="M")!(DURU="m") S IVDUR="with total volume "_+DURV_" ml"
 . I (DURU="L")!(DURU="l") S IVDUR="with total volume "_+DURV_" L"
 Q IVDUR
UNESC(STRING) ;
 Q $$UNESC^ORHLESC(STRING)
UNESCARR(ARR) ;
 N I S I="" F  S I=$O(@ARR@(I)) Q:'$L(I)  D
 .N IND S IND=$S(ARR["(":$E(ARR,0,$L(ARR)-1)_","""_I_""")",1:ARR_"("""_I_""")")
 .N TYPE S TYPE=$D(@ARR@(I))
 .I TYPE=11!(TYPE=10) D UNESCARR(IND)
 .I TYPE=1!(TYPE=11) S @ARR@(I)=$$UNESC(@ARR@(I))
 Q
PCOMM ; -- Get Provider Comments from previous order, when changed
 N OLD,I
 S OLD=+$G(ORIFN) I OLD<1 S OLD=+$P(ZRX,"|",2) Q:OLD<1
 S I=+$O(^OR(100,OLD,4.5,"ID","COMMENT",0)) Q:I<1
 Q:'$O(^OR(100,OLD,4.5,I,2,0))  ;none
 M ^TMP("ORWORD",$J,PC,1)=^OR(100,OLD,4.5,I,2)
 S ORDIALOG(PC,1)="^TMP(""ORWORD"",$J,"_PC_",1)"
 S ORDIALOG(PC,"FORMAT")="@" ;text in Sig already
 Q
