DICATT22 ;SFISC/GFT-CREATE A SUBFILE ;28MAY2006
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**42,52,89,999,1004,1024**
 ;
 G M:V I P,$D(^DD(J(N-1),P,0)) S I=A_$E("I",$P(^(0),U,2)["I") D P
 I O,DA=.01,'N S I=$P(@(I(0)_"0)"),U,2) D P
1 ;
 S %=$L(F)+$L(W)+$L(C)+$L(Z) I %>242 W $C(7),!?5,"Field Definition is TOO LONG by ",%-242," characters!" G TYPE^DICATT2
 I T["P",$D(O)=11,+$P($P(O(1),U,2),"P",2)'=+$P(Z,"P",2) S X=$P(O(1),U,2),DA(1)=A X:$D(^DD(0,.2,1,3,2)) ^(2)
 S ^DD(A,DA,0)=F_U_Z_U_W_U_C S:$P(Z,U)["K" ^(9)="@" D SDIK,I G N^DICATT
 ;
Q W $C(7),!,"NUMBER MUST BE BETWEEN ",A," & ",%+1," AND NOT ALREADY IN USE"
M S %=$P(A,"."),DE=%_"."_+$P(A,".",2)_DA I +DE'=DE!$D(^DD(DE)) F DE=A+.01:.01:%+.7,%+.7:.001:%+.9,%+.9:.0001 Q:DE>A&'$D(^DD(DE))
 I DUZ(0)="@" W !,"SUB-DICTIONARY NUMBER: "_DE_"// " R DG:DTIME S:'$T DTOUT=1 G:DG=U!'$T ^DICATT2 S:DG]"" DE=DG G Q:+DE'=DE!(DE<A)
 G Q:%+1'>DE!$D(^DD(DE)) S I=DE,^(I,0)=F_" SUB-FIELD^^.01^1",^(0,"UP")=A,^("NM",F)="",%X="^DD("_A_","_DA_")",@%X@(0)=F_"^^^"_W D P
 S W=$P(W,";") D SDIK S:+W'=W W=""""_W_""""
 S DICATT22=DA,(N,DICL)=N+1,I(N)=W,J(N)=DE,DA=.01,^DD(DE,DA,0)=F_U_Z_"^0;1^"_C,%Y="^DD("_DE_",.01)"
VARPOINT I T["V" D
 . N I,FI,FD,P
 . S FI=$QS(%X,1),FD=$QS(%X,2)
 . S I=0
 . F  S I=$O(@%X@("V",I)) Q:'I  S P=+$G(^(I,0)) K:P ^DD(P,0,"PT",FI,FD)
 . M @%Y@("V")=@%X@("V") K @%X@("V")
POINT I T["P" F %=12,12.1 I $D(@%X@(%)) S @%Y@(%)=@%X@(%) K @%X@(%)
 K %X,%Y
 I T'["W" D
 .S ^DD(DE,DA,1,0)="^.1",^(1,0)=DE_"^B",DIK=W_",""B"",$E(X,1,30),DA)"
 .F %=DICL-1:-1 S DIK=I(%)_$E(",",1,%)_"DA("_(DICL-%)_"),"_DIK I '% S ^(1)="S "_DIK_"=""""",^(2)="K "_DIK S:T["V" ^(3)="Required Index for Variable Pointer" Q
 D SDIK,I S DICL=DICL-1
 D AUDIT(DA(1),.01,"N") S DA=DICATT22 K DICATT22 ;AUDIT THE NEW .01 FIELD AT THE LOWER LEVEL
 G N^DICATT
 ;
AUDIT(DIFILE,DIFIELD,DITYPE) ;
 N DDA,DA,B0,A0
 S DDA(1)=DIFILE,DA=DIFIELD,DDA=$G(DITYPE,"E")
 D AUDT^DICATTA
 Q
 ;
 ;
 ;
I I $P(O,U,2,99)'=$P(^DD(J(N),DA,0),U,2,99) S:$D(M)#2 ^(3)=M S M(1)=0
 K DR,DG,DB,DQ,DQI,^DD(U,$J),^UTILITY("DIVR",$J)
EGP ;K ^DD(DA(1),DA,.009) ; GET RID OF FOREIGN-LANGUAGE HELP MESSAGE WHEN THE BASIC ENGLISH ONE IS BEING RE-EDITED??
 S DIE=DIK,DR=$S(DUZ(0)="@":"3;4",1:3)_$P(";21",U,'O) D  I T="W" K DE
 .N I,J,T
 .D ^DIE
 I $D(M)>9,O S V=DICL,DR=$P(Z,U),Z=$P(Z,U,2) D  ;It's not clear that we need these variables set, now we are calling DIVR^DIUTL 12/01
V .N D0 S DI=J(N) D DIPZ^DIU0 Q:$D(DTOUT)!'$D(DIZ)  ;NEEDS 'DI' & 'DA'
 .D DIVR^DIUTL(A,DA)
 K DR,M Q
 ;
 ;
P F Y="S","D","P","A","V" S:I[Y I=$P(I,Y)_$P(I,Y,2)_$P(I,Y,3) S:T[Y I=I_Y
 S ^(0)=$P(^(0),U)_U_I_U_$P(^(0),U,3,99) Q
 ;
SDIK N %X
 S DA(1)=J(DICL),DIK="^DD("_DA(1)_"," I O K ^DD(DA(1),"RQ",DA)
 W !,"...." G IX1^DIK
