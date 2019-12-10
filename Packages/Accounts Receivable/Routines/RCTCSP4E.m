RCTCSP4E ;HAF/ASF - CS Debt Referral Stop Reactivate Report ;6/1/2017
 ;;4.5;Accounts Receivable;**350**;Mar 26, 2019;Build 66
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
HDR ; report header
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y,RCSR
 ;
 S CRT=0 S:IOST?1"C".E CRT=1
 ; Do an end of page reader call if page# exists and device is the screen
 I PAGE,CRT S DIR(0)="E" D ^DIR K DIR I 'Y S RCTCSTOP=1 G HDRX
 ;
 ; If screen output or page# exists, do a form feed
 I PAGE!CRT W @IOF
 ;
 ; First printer/file page - do a left margin reset
 I 'PAGE,'CRT W $C(13)
 ;
 S PAGE=PAGE+1    ; increment page#
 ;
 ; For Excel format, display the column headers only
 ;
 ; Display the report headers
 ;
 D DLHDR:RCTCDB="D",DIVHDR:RCTCDB="B"
 Q  ;
 W ?47,"Cross-Servicing Stop Reactivate Report by ",$S(RCTCDIV="D":"Division",1:"Debtor"),?122,"Page: ",PAGE
 ;
 W !,"Date Range: "
 I RCTCDATE="A" W "ALL"
 E  D
 . W $$FMTE^XLFDT($G(RCTCDATE("BEGIN")),"2Z")," - "
 . W $$FMTE^XLFDT($G(RCTCDATE("END")),"2Z")
 . Q
 W "  Currently Flagged, Reactivated, or Both: "
 W $S(RCTCFLG="C":"Currently Flagged",RCTCFLG="R":"Reactivated",1:"Both")
 I RCTCDIV="D" W "  Division: " S DIV1=0 F  S DIV1=$O(RCTC("DIVS",DIV1)) Q:DIV1'>0  W " "_DIV1
 E  W "  Division: All"
 W ?111,$$FMTE^XLFDT($$NOW^XLFDT)
 W !,"Debtors: "
 I RCTCDB="B"!'$D(RCTCSP4("DEBTOR")) W "ALL"
 E  D
 . S RTCN="" F  S RTCN=$O(RCTCSP4("DEBTOR",RTCN)) Q:RTCN=""  W RTCN_" "
 . Q
 ;
 W !,SEPLINE
 W:RCTCDIV="D" !,"Debtor Name",?32,"Pt ID",?39,"Bill#",?49,"Cat",?59,"Letter1",?69,"StopDate",?79,"Reason",?89,"CS STOP",?99,"Entered",?109,"User"
 W !,SEPLINE
 ;
 ; check for a TaskManager stop request
 I $D(ZTQUEUED),$$S^%ZTLOAD() D  G HDRX
 . S (ZTSTOP,RCTCSTOP)=1
 . W !!!?5,"*** Report Halted by TaskManager Request ***"
 . Q
 ;
HDRX ;
 Q
 ;
EXCELHD ; print an Excel header record (only 1 Excel header should print for the whole report)
 ;W !,"Debtor Name",?28,"Division",?37,"Pt ID",?46,"Bill#",?55,"Status",?67,"Letter1",?77,"StopDate",?89,"Reason",?99,"CS STOP",?109,"User"
 N RCH
 S RCH=$$CSV("","Debtor Name")
 S RCH=$$CSV(RCH,"Division")
 ;S RCH=$$CSV(RCH,"Patient ID")
 S RCH=$$CSV(RCH,"Pt ID")
 ;S RCH=$$CSV(RCH,"SSN")
 ;S RCH=$$CSV(RCH,"Bill Number")
 S RCH=$$CSV(RCH,"Bill#")
 ;S RCH=$$CSV(RCH,"Current Balance")
 ;S RCH=$$CSV(RCH,"Current Status")
 S RCH=$$CSV(RCH,"Status")
 ;S RCH=$$CSV(RCH,"Category Name")
 ;S RCH=$$CSV(RCH,"Category Abbr")
 ;S RCH=$$CSV(RCH,"Letter1 Date")
 S RCH=$$CSV(RCH,"Letter1")
 S RCH=$$CSV(RCH,"StopDate")
 ;S RCH=$$CSV(RCH,"Stop Reason")
 S RCH=$$CSV(RCH,"Reason")
 ;S RCH=$$CSV(RCH,"Transaction Type")
 ;S RCH=$$CSV(RCH,"Transaction Date Entered")
 ;S RCH=$$CSV(RCH,"Transaction Processed By")
 S RCH=$$CSV(RCH,"CS STOP")
 S RCH=$$CSV(RCH,"User")
 W RCH
 Q
 ;
EXCELN ; write a line of Excel data
 N RCZ
 S RCZ=$$CSV("",$P(DEBTDATA,U,2))                         ; AR Debtor Name
 S RCZ=$$CSV(RCZ,$P(BILLDATA,U,9))                        ; Division
 S RCZ=$$CSV(RCZ,$P(DEBTDATA,U,1))                        ; patient ID
 ;S RCZ=$$CSV(RCZ,$P(DEBTDATA,U,3))                        ; SSN
 S RCZ=$$CSV(RCZ,$P(BILLDATA,U,1))                        ; bill#
 ;S RCZ=$$CSV(RCZ,+$P(BILLDATA,U,2))                       ; current balance
 S RCZ=$$CSV(RCZ,$P(BILLDATA,U,3))                        ; AR status name
 ;S RCZ=$$CSV(RCZ,$P(BILLDATA,U,4))                        ; AR category name
 ;S RCZ=$$CSV(RCZ,$P(BILLDATA,U,8))                        ; AR category abbr
 S RCZ=$$CSV(RCZ,$$FMTE^XLFDT($P(BILLDATA,U,5),"2Z"))     ; letter1 date
 S RCZ=$$CSV(RCZ,$$FMTE^XLFDT($P(BILLDATA,U,6),"2Z"))     ; stop flag effective date
 S RCZ=$$CSV(RCZ,$P(BILLDATA,U,7))                        ; stop flag reason
 S TT=$P(TRANDATA,U,1)
 S RCZ=$$CSV(RCZ,$S(TT["DELETED":"DEL",TT["PLACED":"ADD",1:"UNK"))
 ;S RCZ=$$CSV(RCZ,$P(TRANDATA,U,1))                        ; ar transaction type desc
 ;S RCZ=$$CSV(RCZ,$$FMTE^XLFDT($P(TRANDATA,U,2),"2Z"))     ; transaction date entered
 S RCZ=$$CSV(RCZ,$P(TRANDATA,U,3))                        ; trans user
 W !,RCZ
 Q
 ;
CSV(STRING,DATA) ; build the Excel data string format
 S STRING=$S(STRING="":DATA,1:STRING_U_DATA)
 Q STRING
 ; 
DIVHDR ;
 I RCTCEXCEL D EXCELHD Q
 W !,"Date Range: "
 I RCTCDATE("BEGIN")=2840101 W "All"
 I RCTCDATE("BEGIN")'=2840101 W $$FMTE^XLFDT($G(RCTCDATE("BEGIN")),"2Z")," - ",$$FMTE^XLFDT($G(RCTCDATE("END")),"2Z")
 W ?47,"Cross-Servicing Stop Reactivate Report by Bill",?122,"Page: ",PAGE
 W ! I RCTCDIV="A" W "Division(s): All"
 W ?45,"  Currently Flagged, Reactivated, or Both: "
 W $S(RCTCFLG="C":"Currently Flagged",RCTCFLG="R":"Reactivated",1:"Both")
 W ?111,$P($$FMTE^XLFDT($$NOW^XLFDT),":",1,2)
 I RCTCDIV'="A" D
 . W !,"Division(s): " S DV="",DV1="" F  S DV=$O(RCTC("DIVN",DV)) Q:DV=""  S DV1=DV1_RCTC("DIVN",DV)_"-"_DV_", "
 . W $E(DV1,1,$L(DV1)-2)
 W !,"Debtor Range: "
 I RCTCDEBT1=("FIRST")&(RCTCDEBT2="LAST") W "ALL"
 E  W RCTCDEBT1,":",RCTCDEBT2
 W !,SEPLINE
 W !,"Debtor Name",?24,"Division",?34,"Pt ID",?44,"Bill#",?55,"Status",?67,"Letter1",?77,"StopDate",?89,"Reason",?99,"CS STOP",?109,"User"
 W !,SEPLINE
 Q
DLEVEL ; stop/reactivate report at 340 debtor level
 K ^TMP("RCTC",$J)
 D DEBTORS^RCTCSP4 Q:$D(DIRUT)
 S DEBRANGE=RCTCDEBT1_":"_RCTCDEBT2
 D DATES^RCTCSP4 Q:'$D(RCTCDATE)!$D(DIRUT)
 S PAGE=0,RCTCSTOP=0,$P(SEPLINE,"-",133)=""
 D FORMAT^RCTCSP4 Q:RCTCEXCEL=""
 D DEVICE
 Q
QENT ;queue ENTRY
 S PAGE=0,RCTCSTOP=0,$P(SEPLINE,"-",133)=""
 D HDR
 K ^TMP("RCTC",$J)
 S DEBTOR=0 F  S DEBTOR=$O(^RCD(340,DEBTOR)) Q:DEBTOR'>0  D DSR
 D PRINT
 Q
DSR Q:^RCD(340,DEBTOR,0)'?.E1"DPT(".E  ;only top level debtors
 S DEBTNAME=$$GET1^DIQ(340,DEBTOR,.01)
 I RCTCDEBT1'="FIRST",RCTCDEBT1'=DEBTNAME,RCTCDEBT1]DEBTNAME Q  ; before name range
 I RCTCDEBT2'="LAST",RCTCDEBT2'=DEBTNAME,DEBTNAME]RCTCDEBT2 Q   ; after name range
 S SRDT="" F  S SRDT=$O(^RCD(340,DEBTOR,8,"C",SRDT)) Q:SRDT'>0  D
 . Q:(RCTCDATE("BEGIN")\1)>SRDT  ;check date range
 . Q:(RCTCDATE("END")_.99)<SRDT
 . S N1=0 F  S N1=$O(^RCD(340,DEBTOR,8,"C",SRDT,N1)) Q:N1'>0  D
 .. S NN=DEBTNAME
 .. S G=^RCD(340,DEBTOR,8,N1,0),RCDT=$P(G,U,2),RCSR=$P(G,U),G(N1)=G
 .. I RCTCFLG="R"&(RCSR="R") S ^TMP("RCTC",$J,NN,DEBTOR,RCDT)=N1  ;Filter stops
 .. I RCTCFLG="C"&(RCSR="S") S ^TMP("RCTC",$J,NN,DEBTOR,RCDT)=N1 ;Filter reactivates
 .. I RCTCFLG="B" S ^TMP("RCTC",$J,NN,DEBTOR,RCDT)=N1
 Q
PRINT ;print for debtor level
 S NN="" F  S NN=$O(^TMP("RCTC",$J,NN)) Q:NN=""  Q:RCTCSTOP  S DEBTOR=0 F  S DEBTOR=$O(^TMP("RCTC",$J,NN,DEBTOR)) Q:DEBTOR'>0  D
 . S RCDT=0 F  S RCDT=$O(^TMP("RCTC",$J,NN,DEBTOR,RCDT)) Q:RCDT'>0  Q:RCTCSTOP  D
 .. S N1=^TMP("RCTC",$J,NN,DEBTOR,RCDT)
 .. S SSN=$$SSN^RCFN01(DEBTOR)
 .. S PTID=$E(NN,1)_$S(SSN'="":$E(SSN,6,9),1:"0000")            ; patient id
 .. S IENS=N1_","_DEBTOR_"," S REASON=$$GET1^DIQ(340.08,IENS,.04) ; REason
 .. S G=^RCD(340,DEBTOR,8,N1,0)
 .. S SR=$P(G,U)
 .. S XDATE=$E($P(G,U,2),1,12) S XDATE=$E(XDATE,4,5)_"/"_$E(XDATE,6,7)_"/"_$E(XDATE,2,3)  ;_"@"_$P(XDATE,".",2)
 .. S USER=$P(G,U,3) S USER=$$GET1^DIQ(200,USER_",",.01)
 .. I RCTCEXCEL D DEXLN Q
 .. W !,NN ;NAME
 .. W ?35,PTID
 .. W ?42,SSN
 .. W ?54,SR
 .. W ?57,XDATE
 .. W ?75,REASON
 .. ;W ?85,$P(G,U,5) ;COMMENT
 .. W ?107,USER
 .. W *7 I $Y+3>IOSL D HDR^RCTCSP4E ;I RCTCSTOP Q
 W !!,?20,"*** ",$S($G(RCTCSTOP):"Report Ended",1:"End of Report")," ***"
 I $E(IOST,1,2)="C-",'$D(DIRUT),'$G(RCTCSTOP) R !!,"Type <Enter> to continue or '^' to exit:",X:DTIME W @IOF
 Q
DLHDR ;Debtor Level Header
 I RCTCEXCEL=1 D DLXHD Q
 W !,"Date Range: "
 I RCTCDATE="A" W "All"
 E  W $$FMTE^XLFDT($G(RCTCDATE("BEGIN")),"2Z")," - ",$$FMTE^XLFDT($G(RCTCDATE("END")),"2Z")
 W ?35,"Cross-Servicing Stop Reactivate Report at Debtor Level",?122,"Page: ",PAGE
 W !?33,"  Currently Flagged, Reactivated, or Both: "
 W $S(RCTCFLG="C":"Currently Flagged",RCTCFLG="R":"Reactivated",1:"Both")
 W !,"Debtor Range: ",DEBRANGE
 W ?111,$P($$FMTE^XLFDT($$NOW^XLFDT),":",1,2)
 W !,SEPLINE
 W !,"Debtor Name",?35,"Pt ID",?42,"SSN",?53,"S/R",?57,"Date",?75,"Reason",?107,"User"
 W !,SEPLINE
 Q
DEVICE() ; Device Selection
 N ZTRTN,ZTDESC,ZTSAVE,POP,RET,ZTSK,DIR,X,Y
 S RET=1
 I 'RCTCEXCEL W !!,"It is recommended that you Queue this report to a device ",!,"that is 132 characters wide",!
 I RCTCEXCEL D
 . W !!,"To capture as an Excel format, it is recommended that you queue this report to"
 . W !,"a spool device with margins of 256 and page length of 99999,"
 . W !,"(e.g. spoolname;256;99999).This should help avoid wrapping problems.",!
 . W !,"Another method would be to set up your terminal to capture the detail report"
 . W !,"data. On some terminals, this can be done by clicking on the 'Tools' menu above,"
 . W !,"then click on 'Capture Incoming Data' to save to Desktop."
 . W !,"To avoid undesired wrapping of the data saved to the file,"
 . W !,"please enter '0;256;99999' at the 'DEVICE:' prompt."
 ;
 S ZTRTN="QENT^RCTCSP4E"
 S ZTDESC="RCTC AR Cross-Servicing Stop Reactivate Report DEBTOR LEVEL"
 S ZTSAVE("RCTC(")=""
 S ZTSAVE("RCTCDB")=""
 S ZTSAVE("RCTCDIV")=""
 S ZTSAVE("RCTCFLG")=""
 S ZTSAVE("RCTCDEBT1")=""
 S ZTSAVE("RCTCDEBT2")=""
 S ZTSAVE("RCTCDATE")=""
 S ZTSAVE("RCTCDATE(")=""
 S ZTSAVE("RCTCEXCEL")=""
 S ZTSAVE("DEBRANGE")=""
 S ZTSAVE("DLEVEL")=""
 D EN^XUTMDEVQ(ZTRTN,ZTDESC,.ZTSAVE,"QM",1)
 I POP S RET=0
 I $G(ZTSK) W !!,"Report compilation has started with task# ",ZTSK,".",! S DIR(0)="E" D ^DIR K DIR
 Q RET
 ;
DLXHD ; print an Excel header record DEBTOR level
 N RCH
 S RCH=$$CSV("","Debtor Name")
 S RCH=$$CSV(RCH,"Pt ID")
 S RCH=$$CSV(RCH,"SSN")
 S RCH=$$CSV(RCH,"S/R")
 S RCH=$$CSV(RCH,"Date")
 S RCH=$$CSV(RCH,"Reason")
 S RCH=$$CSV(RCH,"User")
 W RCH
 Q
DEXLN ; write a line of Excel data for debtor
 N RCZ
 S RCZ=$$CSV("",NN)                         ; AR Debtor Name
 S RCZ=$$CSV(RCZ,PTID)                        ; patient ID
 S RCZ=$$CSV(RCZ,SSN)                        ; SSN
 S RCZ=$$CSV(RCZ,SR)                        ; SR
 S RCZ=$$CSV(RCZ,XDATE)                       ; Date
 S RCZ=$$CSV(RCZ,REASON)                       ; reason
 S RCZ=$$CSV(RCZ,USER)                        ; CLERK
 W !,RCZ
 Q
