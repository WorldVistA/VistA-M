IBJPS ;ALB/MAF,ARH - IBSP IB SITE PARAMETER SCREEN ;22-DEC-1995
 ;;2.0;INTEGRATED BILLING;**39,52,70,115,143,51,137,161,155,320,348,349,377,384,400,432,494,461,516**;21-MAR-94;Build 123
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
EN ; -- main entry point for IBJP IB SITE PARAMETERS, display IB site parameters
 D EN^VALM("IBJP IB SITE PARAMETERS")
 Q
 ;
HDR ; -- header code
 S VALMHDR(1)="Only authorized persons may edit this data."
 Q
 ;
INIT ; -- init variables and list array
 K ^TMP("IBJPS",$J),^TMP("IBJPSAX",$J)
 D BLD^IBJPS1
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K ^TMP("IBJPS",$J),^TMP("IBJPSAX",$J)
 D CLEAR^VALM1
 Q
 ;
NXEDIT ; -- IBJP IB SITE PARAMETER EDIT ACTION (EP): Select data set to edit, do edit
 N VALMY,IBSELN,IBSET
 D EN^VALM2($G(XQORNOD(0)))
 I $D(VALMY) S IBSELN=0 F  S IBSELN=$O(VALMY(IBSELN)) Q:'IBSELN  D
 . S IBSET=$P($G(^TMP("IBJPSAX",$J,IBSELN)),U,1) Q:'IBSET
 . D EDIT(IBSET)
 S VALMBCK="R"
 Q
 ;
EDIT(IBSET) ; edit IB Site Parameters
 D FULL^VALM1
 I IBSET'="" D
 . ; MRD;IB*2.0*516 - Added TRICARE Pay-To Providers.
 . I IBSET=10 D EN^IBJPS3(0) Q
 . I IBSET=11 D EN^IBJPS3(1) Q
 . S DR=$P($T(@IBSET),";;",2,999)
 . Q
 I IBSET=8,$$ICD9SYS^IBACSV(DT)=30 S $P(DR,";",1)=7.05
 ;
 I $G(DR)'="" S DIE="^IBE(350.9,",DA=1 D ^DIE K DA,DR,DIE,DIC,X,Y
 D INIT^IBJPS S VALMBCK="R"
 Q
 ;
1 ;;.09;.13;.14
2 ;;1.2;.15;.11;.12;7.04
3 ;;1.09;1.07;2.07
4 ;;4.04;6.25;6.24
5 ;;.02;1.14;1.25;1.08
6 ;;1.23;1.16;1.22;1.19;1.15;1.17
7 ;;1.33;1.32;1.31;1.27;8.14T;8.15T;8.16T;8.19T
8 ;;1.29;1.3;1.18;1.28
9 ;;1.01;1.02;1.05
12 ;;2.08;2.09
13 ;;11.01
14 ;;10.02;10.03;10.04;10.05;D INIT^IBATFILE
15 ;;2.11;8.01;8.09;8.03;8.06;8.04;8.07;8.02;8.12T;8.11T;8.17T
16 ;;50.01;50.02;50.05;50.06;50.03;50.04;50.07
 ;
