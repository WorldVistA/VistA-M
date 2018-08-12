ONC2PS09 ;Hines OIFO/RTK - Post-Install Routine for Patch ONC*2.2*9 ;03/27/18
 ;;2.2;ONCOLOGY;**9**;Jul 31, 2013;Build 3
 ;
 ;N RC
 ;DC production server.
 ;S RC=$$UPDCSURL^ONCSAPIU("http://127.0.0.1:22/cgi_bin/oncsrv.exe")
 ;DC test server, comment out for final release.
 ;S RC=$$UPDCSURL^ONCSAPIU("http://127.0.0.1:22/cgi_bin/oncsrv.exe")
 ;
 D XRF1693
 Q
 ;
 ;Re-Index the "B", "C" and "D" cross-references on File #169.3
XRF1693 ;
 D BMES^XPDUTL("Re-indexing 'B', 'C' and 'D' cross-references of File #169.3...")
 N DIK
 S DIK="^ONCO(169.3,",DIK(1)=".01^B"
 D ENALL2^DIK ;Kill existing "B" cross-reference.
 D ENALL^DIK ;Re-create "B" cross-reference.
 S DIK="^ONCO(169.3,",DIK(1)="1^D"
 D ENALL2^DIK ;Kill existing "D" cross-reference.
 D ENALL^DIK ;Re-create "D" cross-reference.
 ;next do x-ref on .01 of SYNONYM (field #2) subfile
 S IEN=0 F  S IEN=$O(^ONCO(169.3,IEN)) Q:IEN'>0  D
 .I '$D(^ONCO(169.3,IEN,1)) Q
 .S DIK="^ONCO(169.3,IEN,1,",DIK(1)=".01^C",DA(1)=IEN D ENALL2^DIK
 .S DIK="^ONCO(169.3,IEN,1,",DIK(1)=".01^C",DA(1)=IEN D ENALL^DIK
 ;
 D BMES^XPDUTL("Done Re-indexing the File #169.3 cross-references...")
 ;
 Q
