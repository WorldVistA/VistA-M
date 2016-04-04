DIKC ;SFISC/MKO-FIRE INDEX FILE CROSS REFERENCES ;24OCT2012
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**1,22,11,68,95,146,167**
 ;
INDEX(DIFILE,DIREC,DIFLD,DIXREF,DICTRL) ;Fire Index file xrefs
 N DA,DIF,DIKACT,DIKCT,DIKERR,DIKLOCK,DIKLOG,DIKON,DIKRFIL
 N DIKTMP,DIKVAL,DIMF,DIROOT
 ;
 ;Initialization
 S DIF=$E("D",$G(DICTRL)["D")
 I DIF["D",'$D(DIQUIET) N DIQUIET S DIQUIET=1
 I DIF["D",'$D(DIFM) N DIFM S DIFM=1 D INIZE^DIEFU
 ;
 ;Check (and convert) input parameters
 D CHK^DIKC2 G:$G(DIKERR)]"" EXIT
 ;
 ;Setup variables
 S DIKCT=$E("C",$G(DICTRL)["C")_$E("T",$G(DICTRL)["T")
 S DIKLOG=$E("K",$G(DICTRL)["K")_$E("S",$G(DICTRL)["S")
 S:DIKLOG="" DIKLOG=$E("K",DIKCT'["C")_$E("S",DIKCT'["T")
 S DIKACT=$E("R",$G(DICTRL)["R")_$E("I",$G(DICTRL)["I")
 S DIKRFIL=$S($G(DICTRL)["W":+$P(DICTRL,"W",2),1:DIFILE)
 I $G(DICTRL)["k" D
 . S DIKLOCK=+$P(DICTRL,"k",2)\1
 . S:DIKLOCK<0 DIKLOCK=-DIKLOCK
 . S:$E($P(DICTRL,"k",2))="-" DIKLOCK("STOP")=1
 E  S DIKLOCK=1
 ;
LOAD ;Load xref information into @DIKTMP
 S DIKTMP=$G(DICTRL("LOGIC"))
 I $G(DIKTMP)="" D
 . S DIKTMP=$$GETTMP^DIKC1("DIKC")
 . I $G(DIXREF)?."^" D
 .. I $G(DIFLD) D
 ...D LOADFLD^DIKC1(DIKRFIL,DIFLD,DIKLOG_"W",DIKACT,DIKVAL,DIKTMP,DIKTMP,$E("i",$G(DICTRL)["i"),,$E("x",$G(DICTRL)["x"))
 .. E  D LOADALL^DIKC1(DIKRFIL,DIKLOG,DIKACT,DIKVAL,DIKTMP,$E("s",$G(DICTRL)["s")_$E("i",$G(DICTRL)["i")_$E("x",$G(DICTRL)["x"),.DIMF)
 . E  D LOADXREF^DIKC1(DIKRFIL,$G(DIFLD),DIKLOG,.DIXREF,DIKVAL,DIKTMP)
 ;
 D:DIKRFIL'=DIFILE SBINFO^DIKCU(DIKRFIL,.DIMF)
 ;
 ;Fire the xrefs for all records or the record specified in DA
 I 'DA D
 . L +@DIROOT:DIKLOCK E  D  Q:$G(DIKLOCK("STOP"))
 .. S DIKLOCK=""
 .. D:DIF["D" ERR^DIKCU2(112,DIFILE)
 . D FIREALL(DIFILE,.DA,DIROOT,DIKLOG,.DIMF,DIKTMP,DIKON,"",DIKCT)
 . L:DIKLOCK]"" -@DIROOT
 E  D
 . L +@DIROOT@(DA):DIKLOCK E  D  Q:$G(DIKLOCK("STOP"))
 .. S DIKLOCK=""
 .. D:DIF["D" ERR^DIKCU2(110,DIFILE,$$IENS^DIKCU(DIFILE,.DA))
 . D:$D(@DIKTMP@(DIFILE)) FIRE(DIFILE,.DA,DIKLOG,DIKTMP,DIKON,"",DIKCT)
 . D:$D(DIMF(DIFILE)) FIRESUB(DIFILE,.DA,DIROOT,DIKLOG,.DIMF,DIKTMP,DIKON,"",DIKCT)
 . L:DIKLOCK]"" -@DIROOT@(DA)
 ;
 ;Cleanup ^TMP
 K @DIKTMP
 ;
EXIT ;Move error messages if necessary
 I DIF["D",$G(DIERR),$G(DICTRL("MSG"))]"" D CALLOUT^DIEFU(DICTRL("MSG"))
 Q
 ;
FIREALL(DIFILE,DA,DIROOT,DILOG,DIMF,DIKTMP,DIKON,DIKEY,DIKCT) ;Fire xrefs, all recs
 N DICNT,DIIENS,DILAST,DIXR
 S DILOG=$G(DILOG),DIKON=$G(DIKON)
 S DIIENS=$$IENS^DIKCU(DIFILE,.DA)
 ;
 ;Kill entire indexes
 I DILOG["K",$D(@DIKTMP@("KW",DIFILE)) D XECKW(DIFILE,.DA,$D(DIMF(DIFILE))>0)
 I '$D(@DIKTMP@(DIFILE)),'$D(DIMF(DIFILE)) Q
 ;
 ;Loop through all records in the file
 S (DICNT,DA)=0 F  S DA=$O(@DIROOT@(DA)) Q:DA'=+DA  D
 . S $P(DIIENS,",")=DA
 . S DICNT=DICNT+1
 . D:$D(@DIKTMP@(DIFILE)) FIRE(DIFILE,.DA,DILOG,DIKTMP,DIKON,.DIKEY,DIKCT,DIIENS)
 . D:$D(DIMF(DIFILE)) FIRESUB(DIFILE,.DA,DIROOT,DILOG,.DIMF,DIKTMP,DIKON,.DIKEY,DIKCT)
 ;
 ;Update header node
 I $D(@DIROOT@(0))#2 D
 . S DILAST=$O(@DIROOT@(" "),-1) S:'DILAST DILAST=""
 . S:'DICNT DICNT=""
 . S $P(@DIROOT@(0),U,4)=DICNT ;**DI*22*146
 Q
 ;
FIRE(DIFILE,DA,DILOG,DIKTMP,DIKON,DIKEY,DIKCT,DIIENS) ;Fire xrefs, one record
 N DI01,DIKCLOG,DINULL,DION,DIXR,I,J,X,X2,XN
 S DILOG=$G(DILOG),DIKON=$G(DIKON)
 S:$G(DIIENS)="" DIIENS=$$IENS^DIKCU(DIFILE,.DA)
 ;
 I DIKON="" S DIXR=0 F  S DIXR=$O(@DIKTMP@(DIFILE,DIXR)) Q:DIXR'=+DIXR  D
 . D SETXARR(DIFILE,DIXR,DIKTMP,.DINULL) Q:DINULL
 . I $G(DIKCT)="" D XECUTE(DIFILE,DIXR,DILOG,.X,.X,DIKTMP) Q
 . ;
 . K XN S XN="",I=0 F  S I=$O(X(I)) Q:'I  S XN(I)=""
 . I $G(DIKCT)="C" D XECUTE(DIFILE,DIXR,"S",.XN,.X,DIKTMP) Q
 . I $G(DIKCT)="T" D XECUTE(DIFILE,DIXR,"K",.X,.XN,DIKTMP) Q
 ;
 E  S DIXR=0 F  S DIXR=$O(@DIKTMP@(DIFILE,DIXR)) Q:DIXR'=+DIXR  D
 . K DINFLD
 . S DIKCLOG=""
 . ;
 . ;Set X2 array to new values
 . S DION=$P(DIKON,U,2)
 . D SETXARR(DIFILE,DIXR,DIKTMP,.DINULL,DION) M X2=X
 . ;
 . ;If SET requested, make sure no new values are null
 . I DILOG["S" D
 .. I 'DINULL S DIKCLOG="S"
 .. E  I $P(DIKON,U,4)="N" S I=0 F  S I=$O(^DD("KEY","AU",DIXR,I)) Q:'I  D
 ... S DIKEY(DIFILE,I,DIIENS)="n"
 ... S J=0 F  S J=$O(DINULL(J)) Q:'J  S DIKEY(DIFILE,I,DIIENS,$P(DINULL(J),U),$P(DINULL(J),U,2))=$P(DINULL(J),U,3)
 . ;
 . ;Set X array to old values
 . S DION=$P(DIKON,U)
 . D SETXARR(DIFILE,DIXR,DIKTMP,.DINULL,DION,.DI01)
 . ;
 . ;If KILL requested, make sure no old values are null
 . I DILOG["K",'DINULL S DIKCLOG="K"_DIKCLOG
 . ;
 . ;If "C" flag, set old .01 value to null
 . I $G(DIKCT)="C",$D(DI01) D
 .. S I=0 F  S I=$O(DI01(I)) Q:'I  S X(I)=""
 .. S:$O(DI01(0))=$O(X(0)) X=""
 .. S DIKCLOG=$TR(DIKCLOG,"K")
 . ;
 . ;If "T" flag, set all new values to null
 . I $G(DIKCT)="T" S X2="",I=0 F  S I=$O(X2(I)) Q:'I  S X2(I)=""
 . ;
 . ;Execute the kill and set logic
 . D XECUTE(DIFILE,DIXR,DIKCLOG,.X,.X2,DIKTMP)
 . ;
 . I DIKCLOG["S",$P(DIKON,U,3)="K",$D(^DD("KEY","AU",DIXR)) D
 .. Q:$$UNIQUE^DIKK2(DIFILE,DIXR,.X2,.DA,DIKTMP)
 .. S I=0 F  S I=$O(^DD("KEY","AU",DIXR,I)) Q:'I  S DIKEY(DIFILE,I,DIIENS)=""
 Q
 ;
FIRESUB(DIFILE,DA,DIROOT,DILOG,DIMF,DIKTMP,DIKON,DIKEY,DIKCT) ;Fire xrefs for
 ;all subfiles under DIFILE, for all subrecords under DA
 Q:'$D(DIMF(DIFILE))
 N DIMULTF,DISBFILE,DISBROOT,X
 S DILOG=$G(DILOG),DIKON=$G(DIKON)
 ;
 ;Push down the DA array
 D PUSHDA^DIKCU(.DA)
 ;
 ;Loop through DIMF array and fire xrefs for subfiles
 S DIMULTF=0 F  S DIMULTF=$O(DIMF(DIFILE,DIMULTF)) Q:'DIMULTF  D
 . S DISBROOT=$NA(@DIROOT@(DA(1),DIMF(DIFILE,DIMULTF))) Q:'$D(@DISBROOT)
 . S DISBFILE=DIMF(DIFILE,DIMULTF,0)
 . D FIREALL(DISBFILE,.DA,DISBROOT,DILOG,.DIMF,DIKTMP,DIKON,.DIKEY,DIKCT)
 ;
 ;Pop the DA array
 D POPDA^DIKCU(.DA)
 Q
 ;
XECUTE(DIFILE,DIXR,DILOG,DIKCX1,DIKCX2,DIKTMP) ;Xecute the logic in ^TMP
 Q:$G(DILOG)=""
 N DIKCOD,DIKCON,X,X1,X2
 ;
 ;Execute kill logic
 I DILOG["K" D
 . S DIKCOD=$G(@DIKTMP@(DIFILE,DIXR,"K")) Q:DIKCOD?."^"
 . S DIKCON=$G(@DIKTMP@(DIFILE,DIXR,"KC"))
 . I DIKCON'?."^" M X=DIKCX1,X1=DIKCX1,X2=DIKCX2 X DIKCON Q:'$G(X)  K X,X1,X2
 . M X=DIKCX1,X1=DIKCX1,X2=DIKCX2
 . X DIKCOD K X,X1,X2
 ;
 ;Execute set logic
 I DILOG["S" D
 . S DIKCOD=$G(@DIKTMP@(DIFILE,DIXR,"S")) Q:DIKCOD?."^"
 . S DIKCON=$G(@DIKTMP@(DIFILE,DIXR,"SC"))
 . I DIKCON'?."^" M X=DIKCX2,X1=DIKCX1,X2=DIKCX2 X DIKCON Q:'$G(X)  K X,X1,X2
 . M X=DIKCX2,X1=DIKCX1,X2=DIKCX2
 . X DIKCOD
 Q
 ;
XECKW(DIFILE,DA,DIKSUB) ;Execute the logic to kill the entire index
 N DIKFIL,DIKKW,DIKKW0,DIKLDIF,DIXR
 ;
 S DIXR=0 F  S DIXR=$O(@DIKTMP@("KW",DIFILE,DIXR)) Q:DIXR'=+DIXR  D
 . S DIKKW=$G(@DIKTMP@("KW",DIFILE,DIXR)) Q:DIKKW?."^"
 . S DIKKW0=$G(@DIKTMP@("KW",DIFILE,DIXR,0))
 . ;
 . ;If not a whole file xref, kill the entire index and quit
 . I DIKKW0="" X DIKKW D  Q
 .. I '$D(@DIKTMP@(DIFILE,DIXR,"S")) K @DIKTMP@(DIFILE,DIXR)
 .. E  K @DIKTMP@(DIFILE,DIXR,"K"),@DIKTMP@(DIFILE,DIXR,"KC")
 . ;
 . ;Quit if this isn't a whole file xref or we're not doing subfiles
 . Q:$P(DIKKW0,U)'="W"!'$G(DIKSUB)
 . ;
 . ;Kill the whole index after pushing DA the appropriate amount
 . S DIKFIL=$P(DIKKW0,U,2),DIKLDIF=$P(DIKKW0,U,3)
 . D PUSHDA^DIKCU(.DA,DIKLDIF)
 . X DIKKW
 . I '$D(@DIKTMP@(DIKFIL,DIXR,"S")) K @DIKTMP@(DIKFIL,DIXR)
 . E  K @DIKTMP@(DIKFIL,DIXR,"K"),@DIKTMP@(DIKFIL,DIXR,"KC")
 . D POPDA^DIKCU(.DA,DIKLDIF)
 Q
 ;
SETXARR(DIFILE,DIXR,DIKTMP,DINULL,DION,DI01) ;Loop through DIKTMP and set X array.
 ;If any values used as subscripts are null, return
 ; DINULL=1
 ; DINULL(order#) = ""
 ;                  or file^field^levDiff (for field type subscripts)
 ; DI01(order#) = "" if order # is .01 field
 ;
 N DIKCX,DIKF,DIKO,X1,X2
 K X,DI01,DINULL
 S DINULL=0,(DIKF,DIKO)=$O(@DIKTMP@(DIFILE,DIXR,0)) Q:'DIKF
 ;
 S:$G(DION)="" DION=U
 F  D  S DIKO=$O(@DIKTMP@(DIFILE,DIXR,DIKO)) Q:'DIKO
 . K DIKCX M DIKCX=X
 . X $G(@DIKTMP@(DIFILE,DIXR,DIKO))
 . I $G(X)]"",$D(@DIKTMP@(DIFILE,DIXR,DIKO,"T")) X @DIKTMP@(DIFILE,DIXR,DIKO,"T")
 . S:$D(X)#2 (DIKCX,DIKCX(DIKO))=X K X M X=DIKCX
 . S:$P($G(@DIKTMP@(DIFILE,DIXR,DIKO,"F")),U,2)=.01 DI01(DIKO)=""
 . I $G(X(DIKO))="",$G(@DIKTMP@(DIFILE,DIXR,DIKO,"SS")) S DINULL=1 S:$G(@DIKTMP@(DIFILE,DIXR,DIKO,"F")) DINULL(DIKO)=@DIKTMP@(DIFILE,DIXR,DIKO,"F")
 ;
 S:$D(X(DIKF))#2 X=$G(X(DIKF))
 Q
 ;
 ;#110  The record is currently locked.
 ;#112  The file is currently locked.
