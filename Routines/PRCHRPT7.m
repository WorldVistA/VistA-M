PRCHRPT7 ;WISC/TKW-CONTINUATION OF PRINT SF18 FORM (QUOTATION) ;1/12/94  11:48 AM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN60 Q:'$D(PRC("SITE"))  W !!! S DIC="^PRC(443,",DIC(0)="AEMQZ",DIC("A")="2237 REFERENCE NUMBER: "
 S DIC("S")="I $P(^(0),U,3)]"""",$D(^PRCS(410,+Y,0)),+^(0)=PRC(""SITE""),$P(^(0),U,2)=""O"",$D(^(7)),$P(^(7),U,6)]"""",$D(^(4)),$P(^(4),U,5)="""""
 D ^DIC K DIC G:Y<0 EXIT^PRCHP18 S PRCHD0=+Y
 K PRCHDT1,PRCHDT2 W !!,"Enter the date by which the quotations are to be returned to your office."
 S %DT="AEF",%DT("A")="RETURN BY (Date):  " D ^%DT K %DT G:Y=-1 EN60 S PRCHDT1=Y
 W !!,"Then enter the date by which the delivery must be received." S %DT="AEF",%DT("A")="DELIVER BY (Date): " D ^%DT K %DT G:Y=-1 EN60 S PRCHDT2=Y
 I PRCHDT2'>PRCHDT1 W $C(7),!!,"** 'Deliver By Date' not greater then 'Return Quotation by Date' **" G EN60
 K ^TMP($J) W !!,"Select the Receiving Address to print in the block labeled 'DESTINATION'"
 N SITE,SUBSITE
 I $D(^PRC(411,"UP",PRC("SITE"))) D
 . I $P($G(^PRCS(410,PRCHD0,0)),U,10)]"" S SUBSITE=$P($G(^(0)),U,10)
 S SITE=$S($D(SUBSITE):SUBSITE,1:PRC("SITE"))
 S DIC="^PRC(411,"_SITE_",1,",DA(1)=SITE,DIC(0)="AEQMZ" D ^DIC G:Y=-1 EN60 S ^TMP($J,"D")=Y(0)
 W !!,"Enter VENDOR(S) to which the request for quotations are to be sent",! D ESEL I '$D(^TMP($J,"V")) G EN60
 W !!! K %ZIS,IOP S %ZIS="Q",IOP="Q",%ZIS("B")="" D ^%ZIS I POP K IOP D EXIT^PRCHP18 G EN60
 S IOP=ION_";"_IOST_";"_IOM_";"_IOSL,PRCHIOP=IOP K IOP
 S X=$O(^PRCD(442.3,"C",79,0)) I X,$D(^PRC(443,PRCHD0,0)) L ^PRC(443,PRCHD0,0):DTIME I $T S DIE="^PRC(443,",DA=PRCHD0,DR="1.5///"_X D ^DIE L  K DIE,DA,DR
 I IO=IO(0) D ^%ZIS U IO D ^PRCHP18 D ^%ZISC D EXIT^PRCHP18 G EN60
 S ZTDTH=$H,ZTRTN="^PRCHP18",ZTDESC="Print Request for Quotations (SF18)"
 K ZTSAVE S ZTSAVE("PRCHD0")="",ZTSAVE("U")="",ZTSAVE("PRCHDT1")="",ZTSAVE("PRCHDT2")="",ZTSAVE("PRC(""SITE"")")="",ZTSAVE("^TMP($J,")="",ZTSAVE("D0")="",ZTSAVE("SITE")=""
 D ^%ZTLOAD,EXIT^PRCHP18
 G EN60
 ;
ESEL S DIC="^PRC(440,",DIC(0)="AEQMZ" D ^DIC Q:Y=-1  S ^TMP($J,"V",+Y)=""
 G ESEL
