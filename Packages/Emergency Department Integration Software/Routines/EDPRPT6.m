EDPRPT6 ;SLC/MKB - Provider Report
 ;;1.0;EMERGENCY DEPARTMENT;;Sep 30, 2009;Build 74
 ;
PRV(BEG,END) ; Get Provider Report for EDPSITE by date range
 N IN,LOG,X,X0,X1,X3,X4,MD,MDTIME,DISP,S,ACU
 N CNT,IN2MD,MD2DS,ROW,SHIFT
 S IN=BEG-.000001 D SETUP^EDPRPT5 ;build SHIFT(#)
 I 'SHIFT D ERR^EDPRPT(2300013) Q
 F  S IN=$O(^EDP(230,"ATI",EDPSITE,IN)) Q:'IN  Q:IN>END  S LOG=0 F  S LOG=+$O(^EDP(230,"ATI",EDPSITE,IN,LOG)) Q:LOG<1  D
 . S X0=^EDP(230,LOG,0),X1=$G(^(1)),X3=$G(^(3)),X4=$G(^(4,1,0))
 . S MD=$P(X3,U,5) Q:MD<1  ;no provider
 . S DISP=$P(X1,U,3),ACU=$$ACUITY($P(X3,U,3))
 . S MDTIME=$$MD^EDPRPT(LOG)
 . D:'$D(CNT(MD)) INIT(MD) ;set counters,sums to 0 per provider
D1 . ; all visits
 . S S=$$SHIFT^EDPRPT5(MDTIME)
 . S CNT(MD)=CNT(MD)+1,CNT(MD,S,ACU)=CNT(MD,S,ACU)+1
 . S IN2MD=$$FMDIFF^XLFDT(MDTIME,IN,2)\60
 . S IN2MD(MD)=IN2MD(MD)+IN2MD,IN2MD(MD,S,ACU)=IN2MD(MD,S,ACU)+IN2MD
 . S MD2DS=$S(DISP:$$FMDIFF^XLFDT(DISP,MDTIME,2)\60,1:0)
 . S MD2DS(MD)=MD2DS(MD)+MD2DS,MD2DS(MD,S,ACU)=MD2DS(MD,S,ACU)+MD2DS
D2 ; calculate & return averages as CSV
 I $G(CSV) D  Q
 . N TAB,NM,SFT S TAB=$C(9)
 . S X="MD Name"_TAB_"Shift"_TAB_"Acuity"_TAB_"# Patients"_TAB_"Time In to MD Assigned"_TAB_"MD Assign to Dispo"
 . D ADD^EDPCSV(X)
 . S MD=0 F  S MD=$O(CNT(MD)) Q:MD<1  I CNT(MD) D
 .. S NM=$$EPERS^EDPRPT(MD) F S=1:1:SHIFT D
 ... S SFT=S F ACU=0:1:5 I CNT(MD,S,ACU) D
 .... S X=NM_TAB_SFT_TAB_ACU_TAB_CNT(MD,S,ACU)
 .... S X=X_TAB_$$ETIME^EDPRPT(IN2MD(MD,S,ACU)\CNT(MD,S,ACU))
 .... S X=X_TAB_$$ETIME^EDPRPT(MD2DS(MD,S,ACU)\CNT(MD,S,ACU))
 .... D ADD^EDPCSV(X) S (NM,SFT)=""
 .. S X="  MD TOTALS"_TAB_TAB_TAB_CNT(MD)
 .. S X=X_TAB_$$ETIME^EDPRPT(IN2MD(MD)\CNT(MD))
 .. S X=X_TAB_$$ETIME^EDPRPT(MD2DS(MD)\CNT(MD))
 .. D ADD^EDPCSV(X)
D3 ; or as XML
 D XML^EDPX("<providers>")
 S MD=0 F  S MD=$O(CNT(MD)) Q:MD<1  I CNT(MD) D
 . K ROW S ROW("name")=$$EPERS^EDPRPT(MD),ROW("total")=CNT(MD)
 . S ROW("timeMD")=$$ETIME^EDPRPT(IN2MD(MD)\CNT(MD))
 . S ROW("timeDisp")=$$ETIME^EDPRPT(MD2DS(MD)\CNT(MD))
 . S X=$$XMLA^EDPX("md",.ROW),X=$TR(X,"/") D XML^EDPX(X)
 . D XML^EDPX("<shifts>")
 . F S=1:1:SHIFT D
 .. F ACU=0:1:5 I CNT(MD,S,ACU) D
 ... K ROW S ROW("total")=CNT(MD,S,ACU)
 ... S ROW("number")=S,ROW("acuity")=ACU
 ... S ROW("timeMD")=$$ETIME^EDPRPT(IN2MD(MD,S,ACU)\CNT(MD,S,ACU))
 ... S ROW("timeDisp")=$$ETIME^EDPRPT(MD2DS(MD,S,ACU)\CNT(MD,S,ACU))
 ... S X=$$XMLA^EDPX("shift",.ROW) D XML^EDPX(X)
 . D XML^EDPX("</shifts>"),XML^EDPX("</md>")
 D XML^EDPX("</providers>")
 Q
 ;
INIT(DR) ; Initialize counters and sums
 N S,A
 S (CNT(DR),IN2MD(DR),MD2DS(DR))=0
 F S=1:1:SHIFT D
 . F A=0:1:5 S (CNT(DR,S,A),IN2MD(DR,S,A),MD2DS(DR,S,A))=0
 Q
 ;
ACUITY(IEN) ; Return external value [0-5] for an Acuity code
 N X0,Y S X0=$G(^EDPB(233.1,+IEN,0))
 S Y=$P(X0,U,3) S:Y<1 Y=+$P(X0,U,4) ;code or nat'l code
 Q Y
