ORWD ; SLC/KCM - Utilities for Windows Dialogs ;7/2/01  13:31
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**243,280**;Dec 17, 1997;Build 85
 ;
DT(Y,X) ; Returns internal Fileman Date/Time
 N %DT S %DT="TS" D ^%DT
 Q
PROVKEY(VAL,USERID) ; Returns 1 if user possesses the provider key
 N NAM S NAM=$P(^VA(200,USERID,0),U,1)
 S VAL=$D(^VA(200,"AK.PROVIDER",NAM,USERID))
 Q
KEY(VAL,KEYNAME,USERID) ; Returns 1 if user possesses the key
 S VAL=0 I $D(^XUSEC(KEYNAME,USERID)) S VAL=1
 Q
OI(Y,XREF,DIR,FROM) ; Return a bolus of orderable items
 ; .Return Array, Cross Reference (S.xxx), Direction, Starting Text
 N I,IEN,CNT S CNT=44
 ;
 I DIR=0 D  ; Forward direction
 . F I=1:1:CNT S FROM=$O(^ORD(101.43,XREF,FROM)) Q:FROM=""  D
 . . S Y(I)=$O(^ORD(101.43,XREF,FROM,0))_"^"_FROM
 . I $G(Y(CNT))="" S Y(I)=""
 ;
 I DIR=1 D  ; Reverse direction
 . F I=1:1:CNT S FROM=$O(^ORD(101.43,XREF,FROM),-1) Q:FROM=""  D
 . . S Y(I)=$O(^ORD(101.43,XREF,FROM,0))_"^"_FROM
 Q
ODEF(Y,DLG) ; Return the definition for a dialog
 Q:'$L(DLG)
 S DLG=+$O(^ORD(101.41,"B",DLG,0))
 Q:$D(^ORD(101.41,DLG,50))<10
 N I,IEN,IDX
 S I=0,IDX=0
 S Y(0)=$P($G(^ORD(101.41,DLG,5)),"^",4)
 F  S I=$O(^ORD(101.41,DLG,50,"AC",I)) Q:I=""  S IEN=$O(^(I,0)) D
 . S IDX=IDX+1,Y(IDX)=$G(^ORD(101.41,DLG,50,IEN,0))
 Q
DEF(Y,DLG) ; Return format mapping for a dialog
 ; Y(n): CtrlName^DlgPtr^FmtSeq^Fmt^Omit^Lead^Trail^Mult?^chd1~chd2~...
 I DLG="NOT IMPLEMENTED" S Y(0)="0^0" Q                 ; for testing
 S DLG=$O(^ORD(101.41,"B",DLG,0))
 N I,J,K,N,X0,X2,XW,DPTR
 S Y(0)=$P(^ORD(101.41,DLG,0),U,5)_U_DLG
 S I=0,N=0
 F  S I=$O(^ORD(101.41,DLG,10,I)) Q:I'>0  D
 . S X0=$G(^ORD(101.41,DLG,10,I,0)),DPTR=$P(X0,U,2)
 . S X2=$G(^ORD(101.41,DLG,10,I,2))
 . S XW=$G(^ORD(101.41,DLG,10,I,"W"))
 . S N=N+1,Y(N)=$P(XW,U,1)_U_DPTR_U_X2,CHLD=""
 . S J=0 F  S J=$O(^ORD(101.41,DLG,10,"DAD",DPTR,J)) Q:'J  D
 . . S K=0 F  S K=$O(^ORD(101.41,DLG,10,"DAD",DPTR,J,K)) Q:'K  D
 . . . S CHLD=CHLD_$P(^ORD(101.41,DLG,10,K,0),U,2)_"~"
 . S $P(Y(N),U,8)=CHLD
 Q
FORMID(VAL,ORIFN) ; procedure
 ; Returns the Dialog Form ID
 N X
 S VAL=0,X=$P(^OR(100,+ORIFN,0),U,5)
 Q:$P(X,";",2)'="ORD(101.41,"
 S VAL=+$P($G(^ORD(101.41,+X,5)),U,5)
 ; I X S VAL=$P($G(^XTV(8989.52,+X,0)),U,2)
 Q
GET4EDIT(LST,ORIFN) ; procedure
 ; return responses in format that can be used by dialog
 N ILST,PRMT,INST,DLG,ORDIALOG S ILST=0
 I '$D(ORIFN) S LST=0 Q
 S ORIFN=+ORIFN,DLG=+$P(^OR(100,ORIFN,0),U,5)
 D GETDLG1^ORCD(DLG),GETORDER^ORCD("^OR(100,"_ORIFN_",4.5)")
 S PRMT=0 F  S PRMT=$O(ORDIALOG(PRMT)) Q:'PRMT  D
 . S INST=0 F  S INST=$O(ORDIALOG(PRMT,INST)) Q:'INST  D
 . . S ILST=ILST+1,LST(ILST)="~"_PRMT_U_INST_U_$P(ORDIALOG(PRMT),U,3)
 . . S ILST=ILST+1,LST(ILST)="d"_ORDIALOG(PRMT,INST)
 . . I $E(ORDIALOG(PRMT,INST))=U D                 ; load word processing
 . . . N I,REF S I=0,REF=ORDIALOG(PRMT,INST)
 . . . F  S I=$O(@REF@(I)) Q:'I  S ILST=ILST+1,LST(ILST)="t"_^(I,0)
 . . E  S $P(LST(ILST),U,2)=$$EXT^ORCD(PRMT,INST)  ; load external value
 . . I "R"[$E(ORDIALOG(PRMT,0)) D
 . . . S $P(LST(ILST),U,2)=$$UP^XLFSTR($$FMTE^XLFDT(ORDIALOG(PRMT,INST)))
 Q
EXTDT(X) ; Return an external date time that can be interpreted by %DT
 I $E(X)="T" Q "TODAY"_$E(X,2,255)
 I $E(X)="V" Q "NEXT VISIT"_$E(X,2,255)
 Q ""
SAVE(Y,DFN,ORNP,LOC,DLG,ORWDACT,RSP) ; procedure
 ; Save order
 N ORDIALOG,ORL,ORVP,ORIFN,ORDUZ,ORSTS,ORDG,OREVENT,ORCAT,ORDA
 I $P(^ORD(101.41,+DLG,0),U)="PSO OERR" S ORCAT="O"
 I $P(^ORD(101.41,+DLG,0),U)="PSJ OR PAT OE" S ORCAT="I"
 S ORVP=DFN_";DPT(",ORL(2)=LOC_";SC(",ORL=ORL(2)
 D GETDLG^ORCD(DLG)
 M ORDIALOG=RSP S ORDIALOG=DLG
 I ORWDACT="N" D
 . D EN^ORCSAVE
 . S Y="" I ORIFN D GETBYIFN^ORWORR(.Y,ORIFN)
 I $P(ORWDACT,U,1)="E" D
 . S ORIFN=+$P(ORWDACT,U,2) D XX^ORCSAVE
 . S Y="" S ORIFN=+$P(ORWDACT,U,2)_";"_ORDA D GETBYIFN^ORWORR(.Y,ORIFN)
 Q
SIGN(ERRLST,DFN,ORNP,LOC,ORWSIGN) ; procedure
 ; Sign orders (ORIFN;ACT^RELSTS^SIGSTS^NATR)
 N ORVP,ORL,IDX,ANERROR,ERRCNT
 S ORVP=DFN_";DPT(",ORL(2)=LOC_";SC(",ORL=ORL(2),ERRCNT=0
 I '$D(^XUSEC("ORES",DUZ)) S ERRLST(1)=0_U_"Must have ORES key." Q
 S IDX=0 F  S IDX=$O(ORWSIGN(IDX)) Q:'IDX  S X=ORWSIGN(IDX) D
 . ; ** change NATR when GUI changed to pass Nature in 4th piece
 . S ORIFN=$P(X,U),RELSTS=$P(X,U,2),SIGSTS=$P(X,U,3),NATR="E" ;$P(X,U,4)
 . I SIGSTS=2 D NOTIF^ORCSIGN S ANERROR=""
 . I SIGSTS'=2 D EN^ORCSEND(ORIFN,"",SIGSTS,RELSTS,NATR,"",.ANERROR)
 . I $L(ANERROR) D  Q           ; don't print if an error occurred
 . . S ERRCNT=ERRCNT+1,ERRLST(ERRCNT)=$P(ORWSIGN(IDX),U)_U_ANERROR
 . . K ORWSIGN(IDX)
 . I RELSTS=0 K ORWSIGN(IDX) Q  ; don't print if unreleased
 . S ORWSIGN(IDX)=$P(ORWSIGN(IDX),U)
 D PRINTS^ORWD1(.ORWSIGN,LOC)
 Q
VALIDACT(VAL,ORIFN,ACTION) ;procedure
 ; Return 1 if action is valid for this order, otherwise 0^error
 S VAL=$$VALID^ORCACT0(ORIFN,ACTION,.ERR)
 I VAL=0 S VAL=VAL_U_ERR
 Q
SAVEACT(LST,ORIFN,ACTION,REASON,DFN,ORNP,LOC) ;procedure
 ; Save this action for the order (it is still unsigned/unreleased)
 N ORDIALOG,ORL,ORVP,ORDUZ,ORSTS,ORDG,OREVENT,ACTDA,SIGSTS,RELSTS,ASTS
 S ORVP=DFN_";DPT(",ORL(2)=LOC_";SC("
 S SIGSTS=2,RELSTS=11
 I '$P(ORIFN,";",2) S $P(ORIFN,";",2)=1
 I (ACTION="FL")!(ACTION="UF")!(ACTION="WC") S SIGSTS=3,RELSTS=""
 S ASTS=$P(^OR(100,+ORIFN,8,+$P(ORIFN,";",2),0),U,15)
 I ACTION="DC",((ASTS=10)!(ASTS=11)) D  Q       ; exit here if DELETE
 . D GETBYIFN^ORWORR(.LST,ORIFN)
 . S $P(LST(1),U,1)="~0",LST(2)="tDELETED - "_$E(LST(2),2,245)
 . D CANCEL^ORCSAVE2(ORIFN)
 ;
 ; the only valid action for ActDA>1 is deletion, so only orders 
 ; identified by ORIFN;1 should reach this point
 ;
 I $P(ORIFN,";",2)>1 S $ECODE=",Uorder action invalid," Q
 I ACTION="FL" S $P(^OR(100,+ORIFN,6),U,1)=1
 I ACTION="UF" S $P(^OR(100,+ORIFN,6),U,1)=0
 I ACTION'="RN" D
 . S ACTDA=$$ACTION^ORCSAVE(ACTION,+ORIFN,ORNP,REASON)
 I ACTION="RN" D
 . N ORDA,ORDIALOG,PRMT,SAVIFN,X0
 . S SAVIFN=+ORIFN,X0=^OR(100,+ORIFN,0)
 . I $P(X0,U,5)["101.41," D                        ; version 3
 . . S ORDIALOG=+$P(X0,U,5),ORCAT=$P(^OR(100,+ORIFN,0),U,12)
 . . D GETDLG^ORCD(ORDIALOG),GETORDER^ORCD(+ORIFN)
 . E  D                                            ; version 2.5 generic
 . . S ORDIALOG=$O(^ORD(101.41,"B","OR GXTEXT WORD PROCESSING ORDE",0))
 . . D GETDLG^ORCD(ORDIALOG)
 . . S PRMT=$O(^ORD(101.41,"B","OR GTX WORD PROCESSING 1",0))
 . . S ORDIALOG(PRMT,1)=$NA(^TMP("ORWORD",$J,PRMT,1))
 . . M ^TMP("ORWORD",$J,PRMT,1)=^OR(100,+ORIFN,1)
 . . S PRMT=$O(^ORD(101.41,"B","OR GTX START DATE/TIME",0))
 . . I $P(X0,U,9) S ORDIALOG(PRMT,1)=$P(X0,U,9)
 . D RN^ORCSAVE I 'ORIFN S $ECODE=",UCPRS renew order,"
 . S ACTDA=ORDA,ORIFN=SAVIFN
 I (ACTION="FL")!(ACTION="UF") S ACTDA=1
 D GETBYIFN^ORWORR(.LST,+ORIFN_";"_ACTDA)
 S $P(LST(1),U,12)=ACTDA
 Q
