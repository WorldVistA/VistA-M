DINIT11 ;SFISC/GFT,XAK-INITIALIZE VA FILEMAN ;20DEC2010
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**167**
 ;
DD F I=1:1 S X=$T(DD+I),Y=$P(X," ",3,99) G ^DINIT11A:X?.P S @("^DD("_$E($P(X," ",2),3,99)_")=Y")
 ;;0,23,0 TECHNICAL DESCRIPTION^.001^^23;0
 ;;0,50,0 DATE FIELD LAST EDITED^D^^DT;1^Q
 ;;0,50,9 ^
 ;;0,999,0 TRIGGERED-BY POINTER^.15^^5;0
 ;;0,999,9 ^
 ;;.1,0,"NM","CROSS-REFERENCE"
 ;;.1,0 CROSS-REFERENCE^
 ;;.1,.01,0 INDEX^F^^0;E1,245^Q
 ;;.1,.01,1,0 ^.1^3^3
 ;;.1,.01,1,1,0 0^IX
 ;;.1,.01,1,1,1 S:$P(X,U,2)]"" @("^DD("_$P(X,"^",1)_",0,""IX"",$P(X,""^"",2),DA(2),DA(1))=""""")
 ;;.1,.01,1,1,2 K:$P(X,U,2)]"" @("^DD("_$P(X,"^",1)_",0,""IX"",$P(X,""^"",2),DA(2),DA(1))")
 ;;.1,.01,1,2,0 DA(2)^IX
 ;;.1,.01,1,2,1 S ^DD(DA(2),"IX",DA(1))=""
 ;;.1,.01,1,2,2 I $O(^DD(DA(2),DA(1),1,0))=DA,$O(^(DA))="" K ^DD(DA(2),"IX",DA(1))
 ;;.1,.01,1,3,0 ^^TRIGGER
 ;;.1,.01,1,3,1 S Y=$P(X,U,5),X=$P(X,U,4),Z=DA(2)_U_DA(1)_U_DA I Y F %=1:1 Q:'%  S %1=$S($D(^DD(X,Y,5,%,0)):^(0),1:0) Q:%1=Z  I '%1 S ^(0)=Z F %=-1:0 S ^DD(X,"TRB",DA(2),DA(1),DA,Y)="",Y=X Q:'$D(^DD(X,0,"UP"))  S X=^("UP"),Y=$O(^DD(X,"SB",Y,0))
 ;;.1,.01,1,3,2 S Y=$P(X,"^",5),X=$P(X,"^",4) I Y S %=0 F  S %=$O(^DD(X,Y,5,%)) Q:%=""  Q:'$D(^(%,0))  I DA(2)_"^"_DA(1)_"^"_DA=^(0) K ^DD(X,Y,5,%) F  K ^DD(X,"TRB",DA(2),DA(1),DA,Y) Q:'$D(^DD(X,0,"UP"))  S Y=X,X=^("UP"),Y=$O(^DD(X,"SB",Y,0))
 ;;.1,1,0 SET STATEMENT^K^^1;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;.1,1,3 This is Standard MUMPS code.
 ;;.1,1,21,0 ^^3^3^2890802^
 ;;.1,1,21,1,0 Enter Standard MUMPS code which will set this cross-reference.
 ;;.1,1,21,2,0 You may use X to reference the data in this field and DA-array
 ;;.1,1,21,3,0 to reference the internal entry numbers in the file.
 ;;.1,1,"DEL",1,0 I 1 W $C(7),!,"CAN'T DELETE THIS NODE."
 ;;.1,2,0 KILL STATEMENT^K^^2;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;.1,2,3 This is Standard MUMPS code.
 ;;.1,2,21,0 ^^3^3^2890802^
 ;;.1,2,21,1,0 Enter Standard MUMPS code which will kill this cross-reference.
 ;;.1,2,21,2,0 You may use X to reference the data in this field and the DA-array
 ;;.1,2,21,3,0 to reference the internal entry numbers in the file.
 ;;.1,2,"DEL",1,0 I 1 W $C(7),!,"CAN'T DELETE THIS NODE."
 ;;.1,3,0 NO-DELETION MESSAGE^F^^3;1^K:X[""""!($A(X)=45) X I $D(X) K:$L(X)>245!($L(X)<3) X
 ;;.1,3,1,0 ^.1
 ;;.1,3,1,1,0 .1^AC^MUMPS
 ;;.1,3,1,1,1 Q
 ;;.1,3,1,1,2 K:^DD(DA(2),DA(1),1,DA,3)']"" ^(3)
 ;;.1,3,3 Answer must be 3-245 characters in length.
 ;;.1,3,21,0 ^^2^2^2890803^^
 ;;.1,3,21,1,0 Enter a message if you want to prevent this cross-reference from being
 ;;.1,3,21,2,0 deleted.
 ;;.1,4,0 DATE UPDATED^D^^DT;1^S %DT="ET" D ^%DT S X=Y K:Y<1 X
 ;;.1,10,0 DESCRIPTION^.101^^%D;0
 ;;.1,"IX",.01
 ;;.1,666,0 RE-INDEXING^SI^1:NO RE-INDEXING ALLOWED;0:ALLOW REINDEXING^NOREINDEX;1
 ;;.1,666,3 Should the re-indexing of this cross reference be prohibited?
 ;;.1,666,21,0 ^^5^5
 ;;.1,666,21,1,0 If you answer '1', this cross reference will not be re-indexed during a
 ;;.1,666,21,2,0 general re-indexing of this file, whether it's done via API or
 ;;.1,666,21,3,0 interactively. If you answer '0', which is the default, it will. A cross
 ;;.1,666,21,4,0 reference will be re-indexed if it is specifically named in an API call.
 ;;.1,666,21,5,0 For those APIs which re-index a single record, this restriction is ignored.
 ;;.101,0 DESCRIPTION SUB-FIELD^^.01^1
 ;;.101,0,"UP" .1
 ;;.101,.01,0 DESCRIPTION^W^^0;1^Q
