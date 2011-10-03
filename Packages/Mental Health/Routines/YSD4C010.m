YSD4C010 ;DALISC/LJA - Process-continuation Logic ; [ 04/06/94  1:09 PM ]
 ;;5.01;MENTAL HEALTH;;Dec 30, 1994
 ;;
 ;
DO(TYPE) ;  Determine whether the process should continue...
 ;  Called by YSD4DSM
 ;  Fill in logic later, if needed...
 D @TYPE
 QUIT YSD4OK ;->
 ;
OVERALL ;
 S YSD4OK=0
 S YSD4OK=1
 QUIT
 ;
ADDFILES ;
 S YSD4OK=0
 S YSD4OK=1
 QUIT
 ;
CONVDSM ;
 S YSD4OK=0
 S YSD4OK=1
 QUIT
 ;
MRCONV ;
 S YSD4OK=0
 S YSD4OK=1
 QUIT
 ;
GPNCONV ;
 S YSD4OK=0
 S YSD4OK=1
 QUIT
 ;
DRCONV ;
 S YSD4OK=0
 S YSD4OK=1
 QUIT
 ;
EOR ;YSD4C010 - Process-continuation Logic ; [ 04/06/94  10:02 AM ]
