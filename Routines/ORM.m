ORM ; SLC/MKB/JDL - ORM msg router ;11/17/00  10:58
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**3,97,141,187,195**;Dec 17, 1997
EN(MSG) ; -- main entry point for OR RECEIVE where MSG contains HL7 msg
 N ORMSG,ORNMSP,ORTYPE,MSH,PID,PV1,ORC,ORVP,ORTS,ORL,ORCAT,ORAPPT
 S ORAPPT="",ORL=0
 S ORMSG=$S($L($G(MSG)):MSG,1:"MSG") ; MSG="NAME" or MSG(#)=message
 I '$O(@ORMSG@(0)) D EN^ORERR("Missing HL7 message",.ORMSG) Q
 S MSH=0 F  S MSH=$O(@ORMSG@(MSH)) Q:MSH'>0  Q:$E(@ORMSG@(MSH),1,3)="MSH"
 I 'MSH D EN^ORERR("Missing or invalid MSH segment",.ORMSG) Q
 S ORNMSP=$$NMSP($P(@ORMSG@(MSH),"|",3)),ORTYPE=$P(@ORMSG@(MSH),"|",9)
 I '$L(ORNMSP) D EN^ORERR("Missing or invalid sending application",.ORMSG) Q
 D PID I '$G(ORVP) D EN^ORERR("Missing or invalid patient ID",.ORMSG) Q
 D PV1 S ORC=PID
EN1 F  S ORC=$O(@ORMSG@(+ORC)) Q:ORC'>0  I $E(@ORMSG@(ORC),1,3)="ORC" D
 . N ORDCNTRL,ORDSTS,PKGIFN,ORIFN,ORNP,ORTN,ORERR,ORLOG,ORDUZ,ORQT,ORSTRT,ORSTOP,ORURG,ORNATR,OREASON
 . S ORC=ORC_U_@ORMSG@(ORC),ORDCNTRL=$TR($P(ORC,"|",2),"@","P")
 . I '$L(ORDCNTRL) S ORERR="Invalid control code" D ERROR Q
 . S ORIFN=$P($P(ORC,"|",3),U),PKGIFN=$P($P(ORC,"|",4),U)
 . I ORIFN,$D(^OR(100,+ORIFN,0)),$P(^(0),U,2)'=ORVP S ORERR="Patient doesn't match" D ERROR Q
 . S ORDSTS=$P(ORC,"|",6),ORQT=$P(ORC,"|",8)
 . S ORSTRT=$$FMDATE($P(ORQT,U,4)),ORSTOP=$$FMDATE($P(ORQT,U,5))
 . S ORURG=$$URGENCY($P(ORQT,U,6)),ORLOG=$$FMDATE($P(ORC,"|",10))
 . S ORDUZ=+$P(ORC,"|",11),ORNP=+$P(ORC,"|",13),OREASON=$P(ORC,"|",17)
 . S ORNATR=$S($P(OREASON,U,3)="99ORN":$P(OREASON,U),1:"")
 . S ORTN="EN^ORM"_ORNMSP D @ORTN I $D(ORERR) D ERROR Q
 . I ORDCNTRL="SN",$G(ORIFN) D MSG^ORMBLD(ORIFN,"NA")
 . I $G(DGPMT),ORDCNTRL="OD"!(ORDCNTRL="OC") D XTMP
 Q
 ;
NMSP(NAME) ; -- Returns pkg namespace
 I NAME="RADIOLOGY"!(NAME="IMAGING") Q "RA"
 I NAME="LABORATORY" Q "LR"
 I NAME="DIETETICS" Q "FH"
 I NAME="PHARMACY" Q "PS"
 I NAME="CONSULTS" Q "GMRC"
 I NAME="PROCEDURES" Q "GMRC"
 I NAME="ORDER ENTRY" Q "ORG"
 Q ""
 ;
PID ; -- Returns patient from PID segment in current msg
 ;    Sets PID, ORVP, ORTS if valid patient
 N I,DFN,SEG S I=MSH,PID=""
 F  S I=$O(@ORMSG@(I)) Q:I'>0  S SEG=$E(@ORMSG@(I),1,3) Q:SEG="ORC"  I SEG="PID" D  Q
 . S DFN=+$P(@ORMSG@(I),"|",4),PID=I
 . I $D(^DPT(DFN,0)) S ORVP=DFN_";DPT(",ORTS=$G(^DPT(DFN,.103)) Q
 . S:$L($P(@ORMSG@(I),"|",5)) ORVP=$P(@ORMSG@(I),"|",5) ; alt ID for Lab
 Q
 ;
PV1 ; -- Returns patient location in PV1 segment in current msg
 ;    Sets PV1, ORCAT, & ORL if valid location, ORAPPT: IMO appointment
 N I,X,SEG S I=PID,PV1=""
 F  S I=$O(@ORMSG@(I)) Q:I'>0  S SEG=$E(@ORMSG@(I),1,3) Q:SEG="ORC"  I SEG="PV1" D  Q
 . S X=+$P(@ORMSG@(I),"|",4),ORCAT=$P(@ORMSG@(I),"|",3),PV1=I
 . S:$D(^SC(X,0)) ORL=X_";SC("
 . S ORAPPT=$P(@ORMSG@(I),"|",45)
 . S:+$G(ORAPPT) ORAPPT=$$FMDATE($G(ORAPPT))
 Q
 ;
ORDITEM(USID) ; -- Returns pointer to Orderable Item file for USID
 N ID,OI
 S ID=$P(USID,U,4)_";"_$P(USID,U,6)
 S OI=+$O(^ORD(101.43,"ID",ID,0))
 Q OI
 ;
URGENCY(CODE) ; -- Return ptr to Order Urgency file #101.42
 S:'$L(CODE) CODE="R"
 Q $O(^ORD(101.42,"C",CODE,0))
 ;
FMDATE(Y) ; -- Convert HL7 date/time to FM format
 Q $$HL7TFM^XLFDT(Y)  ;**97
 ;
ERROR ; -- Sends a DE reply to current msg
 ; Uses ORVP, ORNMSP, ORDUZ, ORIFN, ORERR, and PKGIFN
 N ORV S ORV("XQY0")="" D EN^ORERR(ORERR,.ORMSG,.ORV)
 Q:ORTYPE="ORR"  Q:'$L($G(ORNMSP))
 N OREMSG,ORVP,ORTS S:'$G(ORDUZ) ORDUZ=DUZ D:'$G(ORVP) PID
 S OREMSG(1)=$$MSH^ORMBLD("ORR",ORNMSP),OREMSG(2)=$$PID^ORMBLD($G(ORVP))
 S OREMSG(3)="ORC|DE|"_$S($G(ORIFN):ORIFN_"^OR",1:"")_"|"_$S($L($G(PKGIFN)):PKGIFN_U_ORNMSP,1:"")_"|||||||"_ORDUZ_"||||||"_ORERR
 D MSG^XQOR("OR EVSEND "_ORNMSP,.OREMSG)
 Q
 ;
FIND(SEG,PIECE) ; -- Returns value in $P(@ORMSG@(SEG),"|",PIECE)
 N X,Y,FLDS,I,DONE
 S X=$G(@ORMSG@(SEG)),FLDS=$L(X,"|"),Y="",(I,DONE)=0
 F  D  Q:DONE
 . I PIECE<FLDS S Y=$P(X,"|",PIECE),DONE=1 Q
 . I PIECE=FLDS D  Q
 . . S Y=$P(X,"|",PIECE),I=$O(@ORMSG@(SEG,I)),DONE=1
 . . I I S Y=Y_$P($G(@ORMSG@(SEG,I)),"|")
 . S I=$O(@ORMSG@(SEG,I)) I 'I S Y="",DONE=1 Q
 . S PIECE=PIECE-(FLDS-1),X=$G(@ORMSG@(SEG,I)),FLDS=$L(X,"|")
FQ Q Y
 ;
XTMP ; -- Save package auto-dc'd order numbers in ^XTMP
 ;    Uses ORIFN, ORNMSP
 Q:'$G(ORIFN)  Q:"^1^13^"'[($P($G(^OR(100,+ORIFN,3)),U,3)_U)
 N ORNOW,ORDC S ORNOW=+$$NOW^XLFDT,ORDC="ORDC-"_$G(DGPMDA)
 I $G(^XTMP(ORDC,0)),+^(0)<ORNOW K ^XTMP(ORDC)
 I '$G(^XTMP(ORDC,0)) D
 . N ORNOW1H S ORNOW1H=$$FMADD^XLFDT(ORNOW,,1)
 . S ^XTMP(ORDC,0)=ORNOW1H_U_ORNOW_"^Orders AutoDC'd by Packages on Discharge"
 S ^XTMP(ORDC,+ORIFN)=$G(ORNMSP)
 Q
