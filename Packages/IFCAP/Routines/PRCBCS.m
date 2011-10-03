PRCBCS ;WISC@ALTOONA/CTB-WIRMFO/REW-CREATE CODE SHEETS FROM RELEASED TRX ; [7/1/98 3:00pm]
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 N A,PRCF
 K ^PRCF(421,"AN"),^TMP("PRCB",$J,"BCS"),^TMP("PRCB",$J,"TRDA"),^TMP("PRCB",$J,"CODE") S PRCF("X")="BQ" D ^PRCFSITE Q:'%
 S X=PRC("QTR"),X(1)="This option will now generate FMS documents for "_X_$S(X=1:"st",X=2:"nd",X=3:"rd",1:"th")_" Quarter, FY "_PRC("FY")
 S X(2)="released transactions which have not previously been coded."
Q1 S Y(1)="Enter a date you want to send documents to FMS in format: MM/DD/YY"
 S A=$$DT^PRC0B2("T","E"),A=$P(A,"^",5)
 D DT^PRC0A(.X,.Y,"FMS Transaction Date","O",A)
 QUIT:X["^"!(X="")
 I Y#100=0 W "   Enter precise date!" G Q1
 S Y=$$DT^PRC0B2(Y,"I")
 W "    (",$P(Y,"^",5),")"
 ;S A=$$DATE^PRC0C($P(Y,"^",5),"E")
 ;I PRC("FY")'=$E(A,3,4)!(PRC("QTR")'=$P(A,"^",2)) D EN^DDIOL("The FMS Transaction Date should be in the entered fiscal year and quarter.") G Q1
 S PRCF("TDATE")=+Y,PRCF("ACCTP")=$P($$DT^PRC0B2($E(Y,1,5)_"00","I"),"^",5)
Q2 S Y(1)="Enter a calendar (not fiscal year) accounting period in format: MM/YY."
 S Y(2)="NOTE: a closed FMS accounting period will cause documents to be rejected."
 D DT^PRC0A(.X,.Y,"Accounting Period (MM/YY)","O",PRCF("ACCTP"))
 I X=""!(X["^") G Q1
 G Q2:Y<0
 I Y#100'=0 W "    Enter month/year only!" G Q2
 S Y=$$DT^PRC0B2(Y,"I")
 W "    (",$P(Y,"^",5),")"
 ;S A=$$DATE^PRC0C($P(Y,"^",5),"E")
 ;I PRC("FY")'=$E(A,3,4)!(PRC("QTR")'=$P(A,"^",2)) D EN^DDIOL("The Accounting Period should be in the entered fiscal year and quarter.") G Q2
 S PRCF("ACCTP")=$P(Y,"^",5),X=$$DATE^PRC0C(+Y,"I")
 S PRCF("ACCTF")=$P(X,"^",9)_$E(X,3,4)_"^"_PRCF("ACCTP")
Q9 D YN^PRC0A(.X,.Y,"Ready to generate FMS documents","O","YES")
 QUIT:X["^"!(X="")
 G:Y<1 Q1
 ;S ZTDESC="CREATE BUDGET CODE SHEETS",ZTRTN="DQ^PRCBCS",ZTSAVE("PRC*")="",ZTSAVE("PRCF*")="",ZTSAVE("DUZ*")="" D ^PRCFQ
 D DQ
 K PRCF,PRCF("TDATE"),PRCFA Q
 ;
DQ I $D(ZTQUEUED) D:0 KILL^%ZTLOAD S ZTREQ="@" ; REW ? for Patch 97
 ;D:$D(ZTQUEUED) KILL^%ZTLOAD ; original line
 S X="BATCH/TRANSMIT" D LOCK^PRCFALCK Q:'%
 K ^TMP("PRCB",$J,"BCS"),^TMP("PRCB",$J,"TRDA")
 S DA=0 F I=1:1 S DA=$O(^PRCF(421,"AL",PRCF("SIFY"),2,DA)) Q:'DA  D ADD
 ;D DA=0:0 S DA=$O(^TMP("PRCB",$J,"TRDA",DA)) Q:'DA  I $D(^PRCF(421,DA,0)) S $P(^(4),"^",PRC("QTR"))=1
 ;K ^TMP("PRCB",$J,"TRDA")
 S PRC("FYF")=0 F  S PRC("FYF")=$O(^TMP("PRCB",$J,"BCS",PRC("SITE"),PRC("FYF"))) Q:'PRC("FYF")  S AMT=+^(PRC("FYF")),X="",PRCFID="" D:AMT'=0  D EPRN
 . N A,B
 . S PRC("CP")=$P(PRC("FYF"),"~"),PRC("BBFY")=$P(PRC("FYF"),"~",2),PRC("CPT")=$P(PRC("FYF"),"~",3)
 . S PRC("FC")=PRCF("TDATE")_"^"_PRC("FY")_"^"_PRC("QTR")_"^"_PRC("SITE")_"^"_PRC("CP")_"^"_AMT_"^"_PRC("BBFY")_"^"_PRC("CPT"),PRC("AMT")=AMT
 . S $P(PRC("FC"),"^",9)=PRCF("ACCTF")
 . I PRC("CPT")="" D SA^PRCB8A(.X,PRC("FC")) S PRCFID=$P(X,"^",2) QUIT
 . S PRCA=$$ACC^PRC0C(PRC("SITE"),PRC("CP")_"^"_PRC("FY")_"^"_PRC("BBFY"))
 . S PRCB=$$ACC^PRC0C(PRC("SITE"),PRC("CPT")_"^"_PRC("FY")_"^"_PRC("BBFY"))
 . I $P(PRCA,"^",9)=$P(PRCB,"^",9)&($P(PRCA,"^",2)=$P(PRCB,"^",2)) D  QUIT
 .. S C=$$FMSACC^PRC0D(PRC("SITE"),PRCA),C=$$FIRST^PRC0B1("^PRCD(420.141,""B"","""_C_""",",0)
 .. I 'C S $P(PRC("FC"),"^",6)=0 D SA^PRCB8A(.X,PRC("FC"))
 .. S C=$$FMSACC^PRC0D(PRC("SITE"),PRCB),C=$$FIRST^PRC0B1("^PRCD(420.141,""B"","""_C_""",",0)
 .. I 'C S $P(PRC("FC"),"^",6)=0 D SA^PRCB8A(.X,$P(PRC("FC"),"^",1,4)_"^"_PRC("CPT")_"^"_$P(PRC("FC"),"^",6,999))
 .. S $P(PRC("FC"),"^",6)=-PRC("AMT") D ST^PRCB8A1(.X,PRC("FC")) S PRCFID=$P(X,"^",2)
 .. QUIT
 . D SA^PRCB8A(.X,PRC("FC"))
 . S $P(PRC("FC"),"^",6)=-PRC("AMT") D AT^PRCB8A2(.X,PRC("FC"))
 . S PRCFID=$P(X,"^",2),$P(PRC("FC"),"^",5)=PRC("CPT") D SA^PRCB8A(.X,PRC("FC"))
 . QUIT
 ;
 ;
 ;S FR="",TO="",IOP=ION,DIC="^PRCF(421,",L=0,BY=$S($G(PRC("PRCOLD")):"[PRCB GENERATE CODE SHEETS]",1:".6,1,.01")
 K IOP S (FR,TO)="",DIC="^PRCF(421,",L=0,BY="+1;S2,.01"
 S FLDS=".01,1,6,&"_(PRC("QTR")+6),BY(0)="^PRCF(421,""AN"",",L(0)=2
 ; REW <<<<<<< This code eliminate uses of BY-with-a-template with BY(0) per Forum msg 19270200
 ;S (FR,TO)=1,IOP=ION,DIC="^PRCF(421,",L=0,BY="NUMBER",FLDS=".01"
DIP ;S:$G(^PRCHREW) ^PRCHREW($H,1)=$G(ZTQUEUED)_U_$J
 D EN1^DIP
 ;S:$G(^PRCHREW) ^PRCHREW($H,2)=$G(ZTSTAT) ; Documenting call to and return from DIP
 ;
 ;
BACK K ^TMP("PRCB",$J,"BCS") S X="BATCH/TRANSMIT" D UNLOCK^PRCFALCK
 ;S:$G(^PRCHREW) ^PRCHREW($H,3)="" ; <<<<<  REW   Documenting return from UNLOCK
 QUIT
 ;
ERR W !,"Unable to create code sheet for Station: "_PRC("SITE")_", Control Point: "_PRC("CP")_", FY: "_PRC("FY"),", Quarter: "_PRC("QTR")_"." Q
 ;
EPRN ;set printing flag/FMS id in file 410
 N A,B,C
 S A="" F  S A=$O(^TMP("PRCB",$J,"BCS",PRC("SITE"),PRC("FYF"),A)) Q:'A  D
 . F C=1,2 S B=$P(A,"~",C) I B,$D(^PRCF(421,B,0)) S $P(^(4),"^",PRC("QTR"))=1,D=$P(^(4),"^",6+PRC("QTR")) S:D $P(^PRCS(410,D,4),"^",5)=PRCFID
 . QUIT
 QUIT
 ;
ADD ;ADD AMOUNT INTO SCRATCH GLOBAL
 N A
 QUIT:'$D(^PRCF(421,DA,0))  S X=^(0) QUIT:'$P(X,"^",23)!+$P($G(^(4)),U,PRC("QTR"))
 I +$P(X,U,PRC("QTR")+6)'=0,$P(X,U,20)=2,$P(^PRC(420,PRC("SITE"),1,+$P(X,U,2),0),U,12)<3 D  S ^PRCF(421,"AN",1,DA)="",$P(^PRCF(421,DA,0),"^",19)=1
 . ;S ^TMP("PRCB",$J,"TRDA",DA)=""
 . S Y=+$P(X,"^",2)_"~"_$P($$DATE^PRC0C($P(X,"^",23),"I"),"^",3),AMT=$P(X,"^",PRC("QTR")+6)
 . I $P(X,"^",22) QUIT:AMT>0  S $P(Y,"~",3)=+$P($G(^PRCF(421,$P(X,"^",22),0)),"^",2)
 . S:'$D(^TMP("PRCB",$J,"BCS",PRC("SITE"),Y)) ^(Y)=0
 . S ^TMP("PRCB",$J,"BCS",PRC("SITE"),Y)=^TMP("PRCB",$J,"BCS",PRC("SITE"),Y)+$P(X,"^",PRC("QTR")+6)
 . S ^TMP("PRCB",$J,"BCS",PRC("SITE"),Y,DA_"~"_$P(X,"^",22))=""
 . QUIT
 QUIT
