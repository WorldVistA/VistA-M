DVBCCNC1 ;ALB ISC/THM-CANCEL ENTIRE REQUEST ; 9/22/91  4:14 PM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
ALL K NONE W ! S ALLCANC=1,DIC="^DVB(396.5,",DIC(0)="AEQM",DIC("A")="Enter REASON FOR CANCELLATION: " D ^DIC G:X=""!(X=U)!(+Y'>0) EXIT^DVBCCNCL S REAS=+Y
 ;
BY W !,"Cancelled by (M)AS or (R)O?  M//  "
 R BY:DTIME
 G:'$T!(BY=U) EXIT^DVBCCNCL
 I BY=""!(BY="m") W:BY="" "M" S BY="M" ;echo selection
 S:BY="r" BY="R"
 I BY'?1"M"&(BY'?1"R") W !!,"Enter M to indicate cancellation by MAS or",!," R to indicate cancellation by the Regional Office.",!! G BY
 W $S(BY="M":"AS",BY="R":"O",1:"") ;finish echo of selection
 ;
BY1 W *7,!!,"Cancelled by ",$S(BY="":"MAS",BY="M":"MAS",BY="R":"RO",1:"Unknown source")," Ok" S %=2 D YN^DICN G:$D(DTOUT)!(%<0) EXIT^DVBCCNCL
 I $D(%Y),%Y["?" W !!,"Enter Y to verify or N to reselect",! G BY1
 I $D(%),%'=1 G BY
 S BY=$S(BY="R":"RX",BY="M":"X",1:"")
 W !!
 F JJZ=0:0 S JJZ=$O(^DVB(396.4,"C",DA(1),JJZ)) Q:JJZ=""  S STAT=$P(^DVB(396.4,JJZ,0),U,4) I STAT="O" D ALL1
 I '$D(CANC) S CANC("None - (Request only)")=BY_U_REAS ;used in case of request logging error (system)
 H 1 S DA=DA(1),(DIC,DIE)="^DVB(396.3,",DR="17////"_BY_";19///NOW;20////^S X=DUZ" D ^DIE,NOTIFY,BULL I $D(OUT) G EXIT^DVBCCNCL
 G LOOK^DVBCCNCL
 ;
ALL1 S EXMPTR=$P(^DVB(396.4,JJZ,0),U,3),EXMNM=$S($D(^DVB(396.6,+EXMPTR,0)):$P(^(0),U,1),1:"Unknown exam"_" ("_+EXMPTR_")") K EXMPTR ;show deleted exam
 S DR=".04////"_BY_";52////"_REAS_";51////^S X=DUZ;50///NOW",DA=JJZ
 S (DIC,DIE)="^DVB(396.4," D ^DIE
 I '$D(Y) W:$X>50 ! W:$L(EXMNM)>25&($X>45) ! W EXMNM," cancelled, " S CANC(EXMNM)=BY_U_REAS
 I $D(Y) W *7,!,"Cancellation error on ",EXMNM," exam !" H 2
 Q
 ;
NOTIFY S X=$P(^DVB(396.3,DA,0),U,18) I X="RX"!(X="X") W !!,"Entire exam is now CANCELLED.",!! H 1 Q
 I X'="RX"&(X'="X") W *7,!!,"Cancellation error !",!! H 3 S OUT=1
 Q
 ;
BULL Q:'$D(CANC)  S SEND=1,EXAM="" F JI=0:0 S EXAM=$O(CANC(EXAM)) Q:EXAM=""  I $P(CANC(EXAM),U,1)'="X"&($P(CANC(EXAM),U,1)'="RX") S SEND=0 Q
 I SEND=0 W *7,!!,"An error has occurred during cancellation - bulletin will not be sent!",!!,*7 H 3 Q
 K OWNDOM,XDOM,DOMAIN,DOMNUM
 I $D(ALLCANC) S OWNDOM=$P(^DVB(396.3,DA(1),0),U,22) I OWNDOM]"" S XDOM=$S($D(^DIC(4.2,OWNDOM,0)):^(0),1:"") S DOMAIN=$P(XDOM,U,1),DOMNUM=$S(+$P(XDOM,U,3)>0:+$P(XDOM,U,3),1:OWNDOM)
 I $D(ALLCANC),OWNDOM]"" I +DOMNUM>0 S XMY("G.DVBA C 2507 CANCELLATION@"_DOMAIN)=DOMNUM W !!,*7,"I am sending a copy of this cancellation to the",!,"cancellation mail group at "_DOMAIN,!,"since this was transferred in.",!! H 2
 I SEND=1 S REQDA=DA(1) D ^DVBCBULL I $D(ALLCANC),OWNDOM]"",+DOMNUM>0 S REQDA=DA(1) D EN1^DVBCXFRE
 K ALLCANC,CANC,SEND,OWNDOM,DOMNUM
 Q
