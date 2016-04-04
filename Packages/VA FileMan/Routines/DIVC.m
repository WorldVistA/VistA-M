DIVC ;SFISC/MKO-VERIFY INDEXES/KEYS ;2:47 PM  23 Jan 1998
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 ;============================================
 ; VINDEX(file,record,field,flag,.index,.key)
 ;============================================
 ;Programmer entry point to check the existence of indexes and
 ;key integrity for a single file/field/record. (Currently not used)
 ;In:
 ; DIFILE = file or subfile # (required)
 ; DIREC  = DA array or IENS (required)
 ; DIFLD  = field # (required)
 ; DIFLAG [ D : generate dialog errors
 ;Out:
 ; For invalid indexes/keys:
 ; .DIINDEX(indexName,index#) = "" : if an index is not set
 ; .DIKEY(file#,keyName,uiNumber) = null : if a key field is null
 ;                                  uniq : if a key not unique
 ;
VINDEX(DIFILE,DIREC,DIFLD,DIFLAG,DIINDEX,DIKEY) ;
 N DA,DIROOT,DIVCTMP,DIVERR
 ;
 ;Initialization
 S DIFLAG=$G(DIFLAG),DIVERR=0
 I DIFLAG["D",'$D(DIQUIET) N DIQUIET S DIQUIET=1
 I DIFLAG["D",'$D(DIFM) N DIFM S DIFM=1 D INIZE^DIEFU
 ;
 ;Check and convert input paramaters
 D CHK Q:DIVERR
 ;
 ;Load xref info
 S DIVCTMP=$$GETTMP^DIKC1("DIVC")
 D LOADVER(DIFILE,DIFLD,DIVCTMP)
 ;
 D VER(DIFILE,DIROOT,.DA,DIVCTMP,.DIINDEX,.DIKEY)
 K @DIVCTMP
 Q
 ;
 ;=========================================
 ; VER(file#,fileRoot,.DA,tmp,.index,.key)
 ;=========================================
 ;Check that index is set. If index is a uniqueness index also
 ;check that key is unique, and that key fields are non-null.
 ;Called from INDEX^DIVR.
 ;In:
 ;  DIFILE  = [sub]file #
 ;  DIROOT  = closed [sub]file root
 ; .DA      = DA array
 ;  DIVCTMP = root where xref info and verification logic is stored
 ;Out:
 ; .DIINDEX = see VINDEX above
 ; .DIKEY   = see VINDEX above
 ;
VER(DIFILE,DIROOT,DA,DIVCTMP,DIINDEX,DIKEY) ;
 N DICHECK,DINULL,DIXR,DIXRNAM,X,X1,X2
 N KEY,KFIL,KNAM,UNIQ
 ;
 ;Loop through the xrefs loaded in @DIVCTMP
 S DIXR=0 F  S DIXR=$O(@DIVCTMP@(DIFILE,DIXR)) Q:DIXR'=+DIXR  D
 . S DIXRNAM=$P(@DIVCTMP@(DIFILE,DIXR),U)
 . D SETXARR^DIKC(DIFILE,DIXR,DIVCTMP,.DINULL) M X1=X,X2=X
 . ;
 . ;If no X values are null, but no index, set DIINDEX(name,xref#)
 . I 'DINULL D
 .. S DICHECK=$G(@DIVCTMP@(DIFILE,DIXR,"V"))
 .. I DICHECK]"" X DICHECK E  S DIINDEX(DIXRNAM,DIXR)=""
 . ;
 . ;If the xref is a uniqueness index for a key, set DIKEY() if
 . ;key is not unique, or a key field is null.
 . I $D(^DD("KEY","AU",DIXR)) D
 .. S UNIQ=$S(DINULL:0,1:$$UNIQUE^DIKK2(DIFILE,DIXR,.X,.DA,DIVCTMP))
 .. I 'UNIQ S KEY=0 F  S KEY=$O(^DD("KEY","AU",DIXR,KEY)) Q:'KEY  D
 ... Q:$D(^DD("KEY",KEY,0))[0  S KFIL=$P(^(0),U),KNAM=$P(^(0),U,2)
 ... S DIKEY(KFIL,KNAM,DIXRNAM)=$S(DINULL:"null",1:"uniq")
 Q
 ;
 ;=============================
 ; CHK: Check input parameters
 ;=============================
 ;Out:
 ; DA     = DA array
 ; DIFILE = File #
 ; DIROOT = Closed file root
 ; DIVERR = 1 : if there's a problem
 ;
CHK ;File is a required input parameter
 I $G(DIFILE)="" D:DIFLAG["D" ERR^DIKCU2(202,"","","","FILE") D ERR Q
 I $G(DIFLD)="" D:DIFLAG["D" ERR^DIKCU2(202,"","","","FIELD") D ERR Q
 ;
 ;Check DIREC and set DA array
 N DIIENS
 I $G(DIREC)'["," M DA=DIREC S DIIENS=$$IENS^DILF(.DA)
 E  S:DIREC'?.E1"," DIREC=DIREC_"," D DA^DILF(DIREC,.DA) S DIIENS=DIREC
 I '$$VDA^DIKCU1(.DA,DIFLAG_"R") D ERR Q
 ;
 ;Check DIFLD
 I '$$VFLD^DIKCU1(DIFILE,DIFLD,DIFLAG) D ERR Q
 ;
 ;Set DIFILE and DIROOT
 N DILEV
 I DIFILE=+$P(DIFILE,"E") D
 . S DIROOT=$$FROOTDA^DIKCU(DIFILE,DIFLAG,.DILEV) I DIROOT="" D ERR Q
 . I DILEV,$D(DA(DILEV))[0 D  Q
 .. D:DIFLAG["D" ERR^DIKCU2(205,"",$$IENS^DILF(.DA),"",DIFILE) D ERR
 . S:DILEV DIROOT=$NA(@DIROOT)
 . S DIFILE=$$FNUM^DIKCU(DIROOT,DIFLAG) I DIFILE="" D ERR
 E  D
 . S DIROOT=DIFILE
 . S:"(,"[$E(DIROOT,$L(DIROOT)) DIROOT=$$CREF^DILF(DIFILE)
 . S DIFILE=$$FNUM^DIKCU(DIROOT,DIFLAG) I DIFILE="" D ERR Q
 . S DILEV=$$FLEV^DIKCU(DIFILE,DIFLAG) I DILEV="" D ERR Q
 . I DILEV,$D(DA(DILEV))[0 D  Q
 .. D:DIFLAG["D" ERR^DIKCU2(205,"",$$IENS^DILF(.DA),"",DIFILE) D ERR
 Q
 ;
ERR ;Set error flag
 S DIVERR=1
 Q
 ;
 ;============================
 ; LOADVER(file#,field#,tmp)
 ;============================
 ;Load xref info and verification logic for file/field into @TMP.
 ;Also, for each regular xref with no set condition, set
 ;  @TMP@(rootFile#,xref#,"V")=I $D(^index),^index=indexVal
 ; where,
 ;  index    = something like DIZ(9999,"BB",X(1),X(2),DA)
 ;  indexVal = value of index, usually ""
 ;
 ;In:
 ; FILE  = File #
 ; FIELD = Field #
 ; TMP   = Root to store logic
 ;
LOADVER(FILE,FIELD,TMP) ;Load indexes into TMP array
 N FIL,KL,SL,XR
 ;
 ;Load xref info for file/field into @TMP
 D LOADFLD^DIKC1(FILE,FIELD,"KS","","",TMP,TMP)
 ;
 ;Set the "V" nodes, kill the "S" and "K" nodes
 S FIL=0 F  S FIL=$O(@TMP@(FIL)) Q:'FIL  D
 . S XR=0 F  S XR=$O(@TMP@(FIL,XR)) Q:'XR  D
 .. I $P(@TMP@(FIL,XR),U,4)'="R"!$D(@TMP@(FIL,XR,"SC")) K @TMP@(FIL,XR) Q
 .. S SL=$G(@TMP@(FIL,XR,"S")),KL=$G(@TMP@(FIL,XR,"K"))
 .. I SL?1"S ^"1.E,KL?1"K ^"1.E D
 ... S @TMP@(FIL,XR,"V")="I $D("_$E(KL,3,999)_")#2,"_$E(SL,3,999)
 .. K @TMP@(FIL,XR,"S"),@TMP@(FIL,XR,"K")
 Q
 ;
 ;#202  The input parameter that identifies the |1| is missing or invalid.
 ;#601  The entry does not exist.
