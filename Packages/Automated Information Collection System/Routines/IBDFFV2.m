IBDFFV2 ;ALB/CMR - AICS FORM VALIDATION ; NOV 27,1995
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
 ;
 ; -- entry point from IBDFFV
 ; -- called to print out data validation
 ;
 Q:'$D(^TMP($J,"IBFV"))
 W:IOST["C-" @IOF
 N SORT,DOT
 S DOT=".",$P(DOT,".",35)=".",SORT=$O(^TMP($J,"IBFV","")) Q:SORT']""
 ; -- if sorted by form, gather forms to print
 I SORT="F" N FORM,TYPE,FRM,WRITE D  Q
 .S TYPE=$P($T(TYPE+1),";;",2)
 .S FORM="" F  S FORM=$O(^TMP($J,"IBFV",SORT,FORM)) Q:FORM']""!($G(IBDFOUT))  S FRM=0 F  S FRM=$O(^TMP($J,"IBFV",SORT,FORM,FRM)) Q:'FRM!($G(IBDFOUT))  D PRINT^IBDFFV3(FRM,FORM) I '$G(WRITE) D
 ..S ^TMP($J,"IBDF","UC",SORT,FORM)=""
 ; -- if sorted by clinic, gather clinics
 I SORT="C" N CLIN,SETUP,CL,DG D  Q
 .S CLIN="" F  S CLIN=$O(^TMP($J,"IBFV",SORT,CLIN)) Q:CLIN']""!($G(IBDFOUT))  S CL="CLINIC:  .."_DOT_"  "_CLIN,DG="",SETUP=0 F  S SETUP=$O(^TMP($J,"IBFV",SORT,CLIN,SETUP)) Q:'SETUP!($G(IBDFOUT))  D CLIN
 ; -- if sorted by group, gather groups or divisions and clinics
 I SORT="G"!(SORT="D") N HEADER,CLIN,SETUP,CL,DG D  Q
 .S HEADER="" F  S HEADER=$O(^TMP($J,"IBFV",SORT,HEADER)) Q:HEADER']""!($G(IBDFOUT))  D
 ..S CLIN="" F  S CLIN=$O(^TMP($J,"IBFV",SORT,HEADER,CLIN)) Q:CLIN']""!($G(IBDFOUT))  D
 ...S DG=$S(SORT="G":"GROUP:  ...",SORT="D":"DIVISION:  ",1:"")
 ...I DG]"" S DG=DG_DOT_"  "_HEADER
 ...S CL="CLINIC:  .."_DOT_"  "_CLIN
 ...S SETUP=0 F  S SETUP=$O(^TMP($J,"IBFV",SORT,HEADER,CLIN,SETUP)) Q:'SETUP!($G(IBDFOUT))  D CLIN
 Q
CLIN ; -- gather forms for clinics
 N NODE,TYPE,FRM,CHECK,WRITE,NAME
 S NODE=$G(^SD(409.95,SETUP,0))
 F I=2:1:9 S FRM=$P(NODE,U,I) I FRM D PRINT^IBDFFV3(FRM,.NAME,I,CL,DG) Q:$G(IBDFOUT)  I '$D(WRITE) D
 .I SORT="C" S ^TMP($J,"IBDF","UC",SORT,CLIN,NAME)="" Q
 .S ^TMP($J,"IBDF","UC",SORT,HEADER,CLIN,NAME)=""
 Q
