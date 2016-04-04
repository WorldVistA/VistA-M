DICR ;SFISC/GFT-RECURSIVE CALL FOR X-REFS ON TRIGGERED FLDS ;6DEC2004
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**11,88,157**
 ;
 ;From a TRIGGER on field DIH,DIG
 ;DIU is old value, DIV new
AUDIT I $P(^DD(DIH,DIG,0),U,2)["a" D  ;NOIS ISB-1102-31285
 .N DIANUM,DIIX,C,DP
 .I DIU]"" S X=DIU,DIIX=2_U_DIG,DP=DIH D AUDIT^DIET
 .I DIV]"",^DD(DIH,DIG,"AUDIT")'="e"!(DIU]"") S X=DIV,DIIX=3_U_DIG,DP=DIH D AUDIT^DIET ;Don't audit NEW if there's no OLD and mode is EDIT ONLY
 Q:'$O(^DD(DIH,DIG,1,0))&'$D(^DD("IX","F",DIH,DIG))
 N DICRIENS,DICRBADK
 I $D(^DD("KEY","F",DIH,DIG)) D  Q:$G(DICRBADK)
 . N DICRFDA,DICRMSG,DIERR
 . D SAVE
 . S DICRIENS=$$IENS(DIH,.DA)
 . S DICRFDA(DIH,DICRIENS,DIG)=DIV
 . I '$$KEYVAL^DIE("","DICRFDA","DICRMSG") D
 .. S DICRBADK=1
 .. S X=DIU X $$HSET(DIH,DIG)
 . D RESTORE
 ;
 I DIU]"" F DIW=0:0 S DIW=$O(^DD(DIH,DIG,1,DIW)),X=DIU Q:'DIW  I $P(^(DIW,0),U,3)=""!'$D(DB(0,DIH,DIG,DIW,2)) S DB(0,DIH,DIG,DIW,2)=1 D SAVE X ^(2) D RESTORE
 I DIV]"" F DIW=0:0 S DIW=$O(^DD(DIH,DIG,1,DIW)),X=DIV Q:'DIW  I $P(^(DIW,0),U,3)=""!'$D(DB(0,DIH,DIG,DIW,1)) S DB(0,DIH,DIG,DIW,1)=1 D SAVE X ^(1) D RESTORE
 ;
 I $D(^DD("IX","F",DIH,DIG)) D
 . N DICRCTRL,DICRVAL,I
 . D SAVE
 . S:$D(DICRIENS)[0 DICRIENS=$$IENS(DIH,.DA)
 . S DICRVAL(DIH,DICRIENS,DIG,"O")=DIU
 . S DICRVAL(DIH,DICRIENS,DIG,"N")=DIV
 . S:$G(DICRREC)]"" DICRCTRL="r"
 . S DICRCTRL("VAL")="DICRVAL("
 . D INDEX^DIKC(DIH,.DA,DIG,"",.DICRCTRL)
 . D:$G(DICRREC)]"" @DICRREC
 . D RESTORE
Q Q
 ;
SAVE F DB=1:1 Q:'$D(DB(DB))
 F Y="DIC","DIV","DA" S %="" F DB=DB:0 S @("%=$O("_Y_"(%))") Q:%=""  S DB(DB,Y,%)=@(Y_"(%)")
 F %="DIC","DIW","DIU","DIV","DIH","DIG","DB","DG","DA","DICR" S DB(DB,%)="" I $D(@%)#2 S DB(DB,%)=@%
 K DA F Y=-1:1 Q:'$D(DIV(Y+1))
 I Y+1 S DA=DIV(Y) F %=Y-1:-1:0 S DA(Y-%)=DIV(%)
 Q
 ;
RESTORE F DB=1:1 Q:'$D(DB(DB+1))
 F Y="DIC","DIV","DA" K @Y S %="" F DB=DB:0 S %=$O(DB(DB,Y,%)) Q:%=""  S @(Y_"(%)=DB(DB,Y,%)")
 S Y="" F %=0:0 S Y=$O(DB(DB,Y)) Q:Y=""  S @Y=DB(DB,Y)
 K DB(DB) K:DB=1 DB Q
 ;
DICL N I
 K DIC("S"),DLAYGO I '$P(Y,U,3) K DIC Q
DICADD ;
 S (D0,DIV(0))=+Y,DIV(U)=Y
 I DIC S DIH=DIC,DIC=^DIC(DIC,0,"GL")
 E  S @("DIH=+$P("_DIC_"0),U,2)")
 S DICR=$S($D(DA)#2:DA,1:0),DA=D0 F DIG=.001:0 S DIG=$O(DIC(DIG)) Q:DIG'>0  D U:DIC(DIG)]""
 S DA=DICR,Y=DIV(U) K DIC Q
 ;
U S %=$P(^DD(DIH,DIG,0),U,4),Y=$P(%,";",2),%=$P(%,";",1),X="",DIV=DIC(DIG) I @("$D("_DIC_DIV(0)_",%))") S X=^(%)
 G P:Y,Q:Y'?1"E"1N.NP S D=+$E(Y,2,9),Y=$P(Y,",",2),DIU=$E(X,D,Y) I DIU?." " S DIU="" S:$L(X)+1<D X=X_$J("",D-1-$L(X))
 S ^(%)=$E(X,1,D-1)_DIV_$E(X,Y+1,999)
 G DICR
P S DIU=$P(X,U,Y),$P(^(%),U,Y)=DIV
 G DICR
CONV ;
 K DA F %=0:1 Q:'$D(@("D"_%))
 S %=%-1 I '% S DA=D0 K % Q
 S DA=@("D"_%),%=%-1,Y=0
 F %1=%:-1:0 S Y=Y+1,DA(Y)=@("D"_%1)
 K %,%1,Y
 Q
SD ;
 S DIV(0)=DA D U:DA>0 K DA,DIH,DIG,DIV Q
 ;
TRIG(DICRLIST,DICROUT) ;Modify the trigger logic of fields that trigger fields
 ;in DICRLIST so that they call ^DICR unconditionally.
 ;In:
 ; DICRLIST(file#,field#) = array of potentionally triggered fields
 ;Out:
 ; DICROUT(file,field)="" (of triggering field modified)
 ;
 N DICRFIL,DICRFLD
 S DICRFIL=""
 F  S DICRFIL=$O(DICRLIST(DICRFIL)) Q:'DICRFIL  D
 . S DICRFLD=""
 . F  S DICRFLD=$O(DICRLIST(DICRFIL,DICRFLD)) Q:'DICRFLD  D TRMOD(DICRFIL,DICRFLD,.DICROUT)
 Q
 ;
TRMOD(DICRFIL,DICRFLD,DICROUT) ;Modify the trigger logic of fields that
 ;trigger a field so that they call ^DICR unconditionally.
 ;In:
 ; DICRFIL = file# of triggered field
 ; DICRFLD = triggered field#
 ;Out:
 ; DICROUT(file,field)="" (of triggering field modified)
 ;
 ;Loop through 5 node to get triggering fields/xrefs
 N DICRN,DICRFL,DICRFD,DICRXR
 S DICRN=0
 F  S DICRN=$O(^DD(DICRFIL,DICRFLD,5,DICRN)) Q:'DICRN  D
 . S DICRXR=$G(^DD(DICRFIL,DICRFLD,5,DICRN,0))
 . S DICRFL=+$P(DICRXR,U),DICRFD=+$P(DICRXR,U,2),DICRXR=+$P(DICRXR,U,3)
 . Q:'DICRFL!'DICRFD!'DICRXR
 . D MOD(DICRFL,DICRFD,DICRXR,.DICROUT)
 Q
 ;
MOD(DICRFL,DICRFD,DICRXR,DICROUT) ;Modify trigger logic
 ;In:
 ; DICRFL = file# of triggering field
 ; DICRFD = field# of triggering field
 ; DICRXR = xref# of trigger
 ;Out:
 ; DICROUT(file,field)="" (if trigger was modified)
 ;
 Q:'$D(^DD(DICRFL,DICRFD,1,DICRXR))
 N DICRMOD,DICRND,DICRSTR,DICRVAL
 ;
 ;Loop through xref nodes
 S DICRND=0
 F  S DICRND=$O(^DD(DICRFL,DICRFD,1,DICRXR,DICRND)) Q:'DICRND  D
 . S DICRVAL=$G(^DD(DICRFL,DICRFD,1,DICRXR,DICRND)),DICRMOD=0
 . F DICRSTR="D ^DICR:$O(^DD(DIH,DIG,1,0))>0","D ^DICR:$N(^DD(DIH,DIG,1,0))>0" D
 .. F  Q:DICRVAL'[DICRSTR  D
 ... S DICRVAL=$P(DICRVAL,DICRSTR)_"D ^DICR"_$P(DICRVAL,DICRSTR,2,999)
 ... S DICRMOD=1
 . Q:'DICRMOD
 . S ^DD(DICRFL,DICRFD,1,DICRXR,DICRND)=DICRVAL
 . S DICROUT(DICRFL,DICRFD)=""
 Q
 ;
IENS(FIL,DA) ;Build IENS
 N I,IENS
 S IENS=DA_","
 F I=1:1:$$FLEV^DIKCU(FIL) S IENS=IENS_DA(I)_","
 Q IENS
 ;
HSET(FIL,FLD) ;Hard set a value in the file
 Q:$P($G(^DD(FIL,FLD,0)),U)="" ""
 ;
 N HSET,ND,PC,OROOT
 S PC=$P($G(^DD(FIL,FLD,0)),U,4)
 S ND=$P(PC,";"),PC=$P(PC,";",2) Q:ND?." "!("0 "[PC) ""
 S:ND'=+$P(ND,"E") ND=""""_ND_""""
 ;
 S OROOT=$$FROOTDA^DIKCU(FIL,"O")_"DA," Q:OROOT="DA,"
 I PC S HSET="S $P("_OROOT_ND_"),U,"_PC_")=X"
 E  S HSET="S $E("_OROOT_ND_"),"_+$E(PC,2,999)_","_$P(PC,",",2)_")=X"
 Q HSET
