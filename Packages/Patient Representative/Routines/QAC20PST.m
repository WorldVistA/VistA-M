QAC20PST ;ALB/TKW,RRG - POST-INSTALL FOR PATCH QAC*2*20 Repair ROC numbers ;12/06/06  14:30
 ;;2.0;Patient Representative;**20**;07/25/1995;Build 7
 ;
 ;
ENV ; Environment Check
 ;
 Q:'$G(XPDENV)
 W ! K %DT D NOW^%DTC S %DT="RAEX",%DT(0)=%,%DT("A")="Queue the Post-Install to run at what Date@Time: "
 D ^%DT K %DT I $D(DTOUT)!(Y<0) W !!,"Cannot install the patch without queuing the post-install. Install aborted!",! S XPDABORT=2 Q
 S @XPDGREF@("QAC20")=Y K DTOUT
 Q
 ;
EN ;
 S ZTDTH=@XPDGREF@("QAC20")
 S ZTRTN="START^QAC20PST",ZTDESC="Background job to repair ROC numbers",ZTIO="" D ^%ZTLOAD K ZTDTH,ZTRTN,ZTIO,ZTDESC
 I $D(ZTSK)&('$D(ZTQUEUED)) D BMES^XPDUTL("Task Queued!")
 K ZTSK,ZTQUEUED
 Q
 ;
START ;
 N PARENT,ROCNO,NEWROC,IEN,QA0,YR,DIR,I,Y,TIME
 K ^TMP("QACROCNO",$J)
 ; Set up mailman message format
 N LCNT,LINE,LINE2,MESS,MSG,MSG1
 S LCNT=1,$P(LINE,"-",80)="",$P(LINE2,"=",80)=""
 K ^TMP($J)
 S MESS="Repair ROC numbers",MSG1=" beginning at "
 D TIME
 S ^TMP($J,"P20",LCNT)="",LCNT=LCNT+1
 ;
 ; Find parent station number from QUALITY ASSURANCE SITE PARAMETERS file
 S PARENT=$P($G(^QA(740,1,0)),"^"),PARENT=$$STA^XUAF4(PARENT)
 I PARENT="" S ^TMP($J,"P20",LCNT)="Cannot find Parent Institution",LCNT=LCNT+1 D XMT Q
 ;
 ; Build lists of ROCs with invalid numbers by year.
 F I=0:0 S I=$O(^QA(745.1,I)) Q:'I  S QA0=$G(^(I,0)),ROCNO=$P(QA0,"^") D
 . I ROCNO="" S ^TMP("QACROCNO",$J,I," ")="" Q
 . S YR=$E($P(QA0,"^",2),1,3)
 . I ($P(ROCNO,".")'=PARENT)!(ROCNO'?3N.AN1"."6N) D
 .. S:YR YR(YR)=""
 .. S ^TMP("QACROCNO",$J,I,ROCNO)=YR Q
 . Q
 I '$D(^TMP("QACROCNO",$J)) S ^TMP($J,"P20",LCNT)="No invalid ROC numbers were found.",LCNT=LCNT+1 D XMT Q
 ;
 ; Find default 'last sequential number' for ROCs in each year.
 S YR=""
 F  S YR=$O(YR(YR)) Q:YR=""  D
 . S ROCNO=$O(^QA(745.1,"B",PARENT_"."_$E(YR,2,3)_"9999"),-1)
 . I $P(ROCNO,".")=PARENT,$E($P(ROCNO,".",2),1,2)=$E(YR,2,3) S YR(YR)=+$E($P(ROCNO,".",2),3,6) Q
 . S YR(YR)=0 Q
 ;
 ; Assign a suggested new number for each ROC
 F IEN=0:0 S IEN=$O(^TMP("QACROCNO",$J,IEN)) Q:'IEN  D
 . S ROCNO="" F  S ROCNO=$O(^TMP("QACROCNO",$J,IEN,ROCNO)) Q:ROCNO=""  D
 .. S YR=^TMP("QACROCNO",$J,IEN,ROCNO) Q:YR=""  Q:'$D(YR(YR))
 .. S I=YR(YR)+1,YR(YR)=I
 .. S NEWROC=PARENT_"."_$E(YR,2,3)_$E("000",1,(4-$L(I)))_I
 .. S $P(^TMP("QACROCNO",$J,IEN,ROCNO),"^",2)=NEWROC Q
 . Q
 ;
 ;
FIX ; Repair ROC numbers
 N FDA,CNT
 S CNT=0
 F IEN=0:0 S IEN=$O(^TMP("QACROCNO",$J,IEN)) Q:'IEN  D
 . S ROCNO="" F  S ROCNO=$O(^TMP("QACROCNO",$J,IEN,ROCNO)) Q:ROCNO=""  D:ROCNO'=" "
 .. S NEWROC=$P(^TMP("QACROCNO",$J,IEN,ROCNO),"^",2) I NEWROC="" S ^TMP($J,"P20",LCNT)="ROC number "_ROCNO_" could not be changed. Please review manually for a missing Date of Contact.",LCNT=LCNT+1 Q
 .. S ^TMP($J,"P20",LCNT)="ROC Number changed from "_ROCNO_" to "_NEWROC,LCNT=LCNT+1
 .. K FDA S FDA(745.1,IEN_",",.01)=NEWROC
 .. D FILE^DIE("","FDA")
 .. S CNT=CNT+1
 .. Q
 . Q
 S ^TMP($J,"P20",LCNT)=CNT_" ROC Numbers have been corrected.",LCNT=LCNT+1
 D XMT
 Q
 ;
ENRPT ; Setup to print report of invalid ROCs
 N ZTSAVE
 S ZTSAVE("PATSHDR")=""
 D EN^XUTMDEVQ("DQRPT^QAC20PST","Report of Invalid ROCs",.ZTSAVE)
 Q
 ;
DQRPT ; Print report of invalid ROCs
 N PAGENO,LNCNT,ROCNO,IEN,NEWROC,HDDATE,%,%H,%I
 S PAGENO=1,LNCNT=0
 D NOW^%DTC S HDDATE=$$FMTE^XLFDT(%)
 U IO D HDR
 F IEN=0:0 S IEN=$O(^TMP("QACROCNO",$J,IEN)) Q:'IEN  D
 . S ROCNO="" F  S ROCNO=$O(^TMP("QACROCNO",$J,IEN,ROCNO)) Q:ROCNO=""  D
 .. D:LNCNT>55 HDR
 .. S NEWROC=$P(^TMP("QACROCNO",$J,IEN,ROCNO),"^",2)
 .. W !,IEN,?20,$S(ROCNO=" ":"Missing",1:ROCNO),?45,$S(NEWROC="":"Cannot be fixed",1:NEWROC)
 .. S LNCNT=LNCNT+1 Q
 . Q
 Q
 ;
HDR W #,!,"Report of Invalid ROCs",?43,HDDATE,?68,"Page "_PAGENO,!
 W "IEN",?20,"Old ROC Number",?45,"Suggested New ROC Number",!
 N X S X="",$P(X,"-",78)=""
 W X,!
 S LNCNT=0,PAGENO=PAGENO+1 Q
 ;
TIME ;Get current time
 D NOW^%DTC
 S Y=%
 D DD^%DT
 S TIME=Y
 Q
 ;
XMT ;Send report via mail message
 I $D(^TMP($J,"P20")) D
 . N DIFROM,XMDUZ,XMSUB,XMTEXT,XMY
 . S XMDUZ=.5
 . S XMSUB="QAC*2*20 POST INSTALL RESULTS"
 . S XMTEXT="^TMP($J,""P20"","
 . S XMY(DUZ)=""
 . D ^XMD
 ;
