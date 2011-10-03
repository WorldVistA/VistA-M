PSBOIV1 ;BIRMINGHAM/TEJ-IV BAG STATUS REPORT ;Mar 2004
 ;;3.0;BAR CODE MED ADMIN;**32**;Mar 2004;Build 32
 ;Per VHA Directive 2004-038 (or future revisions regarding same), this routine should not be modified.
 ;
FORMDAT(FLD) ;
 K PSBVAL
 S PSBVAL=PSBDATA(FLD)
 D WRAPPER(@("PSBTAB"_(FLD-1))+1,((@("PSBTAB"_(FLD))-(@("PSBTAB"_(FLD-1))+1))),PSBVAL)
 Q
WRAPPER(X,Y,Z) ;  Text WRAP
 N PSB
 I ($L(Z)>0),$F(Z,"""")>1 F  Q:$F(Z,"""")'>1  S Z=$TR(Z,"""","^")
 F  Q:'$L(Z)  D
 .I $L(Z)<Y S $E(PSBRPLN(J),X)=Z S Z="" D  Q
 ..I $L(PSBRPLN(J),"^")>1 F INX=1:1:$L(PSBRPLN(J),"^")-1 S $P(PSBRPLN(J),"^",INX)=$P(PSBRPLN(J),"^",INX)_""""
 ..S PSBRPLN(J)=$TR(PSBRPLN(J),"^","""")
 ..S J(J)="",J=J+1
 .F PSB=Y:-1:0 Q:$E(Z,PSB)=" "
 .S:PSB<1 PSB=Y
 .S $E(PSBRPLN(J),X)=$E(Z,1,PSB)
 .S Z=$E(Z,PSB+1,250)
 .I $L(PSBRPLN(J),"^")>1 F INX=1:1:$L(PSBRPLN(J),"^")-1 S $P(PSBRPLN(J),"^",INX)=$P(PSBRPLN(J),"^",INX)_""""
 .S PSBRPLN(J)=$TR(PSBRPLN(J),"^","""")
 .S J(J)="",J=J+1
 Q 0
FMTDT(Y) ;
 N X S X=$E(Y,4,5) X ^DD("DD") S Y=$TR(Y," ,:","//") S $P(Y,"/")=X
 Q Y
SUBHDR ;
 N PSBAL S PSBAL=$O(PSBHDR("ALERGY",""),-1) S PSBAL=$S((PSBAL/12)>(PSBAL\12):(PSBAL\12)+1,1:(PSBAL\12))
 N PSBRE S PSBRE=$O(PSBHDR("REAC",""),-1) S PSBRE=$S((PSBRE/12)>(PSBRE\12):(PSBRE\12)+1,1:(PSBRE\12))
 S PSBLNTOT=$O(PSBHDR(""),-1)+9+PSBAL+PSBRE+1
 W !,$G(PSBHD1,"") S PSBLNTOT=PSBLNTOT+1
 W !,$G(PSBHD2,"") S PSBLNTOT=PSBLNTOT+1
 W !,$TR($J("",PSBTAB8)," ","="),! S PSBLNTOT=PSBLNTOT+2
 Q 
