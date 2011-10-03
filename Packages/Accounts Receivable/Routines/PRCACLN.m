PRCACLN ;ALB/MAF; CLEAN UP OF EXTRANEOUS PRCA PACKAGE FILE ENTRIES; 12 MAY 1997
 ;;4.5;Accounts Receivable;**81**;Mar 20, 1995
 ;Check to see if there is a package labeled ACCOUNTS RECEIVABLE and 
 ;to make sure there is not more than one package with the name of
 ;ACCOUNTS RECEIVABLE.  If so the install will abort.
 ;This is the Environment Check routine portion of the code.
 N PRCAPKG,PRCANME,PRCAID,IBQUIT,PRCANODE
 F PRCAID=0:0 S PRCAID=$O(^DIC(9.4,"B","ACCOUNTS RECEIVABLE",PRCAID)) Q:PRCAID']""!($D(IBQUIT))  S PRCAPKG=PRCAID,PRCANODE=$G(^DIC(9.4,PRCAID,0)) I $O(^DIC(9.4,"B","ACCOUNTS RECEIVABLE",PRCAID)) D  I IBQUIT Q
 .W !,"*** There is more than one ACCOUNTS RECEIVABLE entry in the package file"
 .W !,"     Please check your Package file and find the correct entry"
 .W !,"     and rename the other(s).",!
 .W !,"*** Once this has been done, re-install pacman using INSTALL/CHECK MESSAGE"
 .W !,"     and install the patch.",!
 .S (XPDQUIT,IBQUIT)=1
 .Q
 I $G(XPDQUIT) Q
 I '$D(PRCAPKG) D  Q
 .W !,"*** There are no ACCOUNTS RECEIVABLE entries in the Package file"
 .W !,"     Please check your Package File to make sure you have an"
 .W !,"     entry named ACCOUNTS RECEIVABLE.",!
 .W !,"*** Once this has been done, re-install pacman using INSTALL/CHECK MESSAGE"
 .W !,"     and install the patch.",!
 .S XPDQUIT=1
 .Q
 I '$G(XPDQUIT) W !!,"Environment Check is OK!"
 Q
EN ;Check the "C" cross ref for more than one ocurrence of the PRCA
 ;prefix.  If only one nothing gets cleaned up.
 ;This is the cleanup routine portion of the code.
 N PRCAIFN,PRCAFL1,PRCAFL2,PRCAFL3,PRCABLK,PRCABLK1,PRCABLK2,PRCABLK3,PRCANODE,IBQUIT
 S $P(PRCABLK," ",15)="",$P(PRCABLK1," ",21)="",$P(PRCABLK2," ",5)=""
 N PRCANME,PRCAID
 F PRCAIFN=0:0 S PRCAIFN=$O(^DIC(9.4,"C","PRCA",PRCAIFN)) Q:PRCAIFN']""  D:'$D(PRCAFL1) MES Q:$D(PRCAFL2)  D
 .I $P($G(^DIC(9.4,PRCAIFN,0)),"^",1)'="ACCOUNTS RECEIVABLE" D
 ..S DIE="^DIC(9.4,",DR="1////"_"PRCZ",DA=PRCAIFN D ^DIE K DIE,DR,DA
 .I '$D(PRCAFL3) D MES^XPDUTL("The prefix has been changed for the following entries in the Package File: ") D MES^XPDUTL("File IEN"_PRCABLK2_"Old Prefix"_PRCABLK_"New Prefix"_PRCABLK_"Package Name") S PRCAFL3=1
 .S X=13-$L(PRCAIFN),$P(PRCABLK3," ",X)="" D MES^XPDUTL(PRCAIFN_PRCABLK3_"PRCA"_PRCABLK1_$P($G(^DIC(9.4,PRCAIFN,0)),"^",2)_PRCABLK1_$P($G(^DIC(9.4,PRCAIFN,0)),"^",1))
 .Q
 Q
MES S PRCAFL1=1 I $O(^DIC(9.4,"C","PRCA",PRCAIFN))']"" D MES^XPDUTL("*** Only one PRCA entry in Package file... no 'C' x-reference cleanup occurred!!") S PRCAFL2=1 Q  ;Only one PRCA prefix--no cleanup
 Q
