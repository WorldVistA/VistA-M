DIKK1 ;SFISC/MKO-CHECK KEY INTEGRITY ;9:19 AM  5 Feb 1998
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 ;========================
 ; LOADALL(File,Flag,.MF)
 ;========================
 ;Load info about all keys on a file. Use the "B" xref on the Key file.
 ;In:
 ; KFIL = File # [.31,.01]
 ; FLAG [ "s" : don't include subfile under file
 ;Out:
 ; ^TMP("DIKK",$J,keyFile#,file#) = levDif(keyfile,file) (if > 0)
 ;                                  ^openRootDA
 ;                ...      file#,field#) = S X=$P($G(...),U,n)
 ;                                         or S X=$E($G(...),m,n)
 ;
 ; ^TMP("DIKK",$J,"UI",file[.01],ui#)   = key#
 ; ^TMP("DIKK",$J,"UIR",rFile[.51],ui#) = key#
 ;
 ; MF(file#,mField#)   = multiple node
 ; MF(file#,mField#,0) = subfile#
 ;
LOADALL(KFIL,FLAG,MF) ;
 N FLD,KEY,ROOT
 ;
 ;Get info for all keys on this file
 S KEY=0
 F  S KEY=$O(^DD("KEY","B",KFIL,KEY)) Q:'KEY  D LOADKEY(KEY,.ROOT)
 Q:$G(FLAG)["s"
 ;
 ;Make a recursive call to get subfiles under KFIL
 N CHK,FIL,MFLD,PAR,SB
 D SUBFILES^DIKCU(KFIL,.SB,.MF)
 S SB=0 F  S SB=$O(SB(SB)) Q:'SB  D
 . D LOADALL(SB,"s") Q:'$D(^TMP("DIKK",$J,SB))
 . ;
 . ;Set CHK(subfile)="" for subfile and its antecedents
 . S PAR=SB F  Q:$D(CHK(PAR))  S CHK(PAR)=1,PAR=$G(SB(PAR)) Q:PAR=""
 ;
 ;Use the CHK array to get rid of unneeded elements in MF
 S FIL=0 F  S FIL=$O(MF(FIL)) Q:'FIL  D
 . S MFLD=0 F  S MFLD=$O(MF(FIL,MFLD)) Q:'MFLD  D
 .. K:'$D(CHK(MF(FIL,MFLD,0))) MF(FIL,MFLD)
 Q
 ;
 ;=====================
 ; LOADFLD(File,Field)
 ;=====================
 ;Load info for all keys of which a field is a part.
 ;
LOADFLD(FIL,FLD) ;
 N KEY
 S KEY=0 F  S KEY=$O(^DD("KEY","F",FIL,FLD,KEY)) Q:'KEY  D LOADKEY(KEY)
 Q
 ;
 ;===================
 ; LOADKEY(Key,Root)
 ;===================
 ;Load info about a key.
 ;In:
 ;  KEY   = Key #
 ; .OROOT = Open root of File of Key [.31,.01] (optional) (also output)
 ;Out:
 ; .OROOT = Open root of File of Key [.31,.01]
 ; ^TMP (see LOADALL above)
 ;
LOADKEY(KEY,OROOT) ;
 N DEC,FIL,FLD,FLDN,KFIL,LDIF,UI,UIFIL,UIRFIL
 ;
 ;Get key data
 S KFIL=$P($G(^DD("KEY",KEY,0)),U),UI=$P($G(^(0)),U,4) Q:'KFIL!'UI
 ;
 ;Get info about UI
 S UIFIL=$P($G(^DD("IX",UI,0)),U),UIRFIL=$P(^(0),U,9) Q:'UIFIL!'UIRFIL
 Q:$D(^TMP("DIKK",$J,"UI",UIFIL,UI))  S ^(UI)=KEY
 S ^TMP("DIKK",$J,"UIR",UIRFIL,UI)=KEY
 ;
 ;Get root of file [.31,.01]
 I $G(OROOT)="" S OROOT=$$FROOTDA^DIKCU(KFIL,"O")_"DA," Q:OROOT="DA,"
 ;
 ;Loop through fields in key; get data extraction code
 S FLDN=0 F  S FLDN=$O(^DD("KEY",KEY,2,FLDN)) Q:'FLDN  D
 . Q:'$D(^DD("KEY",KEY,2,FLDN,0))  S FLD=$P(^(0),U),FIL=$P(^(0),U,2)
 . Q:'FLD!'FIL  Q:$D(^TMP("DIKK",$J,KFIL,FIL,FLD))#2
 . ;
 . I FIL'=KFIL N OROOT D  Q:$G(OROOT)=""
 .. I $D(^TMP("DIKK",$J,KFIL,FIL))#2 S LDIF=+^(FIL),OROOT=U_$P(^(FIL),U,2,999)
 .. E  D
 ... S LDIF=$$FLEVDIFF^DIKCU(FIL,KFIL) Q:'LDIF
 ... S OROOT=$$FROOTDA^DIKCU(FIL,LDIF_"O") Q:OROOT=""
 ... S OROOT=OROOT_"DA("_LDIF_"),"
 ... S ^TMP("DIKK",$J,KFIL,FIL)=LDIF_OROOT
 . ;
 . S DEC=$$DEC(FIL,FLD,OROOT) Q:DEC=""
 . S ^TMP("DIKK",$J,KFIL,FIL,FLD)=DEC
 ;
 Q
 ;
 ;==============================
 ; $$DEC(File#,Field#,OpenRoot)
 ;==============================
 ;Return code that sets X=data from file; examples:
 ; S X=$P($G(^DIZ(1000,DA(2),"m1",DA(1),"m2",DA,0)),U,3)
 ; S X=$E($G(^DIZ(1000,DA(2),"m1",DA(1),"m2",DA,0)),1,245)
 ;In:
 ; FIL   = File #
 ; FLD   = Field #
 ; OROOT = Open root of record (with DA strings) (optional)
 ;
DEC(FIL,FLD,OROOT) ;Get data extraction code
 N ND,PC
 S PC=$P($G(^DD(FIL,FLD,0)),U,4)
 S ND=$P(PC,";"),PC=$P(PC,";",2) Q:ND?." " ""  Q:"0 "[PC ""
 S:ND'=+$P(ND,"E") ND=""""_ND_""""
 ;
 I $G(OROOT)="" S OROOT=$$FROOTDA^DIKCU(FIL,"O")_"DA," Q:OROOT="DA," ""
 I PC Q "S X=$P($G("_OROOT_ND_")),U,"_PC_")"
 E  Q "S X=$E($G("_OROOT_ND_")),"_+$E(PC,2,999)_","_$P(PC,",",2)_")"
 ;
