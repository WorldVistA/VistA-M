XUSUDOPI ;SLC/JLA - Post Install for P787 ; SEP 3, 2025@7:30
 ;;8.0;KERNEL;**787**;Jul 10, 1995;Build 73
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; ***** IMPORTANT NOTE *******************************************
 ; This routine requires access to the manager (%SYS) namespace and
 ; can only be run by a user with permissions to that namespace.
 ; ****************************************************************
 ;
 ;
 ; FileMan/ScreenMan API's
FMDIE D ^DIE Q
 ;
 ;
 ; Loads "xusudo.xml" into XU*8.0*787 transport global. Post-installation
 ; routine ^XUSODOPI will reconstruct the file for the installation of Cache
 ; classes into VistA to support SSL/TLS. 
 ;
POST ;
 N STATUS
 S STATUS=$$SAVETLSNAME()
 I 'STATUS D BMES^XPDUTL($P(STATUS,U,2))
 Q
 ;
 ;
SAVETLSNAME() ;
 NEW KSPFILE,KSPIEN,TLSFIELD,TLSNAME,MESSAGE,RTNVAL
 NEW DIE,DA,DR,DIK
 S KSPFILE=8989.3 ; File number of Kernel System Parameter file
 S KSPIEN=1  ; Only one record
 ; Set the Global root of the Kernel System Parameter file
 S KSPGLBROOT="^XTV("_KSPFILE_","
 ; Setup the DIE call
 S DIE=KSPGLBROOT    ; Global root of subfile
 S TLSFIELD=667
 S TLSNAME="tls_encrypt_server"
 S DA=KSPIEN
 S DR=""_TLSFIELD_"////"_TLSNAME
 ;W !,"DIE: ",DIE,", DA: ",DA,", DR: ",DR
 L +^XTV(8989.3):5
 I $T D 
 . D FMDIE
 . L -^XTV(8989.3)
 . S MESSAGE="DEFAULT TLS SERVER CONFIG. initialized to ""tls_encrypt_server"""
 . D BMES^XPDUTL("KERNEL SYSTEM PARAMETERS updated")
 . D MES^XPDUTL("  "_MESSAGE)
 . S RTNVAL="1^"_MESSAGE
 E  D 
 . SET MESSAGE="Another user is editing KERNEL SYSTEM PARAMETERS"
 . D BMES^XPDUTL(MESSAGE)
 . S RTNVAL="0^"_MESSAGE
SVTLSNMDN ;
 Q RTNVAL
