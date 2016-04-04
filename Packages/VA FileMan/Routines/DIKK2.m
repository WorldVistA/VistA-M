DIKK2 ;SFISC/MKO-CHECK INPUT PARAMETERS TO INTEG^DIKK ;2:20 PM  15 Jul 1999
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**11**
 ;
 ;======
 ; INIT
 ;======
 ;Check input parameters to INTEG^DIKK and initialize variables.
 ;Out:
 ; DA     = DA array
 ; DIFILE = File #
 ; DIKFIL = Root (Key) File # (passed in via the W# parameter in DICTRL)
 ;          or DIFILE
 ; DIROOT = Closed root of file DIFILE
 ; DITAR  = Closed root of ouptut array [default: ^TMP("DIKKTAR",$J)]
 ; DIKERR = 1 : if there's a problem
 ; DIKKQUIT = 0 : if DICTRL["Q" (indicates we should quit when the
 ;                first problem is encountered)
 ;
INIT ;Check and setup
 N DILEV,DIIENS
 ;
 ;Get and clean output array
 S DITAR=$G(DICTRL("TAR")) S:DITAR="" DITAR=$NA(^TMP("DIKKTAR",$J))
 K @DITAR
 ;
 ;File is required
 I $G(DIFILE)="" D:DIF["D" ERR^DIKCU2(202,"","","","FILE") G ERR
 ;
 ;Check DIREC and set DA array
 I $G(DIREC)'["," M DA=DIREC S DIIENS=$$IENS(.DA)
 E  S DIIENS=DIREC_$E(",",DIREC'?.E1",") D DA^DILF(DIIENS,.DA)
 S:'$G(DA) DA=""
 G:'$$VDA^DIKCU1(.DA,DIF) ERR
 ;
 ;Set DIFILE and DIROOT
 I DIFILE=+$P(DIFILE,"E") D
 . S DIROOT=$$FROOTDA^DIKCU(DIFILE,DIF,.DILEV) I DIROOT="" D ERR Q
 . I $L(DIIENS,",")-2'=DILEV D  Q
 .. D:DIF["D" ERR^DIKCU2(205,"",$$IENS(.DA),"",DIFILE) D ERR
 . S:DILEV DIROOT=$NA(@DIROOT)
 . S DIFILE=$$FNUM^DIKCU(DIROOT,DIF) I DIFILE="" D ERR Q
 E  D
 . S DIROOT=DIFILE
 . S:"(,"[$E(DIROOT,$L(DIROOT)) DIROOT=$$CREF^DILF(DIFILE)
 . S DIFILE=$$FNUM^DIKCU(DIROOT,DIF) I DIFILE="" D ERR Q
 . S DILEV=$$FLEV^DIKCU(DIFILE,DIF) I DILEV="" D ERR Q
 . I $L(DIIENS,",")-2'=DILEV D  Q
 .. D:DIF["D" ERR^DIKCU2(205,"",$$IENS(.DA),"",DIFILE) D ERR
 Q:$G(DIKERR)
 ;
 ;Check DICTRL parameter
 I $G(DICTRL)]"",'$$VFLAG^DIKCU1(DICTRL,"QWds",DIF) G ERR
 ;
 ;Set DIKFILE = key (root) file
 I $G(DIKKEY) D  Q:$G(DIKERR)
 . S DIKFIL=$P($G(^DD("KEY",DIKKEY,0)),U)
 . I 'DIKFIL D:DIF["D" ERR^DIKCU2(202,"","","","KEY") D ERR
 E  S DIKFIL=+$P($G(DICTRL),"W",2)
 I 'DIKFIL S DIKFIL=DIFILE
 E  G:'$$VFNUM^DIKCU1(DIKFIL,DIF) ERR
 ;
 K DIKKQUIT S:$G(DICTRL)["Q" DIKKQUIT=0
 Q
 ;
ERR ;Set error flag
 S DIKERR=1
 Q
 ;
CHECK(RFIL,DA,DITAR,DIKKQUIT) ;Check key integrity for one record
 N FIL,FLD,IENSC,KEY,ML,NULL,S,SS,UI,UIR,VAL,X
 S IENSC=$$IENS(.DA)
 ;
 S UI=0 F  S UI=$O(^TMP("DIKK",$J,"UIR",RFIL,UI)) Q:'UI  S KEY=^(UI) D  Q:$G(DIKKQUIT)
 . ;Get info about uniqueness index
 . D XRINFO^DIKCU2(UI,.UIR,"","","","",.SS)
 . ;
 . ;Set UIR=root incl X(n); VAL(n)=X(n) if >= maxlen; SS(n)=dec
 . K NULL,VAL,X
 . S S=0 F  S S=$O(SS(S)) Q:'S  D  Q:$G(DIKKQUIT)
 .. S FIL=$P(SS(S),U),FLD=$P(SS(S),U,2),ML=$P(SS(S),U,3)
 .. S SS(S)=^TMP("DIKK",$J,RFIL,FIL,FLD)
 .. X SS(S) I X="" D SETN^DIKK(FIL,IENSC,FLD,DITAR,.DIKKQUIT) S NULL=1
 .. Q:$G(NULL)
 .. I ML,$L(X)'<ML S VAL(S)=X
 .. S X(S)=X
 . Q:$G(NULL)
 . ;
 . ;Check matching indexes
 . S UIR=$NA(@UIR) Q:'$D(@UIR)
 . D:'$$UNIQIX(UIR,IENSC,.DA,.VAL,.SS) SETK^DIKK(RFIL,IENSC,KEY,DITAR,.DIKKQUIT)
 Q
 ;
UNIQUE(DIFILE,DIUINDEX,X,DA,DITMP) ;Check whether X values are unique
 N DIIENSC,DIMAXL,DIORD,DISS,DIUIR,DIVAL,S
 ;
 I $G(DITMP)="" N DIKKTMP D
 . S DITMP="DIKKTMP"
 . D LOADXREF^DIKC1("","","",DIUINDEX,"",DITMP)
 ;
 ;Get index reference
 D XRINFO^DIKCU2(DIUINDEX,.DIUIR,"",.DIMAXL)
 S DIUIR=$NA(@DIUIR)
 Q:'$D(@DIUIR) 1
 ;
 ;There's a matching index
 ;Set DIVAL(ss#) for those subscripts that may have been truncated
 S DIIENSC=$$IENS(.DA)
 S DIORD=0
 F  S DIORD=$O(DIMAXL(DIORD)) Q:'DIORD  D:$L(X(DIORD))'<DIMAXL(DIORD)
 . S S=+$G(@DITMP@(DIFILE,DIUINDEX,DIORD,"SS")) Q:'S
 . S DIVAL(S)=X(DIORD)
 . S DISS(S)=$G(@DITMP@(DIFILE,DIUINDEX,DIORD))
 Q $$UNIQIX(DIUIR,DIIENSC,.DA,.DIVAL,.DISS)
 ;
UNIQIX(DIUIR,DIIENSC,DA,DIVAL,DISS,DIEVK) ;
 ;Loop through the matching indexes; Return 1 if unique
 N DIDASV,DIIENS,DINDX,DINS,DION,DIS,DIUNIQ,I,L,X
 M DIDASV=DA
 S DION="N"
 ;
 S DIUNIQ=1,DINS=$QL(DIUIR),DINDX=DIUIR
 F  S DINDX=$Q(@DINDX) Q:DINDX=""  Q:$NA(@DINDX,DINS)'=DIUIR  D  Q:'DIUNIQ
 . ;Set DA array, quit if this is index for current record
 . S DIIENS=$E(DINDX,$L(DIUIR)+1,$L(DINDX)-1),L=$L(DIIENS,",")
 . S DA=$P(DIIENS,",",L) F I=1:1:L-1 S DA(I)=$P(DIIENS,",",L-I)
 . S DIIENS=$$IENS(.DA) Q:DIIENS=DIIENSC
 . ;
 . ;If values for this record are being updated via the FDA, don't
 . ;bother checking (used by DIEVK)
 . I $G(DIEVK) Q:$D(^TMP("DIKK",$J,"L",$P(DIEVK,U),$P(DIEVK,U,2),DIIENS))  Q:$D(^TMP("DIKK",$J,"F",$P(DIEVK,U),$P(DIEVK,U,2),DIIENS))
 . ;
 . ;If no values in index were truncated, values are not unique.
 . I '$D(DIVAL) S DIUNIQ=0 Q
 . ;
 . ;Set the X array for the indexed record and compare
 . S DIS=0 F  S DIS=$O(DIVAL(DIS)) Q:'DIS  X DISS(DIS) I X'=DIVAL(DIS) Q
 . S:'DIS DIUNIQ=0
 ;
 K DA M DA=DIDASV
 Q DIUNIQ
 ;
KEYCHK(DIFIL,DA,DIFLD,DIXREF,DIIENS,DITAR,DINEW) ;Check whether indexes
 ;in @DIXREF are unique
 N DIKEY,DIUINDEX,DIUNIQ,X
 I $G(DITAR)]"",$G(DIIENS)="" S DIIENS=$$IENS(.DA)
 ;
 S DIUNIQ=1,DIKEY=0
 F  S DIKEY=$O(^DD("KEY","F",DIFIL,DIFLD,DIKEY)) Q:'DIKEY  D  Q:'DIUNIQ
 . S DIUINDEX=$P(^DD("KEY",DIKEY,0),U,4)
 . Q:'DIUINDEX!'$D(@DIXREF@(DIFIL,DIUINDEX))
 . D SETXARR^DIKC(DIFIL,DIUINDEX,DIXREF,"",DINEW)
 . S DIUNIQ=$$UNIQUE(DIFIL,DIUINDEX,.X,.DA,DIXREF)
 . I 'DIUNIQ,$G(DITAR)]"" D SETK^DIKK(DIFIL,DIIENS,DIKEY,DITAR) S DIUNIQ=1
 I $G(DITAR)]"",$D(@DITAR) S DIUNIQ=0
 Q DIUNIQ
 ;
IENS(DA) ;Return IENS from DA array
 N I,IENS
 S IENS=$G(DA)_"," F I=1:1:$O(DA(" "),-1) S IENS=IENS_DA(I)_","
 Q IENS
