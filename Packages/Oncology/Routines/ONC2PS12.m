ONC2PS12 ;Hines OIFO/RTK - Post-Install Routine for Patch ONC*2.2*12 ;06/03/20
 ;;2.2;ONCOLOGY;**12**;Jul 31, 2013;Build 8
 ;
 N RC
 ;DC production server Patch 12
 S RC=$$UPDCSURL^ONCSAPIU("http://127.0.0.1:83/cgi_bin/oncsrv.exe")
 ;DC test server, comment out for final release
 ;S RC=$$UPDCSURL^ONCSAPIU("http://127.0.0.1:81/cgi_bin/oncsrv.exe")
 ;
 ;CS Input Original
 N IEN,CSCS,CSCS1,CSCS2,CSINPUT,DATEDX
 W !!," CS Input Original setting for old cases..."
 S IEN=0 F CNT=1:1 S IEN=$O(^ONCO(165.5,IEN)) Q:IEN'>0  D
 .S DATEDX=$P($G(^ONCO(165.5,IEN,0)),U,16)
 .S CSCS=$G(^ONCO(165.5,IEN,"CS"))
 .S CSCS1=$G(^ONCO(165.5,IEN,"CS1"))
 .S CSCS2=$G(^ONCO(165.5,IEN,"CS2"))
 .S CSINPUT=$P($G(^ONCO(165.5,IEN,"CS1")),U,12)
 .I (DATEDX>3180000),(CSINPUT="020440") S $P(^ONCO(165.5,IEN,"CS1"),U,12)=""
 .I (DATEDX<3180000),(CSINPUT="") D
 ..I ((CSCS'="")&(CSCS1'="")&(CSCS2'="")) S $P(^ONCO(165.5,IEN,"CS1"),U,12)="020440"
 K CNT,CSCS,CSCS1,CSCS2,CSINPUT,IEN,DATEDX
 ;
 Q
