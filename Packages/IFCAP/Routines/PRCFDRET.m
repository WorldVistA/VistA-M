PRCFDRET ;WISC@ALTOONA/CTB-RETURN INVOICE FROM ACCOUNTING TO VOUCHER AUDIT ;2/5/93  3:18 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 I '$D(PRC("SITE")) S PRCF("X")="AS" D ^PRCFSITE Q:'%
 S DIC("S")="I $D(^(2)),$P(^(2),U)=15",DIC=421.5,DIC(0)="AEMNZQ" D ^DIC K DIC Q:Y<0
 S PRCF("CIDA")=+Y,%A="Are you sure you want to return this Invoice to Voucher Audit",%B="",%=2 D ^PRCFYN I %'=1 S X="  <No Action Taken>*" D MSG^PRCFQ G OUT
 S X=0 D STATUS^PRCFDE1
 S %A="Return another Invoice",%B="",%=2 I %=1 G V
OUT K PRCF Q
