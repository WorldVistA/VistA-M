YTQRCDB2 ;BAL/KTL - MHA CLOUD DATABASE RPC CALLS; 1/25/2017
 ;;5.01;MENTAL HEALTH;**239,250,236**;Dec 30, 1994;Build 25
 ;
 ;
 ;Reference to VADPT APIs supported by ICR #10061
 ;Reference to $$KSP^XUPARAM supported by ICR #2541
 ;Reference to DIUTC supported by ICR #6445
 ;Reference to PXRMINDX in ICR #4290
 ;
 Q
PID2(ARGS,RESULTS) ;Get additional patient demographics
 N DFN,VA,VADM,YSNM,YSDOB,YSAGE,YSSSN,YSSEX,YSSX,YSSIG
 S DFN=$G(ARGS("dfn"))
 I +DFN=0 D SETERROR^YTQRUTL(404,"Bad patient identifier") QUIT
 I '$D(^DPT(DFN,0)) D SETERROR^YTQRUTL(404,"Not Found: "_DFN) QUIT
 D DEM^VADPT,PID^VADPT
 S YSNM=VADM(1)
 S YSDOB=$P(VADM(3),U,2)
 S YSAGE=VADM(4)
 S YSSSN="xxx-xx-"_VA("BID")
 S YSSEX=$P(VADM(5),U,1)
 S YSSX=YSSEX
 S YSSIG=$P($G(VADM(14,5)),U,2)
 S RESULTS("dob")=YSDOB
 S RESULTS("ssn")=YSSSN
 S RESULTS("sex")=YSSEX
 S RESULTS("sigi")=YSSIG
 Q
TZ(ARGS,RESULTS) ;Get Timezone
 N INST,PROP,UTC
 F PROP="fileman","external","offset","timezone" D
 . S RESULTS(PROP)=""
 S INST=$$KSP^XUPARAM("INST") Q:+INST=0
 S UTC=$$UTC^DIUTC($$NOW^XLFDT(),,INST,,1)
 S RESULTS("fileman")=$P(UTC,U)
 S RESULTS("external")=$P(UTC,U,2)
 S RESULTS("offset")=$P(UTC,U,3)
 S RESULTS("timezone")=$P(UTC,U,4)
 Q
GETLIST(ARGS,RESULTS) ; GET Insts for Pat
 N LST,TST,I,NM,TEST,DFN,SRISK
 N ADMINDT,ADMINID,CMPL,CNT,HIT,PAT,G,YSIENS,YSDATA,N,STR,ERRLST,ERRSTR
 N ADMINAR,XDT,SAVEDT,SRC,ORD,RVW,NAME
 N NMARR
 S NM="",N=0
 K ^TMP("YTQ-JSON",$J) S CNT=0
 D SETRES("{""instruments"":[")
 S HIT=""
 S DFN=+$G(ARGS("dfn"))
 D UPDTSRFL^YTQRQAD4  ; update Suicide Risk Flag
 I DFN'?1N.NP D SETERROR^YTQRUTL(404,"Bad Patient ID: "_DFN) QUIT
 I '$D(^DPT(DFN,0)) D SETERROR^YTQRUTL(404,"Patient Not Found: "_DFN) QUIT
 F  S NM=$O(^YTT(601.84,"C",DFN,NM)) Q:'NM  D
 .S G=$G(^YTT(601.84,NM,0))
 .I G="" S ERRLST(NM)="" Q  ;-->out
 .S CMPL=$P(G,U,9) Q:CMPL'="Y"
 .S ADMINDT=$P(G,U,4) Q:ADMINDT=""
 .S TST=$P(G,U,3),NAME=$P($G(^YTT(601.71,TST,0)),U,1)
 .I $P($G(^YTT(601.71,TST,2)),U,2)="C" QUIT
 .S SRISK=$P(G,U,14) I SRISK="" S SRISK=0
 .Q:$G(NMARR(NAME))'=""&($G(NMARR(NAME))>ADMINDT)
 .I $D(NMARR(NAME)) K ADMINAR(-NMARR(NAME),NAME)
 .S ADMINAR(-ADMINDT,NAME)=SRISK,NMARR(NAME)=ADMINDT
 S XDT="" F  S XDT=$O(ADMINAR(XDT)) Q:XDT=""  D
 .S NM="" F  S NM=$O(ADMINAR(XDT,NM)) Q:NM=""  D
 ..S STR="{""instrumentName"":"""_NM_""", ""suicideRisk"":"""_ADMINAR(XDT,NM)_""" },"
 ..D SETRES(STR) S HIT=1
 I HIT S STR=^TMP("YTQ-JSON",$J,CNT,0),STR=$E(STR,1,$L(STR)-1),^TMP("YTQ-JSON",$J,CNT,0)=STR
 D SETRES("]}")
 S RESULTS=$NA(^TMP("YTQ-JSON",$J))
 Q
GETALST(ARGS,RESULTS) ; GET admins for Pat+Inst
 N TST,I,ADM,TEST,DFN,SRISK
 N ADMINDT,ADMINID,CMPL,CNT,HIT,G,N,STR
 N XDT,SAVEDT,SRC,ORD,RVW,INSTIEN
 S ADM="",N=0
 K ^TMP("YTQ-JSON",$J) S CNT=0
 S HIT=""
 S DFN=+$G(ARGS("dfn")),TEST=$G(ARGS("instrumentName"))
 I DFN'?1N.NP D SETERROR^YTQRUTL(404,"Bad Patient ID: "_DFN) QUIT
 I '$D(^DPT(DFN,0)) D SETERROR^YTQRUTL(404,"Patient Not Found: "_DFN) QUIT
 S INSTIEN=$O(^YTT(601.71,"B",TEST,0)) I +INSTIEN=0 D SETERROR^YTQRUTL(404,"Instrument Not Found: "_TEST) QUIT
 D SETRES("{""instruments"":[")
 S XDT=""
 F  S XDT=$O(^PXRMINDX(601.84,"PI",DFN,INSTIEN,XDT),-1) Q:XDT=""  D  ;Get list of instr IENs
 . S ADM=0 F  S ADM=$O(^PXRMINDX(601.84,"PI",DFN,INSTIEN,XDT,ADM)) Q:ADM=""  D
 .. S G=$G(^YTT(601.84,ADM,0))
 .. I G="" Q
 .. S CMPL=$P(G,U,9) Q:CMPL'="Y"
 .. S STR=""
 .. S TST=$P(G,U,3),ORD=$P(G,U,6),RVW=$P(G,U,17)
 .. S SRC=$P(G,U,13) S:SRC'="" SRC=$P($G(^YTT(601.844,SRC,0)),U)
 .. I $P($G(^YTT(601.71,TST,2)),U,2)="C" QUIT
 .. S ADMINID=$P(G,U,1),ADMINDT=$P($P(G,U,4),":",1,2)
 .. S SAVEDT=$P($P(G,U,5),":",1,2)
 .. S SRISK=$P(G,U,14) I SRISK="" S SRISK=0
 .. S STR="{""adminId"":"""_ADMINID_""", ""instrumentName"":"""_TEST_""" , ""instrumentIen"":"""_INSTIEN_""" , ""administrationDate"":"""_$P($$FMTE^XLFDT(ADMINDT),":",1,2)
 .. S STR=STR_""" , ""saveDate"":"""_$P($$FMTE^XLFDT(SAVEDT),":",1,2)_""" , ""suicideRisk"":"""_SRISK_""", ""entrySource"":"""_SRC
 .. S STR=STR_""" , ""orderedBy"":"""_ORD_""" , ""reviewed"":"""_RVW_""" },"
 .. D SETRES(STR) S HIT=1
 I HIT S STR=^TMP("YTQ-JSON",$J,CNT,0),STR=$E(STR,1,$L(STR)-1),^TMP("YTQ-JSON",$J,CNT,0)=STR
 D SETRES("]}")
 S RESULTS=$NA(^TMP("YTQ-JSON",$J))
 Q
SETRES(STR) ;
 S CNT=CNT+1,^TMP("YTQ-JSON",$J,CNT,0)=STR
 Q
