ORMPS3 ;SLC/MKB - Process Pharmacy ORM msgs cont ;05/08/2008  10:32
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**213,243**;Dec 17, 1997;Build 242
 ;
PTR(X) ; -- Return ptr to prompt OR GTX X
 Q +$O(^ORD(101.41,"AB","OR GTX "_X,0))
 ;
PARENT ; -- create parent order for backdoor complex renewals
 ;    Expects ORIFN, ORIG, ORDIALOG()
 ;Q:'$$PATCH^XPDUTL("PSJ*5.0*110")
 N ORIGDAD,ORIFNDAD,HDR S ORIGDAD=$P($G(^OR(100,ORIG,3)),U,9)
 Q:ORIGDAD<1  Q:$$DOSES^ORCACT4(ORIGDAD)'>1  ;cont if complex
 S ORIFNDAD=$P($G(^OR(100,ORIGDAD,3)),U,6) I ORIFNDAD<1 D  G P1
 . N ORIFN D EN^ORCSAVE Q:ORIFN<1
 . S $P(^OR(100,ORIFN,3),U,5)=ORIGDAD,$P(^(3),U,8)=1,$P(^(3),U,11)=2
 . S $P(^OR(100,ORIGDAD,3),U,6)=ORIFN,ORIFNDAD=ORIFN
 . D RELEASE^ORCSAVE2(ORIFN,1,ORLOG,ORDUZ,ORNATR)
 . D SIGSTS^ORCSAVE2(ORIFN,1),DATES^ORCSAVE2(ORIFN,ORSTRT)
 . I $P(^OR(100,ORIFN,8,1,0),U,4)=2 S $P(^(0),U,4)="" K ^OR(100,"AS",ORVP,9999999-ORLOG,ORIFN,1) ;sign children instead
 . ;STATUS updated in SN2^ORMPS from child orders
P0 ; -- just add conjunction, new dose if DAD already exists
 N INST,DA,PTR,ID,P,I,J,X
 S INST=$$DOSES^ORCACT4(ORIFNDAD),DA=$O(^OR(100,ORIFNDAD,4.5,"A"),-1)
 S PTR=$$PTR("AND/THEN"),ID="CONJ",DA=DA+1
 S ^OR(100,ORIFNDAD,4.5,DA,0)=U_PTR_U_INST_U_ID,^(1)="A"
 S ^OR(100,ORIFNDAD,4.5,"ID","CONJ",DA)="",INST=INST+1
 F P="INSTRUCTIONS","ROUTE","SCHEDULE","DURATION","DOSE","DISPENSE DRUG" D
 . S PTR=$$PTR(P) Q:'$L($G(ORDIALOG(PTR,1)))
 . S DA=DA+1,ID=$P($G(^ORD(101.41,PTR,1)),U,3)
 . S ^OR(100,ORIFNDAD,4.5,DA,0)=U_PTR_U_INST_U_ID,^(1)=ORDIALOG(PTR,1)
 . S ^OR(100,ORIFNDAD,4.5,"ID",ID,DA)=""
 S $P(^OR(100,ORIFNDAD,4.5,0),U,3,4)=DA_U_DA
 S P=$$PTR("SIG"),DA=+$O(^OR(100,ORIFNDAD,4.5,"ID","SIG",0))
 S I=+$O(^OR(100,ORIFNDAD,4.5,DA,2,""),-1),X=$G(^(I,0)) S:$L(X) X=X_" AND",^(0)=X
 S J=0 F  S J=$O(^TMP("ORWORD",$J,PTR,1,J)) Q:J<1  S I=I+1,^OR(100,ORIFNDAD,4.5,DA,2,I,0)=^TMP("ORWORD",$J,PTR,1,J,0)
 S $P(^OR(100,ORIFNDAD,4.5,DA,2,0),U,3,4)=I_U_I
 ; -- rebuild order text w/new SIG
 K ^TMP("ORWORD",$J,PTR) M ^TMP("ORWORD",$J,PTR,1)=^OR(100,ORIFNDAD,4.5,DA,2)
 K ^OR(100,ORIFNDAD,8,1,.1) D ORDTEXT^ORCSAVE1(ORIFNDAD_";1")
P1 ; -- set up links
 S $P(^OR(100,ORIFN,3),U,9)=ORIFNDAD
 S HDR=$G(^OR(100,ORIFNDAD,2,0)),^(0)="^100.002PA^"_ORIFN_U_($P(HDR,U,4)+1),^(ORIFN,0)=ORIFN
 Q
 ;
NTE(ID) ; -- Return subscript of NTE|ID segment
 N I,SEG,Y S Y="",I=+RXE S:'$G(ID) ID=21
 F  S I=$O(@ORMSG@(I)) Q:I'>0  S SEG=@ORMSG@(I) Q:$E(SEG,1,3)="ORC"  I $P(SEG,"|",1,2)=("NTE|"_ID) S Y=I Q
 Q Y
 ;
NTXT(NTE) ; -- Return string of text in ORMSG(NTE)
 N Y,I S NTE=+$G(NTE)
 S Y=$P($G(@ORMSG@(NTE)),"|",4),Y=$$UNESC^ORHLESC(Y)
 S I=0 F  S I=$O(@ORMSG@(NTE,I)) Q:I<1  S Y=Y_" "_$$UNESC^ORHLESC(@ORMSG@(NTE,I))
 Q Y
 ;
ZSC() ; -- Return subscript of ZSC segment
 N I,SEG,Y S Y="",I=+RXE
 F  S I=$O(@ORMSG@(I)) Q:I'>0  S SEG=$E(@ORMSG@(I),1,3) Q:SEG="ORC"  I SEG="ZSC" S Y=I_U_@ORMSG@(I) Q
 Q Y
 ;
NUMADDS() ; -- count number of additives to determine type
 N CNT,I,X S CNT=0,I=+RXE
 F  S I=$O(@ORMSG@(I)) Q:I'>0  S X=@ORMSG@(I) Q:$P(X,"|")="ORC"  I $E(X,1,6)="RXC|A|" S CNT=CNT+1
 Q CNT
 ;
DURATION(X) ; -- Returns "# units" from U# format
 N Y,Y1,Y2 I X'?.1U1.N Q ""
 S Y1=$E(X),Y2=+$E(X,2,$L(X)) I X=+X S Y1="D",Y2=+X
 S Y=Y2_" "_$S(Y1="L":"MONTH",Y1="W":"WEEK",Y1="H":"HOUR",Y1="M":"MINUTE",Y1="S":"SECOND",1:"DAY")_$S(Y2>1:"S",1:"")
 Q Y
 ;
UPD ; -- Compare ORMSG to order, update responses [from SC^ORMPS]
 ;    Also expects ORIFN,ORNP,ORCAT,OR3,RXE,ZRX,PKGIFN
 N X,I,ORDER,ZSC,NTE,PI
 S ORDER=+$G(ORIFN),I=+$P(ORIFN,";",2) I I<1 D
 . S I=+$P(OR3,U,7) Q:I
 . S I=$O(^OR(100,+ORIFN,8,"A"),-1)
 S X=+$P($G(^OR(100,+ORIFN,8,I,0)),U,3) S:X'=ORNP $P(^(0),U,3)=ORNP
 S X=+$P($P(RXE,"|",3),U,4)
 I X,X'=+$$VALUE(ORDER,"DRUG") D RESP^ORCSAVE2(ORDER,"OR GTX DISPENSE DRUG",X)
 I $G(ORCAT)="I" D  Q
 . S X=$P($P($P(RXE,"|",2),U,2),"&",2)
 . I X'=$$VALUE(ORDER,"ADMIN") D RESP^ORCSAVE2(ORDER,"OR GTX ADMIN TIMES",X)
 . ;SCHEDULE TYPE
 . S X=$P($P(RXE,"|",2),U,7)
 . I X'=$$VALUE(ORDER,"SCHTYPE") D RESP^ORCSAVE2(ORDER,"OR GTX SCHEDULE TYPE",X)
 . I $S(X="P":1,X="O":1,X="OC":1,1:0) D
 . .D RESP^ORCSAVE2(ORDER,"OR GTX ADMIN TIMES","")
 I $G(PKGIFN)'["N" D  ;Rx only, not non-VA
 . S X=$P(RXE,"|",23) S:$E(X)="D" X=+$E(X,2,99)
 . I +X'=+$$VALUE(ORDER,"SUPPLY") D RESP^ORCSAVE2(ORDER,"OR GTX DAYS SUPPLY",X)
 . I $P(ZRX,"|",5)'=$$VALUE(ORDER,"PICKUP") D RESP^ORCSAVE2(ORDER,"OR GTX ROUTING",$P(ZRX,"|",5))
 . S NTE=$$NTE(7),PI=+$O(^OR(100,ORDER,4.5,"ID","PI",0))
 . I NTE,PI,$$NTXT(NTE)'=$$VALTXT(ORDER,PI) D
 .. N CNT K ^OR(100,ORDER,4.5,PI,2)
 .. S CNT=1,^OR(100,ORDER,4.5,PI,2,1,0)=$$UNESC^ORMPS2($P(@ORMSG@(NTE),"|",4))
 .. S I=0 F  S I=$O(@ORMSG@(NTE,I)) Q:I<1  S CNT=CNT+1,^OR(100,ORDER,4.5,PI,2,CNT,0)=$$UNESC^ORMPS2(@ORMSG@(NTE,I))
 .. S ^OR(100,ORDER,4.5,PI,2,0)="^^"_CNT_U_CNT_U_DT_U
 S ZSC=$$ZSC I ZSC,$P(ZSC,"|",2)'?2.3U S ^OR(100,ORDER,5)=$TR($P(ZSC,"|",2,7),"|","^") ;1 or 0 instead of [N]SC
 Q
 ;
VALUE(IFN,ID,INST) ; -- Returns value of prompt by identifier ID
 I '$G(IFN)!('$D(^OR(100,+$G(IFN),0)))!($G(ID)="") Q ""
 N I,Y S I=0,Y="" S:'$G(INST) INST=1
 F  S I=$O(^OR(100,IFN,4.5,"ID",ID,I)) Q:I'>0  I $P($G(^OR(100,IFN,4.5,+I,0)),U,3)=INST S Y=$G(^(1)) Q
 Q Y
 ;
VALTXT(IFN,ID) ; -- Return string of text for prompt ID [assumes single instance]
 ;    ID may be identifier name or Response IEN
 N Y,DA,I S IFN=+$G(IFN),ID=$G(ID)
 S DA=$S($G(ID):+ID,$L(ID):+$O(^OR(100,IFN,4.5,"ID",ID,0)),1:0)
 S I=+$O(^OR(100,IFN,4.5,DA,2,0)),Y=$G(^(I,0))
 F  S I=$O(^OR(100,IFN,4.5,DA,2,I)) Q:I<1  S Y=Y_" "_$G(^(I,0))
 Q Y
