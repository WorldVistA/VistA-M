DICA3 ;SEA/TOAD-VA FileMan: Updater, Adder ;16FEB2011
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**1021,147,1034,1036,1041**
 ;
CREATE(DIFILE,DIEN,DIROOT,DIVALUE) ;If DIEN comes in with a leading number, use it as IEN
 N DIENP S DIENP=","_$P(DIEN,",",2,999)
 S DIEN=$P(DIEN,",")
 N DINEXT S DINEXT=$P($G(@(DIROOT_"0)")),U,3)
 I DINEXT="" D  I $G(DIERR) S DIEN="" Q
 . N DIHEADER S DIHEADER=$$HEADER^DIDU2(.DIFILE,DIENP)
 . I '$G(DIERR) S @(DIROOT_"0)")=DIHEADER
GETNUM ;
 N DINUM,DIFAUD S DINUM=DIEN'="",DIFAUD=0 I 'DINUM S DIEN=DINEXT\1 I $D(^DIA(DIFILE,"B")) S DIFAUD=DIFILE
 N DIFAIL,DIOUT S DIFAIL=0,DIOUT=0 F  D  I DIOUT!DIFAIL Q
 . I 'DINUM S DIEN=DIEN+1 I $D(@(DIROOT_"DIEN)")) Q  ;**GFT LOOK BEFORE LOCKING
 . I DIFAUD,+$O(^DIA(DIFAUD,"B",DIEN_","))=DIEN!$D(^(DIEN)) Q  ;**GFT   DON'T PICK AN ALREADY-AUDITED NUMBER
 . I DIEN'>0 D ERR(202,DIFILE,DIEN,.01,"ASSIGNED IEN") S DIFAIL=1 Q  ;ARTF10963 -- "The input parameter that identifies the ASSIGNED IEN is missing or invalid."
 . D LOCK^DILF(DIROOT_"DIEN)") ;**147
 . I '$T S DIFAIL=DINUM Q:'DIFAIL  D ERR(110,DIFILE,DIEN_DIENP) Q  ;RECORD IS LOCKED
ZERO . I $D(@(DIROOT_"DIEN,0)")) L -@(DIROOT_"DIEN)") D  Q
 . . S DIFAIL=DINUM I 'DIFAIL Q  ;COULDN'T DO DINUM!
 . . D ERR(302,DIFILE,DIEN_DIENP) ;ENTRY ALREADY EXISTS
 . S DIOUT=1
 I DIFAIL S DIEN="" Q
SETREC ;
 N DICAFILE M DICAFILE=DIFILE N DIFILE
 S @(DIROOT_"DIEN,0)")=DIVALUE
 D LOCK^DILF(DIROOT_"0)") ;**147
 S $P(^(0),U,3,4)=DIEN_U_($P(@(DIROOT_"0)"),U,4)+1)
 I  L -@(DIROOT_"0)")
 S DIEN=DIEN_DIENP
 D XA^DIEFU(DICAFILE,DIEN,.01,DIVALUE,"")
 D INDEX^DIKC(DICAFILE,DIEN,.01,"","SC")
 Q
 ;
PROOT(DIFILE,DIEN) ;
 ; ENTRY POINT--return the global root of a subfile's parent
 ; extrinsic function, all passed by value
 N DIENP S DIENP=$P(DIEN,",",2,999)
 Q $NA(@$$ROOT^DILFD($$PARENT(DIFILE),DIENP,1)@(+DIENP))
 ;
PARENT(DIFILE) ;
 ; ENTRY POINT--return the file number of a subfile's parent
 ; extrinsic function, all passed by value
 Q $G(^DD(DIFILE,0,"UP"))
 ;
SUBFILE(DIFILE) ;
 ; ENTRY POINT--return whether the file is a subfile
 ; extrinsic function, passed by value
 Q $D(^DD(DIFILE,0,"UP"))#2
 ;
ERR(DIERN,DIFILE,DIIENS,DIFIELD,DI1,DI2,DI3) ;
 ; error logging procedure
 N DIPE
 N DI F DI="FILE","IENS","FIELD",1:1:3 S DIPE(DI)=$G(@("DI"_DI))
 D BLD^DIALOG(DIERN,.DIPE,.DIPE)
 Q
