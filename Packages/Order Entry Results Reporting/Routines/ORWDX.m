ORWDX ; SLC/KCM/REV/JLI - Order dialog utilities ;Oct 12, 2021@10:33:09
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**10,85,125,131,132,141,164,178,187,190,195,215,246,243,283,296,280,306,350,424,421,461,490,397,377,539,405**;Dec 17, 1997;Build 211
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ;Reference to DIC(9.4 supported by IA #2058
 ;Reference to ^SC( supported by ICR #10040
 ;
 ;Sep 18, 2015 - PB - modified to trigger an unsolicited sync action
 ;
ORDITM(Y,FROM,DIR,XREF,QOCALL) ; Subset of orderable items
 ; Y(n)=IEN^.01 Name^.01 Name  -or-  IEN^Synonym <.01 Name>^.01 Name
 N I,IEN,CNT,X,DTXT,CURTM,DEFROUTE,ORDSTART
 S ORDSTART=$O(^ORD(101.43,XREF,FROM))
 S DEFROUTE=""
 S QOCALL=+$G(QOCALL)
 S I=0,CNT=44,CURTM=$$NOW^XLFDT
 F  Q:I'<CNT  S FROM=$O(^ORD(101.43,XREF,FROM),DIR) Q:FROM=""  D
 . S IEN="" F  S IEN=$O(^ORD(101.43,XREF,FROM,IEN),DIR) Q:'IEN  D
 . . S X=^ORD(101.43,XREF,FROM,IEN)
 . . I +$P(X,U,3),$P(X,U,3)<CURTM Q
 . . I 'QOCALL,$P(X,U,5) Q
 . . I QOCALL,$P(X,U,5),FROM'=ORDSTART Q
 . . S I=I+1
 . . I 'X S Y(I)=IEN_U_$P(X,U,2)_U_$P(X,U,2)
 . . E  S Y(I)=IEN_U_$P(X,U,2)_$C(9)_"<"_$P(X,U,4)_">"_U_$P(X,U,4)
 Q
 ;
APORDITM(Y,QOCALL) ; Subset of AP orderable items
 ; Y(n)=IEN^.01 Name^.01 Name  -or-  IEN^Synonym <.01 Name>^.01 Name
 N I,IEN,X,CURTM,FROM,XREF
 S QOCALL=+$G(QOCALL)
 S I=0,FROM="",XREF="S.AP",CURTM=$$NOW^XLFDT
 F  S FROM=$O(^ORD(101.43,XREF,FROM)) Q:FROM=""  D
 . S IEN="" F  S IEN=$O(^ORD(101.43,XREF,FROM,IEN)) Q:'IEN  D
 . . I '$D(^LAB(69.73,"B",IEN)) Q
 . . S X=^ORD(101.43,XREF,FROM,IEN)
 . . I +$P(X,U,3),$P(X,U,3)<CURTM Q
 . . I 'QOCALL,$P(X,U,5) Q
 . . S I=I+1
 . . I 'X S Y(I)=IEN_U_$P(X,U,2)_U_$P(X,U,2)
 . . E  S Y(I)=IEN_U_$P(X,U,2)_$C(9)_"<"_$P(X,U,4)_">"_U_$P(X,U,4)
 Q
 ;
ODITMBC(Y,XREF,ODLST) ;
 N CNT,NM,XRF
 S CNT=0,NM=0,XRF=XREF
 F  S CNT=$O(ODLST(CNT)) Q:'CNT  D FNDINFO(.Y,ODLST(CNT))
 Q
FNDINFO(Y,ODIEN) ;
 D FNDINFO^ORWDX1(.Y,.ODIEN)
 Q
DLGDEF(LST,DLG) ; Format mapping for a dlg
 D DLGDEF^ORWDX1(.LST,.DLG)
 Q
DLGQUIK(LST,QO) ;(NOT USED)
 D LOADRSP(.LST,QO)
 Q
LOADRSP(LST,RSPID,TRANS,ORREN)      ; Load responses from 101.41 or 100
 ; RSPID:  C123456;1-3243 = cached copy,   134-3234 = cached quick
 ;         X123456;1      = change order,  134      = quick dialog
 ; ORREN: If ORREN is set to 1 then RSPID is the order getting renewed
 N I,J,DLG,INST,ID,VAL,ILST,ROOT,ORLOC,ORADDTITRRESP
 S ROOT=""
 K ^TMP($J,"ORWDX LOADRSP","QO SAVE")
 I +RSPID=$P(RSPID,"-",1) D
 .S ^TMP($J,"ORWDX LOADRSP","QO SAVE")=+RSPID
 I RSPID["-" S ROOT="^TMP(""ORWDXMQ"",$J,"""_RSPID_""")" G XROOT^ORWDX2
 I $E(RSPID)="X" D  G XROOT^ORWDX2
 . N ORIFN
 . S ORIFN=+$P(RSPID,"X",2)
 . S ROOT="^OR(100,"_ORIFN_",4.5)"
 . I $$ISTITR^ORUTL3(ORIFN) D TITR(ORIFN,$G(ORREN),.ROOT,.ORADDTITRRESP)
 I +RSPID=RSPID  S ROOT="^ORD(101.41,"_+RSPID_",6)" G XROOT^ORWDX2
 Q:ROOT=""
 G XROOT^ORWDX2
 ;
TITR(ORIFN,ORREN,ROOT,ORADDTITRRESP) ; Special handling for outpatient med titration orders
 N ORRESPIEN
 ;
 ; for titration renewals, only renew maintenance portion
 I $G(ORREN) D
 . S ROOT=$$GETTMP^ORWTITR(ORIFN)
 ;
 ; when changing an old titration order (pre-v32b/p405), check
 ; if it's marked as titrating in back-door, but not in 100
 I '$G(ORREN) D
 . S ORRESPIEN=$O(^OR(100,ORIFN,4.5,"ID","TITR",0))
 . I ORRESPIEN,$D(^OR(100,ORIFN,4.5,+ORRESPIEN,1)) Q
 . S ORADDTITRRESP=1  ; add titration response in ORWDX2
 Q
 ;
SAVE(REC,ORVP,ORNP,ORL,DLG,ORDG,ORIT,ORIFN,ORDIALOG,ORDEA,ORAPPT,ORSRC,OREVTDF,INDICAT) ;
 ; ORVP=DFN, ORNP=Provider, ORL=Location, DLG=Order Dialog,
 ; ORDG=Display Group, ORIT=Quick Order Dialog, ORAPPT=Appointment
 ;
 D SAVE^ORWDX3  ;moved to ORWDX3 because of routine size
 ;
 Q
 ;
SENDED(ORWLST,ORIENS,TS,LOC) ; Release EDOs to svc
 N OK,ORVP,ORWERR,ORSIGST,ORDA,ORNATURE,ORIX,X,PTEVT,ORIFN,J,EVENT,LOCK,OR3
 N ORLR,ORLAB,I  ;*539
 S ORWERR="",ORIX=0,LOC=LOC_";SC("
 ;*539
 F I="LR","VBEC" S X=+$O(^DIC(9.4,"C",I,0)) S:X ORLR(X)=1
 F  S ORIX=$O(ORIENS(ORIX)) Q:'ORIX  D  Q:ORWERR]""
 . S (ORIFN,ORWLST(ORIX))=ORIENS(ORIX)
 . S PTEVT=$P(^OR(100,+ORIFN,0),U,17)
 . I PTEVT D
 .. I $D(EVENT(PTEVT)) S LOCK=1 Q
 .. S LOCK=$$LCKEVT^ORX2(PTEVT) S:LOCK EVENT(PTEVT)=""
 . I 'LOCK S ORWERR="1^delayed event is locked - another user is processing orders for this event" S ORWLST(ORIX)=ORWLST(ORIX)_"^E^"_ORWERR Q
 . S ORDA=$P(ORIFN,";",2) S:'ORDA ORDA=1
 . S ORVP=$P($G(^OR(100,+ORIFN,0)),U,2)
 . ;*539 Add Protocol Invocation for Lab
 . I $G(ORLR(+$P(^OR(100,+ORIFN,0),U,14))),'$G(ORLAB) D
 .. I $L($T(BHS^ORMBLD)) D BHS^ORMBLD(ORVP) S ORLAB=1
 . I $D(^OR(100,+ORIFN,8,ORDA,0)) D
 .. S ORSIGST=$P($G(^(0)),U,4),ORNATURE=$P($G(^(0)),U,12) ;naked references refer to OR(100,+ORIFN,8,ORDA on line above
 . S OK=$$LOCK1^ORX2(ORIFN) I 'OK S ORWERR="1^"_$P(OK,U,2)
 . I OK,$G(LOCK) D
 .. S OR3=$G(^OR(100,+ORIFN,3)) I $P(OR3,"^",3)'=10!($P(OR3,"^",9)]"") D UNLK1^ORX2(ORIENS(ORIX)) Q  ;order already released or has a parent
 .. S:$G(LOC) $P(^OR(100,+ORIFN,0),U,10)=LOC ;set location
 .. S:$G(TS) $P(^OR(100,+ORIFN,0),U,13)=TS ;set specialty
 .. D EN2^ORCSEND(ORIENS(ORIX),ORSIGST,ORNATURE,.ORWERR),UNLK1^ORX2(ORIENS(ORIX)) ;add ,LOCK to if statement for 195
 . I $L(ORWERR) S ORWLST(ORIX)=ORWLST(ORIX)_"^E^"_ORWERR Q
 . E  D
 .. S PTEVT=$P($G(^OR(100,+ORIENS(ORIX),0)),U,17)
 .. D:$$TYPE^OREVNTX(PTEVT)="M" SAVE^ORMEVNT1(ORIENS(ORIX),PTEVT,2)
 . S X="RS"
 . S $P(ORWLST(ORIX),U,2)=X
 I $G(ORLAB) D BTS^ORMBLD(ORVP) ;*539 Finish Protocol Invocation
 S J=0 F  S J=$O(EVENT(J)) Q:'+J  D UNLEVT^ORX2(J) ;195
 Q
SEND(ORWLST,DFN,ORNP,ORL,ES,ORWREC) ; Sign
 ; DFN=Patient, ORNP=Provider, ORL=Location, ES=Encrypted ES code
 ; ORWREC(n)=ORIFN;Action^Signature Sts^Release Sts^Nature of Order
SEND1 N ORVP,ORWI,ORWERR,ORWREL,ORWSIG,ORWNATR,ORDERID,ORBEF,ORLR,ORLAB,X,I
 S ORVP=DFN_";DPT(",ORL=ORL_";SC(",ORL(2)=ORL,ORWLST=0
 F I="LR","VBEC" S X=+$O(^DIC(9.4,"C",I,0)) S:X ORLR(X)=1
 S ORWI=0 F  S ORWI=$O(ORWREC(ORWI)) Q:'ORWI  D
 . S X=ORWREC(ORWI),ORWERR=""
 . S ORDERID=$P(X,U),ORWSIG=$P(X,U,2),ORWREL=$P(X,U,3),ORWNATR=$P(X,U,4)
 . S ORBEF=0
 . I '$D(^OR(100,+ORDERID,0)) Q
 . I $D(^OR(100,+ORDERID,8,+$P(ORDERID,";",2),0)) S ORBEF=$P(^OR(100,+ORDERID,8,+$P(ORDERID,";",2),0),U,15)
 . S:$D(^OR(100,+ORDERID,8,+$P(ORDERID,";",2),0)) ORWNATR=$S($P(^OR(100,+ORDERID,8,+$P(ORDERID,";",2),0),"^",4)=3:"",1:ORWNATR)
 . S ORWERR=$$CHKACT^ORWDXR(ORDERID,ORWSIG,ORWREL,ORWNATR)
 . I $L(ORWERR) S ORWERR="1^"_ORWERR
 . I '$L(ORWERR) D
 .. I $G(ORLR(+$P(^OR(100,+ORDERID,0),U,14))),'$G(ORLAB) D  ; lab batch start
 ... I $L($T(BHS^ORMBLD)) D BHS^ORMBLD(ORVP) S ORLAB=1
 .. N OK S OK=$$LOCK1^ORX2(ORDERID) I 'OK S ORWERR="1^"_$P(OK,U,2)
 .. I OK D EN^ORCSEND(ORDERID,"",ORWSIG,ORWREL,ORWNATR,"",.ORWERR),UNLK1^ORX2(ORDERID)
 . S ORWLST(ORWI)=ORDERID,X=""
 . I $L(ORWERR) S ORWLST(ORWI)=ORWLST(ORWI)_"^E^"_ORWERR Q
 . I ORWREL,((ORBEF=10)!(ORBEF=11)),($P(^OR(100,+ORDERID,3),U,3)'=10) S X="R"
 . I ORWSIG'=2 S X=X_"S"
 . S $P(ORWLST(ORWI),U,2)=X
 I $G(ORLAB) D BTS^ORMBLD(ORVP)
 I $D(ORWLST)>9 D
 . N I,A
 . S I=0 F  S I=$O(ORWLST(I)) Q:I=""  S A=$G(ORWLST(I)) I A["Invalid Procedure, Inactive, no Imaging Type" D SM^ORWDX2(A)
  Q
DLGID(VAL,ORIFN) ; return dlg IEN for order
 S VAL=$P(^OR(100,+ORIFN,0),U,5)
 S VAL=$S($P(VAL,";",2)="ORD(101.41,":+VAL,1:0)
 Q
FORMID(VAL,ORIFN) ; Base dlg FormID for an order
 N DLG
 S VAL=0,DLG=$P(^OR(100,+ORIFN,0),U,5)
 Q:$P(DLG,";",2)'="ORD(101.41,"
 D FORMID^ORWDXM(.VAL,+DLG)
 Q
AGAIN(VAL,DLG) ; return true to keep dlg for another order
 S VAL=''$P($G(^ORD(101.41,DLG,0)),U,9)
 Q
DGRP(VAL,DLG) ; Display grp pointer for a dlg
 S DLG=$S($E(DLG)="`":+$P(DLG,"`",2),1:$O(^ORD(101.41,"AB",DLG,0))) ;kcm
 S VAL=$P($G(^ORD(101.41,DLG,0)),U,5)
 Q
DGNM(VAL,NM) ; Display grp pointer for name
 S VAL=$O(^ORD(100.98,"B",NM,0))
 Q
WRLST(LST,LOC) ; List of dlgs for writing orders
 G WRLST1^ORWDX1
MSG(LST,IEN) ; Msg text for orderable item
 N I
 S I=0 F  S I=$O(^ORD(101.43,IEN,8,I)) Q:I'>0  S LST(I)=^(I,0)
 Q
DISMSG(VAL,IEN) ; Disabled mge for ordering dlg
 S VAL=$P($G(^ORD(101.41,+IEN,0)),U,3)
 Q
LOCK(OK,DFN) ; Attempt to lock pt for ordering
 S OK=$$LOCK^ORX2(DFN)
 Q
UNLOCK(OK,DFN) ; Unlock pt for ordering
 D UNLOCK^ORX2(DFN) S OK=1
 Q
LOCKORD(OK,ORIFN) ; Attempt to lock order
 S OK=$$LOCK1^ORX2(ORIFN)
 Q
UNLKORD(OK,ORIFN) ; Unlock order
 D UNLK1^ORX2(ORIFN) S OK=1
 Q
UNLKOTH(OK,ORIFN) ; Unlock pt not by this session
 K ^XTMP("ORPTLK-"_ORIFN) S OK=1
 Q
