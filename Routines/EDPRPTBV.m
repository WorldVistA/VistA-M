EDPRPTBV ;SLC/MKB - BVAC Report
 ;;1.0;EMERGENCY DEPARTMENT;;Sep 30, 2009;Build 74
 ;
EN(BEG,END) ; Get Activity Report for EDPSITE by date range
 N LOG,X,X0,X1,X3,DX,IN,OUT,ROW,ICD,I
 N ELAPSE,TRIAGE,ADMDEC,ADMDEL,CNT,ADM,MIN,AVG
 D INIT ;set counters, sums to 0
 D:'$G(CSV) XML^EDPX("<logEntries>") I $G(CSV) D  ;headers
 . N TAB S TAB=$C(9)
 . S X="Patient"_TAB_"Time In"_TAB_"Time Out"_TAB_"Complaint"_TAB_"MD"_TAB_"Acuity"_TAB_"Elapsed"_TAB_"Triage"_TAB_"Dispo"_TAB_"Admit Dec"_TAB_"Admit Delay"_TAB_"Diagnosis"_TAB_"ICD9"
 . S X=X_TAB_"Viet Vet"_TAB_"Agent Orange"_TAB_"OEF/OIF"_TAB_"Pers Gulf"_TAB_"VA Pension"_TAB_"POW"_TAB_"Serv Conn %"_TAB_"Purp Hrt"_TAB_"Unemploy"_TAB_"Combat End"
 . D ADD^EDPCSV(X)
 S IN=BEG-.000001
 F  S IN=$O(^EDP(230,"ATI",EDPSITE,IN)) Q:'IN  Q:IN>END  S LOG=0 F  S LOG=+$O(^EDP(230,"ATI",EDPSITE,IN,LOG)) Q:LOG<1  D
 . S X0=^EDP(230,LOG,0),X1=$G(^(1)),X3=$G(^(3))
 . S DX=$$BVAC(+$P(X0,U,3),LOG) Q:DX=""  ;no codes in range
 . S CNT=CNT+1,OUT=$P(X0,U,9) ;S:OUT="" OUT=NOW
 . S ELAPSE=$S(OUT:($$FMDIFF^XLFDT(OUT,IN,2)\60),1:0)
 . S MIN("elapsed")=MIN("elapsed")+ELAPSE
 . S X=$$ACUITY^EDPRPT(LOG),TRIAGE=0 ;S:X<1 X=OUT
 . S:X TRIAGE=($$FMDIFF^XLFDT(X,IN,2)\60)
 . S MIN("triage")=MIN("triage")+TRIAGE
 . S (ADMDEC,ADMDEL)=""
 . S X=$$ADMIT^EDPRPT(LOG) I X S ADM=ADM+1 D   ;decision to admit
 .. S ADMDEC=($$FMDIFF^XLFDT(X,IN,2)\60)
 .. S ADMDEL=$S(OUT:($$FMDIFF^XLFDT(OUT,X,2)\60),1:0)
 .. S MIN("admDec")=MIN("admDec")+ADMDEC
 .. S MIN("admDel")=MIN("admDel")+ADMDEL
 . ;
BV1 . ; add row to report
 . ;S ICD=$P($G(^ICD9(+$P(X4,U,2),0)),U) Q:ICD<290  Q:ICD>316
 . K ROW S ROW("patient")=$P(X0,U,4)
 . S ROW("inTS")=$S($G(CSV):$$EDATE^EDPRPT(IN),1:IN)
 . S ROW("outTS")=$S($G(CSV):$$EDATE^EDPRPT(OUT),1:OUT)
 . S ROW("complaint")=$P(X1,U)
 . S ROW("md")=$$EPERS^EDPRPT($P(X3,U,5))
 . S ROW("acuity")=$$ECODE^EDPRPT($P(X3,U,3))
 . S ROW("elapsed")=ELAPSE_$S(ELAPSE>359:" *",1:"")
 . S ROW("triage")=TRIAGE
 . S ROW("disposition")=$$ECODE^EDPRPT($P(X1,U,2))
 . S ROW("admDec")=ADMDEC,ROW("admDel")=ADMDEL
 . S ROW("icd")=$P(DX,U),ROW("dx")=$P(DX,U,2)
 . ; get other patient attributes from VADPT
 . N DFN,VAEL,VASV,VAMB,VAERR
 . S DFN=$P(X0,U,6) I DFN D 8^VADPT D
 .. S ROW("vietnam")=$S(VASV(1):"Y",1:"N")
 .. S ROW("agentOrange")=$S(VASV(2):"Y",1:"N")
 .. S ROW("iraq")=$S(VASV(11)!VASV(12)!VASV(13):"Y",1:"N")
 .. S ROW("persGulf")=$P($G(^DPT(DFN,.322)),U,10)
 .. S ROW("vaPension")=$S(VAMB(4):"Y",1:"N")
 .. S ROW("pow")=$S(VASV(4):"Y",1:"N")
 .. S ROW("servConnPct")=+$P(VAEL(3),U,2)
 .. S ROW("purpleHeart")=$S(VASV(9):"Y",1:"N")
 .. ; ROW("unemployable")=$P($G(^DGEN(27.11,DFN,"E")),U,17) ;or VAPD(7)=3^NOT EMPLOYED ??
 .. S ROW("combatEndDT")=$P($G(VASV(10,1)),U)
BV2 . ;
 . I '$G(CSV) S X=$$XMLA^EDPX("log",.ROW) D XML^EDPX(X) Q
 . S X=ROW("patient")
 . F I="inTS","outTS","complaint","md","acuity","elapsed","triage","disposition","admDec","admDel","dx","icd" S X=X_$C(9)_$G(ROW(I))
 . F I="vietnam","agentOrange","iraq","persGulf","vaPension","pow","servConn%","purpleHeart","unemployable","combatEndDT" S X=X_$C(9)_$G(ROW(I))
 . D ADD^EDPCSV(X)
 D:'$G(CSV) XML^EDPX("</logEntries>")
 ;
BV3 ; calculate & include averages
 Q:CNT<1  ;no visits found
 S ELAPSE=$$ETIME^EDPRPT(MIN("elapsed")\CNT),AVG("elapsed")=ELAPSE
 S TRIAGE=$$ETIME^EDPRPT(MIN("triage")\CNT),AVG("triage")=TRIAGE
 S ADMDEC=$S(ADM:$$ETIME^EDPRPT(MIN("admDec")\ADM),1:"00:00")
 S ADMDEL=$S(ADM:$$ETIME^EDPRPT(MIN("admDel")\ADM),1:"00:00")
 S AVG("admDec")=ADMDEC,AVG("admDel")=ADMDEL,AVG("total")=CNT
 ;
 I $G(CSV) D  Q  ;CSV format
 . N TAB,D S TAB=$C(9)
 . D BLANK^EDPCSV
 . S X=TAB_"Total Patients"_TAB_CNT_TAB_"Averages Per Patient"_TAB_TAB_TAB_ELAPSE_TAB_TRIAGE_TAB_ADMDEC_TAB_ADMDEL
 . D ADD^EDPCSV(X),BLANK^EDPCSV
 D XML^EDPX("<averages>")
 S X=$$XMLA^EDPX("average",.AVG) D XML^EDPX(X)
 D XML^EDPX("</averages>")
 Q
 ;
INIT ; Initialize counters and sums
 N I,X S (CNT,ADM)=0
 F I="elapsed","triage","admDec","admDel" S MIN(I)=0
 Q
 ;
ECODE(IEN) ; Return external value for a Code
 Q:IEN $P($G(^EDPB(233.1,IEN,0)),U,2) ;name
 Q ""
 ;
BVAC(AREA,LOG) ; -- Return ICD^text of diagnosis in range, else null
 N X,Y,I,EDPDX S Y=""
 D DXALL^EDPQPCE(AREA,LOG,.EDPDX)
 S I=0 F  S I=$O(EDPDX(I)) Q:I<1  S X=$G(EDPDX(I)) I 290<=+X,+X<=316 S Y=X Q
 Q Y
