PRCFDCI1 ;WISC@ALTOONA/CTB-APPROVE CHECKED IN INVOICE ;12/2/10  16:10
V ;;5.1;IFCAP;**154**;Oct 20, 2000;Build 5
 ;Per VHA Directive 2004-038, this routine should not be modified.
OUT K PRCFD("LOGIN"),PRCFDX("ED") D OUT^PRCFDE Q
CERT ;CERTIFY ALREADY CHECKED IN DOCUMENT
 S PRCFD("LOGIN")="",PRCFDX("ED")=""
 S PRCF("X")="AS" D ^PRCFSITE Q:'%
 S DIC("A")="Select/Barcode INVOICE TRACKING NUMBER: "
C1 S DIC=421.5,DIC(0)="AEMNZ",DIC("S")="I $D(^(2)),+^(2)=10" D ^DIC K DIC G:Y<0 OUT
 S (PRCF("CIDA"),DA)=+Y K PRCFD("RECERT")
 I $$VIOLATE^PRCFDSOD(PRCF("CIDA"),DUZ) G OUT
 W:$$CLSD1358^PRCFDE2($P(Y(0),U,7),1) !
 S %A="Do you wish to edit any of the basic invoice information"
 S %B="",%=2 D ^PRCFYN G OUT:%<0
 I %=1 D PAT^PRCFDE W !! G:$D(PRCFD("^")) OUT
 I $D(PRCF("CIDA")) D:'$D(PRCFD("RECERT")) DIE^PRCFDCI
 S DIC("A")="Select/Barcode Next INVOICE TRACKING NUMBER: "
 G OUT:$D(PRCFD("^")),C1
VIEW ;VIEW INDIVIDUAL CERTIFIED INVOICE
 S PRCF("X")="AS" D ^PRCFSITE G OUTV:'%
 S DIC=421.5,DIC(0)="AEMNZ" D ^DIC G OUTV:Y<0
 S DA=+Y,%H=$H D YX^%DTC S Y=$P(Y,"@")_"   "_$P($P(Y,"@",2),":",1,2) K %H
 S X="" S:$D(IOM) $P(X,"-",IOM)=""
 W @IOF,!,"INVOICE TRACKING LIST",?43,Y,"    ","PAGE 1",!,X
 K X,DR S DIC="^PRCF(421.5,",DIQ(0)="C",PRCF("VIEW")="" D EN^DIQ K DIQ
 D OUTV G VIEW
OUTV K DIC,DA,DR,PRCF,X,Y Q
CANC ;CANCEL CERTIFIED RECORD
 ;CURRENT STATUS MUST BE LESS THAN TRANSACTION COMPLETE
 S PRCF("X")="AS" D ^PRCFSITE Q:'%
 S DIC=421.5,DIC(0)="AEMN",DIC("S")="I $S('$D(^(2)):1,$P(^(2),U)<20:1,1:0)"
 D ^DIC K DIC I +Y<0 D OUTV Q
 S %A="Are you SURE that you want to cancel this record",%B="",%=2
 D ^PRCFYN I %<0 D OUTV Q
 I %=2 D OUTV G CANC
 S (DA,PRCF("CIDA"))=+Y D WAIT^PRCFYN S X=$S($D(^PRCF(421.5,DA,2))'["0":$P(^(2),"^",6,8),1:"") S:X]"" $P(^(2),"^",6,8)="^^" S $P(^(0),"^",14,15)="0^0"
 I $P(X,"^",3)]"" K ^PRCF(421.5,"AC",$P(X,"^",3),DA)
 S X=25 D STATUS^PRCFDE1
 S %A="Do you wish to cancel another Certified Invoice record",%B="",%=1
 W ! D ^PRCFYN I %'=1 D OUTV Q
 D OUTV G CANC
