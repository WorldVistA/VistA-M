EDPRPT2 ;SLC/MKB - Delay Report
 ;;1.0;EMERGENCY DEPARTMENT;;Sep 30, 2009;Build 74
 ;
DEL(BEG,END) ; Get Delay Report for EDPSITE by date range
 ;   CNT = counters
 ;   MIN = accumulate #minutes
 N IN,OUT,LOG,X,X0,X1,X3,DX,ELAPSE,ADMDEC,ADMDEL,DISP,VADISP,CNT,MIN,DEL,ACU
 D INIT ;set counters, sums to 0
 D:'$G(CSV) XML^EDPX("<logEntries>") I $G(CSV) D  ;headers
 . N TAB S TAB=$C(9)
 . S X="ED IEN"_TAB_"Time In"_TAB_"Elapsed"_TAB_"Dispo"_TAB_"Delay Reason"_TAB_"MD"_TAB_"Adm Dec"_TAB_"Adm Delay"_TAB_"Acuity"_TAB_"Diagnosis"
 . D ADD^EDPCSV(X)
 S IN=BEG-.000001
 F  S IN=$O(^EDP(230,"ATI",EDPSITE,IN)) Q:'IN  Q:IN>END  S LOG=0 F  S LOG=+$O(^EDP(230,"ATI",EDPSITE,IN,LOG)) Q:LOG<1  D
 . S X0=^EDP(230,LOG,0),X1=$G(^(1)),X3=$G(^(3))
 . S ACU=$$ECODE^EDPRPT($P(X3,U,3)),DEL=+$P(X1,U,5),CNT=CNT+1
 . S DISP=$$ECODE^EDPRPT($P(X1,U,2)),VADISP=$$VADMIT(DISP)
 . S OUT=$P(X0,U,9) ;S:OUT="" OUT=NOW
 . S ELAPSE=$S(OUT:($$FMDIFF^XLFDT(OUT,IN,2)\60),1:0),MIN=MIN+ELAPSE
D1 . ; all admissions
 . S (ADMDEC,ADMDEL)=0
 . S X=$$ADMIT^EDPRPT(LOG) I X D
 .. S ADMDEC=$$FMDIFF^XLFDT(X,IN,2)\60
 .. S:ADMDEC CNT("DEC")=CNT("DEC")+1,MIN("DEC")=MIN("DEC")+ADMDEC
 .. S ADMDEL=$S(OUT:($$FMDIFF^XLFDT(OUT,X,2)\60),1:0)
D2 . ; VA admissions only
 . I VADISP D
 .. S CNT("VA")=CNT("VA")+1
 .. S MIN("VA")=MIN("VA")+ELAPSE
 .. S MIN("VADEC")=MIN("VADEC")+ADMDEC
 .. S MIN("VADEL")=MIN("VADEL")+ADMDEL
 .. S:ADMDEL>359 CNT("VADEL6")=CNT("VADEL6")+1
D3 . ; elapsed visit time >=6 hrs
 . S:ELAPSE>1380 CNT("23+")=CNT("23+")+1
 . I ELAPSE>359 D
 .. S CNT("6+")=CNT("6+")+1
 .. S:VADISP CNT("VA6")=CNT("VA6")+1
 .. S DX=$$DXPRI^EDPQPCE(+$P(X0,U,3),LOG)
 .. N ROW S ROW("id")=LOG
 .. S ROW("inTS")=$S($G(CSV):$$EDATE^EDPRPT(IN),1:IN)
 .. S ROW("elapsed")=$$ETIME^EDPRPT(ELAPSE)_" *"
 .. S ROW("disposition")=DISP
 .. S ROW("acuity")=ACU
 .. S ROW("delayReason")=$$ENAME^EDPRPT(DEL)
 .. S ROW("md")=$$EPERS^EDPRPT($P(X3,U,5))
 .. S ROW("dx")=$P(DX,U,2)
 .. S ROW("admDec")=ADMDEC
 .. S ROW("admDel")=ADMDEL
 .. I '$G(CSV) S X=$$XMLA^EDPX("log",.ROW) D XML^EDPX(X) Q
 .. S X=ROW("id")
 .. F I="inTS","elapsed","disposition","delayReason","md","admDec","admDel","acuity","dx" S X=X_$C(9)_$G(ROW(I))
 .. D ADD^EDPCSV(X)
 D:'$G(CSV) XML^EDPX("</logEntries>")
 Q
 ;
D4 ; return counts and averages
 D XML^EDPX("<averages>")
 S X="<average type='All Patients' total='"_CNT_"' avgTime='"_$S(CNT:$$ETIME^EDPRPT(MIN/CNT),1:0)_"' num6hr='"_CNT("6+")_"' num23hr='"_CNT("23+")_"' avgAdmDec='"_$S(CNT("DEC"):$$ETIME^EDPRPT(MIN("DEC")/CNT("DEC")),1:0)_"' />"
 D XML^EDPX(X)
 S X="<average type='Not VA Admitted' total='"_(CNT-CNT("VA"))_"' avgTime='"_$S(CNT-CNT("VA"):$$ETIME^EDPRPT((MIN-MIN("VA")/(CNT-CNT("VA")))),1:0)_"' />"
 D XML^EDPX(X)
 S X="<average type='VA Admitted' total='"_CNT("VA")_"' num6hr='"_CNT("VA6")_"' numAdmDel6hr='"_CNT("VADEL6")
 S X=X_"' avgAdmDel='"_$S(CNT("VA"):$$ETIME^EDPRPT(MIN("VADEL")/CNT("VA")),1:0)_"' avgAdmDec='"_$S(CNT("VA"):$$ETIME^EDPRPT(MIN("VADEC")/CNT("VA")),1:0)_"' />"
 D XML^EDPX(X)
 D XML^EDPX("</averages>")
 Q
 ;
INIT ; Initialize counters and sums
 N I S (CNT,MIN)=0
 F I="DEC","VA","VA6","VADEL6","6+","23+" S CNT(I)=0
 F I="DEC","VA","VADEC","VADEL" S MIN(I)=0
 Q
 ;
VADMIT(X) ; -- Return 1 or 0, if disposition indicates a VA admission
 I $G(X)="" Q 0
 N I,Y S X=$$UP^XLFSTR(X)
 S I=+$O(^EDPB(233.1,"AB","disposition",X,0))
 S Y=$S($P($G(^EDPB(233.1,I,0)),U,5)["V":1,1:0)
 Q Y
