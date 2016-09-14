ORCHECK ;SLC/MKB-Order checking calls ;05/14/14  11:46
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**7,56,70,94,141,215,243,293,280,346,357,352,345,311,269**;Dec 17, 1997;Build 85
 ;;Per VHA Directive 2004-038, this routine should not be modified.
DISPLAY ; -- DISPLAY event [called from ORCDLG,ORCACT4,ORCMED]
 ;    Expects ORVP, ORNMSP, ORTAB, [ORWARD]
 Q:$$GET^XPAR("DIV^SYS^PKG","ORK SYSTEM ENABLE/DISABLE")'="E"
 N ORX,ORY,I
 I ORNMSP="PS" D  ;reset to PSJ, PSJI, or PSO
 . I $G(ORDG) S I=$P($G(^ORD(100.98,+ORDG,0)),U,3),I=$P(I," ") Q:'$L(I)  S ORNMSP="PS"_$S(I="UD":"I",1:I) Q
 . I $G(ORXFER) S I=$P($P(^TMP("OR",$J,ORTAB,0),U,3),";",3) S:I="" I=$G(ORWARD) S ORNMSP="PS"_$S(I:"O",1:"I") ;opposite of list
 S ORX(1)="|"_ORNMSP,ORX=1
 D EN^ORKCHK(.ORY,+ORVP,.ORX,"DISPLAY") Q:'$D(ORY)
 S I=0 F  S I=$O(ORY(I)) Q:I'>0  W !,$P(ORY(I),U,4) ; display only
 Q
 ;
SELECT ; -- SELECT event
 ;    Expects ORVP, ORDAILOG(PROMPT,ORI), ORNMSP
 Q:$$GET^XPAR("DIV^SYS^PKG","ORK SYSTEM ENABLE/DISABLE")'="E"
 N ORX,ORY,OI,ORDODSG
 S OI=+$G(ORDIALOG(PROMPT,ORI)),ORDODSG=0
 S ORX=1,ORX(1)=OI_"|"_ORNMSP_"|"_$$USID^ORMBLD(OI)
 D EN^ORKCHK(.ORY,+ORVP,.ORX,"SELECT",,.ORDODSG),RETURN:$D(ORY)
 Q
 ;
ACCEPT(MODE) ; -- ACCEPT event [called from ORCDLG,ORCACT4,ORCMED]
 ;    Expects ORVP, ORDIALOG(), ORNMSP
 K ^TMP($J,"ORK XTRA TXT")
 Q:$$GET^XPAR("DIV^SYS^PKG","ORK SYSTEM ENABLE/DISABLE")'="E"
 N ORX,ORY,ORZ,OI,ORSTRT,ORI,ORIT,ORID,ORSP,ORDODSG
 S:'$L($G(MODE)) MODE="ACCEPT"
 S OI=$$PTR^ORCD("OR GTX ORDERABLE ITEM"),ORSTRT=$$START,ORX=0,ORDODSG=0
 S ORI=0 F  S ORI=$O(ORDIALOG(OI,ORI)) Q:ORI'>0  D STUF
 I $G(ORDG)=+$O(^ORD(100.98,"B","IV RX",0)) S OI=$$PTR^ORCD("OR GTX ADDITIVE"),ORI=0 F  S ORI=$O(ORDIALOG(OI,ORI)) Q:ORI'>0  D STUF
 D EN^ORKCHK(.ORY,+ORVP,.ORX,MODE,,.ORDODSG),RETURN:$D(ORY),FDBDOWN(0)
 Q
STUF S ORIT=ORDIALOG(OI,ORI),ORSP=""
 S:ORNMSP="LR" ORSP=+$G(ORDIALOG($$PTR^ORCD("OR GTX SPECIMEN"),ORI))
 S ORID=$S($E(ORNMSP,1,2)="PS":$$DRUG(ORIT,OI),1:$$USID^ORMBLD(ORIT))
 S ORZ=1,ORZ(1)=ORIT_"|"_ORNMSP_"|"_ORID
 I MODE'="ALL" D EN^ORKCHK(.ORY,+ORVP,.ORZ,"SELECT",,.ORDODSG),RETURN:$D(ORY)
 S ORX=ORX+1,ORX(ORX)=ORZ(1)_"|"_ORSTRT_"||"_ORSP K ORY,ORZ
 Q
 ;
DELAY(MODE) ; -- Delayed ACCEPT event [called from ORMEVNT]
 ;    Expects ORVP, ORIFN
 Q:$$GET^XPAR("DIV^SYS^PKG","ORK SYSTEM ENABLE/DISABLE")'="E"
 N ORX,ORY,ORCHECK,ORDODSG S:'$L($G(MODE)) MODE="NOTIF"
 S ORDODSG=0
 D BLD(+ORIFN),EN^ORKCHK(.ORY,+ORVP,.ORX,MODE,,.ORDODSG) Q:'$D(ORY)
 D RETURN I MODE="NOTIF" S ORCHECK("OK")="Notification sent to provider" D OC^ORCSAVE2 Q  ; silent
 Q
 ;
BLD(ORDER) ; -- Build new ORX(#) for ORDER
 Q:'$G(ORDER)  Q:'$D(^OR(100,ORDER,0))  ;Q:$P($G(^(3)),U,11)  ;edit/renew
 N PKG,START,ORI,ITEM,USID,SPEC,ORDG,PTR,INST,ORXSETIV
 S ORXSETIV=0
 S ORDG=$P(^OR(100,ORDER,0),U,11),PKG=$$GET1^DIQ(9.4,$P(^(0),U,14)_",",1)
 I PKG="PS",$G(ORDG) S ORI=$P($G(^ORD(100.98,+ORDG,0)),U,3),ORI=$P(ORI," "),PKG=PKG_$S(ORI="UD":"I",1:ORI)
 S START=$$START(ORDER),ORI=0
 I PKG="PSJ" D
 .N ORITEMS,IDX
 .D MAYBEIV^ORWDXR01(.ORITEMS,ORDER)
 .Q:$G(ORITEMS)=""
 .F IDX=1:1:$L(ORITEMS,U) D
 ..S ORX=+$G(ORX)+1,ORX(ORX)=$P(ORITEMS,U,IDX),$P(ORX(ORX),"|",3)=$$DRUG(+ORX(ORX),$P(ORX(ORX),"|",3),ORDER)
 ..S $P(ORX(ORX),"|",4)=START
 ..S ORXSETIV=1
 Q:ORXSETIV
 F  S ORI=$O(^OR(100,ORDER,4.5,"ID","ORDERABLE",ORI)) Q:ORI'>0  D
 . S INST=$P($G(^OR(100,ORDER,4.5,ORI,0)),U,3),PTR=$P($G(^(0)),U,2),ITEM=+$G(^(1))
 . S USID=$S(PKG?1"PS".E:$$DRUG(ITEM,PTR,ORDER),1:$$USID^ORMBLD(ITEM))
 . S SPEC=$S(PKG="LR":$$VALUE^ORCSAVE2(ORDER,"SPECIMEN",INST),1:"")
 . S ORX=+$G(ORX)+1,ORX(ORX)=ITEM_"|"_PKG_"|"_USID_"|"_START_"|"_ORDER_"|"_SPEC
 Q
 ;
REMDUPS ;
 N IFN,CDL,I,J,CDL2
 S IFN=0 F  S IFN=$O(ORCHECK(IFN)) Q:'IFN  D
 . S CDL=0 F  S CDL=$O(ORCHECK(IFN,CDL)) Q:'CDL  D
 .. S I=0 F  S I=$O(ORCHECK(IFN,CDL,I)) Q:'I  D
 ... S CDL2=0 F  S CDL2=$O(ORCHECK(IFN,CDL2)) Q:'CDL2  D
 .... S J=I F  S J=$O(ORCHECK(IFN,CDL2,J)) Q:'J  I $TR($P($G(ORCHECK(IFN,CDL,I)),U,3),";",",")=$TR($P($G(ORCHECK(IFN,CDL2,J)),U,3),";",",") D
 ..... I CDL2<=CDL K ORCHECK(IFN,CDL2,J) S ORCHECK=$G(ORCHECK)-1
 ..... I CDL2>CDL S $P(ORCHECK(IFN,CDL,I),U,7)="X"
 ... I $P(ORCHECK(IFN,CDL,I),U,7)="X" K ORCHECK(IFN,CDL,I) S ORCHECK=$G(ORCHECK)-1
 Q
 ;
START(DA) ; -- Returns start date/time
 N I,X,Y,%DT S Y=""
 I $G(DA) S X=$O(^OR(100,DA,4.5,"ID","START",0)),X=$G(^OR(100,DA,4.5,+X,1))
 E  D  ; look in ORDIALOG instead
 . S I=0 F  S I=$O(ORDIALOG(I)) Q:I'>0  Q:$P(ORDIALOG(I),U,2)="START"
 . S X=$S(I:$G(ORDIALOG(I,1)),1:"")
 D AM^ORCSAVE2:X="AM",NEXT^ORCSAVE2:X="NEXT"
 D ADMIN^ORCSAVE2("NEXT"):X="NEXTA",ADMIN^ORCSAVE2("CLOSEST"):X="CLOSEST"
 I $L(X) S %DT="TX" D ^%DT S:Y'>0 Y=""
 Q Y
 ;
DRUG(OI,PTR,IFN) ; -- Returns 6 ^-piece identifier for Dispense Drug
 N ORDD,ORNDF,Y
 I ORDG=+$O(^ORD(100.98,"B","IV RX",0)) S ORDD=$$IV G D1
 I $G(IFN) S ORDD=$O(^OR(100,IFN,4.5,"ID","DRUG",0)),ORDD=+$G(^OR(100,IFN,4.5,+ORDD,1))
 E  S ORDD=+$G(ORDIALOG($$PTR^ORCD("OR GTX DISPENSE DRUG"),1))
D1 Q:'ORDD "" S ORNDF=$$ENDCM^PSJORUTL(ORDD)
 S Y=$P(ORNDF,U,3)_"^^99NDF^"_ORDD_U_$$NAME50^ORPEAPI(ORDD)_"^99PSD"
 Q Y
 ;
IV() ; -- Get Dispense Drug for IV orderable
 N PSOI,TYPE,VOL,ORY
 S PSOI=+$P($G(^ORD(101.43,+OI,0)),U,2),VOL=""
 S TYPE=$S(PTR=$$PTR^ORCD("OR GTX ADDITIVE"):"A",1:"B")
 S:TYPE="B" VOL=$S($G(IFN):$$VALUE^ORCSAVE2(IFN,"VOLUME"),1:+$G(ORDIALOG($$PTR^ORCD("OR GTX VOLUME"),1)))
 D ENDDIV^PSJORUTL(PSOI,TYPE,VOL,.ORY)
 Q +$G(ORY)
 ;
LIST(IFN) ; -- Displays list of ORCHECK(IFN) checks
 N ORI,ORJ,ORZ,ORMAX,ORTX,ON,OFF
 S ORZ=0 F  S ORZ=$O(ORCHECK(IFN,ORZ)) Q:ORZ'>0  D
 . S:ORZ=1 ON=IOINHI,OFF=IOINORM S:ORZ'=1 (ON,OFF)="" ; use bold if High
 . S ORI=0 F  S ORI=$O(ORCHECK(IFN,ORZ,ORI)) Q:ORI'>0  D
 . . S X=$P(ORCHECK(IFN,ORZ,ORI),U,3) I $L(X)<75 W !,ON_">>>  "_X_OFF Q
 . . S ORMAX=74 K ORTX D TXT^ORCHTAB Q:'$G(ORTX)  ; wrap
 . . F ORJ=1:1:ORTX W !,ON_$S(ORJ=1:">>>  ",1:"      ")_ORTX(ORJ)_OFF
 W !
 Q
 ;
CANCEL() ; -- Returns 1 or 0: Cancel order(s)?
 N X,Y,DIR,NUM
 S NUM=+$G(ORCHECK("IFN")),DIR(0)="YA"
 S DIR("A")="Do you want to cancel "_$S(NUM>1:"any of the new orders? ",1:"the new order? ")
 S DIR("?",1)="Enter YES to cancel "_$S(NUM>1:"an",1:"the")_" order.  If you wish to override these order checks"
 S DIR("?",2)="and release "_$S(NUM>1:"these orders",1:"this order")_", enter NO; you will be prompted for a justification",DIR("?")="if there are any highlighted critical order checks."
 D ^DIR
 Q +Y
 ;
REASON() ; -- Reason for overriding order checks
 ; I '$D(^XUSEC("ORES",DUZ)),'$D(^XUSEC("ORELSE",DUZ)) Q  ??
 N X,Y,DIR,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="FA^2:80^K:X?1."" "" X",DIR("A")="REASON FOR OVERRIDE: "
 S DIR("?")="Enter a justification for overriding these order checks, up to 80 characters"
 D ^DIR I $D(DTOUT)!$D(DUOUT) S Y="^"
 Q Y
 ;
SESSION ; -- SESSION event [called from ORCSIGN]
 ;    Expects ORVP, ORES()
 K ^TMP($J,"ORK XTRA TXT")
 Q:$$GET^XPAR("DIV^SYS^PKG","ORK SYSTEM ENABLE/DISABLE")'="E"
 N ORX,ORY,ORIFN,I,X,Y,ORGLOB
 S ORGLOB=$H
 K ^TMP($J,ORGLOB)
 S ORIFN=0 F  S ORIFN=$O(ORES(ORIFN)) Q:ORIFN'>0  I +$P(ORIFN,";",2)'>1 D
 . I "^14^13^11^10^"'[(U_$P($G(^OR(100,+ORIFN,3)),U,3)_U) Q  ;unreleased
 . D BLD(+ORIFN) K ^TMP($J,"OCDATA") Q:'$$OCAPI^ORCHECK(+ORIFN,"OCDATA")
 . S ORCHECK("IFN")=+$G(ORCHECK("IFN"))+1
 . S I=0 F  S I=$O(^TMP($J,"OCDATA",I)) Q:'I  D
 . . I $G(^TMP($J,"OCDATA",I,"OC NUMBER"))=32,$$ALGASS(+ORIFN)=1 Q
 . . I $G(^TMP($J,"OCDATA",I,"OC NUMBER"))=3 Q
 . . I $G(^TMP($J,"OCDATA",I,"OC TEXT",1,0))["Drug-Drug order checks (Duplicate Therapy, Duplicate Drug, Drug Interaction) were not able to be performed." Q
 . . S ORCHECK=+$G(ORCHECK)+1,ORCHECK(+ORIFN,$S($G(^TMP($J,"OCDATA",I,"OC LEVEL")):^TMP($J,"OCDATA",I,"OC LEVEL"),1:99),ORCHECK)=$G(^TMP($J,"OCDATA",I,"OC NUMBER"))_U_$G(^TMP($J,"OCDATA",I,"OC LEVEL"))_U_$G(^TMP($J,"OCDATA",I,"OC TEXT",1,0))_U_1
 . . I $O(^TMP($J,"OCDATA",I,"OC TEXT",1)) D
 . . . S ORCHECK(+ORIFN,$S($G(^TMP($J,"OCDATA",I,"OC LEVEL")):^TMP($J,"OCDATA",I,"OC LEVEL"),1:99),ORCHECK)=$G(^TMP($J,"OCDATA",I,"OC NUMBER"))_U_$G(^TMP($J,"OCDATA",I,"OC LEVEL"))_U_"||"_ORGLOB_"&"_$G(^TMP($J,"OCDATA",I,"OC TEXT",1,0))_U_1
 . . . N ORI S ORI=0 F  S ORI=$O(^TMP($J,"OCDATA",I,"OC TEXT",ORI)) Q:'ORI  S ^TMP($J,"ORK XTRA TXT",ORGLOB,^TMP($J,"OCDATA",I,"OC TEXT",1,0),ORI)=^TMP($J,"OCDATA",I,"OC TEXT",ORI,0)
 . . I $D(^ORD(100.05,^TMP($J,"OCDATA",I,"OC INSTANCE"),16)) D
 . . . N ORMONOI S ORMONOI=$O(^TMP($J,"ORMONOGRAPH",""),-1)+1
 . . . M ^TMP($J,"ORMONOGRAPH",ORMONOI,"DATA")=^ORD(100.05,^TMP($J,"OCDATA",I,"OC INSTANCE"),16)
 . . . S ^TMP($J,"ORMONOGRAPH",ORMONOI,"INT")=^ORD(100.05,^TMP($J,"OCDATA",I,"OC INSTANCE"),17)
 . . . S ^TMP($J,"ORMONOGRAPH",ORMONOI,"OC")=$G(^TMP($J,"OCDATA",I,"OC TEXT",1,0))
 . K ^TMP($J,"OCDATA")
 I $D(ORX) D EN^ORKCHK(.ORY,+ORVP,.ORX,"SESSION"),RETURN:$D(ORY),FDBDOWN(1),REMDUPS
 Q
 ;
FDBDOWN(ORX) ; -- Checks to see if the FDB was down and if so set appropriate OC
 ; expects ORCHECK array of order checks
 ; if ORX is 1 then this is getting called from SESSION order checks
 Q:'$D(ORCHECK)
 ;look for the "not able to be performed" OCs for each type (DSG and ENH), set flag for each to 1 if found and remove them from ORCHECK
 N I S I="" F  S I=$O(ORCHECK(I)) Q:'$L(I)  D
 .N ORNEXT,ORDSG,ORENH,ORTHERE
 .S ORDSG=0,ORENH=0,ORTHERE=0,ORNEXT=1
 .N J S J=0 F  S J=$O(ORCHECK(I,J)) Q:'J  D
 ..N K S K=0 F  S K=$O(ORCHECK(I,J,K)) Q:'K  D
 ...I (K+1)>ORNEXT S ORNEXT=K+1
 ...I $G(ORCHECK(I,J,K))[$$DSDWNMSG^ORDSGCHK K ORCHECK(I,J,K) S ORDSG=1
 ...I $G(ORCHECK(I,J,K))["Drug-Drug order checks (Duplicate Therapy, Duplicate Drug, Drug Interaction) were not able to be performed." K ORCHECK(I,J,K) S ORENH=1
 ...I $G(ORCHECK(I,J,K))["These checks could not be completed for this patient:" S ORTHERE=1
 .;if DSG or ENH flag is set then add to ORY
 .I ORDSG!(ORENH) D
 ..;look to see if message already exists
 ..I ORTHERE Q
 ..N ORKGLOB S ORKGLOB=$H_","_I
 ..N ORMAIN S ORMAIN="These checks could not be completed for this patient:"
 ..S ORCHECK(I,2,ORNEXT)="25^2^||"_ORKGLOB_"&"_ORMAIN
 ..I $G(ORX) S ^TMP($J,"ORK XTRA TXT",ORKGLOB,ORMAIN,0)=ORMAIN
 ..N ORCNT S ORCNT=1
 ..I ORENH S ORCNT=ORCNT+1,^TMP($J,"ORK XTRA TXT",ORKGLOB,ORMAIN,ORCNT)="      Drug Interactions"
 ..I ORENH S ORCNT=ORCNT+1,^TMP($J,"ORK XTRA TXT",ORKGLOB,ORMAIN,ORCNT)="      Duplicate Therapy"
 ..I '$G(ORX),ORDSG S ORCNT=ORCNT+1,^TMP($J,"ORK XTRA TXT",ORKGLOB,ORMAIN,ORCNT)="      Dosing"
 Q
 ;
RETURN ; -- Return checks in ORCHECK(ORIFN,CDL,#)
 N I,IFN,CDL S I=0 F  S I=$O(ORY(I)) Q:I'>0  D
 . S IFN=+$P(ORY(I),U) S:'IFN IFN="NEW"
 . S CDL=+$P(ORY(I),U,3) S:'CDL CDL=99
 . S:'$D(ORCHECK(IFN)) ORCHECK("IFN")=+$G(ORCHECK("IFN"))+1 ; count
 . S ORCHECK=+$G(ORCHECK)+1,ORCHECK(IFN,CDL,ORCHECK)=$P(ORY(I),U,2,4)
 Q
 ;
ALGASS(ORIFN) ;see if patient from order has an allergy assessment
 N ORDFN S ORDFN=+$P(^OR(100,ORIFN,0),U,2)
 K ORARRAY D EN1^GMRAOR1(ORDFN,"ORARRAY")
 I ORARRAY'="" Q 1
 Q 0
OCAPI(IFN,ORPLACE) ;IA #4859
 ;LOOK AT ROUTINE OROCAPI1 FOR MORE DETAILED APIS
 ;API to get the order checking info for a specific order (IFN)
 ;info is stored in ^TMP($J,ORPLACE)
 ;               ^TMP($J,ORPLACE,D0,"OC LEVEL")="order check level"
 ;                                                 ,"OC NUMBER")="file 100.8 ien"
 ;                                                 ,"OC TEXT")="order check text"
 ;                                                 ,"OR REASON")="over ride reason text"
 ;                                                 ,"OR PROVIDER")="provider DUZ who entered over ride reason"
 ;                                                 ,"OR DT")="date/time over ride reason was entered"
 ; NOTE on OC LEVEL: 1 is HIGH, 2 is MODERATE, 3 is LOW
 N RET,ORN,CNT,I,ORFLAG
 S ORN=+IFN,CNT=0,ORFLAG=0
 ;if the order is not released then show ACCEPTANCE_CPRS ocs
 I "^14^13^11^10^"[(U_$P($G(^OR(100,ORN,3)),U,3)_U) D GETOC5^OROCAPI1(ORN,"ACCEPTANCE_CPRS",.RET) S ORFLAG=1
 ;if it has been signed then show SIGNATURE_CPRS ocs
 I 'ORFLAG D GETOC5^OROCAPI1(ORN,"SIGNATURE_CPRS",.RET)
 I $D(RET) S I=0 F  S I=$O(RET(ORN,"DATA",I)) Q:'I  S CNT=CNT+1 D
 .S ^TMP($J,ORPLACE,CNT,"OC NUMBER")=$P($P($G(RET(ORN,"DATA",I,1)),U),";",2)
 .S ^TMP($J,ORPLACE,CNT,"OC LEVEL")=$P($G(RET(ORN,"DATA",I,1)),U,2)
 .M ^TMP($J,ORPLACE,CNT,"OC TEXT")=RET(ORN,"DATA",I,"OC")
 .S ^TMP($J,ORPLACE,CNT,"OR REASON")=$G(RET(ORN,"DATA",I,"OR",1,0))
 .S ^TMP($J,ORPLACE,CNT,"OR PROVIDER")=$S($L(^TMP($J,ORPLACE,CNT,"OR REASON")):$P($G(RET(ORN,"DATA",I,0)),U,4),1:"")
 .S ^TMP($J,ORPLACE,CNT,"OR DT")=$S($L(^TMP($J,ORPLACE,CNT,"OR REASON")):$P($G(RET(ORN,"DATA",I,0)),U,5),1:"")
 .S ^TMP($J,ORPLACE,CNT,"OR STATUS")=$P($G(RET(ORN,"DATA",I,0)),U,2)
 .S ^TMP($J,ORPLACE,CNT,"OC INSTANCE")=I
 Q CNT
 ;
ISMONO(ORY) ;returns 1 if there is monograph data for the orderchecks being presented to the user
 S ORY=0
 Q:'$$PATCH^XPDUTL("OR*3.0*272")
 I $D(^TMP($J,"ORMONOGRAPH")) S ORY=1
 Q
GETMONOL(ORY) ;returns a list of monographs available for the orderchecks being presented to the user
 Q:'$D(^TMP($J,"ORMONOGRAPH"))
 N I S I=0
 F  S I=$O(^TMP($J,"ORMONOGRAPH",I)) Q:'I  D
 .S ORY($G(^TMP($J,"ORMONOGRAPH",I,"INT")))=I_U_$G(^TMP($J,"ORMONOGRAPH",I,"INT"))
 Q
GETMONO(ORY,ORMONO) ;return a monograph
 Q:'$D(^TMP($J,"ORMONOGRAPH",ORMONO))
 K ^TMP($J,"ORMONORPC")
 M ^TMP($J,"ORMONORPC")=^TMP($J,"ORMONOGRAPH",ORMONO,"DATA")
 K ^TMP($J,"ORMONORPC",0)
 S ORY=$NA(^TMP($J,"ORMONORPC")),@ORY=""
 Q
DELMONO(ORY) ;delete monograph data
 K ^TMP($J,"ORMONOGRAPH"),^TMP($J,"ORMONORPC")
 Q
GETXTRA(ORY,ORGL,ORRULE) ;get extra text for an order check
 ;^TMP($J,"ORK XTRA TXT") stores the text of order checks that are longer than a single line (reminder order checks)
 Q:'$D(^TMP($J,"ORK XTRA TXT",ORGL,ORRULE))
 M ORY=^TMP($J,"ORK XTRA TXT",ORGL,ORRULE)
 Q
