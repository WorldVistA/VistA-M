PRSAOTS ; HISC/REL-Display OT/CT Requests ;8/16/95  14:28
 ;;4.0;PAID;**34,114**;Sep 21, 1995;Build 6
 ;;Per VHA Directive 2004-038, this routine should not be modified.
DISP ; Display all requests
 S OTS=";"_$P(^DD(458.2,10,0),"^",3),CNT=0 K:NUM R
 F DTI=DTI-.1:0 S DTI=$O(^PRST(458.2,"AD",DFN,DTI)) Q:DTI=""  F DA=0:0 S DA=$O(^PRST(458.2,"AD",DFN,DTI,DA)) Q:DA=""  D LST
 W:'CNT !!,"No Requests on File." Q
LST ; Display Request
 S Z=$G(^PRST(458.2,DA,0)) Q:Z=""  S SCOM=$P($G(^(1)),"^",1) I NUM,$P(Z,"^",8)'="R" Q:"DX"[$P(Z,"^",8)  D  Q:Z=""
 .S X=$P(Z,"^",3),X=$G(^PRST(458,"AD",+X))
 .S Y=$G(^PRST(458,+$P(X,"^",1),"E",DFN,"D",+$P(X,"^",2),2))
 .Q:Y'[$P(Z,"^",5)  S Z="" Q
 S CNT=CNT+1 W !! I NUM W $J(CNT,2)," " S R(CNT)=DA
 S X=$P(Z,"^",3) D DTP^PRSAPPU W Y," ",$P(Z,"^",6)," Hrs. ",$S($P(Z,"^",5)="CT":"COMP TIME/CREDIT HRS",1:"OVERTIME")
 I $P(Z,"^",5)="OT",$P(Z,"^",10) W " ($",$J($P(Z,"^",10),0,2),")"
 S X=$P(Z,"^",9) I X'="" W " on T&L ",X
 S X=$P(Z,"^",8),%=$F(OTS,";"_X_":") I %>0 W " ",$P($E(OTS,%,999),";",1)
 S Y=$P(Z,"^",7) W:Y'="" !?10,Y W:SCOM'="" !?10,"Supr: ",SCOM Q
HDR ; Display Header
 W:$E(IOST,1,2)="C-" @IOF W !?26,"VA TIME & ATTENDANCE SYSTEM",!?19,"OVERTIME & COMP TIME/CREDIT HRS REQUESTS"
 S X=$G(^PRSPC(DFN,0)) W !!,$P(X,"^",1) S X=$P(X,"^",9) I X W ?50,$E(X),"XX-XX-",$E(X,6,9) Q
