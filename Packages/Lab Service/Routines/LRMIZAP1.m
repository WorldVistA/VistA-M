LRMIZAP1 ;SLC/BA - MICRO CONVERSION ; 4/4/87  21:05 ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
XX ;from LRMIZAP
 F I=0:0 S L=+$O(^LR(L)) Q:L<1  W:L#100=0 !,L S ^TMP("LRMIZAP",$J,"ZAP")=L,T=0 F I=0:0 S T=+$O(^LR(L,"MI",T)) Q:T<1  S B=0 F I=0:0 S B=+$O(^LR(L,"MI",T,3,B)) Q:B<1  D P
 Q
P S N=0 F I=0:0 S N=+$O(^TMP("LRMIZAP",$J,N)) Q:N<1  I $D(^LR(L,"MI",T,3,B,N)),$L($P(^(N),U)),$D(^TMP("LRMIZAP",$J,N,$P(^(N),U))) S C=^TMP("LRMIZAP",$J,N,$P(^LR(L,"MI",T,3,B,N),U)) D C
 Q
C I $P(C,U,2)="*" D ALT Q
 S $P(^LR(L,"MI",T,3,B,N),U,2)=$P(C,U) Q
 Q
ALT I '$D(^LR(L,"MI",T,3,B,0)) Q
 S Y(0)=^LR(L,"MI",T,3,B,0),C6=$P(C,U,3),C4=$P(C,U,4),LRISR=$P(C,U) D ISR S $P(^LR(L,"MI",T,3,B,N),U,2)=LRISR
 Q
ISR S LROVERR=0,C2=0 F I=0:0 S C2=$O(^LAB(62.06,C6,1,C4,1,C2)) Q:C2<1  I $D(^(C2,0)),+^(0)=+Y(0) S LRISR=$P(^(0),U,2),LROVERR=1 Q
 I LROVERR Q
 S C2=0 F I=0:0 S C2=$O(^LAB(62.06,C6,1,C4,1,C2)) Q:C2<1  S LRORIDE=^(C2,0),LRBUGN=$P(^LAB(61.2,+LRORIDE,0),U) I LRBUGN["GRAM POS"!(LRBUGN["GRAM NEG") D GSCHECK Q
 I LROVERR S LRISR=$P(^LAB(62.06,C6,1,C4,1,C2,0),U,2) Q
 S LRISR=$P(^LAB(62.06,C6,1,C4,0),U,2)
 Q
GSCHECK I LRBUGN["GRAM POS",$P(^LAB(61.2,+Y(0),0),U,3)="P" S LROVERR=1
 I LRBUGN["GRAM NEG",$P(^LAB(61.2,+Y(0),0),U,3)="N" S LROVERR=1
 Q
ZZ ;from LRMIZAP
 F I=0:0 S L=+$O(^LR(L)) Q:L<1  S ^TMP("LRMIZAP",$J,"UNZAP")=L,T=0 F I=0:0 S T=+$O(^LR(L,"MI",T)) Q:T<1  S B=0 F I=0:0 S B=+$O(^LR(L,"MI",T,3,B)) Q:B<1  D Z
 Q
Z S N=0 F I=0:0 S N=+$O(^TMP("LRMIZAP",$J,N)) Q:N<1  I $D(^LR(L,"MI",T,3,B,N)),$L($P(^(N),U)),$D(^TMP("LRMIZAP",$J,N,$P(^(N),U))) W "." S ^LR(L,"MI",T,3,B,N)=$P(^LR(L,"MI",T,3,B,N),U)
 Q
 ;L=LRDFN, T=LRIDT, B=bug#, N=bugnode of antibiotic
 ;^TMP("LRMIZAP",$J,"ZAP")=LRDFN of last patient processed
 ;C=^TMP("LRMIZAP",$J,bugnode,result)=interpretation
 ;if an alt interpretation  ""     ""   )=interpretation^*^antibiotic#^result#
