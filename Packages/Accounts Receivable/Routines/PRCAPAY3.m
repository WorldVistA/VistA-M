PRCAPAY3 ;WASH-ISC@ALTOONA,PA/CMS-SETUP PREPAYMENT FROM AUTO POST ROUTINE ;10/26/94  2:38 PM
V ;;4.5;Accounts Receivable;**104,345**;Mar 20, 1995;Build 34
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
EN(ACCT,PAMT,DOP,PER,RN,SITE,SER,ERR,DCDJ) ;
 N DA,DIE,DR,FY,PCAT,PRCAERR,X,Y
 S FY=$$FY^RCFN01(DOP),PCAT=$O(^PRCA(430.2,"AC",33,0))
 I '$G(SITE) S SITE=$$SITE^RCMSITE
 I '$G(SER) S SER=""
 ; Next three lines commented for PRCA*4.5*345 - each charge on it's own bill so don't create zero amount prepay.
 ; S X=$O(^RCD(340,"B",ACCT,0)) S Y=0 F  S Y=$O(^PRCA(430,"AS",X,$O(^PRCA(430.3,"AC",112,0)),Y)) Q:'Y  I $P(^PRCA(430,Y,0),U,2)=PCAT Q
 ; I 'Y S X=SITE_U_SER_U_PCAT_U_ACCT_U_FY_U_0_U_PER_U_DOP D ^PRCASER
 ; I Y<1 S X="IBRFN" X ^%ZOSF("TEST") S ERR=$S('$T:$P(Y,U,2)_" IB Error Code (File 350.8)",1:$$MESS^IBRFN($P($G(Y),U,2))) G Q
 S X=SITE_U_SER_U_PCAT_U_ACCT_U_FY_U_PAMT_U_PER_U_DOP D ^PRCASER
 I Y<1 S X="IBRFN" X ^%ZOSF("TEST") S ERR=$S('$T:$P(Y,U,2)_" IB Error Code (File 350.8)",1:$$MESS^IBRFN($P($G(Y),U,2))) G Q
 I $P(Y,U,3)<1 S ERR="PREPAYMENT INCREASE TRANSACTION NOT SETUP" G Q
 S DA=+$P(Y,U,3),DIE="^PRCA(433,",DR="13////^S X="""_RN_"""" S:$G(DCDJ)]"" DR=DR_";7////^S X="""_DCDJ_"""" D ^DIE
Q Q
