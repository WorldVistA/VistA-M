PRSACED5 ; HISC/REL/FPT/PLT-T&A Cross-Edits ;11/20/06  12:53
 ;;4.0;PAID;**102,112**;Sep 21, 1995;Build 54
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 G D1:DUT=1,D2:DUT=2,D3:DUT=3 Q
D1 G:+NOR N1
 I "045"'[LVG S ERR=151 D ERR^PRSACED
 I "LJXWPQY"'[PAY S ERR=152 D ERR^PRSACED
 Q:"45"'[LVG
 S E(1)=0 F K=13:1:18 S X=$P(C0,"^",K),E(1)=E(1)+$E(X,1,2)+($E(X,3)*.25)
 S E(2)=0 F K=48:1:53 S X=$P(C0,"^",K),E(2)=E(2)+$E(X,1,2)+($E(X,3)*.25)
 I E(1)>7!(E(2)>7) S ERR=159 D ERR^PRSACED
 I LVG=5 I E(1)+E(2)+$P(C1,"^",30)>14 S ERR=160 D ERR^PRSACED
 Q
 ;36/40 employee has 8b normal hour = 72
N1 I '(NOR=48!(NOR=72)&("KM"[PAY)),NOR<80 S ERR=153 D ERR^PRSACED
 I '(PAY="W"&(LVG=0)),"123"'[LVG S ERR=154 D ERR^PRSACED
 S E(1)=0 F K=13:1:18,20,43 S X=$P(C0,"^",K),E(1)=E(1)+$E(X,1,2)+($E(X,3)*.25)
 S E(2)=0 F K=48:1:53 S X=$P(C0,"^",K),E(2)=E(2)+$E(X,1,2)+($E(X,3)*.25)
 F K=2,25 S X=$P(C1,"^",K),E(2)=E(2)+$E(X,1,2)+($E(X,3)*.25)
 G:NOR=80 N2
 I $P(C0,"^",42)+$P(C1,"^",24)=0 S MX=NOR/2 I E(1)>MX!(E(2)>MX) S ERR=161 D ERR^PRSACED
 S X=$P(C0,"^",42) I X S X=$E(X,1,2)+($E(X,3)*.25) I E(1)>X S ERR=163 D ERR^PRSACED
 S X=$P(C1,"^",24) I X S X=$E(X,1,2)+($E(X,3)*.25) I E(2)>X S ERR=163 D ERR^PRSACED
 Q
N2 I CWK'="C",E(1)>45!(E(2)>45) S ERR=165 D ERR^PRSACED
 I CWK="C",E(1)+E(2)>80 S ERR=166 D ERR^PRSACED
 Q
 ;exclude 9/3 month employee
D2 I PAY'="M"!(FLSA'="E"),NOR<1!(NOR>79) S ERR=155 D ERR^PRSACED
 I "0123"'[LVG S ERR=156 D ERR^PRSACED
 I "ABCGLMNRU0123456789PQT"'[PAY S ERR=157 D ERR^PRSACED
 ;exclude 9/3 month employee
 QUIT:"123"'[LVG!(NOR="80"&(PAY="M"))
 S E(1)=0 F K=13:1:18,20,43 S X=$P(C0,"^",K),E(1)=E(1)+$E(X,1,2)+($E(X,3)*.25)
 S E(2)=0 F K=48:1:53 S X=$P(C0,"^",K),E(2)=E(2)+$E(X,1,2)+($E(X,3)*.25)
 F K=2,25 S X=$P(C1,"^",K),E(2)=E(2)+$E(X,1,2)+($E(X,3)*.25)
 S X=$P(C0,"^",42),X=$E(X,1,2)+($E(X,3)*.25) I E(1)>X S ERR=164 D ERR^PRSACED
 S X=$P(C1,"^",24),X=$E(X,1,2)+($E(X,3)*.25) I E(2)>X S ERR=164 D ERR^PRSACED
 Q:CWK'="C"
 S E(1)=0 F K=29,30,31 S X=$P(C0,"^",K),E(1)=E(1)+$E(X,1,2)+($E(X,3)*.25)
 F K=11,12,13 S X=$P(C1,"^",K),E(1)=E(1)+$E(X,1,2)+($E(X,3)*.25)
 S E(2)=0 F K=21,42 S X=$P(C0,"^",K),E(2)=E(2)+$E(X,1,2)+($E(X,3)*.25)
 F K=16,51 S X=$P(C0,"^",K),E(2)=E(2)-$E(X,1,2)-($E(X,3)*.25)
 F K=3,24 S X=$P(C1,"^",K),E(2)=E(2)+$E(X,1,2)+($E(X,3)*.25)
 ; The following line was commented out for DFAS Release #1 per Angela Curtiss instructions.
 ; I E(1),E(2)<80 S ERR=170 D ERR^PRSACED - 
 Q
D3 I +NOR!LVG S ERR=158 D ERR^PRSACED
 Q
