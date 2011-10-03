XUS4 ;SEA/FDS - ACCESS CODE GENERATOR ;03/23/2001  08:45
 ;;8.0;KERNEL;**180**;Jul 10, 1995
S G 2 ;Change to select auto generate style.
 ;
1 S XUG=$R(4)+5,XUL=0,XUA="" F XUW=0:0 S XUD=XUG-XUL Q:XUD=0  S:XUD=5 XUD=$R(2)+2 S:XUD>5 XUD=$R(3)+2 D A
 S %=$R(1000),XUW=$R(2),XUU=$S(XUW=0:XUA_%,XUW=1:%_XUA) K XUA,%,XUX3,XUW,XUG,XUL,XUD Q
A S XUL=XUL+XUD S:XUD=2 XUC="TC1",XUV="TV1" S:XUD=4 XUC="TC2",XUV="TV2" I XUD=3 S XUW=$R(2) S:XUW=0 XUC="TC1",XUV="TV2" S:XUW=1 XUC="TC2",XUV="TV1"
 S XUA=XUA_$P($T(@XUC),";",($R($P($T(@XUC),";",3))+4))_$P($T(@XUV),";",($R($P($T(@XUV),";",3))+4)) Q
TC1 ;;16;B;D;F;L;H;J;K;M;N;P;R;S;T;V;W;Z
TC2 ;;26;CH;PH;SH;TH;WH;BL;CL;FL;GL;KL;PL;BR;CR;DR;FR;GR;KR;PR;TR;SC;SK;SM;SN;SP;ST;SW
TV1 ;;6;A;E;I;O;U;Y
TV2 ;;51;EA;OA;AE;EE;IE;OE;UE;AF;EF;IF;OF;UF;AH;EH;IH;OH;UH;AI;EI;OI;UI;AL;EL;IL;OL;UL;AM;EM;IM;OM;UM;AN;EN;IN;ON;UN;OO;AR;ER;IR;OR;UR;AS;ES;IS;OS;US;OU;AY;EY;OY
 ;
AC() ;Do 2
 N XUU,% D 2 Q XUU
2 ;Generate 3.4 alpha 3.4 numeric, random order
 S XUU="",%=$P($H,",",2)#10
 D @$S(%>6:"A2(1),N2(0)",1:"N2(1),A2(0)") K %
 Q
VC() ;Generate a 8 char alpha, numeric, punctuation
 N XUU,%,%1
 S XUU="",%1=$P($H,",",2)#10
 D @$S(%1<4:"A2(1),P2,N2(0)",%1<7:"A2(0),P2,N2(1)",1:"N2(1),A2(0),P2")
 Q XUU
 ;
A2(F) S %=$R(100000000)+100000000,XUU=XUU_$C($E(%,2,3)#26+65)_$C($E(%,4,5)#26+65)_$C($E(%,6,7)#26+65)_$S(F:$C($E(%,8,9)#26+65),1:"") Q
N2(F) S XUU=XUU_$E($R(100000)+100000,3,$S(F:6,1:5)) Q
P2 S XUU=XUU_$E("~`!@#$%&*()_-+=|\{}[]'<>,.?/",$R(28)+1) Q
