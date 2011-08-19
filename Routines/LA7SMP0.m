LA7SMP0 ;DALOI/JMC - Shipping Manifest Print (Cont'd);11/25/96  14:39
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**46,64**;Sep 27, 1994
 ;
HED ; Header
 I $E(IOST,1,2)="C-" D TERM Q:$G(LA7EXIT)
 I LA7PAGE W @IOF S $X=0
 S LA7PAGE=LA7PAGE+1
 I +LA7SMST'=4,IOM<132 D WARN
 ;
 W !,?1,"Shipping Manifest: ",$P(LA7SM,"^",2)
 I +LA7SMST'=4,IOM'<132 D WARN
 ;
 W ?IOM-37," Page: ",LA7PAGE
 W !,?11,"to Site: ",LA7TSITE
 W ?IOM-40," Printed: ",LA7NOW
 W !,?9,"from Site: ",LA7FSITE
 ;
 I +LA7SMST=4 W !,?6,"Date Shipped: ",$P(LA7SDT,"^",2)
 E  W !,?12,"Status: ",$P(LA7SMST,"^",2)
 W ?IOM-41," Ship via: ",LA7SVIA
 ;
 ; Check if task has been asked to stop.
 I $D(ZTQUEUED),$$S^%ZTLOAD D  Q
 . S (LA7EXIT,ZTSTOP)=1
 . W !!,"*** Report requested to stop by TaskMan ***"
 . W !,"*** Task #",$G(ZTQUEUED,"UNKNOWN")," stopped at ",$$HTE^XLFDT($H)," ***"
 ;
 ; Print shipping receipt
 I $P(LA7SMR,"^",2) D  Q
 . W !,LA7LINE
 . I $P(LA7SMR,"^",2)=2 W !!,"Following Required Information and/or Test Codes Missing",!!
 ;
 W !,"Shipping Condition: ",$S(LA7SCOND:$$GET1^DIQ(62.93,LA7SCOND_",",.01),1:"None Specified")
 W ?(IOM-42)," Container: ",$S(LA7SCONT:$$GET1^DIQ(62.91,LA7SCONT_",",.01),1:"None Specified")
 ;
 I $L($P(LA7SCFG(0),"^",13)) W !,?4,"Account Number: ",$P(LA7SCFG(0),"^",13)
 ;
 I LA7SBC D SBC1
 W !!,?11,"Patient Name",?41,"Patient ID",?64,"Accession"
 I IOM>131 W ?86,"Requested By"
 W !,?11,"Date of Birth",?41,"Sex",?64,"Specimen UID"
 I IOM>131 W ?86,"Collect Date/Time"
 I IOM'>131 W !,?11,"Requested By",?41,"Collect Date/Time"
 W !,LA7LINE
 Q
 ;
 ;
SH ; Subheader
 W !,"Item: ",LA7ITEM
 W ?11,PNM
 ;I LRDPF=2,LA7ICN W ?41,LA7ICN
 ;E  W ?41,$S(LRDPF=2:SSN,1:SSN(2))
 W ?41,$S(LRDPF=2:SSN,1:SSN(2))
 W ?64,LA7ACC
 I IOM>131 W ?86,$P(LA7PROV,"^",2)
 W !
 I LA7DC W "Cont'd"
 W ?11,$$FMTE^XLFDT(DOB),?41,$S(SEX="M":"Male",SEX="F":"Female",SEX="":"Unknown",1:SEX),?64,LA7UID
 I IOM'>131 W !,?11,$E($P(LA7PROV,"^",2),1,28),?41,$S(LA7CDT:$$FMTE^XLFDT(LA7CDT,"1M"),1:LA7CDT)
 I IOM>131 W ?86,$S(LA7CDT:$$FMTE^XLFDT(LA7CDT,"1M"),1:LA7CDT)
 W !
 I +LA7SMST'=4 D
 . D PROV(+LA7PROV)
 . I $P($G(LA762801(0)),"^",6) D
 . . S X=$$GET1^DIQ(62.91,$P(LA762801(0),"^",6),.01)
 . . W !,?11,"Specimen Container: ",X
 ;
 ; Print collection sample if micro
 I $G(LA7AA),$P($G(^LRO(68,LA7AA,0)),"^",2)="MI" W !,?11,"Collection sample: ",$P(LA762(0),"^")
 ;
 S LA7X=$G(^TMP("LA7SMRI",$J,LA7SCOND,LA7SCONT,LA7UID,1))
 I $P(LA7X,"^") D
 . W !,?11,"Patient Height: ",$P(LA7X,"^",2)," ",$$GET1^DIQ(64.061,+$P(LA7X,"^",3)_",",.01)
 I $P(LA7X,"^",4) D
 . I $P(LA7X,"^") W ?40
 . E  W !,?11
 . W "Patient Weight: ",$P(LA7X,"^",5)," ",$$GET1^DIQ(64.061,+$P(LA7X,"^",6)_",",.01)
 ;
 S LA7X=$G(^TMP("LA7SMRI",$J,LA7SCOND,LA7SCONT,LA7UID,2))
 I $P(LA7X,"^") D
 . W !,?11,"Collection Volume: ",$P(LA7X,"^",2)," ",$$GET1^DIQ(64.061,+$P(LA7X,"^",3)_",",.01)
 I $P(LA7X,"^",8) D
 . I $P(LA7X,"^") W ?40
 . E  W !,?11
 . W "Collection Weight: ",$P(LA7X,"^",9)," ",$$GET1^DIQ(64.061,+$P(LA7X,"^",10)_",",.01)
 I $P(LA7X,"^",4) D
 . W !,?11,"Collection End Date/Time: ",$$FMTE^XLFDT($P(LA7X,"^",5),"1M")
 . W "  (Duration: ",$P(LA7X,"^",6)," ",$$GET1^DIQ(64.061,+$P(LA7X,"^",7)_",",.01),")"
 ;
 I LA7SBC D SBC2
 S LA7DC=0
 Q
 ;
 ;
WARN ; Write warning for work copy.
 W ?$S(IOM<131:5,1:40),"*** DO NOT USE FOR SHIPPING DOCUMENT - WORK COPY ONLY ***"
 Q
 ;
 ;
SBC1 ; Site bar codes
 ;
 ; Print "SM" bar code
 ; Calculate/append LPC to barcode. 
 I $G(LA7SM("BARCODE"))="" D
 . N LA7X,X,Y
 . I LA7SBC=1 D
 . . S LA7X="STX^SITE^"_LA7FSITE(99)_"^"_$P($G(LA7SDT),"^")_"^"_$P(LA7SM,"^",2)_"^ETX"
 . I LA7SBC=2 D
 . .S LA7X="SITE^"_LA7FSITE(99)_"^"_$P($G(LA7SDT),"^")_"^"_$P(LA7SM,"^",2)_"^"
 . S X=LA7X X ^%ZOSF("LPC") S LA7SM("LPC")=Y,LA7SM("BARCODE")=LA7X_Y
 ;
 W !,?18,"SM: ",$$BC128^LA7SBC(LA7SM("BARCODE"),1,60,"","",2),!
 ;
 Q
 ;
 ;
SBC2 ; Patient bar codes
 ;
 N LA7SDATA
 ;
 ; Print "PD" bar code
 I LA7SBC=1 D
 . S LA7SDATA="STX^PD^"_SSN(2)_"^"_LA7FSITE(99)_"^"_LA7UID_"^"_$G(SEX)_"^"_LA7CDT_"^ETX"_$G(LA7SM("LPC"))
 ;
 I LA7SBC=2 D
 . S LA7SDATA="PD^"_SSN(2)_"^"_LA7FSITE(99)_"^"_LA7UID_"^"_LA7CDT_"^"_$G(LA7SM("LPC"))
 ;
 W !!,?18,"PD: ",$$BC128^LA7SBC(LA7SDATA,1,60,"","",2),!
 W !,?11,$E(LA7LINE,1,69)
 ;
 ; Print "PD1" bar code
 I LA7SBC=1 D
 . S LA7SDATA="STX^PD1^"_SSN(2)_"^"_PNM_"^"_DOB_"^ETX"_$G(LA7SM("LPC"))
 I LA7SBC=2 D
 . S LA7SDATA="PD1^"_SSN(2)_"^"_PNM_"^"_DOB_"^"_SEX_"^"_$G(LA7SM("LPC"))
 ;
 W !,?$S(IOM<131:18,1:50),"PD1: ",$$BC128^LA7SBC(LA7SDATA,1,60,"","",2),!
 ;
 Q
 ;
 ;
CMT ; Print comments on manifest
 ;
 N LA7I
 F LA7I=1:1:LA7CMT D  Q:LA7EXIT
 . I ($Y+4)>IOSL D  Q:LA7EXIT
 . . I LA7PAGE W ! D WARN
 . . D HED
 . W !,?11,LA7CMT(LA7I,0)
 Q
 ;
 ;
PTID ; Get/setup patient identifier information
 ;
 S DFN=+$P(^LR(LRDFN,0),U,3),LRDPF=+$P(^(0),U,2) D PT^LRX
 ;
 ; Integration control number (ICN) from MPI
 S LA7ICN=""
 S X="MPIF001" X ^%ZOSF("TEST")
 I $T,LRDPF=2 D
 . S LA7ICN=$$GETICN^MPIF001(DFN)
 . I LA7ICN<1 S LA7ICN=""
 Q
 ;
 ;
PROV(LA7OP) ; Print ordering provider contact on working copy
 ; Call with LA7OP = provider's file #200 ien
 ;
 N LRERR,X,Y
 I LA7OP D GETS^DIQ(200,LA7OP_",",".132;.137;.138","E","LA7OP(LA7OP)","LRERR")
 I '$D(LA7OP(LA7OP)) Q
 S X="Requestor's "
 I LA7OP(LA7OP,200,LA7OP_",",.132,"E")'="" D
 . W !,?11,X,"Phone: ",LA7OP(LA7OP,200,LA7OP_",",.132,"E")
 . S X=""
 I LA7OP(LA7OP,200,LA7OP_",",.137,"E")'="" D
 . S Y=0
 . I X="" S Y=$L(LA7OP(LA7OP,200,LA7OP_",",.137,"E"))+$X+16
 . I Y>IOM!(X'="") W !,?11
 . E  S X="  "_X
 . W X,"Voice Pager: ",LA7OP(LA7OP,200,LA7OP_",",.137,"E")
 . S X=""
 I LA7OP(LA7OP,200,LA7OP_",",.138,"E")'="" D
 . S Y=0
 . I X="" S Y=$L(LA7OP(LA7OP,200,LA7OP_",",.138,"E"))+$X+18
 . I Y>IOM!(X'="") W !,?11
 . E  S X="  "_X
 . W X,"Digital Pager: ",LA7OP(LA7OP,200,LA7OP_",",.138,"E")
 . S X=""
 ;
 I X="" W !
 Q
 ;
 ;
TERM ;
 I 'LA7PAGE W @IOF S $X=0 Q
 ;
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="E" D ^DIR S:$D(DIRUT) LA7EXIT=1
 Q
 ;
 ;
INIT ; Initialize variables
 ;
 S DT=$$DT^XLFDT
 S LA7QUIT=0
 ;
 ; Select shipping configuration
 S LA7SCFG=$$SSCFG^LA7SUTL(0)
 I LA7SCFG<1 S LA7QUIT=1 Q
 S LA7SCFG(0)=$G(^LAHM(62.9,+LA7SCFG,0))
 Q
 ;
END ;
 I $E(IOST,1,2)="C-",'$G(LA7EXIT) D TERM
 I $E(IOST,1,2)="P-" W @IOF S IONOFF=""
 I '$D(ZTQUEUED) D ^%ZISC
 ;
KILL ; Cleanup variables
 K %,%DT,%ZIS,A,IO("Q"),AGE,DA,DFN,DIC,DIB,DIR,DIRUT,DTOUT,DUOUT,I,J,K,LAST,PNM,SEX,SSN,X,Y,Z
 K LA7AA,LA7ACC,LA7AD,LA7AN,LA7CDT,LA7CHK,LA7CMT,LA7DC,LA7END,LA7ERR,LA7EV,LA7EXIT,LA7FSITE,LA7I,LA7ICN,LA7ITEM,LA7LINE,LA7NLT,LA7NLTN,LA7NOW,LA7PAGE,LA7PROV
 K LA7QUIT,LA7ROOT,LA7SBC,LA7SCFG,LA7SCOND,LA7SCONT,LA7SDT,LA7SKIP,LA7SM,LA7SMR,LA7SMST,LA7SPEC,LA7SVIA,LA7TSITE,LA7UID,LA7X
 K LA760,LA762801
 K LRDFN,LRDPF,LRPRAC
 K ^TMP("LA7ERR",$J),^TMP("LA7SM",$J),^TMP("LA7SMRI",$J)
 D KVAR^LRX
 ;
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
