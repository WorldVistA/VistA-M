ORMHLREC ; SLC/BNT - ORM HL7 message receiver ;2/11/08  11:05
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**212**;Dec 17, 1997;Build 24
 ;
EN ; -- main entry point for HL7 v1.6 message processing.
 N ORMSG,ORNMSP,ORTYPE,ORACK,ORERR,ORVP,ORTS,ORL,ORCAT,I,J,SNDACK,SG
 N ORDCNTRL,ORDSTS,PKGIFN,ORIFN,ORNP,ORTN,ORLOG,ORDUZ,ORQT,ORSTRT,ORSTOP
 N ORURG,ORNATR,OREASON,ORI,ORSEG,ORSEGID
 ;
 ; Is this an Acknowledgement message?  Additional ACK message types
 ; should be included in this $S statement where appropriate to set
 ; ORACK=1
 S ORACK=$S(HL("MTN")="ORG":1,HL("MTN")="ACK":1,1:0)
 ;
 F I=1:1 X HLNEXT Q:HLQUIT'>0  D
 . S ORMSG(I)=HLNODE,J=0
 . F  S J=$O(HLNODE(J)) Q:'J  S ORMSG(I,J)=HLNODE(J)
 ;
 ;I $G(VBTEST) S X=0 F  S X=$O(^XTMP("VBECS-ORM",$J,X)) Q:X=""  S ORMSG(X)=^(X)
 S ORNMSP=$$NMSP(HL("SAN")),ORTYPE=HL("MTN")
 I '$L(ORNMSP) S ORERR="Missing or invalid sending application" D ERROR Q
 S ORTN="EN^ORM"_ORNMSP
 ;
 S ORI=0 F  S ORI=$O(ORMSG(ORI)) Q:'ORI  D  Q:$D(ORERR)
 . S ORSEG=ORMSG(ORI),ORSEGID=$P(ORMSG(ORI),HL("FS"))
 . I $T(@ORSEGID)]"" D @ORSEGID
 Q:$D(ORERR)
 ;
 I $L($G(ORDCNTRL)) D @ORTN I $D(ORERR) D ERROR Q
 I 'ORACK D GENACK
 Q
 ;
ORC S ORDCNTRL=$TR($P(ORSEG,HL("FS"),2),"@","P")
 I '$L(ORDCNTRL) S ORERR="Invalid control code" D ERROR Q
 S ORIFN=$P($P(ORSEG,HL("FS"),3),$E(HL("ECH")))
 S PKGIFN=$P($P(ORSEG,HL("FS"),4),$E(HL("ECH")))
 I ORIFN,$G(ORVP),$D(^OR(100,+ORIFN,0)),$P(^(0),U,2)'=ORVP S ORERR="Patient doesn't match" D ERROR Q
 S ORDSTS=$P(ORSEG,HL("FS"),6)
 S ORQT=$P(ORSEG,HL("FS"),8)
 S ORSTRT=$$FMDATE($P(ORQT,U,4))
 S ORSTOP=$$FMDATE($P(ORQT,U,5))
 S ORURG=$$URGENCY($P(ORQT,U,6))
 S ORLOG=$$FMDATE($P(ORSEG,HL("FS"),10))
 S ORDUZ=+$P(ORSEG,HL("FS"),11) D DUZ^XUP(ORDUZ)
 S ORNP=+$P(ORSEG,HL("FS"),13)
 S OREASON=$P(ORSEG,HL("FS"),17)
 S ORNATR=$S($P(OREASON,$E(HL("ECH")),3)="99ORN":$P(OREASON,$E(HL("ECH"))),1:"")
 Q
 ;
NMSP(NAME) ; -- Returns package namespace
 I NAME="RADIOLOGY"!(NAME="IMAGING") Q "RA"
 I NAME="LABORATORY" Q "LR"
 I NAME="DIETETICS" Q "FH"
 I NAME="PHARMACY" Q "PS"
 I NAME="CONSULTS" Q "GMRC"
 I NAME="PROCEDURES" Q "GMRC"
 I NAME="ORDER ENTRY" Q "ORG"
 I NAME="VBECS" Q "VBEC"
 Q ""
 ;
MSA ; -- Process MSA segment
 S ORACK=1
 I $P(ORSEG,HL("FS"),2)'="AA" D
 . S ORERR=$P(ORSEG,HL("FS"),4)
 . I '$D(OREASON) S OREASON=U_ORERR
 . D ERROR Q
 Q
 ;
PID ; -- Process PID segment
 ;    Sets PID, ORVP, ORTS if valid patient
 N I,DFN,SEG,PIDLST,X
 ; Adding logic to support v2.4 Patient Id List
 S PIDLST=$P(ORSEG,HL("FS"),4)
 I PIDLST[$E(HL("ECH")) D
 . F I=1:1:$L(PIDLST,$E(HL("ECH"),2)) S X=$P(PIDLST,$E(HL("ECH"),2),I) Q:X=""  I $P(X,$E(HL("ECH")),5)["PI" S DFN=+X Q
 I PIDLST'[$E(HL("ECH")) S DFN=+$P(ORSEG,HL("FS"),4)
 I $D(^DPT(DFN,0)) S ORVP=DFN_";DPT(",ORTS=$G(^DPT(DFN,.103)) Q
 S:$L($P(ORSEG,HL("FS"),5)) ORVP=$P(ORSEG,HL("FS"),5) ; alt ID for Lab
 I '$G(ORVP) S ORERR="Missing or invalid patient ID" D ERROR Q
 Q
 ;
PV1 ; -- Process PV1 segment
 ;    Sets ORCAT, & ORL if valid location
 N I,X
 S X=+$P(ORSEG,HL("FS"),4),ORCAT=$P(ORSEG,HL("FS"),3)
 S:$D(^SC(X,0)) ORL=X_";SC("
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
ERROR ; -- Log an error and return ACK if necessary
 N ORV,X S ORV("XQY0")="",ORQUIT=1
 S X=$S($E(ORERR,1,2)="1^":$P(ORERR,U,2),1:ORERR)
 D EN^ORERR(X,.ORMSG,.ORV)
 ; send an ack to current message ??
 I 'ORACK D GENACK
 Q
 ;
GENACK ; -- Send acknowledgment to original message
 ;Q:$G(VBTEST)
 N MSA1,ORESULT S MSA1="AA"
 I $D(ORERR) S MSA1="AR"
 S HLA("HLA",1)="MSA"_HL("FS")_MSA1_HL("FS")_HL("MID")_$S($D(ORERR):HL("FS")_ORERR,1:"")
 ;S HLEID=HL("EID"),HLEIDS=HL("EIDS")
 D GENACK^HLMA1(HL("EID"),HLMTIENS,HL("EIDS"),"LM",1,.ORESULT)
 Q
TEST ; Testing utility
 Q
 N VBTEST S VBTEST=1
 S HL("FS")="|",HL("ECH")="^~\&",HL("SAN")="VBECS",HL("RAN")="OERR"
 S HL("MTN")="OMG"
 D EN
 Q
