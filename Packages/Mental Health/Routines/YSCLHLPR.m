YSCLHLPR ;HEC/hrubovcak ;19 May 2020 14:13:48
 ;;5.01;MENTAL HEALTH;**149**;Dec 30, 1994;Build 72
 ;
 ; Reference to ^PSS50 supported by DBIA #4483
 ; Reference to ^PSRX supported by IA #780
 ; Reference to ^XMB supported by IA #1131
 ;
 Q
 ; Clozapine reports, 29 February 2020
 ;
HL7SMRY ; Clozapine HL7 Messages Summary [YSCL HL7 STATUS REPORT] option - 29 February 2020
 D DT^DICRW
 ;
 N %ZIS,POP
 W !,"Mental Health Clozapine HL7 Transmission Summary",!
 S %ZIS="MQ",%ZIS("A")="Select HL7 Status Report device: ",%ZIS("B")=""
 D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q
 . N ZTDESC,ZTRTN,ZTSK
 . S ZTRTN="HL7RPT^"_$T(+0),ZTDESC="YSCL HL7 STATUS REPORT option" D ^%ZTLOAD,HOME^%ZIS
 . I $G(ZTSK) W !,"Queued as task #"_ZTSK
 ;
 U IO D HL7RPT U IO(0) D ^%ZISC
 Q
 ;
HL7RPT ; text for YSCL HL7 STATUS REPORT
 ;
 N J,X,Y,YSDFN,YSINDX,YSTXT,YSV,ZTQUEUED
 ; count entries in last 30 days
 S YSV("30days")=$$HTFM^XLFDT($H-30)
 F YSINDX="CDATE","DDATE" D
 . S YSV(YSINDX,"total")=0
 . S Y=YSV("30days")-.0000001
 . F  S Y=$O(^YSCL(603.05,YSINDX,Y)) Q:'Y  S YSDFN=0 F  S YSDFN=$O(^YSCL(603.05,YSINDX,Y,YSDFN)) Q:'YSDFN  D
 ..  ; J is IEN
 ..  S J=0  F  S J=$O(^YSCL(603.05,YSINDX,Y,YSDFN,J)) Q:'J  D
 ...   S YSV("hl7Cnt",YSDFN)=$G(YSV("hl7Cnt",YSDFN))+1  ; count for this patient
 ...   S YSV(YSINDX,"total")=YSV(YSINDX,"total")+1  ; count by message type
 ; tallies
 S YSV("hl7Cnt")=0,YSV("ptCnt")=0
 S YSDFN=0 F  S YSDFN=$O(YSV("hl7Cnt",YSDFN)) Q:'YSDFN  S YSV("hl7Cnt")=YSV("hl7Cnt")+YSV("hl7Cnt",YSDFN),YSV("ptCnt")=YSV("ptCnt")+1
 ; results into W-P array
 D WPL(.YSTXT,$J("Clozapine HL7 Transmission Summary "_$$HTE^XLFDT($H,1),60))
 S Y=$E($$STA^XUAF4(+DUZ(2)),1,3)  ; station #
 D WPL(.YSTXT,"Domain: "_^XMB("NETNAME")_$S($L(Y):" (station "_Y_")",1:""))
 D WPL(.YSTXT,""),WPL(.YSTXT," <> Data from the CLOZAPINE PARAMETERS file (#603.03)")
 S X=^YSCL(603.03,1,20)  ; (#20.01) HL7 TRANSMISSION START [1D] ^ (#20.02) HL7 TRANSMISSION END [2D]
 S Y=$P(X,U) D WPL(.YSTXT," HL7 TRANSMISSION START: "_$S(Y:$$FMTE^XLFDT(Y),1:"* not defined *"))
 S Y=$P(X,U,2) D WPL(.YSTXT,"   HL7 TRANSMISSION END: "_$S(Y:$$FMTE^XLFDT(Y),1:"* not defined *"))
 D WPL(.YSTXT,""),WPL(.YSTXT," <> Clozapine HL7 Log Information")
 S X=$G(^XTMP("YSCLHL7",0,"TASK #"))
 I X D WPL(.YSTXT," Queued as Task #"_$P(X,U)_" which finished "_$$FMTE^XLFDT($P(X,U,2)))
 I 'X D WPL(.YSTXT," No HL7 log! Schedule the YSCL HL7 CLOZ TRANSMISSION option via TaskMan.")
 D WPL(.YSTXT,""),WPL(.YSTXT," <> Totals from the CLOZAPINE HL7 TRANSMISSION file (#603.05)")
 D WPL(.YSTXT," Message totals for the last 30 days (since "_$$FMTE^XLFDT(YSV("30days"))_")")
 D WPL(.YSTXT," Total patients with messages: "_$FN(YSV("ptCnt"),","))
 D WPL(.YSTXT," Clozapine HL7 messages total: "_$FN(YSV("hl7Cnt"),","))
 D WPL(.YSTXT,"         Messages from Orders: "_$FN(YSV("DDATE","total"),","))
 D WPL(.YSTXT,"  Messages from Prescriptions: "_$FN(YSV("CDATE","total"),","))
 D WPL(.YSTXT,""),WPL(.YSTXT,$$EOR),WPL(.YSTXT,"")
 ;
 S J=0 F  S J=$O(YSTXT(J)) Q:'J  W !,YSTXT(J,0)
 I '$D(ZTQUEUED),$E(IOST,1,2)="C-" D ENTR
 S:$D(ZTQUEUED) ZTREQ="@"  ; delete the task
 K ^TMP($J,"YSpatient"),ZTREQ
 Q
 ;
RPTBYDT ; report by date, 31 March 2020
 ;
 N %ZIS,DIR,X,Y,YSRPTDT,YSTOP,DTOUT,DUOUT
 W !,"Report by date from the CLOZAPINE HL7 TRANSMISSION file (#603.05).",!
 ; check for data
 S Y=$O(^YSCL(603.05,0)) I '(Y>0) D  Q
 . W !,"There are no entries in file #603.05",! D ENTR
 S YSTOP=0 F  D  Q:YSTOP
 . S DIR(0)="DA^"_(Y\1)_"::EDP",DIR("A")="Select starting date: ",DIR("?")="Enter the starting date, the oldest entry is from "_$$FMTE^XLFDT(Y\1)_"."
 . D ^DIR S YSTOP=$S($D(DTOUT)!$D(DUOUT)!(Y<0):-1,Y>0:1,1:0),YSRPTDT("1st")=Y
 ;
 I YSTOP<0!'(YSRPTDT("1st")>0) Q  ; aborted or timed out
 K DIR S YSTOP=0 F  D  Q:YSTOP
 . S DIR(0)="DA^"_YSRPTDT("1st")_":"_DT_":EDP",DIR("A")="  Select ending date: ",DIR("?",1)="The ending date may not be later than today."
 . S DIR("?")="It can be no earlier than "_$$FMTE^XLFDT(YSRPTDT("1st"))_"."
 . D ^DIR S YSTOP=$S($D(DTOUT)!$D(DUOUT)!(Y<0):-1,Y>0:1,1:0),YSRPTDT("last")=Y
 ;
 I YSTOP<0!'(YSRPTDT("last")>0) Q  ; aborted or timed out
 W !!,"It is recommended that you queue this report."
 S %ZIS="MQ",%ZIS("A")="Select Clozapine HL7 report device: ",%ZIS("B")=""
 D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q
 . N ZTDESC,ZTRTN,ZTSAVE,ZTSK
 . S ZTSAVE("YSRPTDT(")=""
 . S ZTRTN="DTRPRT^"_$T(+0),ZTDESC="YSCL HL7 REPORT BY DATE option" D ^%ZTLOAD,HOME^%ZIS
 . I $G(ZTSK) W !,"Queued as task #"_ZTSK
 ;
 U IO D DTRPRT U IO(0) D ^%ZISC
 ;
 Q
 ;
DTRPRT ; text for YSCL HL7 REPORT BY DATE
 ;
 N C,L,PTNMDFN,X,Y,YSCNTR,YSDTM,YSDFN,YSHDR,YSIEN,YSINDX,ZTQUEUED
 K ^TMP($J,"YSDFN"),^TMP($J,"YSTXT"),^TMP($J,"YS TIMES")
 ; header info
 S YSHDR(1)=$J("Printed "_$$HTE^XLFDT($H),79)
 S Y="HL7 Clozapine Report from "_$$FMTE^XLFDT(YSRPTDT("1st"))_" to "_$$FMTE^XLFDT(YSRPTDT("last"))
 S YSHDR(2)=Y_$J(" ",70-$L(Y))_" Page: ",YSHDR("pgNum")=0
 S YSHDR(3)=" Date&Time           Patient"_$J("Item #          HLO msg Type",51)
 ; get the records
 S YSDTM=YSRPTDT("1st")\1,YSCNTR=0
 F YSINDX="CDATE","DDATE" D
 . N ND,TYP S:YSINDX="CDATE" TYP="Rx",ND=1  S:YSINDX="DDATE" TYP="Or",ND=2
 . S YSDTM=YSRPTDT("1st")\1
 . F  S YSDTM=$O(^YSCL(603.05,YSINDX,YSDTM)) Q:'YSDTM!(YSDTM\1>YSRPTDT("last"))  D
 ..  S Y=$$FMTE^XLFDT(YSDTM,2),YSDTM("rprt")=$J(" ",18-$L(Y))  ; formatted for report
 ..  S YSDFN=0 F  S YSDFN=$O(^YSCL(603.05,YSINDX,YSDTM,YSDFN)) Q:'YSDFN  S YSIEN=0 F  S YSIEN=$O(^YSCL(603.05,YSINDX,YSDTM,YSDFN,YSIEN)) Q:'YSIEN  D
 ...   ; patient info one time only
 ...   I '$D(^TMP($J,"YSDFN",YSDFN,.01)) S ^TMP($J,"YSDFN",YSDFN,.01)=$$GET1^DIQ(2,YSDFN,.01)
 ...   S L=^TMP($J,"YSDFN",YSDFN,.01),PTNMDFN=L_U_YSDFN
 ...   ; TRANSMISSION DATE/TIME ^ HLO MESSAGE ^ MESSAGE TYPE ^ Order or Rx#
 ...   S X=$G(^YSCL(603.05,YSDFN,ND,YSIEN,0))
 ...   S Y=L_$J(" ",31-$L(L))_TYP_$J($P(X,U,4),10)_"  "_$J($P(X,U,2),9)_"  "_$P(X,U,3)
 ...   S ^TMP($J,"YS TIMES",PTNMDFN,YSDTM,YSIEN)=Y
 ; sorted, put 'em in report
 S YSCNTR=0,PTNMDFN=""
 F  S PTNMDFN=$O(^TMP($J,"YS TIMES",PTNMDFN)) Q:PTNMDFN=""  S Y=0 F  S Y=$O(^TMP($J,"YS TIMES",PTNMDFN,Y)) Q:'Y  D
 . S Y("time")=$$FMTE^XLFDT(Y,2),Y("time")=Y("time")_$J(" ",20-$L(Y("time")))
 . S X=0 F  S X=$O(^TMP($J,"YS TIMES",PTNMDFN,Y,X)) Q:'X  D TMPLN(.YSCNTR,Y("time")_^TMP($J,"YS TIMES",PTNMDFN,Y,X))
 ;
 I 'YSCNTR D TMPLN(.YSCNTR," "),TMPLN(.YSCNTR," * No records found. *")
 D TMPLN(.YSCNTR," "),TMPLN(.YSCNTR,$$EOR)
 ; C = count for page, L=line counter
 D HDR(.YSHDR) S C=3
 S L=0 F  S L=$O(^TMP($J,"YSTXT",L)) Q:'L  S Y=^TMP($J,"YSTXT",L,0) D
 . I '(C<IOSL) D HDR(.YSHDR) S C=3
 . W !,Y S C=C+1
 ;
 I '$D(ZTQUEUED),$E(IOST,1,2)="C-" D ENTR
 S:$D(ZTQUEUED) ZTREQ="@"  ; delete the task
 ; clean up and exit
 U IO(0) D ^%ZISC
 K ^TMP($J,"YSDFN"),^TMP($J,"YSTXT"),^TMP($J,"YS TIMES"),ZTREQ
 Q
 ;
RXBYDT ; Clozapine prescriptions for a date range, 27 April 2020
 D DT^DICRW W !,"List all Clozapine prescriptions for a date range.",!
 N DIR,X,Y,YSRXDT,DUTOUT,DTOUT,Z
 D CLOZ^PSS50(,"??",$$FMADD^XLFDT(DT,-90),,,"ACLOZ")
 S Y=0 F  S Y=$O(^TMP($J,"ACLOZ",Y)) Q:'Y  S Z=0 F  S Z=$O(^TMP($J,"ACLOZ",Y,"CLOZ",Z)) Q:'Z  S CLOZLST(Y)=""
 ;I '$O(^PSDRUG("ACLOZ",0)) D  Q
 I '$O(CLOZLST(0)) D  Q
 . N DIR S DIR(0)="EA" W !,"No Clozapine drugs have been identified in the DRUG file (#52).",!
 . S DIR("A")="Press enter: " D ^DIR
 ;
 K DIR,X,Y S DIR(0)="DA^:"_DT_":EPX",DIR("A")="Select earliest Clozapine prescription Fill Date: "
 D ^DIR Q:'(Y>0)!$D(DTOUT)!$D(DUOUT)
 S YSRXDT("BEG")=Y
 K DIR,X,Y S DIR(0)="DA^"_YSRXDT("BEG")_":"_DT_":EPX",DIR("A")="Select latest Clozapine prescription Fill Date: "
 D ^DIR Q:'(Y>0)!$D(DTOUT)!$D(DUOUT)
 S YSRXDT("END")=Y
 ;
 N %ZIS
 S %ZIS="MQ",%ZIS("A")="Select Clozapine Prescription Report device: ",%ZIS("B")=""
 D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q
 . N ZTDESC,ZTRTN,ZTSAVE,ZTSK S ZTSAVE("YSRXDT(")=""
 . S ZTRTN="RXDTLST^"_$T(+0),ZTDESC="YSCL Clozapine Rx Report option"
 . D ^%ZTLOAD,HOME^%ZIS
 . I $G(ZTSK) W !,"Queued as task #"_ZTSK Q
 . W !,"Report not queued!" Q
 ;
 D RXDTLST U IO(0) D ^%ZISC
 Q
 ;
RXDTLST ; prescriptions for a date range, entry from TaskMan or direct call
 ; YSRXDT array required
 U IO K ^TMP($J)
 N CLOZLST,DFN,DPTR,X,Y,YSCLZRPT,YSCNTR,YSHDR,YSIENRX,YSLN,YSRX,YSTXLN,ZTQUEUED,Z
 ; get list of Clozapine DRUG IENs
 D CLOZ^PSS50(,"??",$$FMADD^XLFDT(DT,-90),,,"ACLOZ")
 S Y=0 F  S Y=$O(^TMP($J,"ACLOZ",Y)) Q:'Y  S Z=0 F  S Z=$O(^TMP($J,"ACLOZ",Y,"CLOZ",Z)) Q:'Z  S CLOZLST(Y)=""
 ;S Y=0 F  S Y=$O(^PSDRUG("ACLOZ",Y)) Q:'Y  S CLOZLST(Y)=""
 ;
 S Y=YSRXDT("BEG")-.0000001
 ; iterate for date range, look for Clozapine IEN, cross-ref. ^PSRX("ADL",FILLDATE,DRUG POINTER,DA)=""
 F  S Y=$O(^PSRX("ADL",Y)) Q:'Y!(Y>YSRXDT("END"))  S DPTR=0 F  S DPTR=$O(CLOZLST(DPTR)) Q:'DPTR  D:$O(^PSRX("ADL",Y,DPTR,0))
 . ; collect prescriptions
 . S YSIENRX=0 F  S YSIENRX=$O(^PSRX("ADL",Y,DPTR,YSIENRX)) Q:'YSIENRX  S ^TMP($J,"YSclozIEN",YSIENRX)="",^TMP($J,"YSclozIEN",YSIENRX,"fillDt")=Y
 ;
 S YSHDR(1)="Clozapine Prescriptions Filled "_$$FMTE^XLFDT(YSRXDT("BEG"))_" to "_$$FMTE^XLFDT(YSRXDT("END"))
 S YSHDR(2)=$J("Rx #",10)_$J("Patient",14)_$J("Issue Date - Fill Date",41)
 ; format the output
 S YSCLZRPT("ttl")=0,YSIENRX=0 F  S YSIENRX=$O(^TMP($J,"YSclozIEN",YSIENRX)) Q:'YSIENRX  D
 . K YSRX S YSRX(0)=$G(^PSRX(YSIENRX,0)),DFN=+$P(YSRX(0),U,2)
 . S X=$P(YSRX(0),U),YSTXLN=X_$J(" ",10-$L(X))  ; RX #
 . S YSTXLN=YSTXLN_$$GET1^DIQ(2,DFN,.01)  ; PATIENT
 . S X=$$GET1^DIQ(2,DFN,.09)  ; SSN
 . S YSTXLN=YSTXLN_" ("_$E(X,1,3)_"-"_$E(X,4,5)_"-"_$E(X,6,10)_")"  ; format SSN, 10 chars. in case of pseudo-SSN
 . S YSCLZRPT("ttl")=YSCLZRPT("ttl")+1 D TMPLN(.YSCNTR,$J(YSCLZRPT("ttl"),4)_". "_YSTXLN)  ; counter
 . S YSTXLN="   "_$$GET1^DIQ(52,YSIENRX,6)  ; DRUG
 . S X=$$GET1^DIQ(52,YSIENRX,100),YSTXLN=YSTXLN_" - "_X  ; STATUS
 . S YSTXLN=YSTXLN_$J(" ",45-$L(YSTXLN))  ; padding
 . S X=$P(YSRX(0),U,13),YSTXLN=YSTXLN_" "_$$FMTE^XLFDT(X,2)  ; ISSUE DATE
 . S X=^TMP($J,"YSclozIEN",YSIENRX,"fillDt"),YSTXLN=YSTXLN_" - "_$$FMTE^XLFDT(X,2)  ; FILL DATE
 . D TMPLN(.YSCNTR,YSTXLN)
 ;
 D TMPLN(.YSCNTR,""),TMPLN(.YSCNTR,"Total found: "_YSCLZRPT("ttl"))
 D TMPLN(.YSCNTR,""),TMPLN(.YSCNTR,$$EOR)
 ;
 W @IOF,YSHDR(1),!,YSHDR(2) S YSCLZRPT("rptExit")=0,YSLN=0,YSLN("ioCnt")=2
 F  S YSLN=$O(^TMP($J,"YSTXT",YSLN)) Q:'YSLN!YSCLZRPT("rptExit")  S Y=^TMP($J,"YSTXT",YSLN,0)  D
 . W !,Y S YSLN("ioCnt")=YSLN("ioCnt")+1 Q:YSLN("ioCnt")+2<IOSL!'$O(^TMP($J,"YSTXT",YSLN))
 . I '$G(ZTSK)&($E(IOST,1,2)="C-") D  ; no break if queued or not a terminal
 ..  N DIR S DIR(0)="EA",DIR("A")="Enter to continue, '^' to exit: " D ^DIR
 ..  S:$D(DUOUT)!$D(DTOUT)!(Y[U) YSCLZRPT("rptExit")=1
 . ;
 . Q:YSCLZRPT("rptExit")
 . W @IOF,YSHDR(1),!,YSHDR(2) S YSLN("ioCnt")=2
 ;
 I '$D(ZTQUEUED),$E(IOST,1,2)="C-",'$G(YSCLZRPT("rptExit")) D ENTR
 S:$D(ZTQUEUED) ZTREQ="@"  ; delete the task
 K ^TMP($J),ZTREQ  ; clean up
 Q
 ;
HDR(HDRLNS) ; header, HDRLNS passed by ref.
 S HDRLNS("pgNum")=HDRLNS("pgNum")+1
 W !,HDRLNS(1),!,HDRLNS(2)_HDRLNS("pgNum"),!,HDRLNS(3)
 Q
 ;
ENTR ; prompt user, nothing returned
 U IO(0) N DIR S DIR(0)="EA",DIR("A")="Press enter: " D ^DIR Q
 ;
WPL(WPTXT,LN) ; add LN to WPTXT in W-P format, WPTXT passed by ref.
 S:$G(LN)="" LN=" "  ; blank line to space
 S WPTXT(0)=$G(WPTXT(0))+1,WPTXT(WPTXT(0),0)=LN Q
 ;
TMPLN(CNTR,TX) ; add TX to ^TMP($J,"YSTXT") in w-p format, CNTR passed by ref.
 S:$G(TX)="" TX=" "  ; blank line to space
 S CNTR=$G(CNTR)+1,^TMP($J,"YSTXT",CNTR,0)=TX Q
 ;
EOR() Q $J("*** END OF REPORT ***",50)
 ;
