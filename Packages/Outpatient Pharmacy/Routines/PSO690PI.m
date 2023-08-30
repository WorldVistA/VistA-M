PSO690PI ;HDSO/TTN - PS0*7.0*690 Post-install routine; Sep 28, 2022@15:00
 ;;7.0;OUTPATIENT PHARMACY;**690**;DEC 1997;Build 15
 ;
 ; This post-install routine removes duplicate "RR" entries in 
 ; protocol from the PSO LM HIDDEN OTHER and PSO LM HIDDEN OTHER #2 
 ; protocols/menus. It also provides a method to restore the version of those 
 ; menus prior to the installation via the RESTORE tag. That subroutine must 
 ; be run from the programmer prompt.
 ;
 ; Reference to XREF^XQORM supported by ICR #10140
 ;
 Q  ; Must call from a specific tag. Call EN to start the process
 ;
EN ; Entry point for this post-install routine
 N DA,DIE,DIK,PRTCIEN,PRTCNM,FOUND,XQORM,RRIEN
 N DUPFLAG,PRTCITMIEN,RXRFLDATA,RXRFLMNMC,RXRFLIEN,RXRFLNM
 ;
 D BMES^XPDUTL("*** Starting RR Duplicate Search for PSO*7*690 ***")
 W !
 K ^XTMP("PSO*7.0*690 POST INSTALL")
 S ^XTMP("PSO*7.0*690 POST INSTALL",0)=$$FMADD^XLFDT(DT,90)_"^"_DT_"^PSO*7.0*690 POST INSTALL"
 ;
 F PRTCNM="PSO LM HIDDEN OTHER","PSO LM HIDDEN OTHER #2" D MAIN
 ;
 D BMES^XPDUTL("*** RR Duplicate Search for PSO*7*690 COMPLETED ***")
 Q
 ;
MAIN ; Main processing for this patch
 S FOUND=0,RRIEN=""
 S PRTCIEN=+$O(^ORD(101,"B",PRTCNM,""))
 Q:PRTCIEN=""
 S XQORM=PRTCIEN_";ORD(101,"
 ;Save ^XUTL in case back out of the patch is necessary.
 M ^XTMP("PSO*7.0*690 POST INSTALL","XUTL",PRTCIEN)=^XUTL("XQORM",XQORM)
 ;Keeping a complete picture of the protocol in case there are questions.
 M ^XTMP("PSO*7.0*690 POST INSTALL",101,PRTCIEN)=^ORD(101,PRTCIEN)
 ;Check for dup "RR" in ORD(101) globals
 D ORD101
 ; Below is check for dup "RR" in XUTL globals
 F  S RRIEN=$O(^XUTL("XQORM",XQORM,"B","RR",RRIEN)) Q:'RRIEN  S FOUND=FOUND+1
 I FOUND<2 D  Q
 . D MES^XPDUTL("     * No Duplicate RR entries found in the XUTL global for the")
 . D MES^XPDUTL("       "_PRTCNM_" protocol. Search Completed. *")
 . Q
 ; If we get here,we've found a dup record and we will recompiling to remove the dup.
 D MES^XPDUTL("     * Duplicate RR entries have been found ")
 D MES^XPDUTL("     * in the XUTL global for the "_PRTCNM_" protocol ... *")
 W !
 D MES^XPDUTL("     * Recompiling the "_PRTCNM_" protocol XUTL global... *")
 W !
 D XREF^XQORM
 ;Save in case patch needs to be backed out.
 S ^XTMP("PSO*7.0*690 POST INSTALL","XUTL_DUP",XQORM)=""
 Q
 ;
ORD101 ; Check for dup "RR" in ORD(101) globals
 N PRITM101
 S (DUPFLAG,PRTCITMIEN)=0
 F  S PRTCITMIEN=$O(^ORD(101,PRTCIEN,10,PRTCITMIEN)) Q:'PRTCITMIEN  D
 . S RXRFLDATA=$G(^ORD(101,PRTCIEN,10,PRTCITMIEN,0)) Q:RXRFLDATA=""
 . S RXRFLMNMC=$P(RXRFLDATA,U,2) Q:RXRFLMNMC'="RR"
 . S RXRFLIEN=$P(RXRFLDATA,U,1) Q:RXRFLIEN=""
 . S RXRFLNM=$$GET1^DIQ(101,RXRFLIEN,1,"E")
 . Q:(RXRFLNM="RxRenewal Request")  ; This is the correct entry so don't touch
 . S DUPFLAG=1
 . ; If we get here, then we've found a record needing to be deleted
 . ;Save in case patch needs to be backed out.
 . S PRITM101=$P(^ORD(101,PRTCIEN,10,PRTCITMIEN,0),"^")
 . S ^XTMP("PSO*7.0*690 POST INSTALL","DEL_101",PRTCIEN,PRITM101)=""
 . S DA(1)=PRTCIEN,DA=PRTCITMIEN,DIK="^ORD(101,"_DA(1)_",10,"
 . D ^DIK
 . D MES^XPDUTL("     * The '"_RXRFLNM_"' menu option has been")
 . D MES^XPDUTL("       removed from the "_PRTCNM_" protocol. *")
 . W !
 . I '$G(DUPFLAG) D
 .. D MES^XPDUTL("     * No RR entries have been found ")
 .. D MES^XPDUTL("     * in the "_PRTCNM_" protocol ... *")
 .. W !
 .. Q
 Q
 ;
 ; ----------------------------------------------------------------------------
RESTORE ; Restore the previously backed up entry
 W #
 N DIR,Y,PRTCIEN,PRTCNM,XQORM
 S DIR("A",1)="WARNING - This action will restore the 'PSO LM HIDDEN OTHER' and/or"
 S DIR("A",2)="'PSO LM HIDDEN OTHER #2' protocol(s) to their setup prior to the"
 S DIR("A",3)="installation of PSO*7.0*690."
 S DIR("A",4)=""
 S DIR("A")="Are you sure you wish to proceed",DIR("B")="NO",DIR(0)="Y"
 D ^DIR
 Q:Y<1
 ;
 ; Be sure we still have the backup global
 I '$D(^XTMP("PSO*7.0*690 POST INSTALL")) D BMES^XPDUTL("*** No backup entry found. Not able to proceed. Quitting! ***") Q
 ;
 D BMES^XPDUTL("*** Starting global restore from backup for the PSO*7.0*690 installation ***")
 ;
 F PRTCNM="PSO LM HIDDEN OTHER","PSO LM HIDDEN OTHER #2" D
 . S PRTCIEN=+$O(^ORD(101,"B",PRTCNM,""))
 . I 'PRTCIEN D BMES^XPDUTL("  ** No current "_PRTCNM_" protocol record found. Quitting! **") Q
 . S XQORM=PRTCIEN_";ORD(101,"
 . I $D(^XTMP("PSO*7.0*690 POST INSTALL","XUTL_DUP",XQORM)) D
 . . K ^XUTL("XQORM",XQORM)
 . . M ^XUTL("XQORM",XQORM)=^XTMP("PSO*7.0*690 POST INSTALL","XUTL",PRTCIEN)
 . . D BMES^XPDUTL("  ** "_PRTCNM_" protocol ^XUTL global restored successfully **")
 . Q:'$D(^XTMP("PSO*7.0*690 POST INSTALL","DEL_101",PRTCIEN))
 . N DIC,DR,DA,X
 . S DIC="^ORD(101,"_PRTCIEN_",10,",DIC(0)=""
 . S DA(1)=PRTCIEN
 . S DA=""
 . F  S DA=$O(^XTMP("PSO*7.0*690 POST INSTALL","DEL_101",PRTCIEN,DA)) Q:DA=""  D
 . . S DIC("DR")=".01///"_DA_";2///RR",X=DA
 . . D FILE^DICN
 . D BMES^XPDUTL("  ** "_PRTCNM_" protocol IEN "_PRTCIEN_" restored successfully **")
 . Q
 ;
 D BMES^XPDUTL("*** Restore from backup for the PSO*7.0*690 installation complete ***")
 Q
