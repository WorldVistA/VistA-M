PRCHQ11 ;(WASH IRMFO)/LKG-RFQ QUOTE VENDOR INQUIRY ;9/19/96  13:35
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
EN ;Entry for Quote's Vendor Inquiry
 S DIC=444,DIC(0)="AEMQ",DIC("A")="Select RFQ: " D ^DIC K DIC
 G:+Y<1 EX
 S PRCDA=+Y
 I $P($G(^PRC(444,PRCDA,8,0)),U,4)'>0 W !,"  No Quotes on File!" G EN
VLKUP ;Loop for selecting vendor
 K DA S DA(1)=PRCDA,DIR(0)="PAO^PRC(444,DA(1),8,:AEMQ"
 S DIR("A")="Select Quote Vendor: ",DIR("?",1)="Enter the Name of the Vendor or"
 S DIR("?")="  enter 'DUN' plus the vendor's Dun & Bradstreet Number."
 D ^DIR K DIR I +Y<1 G EX:$D(DIROUT)!$D(DTOUT)!$D(DUOUT),EN
 S PRCVEN=$P(Y,U,2),PRCX=$S(PRCVEN["PRC(440,":$P($G(^PRC(440,$P(PRCVEN,";"),0)),U),1:$P($G(^PRC(444.1,$P(PRCVEN,";"),0)),U))
 G:PRCX="" VLKUP
 S DIC="^"_$P(PRCVEN,";",2),L=0,FLDS="[CAPTIONED]",BY=".01"
 S FR=$TR(PRCX,","," "),TO=$TR(PRCX,",","-"),DIS(0)="I $P(PRCVEN,"";"")=D0"
 D EN1^DIP K DIC,FLDS,BY,FR,TO,DHD,L,DIS
 G VLKUP
EX K DA,PRCDA,X,Y,DTOUT,DUOUT,DIRUT,DIROUT,PRCVEN,PRCX
 Q
PRTMSG ;Entry point for Printing 864 Text Messages for RFQ
 S DIC=444,DIC(0)="AEMQ",DIC("A")="Select RFQ: " D ^DIC K DIC
 G:+Y<1 EX2
 S PRCDA=+Y,PRCRFQ=$P(Y,U,2)
 S DIC=444,L=0,BY="[PRCHQ RFQ MESSAGE SORT]",FLDS="[PRCHQ RFQ MESSAGES 2]"
 S (FR,TO)=PRCRFQ_",?",DHD="TEXT MESSAGES FOR RFQ #: "_PRCRFQ D EN1^DIP
 K DIC,FLDS,BY,FR,TO,DHD,L
 G PRTMSG
EX2 K DTOUT,DUOUT,Y,PRCDA,PRCRFQ
 Q
PRTRFQ ;Entry point for Viewing RFQ request portion
 K DIC S DIC=444,DIC(0)="AEMQ",DIC("A")="Select RFQ: " D ^DIC K DIC
 G:+Y<1 EX3
 S PRCRFQ=$P(Y,U,2)
 S DIC=444,BY=.01,FLDS="[PRCHQ RFQ FULL]",L=0,(FR,TO)=PRCRFQ,DHD="@"
 D EN1^DIP K BY,DIC,DHD,FLDS,FR,L,TO
 G PRTRFQ
EX3 K DTOUT,DUOUT,PRCRFQ,Y
 Q
