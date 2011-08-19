FBAALPI ;AISC/GRR-LIST INVOICES READY FOR MAS COMPLETION ;27MAR86
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 D DT^DICRW I '$D(^FBAA(162.1,"AC",2)) W !!,*7,"There are no Invoices pending completion!" Q
 D HOME^%ZIS W @IOF,?5,"Pharmacy Invoices Pending MAS completion",! S C=0,FBAAOUT=0
 F J=0:0 S J=$O(^FBAA(162.1,"AC",2,J)) Q:J'>0!FBAAOUT  I $D(^FBAA(162.1,J,"RX","AC",2)) S C=0 F K=0:0 S K=$O(^FBAA(162.1,J,"RX","AC",2,K)) D:K'>0!FBAAOUT&(C>0) WRT Q:K'>0  S C=C+1
 G END:FBAAOUT I C'>0 W !!,"No invoices Pending MAS completion.",! G END
RD S DIR(0)="Y",DIR("A")="Want to complete one of them now",DIR("B")="YES" D ^DIR K DIR G:$D(DIRUT)!'Y END
 G ^FBAACIE
END K C,J,K,X,Y,DIC,DIRUT,FBAAOUT,FBMDF,J,S,UL,ULL,Z,ZZ,K,PI Q
WRT I ($Y+2)>IOSL S DIR(0)="E" D ^DIR K DIR S:'Y FBAAOUT=1 Q:FBAAOUT  W @IOF,?5,"Pharmacy Invoices Pending MAS completion",!
 W !,"Invoice No: ",J," has ",C," line items to be completed"
 Q
