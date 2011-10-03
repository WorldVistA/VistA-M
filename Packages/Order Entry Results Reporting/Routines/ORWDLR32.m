ORWDLR32 ; SLC/KCM/REV/JDL - Lab Calls 6/28/2002
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**10,85,141,215,250,243**;Dec 17, 1997;Build 242
 ;
 ; DBIA 2263   GETLST^XPAR  ^TMP($J,"WC")
 ;
DEF(LST,ALOC,ADIV) ; procedure
 ; For Event Delay Order
 ;  ALOC: Delay Event's default location
 ;  ADIV: Delay Event's default division
 ; get dialog definition specific to lab
 S ILST=0
 S LST($$NXT)="~ShortList" D SHORT
 S LST($$NXT)="~Lab Collection Times" D LCOLLTM
 S LST($$NXT)="~Ward Collection Times" D WCOLLTM
 S LST($$NXT)="~Send Patient Times" D SENDTM
 S LST($$NXT)="~Collection Types" D COLLTYP
 S LST($$NXT)="~Default Urgency" D URGENCY
 S LST($$NXT)="~Schedules" D SCHED
 S LST($$NXT)="~Common" D COMMON
 Q
SHORT ; from DEF, get short list of lab quick orders
 N I,ORTMP,ORDG,A
 S I=$O(^ORD(100.98,"B","LAB",0))  ; get IEN of parent lab
 D DG^ORCHANG1(I,"BILD",.ORDG)   ; find members groups for parent lab
 S I=0
 F  S I=$O(ORDG(I)) Q:'I  D   ; loop through list of members groups
 . I $E($P($G(^ORD(100.98,I,0)),"^",3),1,2)="VB" Q
 . D GETQLST^ORWDXQ(.ORTMP,I,"Q")   ;get quick order of each members groups
 . S A=0 F  S A=$O(ORTMP(A)) Q:'A  D   ; loop through returned quick orders and
 . . S LST($$NXT)="i"_ORTMP(A)  ; move quick orders to display list
 . K ORTMP   ; clean up for next members groups of quick orders
 Q
LCOLLTM ; get collection times
 N TDAY,TMRW,IGNOR,CNT,ICTM,ORCTM,DOW,AMPM,DAY,TIME,TXDT
 S TDAY=DT,TDAY("DOW")=$H#7,TDAY("H")=$H,TDAY("TX")="T"
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
 I $G(ADIV) D GETLST^XPAR(.ORCTM,ADIV_";DIC(4,^SYS","LR PHLEBOTOMY COLLECTION","Q")
 E  D GETLST^XPAR(.ORCTM,"ALL","LR PHLEBOTOMY COLLECTION","Q")
 ;S DUZ(2)=TMPDIV
 S LST($$NXT)="iLNEXT^Next scheduled lab collection"
 S ICTM=0 F  S ICTM=$O(ORCTM(ICTM)) Q:'ICTM  D
 . I $P(ORCTM(ICTM),U)>$P($H,",",2) D
 . . S TXDT=TDAY("TX")
 . . I +TDAY("H")=+$H S DAY="Today"
 . . I TDAY("H")-$H=1 S DAY="Tomorrow"
 . . I TDAY("H")-$H>1 S DAY=$$DOWNAME(TDAY("DOW"))
 . E  D
 . . S TXDT=TMRW("TX")
 . . S DAY=$S(TMRW("H")-$H>1:$$DOWNAME(TMRW("DOW")),1:"Tomorrow")
 . S AMPM=$S($P(ORCTM(ICTM),U,2)>1159:"PM",1:"AM")
 . S TXDT=TXDT_"@"_$P(ORCTM(ICTM),"^",2)
 . S TIME=$P(ORCTM(ICTM),U,2),TIME=$E(TIME,1,2)_":"_$E(TIME,3,4)
 . S LST($$NXT)="iL"_TXDT_U_AMPM_" Collection: "_TIME_" ("_DAY_")"
 . S ^TMP($J,"WC",ILST)="iW"_TXDT_U_TIME_" "_AMPM_" ("_DAY_") Ward collect"  ;DBIA 2263
 ; D NOW^%DTC
 ;S LST($$NXT)="iWNOW^Now (Collect on ward)"
 S LST($$NXT)="iLO^Future"
 Q
WCOLLTM ; get Ward Collect times
 S I=""
 F  S I=$O(^TMP($J,"WC",I)) Q:I=""  D
 . S LST($$NXT)=^TMP($J,"WC",I)
 S LST($$NXT)="iWNOW^Now (Collect on ward)"
 ;S LST($$NXT)="iWO^Other"
 K ^TMP($J,"WC")
 Q
SENDTM ; get send patient times
 ;N X,X1,X2
 S LST($$NXT)="iLT^Today"
 ;S X1=DT,X2=1 D C^%DTC
 S LST($$NXT)="iLT+1^Tomorrow"
 ;S LST($$NXT)="iLO^Other"
 Q
COLLTYP ; Collection Types in effect for this division
 N Y S Y=""
 S LST($$NXT)="iLC^Lab Collect"
 S LST($$NXT)="iWC^Ward Collect"
 S LST($$NXT)="iSP^Send Patient to Lab"
 I +$$ON^LR7OV4(DUZ(2)) S LST($$NXT)="iI^Immediate Collect"
 S:$G(ALOC) Y=$$GET^XPAR("ALL^"_ALOC_";SC(","LR DEFAULT TYPE QUICK")
 I $L(Y) S LST($$NXT)="d"_Y
 Q
INCDATE(ADATE) ; called from COLLTM, increments date nodes in .ADATE
 N X,X1,X2,%H
 S X1=ADATE,X2=1 D C^%DTC S ADATE=X
 S ADATE("H")=ADATE("H")+1
 S ADATE("DOW")=ADATE("H")#7
 S ADATE("TX")="T+"_($P(ADATE("TX"),"+",2)+1)
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
URGENCY ; return default urgency for lab
 N URG
 S URG=$$DEFURG^LR7OR3
 S LST($$NXT)="i"_URG_U_$P(^LAB(62.05,URG,0),U,1)
 S LST($$NXT)="d"_URG_U_$P(^LAB(62.05,URG,0),U,1)
 Q
SCHED ; return list of schedules available for lab tests
 N X,X0,IEN,TYPE,FREQ
 K ^TMP($J,"ORWDLR32 APLR")
 D AP^PSS51P1("LR",,,,"ORWDLR32 APLR")
 S X="" F  S X=$O(^TMP($J,"ORWDLR32 APLR","APLR",X)) Q:X=""  D
 .S IEN=$O(^TMP($J,"ORWDLR32 APLR","APLR",X,"")) I IEN'>0 Q
 .S TYPE=$P($G(^TMP($J,"ORWDLR32 APLR",IEN,5)),U)
 .S FREQ=+$G(^TMP($J,"ORWDLR32 APLR",IEN,2))
 .I ((TYPE="C")!(TYPE="D")),FREQ=0 Q
 .S LST($$NXT)="i"_IEN_U_X_U_TYPE_U_FREQ
 .I X="ONE TIME" S LST($$NXT)="d"_IEN_U_X
 K ^TMP($J,"ORWDLR32 APLR")
 Q
COMMON ; return list of commonly ordered lab tests
 N ORLST,IEN,I
 D GETLST^XPAR(.ORLST,"ALL","ORWD COMMON LAB INPT")  ;DBIA 2263
 S I=0 F  S I=$O(ORLST(I)) Q:'I  D
 . S IEN=$P(ORLST(I),U,2)
 . S LST($$NXT)="i"_IEN_U_$P(^ORD(101.43,IEN,0),U,1)
 Q
LOAD(LST,TESTID) ; procedure
 ; Return sample, specimen, & urgency info about a lab test
 N I,J,X,X1,X4,ORY,ORLABID,ILST,PARAM
 S ILST=0,X=$P(^ORD(101.43,TESTID,0),"^"),ORLABID=$P(^(0),U,2)
 S LST($$NXT)="~Test Name"
 S LST($$NXT)="d"_X
 S LST($$NXT)="~Item ID"
 S LST($$NXT)="d"_+ORLABID
 S X1=$S($P($P(^ORD(101.43,TESTID,0),U,2),";",2)="99VBC":$O(^LAB(60,"B",$P(^ORD(101.43,TESTID,0),"^")_" - LAB",0)),1:$P($P(^ORD(101.43,TESTID,0),U,2),";",1)) Q:'X1
 S X4=$P($G(^LAB(60,X1,0)),U,4)
 S LST(ILST)=LST(ILST)_U_X4
 I $D(^ORD(101.43,TESTID,8))>1 S LST($$NXT)="~OIMessage"
 S I=0 F  S I=$O(^ORD(101.43,TESTID,8,I)) Q:'I  S LST($$NXT)="t"_^(I,0)
 S TESTID=+$P(^ORD(101.43,TESTID,0),U,2)
 D TEST^LR7OR3(X1,.ORY)
 S PARAM="" F  S PARAM=$O(ORY(PARAM)) Q:PARAM=""  D
 . S LST($$NXT)="~"_PARAM
 . I PARAM="ReqCom" D
 . . S LST($$NXT)="d"_$G(ORY("ReqCom")) Q
 . I PARAM="Default CollSamp" D
 . . S LST($$NXT)="d"_$G(ORY("Default CollSamp")) Q
 . I PARAM="Unique CollSamp" D
 . . S LST($$NXT)="d"_$G(ORY("Unique CollSamp")) Q
 . I PARAM="Default Urgency" D
 . . S LST($$NXT)="d"_$G(ORY("Default Urgency")) Q
 . I PARAM="Lab CollSamp" D
 . . S LST($$NXT)="d"_$G(ORY("Lab CollSamp")) Q
 . I $D(ORY(PARAM))>1 S I=0 F  S I=$O(ORY(PARAM,I)) Q:'I  D
 . . I PARAM="Specimens" S LST($$NXT)="i"_ORY(PARAM,I) Q
 . . I PARAM="Urgencies" S LST($$NXT)="i"_ORY(PARAM,I) Q
 . . I PARAM="GenWardInstructions" S LST($$NXT)="t"_ORY(PARAM,I,0) Q
 . . S LST($$NXT)="i"_I_U_ORY(PARAM,I)
 . . I PARAM="CollSamp" D
 . . . I $G(ORY("Lab CollSamp")) S $P(LST(ILST),U,8)=1
 . . . S X=+$P(ORY(PARAM,I),U,3)
 . . . I X S $P(LST(ILST),U,10)=$P($G(^LAB(61,X,0)),U,1)
 . . I $D(ORY(PARAM,I,"WP")) S J=0 F  S J=$O(ORY(PARAM,I,"WP",J)) Q:'J  D
 . . . S LST($$NXT)="t"_ORY(PARAM,I,"WP",J,0)
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
ONESAMP(LST,IEN) ;Return data for one colelction sample
 ; n^SampIEN^SampName^SpecPtr^TubeTop^^^LabCollect^^SpecName
 N SPC,ILST,X,X0
 Q:+$G(IEN)=0
 S ILST=0,LST($$NXT)="~CollSamp"
 S X0=^LAB(62,IEN,0)
 S X="i1"_U_IEN_U_$P(X0,U,1)_U_$P(X0,U,2)_U_$P(X0,U,3)_U_U_U_$P(X0,U,7)
 I $P(X0,U,2) D
 . S $P(X,U,10)=$P(^LAB(61,+$P(X0,U,2),0),U,1)
 . S SPC($P(X,U,4))=$P(X,U,10)
 S LST($$NXT)=X
 S LST($$NXT)="~Specimens"
 S SPC=0 F  S SPC=$O(SPC(SPC)) Q:'SPC  S LST($$NXT)=SPC_U_SPC(SPC)
 Q
ONESPEC(LST,IEN) ;return one specimen
 Q:(+$G(IEN)=0)!('$D(^LAB(61,IEN,0)))
 S LST=IEN_U_$P(^LAB(61,IEN,0),U,1)
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
 ;
