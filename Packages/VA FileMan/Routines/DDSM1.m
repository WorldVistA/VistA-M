DDSM1 ;SFISC/MKO-MULTILINE, LOAD AND DELETE ;2015-01-02  5:49 PM
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**8,1003**
 ;
LOAD(DDSIEN) ;Load subentries
MLOAD ;Entry point from MLOAD^DDSUTL
 ;@DDSIEN is an array of record numbers
 ;
 Q:$D(DDSIEN)[0
 Q:$D(@DDSIEN)<9
 ;
 N DDSI,DDSPDA,DDSRN,DDSSN
 S DDSPDA=$P(DDSREP,U)
 S DDSSN=$O(@DDSREFT@(DDSPG,DDSBK,DDSPDA," "),-1)
 ;
 ;Add records to internal ^TMP array
 ;Load data for each record
 S DDSI="" F  S DDSI=$O(@DDSIEN@(DDSI)) Q:DDSI=""  D
 . S DDSRN=@DDSIEN@(DDSI) Q:'DDSRN
 . S DA=+DDSRN,$P(DDSDA,",")=DA,@("D"_DDSDL)=DA
 . I $D(@DDSREFT@(DDSPG,DDSBK,DDSPDA,"B",DDSDA))[0 D
 .. S DDSSN=DDSSN+1
 .. S @DDSREFT@(DDSPG,DDSBK,DDSPDA,"B",DDSDA)=DDSSN
 .. S @DDSREFT@(DDSPG,DDSBK,DDSPDA,DDSSN)=DDSDA
 .. S ^("ADD")=$G(@DDSREFT@("ADD"))+1,^("ADD",^("ADD"))=DDSDA_DIE
 . D EN^DDS11(DDSBK)
 . S DDSCHG=1
 ;
 ;Position the cursor on blank (Select) line
 ;Repaint all lines in the repeating block
 D POSSN^DDSM(999999999999)
 D DMULTN^DDSR(DDSPG,DDSBK,DDSPDA,$P(DDSREP,U,5),1)
 ;
 ;Update DIR0
DIR0 S DIR0=$P(@DDSREFS@(DDSPG,DDSBK,DDO,"D"),U,1,3)
 S:$P($G(DDSREP),U,3)>1 $P(DIR0,U)=$P(DIR0,U)+($P(DDSREP,U,3)-1*$$HITE^DDSR(DDSBK)) ;DJW/GFT
 Q
 ;
DEL(DDSIEN) ;Delete subentries
MDEL ;Entry point from MDEL^DDSUTL
 ;In:
 ; If DDSIEN contains a record number, delete that one (G MDELONE)
 ; If DDSIEN contains a closed root, @DDSIEN is an array
 ;  of record numbers to delete
 ; DIE   = global root
 ; DDSDA = current IENS
 ;
 Q:$D(DDSIEN)[0
 G:+$P(DDSIEN,"E") MDELONE
 Q:$D(@DDSIEN)<9
 ;
 N DDSI,DDSPDA,DDSRN,DDSSN
 S DDSPDA=$P(DDSREP,U)
 ;
 ;Loop through passed array and delete subentries
 S DDSI="" F  S DDSI=$O(@DDSIEN@(DDSI)) Q:DDSI=""  D
 . ;S DDSRN=@DDSIEN@(DDSI) Q:'DDSRN
 . ;S DDSIENS=DDSDA,$P(DDSIENS,",")=+DDSRN
 . ;D K^DDS6(DDSIENS,DIE)
 . ;Q
 . ;
 . S DDSRN=@DDSIEN@(DDSI) Q:'DDSRN
 . S DA=+DDSRN,$P(DDSDA,",")=DA
 . S DDSSN=$G(@DDSREFT@(DDSPG,DDSBK,DDSPDA,"B",DDSDA)) Q:'DDSSN
 . K @DDSREFT@(DDSPG,DDSBK,DDSPDA,"B",DDSDA)
 . K @DDSREFT@(DDSPG,DDSBK,DDSPDA,DDSSN)
 . K @DDSREFT@("F"_DDP,DDSDA)
 . K @DDSREFT@("F0",DDSDA)
 ;
 ;Close up gaps in ^TMP array
 S (DDSI,DDSSN)=0
 F  S DDSI=$O(@DDSREFT@(DDSPG,DDSBK,DDSPDA,DDSI)) Q:'DDSI  D
 . S DDSSN=DDSSN+1 Q:DDSI=DDSSN
 . S DDSRN=@DDSREFT@(DDSPG,DDSBK,DDSPDA,DDSI)
 . S @DDSREFT@(DDSPG,DDSBK,DDSPDA,DDSSN)=DDSRN
 . S @DDSREFT@(DDSPG,DDSBK,DDSPDA,"B",DDSRN)=DDSSN
 ;
 F  S DDSSN=$O(@DDSREFT@(DDSPG,DDSBK,DDSPDA,DDSSN)) Q:'DDSSN  D
 . K @DDSREFT@(DDSPG,DDSBK,DDSPDA,DDSSN)
 ;
 ;Position cursor on "Select" line
 ;Repaint all lines in repeating block
 D POSSN^DDSM(999999999999,1)
 ;
 ;Update DIR0
DIR01 D DIR0
 Q
 ;
MDELONE ;Delete one subentry in the current repeating block
 ;In:  DDSIEN = IENS of record to be deleted
 ;     DDSREP = data for repeating blocks
 ;     DDSDA  = current IENS
 ;     DIE    = current global root
 ;
 N DDSPDA,DDSRN,DDSSN
 ;
 ;Get parent IENS
 S DDSPDA=$P(DDSREP,U)
 ;
 ;Kill all data pertaining to current (sub)record
 D K^DDS6(DDSIEN,DIE)
 ;
 ;Repaint lines and reposition cursor
 I DDSDA=DDSIEN D
 . D DMULTN^DDSR(DDSPG,DDSBK,DDSPDA,$P(DDSREP,U,5),$P(DDSREP,U,3))
 . S DDSSN=$P(DDSREP,U,4)
 . I $D(@DDSREFT@(DDSPG,DDSBK,DDSPDA,DDSSN))[0 D
 .. S DDSSN=$O(@DDSREFT@(DDSPG,DDSBK,DDSPDA,DDSSN),-1)
 . D POSSN^DDSM(DDSSN)
 ;
 E  D POSSN^DDSM(999999999999,1)
 ;
DIR02 D DIR0
 Q
