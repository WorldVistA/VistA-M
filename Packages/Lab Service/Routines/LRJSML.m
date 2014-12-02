LRJSML ;ALB/GTS - Lab Vista Hospital Location Utilities;02/24/2010 11:00:25
 ;;5.2;LAB SERVICE;**425**;Sep 27, 1994;Build 30
 ;
 ;
HDR ; -- header code
 SET VALMHDR(1)="                    Lab Hospital Location Change Extract"
 SET VALMHDR(2)="                         Version: "_$$VERNUM^LRJSMLU()_"     Build: "_$$BLDNUM^LRJSMLU()
 Q
 ;
INIT ;* init variables and list array
 N LRFROM,LRTO
 D CREATRPT(.LRFROM,.LRTO,"^TMP($J,""LRJ SYS"")")
 I (+$G(LRFROM)'>0)!(+$G(LRTO)'>0) DO
 . S VALMBCK="Q"
 . S VALMQUIT=1
 I (+$G(LRFROM)>0),(+$G(LRTO)>0) DO
 . D CLEAR(LRFROM,LRTO,"^TMP($J,""LRJ SYS"")")
 . D MSG
 QUIT
 ;
CLEAR(LRFROM,LRTO,LRHLARY) ;* clean up entries
 DO REFRESH(LRFROM,LRTO,LRHLARY)
 QUIT
 ;
MSG ; -- set default message
 N LREND,LRBEGIN,LRAUTMSG
 S LRBEGIN=$$GET^XPAR("SYS","LRJ HL LAST START DATE",1,"Q")
 S LREND=$$GET^XPAR("SYS","LRJ HL LAST END DATE",1,"Q")
 I (LRBEGIN'="")!(LREND'="") D 
 .S LRAUTMSG="Task Rpt "_$S(LRBEGIN'="":$$FMTE^XLFDT(LRBEGIN),1:"undefined")_" - "_$S(LREND'="":$$FMTE^XLFDT(LREND),1:"undefined")
 ;
 I LRBEGIN="",LREND="" D 
 .S LRAUTMSG="Tasked Report has not run!"
 S VALMSG=LRAUTMSG
 QUIT
 ;
REFRESH(LRFROM,LRTO,LRHLARY) ;* refresh display
 DO BUILD(LRFROM,LRTO,LRHLARY)
 D MSG
 SET VALMBCK="R"
 SET VALMBG=1
 QUIT
 ;
BUILD(LRFROM,LRTO,LRHLARY) ; -- build display array
 ;
 ;INPUT
 ; LRFROM  - Start report date (Optional)
 ; LRTO    - End report date (Optional)
 ; LRHLARY - Array of raw data extract (Required)
 ;
 QUIT:'$D(LRHLARY)  ;QUIT if LRHLARY is not defined)
 ;
 NEW LRSTATUS,LRJERRCT,LRX
 DO KILL^VALM10()
 SET VALMCNT=0
 S LRX=" VistA Hospital Location changes"_$S($D(LRFROM):" from "_LRFROM,1:"")_$S($D(LRTO):" to "_LRTO,1:"")
 D ADD^LRJSMLU(.VALMCNT,LRX)
 DO CNTRL^VALM10(VALMCNT,1,$LENGTH(LRX)-1,IOUON,IOUOFF_IOINORM)
 ;
 D LISTHL(LRFROM,LRTO,LRHLARY)
 ;
 ;;D GETLINK^LRJSML1(.VALMCNT,$$GETLINK())  ;;If enhance send message HL MFN, see if can check link here.
 Q
 ;
LISTHL(LRFROM,LRTO,LRHLARY) ; -- place Hospital Locations in the display array
 NEW X,NODE
 DO KILL^VALM10()
 SET VALMCNT=0
 SET X=" VistA Hospital Location changes"_$S($D(LRFROM):" from "_$$FMTE^XLFDT(LRFROM),1:"")_$S($D(LRTO):" to "_$$FMTE^XLFDT(LRTO),1:"")
 DO ADD^LRJSMLU(.VALMCNT,X)
 DO CNTRL^VALM10(VALMCNT,2,$LENGTH(X)-1,IOUON,IOUOFF_IOINORM)
 D ADD^LRJSMLU(.VALMCNT," ")
 SET NODE=0
 FOR  SET NODE=$ORDER(@LRHLARY@(NODE)) QUIT:NODE=""  DO
 . SET X=@LRHLARY@(NODE)
 . DO BREAK(.VALMCNT,X,NODE)
 QUIT
 ;
BREAK(VALMCNT,X,NODE) ; -- break into 79/80 char chunks for display
 NEW LAOUT,LAX,SUBNODE,C
 SET C="" ; -- continuation character
 SET LAX=NODE_" : "_X
 DO ADD^LRJSMLU(.VALMCNT,C_$EXTRACT(LAX,1,80))
 SET C="+"
 SET LAOUT=$EXTRACT(LAX,81,159)
 IF $LENGTH(LAOUT)>0 DO ADD^LRJSMLU(.VALMCNT,C_LAOUT)
 SET LAOUT=$EXTRACT(LAX,160,239)
 IF $LENGTH(LAOUT)>0 DO ADD^LRJSMLU(.VALMCNT,C_LAOUT)
 SET LAOUT=$EXTRACT(LAX,240,255)
 IF $LENGTH(LAOUT)>0 DO ADD^LRJSMLU(.VALMCNT,C_LAOUT)
 QUIT
 ;
 ;
CREATRPT(LRFROM,LRTO,LRHLARY) ;Create array of HL changes between selected dates
 N DIR
 ;
 W !!,"  Enter Hospital Location Extract Date Range...",!
 ;
 S LRFROM=$$DATEENT("Select Start date: ",,"-NOW")
 Q:+LRFROM<1
 S LRTO=$$DATEENT("  Select End date: ",LRFROM,"-NOW")
 Q:+LRTO<1
 D MSG
 ;
 ;Call Report API
 D BLDREC^LRJSMLA(LRFROM,LRTO,LRHLARY)
 ;
 Q
 ;
DATEENT(LRPRMPT,LRBD,LRED) ;Prompt for extract date
 ;INPUT
 ; LRPRMPT - Prompt displayed to user
 ; LRBD    - Begin date of range
 ; LRED    - End date of range
 ;
 ;RETURN
 ; LRDT
 ;  SUCCESS: FILEMAN INTERNALLY FORMATED DATE
 ;  FAILURE: -1
 ;
 N LRDT,LRGOOD
 S LRGOOD=0
 S:+$G(LRED)>0 %DT(0)=LRED
 S:$G(LRED)["NOW" %DT(0)=LRED
 S %DT("A")=LRPRMPT
 S %DT("B")="TODAY" ;Default for [Start] date entry
 S %DT="AEPST"
 D:LRPRMPT["Start" ^%DT ;Prompt for Start date
 ;
 ;Prompt for End date with conditions
 I LRPRMPT["End" DO
 . F  Q:LRGOOD  DO
 . . S %DT("B")="NOW" ;Change default for End Date entry
 . . D ^%DT
 . . W:((Y<LRBD)&(X'="^")&('$D(DTOUT))) " ??",!,"   End date must follow Begin date!",!
 . . S:((Y>LRBD)!(Y=LRBD)!($D(DTOUT))!(X="^")) LRGOOD=1
 S LRDT=Y
 K Y,%DT
 Q LRDT
 ;
DISPEXT(LRHLARY) ;Display Raw HL changes extracted
 ;
 ; This API will change the ListMan display array to a raw extract format
 ;INPUT
 ; LRHLARY - Array of raw extract data.
 ; 
 NEW LRFROM,LRTO
 D HDR
 ;
 ;Pull date range of extract from ^TMP("LRJ SYS MAP HL INIT MGR",$JOB)
 D GETDATE^LRJSML8(.LRFROM,.LRTO)
 IF (+LRFROM=0)!(+LRTO=0) DO
 .SET LRFROM=$P($G(^TMP("LRJ SYS USER MANAGER - DATES",$JOB)),"^")
 .SET LRTO=$P($G(^TMP("LRJ SYS USER MANAGER - DATES",$JOB)),"^",2)
 SET ^TMP("LRJ SYS USER MANAGER - DATES",$JOB)=LRFROM_"^"_LRTO
 KILL ^TMP("LRJ SYS MAP HL INIT MGR",$JOB)
 D REFRESH(LRFROM,LRTO,LRHLARY)
 D MSG
 S VALMBCK="R"
 S VALMBG=1
 Q
 ;
MMHDR ; -- header code for Mail Message display
 SET VALMHDR(1)="                    Lab Hospital Location Change Message"
 SET VALMHDR(2)="                         Version: "_$$VERNUM^LRJSMLU()_"     Build: "_$$BLDNUM^LRJSMLU()
 Q
