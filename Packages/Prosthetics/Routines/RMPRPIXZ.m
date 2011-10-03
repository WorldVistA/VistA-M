RMPRPIXZ ;HINCIO/ODJ - MISC. ;3/8/01
 ;;3.0;PROSTHETICS;**61**;Feb 09, 1996
 Q
 ;
 ; Some miscellaneous routines to be used for testing only
 ; NOT FOR GENERAL USE
 ;
 ;
 ; Clear down new PIP files
 ; Only use if need to re-run the old to new PIP file conversion
 ; utility in RMPRPIUG
KILL N FIL,S,P62,I,P60
 ;
 ; Restore pointers to 661.2 in file 660
 S I=0
 F  S I=$O(^RMPR(661.63,I)) Q:'+I  D
 . S S=^RMPR(661.63,I,0)
 . S P62=$P(S,"^",3)
 . S P60=$P(S,"^",2)
 . S $P(^RMPR(660,P60,1),"^",5)=P62
 . Q
 ;
 ; Clear down new files
 F FIL=661.11,661.4,661.41,661.5,661.6,661.63,661.69,661.7,661.9 D
 . S S=^RMPR(FIL,0)
 . S $P(S,"^",3)=0,$P(S,"^",4)=0
 . K ^RMPR(FIL)
 . S ^RMPR(FIL,0)=S
 . Q
 Q
 ;
 ; Make all Locations start with 'A'
ALOC N NM,IEN,RMPR,RMPRE,FIL
 F FIL=661.3,661.5 D
 . S IEN=0
 . F  S IEN=$O(^RMPR(FIL,IEN)) Q:'+IEN  D
 .. S NM=$P(^RMPR(FIL,IEN,0),"^",1)
 .. W !,NM
 .. K RMPR
 .. S RMPR(FIL,IEN_",",.01)="A"_NM
 .. D FILE^DIE("","RMPR","RMPRE")
 .. Q
 . Q
 Q
 ;
 ; Get rid of 1st char.
REMA N NM,IEN,RMPR,RMPRE,FIL
 F FIL=661.3,661.5 D
 . S IEN=0
 . F  S IEN=$O(^RMPR(FIL,IEN)) Q:'+IEN  D
 .. S NM=$P(^RMPR(FIL,IEN,0),"^",1)
 .. W !,NM
 .. K RMPR
 .. S RMPR(FIL,IEN_",",.01)=$E(NM,2,$L(NM))
 .. D FILE^DIE("","RMPR","RMPRE")
 .. Q
 . Q
 Q
