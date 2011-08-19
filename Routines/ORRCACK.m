ORRCACK ;SLC/MKB - Result Acknowledgement file utilities ; 25 Jul 2003  9:31 AM
 ;;1.0;CARE MANAGEMENT;;Jul 15, 2003
 ;
 ; ID = "ORR:"_order# everywhere below
 ;
PARAM(PROV) ; -- Return ORRC ACTIVATION DATE parameter for PROV
 N SERV,Y S PROV=+$G(PROV),SERV=+$G(^VA(200,PROV,5))
 S Y=$$GET^XPAR("ALL^USR.`"_PROV_"^SRV.`"_SERV,"ORRC ACTIVATION DATE")
 Q Y
 ;
ADD(ORDER,PROV,ACK) ; -- Create new entry in file #102.4 when results are posted
 ;  [called from HL7 messages: ORMLR, ORMRA, ORMGMRC]
 Q:'$G(ORDER)  N X,Y,DIC,DO,STOP
 I '$G(ACK),+$G(PROV) D  Q:$G(STOP)
 . I $D(^ORA(102.4,"ACK",PROV,+$G(ORDER))) S STOP=1 Q  ;exists
 . N ACTDT S ACTDT=$$PARAM(PROV)
 . I (ACTDT<1)!(ACTDT>DT) S STOP=1 Q  ;not [yet] active
 S DIC="^ORA(102.4,",DIC(0)="" S:$G(PROV) DIC("DR")="2////"_+PROV
 S X=+ORDER D FILE^DICN
 Q
 ;
ACK(ORY,ORUSR,ORDER) ; -- Acknowledge results of ORDERs by ORUSR
 ; where ORDER(#) = ID ^ 1 or 0, if acknowledged
 ; Returns ORY(#) = ID ^ 1 or 0, if successful
 ; RPC = ORRC RESULTS ACKNOWLEDGE
 Q:'$G(ORUSR)  N X,Y,DA,DR,DIE,ORI,ORIFN,ORACK,ORXQ
 S DIE="^ORA(102.4,",ORUSR=+$G(ORUSR)
 S ORI="" F  S ORI=$O(ORDER(ORI)) Q:ORI=""  D
 . S X=ORDER(ORI),ORIFN=$P(X,U),ORACK=+$P(X,U,2)
 . S ORY(ORI)=ORIFN_"^0",ORIFN=+$P(ORIFN,":",2) Q:ORIFN<1
 . I '$D(^ORA(102.4,"ACK",+ORUSR,+ORIFN)) D ADD(ORIFN,ORUSR,1)
 . S DA=+$O(^ORA(102.4,"ACK",+ORUSR,+ORIFN,0)) Q:DA<1
 . S DR="3///"_$S(ORACK:"NOW",1:"@") D ^DIE
 . S $P(ORY(ORI),U,2)=1,ORXQ(+ORIFN)=""
 D:$D(ORXQ) RSLT^ORRCXQ(.ORXQ,ORUSR)
 Q
 ;
DEL(DA) ; -- Delete old acknowledgment stub
 N DIK S DIK="^ORA(102.4,"
 I $G(DA),'$P($G(^ORA(102.4,DA,0)),U,3) D ^DIK
 Q
 ;
PATS(ORY,ORUSR) ; -- Return list of patients for whom ORUSR has unack'd results
 ; in @ORY@(PAT) = #orders ^ 1 if any are abnormal
 ;    @ORY@(PAT,ID) = * if abnormal, else null
 ; [from ORRCDPT]
 N ORIFN,PAT,ABN,X,CNT,ACTDT,RDT,ACK
 S ORUSR=+$G(ORUSR),ACTDT=$$PARAM(ORUSR)
 S ORY=$NA(^TMP($J,"ORRCRSLT")) K @ORY,^TMP($J,"ORSLT")
 S ORIFN=0 F  S ORIFN=+$O(^ORA(102.4,"ACK",ORUSR,ORIFN)) Q:ORIFN<1  D
 . Q:+$P($G(^OR(100,ORIFN,3)),U,3)=9  ;partial results
 . S PAT=+$P($G(^OR(100,ORIFN,0)),U,2),RDT=+$G(^(7)),ABN=$P($G(^(7)),U,2)
 . I $D(^TMP($J,"ORRCLST")),'$D(^TMP($J,"ORRCY",PAT)) Q  ;pt not on list
 . I 'ACTDT!(RDT<ACTDT) S ACK=+$O(^ORA(102.4,"ACK",ORUSR,ORIFN,0)) D DEL(ACK) Q  ;remove old stub
 . S X=$G(ORY(PAT)),CNT=+X
 . S CNT=CNT+1,@ORY@(PAT)=CNT_$S(ABN!$P(X,U,2):"^1",1:"")
 . S @ORY@(PAT,"ORR:"_ORIFN)=$S(ABN:"*",1:"")
 . D ORSLT ;temp xref for PATS^ORRCEVT
 Q
 ;
ORSLT ; -- Add ORIFN to ^TMP($J,"ORSLT",PAT,pkgid) for use by Events
 N OR0,OR4,NMSP,X
 S OR0=$G(^OR(100,+ORIFN,0)),OR4=$G(^(4)),X=""
 S NMSP=$$NMSP^ORCD($P(OR0,U,14)) I NMSP="RA" D  Q
 . N IDX S IDX="^RADPT(""AO"",+OR4,PAT)"
 . F  S IDX=$Q(@IDX) Q:$P(IDX,",",2)'=+OR4  Q:$P(IDX,",",3)'=PAT  S X=$P(IDX,",",4)_"~"_$P(IDX,",",5),^TMP($J,"ORSLT",PAT,X)=+ORIFN
 I NMSP="LR" S X=+ORIFN_"@OR"
 I NMSP="GMRC" S X=+OR4
 S:$L(X) ^TMP($J,"ORSLT",PAT,X)=+ORIFN
 Q
 ;
IDS(ORY,ORPAT,ORUSR,SDATE,EDATE) ; -- Return new results for ORPAT
 ; between ORBEG & OREND that ORUSR has not acknowledged
 ; in @ORY@(ORPAT) = #orders ^ 1 if any are abnormal
 ;    @ORY@(ORPAT,ID) = * if abnormal, else null
 ; [from ORRCDPT1]
 N CNT,ORIFN,ORDT,ABN,X
 S ORY=$NA(^TMP($J,"ORRCRSLT")) K @ORY
 S ORUSR=+$G(ORUSR),ORPAT=+$G(ORPAT)_";DPT(",CNT=0
 S SDATE=$G(SDATE),EDATE=$G(EDATE) D DT1 ;defaults ??
 S ORDT=SDATE F  S ORDT=$O(^OR(100,"ARS",ORPAT,ORDT)) Q:ORDT<1  Q:ORDT>EDATE  D
 . S ORIFN=0 F  S ORIFN=+$O(^OR(100,"ARS",ORPAT,ORDT,ORIFN)) Q:ORIFN<1  D
 .. Q:+$P($G(^OR(100,ORIFN,3)),U,3)=9  ;partial results
 .. Q:$$ACKD(ORIFN,ORUSR)  S CNT=CNT+1,X=$P($G(^OR(100,ORIFN,7)),U,2)
 .. S @ORY@(+ORPAT,"ORR:"_ORIFN)=$S(X:"*",1:"") S:X ABN=1
 S:CNT @ORY@(+ORPAT)=CNT_U_$G(ABN)
 Q
 ;
LIST(ORY,ORUSR,ORPAT,ORSLT) ; -- Return orders by ORUSR for ORPAT with new results
 ; in @ORY@(#) = Item=ID^Text^ResultDate in HL7 format, and also if ORSLT
 ;             = Data=Test^Value^Units^ReferenceRange^CriticalFlag
 ;             = Cmnt=result comment
 ;            or Text=line of report text
 ; RPC = ORRC RESULTS BY PATIENT
 N ORN,ORIFN,ORTX,ORDT
 S ORY=$NA(^TMP($J,"ORRCRSLT")) K @ORY
 S ORUSR=+$G(ORUSR),ORPAT=+$G(ORPAT),ORN=0
 S ORIFN=0 F  S ORIFN=+$O(^ORA(102.4,"ACK",ORUSR,ORIFN)) Q:ORIFN<1  I +$P($G(^OR(100,ORIFN,0)),U,2)=ORPAT D
 . Q:+$P($G(^OR(100,ORIFN,3)),U,3)=9  ;partial results
 . D TEXT^ORQ12(.ORTX,ORIFN) S ORDT=+$G(^OR(100,ORIFN,7))
 . S ORN=ORN+1,@ORY@(ORN)="Item=ORR:"_ORIFN_U_ORTX(1)_U_$$FMTHL7^XLFDT(ORDT)
 . I $G(ORSLT) D ORD ;add results data to ORY(#)
 ;S ORY(0)=CNT
 Q
 ;
LISTD(ORY,ORPAT,ORUSR,ORBEG,OREND,ORSLT) ; -- Return new results for ORPAT
 ; between ORBEG & OREND that ORUSR has not acknowledged
 ; in @ORY@(#) = Item=ID^Text^ResultDate in HL7 format, and also if ORSLT
 ;             = Data=Test^Value^Units^ReferenceRange^CriticalFlag
 ;             = Cmnt=result comment
 ;            or Text=line of report text
 ; RPC = ORRC RESULTS BY DATE
 N ORN,ORIFN,ORTX,ORDT,SDATE,EDATE
 S ORY=$NA(^TMP($J,"ORRCRSLT")) K @ORY
 S ORUSR=+$G(ORUSR),ORPAT=+$G(ORPAT)_";DPT(",ORN=0 D DATES
 S ORDT=SDATE F  S ORDT=$O(^OR(100,"ARS",ORPAT,ORDT)) Q:ORDT<1  Q:ORDT>EDATE  D
 . S ORIFN=0 F  S ORIFN=+$O(^OR(100,"ARS",ORPAT,ORDT,ORIFN)) Q:ORIFN<1  D
 .. Q:+$P($G(^OR(100,ORIFN,3)),U,3)=9  ;partial results
 .. Q:$$ACKD(ORIFN,ORUSR)  D TEXT^ORQ12(.ORTX,ORIFN)
 .. S ORN=ORN+1,@ORY@(ORN)="Item=ORR:"_ORIFN_U_ORTX(1)_U_$$FMTHL7^XLFDT(ORDT)
 .. I $G(ORSLT) D ORD ;add results data to ORY(#)
 Q
 ;
DATES ; -- Return SDATE and EDATE from ORBEG and OREND
 ;    [Inverted for rev-chron search]
 S SDATE=$$HL7TFM^XLFDT($G(ORBEG)),EDATE=$$HL7TFM^XLFDT($G(OREND))
DT1 I EDATE S EDATE=$S($L(EDATE,".")=2:EDATE+.0001,1:EDATE+1)
 I SDATE S SDATE=$S($L(SDATE,".")=2:SDATE-.0001,1:SDATE)
 S SDATE=9999999-$S(SDATE:SDATE,1:0),EDATE=9999999-$S(EDATE:EDATE,1:9999998)
 S X=EDATE,EDATE=SDATE,SDATE=X
 Q
 ;
ACKD(ORDER,USER) ; -- Returns 1 or 0, if USER has acknowledged ORDER
 N Y S Y=0
 S IFN=0 F  S IFN=$O(^ORA(102.4,"B",+$G(ORDER),IFN)) Q:IFN<1  D  Q:Y
 . S X=$G(^ORA(102.4,IFN,0)) I $P(X,U,3),$P(X,U,2)=+$G(USER) S Y=1 Q
 Q Y
 ;
RESULT(ORY,ORDER) ; -- Return results of ORDERs
 ; where ORDER(#) = ID
 ; in @ORY@(#) = Item=ID^Text^ResultDate in HL7 format, and
 ;             = Data=Test^Value^Units^ReferenceRange^CriticalFlag
 ;             = Cmnt=result comment
 ;            or Text=line of report text
 ; RPC = ORRC RESULTS BY ID
 N ORN,ORI,ORIFN,ORDT,ORTX
 S ORN=0,ORY=$NA(^TMP($J,"ORRCRSLT")) K @ORY
 S ORI="" F  S ORI=$O(ORDER(ORI)) Q:ORI=""  S ORIFN=ORDER(ORI) D
 . S ORIFN=+$P(ORIFN,":",2),ORDT=+$G(^OR(100,ORIFN,7))
 . D TEXT^ORQ12(.ORTX,ORIFN)
 . S ORN=ORN+1,@ORY@(ORN)="Item=ORR:"_ORIFN_U_ORTX(1)_U_$$FMTHL7^XLFDT(ORDT)
 . D ORD
 Q
 ;
ORD ; -- Add results for ORIFN to @ORY@(ORN)
 N PKG Q:'+$G(ORIFN)
 S PKG=+$P($G(^OR(100,ORIFN,0)),U,14),PKG=$$NMSP^ORCD(PKG)
 I "^LR^RA^GMRC^"'[(U_PKG_U)!'ORIFN S ORY(1)="Text=No results available." Q  ;DT??
 D @PKG
 Q
LR ; -- Lab results
 N ORVP,LRID,LRTST,LRSUB,I,X K ^TMP("LRRR",$J)
 S ORVP=$P($G(^OR(100,ORIFN,0)),U,2),LRID=$G(^(4))
 I '$L(LRID) S ORN=ORN+1,@ORY@(ORN)="Text=No results available." Q
 S X=$$VALUE^ORCSAVE2(ORIFN,"ORDERABLE"),LRTST=+$P($G(^ORD(101.43,+X,0)),U,2)
 I +LRID  D RR^LR7OR1(+ORVP,LRID,,,,LRTST) I '$D(^TMP("LRRR",$J,+ORVP)) S $P(LRID,";",1,3)=";;" ;Order possibly purged, reset to lookup on file 63
 I '+LRID,$P(LRID,";",5)  D RR^LR7OR1(+ORVP,,9999999-$P(LRID,";",5),9999999-$P(LRID,";",5),$P(LRID,";",4),LRTST)
 I '$D(^TMP("LRRR",$J,+ORVP)) S ORN=ORN+1,@ORY@(ORN)="Text=No results available." Q
 S LRSUB=$O(^TMP("LRRR",$J,+ORVP,"")) Q:LRSUB=""
 S LRDT=$O(^TMP("LRRR",$J,+ORVP,LRSUB,0)) I LRDT S LRDT=9999999-LRDT,$P(@ORY@(ORN),U,3)=$$FMTHL7^XLFDT(LRDT) ;return Coll Dt instead of Results Dt
 I LRSUB="CH" D  K ^TMP("LRRR",$J) Q
 . N TEST,LRDT,LRN,LRI M TEST=^TMP("LRRR",$J,+ORVP,"CH")
 . S LRDT=0 F  S LRDT=$O(TEST(LRDT)) Q:LRDT<1  S LRN=0 F  S LRN=$O(TEST(LRDT,LRN)) Q:LRN=""  D
 .. I LRN S I=$G(TEST(LRDT,LRN)),X=$P($G(^LAB(60,+I,0)),U)_U_$P(I,U,2)_U_$P(I,U,4,5)_U_$P(I,U,3) S ORN=ORN+1,@ORY@(ORN)="Data="_X
 .. I LRN="N" S LRI=0 F  S LRI=$O(TEST(LRDT,LRN,LRI)) Q:LRI<1  S ORN=ORN+1,@ORY@(ORN)="Cmnt="_$G(TEST(LRDT,LRN,LRI))
 K ^TMP("LRC",$J) D EN1^LR7OSBR(+ORVP):LRSUB="BB",EN^LR7OSMZ0(+ORVP):LRSUB="MI"
 S I=0 F  S I=+$O(^TMP("LRC",$J,I)) Q:I<1  S X=$G(^(I,0)),ORN=ORN+1,@ORY@(ORN)="Text="_X
 K ^TMP("LRC",$J),^TMP("LRRR",$J)
 Q
RA ; -- Radiology results
 N ORVP,RAID,CASE,PROC,PSET,FIRST
 S ORVP=$P($G(^OR(100,ORIFN,0)),U,2),RAID=+$G(^(4)) D EN30^RAO7PC3(RAID)
 S PSET=$D(^TMP($J,"RAE3",+ORVP,"PRINT_SET")),FIRST=1
 I 'PSET S CASE=0 F  S CASE=$O(^TMP($J,"RAE3",+ORVP,CASE)) Q:CASE'>0  D
 . S PROC="" F  S PROC=$O(^TMP($J,"RAE3",+ORVP,CASE,PROC)) Q:PROC=""  D XRPT
 I PSET S CASE=$O(^TMP($J,"RAE3",+ORVP,0)),PROC=$O(^(CASE,"")) D XRPT
 K ^TMP($J,"RAE3",+ORVP)
 Q
XRPT ; -- body of report for CASE, PROC
 N ORD,X,I
 I 'FIRST S ORN=ORN+1,@ORY@(ORN)="Text="_$$REPEAT^XLFSTR(" * ",24)
 S ORD=$S($L($G(^TMP($J,"RAE3",+ORVP,"ORD"))):^("ORD"),$L($G(^("ORD",CASE))):^(CASE),1:"") I $L(ORD),ORD'=PROC S ORN=ORN+1,@ORY@(ORN)="Text=Proc Ord: "_ORD
 S I=1 F  S I=$O(^TMP($J,"RAE3",+ORVP,CASE,PROC,I)) Q:I'>0  S X=^(I),ORN=ORN+1,@ORY@(ORN)="Text="_X ;Skip pt ID on line 1
 S FIRST=0
 Q
GMRC ; -- Consult results
 N GMRCID,I,X,SUB S GMRCID=+$G(^OR(100,ORIFN,4)),SUB="RT" N ORIFN ;protect
 I '$D(^GMR(123,GMRCID,50,"B")),'$D(^GMR(123,GMRCID,51,"B")) S SUB="DT"
 D RT^GMRCGUIA(GMRCID,"^TMP(""GMRCR"",$J,""RT"")"):SUB="RT",DT^GMRCSLM2(GMRCID):SUB="DT"
 S I=0 F  S I=$O(^TMP("GMRCR",$J,SUB,I)) Q:I'>0  S X=$G(^(I,0)),ORN=ORN+1,@ORY@(ORN)="Text="_X
 K ^TMP("GMRCR",$J)
 Q
