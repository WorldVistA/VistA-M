EDPRPT11 ;SLC/MKB - Patient Intake Report
 ;;1.0;EMERGENCY DEPARTMENT;;Sep 30, 2009;Build 74
 ;
CNT(BEG,END) ; Get Patient Intake Report for EDPSITE by date range
 ;   CNT = counters
 N IN,LOG,LAST,X,CNT,HR,DAY,%H,%T,%Y,H,D,ROW,AVG,NM,TAB,DAYS
 D INIT S LAST="" ;set counters to 0
 S IN=BEG-.000001,TAB=$C(9)
 F  S IN=$O(^EDP(230,"ATI",EDPSITE,IN)) Q:'IN  Q:IN>END  S LOG=0 F  S LOG=+$O(^EDP(230,"ATI",EDPSITE,IN,LOG)) Q:LOG<1  D
 . S X=$P($G(^EDP(230,LOG,0)),U,8) Q:X<1
 . D H^%DTC S H=%T\3600,D=%Y
 . S CNT=CNT+1,HR(H)=HR(H)+1,CNT(H,D)=CNT(H,D)+1
 . S DAY(D)=DAY(D)+1
 . I LAST=""!($P(LAST,".")'=$P(IN,".")) S DAYS(D)=DAYS(D)+1,LAST=IN
C1 ; return counts and averages
 D:'$G(CSV) XML^EDPX("<averages>") I $G(CSV) D  ;headers
 . S X="Time/Day"_TAB_"Sunday"_TAB_"Monday"_TAB_"Tuesday"_TAB_"Wednesday"_TAB_"Thursday"_TAB_"Friday"_TAB_"Saturday"_TAB_"Totals"_TAB_"Avg/Day"
 . D ADD^EDPCSV(X),BLANK^EDPCSV
 F H=0:1:23 D
 . K ROW S ROW("time")=$$TIME(H)_"-"_$$TIME(H+1)
 . S ROW=ROW("time") ;CSV
 . F D=0:1:6 S NM=$$NAME(D) D
 .. S ROW(NM)=CNT(H,D)
 .. S ROW=ROW_TAB_ROW(NM) ;CSV
 . S ROW("total")=HR(H),ROW("average")=$$ROUND(HR(H)/DAYS)
 . I '$G(CSV) S X=$$XMLA^EDPX("row",.ROW) D XML^EDPX(X) Q
 . S ROW=ROW_TAB_ROW("total")_TAB_ROW("average") D ADD^EDPCSV(ROW)
 ; total & average rows
 K ROW S ROW("time")="Totals",ROW=ROW("time")
 S AVG("time")="Avg/Hour",AVG=AVG("time")
 F D=0:1:6 S NM=$$NAME(D) D
 . S ROW(NM)=DAY(D),X=0
 . S:DAYS(D) X=DAY(D)/(24*DAYS(D))
 . S AVG(NM)=$$ROUND(X)
 . S ROW=ROW_TAB_ROW(NM) ;CSV
 . S AVG=AVG_TAB_AVG(NM) ;CSV
 S ROW("total")=CNT,ROW("average")=$$ROUND(CNT/DAYS)
 S ROW=ROW_TAB_ROW("total")_TAB_ROW("average")
 I $G(CSV) D BLANK^EDPCSV,ADD^EDPCSV(ROW),ADD^EDPCSV(AVG) Q
 S X=$$XMLA^EDPX("row",.ROW) D XML^EDPX(X)
 S X=$$XMLA^EDPX("row",.AVG) D XML^EDPX(X)
 D XML^EDPX("</averages>")
 Q
 ;
INIT ; Initialize counters and sums
 N H,D S CNT=0
 F H=0:1:23 S HR(H)=0 F D=0:1:6 S CNT(H,D)=0
 F D=0:1:6 S DAY(D)=0,DAYS(D)=0
 S DAYS=$$FMDIFF^XLFDT(END,BEG)+1
 Q
 ;
ROUND(X) ; Round X to one decimal place
 N Y1,Y2,Y S X=+$G(X)
 S Y1=+$P(X,"."),Y2=$E($P(X,".",2)_"00",1,2)
 S:$E(Y2,2)'>4 Y2=+$E(Y2) I $E(Y2,2)>4 D
 . I $E(Y2)=9 S Y1=Y1+1,Y2=0 Q
 . S Y2=$E(Y2)+1
 S Y=Y1_"."_Y2
 Q Y
 ;
ZROUND(X) ; Round X to nearest integer
 N Y S Y=+$E($P(X,".",2)),X=X\1
 S:Y>4 X=X+1
 Q X
 ;
TIME(X) ; Return 0000 form of hour# X
 N Y S Y=$S($L(X)=1:"0"_X,1:X)_"00"
 Q Y
 ;
NAME(X) ; Return name of day# X
 I X=1 Q "Monday"
 I X=2 Q "Tuesday"
 I X=3 Q "Wednesday"
 I X=4 Q "Thursday"
 I X=5 Q "Friday"
 I X=6 Q "Saturday"
 Q "Sunday"
