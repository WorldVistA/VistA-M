DIR1 ;SFISC/XAK-READER-MAID (PROCESS DATATYPE) ;11:41 AM  8 Jun 2007
 ;;22.0;VA FileMan;**1,5,73,156**;Mar 30, 1999;Build 1
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 S %E=0 D @%T S:X?.E1C.E %E=1 Q:'%E!(X'?.E1L.E)!(%A["S")!(%A["Y")!((%T=1)&(%B["P"))!(%A["P")
 F %Y=1:1:$L(X) I $E(X,%Y)?1L S X=$E(X,1,%Y-1)_$C($A(X,%Y)-32)_$E(X,%Y+1,999)
 G DIR1
Y ; YES/NO
S ; SET
 N %BU,%K,%M,%J,DDH
 I $L(X)>245 S %E=1,Y="" Q  ;DI*156
 I %T="S",$D(DIR("S"))#2 S DIC("S")=DIR("S")
 S %BA=$S($D(DIC("S")):DIC("S"),1:"I 1")
 S (%J,%K,DDH)=0
 I %B'[":",$O(DIR("C",""))]"" D
 . ;Look for match on internal code
 . S %I="" F  S %I=$O(DIR("C",%I)) Q:%I=""  S %J=DIR("C",%I) I X=$P(%J,":") S Y=X,Y(0)=$P(%J,":",2) X %BA S:'$T %I="" Q
 . ;If not found, look for match on external code
 . I %I="" F  S %I=$O(DIR("C",%I)) Q:%I=""  S %J=DIR("C",%I) I $F(%J,":"_X) S Y=$P(%J,":") X %BA I  S %K=%K+1,%K(%K)=%J Q:%A["o"  I $D(DIQUIET),X=$P(%J,":",2) Q
 . ;If still no match, convert X and choices to uppercase, search again
 . I %I="",%A'["X",'%K D
 .. S %M=X N X S X=$$UP^DILIBF(%M)
 .. F  S %I=$O(DIR("C",%I)) Q:%I=""  S %J1=DIR("C",%I),%J=$$UP^DILIBF(%J1) I X=$P(%J,":") S Y=$P(%J1,":"),Y(0)=$P(%J1,":",2) X %BA S:'$T %I="" Q
 .. I %I="" F  S %I=$O(DIR("C",%I)) Q:%I=""  S %J1=DIR("C",%I),%J=$$UP^DILIBF(%J1) I $F(%J,":"_X) S Y=$P(%J1,":") X %BA I  S %K=%K+1,%K(%K)=%J1 Q:%A["o"  I $D(DIQUIET),X=$P(%J,":",2) Q
 . S %J=%I
 E  D
 . S Y(0)=$P($P(";"_%B,";"_X_":",2),";") I Y(0)]"" S Y=X X %BA I  S %J=1
 . I '%J F %I=1:1 S %J=$P(%B,";",%I) Q:%J=""  S Y=$F(%J,":"_X) I Y S Y=$P(%J,":") X %BA I  S %K=%K+1,%K(%K)=%J Q:%A["o"  I $D(DIQUIET),X=$P(%J,":",2) Q
 . I %J="",%A'["X",'%K D
 .. S %BU=$$UP^DILIBF(%B),%M=X N X S X=$$UP^DILIBF(%M)
 .. S Y=$F(";"_%BU,";"_X_":") I Y D  X %BA I  S %J=1 Q
 ... S Y(0)=$P($E(";"_%B,Y,999),";")
 ... S Y=$L($E(";"_%B,1,Y-1),";"),Y=$P($P(";"_%B,";",Y),":")
 .. F %I=1:1 S %J=$P(%BU,";",%I),%J1=$P(%B,";",%I) Q:%J=""  S Y=$F(%J,":"_X) I Y S Y=$P(%J1,":") X %BA I  S %K=%K+1,%K(%K)=%J1 Q:%A["o"  I $D(DIQUIET),X=$P(%J,":",2) Q
 I %K=1 S Y=$P(%K(1),":"),Y(0)=$P(%K(1),":",2)
 I %K>1,$G(DIQUIET) S %E=1 Q
 I %K>1 D CH Q:%E=1  I '$D(%K(%I)) S X=%I G S
 I %J="",'%K S %E=1 Q
 I %A'["V",$D(DDS)[0 W $S((%K=1!('%K))&($P(Y(0),X)=""):$E(Y(0),$L(X)+1,99),1:"  "_Y(0))
 I %T="Y" S (%,Y)=+$$PRS^DIALOGU(7001,$E(X)) S:%<0 (%,Y)="" S:%=2 Y=0
 Q
 ;
CH ;
 N DIY,DDD,DDC,DS,DD
 F %I=1:1:%K S A0="     "_%I_"   "_$P(%K(%I),":",2) D MSG
 I '$D(DDS) S A0="Choose 1-"_%K_": " D MSG R %I:$S($D(DIR("T")):DIR("T"),'$D(DTIME):300,1:DTIME)
 I $D(DDS) S DDD=2,DDC=5,(DS,DD)=%K D LIST^DDSU S %I=DIY
 I U[%I!(%I?1."?") S X="?",%E=1 Q
 I $D(%K(%I)) S Y=$P(%K(%I),":"),Y(0)=$P(%K(%I),":",2)
 Q
 ;
MSG ;
 I $D(DDS),A0]"" S DDH=$G(DDH)+1,DS(DDH)=$P(%K(%I),":"),DDH(DDH,DDH)=$P(%K(%I),":",2)
 I '$D(DDS) W !,A0
 K A0
 Q
 ;
L ; LIST OR RANGE
 D L^DIR3
 Q
D ; DATE
 D ^%DT I Y<0 S %E=1 Q
 I %D1["NOW"!(%D2["NOW")&($P("NOW",$$UP^DILIBF(X))="") S:%D1["NOW" %B1=Y S:%D2["NOW" %B2=Y
 I %B1,Y<%B1 S %E=1 S:'%N %W="Response must not precede "_+$E(%B1,4,5)_"/"_+$E(%B1,6,7)_"/"_(1700+$E(%B1,1,3)) Q
 I Y>%B2 S %E=1 S:'%N %W="Response must not follow "_+$E(%B2,4,5)_"/"_+$E(%B2,6,7)_"/"_(1700+$E(%B2,1,3))
 S Y(1)=Y X ^DD("DD") S Y(0)=Y,Y=Y(1) K Y(1)
 Q
 ;
N ; NUMERIC
 I $L($P(X,"."))>24 S %E=1 Q
 I X'?.1"-".N.1".".N S %E=1 Q
 I X>%B2!(X<%B1) S %E=1 S:'%N %W="Response must be no "_$S(X>%B2:"greater",1:"less")_" than "_$S(X>%B2:%B2,1:+%B1) Q
 I '%E,($L($P(+X,".",2))>%B3) S %E=1 S:'%N %W="Response must be with no more than "_+%B3_" decimal digit"_$S(%B3>1:"s",1:"") Q
 S Y=+X
 Q
 ;
F ; FREETEXT
 S Y=X I X[U,%A'["U" S %E=1
 S:'%N %W="This response must have at least "_+%B1_" character"_$S(+%B1>1:"s",1:"")_" and no more than "_%B2_" characters"_$S(%A'["U":" and must not contain embedded uparrow",1:"")
 I $L(X)<%B1!($L(X)>%B2) S %E=1
 Q
 ;
E ; END-OF-PAGE
 S Y=X="" S:X=U (DUOUT,DIRUT)=1 I $L(X),X'=U S %E=1
 Q
 ;
P ; POINTER
 S:'$D(DDS) %B2=$P(%B2,"L")_$P(%B2,"L",2)
 I %B2["A" S %B2=$P(%B2,"A")_$P(%B2,"A",2)
 S:$D(DIR("S"))#2 DIC("S")=DIR("S")
 S DIC=%B1,DIC(0)=%B2,%C=X D P1
 I $D(X)#2,X="",Y<0 S %E=-1
 E  S %E=Y<0
 S X=%C
 Q
P1 N %A,%B,%C,%N,%P,%T,%W D ^DIC
 Q
 ;
1 ; DD
 S %C=X N %W I %B["P"!(%B["V") N DIE
 I %B["F" S Y=X I X[U,$P($P(%B3,U,4),";",2)'?1"E"1.N1","1.N S %E=1 Q
 I %B["S" S %B=$P(%B3,U,3),%BU=$$UP^DILIBF(%B) X:$D(^DD(%B1,%B2,12.1)) ^(12.1) D S S X=Y,%B=$P(%B3,U,2) G R
 I %B["P" S DIC=U_$P(%B3,U,3),DIE=DIC,DIC(0)=$E("L",%B'["'"&$D(DDS))_$E("E",$D(DIR("V"))[0)_"MZ" I %B'["*" D P1 S X=+Y,%E=Y<0
 I %B["V" D
 . N %A,%B,%C,%N,%P,%T,%W
 . S (DIE,DP)=%B1,DIFLD=%B2,DQ=1
 . D ^DIE3
 . S %E=Y'>0 S:Y>0 Y(0)=$P(Y,U,2)
R D IT:'%E S X=%C
 Q
IT D
 . N %A,%B,%C,%N,%P,%T,%W N:'$G(DIRDINUM) DINUM
 . I $P(%B3,U,2)["N",$P(%B3,U,5,99)'["$",X?.1"-".N.1".".N,$P(%B3,U,5,99)["+X'=X" S X=+X
 . X $P(%B3,U,5,99)
 S %E='$D(X)
 I '%E,%B'["P" S Y=X
 I '%E,%B["D" X ^DD("DD") S Y(0)=Y,Y=X
 Q
 ;
 ;#7001  Yes/No question
