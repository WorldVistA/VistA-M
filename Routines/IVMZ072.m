IVMZ072 ;BAJ/PHH - HL7 Z07 CONSISTENCY CHECKER -- DRIVER ROUTINE II ; 05/22/08
 ;;2.0;INCOME VERIFICATION MATCH;**105,130**;JUL 8,1996;Build 2
 ;
 ; 
 ; This routine supports the IVMZ07C consistency checker routines.
LOADSD(DFN,DGSD) ; Load spouse & dependent data into array
 ; We will need to look at the Patient Relationship file to determine the spouse(s) and dependents for the patient
 ; from the Patient Relation file ^DGPR(408.12)  This file will point to an IEN in the Income Person file.
 ; Next, we will load all of the spouse(s) and dependents from the Income Person file into the array.
 N NIEN,IEN,RIEN,NODE,I,ENODE
 ; look into Patient Relation file #408.12.  Here we will find a pointer to each relation.  And the record itself will
 ; contain a pointer into the INCOME PERSON file (#408.13)
 ;
 ;Global ^DGPR(408.12,,DFN
 ;^DGPR(408.12,"B",9999955601,3206)= 
 ;                        3210)=      <<------|
 ;                        3211)=              |
 ;                        3212)=              |
 ;                                            ]
 ;Global ^DGPR(408.12,3210 <<------------
 ;^DGPR(408.12,3210,0)=9999955601^2^7170758;DGPR(408.13,
 ;^DGPR(408.12,3210,"E",0)=^408.1275D^1^1        |
 ;^DGPR(408.12,3210,"E",1,0)=2560406^1           |
 ;^DGPR(408.12,3210,"E","AID",-2560406,1)=       |
 ;^DGPR(408.12,3210,"E","B",2560406,1)=          |
 ;                                               |
 ;                                               |
 ;Global ^DGPR(408.13,7170758 <<--------------
 ;^DGPR(408.13,7170758,0)=XXXXXX,XXXX SPOUSE^F^2560406^^^^^^174040656P^N
 ;                     1)=XXXXX,XXXX^^^^^^^
 ;
 I '$D(^DGPR(408.12,"B",DFN)) Q
 S NIEN="" F  S NIEN=$O(^DGPR(408.12,"B",DFN,NIEN)) Q:NIEN=""  D
 . Q:'$D(^DGPR(408.12,NIEN,0))
 . S IEN=$P(^DGPR(408.12,NIEN,0),U,3)
 . ; an entry in DPT is the patient.  we only need relations 
 . Q:$P(IEN,";",2)["DPT"!'IEN
 . Q:'$$ACTIF(NIEN,.ENODE)   ;include only Active dependents
 . S RIEN=$P(IEN,";",1),NODE=$P(IEN,";",2)
 . S NODE=U_NODE,NODE=NODE_RIEN_")"
 . Q:'$D(@NODE)
 . S DGSD("DEP",RIEN,"EFF")=ENODE
 . S DGSD("DEP",RIEN)=$P(^DGPR(408.12,NIEN,0),U,2)
 . M DGSD("DEP",RIEN)=@NODE
 Q
 ;
ACTIF(NIEN,ENODE) ;determine if record in ^DGPR(408.12) is currently active. If active, populate variable ENODE with Effective Date.
 ; This API should be called something like this I $$ACTIF^IVMZ072(NIEN,.ENODE)...
 ; Input:
 ;       NIEN    =       IEN of ^DGPR(408.12) reference
 ;       ENODE   =       Variable to contain Effective Date
 ;
 ; Populates:
 ;       ENODE =         With the most recent effective date of changes
 ;
 ; Returns:
 ;       ACTIVE flag
 ;       1 = Active
 ;       0 = Inactive
 ;
 N ROOT,ACTDAT,INDEX,ACTIVE,EFF
 S ACTIVE=0
 D  Q ACTIVE
 . S ROOT=$O(^DGPR(408.12,NIEN,"E","AID","")) Q:ROOT=""
 . S INDEX=$O(^DGPR(408.12,NIEN,"E","AID",ROOT,"")) Q:INDEX=""
 . S ACTDAT=^DGPR(408.12,NIEN,"E",INDEX,0)
 . S ACTIVE=$P(ACTDAT,"^",2),ENODE=$P(ACTDAT,"^",1)
 Q ACTIVE
 ;
