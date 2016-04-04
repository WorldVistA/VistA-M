DIC0 ;SFISC/TKW-Lookup routine utilities called by DIC ;16JAN2011
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**4,20,1027,1041**
 ;
D ; Reset back to starting index for lookup.
 S D=DINDEX("START") K DINDEX S (DINDEX,DINDEX("START"))=D,DINDEX("WAY")=1
 S:$D(DID(1)) DID(1)=2
 N DIFLAGS S DIFLAGS="4l"_$P("M^",U,DIC(0)["M")
 D INDEX^DICUIX(.DIFILEI,DIFLAGS,.DINDEX,"",.DIVAL)
 Q
 ;
SETVAL ; If custom lookup routine (like MTLU) comes in to entry point after ASK, we need to set up the lookup values.
 K DIVAL,DIALLVAL D CHKVAL
 I DIVAL(0) D CHKVAL1(DINDEX("#"),.DIVAL,DIC(0),DIC(0),.DIALLVAL)
 Q
 ;
INIT ; Initialize variables at all entry points in ^DIC.
 I $D(DIFILEI)[0 D GETFILE(.DIC,.DIFILEI,.DIENS) Q:DIFILEI=""
 I '$D(@(DIC_"0)")),'$D(DIC("P")),$E(DIC,1,6)'="^DOPT(" S DIC("P")=$$GETP^DIC0(DIFILEI) I DIC("P")="" S Y=-1 D Q^DIC2 Q
 I $G(DO)="" K DO D GETFA^DIC1(.DIC,.DO)
 S (DINDEX,DINDEX("START"))=D,DINDEX("WAY")=1
 D INDEX^DICUIX(.DIFILEI,"4l",.DINDEX,"",.DIVAL)
 I DIC(0)["V" S DIASKOK=1
 S Y=-1 I DIC(0)["Z" K Y(0)
 Q
 ;
CHKVAL ; Check lookup values input by user.
 N I I $G(X)="" S X=$G(X(1))
 S DIVAL(0)=0,DIVAL(1)=X F I=2:1:DINDEX("#") S DIVAL(I)=$G(X(I))
 N J,DIOUT S DIOUT=0
 F I=1:1:DINDEX("#") S J=$G(DIVAL(I)) I J]"" D  Q:DIOUT
 . I DINDEX("#")>1 S X(I)=J
 . I J["^" S (DUOUT,DIOUT)=1,DIVAL(0)=0 Q
 . I J?1."?" K DIVAL S DIVAL(0)=0,X=$E(J,1,2),DIOUT=1 Q
 . S DIVAL(0)=DIVAL(0)+1 Q
 Q
 ;
CHKVAL1(DIXNO,DIVAL,DIFLAGS,DIC0,DIALLVAL) ; Check for errors with values, flags,index.
 N DIERROR,I S DIALLVAL=1 D
 . I '$D(DIC0),DIFLAGS'["l" D  Q:$G(DIERROR)
 . . S I=$O(DIVAL(99999),-1) I I>DIXNO S DIERROR=8093 Q
 . . S:DIXNO>1&(DIFLAGS["M") DIERROR=8095 Q
 . F I=1:1:DIXNO S DIVAL(I)=$G(DIVAL(I)) D:DIVAL(I)=""
 . . I DIFLAGS["X",DIFLAGS'["l" S DIERROR=8094 Q
 . . S DIALLVAL=0 Q
 . Q
 I $D(DIERROR) D
 . I '$D(DIC0) D ERR^DICF4(DIERROR) Q
 . K DIVAL S DIVAL(0)=0 Q:DIC0'["E"  W $C(7),!,$$EZBLD^DIALOG(DIERROR) Q
 Q
 ;
CHKVAL2(DIXNO,DIVAL,DIC0,DDS) ; Check lookup values for control characters or too long.
 N I,J,DIER S DIER=""
 F I=1:1:DIXNO S J=$G(DIVAL(I)) D:J]""  Q:DIER
 . I J'?.ANP S DIER=204 Q
 . I J?1.N.1".".N,($L($P(J,"."))>25!($L($P(J,".",2))>25)) S DIER=208 Q
 . I ($L(J)-255)>0 S DIER=209
 . Q
 Q:'DIER
 D:DIC0["Q"
 . W $C(7) Q:DIC(0)'["E"
 . I '$D(DDS) W !,$$EZBLD^DIALOG(DIER) Q
 . N DDH S DDH=1,DDH(1,"T")="  **  "_$$EZBLD^DIALOG(DIER)
 . S DDC=7,DDD=1 D LIST^DDSU
 . Q
 K DIVAL S DIVAL(0)=0
 Q
 ;
KILL2 K DIVAL,DIALLVAL
KILL1 K DIFILEI,DINDEX,DIMAXLEN,DIENS Q
 ;
GETFILE(DIC,DIFILE,DIENS) ; Return file number, global references, IEN string and KEY fields data.
 S DIFILE="" I $G(DIC)="" Q
 I +$P(DIC,"E")'=DIC N DIDIC M DIDIC=DIC N DIC S DIDIC=$$CREF^DILF(DIDIC),DIDIC=$NA(@DIDIC),DIDIC=$$OREF^DILF(DIDIC) M DIC=DIDIC K DIDIC
 N DA
 I +$P(DIC,"E")=DIC D
 . S DIFILE=DIC,DIC=$G(^DIC(DIC,0,"GL")) Q:DIC]""
 . S DIC=DIFILE,DIFILE="" Q
 E  D
 . S DIFILE=$G(@(DIC_"0)")) I DIFILE]"" S DIFILE=+$P(DIFILE,U,2) Q
 . S DIFILE=+$G(DIC("P")) Q:DIFILE
 . ;I DIC["^DD(",'$D(@(DIC_"0)")) S DIFILE="" Q
 . S DIFILE=$$FILENUM^DILIBF(DIC) Q
 Q:DIFILE=""
 S DIENS=","
 I DIC(0)'["p" D SETIEN(DIC,DIFILE,.DIENS) Q:DIFILE=""
 S DIFILE(DIFILE,"O")=DIC
 S DIFILE(DIFILE)=$$CREF^DILF(DIC)
 N I S I=$O(^DD("KEY","AP",DIFILE,"P",0)) Q:'I
 S DIFILE(DIFILE,"KEY","IEN")=DIENS
 N F,X F F=0:0 S F=$O(^DD("KEY",I,2,F)) Q:'F  S X=$G(^(F,0)) D
 . S DIFILE(DIFILE,"KEY",+$P(X,U,2),+$P(X,U,3),+X)="" Q
 Q
 ;
SETIEN(DIC,DIFILE,DIENS) ; Set DIENS from global root
 N F,G,I,J,K,DIDA
 S F=$$FNO^DILIBF(DIFILE) I F="" S DIFILE="" Q
 S G=$G(^DIC(F,0,"GL")) I G="" S DIFILE="" Q
 S F=$P(DIC,G,2)
 S K=0 F I=1:2 S J=$P(F,",",I) Q:J=""  S K=K+1,J(K)=J
 S DIDA="" F J=1:1:K S DIDA(K+1-J)=J(J)
 S DIENS=$$IENS^DILF(.DIDA) Q
 ;
GETP(DISUB) ; Return DIC("P") for a subfile DIFILE.
 N DIFILE S DIFILE=$G(^DD(DISUB,0,"UP")) Q:'DIFILE ""
 N DIFIELD S DIFIELD=$O(^DD(DIFILE,"SB",DISUB,0)) Q:'DIFIELD ""
 Q $P($G(^DD(DIFILE,DIFIELD,0)),U,2)
 ;
DSPH ; Display name of indexed fields when DIC(0)["T" (called from DIC1 & DIC2)
 Q:$G(DS(0,"HDRDSP",DIFILEI))  S DS(0,"HDRDSP",DIFILEI)=1
 W ! N I S I=($G(DICR))*2 W:I ?I
 W "  Lookup: "
 I $G(DICR) S I=$G(@(DIC_"0)")) I I]"" W $P(I,U)_"  "
 F I=1:1:DINDEX("#") W DINDEX(I,"PROMPT")_$P(",  ^",U,I<DINDEX("#"))
 Q
 ;
 ; Error messages:
 ; 204  The input value contains control character
 ; 349  String too long by |1| character(s)!
 ; 8093 Too many lookup values for this index.
 ; 8094 Not enough lookup values provided for an e
 ; 8095 Only one compound index allowed on a looku
 ;
