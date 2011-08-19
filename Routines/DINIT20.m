DINIT20 ;SFISC/XAK-INITIALIZE VA FILEMAN ;10:36 AM  30 Oct 1998
 ;;22.0;VA FileMan;;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
DD F I=1:1 S X=$T(DD+I),Y=$P(X," ",3,99) G ^DINIT22:X?.P S @("^DD(1.1,"_$E($P(X," ",2),3,99)_")=Y")
 ;;0 FIELD^^4.2^16
 ;;0,"ID","WRITE" N % S %=$P(^(0),U,2) D EN^DDIOL("   "_$E(%,4,5)_"-"_$E(%,6,7)_"-"_$E(%,2,3)_"@"_$E($P(%_"0000",".",2),1,4),"","?0")
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
 ;;1,0 ENTRY NAME^CJ30^^ ; ^S %=^DIC(DIA,0,"GL"),X=^DIA(DIA,D0,0),X=$S($D(@(%_+X_",0)")):$P(^(0),U,1),1:""),C=$S($D(^DD(DIA,.01,0)):$P(^(0),U,2),1:""),Y=X D:Y]"" Y^DIQ:C]"" S X=Y,C=","
 ;;1,9 ^
 ;;1.1,0 FIELD NAME^CJ50X^^ ; ^S Y(1.1,1.1)=$S($D(^DIA(DIA,D0,0)):$P(^(0),U,3),1:"") X ^DD(1.1,1.1,9.2) K Y(1.1) S X=$E(X,1,$L(X)-1)
 ;;1.1,9 ^
 ;;1.1,9.2 X ^DD(1.1,1.1,9.3) S X="" F %=1:1:%-1 S X=X_Y(1.1,%)_","
 ;;1.1,9.3 S X1=DIA F %=1:1 S X=$P(Y(1.1,1.1),",",%) Q:X=""  S Y(1.1,%)=$S($D(^DD(X1,X,0)):$P(^(0),U,1,2),1:"????"),X1=+$P(Y(1.1,%),U,2),Y(1.1,%)=$P(Y(1.1,%),U,1)
 ;;2,0 OLD VALUE^CJ80^^ ; ^S X=$S($D(^DIA(DIA,D0,2)):^(2),1:"<no previous value>")
 ;;2,9 ^
 ;;2.1,0 OLD INTERNAL VALUE^F^^2.1;1^K:$L(X)>30 X
 ;;2.2,0 DATATYPE OF OLD VALUE^S^S:SET;P:POINTER;V:VARIABLE POINTER;^2.1;2^Q
 ;;3,0 NEW VALUE^CJ80^^ ; ^S X=$S($D(^DIA(DIA,D0,3)):^(3),1:"<deleted>")
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
 ;;4.2,23,1,0 This is a Variable Pointer field who's value is obtain from the local
 ;;4.2,23,2,0 variable XQORNOD, which is in the form ien;global root.  It can either
 ;;4.2,23,3,0 point to the Option file or to the Protocol file.
 ;;4.2,"V",0 ^.12P^2^2
 ;;4.2,"V",1,0 19^What Option was used?^1^O^^n
 ;;4.2,"V",2,0 101^What Protocol was used?^2^P^^n
