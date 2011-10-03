ORWDLR ; SLC/KCM - Lab Calls [ 08/04/96  8:47 PM ]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**243**;Dec 17, 1997;Build 242
 ;
DEF(LST,ALOC) ; procedure
 ; get dialog definition specific to lab
 S ILST=0
 S LST($$NXT)="~Collection Times" D COLLTM
 S LST($$NXT)="~Send Patient Times" D SENDTM
 S LST($$NXT)="~Default Urgency="_$$DEFURG^LR7OR3
 ; S LST($$NXT)="~Urgencies Map" D URGMAP
 S LST($$NXT)="~Schedules" D SCHED
 S LST($$NXT)="~Common" D COMMON
 Q
COLLTM ; get collection times
 N TDAY,TMRW,IGNOR,CNT,ICTM,CTM,DOW,AMPM,DAY,TIME,FMDT
 S TDAY=DT,TDAY("DOW")=$H#7,TDAY("H")=$H
 M TMRW=TDAY D INCDATE(.TMRW)
 I $G(ALOC),'$$GET^XPAR(ALOC_";SC(","LR EXCEPTED LOCATIONS",1,"Q") D
 . S IGNOR=$$GET^XPAR("ALL","LR IGNORE HOLIDAYS",1,"Q")
 . S DOW(0)=$$GET^XPAR("ALL","LR COLLECT THURSDAY",1,"Q")
 . S DOW(1)=$$GET^XPAR("ALL","LR COLLECT FRIDAY",1,"Q")
 . S DOW(2)=$$GET^XPAR("ALL","LR COLLECT SATURDAY",1,"Q")
 . S DOW(3)=$$GET^XPAR("ALL","LR COLLECT SUNDAY",1,"Q")
 . S DOW(4)=$$GET^XPAR("ALL","LR COLLECT MONDAY",1,"Q")
 . S DOW(5)=$$GET^XPAR("ALL","LR COLLECT TUESDAY",1,"Q")
 . S DOW(6)=$$GET^XPAR("ALL","LR COLLECT WEDNESDAY",1,"Q")
 . S CNT=0 F  Q:(DOW(TDAY("DOW"))=1)&((IGNOR=1)!('$D(^HOLIDAY(TDAY,0))))  D  Q:CNT>6
 . . D INCDATE(.TDAY) S CNT=CNT+1
 . S CNT=0 F  Q:(DOW(TMRW("DOW"))=1)&((IGNOR=1)!('$D(^HOLIDAY(TMRW,0))))  D  Q:CNT>6
 . . D INCDATE(.TMRW) S CNT=CNT+1
 D GETLST^XPAR(.CTM,"ALL","LR PHLEBOTOMY COLLECTION","Q")
 S ICTM=0 F  S ICTM=$O(CTM(ICTM)) Q:'ICTM  D
 . I $P(CTM(ICTM),U)>$P($H,",",2) D
 . . S FMDT=TDAY
 . . I +TDAY("H")=+$H S DAY="Today"
 . . I TDAY("H")-$H=1 S DAY="Tomorrow"
 . . I TDAY("H")-$H>1 S DAY=$$DOWNAME(TDAY("DOW"))
 . E  D
 . . S FMDT=TMRW
 . . S DAY=$S(TMRW("H")-$H>1:$$DOWNAME(TMRW("DOW")),1:"Tomorrow")
 . S AMPM=$S($P(CTM(ICTM),U,2)>1159:"PM",1:"AM")
 . S FMDT=FMDT_"."_$P(CTM(ICTM),"^",2)
 . S TIME=$P(CTM(ICTM),U,2),TIME=$E(TIME,1,2)_":"_$E(TIME,3,4)
 . S LST($$NXT)="iL"_FMDT_U_AMPM_" Collection: "_TIME_" ("_DAY_")"
 D NOW^%DTC
 S LST($$NXT)="iW"_%_"^Now (Collect on ward)"
 Q
SENDTM ; get send patient times
 N X,X1,X2
 S LST($$NXT)="iL"_DT_"^Today"
 S X1=DT,X2=1 D C^%DTC
 S LST($$NXT)="iL"_X_"^Tomorrow"
 Q
INCDATE(ADATE) ; called from COLLTM, increments date nodes in .ADATE
 N X,X1,X2,%H
 S X1=ADATE,X2=1 D C^%DTC S ADATE=X
 S ADATE("H")=ADATE("H")+1
 S ADATE("DOW")=ADATE("H")#7
 Q
DOWNAME(DOW) ; function
 ; Returns Day of Week name (DOW should be $H#7)
 I DOW=0 Q "Thursday"
 I DOW=1 Q "Friday"
 I DOW=2 Q "Saturday"
 I DOW=3 Q "Sunday"
 I DOW=4 Q "Monday"
 I DOW=5 Q "Tuesday"
 I DOW=6 Q "Wednesday"
 Q ""
URGMAP ; return list of lab urgencies mapped to OE/RR urgencies
 Q
 N I,X
 S I=0 F  S I=$O(^LAB(62.05,I)) Q:'I  S X=^(I,0) I '$P(X,U,3) D
 . S LST($$NXT)="i"_I_"="_I_U_$P(X,U)
 ; D GETLST^XPAR(.Y,"ALL","ORCDLR URGENCIES","N")
 ; S URG=0 F  S URG=$O(Y(URG)) Q:'URG  S LST($$NXT)="i"_URG_"="_Y(URG)
 Q
SCHED ; return list of schedules available for lab tests
 N X,IEN
 K ^TMP($J,"ORWDLR APLR")
 D AP^PSS51P1("LR",,,,"ORWDLR APLR")
 S X="" F  S X=$O(^TMP($J,"ORWDLR APLR","APLR",X)) Q:X=""  D
 . S IEN=$O(^TMP($J,"ORWDLR APLR","APLR",X,"")) I IEN'>0 Q
 . S LST($$NXT)="i"_IEN_U_X_U_$P($G(^TMP($J,"ORWDLR APLR",IEN,5)),U)
 . I X="ONE TIME" S LST($$NXT)="d"_X
 K ^TMP($J,"ORWDLR APLR")
 Q
COMMON ; return list of commonly ordered lab tests
 N TMPLST,IEN,I
 D GETLST^XPAR(.TMPLST,"ALL","ORWD COMMON LAB INPT")
 S I=0 F  S I=$O(TMPLST(I)) Q:'I  D
 . S IEN=$P(TMPLST(I),U,2)
 . S LST($$NXT)="i"_IEN_U_$P(^ORD(101.43,IEN,0),U,1)
 Q
LOAD(LST,TESTID) ; procedure
 ; Return sample, specimen, & urgency info about a lab test
 N X,Y,ILST,PARAM S ILST=0
 S LST($$NXT)="~Test Name="_$P(^ORD(101.43,TESTID,0),U,1)
 I $D(^ORD(101.43,TESTID,8))>1 S LST($$NXT)="~OIMessage"
 S I=0 F  S I=$O(^ORD(101.43,TESTID,8,I)) Q:'I  S LST($$NXT)="t"_^(I,0)
 S TESTID=+$P(^ORD(101.43,TESTID,0),U,2)
 D TEST^LR7OR3(TESTID,.Y)
 S PARAM="" F  S PARAM=$O(Y(PARAM)) Q:PARAM=""  D
 . S LST($$NXT)="~"_PARAM_$S($D(Y(PARAM))>1:"",1:"="_$G(Y(PARAM)))
 . I $D(Y(PARAM))>1 S I=0 F  S I=$O(Y(PARAM,I)) Q:'I  D
 . . I PARAM="Specimens" S LST($$NXT)="i"_Y(PARAM,I) Q
 . . I PARAM="Urgencies" S LST($$NXT)="i"_Y(PARAM,I) Q
 . . S LST($$NXT)="i"_I_U_Y(PARAM,I)
 . . I PARAM="CollSamp" D
 . . . I $G(Y("Lab CollSamp")) S $P(LST(ILST),U,8)=1
 . . . S X=+$P(Y(PARAM,I),U,3)
 . . . I X S $P(LST(ILST),U,10)=$P($G(^LAB(61,X,0)),U,1)
 . . I $D(Y(PARAM,I,"WP")) S J=0 F  S J=$O(Y(PARAM,I,"WP",J)) Q:'J  D
 . . . S LST($$NXT)="t"_Y(PARAM,I,"WP",J,0)
 Q
ALLSAMP(LST) ; procedure
 ; returns all collection samples
 ; n^SampIEN^SampName^SpecPtr^TubeTop^^^LabCollect^^SpecName
 N SMP,SPC,ILST,IEN,X,X0
 S ILST=0,LST($$NXT)="~CollSamp"
 S SMP="" F  S SMP=$O(^LAB(62,"B",SMP)) Q:SMP=""  D
 . S IEN=0 F  S IEN=$O(^LAB(62,"B",SMP,IEN)) Q:'IEN  D
 . . S X0=^LAB(62,IEN,0)
 . . S X="i"_U_IEN_U_SMP_U_$P(X0,U,2)_U_$P(X0,U,3)_U_U_U_$P(X0,U,7)
 . . I $P(X0,U,2) D
 . . . S $P(X,U,10)=$P(^LAB(61,+$P(X0,U,2),0),U,1)
 . . . S SPC($P(X,U,4))=$P(X,U,10)
 . . S LST($$NXT)=X
 S LST($$NXT)="~Specimens"
 S SPC=0 F  S SPC=$O(SPC(SPC)) Q:'SPC  S LST($$NXT)=SPC_U_SPC(SPC)
 Q
ABBSPEC(LST) ; procedure
 ; returns specimens with abbreviation (uses 'E' xref)
 N X,IEN,ILST S ILST=0
 S X="" F  S X=$O(^LAB(61,"E",X)) Q:X=""  S IEN=$O(^(X,0)) D
 . S LST($$NXT)=IEN_U_$P(^LAB(61,IEN,0),U,1)
 Q
NXT() ; called by TESTINFO, increments ILST
 S ILST=ILST+1
 Q ILST
STOP(VAL,X2)       ; return a calculated stop date
 N X1,X
 S X1=DT D C^%DTC S VAL=X
 Q
