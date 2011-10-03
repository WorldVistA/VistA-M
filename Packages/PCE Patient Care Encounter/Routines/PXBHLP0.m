PXBHLP0 ;ISL/JVS - MAIN HELP DRIVING ROUTINE ;11/5/96  14:25
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**11**;Aug 12, 1996
 ;
 ;
 ;
EN1(PACK,SUBJ,INTR,BODY,LEVEL) ;--MAIN ENTRY POINT TO HELP
 ;
 ;
 ;  PACK    - Package that is calling for help (REQUIRED)
 ;  SUBJ    - Subject that the help is about (REQUIRED)
 ;  INTR    - Line number on which to write the INTRODUCTION
 ;  BODY    - Line number on which to write the BODY
 ;
 ;  PXBREC  - The node in the PHBHLPR routine
 ;
 I '$D(PACK),'$D(SUBJ) W !," Requires the Package and the Subject!! "
 ;
NEW ;----New any necessary Items
 N TAG,RTN,LENGTH,PLACE,BLENGTH
 K NOREV
 ;
SET ;-----Set up Variables needed for HELP
 D TERM^PXBCC
 I $D(LEVEL),LEVEL=1 S TAG="INTRO"
 I $D(LEVEL),LEVEL=2 S TAG="BODY"
 ;
 ;
NODE ;
 I '$D(TAG) Q
 S PXBNOD=PACK_SUBJ D EN1^PXBHLPR I PXBREC="" S PXBREC=-1 Q
 ;---GET LENGTH OF TAG FROM ROUTINE IN FIRST PIECE OF PXBREC
 ;
 S ROUTINE=$P($P(PXBREC,"~",1),"^",2)
 D SIZE
 ;
 ;----CLEAN OFF THE SCREEN
 D CLEAN(LENGTH)
 ;
 ;
 ;---WRITE THE TEXT TO THE SCREEN
 I $D(IOEDEOP),PACK="PXB" W IOEDEOP
 I TAG="INTRO" D @$P(PXBREC,"~",1) Q
 I TAG="BODY" D @$P(PXBREC,"~",2)
 I TAG'="INTRO",TAG'="BODY" S RTN=TAG_"^"_$P($P(PXBREC,"~",2),"^",2) D
 .D @RTN
 I $G(TAG)>0 Q
 ;----D THE PROMPT
 ;
 D @$P(PXBREC,"~",3)
 I TAG=""!(TAG["^") Q
 G NODE
 Q
 ;--------------------------SUB ROUTINES---------------------------------
 ;
CLEAN(LENGTH) ;---Clean off the Screen where the message will be.
 D PLACE
 S (IOBM,IOTM)=0 W @IOSTBM
 I $D(INTR),$G(PLACE) D
 .D LOC^PXBCC(PLACE,0) F I=1:1:LENGTH W IORI,IOELALL
 I $D(BODY),$G(PLACE) D
 .D LOC^PXBCC(PLACE,0) F I=1:1:LENGTH W IORI,IOELALL
 Q
SIZE ;-----GET THE SIZE OF THE SPACE OF THE DATA
 ;-----------------------------------
 S X="LENGTH=$P($T("_TAG_"^"_ROUTINE_"),"";;"",2)"
 S @X
 I TAG="BODY" S BLENGTH=LENGTH
 ;----------------------------------------------
 ;
 Q
PLACE ;----CALCULATE THE PLACEMENT OF THE HELP FOR PXB*
 N HDR
 I $D(BLENGTH) S LENGTH=BLENGTH
 S HDR=4
 S PLACE=HDR+PXBCNT+1+LENGTH
 I PLACE<17 Q
 I PLACE>16 S PLACE=4+LENGTH,NOREV=1
 Q
