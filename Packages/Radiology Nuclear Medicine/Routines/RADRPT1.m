RADRPT1 ;HISC/GJC Radiation dosage report utility one ;1/18/13  09:00
 ;;5.0;Radiology/Nuclear Medicine;**113**;Mar 16, 1998;Build 6
 ;
EN ;entry point
 ;--- IAs ---
 ;Call/File            Number     Type
 ;------------------------------------------------
 ;^DIC                 10006      S
 ;$$GET1^DIQ           2056       S
 ;^DIR                 10026      S
 ;$$FMTE^XLFDT         10103      S
 ;$$CJ^XLFSTR          10104      S
 ;EN^XUTMDEVQ          1519       S
 ;^DPT(                10035      S
 ;CPT/HCPCS file 81    5408       S
 ;^VA(200,             10060      S
 ;where 'S'=Supported; 'C'=Controlled Subscription; 'P'=Private
 ;
 ;report specifications: sort levels
 ;1) select a single patient
 ;2) a replica of 'Profile of Rad/Nuc Med Exams'
 ;
PAT ;select a patient
 K %,DIC,DIRUT,DTOUT,DUOUT,X,Y
 S DIC="^RADPT(",DIC("A")="Select Patient: "
 S DIC("S")="I $D(^RADPT(""RDE"",+Y))"
 S DIC(0)="QEAMZ" D ^DIC
 K %,DIC,DIRUT,DTOUT,DUOUT
 I +Y=-1 K X,Y Q
 S RADFN=+Y ;we have our patient
 ;get exam data for this specific patient
 K X,Y D RT^RAPROQ
 Q:'$D(^DPT(RADFN,0))#2  S RADPT(0)=$G(^(0))
 S RA("NAME")=$P(RADPT(0),U),RA("SSN")=$$SSN^RAUTL
 ;does Radiology use the SSAN? returns '1' for yes; '0' for no
 ;S RA("SSAN")=$$USESSAN^RAHLRU1()
 S RA("HDR")="**** Radiation dose for "_RA("NAME")_" ****"
 ;
 ;get the Rad Dosage Data from file 70.3
 ;RAY = record #'s file 70.3
 ;RAP = numeric representation of each selectable record
 ;RAQ = loop exit logic
 ;RAR = user's selection
 S RAC=9999999.9999,(RAP,RAQ,RAY)=0
 S RAR="" K ^TMP($J,"RAEX")
 ;are there more than one exam for this patient?
 S RA("ALPHA")=$O(^RAD("B",RADFN,0)),RA("OMEGA")=$O(^RAD("B",RADFN,$C(32)),-1)
 S RA("STRING")="Exam"
 S:RA("ALPHA")'=RA("OMEGA") RA("STRING")="Exam(s)"
 ;
 D HDR ;
 F  S RAY=$O(^RAD("B",RADFN,RAY)) Q:'RAY  D  Q:RAQ
 .S RAX=$G(^RAD(RAY,0)),RADTE=$P(RAX,U,2),RACN=$P(RAX,U,3),RADTI=(RAC-RADTE)
 .S RACNI=$O(^RADPT(RADFN,"DT",RADTI,"P","B",RACN,0)) Q:'RACNI  ;can determine case
 .S RAP=RAP+1 ; RAP = # of exams counter
 .S RAY2=$G(^RADPT(RADFN,"DT",RADTI,0))
 .S RAY3=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0))
 .S RA("RAMIS")=$G(^RAMIS(71,+$P(RAY3,U,2),0))
 .S RA("PRC")=$P(RA("RAMIS"),U)
 .S RA("CPT")=$$GET1^DIQ(81,$P(RA("RAMIS"),U,9),.01)
 .S X=$P(RAY2,U) ;3121120.1321
 .S RA("EXDT")=$$FMTE^XLFDT(X,2) ;MM/DD/YY@HH:MM:SS format
 .S X=$$SSANVAL^RAHLRU1(RADFN,RADTI,RACNI)
 .S:X'="" RA("ACC")=X
 .S:X="" RA("ACC")=$E($P(RAY2,U),4,5)_$E($P(RAY2,U),6,7)_$E($P(RAY2,U),2,3)_"-"_$P(RAY3,U)
 .S RA("PIS")=$$GET1^DIQ(200,$P(RAY3,U,15),.01) ;ptr value or null
 .S RARPT=$P(RAY3,U,17) ;referencing a pointer field value could be null
 .; ^TMP($J,"RAEX",RAP)=IEN 70.3 ^ RADFN ^ Exam Date ^ inv. Exam Date (IEN 70.02)
 .;                     ^ Case Number ^ IEN EXAMINATIONS (70.03) ^ Report (if none null)
 .S ^TMP($J,"RAEX",RAP)=RAY_U_RADFN_U_RADTE_U_RADTI_U_RACN_U_RACNI_U_RARPT
 .W !,RAP,?3,RA("ACC"),?21,RA("EXDT"),?37,$E(RA("PRC"),1,16),?55,RA("CPT"),?62,$E(RA("PIS"),1,17)
 .I $Y>(IOSL-6) D
 ..S:RAY'=RA("OMEGA") RAHLP="Enter a '^' to exit or <return> to continue."
 ..S:RAY=RA("OMEGA") RAHLP="Enter a '^' or <return> to exit."
 ..D ASK(RAHLP)
 ..;straight exit '^' or timeout
 ..I RAR="^" S RAQ=-1 Q
 ..;no more data to display (user enters return)
 ..I RAY=RA("OMEGA"),(RAR="") S RAQ=-1 Q
 ..;more data to dispay, user chooses to continue
 ..I RAR="" D HDR Q
 ..;the user selected a record/list of records...
 ..I +RAR S RAQ=1
 ..Q
 .Q
 ;now check if the user went through all the record w/o selecting
 ; - the user exited the loop abruptly
 I RAQ=-1 D XIT QUIT
 ; - the user fell through the loop without selecting
 I RAR="" S RAHLP="Enter a '^' or <return> to exit." W ! D ASK(RAHLP)
 ;the user exited w/o selecting a list
 I RAR="^"!(RAR="") D XIT QUIT
 ; - the user salected
 I +RAR D
 .D DATA ;save off only the user's selections
 .S ZTSAVE("RADFN")=""
 .S ZTSAVE("^TMP($J,""RAEX"",")="",ZTRTN="EN^RADRPT1A"
 .S ZTDESC="RA-Radiation dosage report (Patient Profile format)"
 .D EN^XUTMDEVQ(ZTRTN,ZTDESC,.ZTSAVE,,1)
 .I $G(ZTSK) W !!,"This report has been tasked: "_ZTSK
 .Q
 D XIT
 Q
 ;
HDR ;header - study selection process
 W @IOF,!!,$$CJ^XLFSTR(RA("HDR"),80)
 W !?62,"Primary"
 W !?3,"Assession No.",?21,"Exam Date/Time",?37,"Procedure Name",?55,"CPT",?62,"Interpreting"
 W !?3,"-------------",?21,"--------------",?37,"--------------",?55,"-----",?62,"------------"
 Q
 ;
XIT ;kill variables set ZTREQ then exit
 K %,%H,%I,N,RA,RAC,RACN,RACNI,RADFN,RADTE,RADPT,RADTI,RAHLP,RAP,RAQ,RAR,RARPT,RASSN
 K RAX,RAY,RAY2,RAY3,RTFL,X,X1,Y,Z,ZTDESC,ZTRTN,ZTSAVE,ZTSK
 K ^TMP($J,"RAEX")
 ;S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
ASK(RAHLP) ;ask the user for a response/end of screen
 K DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y S DIR(0)="LO^1:"_RAP_":0"
 S DIR("A")="Enter a number or range of numbers between 1 and "_RAP
 S DIR("?",1)="This response must be a list or range, e.g., 1,3,5 or 2-4,8."
 S DIR("?")=RAHLP D ^DIR
 S:$D(DTOUT)#2!($D(DUOUT)#2) Y="^"
 ;Y can be: '^', "" (upon <CR>) or a value.
 S RAR=Y K DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 QUIT
 ;
DATA ;Make sure only the records selected by the patient
 ;are preserved.
 ;input: RAR - the user's selections
 S XRAR=","_RAR,I=0
 F  S I=$O(^TMP($J,"RAEX",I)) Q:'I  D
 .I XRAR'[(","_I_",") K ^TMP($J,"RAEX",I)
 K I,XRAR
 Q
 ;
CT ;----------------------- get Rad Dose (CT SCAN) -------------------
 ;called from RADRPT1A
 S RAHDR=$$CJ^XLFSTR("Rad Dose",IOM,"-")
 S RACOL("A1")="Irradiation Event",RACOL("A2")="(5 highest DLP)"
 s $P(RACOL("A3"),"-",($L(RACOL("A1"))+1))=""
 S RACOL("B1")="CTDIvol",RACOL("B2")=" (mGy)"
 S $P(RACOL("B3"),"-",($L(RACOL("B1"))+1))=""
 S RACOL("C1")="DLP",RACOL("C2")="(mGy-cm)"
 S $P(RACOL("C3"),"-",($L(RACOL("C2"))+1))=""
 S RACOL("E2")="Target Region",$P(RACOL("E3"),"-",($L(RACOL("E2"))+1))=""
 I $Y>(IOSL-6) D  Q:RAQUIT
 .D HDR1^RADRPT1
 .Q
 E  D
 .W !,RAHDR D CTCOL
 .Q
 S RAB=$C(32),RAE=0,RAGJC="0^0"
 F  S RAB=$O(^RAD(RARAD,"II","DLP",RAB),-1) Q:RAB'>0  D  Q:RAQUIT
 .S RACC=0 F  S RACC=$O(^RAD(RARAD,"II","DLP",RAB,RACC)) Q:RACC'>0  D  Q:RAQUIT
 ..S RAII(0)=$G(^RAD(RARAD,"II",RACC,0)) Q:RAII(0)=""
 ..I $Y>(IOSL-4) D HDR1^RADRPT1 Q:RAQUIT
 ..S RAE=RAE+1 ; # IIUID records
 ..S RAII(2)=$$GET1^DIQ(2005.6361,+$P(RAII(0),U,2)_",",2) ;ATR - CODE MEANING fld
 ..S $P(RAGJC,U,1)=$P(RAGJC,U,1)+$P(RAII(0),U,4) ; CTDIvol totals
 ..S $P(RAGJC,U,2)=$P(RAGJC,U,2)+$P(RAII(0),U,5) ; DLP totals
 ..;Columns: Sequence, CTDIvol, DLP, Irradiation Type & Target Region only the top five
 ..W:RAE'>5 !?2,RAE,?24,$J($P(RAII(0),U,4),8,2),?39,$J($P(RAII(0),U,5),8,2),?54,$E(RAII(2),1,25)
 ..Q
 .Q
 I 'RAQUIT D
 .W !,"Total Exam CTDIvol: "_+$P(RAGJC,U,1)_" mGy  from all irradiation events."
 .W !,"Total Exam DLP: "_+$P(RAGJC,U,2)_" mGy-cm  from all irradiation events."
 .W !!,"Total # irradiation events: ",RAE
 .Q
 K RAB,RACC,RACOL,RAE,RAGJC,RAHD,RAII,RAIRT,RATMP,RATR
 Q
 ;
CTCOL ;print CT column headers
 W !,RACOL("A1"),?24,RACOL("B1"),?41,RACOL("C1")
 W !,RACOL("A2"),?24,RACOL("B2"),?39,RACOL("C2"),?54,RACOL("E2")
 W !,RACOL("A3"),?24,RACOL("B3"),?39,RACOL("C3"),?54,RACOL("E3")
 Q
 ;
HDR1 ;header/end of screen logic
 ;RAHDR: is dynamic; its value is based on the section
 ;HDR^RADRPT1 is called from.
 I $E(IOST,1,2)="C-" D  Q:RAQUIT
 .W !,"Press RETURN to continue or '^' to exit: " R X:DTIME
 .S RAQUIT='$T!(X["^") K X
 .Q
 S RAPG=RAPG+1 W @IOF,!,RATITLE
 W !,"Date: ",RANODT,?69,"Page: ",RAPG
 W !,RABORDR
 W !?RATAB(1),"Name: ",$E(RA("NAME"),1,27)_"    "_RA("BID")
 W ?RATAB(4),"Exam Date: ",$E(RAY2A(70.02,RAIEN,".01","E"),1,21)
 W !?RATAB(1),"Procedure: ",$E(RAPRC,1,30)
 W ?RATAB(4),"Case Number: ",RA("RACN")
 W !,RAHDR D CTCOL
 ;specifc to CT SCANS - print column data
 Q
 ;
