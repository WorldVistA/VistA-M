ONC2PR15 ;HINES OIFO/RTK - Pre-Install Routine for Patch ONC*2.2*15 ;06/27/22
 ;;2.2;ONCOLOGY;**15**;Jul 31, 2013;Build 5
 ;
 K ^ONCO(165.9)  ;delete file 165.9 and bring back in patch 15 build
 K ^ONCO(164)  ;delete file 164 and bring back in patch 15 build
 K ^ONCO(160.16)  ;delete file 160.16 and bring back in the patch 15 build
 ;
 Q
