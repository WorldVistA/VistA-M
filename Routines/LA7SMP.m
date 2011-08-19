LA7SMP ;DALOI/JMC - Shipping Manifest Print ;11/25/96  14:39
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**27,45,46,64**;Sep 27, 1994
EN ;
 D EN^DDIOL("Print Shipping Manifest","","!!")
 D KILL^LA7SMP0
 D INIT^LA7SMP0
 I LA7QUIT D KILL^LA7SMP0 Q
 S LA7SM=$$SELSM^LA7SMU(+LA7SCFG)
 I LA7SM<0 D  Q
 . D EN^DDIOL($P(LA7SM,"^",2),"","!?5")
 . D KILL^LA7SMP0
 S LA7CHK=1 ; flag to check for missing info.
 W !
 D DEV
 D END^LA7SMP0
 Q
 ;
 ;
DEV ; Alternate entry point when user has already selected a manifest.
 ;
 ; Determine if bar codes on manifest
 S LA7SBC=$$GET1^DIQ(62.9,+LA7SCFG_",",.09,"I")
 ; If not in shipping status then don't print, save paper
 I $P($G(^LAHM(62.8,+LA7SM,0)),"^",3)<4 S LA7SBC=0
 I LA7SBC,$P($G(^LAHM(62.8,+LA7SM,0)),"^",3)=4 D
 . N DIR,DIRUT,DTOUT,DUOUT,X,Y
 . S DIR(0)="YO",DIR("A")="Print barcodes on manifest",DIR("B")="YES"
 . D ^DIR
 . I $D(DIRUT) S LA7EXIT=1
 . I Y'=1 S LA7SBC=0
 I $G(LA7EXIT) Q
 ;
 S %ZIS="MQ" D ^%ZIS
 I POP D  Q
 . D HOME^%ZIS
 . S LA7EXIT=1
 I $D(IO("Q")) D  Q
 . N ZTDTH,ZTSK,ZTRTN,ZTIO,ZTSAVE
 . S ZTRTN="DQ^LA7SMP",ZTSAVE("LA7*")="",ZTDESC="Lab Shipping Manifest Print"
 . D ^%ZTLOAD,^%ZISC
 . D EN^DDIOL("Request "_$S($G(ZTSK):"queued - Task #"_ZTSK,1:"NOT queued"),"","!")
 . S LA7EXIT=1
DQ ;
 ;
 U IO
 ;
 S LA7SM(0)=$G(^LAHM(62.8,+LA7SM,0))
 S LA7SCFG=+$P(LA7SM(0),"^",2),LA7SCFG(0)=$G(^LAHM(62.9,LA7SCFG,0))
 S (LA7DC,LA7EXIT,LA7END,LA7ITEM,LA7PAGE,LA7SMR,LA760,LA762801)=0
 ;
 ; Get collecting site's names and station numbers
 D GETSITE^LA7SMP($P(LA7SCFG(0),"^",2),$P(LA7SCFG(0),"^",3),.LA7FSITE,.LA7TSITE)
 ;
 ; Flag - skip if accession deleted
 S LA7SKIP=0
 ; Check manifest for missing info.
 I $G(LA7CHK)="" S LA7CHK=1
 ;
 S LA7NOW=$$HTE^XLFDT($H,"1M")
 ; Manifest status
 S LA7SMST=$P(LA7SM(0),"^",3)
 I LA7SMST=4 D
 . ; Get shipping date
 . S LA7SDT=$$SMED^LA7SMU(LA7SM,"SM05")
 . ; Flag to print receipt.
 . I IOST["P-" S LA7SMR=$P(LA7SCFG(0),"^",10)
 ;
 ; Set barcode flag to "off"
 I LA7SBC,IOST'["P-" S LA7SBC=0
 ;
 S $P(LA7SMST,"^",2)=$$EXTERNAL^DILFD(62.8,.03,"",LA7SMST)
 S LA7LINE="",$P(LA7LINE,"-",IOM)=""
 S LA7SVIA=$S($P(LA7SM(0),"^",4):$$GET1^DIQ(62.92,$P(LA7SM(0),"^",4)_",",.01),1:"None Specified")
 ;
 F  S LA762801=$O(^LAHM(62.8,+LA7SM,10,LA762801)) Q:'LA762801  D
 . F I=0,1,2 S LA762801(I)=$G(^LAHM(62.8,+LA7SM,10,LA762801,I))
 . I $P(LA762801(0),"^",8)=0 Q  ; Test previously "removed".
 . S LA7SKIP=$$CHKTST^LA7SMU(+LA7SM,LA762801)
 . I LA7SKIP,LA7SKIP<3 Q  ; Accession/test deleted
 . I $G(LA7CHK) D CHKREQI^LA7SM2(+LA7SM,LA762801)
 . S ^TMP("LA7SM",$J,+$P(LA762801(0),"^",7),+$P(LA762801(0),"^",9),$P(LA762801(0),"^",5),LA762801)=""
 . D BUILDRI^LA7SM2
 ;
 S (LA7SCOND,LA7SCONT,LA7UID)=""
 ;
 I '$D(^TMP("LA7SM",$J)) D
 . D HED^LA7SMP0
 . W !!,$$CJ^XLFSTR("No entries to print",IOM)
 ;
 S LA7ROOT="^TMP(""LA7SM"",$J)"
 F  S LA7ROOT=$Q(@LA7ROOT) Q:LA7ROOT=""  Q:$QS(LA7ROOT,1)'="LA7SM"!($QS(LA7ROOT,2)'=$J)  D  Q:LA7EXIT
 . I LA7EXIT Q
 . I $L(LA7UID),LA7UID'=$QS(LA7ROOT,5) W !,LA7LINE
 . I LA7SCOND'=$QS(LA7ROOT,3)!(LA7SCONT'=$QS(LA7ROOT,4)) D  Q:LA7EXIT
 . . I $L(LA7UID),LA7UID=$QS(LA7ROOT,5) W !,LA7LINE
 . . I LA7PAGE,+LA7SMST'=4 W ! D WARN^LA7SMP0
 . . S LA7SCOND=$QS(LA7ROOT,3),LA7SCONT=$QS(LA7ROOT,4)
 . . D HED^LA7SMP0 S LA7UID=""
 . S LA762801=$QS(LA7ROOT,6)
 . F I=0,.1,2,5 S LA762801(I)=$G(^LAHM(62.8,+LA7SM,10,LA762801,I))
 . S LA760=+$P(LA762801(0),"^",2) ; File #60 test ien
 . I LA7UID'=$QS(LA7ROOT,5) D  Q:LA7EXIT
 . . S LA7UID=$QS(LA7ROOT,5)
 . . S LRDFN=+LA762801(0) D PTID^LA7SMP0
 . . S X=$Q(^LRO(68,"C",LA7UID))
 . . I LA7UID'=$QS(X,3) S LA7SKIP=1 ; Skip - UID missing.
 . . S LA7AA=+$QS(X,4),LA7AD=+$QS(X,5),LA7AN=+$QS(X,6)
 . . S LA7SKIP=$$CHKTST^LA7SMU(+LA7SM,LA762801)
 . . I LA7SKIP,LA7SKIP<3 Q  ; Skip - accession/test deleted.
 . . S LA7ACC=$P($G(^LRO(68,LA7AA,1,LA7AD,1,LA7AN,.2),"Accession not available"),"^")
 . . S X=$P($G(^LRO(68,LA7AA,1,LA7AD,1,LA7AN,0),"Not available"),U,8)
 . . S LA7PROV=$S(X>0:X,1:"")_"^"_$S(X>0:$$PRAC^LRX(X),1:X)
 . . S LA7CDT=$P($G(^LRO(68,LA7AA,1,LA7AD,1,LA7AN,3),"Not available"),U,1)
 . . S LA7SPEC=$G(^LRO(68,LA7AA,1,LA7AD,1,LA7AN,5,1,0),"Not available")
 . . I LA7SPEC S LA7SPEC(0)=$G(^LAB(61,+LA7SPEC,0))
 . . E  S LA7SPEC(0)="Specimen info not assigned"
 . . S LA762=$P(LA7SPEC,"^",2)
 . . I LA762 S LA762(0)=$G(^LAB(62,LA762,0))
 . . E  S LA762(0)="Collection info not assigned"
 . . S LA7ITEM=LA7ITEM+1
 . . I ($Y+12)>IOSL D  Q:LA7EXIT
 . . . W !
 . . . I +LA7SMST'=4 D WARN^LA7SMP0
 . . . D HED^LA7SMP0
 . . D SH^LA7SMP0
 . I LA7SKIP,LA7SKIP<3 Q  ; Skip - accession/test deleted.
 . I ($Y+6)>IOSL D  Q:LA7EXIT
 . . W !,LA7LINE
 . . I +LA7SMST'=4 W ! D WARN^LA7SMP0
 . . D HED^LA7SMP0 Q:LA7EXIT
 . . S LA7DC=1 D SH^LA7SMP0
 . W !,?11,$E(LA7LINE,1,41)
 . W !,?11,$P(^LAB(60,LA760,0),"^",1),?43,$P(LA7SPEC(0),"^")
 . I +LA7SMST'=4 D
 . . N LA7TCOST
 . . S LA7TCOST=$$GET1^DIQ(60,LA760_",",1,"E") Q:'$L(LA7TCOST)
 . . W:$X>(IOM-15) ! W ?(IOM-15)," Cost: $",$FN(LA7TCOST,",",2)
 . I LA762801(.1)'="" D
 . . K ^UTILITY($J),LA7CMT
 . . S DIWL=1,DIWR=IOM-13,DIWF=""
 . . S X="Relevant clinical information: "_LA762801(.1) D ^DIWP
 . . M LA7CMT=^UTILITY($J,"W",DIWL)
 . . W ! D CMT^LA7SMP0 W !
 . W !,?13,"VA NLT Code [Name]: "
 . S LA7NLT=$$GET1^DIQ(64,+$$GET1^DIQ(60,LA760_",",64,"I")_",",1) ; NLT code.
 . W $S($L(LA7NLT):LA7NLT,1:"*** None specified ***")
 . S LA7NLTN=""
 . I $L(LA7NLT) S LA7NLTN=$$GET1^DIQ(64,+$$GET1^DIQ(60,LA760_",",64,"I")_",",.01) ; NLT code test name.
 . I $L(LA7NLTN) W:($X+$L(LA7NLTN)+3)>IOM !,?32 W " [",LA7NLTN,"]"
 . I $P(LA7SM(0),"^",5) D  ; Print non-VA test code info
 . . N LA7X,LA7Y,LA7Z
 . . S LA7X=$P($G(^DIC(4,+$P(LA7SCFG(0),"^",3),0),"UNKNOWN"),"^",1)_" Order Code [Name]: "
 . . W !,?11,LA7X,$S($L($P(LA762801(5),"^")):$P(LA762801(5),"^"),1:"*** None specified ***")," "
 . . S LA7Y="["_$S($L($P(LA762801(5),"^",2)):$P(LA762801(5),"^",2),1:"*** None specified ***")_"]"
 . . I $L(LA7Y)<(IOM-$X) W LA7Y Q
 . . S LA7X=IOM-$X W $E(LA7Y,1,LA7X)
 . . S LA7Y=$E(LA7Y,LA7X+1,$L(LA7Y)),LA7Z=IOM-11
 . . F  S LA7X=$E(LA7Y,1,LA7Z) Q:LA7X=""  W !,?11,LA7X S LA7Y=$E(LA7Y,LA7Z+1,$L(LA7Y))
 ;
 I LA7EXIT Q
 ;
 W !,LA7LINE,!!,"End of Shipping Manifest"
 ;
 I +LA7SMST'=4 D
 . I IOM<131 W !
 . D WARN^LA7SMP0
 ;
 ; Print shipping manifest receipt.
 I LA7SMR D
 . ; Flag that we're now printing receipt
 . S $P(LA7SMR,"^",2)=1
 . D HED^LA7SMP0
 . W !!,"Number of specimens: ",LA7ITEM
 . W !!,"Receipted by: ",$$REPEAT^XLFSTR("_",40)
 . W !!,"   Date/time: ",$$REPEAT^XLFSTR("_",20)
 ;
 ; Print error listing if any.
 I $O(LA7ERR(""))'="" D
 . S $P(LA7SMR,"^",2)=2 ; Flag printing of error listing
 . D HED^LA7SMP0
 . S LA7I=0
 . F  S LA7I=$O(LA7ERR(LA7I)) Q:LA7I=""  D  Q:LA7EXIT
 . . I ($Y+6)>IOSL D HED^LA7SMP0 Q:LA7EXIT
 . . W LA7ERR(LA7I)
 . . S LA7ROOT="^TMP(""LA7ERR"",$J,LA7I,$P(LA7SM,""^""))"
 . . F  S LA7ROOT=$Q(@LA7ROOT) Q:$QS(LA7ROOT,1)'="LA7ERR"!($QS(LA7ROOT,2)'=$J)!($QS(LA7ROOT,3)'=LA7I)!($QS(LA7ROOT,4)'=$P(LA7SM,"^"))  D  Q:LA7EXIT
 . . . I ($Y+6)>IOSL D HED^LA7SMP0 Q:LA7EXIT  W LA7ERR(LA7I)," (Cont'd)"
 . . . W !,?10,"UID: ",$QS(LA7ROOT,5),"  Test: ",$$GET1^DIQ(60,$QS(LA7ROOT,6)_",",.01)
 . . W !!
 ;
 I $D(ZTQUEUED) D END^LA7SMP0
 ;
 Q
 ;
 ;
GETSITE(LA7X,LA7Y,LA7FS,LA7TS) ; Setup variables for ordering and host sites
 ;
 ; Call with  LA7X = File #4 ordering site ien
 ;            LA7Y = File #4 host site ien
 ;            LA7FS = array to return collecting site info
 ;            LA7TS = array to return host site info
 ;
 ; Get ordering site's names and station numbers
 S LA7FS=$$GET1^DIQ(4,LA7X_",",.01)
 I LA7FS="" S LA7FS="UNKNOWN:Entry #"_+LA7X
 S LA7FS(99)=$$RETFACID^LA7VHLU2(LA7X,2,1)
 I LA7FS(99)="" S LA7FS(99)="UNK: #"_+LA7X
 ;
 ; Get host site's names and station numbers
 S LA7TS=$$GET1^DIQ(4,LA7Y_",",.01)
 I LA7TS="" S LA7TS="UNKNOWN:Entry #"_+LA7Y
 S LA7TS(99)=$$RETFACID^LA7VHLU2(LA7X,1,1)
 I LA7TS(99)="" S LA7TS(99)="UNK: #"_+LA7Y
 Q
 ;
 ;
ASK(LA7SM) ; Ask it user wants to print manifest.
 ;  Call with array LA7SM = ien of 62.8^.01 field of #62.8
 ;
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 ;
 S DIR(0)="YO",DIR("A")="Print Shipping Manifest",DIR("B")="NO"
 D ^DIR Q:$D(DIRUT)
 I Y=1 D DEV,END^LA7SMP0
 ;
 Q
