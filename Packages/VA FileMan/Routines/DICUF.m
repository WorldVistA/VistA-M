DICUF ;SEA/TOAD,SF/TKW-FileMan: Lookup Tools, Files ;12APR2008
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**1032**
 ;
 ;
FILE(DIFILE,DIFIEN,DIFLAGS) ;
 ; retrieve and calculate info about indexed file
 ;
F1 ; set and check source file number. 
 ;
 S DIFILE=+$G(DIFILE) I 'DIFILE D ERR(202,"","","","","file") Q
 ;
F2 ; get the file's .01 definition; quit & error if bad
 ;
 N DINODE S DINODE=$G(^DD(DIFILE,.01,0))
 I DINODE="" D ERR($S('$D(^DD(DIFILE)):401,1:406),DIFILE) Q
 I $P(DINODE,U,2)["W" D ERR(407,DIFILE) Q
 ;
F3 ; set and check the Lister's IENS parameter
 ;
 S DIFIEN=$G(DIFIEN) I DIFIEN="" S DIFIEN=","
 I '$$IEN^DIDU1(DIFIEN) D  Q
 . I '$$IEN^DIDU1(DIFIEN_",") D ERR(202,"","","","","IENS") Q
 . E  D ERR(304,"",DIFIEN) Q
 I $P(DIFIEN,",")'="" D ERR(306,"",DIFIEN) Q
 ;
F4 ; calculate the source file's global root (open & closed)
 ;
 S DIFILE(DIFILE)=$$ROOT^DIQGU(DIFILE,DIFIEN,1,1) Q:$G(DIERR)
 I DIFILE(DIFILE)'?1"^"1A.ANP,DIFILE(DIFILE)'?1"^%".ANP D  Q  ;JIM SELF --ALLOW LC GLOBAL NAMES
 . D ERR(402,DIFILE,DIFIEN,"",DIFILE(DIFILE))
 S DIFILE(DIFILE,"O")=$$OREF^DIQGU(DIFILE(DIFILE))
 Q
 ;
SCREEN(DIFLAGS,DIFILE,DISCREEN) ;
 ; Set user defined and whole file screen variables.
 ;
 I $G(DISCREEN("S"))="" S DISCREEN("S")=$G(DISCREEN)
 I $G(DISCREEN("V"))]"",$G(DISCREEN("V",1))']"" S DISCREEN("V",1)=DISCREEN("V")
 S DISCREEN("F")="" I DIFLAGS'["U" D
 . Q:$P($G(@DIFILE(DIFILE)@(0)),U,2)'["s"
 . S DISCREEN("F")=$G(^DD(DIFILE,0,"SCR"))
 . Q
 Q
 ;
VPDATA(DINDEX,DISCREEN) ; Add variable pointer info to DINDEX array for executing DIC("V") type screen
 N DISUB,F,I,F1,F2,G,Y
 F DISUB=1:1:DINDEX("#") I $G(DISCREEN("V",DISUB))]"" D
 . S F1=DINDEX(DISUB,"FILE"),F2=DINDEX(DISUB,"FIELD") Q:'F1!('F2)
 . F F=0:0 S F=$O(^DD(F1,F2,"V","B",F)) Q:'F  D
 . . S I=$O(^DD(F1,F2,"V","B",F,0)) Q:'I
 . . S Y(0)=$G(^DD(F1,F2,"V",I,0)) Q:Y(0)=""
 . . X DISCREEN("V",DISUB) Q:'$T
 . . S G=$G(^DIC(F,0,"GL")) Q:G=""
 . . S DINDEX(DISUB,"VP",G)="" Q
 . Q
 Q
 ;
ERR(DIERN,DIFILE,DIIENS,DIFIELD,DIROOT,DI1,DI2,DI3) ;
 ;
 ; error logging procedure
 ;
E1 N DIPE,P
 N DI F DI="FILE","IENS","FIELD","ROOT",1:1:3 D
 . S P=$G(@("DI"_DI)) Q:P=""
 . S DIPE(DI)=P
 D BLD^DIALOG(DIERN,.DIPE,.DIPE)
 Q
 ;
