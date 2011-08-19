LRAPU ;AVAMC/REG - PATH UTILITY ;8/11/95  08:59 ;
 ;;5.2;LAB SERVICE;**72**;Sep 27, 1994
 S (A,B)=0 F  S A=$O(^LRO(68,A)) Q:'A  I $P($G(^LRO(68,A,0)),"^",2)=LRSS,$G(^(3,DUZ(2),0)) S B=B+1,B(B)=A
 I B=0 S Y=-1 Q  ;W $C(7),!!,"There are no accession areas for ",LRSS,!,"Please have responsible person enter one in Accession File (#68)."
 I B=1!($D(LR("M"))) S Y(0)=^LRO(68,B(B),0),X=$P(Y(0),U),Y=B(B)_U_X K A,B Q
 S DIC=68,DIC(0)="AEQMZ",DIC("S")="I $P(^(0),U,2)=LRSS&(+$G(^(3,+DUZ(2),0)))" D ^DIC K DIC S X=$P(Y,U,2) Q
