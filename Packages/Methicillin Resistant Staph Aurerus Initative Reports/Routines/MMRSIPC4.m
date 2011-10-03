MMRSIPC4 ;MIA/LMT - Print MRSA Report Cont. (Contains functions to print report) ;10-20-06
 ;;1.0;MRSA PROGRAM TOOLS;**1**;Mar 22, 2009;Build 3
 ;
PRINT ;Prints report data
 N PG,MMRSNOW,NUMLOCS,LOCNAME,LN,PREVLOC,INDATE,DFN,OUTDATE,DATA
 S PG=1
 S MMRSNOW=$$NOW^XLFDT()
 S NUMLOCS=0
 S LOCNAME="" F  S LOCNAME=$O(^TMP($J,"MMRSIPC","D",LOCNAME)) Q:LOCNAME=""  S NUMLOCS=NUMLOCS+1
 I PRTSUM D  Q
 .S LOCNAME="" F  S LOCNAME=$O(^TMP($J,"MMRSIPC","D",LOCNAME)) Q:LOCNAME=""  D
 ..D:BYADM PRTSUMA(LOCNAME) D:'BYADM PRTSUMD(LOCNAME)
 .I NUMLOCS>1 D:BYADM PRTSUMA() D:'BYADM PRTSUMD()
 I BYADM S $P(LN,"-",120)=""
 I 'BYADM S $P(LN,"-",171)=""
 S PREVLOC=""
 S LOCNAME="" F  S LOCNAME=$O(^TMP($J,"MMRSIPC","D",LOCNAME)) Q:LOCNAME=""  D
 .I PREVLOC'="" D:BYADM PRTSUMA(PREVLOC) D:'BYADM PRTSUMD(PREVLOC)
 .S PREVLOC=LOCNAME
 .I BYADM D PRTHDRA
 .I 'BYADM D PRTHDRD
 .S INDATE="" F  S INDATE=$O(^TMP($J,"MMRSIPC","D",LOCNAME,INDATE)) Q:INDATE=""  D
 ..S DFN="" F  S DFN=$O(^TMP($J,"MMRSIPC","D",LOCNAME,INDATE,DFN)) Q:DFN=""  D
 ...S OUTDATE="" F  S OUTDATE=$O(^TMP($J,"MMRSIPC","D",LOCNAME,INDATE,DFN,OUTDATE)) Q:OUTDATE=""  D
 ....S DATA=$G(^TMP($J,"MMRSIPC","D",LOCNAME,INDATE,DFN,OUTDATE))
 ....I BYADM D PRINTADM(DATA)
 ....I 'BYADM D PRINTDIS(DATA)
 I BYADM D PRTSUMA(PREVLOC) I NUMLOCS>1 D PRTSUMA()
 I 'BYADM D PRTSUMD(PREVLOC) I NUMLOCS>1 D PRTSUMD()
 Q
PRINTADM(DATA) ; Print cont.
 N PATIENT,LAST4,INDATEE,INTT,ADT,MOVTYPE,NARES24,NARES48,CULT48,MRSA365,VADM,VAIP,WARD,IND
 D KVA^VADPT
 D DEM^VADPT
 S PATIENT=VADM(1)
 S LAST4=$E($P(VADM(2),U),6,9)
 D KVA^VADPT
 S INDATEE=$$FMTE^XLFDT(INDATE,"2M")
 S INTT=$P(DATA,U,5)
 S ADT=$S(INTT=1:"A",INTT=2:"T",1:"")
 D KVA^VADPT S VAIP("E")=$P(DATA,U,4) D IN5^VADPT
 S MOVTYPE=$E($P(VAIP(4),U,2),1,13)
 S WARD=$E($P(VAIP(5),U,2),1,13)
 D KVA^VADPT
 S NARES24=$P(DATA,U,9)
 S NARES48=$P($P(DATA,U,10),";")
 S CULT48=$P($P(DATA,U,11),";")
 S MRSA365=$P($P(DATA,U,12),";")
 ;MIA/LMT - Add a '*' if patient was indicated for a swab ;3/16/10
 S IND=$P(DATA,U,13)
 ;W !,WARD,?15,$E(PATIENT,1,20),?38,LAST4,?45,INDATEE,?61,ADT,?66,MOVTYPE,?81,NARES24,?90,NARES48,?99,CULT48,?108,MRSA365
 W !,WARD,?15,$S(IND=1:"*",1:" ")_$E(PATIENT,1,20),?38,LAST4,?45,INDATEE,?61,ADT,?66,MOVTYPE,?81,NARES24,?90,NARES48,?99,CULT48,?108,MRSA365
 I $Y+1>IOSL D PRTHDRA
 Q
PRINTDIS(DATA) ; Print cont.
 N PATIENT,LAST4,INDATEE,INTT,ADTA,MOVTYPEA,NARES24A,NARES48A,MRSA365,OUTIFN,OUTDATEE
 N OUTTT,ADTD,MOVTYPED,NARES24D,NARES48D,MRSACPRD,TRANS,VADM,VAIP,WARD,IND
 D KVA^VADPT
 D DEM^VADPT
 S PATIENT=VADM(1)
 S LAST4=$E($P(VADM(2),U),6,9)
 D KVA^VADPT
 S INDATEE=$$FMTE^XLFDT(INDATE,"2M")
 S INTT=$P(DATA,U,5)
 S ADTA=$S(INTT=1:"A",INTT=2:"T",1:"")
 D KVA^VADPT S VAIP("E")=$P(DATA,U,4) D IN5^VADPT
 S MOVTYPEA=$E($P(VAIP(4),U,2),1,13)
 S WARD=$E($P(VAIP(5),U,2),1,6)
 D KVA^VADPT
 S NARES24A=$P(DATA,U,9)
 S NARES48A=$P($P(DATA,U,10),";")
 S MRSA365=$P($P(DATA,U,11),";")
 S (OUTDATEE,OUTTT,ADTD,MOVTYPED,NARES24D,NARES48D)=""
 S OUTIFN=$P(DATA,U,7)
 I OUTIFN D
 .S OUTDATEE=$$FMTE^XLFDT(OUTDATE,"2M")
 .S OUTTT=$P(DATA,U,8)
 .S ADTD=$S(OUTTT=2:"T",OUTTT=3:"D",1:"")
 .D KVA^VADPT S VAIP("E")=OUTIFN D IN5^VADPT S MOVTYPED=$E($P(VAIP(4),U,2),1,13) D KVA^VADPT
 .S NARES24D=$P(DATA,U,12)
 .S NARES48D=$P($P(DATA,U,13),";")
 S MRSACPRD=$P($P(DATA,U,14),";")
 S TRANS=$P(DATA,U,15)
 ;MIA/LMT - Add a '*' if patient was indicated for a swab ;3/16/10
 S IND=$P(DATA,U,16)
 W !,WARD,?8,$S(IND=1:"*",1:" ")_$E(PATIENT,1,20),?31,LAST4,?38,INDATEE,?54,ADTA,?59,MOVTYPEA,?74,NARES24A,?83,NARES48A,?92,MRSA365
 W ?101,OUTDATEE,?117,ADTD,?122,MOVTYPED,?137,NARES24D,?146,NARES48D,?155,MRSACPRD,?165,TRANS
 I $Y+1>IOSL D PRTHDRD
 Q
PRTHDRA ;
 W @IOF
 W ?13,"MRSA IPEC ADMISSION REPORT"
 W !,?13,"Geographical Location: ",LOCNAME
 W !,?13,"Report period: ",$$FMTE^XLFDT(STRTDT)," to ",$$FMTE^XLFDT(ENDDT)
 W !,?13,"Report printed on: ",$$FMTE^XLFDT(MMRSNOW),?70,"PAGE: ",PG
 W !!,?81,"NARES",?90,"NARES",?99,"CULTURE"
 W !,"VISTA",?45,"DATE",?66,"MAS MOVE",?81,"SCREEN",?90,"RESULT",?99,"RESULT",?108,"MRSA IN"
 W !,"WARD",?15,"PATIENT",?38,"SSN",?45,"ENTERED WARD",?61,"ADT",?66,"TYPE",?81,"24H",?90,"48H",?99,"48H",?108,"PAST YEAR"
 W !,LN
 S PG=PG+1
 Q
PRTHDRD ;
 W @IOF
 W ?13,"MRSA IPEC DISCHARGE/TRANSMISSION REPORT"
 W !,?13,"Geographical Location: ",LOCNAME
 W !,?13,"Report period: ",$$FMTE^XLFDT(STRTDT)," to ",$$FMTE^XLFDT(ENDDT)
 W !,?13,"Report printed on: ",$$FMTE^XLFDT(MMRSNOW),?70,"PAGE: ",PG
 W !!,?59,"ADM",?74,"NARES",?83,"NARES",?122,"DIS",?137,"NARES",?146,"NARES",?155,"MRSA"
 W !,"VISTA",?38,"DATE",?54,"ADM",?59,"MAS MOVE",?74,"SCREEN",?83,"RESULT",?92,"MRSA IN"
 W ?101,"DATE",?117,"DIS",?122,"MAS MOVE",?137,"SCREEN",?146,"RESULT",?155,"IN CURR"
 W !,"WARD",?8,"PATIENT",?31,"SSN",?38,"ENTERED WARD",?54,"ADT",?59,"TYPE",?74,"24H",?83,"48H",?92,"PAST YR"
 W ?101,"LEFT WARD",?117,"ADT",?122,"TYPE",?137,"24H",?146,"48H",?155,"PRD",?165,"TRANS"
 W !,LN
 S PG=PG+1
 Q
PRTSUMA(LOC) ;
 N II,L,DATA
 W @IOF
 W ?13,"MRSA IPEC ADMISSION SUMMARY REPORT"
 I $G(LOC)'="" W !,?13,"Geographical Location: ",LOC
 I $G(LOC)="" W !,?13,"Geographical Locations: " D
 .S II=1 S L="" F  S L=$O(^TMP($J,"MMRSIPC","DSUM",L)) Q:L=""  W:II>1&($X>37) ", " W L S II=II+1 I $X>110 W !,?37
 W !,?13,"Report period: ",$$FMTE^XLFDT(STRTDT)," to ",$$FMTE^XLFDT(ENDDT)
 W !,?13,"Report printed on: ",$$FMTE^XLFDT(MMRSNOW),?70,"PAGE: ",PG
 I $G(LOC)'="" S DATA=$G(^TMP($J,"MMRSIPC","DSUM",LOC))
 I $G(LOC)="" S DATA=$G(^TMP($J,"MMRSIPC","DSUM"))
 W !!,"Prevalence Measures (Facility Wide)"
 W !,?3,"1. Number of admissions to the facility: ",$P(DATA,U,1)
 W !,?3,"2. Number of (1) who received MRSA nasal screening upon admission to facility: ",$P(DATA,U,2)
 W !,?3,"3. Number of (1) positive for MRSA based on nasal screening upon admission to facility: ",$P(DATA,U,3)
 W !,?3,"4. Number of those in (1) positive for MRSA based on clinical cultures upon admission to facility: ",$P(DATA,U,4)
 W !!,"Prevalence Measures (Unit Specific)"
 W !,?3,"1. Number of admissions (admissions + transfers in) to the unit for the month: ",$P(DATA,U,5)
 W !,?3,"2. Number of (1) for whom nasal screening was indicated: ",$P(DATA,U,6)
 W !,?3,"3. Number of (2) who received MRSA nasal screening upon admission to unit (within 24 hours): ",$P(DATA,U,7)
 W !,?3,"4. Number of (1) positive for MRSA based on nasal screening upon admission to unit: ",$P(DATA,U,8)
 W !,?3,"5. Number of (1) positive for MRSA based on clinical cultures upon admission to unit: ",$P(DATA,U,9)
 S PG=PG+1
 Q
PRTSUMD(LOC) ;
 N II,L,DATA
 W @IOF
 W ?13,"MRSA IPEC DISCHARGE/TRANSMISSION SUMMARY REPORT"
 I $G(LOC)'="" W !,?13,"Geographical Location: ",LOC
 I $G(LOC)="" W !,?13,"Geographical Locations: " D
 .S II=1 S L="" F  S L=$O(^TMP($J,"MMRSIPC","DSUM",L)) Q:L=""  W:II>1&($X>37) ", " W L S II=II+1 I $X>110 W !,?37
 W !,?13,"Report period: ",$$FMTE^XLFDT(STRTDT)," to ",$$FMTE^XLFDT(ENDDT)
 W !,?13,"Report printed on: ",$$FMTE^XLFDT(MMRSNOW),?70,"PAGE: ",PG
 I $G(LOC)'="" S DATA=$G(^TMP($J,"MMRSIPC","DSUM",LOC))
 I $G(LOC)="" S DATA=$G(^TMP($J,"MMRSIPC","DSUM"))
 W !!,"Transmission Measures (Unit Specific)"
 W !,?3,"10. Number of bed days of care for the unit: ",$P(DATA,U,1)
 W !,?3,"11. Number of exits (discharges + deaths + transfers out) from the unit: ",$P(DATA,U,2)
 W !,?3,"12. Number of (11) from whom a discharge/transfer swab was indicated: ",$P(DATA,U,3)
 W !,?3,"13. Number of (12) who received MRSA nasal screening upon exit from unit: ",$P(DATA,U,4)
 W !,?3,"14. Number of MRSA transmissions on unit based on MRSA nasal screenings or clinical cultures: ",$P(DATA,U,5)
 S PG=PG+1
 Q
