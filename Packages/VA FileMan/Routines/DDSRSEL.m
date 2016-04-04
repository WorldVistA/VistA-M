DDSRSEL ;SFISC/MKO-RECORD SELECTION ;7JAN2004
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**1003**
 ;
PG ;Called from:
 ;  DDS01 when user presses SELECT
 ;  FIRSTPG^DDS0 if no DA was passed in.
 ;
 ;Returns (if there is a record selection page and we're not in
 ;a multiple)
 ; DDSPG  = Record selection page #
 ; DDACT  = "NP"
 ; DDSSEL = 1 (undefined if no record selection page)
 ;
 N P,P1 K DDSSEL
 I $D(DDSSC),$P($G(DDSSC(DDSSC)),U,4) Q  ;GFT
 ;
 S P="",P1=$P($G(^DIST(.403,+DDS,21)),U)
 I P1]"" D
 . S P=$O(^DIST(.403,+DDS,40,"B",P1,""))
 . I P]"",$D(^DIST(.403,+DDS,40,P,0))[0 S P=""
 ;
 I P]"" D
 . I $G(DDO),$G(DDSDN)=1 D
 .. D ERR3^DDS3
 . E  S DDSPG=P,DDACT="NP",DDSSEL=1
 Q
 ;
GDA ;Called from DDS
 ;After a record selection page is closed get the DA from
 ;the first field on the page.
 N DDSANS,DDSREC,Y,PG
 S DDSANS=""
GFT S PG=$P($G(^DIST(.403,+DDS,21)),U) G KILL:'PG N P S P=$O(^(40,"B",PG,0)) D:P  I '$D(Y) G KILL
 .F Y=0:0 S Y=$O(^DIST(.403,+DDS,40,P,40,Y)) Q:'Y  I $G(^(Y,"COMP MUL"))]"" K Y Q
 E  S DDSREC=$$GET^DDSVALF(1,1,PG) ;ON THE OLD KIND OF LOOKUP PAGE, THERE IS 1 FIELD, 1 BLOCK
 ;
 K DA,DDSDAORG
 S DDSDA=DDSDASV,DDSDL=DDSDLSV
 D BLDDA^DDS(DDSDA)
 M DDSDAORG=DDSORGSV
 ;
 I 'DDSREC,DA S DDSREC=DA
 E  I DDSREC,DDSREC'=DA D
 . I DA D  Q:DDSREC=DA
 .. S DDSANS=$$ASKSAVE
 .. I DDSANS="R" S DDSREC=DA
 .. E  I DDSANS="S" D
 ... D ^DDS4
 ... S:Y'=1 DDSREC=DA
 . ;
 . S DA=DDSREC
 . D REC^DDS0(DDP,.DA)
 . ;
 . I $G(DIERR) D  Q
 .. D ERR^DDSMSG H 2
 .. S DA=+$G(DDSDASV),DDACT="N"
 .. D REC^DDS0(DDP,.DA)
 . ;
 . S DDACT="N"
 . I DDSSC=1 D FRSTPG^DDS0(DDS,.DA,$G(DDSPAGE))
 . D CLRDAT,UNLOCK
 ;
KILL K DDSSEL,DDSDASV,DDSDASV,DDSDLSV,DDSORGSV
 Q
 ;
ASKSAVE() ;
 ;Ask user whether to save the previous record
 N X,Y
 D:DDM CLRMSG^DDS
 S DDM=1
 ;
 K DIR S DIR(0)="SM^S:SAVE;D:DISCARD;R:RETURN"
 S DIR("A",1)="  NOTE:  You must Save or Discard all edits to the"
 S DIR("A",2)="         previous record before editing the next record."
 S DIR("A",3)=" "
 S DIR("A")="Save, Discard, or Return (S/D/R)"
 S DIR("B")="SAVE"
 ;
 S DIR("?",1)="Enter 'S' to save or 'D' to discard."
 S DIR("?")="Enter 'R' or '^' to return to previous record."
 ;
 S DIR0=IOSL-1_U_($L(DIR("A"))+1)_"^7^"_(IOSL-4)_"^0"
 D ^DIR
 I $D(DIRUT) S Y="R"
 E  I X="SAVE" S Y="S"
 K DIR,DIROUT,DIRUT,DTOUT,DUOUT
 Q Y
 ;
CLRDAT ;Clear all data values from @DDSREFT
 N F,P
 S P=0 F  S P=$O(@DDSREFT@(P)) Q:'P  K @DDSREFT@(P)
 S F="F" F  S F=$O(@DDSREFT@(F)) Q:$E(F)'="F"  K @DDSREFT@(F)
 Q
 ;
UNLOCK ;Unlock all records locked
 Q:'$D(^TMP("DDS",$J,"LOCK"))
 N I S I=""
 F  S I=$O(^TMP("DDS",$J,"LOCK",I)) Q:I=""  D
 . I I'=(DIE_DA_")") L -@I K ^TMP("DDS",$J,"LOCK",I)
 Q
