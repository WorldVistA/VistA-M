IBJPS ;ALB/MAF,ARH - IBSP IB SITE PARAMETER SCREEN ;22-DEC-1995
 ;;2.0;INTEGRATED BILLING;**39,52,70,115,143,51,137,161,155,320,348,349,377,384,400,432,494,461,516,547,592,608,623**;21-MAR-94;Build 70
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
 N DR
 I IBSET'="" D
 . ; MRD;IB*2.0*516 - Added TRICARE Pay-To Providers.
 . ; WCJ;IB*2.0*547 - shifted the numbers down to insert a new one
 . I IBSET=8 D EN^IBJPS5 Q
 . I IBSET=11 D EN^IBJPS3(0) Q
 . I IBSET=12 D EN^IBJPS3(1) Q
 . ;WCJ;IB*2.0*547 added default Administrative contractors for billing (medicare and commercial)
 . I IBSET=17 D EN^IBJPS6(1) Q   ; medicare
 . I IBSET=18 D EN^IBJPS6(2) Q   ; commercial
 . I IBSET=21 D EN^IBJPS8 Q   ; WCJ;IB*2.0*608;US3;
 . S DR=$P($T(@IBSET),";;",2,999)
 . Q
 ; WCJ;IB*2.0*547 - shifted the number down to insert a new one
 I IBSET=9,$$ICD9SYS^IBACSV(DT)=30 S $P(DR,";",1)=7.05
 ;
 I $G(DR)'="" S DIE="^IBE(350.9,",DA=1 D ^DIE K DA,DR,DIE,DIC,X,Y
 ;JWS;IB*2.0*623;If 837 FHIR transaction is turned off, then reset 364 field .09 AC index
 I '$$GET1^DIQ(350.9,"1,",8.21,"I") D
 . S DA=""
 . F  S DA=$O(^IBA(364,"AC",1,DA)) Q:DA=""  D
 .. S DR=".09////0",DIE="^IBA(364," D ^DIE
 .. Q
 . K DA,DR,DIE,DIC,X
 . Q
 ;JWS;IB*2.0*623;end
 D INIT^IBJPS S VALMBCK="R"
 Q
 ;
 ;WCJ;IB*2.0*547 - cleared the spot for the new #8, added 17 & 18, move 16 to 19.
 ;gef;IB*2.0*547 - added 20
 ;JWS;IB*2.0*592 - added field 8.2 to 16
 ;JWS;IB*2.0*623 - added field 8.21 to 16
1 ;;.09;.13;.14
2 ;;1.2;.15;.11;.12;7.04
3 ;;1.09;1.07;2.07
4 ;;4.04;6.25;6.24
5 ;;.02;1.14;1.25;1.08
6 ;;1.23;1.16;1.22;1.19;1.15;1.17
7 ;;1.33;1.32;1.31;1.27;8.14T;8.15T;8.16T;8.19T
9 ;;1.29;1.3;1.18;1.28
10 ;;1.01;1.02;1.05
13 ;;2.08;2.09
14 ;;11.01
15 ;;10.02;10.03;10.04;10.05;D INIT^IBATFILE
16 ;;2.11;8.01;8.09;8.03;8.06;8.04;8.07;8.02;8.12T;8.11T;8.17T;8.2T;8.21T
19 ;;50.01;50.02;50.05;50.06;50.03;50.04;50.07
20 ;;52.01;52.02
 ;
