HMPDCRC ;SLC/MKB,AGP,ASMR/RRB - Compute CRC32 for VistA data;May 15, 2016 14:15
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**1**;May 15, 2016;Build 4
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^DPT                         10035
 ; %ZTLOAD                      10063
 ; MPIF001                       2701
 ; XLFCRC                        3156
 ; XLFDT                        10103
 Q
 ;
CHECK(HMPCRC,FILTER) ; -- Return CRC32 checksums of VistA data
 ; RPC = HMP GET CHECKSUM
 ; where FILTER("system")    = name of calling/client system
 ;       FILTER("patientId") = DFN or DFN;ICN
 ;       FILTER("domain")    = name of desired data type (see HMPDJ0)
 ;       FILTER("uid")       = single item id to return  [opt]
 ;       FILTER("start")     = start date.time of search [opt]
 ;       FILTER("stop")      = stop date.time of search  [opt]
 ;       FILTER("queued")    = true or false
 ;
 ; HMPCRC returns the name of the ^TMP array containing the results
 ;
 N DFN,NODE,QUEUED,SYS,HMPSYS
 K ^TMP("HMPDCRC",$J),HMPCRC
 S SYS=$G(FILTER("system")) I SYS="" Q
 S DFN=$G(FILTER("patientId")) I DFN="" Q
 S QUEUED=$G(FILTER("queued"))
 S NODE="HMPDCRC "_SYS_"-"_"-"_DFN
 S FILTER("node")=NODE
 S HMPSYS=$$SYS^HMPUTILS
 ;
 ; - if not queued, generate checksums and exit w/values in ^TMP
 I QUEUED'="true" D  Q
 . S ^XTMP(NODE,0)=$$FMADD^XLFDT(DT,1)_U_DT_U_"Checksum for Server "_SYS_" patient "_DFN
 . D EN(.FILTER)
 . M ^TMP("HMPDCRC",$J)=^XTMP(NODE,"data")
 . S HMPCRC=$NA(^TMP("HMPDCRC",$J))
 . K ^XTMP(NODE)
 ;
 ; - Queue job if not started, else return data if done
 I +$G(^XTMP(NODE,"start"))=0 D QUEUED(.FILTER,NODE,SYS,DFN) Q
 I +$G(^XTMP(NODE,"stop"))>0 D  K ^XTMP(NODE)
 . I $G(^XTMP(NODE,"error"))'=""  S HMPCRC=^XTMP(NODE,"error") Q
 . S HMPCRC=$NA(^TMP("HMPDCRC",$J))
 . M ^TMP("HMPDCRC",$J)=^XTMP(NODE,"data")
 Q
 ;
QUEUED(FILTER,NODE,SYS,DFN) ; -- start job to generate checksums
 N ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTDTH,ZTSK
 S ^XTMP(NODE,0)=$$FMADD^XLFDT(DT,1)_U_DT_U_"Checksum for Server "_SYS_" patient "_DFN
 S ZTRTN="EN1^HMPDCRC",ZTDESC="Patient Checksum Extract for "_DFN
 S ZTDTH=$$NOW^XLFDT(),ZTIO="",ZTSAVE("FILTER(")=""
 S ^XTMP(NODE,"start")=$$NOW^XLFDT()
 D ^%ZTLOAD I +$G(ZTSK)>0  S ^XTMP(NODE,"task")=+$G(ZTSK) Q    ;success
 S ^XTMP(NODE,"error")="Cannot start a task job"
 S ^XTMP(NODE,"stop")=$$NOW^XLFDT()
 S ^XTMP(NODE,"task")=ZTSK
 Q
 ;
EN(FILTER) ; -- Return CRC values of requested data in ^XTMP(node,"data") as JSON
EN1 ;           [entry point for queued job]
 ;
 N ICN,DFN,NODE,UID,HMPP,TYPE,HMPTN,CRC
 N HMPCRC,HMPSTART,HMPSTOP,HMPMAX,HMPI,HMPID,HMPTYPE ;for HMPDJ0
 K ^TMP("HMPCRC",$J),^TMP("HMPCRCF",$J)
 ;
 ; parse & validate input parameters
 S DFN=$G(FILTER("patientId")),HMPCRC=""
 S ICN=+$P($G(DFN),";",2),DFN=+$G(DFN)
 I DFN<1,ICN S DFN=+$$GETDFN^MPIF001(ICN)
 Q:DFN<1!'$D(^DPT(DFN))  ;ICR 10035 DE 2818 ASF 11/2/15
 S NODE=$G(FILTER("node")) I NODE="" S NODE="HMPDCRC"
 ;
 S HMPMAX=9999,HMPI=0                                ;for HMPDJ0
 S HMPSTART=+$G(FILTER("start"),1410102)
 S HMPSTOP=+$G(FILTER("stop"),4141015)
 S UID=$G(FILTER("uid")),HMPTYPE=$G(FILTER("domain"))
 I $L(UID) S HMPTYPE=$P(UID,":",3),HMPID=$P(UID,":",6)
 E  S:HMPTYPE="" HMPTYPE=$$ALL
 ;
 F HMPP=1:1:$L(HMPTYPE,";") S TYPE=$P(HMPTYPE,";",HMPP) I $L(TYPE) D
 . S HMPTN=$$TAG^HMPDJ(TYPE)_"^HMPDJ0" Q:'$L($T(@HMPTN))
 . D @HMPTN
 ;
 I $L(UID) D  G ENQ ;single item
 . S CRC=$G(^TMP("HMPCRC",$J,HMPTYPE,UID))
 . S ^XTMP(NODE,"data",1)=CRC,^XTMP(NODE,"stop")=$$NOW^XLFDT()
 ; generate checksum for each domain requested
 S TYPE="" F  S TYPE=$O(^TMP("HMPCRC",$J,TYPE)) Q:TYPE=""  D
 . S CRC="" D GET($NA(^TMP("HMPCRC",$J,TYPE)),.CRC)
 . S ^TMP("HMPCRC",$J,TYPE)=CRC
 I $L(HMPTYPE,";")>1 D  ;get whole-chart checksum
 . S CRC="" D GET($NA(^TMP("HMPCRC",$J)),.CRC)
 . S ^TMP("HMPCRC",$J,"patient")=CRC
 ;
ENCODE ; -- return list(s) of checksums as JSON
 D PREP
 D ENCODE^HMPJSON($NA(^TMP("HMPCRCF",$J)),$NA(^XTMP(NODE,"data")),"ERROR")
 S ^XTMP(NODE,"stop")=$$NOW^XLFDT()
 ;
ENQ K ^TMP("HMPCRC",$J),^TMP("HMPCRCF",$J)
 Q
 ;
PREP ; -- reformat ^TMP("HMPCRC",$J) for JSON utility -> ^TMP("HMPCRCF",$J)
 N DCNT,DOMAIN,UID,UCNT
 S DOMAIN="",DCNT=0
 F  S DOMAIN=$O(^TMP("HMPCRC",$J,DOMAIN)) Q:DOMAIN=""  D
 . S ^TMP("HMPCRCF",$J,DOMAIN,"crc")=^TMP("HMPCRC",$J,DOMAIN)
 . S UCNT=0,UID="" F  S UID=$O(^TMP("HMPCRC",$J,DOMAIN,UID)) Q:UID=""  D
 .. S UCNT=UCNT+1,^TMP("HMPCRCF",$J,DOMAIN,"uids",UCNT,UID)=^TMP("HMPCRC",$J,DOMAIN,UID)
 Q
 ;
GET(LIST,CRC) ; -- compute CRC32 value for LIST of strings
 N I S CRC=$G(CRC),I=""
 F  S I=$O(@LIST@(I)) Q:I=""  I $G(@LIST@(I))'="" S CRC=$$CRC32^XLFCRC(I_":"_@LIST@(I),CRC)
 Q
 ;
ONE(ARRAY,COLL) ; -- process one data item [save result in ^TMP]
 N LIST,UID,ATTR,CRC
 S LIST=$$ATTR(COLL),UID=$G(@ARRAY@("uid")) Q:UID=""
 S ATTR="" F  S ATTR=$O(@ARRAY@(ATTR)) Q:ATTR=""  I LIST'[(U_ATTR_U) K @ARRAY@(ATTR)
 D GET(ARRAY,.CRC)
 S ^TMP("HMPCRC",$J,COLL,UID)=CRC
 S HMPI=HMPI+1
 Q
 ;
GET1(ARRAY,COLL) ; -- process one data item [return result]
 N LIST,ATTR,ITEM,CRC
 S LIST=$$ATTR(COLL)
 S ATTR="" F  S ATTR=$O(@ARRAY@(ATTR)) Q:ATTR=""  I LIST[(U_ATTR_U) S ITEM(ATTR)=@ARRAY@(ATTR)
 D GET(ITEM,.CRC)
 Q CRC
 ;
ALL() ; -- return string for all types of data
 Q "problem;allergy;consult;vital;lab;procedure;obs;order;treatment;med;ptf;factor;immunization;exam;cpt;education;pov;skin;image;appointment;surgery;document;visit;mh"
 ;
ATTR(X) ; -- return list of attributes needed for collection X
 N Y S Y=""
 I X="vital"        S Y="^observed^typeName^result^"
 I X="problem"      S Y="^onset^problemText^statusName^"
 I X="allergy"      S Y="^entered^summary^"
 I X="order"        S Y="^start^name^statusName^"
 I X="treatment"    S Y="^start^name^statusName^"
 I X="med"          S Y="^overallstart^name^vaStatus^"
 I X="consult"      S Y="^startDate^typeName^statusName^"
 I X="procedure"    S Y="^dateTime^name^statusName^"
 I X="obs"          S Y="^observed^typeName^result^"
 I X="lab"          S Y="^observed^typeName^"
 I X="image"        S Y="^dateTime^name^statusName^"
 I X="surgery"      S Y="^dateTime^typeName^statusName^"
 I X="document"     S Y="^referenceDateTime^localTitle^statusName^"
 I X="mh"           S Y="^administeredDateTime^name^"
 I X="immunization" S Y="^administeredDateTime^name^"
 I X="pov"          S Y="^entered^name^"
 I X="skin"         S Y="^entered^name^result^"
 I X="exam"         S Y="^entered^name^result^"
 I X="cpt"          S Y="^entered^name^"
 I X="education"    S Y="^entered^name^result^"
 I X="factor"       S Y="^entered^name^"
 I X="appointment"  S Y="^dateTime^typeName^appointmentStatus^"
 I X="visit"        S Y="^dateTime^typeName^"
 I X="ptf"          S Y="^arrivalDateTime^icdCode^"
 Q Y
 ;
 ;
TEST(FILTER) ;
 N DONE,OUT
 S DONE=0
 F  D  Q:DONE=1
 .D CHECK(.OUT,.FILTER)
 .H 1 W !,$D(OUT)
 .I $D(OUT)>0 S DONE=1
 Q
