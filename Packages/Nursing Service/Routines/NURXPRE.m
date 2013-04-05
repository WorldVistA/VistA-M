NURXPRE ;HIRMFO/FT-Nursing Service v4.0 Pre-initialization routine ;1/21/97  14:58
 ;;4.0;NURSING SERVICE;;Apr 25, 1997
 ;
 ; This routine contains the pre-initialization code for the Nursing
 ; Service package v4.0.
 ;
 D ^NURXENV I $G(XPDABORT) D KILL Q
 S NURPKG=+$$VERSION^XPDUTL("GMRV")
 I NURPKG<4 D BMES^XPDUTL("Vitals/Measurements v4.0 is required before you continue with this installation.") S XPDABORT=2 D KILL Q
 S NURPKG=+$$VERSION^XPDUTL("GMRY")
 I NURPKG<4 D BMES^XPDUTL("Intake/Output v4.0 is required before you continue with this installation.") S XPDABORT=2 D KILL Q
 D OFFLINE,KILLDD,NMSP
KILL ; kill variables
 K DA,DIC,DIE,DLAYGO,DR,NURCNT,NURDA,NURERROR,NURIEN,NURMSG,NURPATCH,NURPKG,NURSEQ,X,Y
 Q
OFFLINE ; Set Nursing switch to Off-Line
 S $P(^DIC(213.9,1,"OFF"),U,1)=1
 D BMES^XPDUTL("Setting Nursing software switch to OFF-LINE")
 Q
KILLDD ; Kill old data dictionary nodes that no longer apply
 ;
 ; old File 16 references
 K ^DD(210,21.71,9.3)
 K ^DD(210,21.71,9.4)
 ; old computed field code
 K ^DD(210,19,9.01)
 K ^DD(210,19,9.1)
 K ^DD(210,19,9.2)
 K ^DD(210,19,9.3)
 K ^DD(213.4,11,9.2)
 D BMES^XPDUTL("Killing old data dictionary nodes that are no longer needed.")
 Q
 ;
NMSP ; This subroutine changes the PACKAGE FILE LINK (#1) pointer value to
 ; the NUR*3.0*1/3/6/7/8/9/10 entries in the BUILD (#9.6) and INSTALL
 ; (#9.7) files to the NURSING SERVICE entry.
 ;
 Q:+$$VERSION^XPDUTL("NUR")>3  ;quit if v4.0 already installed.
 Q:'$D(^NURSF(210,0))  ;quit if virgin installation
 D FIND^DIC(9.4,"","","X","NUR","","C","","","NURIEN","NURERROR")
 S NURDA=$O(NURIEN("DILIST",2,0)) Q:'NURDA
 S NURDA=+$G(NURIEN("DILIST",2,+NURDA))
 D BUILD,INSTALL
 Q
BUILD ; stuff pointer for NURSING SERVICE in PACKAGE FILE LINK field (#1)
 ; of BUILD file (#9.6) for NUR*3.0*1/3/6/7/8/9/10 entries
 Q:'$G(NURDA)  ;quit if no package file pointer value
 F NURPATCH="NUR*3.0*1","NUR*3.0*3","NUR*3.0*6","NUR*3.0*7","NUR*3.0*8","NUR*3.0*9","NUR*3.0*10" D
 .K NURIEN,NURERROR
 .D FIND^DIC(9.6,"","","X",NURPATCH,"","B","","","NURIEN","NURERROR")
 .S NURSEQ=0
 .F  S NURSEQ=+$O(NURIEN("DILIST",2,NURSEQ)) Q:NURSEQ'>0  D
 ..S DA=+$G(NURIEN("DILIST",2,NURSEQ)) Q:DA'>0
 ..S DIE="^XPD(9.6,",DR="1////"_NURDA D ^DIE
 ..Q
 .Q
 Q
INSTALL ; stuff pointer for NURSING SERVICE in PACKAGE FILE LINK field (#1)
 ; of INSTALL file (#9.7) for NUR*3.0*1/3/6/7/8/9/10 entries
 Q:'$G(NURDA)  ;quit if no package file pointer value
 F NURPATCH="NUR*3.0*1","NUR*3.0*3","NUR*3.0*6","NUR*3.0*7","NUR*3.0*8","NUR*3.0*9","NUR*3.0*10" D
 .K NURIEN,NURERROR
 .D FIND^DIC(9.7,"","","X",NURPATCH,"","B","","","NURIEN","NURERROR")
 .S NURSEQ=0
 .F  S NURSEQ=+$O(NURIEN("DILIST",2,NURSEQ)) Q:NURSEQ'>0  D
 ..S DA=+$G(NURIEN("DILIST",2,NURSEQ)) Q:DA'>0
 ..S DIE="^XPD(9.7,",DR="1////"_NURDA D ^DIE
 ..Q
 .Q
 Q
