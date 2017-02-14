MMRSCRE ;TCK - Print CRE Acute Care IPEC Report ; 12/6/16 11:24am
 ;;1.0;MDRO PROGRAM TOOLS;**4**;June 01, 2016;Build 130
 ;
 ;This is the main routine to print the CRE Acute Care IPEC Report.
 ;This routine uses functions contained in MMRSCRE2, MMRSCRE3, and MMRSCRE4.
MAIN ;
 N NUMDIV,MMRSDIV,MMRSLOC,EXTFLG,STRTDT,ENDDT,PRTSUM,BYADM
 D CLEAN
 D CHECK2
 I $D(EXTFLG) W ! H 2 Q
 W !
 D CHECK3
 I $D(EXTFLG) W ! H 2 Q
 D PROMPT
 I $D(EXTFLG) D CLEAN K MMRSSUM,DIVARY,DVSN,MDIV Q
 D ASKDVC Q:$D(EXTFLG)
 D CLEAN
 K MMRSSUM,DIVARY,DVSN,MDIV
 Q
CHKPAR(ORG,Y,CHK) ;
 N I,TST,ETI
 I '$D(^MMRS(104.1,"C",+Y,ORG)) S CHK=0 Q
 S I="",I=$O(^MMRS(104.1,"C",+Y,ORG,I))
 S LIEN=1_","_I_","
 S TST=$$GET1^DIQ(104.15,LIEN,.01,"I")
 I $G(TST)>0 Q
 S ETI=$$GET1^DIQ(104.109,LIEN,.01,"I")
 I $G(ETI)>0 Q
 S CHK=0
 Q
 ;
CHECK(L) ;Check if parameters are setup
 Q:$G(L)'>0
 N DVSN
 S (SPCM,NUMDIV)=0
 S MMRSDIV=0 F  S MMRSDIV=$O(^MMRS(104,MMRSDIV)) Q:'MMRSDIV  D  Q:NUMDIV
 .I $D(^MMRS(104,MMRSDIV,0)) S NUMDIV=NUMDIV+1 Q
 I NUMDIV D
 .Q:'$D(^MMRS(104,"B",L))
 .S DVSN="",DVSN=$O(^MMRS(104,"B",L,DVSN))
 .Q:$G(DVSN)'>0
 .Q:'$D(^MMRS(104,DVSN,61))
 .Q:'$P(^MMRS(104,DVSN,61,0),"^",3)
 .S SPCM=1
 I 'NUMDIV!('SPCM) D
 .W !!,"   >>>Make sure a division and/or a Surveillance specimen has been "
 .W !,"         setup using the option: 'CRE Tools Site Parameter Setup'"
 .S EXTFLG=1
 Q
CHECK2 ;Check if lab tests and etiologies are setup
 N TST,MRSASTAP,MMRSET,MMRSI
 S (MDROETIO,TSTSTP)=0
 I $D(^MMRS(104.1)) D
 .S II=0 F  S II=$O(^MMRS(104.1,II)) Q:II'>0  D  Q:MDROETIO!(TSTSTP)
 ..Q:'$D(^MMRS(104.1,II,0))
 ..S ORGP=$P(^MMRS(104.1,II,0),"^")
 ..Q:$G(ORGP)'>0
 ..S ETIO=$$GET1^DIQ(104.2,ORGP,.01,"E")
 ..S ETIO=$$UPPER^DGUTL(ETIO)
 ..Q:ETIO'["CRB"
 ..S IX=0
 ..F  S IX=$O(^MMRS(104.1,II,3,IX)) Q:IX'>0  D  Q:TSTSTP
 ...I $G(IX)>0 D
 ....Q:'$D(^MMRS(104.1,II,3,IX,0))
 ....S III=IX_","_II_","
 ....Q:III=""
 ....S TST=$$GET1^DIQ(104.15,III,.01,"E")
 ....S TSTSTP=1
 ..I $D(^MMRS(104.1,II,6)) D
 ...S IXI=0 F  S IXI=$O(^MMRS(104.1,II,6,IXI)) Q:IXI'>0  D  Q:MDROETIO
 ....Q:IXI=""
 ....Q:'IXI
 ....S III=IXI_","_II_","
 ....S XX=$$GET1^DIQ(104.109,III,.01,"E")
 ....Q:XX=""
 ....S ETIONAME=XX,ORG=II,MDROETIO=ORG
ERROR ;
 I 'TSTSTP&'MDROETIO D
 .S EXTFLG=1
 .W !!,"    >>>The report cannot be run because the Etiology has not been "
 .W !,"        configured in the MDRO TOOLS LAB SEARCH/EXTRACT file, "
 .W !,"        (#104.1).  Use the MDRO Tools Lab Parameter Setup "
 .W !,"        option to configure."
 Q
 ;
CHECK3 ;Check if Ward Mappings have been setup for this division
 N NUMLOC,MMRSLOC,MMRSDIV
 S NUMLOC=0
 S MMRSDIV=0 F  S MMRSDIV=$O(^MMRS(104.3,MMRSDIV)) Q:'MMRSDIV  D
 .I $G(MMRSDIV) S NUMLOC=NUMLOC+1
 I NUMLOC=0 W !!,"   >>> Make sure the Ward Mappings for each Geographical Unit has been setup.",!! S EXTFLG=1
 Q
 ;
MAIN2 ; Entry for queuing
 ;D CLEAN ;Kill Temp Global
 D GETPARAM ; Load parameters in temp global
 D CLEAN ;Kill Temp Global
 Q
CLEAN ;
 K DFN,INDT,LIENS,LIEN,IN,ADMTDT,COLDT,LRIDT
 K ^TMP($J,"MMRSCRE"),TOTAL,DATA,DATA1,DIVARY,MDIV,DVSN
 K ^TMP($J,"MMRSCREPD"),TMPDATA
 Q
 ;
GETDIV() ;Prompt user to select Division
 N MMRSDIV,COUNT,DIV,DIC,Y,DLAYGO,X,DTOUT,DUOUT
 S MMRSDIV=""
 S COUNT=0,DIV=0 F  S DIV=$O(^MMRS(104,DIV)) Q:'DIV  S COUNT=COUNT+1
 I COUNT=1 S MMRSDIV=$O(^MMRS(104,0)) Q MMRSDIV
 S DIC="^DG(40.8,"
 S DIC(0)="AEMQ"
 S DIC("A")="Select the Division/Station: "
 S DIC("S")="I $D(^MMRS(104,""B"",Y))"
 D ^DIC K DIC
 I $D(DTOUT)!($D(DUOUT))!(Y=-1) S EXTFLG=1 Q ""
 S MMRSDIV=+Y
 S MMRSDIV=$O(^MMRS(104,"B",MMRSDIV,0))
 Q MMRSDIV
 ;
PROMPT ;Prompts user for start date, end date, locations, and if user wants to only print the Summary Report.
 S BYADM=1,PRMPTTXT="facility admission"
 ;
LOC ;Prompts user for division
 N STID,STNM,SIEN
 S (STP,ALL)=0
 W !
 S DIR(0)="YA",DIR("A")="Do you want to select all divisions: ",DIR("B")="NO"
 D ^DIR K DIR
 I $D(DIRUT) S EXTFLG=1 Q
 I Y=1 S ALL=1 D  Q:'CHK
 .S CHK=1
 .S DIV=0 F  S DIV=$O(^MMRS(104,DIV)) Q:DIV'>0  D  Q:STP!('CHK)
 ..S WR=$$GET1^DIQ(40.8,DIV,.01,"I")
 ..D CHKPAR(ORGP,DIV,.CHK)
 ..I 'CHK S (MDROETIO,TSTSTP)=0 D ERROR  Q
 ..S FID=$$GET1^DIQ(40.8,DIV,1,"E"),STID=$$GET1^DIQ(40.8,DIV,.01,"E")
 ..S MMRSLOC(FID)=STID,DIVARY(STID)=+DIV
 ..D CHECK(DIV)
 ..I $G(NUMDIV)'>0 S STP=1 Q
 ..I $G(SPCM)'>0 S STP=1 Q
 Q:STP
 ;PROMPT FOR WARDS
 I 'Y D  Q:'CHK
 .S CHK=1
 .N DIC,DLAYGO,DTOUT,DUOUT
 .W !
 .S DIC("A")="Select Division: "
 .S DIC="^MMRS(104,",DIC(0)="QEAM" D ^DIC
 .I (Y=-1)!($D(DTOUT))!($D(DUOUT)) S EXTFLG=1 Q
 .D CHKPAR(ORGP,Y,.CHK)
 .I 'CHK S (MDROETIO,TSTSTP)=0 D ERROR  Q
 .S DPT=$P(Y,"^",2)
 .S STID=$$GET1^DIQ(40.8,DPT,.01,"E"),FID=$$GET1^DIQ(40.8,DPT,1,"E")
 .S WR=+Y
 .S MMRSLOC(FID)=STID,DIVARY(STID)=+Y
 .I $G(Y)>0 D CHECK(WR)
 .;S NUMDIV=1
 .Q:$G(NUMDIV)'>0
 .Q:$G(SPCM)'>0
 .S CHK=1
 .S DIC("A")="Select another Division: " F  D ^DIC Q:Y=-1  D  Q:'CHK
 ..D CHKPAR(ORGP,Y,.CHK)
 ..I 'CHK S (MDROETIO,TSTSTP)=0 D ERROR  Q
 ..S STID=$$GET1^DIQ(104,+Y,.01,"E"),WR=$$GET1^DIQ(104,+Y,.01,"I")
 ..S FID=$$GET1^DIQ(40.8,+Y,1,"E"),MMRSLOC(FID)=STID,DIVARY(STID)=+Y
 ..I $G(Y)>0 D CHECK(WR)
 ..I $G(NUMDIV)'>0 S STP=1 Q
 ..I $G(SPCM)'>0 S STP=1 Q
 ..;K DIC
 .I ($D(DTOUT))!($D(DUOUT)) S EXTFLG=1 Q
 K DIC
 ;I $G(Y)<0 S CHK=0,EXTFLG=1 Q
 Q:$G(NUMDIV)'>0
 Q:$G(SPCM)'>0
 Q:$D(EXTFLG)
 I ($D(DTOUT))!($D(DUOUT)) S EXTFLG=1 Q
 ;
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
 ;
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
 S MMRSVAR("DFLTDT")="",MMRSVAR("TSTSTP")="",MMRSVAR("MDROETIO")=""
 S MMRSVAR("ORG")="",MMRSVAR("DIVARY")="",MMRSVAR("DIVARY(")=""
 D EN^XUTMDEVQ("MAIN2^MMRSCRE","PRINT CRE Acute Care IPEC REPORT",.MMRSVAR,"QM",1)
 W:$D(ZTSK) !,"Report Queued to Print ("_ZTSK_").",!
 Q
GETPARAM ;(MDRO) ; Loads lab search/extract parameters from file 104.1
 N TSTNM,TST,MDRO,TEST,IEN,TIEN,ITOP,TOP,ETOP,IBACT,BACT,EBACT
 N ETIOL,ETIOLOGY,ANTI,ANTIM,INC,MRSASTAP,ETIONAME,MMRSI,MMRSET
 N MDRO
 S MMRSDIV=0,DIVSN="",LOC=""
 S MMRSMDRO=$O(^MMRS(104.2,"B","CRB-R",0))
 F  S LOC=$O(DIVARY(LOC)) Q:LOC=""  D
 .K ^TMP($J,"MMRSCRE","T")
 .K ^TMP($J,"MMRSCRE","ETIOL")
 .S Y=DIVARY(LOC)
 .S IEN="",IEN=$O(^MMRS(104.1,"C",+Y,MMRSMDRO,IEN))
 .Q:$G(IEN)'>0
 .;S MDROETIO=IEN
 .S MDRO=MMRSMDRO
 .S (FND,SUB,INC)=0
 .I $G(TSTSTP)'>0 S TSTSTP=1
 .I TSTSTP D
 ..S TIEN=0 F  S TIEN=$O(^MMRS(104.1,IEN,3,TIEN)) Q:'TIEN  D
 ...S LRIEN=TIEN_","_MDRO_","
 ...S TEST=$$GET1^DIQ(104.15,LRIEN,.01,"I")
 ...Q:'TEST
 ...S INC=INC+1
 ...S ^TMP($J,"MMRSCRE","T",MDRO,TEST_"_"_INC,0)=$P($G(^MMRS(104.1,MDRO,3,TIEN,0)),U,2,3)
 .I MDROETIO D
 ..S IBACT=0 F  S IBACT=$O(^MMRS(104.1,MDROETIO,4,IBACT)) Q:'IBACT  D
 ...S BACT=$G(^MMRS(104.1,MDROETIO,4,IBACT,0))
 ...I BACT'="" S ^TMP($J,"MMRSCD","BACT",MDROETIO,"INC_REMARK",IBACT)=BACT
 ..S EBACT=0 F  S EBACT=$O(^MMRS(104.1,MDROETIO,5,EBACT)) Q:'EBACT  D
 ...S BACT=$G(^MMRS(104.1,MDROETIO,5,EBACT,0))
 ..S ETIOL=0 F  S ETIOL=$O(^MMRS(104.1,MDROETIO,6,ETIOL)) Q:'ETIOL  D
 ...S ETIOLOGY=$G(^MMRS(104.1,MDROETIO,6,ETIOL,0))
 ...Q:'ETIOLOGY
 ...S ^TMP($J,"MMRSCRE","ETIOL",MDROETIO,+ETIOLOGY)=""
 .D GETMOVE^MMRSCRE2
 .D GETLABS^MMRSCRE3
 .D PRINT^MMRSCRE4
 Q
 ;
PATDAYS ;Gets 'PATIENT DAYS OF CARE'.
 N TTLRSLT,SDT,EDT,LOC,RSLT,WLOC,WARD,PATDAYS,LOCNAME,RTOT
 S (FND,TTLRSLT,RTOT,TOTAL("PAT"))=0
 S SDT=$P(STRTDT,".")
 S EDT=$P(ENDDT,".")
 Q:'$D(WRDLOC)
 S WARD="" F  S WARD=$O(WRDLOC(WARD)) Q:$G(WARD)'>0  D
 .S RSLT=0
 .S DIV=$$GET1^DIQ(42,WARD,.015,"I"),DIV=$$GET1^DIQ(40.8,DIV,1,"I")
 .;I '$D(MMRSLOC(DIV)) K WRDLOC(WARD) Q
 .S PATDAYS=$$GETPATDY(WARD,SDT,EDT)
 .S RSLT=RSLT+PATDAYS,TTLRSLT=TTLRSLT+PATDAYS
 .S LOCNAME=$$GET1^DIQ(42,WARD,.015,"E")
 .S $P(^TMP($J,"MMRSCREPD","DSUM",LOCNAME),U,1)=RSLT
 S $P(^TMP($J,"MMRSCREPD","DSUM"),U,1)=TTLRSLT
 S TOTAL("PAT")=TTLRSLT
 ;S PATDAYS=""
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
 I ECUMPD<SCUMPD Q 0
 Q ECUMPD-SCUMPD
FY(DATE) ;Helper function for GETPATDY - Gets fiscal year for the specified date
 I $E(DATE,4,7)>("1000"),$E(DATE,4,7)<("1232") Q $E(DATE,1,3)
 Q ($E(DATE,1,3)-1)
