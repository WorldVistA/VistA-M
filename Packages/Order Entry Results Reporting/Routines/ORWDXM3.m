ORWDXM3 ; SLC/KCM/JLI - Quick Orders ;09/10/09
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**10,85,131,132,141,185,187,190,195,215,243,303,296,280**;Dec 17, 1997;Build 85
 ;
VALCOUNT(NAME,ORDIALOG) ;
 N COUNT,IEN,NUM
 S NUM=0,COUNT=0
 S IEN=$P($G(ORDIALOG("B",NAME)),U,2) Q:IEN'>0
 F  S NUM=$O(ORDIALOG(IEN,NUM)) Q:+NUM'>0  S COUNT=COUNT+1
 Q COUNT
 ;
ISMISSFL(ORDIALOG,IVTYPE) ;
 N ADDCNT,RESULT,SOLCNT,STRCNT
 S RESULT=0
 S ADDCNT=$$VALCOUNT("ADDITIVE",.ORDIALOG)
 S STRCNT=$$VALCOUNT("STRENGTH",.ORDIALOG)
 S SOLCNT=$$VALCOUNT("SOLUTION",.ORDIALOG)
 I IVTYPE'="I",ADDCNT'=STRCNT S RESULT=1
 I IVTYPE="I" D
 .I ADDCNT=0,SOLCNT>0 Q
 .I ADDCNT=0 S RESULT=1 Q
 .I ADDCNT'=STRCNT S RESULT=1 Q
 Q RESULT
 ;
IVADFCHK(ORDIALOG) ;
 ; This line tag checks to see if there are the same number of values
 ;for ADDITIVE and Additive Frequency. This also checks to see if
 ;the value assigned to ADDFREQ is one of the three possible values
 ;All Bags, 1 bag/day, See Comments. If See Comments it also checks
 ;for text in the comment section.
 N ADDCNT,ADDFCNT,ADDFREQ,COMMENT,FREQ,INST,RESULT
 S ADDCNT=$$VALCOUNT("ADDITIVE",.ORDIALOG)
 S ADDFCNT=$$VALCOUNT("ADDITIVE FREQUENCY",.ORDIALOG)
 I ADDCNT'=ADDFCNT Q 0
 S ADDFREQ=$O(^ORD(101.41,"AB","OR GTX ADDITIVE FREQUENCY",""))
 S COMMENT=$O(^ORD(101.41,"AB","OR GTX WORD PROCESSING 1",""))
 I +$G(ADDFREQ)'>0 Q O
 S INST=0,RESULT=1
 F  S INST=$O(ORDIALOG(ADDFREQ,INST)) Q:INST'>0!(RESULT=0)  D
 .S FREQ=$$ADDFRQCV^ORMBLDP1($G(ORDIALOG(ADDFREQ,INST)),"O")
 .I FREQ="A"!(FREQ=1) Q
 .I FREQ="" S RESULT=0 Q
 .I FREQ="S",'$L($G(ORDIALOG(COMMENT,1))) S RESULT=0 Q
 Q RESULT
 ;
KEYVAR(DLG)  ; Parse entry action for key variables & return in string
 ; RV=CollTp^Samp^Spec^CollDt^Urg^Sched^NoComm^NoDiag^NoProv^NoRsn
 N XCODE,RV,POS,Z
 S XCODE=$G(^ORD(101.41,DLG,3)),RV=""
 I '$L(XCODE) Q ""
 S POS=$F(XCODE,"LRFZX=")    I POS S $P(RV,U,1)=$$VALUE(XCODE,POS)
 S POS=$F(XCODE,"LRFSAMP=")  I POS S $P(RV,U,2)=$$VALUE(XCODE,POS)
 S POS=$F(XCODE,"LRFSPEC=")  I POS S $P(RV,U,3)=$$VALUE(XCODE,POS)
 S POS=$F(XCODE,"LRFDATE=")  I POS S $P(RV,U,4)=$$VALUE(XCODE,POS)
 S POS=$F(XCODE,"LRFURG=")   I POS S $P(RV,U,5)=$$VALUE(XCODE,POS)
 S POS=$F(XCODE,"LRFSCH=")   I POS S $P(RV,U,6)=$$VALUE(XCODE,POS)
 S POS=$F(XCODE,"PSJNOPC=")  I POS S $P(RV,U,7)=$$VALUE(XCODE,POS)
 S POS=$F(XCODE,"GMRCNOPD=") I POS S $P(RV,U,8)=$$VALUE(XCODE,POS)
 S POS=$F(XCODE,"GMRCNOAT=") I POS S $P(RV,U,9)=$$VALUE(XCODE,POS)
 S POS=$F(XCODE,"GMRCREAF=") I POS S $P(RV,U,10)=$$VALUE(XCODE,POS)
 S POS=$F(XCODE,"ORFORGET=") I POS D
 . ; need to change this so that it is executed in SETKEYV so
 . ; that it is executed each time menu is revisited
 . N ORFORGET S ORFORGET=$$VALUE(XCODE,POS)
 . I ORFORGET K ^TMP("ORECALL",$J,+ORFORGET)
 . E  K ^TMP("ORECALL",$J)
 Q RV
VALUE(STR,BEG) ; Return value of "var=" (copied from ORCONVRT)
 N X,Y,I S X=$E(STR,BEG,999),Y=""
 S:$E(X)="""" X=$E(X,2,999) ; strip leading "
 F I=1:1:$L(X) S Z=$E(X,I) Q:(Z=",")!(Z=" ")!(Z="""")  S Y=Y_Z
 Q $TR(Y,U,"")
 ;
SETKEYV(X)      ; Set the key variables based on contents of X
 I $L($P(X,U,1))  S LRFZX=$P(X,U,1)
 I $L($P(X,U,2))  S LRFSAMP=$P(X,U,2)
 I $L($P(X,U,3))  S LRFSPEC=$P(X,U,3)
 I $L($P(X,U,4))  S LRFDATE=$P(X,U,4)
 I $L($P(X,U,5))  S LRFURG=$P(X,U,5)
 I $L($P(X,U,6))  S LRFSCH=$P(X,U,6)
 I $L($P(X,U,7))  S PSJNOPC=$P(X,U,7)
 I $L($P(X,U,8))  S GMRCNOPD=$P(X,U,8)
 I $L($P(X,U,9))  S GMRCNOAT=$P(X,U,9)
 I $L($P(X,U,10)) S GMRCREAF=$P(X,U,10)
 Q
DLGINFO(IEN,MODE)    ; return information about a dialog
 ; IEN=DlgIEN or ORIFN, MODE=0:Dlg,1:Copy,2:Change
 ; RESULT=DlgIEN^DlgType^FormID^DGrp
 ; If MODE="1;T",don't check "PS MEDS" for transfer order
 ; PSMDGP=1: Unit/Dose  Group
 ; PSMDGP=2: OutPatient Group
 N X0,DLGIEN,TYP,FID,DGRP,PSMDGP,ISXF
 S PSMDGP=0,ISXF=""
 S ISXF=$P(MODE,";",2)
 S MODE=+MODE
 S DLGIEN=IEN I MODE,(ISXF'="T") D
 . S DLGIEN=+$P($G(^OR(100,+IEN,0)),U,5)
 . I $P(^ORD(101.41,DLGIEN,0),U)="PS MEDS" D
 . . N PTCAT S PTCAT=$P($G(^OR(100,+IEN,0)),U,12)
 . . I PTCAT="I" S DLGIEN=$O(^ORD(101.41,"B","PSJ OR PAT OE",0)),PSMDGP=1
 . . I PTCAT="O" S DLGIEN=$O(^ORD(101.41,"B","PSO OERR",0)),PSMDGP=2
 I MODE,(ISXF="T") S DLGIEN=+$P($G(^OR(100,+IEN,0)),U,5)
 S X0=$G(^ORD(101.41,DLGIEN,0)),TYP=$P(X0,U,4),DGRP=$P(X0,U,5)
 I MODE S DGRP=+$P($G(^OR(100,+IEN,0)),U,11)
 ;JD NEW START 11/13/02
 I DLGIEN=$O(^ORD(101.41,"B","PSJ OR PAT OE",0)) S PSMDGP=1
 I DLGIEN=$O(^ORD(101.41,"B","PSO OERR",0)) S PSMDGP=2
 ;JD NEW END 11/13/02
 ; for copy or change, if the base dialog has changed, use it's info
 I MODE,$G(ORDIALOG),(+DLGIEN'=+ORDIALOG),(PSMDGP=0) D
 . S DLGIEN=+ORDIALOG,DGRP=$P(^ORD(101.41,+ORDIALOG,0),U,5)
 D FORMID^ORWDXM(.FID,DLGIEN)
 Q DLGIEN_U_TYP_U_FID_U_DGRP
 ;
CHKDSBL(LST,ID,MODE)  ; return message if dialog disabled
 ; ID=DlgIEN or ORIFN, MODE=0:Dialog,1:Copy,2:Change
 ; LST=QL_REJECT + disabled message or unchanged
 S DLGIEN=+ID I MODE S DLGIEN=+$P($G(^OR(100,+ID,0)),U,5)
 S X0=$G(^ORD(101.41,DLGIEN,0)),X=$P(X0,U,3)
 I '$L(X),($P(X0,U,4)="Q") D  ; check default dialog
 . S DLGIEN=+$$DEFDLG^ORWDXQ($P(X0,U,5))
 . S X=$P($G(^ORD(101.41,DLGIEN,0)),U,3)
 I $L(X) D
 . I MODE D GETTXT^ORWORR(.LST,ID) S LST(.6)="",LST(.7)="Cannot "_$S(MODE=1:"Copy",1:"Change")_" -"
 . S LST(0)="8^0",LST(.5)="Dialog Disabled:  "_X
 Q
CHKVACT(LST,ID,MODE,ORNP)  ; return message if action not valid
 ; ID=DlgIEN or ORIFN, MODE=0:Dialog,1:Copy,2:Change
 ; LST=QL_REJECT + invalid action message or unchanged
 Q:'MODE  ; not an action on an order
 N X,ACT S ACT=$S(MODE=1:"RW",MODE=2:"XX",1:"")
 D VALID^ORWDXA(.X,ID,ACT,ORNP)
 I $L(X) D GETTXT^ORWORR(.LST,ID) D
 . S LST(0)="8^0",LST(.5)=X,LST(.6)="",LST(.7)="Cannot "_$S(MODE=1:"Copy",1:"Change")_" -"
 Q
CHKCOPY(LST,ID,FLDS)  ; return message if can't copy this order
 ; ID=ORIFN;ACT FLDS=EventType in 7th piece
 ; LST=QL_REJECT + cannot copy message or unchanged
 I "^A^D^T^"'[(U_$E($P(FLDS,U,7))_U) Q             ; not event delayed
 N PKG S PKG=$P($G(^OR(100,+ID,0)),U,14)
 S PKG=$$NMSP^ORCD(PKG) I PKG="OR"!(PKG="PS") Q    ; xfer meds, generics
 N ORWCAT S ORWCAT=$P($G(^OR(100,+ID,0)),U,12)
 I ORWCAT="I",("^A^T^"[(U_$E($P(FLDS,U,7))_U)) Q   ; admit, xfer inpt
 I ORWCAT="O",$E($P(FLDS,U,7))="D" Q               ; discharge outpt
 D GETTXT^ORWORR(.LST,ID)
 I ORWCAT="I" S LST(.5)="inpatient order to outpatient -"
 I ORWCAT="O" S LST(.5)="outpatient order to inpatient -"
 S:$D(LST(.5)) LST(.5)="Cannot copy the following "_LST(.5)
 S LST(0)="8^0",LST(.7)=""
 Q
BLD4CHG(LST,ID,FLDS)  ; build responses for an edit
 ; ID=ORIFN;ACT FLDS=unused right now
 ; LST(0)=Qlvl^RespID(XOrderID)^DlgIEN^DlgType^FormID^DGrp
 N OIDX,OI,CNT
 S (OI,OIDX,CNT)=0
 S:$D(^OR(100,+ID,4.5,"ID","ORDERABLE")) OIDX=$O(^OR(100,+ID,4.5,"ID","ORDERABLE",0))
 I $D(^OR(100,+ID,4.5,OIDX)) D
 . F  S CNT=$O(^OR(100,+ID,4.5,OIDX,CNT)) Q:'CNT  D
 . . S OI=^(CNT) D VALDOI
 I +LST(0)=8 S LST(.5)="You can not change this order." Q
 S LST(0)="0^X"_ID_U_$$DLGINFO(+ID,2)
 S $P(LST(0),U,4)="X"
 Q
GETIVTYP() ;
 N RESULT,TYPEIEN
 S RESULT=""
 S TYPEIEN=$O(^ORD(101.41,"B","OR GTX IV TYPE","")) I TYPEIEN'>0 Q RESULT
 S RESULT=$G(ORDIALOG(TYPEIEN,1))
 Q RESULT
 ;
VALDOI ; Validate the Orderable Items
 N ORQUIT,ORPS
 I $G(^ORD(101.43,OI,.1)),^(.1)'>$$NOW^XLFDT D
 . S ORQUIT=1
 . S LST(0)="8^0"
 I $D(ORQUIT) Q:ORQUIT
 S ORPS=$G(^ORD(101.43,+OI,"PS"))
 I $P(ORPS,U,1,4)="0^0^0^0",($P(ORPS,U,7)=0) S LST(0)="8^0"
 Q
VERDUR(ORDIALOG) ;
 ;check for duration value if a THEN conjunation is used
 N CONJ,CONVALUE,DUR,I,SUCC
 S SUCC=1
 S CONJ=$$PTR^ORCDPS1("AND/THEN")
 S DUR=$$PTR^ORCDPS1("DURATION")
 S I=0 F  S I=$O(ORDIALOG(CONJ,I)) Q:I'>0!(SUCC=0)  D
 . I $$UP^XLFSTR($E($G(ORDIALOG(CONJ,I)),1))="T" D
 . . I '$L($G(ORDIALOG(DUR,I))) S SUCC=0
 Q SUCC
 ;
VERORD(OIEN) ;
 N IFN,INFUSE,INFUID,ODG,ODP,ASSIV,SUCC,TYPE
 S SUCC=0,IFN=ORDIALOG
 S ODP=+$P($G(^ORD(101.41,+IFN,0)),U,7),ODG=+$P($G(^(0)),U,5)
 S ODP=$$GET1^DIQ(9.4,+ODP_",",1),ODG=$P($G(^ORD(100.98,ODG,0)),U,3)
 I ODP'["PS" Q 1
 I ODP="PSH" Q 1
 ;check infusion rate for IV QO
 I ODG="IV RX"!(ODG="TPN") D  Q SUCC
 .S TYPE=$$GETIVTYP
 .I TYPE="" Q SUCC
 .S PASSIV=$$IVRTECHK
 .I PASSIV=0 Q SUCC
 .S INFUID=$O(^ORD(101.41,"B","OR GTX INFUSION RATE",0))
 .S INFUSE=$G(ORDIALOG(INFUID,1))
 .S SUCC=$$VALINF(TYPE,INFUSE)
 .I SUCC=0 Q
 .I TYPE="C" S SUCC=$$IVADFCHK(.ORDIALOG)
 I (ODP="PSJ")!(ODP="PSO"),ODG'="IV RX",ODG'="TPN" S SUCC=$$VERDUR(.ORDIALOG)
 Q SUCC
 ;
VALINF(TYPE,INFUSE) ;
 N SUCC
 S SUCC=0
 I TYPE="I" D  Q SUCC
 .I INFUSE="" S SUCC=1 Q
 .I $TR(INFUSE,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")["INFUSE OVER" S SUCC=1 Q
 .I $L(INFUSE)>4 Q
 Q 1
 ;
VALQO(IFN) ;Check to see if it's a good QO med
 ;If it's an IV QO: check if infusion rate entered
 ;If it's an UD QO: check if dosage entered
 ;regular order treated as good QO
 ;
 I IFN[";",($$UPCTCHK^ORWDXA(+IFN)) Q 0
 I $P($G(^ORD(101.41,IFN,0)),U,4)'="Q" Q 1
 N ODP,ODG,INFUID,INFUSE,DSAGEID,SUCC,PASSIV,TYPE
 S SUCC=0
 S ODP=+$P($G(^ORD(101.41,IFN,0)),U,7),ODG=+$P($G(^(0)),U,5)
 S ODP=$$GET1^DIQ(9.4,+ODP_",",1),ODG=$P($G(^ORD(100.98,ODG,0)),U,3)
 I ODP'["PS" Q 1
 I ODP="PSH" Q 1
 ;check infusion rate for IV QO
 I ODG="IV RX"!(ODG="TPN") D
 . S INFUID=$O(^ORD(101.41,"B","OR GTX INFUSION RATE",0))
 . S TYPE=$$GETIVTYP
 . I TYPE="" Q
 . I $D(ORDIALOG(INFUID,1)) D
 . . I TYPE="I" D  Q
 . . . S INFUSE=$G(ORDIALOG(INFUID,1))
 . . . I INFUSE="" Q
 . . . I INFUSE["INFUSE OVER" S SUCC=1 Q
 . . . I $L(INFUSE)>4 Q
 . . . I +INFUSE>0 S INFUSE="INFUSE OVER "_INFUSE_" Minutes"
 . . . S ORDIALOG(INFUID,1)=INFUSE,SUCC=1
 . . S SUCC=1
 . ; additive frequency check/infusion rate checks for continuous orders
 . I TYPE="C" D  I SUCC=0 Q
 . . I $D(ORDIALOG(INFUID,1)) S SUCC=1 I SUCC=0 Q
 . . S SUCC=$$IVADFCHK(.ORDIALOG)
 . I SUCC=0 Q
 . I '$D(ORDIALOG(INFUID,1)),TYPE="I" S SUCC=1
 . S PASSIV=$$IVRTECHK
 . I SUCC=0 Q
 . I PASSIV=0 S SUCC=0
 . I SUCC=1,$$ISMISSFL(.ORDIALOG,TYPE)=1 S SUCC=0
 ;check dosage for UD QO
 I (ODP="PSJ")!(ODP="PSO"),ODG'="IV RX",ODG'="TPN" D
 . S DSAGEID=$O(^ORD(101.41,"B","OR GTX INSTRUCTIONS",0))
 . I $D(ORDIALOG(DSAGEID,1)) S SUCC=1
 . I SUCC=0 Q
 . ;
 . S SUCC=$$VERDUR(.ORDIALOG)
 ;
 I SUCC=1,$P($G(^ORD(101.41,IFN,5)),U,8) D
 .N COMMID,WPCNT
 .S COMMID=$O(^ORD(101.41,"B","OR GTX WORD PROCESSING 1",0))
 .S COMMID=$O(^ORD(101.41,IFN,6,"D",COMMID,0))
 .I COMMID S WPCNT=0 F  S WPCNT=$O(^ORD(101.41,IFN,6,COMMID,2,WPCNT)) Q:'WPCNT!('SUCC)  D
 ..I ^ORD(101.41,IFN,6,COMMID,2,WPCNT,0)["^" S SUCC=0
 Q SUCC
 ;
IVRTECHK() ;
 N RTIEN,RTVALUE,RESULT
 N CNT,NUM,ORDERIDS,OIIEN,OTYPE,ROUTE
 S CNT=0,RESULT=0
 S RTIEN=+$P($G(ORDIALOG("B","ROUTE")),U,2) I RTIEN'>0 Q RESULT
 S RTVALUE=+$G(ORDIALOG(RTIEN,1)) I RTVALUE'>0 Q RESULT
 F OTYPE="SOLUTION","ADDITIVE" D
 .S OIIEN=+$P($G(ORDIALOG("B",OTYPE)),U,2) I OIIEN>0 D
 ..S NUM=0 F  S NUM=$O(ORDIALOG(OIIEN,NUM)) Q:NUM'>0  I +$G(ORDIALOG(OIIEN,NUM))>0 D
 ...S CNT=CNT+1,ORDERIDS(CNT)=ORDIALOG(OIIEN,NUM)
 I $D(ORDERIDS)=0 Q
 S ROUTE=$$IVQOVAL^ORWDPS33(.ORDERIDS,RTVALUE)
 I ROUTE="" S ORDIALOG(RTIEN,1)=ROUTE
 I ROUTE'="" S RESULT=1
 ;K ^TMP($J,"ORWDXM3 IVRTECHK")
 ;D ALL^PSS51P2(RTVALUE,,,,"ORWDXM3 IVRTECHK")
 ;I +^TMP($J,"ORWDXM3 IVRTECHK",RTVALUE,6)'=1 S ORDIALOG(RTIEN,1)="",RESULT=0
 ;K ^TMP($J,"ORWDXM3 IVRTECHK")
 Q RESULT
 ;
ISUDQO(ORY,DLGID) ;True: is unit dose quick order
 S ORY=0
 Q:'$D(^ORD(101.41,DLGID,0))
 N CLODGRP,UDGRP1,UDGRP2,DLGTYP,DLGGRP
 S UDGRP1=$O(^ORD(100.98,"B","UD RX",0))
 S UDGRP2=$O(^ORD(100.98,"B","I RX",0))
 S CLODGRP=$O(^ORD(100.98,"B","CLINIC ORDERS",""))
 S DLGTYP=$P($G(^ORD(101.41,DLGID,0)),U,4)
 S DLGGRP=$P($G(^ORD(101.41,DLGID,0)),U,5)
 I (DLGTYP="Q"),((DLGGRP=UDGRP1)!(DLGGRP=UDGRP2)!(DLGGRP=CLODGRP)) S ORY=1
 Q
