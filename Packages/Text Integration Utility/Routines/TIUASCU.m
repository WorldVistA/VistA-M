TIUASCU ; SPFO/AJB - ADDITIONAL SIGNER CLEANUP ;05/13/22  10:24
 ;;1.0;TEXT INTEGRATION UTILITIES;**254**;Jun 20, 1997;Build 9
 ;
 ; External reference to File ^DPT supported by IA 10035
 ; External reference to File ^VA supported by IA 10060
 Q
EN ;
 N C,DATE,LOC,POP,X,Y D HOME^%ZIS,PREP^XGF S DT=$$DT^XLFDT
 S $P(DATE("Begin"),U)=$P($O(^TIU(8925.7,"AC",0)),"."),$P(DATE("End"),U)=$P($O(^TIU(8925.7,"AC",""),-1),".")_".999999"
 S $P(DATE("Begin"),U,2)=$$FMTE^XLFDT(+DATE("Begin")),$P(DATE("End"),U,2)=$$FMTE^XLFDT(+DATE("End"))
 I '+DATE("Begin"),'+$O(^XTMP("TIUASCU",0)) W !,"No outstanding signatures or reports to view.",! D FMR("EA","Press <Enter> to continue. ") Q
 F X=1:1 S Y=$P($T(INTRO+X),";;",2) Q:Y="EOM"  W @Y,!
 F  Q:$Y+4>24  W !
 D FMR("EA"," Press <Enter> to continue. ")
 S LOC=$NA(^XTMP("TIUASCU")),@LOC@(0)=$$FMADD^XLFDT(DT,7)_U_DT_U_"Additional Signer Report"
 ;S LOC=$NA(@LOC@($J)) ; job/session location
 F  D  Q:X="^"
 . N ACTION,CNT,DIR,USER D CLS
 . F X=0:1 S Y=$P($T(MENU+X),";;",2) Q:Y=""  D
 . . I $P(Y,U,2)="" W IOUON_$$CJ^XLFSTR(Y,IOM)_IOUOFF,! Q
 . . I Y["VIEW",'+$O(^XTMP("TIUASCU",0)) Q
 . . I Y["GENERATE"!(Y["REMOVE")!(Y["BOTH"),'+DATE("Begin") Q
 . . S CNT=+$G(CNT)+1,ACTION(CNT)=Y
 . . W !,?24,CNT_"  "_$P(Y,U)
 . . S $P(DIR,";",CNT)=CNT_":"_$P(Y,U)
 . S DIR="SAO^"_DIR W ! S (ACTION,X)=$$FMR(DIR,"What would you like to do? ","QUIT") Q:'X  I ACTION["QUIT" S X=U Q
 . X $P(ACTION(+ACTION),U,2) Q:+X'>0
 . ; confirm user input
 . W ! S X=$$FMR("YA",$P(ACTION,U,2)_$S(+$G(USER):" for "_$E($P(USER,U,2),1,20)_" as the addtional signer? ",1:" from "_$P(DATE("Begin"),U,2)_" to "_$P(DATE("End"),U,2)_"? "),"NO") Q:'X
 . I $D(@LOC@("Start Time")),'$D(@LOC@("Elapsed")) W !!,"The task for Job #"_$J_" is still running." W ! D FMR("EA","Press <Enter> to continue. ") S X="" Q
 . N ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK S ZTDESC="Additional Signer Cleanup [TIU]",ZTDTH=+$H_","_($P($H,",",2)+3),ZTIO=""
 . S ZTSAVE("ACTION")="",ZTSAVE("DATE(""Begin"")")="",ZTSAVE("DATE(""End"")")="",ZTSAVE("DUZ")="",ZTSAVE("LOC")="",ZTSAVE("USER")=""
 . S ZTRTN="TASK^TIUASCU(.X,.ACTION,.DATE,.LOC,.USER)" D ^%ZTLOAD W:+$G(ZTSK) !!,"Task #",$G(ZTSK)
 . ;D TASK(.X,ACTION,.DATE,LOC,.USER) Q:'+X  ; for testing
 . W ! D FMR("EA","Press <Enter> to continue. ")
EXIT ;
 D CLEAN^XGF
 Q
 ;
TASK(X,ACTION,DATE,LOC,USER) ;
 S LOC=$NA(@LOC@(($O(@LOC@(""),-1)+1))) ; increment location
 N Y I ACTION["REMOVE" N INF S LOC="INF"
 K @LOC S @LOC@("Start Time")=$H
 S DATE("Begin")=$G(DATE("Begin"),$P($O(^TIU(8925.7,"AC",0)),"."))
 S DATE("End")=$G(DATE("End"),$P($O(^TIU(8925.7,"AC",""),-1),".")_".999999")
 S Y=$P($$FMTE^XLFDT($$NOW^XLFDT,2),"@") F X=1:1:3 S:$L($P(Y,"/",X))'=2 $P(Y,"/",X)="0"_$P(Y,"/",X)
 S @LOC@("Info")=$P($G(^VA(200,DUZ,0)),U)_U_Y_"@"_$P($$FMTE^XLFDT($$NOW^XLFDT,2),"@",2)
 S $P(@LOC@("Info"),U,3)=$S(+$G(USER):$P(USER,U,2),1:$$FMTE^XLFDT(+DATE("Begin"),2)_U_$$FMTE^XLFDT($P(+DATE("End"),"."),2))
 S ZTREQ="@"
 N EDT S EDT=+$G(DATE("Begin"),"") F  S EDT=$O(^TIU(8925.7,"AC",EDT)) Q:'+EDT!(EDT>+DATE("End"))  D
 . N TIUDA S TIUDA=0 F  S TIUDA=$O(^TIU(8925.7,"AC",EDT,TIUDA)) Q:'+TIUDA  D
 . . N IEN S IEN=0 F  S IEN=$O(^TIU(8925.7,"AC",EDT,TIUDA,IEN)) Q:'+IEN  D
 . . . I '$D(^TIU(8925.7,IEN)) K ^TIU(8925.7,"AC",EDT,TIUDA,IEN) Q  ; remove index if entry doesn't exist
 . . . N NODE S NODE(8925.7,0)=$G(^TIU(8925.7,IEN,0)) Q:NODE(8925.7,0)=""  Q:TIUDA'=+NODE(8925.7,0)  ; don't get me started
 . . . I +$G(USER),+USER'=$P(NODE(8925.7,0),U,3) Q  ; additional signer '= user
 . . . S @LOC@("Total")=$G(@LOC@("Total"))+1 ; total # of outstanding signatures
 . . . I ACTION'["GENERATE" D  I ACTION["REMOVE" Q
 . . . . N DA,DIK S DA=IEN,DIK="^TIU(8925.7," D ^DIK K ^TIU(8925.7,"AC",EDT,TIUDA,DA) ; kill logic forgot about "AC"
 . . . . N D0,DILOCKTM,DISYS,FDA,TIUDIV1,TIUPRM0,TIUPRM1 ; variables left by TIUALRT (ugh)
 . . . . D SEND^TIUALRT(TIUDA)
 . . . N DATA S DATA=$P($G(NODE(8925.7,0)),U,3) S:+DATA DATA=$E($P($G(^VA(200,DATA,0)),U),1,30) S DATA=$G(DATA,"<unknown>")
 . . . S $P(@LOC@("DATA",@LOC@("Total")),U)=$$QM(DATA,1) ; additional signer
 . . . S NODE(8925,0)=$G(^TIU(8925,TIUDA,0)),NODE(8925,12)=$G(^TIU(8925,TIUDA,12)) ; nodes
 . . . S DATA=+NODE(8925,0) S:+DATA DATA=$E($P($G(^TIU(8925.1,DATA,0)),U),1,60) S DATA=$G(DATA,"<unknown>")
 . . . S $P(@LOC@("DATA",@LOC@("Total")),U,2)=$$QM(DATA,1) ; title
 . . . S DATA=$P(NODE(8925,12),U) S:+DATA DATA=$$FMTE^XLFDT(DATA) S DATA=$G(DATA,"<unknown>")
 . . . S $P(@LOC@("DATA",@LOC@("Total")),U,3)=$$QM(DATA,1) ; entry date/time
 . . . S DATA=$P(NODE(8925,12),U,4) S:+DATA DATA=$E($P($G(^VA(200,DATA,0)),U),1,30) S DATA=$G(DATA,"<unknown>")
 . . . S $P(@LOC@("DATA",@LOC@("Total")),U,4)=$$QM(DATA,1) ; expected signer
 . . . I +$P(NODE(8925,12),U,8) D  ; expected cosigner
 . . . . S DATA=$P(NODE(8925,12),U,8),DATA=$E($P($G(^VA(200,DATA,0)),U),1,30) S DATA=$G(DATA,"<unknown>")
 . . . . S $P(@LOC@("DATA",@LOC@("Total")),U,5)=$$QM(DATA,1) ; expected cosigner
 . . . S DATA=$P(NODE(8925,0),U,2) S:+DATA DATA=$E($P($G(^DPT(DATA,0)),U),1,30) S DATA=$G(DATA,"<unknown>")
 . . . S $P(@LOC@("DATA",@LOC@("Total")),U,6)=$$QM(DATA,1) ; patient
 . . . S:ACTION'["GENERATE" $P(@LOC@("DATA",@LOC@("Total")),U,7)=$$QM($$FMTE^XLFDT($$NOW^XLFDT),1) ; date removed
 . . . S @LOC@("DATA",@LOC@("Total"))=$TR(@LOC@("DATA",@LOC@("Total")),U,",") ; replace ^ with , for delimiter
 S @LOC@("Start Date")=$P(DATE("Begin"),U,2),@LOC@("End Date")=$P(DATE("End"),U,2)
 S @LOC@("Stop Time")=$H,@LOC@("Elapsed")=$$CONVERT($$HDIFF^XLFDT(@LOC@("Stop Time"),@LOC@("Start Time"),2))
 S @LOC@("Start Time")=$$HTE^XLFDT(@LOC@("Start Time")),@LOC@("Stop Time")=$$HTE^XLFDT(@LOC@("Stop Time"))
 D MAIL(LOC,$P(ACTION,U,2)) ; mail the completion message
 ; reset date range
 S $P(DATE("Begin"),U)=$P($O(^TIU(8925.7,"AC",0)),"."),$P(DATE("End"),U)=$P($O(^TIU(8925.7,"AC",""),-1),".")_".999999"
 S $P(DATE("Begin"),U,2)=$$FMTE^XLFDT(+DATE("Begin")),$P(DATE("End"),U,2)=$$FMTE^XLFDT(+DATE("End"))
 Q
 ;
VIEW(X) ;
 I '+$O(^XTMP("TIUASCU",0)) W !!,"There are no reports to view.",! S X="" D FMR("EA","Press <Enter> to continue.") Q
 D CLS N DIR,LOC,TXT,Y S X=0 F  S X=$O(^XTMP("TIUASCU",X)) Q:'X  D  ; sort reports
 . S LOC=$NA(^XTMP("TIUASCU",X)) I '$D(@LOC@("Elapsed")) Q  ; task running
 . S LOC($P(@LOC@("Info"),U,2)_U_X)=""
 F X=1:1 S TXT=$P($T(RPT+X),";;",2) Q:TXT="EOM"  W:$P($T(RPT+(X+1)),";;",2)="EOM" IOUON W !,TXT W:$P($T(RPT+(X+1)),";;",2)="EOM" IOUOFF
 S (X,Y)=0 F  S X=$O(LOC(X)) Q:'X  D
 . S Y=Y+1,$P(DIR,";",Y)=Y_":Job #"_$P(X,U,2)
 . S LOC=$NA(^XTMP("TIUASCU",$P(X,U,2)))
 . S Y=$$SETSTR($E($P(@LOC@("Info"),U),1,24),Y,5,24) ; generated by
 . S Y=$$SETSTR($P(@LOC@("Info"),U,2),Y,30,29) ; date/time
 . S Y=$$SETSTR($TR($E($P(@LOC@("Info"),U,3,4),1,20),U,"-"),Y,(IOM-$E($L($P(@LOC@("Info"),U,3,4)),1,20)),$L($TR($E($P(@LOC@("Info"),U,3,4),1,20),U,"-"))) ; type
 . W !,?1,Y
 S DIR="SAO^"_DIR W ! S X=$$FMR(DIR," Which report would you like to display? ") Q:'X
 S LOC=$NA(^XTMP("TIUASCU",$P(X,"#",2)))
 I '$D(@LOC@("Total")) D  S X="" Q
 . W !!," There are no results for this criteria:  ",$TR($E($P($G(@LOC@("Info")),U,3,4),1,20),U,"-"),! ;K @LOC ; user input to leave entries with no results
 . D FMR("EA"," Press <Enter> to continue.")
 N POP,ZTSAVE S ZTSAVE(LOC)="" D CLS
 W IOCUON,"This output is designed for up to 255 characters per row.",!
 W !,"Example DEVICE input:  ;255;999999",!
 D EN^XUTMDEVQ("DISPLAY^TIUASCU(LOC)","Additional Signer Report",.ZTSAVE) I +$G(POP) S X="" Q
 W ! D FMR("EA","Press <Enter> to continue.") S X=""
 Q
 ;
DISPLAY(LOC) ;
 I IOST["C-VT" D FMR("EA","To capture the report output, start logging now and press <Enter> to begin.") W @IOF
 W """ADDITIONAL SIGNER"",""TITLE"",""ENTRY DATE/TIME"",""EXPECTED SIGNER"",""EXPECTED COSIGNER"",""PATIENT"",""DATE REMOVED"""
 S X=0 F  S X=$O(@LOC@("DATA",X)) Q:'+X  W !,@LOC@("DATA",X)
 I IOST["C-VT",$O(@LOC@("DATA",""),-1)<10 S X="",$P(X," ",IOM)=" " F  Q:$Y+4>24  W !,X
 Q
 ;
MAIL(LOC,ACTION) ;
 N %,D0,D1,D2,DG,DIC,DICR,DILOCKTM,DISYS,DIW ; left over by ^xmd call
 N CNT,XMDUN,XMDUZ,XMSUB,XMTEXT,XMY,XMZ
 S XMDUZ=.5,XMTEXT="XMTEXT(",XMSUB="Additional Signer Cleanup" ; subject
 S XMY(DUZ)="" ; ,XMY("andrew.bakke@domain.ext")="" ; recipients
 D ADD(.XMTEXT,.CNT,"Task is complete.  You may view the report now via the option.")
 D ADD(.XMTEXT,.CNT,"")
 D ADD(.XMTEXT,.CNT,"Mode:          "_$S(ACTION["REMOVE":"Remove",ACTION["GENERATE":"Report",1:"Remove & Report"))
 D ADD(.XMTEXT,.CNT,"Total #:       "_$G(@LOC@("Total"),0))
 D:'+$G(USER) ADD(.XMTEXT,.CNT,"Date Range:    "_@LOC@("Start Date")_"-"_@LOC@("End Date"))
 D:+$G(USER) ADD(.XMTEXT,.CNT,"User:          "_$P(USER,U,2))
 D ADD(.XMTEXT,.CNT,"Elapsed Time:  "_@LOC@("Elapsed"))
 D ^XMD
 Q
 ;
ADD(LOC,CNT,DATA) ; add line of data to location
 S CNT=+$G(CNT)+1,LOC(CNT)=DATA
 Q
 ;
CLS N X F X=1:1:(IOSL+1) W ! I X=(IOSL+1) D IOXY^XGF(0,0) ; clear screen
 Q
 ;
CONVERT(SEC) ; convert seconds to hours/minutes/seconds
 Q:SEC'>60 $FN(SEC,"",2)_" sec"
 Q:SEC'>3600 (SEC\60)_" min "_$S($L($FN((SEC#60),"",0))'>1:"0"_$FN((SEC#60),"",0),1:$FN((SEC#60),"",0))_" sec"
 Q (SEC\3600)_" hr "_((SEC#3600)\60)_" min "_$S($L($FN(((SEC#3600)#60),"",0))'>1:"0"_$FN(((SEC#3600)#60),"",0),1:$FN(((SEC#3600)#60),"",0))_" sec"
 ;
DATE(X,DATE) ; ask user for begin & end date of search
 S $P(DATE("Begin"),U)=$P($O(^TIU(8925.7,"AC",0)),"."),$P(DATE("End"),U)=$P($O(^TIU(8925.7,"AC",""),-1),".")
 S $P(DATE("Begin"),U,2)=$$FMTE^XLFDT(+DATE("Begin")),$P(DATE("End"),U,2)=$$FMTE^XLFDT(+DATE("End"))
 I '+DATE("Begin") W !!,"  No outstanding additional signatures." S X="" Q
 W ! F X="Begin","End" D  S:'+DATE(X) X="^" Q:X="^"  S:X="End" X=1
 . N HELP S HELP="    Enter a date from "_$P(DATE("Begin"),U,2)_" to "_$P(DATE("End"),U,2)
 . S DATE(X)=$$FMR("DOA^"_+DATE("Begin")_":"_+DATE("End"),$S(X="Begin":"    Starting ",1:"      Ending ")_"Date: ",$S(X="Begin":$$FMTE^XLFDT(DATE("Begin")),1:$$FMTE^XLFDT(DATE("End"))),HELP)
 . Q:'+DATE(X)  S:X="End" $P(DATE(X),U)=DATE(X)+.999999
 Q
 ;
FLU(FILE) ; file lookup
 N DIC,DILOCKTM,DISYS,FINFO,X,Y
 D FILE^DID(FILE,,"NAME;GLOBAL NAME","FINFO")
 S DIC=FINFO("GLOBAL NAME"),DIC(0)="AEMQ",DIC("A")="Select "_FINFO("NAME")_": "
 D ^DIC
 Q $S(X="^":"^",X="":"",1:Y)
 ;
FMR(DIR,PRM,DEF,HLP,SCR) ; fileman reader
 N DILN,DILOCKTM,DISYS
 N DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)=DIR S:$G(PRM)'="" DIR("A")=PRM S:$G(DEF)'="" DIR("B")=DEF S:$G(SCR)'="" DIR("S")=SCR
 I $G(HLP)'="" S DIR("?")=HLP
 I $D(HLP) M DIR=HLP
 W $G(IOCUON) D ^DIR W $G(IOCUOFF)
 Q $S(X="":"",$D(DIROUT):U,$D(DIRUT):U,$D(DTOUT):U,$D(DUOUT):U,1:Y_U_Y(0))
 ;
QM(DATA,QM) ; quote me
 I DATA[$C(34) N X S X("""")="""""" S DATA=$$REPLACE^XLFSTR(DATA,.X)
 Q $S(+$G(QM):$C(34)_DATA_$C(34),1:DATA)
 ;
SETSTR(S,V,X,L) ; -- insert text(S) into variable(V) at position (X) with length of (L)
 Q $E(V_$J("",X-1),1,X-1)_$E(S_$J("",L),1,L)_$E(V,X+L,999)
 ;
SETUP(X,DATE,USER) ; ask user for type of search
 W ! S X=$$FMR("SAO^1:Date Range;2:Additional Signer","  Search by DATE RANGE or ADDITIONAL SIGNER? ","Date Range") Q:'+X
 D:+X=1 DATE(.X,.DATE) Q:'+X
 D:+X=2 SIGNER(.X,.USER) Q:+X'>0
 Q
 ;
SIGNER(X,USER) ; lookup user from File #200
 W !,IOCUON S (USER,X)=$$FLU(200)
 Q
 ;
MENU ;;Additional Signer Utility
 ;;GENERATE a Report^D SETUP(.X,.DATE,.USER)
 ;;REMOVE Additional Signer(s)^D SETUP(.X,.DATE,.USER)
 ;;BOTH (Generate & Remove)^D SETUP(.X,.DATE,.USER)
 ;;VIEW Report(s)^D VIEW(.X)
 ;;QUIT^This is the end...
 ;;
INTRO ;
 ;;"VHA HANDBOOK 1907.01 defines the additional signer role as follows:"
 ;;""
 ;;"""Additional signer"" is a communication tool used to alert a clinician about"
 ;;"information pertaining to the patient.  This functionality is designed to"
 ;;"allow clinicians to call attention to specific documents and the recipient to"
 ;;"acknowledge receipt of the information.  Being identified as an additional"
 ;;"signer does not constitute a co-signature.  This nomenclature in no way implies"
 ;;"responsibility for the content of, or concurrence with, the note."""
 ;;""
 ;;""
 ;;"This utility provides options to report and/or remove outstanding additional"
 ;;"signers and the associated alerts by either date range or additional signer."
 ;;""
 ;;$$CJ^XLFSTR("** WARNING **",IOM)
 ;;""
 ;;IOBON_IORVON_"Removing additional signers from a document is PERMANENT and cannot be undone."_IORVOFF_IOBOFF
 ;;""
 ;;$$CJ^XLFSTR("** WARNING **",IOM)
 ;;""
 ;;EOM
RPT ; 01234567890123456789012345678901234567890123456789012345678901234567890123456789
 ;;The following report(s) are available:
 ;;
 ;;     Report
 ;; #   Generated By             Date@Time                                     Type
 ;;EOM
 ;
