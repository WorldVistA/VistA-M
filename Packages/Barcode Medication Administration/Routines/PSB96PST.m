PSB96PST ;SLC/ARF - Post install for ORDERCOM.DLL ; 8/16/18 11:09am
 ;;3.0;BAR CODE MED ADMIN;**96**;Mar 2004;Build 6
 Q
 ; This routine uses the following IAs:
 ; 2263 - ^XPAR                  (supported)
 ;
EN ; main entry point
 ; Variables:
 ; MOBDLL [Private] Current version of DLL being installed
 ;
 ; New private variables
 N MOBDLL
 ; Announce my intentions
 D BMES^XPDUTL("Updating DLL parameter.")
 S MOBDLL="2.0.18.3" ;patch 96
 D EN^XPAR("SYS","PSB MOB DLL REQUIRED VERSION",1,MOBDLL)
 Q
