RCY220PT ;ALB/ARH/MAF - POST INIT FILES 347.3 & 430.2 - POST INIT ; 5/1/97
 ;;4.5;Accounts Receivable;**220**;Mar 20, 1995
 ;
 D EN,EN1
 Q
EN ; Add new Revenue Source Codes to file 347.3
 D BMES^XPDUTL("Updating file 347.3 REVENUE SOURCE CODE with new codes...")
 D MES^XPDUTL("   ")
 N DLAYGO,DIC,DIE,DD,DO,DA,DR,X,Y,RCA,RCFL,RCI,RCLN,RCCNT,RCFN,RCINACT S RCCNT=0
 ;
 F RCI=1:1 S RCLN=$P($T(RSC+RCI),";;",2) Q:RCLN="END"  D
 . ;
 . I $D(^RC(347.3,"B",$P(RCLN,U,1))) S RCFL=0 D SET Q
 . ;
 . S RCCNT=RCCNT+1,RCINACT=" "
 . S ^RC(347.3,$P(RCLN,U,1),0)=RCLN
 . S ^RC(347.3,"B",$P(RCLN,U,1),$P(RCLN,U,1))=""
 . S ^RC(347.3,"C",$E($P(RCLN,U,2),1,30),$P(RCLN,U,1))=""
 . S RCFL=1 D SET
 D BMES^XPDUTL("      *  "_RCCNT_" Revenue Source Codes #347.3 added")
 D BSQ
 Q
EN1 ; Add new categories to the ACCOUNTS RECEIVABLE CATEGORY file 430.2
 D BMES^XPDUTL("Updating file 430.2 ACCOUNTS RECEIVABLE CATEGORY with new categories...")
 D MES^XPDUTL("   ")
 N DLAYGO,DIC,DIE,DD,DO,DA,DR,X,Y,RCA,RCFL,RCI,RCLN,RCCNT,RCFN,RCINACT S RCCNT=0
 ;
 F RCI=1:1 S RCLN=$P($T(CAT+RCI),";;",2) Q:RCLN="END"  D
 . ;
 . I $D(^PRCA(430.2,"B",$P(RCLN,U,1))) S RCFL=0 D SET Q
 . ;
 . K DD,DO S DLAYGO=430.2,DIC="^PRCA(430.2,",DIC(0)="L",X=$P(RCLN,U,1) D FILE^DICN K DIC I Y<1 K X,Y Q
 . S RCFN=+Y,RCCNT=RCCNT+1,RCINACT=" "
 . ;
 . S DR="1////"_$P(RCLN,U,2)_";2////"_$P(RCLN,U,3)_";3////"_$P(RCLN,U,4)_";5////"_$P(RCLN,U,6)_";6////"_$P(RCLN,U,7)_";7////"_$P(RCLN,U,8)_";12////"_$P(RCLN,U,9)_";9////"_$P(RCLN,U,10)_";10////"_$P(RCLN,U,11)
 . S DR=DR_";11////"_$P(RCLN,U,12)_";13////"_$P(RCLN,U,13)
 . S DIE="^PRCA(430.2,",DA=+RCFN D ^DIE K DIE,DA,DR,X,Y
 . S RCFL=1 D SET
 . Q
 D BMES^XPDUTL("      *  "_RCCNT_" Accounts Receivable Category #430.2 added")
 ;
BSQ ;
 ;S RCA(1)="      *  "_RCCNT_" Revenue Source Codes (#347.3)"
 D BMES^XPDUTL(.RCA)
 Q
 ;
 ;
SET ; SET RCA() FOR DISPLAY 
 S RCA(RCI)="  "_$P(RCLN,U,1)_"    "_$P(RCLN,U,2)_"    "_$S(RCFL=1:"*** Code Added ***",1:"*** Duplicate ***")
 Q
 ;
 ;
RSC ; Revenue Source Code (347.3)   CODE^CODE NAME^INACTIVE
 ;;1010^Interest Revenue
 ;;8038^Economic Act-All Other
 ;;8083^Enhanced Use Lease
 ;;9041^Spec Donations
 ;;9042^Spec Donations
 ;;9045^General Donations
 ;;9046^General Donations
 ;;9057^Rental
 ;;END
 Q
CAT ;New Categories to be entered into file 430.2
 ;;NURSING HOME PROCEEDS^NH^0^1228^^O^5^2^0^1^1^1^2
 ;;PARKING FEES^PF^0^1228^^O^6^2^0^1^1^1^2
 ;;CWT PROCEEDS^CW^0^1228^^O^7^2^0^1^1^1^2
 ;;COMP & PEN PROCEEDS^CM^0^1228^^O^8^2^0^1^1^1^2
 ;;ENHANCED USE LEASE PROCEEDS^EP^0^1228^^O^10^2^0^1^1^1^2
 ;;END
