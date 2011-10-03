ORWDRA ; SLC/KCM - Radiology calls to support windows [ 08/03/96  6:42 PM ]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;;Dec 17, 1997
 ;
DEF(LST,PATID) ; Get dialog data for radiology
 N ILST,I,X S ILST=0
 S LST($$NXT)="~Common Procedures" D COMMPRO
 S LST($$NXT)="~Modifiers" D MODIFYR
 S LST($$NXT)="~Urgencies" D URGENCY
 S LST($$NXT)="~Transport" D TRNSPRT
 S LST($$NXT)="~Category" D CATEGRY
 S LST($$NXT)="~Submit to" D SUBMIT
 S LST($$NXT)="~Ask Submit="_$$GET^XPAR("ALL","RA SUBMIT PROMPT",1,"Q")
 S LST($$NXT)="~Last 7 Days" D LAST7
 Q
MODIFYR ; Get the modifiers (should be by imaging type)
 S I=0 F  S I=$O(^RAMIS(71.2,I)) Q:'I  S LST($$NXT)="i"_I_U_$P(^(I,0),U)
 Q
COMMPRO ; Get the common procedures
 S X="" F  S X=$O(^ORD(101.43,"COMMON","RAD",X)) Q:X=""  D
 . S I=$O(^ORD(101.43,"COMMON","RAD",X,0)),LST($$NXT)="i"_I_U_X
 Q
URGENCY ; Get the allowable urgencies and default
 F X="STAT","ASAP","ROUTINE","DONE" D
 . S I=$O(^ORD(101.42,"B",X,0)),LST($$NXT)="i"_I_U_X
 S LST($$NXT)="dROUTINE"
 Q
TRNSPRT ; Get the modes of transport
 F X="A^AMBULATORY","P^PORTABLE","S^STRETCHER","W^WHEELCHAIR" D
 . S LST($$NXT)="i"_X
 ; figure default on windows side
 Q
CATEGRY ; Get the categories of exam  
 F X="I^INPATIENT","O^OUTPATIENT","C^CONTRACT","S^SHARING","E^EMPLOYEE","R^RESEARCH" D
 . S LST($$NXT)="i"_X
 ; figure default on windows side
 Q
SUBMIT ; Get the locations to which the request may be submitted
 N TMPLST
 D EN4^RAO7PC1("RAD","TMPLST")
 S I=0 F  S I=$O(TMPLST(I)) Q:'I  S LST($$NXT)="i"_TMPLST(I)
 S I=$O(TMPLST(0)),X=$P(TMPLST(I),U,2),LST($$NXT)="d"_X
 Q
LAST7 ; Get exams for the last 7 days
 K ^TMP($J,"RAE7") D EN2^RAO7PC1(PATID)
 S I=0 F  S I=$O(^TMP($J,"RAE7",PATID,I)) Q:'I  D 
 . S LST($$NXT)="i"_I_U_^(I)
 K ^TMP($J,"RAE7")
 Q
NXT() ; Increment index of LST
 S ILST=ILST+1
 Q ILST
