GMRCIAIT ;SLC/JFR - PRINT ALL INC. IFC TRANSACTIONS; 12/18/02 09:11
 ;;3.0;CONSULT/REQUEST TRACKING;**30**;DEC 27, 1997
EN ; get the device to use
 N %ZIS,POP
 S %ZIS="QM" D ^%ZIS
 I POP D HOME^%ZIS Q
 I $D(IO("Q")) D  D ^%ZISC,HOME^%ZIS Q
 . N ZTRTN,ZTSK,ZTIO,ZTDTH,ZTDESC
 . S ZTRTN="RPT^GMRCIAIT",ZTDESC="Incomplete IFC Transaction report"
 . S ZTIO=ION,ZTDTH=$H
 . D ^%ZTLOAD
 . I $G(ZTSK) W !,"Queued to Print, Task # ",ZTSK
 . E  W !,"Sorry, Try again Later"
 D RPT
 D ^%ZISC,HOME^%ZIS
 Q
RPT ; sort logic
 I $D(ZTQUEUED) S ZTREQ="@"
 U IO
 N GMRCDA,GMRCPAGE,GMRCQT
 S GMRCDA=0,GMRCPAGE=1
 I '$O(^GMR(123.6,"AC",GMRCDA)) D HDR(.GMRCPAGE),NOREC Q
 D HDR(.GMRCPAGE)
 F  S GMRCDA=$O(^GMR(123.6,"AC",GMRCDA)) Q:'GMRCDA!($D(GMRCQT))  D
 . I $Y>(IOSL-9) D  Q:$D(GMRCQT)
 .. N DIR,DIRUT,DIROUT,DUOUT,DTOUT
 .. ;W !
 .. I $E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR
 .. I $D(DIRUT) S GMRCQT=1 Q
 .. D HDR(.GMRCPAGE)
 . W !!,?11,"CONSULT/REQUEST #: ",GMRCDA
 . N GMRCACT,GMRCLOG
 . S GMRCACT=0
 . F  S GMRCACT=$O(^GMR(123.6,"AC",GMRCDA,GMRCACT)) Q:'GMRCACT!($D(GMRCQT))  D
 .. S GMRCLOG=$O(^GMR(123.6,"AC",GMRCDA,GMRCACT,1,0)) Q:'GMRCLOG
 .. I $Y>(IOSL-8) D  Q:$D(GMRCQT)
 ... N DIR,DIRUT,DIROUT,DUOUT,DTOUT
 ... ;W !
 ... I $E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR
 ... I $D(DIRUT) S GMRCQT=1 Q
 ... D HDR(.GMRCPAGE)
 .. D PRTLOG(GMRCLOG,GMRCDA,GMRCACT)
 .. Q
 . Q
 Q
PRTLOG(LOG,CSLT,ACTVT) ;print the formatted entry
 ;
 ; Input:
 ;   LOG   = ien from file 123.6
 ;   CSLT  = ien from file 123 associated with LOG
 ;   ACTVT = activity within CSLT that is incomplete
 ;
 N GMRCMSG,GMRCPT,GMRCSSN,GMRCERR,GMRCDT
 N GMRCFAC,GMRCSER,GMRCTRAN,GMRCLOG0,GMRCDTR
 S GMRCLOG0=$G(^GMR(123.6,LOG,0)) I '$L(GMRCLOG0) Q
 S GMRCDT=$$FMTE^XLFDT($P(GMRCLOG0,U),2)
 S GMRCFAC=$$GET1^DIQ(4,$P(GMRCLOG0,U,2),.01)
 S GMRCMSG=$P(GMRCLOG0,U,3)
 S GMRCTRAN=$P(GMRCLOG0,U,7)
 S GMRCERR=$$GET1^DIQ(123.6,LOG,.08)
 S GMRCSER=$$GET1^DIQ(123,CSLT,1)
 S GMRCPT=$$GET1^DIQ(123,CSLT,.02,"I")
 S GMRCDTR=$$FMTE^XLFDT($$GET1^DIQ(123,CSLT,.01,"I"),2)
 S GMRCSSN=$$GET1^DIQ(2,GMRCPT,.09)
 S GMRCPT=$$GET1^DIQ(2,GMRCPT,.01)
 W !!,?2,"Date/Time last transmitted: ",GMRCDT
 W ?51,"Trans. attempts: ",GMRCTRAN
 W !,?2,"Facility: ",GMRCFAC,?51,"Message: ",GMRCMSG
 W !,?2,"Consult #: ",CSLT,?51,"Activity: ",ACTVT
 W !,?2,"Patient name: ",GMRCPT,?51,"SSN: ",GMRCSSN
 W !,?2,"Ordered Service: ",$E(GMRCSER,1,31),?51,"Req. date: ",GMRCDTR
 W !,?2,"Error: ",GMRCERR
 Q
NOREC ; print the no records found message
 W !,?5,"No incomplete IFC Transactions to report",!
 Q
HDR(PAGE) ; print the page hdr and increment page number
 ;
 W @IOF
 W "Incomplete IFC Transaction Report"
 W ?44,$$FMTE^XLFDT($$NOW^XLFDT),?69,"Page: ",PAGE
 W !,$$REPEAT^XLFSTR("-",78)
 S PAGE=PAGE+1
 Q
