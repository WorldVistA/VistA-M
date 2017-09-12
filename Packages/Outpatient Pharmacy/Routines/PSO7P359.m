PSO7P359 ;BIRM/BNT - Post-intall for PSO*7*359 ;02/16/11
 ;;7.0;OUTPATIENT PHARMACY;**359**;DEC 1997;Build 27
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
 ;
POST ; Entry Point for post-install
 D MES^XPDUTL("  Starting post-install of PSO*7*359")
 N PSORDHM,PSOHA1,XQORM,I
 ; Remove ^XUTL entry for hidden action menu protocols
 ; Get the IEN for the PSO REJECT DISPLAY HIDDEN MENU
 S PSORDHM=$O(^ORD(101,"B","PSO REJECT DISPLAY HIDDEN MENU",0))
 ; Get the IEN for the PSO HIDDEN ACTIONS #1
 S PSOHA1=$O(^ORD(101,"B","PSO HIDDEN ACTIONS #1",0))
 ;
 F I=PSORDHM,PSOHA1 S XQORM=I_";ORD(101," I $D(^XUTL("XQORM",XQORM)) D
 . D MES^XPDUTL("    Removing cached hidden menu for "_$P(^ORD(101,I,0),U,1))
 . K ^XUTL("XQORM",XQORM)
 ;
 D MES^XPDUTL("  Finished post-install of PSO*7*359")
 Q
