FSCRX ;SLC/STAFF-NOIS Report Extract ;1/29/98  18:51
 ;;1.1;NOIS;;Sep 06, 1998
 ;
EXTRACT ; from FSCFORMF
 N ALL
 I TYPE'["VIEW" Q
 I CALLNUM=0 W !,"No calls to display." H 2 S DTOUT=1 Q
 I $G(CALLCNT)=1 D  Q
 .D FULL^VALM1
 .W !,"This is a special ouput to capture NOIS data using a terminal emulator."
 .K EXTRACT,CHOICE
 .;D FIELDS(.EXTRACT,.CHOICE,.OK)
 .S CNT=0 F  S CNT=$O(FORMAT(CNT)) Q:CNT<1  S CHOICE(CNT)=FORMAT(CNT),FIELDS($P(FORMAT(CNT),U,7))=""
 .N DIR,X,Y K DIR
 .S DIR(0)="FAO^1:1",DIR("A")="Enter a delimiter: ",DIR("B")=","
 .S DIR("?",1)="Enter a single character used to delimit the fields."
 .S DIR("?",2)="If the data contains this delimiter it will be repalced by a space."
 .S DIR("?",3)="For example: DOE,JOHN with a comma delimiter would appear as DOE JOHN."
 .S DIR("?",4)="Enter 'E' to exit (NOTE: a '^' will be used as a delimiter)."
 .S DIR("?",5)="Enter '??' for more help."
 .S DIR("?")="^D HELP^FSCU(.DIR)"
 .S DIR("??")="FSC U1 NOIS"
 .W !,"-- Begin capture after this prompt. --"
 .D ^DIR K DIR
 .I Y="E"!$D(DTOUT) S DTOUT=1 Q
 .S DELIM=$S($L(Y):Y,1:",")
 .S IOP=";255;9999" D ^%ZIS
 .W !
 .S ALL=0 I '$L($O(EXTRACT(""))) S ALL=1
 .D GET^FSCGET($S('ALL:"CUSTOM",1:"DETAIL"),CALLNUM,.EXTRACT)
 .S:$D(EXTRACT("REF"))!ALL EXTRACT("REF")=U_$P($G(^FSCD("CALL",CALLNUM,0)),U) S:$D(EXTRACT("SUBJECT"))!ALL EXTRACT("SUBJECT")=U_$G(^(1))
 .S CNT=0 F  S CNT=$O(CHOICE(CNT)) Q:CNT<1  S VALUE=$P(CHOICE(CNT),U,7) W $TR(VALUE,DELIM," "),DELIM
 .W ! D FORMATX
 .I $G(CALLCNT)=+^TMP("FSC LIST CALLS",$J) W ! D HOME^%ZIS,PAUSE^FSCU(.OK) K EXTRACT
 I $G(CALLCNT)'=1 D
 .S ALL=0 I '$L($O(EXTRACT(""))) S ALL=1
 .D GET^FSCGET($S('ALL:"CUSTOM",1:"DETAIL"),CALLNUM,.EXTRACT)
 .S:$D(EXTRACT("REF"))!ALL EXTRACT("REF")=U_$P($G(^FSCD("CALL",CALLNUM,0)),U) S:$D(EXTRACT("SUBJECT"))!ALL EXTRACT("SUBJECT")=U_$G(^(1))
 .D FORMATX
 I $G(CALLCNT)=+^TMP("FSC LIST CALLS",$J) W ! D HOME^%ZIS,PAUSE^FSCU(.OK) K EXTRACT
 Q
 ;
FIELDS(FIELDS,CHOICE,OK) ;
 S OK=1
 N DIR,X,Y K DIR
 S DIR(0)="SAMO^FORMAT:FORMAT;SELECT:SELECT",DIR("A")="Select (F)ormat or (S)elect fields: "
 S DIR("?",1)="Enter FORMAT to select a format (a collect of fields)."
 S DIR("?",2)="Enter SELECT to select specific fields to be extracted."
 S DIR("?")="^D HELP^FSCU(.DIR)"
 S DIR("??")="FSC U1 NOIS"
 D ^DIR K DIR
 I $D(DIRUT) S OK=0 Q
 I Y="SELECT" D SELECT(.FIELDS,.CHOICE,.OK)
 I Y="FORMAT" D FORMAT(.FIELDS,.CHOICE,.OK)
 Q
 ;
SELECT(FIELDS,CHOICE,OK) ;
 K FIELDS,CHOICE S OK=0
 N CNT,DIC,X,Y K DIC,Y
 S DIC=7107.2,DIC(0)="AEMOQZ",DIC("A")="Select Field: " F CNT=1:1 D ^DIC Q:Y<1  S CHOICE(CNT)=Y(0),FIELDS($P(Y(0),U,7))=""
 K DIC
 Q
FORMAT(FIELDS,CHOICE,OK) ;
 K FIELDS,CHOICE S OK=1
 N CNT,DIC,X,Y K DIC,Y
 S DIC=7107.6,DIC(0)="AEMOQZ",DIC("A")="Select Format: ",DIC("S")="I $O(^(2,0))" D ^DIC K DIC Q:Y<1
 Q
FORMATX ;
 W !
 S CNT=0 F  S CNT=$O(CHOICE(CNT)) Q:CNT<1  S VALUE=$P(CHOICE(CNT),U,7) S:$P(CHOICE(CNT),U,3)="D" $P(EXTRACT(VALUE),U,2)=$$DATE(+EXTRACT(VALUE)) W $TR($P(EXTRACT(VALUE),U,2),DELIM," "),DELIM
 Q
 ;
DATE(DATETIME) ; $$(date) -> M/D/Y HH:MM
 Q:'DATETIME ""
 S DATETIME=+$TR($J(DATETIME,$L(DATETIME),4)," ","")
 Q $TR($$FMTE^XLFDT(DATETIME,2),"@"," ")
