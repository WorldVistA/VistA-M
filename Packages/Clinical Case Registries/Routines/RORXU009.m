RORXU009 ;HOIFO/VC - REPORT MODIFICATON UTILITY ;2/10/09 5:01pm
 ;;1.5;CLINICAL CASE REGISTRIES;**8**;Feb 17, 2006;Build 8
 ;
 Q
DEL(TSK) ;DELETES RECORDS FROM A REPORT FILE
 ;This routine will remove all except the most recent lab test
 ;Input    TASK - the task number created when the report is generated
 ;
 K ^TMP($J,"RORKILL")
 N NAMEOLD,DATENEW,TEST,DATE,BEG,CTR,END,NAME,RES,J,K,I,M,N,X
 S I=0,NAMEOLD="",DATENEW=""
 ;
 ;---  Put the test records in order by Patient,test,and date
 ;
 F X=1:1 S I=$O(^RORDATA(798.8,TSK,"RI",I)) D  Q:+I=0
 .S NAME=$G(^RORDATA(798.8,TSK,"RI",I,1))
 .Q:NAME'[","
 .S J=I+3
 .S DATENEW=$G(^RORDATA(798.8,TSK,"RI",J,1))
 .Q:DATENEW=""
 .S K=I+4
 .S TEST=$G(^RORDATA(798.8,TSK,"RI",K,1))
 .Q:TEST=""
 .S CTR=1
 .S RES=0
 .I $G(^TMP($J,"RORKILL",NAME,TEST,(DATENEW*(-1)),CTR))'="" D
 ..S CTR=CTR+1
 ..F M=1:1:10 I $G(^TMP($J,"RORKILL",NAME,TEST,(DATENEW*(-1)),CTR))'="" S CTR=CTR+1
 .S ^TMP($J,"RORKILL",NAME,TEST,(DATENEW*(-1)),CTR)=(I-1)_U_(K+1)
 ;
 ;--- Use the TMP file to kill the nodes in file 798.8
 ;
 S NAME=""
 F  S NAME=$O(^TMP($J,"RORKILL",NAME)) Q:NAME=""  D
 .S TEST=""
 .F  S TEST=$O(^TMP($J,"RORKILL",NAME,TEST)) Q:TEST=""  D
 ..S DATE=-9999999
 ..F M=1:1  S DATE=$O(^TMP($J,"RORKILL",NAME,TEST,DATE)) Q:DATE=""  D
 ...Q:M=1
 ...S CTR=0
 ...F  S CTR=$O(^TMP($J,"RORKILL",NAME,TEST,DATE,CTR)) Q:CTR=""  D
 ....S BEG=$P(^TMP($J,"RORKILL",NAME,TEST,DATE,CTR),U,1)
 ....S END=$P(^TMP($J,"RORKILL",NAME,TEST,DATE,CTR),U,2)
 ....F N=BEG:1:END K ^RORDATA(798.8,TSK,"RI",N)
 K ^TMP($J,"RORKILL")
 Q
 ;
