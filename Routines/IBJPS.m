IBJPS ;ALB/MAF,ARH - IBSP IB SITE PARAMETER SCREEN ;22-DEC-1995
 ;;2.0;INTEGRATED BILLING;**39,52,70,115,143,51,137,161,155,320,348,349,377,384,400**;21-MAR-94;Build 52
 ;;Per VHA Directive 2004-038, this routine should not be modified.
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
 I IBSET'="" D:IBSET=10 EN^IBJPS3 S:IBSET'=10 DR=$P($T(@IBSET),";;",2,999)
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
7 ;;1.33;1.32;1.31;1.27
8 ;;1.29;1.3;1.18;1.28
9 ;;1.01;1.02;1.05
11 ;;2.08;2.09
12 ;;11.01;11.02;12
13 ;;10.02;10.03;10.04;10.05;D INIT^IBATFILE
14 ;;2.11;8.01;8.09;8.03;8.06;8.04;8.07;8.02;8.12T;8.11T
15 ;;50.01;50.02;50.05;50.06;50.03;50.04;50.07
 ;
