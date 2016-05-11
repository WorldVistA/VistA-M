ORDEA01A ;ISP/RFR - DEA REPORTS 01;10/15/2014  08:03
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**218,350**;Dec 17, 1997;Build 77
 Q
DUPVA ;DUPLICATE VA#'S REPORT
 ;REP IS HANDLED BY REPORTS^ORDEA01
 N DISINC,DIV,SAVE
 W !!,"This report identifies all users with similar VA numbers. To identify",!
 W "similar numbers, the software builds a temporary index. First, it removes all",!
 W "non-alphanumeric characters (such as punctuation and spaces) from the user's",!
 W "VA number, then changes all letters to uppercase, and finally adds the VA",!
 W "number to the temporary index. It then uses that index to build a list of",!
 W "similar or duplicate numbers. For example, kc123, KC 123, and KC-123 are",!
 W "considered similar.",!
 S DISINC=$$DISPRMPT^ORDEA01()
 Q:DISINC=U
 S SAVE("DISINC")=""
 D DEVICE^ORUTL($P(REP(REP),";",3),"OR "_$$UP^XLFSTR($P(REP(REP),";")),"Q",.SAVE)
 Q
DUPVAQ ;TASKMAN ENTRY POINT
 ;CBUFFER IS HANDLED BY DEVICE^ORUTL OR TASKMAN
 N DOCS,ERROR,KEY,INDEX,NUMBER,DUPL,PGNUM,COL,STOP,OUTPUT
 ;RETRIEVE ALL USERS WITH A VA #
 S DOCS=$NA(^TMP($J,"ORDUPVA")),DUPL=$NA(^TMP($J,"ORDUPVA","DUPL"))
 K @DOCS
 D LIST^DIC(200,,"@;.01;53.3","PQ",,,,"PS2",,,DOCS,"ERROR")
 I $D(ERROR) D  Q
 .D FMERROR^ORUTL(.ERROR)
 .S:$D(ZTQUEUED) ZTREQ="@"
 ;ORDER THE RETURNED LIST BY VA #
 S INDEX=0 F  S INDEX=$O(@DOCS@("DILIST",INDEX)) Q:+$G(INDEX)=0  D
 .S NUMBER=$P(@DOCS@("DILIST",INDEX,0),U,3),KEY=$$UP^XLFSTR(NUMBER)
 .S KEY=$$STRIP(KEY)
 .Q:$G(KEY)=""
 .N ACCOUNT S ACCOUNT=$$ACTIVE^XUSER($P(@DOCS@("DILIST",INDEX,0),U))
 .I 'DISINC,(+ACCOUNT<1),($P(ACCOUNT,U,2)'="") Q
 .S ACCOUNT("TEXT")=$S($P(ACCOUNT,U,2)'="":$P(ACCOUNT,U,2),ACCOUNT=0:"CANNOT SIGN ON",1:"UNKNOWN")
 .S @DUPL@(KEY)=+$G(@DUPL@(KEY))+1
 .S @DUPL@(KEY,@DUPL@(KEY),NUMBER)=$$LJ^XLFSTR($P(@DOCS@("DILIST",INDEX,0),U,2),37," ")_ACCOUNT("TEXT")
 ;OUTPUT THE DUPLICATES
 S COL(1)=$$LJ^XLFSTR("VA#",12," ")_$$LJ^XLFSTR("NAME",37," ")_"ACCOUNT STATUS"
 S KEY="" F  S KEY=$O(@DUPL@(KEY)) Q:$G(KEY)=""!($G(STOP))  D
 .I @DUPL@(KEY)>1 D
 ..S OUTPUT=1
 ..I (@DUPL@(KEY)+$Y+CBUFFER)>IOSL!($Y=0) S STOP=$$HEADER^ORUTL("NON-UNIQUE VA NUMBERS REPORT",.PGNUM,.COL)
 ..Q:$G(STOP)
 ..S INDEX=0 F  S INDEX=$O(@DUPL@(KEY,INDEX)) Q:+$G(INDEX)=0  D
 ...S NUMBER=$O(@DUPL@(KEY,INDEX,""))
 ...W $$LJ^XLFSTR(NUMBER,12," ")_@DUPL@(KEY,INDEX,NUMBER)
 ...I ($Y+1)<IOSL W !
 ..W $$REPEAT^XLFSTR("=",60)
 ..I ($Y+1)<IOSL W !
 I '$G(STOP) D
 .I '$G(OUTPUT) D  Q:$G(STOP)
 ..S STOP=$$HEADER^ORUTL("NON-UNIQUE VA NUMBERS REPORT",.PGNUM,.COL)
 ..Q:STOP
 ..W !,$$CJ^XLFSTR("All VA Numbers are unique.",$S(+$G(IOM)>0:(IOM-1),1:79)," "),!
 .I ($Y+2)>IOSL S STOP=$$HEADER^ORUTL("NON-UNIQUE VA NUMBERS REPORT",.PGNUM,.COL)
 .Q:$G(STOP)
 .W !,$$CJ^XLFSTR("[END OF REPORT]",$S(+$G(IOM)>0:(IOM-1),1:79)," ")
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
STRIP(TEXT) ;REMOVE PUNCTUATION CHARACTERS AND SPACES
 N %
 F %=1:1:$L(TEXT) N CHR S CHR=$A($E(TEXT,%)) I CHR<48!(CHR>57&(CHR<65))!(CHR>90&(CHR<97))!(CHR>122) S TEXT=$TR(TEXT,$E(TEXT,%))
 Q TEXT
INCOMPL ;INCOMPLETE PROVIDER SETUP REPORT
 ;REP IS HANDLED BY REPORTS^ORDEA01
 W !!,"This report identifies all active providers who are unable to sign controlled",!
 W "substance orders. For the purposes of this report, a provider is a user who",!
 W "holds the ORES security key.",!
 W !,"By default, the report lists the prescribable schedules for each provider",!
 W "(including those providers that are properly configured).",!
 N INCLUDE,DISINC,DIV,DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT,SAVE,ORCSV
 S DIR(0)="Y"_U,DIR("A")="Do you want to include prescribable schedules in the output"
 S DIR("B")="NO"
 S DIR("?",1)="By answering YES, the report will list the schedules each provider is able to"
 S DIR("?",2)="prescribe and will include those providers who are able to sign controlled"
 S DIR("?",3)="substance orders."
 S DIR("?",4)="By answering NO, the report will not list the prescribable schedules and will"
 S DIR("?",5)="only include those providers who are unable to sign controlled substance"
 S DIR("?")="orders."
 D ^DIR
 Q:$D(DIRUT)
 S INCLUDE=Y
 K X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 W !
 S DISINC=$$DISPRMPT^ORDEA01()
 Q:DISINC=U
 W !
 S X=$$DIVPRMPT^ORUTL(.DIV)
 Q:X<1
 K X,Y,DIR,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="Y"_U,DIR("A",1)="Do you want to generate the report in a delimited format suitable for import"
 S DIR("A")="into third-party applications"
 S DIR("?",1)="By answering YES, the report is generated in a comma-separated values (CSV)"
 S DIR("?",2)="format."
 S DIR("?")="By answering NO, the report is generated in a non-delimited format."
 W !
 D ^DIR
 Q:$D(DIRUT)
 S ORCSV=Y
 I ORCSV D
 .W !!,"To create a file on your computer for use in third-party applications, perform"
 .W !,"the following:",!
 .W !," 1. To queue the report, at the DEVICE: prompt, enter the letter Q."
 .W !," 2. At the DEVICE: prompt, select the appropriate spooler device."
 .W !," 3. Once the spooled document is ready, use option Download a Spool file entry"
 .W !,"    [XT-KERMIT SPOOL DL] to download the report to your computer."
 .W !,"    Note: Refer to your terminal emulator's documentation for instructions on"
 .W !,"          receiving files via the KERMIT protocol.",!
 S SAVE("INCLUDE")="",SAVE("DISINC")="",SAVE("DIV(")="",SAVE("ORCSV")=""
 D DEVICE^ORUTL($P(REP(REP),";",3),"OR "_$$UP^XLFSTR($P(REP(REP),";")),"Q",.SAVE)
 Q
INCOMPLQ ;TASKMAN ENTRY POINT
 ;CBUFFER IS HANDLED BY DEVICE^ORUTL OR TASKMAN
 N DATA,Y,INDENT,STOP,COUNT
 S DATA=$NA(^TMP($J,"ORDATA"))
 K @DATA
 S INDENT(0)=$$REPEAT^XLFSTR(" ",37),INDENT(1)=$$REPEAT^XLFSTR("-",34)
 ;IA #10076
 S Y=0 F  S Y=$O(^XUSEC("ORES",Y)) Q:+$G(Y)=0!($G(STOP))  D
 .N DIVISION S DIVISION=$$HASDIV^ORUTL(Y,.DIV)
 .Q:$G(DIVISION)=""
 .N ACCOUNT S ACCOUNT=$$ACTIVE^XUSER(Y)
 .I 'DISINC,(+ACCOUNT<1),($P(ACCOUNT,U,2)'="") Q
 .;INCLUDE USERS WHO CANNOT SIGN-ON IN ACTIVE LISTING
 .S ACCOUNT=$S(ACCOUNT=0:1,ACCOUNT="":-1,1:ACCOUNT)
 .N RETURN,STATUS
 .S STATUS=$$VDEA^XUSER(.RETURN,Y),COUNT=1+$G(COUNT)
 .S STATUS=$$CHKSWIT^ORDEA01(.RETURN,Y,STATUS)
 .I $D(RETURN)>9 D
 ..N REASON,NAME,INDEX
 ..S NAME=$$GET1^DIQ(200,Y_",",.01)
 ..I NAME="",ACCOUNT=-1 S NAME="ACCOUNT #"_Y
 ..S @DATA@(DIVISION,STATUS,+ACCOUNT,NAME)=$$GET1^DIQ(200,Y_",",8)
 ..S REASON="" F  S REASON=$O(RETURN(REASON)) Q:$G(REASON)=""  D
 ...N TEXT
 ...I '$G(INCLUDE),(REASON["Is permitted") Q
 ...I STATUS=1,(REASON'["Is permitted") D
 ....S TEXT=$$LOW^XLFSTR($E(REASON,1,1))_$E(REASON,2,$L(REASON))
 ....S TEXT="Can sign controlled substance orders, however, the provider "_TEXT
 ...S INDEX=1+$G(INDEX),@DATA@(DIVISION,STATUS,+ACCOUNT,NAME,INDEX)=$S($G(TEXT)'="":$G(TEXT),1:REASON)
 .I 'COUNT#100 S STOP=$$STOPTASK^ORUTL()
 I 'ORCSV D IREPORT
 I ORCSV D IEXPORT
 K @DATA
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
IREPORT ;CREATE NON-CSV FORMAT
 N DIVISION,NAME,LINE,STATUS,TEXT,OUTPUT,ACCOUNT,COL,PGNUM
 S DIVISION="" F  S DIVISION=$O(@DATA@(DIVISION)) Q:$G(DIVISION)=""!($G(STOP))  D
 .S COL(1)="DIVISION: "_DIVISION
 .F STATUS=0:1:1 D  Q:$G(STOP)
 ..I STATUS=1,('$G(INCLUDE)) Q
 ..Q:$D(@DATA@(DIVISION,STATUS))<10
 ..S TEXT=$S(STATUS=0:"un",1:"")_"able"
 ..S COL(2)=$$LJ^XLFSTR("PROVIDER NAME",37," ")
 ..S COL(3)=$$LJ^XLFSTR(" TITLE",37," ")_$S(TEXT="unable":"DEFICIENCY",1:"")
 ..S COL(3)=COL(3)_$S(TEXT="unable"&INCLUDE=1:"/",1:"")_$S(INCLUDE=1:"PRESCRIBABLE SCHEDULES",1:"")
 ..S STOP=$$HEADER^ORUTL("PROVIDER INCOMPLETE CONFIGURATION REPORT",.PGNUM,.COL)
 ..Q:$G(STOP)
 ..F ACCOUNT=1:-1:-1 D  Q:$G(STOP)
 ...Q:$D(@DATA@(DIVISION,STATUS,ACCOUNT))<10
 ...N BUFFER S BUFFER=@DATA@(DIVISION,STATUS,ACCOUNT,$O(@DATA@(DIVISION,STATUS,ACCOUNT,"")))
 ...S BUFFER=BUFFER+$S(ACCOUNT=0&($Y>4):3,ACCOUNT=0:2,1:0)
 ...I (BUFFER+$Y+CBUFFER)>IOSL!($Y=0) D  Q:$G(STOP)
 ....S STOP=$$HEADER^ORUTL("PROVIDER INCOMPLETE CONFIGURATION REPORT",.PGNUM,.COL)
 ...I ACCOUNT=0 D
 ....W:$Y>4 !
 ....W $$CJ^XLFSTR("*** DISUSERED/TERMINATED USERS ***",$S(+$G(IOM)>0:(IOM-1),1:79)," "),!
 ....W $$CJ^XLFSTR(INDENT(1),$S(+$G(IOM)>0:(IOM-1),1:79)," "),!
 ...S NAME="" F  S NAME=$O(@DATA@(DIVISION,STATUS,ACCOUNT,NAME)) Q:$G(NAME)=""!($G(STOP))  D
 ....N BODY
 ....S INDEX=0 F  S INDEX=$O(@DATA@(DIVISION,STATUS,ACCOUNT,NAME,INDEX)) Q:'INDEX  D
 .....D WRAP^ORUTL(INDENT(0)_@DATA@(DIVISION,STATUS,ACCOUNT,NAME,INDEX),"BODY")
 ....S BODY(1)=$$LJ^XLFSTR(NAME,37," ")_$E($G(BODY(1)),38,$S(+$G(IOM)>0:IOM,1:80))
 ....S BODY(2)=$$LJ^XLFSTR(" "_@DATA@(DIVISION,STATUS,ACCOUNT,NAME),37," ")_$E($G(BODY(2)),38,$S(+$G(IOM)>0:IOM,1:80))
 ....S:BODY<2 BODY=2
 ....I (BODY+$Y+CBUFFER)>IOSL D  Q:$G(STOP)
 .....S STOP=$$HEADER^ORUTL("PROVIDER INCOMPLETE CONFIGURATION REPORT",.PGNUM,.COL)
 ....F LINE=1:1:BODY  D
 .....W BODY(LINE)
 .....I ($Y+1)<IOSL W !
 .....S OUTPUT=1
 ....I LINE>0,(($Y+1)<IOSL) W !
 I '$G(STOP) D
 .I '$G(OUTPUT) D  Q:$G(STOP)
 ..S STOP=$$HEADER^ORUTL("PROVIDER INCOMPLETE CONFIGURATION REPORT",.PGNUM,.COL)
 ..Q:STOP
 ..N TEXT,BODY
 ..S TEXT="All providers are able to sign controlled substance orders"
 ..I $D(DIV) D
 ...N IDX,STATIONS
 ...S IDX="" F  S IDX=$O(DIV(IDX)) Q:$G(IDX)=""  D
 ....N DELIMIT
 ....S DELIMIT=$S($O(DIV(IDX))'="":", ",1:" and ")
 ....S STATIONS=$S($G(STATIONS)'="":STATIONS_DELIMIT,1:"")_DIV(IDX)
 ...S TEXT=TEXT_" in "_STATIONS
 ..D WRAP^ORUTL(TEXT_".","BODY")
 ..S BODY=0 F  S BODY=$O(BODY(BODY)) Q:'BODY  W BODY(BODY),!
 .I ($Y+2)>IOSL S STOP=$$HEADER^ORUTL("PROVIDER INCOMPLETE CONFIGURATION REPORT",.PGNUM,.COL)
 .Q:$G(STOP)
 .W !,$$CJ^XLFSTR("[END OF REPORT]",$S(+$G(IOM)>0:(IOM-1),1:79)," ")
 Q
IEXPORT ;CREATE CSV FORMAT
 N DIVISION,STATUS,ACCOUNT,NAME,Q,QCQ,LINE,XTKDIC,XTKMODE,XTKFILE
 S Q=$C(34),QCQ=Q_","_Q
 W Q_"DIVISION"_QCQ_"PROVIDER NAME"_QCQ_"TITLE"_QCQ_"DEFICIENCY"
 W $S(INCLUDE=1:"/PRESCRIBABLE SCHEDULES",1:"")_Q,!
 S DIVISION="" F  S DIVISION=$O(@DATA@(DIVISION)) Q:$G(DIVISION)=""  D
 .F STATUS=0:1:1 D
 ..I STATUS=1,('$G(INCLUDE)) Q
 ..F ACCOUNT=1:-1:0 D
 ...S NAME="" F  S NAME=$O(@DATA@(DIVISION,STATUS,ACCOUNT,NAME)) Q:$G(NAME)=""  D
 ....S INDEX=0 F  S INDEX=$O(@DATA@(DIVISION,STATUS,ACCOUNT,NAME,INDEX)) Q:$G(INDEX)=""  D
 .....W Q_DIVISION_QCQ_NAME_QCQ_@DATA@(DIVISION,STATUS,ACCOUNT,NAME)_QCQ
 .....W @DATA@(DIVISION,STATUS,ACCOUNT,NAME,INDEX)_Q,!
 Q
DETOX ;DETOX/MAINTENANCE ID Report
 ;REP IS HANDLED BY REPORTS^ORDEA01
 N DISINC
 W !!,"This report identifies all users who have a DETOX/MAINTENANCE ID number",!
 W "in the NEW PERSON FILE (#200).",!
 S DISINC=$$DISPRMPT^ORDEA01()
 Q:DISINC=U
 S SAVE("DISINC")=""
 D DEVICE^ORUTL($P(REP(REP),";",3),"OR "_$$UP^XLFSTR($P(REP(REP),";")),"Q",.SAVE)
 Q
DETOXQ ;TASKMAN ENTRY POINT
 ;CBUFFER IS HANDLED BY DEVICE^ORUTL OR TASKMAN
 N DOCS,DATA,ERROR,INDEX,PGNUM,COL,STOP,ACCOUNT,OUTPUT
 ;RETRIEVE ALL USERS WITH A DETOX/MAINTENANCE ID NUMBER
 S DOCS=$NA(^TMP($J,"ORDETOX")),DATA=$NA(^TMP($J,"ORDETOXDATA"))
 K @DOCS,@DATA
 S COL(1)="                                     DETOX/MAINTENANCE"
 S COL(2)="NAME                                 ID NUMBER          ACCOUNT STATUS"
 D LIST^DIC(200,,"@;.01;53.11","PQ",,,,,"I $P($G(^VA(200,Y,""PS"")),U,11)'=""""",,DOCS,"ERROR")
 I $D(ERROR) D  Q
 .D FMERROR^ORUTL(.ERROR)
 .S:$D(ZTQUEUED) ZTREQ="@"
 .K @DOCS
 S INDEX=0 F  S INDEX=$O(@DOCS@("DILIST",INDEX)) Q:+$G(INDEX)=0  D
 .N ACCOUNT S ACCOUNT=$$ACTIVE^XUSER($P(@DOCS@("DILIST",INDEX,0),U))
 .I 'DISINC,(+ACCOUNT<1),($P(ACCOUNT,U,2)'="") Q
 .S ACCOUNT("TEXT")=$S($P(ACCOUNT,U,2)'="":$P(ACCOUNT,U,2),ACCOUNT=0:"CANNOT SIGN ON",1:"UNKNOWN")
 .;INCLUDE USERS WHO CANNOT SIGN-ON IN ACTIVE LISTING
 .I ACCOUNT=0 S ACCOUNT=1
 .S @DATA@(+ACCOUNT,$P(@DOCS@("DILIST",INDEX,0),U,2))=$$LJ^XLFSTR($P(@DOCS@("DILIST",INDEX,0),U,3),19,"  ")_ACCOUNT("TEXT")
 F ACCOUNT=1:-1:0  D  Q:$G(STOP)
 .Q:'$D(@DATA@(ACCOUNT))
 .I ACCOUNT=0 D
 ..I ($Y+CBUFFER+4)>IOSL!($Y=0) D  Q:$G(STOP)
 ...S STOP=$$HEADER^ORUTL("PROVIDERS WITH A DETOX/MAINTENANCE ID",.PGNUM,.COL)
 ..W !,$$CJ^XLFSTR("*** DISUSERED/TERMINATED USERS ***",$S(+$G(IOM)>0:(IOM-1),1:79)," "),!
 ..W $$CJ^XLFSTR($$REPEAT^XLFSTR("-",34),$S(+$G(IOM)>0:IOM,1:80)," "),!
 .S NAME="" F  S NAME=$O(@DATA@(ACCOUNT,NAME)) Q:NAME=""!($G(STOP))  D
 ..I ($Y+CBUFFER)>IOSL!($Y=0) D  Q:$G(STOP)
 ...S STOP=$$HEADER^ORUTL("PROVIDERS WITH A DETOX/MAINTENANCE ID",.PGNUM,.COL)
 ..W $$LJ^XLFSTR(NAME,37," ")_@DATA@(ACCOUNT,NAME)
 ..I ($Y+1)<IOSL W !
 ..S OUTPUT=1
 I '$G(STOP) D
 .I '$G(OUTPUT) D  Q:$G(STOP)
 ..S STOP=$$HEADER^ORUTL("PROVIDERS WITH A DETOX/MAINTENANCE ID",.PGNUM,.COL)
 ..Q:STOP
 ..W !,$$CJ^XLFSTR("0 PROVIDERS FOUND",$S(+$G(IOM)>0:(IOM-1),1:79)," "),!
 .I ($Y+2)>IOSL S STOP=$$HEADER^ORUTL("PROVIDERS WITH A DETOX/MAINTENANCE ID",.PGNUM,.COL)
 .Q:$G(STOP)
 .W !,$$CJ^XLFSTR("[END OF REPORT]",$S(+$G(IOM)>0:(IOM-1),1:79)," ")
 K @DOCS,@DATA
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
