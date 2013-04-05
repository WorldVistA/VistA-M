PRCGA ;WIRMFO/CTB/PLT - POST INIT - IFCAP PURGE  ;12/23/96  2:27 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 N DA,PRC442,PRCA,PRCB,ZTSTOP,X,Y
ETM S PRCA="",ZTSTOP=""
 S MESSAGE="UPDATING PURCHASE ORDER DATE FIELD AND XREF IN FILES 410 AND 442",ITEMS="documents"
 S TREC=$P(^PRCS(410,0),"^",4)+$P(^PRC(442,0),"^",4)
 D BEGIN^PRCGU
 S PRCSDA=0
 F  D  S XCOUNT=XCOUNT+COUNT D PERCENT^PRCGU Q:'PRCSDA
 . F COUNT=1:1:LREC S PRCSDA=$O(^PRCS(410,PRCSDA)) Q:'PRCSDA  D
 .. D DOR(PRCSDA) I $D(KILLFLAG) K KILLFLAG QUIT
 .. S PRCB=$G(^PRCS(410,PRCSDA,0)) Q:$P(PRCB,"^",4)'=1
 .. S PRCB=$G(^PRCS(410,PRCSDA,10)),PRC442=$P(PRCB,"^",3) Q:PRC442=""
 .. S PRCB=$G(^PRCS(410,PRCSDA,4)) Q:$P(PRCB,"^",5)=""!($P(PRCB,"^",4)="")
 .. Q:$P($G(^PRC(442,PRC442,1)),"^",15)'=""
 .. S DA=PRC442,DIE="^PRC(442,",DR=".1////"_$P(PRCB,"^",4) D ^DIE
 .. QUIT
 . QUIT
 S N=0 F  D  S XCOUNT=XCOUNT+COUNT D PERCENT^PRCGU Q:'N
 . F COUNT=1:1:LREC S N=$O(^PRC(442,N)) Q:'N  D
 . S N0=$G(^(N,0)),N1=$G(^(1))
 . S X=$P(N1,"^",15) I X]"",'$D(^PRC(442,"AB",X,N)) S ^PRC(442,"AB",X,N)=""
 . I $P(N0,"^",2)=21,X="" D 1358(N,N0,N1)
 . QUIT
 D END^PRCGU
 QUIT
1358(DA,DA0,DA1) ;correct 1358's without po dates in 442
 N OB,OK,X
 ;If obligation data, take date of first code sheet
 S OB=$O(^PRC(442,DA,10,0)) I +OB D  QUIT:$D(OK)
 . S X=$P($G(^PRC(442,DA,10,OB,0)),"^",1) I $P(X,".",3)?6N S X="2"_$P(X,".",3) D SET QUIT
 . QUIT
 ;If no obligation data, take date of first entry in 424
 S OB=$O(^PRC(424,"C",DA,0)) I +OB D  QUIT:$D(OK)
 . S X=$P($G(^PRC(424,OB,0)),"^",7) I $E(X,1,7)?7N D SET QUIT
 . QUIT
 ;If no entries in 424 take Date P.O. Assigned
 S X=$P($G(^PRC(442,DA,12)),"^",5) I $E(X,1,7)?7N D SET QUIT:$D(OK)
 QUIT
SET ;Places date in P.O. Date field and sets xref
 S X=$E(X,1,7)
 S $P(DA1,"^",15)=X,^PRC(442,DA,1)=DA1,^PRC(442,"AC",X,DA)=""
 S OK=1 QUIT
EXIT QUIT
 ;
FILE S $P(^PRCS(410,DA,1),"^",1)=X
 QUIT
DOR(DA) ;CLEANUP DATE OF REQUEST FIELD
 N X,Y
 F I=0,1,3,4,5,6,7 S X(I)=$G(^PRCS(410,DA,I))
 Q:$P(X(1),"^",1)]""  ;QUIT WHEN DATE OF REQUEST PRESENT
 S X=$P($P(X(4),"^",4),".",1)]"" I X]"" D FILE QUIT
 S X=$P($P(X(1),"^",4),".",1)]"" I X]"" D FILE QUIT
 S X=$P($P(X(7),"^",5),".",1)]"" I X]"" D FILE QUIT
 S X=$P($P(X(6),"^",2),".",1)]"" I X]"" D FILE QUIT
 S X=$P($P(X(4),"^",13),".",1)]"" I X]"" D FILE QUIT
 S X=$P($P(X(5),"^",2),".",1)]"" I X]"" D FILE QUIT
 S X=$P($P(X(7),"^",7),".",1)]"" I X]"" D FILE QUIT
 S X=$P($P(X(7),"^",10),".",1)]"" I X]"" D FILE QUIT
 S X=$P($P(X(4),"^",7),".",1)]"" I X]"" D FILE QUIT
 S X=$P($P(X(4),"^",2),".",1)]"" I X]"" D FILE QUIT
 S X=$P($P(X(0),"^",8),".",1)]"" I X]"" D  QUIT
 . N Y S Y=$E(X,4,5),Y=$S("01,03,05,07,08,10,12"[Y:31,Y=2:28,1:30)
 . S X=$E(X,1,5)_Y D FILE QUIT
 I $P(X(0),"^",1)?3N1"-"2N1"-"1N1"-"3.4N1"-"4N S X=$$EOFY(X(0)) I X]"" D FILE QUIT
 I $P(X(0),"^",12)="E" S X=$P(DT,".") D FILE QUIT
 D KILL410
 QUIT
EOFY(Y) S X="",X=$P(Y,"-",2),X=$S(X>70:"2"_X,1:"3"_X)_"0930" QUIT X
KILL410 D KILL410^PRCGARP1(DA)  ;WHEN NO DATES OR GARBAGE, REMOVE RECORD
 S KILLFLAG=""
 QUIT
