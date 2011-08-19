ORCFLAG ; SLC/MKB - Flag orders ;12/26/2006
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**141,243**;Dec 17, 1997;Build 242
 ;
EN1(ORIFN) ; -- standalone entry point to un/flag order ORIFN
 N ORLK,ORERR,VA,VADM,VAERR,DFN,ORVP,ORPNM,ORSSN,ORAGE,ORACTN,ORPS
 Q:'$G(ORIFN)  S:'$P(ORIFN,";",2) ORIFN=+ORIFN_";1"
 S ORVP=$P($G(^OR(100,+ORIFN,0)),U,2),DFN=+ORVP I 'ORVP!'$D(^(8,+$P(ORIFN,";",2),0)) W !,"Missing or invalid order!" H 1 Q
 D DEM^VADPT S ORPNM=VADM(1),ORSSN=$P(VADM(2),U,2),ORAGE=VADM(4)
 S ORACTN=$S($G(^OR(100,+ORIFN,8,+$P(ORIFN,";",2),3)):"UF",1:"FL")
 I '$$VALID^ORCACT0(ORIFN,ORACTN,.ORERR) W !,ORERR H 1 Q
 S ORLK=$$LOCK1^ORX2(+ORIFN) I 'ORLK W !,$P(ORLK,U,2) H 1 Q
 S ORACTN=$S(ORACTN="UF":"UN",1:"EN"),ORPS=1
 D @ORACTN,UNLK1^ORX2(+ORIFN)
 Q
 ;
EN ; -- Flag order ORIFN
 N OREASON,DA,ORB,ORNP,ORNOW S ORNOW=+$E($$NOW^XLFDT,1,12)
 S DA=$P(ORIFN,";",2) I 'DA W !,"Unable to flag!" H 1 Q
 S OREASON=$$REASON Q:OREASON="^"
 S ORNP=+$P($G(^OR(100,+ORIFN,8,DA,0)),U,3),ORNP=$$PROV(ORNP) Q:ORNP="^"
 D BULLETIN ;use ORNP?
 K ^OR(100,+ORIFN,8,DA,3) S ^(3)="1^"_$G(XMZ)_U_ORNOW_U_DUZ_U_OREASON_"^^^^"_ORNP
 S $P(^OR(100,+ORIFN,3),U)=$$NOW^XLFDT,OREBUILD=1 ; Last Activity
 S ORB=+ORVP_U_+ORIFN_U_ORNP_"^1" D EN^OCXOERR(ORB) ; notification
 W !?10,"... order flagged." H 1 D KILL^XM,MSG(ORIFN)
 Q
 ;
UN ; -- Unflag order ORIFN
 N OREASON,DA,ORB,ORNP,ORNOW S ORNOW=+$E($$NOW^XLFDT,1,12)
 S DA=$P(ORIFN,";",2) I 'DA W !,"Unable to unflag order!" H 1 Q
 D SHOWFLAG S OREASON=$$COMMENT Q:OREASON="^"
 S $P(^OR(100,+ORIFN,8,DA,3),U)=0,$P(^(3),U,6,8)=ORNOW_U_DUZ_U_OREASON
 S ORNP=+$P(^OR(100,+ORIFN,8,DA,3),U,9) S:'ORNP ORNP=+$P($G(^(0)),U,3)
 S ORB=+ORVP_U_+ORIFN_U_ORNP_"^0" D EN^OCXOERR(ORB) ; notification
 S $P(^OR(100,+ORIFN,3),U)=$$NOW^XLFDT,OREBUILD=1 ; Last Activity
 W !?10,"... order unflagged." H 1 D MSG(ORIFN)
 Q
 ;
SHOWFLAG ; -- Display [last] flag for order ORIFN
 N FLAG
 S FLAG=$G(^OR(100,+ORIFN,8,DA,3))
 W !," FLAGGED: "_$$LTIM($P(FLAG,U,3))_" by "_$P($G(^VA(200,+$P(FLAG,U,4),0)),U)
 W !?10,$P(FLAG,U,5) ; reason
 Q
 ;
REASON() ; -- Reason for flag
 N X,Y,DIR
 S DIR(0)="FA^1:80",DIR("A")="REASON FOR FLAG: " ; ck E3R
 S DIR("?")="A reason must be entered to flag this order."
 D ^DIR
 Q Y
 ;
COMMENT() ; -- Comments on unflag
 N X,Y,DIR
 S DIR(0)="FAO^1:80",DIR("A")="COMMENTS: "
 S DIR("?")="A comment may be entered to clarify this order."
 D ^DIR S:$D(DTOUT) Y="^"
 Q Y
 ;
PROV(ORDR) ; -- Get provider to alert
 N X,Y,DIC
 S DIC=200,DIC(0)="AEQM",DIC("A")="Send alert to: "
 I $G(ORDR) S ORDR=$P($G(^VA(200,+ORDR,0)),U) S:$L(ORDR) DIC("B")=ORDR
 S DIC("S")="N ORT S ORT=$P(^(0),U,11) I 'ORT!(ORT>DT)"
 D ^DIC S:Y>0 Y=+Y I Y'>0 S Y="^"
 Q Y
 ;
BULLETIN ; -- Send bulletin re: flag
 N OR0,OR3,ORDTXT,XMB,XMY,XMDUZ,ORENT,BULL,ORSRV,ORUSR
 S OR0=$G(^OR(100,+ORIFN,0)),OR3=$G(^(3)) ;ORUSR=+$P(OR0,U,4)
 S ORUSR=+$G(ORNP),ORSRV=+$P($G(^VA(200,ORUSR,5)),U)
 S ORENT="USR.`"_ORUSR_"^SRV.`"_ORSRV_"^DIV^SYS^PKG"
 S BULL=$$GET^XPAR(ORENT,"ORB FLAGGED ORDERS BULLETIN",1,"Q")
 Q:$G(BULL)'="Y"   ;quit if parameter value is not 'Y'es
 ;
 W !,"Sending bulletin to "_$P($G(^VA(200,ORUSR,0)),U)_"..."
 S XMB="OR FLAGGED ORDER",XMDUZ=DUZ,XMY(ORUSR)=""
 S XMB(1)=ORPNM,XMB(2)=ORSSN,XMB(3)=ORAGE,XMB(4)=$$LTIM($P(OR0,U,7))
 D TEXT^ORQ12(.ORDTXT,+ORIFN,80)
 S XMB(5)=$G(ORDTXT(1)),XMB(6)=$G(ORDTXT(2)),XMB(7)=$G(ORDTXT(3))
 S XMB(8)=$$LTIM($P(OR0,U,8)),XMB(9)=$$LTIM($P(OR0,U,9)),XMB(10)=OREASON
 S XMB(11)=$P($G(^ORD(100.01,+$P(OR3,U,3),0)),U)
 D EN^XMB
 Q
 ;
LTIM(X) ; -- format FM date/time into MM/DD HH:MM
 N Y S Y=""
 S:X Y=$E(X,4,5)_"/"_$E(X,6,7)
 S:X["." Y=Y_" "_$E(X_"0",9,10)_":"_$E(X_"000",11,12)
 Q Y
 ;
MSG(ORDER)      ; -- Sends HL7 message to Pharmacy when order is un/flagged
 Q:'$L($T(OBR^PSJHL4))  ;needs PSJ*5*85
 Q:'$G(ORDER)  Q:'$D(^OR(100,+ORDER,0))  Q:'$P(ORDER,";",2)
 N OR0,OR3,ORMSG,ORVP,ORX,ORFLAG
 S OR0=$G(^OR(100,+ORDER,0)),OR3=$G(^(8,+$P(ORDER,";",2),3))
 Q:"^PSJ^PSIV^PSO^"'[(U_$$GET1^DIQ(9.4,+$P(OR0,U,14)_",",1)_U)  ;Inpt or IV
 S ORMSG(1)=$$MSH^ORMBLD("ORU","PS")
 S ORVP=$P(OR0,U,2),ORMSG(2)=$$PID^ORMBLD(ORVP)
 S ORMSG(3)=$$PV1^ORMBLD(ORVP,$P(OR0,U,12),+$P(OR0,U,10))
 S ORX=$S(OR3:$P(OR3,U,3,5),1:$P(OR3,U,6,8))
 S ORFLAG=$S(OR3:"FL",1:"UF")_"|||"_$$HL7DATE^ORMBLD($P(ORX,U))_"||||||"_$P(ORX,U,3)_"|||"_+$P(ORX,U,2)
 S:$G(ORPS) ORFLAG=ORFLAG_"||||||||PHR" ;action taken by pharmacist
 S ORMSG(4)="OBR|1|"_ORDER_"^OR|"_$G(^OR(100,+ORDER,4))_"^PS|"_ORFLAG
 D MSG^XQOR("OR EVSEND PS",.ORMSG)
 Q
