DINIT20 ;SFISC/XAK-INITIALIZE VA FILEMAN ;29MAR2013
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**999,1001,1009,1040,1045**
 ;
DD F I=1:1 S X=$T(DD+I),Y=$P(X," ",3,99) G ^DINIT22:X?.P S @("^DD(1.1,"_$E($P(X," ",2),3,99)_")=Y")
 ;;0 FIELD^^4.2^16
 ;;0,"ID","WRITE" N % S %=$P(^(0),U,2) D EN^DDIOL("   "_$$NAKED^DIUTL("$$DATE^DIUTL(%)"),"","?0")
 ;;0,"NM","AUDIT"
 ;;.001,0 NUMBER^NJ7,0^^ ^K:+X'=X!(X<1)!(X?.E1"."1N.N) X
 ;;.001,3 A whole number greater than 1.
 ;;.01,0 INTERNAL ENTRY NUMBER^RF^^0;1^K:X[""""!($A(X)=45) X I $D(X) K:$L(X)>16!($L(X)<1)!'(X'?1P.E) X
 ;;.01,.1 The Internal Number of the Entry that has been audited.
 ;;.01,1,0 ^.1
 ;;.01,1,1,0 1.1^B
 ;;.01,1,1,1 S ^DIA(DIA,"B",$E(X,1,30),DA)=""
 ;;.01,1,1,2 K ^DIA(DIA,"B",$E(X,1,30),DA)
 ;;.02,0 DATE/TIME RECORDED^RD^^0;2^S %DT="ETXR" D ^%DT S X=Y K:Y<1 X
 ;;.02,1,0 ^.1
 ;;.02,1,1,0 1.1^C
 ;;.02,1,1,1 S ^DIA(DIA,"C",$E(X,1,30),DA)=""
 ;;.02,1,1,2 K ^DIA(DIA,"C",$E(X,1,30),DA)
 ;;.03,0 FIELD NUMBER^RF^^0;3^K:$L(X)>10!$L(X)<1) X
 ;;.03,3 The number of the field that was audited.
 ;;.04,0 USER^RP200'^VA(200,^0;4^Q
 ;;.04,1,0 ^.1
 ;;.04,1,1,0 1.1^D
 ;;.04,1,1,1 S ^DIA(DIA,"D",$E(X,1,30),DA)=""
 ;;.04,1,1,2 K ^DIA(DIA,"D",$E(X,1,30),DA)
 ;;.05,0 RECORD ADDED^S^A:Added Record;^0;5^Q
 ;;.05,21,0 ^^2^2^2981028^
 ;;.05,21,1,0 When a new recorded is added to a file (sub-file) and the .01 field is
 ;;.05,21,2,0 being audited, then this field will be set to an 'A'.
 ;;.06,0 ACCESSED^S^i:INQUIRED TO ENTRY^0;6
 ;;.06,21,0 ^^2^2
 ;;.06,21,1,0 This flag (settable by ACCESSED^DIET) is designed to record that a user LOOKED UP the Entry, without necessarily
 ;;.06,21,2,0 changing it.  Such an audit might be set by the POST-SELECTION ACTION of a File, e.g. for HIPAA.
 ;;1,0 ENTRY NAME^CJ30^^ ; ^N C,Y S Y=^DIC(DIA,0,"GL"),X=^DIA(DIA,D0,0),Y=$P($G(@(Y_+X_",0)")),U),C=$P($G(^DD(DIA,.01,0)),U,2) D Y^DIQ:C]"" S X=Y
 ;;1,9 ^
 ;;1.1,0 FIELD NAME^CJ50X^^ ; ^S Y(1.1,1.1)=$S($D(^DIA(DIA,D0,0)):$P(^(0),U,3),1:""),X="" Q:$P($G(^(0)),U,6)="i"  X ^DD(1.1,1.1,9.2) K Y(1.1) S X=$E(X,1,$L(X)-1)
 ;;1.1,9 ^
 ;;1.1,9.2 X ^DD(1.1,1.1,9.3) S X="" F %=1:1:%-1 S X=X_Y(1.1,%)_","
 ;;1.1,9.3 S X1=DIA F %=1:1 S X=$P(Y(1.1,1.1),",",%) Q:X=""  S Y(1.1,%)=$S($D(^DD(X1,X,0)):$P(^(0),U,1,2),1:"????"),X1=+$P(Y(1.1,%),U,2),Y(1.1,%)=$P(Y(1.1,%),U,1)
 ;;2,0 OLD VALUE^CJ80^^ ; ^S X=$G(^DIA(DIA,D0,2)) I X="" Q:$P($G(^(0)),U,6)="i"!$D(^(2.14))  S X="<no previous value>"
 ;;2,9 ^
 ;;2.1,0 OLD INTERNAL VALUE^F^^2.1;1^K:$L(X)>30 X
 ;;2.2,0 DATATYPE OF OLD VALUE^S^S:SET;P:POINTER;V:VARIABLE POINTER;^2.1;2^Q
 ;;2.14,0 OLD W-P TEXT^Cm^^ ; ^X "N I,X F I=0:0 S I=$O(^DIA(DIA,D0,2.14,I)) Q:'I  S X=$G(^(I,0)) X DICMX"
 ;;2.9,0 PATIENT^Cp2^^ ; ^N A,% S %=$G(^DIC(DIA,0,"GL")),A=+$G(^DIA(DIA,D0,0)) X ^DD(1.1,2.9,9.2)
 ;;2.9,9 ^
 ;;2.9,9.1 N A,% S %=$G(^DIC(DIA,0,"GL")),A=+$G(^DIA(DIA,D0,0)) X ^DD(1.1,2.9,9.2)
 ;;2.9,9.2 S X="",X=$S(DIA=2:A,DIA=9000001:A,1:"") X ^DD(1.1,2.9,9.3):'X
 ;;2.9,9.3 N I,GL S I=$S($O(^DD(2,0,"PT",DIA,0)):+$O(^(0)),1:$O(^DD(9000001,0,"PT",DIA,0))) I I S GL=$P($G(^DD(DIA,I,0)),U,4) I GL'="" S X=$S($D(@(%_+A_","_$P(GL,";")_")")):$P(^(0),U,+$P(GL,";",2)),1:"") X:X[";" ^DD(1.1,2.9,9.4)
 ;;2.9,9.4 S X=$S(X[";DPT(":+X,X[";AUPNPAT(":+X,1:"")
 ;;3,0 NEW VALUE^CJ80^^ ; ^S X=$G(^DIA(DIA,D0,3)) I X="",$G(^(2))]"" S X="<deleted>"
 ;;3,9 ^
 ;;3.1,0 NEW INTERNAL VALUE^F^^3.1;1^K:$L(X)>30 X
 ;;3.2,0 DATATYPE OF NEW VALUE^S^S:SET;P:POINTER;V:VARIABLE POINTER;^3.1;2^Q
 ;;4.1,0 MENU OPTION USED^P19'^DIC(19,^4.1;1^Q
 ;;4.1,21,0 ^^2^2^2981021^^
 ;;4.1,21,1,0 This is the Option that the Kernel menu system used to change the audited
 ;;4.1,21,2,0 data.
 ;;4.1,23,0 ^^2^2^2981021^
 ;;4.1,23,1,0 This field contains the value of +XQY and is a direct pointer to the
 ;;4.1,23,2,0 OPTION FILE (#19).
 ;;4.2,0 PROTOCOL or OPTION USED^V^^4.1;2^Q
 ;;4.2,3 Answer must be 1-63 characters in length.
 ;;4.2,21,0 ^^2^2^2981021^
 ;;4.2,21,1,0 This is the Protocol or Option (type Protocol) that was used when the
 ;;4.2,21,2,0 audit took place.
 ;;4.2,23,0 ^^3^3^2981021^^
 ;;4.2,23,1,0 This is a Variable Pointer field whose value is obtained from the local
 ;;4.2,23,2,0 variable XQORNOD, which is in the form ien;global root.  It can either
 ;;4.2,23,3,0 point to the Option file or to the Protocol file.
 ;;4.2,"V",0 ^.12P^2^2
 ;;4.2,"V",1,0 19^What Option was used?^1^O^^n
 ;;4.2,"V",2,0 101^What Protocol was used?^2^P^^n
