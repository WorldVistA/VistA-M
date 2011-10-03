DVBHQM11 ;ISC-ALBANY/JLU/PKE - create mail message;10/27/87  10:50
 ;;4.0;HINQ;**7,20,49,65**;03/25/92;Build 19
 ;
LIN Q:CT>100  S CT=CT+1,A1=A_CT_",0)",@A1=T1 Q
DD S:Y Y=$S($E(Y,4,5):$P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC","^",+$E(Y,4,5))_" ",1:"")_$S($E(Y,6,7):+$E(Y,6,7)_",",1:"")_($E(Y,1,3)+1700)_$P("@"_$E(Y_0,9,10)_":"_$E(Y_"000",11,12),"^",Y[".") S:$L(Y)=10 Y=Y_" " Q
 ;
MM S M=$P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC","^",M) Q
 ;
P1 Q:'$D(DVBP(1))
 S T1=$P(DVBP(1),U,4)
 I T1'="" D
 . ;VBA is no longer sending entitlement code, but AAC is computing a
 . ;type of benefit code from the information sent. DVB*4*49  
 . S T1="Type Benefit: "_$S($P(DVBP(1),U,4)="01":"Compensation",$P(DVBP(1),U,4)="0L":"Pension",1:" ")
 . D LIN
 ;VBA will be sending all records as Type "A" records, so Record Type
 ;will no longer display
 Q
 ;
P2 Q:'$D(DVBP(2))
 S T1=" " D LIN S T1=$P(DVBP(2),U) I T1'="  " S Z=$O(^DVB(395.2,"B",T1,"")) I Z S S="   Anatomical loss = ",ST=$P(^DVB(395.2,Z,0),U,2)_" - "_T1 D WRAP
 S T1=$P(DVBP(2),U,3) I T1'="  " S Z=$O(^DVB(395.2,"B",T1,"")) I Z S T1="       Loss of use = "_$P(^DVB(395.2,Z,0),U,2)_" - "_T1 D LIN
 S T1=$P(DVBP(2),U,4) I T1'=" " D OLC^DVBHQM13 I Z'="" S T1="        Other loss = "_Z_" - "_T1 D LIN
 S T1=$P(DVBP(2),U,5) D VMV^DVBHQM13 I Z'="" S S="   Vet married Vet = ",ST=Z D WRAP
 ;Special Monthly Comp. will no longer be sent by VBA - DVB*4*49
 ;Special Provision will no longer be sent by VBA - DVB*4*49
 Q
 ;
P3 Q  ;P3 concerns future data - after DVB*4*49 there will be none
 Q:'$D(DVBP(3))
 I $P(DVBP(3),U,3)="RR" S T1="Future data present - contact RO !!" D LIN Q
 I $P(DVBFUE,U,22) S T1="Amount PFOP Deduction = "_"$"_$E($P(DVBFUE,U,22),1,4)_"."_$E($P(DVBFUE,U,22),5,6) D LIN Q
 I $P(DVBP(3),U)="A" D T4 F XX=1:1:T4 S T3=$P(DVBP(3),U,XX+2) I T3?7N1E S M=$E(T3,5,6) D MM,T5,EMP,HD S ST="  "_M_", "_$E(T3,1,4)_"  "_$S(Z:$P(^DVB(395.4,Z,0),U,2),1:"")_" - "_DVBV1,S=" " D WRAP
 D EMP Q
 ;
P4 Q:'$D(DVBREF)
 I $P(DVBREF,U,3)?9N S T1="Cross Reference number = "_$P(DVBREF,U,3) D LIN
 I $P(DVBREF,U)?9N S T1="     VBA SSN = "_$P(DVBREF,U) D VSS,LIN
 S T1=" " D LIN
 Q
 ;
P5 Q:'$D(DVBP(5))  S T1=$P(DVBP(5),U) I T1 S T1="PFOP Balance : "_" $"_+$E(T1,1,6)_"."_$E(T1,7,8) D LIN Q
 ;
 Q
 ;
 ;DVB*4.0*65
P6 ;
 I $P(DVBP(1),U,10)>0 S M=$E($P(DVBP(1),U,10),1,2) D MM^DVBHQM11 D
 . S T1="Pension Award Eff Date = "_M_" "_$S(+$E($P(DVBP(1),U,10),3,4)>0:$E($P(DVBP(1),U,10),3,4)_", ",1:" ")_$E($P(DVBP(1),U,10),5,8) S:$P(DVBP(1),U,11)]"" T1=T1_"            Reason code = "_$P(DVBP(1),U,11) D LIN
 I $P(DVBP(1),U,12)>0 S M=$E($P(DVBP(1),U,12),1,2) D MM^DVBHQM11 D
 . S T1="    Pension Terminated = "_M_" "_$S(+$E($P(DVBP(1),U,12),3,4)>0:$E($P(DVBP(1),U,12),3,4)_", ",1:" ")_$E($P(DVBP(1),U,12),5,8) S:$P(DVBP(1),U,13)]"" T1=T1_"            Reason code = "_$P(DVBP(1),U,13) D LIN
 I $P(DVBP(1),U,14)'?1" "." " S T1="                                                 Reason code = "_$P(DVBP(1),U,14) D LIN
 I $P(DVBP(1),U,15)'?1" "." " S T1="                                                 Reason code = "_$P(DVBP(1),U,15) D LIN
 I $P(DVBP(1),U,16)'?1" "." " S T1="                                                 Reason code = "_$P(DVBP(1),U,16) D LIN
 ;
 Q
 ;
EMP S T1=" " D LIN Q
 ;
HD S T1="Diary data:" D LIN Q
T4 S T4=$P(DVBP(3),U,2) Q
 ;
T5 S DVBV1=$E(T3,7,8)
 I DVBV1?1N1A!(DVBV1["{") S DVBV2=2 D SIGN^DVBHUTIL
 S Z=$O(^DVB(395.4,"B",DVBV1,""))
 Q
 ;
WRAP S B=$L(S),GL=$P((($L(ST)+B/78)+.9),"."),SP=1,V=78-B,$P(T," ",B+1)=""
 F LP=1:1:GL S Z=$E(ST,V*LP) D:Z=" "!(Z="") SET D:Z'=" "&(Z'="") PAR
 K GL,LP,LP1,Z,Z1,EP,SP,ST,B,V,T,S Q
SET S T1=$E(ST,SP,V*LP) S:SP=1 T1=S_T1 S:SP'=1 T1=T_T1 S SP=V*LP+1 D LIN Q
PAR F LP1=1:1 S EP=(V*LP)-LP1,Z1=$E(ST,EP) Q:Z1=" "
 S T1=$E(ST,SP,EP) S:SP=1 T1=S_T1 S:SP'=1 T1=T_T1 S SP=EP+1 D LIN Q
 ;
VSS I $D(DVBP(1)) S C=$P(DVBP(1),U,8) I C]"" S T1=T1_$S(C=1:" Verified SSA",C=2:" Verified VBA",C=4:" Verified by BIRLS",C=9:" SSA Verified No Number Exists",C=0:" Unverified",C=3:" Not Required, Child Under 2",1:" "_C) K C
 Q
