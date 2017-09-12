IBDY350 ;ALB/DHH - PRE INSTALL FOR PATCH IBD*3*50 ;AUG 20, 2002
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**50**;APR 24, 1997
 ;
PRE ;- clear workspace before install
 D CLWKSP
 Q
 ;
 ;
CLWKSP ;- Clear the AICS Import/Export Workspace (files in #358) before
 ;- loading new toolkit blocks
 ;
 D MES^XPDUTL("")
 D BMES^XPDUTL(">>> Clearing AICS Import/Export workspace...")
 D DLTALL^IBDE2
 D MES^XPDUTL(">>> ...completed.")
 Q
 ;
 ;
