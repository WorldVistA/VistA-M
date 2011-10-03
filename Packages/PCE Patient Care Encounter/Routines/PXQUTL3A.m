PXQUTL3A ;ISL/JVS CLEAN OUT BAD XREF #2 ;4/16/97  14:30
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**29**;Aug 12, 1996
 ;
 ;
 Q
 ;
V ;--------------VISIT FILE---------------------------------
 W !!,"Checking the VISIT FILE #9000010 (VISITS)",!
 S VSTCNT=0
 I Y="^" Q
 D Q
 Q
AA ;-----------------AA-LEVEL 3------------------------------
 S VSTXCNT=0,XREF="^AUPNVSIT('AA',"
 W !!,"Checking the ^AUPNVSIT(""AA"") X-REF",!
 S I="" F  S I=$O(^AUPNVSIT("AA",I)) Q:I=""  D  G:Y="^" EXIT
 . S IEN="" F  S IEN=$O(^AUPNVSIT("AA",I,IEN)) Q:IEN=""  D
 ..S IENN="" F  S IENN=$O(^AUPNVSIT("AA",I,IEN,IENN)) W:IENN#1000=22 "." Q:IENN=""  D
 ...S ARRAY="^AUPNVSIT(""AA"",I,IEN,IENN)" S VSTCNT=VSTCNT+1,VSTXCNT=VSTXCNT+1 I VSTCNT#1000=2 D MON^PXQUTL3
 ...I '$D(^AUPNVSIT(IENN)) W !,"Entry "_IENN," IS NOT THERE! BAD REFERENCE IS ^AUPNVPOV(""AA"","_I_",",IEN_","_IENN_")" D @$S(AUTO="F":"KILL",AUTO'="F":"TT",1:"")
 ;
 Q
AD ;-----------------AD-LEVEL 2------------------------------
 S VSTXCNT=0,XREF="^AUPNVSIT('AD',"
 W !!,"Checking the ^AUPNVSIT(""AD"") X-REF",!
 S I="" F  S I=$O(^AUPNVSIT("AD",I)) Q:I=""  D  G:Y="^" EXIT
 . S IEN="" F  S IEN=$O(^AUPNVSIT("AD",I,IEN)) W:IEN#1000=22 "." Q:IEN=""  D
 ..S ARRAY="^AUPNVSIT(""AD"",I,IEN)" S VSTCNT=VSTCNT+1,VSTXCNT=VSTXCNT+1 I VSTCNT#1000=2 D MON^PXQUTL3
 ..I '$D(^AUPNVSIT(IEN)) W !,"Entry "_IEN," IS NOT THERE! BAD REFERENCE IS ^AUPNVSIT(""AD"","_I_",",IEN_")" D @$S(AUTO="F":"KILL",AUTO'="F":"TT",1:"")
 ;
 Q
ADEL ;-----------------ADEL-LEVEL 2------------------------------
 S VSTXCNT=0,XREF="^AUPNVSIT('ADEL',"
 W !!,"Checking the ^AUPNVSIT(""ADEL"") X-REF",!
 S I="" F  S I=$O(^AUPNVSIT("ADEL",I)) Q:I=""  D  G:Y="^" EXIT
 . S IEN="" F  S IEN=$O(^AUPNVSIT("ADEL",I,IEN)) W:IEN#1000=22 "." Q:IEN=""  D
 ..S ARRAY="^AUPNVSIT(""ADEL"",I,IEN)" S VSTCNT=VSTCNT+1,VSTXCNT=VSTXCNT+1 I VSTCNT#1000=2 D MON^PXQUTL3
 ..I '$D(^AUPNVSIT(IEN)) W !,"Entry "_IEN," IS NOT THERE! BAD REFERENCE IS ^AUPNVSIT(""ADEL"","_I_",",IEN_")" D @$S(AUTO="F":"KILL",AUTO'="F":"TT",1:"")
 ;
 Q
AET ;-----------------AET-LEVEL 5------------------------------
 S VSTXCNT=0,XREF="^AUPNVSIT('AET',"
 W !!,"Checking the ^AUPNVSIT(""AET"") X-REF",!
 S I="" F  S I=$O(^AUPNVSIT("AET",I)) Q:I=""  D  G:Y="^" EXIT
 . S IEN="" F  S IEN=$O(^AUPNVSIT("AET",I,IEN)) Q:IEN=""  D
 ..S IENN="" F  S IENN=$O(^AUPNVSIT("AET",I,IEN,IENN)) Q:IENN=""  D
 ...S IENNN="" F  S IENNN=$O(^AUPNVSIT("AET",I,IEN,IENN,IENNN)) Q:IENNN=""  D
 ....S IENNNN="" F  S IENNNN=$O(^AUPNVSIT("AET",I,IEN,IENN,IENNN,IENNNN)) W:IENNNN#1000=22 "." Q:IENNNN=""  D
 .....S ARRAY="^AUPNVSIT(""AET"",I,IEN,IENN,IENNN,IENNNN)" S VSTCNT=VSTCNT+1,VSTXCNT=VSTXCNT+1 I VSTCNT#1000=2 D MON^PXQUTL3
 .....I '$D(^AUPNVSIT(IENNNN)) W !,"Entry "_IENNNN," IS NOT THERE! BAD REFERENCE IS ^AUPNVSIT(""AET"","_I_",",IEN_","_IENN_","_IENNN_","_IENNNN_")" D @$S(AUTO="F":"KILL",AUTO'="F":"TT",1:"")
 ;
 Q
AHL ;-----------------AHL-LEVEL 3------------------------------
 S VSTXCNT=0,XREF="^AUPNVSIT('AHL',"
 W !!,"Checking the ^AUPNVSIT(""AHL"") X-REF",!
 S I="" F  S I=$O(^AUPNVSIT("AHL",I)) Q:I=""  D  G:Y="^" EXIT
 . S IEN="" F  S IEN=$O(^AUPNVSIT("AHL",I,IEN)) Q:IEN=""  D
 ..S IENN="" F  S IENN=$O(^AUPNVSIT("AHL",I,IEN,IENN)) W:IENN#1000=22 "." Q:IENN=""  D
 ...S ARRAY="^AUPNVSIT(""AHL"",I,IEN,IENN)" S VSTCNT=VSTCNT+1,VSTXCNT=VSTXCNT+1 I VSTCNT#1000=2 D MON^PXQUTL3
 ...I '$D(^AUPNVSIT(IENN)) W !,"Entry "_IENN," IS NOT THERE! BAD REFERENCE IS ^AUPNVPOV(""AHL"","_I_",",IEN_","_IENN_")" D @$S(AUTO="F":"KILL",AUTO'="F":"TT",1:"")
 ;
 Q
B ;-----------------B-LEVEL 2------------------------------
 S VSTXCNT=0,XREF="^AUPNVSIT('B',"
 W !!,"Checking the ^AUPNVSIT(""B"") X-REF",!
 S I="" F  S I=$O(^AUPNVSIT("B",I)) Q:I=""  D  G:Y="^" EXIT
 . S IEN="" F  S IEN=$O(^AUPNVSIT("B",I,IEN)) W:IEN#1000=22 "." Q:IEN=""  D
 ..S ARRAY="^AUPNVSIT(""B"",I,IEN)" S VSTCNT=VSTCNT+1,VSTXCNT=VSTXCNT+1 I VSTCNT#1000=2 D MON^PXQUTL3
 ..I '$D(^AUPNVSIT(IEN)) W !,"Entry "_IEN," IS NOT THERE! BAD REFERENCE IS ^AUPNVSIT(""B"","_I_",",IEN_")" D @$S(AUTO="F":"KILL",AUTO'="F":"TT",1:"")
 ;
 Q
C ;-----------------C-LEVEL 2------------------------------
 S VSTXCNT=0,XREF="^AUPNVSIT('C',"
 W !!,"Checking the ^AUPNVSIT(""C"") X-REF",!
 S I="" F  S I=$O(^AUPNVSIT("C",I)) Q:I=""  D  G:Y="^" EXIT
 . S IEN="" F  S IEN=$O(^AUPNVSIT("C",I,IEN)) W:IEN#1000=22 "." Q:IEN=""  D
 ..S ARRAY="^AUPNVSIT(""C"",I,IEN)" S VSTCNT=VSTCNT+1,VSTXCNT=VSTXCNT+1 I VSTCNT#1000=2 D MON^PXQUTL3
 ..I '$D(^AUPNVSIT(IEN)) W !,"Entry "_IEN," IS NOT THERE! BAD REFERENCE IS ^AUPNVSIT(""C"","_I_",",IEN_")" D @$S(AUTO="F":"KILL",AUTO'="F":"TT",1:"")
 ;
 Q
VID ;-----------------VID-LEVEL 2------------------------------
 S VSTXCNT=0,XREF="^AUPNVSIT('VID',"
 W !!,"Checking the ^AUPNVSIT(""VID"") X-REF",!
 S I="" F  S I=$O(^AUPNVSIT("VID",I)) Q:I=""  D  G:Y="^" EXIT
 . S IEN="" F  S IEN=$O(^AUPNVSIT("VID",I,IEN)) W:IEN#1000=22 "." Q:IEN=""  D
 ..S ARRAY="^AUPNVSIT(""VID"",I,IEN)" S VSTCNT=VSTCNT+1,VSTXCNT=VSTXCNT+1 I VSTCNT#1000=2 D MON^PXQUTL3
 ..I '$D(^AUPNVSIT(IEN)) W !,"Entry "_IEN," IS NOT THERE! BAD REFERENCE IS ^AUPNVSIT(""VID"","_I_",",IEN_")" D @$S(AUTO="F":"KILL",AUTO'="F":"TT",1:"")
 ;
 Q
AAH ;-----------------AAH-LEVEL 3------------------------------
 S VSTXCNT=0,XREF="^AUPNVSIT('AAH',"
 W !!,"Checking the ^AUPNVSIT(""AAH"") X-REF",!
 S I="" F  S I=$O(^AUPNVSIT("AAH",I)) Q:I=""  D  G:Y="^" EXIT
 . S IEN="" F  S IEN=$O(^AUPNVSIT("AAH",I,IEN)) Q:IEN=""  D
 ..S IENN="" F  S IENN=$O(^AUPNVSIT("AAH",I,IEN,IENN)) W:IENN#1000=22 "." Q:IENN=""  D
 ...S ARRAY="^AUPNVSIT(""AAH"",I,IEN,IENN)" S VSTCNT=VSTCNT+1,VSTXCNT=VSTXCNT+1 I VSTCNT#1000=2 D MON^PXQUTL3
 ...I '$D(^AUPNVSIT(IENN)) W !,"Entry "_IENN," IS NOT THERE! BAD REFERENCE IS ^AUPNVPOV(""AAH"","_I_",",IEN_","_IENN_")" D @$S(AUTO="F":"KILL",AUTO'="F":"TT",1:"")
 Q
 ;
 ;-------------------------------------------------------
S ;++--SCREEN FOR POSSIBLE BROKEN X REFERENCES
 ;--V PROVIDER FILE
 S (VSTCNT,CPTCNT,PRVCNT,POVCNT)=0
 W !!,"Screening the V provider file",!
 S I="" F  S I=$O(^AUPNVPRV("B",I)) Q:I=""  D  G:Y="^" EXIT
 . S IEN="" F  S IEN=$O(^AUPNVPRV("B",I,IEN)) W:IEN#10000=22 "." Q:IEN=""  D
 ..S ARRAY="^AUPNVPRV(""B"",I,IEN)" S PRVCNT=PRVCNT+1 I PRVCNT#1000=2 D MON^PXQUTL3
 ..I '$D(^AUPNVPRV(IEN)) W !,"Entry "_IEN," IS NOT THERE! BAD REFERENCE IS ^AUPNVPRV(""B"","_I_",",IEN_")"
 ;
 ;--V POV FILE (DIAGNOSIS)
 W !!,"Screening the V POV file (IDAGNOSIS)",!
 S I="" F  S I=$O(^AUPNVPOV("B",I)) Q:I=""  D  G:Y="^" EXIT
 . S IEN="" F  S IEN=$O(^AUPNVPOV("B",I,IEN)) W:IEN#10000=22 "." Q:IEN=""  D
 ..S ARRAY="^AUPNVPOV(""B"",I,IEN)" S POVCNT=POVCNT+1 I POVCNT#1000=2 D MON^PXQUTL3
 ..I '$D(^AUPNVPOV(IEN)) W !,"Entry "_IEN," IS NOT THERE! BAD REFERENCE IS ^AUPNVPOV(""B"","_I_",",IEN_")"
 ;--V CPT FILE (PROCEDURES)
 W !!,"Screening the V CPT file (PROCEDURES)",!
 S I="" F  S I=$O(^AUPNVCPT("B",I)) Q:I=""  D  G:Y="^" EXIT
 . S IEN="" F  S IEN=$O(^AUPNVCPT("B",I,IEN)) W:IEN#10000=22 "." Q:IEN=""  D
 ..S ARRAY="^AUPNVCPT(""B"",I,IEN)" S CPTCNT=CPTCNT+1 I CPTCNT#1000=2 D MON^PXQUTL3
 ..I '$D(^AUPNVCPT(IEN)) W !,"Entry "_IEN," IS NOT THERE! BAD REFERENCE IS ^AUPNVCPT(""B"","_I_",",IEN_")"
 ;--VISIT FILE
 W !!,"Screening the VISIT file",!
 S I="" F  S I=$O(^AUPNVSIT("B",I)) Q:I=""  D  G:Y="^" EXIT
 . S IEN="" F  S IEN=$O(^AUPNVSIT("B",I,IEN)) W:IEN#10000=22 "." Q:IEN=""  D
 ..S ARRAY="^AUPNVSIT(""B"",I,IEN)" S VSTCNT=VSTCNT+1 I VSTCNT#1000=2 D MON^PXQUTL3
 ..I '$D(^AUPNVSIT(IEN)) W !,"Entry "_IEN," IS NOT THERE! BAD REFERENCE IS ^AUPNVSIT(""B"","_I_",",IEN_")"
 Q
 ;
TT ;--QUERY FOR CORRECT ENTRY
 S DIR("A")="Should I fix this one by removing the reference ??"
 S DIR("B")="NO"
 S DIR(0)="YAO" D ^DIR
 I Y=1 D
 .K @ARRAY
 I Y="^" Q
 K DIR
 Q
KILL ;--AUTOMATIC
 ;W !,"KILL "_ARRAY
 K @ARRAY
 Q
EXIT K DIR,DA,DIK
 Q
Q ;---PROMPT FOR WHICH X-REF
 I AUTO="F",AUTOO="F" D AA,AAH,AD,ADEL,AET,AHL,B,C,VID Q
 S DIR(0)="SOM^AA:AA X-REF;AAH:AAH X-REF;AD:AD X-REF;ADEL:ADEL X-REF;AET:AET X-REF;AHL:AHL X-REF;B:B X-REF;C:C X-REF;VID:VID X-REF;ALL:ALL X-REFERENCES"
 S DIR("A")="Select a VISIT Cross-reference: "
 S DIR("B")="B"
 D ^DIR
 I Y="AA" D AA G Q
 I Y="AAH" D AAH G Q
 I Y="AD" D AD G Q
 I Y="ADEL" D ADEL G Q
 I Y="AET" D AET G Q
 I Y="AHL" D AHL G Q
 I Y="B" D B G Q
 I Y="C" D C G Q
 I Y="VID" D VID G Q
 I Y="ALL" D 
 .D AA I Y="^" Q
 .D AAH I Y="^" Q
 .D AD I Y="^" Q
 .D ADEL I Y="^" Q
 .D AET I Y="^" Q
 .D AHL I Y="^" Q
 .D B I Y="^" Q
 .D C I Y="^" Q
 .D VID Q
 K DIR
 Q
