LRAPFICH ;AVAMC/REG/WTY/KLL - MICROFICH PATH REPORTS ;03/21/2002
 ;;5.2;LAB SERVICE;**72,173,248,259**;Sep 27, 1994
 ;
 D END ;Final path reports by accession number
 N LRQUIT
 W ! S LRDICS="SPCYEM" D ^LRAP G:'$D(Y) END
 ;KLL - Final Office Copy prints SNOMED codes on a separate page
 D FOC
 ;Variable LR("DVD") is used to divide reports displayed in the browser
 K LR("DVD")
 S $P(LR("DVD"),"|",IOM)=""
 S %DT("A")="Select Accession YEAR: ",%DT="AEQ" D ^%DT K %DT G:Y<1 END S LR("Y")=$E(Y,1,3)
A R !,"Start with accession #: ",X:DTIME G:X[U!(X="") END I X'?1N.N W $C(7),!,"Enter a number." G A
 S LR("B")=X
B R !,"Go      to accession #: ",X:DTIME G:X[U!(X="") END I X'?1N.N W $C(7),!,"Enter a number." G B
 S LR("E")=X I LR("E")<LR("B") S X=LR("B"),LR("B")=LR("E"),LR("E")=X
 S LR("B")=LR("B")-1
SETUP ;
 W !
 S %ZIS="Q" D ^%ZIS
 I POP W ! D END Q
 I $D(IO("Q")) D  Q
 .S ZTDESC="Final path reports by accession #"
 .S ZTSAVE("*")="",ZTRTN="QUE^LRAPFICH",ZTREQ="@",ZTIO=ION
 .D ^%ZTLOAD W:$D(ZTSK) !,"Report Queued to device ",ION K ZTIO
 .D HOME^%ZIS K ZTSK,IO("Q"),ZTREQ
QUE ;
 U IO S LR("DIWF")="W",(LR,LR("A"),LR(1),LR(2),LR(3))=0
 S (LRA,LRQ(3))=1
 D L^LRU,S^LRU,XR^LRU,L1^LRU,EN2^LRUA,SET^LRUA
 S LRAN=LR("B")
 F  S LRAN=$O(^LR(LRXREF,LR("Y"),LRABV,LRAN)) Q:'LRAN!(LRAN>LR("E"))!(LR("Q"))  D
 .S LRDFN=$O(^LR(LRXREF,LR("Y"),LRABV,LRAN,0)),LRI=$O(^(LRDFN,0))
 .S LRSF515=1,LRQUIT=0
 .K LR("F")
 .D TIUCHK^LRAPUTL(.LRPTR,LRDFN,LRSS,LRI)
 .I +$G(LRPTR) D  Q
 ..D MAIN^LRAPTIUP(LRPTR,0)
 ..W:IOST["BROWSER" !!,LR("DVD")
 ..K LRPTR
 ..;KLL-Print SNOMED Codes if Final Office Copy selected
 ..I LRFOC D FOC^LRSPRPT
 ..I LRQUIT S LR("Q")=1 Q
 ..S LR("F")=1
 ..I 'LR("Q"),$D(LR("F")),IOST?1"C-".E D CONT
 .W:IOST?1"C-".E @IOF
 .D EN^LRSPRPT
 .W:IOST?1"P-".E @IOF
 .W:IOST["BROWSER" !!,LR("DVD")
 .I LRFOC D FOC^LRSPRPT
 .I 'LR("Q"),$D(LR("F")),IOST?1"C-".E D CONT
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 K %,DIR,DTOUT,DUOUT,DIRUT,X,Y
 D END
 Q
FOC ;Final Office Copy
 W !
 K DIR
 S LRFOC=0
 S DIR(0)="Y",DIR("A")="Is this a final office copy"
 S DIR("B")="YES"
 S DIR("?",1)="SNOMED codes no longer appear on the report.  The final"
 S DIR("?",1)=DIR("?",1)_" office copy prints"
 S DIR("?")="these codes on a separate page.  Enter 'Yes' to include "
 S DIR("?")=DIR("?")_"this page."
 D ^DIR
 I Y S LRFOC=1
 Q
CONT ;
 K DIR S DIR(0)="E"
 D ^DIR W !
 S:$D(DTOUT)!(X[U) LR("Q")=1
 Q
END D V^LRU
 K LRSF515
 Q
