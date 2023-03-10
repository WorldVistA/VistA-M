KMPDUT ;OAK/RAK - CM Tools Utility ;2/17/04  10:45
 ;;3.0;KMPD;;Jan 22, 2009;Build 42
 ;
PARAMS(KMPDARRY) ;-- cp parameters file data
 ;-----------------------------------------------------------------------
 ; KMPDARRY... Array (called by name) that will contain data from file
 ;             #8973 (CP PARAMETERS).  This will be returned in internal 
 ;             format
 ;-----------------------------------------------------------------------
 ;
 Q:$G(KMPDARRY)=""
 M @KMPDARRY=^KMPD(8973,1)
 Q
