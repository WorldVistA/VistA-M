PRCSRIP ;WISC/SAW/BMM-PRINT/DISPLAY ITEMS BY VENDOR FROM REPETITIVE ITEM LIST FILE ;8/18/94  14:24 ;
V ;;5.1;IFCAP;**13,81**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;BMM 2/22/05 per PRC*5.1*81 add code to display DM DOC ID and Date
 ;Needed fields for RILs originating in DynaMed
 ;
 S DIC="^PRCS(410.3,",DIC(0)="AEMQ",DIC("S")="S PRC(""SITE"")=+^(0),PRC(""CP"")=+$P(^(0),""-"",4) I $D(^PRC(420,""A"",DUZ,PRC(""SITE""),+PRC(""CP""),1))!($D(^(2)))"
 S DIC("A")="Select REPETITIVE ITEM LIST #: " D ^DIC K DIC("S") I Y'>0 G EXIT
 S D0=+Y G EXIT:$G(^PRCS(410.3,D0,0))=""
 ;
 ;See NOIS MON-0399-51726
 D SORT
 ;
 S %ZIS("B")="HOME",%ZIS="MQ" D ^%ZIS G EXIT:POP I $D(IO("Q")) S ZTRTN="QUE^PRCSRIP",ZTSAVE("D0")="" D ^%ZTLOAD G EXIT
QUE U IO S PRCSNO=$P(^PRCS(410.3,D0,0),"^") D NOW^%DTC S Y=% D DD^%DT S PRCSD=Y
 S (N,PRCSP,PRCSIT,PRCSTC,Z(1))=""
 I $G(ZTRTN)="QUE^PRCSRIP" D SORT ;See NOIS MON-0399-51726
 F J=0:1 S N=$O(^TMP($J,410.3,D0,1,"AC",N)) Q:N=""  D:'J HDRL D:IOSL-($Y#IOSL)<4 HOLD Q:Z(1)=U  D:IOSL-($Y#IOSL)<4 HDRL W !!,"VENDOR: ",$P(N,";")," (",$P(N,";",2),")",! D ITEML
 I 'J W !,"Items have not yet been entered for Repetitive Item List # ",PRCSNO
 I J D:IOSL-($Y#IOSL)<4 HOLD Q:Z(1)=U  D:IOSL-($Y#IOSL)<4 HDRL W !!,"TOTAL # OF ITEMS (ALL VENDORS): ",$J(PRCSIT,4),?40,"TOTAL COST (ALL VENDORS): ",$J(PRCSTC,9,2)
 I (IO'=IO(0))!($D(ZTQUEUED)) D ^%ZISC
 G EXIT
 ;
ITEML ;PRC*5.1*81 redirect to ITEML1D instead of ITEML1 if a DynaMed RIL
 ;
 N PRCVDF,PRCVDN
 S (N(1),PRCSC,PRCVDF,PRCVDN)=""
 ;check Inventory flag
 S PRCVDF=$$GET^XPAR("SYS","PRCV COTS INVENTORY",1,"Q")
 F K=0:1 S N(1)=$O(^TMP($J,410.3,D0,1,"AC",N,N(1))) Q:N(1)=""  D  Q:Z(1)=U
 . ;PRC*5.1*81 if flag=1 then DM RIL, use different display
 . S PRCVDN=$$GET1^DIQ(410.31,N(1)_","_D0_",",6)
 . I PRCVDF=1,PRCVDN'="" D ITEML1D(PRCVDN) Q
 . D ITEML1
 Q:Z(1)=U  D:IOSL-($Y#IOSL)<3 HDRL W !!,"TOTAL # OF ITEMS: ",$J(K,4),?25,"TOTAL COST: ",$J(PRCSC,9,2),! S L="",$P(L,"-",IOM)="-" W L S L=""
 S PRCSIT=PRCSIT+K,PRCSTC=PRCSTC+PRCSC Q
 ;
ITEML1 I IOSL-($Y#IOSL)<2 D HOLD Q:Z(1)=U  D HDRL W !!,"VENDOR: ",$P(N,";")," (",$P(N,";",2),")",!
 S X=^PRCS(410.3,D0,1,N(1),0) W !,$P(X,"^"),?12 W:$D(^PRC(441,$P(X,"^"),0)) $E($P(^(0),"^",2),1,42) W ?54,$S($P(X,"^",2)[".":$J($P(X,"^",2),9,2),1:$J($P(X,"^",2),9)),?66,$J($P(X,"^",4),9,2)
 I $D(^PRC(441,$P(X,"^"),2,+$P(X,"^",5),0)) W ?78,$S($D(^PRCD(420.5,+$P(^(0),"^",7),0)):$P(^(0),"^"),1:"")
 S PRCSC=PRCSC+($P(X,"^",2)*($P(X,"^",4))) Q
 ;
HOLD Q:IO'=IO(0)!($D(ZTQUEUED))  S Z(1)="" W !,"Press return to continue, uparrow (^) to exit: " R Z(1):DTIME S:'$T Z(1)=U Q
HDRL S PRCSP=PRCSP+1 W @IOF,"REPETITIVE ITEM LIST #: ",PRCSNO,?50,"DATE: ",PRCSD,"  PAGE ",PRCSP
 W !,"ITEM NO.",?12,"SHORT DESCRIPTION",?55,"QUANTITY",?66,"UNIT COST",?77,"U/P",! S L="",$P(L,"-",IOM)="-" W L S L=""
 Q
 ;
SORT ;See NOIS MON-0399-51726
 KILL ^TMP($J)
 N II,FF S II=0
 F  S II=$O(^PRCS(410.3,D0,1,II)) Q:'II  D  ;
 . S FF=$G(^PRCS(410.3,D0,1,II,0))
 . S ^TMP($J,410.3,D0,1,"AC",$P(FF,"^",3)_";"_$P(FF,"^",5),II)=""
 Q
 ;
EXIT K %,%DT,%ZIS,D0,DIC,I,J,K,L,N,PRCSC,PRCSD,PRCSIT,PRCSNO,PRCSP,PRCSTC
 K PRCS,X,Y,Z,IEN410,^TMP($J) Q
 ;
ITEML1D(PRCVDN) ;PRC*5.1*81
 ;display items from DynaMed RIL, include DM Doc ID and
 ;Date Needed
 ;PRCVDN is DM Doc ID
 ;
 N PRCVED,PRCVFMD
 I IOSL-($Y#IOSL)<2 D HOLD Q:Z(1)=U  D HDRL W !!,"VENDOR: ",$P(N,";")," (",$P(N,";",2),")",!
 S X=^PRCS(410.3,D0,1,N(1),0) W !,$P(X,"^"),?12 W:$D(^PRC(441,$P(X,"^"),0)) $E($P(^(0),"^",2),1,42) W ?54,$S($P(X,"^",2)[".":$J($P(X,"^",2),9,2),1:$J($P(X,"^",2),9)),?66,$J($P(X,"^",4),9,2)
 I $D(^PRC(441,$P(X,"^"),2,+$P(X,"^",5),0)) W ?78,$S($D(^PRCD(420.5,+$P(^(0),"^",7),0)):$P(^(0),"^"),1:"")
 ;S PRCVFMD=$$HL7TFM^XLFDT($P(X,"^",8))
 S PRCVED=$$FMTE^XLFDT($P(X,"^",8))
 W !,"DM DOC ID: ",$P(X,"^",7),?45,"DATE NEEDED BY: ",PRCVED
 S PRCSC=PRCSC+($P(X,"^",2)*($P(X,"^",4)))
 Q
 ;
