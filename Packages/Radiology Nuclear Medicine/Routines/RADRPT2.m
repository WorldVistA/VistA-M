RADRPT2 ;HISC/GJC Radiation dosage report utility two ;1/18/13  09:00
 ;;5.0;Radiology/Nuclear Medicine;**113**;Mar 16, 1998;Build 6
 ;
EN ;entry point
 ;--- IAs ---
 ;Call/File             Number     Type
 ;------------------------------------------------
 ;$$GET1^DIQ            2056       S
 ;DIR                   10026      S
 ;$$FMADD^XLFDT         10103      S
 ;$$FMTE^XLFDT          10103      S
 ;$$NOW^XLFDT           10103      S
 ;$$KSP^XUPARAM         2541       S
 ;EN^XUTMDEVQ           1519       S
 ;^DPT(                 10035      S
 ;^DIC(4,               10060      S
 ;^VA(200,              10090      S
 ;where 'S'=Supported; 'C'=Controlled Subscription; 'P'=Private
 ;
 ;report specifications: sort levels
 ;1) Type of Report (Fluoro, CT Detailed or CT Summary)
 ;2) exam date range begin-end
 ;3) exam attribute: Patient, Pri. Interpreting Staff or Procedure (one/many/all)
 K DIR,DIRUT,DIROUT,DTOUT,DUOUT
 S DIR(0)="S^F:Fluoroscopy;D:CT Detailed;S:CT Summary"
 S DIR("A")="Enter a report format"
 S DIR("?",1)="Enter the format of the report: 'F' for a Fluoroscopy summary report"
 S DIR("?",2)="'D' for a detailed Cat Scan (CT) report or 'S' for a CT summary report."
 S DIR("?",3)=""
 S DIR("?")="Enter '^' to exit."
 D ^DIR
 I $D(DIRUT)#2 K DIR,DIRUT,DIROUT,DTOUT,DUOUT,X,Y Q
 S RARPTYPE=Y
 K DIR,DIRUT,DIROUT,DTOUT,DUOUT,X,Y
 ;
 ;enter a date range beginning/ending
 D DATE^RAUTL
 I '($D(BEGDATE)#2) D XIT Q  ;ex: 3120112
 I '($D(ENDDATE)#2) D XIT Q  ;ex: 3120113
 ;namespace, make sure we get all the data for this range
 S RABEGDT=$$FMADD^XLFDT(BEGDATE,0,0,-1,0) ;ex: 3120111.2359
 S RAENDDT=ENDDATE+.2359 ;ex: 3120113.2359
 S RANGE=$$FMTE^XLFDT(BEGDATE,"2DZ")_" - "_$$FMTE^XLFDT(ENDDATE,"2DZ")
 K BEGDATE,ENDDATE
 ;
 W @IOF K DIR,DIRUT,DIROUT,DTOUT,DUOUT
 S DIR(0)="S^C:CPT Code;P:Patient;R:Radiologist"
 S DIR("A")="Enter a filter parameter"
 S DIR("?",1)="Enter the final filter parameter for the report: 'C' for CPT Code"
 S DIR("?",2)="'P' for patient or 'R' for radiologist."
 S DIR("?",3)=""
 S DIR("?")="Enter '^' to exit."
 D ^DIR
 I $D(DIRUT)#2 D XIT Q
 S RAFILTR=Y
 K DIR,DIRUT,DIROUT,DTOUT,DUOUT,X,Y
 ;
 S RAQUIT=0
 D @$S(RAFILTR="C":"PROC",RAFILTR="P":"PAT",1:"STAFF")
 I RAQUIT D XIT Q
 ;
 K RAVAR D INIT ;get facility name, station # & VISN
 ;
 F RA="RABEGDT","RAENDDT","RANGE","RAVISN","RASTNUM","RAFAC","RAFILTR","RARPTYPE","RAQUIT" S RAVAR(RA)=""
 S RAX=$S(RAFILTR="R":"^TMP(""RA STFPHYSI"",$J,",RAFILTR="C":"^TMP(""RA PROCI"",$J,",1:"^TMP(""RA PATI"",$J,")
 S RAVAR(RAX)=""
 D EN^XUTMDEVQ("START^RADRPT2","Package: RA - Print the radiation dosage report",.RAVAR,,1)
 I +$G(ZTSK)>0 W !!,"Task Number: "_ZTSK,!
 D XIT
 QUIT
 ;
START ;start processing
 K ^TMP($J,"RA SORT")
 ;^RADPT("AR",2920610.095,2,7079389.9049)=""
 ;^RADPT("AR",2920610.1035,1,7079389.8964)=""
 S RADTE=RABEGDT,RARUNDT=$$FMTE^XLFDT($$NOW^XLFDT(),"2PM")
 S RAC=9999999.9999,(RAP,RAQUIT,RAPG)=0 K ^TMP($J,"RA SORT")
 F  S RADTE=$O(^RAD("ARAD",RADTE)) Q:RADTE'>0!(RADTE>RAENDDT)  D  Q:RAQUIT
 .S RADFN=0 F  S RADFN=$O(^RAD("ARAD",RADTE,RADFN)) Q:RADFN'>0  D  Q:RAQUIT
 ..;
 ..S RACN=0,RADTI=(RAC-RADTE)
 ..S RAY2=$G(^RADPT(RADFN,"DT",RADTI,0))
 ..F  S RACN=$O(^RADPT(RADFN,"DT",RADTI,"P","B",RACN)) Q:RACN'>0  D  Q:RAQUIT
 ...S RACNI=$O(^RADPT(RADFN,"DT",RADTI,"P","B",RACN,0))
 ...S RAY3=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0))
 ...S RADIEN=$P($G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,1)),U,1) Q:RADIEN=""
 ...;
 ...; --------------------- sanity check: pointers to/from 70.3 & 70.03 -------------------
 ...I $O(^RAD("ARAD",RADTE,RADFN,RACN,0))'=RADIEN Q
 ...; -------------------------------------------------------------------------------------
 ...;
 ...; -------------------------------- patient sort ---------------------------------------
 ...I RAFILTR="P",($D(^TMP("RA PATI",$J,RADFN))\10) D
 ....S RASORT=$O(^TMP("RA PATI",$J,RADFN,"")) Q:RASORT=""
 ....D GETRDOSE K RASORT
 ....Q
 ...; -------------------------------------------------------------------------------------
 ...;
 ...; ----------------------------- procedure/CPT sort ------------------------------------
 ...I RAFILTR="C",($D(^TMP("RA PROCI",$J,+$P(RAY3,U,2)))\10) D
 ....S RASORT=$O(^TMP("RA PROCI",$J,+$P(RAY3,U,2),"")) Q:RASORT=""
 ....D GETRDOSE K RASORT
 ....Q
 ...; -------------------------------------------------------------------------------------
 ...;
 ...; ----------------------- primary interpreting staff sort -----------------------------
 ...I RAFILTR="R",($D(^TMP("RA STFPHYSI",$J,+$P(RAY3,U,15)))\10) D
 ....S RASORT=$O(^TMP("RA STFPHYSI",$J,+$P(RAY3,U,15),"")) Q:RASORT=""
 ....D GETRDOSE K RASORT
 ....Q
 ...; -------------------------------------------------------------------------------------
 ...Q
 ..Q
 .Q
 ;display the data. if no data print the negative report and quit
 D DISPLAY^RADRPT2A
 K ^TMP($J,"RA SORT"),^TMP("RA PATI"),^TMP("RA PROCI"),^TMP("RA STFPHYSI")
 D XIT
 QUIT
 ;
PAT ;sort by patient
 K ^TMP($J,"RA PAT"),^TMP("RA PATI",$J)
 S RADIC="^RADPT(",RADIC(0)="QEAMZ",RAUTIL="RA PAT"
 S RADIC("A")="Select Rad/Nuc Med Patient: ",RADIC("B")="All"
 W !! D EN1^RASELCT(.RADIC,RAUTIL) K %W,%Y1,DIC,RADIC,RAUTIL,X,Y
 ;Did the user select radiology patients? If not, quit
 I $O(^TMP($J,"RA PAT",""))="" D
 .S RAQUIT=1 W !!?3,$C(7),"Radiology patient data was not selected."
 .Q
 ;set ^TMP($J,"RA PAT","I",IEN_#2)
 E  D INT($NA(^TMP($J,"RA PAT")))
 Q
 ;
PROC ;sort by procedure
 K ^TMP($J,"RA PROC"),^TMP("RA PROCI",$J)
 S RADIC="^RAMIS(71,",RADIC(0)="QEAMZ",RAUTIL="RA PROC"
 S RADIC("A")="Select Rad/Nuc Med Procedures: ",RADIC("B")="All"
 S RADIC("S")="I $$SCRPROC^RADRPT2(+Y)"
 W !! D EN1^RASELCT(.RADIC,RAUTIL) K %W,%Y1,DIC,RADIC,RAUTIL,X,Y
 ;Did the user select radiology procedures? If not, quit
 I $O(^TMP($J,"RA PROC",""))="" D
 .S RAQUIT=1 W !!?3,$C(7),"Radiology procedure data was not selected."
 .Q
 ;set ^TMP($J,"RA PROC","I",IEN_#71)
 E  D INT($NA(^TMP($J,"RA PROC")))
 Q
 ;
SCRPROC(DA) ;screen procedures by type and if inactive.
 N RA71 S RA71(0)=$G(^RAMIS(71,DA,0))
 ;S RA71("I")=$G(^RAMIS(71,DA,"I"))
 Q:"^B^P^"[("^"_$P(RA71(0),U,6)_"^") 0
 ;Q:$L(RA71("I"))&(RA71("I")'>DT) 0
 Q 1
 ; 
STAFF ;sort by primary interpreting staff (radiologist)
 K ^TMP($J,"RA STFPHYS"),^TMP("RA STFPHYSI",$J)
 S RADIC="^VA(200,",RADIC(0)="QEAMZ",RAUTIL="RA STFPHYS"
 S RADIC("A")="Select Radiologist: ",RADIC("B")="All"
 S RADIC("S")="I $D(^VA(200,""ARC"",""S"",+Y))\10"
 W !! D EN1^RASELCT(.RADIC,RAUTIL) K %W,%Y1,DIC,RADIC,RAUTIL,X,Y
 ;Did the user select staff radiologists? If not, quit
 I $O(^TMP($J,"RA STFPHYS",""))="" D
 .S RAQUIT=1 W !!?3,$C(7),"Staff Radiologist data was not selected."
 .Q
 ;set ^TMP($J,"RA STFPHYS","I",IEN_#200)
 E  D INT($NA(^TMP($J,"RA STFPHYS")))
 Q
 ;
INT(ROOT) ;store the internal value of the patient/procedure/radiologist record
 N X,Y S X=""
 F  S X=$O(@ROOT@(X)) Q:X=""  D
 .S Y=0 F  S Y=$O(@ROOT@(X,Y)) Q:Y'>0  D
 ..S:RAFILTR="C" ^TMP("RA PROCI",$J,Y,X)=""
 ..S:RAFILTR="P" ^TMP("RA PATI",$J,Y,X)=""
 ..S:RAFILTR="R" ^TMP("RA STFPHYSI",$J,Y,X)=""
 ..Q
 .K @ROOT@(X)
 .Q
 Q
 ;
INIT ;initialize some variables
 ;return facility name (RAFAC), station # (RASTNUM) & VISN # (RAVISN)
 K RAR,X S RAY=$$KSP^XUPARAM("INST")_","
 D GETS^DIQ(4,RAY,".01;14*;99","E","RAR")
 S RAFAC=RAR(4,RAY,.01,"E") ; Name of facility
 S RASTNUM=RAR(4,RAY,99,"E") ;  Station Number
 K RAR,RAY,X
 Q
 ;
GETRDOSE ;get Rad dosage data
 I RARPTYPE="F" D  Q
 .S X=$G(^RAD(RADIEN,0))
 .S RAK=$P(X,U,5),RAKAP=$P(X,U,6)
 .S RAFLSEC=$P(X,U,7),RAFLMIN=$J((RAFLSEC/60),5,1)
 .;^("F") = air kerma ^ air kerma area product ^ total fluoro time (mins)
 .S ^TMP($J,"RA SORT",RADTE,RASORT,RADFN,RACNI,"F")=RAK_U_RAKAP_U_RAFLMIN
 .K RAFLMIN,RAFLSEC,RAK,RAKAP,X
 .Q
 ;check sub-file for CT data
 I $O(^RAD(RADIEN,"II",0)) D
 .K RADLP,RAII,I,X,Y S X="0^0"
 .; ^("S") = CTDIvol (total) ^ DLP (total)
 .S ^TMP($J,"RA SORT",RADTE,RASORT,RADFN,RACNI,"S")="0^0",RADLP=$C(32),I=0
 .;get "top five" total all CTDIvol & DLP values
 .F  S RADLP=$O(^RAD(RADIEN,"II","DLP",RADLP),-1) Q:RADLP'>0  D  Q:RAQUIT
 ..S Y=0 F  S Y=$O(^RAD(RADIEN,"II","DLP",RADLP,Y)) Q:Y'>0  D  Q:RAQUIT
 ...S RAII(0)=$G(^RAD(RADIEN,"II",Y,0)) Q:RAII(0)=""
 ...S I=I+1
 ...S:I'>5 ^TMP($J,"RA SORT",RADTE,RASORT,RADFN,RACNI,I)=$P(RAII(0),U,3,5)
 ...S $P(X,U,1)=$P(X,U,1)+$P(RAII(0),U,4) ;CTDIvol
 ...S $P(X,U,2)=$P(X,U,2)+$P(RAII(0),U,5) ;DLP
 ...Q
 ..Q
 .S ^TMP($J,"RA SORT",RADTE,RASORT,RADFN,RACNI,"S")=X
 .K RADLP,RAII,I,X,Y
 .Q
 Q
 ;
XIT ;kill variables
 K %,DF,DIR,DIRUT,DIROUT,DTOUT,DUOUT,RA,RABEGDT,RAC,RACNI,RADFN,RADIEN,RADTE,RADTI,RAENDDT
 K RAFAC,RAFILTR,RAP,RAPG,RAPOP,RANGE,RAQUIT,RAR,RARPTYPE,RARUNDT,RASORT,RASTNUM,RAUTIL
 K RAVAR,RAX,RAY,RAY2,RAY3,X,Y,ZTDESC,ZTSAVE,ZTSK
 Q
 ;
