EDPRPT8 ;SLC/MKB - Acuity Report
 ;;1.0;EMERGENCY DEPARTMENT;;Sep 30, 2009;Build 74
 ;
ACU(BEG,END) ; Get Acuity Report for EDPSITE by date range
 ;   CNT = counters by acuity
 ;   ADM = counters for all admissions
 ;   VA  = counters for VA  admissions
 ;   MIN = accumulate #minutes
 N IN,OUT,X,X0,X1,X3,X4,DISP,ACU,CNT,ADM,MIN,VA,ROW
 D INIT ;set counters, sums to 0
 S IN=BEG-.000001
 F  S IN=$O(^EDP(230,"ATI",EDPSITE,IN)) Q:'IN  Q:IN>END  S LOG=0 F  S LOG=+$O(^EDP(230,"ATI",EDPSITE,IN,LOG)) Q:LOG<1  D
 . S X0=^EDP(230,LOG,0),X1=$G(^(1)),X3=$G(^(3)),X4=$G(^(4,1,0))
 . S DISP=$$ECODE^EDPRPT($P(X1,U,2)),ACU=$$ECODE($P(X3,U,3))
 . S CNT=CNT+1,CNT(ACU)=CNT(ACU)+1
 . ; all admissions
 . S (ADMDEC,ADMDEL)=0
 . S X=$$ADMIT^EDPRPT(LOG) I X D  ;decision to admit
 .. S ADM=ADM+1,ADM(ACU)=ADM(ACU)+1
 .. S ADMDEC=$$FMDIFF^XLFDT(X,IN,2)\60
 .. S:ADMDEC MIN("DEC")=MIN("DEC")+ADMDEC,MIN("DEC",ACU)=MIN("DEC",ACU)+ADMDEC
 .. S OUT=$P(X0,U,9) ;S:OUT="" OUT=NOW
 .. S:OUT ADMDEL=$$FMDIFF^XLFDT(OUT,X,2)\60
 . I $$VADMIT^EDPRPT2(DISP) D  ;VA admissions
 .. S VA=VA+1,VA(ACU)=VA(ACU)+1
 .. S MIN("VADEC")=MIN("VADEC")+ADMDEC
 .. S MIN("VADEC",ACU)=MIN("VADEC",ACU)+ADMDEC
 .. S MIN("VADEL")=MIN("VADEL")+ADMDEL
 .. S MIN("VADEL",ACU)=MIN("VADEL",ACU)+ADMDEL
A1 ; return counts and averages
 S I="" F  S I=$O(ADM(I)) Q:I=""  D  ;avg #min admit dec by acuity
 . S MIN("DEC",I)=$S(ADM(I):$$ETIME^EDPRPT(MIN("DEC",I)\ADM(I)),1:0)
 . S MIN("VADEC",I)=$S(VA(I):$$ETIME^EDPRPT(MIN("VADEC",I)\VA(I)),1:0)
 . S MIN("VADEL",I)=$S(VA(I):$$ETIME^EDPRPT(MIN("VADEL",I)\VA(I)),1:0)
 S CNT("total")=CNT,ADM("total")=ADM,VA("total")=VA
 S CNT("type")="Number of Patients",ADM("type")="Number Admitted",VA("type")="Number VA Admitted"
 S MIN("DEC","type")="Avg All Admit Dec Time",MIN("VADEC","type")="Avg VA Admit Dec Time",MIN("VADEL","type")="Avg VA Admit Delay Time"
 S MIN("DEC","total")=$S(ADM:$$ETIME^EDPRPT(MIN("DEC")\ADM),1:0)
 S MIN("VADEC","total")=$S(VA:$$ETIME^EDPRPT(MIN("VADEC")\VA),1:0)
 S MIN("VADEL","total")=$S(VA:$$ETIME^EDPRPT(MIN("VADEL")\VA),1:0)
 ; as CSV
 I $G(CSV) D  Q
 . N TAB S TAB=$C(9)
 . S X="Acuity->"_TAB_"0"_TAB_"1"_TAB_"2"_TAB_"3"_TAB_"4"_TAB_"5"_TAB_"Total/Average"
 . D ADD^EDPCSV(X)
 . D ROW("Number of Patients",.CNT)
 . D ROW("Number Admitted",.ADM)
 . D ROW("Number VA Admitted",.VA)
 . M ROW=MIN("DEC")   D ROW("Avg All Admit Dec Time",.ROW)  K ROW
 . M ROW=MIN("VADEC") D ROW("Avg VA Admit Dec Time",.ROW)   K ROW
 . M ROW=MIN("VADEL") D ROW("Avg VA Admit Delay Time",.ROW) K ROW
 ; or as XML
 D XML^EDPX("<statistics>")
 S X=$$XMLA^EDPX("row",.CNT) D XML^EDPX(X)
 S X=$$XMLA^EDPX("row",.ADM) D XML^EDPX(X)
 S X=$$XMLA^EDPX("row",.VA)  D XML^EDPX(X)
 M ROW=MIN("DEC")   S X=$$XMLA^EDPX("row",.ROW) D XML^EDPX(X) K ROW
 M ROW=MIN("VADEC") S X=$$XMLA^EDPX("row",.ROW) D XML^EDPX(X) K ROW
 M ROW=MIN("VADEL") S X=$$XMLA^EDPX("row",.ROW) D XML^EDPX(X) K ROW
 D XML^EDPX("</statistics>")
 Q
 ;
ROW(NAME,LIST) ; add line
 N I S X=NAME
 F I="none","one","two","three","four","five","total" S X=X_TAB_LIST(I)
 D ADD^EDPCSV(X)
 Q
 ;
INIT ; Initialize acuity counters
 N X S (CNT,ADM,VA)=0
 F X="none","one","two","three","four","five" D
 . S (CNT(X),ADM(X),VA(X),MIN("DEC",X),MIN("VADEC",X),MIN("VADEL",X))=0
 F X="DEC","VADEC","VADEL" S MIN(X)=0
 Q
 ;
ECODE(IEN) ; Return external value for an Acuity code
 N X0,X,Y S X0=$G(^EDPB(233.1,+IEN,0))
 S X=$P(X0,U,3) S:X<1 X=$P(X0,U,4) ;code or nat'l code
 S Y=$S(X=1:"one",X=2:"two",X=3:"three",X=4:"four",X=5:"five",1:"none")
 Q Y
