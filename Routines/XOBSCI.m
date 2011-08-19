XOBSCI ;; ld,mjk/alb - VistaLink Interface Implementation ; 07/27/2002  13:00
 ;;1.6;VistALink Security;;May 08, 2009;Build 15
 ;Per VHA directive 2004-038, this routine should not be modified.
 ;
 ;Implements the VistaLink message framework for messages in the (XOBS) security module.
 ;
CALLBACK(CB) ; -- init callbacks implementation
 SET CB("STARTELEMENT")="ELEST^XOBSCAV2"
 SET CB("ENDELEMENT")="ELEND^XOBSCAV2"
 SET CB("CHARACTERS")="CHR^XOBSCAV2"
 QUIT
 ;
READER(XOBUF,XOBDATA) ; -- proprietary format reader implementation
 QUIT
 ;
REQHDLR(XOBDATA) ; -- request handler implementation
 DO EN^XOBSCAV(.XOBDATA)
 QUIT
 ;
