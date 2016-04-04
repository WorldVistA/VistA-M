DIR2 ;SFISC/XAK-READER (SETUP VARS,REPLACE...WITH) ;2015-01-02  3:56 PM
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**30,999,1038,1042,1044,1051**
 ;
 K Y,% S U="^"
 D DIR("A"),DIR("?"),DIR("L"),DIR("B") ;**
 S %T=$E(DIR(0)),%A=$P(DIR(0),U),%B=$P(DIR(0),U,2),%N=%A'["V"
 K:$D(DIR("A"))=10 DIR("A") K:$D(DIR("?"))=10 DIR("?")
 S %W0=$S($D(DIR("?")):DIR("?"),%T'?.AN:"",'$P($T(@(%T_1)),";",5):"",1:$$EZBLD^DIALOG($P($T(@(%T_1)),";",5)))
 S %A0=$$EZBLD^DIALOG(8041)
 ;I %T="t" D SETUP^DIRUD Q  ;if this a user-defined data type read
 ;**CCO/NI (next line) SPECIFICATION OF READ IS 'DATA DICTIONARY', SO GET FIELD LABEL AND PROPERTIES
 I %A?.NP1",".ANP S %B1=$P(%A,","),%B2=+$P(%A,",",2) G:'$D(^DD(%B1,%B2,0)) EO S %B3=^(0),%B=$P(%B3,U,2) G:%B EO D:'$D(DIR("B")) DA^DIRQ:$D(DA)#2 S:'$D(DIR("A")) %P=$$LABEL^DIALOGZ(%B1,%B2)_": " S:$P(%B3,U,2)'["R" %A=%A_"O" S %T=1 G NN
 I "FSYENDLP"'[%T G EO
 S %B1=$P(%B,":"),%B2=$P(%B,":",2),%B3=$P(%B,":",3)
 S:'$L(%B2) %B2=$S(%T="D":9991231,%T="F":245,1:999999999999)
 I %T="F",%B2>245 S %B2=245
 I %T="Y" S %B=$$EZBLD^DIALOG(7003)
 I %T="D" S %DT=$P(%B3,"A")_$P(%B3,"A",2)
 I %T="D",'$D(DIR("?")) S %W0=%W0_$S(%B3["R":$$EZBLD^DIALOG(8043),%B3["T":$$EZBLD^DIALOG(8044),1:"")
 I %T="D" S %D1=%B1,%D2=%B2 I %B["NOW"!(%B["DT") D NOW^%DTC K %I,%H S DT=X S:%B1["NOW" %B1=% S:%B1["DT" %B1=X S:%B2["NOW" %B2=% S:%B2["DT" %B2=X K %
 I %T="P" S %B1=$S('%B1:U_%B1,'$D(^DIC(+%B1,0,"GL")):U,1:^("GL")) G EO:%B1=U,EO:'$D(@(%B1_"0)")) I '$D(DIR("A")) S %P=$$EZBLD^DIALOG(8042,$O(^DD(+$P(^(0),U,2),0,"NM",0))) Q
NN D:%T="S" S0:%A'["A" Q:$D(%P)
 S %P="" I %A["A" S:$D(DIR("A")) %P=DIR("A") Q
 I '$D(DIR("A")) S %P=$$EZBLD^DIALOG($P($T(@%T),";",4)) I %T="D" S %P=%P_$S(%B3["R":$$EZBLD^DIALOG(8043),%B3["T":$$EZBLD^DIALOG(8044),1:"")
 S:$D(DIR("A")) %P=$S(%T="Y":DIR("A")_"? ",%T="S":$$EZBLD^DIALOG(8045,DIR("A")),1:DIR("A")_": ") I "LND"'[%T Q
 I $L(%B1) S %P=%P_" ("_$S(%T="D":$$DATE^DIUTL(%B1)_"-"_$$DATE^DIUTL(%B2),1:%B1_"-"_%B2)_")" ;**
 S %P=%P_$S("?: "[$E(%P,$L(%P)):"",1:":")_" "
 Q
S0 S %P=$S($D(DIR("A")):DIR("A")_": ",%A["B":$$EZBLD^DIALOG(8046),1:$$EZBLD^DIALOG($P($T(@%T),";",4)))
 Q:%A'["B"  S %P=%P_" ("
 I %B'[":",$O(DIR("C",""))]"" S %I="" F  S %I=$O(DIR("C",%I)) Q:%I=""  D
 . N Y S Y=$P(DIR("C",%I),":") Q:Y=""
 . I $D(DIR("S"))#2 X DIR("S") E  Q
 . S %P=%P_Y_"/"
 E  F %I=1:1 Q:$P(%B,";",%I,999)=""  D
 . N Y S Y=$P($P(%B,";",%I),":") Q:Y=""
 . I $D(DIR("S"))#2 X DIR("S") E  Q
 . S %P=%P_Y_"/"
 S %P=$E(%P,1,$L(%P)-(%P?.E1"/"))_"): "
 Q
EO S %T="",Y=-1 Q
 ;
DIR(DIALA) ;** INSERTS DIALOGS INTO DIR ARRAY
 N DIALN,DIALP
 S DIALN=$G(DIR("DIALOG",DIALA))
 Q:'$D(^DI(.84,0))  Q:+DIALN'=DIALN  Q:'$D(^(DIALN,2))  ;GIVES US A MAKED REFERENCE PRIOR TO CALLING $$EZBLD^DIALOG
 I $D(DIR("DIALOG",DIALA))>9 M DIALP=DIR("DIALOG",DIALA)
 K DIR(DIALA) D BLD^DIALOG(DIALN,.DIALP,,"DIR(DIALA)","F")
 Q
 ;
 ;
RW ; Replace...With..   ENTER WITH 'Y', EXIT WITH 'Y' CHANGED.
 N %,L,DINAKED S DINAKED=$NA(^(0)),DG=Y S:$D(DTIME)[0 DTIME=999
A W:$X>50 ! K DTOUT W $$EZBLD^DIALOG(8047) R X:DTIME E  S DTOUT=1,X=""
 G B:X="",Q:X?1."^",Q:$E(X)=U&($D(DIRWP)[0)&(Y'[X),Q:X?."?",Q:X="@"
 I X="END"!(X="end")!(X=$$UP^DILIBF($$EZBLD^DIALOG(7097))) S L=0 D H S:'%&'$D(DTOUT) Y=Y_X G A ;**CCO/NI 'END'
 I Y[X S D=X,L=$L(X) D H S:'%&'$D(DTOUT) Y=$P(Y,D,1)_X_$P(Y,D,2,999) G A
 S D=$P(X,"...",1),DH=$F(Y,D) I DH S X=$P(X,"...",2,99),X=$S(X="":$L(Y)+1,1:$F(Y,X,DH)) I X S DH=DH-$L(D)-1,D=X,L=D-DH-1 D H S:'%&'$D(DTOUT) Y=$E(Y,1,DH)_X_$E(Y,D,999) G A
 W $C(7)," ??" G A
 ;
H N DIMAX
WITH W $$EZBLD^DIALOG(8048) R X:DTIME E  S DTOUT=1,X="",%=0 W $C(7)," ??" Q
 S DIMAX=$G(^DD("STRING_LIMIT"),255)-10,%=$L(Y)-L+$L(X)>DIMAX
 I % W $C(7),$S($L(Y)-L'>DIMAX:$$EZBLD^DIALOG(349,($L(Y)-L+$L(X)-DIMAX)),X'=U:$$EZBLD^DIALOG(350),1:" ??") Q:$L(Y)-L>DIMAX&(X=U)  G WITH
 Q:X?.ANP  W $C(7)," ??" G WITH
 ;
B W:$D(DTOUT) $C(7) I DG'=Y S X=Y W !?3 W X I X="" S X="@"
 D:$D(DINAKED)
 .I $D(@DINAKED)
Q Q
 ;
F ;;Enter response: ;8051
S ;;Enter response: ;8051
Y ;;Enter Yes or No: ;8052
E ;;Press RETURN to continue or '^' to exit: ;8053
N ;;Enter a number;8054
D ;;Enter a date;8055
L ;;Enter a list or range of numbers;8056
P ;;Select: ;8057
F1 ;;;This response can be free text;9031
S1 ;;;Enter a code from the list.;9032
Y1 ;;;Enter either 'Y' or 'N'.;9040
E1 ;;;Enter either RETURN or '^';9033
N1 ;;;This response must be a number;9034
D1 ;;;This response must be a date;9035
L1 ;;;This response must be a list or range, e.g., 1,3,5 or 2-4,8;9036
 ;
 ;#349   String too long by |nuber| character(s)!
 ;#350   String too long! '^' to quit.
 ;#8041  This is a required response...
 ;#8042  Select |1|
 ;#8043  and time
 ;#8044  and optional time
 ;#8045  Enter |1|
 ;#8046  Select one of the following
 ;#8047  Replace
 ;#8048  With
