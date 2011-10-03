XMKPR1 ;ISC-SF/GMB-^XMKPR (cont.) ;09/06/2002  09:11
 ;;8.0;MailMan;**3**;Jun 28, 2002
 ; Reference to ^XTV(8989.3 - IA #3749
SCRIPT(XMINST,XMSITE,XMB,XMOKTYPE) ; Get first/next Transmission Script
 ; XMINST   (in)  Pointer to domain file
 ; XMSITE   (in)  Name (.01 field) of domain pointed to by XMINST
 ; XMOKTYPE (in)  array of script types which are acceptable
 ; XMB      (out) XMB("SCR IEN")      Pointer to script within domain
 ;                XMB("FIRST SCRIPT") Pointer to first script tried
 ;                XMB("SCR REC")      Script zero node
 ;                XMB("ITERATIONS")   Number of cycles of scripts
 ;                XMB("TRIES")        Number of tries with one script
 ;                XMB("IP TRIED")     IP addresses tried so far
 ; If no transmission scripts are prioritized use old data/defaults.
 ; If failure, then XMB("SCR IEN")=0
 ; XMPRI    Priority
 ; XMTYPE   Script type
 ; XMDEFALT Default script settings
 ; XMSLIST  Array of possible scripts
 ; XMSFIRST First possible script
 ; XMSNEXT  Next possible script
 N XMSLIST,XMSFIRST,XMSNEXT,XMPRI,XMTYPE,I,XMREC,XMIEN
 I $D(XMB("SCR REC")),(XMB("TRIES")+1)<$P(XMB("SCR REC"),U,3) D  Q
 . S XMB("TRIES")=XMB("TRIES")+1
 . D DEFAULT(XMINST,XMSITE,.XMB) ; refresh the script
 . ;I $G(ER)=25,$$USEDNS D NEXTIP(XMSITE,.XMB)
 . I $G(ER)=25!($P(XMB("SCR REC"),U,6)=""),$$USEDNS D NEXTIP(XMSITE,.XMB)
 ; We are here because the # attempts made is more than the max allowed,
 ; or because we are about to make our first attempt.
 ; In either case, we need a (next) script to try.
 I '$D(XMOKTYPE) S (XMOKTYPE("SMTP"),XMOKTYPE("TCPCHAN"),XMOKTYPE("NONE"))=""
 S XMIEN=0
 F  S XMIEN=$O(^DIC(4.2,XMINST,1,XMIEN)) Q:XMIEN'>0  D
 . S XMREC=$G(^DIC(4.2,XMINST,1,XMIEN,0))
 . Q:$P(XMREC,U,7)  ; Out of service
 . S XMTYPE=$P(XMREC,U,4)
 . S:XMTYPE="" XMTYPE="NONE"
 . Q:'$D(XMOKTYPE(XMTYPE))
 . S XMPRI=$P(XMREC,U,2) S:XMPRI="" XMPRI=9999
 . S XMSLIST(XMPRI,XMIEN)=XMIEN
 I '$D(XMSLIST) S XMB("SCR IEN")=0 Q
 S XMIEN=+$G(XMB("SCR IEN"))
 S XMSFIRST="XMSLIST"
 S XMSFIRST=$Q(@XMSFIRST)
 I XMIEN=0!('$D(^DIC(4.2,XMINST,1,XMIEN,0))) D  ; First attempt, so take the first script
 . S XMB("SCR IEN")=@XMSFIRST
 . S XMB("FIRST SCRIPT")=XMB("SCR IEN")
 . S XMB("ITERATIONS")=0
 E  D  ; Try the next script after the one we just tried.
 . ; If that was the last one, go back to the first.
 . S XMPRI=$P(^DIC(4.2,XMINST,1,XMIEN,0),U,2) S:XMPRI="" XMPRI=9999
 . S XMSNEXT="XMSLIST(XMPRI,XMIEN)"
 . S XMSNEXT=$Q(@XMSNEXT)
 . I XMSNEXT="" D
 . . S XMB("SCR IEN")=@XMSFIRST
 . . S XMB("ITERATIONS")=XMB("ITERATIONS")+1
 . E  S XMB("SCR IEN")=@XMSNEXT
 D INITSCR(XMINST,XMSITE,.XMB)
 Q
NEXTIP(XMSITE,XMB) ;
 I ","_$G(XMB("IP TRIED"))_","[(","_$P(XMB("SCR REC"),U,6)_",")!($P(XMB("SCR REC"),U,6)="") D
 . N XMIP
 . S XMIP=$$NEXTIPF^XMKPRD(XMSITE,$G(XMB("IP TRIED")))
 . I XMIP'="" S $P(XMB("SCR REC"),U,6)=XMIP
 I $P(XMB("SCR REC"),U,6)="" S $P(XMB("SCR REC"),U,6)=$P($G(XMB("IP TRIED")),",",1)
 I $G(XMB("IP TRIED"))="" S XMB("IP TRIED")=$P(XMB("SCR REC"),U,6) Q
 I ","_XMB("IP TRIED")_","[(","_$P(XMB("SCR REC"),U,6)_",") Q
 S XMB("IP TRIED")=XMB("IP TRIED")_","_$P(XMB("SCR REC"),U,6)
 Q
INITSCR(XMINST,XMSITE,XMB) ;
 S:'$D(XMB("ITERATIONS")) XMB("ITERATIONS")=0
 S XMB("TRIES")=0
 S:'$D(XMB("FIRST SCRIPT")) XMB("FIRST SCRIPT")=XMB("SCR IEN")
 S XMB("IP TRIED")=""
 D DEFAULT(XMINST,XMSITE,.XMB)
 S:XMB("IP TRIED")="" XMB("IP TRIED")=$P(XMB("SCR REC"),U,6)
 Q
DEFAULT(XMINST,XMSITE,XMB) ;
 N XMDEFALT,I
 ; Pickup data from selected script
 S XMB("SCR REC")=^DIC(4.2,XMINST,1,XMB("SCR IEN"),0)
 ;I $P(XMB("SCR REC"),U,6)="",$$USEDNS D NEXTIP(XMSITE,.XMB)
 ; Create defaults
 S XMDEFALT=^DIC(4.2,XMINST,0)
 ; Piece 17=Physical link device; Piece 12=Host IP Address;
 ; $P(^XMB(1,1,"NETWORK"),U,1) is the number of attempts before failure
 S XMDEFALT=$P(XMDEFALT,U)_"^0^"_$S(+$G(^XMB(1,1,"NETWORK")):+^("NETWORK"),1:10)_"^SMTP^"_$P(XMDEFALT,U,17)_U_$P(XMDEFALT,U,12)
 ;
 I $P(XMDEFALT,U,5)="" D
 . N XMIO
 . S XMIO=$P($G(^XMB(1,1,"NETWORK")),U,5)
 . I XMIO'="" S $P(XMDEFALT,U,5)=XMIO
 ;Use defaults if no data in transmission script fields
 F I=3:1:$L(XMDEFALT,U) S:$P(XMB("SCR REC"),U,I)="" $P(XMB("SCR REC"),U,I)=$P(XMDEFALT,U,I)
 Q
USEDNS() ; Function returns 1 if we can use DNS; 0 if we can't.
 Q:'$P($G(^XMB(1,1,"NETWORK")),U,2) 0  ; Site says don't use DNS
 Q:$T(^XLFNSLK)="" 0  ; DNS API is not present
 Q:$P($G(^XTV(8989.3,1,"DNS")),U,1)="" 0  ; No DNS IP address
 Q 1
