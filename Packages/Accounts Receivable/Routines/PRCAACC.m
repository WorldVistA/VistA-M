PRCAACC ;WASH-ISC@ALTOONA,PA/CMS-AR ACCRUAL TOTALS ; 10/19/10 1:36pm
 ;;4.5;Accounts Receivable;**60,74,90,101,157,203,220,273**;Mar 20, 1995;Build 3
 ;;Per VHA Directive 2004-38, this routine should not be modified.
 NEW PRCAQUE,PRCADEV,PRCA,ZTSK
 S PRCA("MESS")="Do you wish to queue this report" D QUE^PRCAQUE G:'$D(PRCAQUE) Q
 I $D(IO("Q")) S ZTRTN="DQ^PRCAACC",ZTDESC="AR Accrual Totals" D ^%ZTLOAD G Q
DQ ;
 U IO
 NEW BILLN,COM,TOT,STAT,X,Y
 S BILLN=0
 D COM G:$O(COM(""))="" RPT
 F STAT=42,16 F  S BILLN=$O(^PRCA(430,"AC",STAT,BILLN)) Q:'BILLN  I $$ACCK(BILLN) D
 .S X=(","_$P(^PRCA(430,BILLN,0),"^",2)_",")
 .S TOT(X)=$G(TOT(X))+$G(^PRCA(430,BILLN,7))
 .QUIT
RPT D NOW^%DTC W @IOF,!!,?23,"Accrual Totals Report",!?20,"As of: " S Y=% X ^DD("DD") W Y,!
 S X="",$P(X,"=",80)="" W X
 W:$O(COM(""))="" !!,"WARNING: Accruals are *NOT* set-up correctly.",!,"No RX accrual common numbering series are set-up in AR Bill Number File!",!!
 S TOT=$G(TOT(",22,"))+$G(TOT(",23,")) I TOT W !!!,"RX CO-PAYMENT  Accrual Amount: $",$FN(TOT,",",2)
 I $G(TOT(",18,"))>0 W !!!,"C (MEANS TEST)  Accrual Amount: $",$FN(TOT(",18,"),",",2)
 W !!!!,"Includes Common Numbering Series:",! S COM="" F  S COM=$O(COM(COM)) Q:COM=""  W !,COM,?20,COM(COM)
Q D ^%ZISC S IOP=IO(0) D ^%ZIS K IOP,IO("Q") Q
ACCK(BN) ;Check BILLN to see if Accrual
 N ACC,ACTDATE,CAT,FUND,DB
 S CAT=+$P(^PRCA(430,BN,0),"^",2)
 ;  field 12, ACCRUED ? where 0=no 1=yes, 2=could be either
 S ACC=+$P($G(^PRCA(430.2,CAT,0)),"^",9)
 ;  it could be either accrued or non-accrued
 I ACC=2 D
 .   S FUND=$P($G(^PRCA(430,BN,11)),"^",17)
 .   S ACC=$S(FUND=5014:1,FUND=2431:1,1:0)
 .   I $E(FUND,1,4)=5287 S ACC=$$PTACCT(FUND)
 .   ;  special case with Workman's Comp
 .   I ACC=0,CAT=6,FUND="" D
 .   .   S DB=$P($G(^RCD(340,+$P($G(^PRCA(430,BN,0)),U,9),0)),U)
 .   .   I DB[";DPT"!($P($G(^PRCA(430,BN,0)),U,7)'="") S ACC=1
 ;
 ;  public law states that bills in the category ineligible (1),
 ;  emerg/human (2), torts (10), or medicare (21) which are older 
 ;  than oct 1, 1992 should be treated as non-accrued.
 I CAT=1!(CAT=2)!(CAT=10)!(CAT=21) D
 .   S ACTDATE=$P($G(^PRCA(430,BN,6)),"^",21) I 'ACTDATE S ACTDATE=DT
 .   I ACTDATE<2921001 S ACC=0
 .   ;
 .   ;  patch157 changes ineligibles.  an ineligible created before
 .   ;  oct 1, 1992 or after sep 30, 2000 will be non-accrued.
 .   ;  otherwise it will be accrued.
 .   I CAT=1,ACTDATE>3000930 S ACC=0
 ;
 Q ACC
COM ;Find Accrual common numbering series
 S COM=0
 F  S COM=$O(^PRCA(430.4,COM)) Q:'COM  I $P(^PRCA(430.4,COM,0),"^",6) S COM($P(^PRCA(430.4,COM,0),"^"))=$P($G(^DIC(49,$P(^(0),"^",5),0)),"^",1)
 Q
PTACCT(FUND) ;Determines whether Point Accounts are accrued
 ;returns 1 for accrued funds 528701,528702,528703,528704,528709,528711
 ;returns 0 for any other fund
 I FUND'[5287 Q 0
 S X=$E(FUND,5,6),X=$S(X="09"!(X="11"):1,X<"05":1,1:0)
 Q X
ADDPTEDT() ;Effective date of additional point accounts 
 ;       (528705 - 528708 and 528710)
 ;Effective date of switch from 4032 to 528709
 Q 3040928
