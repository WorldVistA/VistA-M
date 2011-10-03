PRCX1Q1 ;WISC/PLT-fill in fields 449, 450 of file 410 for carry forward ;4/23/96  13:55
V ;;5.0;IFCAP;**55**;4/21/95
 QUIT  ;invalid entry
 ;
EN ;fill in field 449 and 450 of file 410
 N PRC,PRCRI,PRCA,PRCB,PRCC,PRCD,PRCE,PRCG,PRCH,PRCF,DMAX
 N A,B,X,Y
410 W @IOF D EN^DDIOL("This is for IFCAP patch PRC*5*55 to fill in new fields")
 D EN^DDIOL("449 & 450 of file 410 for fiscal year 95 only.")
 D EN^DDIOL("This routine also sets up file 410 entries for all fiscal year 95")
 D EN^DDIOL("PURCHASE ORDERS without 2237 requests"),EN^DDIOL(" ")
Q1 D YN^PRC0A(.X,.Y,"Ready to run","O","NO")
 G:X["^"!(X="")!'Y EXIT
 D EN^DDIOL("Start convert file 410")
 S PRCRI(411)=0 F  S PRCRI(411)=$O(^PRC(411,PRCRI(411))) QUIT:PRCRI(411)>999999!'PRCRI(411)  D
 . S PRC("SITE")=$P($G(^PRC(411,PRCRI(411),0)),"^") QUIT:'PRC("SITE")  D
 .. QUIT
 . S PRCB=PRC("SITE")_"-95-1"
 . S PRCD=PRCB,PRCB=PRC("SITE")_"-95~"
 . F  S PRCD=$O(^PRCS(410,"B",PRCD)) QUIT:PRCD]PRCB!'PRCD  S PRCRI(410)=$O(^(PRCD,0)) I PRCRI(410) S PRCE=$G(^PRCS(410,PRCRI(410),0)),A=$G(^(4)),B=$G(^(7)) D
 .. S PRCG=$P(PRCE,"^",2),PRCF=$P(PRCE,"^",4),PRCH="E"
 .. W !,$P(PRCE,"^")
 .. I PRCG="CA" S PRCH="C"
 .. I PRCG="C" S PRCH="O"
 .. I PRCG="O" S PRCH=$S($P(A,"^",10)]"":"O",$P(B,"^",6)]"":"A",1:"E") I PRCH="A",$P(A,"^",3)]"",+$P(A,"^",3)=0,$P(A,"^",5)]"" S PRCH="O" W "      SECONDARY REQUEST"
 .. I PRCG="A" S PRCH="O" S:PRCF=1 PRCH=$S($P(A,"^",10)]"":"O",$P(B,"^",6)]"":"A",1:"E")
 .. ;D ERS410^PRC0G(PRCRI(410)_"^"_PRCH)
 .. I $P(PRCE,"^",12)="" D EDIT^PRC0B(.X,"410;^PRCS(410,;"_PRCRI(410),"450///^S X=PRCH;449////"_$P($$QTRDATE^PRC0D($P(PRCE,"-",2),$P(PRCE,"-",3)),"^",7))
 .. S PRCE=$G(^PRCS(410,PRCRI(410),0))
 .. W ?20,$P(PRCE,"^",11),?30,$P(PRCE,"^",12)
 .. QUIT
 . QUIT
 ;
 D EN^DDIOL(" ")
 D EN^DDIOL("FILL-IN NEW FIELD 449 & 450 IN FILE 410 DONE")
 D EN^DDIOL(" ")
442 D EN^DDIOL("Start convert purchase orders without requests in file 442")
 S PRCB=2941000
 F  S PRCB=$O(^PRC(442,"AB",PRCB)) QUIT:PRCB>2951000!'PRCB  D
 . W !,PRCB
 . S PRCRI(442)="" F  S PRCRI(442)=$O(^PRC(442,"AB",PRCB,PRCRI(442))) QUIT:'PRCRI(442)  S PRCD=$G(^PRC(442,PRCRI(442),0)),PRCF=$P(PRCD,"^",2) I PRCF-22,PRCF-23,PRCF-24 D:$P($G(^(12)),"^",12)]""&($P($G(^(10,1,0)),"^",2)]"")
 .. W !,$P(PRCD,"^")
 .. I $P(PRCD,"^",12)]"" D  QUIT
 ... N A,B
 ... S A=0 F  S A=$O(^PRC(442,PRCRI(442),13,A)) QUIT:'A  S PRCRI(410)=$P($G(^(A,0)),"^") I PRCRI(410) S PRCE=$G(^PRCS(410,PRCRI(410),0)) I PRCE,$P(PRCE,"^",12)=""!1 D  W "   REQUEST-"_PRCRI(410)
 .... D EDIT^PRC0B(.X,"410;^PRCS(410,;"_PRCRI(410),"450////O;449////"_$P($$QTRDATE^PRC0D($P(PRCE,"-",2),$P(PRCE,"-",3)),"^",7))
 .... QUIT
 ... QUIT
 .. N PRCOBL,PRCOBD,PRCOBA
 .. N A,B,X,Y,Z
 .. W "    WITHOUT REQUEST"
 .. S A=$P(PRCD,"^"),PRC("SITE")=$P(A,"-"),PRCOBL=$P(A,"-",2)_"WR"
 .. I $$DUP(PRC("SITE"),PRCOBL) W "    *** DUPLICATE" QUIT
 .. S PRCOBD=$P(^PRC(442,PRCRI(442),1),"^",15)
 .. S PRCOBA=$P($G(^PRC(442,PRCRI(442),0)),"^",16) S:PRCOBA="" PRCOBA=0 S:$P($G(^PRC(442,PRCRI(442),7)),"^",2)=45 PRCOBA=0
 .. I $P($G(^PRC(442,PRCRI(442),0)),"^",2)=25 S PRCOBA=0
 .. I '$D(^PRCS(410.1,"B",$P(PRCD,"-")_"-"_$E($$DATE^PRC0C(PRCOBD,"I"),3,4)_"-"_$P($P(PRCD,"^",3)," "))) W !," MISSING SEQ#, NOT CONVERTED" QUIT
 .. D A410^PRC0F(.X,$P(PRCD,"-")_"^"_$P(PRCD,"^",3)_"^A^^"_PRCOBD_"^"_PRCOBA_"^"_PRCOBL)
 .. S PRCRI(410)=X I PRCRI(410) S PRCE=$G(^PRCS(410,PRCRI(410),0)) D EDIT^PRC0B(.X,"410;^PRCS(410,;"_PRCRI(410),"449////"_$P($$QTRDATE^PRC0D($P(PRCE,"-",2),$P(PRCE,"-",3)),"^",7))
 .. QUIT
 . QUIT
 D EN^DDIOL("PURCHASE ORDERS WITHOUT REQUESTS DONE!")
417 I 0 D EN^DDIOL(""),EN^DDIOL("Start convert 820 transactions in file 417")
 I 0 S PRCRI(411)=0 F  S PRCRI(411)=$O(^PRC(411,PRCRI(411))) QUIT:PRCRI(411)>999999!'PRCRI(411)  D
 . S PRC("SITE")=$P($G(^PRC(411,PRCRI(411),0)),"^") QUIT:'PRC("SITE")  D
 . S PRCB=PRC("SITE")_"-95-"
 . S PRCD=PRCB,PRCB=PRC("SITE")_"-~"
 . F  S PRCD=$O(^PRCS(417,"C",PRCD)) QUIT:PRCD]PRCB!'PRCD  W !,PRCD S PRCRI(417)="" F  S PRCRI(417)=$O(^PRCS(417,"C",PRCD,PRCRI(417))) QUIT:'PRCRI(417)  I PRCRI(417) S PRCE=$G(^PRCS(417,PRCRI(417),0)),PRCF=$P($G(^(1)),"^") D
 .. N PRCOBL,PRCOBD,PRCOBA
 .. N A,B,X,Y,Z
 .. S PRCOBA=$P(PRCE,"^",20),PRCOBD=$P($P(PRCE,"^",22),"."),PRCOBL=$P(PRCE,"^",18)_"_820"
 .. W !,PRCE
 .. I $G(PRCF) W "    *** DUPLICATE" QUIT
 .. D A410^PRC0F(.X,$P(PRCD,"-")_"^"_$P(PRCD,"-",4)_"^A^^"_PRCOBD_"^"_PRCOBA_"^"_PRCOBL)
 .. S:X $P(^PRCS(417,PRCRI(417),1),"^")=X
 .. QUIT
 . QUIT
 ;D EN^DDIOL("820 FMS TRANSACTION DONE!")
 D EN^DDIOL("IFCAP PATCH *5*55 CONVERSION DONE FOR 1995!")
 D
 . N A,B,X,Y
 . S X(1)="IFCAP CARRY FORWARD CONVERSION FOR 1995 DONE! 1995 RUNNING BALNCE REPORT IS SET UP."
 . S Y(.5)="",Y(DUZ)=""
 . D MM^PRC0B2("IFCAP CARRY FORWARD CONVERSION FOR 1995 DONE!","X(",.Y)
EXIT QUIT
 ;
DUP(A,B) ;CHECK DUPLICATION FOR 442 CONVERSION
 N C,D,E
 S C=""
 S D="" F  S D=$O(^PRCS(410,"D",B,D)) QUIT:'D  I D,+$G(^PRCS(410,D,0))=+PRC("SITE") S C=1 QUIT
 QUIT C
