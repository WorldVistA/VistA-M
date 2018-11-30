DVBCIRP2 ;ALB/RTW - CAPRI INSUFFICIENT 2507 RPT -CONT 1 ; 07/17/2015  4:24 AM
 ;;2.7;AMIE;**192**;Apr 10, 1995;Build 15
 ;Copied DVBCIRP1 and to remove all Priority of exam filter code for CAPRI only
 ;CAPRI Insufficient Exam Report no longer uses priority of exam filters
 ;no longer uses insufficient reason filters
 ;** Version Changes
 ;   2.7 - New routine (Enhc 1)
 ;
SUMRPT ;**Output the summary report
 W:IOST?1"C-".E @IOF
 D SUMHD
 ;print request data
 W !?3,"Total 2507 requests received for date range:",?71,$J(DVBARQCT,5)
 W !?3,"Total insufficient 2507 requests received for date range:",?71,$J(DVBAINRQ,5)
 W !?3,"Total insufficient 2507 requests cancelled by RO for date range:",?71,$J(DVBACAN("REQ"),5)
 I DVBARQCT>0 D
 .S PERCENT=(DVBAINRQ/DVBARQCT)*100
 .W !?3,"% of insufficient requests per total requests received:",?71,$J(PERCENT,5,1)_"%"
 .S PERCENT=((DVBAINRQ-DVBACAN("REQ"))/DVBARQCT)*100
 .W !?3,"% of uncancelled insufficient requests per total requests received:",?71,$J(PERCENT,5,1)_"%"
 I DVBARQCT'>0 D
 .S PERCENT=0
 .W !?3,"% of insufficient requests per total requests received:",?71,$J(PERCENT,5,1)_"%"
 .W !?3,"% of uncancelled insufficient requests per total requests received:",?71,$J(PERCENT,5,1)_"%"
 ;print exam data
 W !!?3,"Total 2507 exams received for date range:",?71,$J(DVBAXMCT,5)
 W !?3,"Total insufficient 2507 exams received for date range:",?71,$J(DVBAINXM,5)
 W !?3,"Total insufficient 2507 exams cancelled by RO for date range:",?71,$J(DVBACAN("EXM"),5)
 I DVBAXMCT>0 D
 .S PERCENT=(DVBAINXM/DVBAXMCT)*100
 .W !?3,"% of insufficient exams per total exams received:",?71,$J(PERCENT,5,1)_"%"
 .S PERCENT=((DVBAINXM-DVBACAN("EXM"))/DVBAXMCT)*100
 .W !?3,"% of uncancelled insufficient exams per total exams received:",?71,$J(PERCENT,5,1)_"%"
 I DVBAXMCT'>0 D
 .S PERCENT=0
 .W !?3,"% of insufficient exams per total exams received:",?71,$J(PERCENT,5,1)_"%"
 .W !?3,"% of uncancelled insufficient exams per total exams received:",?71,$J(PERCENT,5,1)_"%"
 ;print insufficient reason data
 I IOST?1"C-".E DO
 .K DTOUT,DUOUT
 .W !!
 .D PAUSE^DVBCUTL4
 .I '$D(DTOUT),('$D(DUOUT)) DO
 ..W @IOF
 ..D SUMHD
 I '$D(DTOUT),('$D(DUOUT)) DO
 .W:IOST'?1"C-".E !!
 .W !?15,"Summary of insufficient exams per Reason",!
 .W !?3,"Reason",?53,"Num",?59,"Percent"
 .N DVBARSLP S DVBARSLP=""
 .F  S DVBARSLP=$O(DVBAINXM(DVBARSLP)) Q:DVBARSLP=""  DO  ;**Reason tot's
 ..W:+DVBARSLP>0 !?3,$P(^DVB(396.94,DVBARSLP,0),U,3),?53,DVBAINXM(DVBARSLP)
 ..I +DVBARSLP'>0,(+DVBAINXM(DVBARSLP)>0) W !?3,"Exams without insufficient reason indicated",?53,DVBAINXM(DVBARSLP)
 ..W:(+DVBAINXM(DVBARSLP)>0&(DVBAINXM>0)) ?59,($P(((DVBAINXM(DVBARSLP)/DVBAINXM)*100),".",1))_$S($E($P(((DVBAINXM(DVBARSLP)/DVBAINXM)*100),".",2),1,1)'="":"."_$E($P(((DVBAINXM(DVBARSLP)/DVBAINXM)*100),".",2),1,1),1:"")_" %"
 .I IOST?1"C-".E DO
 ..D CONTMES^DVBCUTL4
 Q
 ;
SUMHD ;** Output Summary Report heading
 N STRTDT,LSTDT,DVBATXT,DVBASL
 W !?15,"Summary Insufficient Exam Report for ",$$SITE^DVBCUTL4(),!
 S Y=$P(BEGDT,".",1) X ^DD("DD") S STRTDT=Y K Y
 S Y=$P(ENDDT,".",1) X ^DD("DD") S LSTDT=Y K Y
 S DVBASL=$L($$SITE^DVBCUTL4)
 ;S DVBATXT=$$PRHD^DVBCIUTL(DVBAPRTY)
 S DVBATXT=""
 W ?(((67+DVBASL)-$L(DVBATXT))\2)
 W !?16,"For Date Range: "_STRTDT_" to "_LSTDT,!
 Q
 ;
DETAIL ;** Output reason, exam type and exam info
 ;RSDA is the reason ien
 ;TPDA is the exam type ien
 ;XMDA is the exam ien from 396.4
 ;DVBARQST is the request ien from 396.3
 N STRTDT,LSTDT,DVBARQST,DVBAEXMP,DVBAP,DVBAPREXM,MSGCNT
 S MSGCNT=0
 K ^TMP("DVBAEXAMS",$J),^TMP("INSUFF",$J)
 S X=$P(BEGDT,".",1),STRTDT=$$FMTE^XLFDT(X,"5DZ")
 S Y=$P(ENDDT,".",1),LSTDT=$$FMTE^XLFDT(Y,"5DZ")
 U IO
 S DVBADTLP=BEGDT
 S DVBAENDL=ENDDT
 S RSDA=""
 S DVBAPG1=""
 F  S RSDA=$O(DVBAARY("REASON",RSDA)) Q:(RSDA=""!($D(GETOUT)))  DO
 .K DVBARSPT
 .S TPDA=""
 .F  S TPDA=$O(^TMP($J,"XMTYPE",TPDA)) Q:(TPDA=""!($D(GETOUT)))  DO
 ..K DVBAXMPT
 ..S XMDA=""
 ..F  S XMDA=$O(^DVB(396.4,"AIT",RSDA,TPDA,XMDA)) Q:(XMDA=""!($D(GETOUT)))  DO
 ...S DVBARQST=$G(^DVB(396.3,$P(^DVB(396.4,XMDA,0),U,2),0))
 ...I $P(DVBARQST,U,5)>DVBADTLP,($P(DVBARQST,U,5)<DVBAENDL) D
 ....S ^TMP("DVBAEXAMS",$J,RSDA,TPDA,XMDA)=""
 S DVBABIEN=DVBARQST
 K DVBAPG1 S RSDA=""
 D CAPDETHD^DVBCIUTL S DVBAPG1=""
 F  S RSDA=$O(^TMP("DVBAEXAMS",$J,RSDA)) Q:(('+RSDA)!($D(GETOUT)))  D
 .K DVBARSPT S TPDA=""
 .F  S TPDA=$O(^TMP("DVBAEXAMS",$J,RSDA,TPDA)) Q:(('+TPDA)!($D(GETOUT)))  D
 ..K DVBAXMPT S XMDA=""
 ..F  S XMDA=$O(^TMP("DVBAEXAMS",$J,RSDA,TPDA,XMDA)) Q:(('+XMDA)!($D(GETOUT)))  D EXMOUT^DVBCIUTL
 I '$D(GETOUT),(IOST?1"C-".E) D CONTMES^DVBCUTL4
 K GETOUT W !
 D ^%ZISC
 D KVARS ;**KILL the variables used by DETAIL
 Q
 ;
KVARS ;** Final Kill for Detail report
 S:$D(ZTQUEUED) ZTREQ="@"
 K ^TMP($J),DVBAARY,DVBANAME,DVBASSN,DVBACNUM,RSDA,TPDA,XMDA,DVBADTLP,DVBAENDL
 Q
 ;
 ;
 ;Input:  IEN of 2507 Request in File #396.3
 ;Output: Priority of Exam for the Current/Parent 2507 Request
CHKREQ(DVBARIEN) ;check for parent requests
 N DVBAPIEN,DVBAPEXM
 Q:($G(DVBARIEN)']"") ""
 S DVBAPEXM=$P($G(^DVB(396.3,DVBARIEN,0)),U,10)  ;Priority of Exam
 S DVBAPIEN=$P($G(^DVB(396.3,DVBARIEN,5)),U)  ;parent IEN if it exists
 I (DVBAPIEN]"") D  ;Parent 2507 Request
 .S DVBAPEXM=$P($G(^DVB(396.3,DVBAPIEN,0)),U,10)  ;Priority of Exam
 Q DVBAPEXM
SUM ;** Set up reason counter array, count all 2507's received
 ;copied from DVBCIRPT 
 N DVBAEXMP,DVBAI,DVBAP,DVBATVAR,DVBAMCDES,DVBAPREXM
 U IO
 S (DVBARQCT,DVBAINRQ,DVBAXMCT,DVBAINXM)=0
 S DVBACAN("REQ")=0,DVBACAN("EXM")=0
 S DVBAENDL=ENDDT
 S DVBAEXMP=$S(($G(DVBAPRTY)["BDD"):";BDD;QS;",($G(DVBAPRTY)["IDES"):";IDES;",($G(DVBAPRTY)["AO"):";AO;",1:"")
 ; S DVBAMCDES=((DVBAEXMP]"")&(DVBAPRTY'="AO"))
 S NUMRPTS=$L(DVBAEXMP,";")
 S DVBAMCDES=((DVBAEXMP]"")&(NUMRPTS>3))
 K ^TMP("DVBATOTALS",$J)  ;for multiple priority reporting
 ;
 ;** Initialize reason counter array(s)
 F DVBARIFN=0:0 S DVBARIFN=$O(^DVB(396.94,DVBARIFN)) Q:+DVBARIFN'>0  DO
 .D:(DVBAMCDES)
 ..F DVBAP=$P(DVBAEXMP,";",2),$P(DVBAEXMP,";",3)  D
 ...Q:DVBAP=""
 ...S ^TMP("DVBATOTALS",$J,DVBAP,"DVBAINXM",DVBARIFN)=0
 .S DVBAINXM(DVBARIFN)=0
 D:(DVBAMCDES)
 .F DVBAP=$P(DVBAEXMP,";",2),$P(DVBAEXMP,";",3)  D
 ..Q:DVBAP=""
 ..S ^TMP("DVBATOTALS",$J,DVBAP,"DVBAINXM","NO REASON")=0
 S DVBAINXM("NO REASON")=0
 ;
 ;** Count the total and insufficient number of exams and 2507 requests
 ;     For performance, if multiple reports, store totals in single pass of data
 S DVBADTLP=BEGDT-.0001
 F  S DVBADTLP=$O(^DVB(396.3,"ADP",DVBADTLP)) Q:(DVBADTLP=""!(DVBADTLP>ENDDT))  DO
 .S DVBAPRIO=""
 .F  S DVBAPRIO=$O(^DVB(396.3,"ADP",DVBADTLP,DVBAPRIO)) Q:DVBAPRIO=""  DO
 ..S DVBADALP=""
 ..F  S DVBADALP=$O(^DVB(396.3,"ADP",DVBADTLP,DVBAPRIO,DVBADALP)) Q:DVBADALP=""  DO
 ...;check for Parent Request (retrieve current/parent Priority of Exam)
 ...S DVBAPREXM=$$CHKREQ(DVBADALP)
 ...S DVBAPREXM=""
 ...;original report run (Exclude new priorities)
 ...Q:((DVBAEXMP']"")&((";BDD;QS;IDES;AO;")[(";"_DVBAPREXM_";")))
 ...;report for specific Priority of Exam
 ...Q:((DVBAEXMP]"")&(DVBAEXMP'[(";"_DVBAPREXM_";")))
 ...S:(DVBAMCDES) ^TMP("DVBATOTALS",$J,DVBAPREXM,"DVBARQCT")=$G(^TMP("DVBATOTALS",$J,DVBAPREXM,"DVBARQCT"))+1
 ...S DVBARQCT=DVBARQCT+1
 ...K DVBAINSF
 ...I DVBAPRIO="E" DO
 ....S:(DVBAMCDES) ^TMP("DVBATOTALS",$J,DVBAPREXM,"DVBAINRQ")=$G(^TMP("DVBATOTALS",$J,DVBAPREXM,"DVBAINRQ"))+1
 ....S DVBAINRQ=DVBAINRQ+1
 ....I $P(^DVB(396.3,DVBADALP,0),U,18)="RX" D
 .....S:(DVBAMCDES) ^TMP("DVBATOTALS",$J,DVBAPREXM,"DVBACANREQ")=$G(^TMP("DVBATOTALS",$J,DVBAPREXM,"DVBACANREQ"))+1
 .....S DVBACAN("REQ")=DVBACAN("REQ")+1
 ....S DVBAINSF=""
 ...S DVBAXMDA=""
 ...F  S DVBAXMDA=$O(^DVB(396.4,"C",DVBADALP,DVBAXMDA)) Q:DVBAXMDA=""  DO
 ....S:(DVBAMCDES) ^TMP("DVBATOTALS",$J,DVBAPREXM,"DVBAXMCT")=$G(^TMP("DVBATOTALS",$J,DVBAPREXM,"DVBAXMCT"))+1
 ....S DVBAXMCT=DVBAXMCT+1
 ....I $D(DVBAINSF) DO
 .....S:(DVBAMCDES) ^TMP("DVBATOTALS",$J,DVBAPREXM,"DVBAINXM")=$G(^TMP("DVBATOTALS",$J,DVBAPREXM,"DVBAINXM"))+1
 .....S DVBAINXM=DVBAINXM+1
 .....S DVBARIFN=$P(^DVB(396.4,DVBAXMDA,0),U,11),DVBASTAT=$P(^(0),U,4)
 .....S:DVBARIFN="" DVBARIFN="NO REASON"
 .....S:(DVBAMCDES) ^TMP("DVBATOTALS",$J,DVBAPREXM,"DVBAINXM",DVBARIFN)=$G(^TMP("DVBATOTALS",$J,DVBAPREXM,"DVBAINXM",DVBARIFN))+1
 .....S DVBAINXM(DVBARIFN)=DVBAINXM(DVBARIFN)+1
 .....I DVBASTAT="RX" D
 ......S:(DVBAMCDES) ^TMP("DVBATOTALS",$J,DVBAPREXM,"DVBACANEXM")=$G(^TMP("DVBATOTALS",$J,DVBAPREXM,"DVBACANEXM"))+1
 ......S DVBACAN("EXM")=DVBACAN("EXM")+1
 ;
 S DVBAEXMP=$S(($G(DVBAPRTY)["BDD"):"BDD,QS",($G(DVBAPRTY)["IDES"):"IDES",($G(DVBAPRTY)["AO"):"AO",1:"")
 F DVBAI=1:1:$L(DVBAEXMP,",")  D
 .S DVBAPRTY=$P(DVBAEXMP,",",DVBAI)  ;priority to report on
 .D:(DVBAI>1)  ;Form Feed between multiple Reports
 ..S DVBATVAR(1,0)="0,0,0,0,1^"
 ..D WR^DVBAUTL4("DVBATVAR")
 .;
 .D:(DVBAMCDES)  ;reset var cntrs for specific priority
 ..S DVBARQCT=+$G(^TMP("DVBATOTALS",$J,DVBAPRTY,"DVBARQCT"))
 ..S DVBAINRQ=+$G(^TMP("DVBATOTALS",$J,DVBAPRTY,"DVBAINRQ"))
 ..S DVBACAN("REQ")=+$G(^TMP("DVBATOTALS",$J,DVBAPRTY,"DVBACANREQ"))
 ..S DVBAXMCT=+$G(^TMP("DVBATOTALS",$J,DVBAPRTY,"DVBAXMCT"))
 ..S DVBAINXM=+$G(^TMP("DVBATOTALS",$J,DVBAPRTY,"DVBAINXM"))
 ..S DVBAP=0 F  S DVBAP=$O(^TMP("DVBATOTALS",$J,DVBAPRTY,"DVBAINXM",DVBAP)) Q:DVBAP=""  D
 ...S DVBAINXM(DVBAP)=+$G(^TMP("DVBATOTALS",$J,DVBAPRTY,"DVBAINXM",DVBAP))
 ..S DVBACAN("EXM")=+$G(^TMP("DVBATOTALS",$J,DVBAPRTY,"DVBACANEXM"))
 .;
 .D SUMRPT  ;print SUMMARY report
 S:$D(ZTQUEUED) ZTREQ="@"
 D SUMKILL
 D ^%ZISC
 Q
 ;
SUMKILL ;** Kill the variables used in the summary report
 K DVBADTLP,DVBAENDL,DVBARQCT,DVBAINRQ,DVBAXMCT,DVBAINXM
 K DVBAPRIO,DVBADALP,DVBAXMDA,DVBAINSF,DVBARIFN
 K ^TMP("DVBATOTALS",$J)
 Q
