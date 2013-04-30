XOBUPRE ;; mjk,ld/alb - Foundations Pre-Init ; 07/27/2002  13:00
 ;;1.6;Foundations;;May 08, 2009;Build 15
 ;Per VHA directive 2004-038, this routine should not be modified.
 QUIT
 ;
EN ; -- pre-init code
 ;
 ; -- change package file name entry from XOBS VISTALINK SECURITY to VISTALINK SECURITY
 DO PKGCHG
 ;
 ; -- delete obsolete SYSTEM file (18) if it exists
 DO DEL(18,"SYSTEM")
 ;
 ; -- delete VISTALINK PERSON file (18.09) if it exists (interim file used in early developers' previews)
 DO DEL(18.09,"VISTALINK PERSON")
 ;
 IF $$CHK() QUIT
 ;
 ; -- delete FOUNDATIONS SITE PARAMETERS file (18.01)
 DO DEL(18.01,"FOUNDATIONS SITE PARAMETERS")
 ;
 ; -- delete FOUNDATIONS SECURITY PROVIDER file (18.02)
 DO DEL(18.02,"FOUNDATIONS SECURITY PROVIDER")
 ;
 QUIT
 ;
PKGCHG ; -- change package file name
 ;
 ; -- change package file name entry to VISTALINK SECURITY
 ;   (should only affect VistALink v1.0 test sites)
 NEW DA,DIC,DIE,DR,X,Y
 SET DIC="^DIC(9.4,",DIC(0)="X",X="XOBS VISTALINK SECURITY" DO ^DIC
 IF +Y>0 SET DIE=DIC,DA=+Y,DR=".01///VISTALINK SECURITY" DO ^DIE
 ;
 ; -- change package PREFIX for entry FOUNDATIONS
 ;   (should only affect VistALink v1.0 test sites)
 NEW DA,DIC,DIE,DR,X,Y
 SET DIC="^DIC(9.4,",DIC(0)="X",X="FOUNDATIONS",DIC("S")="IF $P(^(0),U,2)=""XOB""" DO ^DIC
 IF +Y>0 SET DIE=DIC,DA=+Y,DR="1///XOBU" DO ^DIE
 ;
 QUIT
 ;
CHK() ; -- is newer version present
 NEW XOBRES
 ;
 ; -- check if new configuration file is present
 DO FILE^DID(18.03,"","NAME","XOBRES")
 ;
 ; -- if config file present than newer version installed
 QUIT $GET(XOBRES("NAME"))="VISTALINK LISTENER CONFIGURATION"
 ;
DEL(XOBFILE,XOBNAME) ; -- delete file
 NEW DIU,XOBRES
 ;
 DO FILE^DID(XOBFILE,"","NAME","XOBRES")
 ;
 ; -- if file present then delete
 IF $GET(XOBRES("NAME"))=XOBNAME DO
 . ; -- delete file and data
 . SET DIU=XOBFILE,DIU(0)="TD" DO EN^DIU2
 ;
 QUIT
 ;
