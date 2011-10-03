PRSAEDS ; HISC/REL-Display Envir. Diff. Request ;6/10/93  14:33
 ;;4.0;PAID;**114**;Sep 21, 1995;Build 6
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
DISP ; Display Envir. Diff. Requests
 S EDS=";"_$P(^DD(458.3,8,0),"^",3),CNT=0 K:NUM R
 F DTI=0:0 S DTI=$O(^PRST(458.3,"AD",DFN,DTI)) Q:DTI=""!(DTI>EDT)  F DA=0:0 S DA=$O(^PRST(458.3,"AD",DFN,DTI,DA)) Q:DA=""  D LST
 W:'CNT !,"No Requests on File." Q
LST ; Display Request
 S Z=$G(^PRST(458.3,DA,0)) Q:Z=""  S SCOM=$P($G(^(1)),"^",1) I NUM,$P(Z,"^",9)'="R" Q
 S CNT=CNT+1 W ! I NUM W $J(CNT,2)," " S R(CNT)=DA
 S X=$P(Z,"^",3) D DTP^PRSAPPU W Y," ",$P(Z,"^",4),"-",$P(Z,"^",6)," (Meal: ",+$P(Z,"^",5),") "
 S X=$P(Z,"^",7)
 W $P($G(^PRST(457.6,+X,0)),"^",1)," Envir. Diff. "
 S X=$P(Z,"^",9)
 S %=$F(EDS,";"_X_":") I %>0 W $P($E(EDS,%,999),";",1)
 S X=$P(Z,"^",8) W:X'="" !?5,X W:SCOM'="" !?5,"Supr: ",SCOM Q
HDR ; Display Header
 W:$E(IOST,1,2)="C-" @IOF W !?26,"VA TIME & ATTENDANCE SYSTEM",!?22,"ENVIRONMENTAL DIFFERENTIAL REQUESTS"
 S X=$G(^PRSPC(DFN,0)) W !!,$P(X,"^",1) S X=$P(X,"^",9) I X W ?67,$E(X),"XX-XX-",$E(X,6,9) Q
