RGUTDIC ;CAIRO/DKM - Encapsulated FileMan API;04-Sep-1998 11:26;DKM
 ;;2.1;RUN TIME LIBRARY;;Mar 22, 1999
 ;=================================================================
 ; Parameterized routine to add/edit/extract an entry in a
 ; FileMan file.  Encapsulates global structure info so no
 ; need to specify this directly.
 ; Inputs:
 ;    %RGDIC = Global root, file number, or bookmark
 ;    %RGCMD = n    : IEN of entry to process
 ;             0    : Process last IEN referenced
 ;             +n   : Move down to subfile n
 ;             -    : Move up to parent file
 ;             @n   : Delete IEN #n (or last referenced if missing)
 ;             =x;y : Lookup y at current level using options in x
 ;             ?x;y ; Lookup y using RGUTLKP utility with options in x
 ;             >x;y : Read fields specified in y using options in x
 ;             <x;y : Write fields specified in y using options in x
 ;             ~x;y : Same as <, but creates new entry
 ;             %n   : Force DINUM to n
 ; Outputs:
 ;     Returns in the first piece the IEN of the entry or...
 ;      0 = Entry was deleted
 ;     -1 = Entry was rejected
 ;     -2 = Entry locked by another process
 ;     -3 = Unexpected error
 ;=================================================================
ENTRY(%RGDIC,%RGCMD) ;
 S %RGDIC(0)=+$G(DUZ)
 N DUZ,DIC,DINUM,DIE,DIQ,DIQUIET,DIK,%RGX,%RGIEN,%RGARG,%RGN1,%RGN2,%RGZ,X,Y
 N DA,DC,DD,DG,DH,DK,DL,DO,DQ,DR,DU,DV,DW,DY
 S DUZ=%RGDIC(0),DUZ(0)="@",@$$TRAP^RGZOSF("ERROR^RGUTDIC"),%RGCMD=$G(%RGCMD),%RGIEN="",DIQUIET=1
 ; Build the bookmark if a global reference or file # passed
 I %RGDIC'[U D
 .S:%RGDIC'=+%RGDIC %RGDIC=+$O(^DIC("B",%RGDIC,0))
 .S %RGDIC=$$ROOT^DILFD(%RGDIC)_U_U_%RGDIC
 I $P(%RGDIC,U,4)="" D
 .S %RGZ=U_$P(%RGDIC,U,2),%RGZ=$E(%RGZ,1,$L(%RGZ)-1),%RGZ=%RGZ_$S(%RGZ["(":")",1:"")
 .S $P(%RGDIC,U,4)=$P(@%RGZ@(0),U,2)
 F %RGN1=1:1:$L(%RGCMD,"|") S %RGARG=$P(%RGCMD,"|",%RGN1),%RGZ=$E(%RGARG) D  Q:%RGIEN<0
 .S %RGN2=$F("-+=@><~?%",%RGZ)
 .S:%RGN2 %RGN2=%RGN2-1,%RGARG=$E(%RGARG,2,999)
 .D DA,@%RGN2
 .S:%RGIEN>0 $P(%RGDIC,U,3)=%RGIEN
 S $P(%RGDIC,U)=%RGIEN
 Q %RGDIC
 ; Set IEN
0 S:%RGARG'<0 %RGIEN=$S($D(@%RGDIC(2)@(+%RGARG)):+%RGARG,1:0),$P(%RGDIC,U,3)=%RGIEN
 Q
 ; Move up to parent file
1 N %RGX,%RGY
 S $P(%RGDIC,U,4)=$P($P(%RGDIC,U,4),"|",2,999)
 S %RGY=$P(%RGDIC,U,2),%RGX=$L(%RGY,"|"),$P(%RGDIC,U,2)=$P(%RGY,"|",1,%RGX-1)
 S %RGIEN=+$P(%RGY,"|",%RGX),$P(%RGDIC,U,3)=%RGIEN
 D DA
 Q
 ; Move down to subfile
2 N %RGX,%RGY,%RGZ
 I $P(%RGDIC,U,3)'>0 S %RGIEN=-1 Q
 S %RGY=+$P(%RGDIC,U,4)
 S:%RGARG'=+%RGARG %RGARG=+$O(^DD(%RGY,"B",%RGARG,0)),%RGARG=+$P($G(^DD(%RGY,%RGARG,0)),U,2)
 S %RGX=+%RGARG,%RGZ=+$O(^DD(%RGY,"SB",%RGX,0)),%RGZ=$P($P(^DD(%RGY,%RGZ,0),U,4),";"),%RGX=$P(^(0),U,2)
 S:%RGZ'=+%RGZ %RGZ=""""_%RGZ_""""
 S $P(%RGDIC,U,4)=%RGX_"|"_$P(%RGDIC,U,4),$P(%RGDIC,U,2)=$P(%RGDIC,U,2)_"|"_$P(%RGDIC,U,3)_","_%RGZ_","
 S %RGIEN="",$P(%RGDIC,U,3)=""
 D DA
 Q
 ; Lookup an entry
3 N X,Y
 I %RGARG[";" S DIC(0)=$P(%RGARG,";"),%RGARG=$P(%RGARG,";",2,999)
 E  S DIC(0)="XMF"
 S DIC=%RGDIC(1),X=%RGARG
 D ^DIC
 S %RGIEN=+Y
 Q
 ; Delete an entry
4 N X,Y
 S:%RGARG DA=%RGARG
 S DIK=%RGDIC(1),%RGIEN=0
 D ^DIK
 Q
 ; Extract data
5 N %RGZ,%RGZ1,%RGX,%RGY
 I '%RGIEN S %RGIEN=-1 Q
 S DR=""
 F %RGX=2:1:$L(%RGARG,";") D
 .S %RGY=$P(%RGARG,";",%RGX)
 .I %RGY["=" S %RGZ=$$FLD($P(%RGY,"=",2)),%RGZ1(%RGZ,$P(%RGY,"="))="",%RGY=%RGZ
 .S DR=DR_$S($L(DR):";",1:"")_%RGY
 S DIC=%RGDIC(1),DIQ(0)=$P(%RGARG,";")
 S:DIQ(0)="" DIQ(0)="E"
 K ^UTILITY("DIQ1",$J)
 D
 .N X,Y
 .D EN^DIQ1
 F %RGX=0:0 S %RGX=$O(%RGZ1(%RGX)),%RGZ="" Q:'%RGX  D
 .F  S %RGZ=$O(%RGZ1(%RGX,%RGZ)),%RGZ1="" Q:%RGZ=""  D
 ..F %RGY="E","I" D
 ...S:$D(^UTILITY("DIQ1",$J,+$P(%RGDIC,U,4),%RGIEN,%RGX,%RGY)) %RGZ1=%RGZ1_$S($L(%RGZ1):U,1:"")_^(%RGY)
 ..S @%RGZ=%RGZ1
 Q
 ; Edit existing entry
6 S DIC(0)=$P(%RGARG,";"),DIC("P")=$P($P(%RGDIC,U,4),"|"),%RGARG=$P(%RGARG,";",2,999)
 I %RGIEN'>0 S %RGIEN=-1 Q
 S DIE=%RGDIC(1),DR=%RGARG
 L +@%RGDIC(2)@(%RGIEN):$S(DIC(0)["!":9999999,1:0)
 E  S %RGIEN=-2 Q
 D ^DIE
 L -@%RGDIC(2)@(%RGIEN)
 S %RGIEN=+$G(DA)
 Q
 ; Create new entry
7 N X,Y,DD,DO,DLAYGO
 S DIC=%RGDIC(1),DIC(0)=$P(%RGARG,";")_"L",DIC("P")=$P($P(%RGDIC,U,4),"|"),Y=$P(%RGARG,";",2),%RGARG=DIC(0)_";"_$P(%RGARG,";",3,999),DLAYGO=DIC("P")\1
 I +Y'=.01 S %RGIEN=-1 Q
 S X=$P(Y,"/",4)
 S:X="" X=$P(Y,"/",5)
 X:$E(X)=U $E(X,2,999)
 I $P(^DD(+DIC("P"),.01,0),U,2)["W" D
 .D WP
 E  D ^DIC:DIC(0)'["U",FILE^DICN:DIC(0)["U"
 S %RGIEN=+Y
 I %RGIEN>0,$P(%RGARG,";",2,99)'="" D DA,6
 K DINUM
 Q
8 ; Lookup entry
 N %RGOPT,%RGP,RGFN
 S %RGOPT=$P(%RGARG,";"),%RGARG=$P(%RGARG,";",2,999),RGFN=+$P(%RGDIC,U,4)
 S %RGP=+$P(%RGDIC,U,4),%RGP=$P($G(^DD(%RGP,.01,0)),U)
 S:$L(%RGP) %RGP=%RGP_": "
 S %RGIEN=$$ENTRY^RGUTLKP(%RGDIC(2),%RGOPT,%RGP,"",%RGARG,"","",$X,$Y,"","","HLP^RGUTDIC")
 Q
 ; Force DINUM
9 S DINUM=%RGARG
 Q
HLP W $G(^DD(+RGFN,.01,3)),!
 Q
 ; Word processing field (special case of #7)
WP N %RGZ,%RGZ1
 I X="@" D
 .K @%RGDIC(2)
 .S Y=0
 E  D
 .S %RGZ=$G(@%RGDIC(2)@(0)),Y=$G(DINUM,1+$O(^($C(1)),-1))
 .S %RGZ1=+$P(%RGZ,U,4),%RGZ=+$P(%RGZ,U,3)
 .S:Y>%RGZ %RGZ=Y
 .S:'$D(^(Y)) %RGZ1=%RGZ1+1
 .S ^(0)=U_U_%RGZ_U_%RGZ1_U_$G(DT),^(Y,0)=X
 Q:$P(^DD(+DIC("P"),.01,0),U,2)'["a"
 S %RGIEN=Y
 D DA,WPAUDIT^RGCODAUD(+DIC("P"),.DA,X,"")
 Q
 ; Trap unexpected error
ERROR S $P(%RGDIC,U)=-3
 Q %RGDIC
 ; Return field #
FLD(X) Q $S(X=+X:X,1:+$O(^DD(+$P(%RGDIC,U,4),"B",X,0)))
 ; Set up DA array
DA N %RGZ,%RGZ1,%RGZ2
 K DA
 S:'$G(%RGIEN) %RGIEN=$P(%RGDIC,U,3)
 S %RGZ=$P(%RGDIC,U,2),%RGZ2=$L(%RGZ,"|"),DA=%RGIEN
 F %RGZ1=2:1:%RGZ2 S DA(%RGZ2-%RGZ1+1)=+$P(%RGZ,"|",%RGZ1)
 S %RGDIC(1)=U_$TR($P(%RGDIC,U,2),"|"),%RGDIC(2)=$E(%RGDIC(1),1,$L(%RGDIC(1))-1),%RGDIC(2)=%RGDIC(2)_$S(%RGDIC(2)["(":")",1:"")
 Q
