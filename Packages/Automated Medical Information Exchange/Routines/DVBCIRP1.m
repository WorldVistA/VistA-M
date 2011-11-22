DVBCIRP1 ;ALB/GTS-AMIE INSUFFICIENT 2507 RPT -CONT 1 ; 11/10/94  1:30 PM
 ;;2.7;AMIE;**13,19,27,149**;Apr 10, 1995;Build 16
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;** Version Changes
 ;   2.7 - New routine (Enhc 15)
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
 S DVBATXT=$$PRHD^DVBCIUTL(DVBAPRTY)
 W ?(((67+DVBASL)-$L(DVBATXT))\2),DVBATXT,!
 W !?16,"For Date Range: "_STRTDT_" to "_LSTDT,!
 Q
 ;
DETAIL ;** Output reason, exam type and exam info
 N STRTDT,LSTDT,DVBARQST,DVBAEXMP,DVBAP,DVBAPREXM
 K ^TMP("DVBAEXAMS",$J)
 S Y=$P(BEGDT,".",1) X ^DD("DD") S STRTDT=Y K Y
 S Y=$P(ENDDT,".",1) X ^DD("DD") S LSTDT=Y K Y
 U IO
 S DVBADTLP=BEGDT
 S DVBAENDL=ENDDT
 S DVBAPRTY=$S(($G(DVBAPRTY)["BDD"):";BDD;QS;",($G(DVBAPRTY)["DES"):";DCS;DFD;",($G(DVBAPRTY)["AO"):";AO;",1:"")
 D:((DVBAPRTY']"")!(DVBAPRTY["AO")) DETHD^DVBCIUTL
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
 ...;retrieve Priority of Exam from Current/Parent(if exists) 2507 Request
 ...S DVBAPREXM=$$CHKREQ($P(^DVB(396.4,XMDA,0),U,2))
 ...I $P(DVBARQST,U,5)>DVBADTLP,($P(DVBARQST,U,5)<DVBAENDL) D
 ....;Current-As Is (All Others, except new priorities)
 ....D:((DVBAPRTY']"")&((";BDD;QS;DCS;DFD;AO;")'[(";"_DVBAPREXM_";"))) EXMOUT^DVBCIUTL
 ....;Report for Specific Priority of Exam(s)
 ....D:((DVBAPRTY]"")&(DVBAPRTY[(";"_DVBAPREXM_";")))
 .....D:(DVBAPREXM="AO") EXMOUT^DVBCIUTL  ;Agent Orange Single Report
 .....;BDD,QS,DCS,DFD require report for each priority code
 .....;for performance grab all data then print 2 reports
 .....S:(DVBAPREXM'="AO") ^TMP("DVBAEXAMS",$J,DVBAPREXM,RSDA,TPDA,XMDA)=""
 I '$D(GETOUT),(IOST?1"C-".E),((DVBAPRTY']"")!(DVBAPRTY["AO")) D CONTMES^DVBCUTL4
 D:((DVBAPRTY]"")&(DVBAPRTY'["AO"))  ;print BDD/DES reports
 .K DVBAPG1 S DVBAEXMP=DVBAPRTY,RSDA=""
 .F DVBAP=$P(DVBAEXMP,";",2),$P(DVBAEXMP,";",3)  D
 ..S DVBAPRTY=DVBAP
 ..D DETHD^DVBCIUTL S DVBAPG1=""
 ..F  S RSDA=$O(^TMP("DVBAEXAMS",$J,DVBAP,RSDA)) Q:(('+RSDA)!($D(GETOUT)))  D
 ...K DVBARSPT S TPDA=""
 ...F  S TPDA=$O(^TMP("DVBAEXAMS",$J,DVBAP,RSDA,TPDA)) Q:(('+TPDA)!($D(GETOUT)))  D
 ....K DVBAXMPT S XMDA=""
 ....F  S XMDA=$O(^TMP("DVBAEXAMS",$J,DVBAP,RSDA,TPDA,XMDA)) Q:(('+XMDA)!($D(GETOUT)))  D EXMOUT^DVBCIUTL
 ..I '$D(GETOUT),(IOST?1"C-".E) D CONTMES^DVBCUTL4
 ..K GETOUT W !
 D ^%ZISC
 D KVARS ;**KILL the variables used by DETAIL
 Q
 ;
KVARS ;** Final Kill for Detail report
 S:$D(ZTQUEUED) ZTREQ="@"
 K ^TMP($J),DVBAARY,DVBANAME,DVBASSN,DVBACNUM,RSDA,TPDA,XMDA,DVBADTLP
 K DVBAENDL,DVBARSPT,DVBAXMPT,REQDA,DFN,DVBAORXM,DVBAXMTP,DVBACMND
 K DVBAORPV,DVBAORP1,DVBADTWK,DVBADTE,DVBAORDT,DVBANAM1,GETOUT
 K DVBAARY,DVBAPG1,DVBARQDT,DVBAXDT,DVBAXRS,^TMP("DVBAEXAMS",$J)
 Q
 ;
DETSEL ;** Select the details to report
 D RSEL^DVBCIUTL
 I '$D(DVBAARY("REASON")) S DVBAQTSL=""
 I $D(DVBAQTSL) DO
 .S DIR("A",1)="You have not selected Insufficient reasons to report."
 .S DIR("A",2)="This is required to print the Detailed report."
 .S DIR("A",3)=" "
 .S DIR(0)="FAO^1:1",DIR("A")="Hit Return to continue." D ^DIR K DIR,X,Y
 I '$D(DVBAQTSL) DO
 .D XMSEL^DVBCIUTL
 .I '$D(^TMP($J,"XMTYPE")) S DVBAQTSL=""
 .I $D(DVBAQTSL) DO
 ..S DIR("A",1)="You have not selected Exams to report."
 ..S DIR("A",2)="This is required to print the Detailed report."
 ..S DIR("A",3)=" "
 ..S DIR(0)="FAO^1:1",DIR("A")="Hit Return to continue." D ^DIR K DIR,X,Y
 ..K DVBAARY("REASON")
 Q
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
