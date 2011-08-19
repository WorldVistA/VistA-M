IBCSCE1 ;ALB/MRL,MJB - MCCR SCREEN EDITS  ;07 JUN 88 14:35
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;MAP TO DGCRSCE1
 ;
 S:'$D(DR(2,2)) DR(2,2)="" S:'$D(DGDRS1) DGDRS1="DR(2,2)" S:'$D(IB1) IB1=0 S:'$D(DGCT1) DGCT1=0 S DGDRD=$P($T(@J),";;",2) D S S K=(J*10) I $T(@K) S DGDRD=$P($T(@K),";;",2) D S
 I +J=31 S DR(3,2.312)=".01;1;2;15;8;3;6;S IBADI=X;17//^S X=$S(IBADI=""v"":$P(VADM(1),""^"",1),1:"""");16//^S X=$S(IBADI=""v"":""01"",1:"""");"
 Q
S I $L(@DGDRS1)+$L(DGDRD)<241 S @DGDRS1=@DGDRS1_DGDRD Q
 S DGCT1=DGCT1+1,DGDRS1="DR(2,2,"_DGCT1_")",@DGDRS1=DGDRD Q
 Q
11 ;;.03;
12 ;;1;
13 ;;.02;.05;
14 ;;1901;.361;
15 ;;.111;S:X="" Y=.114;.112;S:X="" Y=.114;.113:.117;.131;.12105;S:X="N" Y="@15" S:X="Y" DIE("NO^")="";.1217;I X']"" W !?4,*7,"But I need a Start Date for this Temporary Address." S Y=.12105;
150 ;;.1218;.1211;I X']"" W !?4,*7,"But I need at least one line of a Temporary address." S Y=.12105;.1212;S:X']"" Y=.1214;.1213;.1214;.1215;.1216;.1219;@15;K DIE("NO^");
21 ;;.07;.31115;I $S(X']"":1,X=3:1,X=9:1,1:0) S Y="@41";.3111;S:X']"" Y="@41";.3113;S:X']"" Y=.3116;.3114;S:X']"" Y=.3116;.3115:.3119;@41;
22 ;;.251;S:X']"" Y="@42";.252;S:X']"" Y=.255;.253;S:X']"" Y=.255;.254:.258;@42;
31 ;;.3121;
AD S X=$S($D(^DPT(DA,.11)):^(.11),1:""),IBPHO=$S($D(^(.13)):$P(^(.13),U,1),1:""),Y=$S($D(^(IBADD)):^(IBADD),1:""),^(IBADD)=$P(Y,U,1)_U_$P(Y,U,2)_U_$P(X,U,1,6)_U_IBPHO_U_$P(Y,U,10) K IBADD,IBPHO Q
SET S I(0,0)=D0,Y(1)=$S($D(^DGCR(399,D0,0)):^(0),1:""),X=$P(Y(1),"^",2),D(0)=X,X=$S(D(0)>0:D(0),1:"") Q
 ;IBCSCE1
