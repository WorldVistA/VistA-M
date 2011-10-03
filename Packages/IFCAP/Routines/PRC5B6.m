PRC5B6 ;WISC/PLT-CORRECT ISSUE BOOK BALANCE BY QUARTERS FOR FY-1995 ONLY ;
V ;;5.0;IFCAP;**27**;4/21/95
 QUIT  ;invalid entry
 ;
EN ;CORRECT ISSUE BOOK BALANCE
 N PRC,PRCRI,PRCA,PRCB,PRCC,PRCD,PRCG,PRCH
 N A,B,X,Y
 W @IOF D EN^DDIOL("CONVERT POSTED ISSUE BOOK BALANCE FOR IFCAP V5 INSTALLATION QUARTER WITH V4 RECORDS ONLY")
Q1 D DT^PRC0A(.X,.Y,"For IFCAP v4 -> v5 Installation Date","O","")
 G:X["^"!(X="") EXIT
 S PRCA=$$DATE^PRC0C(Y,"I")
Q2 D YN^PRC0A(.X,.Y,"CONVERT POSTED ISSUE BOOK REQUEST FOR "_$P(PRCA,"^")_" QTR "_$P(PRCA,"^",2),"O","NO")
 G:X["^"!(X="")!'Y Q1
EN1 S PRCRI(410.5)=0 F  S PRCRI(410.5)=$O(^PRCS(410.5,PRCRI(410.5))) Q:'PRCRI(410.5)  S A=$G(^(PRCRI(410.5),0)) QUIT:A["ISSUE BOOK"
 I $G(PRCRI(410.5))'=5 D EN^DDIOL("ISSUE BOOK form type code is not 5 in file 410.5") G EXIT
 S PRCRI(442.3)=$O(^PRCD(442.3,"C",40,0))
 I 'PRCRI(442.3) D EN^DDIOL("Issue Book complete status is not in file 442.3") G EXIT
 D EN^DDIOL("ISSUE BOOK CONVERTING FOR OLD IFCAP V4 RECORDS STARTS")
 S PRCRI(411)=0 F  S PRCRI(411)=$O(^PRC(411,PRCRI(411))) QUIT:PRCRI(411)>999999!'PRCRI(411)  D
 . S PRC("SITE")=$P($G(^PRC(411,PRCRI(411),0)),"^") QUIT:'PRC("SITE")
 . S PRCB=PRC("SITE")_"-"_$E(PRCA,3,4)_"-"_$P(PRCA,"^",2)_"-",PRCC=PRCB_"~"
 . S PRCD=PRCB
 . ;check form type 5 and status 40 for final post
 . F  S PRCD=$O(^PRCS(410,"B",PRCD)) Q:PRCD=""!(PRCD]PRCC)  S PRCRI(410)=$O(^(PRCD,0)) I PRCRI(410) S PRCF=$G(^PRCS(410,PRCRI(410),0)) I $P(PRCF,"^",4)=PRCRI(410.5),$P($G(^(10)),"^",4)=PRCRI(442.3) D
 .. S PRCF=$G(^PRCS(410,PRCRI(410),445)),PRCG=$G(^(4)),PRCH=$G(^(9)),PRCI=$G(^(10))
 .. I PRCF="",$P(PRCH,"^",3)]"",$P(PRCI,"^",4)=$O(^PRCD(442.3,"C",40,0)) D IB
 . QUIT
 ;
 D EN^DDIOL(" ")
 D EN^DDIOL("ISSUE BOOK CONVERTING FOR OLD IFCAP V4 RECORDS ENDS")
 D EN^DDIOL(" ")
 D EN^DDIOL(" Any IB transactions followed by a printed message 'IB obligation #/amount...'")
 D EN^DDIOL("were not converted because the Obligation Data was not entered for these IBs.")
EXIT QUIT
 ;
EN2 ;called from prc5b
 N PRC,PRCRI,PRCA,PRCB,PRCC,PRCD,PRCG,PRCH
 N A,B,X,Y
 S PRCA=$$DATE^PRC0C("N","E")
 G EN1
 ;
IB ;process ib txn
 S $P(PRCF,"^")=$P(PRCG,"^",5),$P(PRCF,"^",3)=$P(PRCG,"^",3)
 W !,PRCD,?20,$P(PRCF,"^"),?30,"$",$P(PRCF,"^",3)
 I $P(PRCF,"^",1)=""!($P(PRCF,"^",3)="") W "  IB obligation #/amount not entered by using OBLIGATION DATA option in v4" QUIT
 S TOTALSAL=$P(PRCF,"^",3)
 D IVDATA(PRCRI(410),"")
 S PRCPDA=PRCRI(410)
 I $P($G(^PRC(420,PRCPPSTA,1,PRCPPFCP,0)),"^",12)=4 W ?40,"Canteen, not processed" I 1
 E  S ^PRCS(410,PRCRI(410),445)=PRCF D IB^PRCS0B(PRCPPSTA_"^"_PRCPWSTA,PRCPPFCP_"^"_PRCPWFCP,PRCPDA,TOTALSAL_"^"_TOTALSAL) W ?40,"Processed"
 QUIT
 ;
IVDATA(TRANDA,INVPT) ;  get fund control point data for iv doc
 ;  tranda=issue book ien; invpt=whse inventory point
 N PRC,TRANNO
 S TRANNO=$P($G(^PRCS(410,TRANDA,0)),"^")
 D:$G(INVPT)=""
 . N A
 . S A=0 F  S A=$O(^PRCP(445,"AC","W",A)) Q:'A  I +$G(^PRCP(445,+A,0))=$P(TRANNO,"-",1) S INVPT=A QUIT
 . QUIT
 I INVPT="" W "     Warehouse is not defined for this station" QUIT
 ;  seller=whse data
 S PRCPWSTA=$P($P($G(^PRCP(445,INVPT,0)),"^"),"-")
 S PRCPWFCP=+$O(^PRC(420,"AE",INVPT,PRCPWSTA,0))
 S PRCPWBFY=$$BBFY^PRCSUT(PRCPWSTA,$P(TRANNO,"-",2),PRCPWFCP,1)
 ;  buyer data
 S PRCPPSTA=$P(TRANNO,"-")
 S PRCPPFCP=+$P($G(^PRCS(410,TRANDA,3)),"^") I 'PRCPPFCP S PRCPPFCP=+$P(TRANNO,"-",4)
 S PRCPPBFY=$P($G(^PRCS(410,TRANDA,3)),"^",11) I PRCPPBFY'="" S PRCPPBFY=(17+$E(PRCPPBFY))_$E(PRCPPBFY,2,3)
 I PRCPPBFY="" S PRCPPBFY=$$BBFY^PRCSUT(PRCPPSTA,$P(TRANNO,"-",2),PRCPPFCP,1),$P(^PRCS(410,TRANDA,3),"^",11)=$P($$DATE^PRC0C(PRCPPBFY,"E"),"^",7) W "*"
 QUIT
