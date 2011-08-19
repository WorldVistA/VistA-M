LA7SMPXL ;DALOI/JMC - PRINT SHIPPING MANIFEST FROM PENDING ORDERS FILE ; 12/3/1997
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**27,42,46,64**;Sep 27, 1994
EN ;
 ;
 N D,DIC,LA7SM,X,Y,%ZIS
 ;
 S DIC=69.6,DIC(0)="AQEZNM",DIC("A")="Select Shipping Manifest: ",D="D"
 S DIC("S")="I $L($P(^(0),U,14))"
 D MIX^DIC1 K DIC("S")
 I Y<1 D END Q
 ;
 S LA7SMAN=$P(Y(0),U,14)
 ;
 S %ZIS="MQ"
 D ^%ZIS
 I POP D  Q
 . D HOME^%ZIS
 . D END
 ;
 I $D(IO("Q")) D  Q
 . S ZTRTN="DQ^LA7SMPXL",ZTDESC="Shipping Manifest Reprint",ZTSAVE("LA7*")=""
 . D ^%ZTLOAD,HOME^%ZIS
 . D EN^DDIOL("Request "_$S($G(ZTSK):"queued - Task #"_ZTSK,1:"NOT queued"),"","!")
 . D END
 ;
DQ ; Tasked entry point
 ;
 U IO
 ;
 S DT=$$DT^XLFDT
 S LRDPF=69.6,LA7NOW=$$HTE^XLFDT($H,"1M")
 S (LA7DC,LA7EXIT,LA7PAGE,LA7SCOND,LA7SCONT)=0
 S LA7SCFG=0,LA7SCFG(0)=""
 S LA7LINE="",$P(LA7LINE,"-",IOM)="",LA7SVIA="Electronic manifest"
 ;
 ; Check manifest for missing info.
 S LA7CHK=0
 ; Flag to print receipt.
 S LA7SMR="0^0"
 ; Set barcode flag
 S LA7SBC=0
 I IOST["P-" S LA7SBC=2
 ; Shipping status flag
 S LA7SMST="0^Electronic Manifest"
 ;
 S (LA7696,LA7QUIT)=0,LA7UID=""
 S LA7SM="^"_LA7SMAN
 S LA7ROOT="^LRO(69.6,""AD"",LA7SMAN)"
 F LA7ITEM=1:1 S LA7ROOT=$Q(@LA7ROOT) D  Q:LA7EXIT
 . I $QS(LA7ROOT,3)'=LA7SMAN S LA7EXIT=1
 . I LA7EXIT Q
 . I LA7UID'="",LA7UID'=$QS(LA7ROOT,4) W !,LA7LINE
 . S LA7696=$QS(LA7ROOT,5)
 . D SETUP
 . I ($Y+12)>IOSL!('LA7PAGE) D  Q:LA7EXIT
 . . I LA7PAGE W ! D WARN^LA7SMP0
 . . D HED^LA7SMP0
 . D SH^LA7SMP0
 . I $D(LA7CMT) D CMT^LA7SMP0
 . W !,?18,$E(LA7LINE,1,31)
 . S LA76964=0
 . F  S LA76964=$O(^LRO(69.6,LA7696,2,LA76964)) Q:LA76964<1  D
 . . S LA76964(0)=$G(^LRO(69.6,LA7696,2,LA76964,0))
 . . W !?18,$P(LA76964(0),"^",3),?50,$P(LA7SPEC(0),"^")
 . . W !,?20,"VA NLT code [Name]: "
 . . S LA7NLT=$P(LA76964(0),"^",2)
 . . W $S($L(LA7NLT):LA7NLT,1:"*** None specified ***")
 . . S LA7NLTN=$P(LA76964(0),"^")
 . . I LA7NLTN'="" W:($X+$L($P(LA76964(0),"^",2))+3)>IOM !,?39 W " [",LA7NLTN,"]"
 . . I $P(LA76964(0),"^",9)'="" W !,?20,"Host site UID: ",$P(LA76964(0),"^",9)
 ;
 D END
 Q
 ;
 ;
SETUP ; Setup variables for this order
 ;
 N I,X
 ;
 F I=0,1 S LA7696(I)=$G(^LRO(69.6,LA7696,I))
 ;
 S PNM=$P(LA7696(0),U),SEX=$P(LA7696(0),U,2),DOB=$P(LA7696(0),U,3)
 S (SSN,SSN(2))=$P(LA7696(0),U,9)
 ;
 S LA7ACC=$P(LA7696(0),"^",12)
 S LA7UID=$P(LA7696(0),"^",6)
 S LA7SPEC=+$P(LA7696(0),"^",7),LA7SPEC(0)=$G(^LAB(61,LA7SPEC,0))
 S LA7CDT=$P(LA7696(1),U,2)
 S LA7SDT=$P(LA7696(1),U,5)
 ;
 ; Get collecting site and host site info
 D GETSITE^LA7SMP($P(LA7696(0),U,5),DUZ(2),.LA7FSITE,.LA7TSITE)
 ;
 ; Ordering provider
 S I=0,LA7PROV=""
 F  S I=$O(^LRO(69.6,LA7696,2,I)) Q:'I  D  Q:LA7PROV'=""
 . S X=$P($G(^LRO(69.6,LA7696,2,I,1)),"^")
 . I X'="" S $P(LA7PROV,"^",2)=$P(X,"[")
 I LA7PROV="" S LA7PROV="^REF:"_LA7FSITE(99)
 ;
 ; Get shipping date
 S LA7SDT=$$FMTE^XLFDT($P(LA7696(1),"^",3),"")
 ;
 ; Check for comments
 K LA7CMT
 I $D(^LRO(69.6,LA7696,99,0)) D
 . N DIWF,DIWL,DIWR,LA7ERR,X
 . S LA7CMT=$$GET1^DIQ(69.6,LA7696_",",99,"","LA7CMT","LA7ERR(2)")
 . K ^UTILITY($J,"W")
 . S DIWL=1,DIWR=IOM-13,DIWF=""
 . I $$GET1^DID(+$$GET1^DID(69.6,99,"","SPECIFIER","LA7ERR(1)"),.01,"","SPECIFIER","LA7ERR(3)")["L" S DIWF="N"
 . S LA7I=$O(LA7CMT(0)),LA7CMT(LA7I)="COMMENTS: "_LA7CMT(LA7I),LA7I=0
 . F  S LA7I=$O(LA7CMT(LA7I)) Q:'LA7I  S X=LA7CMT(LA7I) D ^DIWP
 . K LA7CMT
 . M LA7CMT=^UTILITY($J,"W",DIWL)
 . K ^UTILITY($J,"W")
 ;
 ; Add local (host) status info
 S LA7CMT=$G(LA7CMT)+1
 I LA7CMT>1 S LA7CMT(LA7CMT,0)=" ",LA7CMT=LA7CMT+1
 S LA7CMT(LA7CMT,0)="Host test status: "_$$GET1^DIQ(69.6,LA7696_",",6,"",,"LA7ERR(4)")
 Q
 ;
 ;
END ;
 S LA7EXIT=1
 D END^LA7SMP0
 K LA7696,LA76964,LA7CMT,LA7SMAN
 ;
 Q
