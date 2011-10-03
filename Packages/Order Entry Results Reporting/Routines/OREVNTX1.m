OREVNTX1 ; SLC/JLI - Event delayed orders RPC's ;8/20/09  13:53
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**141,165,149,243,280**;Dec 17, 1997;Build 85
 ;
PUTEVNT(ORY,DFN,EVT,ORIFN) ; Save new patient delayed events to file 100.2
 S ORY=$$NEW^OREVNT(DFN,EVT,ORIFN)
 Q
 ;
GTEVT(ORY,PTEVT) ; Return Event infomation based on PTEVT ptr #100.2
 ;EVTID     ptr #100.5
 Q:'+PTEVT
 N EVTID,EVTTYPE,EVTNAME,EVTDISP,EVTDLG,PRTEVT
 S (EVTTYPE,EVTNAME,EVTDISP,PRTEVT)=""
 S EVTDLG=0
 I '$P(^ORE(100.2,+$G(PTEVT),0),U,2) Q
 S EVTID=$$EVT^OREVNTX(PTEVT)
 S PRTEVT=$P(^ORD(100.5,EVTID,0),U,12)
 I PRTEVT S EVTTYPE=$P(^ORD(100.5,PRTEVT,0),U,2)
 E  S EVTTYPE=$P(^ORD(100.5,EVTID,0),U,2)
 I $D(^ORD(100.5,EVTID,0)) D
 . S EVTNAME=$P(^ORD(100.5,EVTID,0),U,1)
 . S EVTDISP=$P(^ORD(100.5,EVTID,0),U,8)
 . S EVTDLG=$P(^ORD(100.5,EVTID,0),U,4)
 S ORY=EVTTYPE_U_EVTID_U_EVTNAME_U_EVTDISP_U_EVTDLG
 Q
GTEVT1(ORY,EVT) ; Return Event information based on EVT ptr #100.5
 ;EVT    ptr #100.5
 Q:'+EVT
 N EVTTYPE,EVTNAME,EVTDISP,EVTDLG,PRTEVT
 S (EVTDLG,PRTEVT)=0
 S PRTEVT=$P(^ORD(100.5,+EVT,0),U,12)
 I PRTEVT>0 S EVTTYPE=$P(^ORD(100.5,PRTEVT,0),U,2)
 E  S EVTTYPE=$P(^ORD(100.5,+EVT,0),U,2)
 S EVTNAME=$P($G(^ORD(100.5,+EVT,0)),U,1)
 S EVTDISP=$P($G(^ORD(100.5,+EVT,0)),U,8)
 S EVTDLG=$P($G(^ORD(100.5,+EVT,0)),U,4)
 S ORY=EVTTYPE_U_EVT_U_EVTNAME_U_EVTDISP_U_EVTDLG
 Q
 ;
EVT(ORY,PTEVT) ; Return Event ptr #100.5, given PTEVT ptr #100.2
 Q:'+PTEVT
 S ORY=$$EVT^OREVNTX(PTEVT)
 Q
 ; 
EXISTS(ORY,DFN,EVT) ;Returns PtEvtID ptr #100.2 if patient already has delayed orders
 I '+EVT S ORY=0 Q
 N PTEVT S (PTEVT,ORY)=0
 S PTEVT=$O(^ORE(100.2,"AE",+DFN,+EVT,PTEVT))
 I PTEVT>0 S ORY=PTEVT
 Q
 ;
TYPEXT(ORY,DFN,EVT) ; does EVT has delayed orders?
 ; 1 if Patient DFN has delayed orders for EVT
 ; 2 if Parent/Sibling event has delayed orders
 ; 0 if No delayed orders for EVT
 Q:'+EVT
 S ORY=$$EXISTS^OREVNTX(DFN,EVT)
 Q
 ;
MATCH(ORY,DFN,EVT) ;If Pt's current data match selected event
 ;DFN: patient DFN
 ;EVT: ptr to #100.5
 S ORY=0
 Q:('+DFN)!('+EVT)
 S ORY=$$MATCH^OREVNT(DFN,EVT)
 N TS,TSNM
 S TS=$S($G(ORTS):+ORTS,1:+$G(^DPT(DFN,.103)))
 S TSNM=$P($G(^DIC(45.7,TS,0)),U)
 S:ORY ORY=ORY_U_TSNM
 Q
 ;
NAME(ORY,PTEVT) ; Return Event name from #100.5, given PTEVT ptr #100.2
 I PTEVT'>0 S ORY="" Q
 S ORY=$$NAME^OREVNTX(PTEVT)
 Q
 ;
DIV(ORY,PTEVT) ; Return division for PTEVT ptr #100.2
 Q:'+PTEVT
 S ORY=$$DIV^OREVNTX(PTEVT)
 Q
 ;
DIV1(ORY,EVT) ; Return division for EVT ptr #100.5
 Q:'+EVT
 S ORY=+$P($G(^ORD(100.5,+EVT,0)),U,3) S:ORY<1 ORY=+$G(DUZ(2))
 Q
 ;
LOC(ORY,PTEVT) ; Return default hospital location ^SC( for PTEVT ptr #100.2
 Q:'+PTEVT
 S ORY=$$LOC^OREVNTX(PTEVT)
 S ORY=+ORY
 Q
 ;
LOC1(ORY,EVT) ; Return default hospital location ^SC( for EVT ptr #100.5
 Q:'+EVT
 S ORY=+$P($G(^ORD(100.5,+EVT,0)),U,9) S:ORY<1 ORY=+$G(ORL)
 Q
 ;
CHGEVT(ORY,NEWEVT,ORIDS) ; Change order's event
 N ORI
 S ORI=0
 F  S ORI=$O(ORIDS(ORI)) Q:'+ORI  D
 . D CHGEVT^OREVNTX(+$G(ORIDS(ORI)),NEWEVT)
 Q
 ;
EMPTY(ORY,PTEVT) ; Return 1 if PTEVT doesn't have any orders
 Q:'+PTEVT
 S ORY=$$EMPTY^OREVNTX(PTEVT)
 Q
 ;
DELPTEVT(ORY,PTEVT) ; Delete Patient Event in #100.2
 Q:'+PTEVT
 D CANCEL^OREVNTX(PTEVT)
 Q
 ;
UPDTOR(ORY,PTIFN,ORIFN,PTEVT) ; If delayed order was DCed, then update the EVENT and "AEVNT"
 Q  ;Don't ever need to do this!
CURSPE(ORY,PTIFN) ; Return current treating specialty
 Q:'PTIFN
 N SPEC S SPEC=$$PT^DGPMOBS(PTIFN),ORY=""
 I SPEC'<0 S ORY=$P(SPEC,U,3)_U_$P(SPEC,U,2)_U_$P(SPEC,U) ;name^ien^obs flag
 Q
DFLTEVT(ORY,PVIFN) ; Return default release event based on provider IFN
 N CMEVTLST,IDX
 S CMEVTLST="",IDX=0
 D GETLST^OREV3(.CMEVTLST)
 F  S IDX=$O(CMEVTLST(IDX)) Q:'IDX  D
 . I $P($G(CMEVTLST(IDX)),U,2) S ORY=$P($G(CMEVTLST(IDX)),U) Q
 Q
CMEVTS(ORY,CLOC) ;Return common event list
 N IDX,X0,X,LOC
 S:CLOC>0 LOC=CLOC
 S IDX=0,ORY=""
 D GETLST^OREV3(.ORY)
 F  S IDX=$O(ORY(IDX)) Q:'IDX  D
 . S X0=""
 . S:$L($G(^ORD(100.5,+ORY(IDX),0))) X0=$G(^(0))
 . I '$L($P(X0,U,2)) D
 .. S X=$P(X0,U,12) S:X $P(X0,U,2)=$P($G(^ORD(100.5,+X,0)),U,2)
 . S:$L(X0) ORY(IDX)=+ORY(IDX)_U_X0
 Q
 ;
DELDFLT(ORY,PVIFN) ; Delete default release event
 Q:'PVIFN
 N ORERR
 S ORERR=""
 D DEL^XPAR(PVIFN_";VA(200,","OREVNT DEFAULT",1,.ORERR)
 Q
WRLSTED(LST,LOC,EVTID) ; Return list of dialogs for writing event delayed orders
 ; .Y(n): DlgName^ListBox Text
WRLST1 N ANENT
 S LOC=+$G(LOC)_";SC(" I 'LOC S LOC=""
 S ANENT="ALL^USR.`"_DUZ_"^"_LOC_$S($G(^VA(200,DUZ,5)):"^SRV.`"_+$G(^(5)),1:"")
 N MNU,SEQ,IEN,ITM,TXT,FID,DGRP,X,TYP
 S MNU=$$GET^XPAR(ANENT,"ORWDX WRITE ORDERS EVENT LIST",EVTID,"I") Q:'MNU
 S SEQ=0 F  S SEQ=$O(^ORD(101.41,MNU,10,"B",SEQ)) Q:'SEQ  D
 . S IEN=0 F  S IEN=$O(^ORD(101.41,MNU,10,"B",SEQ,IEN)) Q:'IEN  D
 . . S X=$G(^ORD(101.41,MNU,10,IEN,0)),ITM=+$P(X,U,2),TXT=$P(X,U,4)
 . . S X=$G(^ORD(101.41,ITM,5)),FID=+$P(X,U,5)
 . . S X=$G(^ORD(101.41,ITM,0)),TYP=$P(X,U,4),DGRP=+$P(X,U,5)
 . . S:'$L(TXT) TXT=$P(X,U,2)
 . . I TYP="M" S:'FID FID=1001
 . . S LST(SEQ)=ITM_";"_FID_";"_DGRP_";"_TYP_U_TXT
 Q
 ;
GETDLG(LST,DLGID) ; Return dialog infomation based on the DLGID
 N DIEN,DFID,DTXT,DTYP,DGRP,X0,X5
 S DLGID=+DLGID
 Q:'DLGID
 S X0=^ORD(101.41,DLGID,0),X5=$G(^(5))
 S DGRP=+$P(X0,U,5),DFID=+$P(X5,U,5),DTXT=$P(X5,U,4),DTYP=$P(X0,U,4)
    S:'$L(DTXT) DTXT=$P(X0,U,2)
 I $P(X0,U,4)="M" S:'DFID DFID=1001
 S LST=DLGID_";"_DFID_";"_DGRP_";"_DTYP_U_DTXT
 Q
DONE(LST,PTEVT) ; Terminate PTEvt
 Q:'PTEVT
 D DONE^OREVNTX(PTEVT)
 D ACTLOG^OREVNTX(PTEVT,"MN")
 Q
SETDFLT(ORY,EVT) ;Set personal default event
 N ERR,VAL S ERR=""
 Q:'$D(^ORD(100.5,EVT,0))
 S VAL=$P(^ORD(100.5,EVT,0),U)
 D EN^XPAR(DUZ_";VA(200,","OREVNT DEFAULT",1,VAL,ERR)
 S ORY=ERR
 Q
CPACT(ORY,EVT) ; Return True/False to display active orders for copy
 ; EVT ptr to #100.5
 Q:'EVT
 S ORY=0
 Q:'$D(^ORD(100.5,EVT,0))
 S ORY=$P(^ORD(100.5,EVT,0),U,11)
 Q
PRMPTID(ORY,PRTNM) ;Return event prompt IEN for OR GTX EVENT
 S:$D(^ORD(101.41,"B","OR GTX EVENT")) ORY=$O(^("OR GTX EVENT",0))
 Q
ISDCOD(ORY,ORIFN) ;True: the order need to be filtered out
 N PAS,X3,X0,ORGRPLST,THEGRP,IDX,ODGRP
 S (ORY,IDX)=0
 Q:'$D(^OR(100,+ORIFN,0))
 S X0=$G(^OR(100,+ORIFN,0))
 S ODGRP=$P(X0,U,11)
 D GETLST^XPAR(.ORGRPLST,"ALL","OREVNT EXCLUDE DGRP")
 F  S IDX=$O(ORGRPLST(IDX)) Q:'IDX!ORY  D
 . S THEGRP=$P($G(ORGRPLST(IDX)),U,2)
 . I $$GRPCHK(THEGRP,ODGRP) S ORY=1
 I ORY Q
 S PAS=";1;"
 S:$D(^OR(100,+ORIFN,3)) X3=^OR(100,+ORIFN,3)
 S:(PAS'[(";"_$P(X3,U,3)_";")) ORY=0
 Q
DEFLTS(ORY,EVTID) ;Return default specialty for EVTID(#100.5)
 Q:'+EVTID
 N PRTEVT
 S PRTEVT=0
 S PRTEVT=$P(^ORD(100.5,+EVTID,0),U,12)
 I PRTEVT>0 S EVTID=PRTEVT
 S ORY=$$DEFTS^ORCDADT(EVTID)
 Q
 ;
MULTS(ORY,EVTID) ;Return specialty list for the EVTID(#100.5)
 Q:'+EVTID
 N I,CNT,X,Y S (I,CNT)=0
 N PRTEVT
 S PRTEVT=0
 S PRTEVT=$P(^ORD(100.5,+EVTID,0),U,12)
 I PRTEVT>0 S EVTID=PRTEVT
 F  S I=$O(^ORD(100.5,+$G(EVTID),"TS",I)) Q:I<1  S X=+$G(^(I,0)) D
 . S Y=$$GET1^DIQ(45.7,X_",",.01)
 . S CNT=CNT+1,ORY(CNT)=X_U_Y
 Q
 ;
PRTIDS(ORY,IDS) ;Return some prompt ids from #101.41
 ; treating specialty Id^attending provider id
 N IDX,ORTS,ORATT
 S (ORY,ORTS,ORATT)=""
 S IDX=$O(^ORD(101.41,"B","OR GTX TREATING SPECIALTY",0))
 S:$D(^ORD(101.41,IDX,1)) ORTS=$P($G(^ORD(101.41,IDX,1)),U,2,3)
 S IDX=$O(^ORD(101.41,"B","OR GTX PROVIDER",0))
 S:$D(^ORD(101.41,IDX,1)) ORATT=$P($G(^ORD(101.41,IDX,1)),U,2,3)
 S ORY=ORTS_"~"_ORATT
 Q
 ;
DFLTDLG(ORY,EVTID) ;Return event default dialog IEN
 S ORY=0
 Q:'$D(^ORD(100.5,+EVTID,0))
 S ORY=$P(^ORD(100.5,+EVTID,0),U,4)
 Q
AUTHMREL(ORY,USER) ;1: user can manual release delayed orders 0: can't
 S ORY=$$CANREL^OREV3
 Q
HAVEPRT(ORY,PTEVT) ;return parent patient event from #100.2
 Q:'+PTEVT
 S ORY=""
 S:$L($G(^ORE(100.2,PTEVT,1))) ORY=$P(^(1),U,5)
 Q
GRPCHK(DG,AGRP) ;If an order's group belong to DG group
 N RST
 S RST=0
 N ORGRP
 D GRP^ORQ1(DG)
 S RST=$S($D(ORGRP(AGRP)):1,1:0)
 Q RST
ODPTEVID(ORY,ORID) ;Return PtEvtID based on the ORID
 Q:'$D(^OR(100,+ORID,0))
 S ORY=$P($G(^OR(100,+ORID,0)),U,17)
 Q
COMP(ORY,PTEVT) ;Return 1 or 0 if PTEVT completed or not
 Q:'+PTEVT
 S ORY=$$COMP^OREVNTX(+PTEVT)
 Q
ISHDORD(ORY,ORID) ;Return 1 if it's on-hold med order
 Q:'+ORID
 Q:'$D(^OR(100,+ORID,0))
 N STS,HDSTS,ODGP,INPT,OUPT,MEDS,IVMD
 S HDSTS=$O(^ORD(100.01,"B","HOLD",0))
 S STS=$P($G(^OR(100,+ORID,3)),U,3)
 S INPT=$O(^ORD(100.98,"B","UD RX",0))
 S OUPT=$O(^ORD(100.98,"B","O RX",0))
 S MEDS=$O(^ORD(100.98,"B","RX",0))
 S IVMD=$O(^ORD(100.98,"B","IV RX",0))
 S ODGP=$P(^OR(100,+ORID,0),U,11)
 I (U_INPT_U_OUPT_U_MEDS_U_IVMD_U[U_ODGP_U),(HDSTS=STS) S ORY=1
 Q
ISPASS(ORY,PTEVTID,EVTTYPE) ;Return 1 if it's a pass event
 S ORY=$$EVT^OREVNTX(PTEVTID)
 S ORY=$P($G(^ORD(100.5,+ORY,0)),U,7)
 I EVTTYPE="T",ORY,ORY<4 S ORY=1
 E  S ORY=0
 Q
ISPASS1(ORY,EVTID,EVTTYPE) ;Return 1 if it's a pass event
 S ORY=$P($G(^ORD(100.5,+EVTID,0)),U,7)
 I EVTTYPE="T",ORY,ORY<4 S ORY=1
 E  S ORY=0
 Q
DLGIEN(ORY,DLGNAME) ;Return Order Dialog IEN based on name
 Q:'$D(^ORD(101.41,"B",DLGNAME))
 S ORY=$O(^ORD(101.41,"B",DLGNAME,0))
 Q
GETSTS(ORY,ORDID) ;Return Order status
 Q:'+ORDID
 Q:'$D(^OR(100,+ORDID,0))
 S ORY=$P($G(^OR(100,+ORDID,3)),U,3)
 Q
 ;
CHKORD(ORDER) ;Extrinsic function to determine if order is delayed and the "event" order
 ;
 N VALUE
 S VALUE=0
 I +$P($G(^OR(100,ORDER,0)),U,17),'$O(^ORE(100.2,"AO",ORDER,0)) S VALUE=1 ;Delayed but not the "event" order
 Q VALUE
