XTEDTVXD ;SF/RWF - Call VMS EDT editor for a WP field. ;03/23/2004  10:38
 ;;7.3;TOOLKIT;**11,70**;Apr 25, 1995
A ;
DSM ;Entry point for DSM on VMS
 S:$D(IO)[0 IO=$I Q:^%ZOSF("OS")'["VAX"
 N FN,I,C,F,X
 D DPUT X "S X=$ZC(%EDT,FN)" D DGET
 Q
DPUT ;DSM, Put current data in VMS file
 S FN="DIWE$"_$J_".TMP" X "C FN O FN:(NEWVERSION:PROT=(W=RWD))"
 U FN X "F I=0:0 S I=$O("_DIC_"I)) Q:I'>0  W ^(I,0),!"
 C FN
 Q
DGET ;DSM, Get data from VMS file, Expand tab, Strip control.
 N $ES,$ET,%A S $ET="G DERR^XTEDTVXD"
 X "O FN:(READONLY:DELETE)" K @($E(DIC,1,$L(DIC)-1)_")")
 S C=$$CTRL
 U FN F I=1:1 R X#255:60 D SAVE(I,X) Q:$ZA=-1
DERR U IO S DWLC=I-1,$EC="" X "C FN O FN C FN:DELETE" ;Clean-up both copies
 Q
 ;
CTRL() ;Return control char to remove
 ;9 is missing, handle TAB special.
 Q $C(1,2,3,4,5,6,7,8,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31)
 ;
SAVE(I,V) ;Save one line
 S:V[$C(9) V=$$TAB(V) S @(DIC_"I,0)")=$TR(V,C)
 Q
 ;
TAB(S) ;Expand tabs
 N F
 S F=0 F  S F=$F(S,$C(9),F) Q:(F'>0)!($L(S)+8>255)  S S=$E(S,1,F-2)_$J("",8-(F-1#8))_$E(S,F,999)
 Q S
 ;
TPU ;DSM, Call VMS TPU editor.
 S:$D(IO)[0 IO=$I Q:^%ZOSF("OS")'["VAX"
 N FN,I,C,F,X
 D DPUT S X="TPU "_FN X "S X=$ZC(%TPU,X)" D DGET
 Q
 ;
GTMVMS ;Entry point for GT.M on VMS
 N FN,I,C,F,X
 S:$D(IO)[0 IO=$I S X=^%ZOSF("OS") Q:X'["GT.M"
 S FN="DIWE$"_$J_".TMP"
 D GPUT S X="ZSYSTEM ""EDIT "_FN_"""" X X D GGET
 I $L($ZSEARCH(FN)) ZSYSTEM "DEL "_FN_";*"
 Q
 ;
GPUT ;GTM, Put current data in VMS file
 X "C FN O FN:(NEWVERSION:NOREADONLY:VARIABLE)"
 U FN X "F I=0:0 S I=$O("_DIC_"I)) Q:I'>0  W ^(I,0),!"
 C FN
 Q
GGET ;GTM, Get data from VMS file, Expand tab, Strip control.
 N $ES,$ET,%A S $ET="G GERR^XTEDTVXD"
 S C=$$CTRL
 X "O FN:(READONLY)" K @($E(DIC,1,$L(DIC)-1)_")")
 U FN F I=1:1 R X#255:60 D SAVE(I,X) Q:$ZEOF
GERR U IO S DWLC=I-1,$EC="" X "C FN O FN C FN:DELETE" ;Clean-up both copies
 Q
 ;
GTMUNIX ;Entry point for GT.M on Unix
 N FN,I,C,F,X
 S:$D(IO)[0 IO=$I S X=^%ZOSF("OS") Q:X'["GT.M"
 S FN="DIWE$"_$J_".TMP"
 D GPUT X "ZSYSTEM ""vi """_FN D GGET
 I $L($ZSEARCH(FN)) X "ZSYSTEM ""rm """_FN
 Q
 ;
CACHE ;Entry point for Cache/VMS
 N FN,OD,I,C,F,X
 Q:^%ZOSF("OS")'["OpenM"
 S:$D(IO)[0 IO=$I
 S X=$$DEFDIR^%ZISH(""),OD=$ZU(168,X) ;Set working directory to default
 D CPUT X "S X=$ZF(-1,""EDIT ""_FN)" D CGET
 I $L($ZSEARCH(FN)) X "S X=$ZF(-1,""DEL ""_FN_"";*"")"
 S X=$ZU(168,OD) ;Change back
 Q
 ;
CPUT ;Cache, Put current data in VMS file
 S FN="DIWE$"_$J_".TMP" X "O FN:(""NWS"")"
 U FN X "F I=0:0 S I=$O("_DIC_"I)) Q:I'>0  W ^(I,0),!"
 C FN
 Q
 ;
CGET ;Cache, Get data from VMS file, Expand tab, Strip control.
 N $ES,$ET,%A,% S $ET="G CERR^XTEDTVXD"
 S C=$$CTRL
 X "O FN:(""RV"")" S %A=$ZUTIL(68,40),%=$ZUTIL(68,40,1) ;Use $ZEOF
 K @($E(DIC,1,$L(DIC)-1)_")")
 U FN F I=1:1 Q:$ZEOF<0  R X#255:60 D SAVE(I,X)
CERR U IO S DWLC=I-1,$EC="",%=$ZUTIL(68,40,%A)
 X "C FN:""D"" O FN::1 I $T C FN:""D""" ;Clean-up both copies
 Q
