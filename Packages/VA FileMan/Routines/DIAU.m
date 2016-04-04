DIAU ;SFISC/XAK-AUDIT OPTIONS ; 27JAN2013
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**76,129,1009,1022,1040,1043,1044**
 ;
 ;
 ; Contents
 ;
 ; ^DIAU/O/OPT: Run Audit Menu (Rebuild If Necessary)
 ; EN/Q: Run an Audit Option
 ;
 ; 1/WRITE/Q2: LIST FIELDS BEING AUDITED
 ; 2/21/22: TURN DATA AUDIT ON/OFF
 ; 3: DATA AUDIT TRAIL PURGE
 ; 4: SHOW DD AUDIT TRAIL
 ; 5: DD AUDIT TRAIL PURGE
 ; 6: MONITOR A USER
 ;
 ; KILLDIA: DHIT Code for Option 3 (DATA AUDIT TRAIL PURGE)
 ; ENDKILL: DIOEND Code for Option 3 (DATA AUDIT TRAIL PURGE)
 ; $$DANGLE: Clean Danglers for ENDKILL
 ; ALL: Confirm Purge of All Audit Records for Options 3 & 5
 ; PR: Purge All Audit Records for a File & Its Subfiles for Option 5
 ; M/UP/P/QM: DIOEND Code for Option 5 (DD AUDIT TRAIL PURGE)
 ; WUSRDHD: DHD Code for Option 6 (MONITOR A USER)
 ; WUSR: DHIT Code for Option 6 (MONITOR A USER)
 ;
 ;
0 ; Rebuild DOPT Audit Menu If Necessary
 ;
 S DIC="^DOPT(""DIAU"","
 I '$D(^DOPT("DIAU","B","MONITOR A USER")) D
 .S ^DOPT("DIAU",0)="AUDIT OPTION^1.01" K ^("B")
 .F X=1:1:6 S ^DOPT("DIAU",X,0)=$P($T(@X),";;",2)
 .S DIK=DIC D IXALL^DIK
 ;
OPT ; Run Audit Menu
 ;
 S DIC(0)="AEQIZ" D ^DIC G Q:Y<0 S DI=+Y D EN
 ;
 GOTO 0 ; end of ^DIAU/0/OPT
 ;
 ;
EN ; Run an Audit Option
 ;
 D @DI W !!
 ;
Q K %,DIC,DIK,DI,DA,I,J,X,Y
 ;
 QUIT  ; end of EN/Q
 ;
 ;
1 ;;LIST FIELDS BEING AUDITED
 ;
 D L^DICRW1 Q:'$D(DIC)  S (DUB,DIB,DFF)=+Y,BY(0)="^DD(DFF,""AUDIT"",",L(0)=1
 S Y=$O(^DIC(DIB(1))) I Y S DIB(1)=$O(^DD(Y),-1) S:'DIB(1) DIB(1)=DIB
 I $O(^DD(DIB,"AUDIT",""))="" F  S DIB=$O(^DD(+DIB)) Q:'DIB!(DIB>DIB(1))  I $O(^DD(DIB,"AUDIT",""))]"" S (DUB,DFF)=DIB Q
 I 'DIB!(DIB>DIB(1)) G Q2
 S FLDS="W DFF;C1;L9;""FILE"",.001;L9,.01;L20,.25;L15,1.1",DISUPNO=1
 S L=0,DHD="AUDITED FIELDS",DIS(0)="I $D(^DD(DFF,D0,""AUDIT"")),""n""'[^(""AUDIT"")"
 S DIA=1,DIC="^DD(DFF,",DIOEND="G L^DIDC" D EN1^DIP
 ;
 GOTO Q2 ; end of 1 (LIST FIELDS BEING AUDITED)
 ;
 ;
2 ;;TURN DATA AUDIT ON/OFF
 ;
 N J,DUOUT,DIRUT,DA,DDA,DIAU,DIA,C,D,%,DIC,X,Y,DIR
 S (DDA,DIA)=0 D AU^DICRW I 'DIA Q
21 S DIC="^DD("_DIA_",",DIC(0)="QEANIZ",DA(1)=DIA
 S DIC("S")="I 1 S %=$P(^(0),U,2) I $E(%)'=""C"""
22 S DIC("W")="N %,%A S %A=$G(^(""AUDIT"")),%=$P(^(0),U,2) W:% $S($P(^DD(+%,.01,0),U,2)[""W"":""  (word-processing)"",1:""  (multiple)"") S:% %A=$G(^(""AUDIT"")) W ""   "",%A"
 D ^DIC I Y<0 K DIA G Q
 I $P(Y(0),U,2) S DA(1)=+$P(Y(0),U,2),DIC="^DD("_DA(1)_"," G 22
 K DIC,DIR S DDA=+Y S:$D(^("AUDIT")) DIR("B")=^("AUDIT")
 S DIR(0)="0,1.1" D ^DIR I $D(DIRUT) Q:X'="@"  S Y="n"
 D TURNON^DIAUTL(DA(1),DDA,Y) I $D(DIRUT) K ^DD(DA(1),DDA,"AUDIT")
 W !!
 ;
 GOTO 21 ; end of 2/21/22 (TURN DATA AUDIT ON/OFF)
 ;
 ;
3 ;;DATA AUDIT TRAIL PURGE
 ;
 S DIC("S")="I $D(^DIA(+Y)),'$D(^DD(+Y,0,""AUDPURGEFORBID"")) S DIAC=""AUDIT"",DIFILE=+Y D ^DIAC I DIAC"
 S DIA="" D AU^DICRW K DIC("S") G Q2:$D(DTOUT),Q2:Y<0,Q2:'$D(DIC)
 S DDA="DATA" D ALL G Q2:$D(DIRUT)
 I Y W !!,"..." K ^DIA(DIA) H 3 W "DELETED" G Q2
 W ! S L="PURGE AUDIT RECORDS",DIOEND="D ENDKILL^DIAU",DISTOP=0
 S FLDS="",DHD="PURGE OF AUDIT DATA: "_$O(^DD(DIA,0,"NM",0))_" FILE",DISUPNO=1
 S DHIT="D KILLDIA^DIAU",DIACNT=0
 D EN1^DIP K DISTOP,DHIT,DIK,DA,DIACNT
 ;
 GOTO Q2 ; end of 3 (DATA AUDIT TRAIL PURGE)
 ;
 ;
ALL ; Confirm Purge of All Audit Records for Options 3 & 5
 ;
 S DIR(0)="Y",DIR("B")="NO"
 S DIR("A")="DO YOU WANT TO PURGE ALL "_DDA_" AUDIT RECORDS"
 S DIR("??")="^W !!?5,""Answer 'YES' to purge all the "_DDA_" audit records for this file, or"",!?5,""answer 'NO' to sort out the records to be purged."""
 D ^DIR Q:$D(DIRUT)  I Y S DIR("A")="ARE YOU SURE" D ^DIR
 K DIR
 ;
 QUIT  ; end of ALL
 ;
 ;
KILLDIA ; DHIT Code for Option 3 (DATA AUDIT TRAIL PURGE)
 ;
 ; called from DHIT
 S X=$G(^DIA(DIA,D0,0)) K ^DIA(DIA,D0)
 S Y=$P(X,U) I Y K ^DIA(DIA,"B",Y,D0)
 S Y=$P(X,U,2) I Y K ^DIA(DIA,"C",Y,D0)
 S Y=$P(X,U,4) K ^DIA(DIA,"D",+Y,D0)
 S DIACNT=DIACNT+1
 ;
 QUIT  ; end of KILLDIA
 ;
 ;
ENDKILL ; DIOEND Code for Option 3 (DATA AUDIT TRAIL PURGE)
 ;
 ; check danglers
 S $P(^(0),U,4)=$P($G(^DIA(DIA,0)),U,4)-DIACNT
 W !!,"...",! W $$DANGLE(DIA)," POINTERS FIXED."
 W !!,DIACNT," RECORDS PURGED."
 ;
 QUIT  ; end of ENDKILL
 ;
 ;
DANGLE(DIA) ; Clean Danglers for ENDKILL
 ;
 N A,B,D0,AA,C
 S C=0
 F AA=1,2,4 S A=$E("BC D",AA),B="" D
 .F  S B=$O(^DIA(DIA,A,B)) Q:B=""  D
 ..F D0=0:0 S D0=$O(^DIA(DIA,A,B,D0)) Q:'D0  I $P($G(^DIA(DIA,D0,0)),U,AA)'=B K ^DIA(DIA,A,B,D0) S C=C+1
 ;
 Q C ; end of $$DANGLE
 ;
 ;
4 ;;SHOW DD AUDIT TRAIL
 ;
 N DIR,DIRB,%DT S DIRB=$$EZBLD^DIALOG(7065)
 S DIR(0)="FO^^S:X=DIRB X=1900 S %DT=""EP"" D ^%DT",DIR("A")="Show Data Dictionary changes since",DIR("B")=DIRB
 S DIR("?")="Enter a date.  All audited changes to Data Dictionaries, starting with that date, will be shown."
 D ^DIR I Y>0 D DISP^DIAUTL(Y)
 ;
 QUIT  ; end of 4 (SHOW DD AUDIT TRAIL)
 ;
 ;
5 ;;DD AUDIT TRAIL PURGE
 ;
 S DIC("S")="I '$D(^DD(+Y,0,""DDAUDPURGEFORBID"")) S DIAC=""AUDIT"",DIFILE=+Y D ^DIAC I DIAC"
 S DIA="DDA",DDA="DD" D A^DICRW G Q:$D(DTOUT)!(Y<0)!'$D(DIC)
 D ALL G:$D(DIRUT) Q I Y S X=DIA D PR G Q
 W ! S L="PURGE DD AUDIT RECORDS",DIOEND="G M^DIAU",DISTOP=0,DISUPNO=1
 S FLDS="",DHD="PURGE OF DD AUDIT: "_$O(^DD(DIA,0,"NM",0))_" FILE"
 S DHIT="S DIK=DCC,DA=D0,DIACNT=DIACNT+1 D ^DIK",DIACNT=0,DIC="^DDA(DDA,"
 S DDA=DIA D EN1^DIP K DISTOP,DHIT,DIK,DA,DIACNT
 ;
 GOTO Q2 ; end of 5 (DD AUDIT TRAIL PURGE)
 ;
 ;
PR ; Purge All Audit Records for a File & Its Subfiles for Option 5
 ;
 N DIA S DIA=X N X K ^DDA(DIA)
 F X=0:0 S X=$O(^DD(DIA,"SB",X)) Q:X'>0  D PR
 ;
 QUIT  ; end of PR
 ;
 ;
M ; DIOEND Code for Option 5 (DD AUDIT TRAIL PURGE)
 ;
 S DDA=$O(^DDA(DDA))
 I DDA'>0!(DDA-1>DIA) W !!,DIACNT," RECORDS PURGED." G QM
 S %=0,X=DDA D UP
 GOTO P:%,M:'%
 ;
UP Q:'$D(^DD(X,0,"UP"))  S X=^("UP") I X=DIA S %=1 Q
 GOTO UP
 ;
P K ^UTILITY($J,0) S %X="DIPP(",%Y="DPP(" D %XY^%RCR
 S DPP=DIPP,L=0,DJ=DIJS,DPQ=DIPQ,M=DIMS,C=",",DIOSL=IOSL G ^DIO
 QUIT
 ;
QM ; return to ^DIO4 from line tag M+3
 ;
 GOTO STOP^DIO4 ; end of M/UP/P/QM
 ;
 ;
6 ;;MONITOR A USER
 ;
 N DIAUSR,%DT,DHIT,DWHEN,DIC,DIAUIDEN
 S DIC=200,DIC(0)="AQEM",DIC("A")="Select a USER who has signed on to this system: ",DIC("S")="I $G(^(1.1))" D ^DIC K DIC Q:Y<0  S DIAUSR=+Y
 D R1^DICRW ;Creates a DIC("S") that screens out files user has no access to
 S DIC("S")=DIC("S")_" I $D(^DIA(+Y,""D"",DIAUSR))",DIC=1,DIC(0)="QAEI",DIC("A")="Select AUDITED File: "
 S Y=$G(^DISV(DUZ,"^DIC(")) I Y X DIC("S") I  S DIC("B")=Y
 D ^DIC K DIC
 Q:$G(Y)'>0  S DIA=+Y,DIAUIDEN=$G(^DD(DIA,0,"ID","WRITE"))
 K ^UTILITY("DIAU",$J)
 S B=0,%DT="AEPT",%DT("A")="START WITH DATE: FIRST// " D ^%DT S DWHEN=" SINCE "_$$DATE^DIUTL(Y) I Y<1 Q:X]""  S Y=0,DWHEN=""
 S A=$O(^DIA(DIA,"C",Y-.0001)) Q:'A  S B=$O(^(A,0))-.01
 F A=B:0 S A=$O(^DIA(DIA,"D",DIAUSR,A)) Q:'A  S P=$G(^DIA(DIA,A,0)) I P D
 .I $D(^UTILITY("DIAU",$J,0,+P)) S $P(^(+P),U,2)=A Q
 .S ^UTILITY("DIAU",$J,0,+P)=A,DP=$$GET1^DIQ(DIA,+P,.01) S:DP]"" ^UTILITY("DIAU",$J,1,DP,+P)="" ;BY NAME
 ;
WRITE ; Display Monitor a User Report
 ;
 S BY(0)="^UTILITY(""DIAU"","_$J_",1,",L(0)=2,FLDS=""
 S DHD="W ! D WUSRDHD^DIAU"
 S DIC=^DIC(DIA,0,"GL")
 S DIOEND="K ^UTILITY(""DIAU"","_$J_")",DHIT="D WUSR^DIAU(D0)"
 D EN1^DIP
 ;
Q2 K DIA,A,B,DIJ,DP,P,BY,FLDS,DIS,DHD,DCC,L,DNP,DFF,DIB,DIJS,DIPQ,DIMS,DIPP,DUB,DIOEND
 ;
 QUIT  ; end of 6/WRITE/Q2 (MONITOR A USER)
 ;
 ;
WUSRDHD ; DHD Code for Option 6 (MONITOR A USER)
 ;
 ; called by DHD
 W $P(^DIC(DIA,0),U)," RECORDS ACCESSED BY ",$P(^VA(200,DIAUSR,0),U)," (DUZ=",DIAUSR,") ",DWHEN,?IOM-8,"Page ",DC,!
 W ?IOM-50,"EARLIEST ACCESS",?IOM-25,"LATEST ACCESS",!
 W $TR($J("",IOM)," ","-"),!
 ;
 QUIT  ; end of WUSRDHD
 ;
 ;
WUSR(Y) ; DHIT Code for Option 6 (MONITOR A USER)
 ;
 ; called by DHIT
 N X,DIAU,DIC,DITAB
 W $$GET1^DIQ(DIA,Y,.01) ;NAME
 S DITAB=IOM-50 D:DIAUIDEN]""
 .;I IOM>131 W ?80 S $X=19
 .;E  D N^DIO2 W ?19
 .S DIC=^DIC(DIA,0,"GL") I $G(@(DIC_"+Y,0)"))]"" X DIAUIDEN ;CALL ^DD(2,0,"ID","WRITE") WITH NAKED REFERENCE
 .I IOM<132 D N^DIO2
 S DIAU=^UTILITY("DIAU",$J,0,D0),X=+DIAU
 W ?DITAB D  W ?DITAB+25 S X=$P(DIAU,U,2) D:X
 .N Y S Y=$P(^DIA(DIA,X,0),U,2) X ^DD("DD") W Y
 D N^DIO2
 ;
 QUIT  ; end of WUSR
 ;
 ;
EOR ; end of routine DIAU
