RARTVER ;HISC/FPT,CAH AISC/MJK,RMO-On-line Verify Reports ;09/24/08  10:27
 ;;5.0;Radiology/Nuclear Medicine;**8,23,26,82,56,95**;Mar 16, 1998;Build 7
 ;Supported IA #10035 ^DPT(
 ;Supported IA #10060 ^VA(200
 D SET^RAPSET1 I $D(XQUIT) K XQUIT Q
 N RAVFIED,RAXIT S RAXIT=0
 K RAVER S:$D(^VA(200,DUZ,0)) RAVER=$P(^(0),"^") I '$D(RAVER) W !!,$C(7),"Your name must be defined in the NEW PERSON File to continue." G Q
 I '$D(^VA(200,"ARC","R",DUZ)),'$D(^VA(200,"ARC","S",DUZ)) W !!,$C(7),"This option is only available for Rad/Nuc Med Interpreting Physicians." G Q
 I '$$CHKUSR^RAO7UTL(DUZ) D ERR^RARTVER2(DUZ) D Q QUIT
 I $D(^VA(200,"ARC","S",DUZ)) S RASTAFF=1 G 1
 I $P(RAMDV,"^",18)'=1 W !!,$C(7),"Interpreting Residents are not allowed to verify reports.",!! G Q
1 S RAONLINE="" W ! D ES^RASIGU G Q:'%
 I $D(RASTAFF),$P($G(^VA(200,DUZ,"RA")),U,2)'="y" S RARAD=DUZ,RAD="ASTF",RARESFLG="" G SRTRPT ;selected USER does NOT have ALLOW VERIFYING OF OTHERS
 I '$D(^VA(200,"ARC","S",DUZ)),$S('$P(RAMDV,"^",18):1,'$D(^VA(200,"ARC","R",DUZ)):1,'$D(^VA(200,DUZ,"RA")):1,$P(^VA(200,DUZ,"RA"),"^",2)'="y":1,1:0) S RARAD=DUZ,RAD="ARES",RARESFLG="" G SRTRPT
ASKRAD W ! S DIC("B")=RAVER,DIC("S")="I $D(^VA(200,""ARC"",""R"",Y))!($D(^VA(200,""ARC"",""S"",Y)))",DIC("A")="Select Interpreting Physician: ",DIC="^VA(200,",DIC(0)="AEMQ" D ^DIC K DIC G Q:Y<0 S RARAD=+Y
 S RAD=$S($D(^VA(200,"ARC","R",RARAD)):"ARES",1:"ASTF")
 ;
SRTRPT K ^TMP($J,"RA"),RA,RARPTX
 S RARADHLD=RARAD,RATOT=0,RARPT=0
 ;tmp($j,"ra","dt",-,-) =
 ;^rpt status at start of selection^/long CN^Pat.ien^Proc.ien
 F  S RARPT=$O(^RARPT(RAD,RARAD,RARPT)) Q:'RARPT  I $D(^RARPT(RARPT,0)) S RARTDT=$S($P(^(0),"^",6)="":9999999.9999,1:$P(^(0),"^",6)) D
 .Q:$$STUB^RAEDCN1(RARPT)  ;skip stub report 081500
 .Q:"^V^EF^X^"[("^"_$P($G(^RARPT(+RARPT,0)),"^",5)_"^")  ;skip V,EF,X
 .S Y=RARPT D RASET^RAUTL2 ;returns Y=radpt(radfn,"dt",radti,"p",-,0)
 .Q:'Y  ;record must be corrupt no zero node for ADC x-ref!!
 .S ^TMP($J,"RA","DT",RARTDT,RARPT)="^"_$P($G(^RARPT(+RARPT,0)),"^",5)_"^/"_$P(^(0),"^",1,2)_"^"_+$P(Y,U,2)
 .S RATOT=RATOT+1
 .Q
 I 'RATOT S RANM=$S($D(^VA(200,RARAD,0)):$P(^(0),"^"),1:"UNKNOWN"),RANM=$S(RANM=RAVER:"You have",1:"Interpreting Physician "_RANM_" has") W !!,RANM," no Unverified Reports." G Q:$D(RARESFLG),ASKRAD
 N RATOTORI S RATOTORI=RATOT ; save original value of RATOT
 ;
SELRPT I RATOT=1 D ONERPT^RARTVER1 G:'$D(^TMP($J,"RA")) Q S RACHOICE=5,RACHOICE("1RPT")="" G RPTLP
 D TALLY^RARTVER1,SELRPT^RARTVER1 G Q:Y=0 S RACHOICE=+Y
 I Y=1 D PV^RARTVER1 G:RATOT'>0 SRTRPT G RPTLP
 I Y=2 S RASTATUS="R" D DPDRNV^RARTVER1 G:RATOT'>0 SRTRPT G RPTLP
 I Y=3 S RASTATUS="D" D DPDRNV^RARTVER1 G:RATOT'>0 SRTRPT G RPTLP
 I Y=4 S RASTATUS="PD" D DPDRNV^RARTVER1 G:RATOT'>0 SRTRPT G RPTLP
 I Y=5 G RPTLP
 I Y=7 D STAT^RARTVER1 G:RATOT'>0 SRTRPT G RPTLP
 ; if none of the above, then defaults to Y=6 SELECTED 
 S RASTATFG="" D ^RARTVER1 K RASTATFG G Q:$D(RAOUT)!('$D(RARPTX))
 ;
RPTLP S DIR(0)="S^P:PAGE AT A TIME;E:ENTIRE REPORT",DIR("B")="P",DIR("A")="How would you like to view the reports?"
 S DIR("?",1)="If you would like to pause after each page of the report enter 'P'.",DIR("?")="Otherwise enter 'E' to view an entire report at one time."
 D ^DIR K DIR G Q:$D(DIRUT) I Y="E" S RARTVERF=1
 S RACHOICE("NAME")=$S(RACHOICE=6:"SELECTED",RACHOICE=5:"ALL",RACHOICE=4:"PROBLEM DRAFT",RACHOICE=3:"DRAFT",RACHOICE=2:"RELEASED/NOT VERIFIED",1:"PREVERIFIED")
RPTLP1 I $D(^TMP($J,"RA","DT")) S RARPT=0,RARTDT=0 F  S RARTDT=$O(^TMP($J,"RA","DT",RARTDT)) Q:'RARTDT  S RARDX="" D GETRPT Q:RARDX="^"  I $D(RARLTV),$G(RARLTV)=0 D ADDLRPT^RARTVER2 Q:RATOT=0  S RARLTV=RATOT G RPTLP1
 I $D(^TMP($J,"RA","XREF")) S (RPTX,RARPT)=0 D GETRPT
 ; RARESFLG  is used to flag that  VERIFYING OF OTHERS  is allowed
 ; Before looping back, RARESFLG is set, so that if there are no reports,
 ; the logic will goto Q instead of to ASKRAD
 I RATOTORI>1 S RARAD=RARADHLD,RARESFLG="" K RARLTV,RARTVERF G SRTRPT ; go another round
 ; also dis-allow re-asking another USER when all reports
 ; become verified by current USER
 ;
Q D CU^RARTVER2
 Q
 ;
GETRPT I $G(RARPT) L -^RARPT(RARPT)
 S:$D(^TMP($J,"RA","XREF")) RPTX=RPTX+1 S RARPT=$S($D(^TMP($J,"RA","DT")):$O(^TMP($J,"RA","DT",RARTDT,RARPT)),$D(^TMP($J,"RA","XREF")):+$G(RARPTX(RPTX)),1:0) Q:'RARPT
 I $D(^TMP($J,"RA","DT")) G:$P(^TMP($J,"RA","DT",RARTDT,RARPT),"^")="V" GETRPT S $P(^TMP($J,"RA","DT",RARTDT,RARPT),"^")="V" ;here, V = viewed already
 I '$D(^RARPT(RARPT)) D MSG1 G GETRPT ;rpt disappeared
 L +^RARPT(RARPT):2 I '$T G LOCK^RARTVER2
 S RAXIT=0 D DISRPT^RARTVER2 I $G(X)="^" S RARDX="^" Q  ;display whole report
 I +$G(RAVFIED) S RAVFIED=0 G GETRPT
 N RASTBEF S RASTBEF=$S($D(^TMP($J,"RA","DT",+$G(RARTDT),+$G(RARPT))):$P(^(RARPT),"^",2),$D(^TMP($J,"RA","XREF")):$P($G(RARPTX(RPTX)),U,2),1:"")
ASK Q:RAXIT  W ! S I="",$P(I,"=",80)="" W I K I
 I "12345"[$E(RACHOICE) D:'$D(RARLTVFL) RLTV^RARTVER1 D:$D(RARLTVFL) RLTV1^RARTVER1
 S RARD("A")="",RARD(1)="Print^print this report for editing",RARD(2)="Edit^edit this report",RARD(3)="Top^display the report from the beginning",RARD(4)="continue^continue normal processing"
 S RARD(5)="Status & Print^edit Status, then print report",RARD(0)="S",RARD("B")=4
 S:$G(RARLTV) RARLTV=RARLTV-1
 I $G(RARLTV)>0 S RARD("A")="("_$G(RARLTV)_" left to review) "
 I $G(RARLTV)=0 I '$D(RACHOICE("1RPT")) S RARD("A")="(No more "_RACHOICE("NAME")_") " S:RACHOICE=5 RARD("A")="(ALL gone) "
 S RARD("A")=RARD("A")_"Type '?' for action list, 'Enter' to " ;12/30/96
 I RASTBEF'=$P(^RARPT(RARPT,0),U,5) D MSG2
 D SET^RARD K RARD S RARDX=$E(X) I RARDX="^" L -^RARPT(RARPT) Q
 ; if user chose "T"op, the report will be displayed again from the top
 I "PT"[RARDX D PRTRPT^RARTVER2:RARDX="P",DISRPT^RARTVER2:RARDX="T" G ASK
 I RARDX="E" D EDTCHK^RARTVER2 I RARDX="E" W !!,"EDITING REPORT",!,"--------------",! D EDTRPT^RARTE1 D  K RAAB G ASK
 .; RAHLTCPB flag is inactive
 .N RAHLTCPB S RAHLTCPB=1 D:RACT="V" UPSTAT^RAUTL0 D:RACT'="V" UP1^RAUTL1
 S RAPGM="GETRPT^RARTVER" G 31^RART ;goto Verify Report Only template
 ;
MSG1 N I,J1,J2,J3 S I=$S($D(^TMP($J,"RA","DT",+$G(RARTDT),+$G(RARPT))):^(RARPT),$D(^TMP($J,"RA","XREF")):$G(RARPTX(RPTX)),1:"")
 S J1=$P(I,"/",2),J2=$P(J1,"^",2),J3=$P(J1,"^",3),J1=$P(J1,"^")
 W !!!?15,$C(7),"Since the time you selected this group of reports,",!?15,"another user has deleted this report for",!?15,$P($G(^DPT(J2,0)),"^"),"   case ",J1,!?15,"Procedure ",$P($G(^RAMIS(71,+J3,0)),U),".",!! G CONT Q
MSG2 N I,J S I=";"_$P(^RARPT(RARPT,0),"^",5)_":"
 S J=";"_$P(^DD(74,5,0),U,3)
 W !!!?15,$C(7),"Since the time you selected this group of reports,",!?15,"another user has changed this report's status to '",$P($P(J,I,2),";"),"'.",!! Q
CONT W !! S DIR(0)="FO",DIR("A")="Press return key to continue " D ^DIR
 Q
