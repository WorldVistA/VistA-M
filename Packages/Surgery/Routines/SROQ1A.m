SROQ1A ;BIR/ADM - QUARTERLY REPORT (CONTINUED) ;05/12/10
 ;;3.0; Surgery ;**38,62,50,129,153,160,174**;24 Jun 93;Build 8
 ;** NOTICE: This routine is part of an implementation of a nationally
 ;**         controlled procedure. Local modifications to this routine
 ;**         are prohibited.
 ;
 ; Reference to ^DIC(45.3 supported by DBIA #218
 ;
CC ; occurrence categories
 I $E(IOST,1,2)="C-" D HDR^SROQ0 Q:SRSOUT
 W !!!,?21,"PERIOPERATIVE OCCURRENCE CATEGORIES",!,?21,"-----------------------------------",!
WC W !,?2,"Wound Occurrences",?31,"Total",?42,"Urinary Occurrences",?71,"Total"
 W !,?2,"A. Superficial Incisional SSI",?31,$J(SRC(1),5),?42,"A. Renal Insufficiency",?71,$J(SRC(8),5)
 W !,?2,"B. Deep Incisional SSI",?31,$J(SRC(2),5),?42,"B. Acute Renal Failure",?71,$J(SRC(9),5)
 W !,?2,"C. Wound Disruption",?31,$J(SRC(22),5),?42,"C. Urinary Tract Infection",?71,$J(SRC(10),5)
 W !,?2,"D. Organ/Space SSI",?31,$J(SRC(35),5),?42,"D. Other",?71,$J(SRC(31),5)
 W !,?2,"E. Other",?31,$J(SRC(36),5)
 W !,?42,"Respiratory Occurrences",?71,"Total"
RC W !,?2,"CNS Occurrences",?31,"Total",?42,"A. Pneumonia",?71,$J(SRC(4),5)
 W !,?2,"A. CVA/Stroke",?31,$J((SRC(12)+SRC(28)),5),?42,"B. Unplanned Intubation",?71,$J((SRC(7)+SRC(11)),5)
 W !,?2,"B. Coma >24 Hours",?31,$J(SRC(13),5),?42,"C. Pulmonary Embolism",?71,$J(SRC(5),5)
 W !,?2,"C. Peripheral Nerve Injury",?31,$J(SRC(14),5),?42,"D. On Ventilator >48 Hours",?71,$J(SRC(6),5)
 W !,?2,"D. Other",?31,$J(SRC(30),5),?42,"E. Tracheostomy",?71,$J(SRC(33),5)
 W !,?42,"F. Other",?71,$J(SRC(29),5)
 I $E(IOST,1,2)="C-" D HDR^SROQ0 Q:SRSOUT  W !,?15,"PERIOPERATIVE OCCURRENCE CATEGORIES (Continued)",!
CARD W !,?2,"Cardiac Occurrences",?31,"Total"
 W !,?2,"A. Cardiac Arrest Req. CPR",?31,$J(SRC(16),5),?42,"Other Occurrences",?71,"Total"
 W !,?2,"B. Myocardial Infarction",?31,$J(SRC(17),5),?42,"A. Bleeding/Transfusions",?71,$J(SRC(15),5)
 W !,?2,"C. Endocarditis",?31,$J(SRC(23),5),?42,"B. Graft/Prosthesis/Flap"
 W !,?2,"D. Low Cardiac Output >6 Hrs.",?31,$J(SRC(24),5),?62,"Failure",?71,$J(SRC(19),5)
 W !,?2,"E. Mediastinitis",?31,$J(SRC(25),5),?42,"C. DVT/Thrombophlebitis",?71,$J(SRC(20),5)
 W !,?2,"F. Repeat Card Surg Proc",?31,$J(SRC(27),5),?42,"D. Systemic Sepsis",?71,$J(SRC(3),5)
 W !,?2,"G. New Mech Circulatory Sup",?31,$J(SRC(34),5),?42,"E. Reoperation for Bleeding",?71,$J(SRC(26),5)
 W !,?2,"H. Postop Atrial Fibrillation",?31,$J(SRC(39),5),?42,"F. C. difficile Colitis",?71,$J(SRC(38),5)
 W !,?2,"I. Other",?31,$J(SRC(32),5),?42,"G. Other",?71,$J(SRC(21),5)
CLEAN ; clean wounds
 S:'SRWC SRWC=1 W !!,?2,"Clean Wound Infection Rate: ",$J((SRIN/SRWC*100),5,1),"%"
 Q
BORD W !,?14 F I=1:1:51 W "*"
 Q
ACTION ; alert action
 D CURRENT^SROQT W @IOF D BORD W !,?14,"*",?64,"*",!,?14,"*    The Surgical Service Quarterly Report for    *",!,?14,"*    quarter #"_SRQTR_" of fiscal year "_(SRYR+1700)_" is now due.   *",!,?14,"*",?64,"*" D BORD
 W !!,"NOTE: The report will be transmitted automatically on "_$S(SRQTR=1:"February 14",SRQTR=2:"May 15",SRQTR=3:"August 14",1:"November 14")_" to the",!,"      national database if not manually transmitted before then."
 K DIR S DIR("?",1)="Choose the number matching your choice of action or press the return",DIR("?")="key to continue or '^' to exit."
 S DIR(0)="SO^1:Print report only;2:Transmit report only;3:Both print and transmit report" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT)!'Y D ^SRSKILL Q
 I Y=2 S DIR("A")="Do you want to transmit the Quarterly Report now ? ",DIR("B")="YES",DIR(0)="YA" D ^DIR K DIR Q:$D(DTOUT)!$D(DUOUT)!'Y  D AUTO^SROQT Q
 I Y S SRT=$S(Y=3:1,1:0) D VAR^SROQT,IO^SROQ
 Q
ALERT ; send alert to SR-QUARTERLY mailgroup
 S XQAID="SRQTR-"_SRFQ,XQAKILL=0 D DELETEA^XQALERT
 S XQA("G.SR-QUARTERLY")="",XQAMSG="The Quarterly Report to VHA HQ for fiscal quarter #"_SRQTR_" is now due.",XQAROU="ACTION^SROQ1A",XQAID="SRQTR-"_SRFQ D SETUP^XQALERT
 Q
MORT ; look for operations in next quarter
 S X1=SRSTART,X2=-30 D C^%DTC S SRSD1=9999999.999999-(X-.0001),X1=SREND,X2=30 D C^%DTC S SRED1=9999999.999999-(X+.9999)
 S DFN=0 F  S DFN=$O(^TMP("SRDTH",$J,DFN)) Q:'DFN  D DEM^VADPT S X1=$P(VADM(6),"^"),SRD=9999999.999999-X1,X2=-30 D C^%DTC S SRD1=(9999999.999999-X) D LATER
 Q
LATER ; gather cases performed within 30 days of death on death patients
 K ^TMP("SRTN",$J) S SRINV=SRED1 F  S SRINV=$O(^SRF("ADT",DFN,SRINV)) Q:'SRINV  I SRINV<SRSD1,SRINV<SRD1,SRINV>SRD S SRTN=0 F  S SRTN=$O(^SRF("ADT",DFN,SRINV,SRTN)) Q:'SRTN  D
 .Q:$P($G(^SRF(SRTN,30)),"^")!'$P($G(^SRF(SRTN,.2)),"^",12)!($P($G(^SRF(SRTN,"NON")),"^")="Y")
 .S ^TMP("SRTN",$J,$P(^SRF(SRTN,0),"^",9),SRTN)=""
 S SRDT=0 F  S SRDT=$O(^TMP("SRTN",$J,SRDT)) Q:'SRDT  S SRTN=0 F  S SRTN=$O(^TMP("SRTN",$J,SRDT,SRTN)) Q:'SRTN  D CASE
 Q
CASE ; examine each case on death patients performed within 30 days of death
 S SR(0)=^SRF(SRTN,0),SRSS=$P(SR(0),"^",4) S SRSS=$S(SRSS:$P(^SRO(137.45,SRSS,0),"^",2),1:"ZZ")
 S SR(0)=^SRF(SRTN,0),X=$P(SR(0),"^",4),Y=$S(X:$P(^SRO(137.45,X,0),"^",2),1:"ZZ") S SRSS=$S(Y:$P(^DIC(45.3,Y,0),"^"),1:"ZZ") I '$D(SRSPEC(SRSS)) S SRSS="ZZ"
 S SRIOSTAT=$P(SR(0),"^",12) I SRIOSTAT'="I"&(SRIOSTAT'="O") S VAIP("D")=SRDT D IN5^VADPT S SRIOSTAT=$S(VAIP(13):"I",1:"O") K VAIP
 S SRREL=$P($G(^SRF(SRTN,.4)),"^",7) I SRREL="R" S ^TMP("SRSP",$J,DFN,(9999999-SRDT))=SRSS,^TMP("SRINOUT",$J,DFN,(9999999-SRDT))=SRIOSTAT
 S ^TMP("SREXP",$J,DFN)=SRTN_"^"_SRSS,^TMP("SRIOD",$J,DFN)=SRTN_"^"_SRIOSTAT
 S SRFLAG=0 D NDEX^SROQ0A
 Q
