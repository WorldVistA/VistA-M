YTQRRPC ;SLC/KCM - Other RPC Calls for MHA ; 1/25/2017
 ;;5.01;MENTAL HEALTH;**130**;Dec 30, 1994;Build 62
 ;
 ; External Reference    ICR#
 ; ------------------   -----
 ; HOSPLOC^ORWU          1816
 ; NEWPERS^ORWU          1836
 ;
SELECT(YTQRRSP,REQ) ; Controller for patient select screen
 N I,CMD,PARAMS
 S CMD=$G(REQ(1))
 S I=1 F  S I=$O(REQ(I)) Q:'I  S PARAMS($P(REQ(I),"="))=$P(REQ(I),"=",2,99)
 ;
 ; switch on CMD
 ; ---------------------------------
 ; getCurrentUser ==> duz^username
 I CMD="getCurrentUser" D  G OUT
 . D USERINFO^YTQRIS(.YTQRRSP)
 ; ---------------------------------
 ; getPatientInfo ==> lastname,firstname^PID
 I CMD="getPatientInfo" D  G OUT
 . D PTINFO^YTQRIS(.YTQRRSP,$$VAL("patientId"))
 ; ---------------------------------
 ; subsetOfPersons ==> [ien^name^- organization] 
 I CMD="subsetOfPersons" D  G OUT
 . D NEWPERS^ORWU(.YTQRRSP,$$VAL("startFrom"),$$VAL("direction"))
 ; ---------------------------------
 ; subsetOfLocations ==> [ien^locationName] 
 I CMD="subsetOfLocations" D  G OUT
 . D HOSPLOC^ORWU(.YTQRRSP,$$VAL("startFrom"),$$VAL("direction"))
 ; ---------------------------------
 ; listAvailable(patientId,userId) ==> [type^displayText^identifier]
 I CMD="listAvailable" D  G OUT
 . D AVAIL^YTQRIS(.YTQRRSP,$$VAL("patientId"),$$VAL("userId"))
 ; --------------------------------- 
 ; deleteAssignment(itemType,identifier) ==> ok or errorMsg
 I CMD="deleteAssignment" D  G OUT
 . D DELASMT^YTQRIS(.YTQRRSP,$$VAL("itemType"),$$VAL("identifier"))
 ; ---------------------------------
 ; listAssignments(patientId,userId) ==> [displayText^pin^test|adminId^...]
 I CMD="listActiveAssignments" D  G OUT
 . D ACTIVE^YTQRIS(.YTQRRSP,$$VAL("patientId"),$$VAL("userId"))
 ; ---------------------------------
 ; deleteAssignment2(pin,admins) ==> ok or errorMsg
 I CMD="deleteAssignment2" D  G OUT
 . D DELASMT2^YTQRIS(.YTQRRSP,$$VAL("pin"),$$VAL("admins"))
 ; --------------------------------- 
 ; describeAssignment(pin,admins) ==> [text]
 I CMD="describeAssignment" D  G OUT
 . D DESCRIBE^YTQRIS(.YTQRRSP,$$VAL("pin"),$$VAL("admins"))
 ; --------------------------------- 
 ; validateInstruments(mode,orderedBy,tests) ==> ok or errorMsg
 I CMD="validateInstruments" D  G OUT
 . D VALTSTS^YTQRIS(.YTQRRSP,$$VAL("mode"),$$VAL("orderedBy"),$$VAL("tests"))
 ; ---------------------------------
 ; listCategories ==> [categoryName]
 I CMD="listCategories" D  G OUT
 . D ACTCAT^YTQRIS(.YTQRRSP)
 ; ---------------------------------
 ; listByCategory(category) ==> root=TEST1^TEST2^...
 I CMD="listByCategory" D  G OUT
 . D INBYCAT^YTQRIS(.YTQRRSP,$$VAL("category"))
 ; ---------------------------------
 ; else
 S YTQRRSP(1)="Error: command not found"
 ;
OUT ; end of switch statement 
 Q
 ;
VAL(X) ; return value from request
 ; expects PARAMS
 Q $G(PARAMS(X))
 ;
TEST ;
 N REQ,RSP
 S REQ(1)="listActiveAssignments"
 S REQ(2)="patientId=100662"
 S REQ(3)="userId=1085"
 ;S REQ(1)="getCurrentUser"
 D SELECT(.RSP,.REQ)
 ;W ! ZW RSP
 Q
