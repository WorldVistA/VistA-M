PRCHQM4 ;WISC/KMB-MANUAL PRINT RFQ REPRESENTATION 3/26/96 ; 2/27/01 2:47pm
 ;;5.1;IFCAP;**9**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
REP ;
 U IO W @IOF W ?10,"REPRESENTATIONS, CERTIFICATIONS, AND PROVISIONS",!!
 N RP1,RP2,RP3,RP4 S (RP1,RP2,RP3,RP4)="_"
 W !,"The following representation applies when the contract is to be performed inside"
 W !,"the United States, its territories or possessions, the Trust Territory"
 W !,"of the Pacific Islands, or the District of Columbia.",!!
 ;
 ;New clause # 52.219-1. As of 10/25/2000. Call routine PRCHP184.
 ;
 D EN01^PRCHP184
 ;
 ;Replacing Provision 52.219-4 with 52.219-6
 W "52.219-6 Notice of Total Small Business Set-Aside.  (JUL 1996)",!!
 W ?4,"As prescribed in 19.508(c), insert the following clause:",!!
 W "NOTICE OF TOTAL SMALL BUSINESS SET-ASIDE   (JUL 1996)",!
 W "(a)  Definition.",!
 W ?5,"Small business concern, as used in this clause, means a concern,",!
 W ?5,"including its affiliates, that is independently owned and operated,",!
 W ?5,"not dominant in the field of operation in which it is bidding on",!
 W ?5,"Government contracts, and qualified as a small business under the",!
 W ?5,"size standards in this solicitation",!
 W "(b)  General.",!
 W ?5,"(1) Offers are solicited only from small business concerns.",!
 W ?9,"Offers received from concerns that are not small business",!
 W ?9,"concerns shall be considered non-responsive and will be rejected.",!
 W ?5,"(2) Any award resulting from this solicitation will be made",!
 W ?10,"to a small business concern.",!
 W "(c)  Agreement.",!
 W ?5,"A small business concern submitting an offer in its own name agrees to",!
 W ?5,"furnish, in performing the contract, only end items manufactured or",!
 W ?5,"produced by small business concerns in the United States.  The term",!
 W ?5,"United States includes its territories and possessions, the Commonwealth",!
 W ?5,"of Puerto Rico, the trust territory of the Pacific Islands, and the",!
 W ?5,"District of Columbia.  If this procurement is processed under simplified",!
 W ?5,"acquisition procedures and the total amount of this contract does not",!
 W ?5,"exceed $25,000 a small business concern may furnish the product of",!
 W ?5,"any domestic firm.  This paragraph does not apply in connection with",!
 W ?5,"construction or service contracts.",!
 W ?30,"(End of clause)",!
 W !!,?30,"PAGE ",P
 Q
ADMCERT(PRCDA,PRCP) ;Print Administrative Certifications
 N PRCI,DIWL,DIWR,DIWF,X,PRCC,PRCT
 Q:$P($G(^PRC(444,PRCDA,4,0)),U,4)'>0
 K ^UTILITY($J,"W") S PRCI=0,DIWL=1,DIWR=70,DIWF=""
 F  S PRCI=$O(^PRC(444,PRCDA,4,PRCI)) Q:+PRCI'=PRCI  D
 . S X=$G(^PRC(444,PRCDA,4,PRCI,0)) Q:X=""
 . I X="~" S X=" "
 . D ^DIWP
 S PRCC=0,PRCT=$G(^UTILITY($J,"W",1))+0,X="" D HDR
 F PRCI=1:1:PRCT D  Q:X["^"
 . I PRCC+5'<IOSL S PRCP=PRCP+1 W !!!,?30,"PAGE ",PRCP D HDR Q:X["^"
 . W !?5,^UTILITY($J,"W",1,PRCI,0) S PRCC=PRCC+1
 I X'["^" S PRCP=PRCP+1 W !!?30,"PAGE ",PRCP R:$E(IOST,1,2)="C-" !,"Hit <Return> to Continue ",X:DTIME
 K ^UTILITY($J,"W")
 Q
HDR ;Header for Administrative Certifications
 I PRCC>0,$E(IOST,1,2)="C-" R !,"Hit <Return> to Continue ",X:DTIME Q:X["^"
 W @IOF,!?26,"ADMINISTATIVE CERTIFICATIONS" W:PRCC>0 "  (Continued)"
 W !! S PRCC=3
 Q
