GMRCP513 ;SLC/DCM - Print Consult form 513 ;4/30/98  09:36
 ;;3.0;CONSULT/REQUEST TRACKING;**1,4**;DEC 27, 1997
TIUEN(GMRCIEN) ;Call TIUEN^GMRCP5 with the proper parameters so that the Consult
 ;Form 513 can be printed by TIU
 D TIUEN^GMRCP5(GMRCIEN)
 Q
