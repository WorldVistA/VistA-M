PXVE206 ;BPOIFO/CLR - ENVIRONMENT CHECK ;04/22/2015
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**206**;Aug 12, 1996;Build 50
 ;Patch cannot be re-installed without assistance if STS seeding and deployment have commenced
 I $$STATUS() D  Q 
  . D BMES^XPDUTL("Patch cannot be re-installed without assistance from Product Support - INSTALLATION ABORTED")
  . S XPDQUIT=1
 Q
 ;
STATUS() ;checks STS status of files
 ; Return  0  if OK to re-install patch
 ;         1  if NOT OK to re-install
 N PXVFF,PXVSTOP,PXV920
 S PXVSTOP=0
 F PXVFF=920,920.1,920.2,920.3,920.4,920.5,9999999.04,9999999.28,9999999.14 D
 . S PXVSTOP=$S(PXVSTOP:1,+$$GETSTAT^HDISVF01(PXVFF)=0:0,1:1)
 Q PXVSTOP
