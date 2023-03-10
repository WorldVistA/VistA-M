XT73P143 ;Albany FO/GTS - VistA Package Sizing Manager; 24-JUN-2016
 ;;7.3;TOOLKIT;**143**;Apr 25, 1995;Build 116
 ;
ENPOST ; -- main entry point for XT*7.3*143 post-init
 NEW XTVSSTAT
 IF $D(^XTMP("XTSIZE")) DO
 . NEW XTDOLRJ
 . DO BMES^XPDUTL(" o Deleting any existing global extract files [^XTMP(""XTSIZE"")]")
 . SET XTDOLRJ=""
 . FOR  SET XTDOLRJ=$O(^XTMP("XTSIZE",XTDOLRJ)) Q:XTDOLRJ=""  DO
 . . KILL ^XTMP("XTSIZE",XTDOLRJ)
 . . DO MES^XPDUTL("       ^XTMP(""XTSIZE"","_XTDOLRJ_")  ...deleted.")
 ;
 DO BMES^XPDUTL(" o Unloading Forum File extract global [^XTMP(""XTSIZE"")]")
 MERGE ^XTMP("XTSIZE")=@XPDGREF@("XTVSEXT")
 ;
 IF '$D(^XTMP("XTSIZE")) DO
 . DO BMES^XPDUTL("      ** ERROR: Forum File extract global [^XTMP(""XTSIZE"")] was")
 . DO MES^XPDUTL("           **   NOT INCLUDED in KIDS Transport!  **")
 . DO MES^XPDUTL("            **  CONTACT THE PATCH DEVELOPER!!!  **")
 ;
 IF $D(^XTMP("XTSIZE")) DO
 . DO BMES^XPDUTL(" o Loading Forum File extract global [^XTMP(""XTSIZE"")] into Packman message.")
 . NEW XMY,XMTEXT,XMDUZ,XMSUB,XTLPCNT,XDATE,XDOLRJ
 . SET XMY(DUZ)=""
 . SET XMDUZ=DUZ
 . SET XDOLRJ=$O(^XTMP("XTSIZE",""))
 . SET XDATE=$P($P(^XTMP("XTSIZE",XDOLRJ,0),"^",3),"-") ; Date from 3rd pce [date of extract]
 . SET XDATE=$$FMTE^XLFDT(XDATE,"1P")
 . SET XMSUB="FORUM PACKAGE FILE EXTRACT with XT*7.3*143 ("_$P(^XTMP("XTSIZE",XDOLRJ,0),"^",4)_" ; "_XDATE_" ; $JOB#: "_XDOLRJ_")"
 . SET XMTEXT="^XTMP(""XTSIZE"","_XDOLRJ_","
 . DO ENT^XMPG
 . IF +XMZ>0 DO
 . . DO BMES^XPDUTL("   ...^XTMP(""XTSIZE"","_XDOLRJ_") E-Mailed via PackMan.  [MSG #:"_XMZ_"]")
 . . DO MES^XPDUTL("         Check your VA Mailman mailbox on this VistA system!")
 . . KILL ^TMP("XMY",$J),^XTMP("XTSIZE",XDOLRJ)
 . IF +XMZ'>0 DO
 . . DO BMES^XPDUTL("   ...Error: ^XTMP(""XTSIZE"","_XDOLRJ_") not sent in Packman.")
 . . DO MES^XPDUTL("          ^XTMP(""XTSIZE"","_XDOLRJ_") global was not deleted.")
 . . DO MES^XPDUTL("      Use VistA Package Size Extract Manager to send in a Packman message.")
 ;
 SET XTVSSTAT=$$ADDPTPLT()
 IF +XTVSSTAT'=2 DO BMES^XPDUTL(" o 'XTVS PKG MGT PARAMETERS' addition to PARAMETER TEMPLATE file (#8989.52) "_$SELECT(+XTVSSTAT:"succeeded.",1:"failed."))
 IF +XTVSSTAT<1 DO MES^XPDUTL("        Error: "_$P(XTVSSTAT,"^",2))
 IF +XTVSSTAT=2 DO 
 . DO BMES^XPDUTL(" o "_$P(XTVSSTAT,"^",2))
 . DO BMES^XPDUTL("       ...no need to add '"_$$TEMPNAME_"' to file #8989.52.")
 QUIT
 ;
 ; -- Add XTVS PKG MGT PARAMETERS to file 8989.52
ADDPTPLT() ;* Create Parameter Template entry
 NEW RESULT,DA,DIE,DIC,DR,Y,X,ERR,XTVSDA0,XTVSDA1
 SET RESULT="1^SUCCESS"
 SET DA=$$FIND1^DIC(8989.52,"","BX",$$TEMPNAME,"","","ERR")
 IF +DA>0 SET RESULT="2^'"_$$TEMPNAME_"' Parameter Template entry exists."
 ;
 ; Add XTVS PKG MGT PARAMETERS Parameter Template
 IF +DA'>0 DO
 . KILL DO
 . SET DIC="^XTV(8989.52,",DIC(0)="LU" ;Do not execute Input Transforms on .01 field
 . SET X=$$TEMPNAME()
 . DO FILE^DICN
 . SET XTVSDA1=+Y
 . IF +XTVSDA1'>0 SET RESULT="0^PARAMETER TEMPLATE file entry failure!"
 . IF +XTVSDA1>0 DO
 . . NEW DA,Y,X
 . . SET DA(1)=XTVSDA1
 . . SET DIC=DIC_DA(1)_",10,",DIC(0)="L" ;Add entry to Parameters multiple
 . . SET X=1
 . . DO ^DIC
 . . SET XTVSDA0=+Y
 . . IF +XTVSDA0'>0 SET RESULT="0^PARAMETER TEMPLATE Parameters Sub-file entry failure!"
 . . IF XTVSDA0>0 DO
 . . . NEW DA,DR,Y,X,DIE
 . . . ; Add values to PARAMETERS Multiple (#10)
 . . . SET DA=XTVSDA0
 . . . SET DA(1)=XTVSDA1
 . . . SET DIE="^XTV(8989.52,"_DA(1)_",10,"
 . . . KILL DIC
 . . . SET DR=".02///"_$$PARAMVAL()
 . . . D ^DIE
 . . SET DA=XTVSDA1
 . . SET DIE="^XTV(8989.52,"
 . . SET DR=".02///"_$$DISPTEXT()_";.03///"_$$USEENTYF()
 . . DO ^DIE
 ;
 QUIT RESULT
 ;
 ; -- Parameter Template definition APIs
TEMPNAME() ; -- return Parameter Template name (fld #.01)
 QUIT "XTVS PKG MGT PARAMETERS"
 ;
DISPTEXT() ; -- return display text (fld #.02)
 QUIT "Package Size Parameter Edit"
 ;
USEENTYF() ; -- return entity for which parameters are entered (fld #.03)
 QUIT "DOMAIN"
 ;
PARAMVAL() ; -- return Parameter (Parameters multiple fld #.02)
 QUIT "XTVS PACKAGE MGR DEFAULT DIR"
