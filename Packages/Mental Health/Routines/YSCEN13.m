YSCEN13 ;ALB/ASF,HIOFO/FT - CANCEL DISCHARGE; 8/15/12 9:53am
 ;;5.01;MENTAL HEALTH;**52,60**;Dec 30, 1994;Build 47
 ;
 ;No external references
 ;
SETDICS ;  Called by WARD LOC screen of MH Team file (#618.4)
 S DIC("S")="X ""K Z F  S Z=+$O(^YSG(""""CEN"""",+$G(Z))) Q:'Z  S Z(0)=^(Z,0),Z(1)=U_$G(^YSG(""""CEN"""",Z,""""ROT""""))_U I +DA=+$P(Z(0),U,9)!(Z(1)[(U_+DA_U)) S Z(2)=1"" I '$G(Z(2))"
 Q
