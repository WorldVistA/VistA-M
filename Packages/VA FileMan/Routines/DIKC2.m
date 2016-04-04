DIKC2 ;SFISC/MKO-CHECK INPUT PARAMETERS TO INDEX^DIKC ;19DEC2010
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**11,167**
 ;
 ;CHK:  Check input parameters to INDEX^DIKC
 ;Also set:
 ; DA     = DA array
 ; DIROOT = Closed root of file
 ; DIFILE = File #
 ; DIKERR = "X" : if there's a problem
 ;
CHK ;File is a required input param
 I $G(DIFILE)="" D:DIF["D" ERR^DIKCU2(202,"","","","FILE") D ERR Q
 ;
 ;Check DIREC and set DA array
 I $G(DIREC)'["," M DA=DIREC
 E  S:DIREC'?.E1"," DIREC=DIREC_"," D DA^DILF(DIREC,.DA)
 S:'$G(DA) DA=""
 I '$$VDA^DIKCU1(.DA,DIF) D ERR Q
 ;
DICTRL ;Check DICTRL parameter
 I $G(DICTRL)]"",'$$VFLAG^DIKCU1(DICTRL,"KSsDWiRIkCTrfx",DIF) D ERR
 I $G(DICTRL)["W",'$$VFNUM^DIKCU1(+$P(DICTRL,"W",2),DIF) D ERR
 I $G(DICTRL)["C",$G(DICTRL)["T" D
 . D:DIF["D" ERR^DIKCU2(301,"","","","C and T")
 . D ERR
 E  I $G(DICTRL)["C",$G(DICTRL)["K" D
 . D:DIF["D" ERR^DIKCU2(301,"","","","C and K")
 . D ERR
 E  I $G(DICTRL)["T",$G(DICTRL)["S" D
 . D:DIF["D" ERR^DIKCU2(301,"","","","T and S")
 . D ERR
 Q:$G(DIKERR)="X"
 ;
 ;Set DIFILE and DIROOT
 N DILEV
 I DIFILE=+$P(DIFILE,"E") D
 . S DIROOT=$$FROOTDA^DIKCU(DIFILE,DIF,.DILEV) I DIROOT="" D ERR Q
 . I DILEV,$D(DA(DILEV))[0 D  Q
 .. D:DIF["D" ERR^DIKCU2(205,"",$$IENS^DILF(.DA),"",DIFILE) D ERR
 . S:DILEV DIROOT=$NA(@DIROOT)
 . S DIFILE=$$FNUM^DIKCU(DIROOT,DIF) I DIFILE="" D ERR
 E  D
 . S DIROOT=DIFILE
 . S:"(,"[$E(DIROOT,$L(DIROOT)) DIROOT=$$CREF^DILF(DIFILE)
 . S DIFILE=$$FNUM^DIKCU(DIROOT,DIF) I DIFILE="" D ERR Q
 . S DILEV=$$FLEV^DIKCU(DIFILE,DIF) I DILEV="" D ERR Q
 . I DILEV,$D(DA(DILEV))[0 D  Q
 .. D:DIF["D" ERR^DIKCU2(205,"",$$IENS^DILF(.DA),"",DIFILE) D ERR
 ;
 ;Set DIKVAL,DIKON
 S DIKVAL=$G(DICTRL("VAL"))
 I DIKVAL]"" D
 . S:"(,_"'[$E(DIKVAL,$L(DIKVAL)) DIKVAL=$$OREF^DILF(DIKVAL)
 . S DIKON="O^N"
 E  S DIKON=""
 Q
 ;
ERR ;Set error flag
 S DIKERR="X"
 Q
 ;
 ;==========================
 ; CRV(Index,ValueRoot,TMP)
 ;==========================
 ;Load values from Cross Reference Values multiple into @TMP
 ;In:
 ;  XR    = Index #
 ;  VALRT = Array Ref where old/new values are located
 ;  TMP   = Root of array to store data
 ;Returns:
 ;  @TMP@(RootFile,Index#)             = Name^File^RootType^Type
 ;                 Index#,Order#)      = Code that sets X to the data
 ;                        Order#,"SS") = Subscript^MaxLength
 ;                               "T")  = Transform (for 'Field'-type)
 ;                               "F")  = file^field^levdiff(file,rFile)
CRV(XR,VALRT,TMP) ;
 Q:'$G(XR)!($G(TMP)="")
 N CRV,CRV0,DEC,FIL,FLD,MAXL,ND,ORD,OROOT,RFIL,SBSC,TYPE
 ;
 S RFIL=$P($G(^DD("IX",XR,0)),U,9) Q:RFIL=""  Q:$D(@TMP@(RFIL,XR))
 S @TMP@(RFIL,XR)=$P(^DD("IX",XR,0),U,2)_U_$P(^(0),U)_U_$P(^(0),U,8)_U_$P(^(0),U,4)
 S OROOT=$$FROOTDA^DIKCU(RFIL,"O")_"DA," Q:OROOT="DA,"
 ;
 S CRV=0 F  S CRV=$O(^DD("IX",XR,11.1,CRV)) Q:'CRV  D
 . S CRV0=$G(^DD("IX",XR,11.1,CRV,0))
 . S ORD=$P(CRV0,U),TYPE=$P(CRV0,U,2),MAXL=$P(CRV0,U,5),SBSC=$P(CRV0,U,6)
 . Q:ORD=""!(TYPE="")
 . ;
 . I TYPE="F" D
 .. S FIL=$P(CRV0,U,3),FLD=$P(CRV0,U,4) Q:(FIL="")!'FLD
 .. I FIL'=RFIL N OROOT,LDIF D  Q:$G(OROOT)=""
 ... S LDIF=$$FLEVDIFF^DIKCU(FIL,RFIL) Q:'LDIF
 ... S OROOT=$$FROOTDA^DIKCU(FIL,LDIF_"O") Q:OROOT=""
 ... S OROOT=OROOT_"DA("_LDIF_"),"
 .. S DEC=$$DEC(FIL,FLD,$G(VALRT),OROOT) Q:DEC=""
 .. S @TMP@(RFIL,XR,ORD)=DEC
 .. S @TMP@(RFIL,XR,ORD,"F")=FIL_U_FLD_$S($G(LDIF):U_LDIF,1:"")
 .. S:$G(^DD("IX",XR,11.1,CRV,2))'?."^" @TMP@(RFIL,XR,ORD,"T")=^(2)
 . ;
 . E  I TYPE="C" S @TMP@(RFIL,XR,ORD)=$G(^DD("IX",XR,11.1,CRV,1.5))
 . ;
 . S:SBSC @TMP@(RFIL,XR,ORD,"SS")=SBSC_$S(MAXL:U_MAXL,1:"")
 Q
 ;
 ;======================================
 ; $$DEC(File,Field,ValueRoot,OpenRoot)
 ;======================================
 ;Return Data Extraction Code -- M code that sets X equal to the data.
 ;In:
 ;  FIL   = File #
 ;  FLD   = Field #
 ;  VALRT = Array Ref where old/new values are located
 ;           if ends in "_", FILE subscript is concatenated to the last
 ;           subscript (used by DDS02)
 ;  OROOT = Open root of record w/ DA subscripts
 ;Returns:  M code
 ;  For example:
 ;    S X=$P(^DIZ(1000,DA(1),100,0),U,2)   or
 ;    S X=$E(^DIZ(1000,DA(1),100,1),1,245) or
 ;    S X=$G(array(file,DIIENS,field,DION),$P(^root(DA,nd),U,pc))
 ;
DEC(FIL,FLD,VALRT,OROOT) ;
 Q:$P($G(^DD(FIL,FLD,0)),U)="" ""
 ;
 N ND,PC,DEC
 S PC=$P($G(^DD(FIL,FLD,0)),U,4)
 S ND=$P(PC,";"),PC=$P(PC,";",2) Q:ND?." "!("0 "[PC) ""
 S:ND'=+$P(ND,"E") ND=""""_ND_""""
 ;
 I $G(OROOT)="" S OROOT=$$FROOTDA^DIKCU(FIL,"O")_"DA," Q:OROOT="DA," ""
 I PC S DEC="$P($G("_OROOT_ND_")),U,"_PC_")"
 E  S DEC="$E($G("_OROOT_ND_")),"_+$E(PC,2,999)_","_$P(PC,",",2)_")"
 ;
 I $G(VALRT)]"" D
 . I $E(VALRT,$L(VALRT))="_" D  Q
 .. S VALRT=$E(VALRT,1,$L(VALRT)-3)
 .. S DEC="$G("_VALRT_FIL_""",DIIENS,"_FLD_",DION),"_DEC_")"
 . S:"(,"'[$E(VALRT,$L(VALRT)) VALRT=$$OREF^DILF(VALRT)
 . S DEC="$G("_VALRT_FIL_",DIIENS,"_FLD_",DION),"_DEC_")"
 S DEC="S X="_DEC
 Q DEC
 ;
 ;======================
 ; LOG(Index,Logic,TMP)
 ;======================
 ;Load Set and/or Kill logic into into @TMP
 ;In:
 ;  XR  = Index #
 ;  LOG [ K : load kill logic
 ;      [ S : load set logic
 ;  TMP = Root of array to store data
 ;Returns:
 ;  @TMP@(RootFile,Index#,"S")  = Set logic
 ;                        "SC") = Set condition
 ;                        "K")  = Kill logic
 ;                        "KC") = Kill condtion
LOG(XR,LOG,TMP) ;
 Q:'$G(XR)  Q:$G(LOG)=""  Q:$G(TMP)=""
 N SL,KL,SC,KC,RFIL
 ;
 S RFIL=$P(^DD("IX",XR,0),U,9) Q:RFIL=""
 I LOG["S" D
 . S SL=$G(^DD("IX",XR,1)),SC=$G(^(1.4))
 . I "Q"'[SL,SL'?."^" S @TMP@(RFIL,XR,"S")=SL
 . I "Q"'[SC,SC'?."^" S @TMP@(RFIL,XR,"SC")=SC
 I LOG["K" D
 . S KL=$G(^DD("IX",XR,2)),KC=$G(^(2.4))
 . I "Q"'[KL,KL'?."^" S @TMP@(RFIL,XR,"K")=KL
 . I "Q"'[KC,KC'?."^" S @TMP@(RFIL,XR,"KC")=KC
 Q
 ;
 ;===============
 ; KW(Index,TMP)
 ;===============
 ;Load Kill Entire Index logic into @TMP
 ;In:
 ;  XR  = Index #
 ;  TMP = Root of array to store data
 ;Returns:
 ;  @TMP@("KW",File#[.01],Index#) =   Kill Entire Index logic
 ;                        Index#,0) = Type ("W" for whole-file index)
 ;                                    ^RootFile
 ;                                    ^Level difference between top file
 ;                                      and root file
KW(XR,TMP) ;Get Kill Entire Index logic
 Q:'$G(XR)!($G(TMP)="")
 N FILE,KW,RFIL,TYPE
 S KW=$G(^DD("IX",XR,2.5)) Q:KW="Q"!(KW?."^")
 S FILE=$P($G(^DD("IX",XR,0)),U),TYPE=$P(^(0),U,8),RFIL=$P(^(0),U,9)
 Q:FILE=""!(RFIL="")
 ;
 S @TMP@("KW",FILE,XR)=KW
 S:RFIL'=FILE @TMP@("KW",FILE,XR,0)=TYPE_U_RFIL_U_$$FLEVDIFF^DIKCU(FILE,RFIL)
 Q
 ;
 ;#202  The input parameter that identifies the |1| is missing or invalid.
 ;#205  File# |1| and IEN string |IENS| represent different subfile levels.
 ;
