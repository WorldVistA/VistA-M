DDR1 ;ALB/MJK-FileMan Delphi Components' RPCs ;4/18/97  16:15
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 Q
 ;
DIKC(DDROK,DDR) ; -- broker callback to kill a file entry via ^DIK
 N DIK,DA,FILE,IENS,FDA
 S FILE=$G(DDR("FILE"))
 S IENS=$G(DDR("IENS"))
 I $$FNO^DILIBF(FILE)=FILE,$L(IENS,",")=2 D  Q
 . S DIK=$G(^DIC(FILE,0,"GL")),DA=+IENS D ^DIK S DDROK=1
 S FDA(FILE,IENS,.01)="@"
 D FILE^DIE("","FDA")
 S DDROK='$G(DIERR)
 Q
 ;
LOCKC(DDROK,DDR) ; -- broker callback to lock/unlock a node
 N DDRNODE
 S DDRNODE=$G(DDR("NODE"))
 IF DDRNODE]"" D
 . IF $G(DDR("LOCKMODE")) D
 . . L @("+"_DDRNODE_":"_$G(DDR("TIMEOUT"),5))
 . . S DDROK=$T
 . ELSE  D
 . . L @("-"_DDRNODE)
 . . S DDROK=1
 ELSE  D
 . S DDROK=0
 Q
 ;
FILENOC(DDRFLNO,DDRNAME) ; -- broker callback to get File #
 ;
 S DDRFLNO=+$O(^DIC("B",DDRNAME,""))
 Q
 ;
NODEC(DDRNODE,DDRROOT) ; -- broker callback to get global node value
 ;
 ;S DDRNODE=$G(@DDRROOT)
 IF $D(@DDRROOT)=0!($D(@DDRROOT)=10) D
 . S DDRNODE="{{"_$D(@DDRROOT)_"}}"
 IF $D(@DDRROOT)=1!($D(@DDRROOT)=11) D
 . S DDRNODE=$G(@DDRROOT)
 Q
 ;
GLCNT(DDROK,DDR) ; -- extrinsic call to invoke broker to return number of
 ;       global nodes found at cross reference
 N DDRNODE,DDRTEAM,DDRXREF
 ;
 S DDRNODE=$G(DDR("ROOT"))
 S DDRXREF=$G(DDR("XREF"))
 S DDRVAL=$G(DDR("VALUE"))
 ;
 S:DDRXREF="" DDRXREF="B"
 S I="",X=0
 F  S I=$O(@DDRNODE@(DDRXREF,DDRVAL,I)) Q:I=""  D
 . S X=X+1
 S DDROK=$G(X)
 Q
 ;
IFNODE(DDRNODE,DDRROOT) ; -- extrinsic call to check if node exists.
 ; passes in full node reference
 N X
 ;
 IF $D(@DDRROOT)=0!($D(@DDRROOT)=10) D
 . S DDRNODE="{{"_$D(@DDRROOT)_"}}"
 IF $D(@DDRROOT)=1!($D(@DDRROOT)=11) D
 . S DDRNODE=$G(@DDRROOT)
 Q
