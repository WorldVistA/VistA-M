A1VSP1PS ;Albany FO/GTS - VistA Package Sizing Manager (Initial release P1 Post-Install; 24-JUN-2016
 ;;1.0;VistA Package Sizing;;Oct 25, 2016;Build 25
 ;
ENPOST ; -- main entry point for A1VS*1*1 post-init
 NEW A1VSSTAT
 SET A1VSSTAT=$$ADDPTPLT()
 IF +A1VSSTAT'=2 DO BMES^XPDUTL(" o 'A1VS PKG MGT PARAMETERS' addition to PARAMETER TEMPLATE file (#8989.52) "_$SELECT(+A1VSSTAT:"succeeded.",1:"failed."))
 IF +A1VSSTAT<1 DO MES^XPDUTL("        Error: "_$P(A1VSSTAT,"^",2))
 IF +A1VSSTAT=2 DO 
 . DO BMES^XPDUTL(" o "_$P(A1VSSTAT,"^",2))
 . DO BMES^XPDUTL("       ...no need to add '"_$$TEMPNAME_"' to file #8989.52.")
 QUIT
 ;
 ; -- Add A1VS PKG MGT PARAMETERS to file 8989.52
ADDPTPLT() ;* Create Parameter Template entry - ;;GTS - TO DO: If released nationally under non-Kernel namespace, Check for ICRs
 NEW RESULT,DA,DIE,DIC,DR,Y,X,ERR,A1VSDA0,A1VSDA1
 SET RESULT="1^SUCCESS"
 SET DA=$$FIND1^DIC(8989.52,"","BX",$$TEMPNAME,"","","ERR")
 IF +DA>0 SET RESULT="2^'"_$$TEMPNAME_"' Parameter Template entry exists."
 ;
 ; Add A1VS PKG MGT PARAMETERS Parameter Template
 IF +DA'>0 DO
 . KILL DO
 . SET DIC="^XTV(8989.52,",DIC(0)="LU" ;Do not execute Input Transforms on .01 field
 . SET X=$$TEMPNAME()
 . DO FILE^DICN
 . SET A1VSDA1=+Y
 . IF +A1VSDA1'>0 SET RESULT="0^PARAMETER TEMPLATE file entry failure!"
 . IF +A1VSDA1>0 DO
 . . NEW DA,Y,X
 . . SET DA(1)=A1VSDA1
 . . SET DIC=DIC_DA(1)_",10,",DIC(0)="L" ;Add entry to Parameters multiple
 . . SET X=1
 . . DO ^DIC
 . . SET A1VSDA0=+Y
 . . IF +A1VSDA0'>0 SET RESULT="0^PARAMETER TEMPLATE Parameters Sub-file entry failure!"
 . . IF A1VSDA0>0 DO
 . . . NEW DA,DR,Y,X,DIE
 . . . ; Add values to PARAMETERS Multiple (#10)
 . . . SET DA=A1VSDA0
 . . . SET DA(1)=A1VSDA1
 . . . SET DIE="^XTV(8989.52,"_DA(1)_",10,"
 . . . KILL DIC
 . . . SET DR=".02///"_$$PARAMVAL()
 . . . D ^DIE
 . . SET DA=A1VSDA1
 . . SET DIE="^XTV(8989.52,"
 . . SET DR=".02///"_$$DISPTEXT()_";.03///"_$$USEENTYF()
 . . DO ^DIE
 ;
 QUIT RESULT
 ;
 ; -- Parameter Template definition APIs
TEMPNAME() ; -- return Parameter Template name (fld #.01)
 QUIT "A1VS PKG MGT PARAMETERS"
 ;
DISPTEXT() ; -- return display text (fld #.02)
 QUIT "Package Size Parameter Edit"
 ;
USEENTYF() ; -- return entity for which parameters are entered (fld #.03)
 QUIT "DOMAIN"
 ;
PARAMVAL() ; -- return Parameter (Parameters multiple fld #.02)
 QUIT "A1VS PACKAGE MGR DEFAULT DIR"
