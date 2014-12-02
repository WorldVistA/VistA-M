DGPFMPI ;BP/DMR - PRF TRANSMISSION CALL FOR MPI
 ;;5.3;Registration;**864**;Aug 13, 1993;Build 16
 ;
 ;Routine to transmit PRF, used by MPI during the the patient load/edit
 ;process or as a standalone routine.
 ;
 ;INPUT - DFN
 ;
EN(DFN) ;
 ;
 Q:$G(DFN)'>0 0
 ;
 N DGINST,DGTRANS,DGTF,DGTF2
 S DGTRANS=0,DGTF2=""
 ;
 I $$BLDTFL^DGPFUT2(DFN,.DGTF) D  G EXIT
 . D SITE
 . S DGINST=0
 . F  S DGINST=$O(DGTF2(DGINST)) Q:+$G(DGINST)'>0  D
 . . S DGTRANS=$$SNDQRY^DGPFHLS(DFN,$$QRYON^DGPFPARM(),DGINST)
 ;
EXIT ;
 Q DGTRANS
 ;
 ;Call to run in background, without displaying patient information.
 ;
EN1(DFN) ;
 ;
 Q:$G(DFN)'>0 0
 ;
 N DGTF,DGINST,DGTRANS,DGMODE,DGTF2
 S DGMODE=2
 S DGTRANS=0,DGTF2=""
 ;
 I $$BLDTFL^DGPFUT2(DFN,.DGTF) D  G EXIT1
 . D SITE
 . S DGINST=0
 . F  S DGINST=$O(DGTF2(DGINST)) Q:+$G(DGINST)'>0  D
 . . S DGTRANS=$$SNDQRY^DGPFHLS(DFN,DGMODE,DGINST)
 ;
EXIT1 ;
 Q DGTRANS
 ;
SITE ;
 N FAC,IEN
 ;
 S FAC=0,IEN=0
 F  S FAC=$O(DGTF(FAC)) Q:+$G(FAC)'>0  D
 . S IEN=$$GET1^DIQ(4,FAC,99) Q:+IEN'>0  D
 . . S DGTF2(IEN)=DGTF(FAC)
 Q
