PRCSRIG1 ;WISC/SAW/KMB/LJP/SC-GENERATE REQUESTS FROM REPETITIVE ITEM LIST FILE (CON'T) ;3-3-93/14:30 ; 3/31/05 3:48pm
V ;;5.1;IFCAP;**13,81,101,110**;Oct 20, 2000;Build 7
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;PRC*5.1*81, RIL that originated thru DynaMed is NOT allowed to be
 ;RE-USED for generating 2237(s),hence removed this prompt for DM
 ;trxs. only.
 ;
 U IO S PRCSNO=$P(^PRCS(410.3,PRCSRID0,0),"^"),PRC("SITE")=+PRCSNO,PRC("CP")=$S($D(^PRC(420,PRC("SITE"),1,+$P(PRCSNO,"-",4),0)):$P(^(0),"^"),1:"")
 I PRC("CP")="" W !!,"Control Point ",$P(PRCSNO,"-",4),"no longer exists.  You will have to transfer",!,"this repetitive item list to an existing control point before you can continue." K PRC("CP") G EXIT
 ;Create transaction number 
 D:'$D(DT) DT^DICRW S PRCSTIME=$E(DT,4,5),PRCSQUAR=$P("2^2^2^3^3^3^4^4^4^1^1^1","^",PRCSTIME)
 S:PQTR=1 PRCSQUAR=$P(PRCSNO,"-",3)
 S Z1=$P(PRCSNO,"-")_"-"_PRC("FY")_"-"_PRCSQUAR_"-"_$P(PRCSNO,"-",4)
 S Z2=$P(Z1,"-",1,2)_"-"_$P(Z1,"-",4)
 S PRCSCC=$P(PRCSNO,"-",5),PRCSCC=$S($D(^PRCD(420.1,+PRCSCC,0)):$E($P(^(0),"^"),1,30),1:PRCSCC) S:PRCSCC="NONE" PRCSCC="" S X="N",%DT="T" D ^%DT S PRCSD1=$P(Y,".") X ^DD("DD") S PRCSD=Y,X="T+30" D ^%DT S PRCSD(1)=Y
 ;
 ;See NOIS MON-0399-51726
 KILL ^TMP($J)
 S IB=0
 F  S IB=$O(^PRCS(410.3,PRCSRID0,1,IB)) Q:'IB  D  ;
 . S FF=$G(^PRCS(410.3,PRCSRID0,1,IB,0))
 . S ^TMP($J,410.3,PRCSRID0,1,"AC",$P(FF,"^",3)_";"_$P(FF,"^",5),IB)=""
 ;
 ; Loop thru RIL entry numbers. PRCSV1 is the vendor for
 ;the item, from the Rep. Item List. Starting here, loop
 ;thru the vendor to get the items ordered from that vendor,
 ;using PRCSRI for the item.
 S (PRCSV1,PRCSTC)="",(PRCSCT,PRCSCT(1),PRCSIT,BFLAG)=0
 F PRCSRIJ=0:1 S PRCSV1=$O(^TMP($J,410.3,PRCSRID0,1,"AC",PRCSV1)) Q:PRCSV1=""!(BFLAG=1)  S PRCSCT=PRCSCT+1,PRCSCT(1)=PRCSCT(1)+1 D:'PRCSRIJ HDRG D ITEMG^PRCSRIG2
 I 'PRCSRIJ W !,"Items have not yet been entered for Repetitive Item List # ",PRCSNO G CLS
 D:IOSL-$Y<3 HOLD,HDRG W !!,"Total no. of requests generated: ",PRCSCT,"    Total no. of items (all requests): ",PRCSIT,!,"Total committed (estimated) cost (all requests) : ","$"_$J(PRCSTC,0,2)
SV ;
 I (IO'=IO(0))!($D(ZTQUEUED)) D ^%ZISC
 ;patch *81 -DynaMed trx. is not allowed to be re-used
 N PRCVSY,PRCVID
 S PRCVSY=$$GET^XPAR("SYS","PRCV COTS INVENTORY",1,"Q")
 I PRCVSY=1 S PRCVID=$$ITDMID(PRCSRID0)
 I PRCVSY=1,PRCVID=1 G CHK1
 G EXIT:$D(ZTQUEUED)
 U IO(0) S %=2 W !,"Do you wish to re-use this list " D YN^DICN G:%=1 JMP G:%=0 SV
CHK1 I PRCSCT=PRCSCT(1) S DIK="^PRCS(410.3,",DA=PRCSRID0 D ^DIK G CLS
JMP D RLR^PRCSUT1
 S $P(^PRCS(410.3,PRCSRID0,0),U,5)="",DIK="^PRCS(410.3,",DA=PRCSRID0 D IX^DIK
CLS ;
 D:$D(ZTSK) KILL^%ZTLOAD G EXIT
 ;
HDRG W @IOF,"GENERATE REQUESTS FROM REPETITIVE ITEM LIST FILE",?55,"DATE: ",PRCSD,!,"Requests Generated From Repetitive Item List Entry # ",PRCSNO,! S L="",$P(L,"-",IOM)="-" W L S L=""
 Q
 ;
HOLD Q:IO'=IO(0)!($D(ZTQUEUED))  W !,"Press return to continue: " R Z(1):DTIME Q
ASK S %=2 W !,"Do you wish to edit this request" D YN^DICN D ASK:%=0 G:%=2 EN1 Q:%'=1
EN W ! K DTOUT,DUOUT,Y S DIE="^PRCS(410,",(PRCSDR,DR)="[PRCSENPR]",T1=DA D ^DIE I $D(Y)!($D(DTOUT)) S DA=T1 Q
 S DA=T1 D RL^PRCSUT1,^PRCSCK I $D(PRCSERR),PRCSERR G EN
EN1 W ! D W6^PRCSEB Q
 ;*****************************************************************
 ; PRCSRID0 represents the ien of the record in file 410.3
 ; patch *81 --itdmid removes Re-use Ques for DM related RIL
 ;*****************************************************************
ITDMID(PRCSRID0) ; check DynaMed DOC ID existence for an item
 ;N PRCVA,PRCVB,PRCVFLG
 ;S PRCVA=0
 ;S PRCVFLG=0 ; 0 means that there is no DM ID on a item
 ;S PRCVA=$O(^PRCS(410.3,PRCSRID0,1,PRCVA)) D
 ;.Q:+$G(PRCVA)'>0
 ;.S PRCVB=$$GET1^DIQ(410.31,PRCVA_","_PRCSRID0_",",6) ; DM doc id
 ;.I PRCVB'="" S PRCVFLG=1 Q
 ;Q PRCVFLG
 ;
 ;Remove the prompt if entry is set in 414.02 Audit File 'C' x-ref
 N PRCVFLG,PRCVL,PRCVM
 S PRCVM=$$GET1^DIQ(410.3,PRCSRID0_",",.01) ; ext value of RIL trx
 S PRCVL=""
 S PRCVFLG=0
 S PRCVL=$O(^PRCV(414.02,"C",PRCVM,PRCVL))
 I PRCVL'="" S PRCVFLG=1 Q 1
 Q PRCVFLG
 ;
 ;
EXIT K %,%DT,%ZIS,PRCSRID0,DA,DIC,DIE,DIK,PRCSRIJ,K,L,PRCSRIM,PRCS,PRCSCS
 K PRCSCT,PRCSCC,PRCSD,PRCSD1,PRCSRI,PRCSIT,PRCSL,PRCSNO,PRCSS,PRCSTC
 K PRCSV1,PX,T1,X,X1,X2,Y,Z,Z1,Z2
 K PRCSTIME,PRCSQUAR,^TMP($J) Q
