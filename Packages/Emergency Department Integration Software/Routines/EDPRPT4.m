EDPRPT4 ;SLC/MKB - Delay Summary Report ;2/28/12 08:33am
 ;;2.0;EMERGENCY DEPARTMENT;;May 2, 2012;Build 103
 ;
SUM(BEG,END,CSV) ; Get Delay Report for EDPSITE by date range
 ;   CNT = counters
 ;   MIN = accumulate #minutes
 N IN,OUT,LOG,X,X0,X1,X3,X4,ELAPSE,ADMDEC,ADMDEL,DISP,STS,VADM,CNT,MIN,PROV,DEL,ACU,Y
 D INIT ;set counters, sums to 0
 S IN=BEG-.000001
 F  S IN=$O(^EDP(230,"ATI",EDPSITE,IN)) Q:'IN  Q:IN>END  S LOG=0 F  S LOG=+$O(^EDP(230,"ATI",EDPSITE,IN,LOG)) Q:LOG<1  D
 . S X0=^EDP(230,LOG,0),X1=$G(^(1)),X3=$G(^(3)),X4=$G(^(4,1,0))
 . S DISP=$$ECODE^EDPRPT($P(X1,U,2)),VADM=$$VADMIT^EDPRPT2(DISP)
 . ;TDP - Patch 2, additional check for VA Admissions w/o abbreviation
 . I VADM=0 S VADM=$$VADMIT1^EDPRPT2($P(X1,U,2))
 . S ACU=$$ECODE($P(X3,U,3)),STS=$P(X3,U,2)
 . S DEL=+$P(X1,U,5),CNT=CNT+1
 . S OUT=$P(X0,U,9) ;S:OUT="" OUT=NOW
 . S ELAPSE=$S(OUT:($$FMDIFF^XLFDT(OUT,IN,2)\60),1:0),MIN=MIN+ELAPSE
D1 . ; all admissions
 . S (ADMDEC,ADMDEL)=0
 . S X=$$ADMIT^EDPRPT(LOG) I X D
 .. S ADMDEC=$$FMDIFF^XLFDT(X,IN,2)\60
 .. S:ADMDEC CNT("DEC")=CNT("DEC")+1,MIN("DEC")=MIN("DEC")+ADMDEC
 .. S ADMDEL=$S(OUT:($$FMDIFF^XLFDT(OUT,X,2)\60),1:0)
 . S:$$OBS(STS) CNT("OBS")=CNT("OBS")+1
D2 . ; VA admissions only
 . I VADM D
 .. S CNT("VA")=CNT("VA")+1
 .. S MIN("VA")=MIN("VA")+ELAPSE
 .. S MIN("VADEC")=MIN("VADEC")+ADMDEC
 .. S MIN("VADEL")=MIN("VADEL")+ADMDEL
 .. S:ADMDEL>359 CNT("VADEL6")=CNT("VADEL6")+1
D3 . ; elapsed visit time >=6 hrs
 . S:ELAPSE>1380 CNT("23+")=CNT("23+")+1
 . I ELAPSE>359 D
 .. S CNT("6+")=CNT("6+")+1
 .. S:VADM CNT("VA6")=CNT("VA6")+1
 . S:DEL CNT(DEL,ACU)=+$G(CNT(DEL,ACU))+1,CNT(DEL)=+$G(CNT(DEL))+1
 ;
D4 ; return counts and averages as CSV
 I $G(CSV) D  Q
 . N TAB S TAB=$C(9)
 . S X=TAB_TAB_"Delay Reason"_TAB_"0"_TAB_"1"_TAB_"2"_TAB_"3"_TAB_"4"_TAB_"5"_TAB_"Total"
 . D ADD^EDPCSV(X),BLANK^EDPCSV ;headers
 . S X="Total ED Visits: "_CNT_TAB
 . S X=X_"Average ED Visit Time: "_$S(CNT:$$ETIME^EDPRPT(MIN\CNT),1:0)
 . D ADD^EDPCSV(X),BLANK^EDPCSV
 . S X="Total Visits over Six Hours: "_CNT("6+")_TAB
 . S X=X_"Total Visits over 23 Hours: "_CNT("23+")
 . D ADD^EDPCSV(X),BLANK^EDPCSV
 . S X="Total Admitted to Observation: "_CNT("OBS")
 . D ADD^EDPCSV(X),BLANK^EDPCSV
 . S Y=CNT-CNT("VA"),X="Total Visits Not VA Admitted: "_Y_TAB
 . S X=X_"Average Visit Time for Not VA Admitted: "_$S(Y:$$ETIME^EDPRPT((MIN-MIN("VA")\Y)),1:0)
 . D ADD^EDPCSV(X),BLANK^EDPCSV
 . S Y=CNT("VA"),X="Total VA Admits: "_Y_TAB
 . S X=X_"Total VA Admit Delay over Six Hours: "_CNT("VADEL6")
 . D ADD^EDPCSV(X),BLANK^EDPCSV
 . S X="Average VA Admit Decision Time: "_$S(Y:$$ETIME^EDPRPT(MIN("VADEC")\Y),1:0)_TAB
 . S X=X_"Average VA Admit Delay Time: "_$S(Y:$$ETIME^EDPRPT(MIN("VADEL")\Y),1:0)
 . D ADD^EDPCSV(X),BLANK^EDPCSV
 . S Y=CNT("DEC"),X="Average All Admit Decision Time: "_$S(Y:$$ETIME^EDPRPT(MIN("DEC")\Y),1:0)
 . D ADD^EDPCSV(X),BLANK^EDPCSV
 . S X=TAB_TAB_"Delay Chart" D ADD^EDPCSV(X),BLANK^EDPCSV
 . S X=TAB_TAB_"Acuity"_TAB_"None"_TAB_"1"_TAB_"2"_TAB_"3"_TAB_"4"_TAB_"5"_TAB_"Total"
 . D ADD^EDPCSV(X),BLANK^EDPCSV
 . S DEL=0 F  S DEL=$O(CNT(DEL)) Q:+DEL'=DEL  D
 .. S X=$$ENAME^EDPRPT(DEL) Q:X=""  Q:X?1." "  S X=TAB_TAB_X ;novalue
 .. F I="none","one","two","three","four","five" S X=X_TAB_+$G(CNT(DEL,I))
 .. S X=X_TAB_CNT(DEL) D ADD^EDPCSV(X)
D5 ; or return counts and averages as XML
 D XML^EDPX("<averages>")
 S X="<average type='All Patients' total='"_CNT
 S X=X_"' avgTime='"_$S(CNT:$$ETIME^EDPRPT(MIN\CNT),1:0)
 S X=X_"' num6hr='"_CNT("6+")_"' num23hr='"_CNT("23+"),Y=CNT("DEC")
 S X=X_"' avgAdmDec='"_$S(Y:$$ETIME^EDPRPT(MIN("DEC")\Y),1:0)
 S X=X_"' numObs='"_CNT("OBS")_"' />"
 D XML^EDPX(X)
 S Y=CNT-CNT("VA")
 S X="<average type='Not VA Admitted' total='"_Y_"' avgTime='"_$S(Y:$$ETIME^EDPRPT((MIN-MIN("VA")\Y)),1:0)_"' />"
 D XML^EDPX(X)
 S Y=CNT("VA"),X="<average type='VA Admitted' total='"_Y
 S X=X_"' num6hr='"_CNT("VA6")_"' numAdmDel6hr='"_CNT("VADEL6")
 S X=X_"' avgAdmDel='"_$S(Y:$$ETIME^EDPRPT(MIN("VADEL")\Y),1:0)
 S X=X_"' avgAdmDec='"_$S(Y:$$ETIME^EDPRPT(MIN("VADEC")\Y),1:0)_"' />"
 D XML^EDPX(X)
 D XML^EDPX("</averages>")
 D XML^EDPX("<delayChart>")
 S DEL=0 F  S DEL=$O(CNT(DEL)) Q:+DEL'=DEL  D
 . S X=$$ENAME^EDPRPT(DEL) Q:X=""  Q:X?1." "  ;novalue
 . S CNT(DEL,"reason")=X,CNT(DEL,"total")=CNT(DEL)
 . F I="none","one","two","three","four","five" S CNT(DEL,I)=+$G(CNT(DEL,I))
 . K ROW M ROW=CNT(DEL)
 . S X=$$XMLA^EDPX("delay",.ROW) D XML^EDPX(X)
 D XML^EDPX("</delayChart>")
 Q
 ;
INIT ; Initialize counters and sums
 N I S (CNT,MIN)=0
 F I="DEC","VA","VA6","VADEL6","6+","23+","OBS" S CNT(I)=0
 F I="DEC","VA","VADEC","VADEL" S MIN(I)=0
 Q
 ;
ECODE(IEN) ; Return external value for an Acuity code
 N X,Y S X=$P($G(^EDPB(233.1,+IEN,0)),U,3) ;code
 S Y=$S(X="":"none",X=1:"one",X=2:"two",X=3:"three",X=4:"four",X=5:"five",1:"X")
 Q Y
 ;
OBS(IEN) ; Return 1 or 0, if status IEN indicates Observation
 I $G(IEN),$P($G(^EDPB(233.1,+IEN,0)),U,5)["O" Q 1
 Q 0
