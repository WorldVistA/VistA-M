ORAERPT ; SPFO/AJB - Alert Enhancements Reports ;Dec 18, 2019@08:09:39
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**518**;Dec 17, 1997;Build 11
 Q
EN ; main entry point
 N DATA,DTRG,MENU,SETUP,TIME,TMP,TMP1,TOP10,TOTNTF,X,Y
 D PREP^XGF W IOCUON
 ; S DATA="DATA",TMP="TMP" ; use tmp global for safety
 S DATA=$NA(^TMP($J,"ORAERPT",$H)),TMP=$NA(^TMP($J,"ORAETMP",$H)),TMP1=$NA(^TMP($J,"ORMDIV",$H))
EN1 ; entry point for re-entering a date range
 D ASKRNG I '+DTRG("Start")!('+DTRG("Stop")) W ! Q  ; get date range
 W @IOF,!,"Gathering notification data..."
 S TIME("Start")=$$NOW^XLFDT
 S TOTNTF=0 D REPORT^ORALEAPI(.DATA,DTRG("Start"),DTRG("Stop"),"") ; get data for report
 S X=0 F  S X=$O(@DATA@(X)) Q:'+X  D
 . ; set data fields, use z to put blank entries at end of lists
 . N USR S USR=$P(@DATA@(X),U,2),USR=$S(USR="":"z<blank>",1:USR)
 . N TTL S TTL=$P(@DATA@(X),U,3),TTL=$S(TTL="":"z<blank>",1:TTL)
 . N SRV S SRV=$P(@DATA@(X),U,4),SRV=$S(SRV="":"z<blank>",1:SRV)
 . N DTE S DTE=$P(@DATA@(X),U,6),DTE=$S(DTE="":"z<date unknown>",1:DTE)
 . N NTF S NTF=$P(@DATA@(X),U,7),NTF=$S(NTF="":"z<blank>",1:NTF)
 . N DIV S DIV=$P(@DATA@(X),U,8),DIV=$S(DIV="":"z<blank>",1:DIV)
 . N LOC S LOC=$P(@DATA@(X),U,9),LOC=$S(LOC="":"z<blank>",1:LOC)
 . ; set ALL index
 . S @TMP@("ALL",USR,TTL,SRV,NTF,DIV,LOC)=$S($D(@TMP@("ALL",USR,TTL,SRV,NTF,DIV,LOC)):@TMP@("ALL",USR,TTL,SRV,NTF,DIV,LOC)+1,1:1)
 . ; total counts by type
 . S @TMP@("USR",USR)=$S($D(@TMP@("USR",USR)):@TMP@("USR",USR)+1,1:1)
 . S @TMP@("TTL",TTL)=$S($D(@TMP@("TTL",TTL)):@TMP@("TTL",TTL)+1,1:1)
 . S @TMP@("DTE",DTE)=$S($D(@TMP@("DTE",DTE)):@TMP@("DTE",DTE)+1,1:1)
 . S @TMP@("SRV",SRV)=$S($D(@TMP@("SRV",SRV)):@TMP@("SRV",SRV)+1,1:1)
 . S @TMP@("NTF",NTF)=$S($D(@TMP@("NTF",NTF)):@TMP@("NTF",NTF)+1,1:1)
 . S @TMP@("DIV",DIV)=$S($D(@TMP@("DIV",DIV)):@TMP@("DIV",DIV)+1,1:1)
 . S @TMP@("LOC",LOC)=$S($D(@TMP@("LOC",LOC)):@TMP@("LOC",LOC)+1,1:1)
 . ; total counts by division
 . S @TMP1@(DIV,"USR",USR)=$S($D(@TMP1@(DIV,"USR",USR)):@TMP1@(DIV,"USR",USR)+1,1:1)
 . S @TMP1@(DIV,"TTL",TTL)=$S($D(@TMP1@(DIV,"TTL",TTL)):@TMP1@(DIV,"TTL",TTL)+1,1:1)
 . S @TMP1@(DIV,"DTE",DTE)=$S($D(@TMP1@(DIV,"DTE",DTE)):@TMP1@(DIV,"DTE",DTE)+1,1:1)
 . S @TMP1@(DIV,"SRV",SRV)=$S($D(@TMP1@(DIV,"SRV",SRV)):@TMP1@(DIV,"SRV",SRV)+1,1:1)
 . S @TMP1@(DIV,"NTF",NTF)=$S($D(@TMP1@(DIV,"NTF",NTF)):@TMP1@(DIV,"NTF",NTF)+1,1:1)
 . S @TMP1@(DIV,"DIV",DIV)=$S($D(@TMP1@(DIV,"DIV",DIV)):@TMP1@(DIV,"DIV",DIV)+1,1:1)
 . S @TMP1@(DIV,"LOC",LOC)=$S($D(@TMP1@(DIV,"LOC",LOC)):@TMP1@(DIV,"LOC",LOC)+1,1:1)
 . ; total # of notifications
 . S @TMP@(1,"TOTAL")=$S($D(@TMP@(1,"TOTAL")):(@TMP@(1,"TOTAL")+1),1:1)
 ;
 S TIME("Stop")=$$NOW^XLFDT,TIME("Total")=$FN($$FMDIFF^XLFDT(TIME("Start"),TIME("Stop"),2),"-") ; timing information
 S TIME("Minutes")=TIME("Total")\60,TIME("Seconds")=TIME("Total")#60,TIME("Elapsed")=""
 S:+TIME("Minutes") TIME("Elapsed")=TIME("Minutes")_" minute(s) "
 S:+TIME("Seconds") TIME("Elapsed")=TIME("Elapsed")_TIME("Seconds")_" second(s)"
 S:+TIME("Elapsed")=0 TIME("Elapsed")="<1 second" S:+TIME("Total")=0 TIME("Total")=1
 ;
 I DTRG("Stop")[".999999" S $P(DTRG("Stop"),".",2)="2400"
 W IOCUON
 I +$G(@TMP@(1,"TOTAL"))=0 D  G EN1 ; re-enter date range for zero results
 . W !!,"No results found.  Please enter another date range.",!
 ;
 ;D
 ;. N AVG,DIFF S DIFF=$$FMDIFF^XLFDT(DTRG("Stop"),DTRG("Start"),1) S DIFF=DIFF_$S(DIFF>1:" days",1:" day")
 ;. I +DIFF=0 S DIFF=$$FMDIFF^XLFDT(DTRG("Stop"),DTRG("Start"),2),DIFF=DIFF/3600_" hours" S:+DIFF=1 DIFF="1 hour" S:+DIFF=24 DIFF="1 day"
 ;. W !!,"                       Elapsed Time:",?(38+$L(TOTNTF)-$S(+TIME("Elapsed"):$L(+TIME("Elapsed")),1:2)),TIME("Elapsed")
 ;. W !,"               Length of Date Range:  ",?(38+$L(TOTNTF)-$L(+DIFF)),DIFF
 ;. W !,"             Notifications Searched:  ",TOTNTF
 ;. W !,"      Notifications Searched/Second:  ",?(38+$L(TOTNTF)-$L($FN(TOTNTF/TIME("Total"),"",0))),$FN(TOTNTF/TIME("Total"),"",0)
 ;. W !,"    OE/RR & TIU Notifications Found:  ",?(38+$L(TOTNTF)-$L(@TMP@(1,"TOTAL"))),@TMP@(1,"TOTAL")
 ;. S AVG("TOTAL")=TOTNTF\$S(DIFF["hour":1,1:+DIFF),AVG("ORTIU")=@TMP@(1,"TOTAL")\$S(DIFF["hour":1,1:+DIFF)
 ;. W !,"          Average Notifications/Day:  ",?(38+$L(TOTNTF)-$L(AVG("ORTIU"))),AVG("ORTIU"),!
 ;
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 D CRTOP10 ; pre-load top10 list for filter default values (default is highest by count per type)
 F  D  Q:$D(DIRUT)!$D(DTOUT)!$D(DUOUT)
 . S DIR(0)="SA^S:SUMMARY;T:TOP10;F:FILTERED;Q:QUIT"
 . S DIR("A")="Select report type: ",DIR("B")="SUMMARY"
 . W:'+TOTNTF @IOF S TOTNTF=""
 . D ^DIR Q:$D(DIRUT)!$D(DTOUT)!$D(DUOUT)  I Y(0)="QUIT" S DTOUT=1 Q
 . I Y(0)="TOP10" S Y(0)="TOP10(0)"
 . I Y(0)="FILTERED" S Y(0)="FILTERED^ORAERPT1"
 . D @Y(0)
 ;
 K @DATA,@TMP,@TMP1 D CLEAN,CLEAN^XGF ; clean up
 Q
SETUP ;  create entries in PROTOCOL file
 ; adds menus and actions based on data for filter selection
 Q:+$G(SETUP)  ; don't do it again if you've alredy done it
 N ACTION,MENU,TYP
 F TYP="FILTER","NTF","USR","TTL","SRV","DIV","LOC" D
 . ; create a MENU for each type
 . S MENU(TYP)=$$GIEN("ORAE MENU "_TYP_" "_$J)
 . N ERR,FDA
 . S FDA(101,MENU(TYP)_",",4)="M"
 . S FDA(101,MENU(TYP)_",",5)=DUZ
 . D UPDATE^DIE("","FDA","","ERR")
 . ; create an ACTION for each type (except FILTER)
 . I TYP="FILTER" Q
 . S ACTION(TYP)=$$GIEN("ORAE ACTION "_TYP_" "_$J)
 . S FDA(101,ACTION(TYP)_",",1)=$S(TYP="NTF":"NOTIFICATION",TYP="USR":"RECIPIENT",TYP="TTL":"TITLE",TYP="SRV":"SERVICE",TYP="DIV":"DIVISION",TYP="LOC":"LOCATION",1:"FILTER")
 . S FDA(101,ACTION(TYP)_",",4)="A"
 . S FDA(101,ACTION(TYP)_",",5)=DUZ
 . S FDA(101.02,"+1,"_ACTION(TYP)_",",.01)=TYP
 . D UPDATE^DIE("","FDA","","ERR") D
 . . ; add ACTION to FILTER MENU
 . . S FDA(101.01,"+1,"_MENU("FILTER")_",",.01)=ACTION(TYP)
 . . D UPDATE^DIE("","FDA","","ERR")
 . ; add data entries as ACTIONs
 . N CNT,IEN,ITM S CNT=0,ITM="" F  S ITM=$O(@TMP@(TYP,ITM)) Q:ITM=""  D
 . . S CNT=CNT+1
 . . N ENTRY S ENTRY=$$GIEN("ORAE "_TYP_" "_$TR(ITM,"z<","<")_" "_$J)
 . . S FDA(101,ENTRY_",",1)=$TR(ITM,"z<","<") ; item text
 . . S FDA(101,ENTRY_",",3)=CNT ; sequence
 . . S FDA(101,ENTRY_",",4)="A" ; type
 . . S FDA(101,ENTRY_",",5)=DUZ ; creator
 . . D UPDATE^DIE("","FDA","IEN","ERR")
 . . S FDA(101.01,"+1,"_MENU(TYP)_",",.01)=ENTRY
 . . S FDA(101.01,"+1,"_MENU(TYP)_",",2)=CNT
 . . D UPDATE^DIE("","FDA","","ERR")
 S SETUP=1
 Q
GIEN(NAME) ; get an IEN from #101
 N DA,DO,DIC,DLAYGO,X,Y
 S (DIC,DLAYGO)=101,DIC(0)="F",X=NAME D FILE^DICN
 Q +Y
SUMMARY(MDIV) ;
 N CNT,SAVE,TXT,X,Y
 I +$G(MDIV) S SAVE("TXT")="" D DPSUMM(.TXT) W ! D EN^XUTMDEVQ("DISPLAY^ORAERPT(.TXT)","Summary Report",.SAVE) Q
 W ! I '$$READ^ORPARMG1("Y","Would you like SUMMARY data by DIVISION","NO") D SUMMARY(1) Q
 N DEFAULT D SETUP ; create entries in protocol file, in case filtered option/top10 hasn't been run yet
 S DEFAULT=$P(TOP10("DIV",1),U)
 S MDIV=$$ASK^ORAERPT(.MDIV,"A",DEFAULT,"ORAE MENU DIV "_$J,"DIVISION:  ","D HELP1^ORAEHLP") Q:MDIV'>0
 I +MDIV,$P(MDIV(1),U,4)="ALL" D DPSUMM(.TXT) W ! D EN^XUTMDEVQ("DISPLAY^ORAERPT(.TXT)","Summary Report",.SAVE) Q  ; don't bother if they select ALL, normal summary
 ;
 S MDIV=0 F  S MDIV=$O(MDIV(MDIV)) Q:'+MDIV  D
 . N DIV S DIV=$P(^ORD(101,$P(MDIV(MDIV),U,2),0),U,2) Q:DIV=""  ; set to data from File #101
 . D DPSUMM(.TXT,DIV)
 W ! D EN^XUTMDEVQ("DISPLAY^ORAERPT(.TXT)","Summary Report",.SAVE)
 Q
DPSUMM(TXT,DIV) ; setup summary data to display
 N CNT,LOC,X,Y
 S CNT=+$O(TXT(""),-1) ; get last line number
 S CNT=CNT+1,TXT(CNT)=$$CJ^XLFSTR("Notification Data [SUMMARY"_$S($G(DIV)="":"]",1:" for "_DIV_"]"),IOM),CNT=CNT+1,TXT(CNT)=""
 S CNT=CNT+1,TXT(CNT)=$$CJ^XLFSTR($$FMTE^XLFDT(DTRG("Start"))_" to "_$$FMTE^XLFDT(DTRG("Stop")),IOM),CNT=CNT+1,TXT(CNT)=""
 S LOC=$S(+$D(DIV):TMP1,1:TMP) S:$G(DIV)'="" $P(LOC,")")=$P(LOC,")")_",DIV" ; set where to look at the data
 F X="NTF","USR","TTL","SRV","DIV","LOC" D
 . S Y=$S(X="NTF":"Notification",X="USR":"Recipient",X="TTL":"Title",X="SRV":"Service",X="DIV":"Division",X="LOC":"Location")
 . S CNT=CNT+1,TXT(CNT)=Y,TXT(CNT)=$$SETSTR^VALM1("Total",TXT(CNT),34,5),TXT(CNT)=$$SETSTR^VALM1(Y,TXT(CNT),40,$L(Y)),TXT(CNT)=$$SETSTR^VALM1("Total",TXT(CNT),75,5)
 . S $P(TXT,"=",IOM-1)="",$P(TXT,"=",39)=" ",CNT=CNT+1,TXT(CNT)=TXT
 . N I S I=0,Y="" F  S Y=$O(@LOC@(X,Y)) Q:Y=""  D
 . . S I=I+1
 . . I I#2'=0 S CNT=CNT+1,TXT(CNT)=$S($E(Y)="z":$E(Y,2,31),1:$E(Y,1,30)),TXT(CNT)=$$SETSTR^VALM1(@LOC@(X,Y),TXT(CNT),(39-$L(@LOC@(X,Y))),$L(@LOC@(X,Y)))
 . . I I#2=0 S TXT(CNT)=$$SETSTR^VALM1($S($E(Y)="z":$E(Y,2,31),1:$E(Y,1,30)),TXT(CNT),40,$L(Y)),TXT(CNT)=$$SETSTR^VALM1(@LOC@(X,Y),TXT(CNT),(IOM-$L(@LOC@(X,Y))),$L(@LOC@(X,Y)))
 . S CNT=CNT+1,TXT(CNT)=""
 S CNT=CNT+1,TXT(CNT)="Total Notifications:  "_$S($G(DIV)="":@LOC@(1,"TOTAL"),1:@LOC@("DIV",DIV)),CNT=CNT+1,TXT(CNT)="     "
 Q
TOP10(MDIV) ;
 N CNT,SAVE,TXT,X,Y
 I +$G(MDIV) S SAVE("TXT")="" D DPTOP10(.TXT) W ! D EN^XUTMDEVQ("DISPLAY^ORAERPT(.TXT)","Top 10 Report",.SAVE) Q
 W ! I '$$READ^ORPARMG1("Y","Would you like TOP 10 data by DIVISION","NO") D TOP10(1) Q
 N DEFAULT D SETUP ; create entries in protocol file, in case the filtered option hasn't been run yet
 S DEFAULT=$P(TOP10("DIV",1),U)
 S MDIV=$$ASK^ORAERPT(.MDIV,"A",DEFAULT,"ORAE MENU DIV "_$J,"DIVISION:  ","D HELP1^ORAEHLP") Q:MDIV'>0
 I +MDIV,$P(MDIV(1),U,4)="ALL" D DPTOP10(.TXT) W ! D EN^XUTMDEVQ("DISPLAY^ORAERPT(.TXT)","Top 10 Report",.SAVE) Q  ; don't bother if they select ALL, just do the normal TOP 10
 ;
 S MDIV=0 F  S MDIV=$O(MDIV(MDIV)) Q:'+MDIV  D
 . N DIV S DIV=$P(^ORD(101,$P(MDIV(MDIV),U,2),0),U,2) Q:DIV=""  ; set to data from File #101
 . N TOP10,X,Y F X="NTF","USR","TTL","SRV","DIV","LOC" F Y=1:1:10 S TOP10(X,Y)=$$SETSTR^VALM1(" ","",20,1) ; set blank list
 . N CNT,ITM,TYP S TYP="" F  S TYP=$O(@TMP1@(DIV,TYP)) Q:TYP=""  S ITM="" F  S ITM=$O(@TMP1@(DIV,TYP,ITM)) Q:ITM=""  D
 . . S TOP10("TMP",TYP,@TMP1@(DIV,TYP,ITM),ITM)=""
 . F X="NTF","USR","TTL","SRV","DIV","LOC" S CNT=0,Y="" F  S Y=$O(TOP10("TMP",X,Y),-1) Q:'+Y!(CNT'<10)  S USR="" F  S USR=$O(TOP10("TMP",X,Y,USR)) Q:USR=""!(CNT'<10)  D
 . . S CNT=CNT+1,TOP10(X,CNT)=USR_U_Y ; only save 10 at most of descending values
 . K TOP10("TMP")
 . D DPTOP10(.TXT,DIV)
 . S CNT=$O(TXT(""),-1) S CNT=CNT+1,TXT(CNT)=" ",CNT=CNT+1,TXT(CNT)=" " ; add blank lines
 S SAVE("TXT")="" W ! D EN^XUTMDEVQ("DISPLAY^ORAERPT(.TXT)","Top 10 Report",.SAVE)
 Q
CRTOP10 ; create the default top 10 list, highest values by type are default selections for the filtered search
 N CNT,ITM,TYP,USR,X,Y
 F X="NTF","USR","TTL","SRV","DIV","LOC" F Y=1:1:10 S TOP10(X,Y)="  " ; set blank list
 S TYP="ALL" F  S TYP=$O(@TMP@(TYP)) Q:TYP=""  S ITM="" F  S ITM=$O(@TMP@(TYP,ITM)) Q:ITM=""  D
 . S TOP10("TMP",TYP,@TMP@(TYP,ITM),ITM)="" ; put all types in order, temporary list
 F X="NTF","USR","TTL","SRV","DIV","LOC" S CNT=0,Y="" F  S Y=$O(TOP10("TMP",X,Y),-1) Q:'+Y!(CNT'<10)  S USR="" F  S USR=$O(TOP10("TMP",X,Y,USR)) Q:USR=""!(CNT'<10)  D
 . S CNT=CNT+1,TOP10(X,CNT)=USR_U_Y ; only save 10 at most of descending values
 K TOP10("TMP") ; kill temporary list
 Q
DPTOP10(TXT,DIV) ; setup the top 10 list to display
 N CNT,X,Y
 S CNT=+$O(TXT(""),-1) ; get last line number
 S CNT=CNT+1,TXT(CNT)=$$CJ^XLFSTR("Top 10"_$S($D(DIV):" ["_DIV_"]",1:""),IOM),CNT=CNT+1,TXT(CNT)="     "
 ;S CNT=CNT+1,TXT(CNT)=$$CJ^XLFSTR("[Descending Order]",IOM),CNT=CNT+1,TXT(CNT)=""
 F X=1:1:3 F Y=1:1:10 D  I Y=10 S CNT=CNT+1,TXT(CNT)=""
 . I Y=1 S CNT=CNT+1,TXT(CNT)=$S(X=1:"Notification",X=2:"Title",X=3:"Division"),TXT(CNT)=$$SETSTR^VALM1("Total",TXT(CNT),34,5)
 . I  S TXT=$S(X=1:"Recipient",X=2:"Service",X=3:"Location"),TXT(CNT)=$$SETSTR^VALM1(TXT,TXT(CNT),40,$L(TXT)),TXT(CNT)=$$SETSTR^VALM1("Total",TXT(CNT),75,5)
 . I  S CNT=CNT+1,$P(TXT(CNT),"=",IOM-1)="",$P(TXT(CNT),"=",39)=" "
 . S CNT=CNT+1
 . S TXT=$NA(TOP10($S(X=1:"NTF",X=2:"TTL",X=3:"DIV"),Y))
 . S TXT(CNT)=$P(@TXT,U),TXT(CNT)=$S($E(TXT(CNT))="z":$E(TXT(CNT),2,32),1:TXT(CNT))
 . S TXT=$P(@TXT,U,2),TXT(CNT)=$$SETSTR^VALM1(TXT,TXT(CNT),(39-$L(TXT)),$L(TXT))
 . S TXT=$NA(TOP10($S(X=1:"USR",X=2:"SRV",X=3:"LOC"),Y))
 . S TXT(CNT)=$$SETSTR^VALM1($S($E($P(@TXT,U))="z":$E($P(@TXT,U),2,32),1:$P(@TXT,U)),TXT(CNT),40,$L($P(@TXT,U)))
 . S TXT(CNT)=$$SETSTR^VALM1($P(@TXT,U,2),TXT(CNT),(IOM-$L($P(@TXT,U,2))),$L($P(@TXT,U,2)))
 ;S CNT=CNT+1,TXT(CNT)="Total Notifications:  "_@TMP1@(DIV,"DIV",DIV)
 S CNT=CNT+1,TXT(CNT)="Total Notifications:  "_$S($G(DIV)="":@TMP@(1,"TOTAL"),1:@TMP1@(DIV,"DIV",DIV))
 Q
ASKRNG ; ask user for the date range
 W "Enter the desired date range for the notification search.",!!
 W "Search times typically vary from 30-90 seconds for each day searched.",!
 S (DTRG("Start"),DTRG("Stop"))=""
 D  I '+DTRG("Start")!('+DTRG("Stop")) W ! Q
 . N %DT,DIR,X,Y S %DT(0)=-$$DT^XLFDT_".24",%DT="AETX",%DT("A")="Select Beginning DATE: ",%DT("B")=$$FMTE^XLFDT($$FMADD^XLFDT(DT,-30))
 . D ^%DT K %DT Q:Y<0  S DTRG("Start")=Y
 . S %DT(0)=DTRG("Start"),%DT="AETX",%DT("A")="          Ending DATE: ",%DT("B")=$$FMTE^XLFDT(DT)
 . W ! D ^%DT Q:Y<0  S DTRG("Stop")=Y S:$P(DTRG("Stop"),".",2)="" $P(DTRG("Stop"),".",2)="999999"
 Q
CLEAN ; S DATA=$NA(^TMP($J,"ORAERPT",$H)),TMP=$NA(^TMP($J,"ORAETMP",$H))
 N DA,DIK,NAME,IEN,X,Y
 S NAME="ORAE" F  S NAME=$O(^ORD(101,"B",NAME)) Q:NAME'["ORAE"  S IEN=0 F  S IEN=$O(^ORD(101,"B",NAME,IEN)) Q:'+IEN  D
 . Q:NAME'[$J
 . S DA=IEN,DIK="^ORD(101," D ^DIK
 Q
ASK(Y,PARAM,DEFAULT,MENU,PROMPT,HELP) ;
 N I,X,XQORM
 S XQORM=+$O(^ORD(101,"B",MENU,0))_";ORD(101,"
 I '+XQORM Q "-1^Menu entry not found."
 S XQORM(0)=$G(PARAM),XQORM("A")=PROMPT,XQORM("B")=DEFAULT,XQORM("?")=$S($G(HELP)="":"D HELP^ORAEHLP",1:HELP)
 D EN^XQORM
 Q $G(Y)
DISPLAY(OUTPUT) ;
 N END,Y S (END,Y)=0
 D:$E(IOST,1,2)="C-" HDR2
 F  S Y=$O(OUTPUT(Y)) Q:'+Y!(+END)  D
 . D HDR1:$Y+3>IOSL Q:+END  W OUTPUT(Y),!
 Q:+END
 I $E(IOST,1,2)="C-",IOSL'>24 F  Q:$Y+3>IOSL  W !
 R:$E(IOST,1,2)="C-" !,"Report Complete.  Press <Enter> to continue ",X:DTIME
 Q
HDR1 ;
 I $E(IOST,1,2)="C-" D
 . R !,"Press <ENTER> to continue or '^' to exit ",X:DTIME S END='$T!(X=U)
 Q:+END
HDR2 ;
 I $E(IOST,1,2)="C-" D
 . W @IOF
 . I +$D(HDR) S X=0 F  S X=$O(HDR(X)) Q:'+X  W HDR(X),!
 W IOUOFF
 Q
