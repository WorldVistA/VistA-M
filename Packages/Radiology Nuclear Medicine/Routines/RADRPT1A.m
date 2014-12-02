RADRPT1A ;HISC/GJC Radiation dosage report utility one A ;1/18/13  09:00
 ;;5.0;Radiology/Nuclear Medicine;**113**;Mar 16, 1998;Build 6
 ;
 ;--- IAs ---
 ;Call/File             Number     Type
 ;------------------------------------------------
 ;$$SS^%ZTLOAD          10063      S
 ;$$GET1^DIQ            2056       S
 ;GETS^DIQ              2056       S
 ;$$FMTE^XLFDT          10103      S
 ;$$NOW^XLFDT           10103      S
 ;$$CJ^XLFSTR           10104      S
 ;^DPT(                 10035      S
 ;^VA(200,              10060      S
 ;where 'S'=Supported; 'C'=Controlled Subscription; 'P'=Private
 ;
EN ;entry point
 ; variables saved
 ;----------------
 ; ^TMP($J,"RAEX",n)=IEN 70.3 ^ RADFN ^ Exam Date ^ inv. Exam Date (IEN 70.02)
 ;                     ^ Case Number ^ IEN EXAMINATIONS (70.03) ^ Report (if none null)
 S (RAI,RAP,RAQUIT)=0
 S RANODT=$$FMTE^XLFDT($$NOW^XLFDT(),"1M")
 S RATITLE=$$CJ^XLFSTR("Patient Profile With Radiation Dose Data",IOM)
 ;RAX = field numbers returned 70.03 level
 S RAX=".01:4;6:8;9;9.5;12:16;19;125*" ;*** see DD map of 70.03 ***
 S $P(RABORDR,"=",(IOM+1))="",$P(RALINE,"-",(IOM+1))=""
 S RATAB(1)=2,RATAB(2)=14,RATAB(3)=38,RATAB(4)=49
 S RATAB(5)=16,RATAB(6)=38,RATAB(7)=51
 ;
 K RAZDFN D GETS^DIQ(2,RADFN_",",".01;.09","E","RAZDFN")
 S RA("NAME")=$E(RAZDFN(2,RADFN_",",".01","E"),1,30)
 S X=RAZDFN(2,RADFN_",",".09","E"),RA("PID")=X
 ;RA("PID") is the full SSN just like VA("PID")
 S X1=$E(X,($L(X)-3),$L(X))
 ;RA("BID") is the last four of the SSN just like VA("BID")
 S RA("BID")=X1 K RAZDFN,X,X1
 ;
 K ^TMP($J,"RA DISCLAIMER") D DISCLAIM^RADRPT2A
 ;
 F  S RAI=$O(^TMP($J,"RAEX",RAI)) Q:'RAI  D  Q:RAQUIT
 .S Y=$G(^TMP($J,"RAEX",RAI))
 .F I=1:1:7 S @$P("RARAD^RADFN^RADTE^RADTI^RACN^RACNI^RARPT","^",I)=$P(Y,"^",I)
 .;RARAD = IEN file 70.3; RARPT = IEN of the report for this study
 .S RAY2=$G(^RADPT(RADFN,"DT",RADTI,0)) Q:RAY2=""
 .S RAY3=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)) Q:RAY3=""
 .S RAORD(0)=$G(^RAO(75.1,+$P(RAY3,U,11),0))
 .;fluoro data on 0 node
 .S RARAD(0)=$G(^RAD(RARAD,0)) Q:RARAD(0)=""
 .S RAIEN=RADTI_","_RADFN_"," K RAY2A,RAY3A
 .D GETS^DIQ(70.02,RAIEN,".01:4","E","RAY2A")
 .S RAIENS=RACNI_","_RADTI_","_RADFN_","
 .D GETS^DIQ(70.03,RAIENS,RAX,"E","RAY3A")
 .S RA("RACN")=$$CN() ; case # accession #
 .;
 .;--- header for first page only ---
 .S RAPG=1 W @IOF,!,RATITLE
 .W !,"Date: ",RANODT,?69,"Page: ",RAPG
 .W !,RABORDR
 .;
 .;--- name and SSN (last four) ---
 .W !?RATAB(1),"Name",?RATAB(2),": ",RA("NAME"),"    ",RA("BID")
 .;
 .W !?RATAB(1),"Division",?RATAB(2),": ",$E(RAY2A(70.02,RAIEN,"3","E"),1,21)
 .W ?RATAB(3),"Category",?RATAB(4),": ",$E(RAY3A(70.03,RAIENS,"4","E"),1,27)
 .W !?RATAB(1),"Location",?RATAB(2),": ",$E(RAY2A(70.02,RAIEN,"4","E"),1,21)
 .W ?RATAB(3),"Ward",?RATAB(4),": ",$E(RAY3A(70.03,RAIENS,"6","E"),1,27)
 .W !?RATAB(1),"Exam Date",?RATAB(2),": ",$E(RAY2A(70.02,RAIEN,".01","E"),1,21)
 .W ?RATAB(3),"Service",?RATAB(4),": ",$E(RAY3A(70.03,RAIENS,"7","E"),1,27)
 .W !?RATAB(1),"Case No.",?RATAB(2),": ",$$CN() ;16 digits max
 .W ?RATAB(3),"Bedsection",?RATAB(4),": ",$E(RAY3A(70.03,RAIENS,"19","E"),1,27)
 .W !?RATAB(3),"Clinic",?RATAB(4),": ",$E(RAY3A(70.03,RAIENS,"8","E"),1,27)
 .W:$E(RAY3A(70.03,RAIENS,"4","E"),1)="C" !?RATAB(3),"Contract",RATAB(4),": ",$E(RAY3A(70.03,RAIENS,"9","E"),1,27)
 .W:$E(RAY3A(70.03,RAIENS,"4","E"),1)="S" !?RATAB(3),"Sharing",RATAB(4),": ",$E(RAY3A(70.03,RAIENS,"9","E"),1,27)
 .W:$E(RAY3A(70.03,RAIENS,"4","E"),1)="R" !?RATAB(3),"Research",RATAB(4),": ",$E(RAY3A(70.03,RAIENS,"9.5","E"),1,27)
 .W !,RALINE ;spacer
 .S RAOPRC=$$GET1^DIQ(71,+$P(RAORD(0),U,2)_",",.01) ;name of ordered proc.
 .S RAPRC=$$GET1^DIQ(71,+$P(RAY3,U,2)_",",.01) ;name of registered proc.
 .W !?RATAB(1),"Registered",?RATAB(2),": ",$E(RAPRC,1,30),?RATAB(4),$$PRC(+$P(RAY3,U,2))
 .W:RAPRC'=RAOPRC !?RATAB(1),"Requested",?RATAB(2),": ",$E(RAOPRC,1,60)
 .S RA("PHYS")=$$GET1^DIQ(200,+$P(RAY3,U,14)_",",.01) ;name of requesting physician
 .S RA("EXS")=$P($G(^RA(72,+$P(RAY3,U,3),0)),U) ;exam status
 .S RA("PIR")=$$GET1^DIQ(200,+$P(RAY3,U,12)_",",.01) ;name of primary interpreting resident
 .I $P(RAY3,U,17)>0 D
 ..S RA("RPT")=$$GET1^DIQ(74,+$P(RAY3,U,17)_",",5)
 ..S RA("RPT")=$S($G(RA("RPT"))'="":RA("RPT"),1:"No Report")
 ..S RA("PREVFIER")=+$P($G(^RARPT(+$P(RAY3,U,17),0)),U,13) ;13th piece fld #15
 ..S RA("PREVFIER")=$$GET1^DIQ(200,+RA("PREVFIER")_",",.01) ;name of requesting physician
 ..S RA("PREVFIED")=$S(RA("PREVFIER")'="":RA("PREVFIER"),1:"No") K RA("PREVFIER")
 ..Q
 .S RA("CAM")=$S(+$P(RAY3,U,18)>0:$P($G(^RA(78.6,+$P(RAY3,U,18),0)),U),1:"") ;cam/eq/rm
 .S RA("PIS")=$$GET1^DIQ(200,+$P(RAY3,U,15)_",",.01) ;name of primary interpreting staff
 .S RA("DX")=$S(+$P(RAY3,U,13)>0:$P($G(^RA(78.3,+$P(RAY3,U,13),0)),U),1:"")
 .S RA("TECH")=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"TC",0))
 .I RA("TECH") D
 ..S RA("T")=+$P($G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"TC",RA("TECH"),0)),U)
 ..S RA("TECH")=$$GET1^DIQ(200,RA("T")_",",.01) ;name of technologist
 ..K RA("T")
 ..QUIT
 .S RA("CMP")=$E(RAY3A(70.03,RAIENS,"16","E"),1,27)
 .W !?RATAB(1),"Requesting Phy",?RATAB(5),": ",$E(RA("PHYS"),1,18)
 .W ?RATAB(6),"Exam Status",?RATAB(7),": ",$E(RA("EXS"),1,27)
 .W !?RATAB(1),"Int'g Resident",?RATAB(5),": ",$E(RA("PIR"),1,18)
 .W ?RATAB(6),"Report Status",?RATAB(7),": ",$E($G(RA("RPT")),1,27)
 .W !?RATAB(1),"Pre-Verified",?RATAB(5),": ",$E($G(RA("PREVFIED")),1,18)
 .W ?RATAB(6),"Cam/Equip/Rm",?RATAB(7),": ",$E(RA("CAM"),1,27)
 .W !?RATAB(1),"Int'g Staff",?RATAB(5),": ",$E(RA("PIS"),1,18)
 .W ?RATAB(6),"Diagnosis",?RATAB(7),": ",$E(RA("DX"),1,27)
 .W !?RATAB(1),"Technologist",?RATAB(5),": ",$E($G(RA("TECH")),1,18)
 .W ?RATAB(6),"Complication",?RATAB(7),": ",$E(RA("CMP"),1,27)
 .I $P(RAORD(0),U,13)'="" W !?RATAB(1),"Pregnant at time of order entry: "_$$GET1^DIQ(75.1,+$P(RAY3,U,11)_",",13)
 .;
 .;--------- get procedure modifiers/CPT Modifiers ---------------
 .S RALBL="Modifiers",RAHDR=$$CJ^XLFSTR(RALBL,IOM,"-")
 .W !,RAHDR,!?RATAB(1),RALBL,?RATAB(5),": "
 .I $O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"M",0)) D  K RAL,RAS
 ..S RAL=$O(RAY3A("70.1",$C(126)),-1)
 ..S RAS="" F  S RAS=$O(RAY3A("70.1",RAS)) Q:RAS=""  D  Q:RAQUIT
 ...I $Y>(IOSL-4) D HDR Q:RAQUIT
 ...W ?18,$E($G(RAY3A("70.1",RAS,.01,"E")),1,30)
 ...W:RAL'=RAS ! ;more data
 ...Q
 ..Q
 .E  W "None"
 .Q:RAQUIT
 .S RALBL="CPT Modifiers" W !?RATAB(1),RALBL,?RATAB(5),": "
 .I $O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"CMOD",0)) D  K RACPT,RAL,RALBL,RAS,RAX99,Y
 ..;EX: - RACPT("70.3135","1,1,6889176.8884,76,",".01","I")=4
 ..D GETS^DIQ(70.03,RAIENS,"135*","I","RACPT")
 ..S RAL=$O(RACPT("70.3135",$C(126)),-1)
 ..S RAS="" F  S RAS=$O(RACPT("70.3135",RAS)) Q:RAS=""  D  Q:RAQUIT
 ...I $Y>(IOSL-4) D HDR Q:RAQUIT
 ...;EX - RAX99="4^23^UNUSUAL ANESTHESIA^09923^C^2930101^1^^2930101^"
 ...S Y=$G(RACPT("70.3135",RAS,.01,"I")),RAX99=""
 ...S:Y RAX99=$$BASICMOD^RACPTMSC(Y,RADTE)
 ...W ?18,$P(RAX99,U,2)," ",$P(RAX99,U,3)
 ...W:RAL'=RAS !
 ...Q
 ..Q
 .E  W "None"
 .Q:RAQUIT
 .;
 .;-------------------- get Contrast Media --------------------------
 .I $O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"CM",0)) D  K RACM,RAL,RALBL,RAS
 ..S RALBL="Contrast Media",RAHDR=$$CJ^XLFSTR(RALBL,IOM,"-")
 ..W !,RAHDR,!?RATAB(1),RALBL,?RATAB(5),": "
 ..D GETS^DIQ(70.03,RAIENS,"225*","E","RACM")
 ..S RAL=$O(RACM("70.3225",$C(126)),-1)
 ..S RAS="" F  S RAS=$O(RACM("70.3225",RAS)) Q:RAS=""  D  Q:RAQUIT
 ...I $Y>(IOSL-4) D HDR Q:RAQUIT
 ...W ?18,$E($G(RACM("70.3225",RAS,.01,"E")),1,30)
 ...W:RAL'=RAS ! ;more data
 ...Q
 ..Q
 .Q:RAQUIT
 .;
 .;----------------------- get Medications ------------------------------
 .I $O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"RX",0)) D  K RAS,RAMED
 ..S RAHDR=$$CJ^XLFSTR("Medications",IOM,"-") W !,RAHDR
 ..K RAMED D GETS^DIQ(70.03,RAIENS,"200*","E","RAMED")
 ..S RAL=$O(RAMED("70.15",$C(126)),-1)
 ..S RAS="" F  S RAS=$O(RAMED("70.15",RAS)) Q:RAS=""  D  Q:RAQUIT
 ...I $Y>(IOSL-4) D HDR Q:RAQUIT
 ...W !?RATAB(1),"Med: ",$E($G(RAMED("70.15",RAS,.01,"E")),1,28)
 ...W ?RATAB(3),"Dose Adm'd: ",$E($G(RAMED("70.15",RAS,2,"E")),1,25)
 ...W !?RATAB(1),"Adm'd by: ",$E($G(RAMED("70.15",RAS,3,"E")),1,24)
 ...W ?RATAB(3),"Date Adm'd: ",$E($G(RAMED("70.15",RAS,4,"E")),1,20)
 ...W:RAS'=RAL ! ;more data
 ...Q
 ..Q
 .Q:RAQUIT
 .;
 .;----------------------- get Radiopharms ------------------------------
 .I $P(RAY3,U,28)>0 D  K RADA,RADIO,RAS,RAU
 ..;#500 NUCLEAR MED DATA
 ..S RADA=$P(RAY3,U,28)_",",RAHDR=$$CJ^XLFSTR("Radiopharmaceuticals",IOM,"-")
 ..W !,RAHDR K RADIO S RAS=""
 ..D GETS^DIQ(70.2,RADA_",","100*","E","RADIO")
 ..S RAL=$O(RADIO("70.21",$C(126)),-1)
 ..F  S RAS=$O(RADIO("70.21",RAS)) Q:RAS=""  D  Q:RAQUIT
 ...I $Y>(IOSL-4) D HDR Q:RAQUIT
 ...S RAU=0 F  S RAU=$O(RADIO("70.21",RAS,RAU)) Q:RAU'>0  D  Q:RAQUIT
 ....I $Y>(IOSL-4) D HDR Q:RAQUIT
 ....S RAU(0)=$$TRN1^RAPROD2(RAU)_$G(RADIO("70.21",RAS,RAU,"E"))
 ....S RAU(0)=RAU(0)_$S(RAU=2:" mCi",RAU=4:" mCi",RAU=7:" mCi",1:"")
 ....W !?RATAB(1),$E(RAU(0),1,28)
 ....S RAU=$O(RADIO("70.21",RAS,RAU))
 ....S:RAU'>0 RAU=$C(32) Q:RAU=$C(32)
 ....S RAU(1)=$$TRN1^RAPROD2(RAU)_$G(RADIO("70.21",RAS,RAU,"E"))
 ....S RAU(1)=RAU(1)_$S(RAU=2:" mCi",RAU=4:" mCi",RAU=7:" mCi",1:"")
 ....W ?RATAB(4),$E(RAU(1),1,27)
 ....Q
 ...W:RAS'=RAL ! ;more data
 ...Q
 ..Q
 .Q:RAQUIT
 .;
 .;----------------------- get Rad Dose (fluoro) --------------------
 .I $P(RARAD(0),U,5) D  ;if air kerma data
 ..S RAHDR=$$CJ^XLFSTR("Rad Dose",IOM,"-"),RAZFL=""
 ..S RACOL(1)="Air Kerma (mGy)"
 ..S RACOL(2)="Air Kerma Area Product (Gy-cm2)"
 ..S RACOL(3)="Fluoro Time (min)" ;note: data is in seconds
 ..W !,RAHDR
 ..I $Y>(IOSL-4) D HDR Q:RAQUIT
 ..W !?RATAB(1),RACOL(1),?24,RACOL(2),?60,RACOL(3)
 ..S $P(XRA,"-",($L(RACOL(1))+1))="" W !?RATAB(1),XRA
 ..K XRA S $P(XRA,"-",($L(RACOL(2))+1))="" W ?24,XRA
 ..K XRA S $P(XRA,"-",($L(RACOL(3))+1))="" W ?60,XRA
 ..W !?RATAB(1),$P(RARAD(0),U,5),?24,$P(RARAD(0),U,6)
 ..W ?60,$J(($P(RARAD(0),U,7))/60,1,1) ;to mins to tenths
 ..K RACOL,XRA
 ..Q
 .Q:RAQUIT
 .;
 .;----------------------- get Rad Dose (CT SCAN) -------------------
 .I $O(^RAD(RARAD,"II",0)) S RAZCT="" D CT^RADRPT1 ;if CT Scan data
 .Q:RAQUIT
 .S RAP=RAP+1
 .I $D(ZTQUEUED) S:RAP#500=0 (RAQUIT,ZTSTOP)=$$S^%ZTLOAD()
 .; --- disclaimer ---
 .K RALBL D HDR Q:RAQUIT
 .F RAII=1:1:5 D  Q:RAQUIT
 ..I ($D(RAZFL)#2)=1,(($D(RAZCT)#2)=0) Q:RAII=3!(RAII=4)
 ..I ($D(RAZFL)#2)=0,(($D(RAZCT)#2)=1) Q:RAII=5
 ..S RAYY=0
 ..F  S RAYY=$O(^TMP($J,"RA DISCLAIMER",RAII,RAYY)) Q:RAYY'>0  D  Q:RAQUIT
 ...I $Y>(IOSL-4) D HDR Q:RAQUIT
 ...W !,$G(^TMP($J,"RA DISCLAIMER",RAII,RAYY))
 ...Q
 ..Q
 .S DX=0,DY=IOSL X ^%ZOSF("XY")
 .K DX,DY,RAIEN,RAIENS,RAII,RAY2A,RAY3A,RAYY,RAZCT,RAZFL,RTFL,Y,Z
 .Q
 D XIT
 Q
 ;
CN() ;return case # in the form of the accession # (SSAN aware)
 N X S X=$P(RAY3,U,31) ;SITE ACCESSION NUMBER (SSAN)
 S:X="" X=$E(RADTE,4,5)_$E(RADTE,6,7)_$E(RADTE,2,3)_"-"_$P(RAY3,U)
 Q X
 ; 
HDR ;header/end of screen logic
 ;RAHDR: is dynamic; its value is based on the section
 ;HDR^RADRPT1A is called from.
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
 W !,RAHDR W:$D(RALBL)#2 !?RATAB(1),RALBL,": "
 Q
 ;
XIT ;kill variables set ZTREQ then exit
 K %,%H,%I,N,RA,RABORDR,RACN,RACNI,RADA,RADFN,RADTE,RADPT,RADTI,RAHDR
 K RAI,RAIEN,RAIENS,RAL,RALBL,RALINE,RAM,RAMED,RANODT,RAOPRC,RAORD,RAP,RAPG
 K RAPRC,RAQUIT,RARAD,RARPT,RARX,RAS,RATAB,RATITLE,RAU,RAX,RAY,RAY2,RAY2A
 K RAY3,RAY3A,RAZCT,RAZFL
 K ^TMP($J,"RAEX"),^TMP($J,"RA DISCLAIMER")
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
PRC(Y) ;print procedure data (file #71)
 ;Input: Y = IEN file 71
 ;Output: imaging type abbreviation - procdure type or inactive - CPT code
 ;       (if not a Parent or Broad procedure)
 ;ex: (NM  Parent)
 ;    (MAM  Inactive) Note: may be broad or parent type
 ;    (CT  Inactive)  CPT:76361
 ;    (VAS  Detailed)  CPT:93619   
 N X
 S X(0)=$G(^RAMIS(71,Y,0)),X("I")=$G(^RAMIS(71,Y,"I"))
 S X("IN")=$S(X("I")="":0,DT'>X("I"):0,1:1)
 S X=$P(X(0),U,6),X("CPT")=""
 S X("PT")=$S(X="B":"Broad",X="D":"Detailed",X="P":"Parent",X="S":"Series",1:"Unknown")
 S X=+$P(X(0),U,12) S X("IT")=$S(X=0:"Unknown",1:$P(^RA(79.2,X,0),U,3)) ;required identifier
 I $E(X("PT"),1)'="B",$E(X("PT"),1)'="P" S X("CPT")="CPT:"_$P($$NAMCODE^RACPTMSC(+$P(X(0),U,9),DT),U)
 S X="("_X("IT")_"  "_$S(X("IN"):"Inactive",1:X("PT"))_")  "_X("CPT")
 Q X
 ;
