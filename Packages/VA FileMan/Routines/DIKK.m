DIKK ;SFISC/MKO-CHECK KEY INTEGRITY ;9:14 AM  23 Feb 1999
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
INTEG(DIFILE,DIREC,DIFLD,DIKKEY,DICTRL,DIKPROC) ;
 N DA,DIF,DIKERR,DIKFIL,DIKKQUIT,DIMF,DIROOT,DITAR
 ;
 ;If called as an extrinsic, manipulate DICTRL
 S DIKPROC=$G(DIKPROC)
 I 'DIKPROC N DICTRL1,DIKKTAR M DICTRL1=DICTRL S DICTRL("TAR")="DIKKTAR"
 ;
 S DIF=$E("D",$G(DICTRL)'["d")
 I DIF["D",'$D(DIQUIET) N DIQUIET S DIQUIET=1
 I DIF["D",'$D(DIFM) N DIFM S DIFM=1 D INIZE^DIEFU
 ;
 ;Check input params, initialize variables, clean output array
 D INIT^DIKK2 G:$G(DIKERR)]"" MOVE
 I 'DIKPROC S:$G(DICTRL)'["Q" DICTRL=$G(DICTRL)_"Q"
 ;
 ;Load key info into ^TMP("DIKK",$J), and multiple info into DIMF
 K ^TMP("DIKK",$J)
 I $G(DIKKEY)?."^" D
 . I $G(DIFLD) D
 .. D LOADFLD^DIKK1(DIKFIL,DIFLD)
 . E  D LOADALL^DIKK1(DIKFIL,$E("s",$G(DICTRL)["s"),.DIMF)
 E  D LOADKEY^DIKK1(DIKKEY)
 G:'$O(^TMP("DIKK",$J,0)) EXIT
 D:DIKFIL'=DIFILE SBINFO^DIKCU(DIKFIL,.DIMF)
 ;
 ;Check one or all records in file DIFILE
 I DA D
 . D CHECK(DIFILE,.DA,DIROOT,.DIMF,DITAR,.DIKKQUIT)
 E  D CHECKALL(DIFILE,.DA,DIROOT,.DIMF,DITAR,.DIKKQUIT)
 ;
EXIT ;Cleanup ^TMP and quit
 K ^TMP("DIKK",$J)
 ;
MOVE ;Move error messages if necessary
 I DIF["D",$G(DIERR),$G(DICTRL("MSG"))]"" D CALLOUT^DIEFU(DICTRL("MSG"))
 I 'DIKPROC K DICTRL M DICTRL=DICTRL1 Q $D(DIKKTAR)=0&($G(DIKERR)="")
 Q
 ;
CHECK(DIFILE,DA,DIROOT,DIMF,DITAR,DIKKQUIT) ;Check one record
 I $D(^TMP("DIKK",$J,"UIR",DIFILE)) D CHECK^DIKK2(DIFILE,.DA,DITAR,.DIKKQUIT) Q:$G(DIKKQUIT)
 D:$D(DIMF(DIFILE)) CHECKSUB(DIFILE,.DA,DIROOT,.DIMF,DITAR,.DIKKQUIT)
 Q
 ;
CHECKALL(DIFILE,DA,DIROOT,DIMF,DITAR,DIKKQUIT) ;Check all records
 I $D(^TMP("DIKK",$J,"UI",DIFILE)) D UICHK(DIFILE,.DA,DITAR,.DIKKQUIT) Q:$G(DIKKQUIT)
 I '$D(^TMP("DIKK",$J,DIFILE)),'$D(DIMF(DIFILE)) Q
 ;
 ;Loop through all records in file, check for null key fields
 S DA=0 F  S DA=$O(@DIROOT@(DA)) Q:DA'=+DA  D  Q:$G(DIKKQUIT)
 . I $D(^TMP("DIKK",$J,DIFILE)) D NULLCHK(DIFILE,.DA,DITAR,.DIKKQUIT) Q:$G(DIKKQUIT)
 . D:$D(DIMF(DIFILE)) CHECKSUB(DIFILE,.DA,DIROOT,.DIMF,DITAR,.DIKKQUIT)
 Q
 ;
CHECKSUB(DIFILE,DA,DIROOT,DIMF,DITAR,DIKKQUIT) ;Process all records in subfiles
 N DIMULTF,DISBFILE,DISBROOT
 D PUSHDA^DIKCU(.DA)
 ;
 ;Loop through the DIMF array and make recursive call to check all
 ;subrecords
 S DIMULTF=0 F  S DIMULTF=$O(DIMF(DIFILE,DIMULTF)) Q:'DIMULTF  D  Q:$G(DIKKQUIT)
 . S DISBROOT=$NA(@DIROOT@(DA(1),DIMF(DIFILE,DIMULTF))) Q:'$D(@DISBROOT)
 . S DISBFILE=DIMF(DIFILE,DIMULTF,0)
 . D CHECKALL(DISBFILE,.DA,DISBROOT,.DIMF,DITAR,.DIKKQUIT)
 ;
 D POPDA^DIKCU(.DA)
 Q
 ;
NULLCHK(KFIL,DA,DITAR,DIKKQUIT) ;Check whether any of the key fields at
 ;KFIL file level are null for a given record.
 N FIL,FLD,IENS,LDIF,X
 ;
 S FIL=0 F  S FIL=$O(^TMP("DIKK",$J,KFIL,FIL)) Q:'FIL  D  Q:$G(DIKKQUIT)
 . S LDIF=+$G(^TMP("DIKK",$J,KFIL,FIL))
 . S FLD=0 F  S FLD=$O(^TMP("DIKK",$J,KFIL,FIL,FLD)) Q:'FLD  D  Q:$G(DIKKQUIT)
 .. X ^TMP("DIKK",$J,KFIL,FIL,FLD) Q:X]""
 .. S IENS=$$IENS(.DA)
 .. S:LDIF IENS=$P(IENS,",",LDIF+1,999)
 .. D SETN(FIL,IENS,FLD,DITAR,.DIKKQUIT)
 Q
 ;
UICHK(FILE,DA,OUT,DIKKQUIT) ;Walk through uniqueness index and check for duplicates
 N IX0,IX1,IX2,IXV1,IXV2,KEY,KFIL,LDIF,NS,S,SS,UI
 ;
 S UI=0 F  S UI=$O(^TMP("DIKK",$J,"UI",FILE,UI)) Q:'UI  D  Q:$G(DIKKQUIT)
 . ;Get info about uniqueness index
 . S KEY=$G(^TMP("DIKK",$J,"UI",FILE,UI))
 . I $P(KEY,U,2)]"" D
 .. S KFIL=$P(KEY,U,2),LDIF=$P(KEY,U,3),KEY=$P(KEY,U)
 .. S IX0=^TMP("DIKK",$J,"UI",FILE,UI,"UIR") M SS=^("SS")
 . E  D
 .. D XRINFO^DIKCU2(UI,"",.LDIF,"",.KFIL,.IX0,.SS)
 .. ;
 .. ;Remove elements from the SS array that have no max length.
 .. ;For those that have max length, set SS(S)=data extraction code
 .. S S=0 F  S S=$O(SS(S)) Q:'S  D
 ... I '$P(SS(S),U,3) K SS(S) Q
 ... S SS(S)=^TMP("DIKK",$J,KFIL,$P(SS(S),U),$P(SS(S),U,2))
 .. ;
 .. ;Remember info for next time
 . S KEY=+KEY
 . S ^TMP("DIKK",$J,"UI",FILE,UI)=KEY_U_KFIL_U_LDIF,^(UI,"UIR")=IX0
 . M ^TMP("DIKK",$J,"UI",FILE,UI,"SS")=SS
 . ;
 . ;If necessary, push the DA array
 . D:LDIF PUSHDA^DIKCU(.DA,LDIF)
 . ;
 . ;Walk down the uniqueness index and look for duplicates
 . S (IX0,IX1,IX2)=$NA(@IX0),NS=$QL(IX0)
 . F  S IX2=$Q(@IX2) Q:IX2=""  Q:$NA(@IX2,NS)'=IX0  D  Q:$G(DIKKQUIT)
 .. S IXV1=$NA(@IX1,NS+SS),IXV2=$NA(@IX2,NS+SS)
 .. I IXV1'=IXV2 S IX1=IX2 Q
 .. D DUPL(KEY,UI,FILE,KFIL,.DA,IX1,IX2,IXV1,NS,.SS,.DIKKQUIT)
 .. S (IX1,IX2)=$NA(@IXV1@("~"))
 . ;
 . ;Pop the DA array
 . D:LDIF POPDA^DIKCU(.DA,LDIF)
 Q
 ;
DUPL(KEY,UI,UIFIL,UIRFIL,DA,IX1,IX2,IXV,NS,SS,DIKKQUIT) ;Process duplicate
 ;indexes
 N DUPL,IENSDONE,I,IENS1,IENS2,L,ML,NEXTIX1,S,V1,X
 ;
 ;Set ML(subsc)=SS(subsc) for those subscripts that are >= maxlength
 S S=0
 F  S S=$O(SS(S)) Q:'S  S:$L($QS(IXV,NS+S))'<$P(SS(S),U,3) ML(S)=SS(S)
 ;
DLOOP ;Compare IX1 with IX2 and subsequent indexes
 K NEXTIX1
 ;
 ;Set iens and DA array for 1st index
 S IENS1=$E(IX1,$L(IXV)+1,$L(IX1)-1),L=$L(IENS1,",")
 S DA=$P(IENS1,",",L) F I=1:1:L-1 S DA(I)=$P(IENS1,",",L-I)
 S IENS1=$$IENS(.DA)
 ;
 ;If any subsc >= maxlen, set V1(subsc) = value array for 1st index
 I $D(ML) K V1 S S=0 F  S S=$O(ML(S)) Q:'S  X ML(S) S V1(S)=X
 ;
 F  D  S IX2=$Q(@IX2) Q:IX2=""  Q:$NA(@IX2,NS+SS)'=IXV!$G(DIKKQUIT)
 . ;Set iens and DA array for the 2nd index
 . S IENS2=$E(IX2,$L(IXV)+1,$L(IX2)-1),L=$L(IENS2,",")
 . S DA=$P(IENS2,",",L) F I=1:1:L-1 S DA(I)=$P(IENS2,",",L-I)
 . S IENS2=$$IENS(.DA)
 . ;
 . ;If no subsc >= maxlen, there's a duplicate
 . I '$D(ML) D SETK(UIRFIL,IENS2,KEY,DITAR,.DIKKQUIT) S DUPL=1 Q
 . ;
 . ;Otherwise, compare with actual data
 . Q:$D(IENSDONE(IENS2))
 . S S=0 F  S S=$O(ML(S)) Q:'S  X ML(S) I X'=V1(S) Q
 . I S S:'$D(NEXTIX1) NEXTIX1=IX2
 . E  D SETK(UIRFIL,IENS2,KEY,DITAR,.DIKKQUIT) S DUPL=1,IENSDONE(IENS2)=""
 ;
 D:$G(DUPL) SETK(UIRFIL,IENS1,KEY,DITAR,.DIKKQUIT)
 Q:'$D(NEXTIX1)
 ;
 S IX1=NEXTIX1,IX2=$Q(@IX1) Q:IX2=""
 G:$NA(@IX1,NS+SS)=$NA(@IX2,NS+SS) DLOOP
 Q
 ;
SETN(DIFIL,DIIENS,DIFLD,DITAR,DIKKQUIT) ;
 S @DITAR@(DIFIL,DIIENS,DIFLD)=""
 ;S @DITAR@("N",DIFIL,DIIENS,DIFLD)=""
 S:$G(DIKKQUIT)]"" DIKKQUIT=1
 Q
 ;
SETK(DIRFIL,DIIENS,DIKEY,DITAR,DIKKQUIT) ;
 S @DITAR@(DIRFIL,DIIENS,"K",DIKEY)=""
 ;S @DITAR@("K",DIRFIL,DIIENS,DIKEY)=""
 S:$G(DIKKQUIT)]"" DIKKQUIT=1
 Q
 ;
IENS(DA) ;Return IENS from DA array
 N I,IENS
 S IENS=$G(DA)_"," F I=1:1:$O(DA(" "),-1) S IENS=IENS_DA(I)_","
 Q IENS
