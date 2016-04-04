DIKD1 ;SFISC/MKO-DELETE XREF DATA ;1:03 PM  20 Aug 1999
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**12**
 ;
KILL(DIFIL,DIFLD,DIXR,DIFLG,DIKDMSG) ;Delete xref data
 N DA,DIDEC,DIF,DIFILR,DIKILL,DIMF,DINAM,DIQUIT,DIROOT,DITOPF,DITYP
 ;
 ;Init
 I '$D(DIFM) N DIFM S DIFM=1 D INIZE^DIEFU
 S DIFLG=$G(DIFLG)
 S DIF=$E("D",DIFLG'["d")
 I DIFLG'["c" D CHK G:$G(DIQUIT) END
 D INIT G:$D(DIQUIT) END
 ;
 ;Fire the kill logic
 D:$G(DIFLG)["W"
 . I DITYP="BULLETIN"!(DITYP="MUMPS")!(DITYP="TRIGGER") D
 .. W !,"Executing kill logic ..."
 . E  W !,"Removing index ..."
 D FIRE(DITOPF,DIROOT)
 ;
END ;Move error message if necessary and quit
 D:$G(DIKDMSG)]"" CALLOUT^DIEFU(DIKDMSG)
 Q
 ;
FIRE(DIFILE,DIROOT) ;Fire the kill logic
 N DICNT,DILAST,DIMULTF,DISBROOT,X
 ;
 ;If we're at the level where the index resides,
 ;check whether we can delete the entire index with one kill
 I DIFILE=DIFILR,DINAM?1.E,DITYP'="MNEMONIC",DITYP'="MUMPS" D
 . K @DIROOT@(DINAM)
 ;
 ;Else, if we're at the level where the index is defined,
 ;execute the kill logic for each entry
 E  I DIFILE=DIFIL S (DICNT,DA)=0 F  S DA=$O(@DIROOT@(DA)) Q:DA'=+DA  D
 . N X
 . S DICNT=DICNT+1
 . X DIDEC X:X]"" DIKILL
 ;
 ;Else, for all entries, descend into multiple
 E  S DIMULTF=$O(DIMF(DIFILE,0)) I DIMULTF S (DICNT,DA)=0 F  S DA=$O(@DIROOT@(DA)) Q:DA'=+DA  D
 . S DICNT=DICNT+1
 . S DISBROOT=$NA(@DIROOT@(DA,DIMF(DIFILE,DIMULTF))) Q:'$D(@DISBROOT)
 . D PUSHDA^DIKCU(.DA)
 . D FIRE(DIMF(DIFILE,DIMULTF,0),DISBROOT)
 . D POPDA^DIKCU(.DA)
 ;
 I $D(DICNT),$D(@DIROOT@(0))#2 D
 . S DILAST=$O(@DIROOT@(" "),-1)
 . S:'DILAST DILAST="" S:'DICNT DICNT=""
 . S $P(@DIROOT@(0),U,3,4)=DILAST_U_DICNT
 Q
 ;
CHK ;Check input parameters
 I '$G(DIFIL) D:DIF["D" ERR^DIKCU2(202,"","","","FILE") D QUIT
 I '$G(DIFLD) D:DIF["D" ERR^DIKCU2(202,"","","","FIELD") D QUIT
 I '$G(DIQUIT),'$$VFLD^DIKCU1($G(DIFIL),$G(DIFLD),DIF) D QUIT
 I '$G(DIXR) D:DIF["D" ERR^DIKCU2(202,"","","","CROSS-REFERENCE") D QUIT
 D:'$$VFLAG^DIKCU1(DIFLG,"Wcd",DIF) QUIT
 Q
 ;
INIT ;Get xref info and subfile info
 N DIXR0
 S DIXR0=$G(^DD(DIFIL,DIFLD,1,DIXR,0)) G:DIXR0="" QUIT
 S DIFILR=$P(DIXR0,U),DINAM=$P(DIXR0,U,2),DITYP=$P(DIXR0,U,3)
 G:DITYP="BULLETIN" QUIT
 ;
 S DIKILL=$G(^DD(DIFIL,DIFLD,1,DIXR,2))
 G:DIKILL="Q"!(DIKILL?."^") QUIT
 ;
 D SBINFO^DIKCU(DIFIL,.DIMF)
 I '$D(DIMF) S DITOPF=DIFIL
 E  S DITOPF=0 F  S DITOPF=$O(DIMF(DITOPF)) Q:'$G(^DD(DITOPF,0,"UP"))
 ;
 S DIROOT=$$CREF^DILF($G(^DIC(DITOPF,0,"GL")))
 S DIDEC=$$DEC^DIKC2(DIFIL,DIFLD)
 G:DIROOT=""!(DIDEC="") QUIT
 Q
 ;
QUIT ;Set flag to quit
 S DIQUIT=1
 Q
