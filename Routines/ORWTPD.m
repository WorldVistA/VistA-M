ORWTPD ; slc/jdl - Personal Reference Tool ;6/20/02 11:40am [7/22/03 11:27am]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**109,120,132,148,141,173,195,243**;Dec 17,1997;Build 242
 ;; Allow user to customize the CPRS reports date/time
 ;; and max occurences setting
 ;
SUDF(Y,VALUE) ;----Set user default for all CPRS reports
 N ORERR S ORERR=""
 I VALUE=$$GET^XPAR("DIV^SYS^PKG","ORWRP TIME/OCC LIMITS ALL",1,"I") D DEL^XPAR(DUZ_";VA(200,","ORWRP TIME/OCC LIMITS ALL",1,.ORERR) K ORERR Q
 E  D EN^XPAR(DUZ_";VA(200,","ORWRP TIME/OCC LIMITS ALL",1,VALUE,.ORERR)
 S Y=1
 K ORERR,VALUES1
 Q
 ;
SUINDV(Y,RPTS,VALUE) ;----Set user individual time/occ setting
 ; RPTS format: RPTIen^RPTIen^RPTIen such as 1^2^3
 I $L(RPTS)=0 Q
 N ORERR,RPTID,P1,P7 S ORERR=0
 S (P1,P7)=""
 F I=1:1:$L(RPTS,"^") S RPTID=$P(RPTS,U,I) D
 . S P1=$P($G(^ORD(101.24,RPTID,0)),U),P7=$P($G(^(0)),U,7)
 . I "02345"[P7,(P1'="ORRP IMAGING") D DEL^XPAR("USR.`"_DUZ,"ORWRP TIME/OCC LIMITS INDV",RPTID,.ORERR) Q
 . D EN^XPAR(DUZ_";VA(200,","ORWRP TIME/OCC LIMITS INDV",RPTID,VALUE,.ORERR)
 Q
 ;
GETIMG(Y,RPT) ; ----Get Image (local only) Time/Occ
 N IMGID,BEG,END,MAX
 S IMGID=0,Y=""
 S IMGID=$O(^ORD(101.24,"B","ORRP IMAGING",0))
 D GETINDV(.Y,IMGID)
 I $L(Y) D
 . S BEG=$$DT^ORCHTAB1($P(Y,";"))
 . S END=$$DT^ORCHTAB1($P(Y,";",2))
 . S MAX=$P(Y,";",3)
 . S Y=BEG_"^"_END_"^"_MAX
 I Y="" D GETDEF^ORWRA(.Y)
 Q
 ;
GETINDV(Y,RPT) ;----Get time/occ limits for this report
 ;RPT:  Report IEN of 101.24
 N CTX,X0,X4,X,IMGCTX
 S X0=$G(^ORD(101.24,RPT,0)),X4=$G(^(4))
 I "02345"[($P(X0,U,7)),($P(X0,U)'="ORRP IMAGING") Q
 S CTX="^DIV^SYS^PKG"
 S Y=$$GET^XPAR("USR.`"_DUZ_CTX,"ORWRP TIME/OCC LIMITS INDV",RPT,"I")
 S:'$L(Y) Y=$$GET^XPAR("USR.`"_DUZ_CTX,"ORWRP TIME/OCC LIMITS ALL",1,"I")
 I $P(^ORD(101.24,RPT,0),U,7)=1 S $P(Y,";",3)=""
 I $P(X4,"^",2) S X=$P($P(Y,";"),"-",2) I X,X>$P(X4,"^",2) S Y="T-"_$P(X4,"^",2)_";"_$P(Y,";",2,99)
 Q
 ;
GETSETS(Y) ;----Get time/occ limit set for each report
 N I,CNT,CAT,SEC
 S I=0,CNT=1,RST=""
 F  S I=$O(^ORD(101.24,I)) Q:'I   D
 . I $P($G(^ORD(101.24,I,0)),U,12)'="M" D
 .. S CAT=$P(^ORD(101.24,I,0),U,7),SEC=$P(^(0),U,8)
 .. I $S(CAT=1:1,CAT=6:1,1:0)!($P(^(0),U)="ORRP IMAGING") D
 ... D GETINDV(.RST,I)
 ... I $L($P(^ORD(101.24,I,2),U,4))>0 S Y(CNT)=I_U_$P(^(2),U,4)_" ["_SEC_"]"_U_RST
 ... E  S Y(CNT)=I_U_$P(^ORD(101.24,I,2),U,3)_" ["_SEC_"]"_U_RST
 ... S CNT=CNT+1
 K I,CNT,RST,CAT
 Q
 ;
GETDFLT(Y) ;----Get default time/occ limits for all reports
 N VALUE
 S Y=$$GET^XPAR("USR.`"_DUZ_"^DIV^SYS^PKG","ORWRP TIME/OCC LIMITS ALL",1,"I")
 K VALUE
 Q
 ;
RSDFLT(Y) ;----Retrieve sys/pkg level default time/occ setting
 N VALUE
 S Y=$$GET^XPAR("DIV^SYS^PKG","ORWRP TIME/OCC LIMITS ALL",1,"I")
 Q
 ;
DELDFLT(Y) ;----Delete user's default setting 
 N ORERR S ORERR=""
 D NDEL^XPAR(DUZ_";VA(200,","ORWRP TIME/OCC LIMITS INDV",.ORERR)
 D DEL^XPAR(DUZ_";VA(200,","ORWRP TIME/OCC LIMITS ALL",1,.ORERR)
 K ORERR
 Q
 ;
ACTDF(Y) ;----Make default setting take action for each report
 N IND,DFLT,VALUE,X,X0,X4,MAX,DFLT1
 S DFLT=$$GET^XPAR("USR.`"_DUZ_"^DIV^SYS^PKG","ORWRP TIME/OCC LIMITS ALL",1,"I")
 S IND=0,X=$P($P(DFLT,";"),"-",2)
 F  S IND=$O(^ORD(101.24,IND)) Q:'IND  S X0=$G(^(IND,0)),X4=$G(^(4)) D
 . I $P(X0,"^",8)="R",$P(X0,"^",12)'="M" D
 .. S MAX=$P(X4,"^",2),DFLT1=DFLT
 .. I MAX,X,X>MAX S DFLT1="T-"_MAX_";"_$P(DFLT,";",2,99)
 .. D SUINDV(.Y,IND,DFLT1)
 Q
GETOCM(ORY) ;Get value of "ORCH CONTEXT MEDS"
 S ORY=$$GET^XPAR("ALL","ORCH CONTEXT MEDS")
 Q
 ;
PUTOCM(ORY,ORVAL) ;Set value of "ORCH CONTEXT MEDS"
 I '$L(ORVAL) D DEL^XPAR("USR.`"_DUZ,"ORCH CONTEXT MEDS",1) Q
 N ORERR S ORERR=""
 D EN^XPAR(DUZ_";VA(200,","ORCH CONTEXT MEDS",1,ORVAL,.ORERR)
 S ORY=ORERR
 Q
 ;
