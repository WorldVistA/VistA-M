PRCHQM3 ;WISC/KMB-MANUAL PRINT OF RFQ ;7/23/99  15:56
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
VET ;
 U IO W @IOF W "852.219-70 VETERAN-OWNED SMALL BUSINESS (DEC 90)",!!
 W ?5,"The offeror represents that the firm submitting this offer___is ___is"
 W !,"not, a veteran-owned small business, ___is ___is not, a Vietnam era"
 W !,"veteran-owned small business, and ___is ___is not, a disabled veteran-owned"
 W !,"small business.  A veteran-owned small business is defined as a small business, at"
 W !,"least 51 percent of which is owned by a veteran, who also controls and operates"
 W !,"the business.  Control in this context means exercising the power to make"
 W !,"policy decisions.  Operate in this context means actively involved in"
 W !,"day-to-day management.  For the purpose of this definition, eligible veterans"
 W !,"include:",!," (a) A person who served in the U.S. Armed Forces and who was discharged"
 W !,"or released under conditions other than dishonorable."
 W !," (b) Vietnam era veterans who served for a period of more than 180 days, any"
 W !,"part of which was between August 5, 1964 and May 7, 1975, and were discharged"
 W !,"under conditions other than dishonorable."
 W !," (c) Disabled veterans with a minimum of compensable disability of 30 percent,",!,"or a veteran who was discharged for disability.",!!
 W !,"Failure to execute this representation will be deemed a minor informality and the"
 W !,"bidder or offeror shall be permitted to satisfy the requirement prior to award",!,"(see FAR 14.405)",!!!!
 S P=P+1 W !,"Exception to SF-18",?45,"SF-18 ADP (Rev 10-83)",!,"Approved by OIRM____",?30,"Page ",P
 Q
METRIC ;
 W !!,"METRIC PRODUCTS - Products manufactured to metric dimensions will be considered on an"
 W !,"equal basis with those manufactured using inch-pound units, providing they fall "
 W !,"within the tolerances specified using conversion tables contained in the latest revision"
 W !,"of Federal Standard No. 376 and all other requirements of this document are met.",!
 W !,"If a product is manufactured to metric dimensions and those dimensions exceed the"
 W !,"tolerances specified in the inch-pound units, a request should be made to the Contracting"
 W !,"Officer to determine if the product is acceptable.  The Contracting Officer, in concert"
 W !,"with COTR (Contracting Officer's Technical Representative) will accept",!,"or reject the product.",!
 Q
HEADER ;
 W @IOF
 W !,?30,"FORM APPROVED OMB NO. 2900-0445","  PAGE: ",P
 S P=P+1
 Q
FOOTER ;
 F I=1:1:90 W "_"
 W !,?40,"PAGE ",P
 Q
ITEMS ;
 N L1,L2,L3 S DIWL=8,DIWR=34,DIWF="",C1=0
 F I=1:1 K ^UTILITY($J,"W") S C1=$O(^PRC(444,DA,2,LN,2,C1)) Q:C1=""  D ITEM1
ITEM1 Q:C1=""  Q:'$D(^PRC(444,DA,2,LN,2,C1,0))
 S X=^PRC(444,DA,2,LN,2,C1,0) S:I=1 X=$P(^PRC(444,DA,2,LN,2,0),"^")_" "_X D DIWP^PRCUTL($G(DA))
 I '$D(^UTILITY($J,"W",DIWL)) S ^(DIWL)=1,^(DIWL,1,0)="*NO DESCRIPTION*"
 S Z=^UTILITY($J,"W",DIWL) W !
 I Z>1 F J=1:1:(Z-1) W ?7,"|",^UTILITY($J,"W",DIWL,J,0),?35,"|",?42,"|",?49,"|",?62,"|",?75,"|" D:$Y>61 HEADER W !
 I Z>1 W ?7,"|",^UTILITY($J,"W",DIWL,Z,0),?35,"|",?42,"|",?49,"|",?62,"|",?75,"|" D:$Y>61 HEADER W !,?7,"|",?35,"|",?42,"|",?49,"|",?62,"|",?75,"|"
 I Z<2 W ?7,"|",^UTILITY($J,"W",DIWL,1,0),?35,"|",?42,"|",?49,"|",?62,"|",?75,"|" D:$Y>61 HEADER W !,?7,"|",?35,"|",?42,"|",?49,"|",?62,"|",?75,"|"
 QUIT
SVEND ;
 N ID,FILE,VEN,REF,KK,VENMAIN,VEND,VENRFQ,VENRFQ1
 K FLAG
 S ID=$P($G(^PRC(444,DA,5,K,0)),"^") I ID="" S FLAG=1 Q
 I $P($G(^(0)),"^",2)="e" S FLAG=1 Q
 S KK=$P(ID,";"),FILE=$P(ID,";",2),REF="^"_FILE_KK_",0)",VEN=@REF
 S VENPH=$S(FILE[440:$P(VEN,U,10),FILE[444.1:$P(VEN,U,6),1:"")
 I FILE[440 F I=1:1:8 S SRC(I)=$P(VEN,"^",I)
 I FILE[444.1 S SRC(1)=$P(VEN,"^") F I=1:1:7 S SRC(I+1)=$P($G(^PRC(444.1,KK,1)),"^",I)
 S:SRC(7)'="" SRC(7)=$P($G(^DIC(5,SRC(7),0)),"^",2)
 ;
 ;setting up FAX# from file 440 and 444.1
 I FILE[440 S VENMAIN="^"_FILE_KK_",10)" S VEND=$G(@(VENMAIN)) S VENFAX=$P(VEND,"^",6)
 ;
 I FILE[444.1 S VENRFQ="^"_FILE_KK_",0)" S VENRFQ1=@(VENRFQ)
 S:FILE[444.1 VENFAX=$P($G(VENRFQ1),"^",7)
 QUIT
