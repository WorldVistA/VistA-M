PRCFDA3 ;WISC/CTB-REPROCESS INVOICES WHICH ERRORED IN FMS/CAPPS ;9/26/95  13:02
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
EN(DA) S PRCF("X")="S" D ^PRCFSITE Q:'%
 ;D DUZ^PRCFSITE Q:'%
 I $G(PRCFA("ERROR"))'=1,'$G(PRCFA("TRANS")) D
 . S X="  Cannot find an error indicator for this invoice !*"
 . D MSG^PRCFQ
 . Q
 ;S DIC=421.5,DIC(0)="AEMN",DIC("S")="I $D(^(2)),$P(^(2),U)=20"
 ;D ^DIC K DIC Q:Y<0
 S PRCF("CIDA")=+DA Q:'DA
 S STATUS=$P(^PRCF(421.5,DA,2),"^")
 S %A="Does this invoice need to be processed by Voucher Audit",%B="",%=2
 D ^PRCFYN G:%<0 ENX
 I %=1 S %A="ARE YOU SURE",%B="",%=1 D ^PRCFYN S X=$S(%=1:10,$L(STATUS):STATUS,1:0) D STATUS^PRCFDE1,PAUSE^PRCFDPVU G ENX
 S %A="Do you wish to process this invoice at this time",%B="",%=1
 D ^PRCFYN
 I %'=1 S X="  <No Further Action Taken>*" D MSG^PRCFQ G ENX
 S X=15 D STATUS^PRCFDE1
 W ! S X="Switching to 'Process Invoice in Accounting' Module.*" D MSG^PRCFQ
 K PRCF("VIEW")
 S Y=DA,PRCFA("ERROR PROCESSING")="" D EN^PRCFDA K PRCFA("ERROR PROCESSING")
 W ! S X="Returning to 'Process FMS/CAPPS Error Message' Module.*" D MSG^PRCFQ
ENX L:$D(PRCF("CIDA")) -^PRCF(421.5,PRCF("CIDA"))
 K PRCF("CIDA"),STATUS,X,Y,%,%A,%B
 Q
 S %A="Do you need to process another FMS/CAPPS error",%B="",%=1
 D ^PRCFYN Q:%'=1
 G V:'$G(PRC("SITE")),EN
OUT K DA Q
