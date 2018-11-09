XU8P690 ;ALB/GTS - Patch XU*8*690 post-init ;1/12/18  14:50
 ;;8.0;KERNEL;**690**;Jul 10, 1995;Build 18
 ;Per VHA VA Directive 6402, this routine should not be modified
 ;
ENPOST ; -- main entry point for XU*8*690 post-init
 NEW XU690ST
 SET XU690ST=$$XU690ST()
 IF +XU690ST'=2 DO BMES^XPDUTL(" o 'ABNL IMA' addition to ALERT CRITICAL TEXT file (#8992.3) "_$SELECT(+XU690ST:"succeeded.",1:"failed."))
 IF +XU690ST<1 DO MES^XPDUTL("        Error: "_$P(XU690ST,"^",2))
 IF +XU690ST=2 DO 
 . DO BMES^XPDUTL(" o "_$P(XU690ST,"^",2))
 . DO MES^XPDUTL("       ...no need to add '"_$$ALERTNAM_"' to file #8992.3")
 QUIT
 ;
 ; -- Add ABNL IMA to file 8992.3
XU690ST() ;* Create Alert Critical Text file (#8992.3) entry
 SET RESULT="1^SUCCESS"
 SET DA=$$FIND1^DIC(8992.3,"","BX",$$ALERTNAM,"","","ERR")
 IF +DA>0 SET RESULT="2^'"_$$ALERTNAM_"' ALERT CRITICAL TEXT file entry exists."
 ;
 ; Add A1VS PKG MGT PARAMETERS Parameter Template
 IF +DA'>0 DO
 . KILL DO
 . SET DIC="^XTV(8992.3,",DIC(0)="LU" ;Do not execute Input Transforms on .01 field
 . SET X=$$ALERTNAM()
 . DO FILE^DICN
 . SET XU690DA=+Y
 . IF +XU690DA'>0 SET RESULT="0^ALERT CRITICAL TEXT file entry failure!"
 . IF +XU690DA>0 DO
 . . SET DA=XU690DA
 . . SET DIE="^XTV(8992.3,"
 . . SET DR=".02///"_$$PKGID()_";.03///"_$$CRTPKG()
 . . DO ^DIE
 ;
 QUIT RESULT
 ;
 ; -- Parameter Template definition APIs
ALERTNAM() ; -- return Parameter Template name (fld #.01)
 QUIT "ABNL IMA"
 ;
PKGID() ; -- Package ID text (fld #.02)
 QUIT ""
 ;
CRTPKG() ; -- return Creating Package that needed the entry (fld #.03)
 QUIT "ORDER ENTRY/RESULTS REPORTING"
