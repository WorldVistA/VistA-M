PSO767POST ;AITC/MRD - Post-install routine for PSO*7.0*767; 06/04/2025
 ;;7.0;OUTPATIENT PHARMACY;**767**;DEC 1997;Build 11
 ;
 ; MCCF VHA DSO EPHARMACY 29 - PSO*7.0*767 patch post-install
 ;
 Q
 ;
POST ; Entry Point for post-install
 ;
 D MES^XPDUTL(" Starting post-install of PSO*7.0*767")
 ;
 ; Recompile two menu protocols.
 ;
 N XQORM
 ;
 D MES^XPDUTL("   - Recompile Menu Protocol PSO REJECT DISPLAY HIDDEN MENU")
 ;
 S XQORM=$O(^ORD(101,"B","PSO REJECT DISPLAY HIDDEN MENU",0))_";ORD(101,"
 D XREF^XQORM
 ;
 D MES^XPDUTL("   - Recompile Menu Protocol PSO REJECT TRICARE HIDDEN MENU")
 ;
 S XQORM=$O(^ORD(101,"B","PSO REJECT TRICARE HIDDEN MENU",0))_";ORD(101,"
 D XREF^XQORM
 ;
 D MES^XPDUTL(" Finished post-install of PSO*7.0*767")
 ;
 Q
 ;
