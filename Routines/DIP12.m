DIP12 ;SFISC/TKW-PROCESS FROM-TO (CONT.) ;06:54 PM  18 Feb 2002
 ;;22.0;VA FileMan;**97**;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
OPT ;Build code to extract field & test sort criteria, build sort description.
 N S,F,X,%,F1,F2,F3,T1,T2,T3,N,DIRANGE
 S S=$P(DPP(DJ),U),F=$P(DPP(DJ),U,2),N=$P(DPP(DJ),U,3) S:N["""" N=$$CONVQQ^DILIBF(N),DIRANGE=""
 S X="DISX("_DJ_")",DPP(DJ,"GET")=""
 I +$P(S,"E")=S,F D GET^DIOU(S,F,X,.%) I $D(%)#10 S DPP(DJ,"GET")=%
 I $D(DPP(DJ,"CM")) S DPP(DJ,"GET")=DPP(DJ,"CM")
 I $G(DPP(DJ,"SRTTXT"))="SORT" S DPP(DJ,"GET")=DPP(DJ,"GET")_" S:"_X_"]"""" "_X_"="_""" ""_"_X
 I +$P(S,"E")=S,F,$P(DPP(DJ),U,10)=2 D
 . N % S %=$P($G(^DD(S,F,0)),U,2) I %'["C",%'["N" Q
 . S DPP(DJ,"GET")=DPP(DJ,"GET")_" S:"_X_"]"""" "_X_"=+"_X
 . Q
 I $P(DPP(DJ),U,4)["@B" S %=X,DPP(DJ,"TXT")=N G O2
 I S,F=0 D BIJ^DIOU(S,.01,.%,.F) S X="D"_$G(%(S)) K %,F
 I '$D(DPP(DJ,"F")) S %=$$NULL^DIOC(X,"'"),DPP(DJ,"TXT")=N_" not null" G O2
RANGE D FT S DIRANGE="" S:$G(DPP(DJ,"SRTTXT"))="RANGE" DIRANGE=""" ""_"
 S %=""
 I F1="?z" D  G O2
 . I T1="z" S %="1",DPP(DJ,"TXT")="All "_N_" (includes nulls)" Q
 . I T1="@" S %=$$NULL^DIOC(X),DPP(DJ,"TXT")=N_" is null" Q
 . S %=$$AFT^DIOC(DIRANGE_X,T1,"'")
 . S DPP(DJ,"TXT")=N_$S(T3]"":" to "_T3,1:"")_" (includes nulls)"
 . Q
 S DPP(DJ,"TXT")=N_$S(F3]"":" from "_F3,1:"")
 I T1="@"!(T1="z") D  G O2
 . S %="" I T1="@" S DPP(DJ,"TXT")=DPP(DJ,"TXT")_" (includes nulls)",%=$$NULL^DIOC(X)_"!("
 . S %=%_$$AFT^DIOC(DIRANGE_X,F1) S:T1="@" %=%_")"
 . Q
 I F3]"",F3=T3 S %=$$EQ^DIOC(X,T1),DPP(DJ,"TXT")=N_" equals "_F3 G O2
 S %=$$BTWI^DIOC(DIRANGE_X,F1,T1,"","SORT")
 I T3]"" S DPP(DJ,"TXT")=DPP(DJ,"TXT")_" to "_T3
O2 S DPP(DJ,"QCON")="I "_%
 K DITYP Q
 ;
FT ;ALSO CALLED BY DIP1
 S %=$G(DPP(DJ,"F")) I %="" S %=$G(DIPP(+$G(DIJ),"F"))
 S F1=$P(%,U),F2=$P(%,U,2),F3=$P(%,U,3) S:F3="" F3=F2 S:$E(F1)="""" F1=""""_F1
 S %=$G(DPP(DJ,"T")) I %="" S %=$G(DIPP(+$G(DIJ),"T"))
 S T1=$P(%,U),T2=$P(%,U,2),T3=$P(%,U,3) S:T3="" T3=T2
 Q
 ;
CK ;VALIDATE FIELDS/DATA
 G QQ:X[U I X="@" S Y=X K DPP(DJ,"IX"),DPP(DJ,"PTRIX") Q
 I DITYP=1 S %DT="" D  D ^%DT K %DT G:Y=-1 QQ S Y(0)=$$FMTE^DILIBF(Y,5) Q
 . S:$G(DITYP("D"))["T" %DT="T"
 . S:$G(DITYP("D"))["S" %DT=%DT_"S"
 . S %DT=%DT_$E("E",(DIFRTO="?")) Q
 I DITYP=3 D  G:Y=-1 QQ Q
 . S Y=$G(DITYP("S","E",X)) I Y]"" S Y(0)=Y_" ("_X_")" W:DIFRTO="?" "    USES INTERNAL CODE: "_Y Q
 . I $D(DITYP("S","I",X)) S Y=X,Y(0)=X_" ("_DITYP("S","I",X)_")" W:DIFRTO="?" "  "_DITYP("S","I",X) Q
 . S D=$O(DITYP("S","E",X)) I D]"",$P(D,X)="" S Y=DITYP("S","E",D),Y(0)=Y_" ("_D_")" W:DIFRTO="?" $P(D,X,2,9)_"    USES INTERNAL CODE: "_Y Q
 . I DIFRTO'="?" S Y=X Q
 . S Y=-1 Q
 I +$P(X,"E")=X!(DITYP'=2) S Y=X Q
QQ S Y=-1,DIERR="Invalid Entry" Q:$G(DIQUIET)
 W $C(7),"??",DIERR Q
