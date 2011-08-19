IBDFUA ;ALB/CJM - ENCOUNTER FORM (utilities - IBDFU continued) ;NOV 16,1992
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
 ;
PRNTVAR ;defines the screen and graphics variables needed for printing
 ;
 D GSET^%ZISS,KILL^%ZISS
 S X="IOINHI;IOINORM;IOUON;IOUOFF"
 D ENDR^%ZISS
 S (IORVON,IORVOFF)=""
 K X
 Q
 ;
KPRNTVAR ;kills the variables defined by PRINTVAR 
 ; -- (actually, kills all screen paramters)
 ;
 Q:$D(VALMEVL)  ;don't kill if listman, (needed for 1010T)
 D GKILL^%ZISS,KILL^%ZISS
 Q 
 ;
GRAPHICS() ; returns1 if graphic mode available with characters needed
 ;sets graphics characters to "|" and "_" if graphics mode not available
 ;If not a raster device, then returns 0 no matter what
 ;
 N GRAPHICS S GRAPHICS=0
 I IBDEVICE("RASTER"),($G(IOG0)'=""),($G(IOG1)'=""),($G(IOVL)'=""),($G(IOHL)'=""),($G(IOBLC)'=""),($G(IOBRC)'=""),($G(IOTLC)'=""),($G(IOTRC)'="") S GRAPHICS=1
 S:IBDEVICE("PCL") GRAPHICS=1
 S:'GRAPHICS (IOVL,IOBLC,IOBRC)="|",(IOHL,IOTRC,IOTLC)="_"
 Q GRAPHICS
 ;
DEVICE(LISTMAN,IBDEVICE) ;sets various device parameters
 ;LISTMAN=1 if display for the List Manager, 0 otherwise
 ;returns IBDEVICE array - pass by reference
 ;Also, the required Kernel screen and graphics parameters are defined.
 ;
 ;IBDEVICE array elements:
 ;  RASTER = 1 if IOXY defined and not a crt
 ;  CRT= 1 if crt
 ;  GRAPHICS=1 if graphic mode available with characters needed.
 ;  PCL=1 if the printer language is PCL, version 5 or higher.
 ;  SIMPLEX,DUPLEX_LONG,DUPLEX_SHORT are printer control statements for simplex, duplex long-edge binding, duplex short-edge binding - in an encounter form file until added to the TERMINAL TYPE file in future version of KERNEL
 ;
 S IBDEVICE("TCP")=0
 ;
 I LISTMAN D  Q
 .S IBDEVICE("LISTMAN")=1
 .S IBDEVICE("CRT")=1
 .S IBDEVICE("PCL")=0
 .S IBDEVICE("GRAPHICS")=0
 .S IBDEVICE("RASTER")=0
 .D NOGRPHCS^IBDFU5
 ;
 ;not List Manager ->
 ;
 S (IBDEVICE("LISTMAN"),IBDEVICE("RASTER"),IBDEVICE("CRT"),IBDEVICE("PCL"))=0
 I $E($G(IOST),1,2)="C-" S IBDEVICE("CRT")=1
 I $G(IOXY)'="" S IBDEVICE("RASTER")=1
 D PRNTVAR
 S (IBDEVICE("SIMPLEX"),IBDEVICE("DUPLEX_LONG"),IBDEVICE("DUPLEX_SHORT"))=""
 I 'IBDEVICE("CRT"),'LISTMAN,$G(IOST(0)) D
 .N TERMINAL,TEMP
 .S TERMINAL=$G(^IBE(357.94,+$O(^IBE(357.94,"B",IOST(0),0)),0))
 .S IBDEVICE("TCP")=+$P(TERMINAL,"^",6)
 .S IBDEVICE("RESET")=$P(TERMINAL,"^",7)
 .S IBDEVICE("PCL")=$S($P(TERMINAL,"^",2)=1:1,1:0)
 .I $P(TERMINAL,"^",3)]"" S TEMP="S IBDEVICE(""SIMPLEX"")="_$P(TERMINAL,"^",3) X TEMP
 .;
 .;do not define duplex mode if simplex not defined
 .Q:IBDEVICE("SIMPLEX")=""
 .I $P(TERMINAL,"^",4)]"" S TEMP="S IBDEVICE(""DUPLEX_LONG"")="_$P(TERMINAL,"^",4) X TEMP
 .I $P(TERMINAL,"^",5)]"" S TEMP="S IBDEVICE(""DUPLEX_SHORT"")="_$P(TERMINAL,"^",5) X TEMP
 ;
 S IBDEVICE("GRAPHICS")=$$GRAPHICS
 Q
 ;
KILL ;this can be used just before calling List Manager to save space in the symbol table
 ;
 ;K XQORKBD,VALMKEY,VALMDDF,VALMHDR,%,CTRLCOL,DIC,Y,X,POP,DX,DY,%I,D,ZTSK,DIC,D0,POP,SEL,DIR,DIE,DR,DA,DIK,DD,%DT,%H,IOP,COL,J
 ;
 K %,CTRLCOL,DIC,Y,X,POP,DX,DY,%I,D,ZTSK,DIC,D0,POP,SEL,DIR,DIE,DR,DA,DIK,DD,%DT,%H,IOP,COL,J
 Q
