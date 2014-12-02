VPRDCRC ;SLC/MKB,AGP -- Compute CRC32 for VistA data ;7/26/13 11:09am
 ;;1.0;VIRTUAL PATIENT RECORD;**2**;Sep 01, 2011;Build 317
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^DPT                         10035
 ; %ZTLOAD                      10063
 ; MPIF001                       2701
 ; XLFCRC                        3156
 ; XLFDT                        10103
 ;
CHECK(VPRCRC,FILTER) ; -- Return CRC32 checksums of VistA data
 ; RPC = VPR GET CHECKSUM
 ; where FILTER("system")    = name of calling/client system
 ;       FILTER("patientId") = DFN or DFN;ICN
 ;       FILTER("domain")    = name of desired data type (see VPRDJ0)
 ;       FILTER("uid")       = single item id to return  [opt]
 ;       FILTER("start")     = start date.time of search [opt]
 ;       FILTER("stop")      = stop date.time of search  [opt]
 ;       FILTER("queued")    = true or false
 ;
 ; VPRCRC returns the name of the ^TMP array containing the results
 ;
 N DFN,NODE,QUEUED,SYS,VPRSYS
 K ^TMP("VPRDCRC",$J),VPRCRC
 S SYS=$G(FILTER("system")) I SYS="" Q
 S DFN=$G(FILTER("patientId")) I DFN="" Q
 S QUEUED=$G(FILTER("queued"))
 S NODE="VPRDCRC "_SYS_"-"_"-"_DFN
 S FILTER("node")=NODE
 S VPRSYS=$$GET^XPAR("SYS","VPR SYSTEM NAME")
 ;
 ; - if not queued, generate checksums and exit w/values in ^TMP
 I QUEUED'="true" D  Q
 . S ^XTMP(NODE,0)=$$FMADD^XLFDT(DT,1)_U_DT_U_"Checksum for Server "_SYS_" patient "_DFN
 . D EN(.FILTER)
 . M ^TMP("VPRDCRC",$J)=^XTMP(NODE,"data")
 . S VPRCRC=$NA(^TMP("VPRDCRC",$J))
 . K ^XTMP(NODE)
 ;
 ; - Queue job if not started, else return data if done
 I +$G(^XTMP(NODE,"start"))=0 D QUEUED(.FILTER,NODE,SYS,DFN) Q
 I +$G(^XTMP(NODE,"stop"))>0 D  K ^XTMP(NODE)
 . I $G(^XTMP(NODE,"error"))'=""  S VPRCRC=^XTMP(NODE,"error") Q
 . S VPRCRC=$NA(^TMP("VPRDCRC",$J))
 . M ^TMP("VPRDCRC",$J)=^XTMP(NODE,"data")
 Q
 ;
QUEUED(FILTER,NODE,SYS,DFN) ; -- start job to generate checksums
 N ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTDTH,ZTSK
 S ^XTMP(NODE,0)=$$FMADD^XLFDT(DT,1)_U_DT_U_"Checksum for Server "_SYS_" patient "_DFN
 S ZTRTN="EN1^VPRDCRC",ZTDESC="Patient Checksum Extract for "_DFN
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
 N ICN,DFN,NODE,UID,VPRP,TYPE,VPRTN,CRC
 N VPRCRC,VPRSTART,VPRSTOP,VPRMAX,VPRI,VPRID,VPRTYPE ;for VPRDJ0
 K ^TMP("VPRCRC",$J),^TMP("VPRCRCF",$J)
 ;
 ; parse & validate input parameters
 S DFN=$G(FILTER("patientId")),VPRCRC=""
 S ICN=+$P($G(DFN),";",2),DFN=+$G(DFN)
 I DFN<1,ICN S DFN=+$$GETDFN^MPIF001(ICN)
 Q:DFN<1!'$D(^DPT(DFN))
 S NODE=$G(FILTER("node")) I NODE="" S NODE="VPRDCRC"
 ;
 S VPRMAX=9999,VPRI=0                                ;for VPRDJ0
 S VPRSTART=+$G(FILTER("start"),1410102)
 S VPRSTOP=+$G(FILTER("stop"),4141015)
 S UID=$G(FILTER("uid")),VPRTYPE=$G(FILTER("domain"))
 I $L(UID) S VPRTYPE=$P(UID,":",3),VPRID=$P(UID,":",6)
 E  S:VPRTYPE="" VPRTYPE=$$ALL
 ;
 F VPRP=1:1:$L(VPRTYPE,";") S TYPE=$P(VPRTYPE,";",VPRP) I $L(TYPE) D
 . S VPRTN=$$TAG^VPRDJ(TYPE)_"^VPRDJ0" Q:'$L($T(@VPRTN))
 . D @VPRTN
 ;
 I $L(UID) D  G ENQ ;single item
 . S CRC=$G(^TMP("VPRCRC",$J,VPRTYPE,UID))
 . S ^XTMP(NODE,"data",1)=CRC,^XTMP(NODE,"stop")=$$NOW^XLFDT()
 ; generate checksum for each domain requested
 S TYPE="" F  S TYPE=$O(^TMP("VPRCRC",$J,TYPE)) Q:TYPE=""  D
 . S CRC="" D GET($NA(^TMP("VPRCRC",$J,TYPE)),.CRC)
 . S ^TMP("VPRCRC",$J,TYPE)=CRC
 I $L(VPRTYPE,";")>1 D  ;get whole-chart checksum
 . S CRC="" D GET($NA(^TMP("VPRCRC",$J)),.CRC)
 . S ^TMP("VPRCRC",$J,"patient")=CRC
 ;
ENCODE ; -- return list(s) of checksums as JSON
 D PREP
 D ENCODE^VPRJSON($NA(^TMP("VPRCRCF",$J)),$NA(^XTMP(NODE,"data")),"ERROR")
 S ^XTMP(NODE,"stop")=$$NOW^XLFDT()
 ;
ENQ K ^TMP("VPRCRC",$J),^TMP("VPRCRCF",$J)
 Q
 ;
PREP ; -- reformat ^TMP("VPRCRC",$J) for JSON utility -> ^TMP("VPRCRCF",$J)
 N DCNT,DOMAIN,UID,UCNT
 S DOMAIN="",DCNT=0
 F  S DOMAIN=$O(^TMP("VPRCRC",$J,DOMAIN)) Q:DOMAIN=""  D
 . S ^TMP("VPRCRCF",$J,DOMAIN,"crc")=^TMP("VPRCRC",$J,DOMAIN)
 . S UCNT=0,UID="" F  S UID=$O(^TMP("VPRCRC",$J,DOMAIN,UID)) Q:UID=""  D
 .. S UCNT=UCNT+1,^TMP("VPRCRCF",$J,DOMAIN,"uids",UCNT,UID)=^TMP("VPRCRC",$J,DOMAIN,UID)
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
 S ^TMP("VPRCRC",$J,COLL,UID)=CRC
 S VPRI=VPRI+1
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
