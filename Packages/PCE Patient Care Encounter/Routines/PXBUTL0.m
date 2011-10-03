PXBUTL0 ;ISL/JVS,ESW - UTILITIES-3 LINE HELP MESSAGES ;6/17/03 10:29
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**108,124,152**;Aug 12, 1996
 ;
HELP(CAT) ;Help messages written when ?'s are entered.
 ;Each message must have 3 line although any of them can be blank.
 N MES,I
 D @CAT,WR
 Q
 ;
WR ;--Write to the screen
 S I=0 F I=1:1:3 W !,IOELEOL,?(IOM-$L(MES(I)))\2,MES(I)
 Q
 ;
STP1 ;--STOP CODE 1 ?
 S MES(1)="Answer with CLINIC STOP NAME, or AMIS RPORTING STOP CODE."
 S MES(2)=""
 S MES(3)=""
 Q
STP3 ;--STOP CODE 3 ?
 S MES(1)="Enter the STOP CODE associated with this ENCOUNTER."
 S MES(2)="Enter '??' to get the entire list of possible STOP CODES"
 S MES(3)="'*' indicates that STOP CODE has been visited in this session."
 Q
STP900 ;--STOP CODE 900
 S MES(1)="The stop code 900 SPECIAL SERVICES is no longer in service."
 S MES(2)="If you wish to enter procedures, you must use the"
 S MES(3)="option provided to enter a PROCEDURE."
 Q
PRV1 ;--Provider 1 ?
 S MES(1)="Answer with PROVIDER'S NAME, or INITIALS, or SSN, or NICK NAME,"
 S MES(2)="or KEY DELEGATION LEVEL, OR USER CLASS, or LINE NUMBER"
 S MES(3)="from the above list."
 Q
PRV3 ;--Provider 3 ?
 S MES(1)="Enter the PROVIDER who performed or ordered the PROCEDURES"
 S MES(2)="that were performed on the patient during this Encounter."
 S MES(3)="'*' indicates that PROVIDER has been used in this session."
 Q
PRVM ;--CPT Add Multiple Provider(s)
 S MES(1)=$E(EDATA,1,50)
 S MES(2)="The above NAME is not a VALID PROVIDER."
 S MES(3)="" ;--Enter each one separately to get more complete help."
 Q
PRVMD ;--CPT Delete Multiple Providers(s)
 S MES(1)=$E(EDATA,1,50)
 S MES(2)="The above Item(s) are not VALID line numbers or Item numbers."
 S MES(3)=""
 Q
 ;
POV1 ;--Purpose of Visit 1 ?
 S MES(1)=""
 S MES(2)="Answer with ICD DIAGNOSIS CODE NUMBER or DESCRIPTION."
 S MES(3)=""
 Q
POV3 ;--Purpose of Visit 3 ?
 S MES(1)="Enter the DIAGNOSIS that is associated with this ENCOUNTER."
 S MES(2)="It is possible that there is more than one DIAGNOSIS."
 S MES(3)=""
 Q
PL1 ;--Problem list ?
 S MES(1)="Select an Item Number, a '+' or '-', or 'ENTER' or '^' to EXIT this prompt."
 S MES(2)="By selecting one of the PROBLEMS, it can then be entered as a"
 S MES(3)="Diagnosis for this ENCOUNTER with "_NAME_"."
 Q
PL11 ;--Problem List ?
 S MES(1)="Select an Item Number, or 'ENTER' or '^' to EXIT this prompt."
 S MES(2)="By selecting one of the PROBLEMS, it can then be entered as a"
 S MES(3)="Diagnosis for this ENCOUNTER with "_PNAME_"."
 Q
PLM ;--Problem List ?
 S MES(1)="The above is not a valid or active problem."
 S MES(2)=""
 S MES(3)=""
 Q
 ;
CPT1 ;--CPT Procedure 1 ?
 S MES(1)="Answer with CPT CODE or CPT CATEGORY or DESCRIPTION."
 S MES(2)="A '*' next to a procedure indicates that it was either"
 S MES(3)=" ADDED or EDITED during this session."
 Q
CPT4 ;--USE MORE THAN 1 LETTER ?
 S MES(1)="Please use more than 1 letter for your request."
 S MES(2)=""
 S MES(3)=""
 Q
CPT3 ;--CPT Procedure 3 ?
 S MES(1)="Enter the PROCEDURE(S) that were performed during this ENCOUNTER."
 S MES(2)="It may also be a procedure that occurred at another time but."
 S MES(3)="occurred as a result of this ENCOUNTER with the Patient."
 Q
CPTM ;--CPT Add Multiple Procedure(s)
 S MES(1)=$E(EDATA,1,50)
 S MES(2)="The above entry is not a VALID or ACTIVE Code(s)."
 S MES(3)=""
 ;S MES(3)="Enter each one separately to get more complete help."
 Q
CPTMDP ;--CPT Adding Procedure with Multiple that already exist
 S MES(1)=$E(EDATA,1,50)
 S MES(2)="The above entry was already entered for this Encounter."
 S MES(3)="Enter it separately if you still want to add/edit."
 Q
CPTMNO ;--CPT Add Multiple Procedure(s)
 W !,$E(EDATA,1,50)
 W !,"The above Item(s) are not VALID or ACTIVE Codes."
 W !,"Enter each one separately to get more complete help."
 Q
CPTMD ;--CPT Delete Multiple Procedure(s)
 S MES(1)=$E(EDATA,1,50)
 S MES(2)="The above Item(s) are not VALID line numbers or Item numbers."
 S MES(3)=""
 Q
WH1 ;--WHICH when selecting different line options 1 ?
 S MES(1)="Enter the line number of the entry that you are selecting."
 S MES(2)=""
 S MES(3)=""
 Q
 ;
WH2 ;--WHICH when selecting different line options 2 ?
 S MES(1)="You can select any line number that you wish."
 S MES(2)=""
 S MES(3)=""
 Q
 ;
WH3 ;--WHICH when selecting different line options 3 ?
 S MES(1)="Please select any line number that you wish or ""^"" to exit."
 S MES(2)=""
 S MES(3)=""
 Q
QU1 ;--QUANTITY when changing quantity of CPT's ?
 S MES(1)="This is the number of times this CPT was done"
 S MES(2)="to the patient during the encounter."
 S MES(3)=""
 Q
QU2 ;--QUANTITY when changing quantity of CPT'S ??
 S MES(1)="Enter a number between 0 and 999 indicating how many"
 S MES(2)="times this procedure was performed on the patient"
 S MES(3)="during this encounter."
 Q
OP1 ;--ORDERING PROVIDER for CPT's ?
 S MES(1)="This is the ordering provider for the Procedure"
 S MES(2)="during the encounter."
 S MES(3)=""
 Q
OP2 ;--ORDERING PROVIDER for CPT'S ??
 S MES(1)="Enter the ordering provider for this"
 S MES(2)="procedure performed on the patient"
 S MES(3)="during this encounter."
 Q
