TIUPS209 ; SLC/AJB - Active Titles Report & Cleanup v2; 06/01/06 ; 7/26/06 11:46am
 ;;1.0;TEXT INTEGRATION UTILITIES;**209,218**;Jun 20, 1997;Build 1
 ;
 Q
EN ; control segment
 N ANS,TIUOMIT
 W @IOF
 D ASKUSER(.ANS,"Inactivate the unused Document Titles at this time") Q:$G(ANS("EXIT"))="YES"
 D
 .N POP,TIUDESC,TIURTN,TIUSAVE
 .S TIUDESC="TIUPS209 Active Title Report & Cleanup",TIURTN="REPORT^TIUPS209",TIUSAVE("*")=""
 .W ! D EN^XUTMDEVQ(TIURTN,TIUDESC,.TIUSAVE)
 Q
REPORT ;
 N CNT,ENDDT,ENDTIME,GBL,LINE,LINETXT,STRDT,STRTIME,TIUDA,TMP,TOTTIME,TIUX,TIUY
 S STRTIME=$$NOW^XLFDT ; start time of search
RESTART ;
 S CNT=$NA(CNT) ; counters
 S GBL=$NA(^TIU(8925.1,"B")) ; global to be searched
 S TMP=$NA(^TMP("TIUPS209",$J)) ; sets temporary storage location
 S @CNT@("T#8925.1")=0 ; number of document titles in 8925.1
 S (TIUX,TIUY)=0 ; gets all document titles from 8925.1
 F  S TIUX=$O(@GBL@(TIUX)) Q:TIUX=""  F  S TIUY=$O(@GBL@(TIUX,TIUY)) Q:'+TIUY  D
 . I $P($G(^TIU(8925.1,TIUY,0)),U,4)="DOC" S @TMP@("B",TIUY)=0,@CNT@("T#8925.1")=@CNT@("T#8925.1")+1
 S GBL=$NA(^TIU(8925,"F")) ; global to be searched
 S STRDT=$P($$FMADD^XLFDT($$NOW^XLFDT,-365),".") ; start date to search
 S ENDDT=$P($$NOW^XLFDT,".")_".24" ; end date to search
 S @CNT@("T#8925")=0 ; number of documents searched in 8925
 S @CNT@("T#M0NODE")=0 ; number of documents with invalid .01 field
 S @CNT@("T#WT8925.1")=0 ; number of documents with incorrect .01 field (non title - 8925.1)
 S @CNT@("T#ADD8925.1")=0 ; number of document titles added due to wrong type
 S @CNT@("T#GDOCS")=0 ; number of documents
 S TIUDA=0
 F  S STRDT=$O(@GBL@(STRDT)) Q:'+STRDT!(STRDT>ENDDT)  F  S TIUDA=$O(@GBL@(STRDT,TIUDA)) Q:'+TIUDA  D
 . S @CNT@("T#8925")=@CNT@("T#8925")+1 ; count of documents searched
 . N TIUD0,TIUD12,TIUX S TIUD0=$G(^TIU(8925,TIUDA,0)),TIUD12=$G(^TIU(8925,TIUDA,12))
 . I '+TIUD0 S @TMP@("UNK",+TIUDA)="",@CNT@("T#M0NODE")=@CNT@("T#M0NODE")+1 Q  ; track documents with invalid .01 field
 . I $P($G(^TIU(8925.1,+TIUD0,0)),U,4)'="DOC" S TIUX=1,@CNT@("T#WT8925.1")=@CNT@("T#WT8925.1")+1,@TMP@("WRT",+TIUD0)=""
 . I '+$D(@TMP@("B",+TIUD0)) S @TMP@("B",+TIUD0)=0,@CNT@("T#ADD8925.1")=@CNT@("T#ADD8925.1")+1
 . S @TMP@("B",+TIUD0)=(+@TMP@("B",+TIUD0)+1) S:'+$G(TIUX) @CNT@("T#GDOCS")=@CNT@("T#GDOCS")+1
 . S @TMP@("B",+TIUD0)=@TMP@("B",+TIUD0)_U_+$P(TIUD12,".")_U_$P(TIUD12,U,2)_U_+TIUD0_U_$P(^TIU(8925.1,+TIUD0,0),U,7)
 S @CNT@("T#ERR8925.1")=0 ; number of errorneous document titles
 S @CNT@("T#U8925.1")=0 ; number of used document titles
 S @CNT@("T#UN8925.1")=0 ; number of unused document titles
 S TIUDA=0
 F  S TIUDA=$O(@TMP@("B",TIUDA)) Q:'+TIUDA  D
 . I +$L($P($G(^TIU(8925.1,TIUDA,0)),U))<3 S @CNT@("T#ERR8925.1")=@CNT@("T#ERR8925.1")+1,@TMP@("B.1",+TIUDA)="" Q
 . I +@TMP@("B",TIUDA) S @CNT@("T#U8925.1")=@CNT@("T#U8925.1")+1,@TMP@("RPT","USED",$$GET1^DIQ(8925.1,+TIUDA,.01))=@TMP@("B",+TIUDA) Q
 . S @CNT@("T#UN8925.1")=@CNT@("T#UN8925.1")+1,@TMP@("RPT","UNUSED",$$GET1^DIQ(8925.1,+TIUDA,.01))=$$GETLAST(+TIUDA)
 S ENDTIME=$$NOW^XLFDT,TOTTIME=$FN($$FMDIFF^XLFDT(STRTIME,ENDTIME,2)/60,"-")
 I $G(ANS("INACT"))="YES" D UPDATE K @TMP S ANS("INACT")="" G RESTART
 F LINE=1:1 S LINETXT=$P($T(RPT+LINE),";;",2) Q:LINETXT="EOM"  W !,@LINETXT
 S TIUX=""
 F TIUY="UNUSED","USED" F  S TIUX=$O(@TMP@("RPT",TIUY,TIUX)) Q:TIUX=""  D
 . N DATA,DISPLAY,STATUS,TITLE
 . S DATA=@TMP@("RPT",TIUY,TIUX)
 . I TIUY="UNUSED",$P(DATA,U,5)=13 Q  ; don't print unused/inactive titles
 . S STATUS=$S($P(DATA,U,5)=11:"",$P(DATA,U,5)=13:" [Inactive]",1:" [unknown]")
 . S TITLE=TIUX_STATUS,TITLE=$$WRAP^TIULS(TITLE,38)
 . S DISPLAY=$$SETSTR^VALM1($P(TITLE,"|"),"",1,38)
 . S DISPLAY=$$SETSTR^VALM1($$SPACER(+DATA,5,1),DISPLAY,40,5)
 . S DISPLAY=$$SETSTR^VALM1($$FMTE^XLFDT($P(DATA,U,2)),DISPLAY,47,12)
 . S DISPLAY=$$SETSTR^VALM1($S($P(DATA,U,3)="N/A":"N/A",1:$$GET1^DIQ(200,+$P(DATA,U,3),.01)),DISPLAY,61,18)
 . W !,DISPLAY
 . I $L(TITLE,"|")>1 F DATA=2:1:$L(TITLE,"|") W !,?2,$P(TITLE,"|",DATA)
 I +$D(@TMP@("B.1")) D
 . W !!,"The following IENs from File #8925.1 have an invalid #.01 Field.",!
 . S TIUDA=0 F  S TIUDA=$O(@TMP@("B.1",TIUDA)) Q:'+TIUDA  W !,TIUDA
 I +$D(@TMP@("WRT")) D
 . W !!,"The following IENs from File #8925.1 have an incorrect #.04 Field.",!
 . S TIUDA=0 F  S TIUDA=$O(@TMP@("WRT",TIUDA)) Q:'+TIUDA  D
 . . N DATA,TITLE S TITLE=$$GET1^DIQ(8925.1,TIUDA,.01),TITLE=$$WRAP^TIULS(TITLE,50)
 . . W !,$$SPACER(TIUDA,12)_$P(TITLE,"|")_" ["_$$GET1^DIQ(8925.1,TIUDA,.04)_"]"
 . . I $L(TITLE,"|")>1 F DATA=2:1:$L(TITLE,"|") W !,?14,$P(TITLE,"|",DATA)
 I +$D(@TMP@("UNK")) D
 . W !!,"The following DOCUMENT IENs have an incorrect (null or zero) #.01 Field.",!
 . S TIUDA=0 F  S TIUDA=$O(@TMP@("UNK",TIUDA)) Q:'+TIUDA  W !,$$SPACER(TIUDA,12) ; I +@TMP@("UNK",TIUDA) W $$GET1^DIQ(8925.1,@TMP@("UNK",TIUDA),.01)
 K @TMP
 Q
RPT ;
 ;;"Elapsed Time:    "_(TOTTIME\1)_" minute(s) "_($FN((TOTTIME#1)*60,"-",0))_" second(s)"
 ;;""
 ;;"                 # of Used Titles  : "_$$SPACER(@CNT@("T#U8925.1"),10,1)
 ;;"               # of Unused Titles  : "_$$SPACER(@CNT@("T#UN8925.1"),10,1)
 ;;"              # of Invalid Titles  : "_$$SPACER(@CNT@("T#ERR8925.1"),10,1)_$S(+@CNT@("T#ERR8925.1"):" (See End of Report)",1:"")
 ;;"                                     ----------"
 ;;"                # of Total Titles  : "_$$SPACER((@CNT@("T#8925.1")+@CNT@("T#ADD8925.1")),10,1)
 ;;""
 ;;"                        # of Docs  : "_$$SPACER(@CNT@("T#GDOCS"),10,1)
 ;;"    # of Docs Incorrect .01 Field  : "_$$SPACER(@CNT@("T#WT8925.1"),10,1)_$S(+@CNT@("T#WT8925.1"):" (See End of Report)",1:"")
 ;;"    # of Docs Zero/Null .01 Field  : "_$$SPACER(@CNT@("T#M0NODE"),10,1)_$S(+@CNT@("T#M0NODE"):" (See End of Report)",1:"")
 ;;"                                     ----------"
 ;;"         # of Total Docs Searched  : "_$$SPACER(@CNT@("T#8925"),10,1)
 ;;""
 ;;"       Current User:  "_($$GET1^DIQ(200,+$G(DUZ),.01))
 ;;"       Current Date:  "_($$HTE^XLFDT($H))
 ;;"Date range searched:  "_($$FMTE^XLFDT($P($$FMADD^XLFDT($$NOW^XLFDT,-365),"."),"D"))_" - "_($$FMTE^XLFDT(ENDDT,"D"))
 ;;""
 ;;"                                        # of"
 ;;"Document Title                          Docs  Last DT Used  Author/Dictator"
 ;;"--------------                          ----  ------------  ---------------"
 ;;EOM
 Q
ASKUSER(ANS,DIR,TIUQUIT) ; ask the user if they want to update titles now
 I $G(ANS("EXIT"))="YES"!($G(ANS("INACT"))="NO") Q
 N DIRUT,DTOUT,DUOUT,POP,X,Y
 S DIR(0)="Y"
 S DIR("A")=DIR,DIR("B")="NO"
 S DIR("?",1)="Entering 'YES' will inactivate all titles unused in the past year;"
 S DIR("?",2)="their STATUS will be changed to INACTIVE.",DIR("?",3)=""
 S DIR("?")="Entering 'NO' will create the report without making any changes."
 D ^DIR I $D(DUOUT)!($D(DTOUT)) S ANS("EXIT")="YES" Q
 S ANS("INACT")=Y(0) Q:+$G(TIUQUIT)
 I ANS("INACT")="YES" D
 . W !!,"All active titles that have not been used in the previous 365 days"
 . W !,"will be set to INACTIVE.",!
 . W !,"You may select individual DOCUMENT TITLES that will NOT be set"
 . W !,"to INACTIVE by this cleanup.",!
 . D ASKUSER(.ANS,"Are you sure you want to change their status to INACTIVE",1)
 . I ANS("INACT")="YES" D OMIT
 Q
GETLAST(TIUDA) ;
 N IEN,GBL,ST,TDT,TEMP,TIUY
 S GBL=$NA(^TIU(8925,"ALL","ANY",TIUDA))
 S TIUY="0^N/A^N/A"_U_TIUDA_U_$P($G(^TIU(8925.1,TIUDA,0)),U,7)
 S ST="" F  S ST=$O(@GBL@(ST)) Q:'ST  S TDT="",TDT=$O(@GBL@(+ST,TDT)),IEN="",IEN=$O(@GBL@(+ST,+TDT,IEN)) S TEMP(TDT)=IEN
 S TDT="",TDT=$O(TEMP(TDT)) I +$G(TEMP(+TDT)) S IEN=+TEMP(TDT) D
 . N TIUD0,TIUD12 S TIUD0=$G(^TIU(8925,IEN,0)),TIUD12=$G(^TIU(8925,IEN,12))
 . I '+TIUD0,'$D(@TMP@("UNK",+IEN)) S @TMP@("UNK",+IEN)="",@CNT@("T#M0NODE")=@CNT@("T#M0NODE")+1,@CNT@("T#8925")=@CNT@("T#8925")+1
 . S $P(TIUY,U,2)=$P(+TIUD12,"."),$P(TIUY,U,3)=$P(TIUD12,U,2)
 Q TIUY
OMIT ;
 N TIUCONT,TIUQUIT
 F  D  Q:$G(TIUQUIT)=1!($G(TIUCONT)=1)
 . N DIC,DIR,POP,TIUCNT,X,Y
 . W !!,"Enter the DOCUMENT TITLE(S) that will NOT be INACTIVATED",!
 . W "during the cleanup process.",!!
 . W "Enter RETURN or '^' to finish selections.",!
 . S TIUCNT=0,DIC="^TIU(8925.1,",DIC("S")="I $P(^(0),U,4)=""DOC"""
 . S DIC(0)="AEMQ",DIC("A")="Enter DOCUMENT TITLE: "
 . F  D ^DIC Q:Y=-1  D  Q:$G(TIUQUIT)=1
 . . S TIUCNT=TIUCNT+1,TIUOMIT(+Y)="" S:TIUCNT=1 DIC("A")="                 and  "
 . Q:$G(TIUQUIT)=1
 . I TIUCNT=0 W !!,"No selections made.",! S DIR("A")="Enter RETURN to continue or '^' to exit",DIR(0)="E" D ^DIR S TIUQUIT=1 Q
 . W !!,$S(TIUCNT>1:"The following DOCUMENT TITLES will NOT be INACTIVATED: ",1:"The following DOCUMENT TITLE will NOT be INACTIVATED: "),!!
 . S X="" F  S X=$O(TIUOMIT(X)) Q:X=""  W ?5,$$GET1^DIQ(8925.1,X_",",.01),!
 . S DIR(0)="Y",DIR("A")="Is this correct",DIR("B")="YES"
 . D ^DIR I +Y'=1 W !! K TIUOMIT S:Y=U TIUQUIT=1 Q
 . S TIUCONT=1
 Q
SPACER(TEXT,LENGTH,REV) ;
 N SPACER
 S SPACER=""
 S $P(SPACER," ",(LENGTH-$L(TEXT)))=" "
 S:'$D(REV) TEXT=TEXT_SPACER
 S:$D(REV) TEXT=SPACER_TEXT
 Q TEXT
UPDATE ; updates status field of TIU Document Title to INACTIVE
 N TIUDA,TIUMSG,TIUUPDT
 S TIUDA=0 F  S TIUDA=$O(@TMP@("B",TIUDA)) Q:'+TIUDA  I '+@TMP@("B",TIUDA),'$D(TIUOMIT(TIUDA)) S TIUUPDT(8925.1,TIUDA_",",.07)=13 D FILE^DIE("","TIUUPDT","TIUMSG")
 Q
