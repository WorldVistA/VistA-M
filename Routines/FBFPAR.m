FBFPAR ;WOIFO/SAB-FPPS AUDIT REPORT ;7/18/2003
 ;;3.5;FEE BASIS;**61**;JAN 30, 1995
 ;
 ; ask if BY INVOICE or BY DATE RANGE
 S DIR(0)="S^I:Invoice;D:Date Range"
 S DIR("A")="Report one invoice or report by Date Range"
 S DIR("B")="Date Range"
 S DIR("?",1)="Enter I to print the audit data for one invoice."
 S DIR("?",2)="Enter D to print all audit data for a date range."
 S DIR("?")="Enter a code from the list."
 D ^DIR K DIR G:$D(DIRUT) EXIT
 S FBRANGE=$S(Y="D":1,1:0)
 ;
 I FBRANGE D  G:$D(DIRUT) EXIT
 . ; ask dates
 . S DIR(0)="D^::EX",DIR("A")="From Date"
 . ;   default from date is first day of current month
 . S DIR("B")=$$FMTE^XLFDT($E(DT,1,5)_"01")
 . D ^DIR K DIR Q:$D(DIRUT)
 . S FBDT1=Y
 . S DIR(0)="DA^"_FBDT1_"::EX",DIR("A")="To Date: "
 . ;   default to date is last day of specified month
 . S X=FBDT1 D DAYS^FBAAUTL1
 . S DIR("B")=$$FMTE^XLFDT($E(FBDT1,1,5)_X)
 . D ^DIR K DIR Q:$D(DIRUT)
 . S FBDT2=Y
 ;
 ; If not date range then ask invoice
 I 'FBRANGE D  G:$D(DIRUT) EXIT
 . S DIR(0)="N",DIR("A")="Invoice Number: "
 . D ^DIR K DIR Q:$D(DIRUT)
 . S FBAAIN=Y
 ;
 ; ask device
 S %ZIS="QM" D ^%ZIS G:POP EXIT
 I $D(IO("Q")) D  G EXIT
 . S ZTRTN="QEN^FBFPAR",ZTDESC="FPPS Audit Report"
 . F FBX="FBAAIN","FBDT*","FBRANGE" S ZTSAVE(FBX)=""
 . D ^%ZTLOAD,HOME^%ZIS K ZTSK
 ;
QEN ; queued entry
 U IO
 ;
GATHER ; collect and sort data
 S FBQUIT=0
 ;
PRINT ; report data
 S FBPG=0 D NOW^%DTC S Y=% D DD^%DT S FBDTR=Y
 K FBDL S FBDL="",$P(FBDL,"-",IOM)=""
 ;
 ; build page header text for selection criteria
 S:FBRANGE FBHDT(1)="  For "_$$FMTE^XLFDT(FBDT1)_" through "_$$FMTE^XLFDT(FBDT2)
 ;
 D HD
 ;
 ; Initialize Counter
 S FBC=0
 ;
 ; if by date range
 I FBRANGE D
 . S FBDT=FBDT1-.0000001
 . F  S FBDT=$O(^FB(163.7,"C",FBDT)) Q:'FBDT!(FBDT>(FBDT2_".999999"))  D  Q:FBQUIT
 . . S FBDA=0 F  S FBDA=$O(^FB(163.7,"C",FBDT,FBDA)) Q:'FBDA  D  Q:FBQUIT
 . . . D PRINT1
 ;
 ; if by invoice
 I 'FBRANGE D
 . S FBDA=0 F  S FBDA=$O(^FB(163.7,"B",FBAAIN,FBDA)) Q:'FBDA  D  Q:FBQUIT
 . . D PRINT1
 ;
 I FBC=0 W !,"no Audit entries found."
 ;
 I FBQUIT W !!,"REPORT STOPPED AT USER REQUEST"
 ;
 I 'FBQUIT,$E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR
 D ^%ZISC
 ;
EXIT ;
 I $D(ZTQUEUED) S ZTREQ="@"
 K FBAAIN,FBC,FBDT,FBDT1,FBDT2,FBDTR,FBHDT,FBIENS,FBRANGE,FBPG,FBQUIT,FBX
 K %,DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,I,J,POP,X,Y
 Q
HD ; page header
 N FBI
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1,FBQUIT=1 Q
 I $E(IOST,1,2)="C-",FBPG S DIR(0)="E" D ^DIR K DIR I 'Y S FBQUIT=1 Q
 I $E(IOST,1,2)="C-"!FBPG W @IOF
 S FBPG=FBPG+1
 W !,"FPPS Data Audit Report "
 I FBRANGE W "by Date Range"
 E  W "for Invoice: ",FBAAIN
 W ?49,FBDTR,?72,"page ",FBPG
 S FBI=0 F  S FBI=$O(FBHDT(FBI)) Q:'FBI  W !,FBHDT(FBI)
 W !!,"Date/Time Changed",?19,"File",?27,"IENS",?58,"User"
 W !,FBDL
 Q
 ;
PRINT1 ; Print one audit record (FBDA)
 N FB,FBADT
 S FBC=FBC+1
 I $Y+9>IOSL D HD Q:FBQUIT
 W !
 ;
 S FBIENS=FBDA_","
 D GETS^DIQ(163.7,FBIENS,"*","","FB")
 S FBADT=$$FMTE^XLFDT($$GET1^DIQ(163.7,FBIENS,1,"I"),"2F")
 W !,FBADT,?19,FB(163.7,FBIENS,2),?27,FB(163.7,FBIENS,3)
 W ?58,$E(FB(163.7,FBIENS,7),1,20)
 W !?4,"Field: "
 W $$GET1^DID(FB(163.7,FBIENS,2),FB(163.7,FBIENS,4),"","LABEL")
 W ?27,"Old Field Value: ",FB(163.7,FBIENS,5)
 W !
 I FBRANGE W ?4,"Invoice: ",FB(163.7,FBIENS,.01)
 W ?27,"New Field Value: ",FB(163.7,FBIENS,6)
 ;
 ; if prescription subfile then write more info to identify
 I FB(163.7,FBIENS,2)="162.11" D
 . W !,?4,"Prescription: "
 . W $$GET1^DIQ(162.11,FB(163.7,FBIENS,3),.01)
 ;
 ; if service provided subfile then write more info to identify
 I FB(163.7,FBIENS,2)="162.03" D
 . N FBDA
 . D DA^DILF(FB(163.7,FBIENS,3),.FBDA)
 . W !,?4,"Patient: "
 . W $$GET1^DIQ(162,FBDA(3)_",",.01)
 . W ?40,"Vendor: "
 . W $E($$GET1^DIQ(162.01,FBDA(2)_","_FBDA(3)_",",.01),1,30)
 . W !,?4,"Date of Service: "
 . W $$GET1^DIQ(162.02,FBDA(1)_","_FBDA(2)_","_FBDA(3)_",",.01)
 . W ?36,"Service Provided: "
 . W $$GET1^DIQ(162.03,FB(163.7,FBIENS,3),.01)
 Q
 ;
 ;FBFPAR
