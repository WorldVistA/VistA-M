ENAEMS ;WOIFO/SU-AEMS/MERS WO PERFORMANCE EXTRACT ; 07/25/2002  03:30 PM
 ;;7.0;ENGINEERING;**72**;August 17,1993
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
BEGIN ;
 ;
 NEW FY
 W !!,"AEMS/MERS WORK ORDER PERFORMANCE EXTRACT",!!!
 R "PLEASE ENTER FISCAL YEAR FOR PROCESSING: 2002//",FY:$S($D(DTIME):DTIME,1:60)
 I FY="^" G EXIT
 I FY="" S FY=2002
 I FY'?4N W !!,"Please enter 4 digits Fiscal Year",!! G BEGIN
 W !!,"Processing ... "
POST ;
 NEW I,J,K,X,Y,STA,OSTA,LC,FDT,TP,QT,AA,BB,A1,U,PMST
 NEW X1,X2,XMSUB,XMTEXT,XMY,FYB,FYE,END,DIFROM
 I $G(FY)="" NEW FY S FY=2002
 K ^TMP("ENAEMS#10"),^TMP("ENAEMS#19")
 ;    get report period ( FY Begin/End date )
 S U="^",FYB=FY-1701_1000,FYE=FY-1700_"0931"
 ;    get reporting site
 S STA=$P(^DIC(6910,1,0),U,2),END=$$LEGACY^XUAF4(STA)
 I END=1 G EXIT
 I STA="" S STA="UNKNOWN"
 ;
MS10 ;  measure #10
 ;
 S I=0 F  S I=$O(^ENG(6914,I)) Q:'I  D
 . ;   get owning station
 . S OSTA=$P($G(^ENG(6914,I,9)),U,5) I OSTA="" S OSTA=STA
 . S J=0 F  S J=$O(^ENG(6914,I,6,J)) Q:'J  D
 .. S K=$G(^ENG(6914,I,6,J,0)),AA=+K
 .. I AA<FYB!(AA>FYE) Q        ;Quit if falls outside the range
 .. S TP=$E($P(K,U,2),1,2) I TP="Y2" Q        ; skip Y2K record
 .. I TP'="PM" S TP="UNSCH"
 .. I TP="PM" S PMST=$E($P(K,U,3)) S TP=$S(PMST="D":"PMDEF",1:"PMNDF")
 .. S QT=$E(AA,4,5)+2\3+1 I QT>4 S QT=1   ; calculate quarter by month
 .. ;   get hour:p4,  labor:p5,   material:p6,   vendor:p7
 .. F A1=4:1:7 S BB(A1-2)=$P(K,U,A1)
 .. S AA=$G(^TMP("ENAEMS#10",$J,OSTA,QT,TP)),BB(1)=1
 .. ;   increment each counter: count, hour, labor$, material$, vendor$
 .. F A1=1:1:5 S $P(AA,",",A1)=$P(AA,",",A1)+BB(A1)
 .. S ^TMP("ENAEMS#10",$J,OSTA,QT,TP)=AA
 ;
MS19 ;   measure #19
 S I=0 F  S I=$O(^ENG(6920,I)) Q:'I  D
 . Q:'$D(^ENG(6920,I,0))
 . ; exclude PM, Y2K work order
 . S TP=$E(^ENG(6920,I,0),1,2) I TP="PM"!(TP="Y2") Q
 . ;  X1: date complete,   X2: date request
 . S X2=$P($P($G(^ENG(6920,I,0)),U,2),".")
 . S X1=$P($P($G(^ENG(6920,I,5)),U,2),".")
 . Q:X2=""                 ; if request date is null
 . Q:X1<X2                 ; date complete smaller than date request
 . I X1<FYB!(X1>FYE) Q     ; Quit if falls outside the range
 . S QT=$E(X1,4,5)+2\3+1 I QT>4 S QT=1    ; calculate quarter by month
 . D ^%DTC                ; calculate total date spent by date X1 and X2
 . S AA=$G(^TMP("ENAEMS#19",$J,QT)),AA(1)=1,AA(2)=X+1
 . ;   increment each counter: count, date spent
 . F A1=1,2 S $P(AA,",",A1)=$P(AA,",",A1)+AA(A1)
 . S ^TMP("ENAEMS#19",$J,QT)=AA
 ;
 D RPT
EXIT ;
 K ^TMP("ENAEMS#10"),^TMP("ENAEMS#19")
 Q
 ;
RPT ;
 ;   Construct Email text file
 S LC=1,X=","
 S OSTA="" F  S OSTA=$O(^TMP("ENAEMS#10",$J,OSTA)) Q:OSTA=""  D
 . S QT=0 F  S QT=$O(^TMP("ENAEMS#10",$J,OSTA,QT)) Q:'QT  D
 .. S TP="" F  S TP=$O(^TMP("ENAEMS#10",$J,OSTA,QT,TP)) Q:TP=""  D
 ... S AA=^TMP("ENAEMS#10",$J,OSTA,QT,TP)
 ... S LC=LC+1,FDT(LC)=STA_X_OSTA_X_FY_"-"_QT_X_TP_X_AA
 D MAIL(10)
 S LC=1,QT=0 K FDT
 F  S QT=$O(^TMP("ENAEMS#19",$J,QT)) Q:'QT  D
 . S AA=^TMP("ENAEMS#19",$J,QT),$P(AA,X,2)=$J($P(AA,X,2)/AA,1,1)
 . S LC=LC+1,FDT(LC)=STA_X_FY_"-"_QT_X_AA
 D MAIL(19)
 Q
 ;
MAIL(MN) ;
 ;   Send report to mail group member and patch installer
 X ^%ZOSF("UCI") S J=^%ZOSF("PROD")
 S:J'["," Y=$P(Y,",") S END=$$KSP^XUPARAM("WHERE")
 ;   send report to mail group for PRODUCTION UCI only
 I Y=J,END'["FO-",END'["ISC-" F I=1:1 S J=$T(MAILGRP+I),J=$P(J,";;",2) Q:J=""  S XMY(J)=""
 ;   mail to user who install this patch
 I $G(DUZ),$D(^VA(200,DUZ)) S XMY(DUZ)=""
 ;   if no data extracted, send blank MSG anyway 
 I '$D(FDT) S FDT(LC)=""
 S XMSUB="Measure #"_MN_", Site "_STA_", FY "_FY_", WO Performance Extract"
 S XMTEXT="FDT("
 D ^XMD
 Q
MAILGRP ;
 ;;G.CoreFLS AEMS/MERS EXTRACT@FORUM.VA.GOV
 ;;
 Q
