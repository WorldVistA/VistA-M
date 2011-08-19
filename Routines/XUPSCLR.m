XUPSCLR ;OIFO-CS/GRR/RAM/DW/PN - New Person file Cleanup Report ; 1 Jan 2004
 ;;8.0;KERNEL;**309**; Jul 10, 1995
 ;
 Q
 ;
DETAIL ; -- detailed report
 ;
 N TYPE
 ;
 S TYPE="Detail Report of"
 ;
 D EN
 ;
 Q
 ;
STATS ; -- totals only
 ;
 N TYPE
 ;
 S TYPE="Statistical Report of"
 ;
 D EN
 ;
 Q
 ;
EN ; -- entry point
 ;
 N ZTDESC,ZTSAVE,ZTIO,ZTDTH,X,ZTQUEUED,ZTREQ,ZTRTN,DIR,POP,Y
 ;
 W !!,"This option will print "_TYPE
 W " entries missing SEX, DOB, or SSN",!
 W "data in the New Person file (#200)",!
 ;
 S DIR(0)="YA",DIR("B")="Yes",DIR("A")="Do you wish to continue? "
 S DIR("?")="Enter 'Yes' to continue or 'No' to quit"
 D ^DIR K DIR ;ask user if they want to continue with option
 Q:'Y!($D(DIRUT))  ;user responded No or with '^' to exit
 ;
 ;initialize task variables
 S ZTDESC="New Person file Cleanup report"
 S ZTRTN="EN1^XUPSCLR"
 S ZTSAVE("TYPE")=TYPE
 ;
 I TYPE="Detail Report of" D
 . W !!,"The report may be lengthy. "
 . W "It is suggested to queue the report."
 D ZIS^XUPSUTQ ;does device selection and queueing if selected
 Q:POP  ;quit if task was queued
 ; 
EN1 ;
 ;
 N ACTIVE,DIR,DIRUT,DOB,SSN,FLG,I,IEN,MISS,MISSING,NODE,Y,PHONE
 N NAME,PERSON,POP,SEX,TOTAL,VISITOR,X,XUPSDT,XUPSL,XUPSREC
 ;
 D INIT
 ;
 S IEN=.9
 F  S IEN=$O(^VA(200,IEN)) Q:'IEN  D XXX
 ;
 I $E(TYPE,1)="D" D ZZZ Q:FLG
 ;
 D TOTALS
 ;
 W:PERSON @IOF
 ;
 D ^%ZISC
 S:$D(ZTQUEUED) ZTREQ="@"
 ;
 Q
 ;
HEAD ; write report header
 ;
 ; pause and wait for user reponse before displaying next screen
 I $E(IOST,1,2)="C-",NAME'="" D  Q:FLG
 .W !
 .S DIR(0)="E" D ^DIR S FLG='Y
 ;
 ;if terminal clear screen first time
 I $E(IOST,1,2)="C-",NAME="" W @IOF
 ;
 ;if printer do not form feed before printing first page
 I NAME'="" W @IOF
 ;
 W !,?1,"New Person file Assessment Report - "
 W XUPSREC_" Persons",?55,XUPSDT
 W !,?1,"Person Name",?31,"IEN",?40,"Missing",?48,"Missing"
 W ?56,"Missing",?65,"Office Phone",!,?42,"SEX",?50,"DOB",?58,"SSN",!
 ;
 Q
 ;
TOTALS ;
 ;if terminal pause after full screen
 I $E(TYPE,1)="D",$E(IOST)="C" D  Q:FLG
 .S DIR(0)="E" D ^DIR
 .S:'Y FLG=1
 ;
 W @IOF
 ;W !,"NOTE: Visitor entries not included in totals other "
 ;W "than the Visitor total!",!
 ;
 S XUPSL="Total Entries: " W !,?(50-$L(XUPSL)),XUPSL,$J(PERSON,6,0)
 S XUPSL="Total Visitor Entries: "
 W !,?(50-$L(XUPSL)),XUPSL,$J(VISITOR,6,0)
 S XUPSL="(Visitor entries not included in the following counts)"
 W !!,?(50-$L(XUPSL)),XUPSL
 S XUPSL="Total Non-Visitor Entries: "
 W !,?(50-$L(XUPSL)),XUPSL,$J(PERSON-VISITOR,6,0)
 S XUPSL="Total Entries Missing Sex Code: "
 W !,?(50-$L(XUPSL)),XUPSL,$J(MISSING("SEX"),6,0)
 S XUPSL="Total Entries Missing DOB: "
 W !,?(50-$L(XUPSL)),XUPSL,$J(MISSING("DOB"),6,0)
 S XUPSL="Total Entries Missing SSN: "
 W !,?(50-$L(XUPSL)),XUPSL,$J(MISSING("SSN"),6,0)
 S XUPSL="Total Entries Missing One Data Element: "
 W !,?(50-$L(XUPSL)),XUPSL,$J(MISS(1),6,0)
 S XUPSL="Total Entries Missing Two Data Elements: "
 W !,?(50-$L(XUPSL)),XUPSL,$J(MISS(2),6,0)
 S XUPSL="Total Entries Missing Three Data Elements: "
 W !,?(50-$L(XUPSL)),XUPSL,$J(MISS(3),6,0)
 S XUPSL="Total Entries Missing Data: "
 W !,?(50-$L(XUPSL)),XUPSL,$J(TOTAL("MISSING"),6,0)
 S XUPSL="Total Active Entries: "
 W !!,?(50-$L(XUPSL)),XUPSL,$J(ACTIVE("TOTAL"),6,0)
 S XUPSL="Total Active Entries Missing Data: "
 W !,?(50-$L(XUPSL)),XUPSL,$J(ACTIVE("MISSING"),6,0)
 S XUPSL="Total Active Entries Missing Sex Code: "
 W !,?(50-$L(XUPSL)),XUPSL,$J(ACTIVE("SEX"),6,0)
 S XUPSL="Total Active Entries Missing DOB: "
 W !,?(50-$L(XUPSL)),XUPSL,$J(ACTIVE("DOB"),6,0)
 S XUPSL="Total Active Entries Missing SSN: "
 W !,?(50-$L(XUPSL)),XUPSL,$J(ACTIVE("SSN"),6,0)
 S XUPSL="Total Active Entries Missing One Data Elements: "
 W !,?(50-$L(XUPSL)),XUPSL,$J(ACTIVE(1),6,0)
 S XUPSL="Total Active entries Missing Two Data Elements: "
 W !,?(50-$L(XUPSL)),XUPSL,$J(ACTIVE(2),6,0)
 S XUPSL="Total Active Entries Missing Three Data Elements: "
 W !,?(50-$L(XUPSL)),XUPSL,$J(ACTIVE(3),6,0)
 ;
 ;pause before clearing screen if terminal
 I $E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR
 ;
 Q
 ;
XXX ;
 S PERSON=PERSON+1  ;count IEN
 ;
 ; count visitors - quit if visitor
 I '$$ACTIVE^XUSER(IEN),$D(^VA(200,IEN,8910)) D  Q
 .S VISITOR=VISITOR+1
 ;
 ; count active
 I $$ACTIVE^XUSER(IEN) D
 .S ACTIVE("TOTAL")=ACTIVE("TOTAL")+1,XUPSREC="Active"
 ;
 ; not active user
 I '$$ACTIVE^XUSER(IEN) S XUPSREC="Inactive"
 ;
 S (SEX,DOB,SSN)="" ;initialize missing data designator
 S MISSING=0 ;initialize total missing for this entry
 S NODE=$G(^VA(200,IEN,1)) ;get node where data is stored
 ;
 I $P(NODE,"^",2)="" D  ;sex is missing
 .S SEX="X" ;flag as missing on report
 .S MISSING("SEX")=MISSING("SEX")+1 ;add 1 to missing sex count
 .S MISSING=MISSING+1 ;add 1 to missing data this entry count
 .S:$$ACTIVE^XUSER(IEN) ACTIVE("SEX")=ACTIVE("SEX")+1
 ;
 I $P(NODE,"^",3)="" D  ;dob is missing
 .S DOB="X" ;flag as missing on report
 .S MISSING("DOB")=MISSING("DOB")+1 ;add 1 to missing dob count
 .S MISSING=MISSING+1 ;add 1 to missing data this entry count
 .S:$$ACTIVE^XUSER(IEN) ACTIVE("DOB")=ACTIVE("DOB")+1
 ;
 I $P(NODE,"^",9)="" D  ;ssn missing
 .S SSN="X" ;flag as missing on report
 .S MISSING("SSN")=MISSING("SSN")+1 ;add 1 to missing ssn count
 .S MISSING=MISSING+1 ;add 1 to missing count this entry
 .S:$$ACTIVE^XUSER(IEN) ACTIVE("SSN")=ACTIVE("SSN")+1
 ;
 Q:'MISSING  ;entry not missing any data, nothing to print
 ;
 S TOTAL("MISSING")=TOTAL("MISSING")+1
 ;
 I $$ACTIVE^XUSER(IEN) S ACTIVE("MISSING")=ACTIVE("MISSING")+1
 ;
 I $$ACTIVE^XUSER(IEN) D
 .S ACTIVE(MISSING)=ACTIVE(MISSING)+1
 ;
 S MISS(MISSING)=MISS(MISSING)+1
 ;
 I $E(TYPE,1)="D" D
 .N X
 .S PHONE=$P($G(^VA(200,IEN,.13)),"^",2)
 .S X=PHONE_"^"_SEX_"^"_DOB_"^"_SSN
 . I $P($G(^VA(200,IEN,0)),"^",1)="" Q
 .S ^TMP($J,XUPSREC,$P(^VA(200,IEN,0),"^",1),IEN)=X
 ;
 Q
 ;
INIT ; -- initialize
 ;
 K ^TMP($J)
 ;
 S (ACTIVE("MISSING"),ACTIVE("TOTAL"),TOTAL("MISSING"))=0
 S (PERSON,VISITOR,FLG,ACTIVE)=0
 ;
 F I=1:1:3 S (MISS(I),ACTIVE(I))=0
 F I="SEX","DOB","SSN" S (ACTIVE(I),MISSING(I))=0
 ;
 ;get current date/time reformat to external form for header
 N %,%I,%H D NOW^%DTC S Y=% D DD^%DT S XUPSDT=Y
 ;
 Q
 ;
ZZZ ; -- detailed output
 ;
 S XUPSREC="Active" D YYY Q:FLG
 I $E(IOST,1,2)="C-" D  Q:FLG
 .W !
 .S DIR(0)="E" D ^DIR
 .S:'Y FLG=1
 I $E(IOST,1,2)'="C-" W @IOF
 ;
 S XUPSREC="Inactive" D YYY
 ;
 Q
 ;
YYY ;
 S NAME=""
 ;
 D HEAD Q:FLG
 ;
 F  S NAME=$O(^TMP($J,XUPSREC,NAME)) Q:NAME=""!(FLG)  D
 .S IEN=0
 .F  S IEN=$O(^TMP($J,XUPSREC,NAME,IEN)) Q:'IEN!(FLG)  D
 ..S NODE=^TMP($J,XUPSREC,NAME,IEN)
 ..S PHONE=$P(NODE,"^",1)
 ..S SEX=$P(NODE,"^",2)
 ..S DOB=$P(NODE,"^",3)
 ..S SSN=$P(NODE,"^",4)
 ..W !,$P(^VA(200,IEN,0),"^",1)
 ..W ?31,IEN,?43,SEX
 ..W ?51,DOB,?59,SSN,?65,PHONE
 ..I $Y>(IOSL-6) D HEAD
 ;
 Q
 ;
