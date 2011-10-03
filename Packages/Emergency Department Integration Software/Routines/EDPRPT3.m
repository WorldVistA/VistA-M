EDPRPT3 ;SLC/MKB - Missed Opportunity Report
 ;;1.0;EMERGENCY DEPARTMENT;;Sep 30, 2009;Build 74
 ;
MO(BEG,END) ; Get Missed Opp Report for EDPSITE by date range
 ;   CNT = counters
 N IN,OUT,LOG,DISP,X,X0,X1,X3,X4,I,CNT,ROW
 D INIT ;set counters to 0
 D:'$G(CSV) XML^EDPX("<logEntries>") I $G(CSV) D  ;headers
 . N TAB S TAB=$C(9)
 . S X="ED"_TAB_"Time In"_TAB_"Complaint"_TAB_"MD"_TAB_"Acuity"_TAB_"Elapsed"_TAB_"Triage"_TAB_"Wait"_TAB_"Dispo"_TAB_"Adm Dec"_TAB_"Adm Del"_TAB_"Delay"
 . D ADD^EDPCSV(X)
 S IN=BEG-.000001
 F  S IN=$O(^EDP(230,"ATI",EDPSITE,IN)) Q:'IN  Q:IN>END  S LOG=0 F  S LOG=+$O(^EDP(230,"ATI",EDPSITE,IN,LOG)) Q:LOG<1  D
 . S X0=^EDP(230,LOG,0),X1=$G(^(1)),X3=$G(^(3)),X4=$G(^(4,1,0))
 . S DISP=$$ECODE^EDPRPT($P(X1,U,2)) Q:'$$MISSEDOP(DISP)
 . S OUT=$P(X0,U,9) ;S:OUT="" OUT=NOW
 . K ROW S ROW("id")=LOG
 . S ROW("inTS")=$S($G(CSV):$$EDATE^EDPRPT(IN),1:IN)
 . S ROW("complaint")=$P(X1,U)
 . S ROW("acuity")=$$ECODE^EDPRPT($P(X3,U,3))
 . S ROW("md")=$$EPERS^EDPRPT($P(X3,U,5))
 . S ROW("disposition")=DISP
 . S DISP=$$UP^XLFSTR(DISP),CNT(DISP)=CNT(DISP)+1
 . ;
 . ; calculate times
 . S ROW("elapsed")=$S(OUT:($$FMDIFF^XLFDT(OUT,IN,2)\60),1:0)
 . S X=$$ACUITY^EDPRPT(LOG) ;S:X<1 X=OUT
 . S ROW("triage")=$S(X:($$FMDIFF^XLFDT(X,IN,2)\60),1:0)
 . S X=$$LVWAITRM^EDPRPT(LOG) ;S:X<1 X=IN
 . S ROW("wait")=$S(X:($$FMDIFF^XLFDT(X,IN,2)\60),1:0)
 . S X=$$ADMIT^EDPRPT(LOG)
 . S ROW("admDec")=$S(X:($$FMDIFF^XLFDT(X,IN,2)\60),1:0)
 . S ROW("admDel")=$S(X&OUT:($$FMDIFF^XLFDT(OUT,X,2)\60),1:0)
 . S ROW("delayReason")=$$ENAME^EDPRPT(+$P(X1,U,5))
 . I '$G(CSV) S X=$$XMLA^EDPX("log",.ROW) D XML^EDPX(X) Q
 . S X=ROW("id")
 . F I="inTS","complaint","md","acuity","elapsed","triage","wait","disposition","admDec","admDel","delayReason" S X=X_$C(9)_$G(ROW(I))
 . D ADD^EDPCSV(X)
 D:'$G(CSV) XML^EDPX("</logEntries>")
 ;
 ; return totals, as XML or CSV
 I '$G(CSV) S X=$$XMLA^EDPX("totals",.CNT) D XML^EDPX(X) Q
 N TAB S TAB=$C(9)
 S I="" F  S I=$O(CNT(I)) Q:I=""  D 
 . D BLANK^EDPCSV
 . S X=TAB_TAB_TAB_TAB_"Total "_CNT(I,0)_": "_CNT(I)
 . D ADD^EDPCSV(X)
 Q
 ;
INIT ; -- initialize counters
 N I,X,X2 S CNT=0
 S X="" F  S X=$O(^EDPB(233.1,"AB","disposition",X)) Q:X=""  S I=+$O(^(X,0)) D
 . S X2=$P($G(^EDPB(233.1,I,0)),U,2)
 . I $$MISSEDOP(X) S CNT(X)=0,CNT(X,0)=X2
 Q
 ;
MISSEDOP(X) ; -- Return 1 or 0, if disposition indicates a missed opportunity
 I $G(X)="" Q 0
 N I,Y S X=$$UP^XLFSTR(X)
 S I=+$O(^EDPB(233.1,"AB","disposition",X,0))
 S Y=$S($P($G(^EDPB(233.1,I,0)),U,5)["M":1,1:0)
 Q Y
