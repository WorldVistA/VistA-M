DDS0 ;SFISC/MLH-SETUP, CLEANUP ;24FEB2004
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**999,1003,1012**
 ;
EN(DDSFILE,DR,DA) ;Initial setup
 S U="^"
 D INIT^DDGLIB0() Q:$G(DIERR)
 D FORM(.DDSFILE,DR) Q:$G(DIERR)
 ;
 ;Compile the form if not already compiled
 S DDSREFS=$$REF(DDS)
 I '$$COMPILED(DDS) D EN^DDSZ(DDS) Q:$G(DIERR)
 N:$P(^DIST(.403,+DDS,0),U,10) DA
 ;
 D FRSTPG(DDS,.DA,$G(DDSPAGE)) Q:$G(DIERR)
 D REC(DDP,.DA) Q:$G(DIERR)
 D INIT
 Q
 ;
FORM(DDSFILE,DR) ;Form lookup
 ;Output:
 ;  DDS     = Form number^Form name
 ;  DDP     = File number (or 0)
 ;  DDSPG   = First page to go to on form
 ;  DIERR
 ;
 I $D(DDSFILE)[0 D BLD^DIALOG(201,"DDSFILE") Q
 ;
 N DIC,X,Y
 ;
 S DDP=$S(DDSFILE=+DDSFILE:DDSFILE,1:+$P($G(@(DDSFILE_"0)")),U,2))
 S X=$S(DR:DR,1:$P($P(DR,"[",2),"]"))
 S DIC="^DIST(.403,",DIC(0)="FNX",D="F"_DDP
 D IX^DIC K DIC
 ;
 I Y<0 D BLD^DIALOG(3021,X) Q
 I '$O(^DIST(.403,+Y,40,"B","")) D BLD^DIALOG(3022,X) Q
 S DDS=Y
 ;
 I $D(DDSFILE(1))#2 S DDP=$S(DDSFILE(1)=+DDSFILE(1):DDSFILE(1),1:+$P($G(@(DDSFILE(1)_"0)")),U,2))
 Q
 ;
FRSTPG(DDS,DA,DDSPAGE) ;Get first page of form
 ;Output:
 ;  DDSPG
 ;  DDSSEL = 1, if DA is null and there is a record selection page
 ;  DIERR
 ;
 N P
 I $G(DA)!$P(^DIST(.403,+DDS,0),U,10) D
 . S P=$S($G(DDSPAGE):DDSPAGE,1:1)
 . S DDSPG=$O(^DIST(.403,+DDS,40,"B",P,""))
 . I $D(^DIST(.403,+DDS,40,+DDSPG,0))[0 D BLD^DIALOG(3023,"number "_P)
 E  D PG^DDSRSEL D:'$G(DDSSEL) BLD^DIALOG(202,"record")
 Q
 ;
REC(DDP,DA) ;Check record and lock
 ;Output:
 ;  DIE      = Global root
 ;  DDSDA    = DA,DA(1),...,
 ;  DDSDAORG = Original DA array
 ;  DDSDL    = Level number (top=0)
 ;  DDSDLORG = Original level number
 ;  DDSFLORG  = Orig DDP^Orig DIE
 ;  D0,D1,etc.
 ;  DIERR
 ;
 I '$G(DA) D  Q
 . S DIE="",(DDSDL,DDSDLORG)=0,DDSDA="0,"
 . S DA="",DDSDAORG=DA
 ;
 D GL^DDS10(DDP,.DA,.DIE,.DDSDL,.DDSDA,'$P(^DIST(.403,+DDS,0),U,9)) Q:$G(DIERR)  ;Don't LOCK record if screen is DISPLAY-ONLY
 ;
 I $D(DIOVRD)[0 D  Q:$G(DIERR)
 . N DDSTOP S DDSTOP=$$FNO^DILIBF(DDP)
 . Q:$P($G(^DD(DDSTOP,0,"DI")),U,2)'["Y"
EGP . N P S P("FILE")=$$FILENAME^DIALOGZ(DDSTOP) ;**CCO/NI RESTRICTED FILE NAME
 . D BLD^DIALOG(405,DDSTOP,.P)
 ;
 S DDSDLORG=DDSDL
 K DDSDAORG S (DDSDAORG,@("D"_DDSDL))=DA
 F DDSI=1:1:DDSDL S (DDSDAORG(DDSI),@("D"_(DDSDL-DDSI)))=DA(DDSI)
 S DDSFLORG=$G(DDP)_$G(DIE)
 K DDSI
 Q
 ;
INIT ;Initialize some variables
 ; DDSHBX   = $Y of first line of help area
 ; DDSREFT  = Global reference of temporary global location
 ; DDSFDO   = 1 if entire form is display-only
 ; DDSCHG   = Change flag
 ; DDSKM    = Flag to keep whatever's in help area
 ; DDSH     = Flag to indicate help area is empty
 ; DDSSC    = Array to indicate what pages are on the screen
 ;
DDSHBX S DDSHBX=17 I $G(DDS),$G(DDSPG),$D(DDSREFS) D
 .N % S %=$O(@DDSREFS@("X",DDSPG,""),-1)+1 I %>DDSHBX S DDSHBX=% ;LAST FIELD CAPTION
 .F DDH=0:0 S DDH=$O(@DDSREFS@(DDSPG,DDH)) Q:'DDH  I $G(^(DDH)) S %=$P(^(DDH),U,7)+^(DDH) I %>DDSHBX S DDSHBX=%
 S DDXY=IOXY_" S $X=DX,$Y=DY"
 ;
 K DDH,DDSSC,DDSCHANG,DDSSAVE
 S DDSH=1,(DDH,DDM,DDSCHG,DDSSC)=0,DDACT="N"
DDSREFT S DDSREFT=$NA(^TMP("DDS",$J,+DDS)) ;GFT
 K @DDSREFT
MOUSEON I $G(DDS)>0 W *27,"[?1000h"
 N %,%H,%I,X
 D NOW^%DTC
 S $P(^DIST(.403,+DDS,0),U,6)=$E(%,1,12)
 Q
 ;
END I $D(DDSHBX) S DX=0,DY=IOSL-1 X IOXY
 D KILL^DDGLIB0($G(DDSPARM))
 ;
 D:$D(^TMP("DDS",$J,"LOCK")) UNLOCK
 ;
 K:'$G(DA) DA
 I $D(DA),$D(DDSDAORG)#2,$D(DDSDLORG)#2 D
 . K DA,D0
 . S DA=DDSDAORG
 . F DDSI=1:1:DDSDLORG S DA(DDSI)=DDSDAORG(DDSI) K @("D"_DDSI)
MOUSEOFF W *27,"[?1000l"
 K:$G(DDSPARM)'["E" DIERR,^TMP("DIERR",$J)
 K:$D(DDSREFT)#2 @DDSREFT,DDSREFT
 K ^TMP("DDSH",$J),^TMP("DDSWP",$J)
 K DDACT,DDH,DDM,DDO,DDP,DDQ,DDS,DDSDDP
 K DDSBK,DDSBR,DDSCHG,DDSDA,DDSDAORG,DDSDL
 K DDSDLORG,DDSDN,DDSEXT,DDSFDO,DDSFLD,DDSFLORG,DDSGL,DDSH,DDSI
 K DDSKM,DDSLN,DDSNP,DDSO,DDSOLD,DDSORD,DDSOPB,DDSOSV,DDSPTB,DDSPG
 K DDSPX,DDSPY,DDSQ,DDSREP,DDSSC,DDSSP,DDSSTACK,DDSTP,DDSU,DDSX
 K DDSHBX,DDSREFS,DDXY
 K DIC,DIR,DIR0N,DIROUT,DIRUT,DUOUT,DY,DX
 K A1,D,DDC,DDD,DI,DIEQ,DIK,DIW,DIY,DIZ,DS
 Q
 ;
UNLOCK ;Unlock any lock records
 N I
 S I="" F  S I=$O(^TMP("DDS",$J,"LOCK",I)) Q:I=""  L -@I
 K ^TMP("DDS",$J,"LOCK")
 Q
 ;
COMPILED(DDS) ;Return 1 if form is compiled
 Q $D(@$$REF(DDS))>0
 ;
REF(DDS) ;Return global reference for compiled global
 Q $NA(^DIST(.403,+DDS,"AY"))
 ;
OLDREF(DDS) ;Return global reference for compiled global used prior
 ;to version 22.0
 Q $NA(^DIST(.403,+DDS,"AZ"))
 ;
IXF ;
 N D0,DA,DIC,DP,Y S DIC="^DD("_DDGFDD_",",DIC(0)="EN" D ^DIC
 I Y'>0 K X
 E  S X=+$P(Y,"E")
 Q
