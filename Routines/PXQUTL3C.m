PXQUTL3C ;ISL/JVS CLEAN OUT BAD XREF #4 ;5/7/98  09:53
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**29,51**;Aug 12, 1996
 ;
 ;
 ;
 Q
INDEX ;Reindex's the AA xref on the patient education file
 ;Used as the Post Install for patch PX*1*51
 D BMES^XPDUTL("Rebuilding 'AA' Cross-References on the V PATIENT EDUCATION File.")
 D MES^XPDUTL("This might take a few minutes!")
 N DIK
 S DIK="^AUPNVPED("
 S DIK(1)=".03^AA"
 D ENALL^DIK
 Q
 ;
 ;
T W !!,"Checking the V TREATMENT FILE #9000010.15 ",!
 S TRTCNT=0
 I Y="^" Q
 S I="" F  S I=$O(^AUPNVTRT("B",I)) Q:I=""  D  Q:Y="^"
 . S IEN="" F  S IEN=$O(^AUPNVTRT("B",I,IEN)) W:IEN#1000=22 "." Q:IEN=""  D  Q:Y="^"
 ..S ARRAY="^AUPNVTRT(""B"",I,IEN)" S TRTCNT=TRTCNT+1 I TRTCNT#1000=2 D MON^PXQUTL3B
 ..I '$D(^AUPNVTRT(IEN)) W !,"Entry "_IEN," IS NOT THERE! BAD REFERENCE IS ^AUPNVTRT(""B"","_I_",",IEN_")" D @$S(AUTO="F":"KILL",AUTO'="F":"TT",1:"")
 S I="" F  S I=$O(^AUPNVTRT("AD",I)) Q:I=""  D  Q:Y="^"
 . S IEN="" F  S IEN=$O(^AUPNVTRT("AD",I,IEN)) W:IEN#1000=22 "." Q:IEN=""  D  Q:Y="^"
 ..S ARRAY="^AUPNVTRT(""AD"",I,IEN)" S TRTCNT=TRTCNT+1 I TRTCNT#1000=2 D MON^PXQUTL3B
 ..I '$D(^AUPNVTRT(IEN)) W !,"Entry "_IEN," IS NOT THERE! BAD REFERENCE IS ^AUPNVTRT(""AD"","_I_",",IEN_")" D @$S(AUTO="F":"KILL",AUTO'="F":"TT",1:"")
 S I="" F  S I=$O(^AUPNVTRT("C",I)) Q:I=""  D  Q:Y="^"
 . S IEN="" F  S IEN=$O(^AUPNVTRT("C",I,IEN)) W:IEN#1000=22 "." Q:IEN=""  D  Q:Y="^"
 ..S ARRAY="^AUPNVTRT(""C"",I,IEN)" S TRTCNT=TRTCNT+1 I TRTCNT#1000=2 D MON^PXQUTL3B
 ..I '$D(^AUPNVTRT(IEN)) W !,"Entry "_IEN," IS NOT THERE! BAD REFERENCE IS ^AUPNVTRT(""C"","_I_",",IEN_")" D @$S(AUTO="F":"KILL",AUTO'="F":"TT",1:"")
 S I="" F  S I=$O(^AUPNVTRT("AA",I)) Q:I=""  D  Q:Y="^"
 . S IEN="" F  S IEN=$O(^AUPNVTRT("AA",I,IEN)) Q:IEN=""  D  Q:Y="^"
 ..S IENN="" F  S IENN=$O(^AUPNVTRT("AA",I,IEN,IENN)) Q:IENN=""  D  Q:Y="^"
 ...S ARRAY="^AUPNVTRT(""AA"",I,IEN,IENN)" S TRTCNT=TRTCNT+1 I TRTCNT#1000=2 D MON^PXQUTL3B
 ...I '$D(^AUPNVTRT(IENN)) W !,"Entry "_IENN," IS NOT THERE! BAD REFERENCE IS ^AUPNVTRT(""AA"","_I_",",IEN_","_IENN_")" D @$S(AUTO="F":"KILL",AUTO'="F":"TT",1:"")
 Q
 ;
 ;
P W !!,"Checking the V PATIENT ED FILE #9000010.16 ",!
 S PEDCNT=0
 I Y="^" Q
 S I="" F  S I=$O(^AUPNVPED("B",I)) Q:I=""  D  Q:Y="^"
 . S IEN="" F  S IEN=$O(^AUPNVPED("B",I,IEN)) W:IEN#1000=22 "." Q:IEN=""  D  Q:Y="^"
 ..S ARRAY="^AUPNVPED(""B"",I,IEN)" S PEDCNT=PEDCNT+1 I PEDCNT#1000=2 D MON^PXQUTL3B
 ..I '$D(^AUPNVPED(IEN)) W !,"Entry "_IEN," IS NOT THERE! BAD REFERENCE IS ^AUPNVPED(""B"","_I_",",IEN_")" D @$S(AUTO="F":"KILL",AUTO'="F":"TT",1:"")
 S I="" F  S I=$O(^AUPNVPED("AD",I)) Q:I=""  D  Q:Y="^"
 . S IEN="" F  S IEN=$O(^AUPNVPED("AD",I,IEN)) W:IEN#1000=22 "." Q:IEN=""  D  Q:Y="^"
 ..S ARRAY="^AUPNVPED(""AD"",I,IEN)" S PEDCNT=PEDCNT+1 I PEDCNT#1000=2 D MON^PXQUTL3B
 ..I '$D(^AUPNVPED(IEN)) W !,"Entry "_IEN," IS NOT THERE! BAD REFERENCE IS ^AUPNVPED(""AD"","_I_",",IEN_")" D @$S(AUTO="F":"KILL",AUTO'="F":"TT",1:"")
 S I="" F  S I=$O(^AUPNVPED("C",I)) Q:I=""  D  Q:Y="^"
 . S IEN="" F  S IEN=$O(^AUPNVPED("C",I,IEN)) W:IEN#1000=22 "." Q:IEN=""  D  Q:Y="^"
 ..S ARRAY="^AUPNVPED(""C"",I,IEN)" S PEDCNT=PEDCNT+1 I PEDCNT#1000=2 D MON^PXQUTL3B
 ..I '$D(^AUPNVPED(IEN)) W !,"Entry "_IEN," IS NOT THERE! BAD REFERENCE IS ^AUPNVPED(""C"","_I_",",IEN_")" D @$S(AUTO="F":"KILL",AUTO'="F":"TT",1:"")
 S I="" F  S I=$O(^AUPNVPED("AA",I)) Q:I=""  D  Q:Y="^"
 . S IEN="" F  S IEN=$O(^AUPNVPED("AA",I,IEN)) Q:IEN=""  D  Q:Y="^"
 ..S IENN="" F  S IENN=$O(^AUPNVPED("AA",I,IEN,IENN)) Q:IENN=""  D  Q:Y="^"
 ...S IENNN="" F  S IENNN=$O(^AUPNVPED("AA",I,IEN,IENN,IENNN)) Q:IENNN=""  D  Q:Y="^"
 ....S ARRAY="^AUPNVPED(""AA"",I,IEN,IENN,IENNN)" S PEDCNT=PEDCNT+1 I PEDCNT#1000=2 D MON^PXQUTL3B
 ....I '$D(^AUPNVPED(IENNN)) W !,"Entry "_IENNN," IS NOT THERE! BAD REFERENCE IS ^AUPNVPED(""AA"","_I_",",IEN_","_IENN_","_IENNN_")" D @$S(AUTO="F":"KILL",AUTO'="F":"TT",1:"")
 Q
 ;
 ;
H W !!,"Checking the V HEALTH FACTOR FILE #9000010.23 ",!
 S HFCNT=0
 I Y="^" Q
 S I="" F  S I=$O(^AUPNVHF("B",I)) Q:I=""  D  Q:Y="^"
 . S IEN="" F  S IEN=$O(^AUPNVHF("B",I,IEN)) W:IEN#1000=22 "." Q:IEN=""  D  Q:Y="^"
 ..S ARRAY="^AUPNVHF(""B"",I,IEN)" S HFCNT=HFCNT+1 I HFCNT#1000=2 D MON^PXQUTL3B
 ..I '$D(^AUPNVHF(IEN)) W !,"Entry "_IEN," IS NOT THERE! BAD REFERENCE IS ^AUPNVHF(""B"","_I_",",IEN_")" D @$S(AUTO="F":"KILL",AUTO'="F":"TT",1:"")
 S I="" F  S I=$O(^AUPNVHF("AD",I)) Q:I=""  D  Q:Y="^"
 . S IEN="" F  S IEN=$O(^AUPNVHF("AD",I,IEN)) W:IEN#1000=22 "." Q:IEN=""  D  Q:Y="^"
 ..S ARRAY="^AUPNVHF(""AD"",I,IEN)" S HFCNT=HFCNT+1 I HFCNT#1000=2 D MON^PXQUTL3B
 ..I '$D(^AUPNVHF(IEN)) W !,"Entry "_IEN," IS NOT THERE! BAD REFERENCE IS ^AUPNVHF(""AD"","_I_",",IEN_")" D @$S(AUTO="F":"KILL",AUTO'="F":"TT",1:"")
 S I="" F  S I=$O(^AUPNVHF("C",I)) Q:I=""  D  Q:Y="^"
 . S IEN="" F  S IEN=$O(^AUPNVHF("C",I,IEN)) W:IEN#1000=22 "." Q:IEN=""  D  Q:Y="^"
 ..S ARRAY="^AUPNVHF(""C"",I,IEN)" S HFCNT=HFCNT+1 I HFCNT#1000=2 D MON^PXQUTL3B
 ..I '$D(^AUPNVHF(IEN)) W !,"Entry "_IEN," IS NOT THERE! BAD REFERENCE IS ^AUPNVHF(""C"","_I_",",IEN_")" D @$S(AUTO="F":"KILL",AUTO'="F":"TT",1:"")
 S I="" F  S I=$O(^AUPNVHF("AA",I)) Q:I=""  D  Q:Y="^"
 . S IEN="" F  S IEN=$O(^AUPNVHF("AA",I,IEN)) Q:IEN=""  D  Q:Y="^"
 ..S IENN="" F  S IENN=$O(^AUPNVHF("AA",I,IEN,IENN)) Q:IENN=""  D  Q:Y="^"
 ...S IENNN="" F  S IENNN=$O(^AUPNVHF("AA",I,IEN,IENN,IENNN)) W:IENNN#1000=22 "." Q:IENNN=""  D  Q:Y="^"
 ....S ARRAY="^AUPNVHF(""AA"",I,IEN,IENN,IENNN)" S HFCNT=HFCNT+1 I HFCNT#1000=2 D MON^PXQUTL3B
 ....I '$D(^AUPNVHF(IENNN)) W !,"Entry "_IENNN," IS NOT THERE! BAD REFERENCE IS ^AUPNVHF(""AA"","_I_",",IEN_","_IENN_","_IENNN_")" D @$S(AUTO="F":"KILL",AUTO'="F":"TT",1:"")
 Q
 ;
 ;
TT ;--QUERY FOR CORRECT ENTRY
 S DIR("A")="Should I fix this one by removing the reference ??  "
 S DIR("B")="NO"
 S DIR(0)="YAO" D ^DIR
 I Y=1 D
 .K @ARRAY
 I Y="^" Q
 Q
KILL ;--AUTOMATIC
 ;W !,"KILL "_ARRAY
 K @ARRAY
 Q
