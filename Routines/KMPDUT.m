KMPDUT ;OAK/RAK - CM Tools Utility ;2/17/04  10:45
 ;;2.0;CAPACITY MANAGEMENT TOOLS;;Mar 22, 2002
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
