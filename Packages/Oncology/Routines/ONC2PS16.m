ONC2PS16 ;ALBANY OIFO/RTK - Post-Install Routine for Patch ONC*2.2*16 ;02/01/23
 ;;2.2;ONCOLOGY;**16**;Jul 31, 2013;Build 5
 ;
 ;DC production server Patch 16
 ;S RC=$$UPDCSURL^ONCSAPIU("http://127.0.0.1:83/cgi_bin/oncsrv.exe")
 ;DC test server, comment out for final release.
 S RC=$$UPDCSURL^ONCSAPIU("http://127.0.0.1:81/cgi_bin/oncsrv.exe")
 Q
