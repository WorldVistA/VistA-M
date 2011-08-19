MMRSIPC ;MIA/LMT - Print MRSA IPEC Report ;10-20-06
 ;;1.0;MRSA PROGRAM TOOLS;;Mar 22, 2009;Build 35
 ;
 ;This is the main routine to print the MRSA IPEC Report. 
 ;This routine uses functions contained in MMRSIPC2, MMRSIPC3, and MMRSIPC4.
MAIN ;
 N NUMDIV,MMRSDIV,MMRSLOC,EXTFLG,STRTDT,ENDDT,PRTSUM,BYADM
 D CHECK
 D CHECK2
 I $D(EXTFLG) W ! H 2 Q
 W !
 S MMRSDIV=$$GETDIV Q:$D(EXTFLG)!(MMRSDIV="")
 D CHECK3
 I $D(EXTFLG) W ! H 2 Q
 D PROMPT Q:$D(EXTFLG)
 D ASKDVC Q:$D(EXTFLG)
 K MMRSSUM
 Q
CHECK ;Check if parameters are setup
 N NUMDIV,MMRSDIV
 S NUMDIV=0
 S MMRSDIV=0 F  S MMRSDIV=$O(^MMRS(104,MMRSDIV)) Q:'MMRSDIV  I $D(^MMRS(104,MMRSDIV,0)) S NUMDIV=NUMDIV+1
 I NUMDIV=0 D
 .W !!,"   >>> Make sure a division has been setup using option:"
 .W !,"          'MRSA Tools Parameter Setup (Main)'"
 .S EXTFLG=1
 Q
CHECK2 ;Check if lab tests and etiologies are setup
 N TSTSTP,MRSAETIO,MRSASTAP,ORG,ETIONAME,MMRSET,MMRSI
 S TSTSTP=0
 I $D(^LAB(60,"B","MRSA SURVL NARES DNA"))!($D(^LAB(60,"B","MRSA SURVL NARES AGAR"))) S TSTSTP=1
 I $O(^LAB(60,"B","MRSA SURVL NARES DNA"))["MRSA SURVL NARES DNA" S TSTSTP=1
 I $O(^LAB(60,"B","MRSA SURVL NARES AGAR"))["MRSA SURVL NARES AGAR" S TSTSTP=1
 I 'TSTSTP D
 .S EXTFLG=1
 .W !!,"   >>> Make sure the MRSA CH-subscripted tests have been setup according"
 .W !,"       to the National Guidelines. Laboratory needs to setup at least"
 .W !,"       one of these lab tests in the system before generating reports:"
 .W !,"          1. 'MRSA SURVL NARES DNA'"
 .W !,"          2. 'MRSA SURVL NARES AGAR'"
 S MRSAETIO=0
 ;S MRSASTAP="STAPHYLOCOCCUS AUREUS METH" F  S MRSASTAP=$O(^LAB(61.2,"B",MRSASTAP)) Q:MRSASTAP=""!(MRSASTAP]"STAPHYLOCOCCUS AUREUSZ")  D
 ;.S ORG=0 F  S ORG=$O(^LAB(61.2,"B",MRSASTAP,ORG)) Q:'ORG  D
 ;..S ETIONAME=$P($G(^LAB(61.2,ORG,0)),U,1)
 ;..I ETIONAME["STAPHYLOCOCCUS AUREUS METHICILLIN RESISTANT (MRSA)" S MRSAETIO=ORG
 D FIND^DIC(61.2,,".01E;@","PM","STAPHYLOCOCCUS AUREUS METHICILLIN RESISTANT",,"B",,,"MMRSET")
 S MMRSI="" F  S MMRSI=$O(MMRSET("DILIST",MMRSI)) Q:MMRSI=""  I +MMRSI>0  D
 .S ETIONAME=$P($G(MMRSET("DILIST",MMRSI,0)),U,2)
 .S ORG=$P($G(MMRSET("DILIST",MMRSI,0)),U,1)
 .I ETIONAME["STAPHYLOCOCCUS AUREUS METHICILLIN RESISTANT" S MRSAETIO=ORG
 I 'MRSAETIO D
 .S EXTFLG=1
 .W !!,"   >>> Make sure the Etiology has been setup according "
 .W !,"       to the National Guidelines. The following etiology "
 .W !,"       must be added to the Etiology Field file (#61.2):"
 .W !,"          'STAPHYLOCOCCUS AUREUS METHICILLIN RESISTANT (MRSA)' "
 Q
CHECK3 ;Check if Ward Mappings have been setup for this division
 N NUMLOC,MMRSLOC
 S NUMLOC=0
 S MMRSLOC=0 F  S MMRSLOC=$O(^MMRS(104.3,MMRSLOC)) Q:'MMRSLOC  I $P($G(^MMRS(104.3,MMRSLOC,0)),U,2)=MMRSDIV S NUMLOC=NUMLOC+1
 I NUMLOC=0 W !!,"   >>> Make sure the Ward Mappings for each Geographical Unit has been setup.",!! S EXTFLG=1
 Q
MAIN2 ; Entry for queuing
 D CLEAN ;Kill Temp Global
 D GETPARAM ; Load parameters in temp global
 D GETMOVE^MMRSIPC2 ;Get movements and store in temp global
 D GETLABS^MMRSIPC3 ;Get swabbing rates and MRSA history and store in temp global
 I 'BYADM D PATDAYS ;Get patient days of care
 D PRINT^MMRSIPC4 ;Print report
 D CLEAN ;Kill Temp Global
 Q
CLEAN ;
 K ^TMP($J,"MMRSIPC")
 Q
GETDIV() ;Prompt user to select Division
 N MMRSDIV,COUNT,DIV,DIC,Y,DLAYGO,X,DTOUT,DUOUT
 S MMRSDIV=""
 S COUNT=0,DIV=0 F  S DIV=$O(^MMRS(104,DIV)) Q:'DIV  S COUNT=COUNT+1
 I COUNT=1 S MMRSDIV=$O(^MMRS(104,0)) Q MMRSDIV
 S DIC="^DG(40.8,"
 S DIC(0)="AEMQ"
 S DIC("A")="Select the Division: "
 S DIC("S")="I $D(^MMRS(104,""B"",Y))"
 D ^DIC K DIC
 I $D(DTOUT)!($D(DUOUT))!(Y=-1) S EXTFLG=1 Q ""
 S MMRSDIV=+Y
 S MMRSDIV=$O(^MMRS(104,"B",MMRSDIV,0))
 Q MMRSDIV
PROMPT ;Prompts user for start date, end date, locations, and if user wants to only print the Summary Report.
 ;Prompt if should run report by Admission or Discharge
 N DIR,DIRUT,PRMPTTXT,Y
 S DIR(0)="S^A:Admission Report;D:Discharge/Transmission Report"
 S DIR("A")="Run (A)dmission Or (D)ischarge/Transmission Report"
 D ^DIR K DIR
 I $D(DIRUT) S EXTFLG=1 Q 
 I Y="A" S BYADM=1,PRMPTTXT="ward admission"
 I Y="D" S BYADM=0,PRMPTTXT="ward discharge"
DATE ;Prompts user for date range
 N %DT,X
 K Y
 W ! S %DT="AEPX",%DT("A")="Begin with "_PRMPTTXT_" date: " D ^%DT
 I Y<0 S EXTFLG=1 Q
 S STRTDT=Y
 S %DT("A")="End with "_PRMPTTXT_" date: " D ^%DT
 I Y<0 S EXTFLG=1 Q
 S ENDDT=Y
 I '$P(ENDDT,".",2) S ENDDT=Y+.24
 I ENDDT<STRTDT W !!,"The ending date of the range must be later than the starting date." G DATE
LOC ;Prompts user for locations
 W !
 S DIR(0)="YA",DIR("A")="Do you want to select all locations? ",DIR("B")="NO"
 D ^DIR K DIR
 I $D(DIRUT) S EXTFLG=1 Q
 I Y=1 D  G SUMRPT
 .S Y=0 F  S Y=$O(^MMRS(104.3,Y)) Q:'Y  I $P($G(^MMRS(104.3,Y,0)),U,2)=MMRSDIV S MMRSLOC(Y)=""
 ;PROMPT FOR WARDS
 N DIC,DLAYGO,DTOUT,DUOUT
 W !
 S DIC("A")="Select Geographical Location: "
 S DIC("S")="I $P($G(^MMRS(104.3,Y,0)),U,2)="_MMRSDIV
 S DIC="^MMRS(104.3,",DIC(0)="QEAM" D ^DIC
 I (Y=-1)!($D(DTOUT))!($D(DUOUT)) S EXTFLG=1 Q
 S MMRSLOC(+Y)=""
 S DIC("A")="Select another Geographical Location: " F  D ^DIC Q:Y=-1  S MMRSLOC(+Y)=""
 K DIC
 I ($D(DTOUT))!($D(DUOUT)) S EXTFLG=1 Q
SUMRPT ;Prompt user if should only run the summary report.
 I $G(MMRSSUM) S PRTSUM=1 Q  ; IF OPTION IS ONLY FOR SUMMARY REPORT...
 W !
 S DIR(0)="Y"
 S DIR("A")="Do you want to only print the summary report"
 S DIR("B")="NO"
 D ^DIR K DIR
 I $D(DIRUT) S EXTFLG=1 Q
 S PRTSUM=Y
 Q
ASKDVC ;Prompts user for device of output (allows queuing)
 N MMRSVAR,ZTSK
 W !! W:'PRTSUM !,"This report is designed for a 176 column format (landscape).",!
 S MMRSVAR("STRTDT")="",MMRSVAR("ENDDT")="",MMRSVAR("MMRSLOC(")=""
 S MMRSVAR("PRTSUM")="",MMRSVAR("BYADM")="",MMRSVAR("MMRSDIV")=""
 D EN^XUTMDEVQ("MAIN2^MMRSIPC","PRINT MRSA IPEC REPORT",.MMRSVAR,"QM",1)
 W:$D(ZTSK) !,"Report Queued to Print ("_ZTSK_").",!
 Q
GETPARAM ;(MDRO) ; Loads lab search/extract parameters from file 104.1
 N MRSAMDRO,TSTNM,TST,MDRO,TEST,IEN,TIEN,ITOP,TOP,ETOP,IBACT,BACT,EBACT
 N ETIOL,ETIOLOGY,ANTI,ANTIM,INC,MRSASTAP,ETIONAME,MMRSI,MMRSET,ORG
 S MRSAMDRO=$O(^MMRS(104.2,"B","MRSA",0))
 S INC=0
 S TSTNM="MRSA SURVL NARES DN"
 F  S TSTNM=$O(^LAB(60,"B",TSTNM)) Q:TSTNM=""!(TSTNM]"MRSA SURVL NARES DNA~zzz")  D
 .I TSTNM'["MRSA SURVL NARES DNA" Q
 .S TST=0 F  S TST=$O(^LAB(60,"B",TSTNM,TST)) Q:'TST  D
 ..S INC=INC+1
 ..S ^TMP($J,"MMRSIPC","T","MRSA_SCREEN",TST_"_"_INC,0)="2^POS"
 ..S ^TMP($J,"MMRSIPC","T",MRSAMDRO,TST_"_"_INC,0)="2^POS"
 S TSTNM="MRSA SURVL NARES AGA"
 F  S TSTNM=$O(^LAB(60,"B",TSTNM)) Q:TSTNM=""!(TSTNM]"MRSA SURVL NARES AGAR~zzz")  D
 .I TSTNM'["MRSA SURVL NARES AGAR" Q
 .S TST=0 F  S TST=$O(^LAB(60,"B",TSTNM,TST)) Q:'TST  D
 ..S INC=INC+1
 ..S ^TMP($J,"MMRSIPC","T","MRSA_SCREEN",TST_"_"_INC,0)="2^POS"
 ..S ^TMP($J,"MMRSIPC","T",MRSAMDRO,TST_"_"_INC,0)="2^POS"
 S TSTNM="MRSA SURVL OTHER DN"
 F  S TSTNM=$O(^LAB(60,"B",TSTNM)) Q:TSTNM=""!(TSTNM]"MRSA SURVL OTHER DNA~zzz")  D
 .I TSTNM'["MRSA SURVL OTHER DNA" Q
 .S TST=0 F  S TST=$O(^LAB(60,"B",TSTNM,TST)) Q:'TST  D
 ..S INC=INC+1
 ..S ^TMP($J,"MMRSIPC","T","MRSA_SURV",TST_"_"_INC,0)="2^POS"
 ..S ^TMP($J,"MMRSIPC","T",MRSAMDRO,TST_"_"_INC,0)="2^POS"
 S TSTNM="MRSA SURVL OTHER AGA"
 F  S TSTNM=$O(^LAB(60,"B",TSTNM)) Q:TSTNM=""!(TSTNM]"MRSA SURVL OTHER AGAR~zzz")  D
 .I TSTNM'["MRSA SURVL OTHER AGAR" Q
 .S TST=0 F  S TST=$O(^LAB(60,"B",TSTNM,TST)) Q:'TST  D
 ..S INC=INC+1
 ..S ^TMP($J,"MMRSIPC","T","MRSA_SURV",TST_"_"_INC,0)="2^POS"
 ..S ^TMP($J,"MMRSIPC","T",MRSAMDRO,TST_"_"_INC,0)="2^POS"
 S IEN="" F  S IEN=$O(^MMRS(104.1,"D",MMRSDIV,IEN)) Q:'IEN  D
 .S MDRO=$P($G(^MMRS(104.1,IEN,0)),U,1)
 .Q:'MDRO
 .S TIEN=0 F  S TIEN=$O(^MMRS(104.1,IEN,3,TIEN)) Q:'TIEN  D
 ..S TEST=$P($G(^MMRS(104.1,IEN,3,TIEN,0)),U,1)
 ..Q:'TEST
 ..S INC=INC+1
 ..S ^TMP($J,"MMRSIPC","T",MDRO,TEST_"_"_INC,0)=$P($G(^MMRS(104.1,IEN,3,TIEN,0)),U,2,3)
 .;S ITOP=0 F  S ITOP=$O(^MMRS(104.1,IEN,1,ITOP)) Q:'ITOP  D
 .;.S TOP=$G(^MMRS(104.1,IEN,1,ITOP,0))
 .;.I TOP S ^TMP($J,"MMRSIPC","TOP",MDRO,"INC_TOP",TOP)=""
 .;S ETOP=0 F  S ETOP=$O(^MMRS(104.1,IEN,2,ETOP)) Q:'ETOP  D
 .;.S TOP=$G(^MMRS(104.1,IEN,2,ETOP,0))
 .;.I TOP S ^TMP($J,"MMRSIPC","TOP",MDRO,"EXC_TOP",TOP)=""
 .S IBACT=0 F  S IBACT=$O(^MMRS(104.1,IEN,4,IBACT)) Q:'IBACT  D
 ..S BACT=$G(^MMRS(104.1,IEN,4,IBACT,0))
 ..I BACT'="" S ^TMP($J,"MMRSIPC","BACT",MDRO,"INC_REMARK",IBACT)=BACT
 .S EBACT=0 F  S EBACT=$O(^MMRS(104.1,IEN,5,EBACT)) Q:'EBACT  D
 ..S BACT=$G(^MMRS(104.1,IEN,5,EBACT,0))
 ..I BACT'="" S ^TMP($J,"MMRSIPC","BACT",MDRO,"EXC_REMARK",EBACT)=BACT
 .S ETIOL=0 F  S ETIOL=$O(^MMRS(104.1,IEN,6,ETIOL)) Q:'ETIOL  D
 ..S ETIOLOGY=$G(^MMRS(104.1,IEN,6,ETIOL,0))
 ..Q:'ETIOLOGY
 ..S ^TMP($J,"MMRSIPC","ETIOL",MDRO,+ETIOLOGY)=""
 ..S ANTI=0 F  S ANTI=$O(^MMRS(104.1,IEN,6,ETIOL,1,ANTI)) Q:'ANTI  D
 ...S ANTIM=$P($G(^MMRS(104.1,IEN,6,ETIOL,1,ANTI,0)),U)
 ...I ANTIM S ^TMP($J,"MMRSIPC","ETIOL",MDRO,ETIOLOGY,ANTIM)=$P($G(^MMRS(104.1,IEN,6,ETIOL,1,ANTI,0)),U,2,3)
 D FIND^DIC(61.2,,".01E;@","PM","STAPHYLOCOCCUS AUREUS METHICILLIN RESISTANT",,"B",,,"MMRSET")
 S MMRSI="" F  S MMRSI=$O(MMRSET("DILIST",MMRSI)) Q:MMRSI=""  I +MMRSI>0  D
 .S ETIONAME=$P($G(MMRSET("DILIST",MMRSI,0)),U,2)
 .S ORG=$P($G(MMRSET("DILIST",MMRSI,0)),U,1)
 .I ETIONAME'["STAPHYLOCOCCUS AUREUS METHICILLIN RESISTANT" Q
 .K ^TMP($J,"MMRSIPC","ETIOL",MRSAMDRO,ORG)
 .S ^TMP($J,"MMRSIPC","ETIOL","MRSA_CULTURE",ORG)=""
 .S ^TMP($J,"MMRSIPC","ETIOL",MRSAMDRO,ORG)=""
 Q
PATDAYS ;Gets 'PATIENT DAYS OF CARE'.
 N TTLRSLT,SDT,EDT,LOC,RSLT,WLOC,WARD,PATDAYS,LOCNAME
 S TTLRSLT=0
 S SDT=$P(STRTDT,".")
 S EDT=$P(ENDDT,".")
 S LOC=0 F  S LOC=$O(MMRSLOC(LOC)) Q:'LOC  D
 .S RSLT=0
 .S WLOC=0 F  S WLOC=$O(^MMRS(104.3,LOC,1,WLOC)) Q:'WLOC  D
 ..S WARD=$P($G(^MMRS(104.3,LOC,1,WLOC,0)),U,1) I 'WARD Q
 ..S PATDAYS=$$GETPATDY(WARD,SDT,EDT)
 ..S RSLT=RSLT+PATDAYS,TTLRSLT=TTLRSLT+PATDAYS
 ..S LOCNAME=$P($G(^MMRS(104.3,LOC,0)),U)
 ..S $P(^TMP($J,"MMRSIPC","DSUM",LOCNAME),U,1)=RSLT
 S $P(^TMP($J,"MMRSIPC","DSUM"),U,1)=TTLRSLT
 Q
GETPATDY(WARD,SDT,EDT) ;Helper function for PATDAYS() - Gets Patient Days of care for specific ward
 N CENSUS,SCUMPD,ECUMPD
 I SDT>EDT Q 0
 I SDT<($$FY(EDT)_"1001") Q ($$GETPATDY(WARD,SDT,($$FY(EDT)_"0930"))+$$GETPATDY(WARD,($$FY(EDT)_"1001"),EDT))
 S CENSUS=$O(^DG(41.9,"B",WARD,0)) I 'CENSUS Q 0
 S SDT=$$FMADD^XLFDT(SDT,-1,0,0,0)
 S SCUMPD=$P($G(^DG(41.9,CENSUS,"C",SDT,0)),U,3)
 I EDT=$$DT^XLFDT S EDT=$$FMADD^XLFDT(EDT,-1,0,0,0)
 S ECUMPD=$P($G(^DG(41.9,CENSUS,"C",EDT,0)),U,3)
 I $E(SDT,4,7)="0930" S SCUMPD=0 ; IF LAST DAY OF FY
 Q ECUMPD-SCUMPD
FY(DATE) ;Helper function for GETPATDY - Gets fiscal year for the specified date
 I $E(DATE,4,7)>("1000"),$E(DATE,4,7)<("1232") Q $E(DATE,1,3)
 Q ($E(DATE,1,3)-1)
