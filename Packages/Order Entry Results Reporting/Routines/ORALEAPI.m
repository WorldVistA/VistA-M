ORALEAPI ; SPFO/AJB - View Alerts Optimization API ;Jul 19, 2019@07:12:41
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**500**;Dec 17, 1997;Build 24
 ; ^XTV(8992.1) ICR#7063
 ; ^VA(200)     ICR#4329
 ; ^XMD         ICR#10070
 Q
POST ;
 N ERROR,IEN,ORBOPT,ORXQOPT
 S ORBOPT=$$LU(19,"ORB3 LM  1 MAIN MENU","X"),ORXQOPT=$$LU(19,"XQAL REPORTS MENU","X")
 I '+ORBOPT!('+ORXQOPT) Q
 N FDA S ORBOPT="+1,"_ORBOPT_","
 S FDA(19.01,ORBOPT,.01)=ORXQOPT
 S FDA(19.01,ORBOPT,2)="17"
 D UPDATE^DIE("","FDA","IEN",.ERROR)
 Q
RPT ;
 N CSV,DATA,SAVE S CSV=1,DATA="^TMP(""ORALERT"",$J,""MSG"")"
 W @IOF
 W "This report will return all TIU and OE/RR notifications for the entered date",!,"range."
 N DEV,DTRG S (DTRG("Start"),DTRG("Stop"))=""
 D  I '+DTRG("Start")!('+DTRG("Stop")) W ! Q
 . N %DT,DIR,X,Y S %DT(0)=-$$DT^XLFDT,%DT="AETX",%DT("A")="Select Beginning DATE: ",%DT("B")=$$FMTE^XLFDT($$FMADD^XLFDT(DT,-30))
 . W ! D ^%DT K %DT Q:Y<0  S DTRG("Start")=Y
 . S DIR("A")="          Ending DATE: ",DIR("B")=$$FMTE^XLFDT(DT),DIR(0)="DA"_U_DTRG("Start")_":"_$$DT^XLFDT_":EXT"
 . S DIR("?")="     Enter a date between "_$$FMTE^XLFDT(DTRG("Start"))_" and "_$$FMTE^XLFDT($$DT^XLFDT)_"."
 . W ! D ^DIR Q:Y'>0  S DTRG("Stop")=Y S:$P(DTRG("Stop"),".",2)="" $P(DTRG("Stop"),".",2)="999999"
 W ! S DEV=$$DEV Q:$S(DEV="":1,DEV="^":1,1:0)
 I DEV["M" N CNT,XMDUN,XMDUZ,XMSUB,XMTEXT,XMY,XMZ D  I DEV="M",'+$D(XMY) Q
 . S XMSUB="Alert Tracking Report ["_$$FMTE^XLFDT(DTRG("Start"))_" to "_$$FMTE^XLFDT(DTRG("Stop"))_"]"
 . S XMTEXT="^TMP(""ORALERT"",$J,""MSG"","
 . S XMDUZ=DUZ,CNT=0
 . D MAIL(.XMY)
 I DEV["D" W ! S SAVE("*")="" D EN^XUTMDEVQ("GENERATE^ORALEAPI","Alert Tracking Report",.SAVE) Q
 N ZTRTN,ZTIO,ZTSAVE,ZTDTH,ZTSK S ZTDTH=$H,ZTRTN="GENERATE^ORALEAPI",ZTSAVE("*")="",ZTIO="" D ^%ZTLOAD
 W !!,"Mail message on its way...here is your task #: ",ZTSK,!
 I $$READ^ORPARMG1("EA","Press <ENTER> to continue")
 Q
GENERATE ;
 K @DATA
 I $E(IOST,1,2)="C-" W @IOF,"Creating report..."
 D REPORT(.DATA,DTRG("Start"),DTRG("Stop"))
 I $E(IOST,1,2)="C-" W "done."
 I DEV["M",+$D(XMY) W:$E(IOST,1,2)="C-" !!,"Sending email..." D ^XMD W:$E(IOST,1,2)="C-" "on its way."
 I DEV["D" W:$E(IOST,1,2)="C-" @IOF D  I $E(IOST,1,2)="C-",$$READ^ORPARMG1("EA","Press <ENTER> to continue")
 . N X S X=0 F  S X=$O(@DATA@(X)) Q:'+X  W @DATA@(X),!
 K @DATA
 Q
REPORT(ORX,SDT,EDT,TYP) ;
 I $G(TYP)="OR"!($G(TYP)="TIU")!($G(TYP)="")
 Q:'$T
 I $G(ORX)="" S ORX="ORY"
 N DELIM S DELIM=$S($D(CSV):",",1:U)
 ; start date[time], end date[time], type (OR/TIU)
 ; add ending time to EDT to ensure full day if no time
 S EDT=$S($G(EDT)'="":EDT,1:$$DT^XLFDT_.99999) S:$P(EDT,".",2)="" $P(EDT,".",2)="999999"
 ; default starting day is EDT-30
 S SDT=$S($G(SDT)'="":SDT,1:$$FMADD^XLFDT(EDT,-30))
 N CNT,GBL,IEN S CNT=0,GBL="^XTV(8992.1)" ;ICR#7063
 F  S SDT=$O(@GBL@("D",SDT)) Q:'+SDT!(SDT'<EDT)  D
 . S IEN="" F  S IEN=$O(@GBL@("D",SDT,IEN)) Q:'+IEN  D
 . . N F01,DATE,RECIPIENT,SERVICE,TIME,TITLE,TEXT S F01=$P(@GBL@(IEN,0),U) I F01["OR"!(F01["TIU") ; check alert type
 . . Q:'$T  ; quit if not OR/TIU alert
 . . I F01["ERR" Q  ; quit for TIU alert filing errors
 . . I $G(TYP)'="" Q:F01'[TYP
 . . N DIVISION I F01["OR" N ORDA,ORTYP S ORDA=+$$GET1^DIQ(8992.1,IEN,2),ORTYP=$P($P(F01,";"),",",3) D
 . . . I '+ORTYP S TEXT="NOTIFICATION TYPE UNKNOWN"
 . . . N HLOC,NODE0 S NODE0=$G(^OR(100,ORDA,0)) I NODE0="" S DIVISION="Order Data No Longer Available" Q
 . . . S HLOC=$$GET1^DIQ(100,ORDA,6) I HLOC="" S DIVISION="Location Data Not Available" Q
 . . . S DIVISION=$$GET1^DIQ(44,+$P(NODE0,U,10),3.5)_" ["_HLOC_"]" S:DIVISION="" DIVISION="Data Not Available"
 . . I F01["TIU" N TIUDA S TIUDA=$P($P(F01,";"),"TIU",2) D
 . . . I '$D(^TIU(8925,TIUDA,0)) S DIVISION="Document No Longer Available" Q
 . . . N HLOC S HLOC=$$GET1^DIQ(8925,TIUDA,1205) I HLOC="" S DIVISION="Location Data Not Available" Q
 . . . S DIVISION=$$GET1^DIQ(44,$$GET1^DIQ(8925,TIUDA,1205,"I"),3.5)_" ["_HLOC_"]" S:DIVISION="" DIVISION="Data Not Available"
 . . S DATE=$$FMTE^XLFDT($P(F01,";",3)),TIME=$P($P(DATE,"@",2),":",1,2),DATE=$$QM($P(DATE,"@"),$G(CSV))
 . . S:$G(TEXT)="" TEXT=$S(F01["OR":$P($G(^ORD(100.9,ORTYP,0)),U,1),1:$$TIU($$GET1^DIQ(8992.1,IEN,1.01)))
 . . S RECIPIENT="" F  S RECIPIENT=$O(@GBL@(IEN,20,"B",RECIPIENT)) Q:'+RECIPIENT  D
 . . . S CNT=CNT+1 I CNT=1,$D(CSV) S @ORX@(CNT)="IEN,RECIPIENT,TITLE,SERVICE,TIME,DATE,NOTIFICATION,DIVISION [LOCATION]",CNT=CNT+1
 . . . S @ORX@(CNT)=IEN_DELIM_$$QM($$GET1^DIQ(200,RECIPIENT,.01),$G(CSV))_DELIM_$$GET1^DIQ(200,RECIPIENT,8)_DELIM_$$GET1^DIQ(200,RECIPIENT,29) ; ICR #4329
 . . . S @ORX@(CNT)=@ORX@(CNT)_DELIM_TIME_DELIM_DATE_DELIM_TEXT_DELIM_DIVISION
 Q
DEV() ;
 W !,"The report may be sent to a Device, Mail Message, or Both."
 N DIRUT,DTOUT,DUOUT,DIR,X,Y
 S DIR("L",1)="     (D)evice"
 S DIR("L",2)="     (M)ail Message"
 S DIR("L")="     (B)oth"
 S DIR("A")="Enter Selection",DIR("B")="DEVICE"
 S DIR(0)="SO^D:DEVICE;M:MAIL MESSAGE;B:BOTH"
 D ^DIR S DEV=Y S:DEV="B" DEV="DM"
 Q DEV
MAIL(XMY) ;
 W !!,"The report must be sent to a DOMAIN.EXT e-mail address."
 N DIRUT,DTOUT,DUOUT,DIR,X,Y
M1 S DIR(0)="FO^^K:$$LOW^XLFSTR(X)'[""domain.ext"" X"
 S DIR("A")="Enter address",DIR("?")="Please enter a valid DOMAIN.EXT e-mail address or '^' to quit."
 W ! D ^DIR Q:$S(Y="":1,Y="^":1,1:0)  S XMY($$LOW^XLFSTR(Y))=""
 D
 . W !!,"Sending report to the following e-mail address:  ",$O(XMY(""))
 . N DIR,X,Y S DIR(0)="Y"
 . S DIR("A")="Is this correct",DIR("B")="YES"
 . W ! D ^DIR I $G(Y(0))="NO" K DIR,XMY G M1
 Q
QM(DATA,QM) ; for excel importing as csv, replace a single double quote with two double quotes
 I DATA[$C(34) N X S X("""")="""""" S DATA=$$REPLACE^XLFSTR(DATA,.X)
 Q $S(+$G(QM):$C(34)_DATA_$C(34),1:DATA)
TIU(X) ;
 Q $S(X["UNRELEASED":"Unreleased",X["UNSIG/UNCOS":"Unsigned/Uncosigned",X["UNSIGNED":"Unsigned",X["UNCOSIGNED":"Uncosigned",X["COMPLETED":"Additional Signature",1:"Unknown")
LU(FILE,NAME,FLAGS,SCREEN,INDEXES) ;
 Q $$FIND1^DIC(FILE,"",$G(FLAGS),NAME,$G(INDEXES),$G(SCREEN),"ERR")
