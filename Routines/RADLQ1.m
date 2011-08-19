RADLQ1 ;HISC/GJC AISC/MJK,RMO-Delq Status/Incomplete Rpt's ;10/30/97  15:02
 ;;5.0;Radiology/Nuclear Medicine;**15,97**;Mar 16, 1998;Build 6
 ;'RALL' will be defined in the entry action of RA INCOMPLETE
 I $D(DUZ),($O(RACCESS(DUZ,""))']"") D CHECK^RADLQ3(DUZ)
 S X=$$DIVLOC^RAUTL7() K ^TMP($J,"RADLQ")
 I X K:$D(RAPSTX) RAPSTX K RAQUIT,X,I,POP Q  ; Selection process aborted.
 S INVMAXDT=9999999.9999,RAXIT=0
 S RAHD(0)=$S($D(RALL):"Incomplete Exam",1:"Delinquent Status")
 S RAHD(0)=RAHD(0)_" Report" W @IOF,!?(IOM-$L(RAHD(0))\2),RAHD(0)
 D DISPXAM^RADLQ3 ; Display xam statuses
 I RAXIT D EXIT^RADLQ3 Q
DEV D DATE^RAUTL I RAPOP D EXIT^RADLQ3 Q  ; Quit if device not selected
 S RABEG=INVMAXDT-ENDDATE,RAEND=INVMAXDT-BEGDATE K DIR,X,Y
 S DIR(0)="SO^I:INPATIENT;O:OUTPATIENT;B:BOTH"
 S DIR("?",1)="This report can be broken out by"
 S DIR("?")="Outpatient, Inpatient, or Both."
 S DIR("A")="Report to include" D ^DIR K DIR
 I $D(DIRUT) D EXIT^RADLQ3 Q
 S RASORT1=Y
 W !!?5,"Now that you have selected ",Y(0)
 W " do you want to sort by",!?5,"Patient or Date ?" K X,Y
 S DIR(0)="SO^P:PATIENT;D:DATE"
 S DIR("?",1)="This allows you the flexibility to further"
 S DIR("?")="sort the report by Patient or Date." D ^DIR K DIR
 I $D(DIRUT) D EXIT^RADLQ3 Q
 S RASORT2=Y D ZEROUT^RADLQ3("RADLQ")
 I '$D(^TMP($J,"RADLQ")) D EXIT^RADLQ3 Q
 K RACCESS(DUZ,"DIV-IMG") W !
 S ZTRTN="START^RADLQ1" S:$D(RALL) ZTSAVE("RALL")=""
 F RASV="RAHD(","RACRT(","RABEG","RAEND","RASORT1","RASORT2","INVMAXDT","RAXIT","RADIVNM" D
 . S ZTSAVE(RASV)=""
 . Q
 S ZTSAVE("^TMP($J,""RA D-TYPE"",")=""
 S ZTSAVE("^TMP($J,""RADLQ"",")=""
 S ZTSAVE("^TMP($J,""RA I-TYPE"",")=""
 D ZIS^RAUTL I RAPOP D EXIT^RADLQ3 Q
START ; start processing here
 U IO S $P(RALN1,"-",(IOM+1))=""
 S:$D(ZTQUEUED) ZTREQ="@"
 S $P(RALN2,"=",(IOM+1))="",(RAPG,RASTI)=0
 F  S RASTI=$O(^RADPT("AS",RASTI)) Q:'RASTI  D  Q:RAXIT
 . D RADFN:$S($D(RALL):1,$D(RACRT(RASTI)):1,1:0)
 . Q
 K RADIV("I") D:'RAXIT PRINT^RADLQ2
 I 'RAXIT D
 . S RADIVNM=$$DIVTOT^RACMP("RADLQ") Q:'RADIVNM
 . S RAXIT=$$EOS^RAUTL5() Q:RAXIT  S RAFLAG="" D HDR^RADLQ2
 . D:'RAXIT LIST^RADLQ3
 . Q
 S RAXIT=$$EOS^RAUTL5() ;cause screen pause for user
 D EXIT^RADLQ3
 Q
RADFN ; $ order through rad patients ien's
 S RADFN=0
 F  S RADFN=$O(^RADPT("AS",RASTI,RADFN)) Q:'RADFN  D  Q:RAXIT
 . F RADTI=RABEG-1:0 S RADTI=$O(^RADPT("AS",RASTI,RADFN,RADTI)) Q:'RADTI!(RADTI>RAEND)  D  Q:RAXIT
 .. S RADTE=INVMAXDT-RADTI D RACNI
 .. Q
 . Q
 Q
RACNI ; $ order through case #
 S RACNI=0
 F  S RACNI=$O(^RADPT("AS",RASTI,RADFN,RADTI,RACNI)) Q:'RACNI  D SORT  Q:RAXIT
 Q
SORT ; sort logic
 S RAREGEX(0)=$G(^RADPT(RADFN,"DT",RADTI,0)) Q:RAREGEX(0)']""
 S RADIV("I")=+$P(RAREGEX(0),"^",3) Q:RADIV("I")=0
 S RADIV("I")=$S($D(^RA(79,RADIV("I"),0)):$P(^(0),"^"),1:0)
 S RADIV=$S($D(^DIC(4,RADIV("I"),0)):$P(^(0),"^"),1:0)
 Q:'$D(^TMP($J,"RA D-TYPE",RADIV))
 S RADIV=RADIV("I"),RAPAT(0)=$G(^DPT(RADFN,0))
 S RANME=$S($P(RAPAT(0),"^")]"":$P(RAPAT(0),"^"),1:"Unknown")
 S RASSN=$$SSN^RAUTL
 S RAEXAM(0)=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)) Q:RAEXAM(0)']""
 S RAIPHY="Unknown"
 S:$P(RAEXAM(0),"^",15)]"" RAIPHY=$P($G(^VA(200,+$P(RAEXAM(0),"^",15),0)),"^")
 S:$P(RAEXAM(0),"^",12)]""&(RAIPHY="Unknown") RAIPHY=$P($G(^VA(200,+$P(RAEXAM(0),"^",12),0)),"^")
 K RATECH S RATD4=+$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"TC",0))
 I RATD4 D  ; Obtain the first 'tech' encountered
 . S RATECH=$E($$GET1^DIQ(200,+$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"TC",RATD4,0))_",",.01),1,15)
 . Q
 K RATD4 S:'$L($G(RATECH)) RATECH="Unknown"
 S RACN=+$P(RAEXAM(0),"^"),RAPRC=+$P(RAEXAM(0),"^",2)
 S RAPRC=$S($D(^RAMIS(71,RAPRC,0)):$P(^(0),"^"),1:"Unknown")
 S RAST=+$P(RAEXAM(0),"^",3),RADT=$P(RADTE,".")
 S RAITYPE("I")=$S($D(^RA(72,RAST,0)):+$P(^(0),"^",7),1:0)
 S RAITYPE=$S($D(^RA(79.2,RAITYPE("I"),0)):$P(^(0),"^"),1:"Unknown")
 Q:'$D(^TMP($J,"RA I-TYPE",RAITYPE))
 S:'$D(^RA(72,RAST,0)) RAST="Unknown"
 S:$D(^RA(72,RAST,0)) RAST=$P(^(0),"^")
 S RADT=$E(RADT,4,5)_"/"_$E(RADT,6,7)_"/"_$E(RADT,2,3)
 ; 6th piece: Ward Location          <-> 8th piece: Principal Clinic
 ; 9th piece: Contact/Sharing Source <-> 17th piece: Report Text
 F RA=6,8,9,17 S RA(RA)=+$P(RAEXAM(0),"^",RA)
 S RA("R")=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"R"))
 S RAWHE=$S($D(^DIC(42,RA(6),0)):$P(^(0),"^"),$D(^SC(RA(8),0)):$P(^(0),"^"),$D(^DIC(34,RA(9),0)):$P(^(0),"^"),RA("R")]"":RA("R"),1:"Unknown")
 S RAVAR=$S($D(^DIC(42,RA(6),0)):"I",1:"O")
 Q:RASORT1'="B"&(RASORT1'=RAVAR)
 S RARP=$S(+$O(^RARPT(RA(17),"R",0)):"Yes",+$O(^RARPT(RA(17),"I",0)):"Yes",1:"No")
 S RAVRFIED=$P($G(^RARPT(RA(17),0)),U,5) S RAVRFIED=$S(RAVRFIED="D":"Draft",RAVRFIED="R":"Released",RAVRFIED="PD":"Prb Drft",RAVRFIED="V":"Verified",RAVRFIED="EF":"Elec. F.",1:"No Rpt")
 I $D(ZTQUEUED) D STOPCHK^RAUTL9 S:$G(ZTSTOP)=1 RAXIT=1 Q:RAXIT
 S ^TMP($J,"RADLQ",RADIV,RAITYPE,RAVAR,$S(RASORT2="P":RANME,1:$P(RADTE,".")),$S(RASORT2="P":$P(RADTE,"."),1:RANME),RACN)=RACN_"^"_RAPRC_"^"_RAST_"^"_RADT_"^"_RAWHE_"^"_RARP_"^"_RASSN_"^"_RAVRFIED_"^"_RAIPHY_"^"_RATECH
 S ^TMP($J,"RADLQ")=+$G(^TMP($J,"RADLQ"))+1
 S ^TMP($J,"RADLQ",RADIV)=+$G(^TMP($J,"RADLQ",RADIV))+1
 S ^TMP($J,"RADLQ",RADIV,RAITYPE)=+$G(^TMP($J,"RADLQ",RADIV,RAITYPE))+1
 S ^TMP($J,"RADLQ",RADIV,RAITYPE,RAVAR)=+$G(^TMP($J,"RADLQ",RADIV,RAITYPE,RAVAR))+1
 Q
