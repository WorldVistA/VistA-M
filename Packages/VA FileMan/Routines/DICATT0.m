DICATT0 ;SFISC/GFT,XAK-DATES, NUMERIC ;1/7/2009
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**160**
 ;
 G @N
 ;
DIE K Y S DP=0 F  S DL=1,DP=$O(DQ(DP)) Q:DP=""  S:$D(DE(DP)) DG(DP)=DE(DP)
 S DP=-1 D DQ^DIED K DQ,DICATTZ G CHECK^DICATT:$D(Y)!$D(DTOUT),@(N_0)
 ;
1 S %DT="E",DQ="^I X'?1""DT"".NP D ^%DT S X=Y K:Y<0 X",DQ(1)="EARLIEST DATE (OPTIONAL)^D^^1"_DQ,DQ(0,2)="S:'$L(X) Y=""CAN""",DQ(3)="LATEST DATE^RD^^3"_DQ_" I $D(X),X<DG(1) K X"
 S P="<X!(" I C[P S DE(1)=$P($P(C,P,2),">X",1),DE(3)=$P($P(C,"K:",2),P,1)
 S DQ(4)="CAN DATE BE IMPRECISE (Y/N)^S^Y:YES;N:NO;^4^Q",DE(4)=$E("YN",$P(C,Q,2)["X"+1),DQ(4,3)="E.G., WOULD 'FEB, 1980' BE ALLOWED?"
 S DQ(5)="CAN TIME OF DAY BE ENTERED (Y/N)^S^Y:YES;N:NO;^5^S:X=""N"" (DG(7),DG(6))=X K:X=""N"" DQ(6)"
 S DQ(6)="CAN SECONDS BE ENTERED (Y/N)^S^Y:YES;N:NO;^6^S DG(6)=X",DE(6)=$E("NY",$P(C,Q,2)["S"+1)
 S DE(5)=$E("NY",$P(C,Q,2)["T"+1),DQ(5,3)="CAN USER ENTER TIME ALONG WITH DATE, AS IN 'JULY 20@4:30'?"
 S DQ(7)="IS TIME REQUIRED (Y/N)^S^Y:YES;N:NO;^7^Q",DQ(7,3)="MUST USER ENTER TIME ALONG WITH DATE",DQ(0,6)="I X=""N"" S Y=U,DQ=DQ+1",DE(7)=$E("NY",$P(C,Q,2)["R"+1)
 S DICATTZ=1 G DIE
 ;
10 S C="S %DT=""E"_$E("S",DG(6)="Y")_$E("T",DG(5)="Y")_$E("X",DG(4)="N")_$E("R",DG(7)="Y")_""" D ^%DT S X=Y K:"
 F X=1,3 G ND:'$D(DG(X)) S Y(X)=$S(DG(X):DG(X)\10000+1700,1:DG(X)) I DG(X)#100 S Y(X)=DG(X)#100_"/"_Y(X) I $E(DG(X),4,5) S Y(X)=+$E(DG(X),4,5)_"/"_Y(X)
 I DG(1)]"" S M="Type a date between "_Y(1)_" and "_Y(3)_".",C=C_DG(3)_P_DG(1)_">X) X" G ED
ND S C=C_"Y<1 X"
ED S Z="D^",L=DG(5)="Y"*5+7,DG(6)="" G H
 ;
2 K DG S DQ("A1")="!(X'["".""&($L(X)>15))!(X["".""&($L($P(+X,"".""))+$L($P(+X,""."",2))>15)) X"
 S DQ(1)="INCLUSIVE LOWER BOUND^R^^1^K:+X'=X"_DQ("A1"),DQ(2)="INCLUSIVE UPPER BOUND^R^^2^K:X<DG(1)!(+X'=X)"_DQ("A1"),DQ(3)="IS THIS A DOLLAR AMOUNT (Y/N)^S^Y:YES;N:NO;^3^Q" K DQ("A1")
 S P="1"".""",Z=$S(C["$":3,1:+$P(C,P,2)),DE(3)=$E("NY",C["$"+1),DE(5)=$S(Z:Z-1,1:0)
 S DQ(0,4)="S:X=""Y"" Y=U,DQ=9,DG(5)=2",DQ(5)="MAXIMUM NUMBER OF FRACTIONAL DIGITS^RN^^5^K:X'?1N X"
 I O S DE(1)=+$P(C,"X<",2),DE(2)=+$P(C,"X>",2)
 G DIE
20 I DG(1)>DG(2) W $C(7),"??" G 2
 S M="Type a "_$P("number^dollar amount",U,DG(3)="Y"+1)_" between "_DG(1)_" and "_DG(2)_", "_DG(5)_" decimal digit"_$E("s",DG(5)'=1)_"."
 S C="K:+X'=X",T=DG(5)+1,Z="!(X?.E"_P_T_"N.N)"
 I DG(3)="Y",DA-.001 S C="S:X[""$"" X=$P(X,""$"",2) K:X'?"_$P(".""-""",U,DG(1)<0)_".N."_P_".2N",Z=""
 S C=C_"!(X>"_DG(2)_")!(X<"_DG(1)_")"_Z_" X",L=$L(DG(2)\1)+T-(T=1),Z="NJ"_L_","_DG(5)_U
H S DIZ=Z G ^DICATT1
