XOBVPRE ;; mjk/alb - VistaLimk Pre-Init ; 07/27/2002  13:00
 ;;1.6;VistALink;;May 08, 2009;Build 15
 ;Per VHA directive 2004-038, this routine should not be modified.
 QUIT
 ;
EN ; -- add pre-init code here
 ; -- delete VISTALINK MESSAGE TYPE file (18.05)
 DO DEL(18.05)
 ;
 QUIT
 ;
DEL(XOBFILE) ; -- delete file
 NEW DIU,XOBRES
 ;
 DO FILE^DID(XOBFILE,"","NAME","XOBRES")
 ;
 ; -- if file present then delete
 IF $GET(XOBRES("NAME"))'="" DO
 . ; -- delete security provider file
 . SET DIU=XOBFILE,DIU(0)="TD" DO EN^DIU2
 ;
 QUIT
 ;
