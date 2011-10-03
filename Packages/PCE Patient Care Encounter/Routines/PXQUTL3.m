PXQUTL3 ;ISL/JVS CLEAN OUT BAD CROSSREFERENCES ;4/16/97  14:30
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**29,131**;Aug 12, 1996
 ;
T ;
 ;
 W !!!,"                  NOTES CONCERNING THIS OPTION"
 W !
 W !,"   These options will check for broken cross-references in all of"
 W !,"           the PCE visit files. It is interactive."
 W !," 'S' will go through ONLY the 'B' X-REF of each file looking for problems."
 W !,"         To EXIT the program, you can enter an '^' at any prompt."
 W !,"  At about 1 minute intervals a message will come up telling you"
 W !,"               how much work has already been done."
 W !
 S Y=""
 S DIR(0)="S^S:Screen of 4 'MAIN' files;P:Provider V PROVIDER FILE;"
 S DIR(0)=DIR(0)_"D:Diagnosis V POV FILE;C:CPT V CPT FILE;"
 S DIR(0)=DIR(0)_"V:Visit VISIT FILE;O:Other 6 V Files;"
 S DIR(0)=DIR(0)_"R:Repair 4 'MAIN' V Files without prompting (automatic);"
 S DIR(0)=DIR(0)_"F:Fix ALL files without prompting (automatic)"
 S DIR("A")="Which file do you need to fix "
 S DIR("B")="P"
 D ^DIR
 N X,IEN,IENN,IENNN,I,ARRAY,PAST,NOW,%,PRVCNT,PRVP,POVCNT,POVP
 N CPTCNT,CNTP,VSTCNT,VSTP,AUTO,XREF,VSTXCNT,AUTOO
 S (AUTO,AUTOO)="",XREF="NONE",VSTXCNT=0
 I Y="P" D PRMPT,P G T
 I Y="D" D PRMPT,D G T
 I Y="C" D PRMPT,C G T
 I Y="O" D INF,PRMPT,O^PXQUTL3B G T
 I Y="V" D PRMPT,V^PXQUTL3A G T
 I Y="R" D PRMPT S:AUTO="F" AUTOO="F" D P,D,C,V^PXQUTL3A G T
 I Y="S" D S^PXQUTL3A G T
 I Y="F" S (AUTO,AUTOO)="F" D P,D,C,V^PXQUTL3A,O^PXQUTL3B G T
 I Y="^" G EXIT
 Q
 ;
 ;
 ;
P ;---CHECK FOR BROKEN CROSSREFERENCES
 S PRVCNT=0
 I Y="^" Q
 W !,"Checking the V PROVIDER FILE #9000010.06",!
 S I="" F  S I=$O(^AUPNVPRV("B",I)) Q:I=""  D  G:Y="^" EXIT
 . S IEN="" F  S IEN=$O(^AUPNVPRV("B",I,IEN)) W:IEN#1000=22 "." Q:IEN=""  D
 ..S ARRAY="^AUPNVPRV(""B"",I,IEN)" S PRVCNT=PRVCNT+1 I PRVCNT#1000=2 D MON
 ..I '$D(^AUPNVPRV(IEN)) W !,"Entry "_IEN," IS NOT THERE! BAD REFERENCE IS ^AUPNVPRV(""B"","_I_",",IEN_")" D @$S(AUTO="F":"KILL",AUTO'="F":"TT",1:"")
 S I="" F  S I=$O(^AUPNVPRV("AD",I)) Q:I=""  D  G:Y="^" EXIT
 . S IEN="" F  S IEN=$O(^AUPNVPRV("AD",I,IEN)) W:IEN#1000=22 "." Q:IEN=""  D
 ..S ARRAY="^AUPNVPRV(""AD"",I,IEN)" S PRVCNT=PRVCNT+1 I PRVCNT#1000=2 D MON
 ..I '$D(^AUPNVPRV(IEN)) W !,"Entry "_IEN," IS NOT THERE! BAD REFERENCE IS ^AUPNVPRV(""AD"","_I_",",IEN_")" D @$S(AUTO="F":"KILL",AUTO'="F":"TT",1:"")
 S I="" F  S I=$O(^AUPNVPRV("C",I)) Q:I=""  D  G:Y="^" EXIT
 . S IEN="" F  S IEN=$O(^AUPNVPRV("C",I,IEN)) W:IEN#1000=22 "." Q:IEN=""  D
 ..S ARRAY="^AUPNVPRV(""C"",I,IEN)" S PRVCNT=PRVCNT+1 I PRVCNT#1000=2 D MON
 ..I '$D(^AUPNVPRV(IEN)) W !,"Entry "_IEN," IS NOT THERE! BAD REFERENCE IS ^AUPNVPRV(""C"","_I_",",IEN_")" D @$S(AUTO="F":"KILL",AUTO'="F":"TT",1:"")
 Q
 ;
 ;
 ;
 ;
D W !!,"Checking the V POV FILE #9000010.07 (PROCEDURES)",!
 S POVCNT=0
 I Y="^" Q
 S I="" F  S I=$O(^AUPNVPOV("B",I)) Q:I=""  D  G:Y="^" EXIT
 . S IEN="" F  S IEN=$O(^AUPNVPOV("B",I,IEN)) W:IEN#1000=22 "." Q:IEN=""  D
 ..S ARRAY="^AUPNVPOV(""B"",I,IEN)" S POVCNT=POVCNT+1 I POVCNT#1000=2 D MON
 ..I '$D(^AUPNVPOV(IEN)) W !,"Entry "_IEN," IS NOT THERE! BAD REFERENCE IS ^AUPNVPOV(""B"","_I_",",IEN_")" D @$S(AUTO="F":"KILL",AUTO'="F":"TT",1:"")
 S I="" F  S I=$O(^AUPNVPOV("AD",I)) Q:I=""  D  G:Y="^" EXIT
 . S IEN="" F  S IEN=$O(^AUPNVPOV("AD",I,IEN)) Q:IEN=""  D
 ..S ARRAY="^AUPNVPOV(""AD"",I,IEN)" S POVCNT=POVCNT+1 I POVCNT#1000=2 D MON
 ..I '$D(^AUPNVPOV(IEN)) W !,"Entry "_IEN," IS NOT THERE! BAD REFERENCE IS ^AUPNVPOV(""AD"","_I_",",IEN_")" D @$S(AUTO="F":"KILL",AUTO'="F":"TT",1:"")
 S I="" F  S I=$O(^AUPNVPOV("C",I)) Q:I=""  D  G:Y="^" EXIT
 . S IEN="" F  S IEN=$O(^AUPNVPOV("C",I,IEN)) W:IEN#1000=22 "." Q:IEN=""  D
 ..S ARRAY="^AUPNVPOV(""C"",I,IEN)" S POVCNT=POVCNT+1 I POVCNT#1000=2 D MON
 ..I '$D(^AUPNVPOV(IEN)) W !,"Entry "_IEN," IS NOT THERE! BAD REFERENCE IS ^AUPNVPOV(""C"","_I_",",IEN_")" D @$S(AUTO="F":"KILL",AUTO'="F":"TT",1:"")
 S I="" F  S I=$O(^AUPNVPOV("AA",I)) Q:I=""  D  G:Y="^" EXIT
 . S IEN="" F  S IEN=$O(^AUPNVPOV("AA",I,IEN)) Q:IEN=""  D
 ..S IENN="" F  S IENN=$O(^AUPNVPOV("AA",I,IEN,IENN)) W:IENN#1000=22 "." Q:IENN=""  D
 ...S ARRAY="^AUPNVPOV(""AA"",I,IEN,IENN)" S POVCNT=POVCNT+1 I POVCNT#1000=2 D MON
 ...I '$D(^AUPNVPOV(IENN)) W !,"Entry "_IENN," IS NOT THERE! BAD REFERENCE IS ^AUPNVPOV(""AA"","_I_",",IEN_","_IENN_")" D @$S(AUTO="F":"KILL",AUTO'="F":"TT",1:"")
 Q
 ;
 ;
C W !!,"Checking the V CPT FILE #9000010.18 (PROCEDURES)",!
 S CPTCNT=0
 I Y="^" Q
 S I="" F  S I=$O(^AUPNVCPT("B",I)) Q:I=""  D  G:Y="^" EXIT
 . S IEN="" F  S IEN=$O(^AUPNVCPT("B",I,IEN)) W:IEN#1000=22 "." Q:IEN=""  D
 ..S ARRAY="^AUPNVCPT(""B"",I,IEN)" S CPTCNT=CPTCNT+1 I CPTCNT#1000=2 D MON
 ..I '$D(^AUPNVCPT(IEN)) W !,"Entry "_IEN," IS NOT THERE! BAD REFERENCE IS ^AUPNVCPT(""B"","_I_",",IEN_")" D @$S(AUTO="F":"KILL",AUTO'="F":"TT",1:"")
 S I="" F  S I=$O(^AUPNVCPT("AD",I)) Q:I=""  D  G:Y="^" EXIT
 . S IEN="" F  S IEN=$O(^AUPNVCPT("AD",I,IEN)) W:IEN#1000=22 "." Q:IEN=""  D
 ..S ARRAY="^AUPNVCPT(""AD"",I,IEN)" S CPTCNT=CPTCNT+1 I CPTCNT#1000=2 D MON
 ..I '$D(^AUPNVCPT(IEN)) W !,"Entry "_IEN," IS NOT THERE! BAD REFERENCE IS ^AUPNVCPT(""AD"","_I_",",IEN_")" D @$S(AUTO="F":"KILL",AUTO'="F":"TT",1:"")
 S I="" F  S I=$O(^AUPNVCPT("C",I)) Q:I=""  D  G:Y="^" EXIT
 . S IEN="" F  S IEN=$O(^AUPNVCPT("C",I,IEN)) W:IEN#1000=22 "." Q:IEN=""  D
 ..S ARRAY="^AUPNVCPT(""C"",I,IEN)" S CPTCNT=CPTCNT+1 I CPTCNT#1000=2 D MON
 ..I '$D(^AUPNVCPT(IEN)) W !,"Entry "_IEN," IS NOT THERE! BAD REFERENCE IS ^AUPNVCPT(""C"","_I_",",IEN_")" D @$S(AUTO="F":"KILL",AUTO'="F":"TT",1:"")
 S I="" F  S I=$O(^AUPNVCPT("AA",I)) Q:I=""  D  G:Y="^" EXIT
 . S IEN="" F  S IEN=$O(^AUPNVCPT("AA",I,IEN)) Q:IEN=""  D
 ..S IENN="" F  S IENN=$O(^AUPNVCPT("AA",I,IEN,IENN)) Q:IENN=""  D
 ...S IENNN="" F  S IENNN=$O(^AUPNVCPT("AA",I,IEN,IENN,IENNN)) W:IENNN#1000=22 "." Q:IENNN=""  D
 ....S ARRAY="^AUPNVCPT(""AA"",I,IEN,IENN,IENNN)" S CPTCNT=CPTCNT+1 I CPTCNT#1000=2 D MON
 ....I '$D(^AUPNVCPT(IENNN)) W !,"Entry "_IENNN," IS NOT THERE! BAD REFERENCE IS ^AUPNVCPT(""AA"","_I_",",IEN_","_IENN_","_IENNN_")" D @$S(AUTO="F":"KILL",AUTO'="F":"TT",1:"")
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
EXIT K DIR,DA,DIK
 Q
MON ;--MONITOR SITUATION
 D NOW^%DTC S NOW=% S:'$G(PAST) PAST=% I $G(PAST) D  S:'$G(PAST) PAST=%
 .I $P(NOW,".",1)'=$P(PAST,".",1) K PAST Q
 .I ($P(NOW,".",2)-$P(PAST,".",2))>60 D
 ..D CAL K PAST
 Q
CAL ;--CALCULATE TIME LEFT
 N PRVT,POVT,CPTT,VSTT
 N CPTP,VSTX,VSTXP     ;PX*1.0*131 (to satisfy ^XINDEX)
 S:'$G(PRVCNT) PRVCNT=1 S:'$G(POVCNT) POVCNT=1
 S:'$G(CPTCNT) CPTCNT=1 S:'$G(VSTCNT) VSTCNT=1
 S PRVT=$P($G(^AUPNVPRV(0)),"^",4)*3,PRVP=(($G(PRVCNT)/PRVT)*100)
 S POVT=$P($G(^AUPNVPOV(0)),"^",4)*4,POVP=(($G(POVCNT)/POVT)*100)
 S CPTT=$P($G(^AUPNVCPT(0)),"^",4)*4,CPTP=(($G(CPTCNT)/CPTT)*100)
 S VSTT=$P($G(^AUPNVSIT(0)),"^",4)*9,VSTP=(($G(VSTCNT)/VSTT)*100)
 S VSTX=$P($G(^AUPNVSIT(0)),"^",4),VSTXP=(($G(VSTXCNT)/VSTX)*100)
 I PRVCNT=1 S PRVCNT=0,PRVP=0
 I POVCNT=1 S POVCNT=0,POVP=0
 I CPTCNT=1 S CPTCNT=0,CPTP=0
 I VSTCNT=1 S VSTCNT=0,VSTP=0
 W !!,"   - - M O N I T O R  AT 1 MINUTE- -" N Y D YX^%DTC W " "_Y
 W !,"FILE",?20,"TOTAL",?35,"#FINISHED",?50,"%COMPLETED"
 W !,"V PROVIDER",?20,PRVT,?35,PRVCNT,?50,$E(PRVP,1,5)_"%"
 W !,"V POV",?20,POVT,?35,POVCNT,?50,$E(POVP,1,5)_"%"
 W !,"V CPT",?20,CPTT,?35,CPTCNT,?50,$E(CPTP,1,5)_"%"
 W !,"VISIT",?20,VSTT,?35,VSTCNT,?50,$E(VSTP,1,5)_"%"
 W !,XREF,?20,VSTX,?35,VSTXCNT,?50,$E(VSTXP,1,5)_"%"
 Q
PRMPT ;---PROMPT FOR PROMPTING
 S DIR("?",1)="By saying YES to this prompt, you will eliminate being asked"
 S DIR("?")="over and over again, 'Should I fix this one by removing the reference ??'"
 S DIR("A")="Eliminate Prompting for Confirmation?  "
 S DIR("B")="NO"
 S DIR(0)="YAO"
 D ^DIR
 I Y=1 S AUTO="F"
 K DIR
 Q
INF ;--LIST OF OTHER 6 V FILES
 W !!,"The 'OTHER' 6 V-files are:"
 W !,"V IMMUNIZATION   file#9000010.11"
 W !,"V SKIN TEST      file#9000010.12"
 W !,"V EXAM           file#9000010.13"
 W !,"V TREATMENT      file#9000010.15"
 W !,"V PATIENT ED     file#9000010.16"
 W !,"V HEALTH FACTOR  file#9000010.23",!
 Q
