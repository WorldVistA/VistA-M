PXBUTL1 ;ISL/JVS - UTILITIES SINGLE LINE HELP MESSAGES ;7/24/96  08:26
 ;;1.0;PCE PATIENT CARE ENCOUNTER;;Aug 12, 1996
 ;
 ;
HELP1(CAT) ;Help messages written when data is not valid.
 ;Each message must have omly 1 line.
 N MES,I
 D @CAT,WR1
 Q
 ;
WR1 ;--Write to the screen
 S I=0 F I=1:1:1 W !,IOELEOL,?(IOM-$L(MES(I)))\2,MES(I),IOEDEOP
 Q
LST ;--END OF LIST
 S MES(1)="END OF LIST"
 Q
VST1 ;--FOR ENCOUNTERS
 S MES(1)="Select an entry less than "_($G(PXBHIGH)+1)
 Q
VST2 ;--FOR ENCOUNTERS
 S MES(1)=$G(Y)_" is not a valid response!"
 Q
VST3 ;--FOR ENCOUNTERS
 S MES(1)="ZERO is not a valid response!"
 Q
VST4 ;--FOR ENCOUNTERS
 S MES(1)="The selection must be a whole, positive number!"
 Q
PRV ;for providers
 S MES(1)=$E(EDATA,1,15)_" does not appear to be a VALID PROVIDER."
 Q
STP ;for STOP CODES
 S MES(1)=$E(EDATA,1,15)_" does not appear to be a VALID STOP CODE."
 Q
STPNO ;for STOP CODES
 W !,$E(EDATA,1,15)_" does not appear to be a VALID STOP CODE."
 Q
PRVDEL ;for providers
 S MES(1)=" You CANNOT delete the last PROVIDER!"
 Q
PRVA ;for inactive providers
 S MES(1)="--WARNING!-This provider was inactive at the time of the encounter."
 Q
POV ;for POV
 S MES(1)=$E(EDATA,1,10)_" does not appear to be an ACTIVE,VALID DIAGNOSIS."
 Q
CPT ;for CPT's
 S MES(1)=$E(EDATA,1,10)_" does not appear to be an ACTIVE,VALID PROCEDURE."
 Q
CPTI ;for CPT's that are inactive
 S MES(1)=$E(EDATA,1,10)_" CPT CODE, became INACTIVE on: "_$P(OK,"^",3)
 Q
CPTMM ;for CPT's MULTIPLE
 S MES(1)=" We assume that the QUANTITY for each of these is 1 and same PROVIDER."
 Q
CON ;for Continue
 S MES(1)=" Press the ENTER key to continue."
 Q
STP1NO ;--STOP CODE 1 ?
 W !,"Answer with CLINIC STOP NAME, or AMIS RPORTING STOP CODE."
 Q
STP3NO ;--STOP CODE 3 ?
 W !,"Enter the STOP CODE associated with this ENCOUNTER."
 W !,"Enter '??' to get the entire list of possible STOP CODES"
 W !,"'*' indicates that STOP CODE has been visited in this session."
 Q
STP4NO ;--STOP CODE-ADD EDIT 4 ?
 W !!!,"Must have a STOP CODE or a PROCEDURE to complete this action."
 W !,"I am deleting previously entered information"
 W !,"Press the any key to continue."
 Q
