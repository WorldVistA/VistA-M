OOPSGUI8 ;WIOFO/LLH-RPC Broker calls for GUI ;10/23/01
 ;;2.0;ASISTS;**8,7,11,15,21**;Jun 03, 2002;Build 7
 ;
EN1(RESULTS,INPUT) ; Entry point for routine
 ;  Input:  INPUT contains the IEN of the ASISTS record and the 
 ;          calling menu, in the format IEN^CALLING MENU
 ; Output:  RESULTS contains status messages back to the client. 
 ;          RESULTS(0) will = either 1 or 0.  1 if ok for form to be
 ;          signed by calling menu option, 0 if not ok.  The RESULTS
 ;          array with status message will start at 1.
 ;
 N CALL,CN,DIC,IEN,FORM,PRM1,PRM2,SIGN,Y
 S CN=1
 S IEN=$P($G(INPUT),U),CALL=$P($G(INPUT),U,2)
 S FORM=$$GET1^DIQ(2260,IEN,52,"I")
 S FORM=$S(FORM=1:"CA1",FORM=2:"CA2",1:"")
 S PRM1=$S(CALL="O":"Safety Officer",CALL="H":"Occupational Health",1:0)
 S PRM2=PRM1_" approves the WCP signing for the Employee: "
 S SIGN=""
 I '$G(IEN)!($G(FORM)="")!($G(CALL)="") D  Q
 . S RESULTS(0)=0
 . S RESULTS(1)="Missing Information, Cannot Continue"
 I CALL="W" G WCPS4E
 S RESULTS(0)=$$VALID()
 I RESULTS(0) S RESULTS(CN)=PRM2,CN=CN+1
 G EXIT
WCPS4E ; allow WCP to sign for employee if all approvals given
 N CONT,EHS,SIGN,SOS,VALID,VIEW
 S SIGN=0,VALID=0,VIEW=1
 ; V2_P15 - all code related to safety and occ health signing is obsolete, commented out
 ;S SOS=$$GET1^DIQ(2260,IEN,76,"I")
 ;S EHS=$$GET1^DIQ(2260,IEN,79,"I")
 ;S CONT=$S(DUZ=SOS:"S",DUZ=EHS:"H",1:"")
 ;I (CONT="S")!(CONT="H") D
 ;. S RESULTS(CN)="You have approved as "_$S(CONT="S":"Safety Officer",CONT="H":"Occ Health Rep",1:"")
 ;. S RESULTS(CN)=RESULTS(0)_" and cannot sign as Employee.",CN=CN+1
 ;. S RESULTS(CN)="Three different individuals must be involved."
 ;. S VIEW=0
 ;I '$G(SOS) S VIEW=0 D
 ;. S RESULTS(CN)="Safety Officer has not approved WCP signing for employee.",CN=CN+1
 ;I '$G(EHS) S VIEW=0 D
 ;. S RESULTS(CN)="Occupational Health has not approved WCP signing for employee.",CN=CN+1
 I VIEW D
 . ; Allow clearing WCP signature, employee may be able to sign
 . I $$GET1^DIQ(2260,IEN,119,"I") D CLRES^OOPSUTL1(IEN,"E",FORM)
 . ;V2P15 - needed to change the logic in the remaining code due to new functionality where
 . ;        Safety and Occ Health do not need to approve prior to WC signing for employee.
 . ;        Must now check required fields are completed before letting WC sign.
 . ;D VALIDATE^OOPSUTL4(IEN,FORM,"E",.VALID)
 . ;V2_P15 llh - modifed for patch 15 - RESULTS will contain the list of invalid fields if any
 . ;             from OOPSGUI9.  If all fields ok, set RESULTS(0) to indicate that by setting =1
 . S RESULTS(0)="The following required fields must be completed before signing"
 . D VALIDATE^OOPSGUI9(IEN,FORM,"E",.VALID)
 . ;09/15/09 - v2_P21 remedy ticket 300258 - put next line back in - took out ;
 . I 'VALID S RESULTS(CN)="All required fields not completed",CN=CN+1 Q
 . I VALID S RESULTS(0)=1
 . I CALL="W" N CALLER S CALLER="E"
 . D EMP^OOPSVAL1
EXIT ;
 Q
VALID() ; make sure same person is not signing for both safety and EH and if
 ; signed from menu option being called not needed again - so quit
 N CONT,EHAPP,ERR,SOAPP,VALID
 S VALID=1,ERR=0
 ;
 S SOAPP=$P($G(^OOPS(2260,IEN,"WCSE")),U)
 S EHAPP=$P($G(^OOPS(2260,IEN,"WCSE")),U,4)
 S CONT=$S(DUZ=SOAPP:"S",DUZ=EHAPP:"H",1:"")
 I CALL="O" D
 . I CONT="S" S ERR=1
 . I $G(EHAPP)=DUZ S ERR=2
 . I $G(SOAPP)&($G(CONT)="") S ERR=3
 I CALL="H" D
 . I CONT="H" S ERR=1
 . I $G(SOAPP)=DUZ S ERR=2
 . I $G(EHAPP)&($G(CONT)="") S ERR=3
 I ERR=1 D
 . S RESULTS(CN)="You have signed as "
 . S RESULTS(CN)=RESULTS(CN)_PRM1
 . S RESULTS(CN)=RESULTS(CN)_", Cannot sign."
 . S CN=CN+1,VALID=0
 I ERR=2 D
 . S RESULTS(CN)="You have already signed as "
 . S RESULTS(CN)=RESULTS(CN)_$S(CALL="O":"Occupational Health",CALL="H":"Safety Officer",1:0)_".",CN=CN+1
 . S RESULTS(CN)="Both signatures cannot be made by the same person."
 . S CN=CN+1,VALID=0
 I ERR=3 D
 . S RESULTS(CN)=PRM1_" has already signed, re-signing is not required."
 . S CN=CN+1,VALID=0
 Q VALID
CSIGN(RESULTS,IEN,FORM,CALL) ; Clears Signature from form
 ;
 ;   Input:     IEN - IEN of the ASISTS case to have the
 ;                    signature cleared from
 ;             FORM - the Form to clear the signature from, 2162,
 ;                    CA1 or CA2 or CA7 (CA7 added V2 patch 5)
 ;             CALL - the calling menu
 ;  Output: RESULTS - single value with status message
 ;
 S RESULTS="Clearing Signatures"
 I ('$G(IEN))!($G(FORM)="")!($G(CALL)="") S RESULTS="FAILED"
 ; V2 Patch 5 llh - added logic for CA7
 I FORM'="CA7" D CLRES^OOPSUTL1(IEN,CALL,FORM)
 I FORM="CA7" D CLRES^OOPSGUIS(IEN,CALL,FORM)
 S RESULTS="CLEARED"
 Q
DTFC(RESULTS,DATE,FLAG) ; Reformat Date/Time
 ;  Input  - Date to be reformatted
 ;         - Flag to be used
 ; Output  - RESULTS contains the reformatted date
 ;
 N X,%DT            ; patch 11 - added %DT
 S FLAG=+$G(FLAG)
 I DATE=""!(FLAG="") S (RESULTS,RESULTS(1))="" Q
 S X=DATE,%DT="T" D ^%DT
 S DATE=Y,X="NOW"
 D ^%DT
 I $S(DATE=-1:1,FLAG<0:Y<DATE,FLAG>0:DATE>Y,1:0) S DATE=-1
 I DATE=-1 S (RESULTS,RESULTS(1))="DATE ERROR" Q
 S (RESULTS,RESULTS(1))=$$FMTE^XLFDT(DATE,5)
 Q
GETNOI(RESULTS,OPT) ; Broker Call to retrieve NOI Codes
 ;  Input:     OPT - Either CA1 or CA2 to indicate which codes should be
 ;                   retrieved.  If CA1 must start with T, otherwise CA2
 ; Output: RESULTS - NOI Description and Code
 N NOI,DES,CODE,CN
 S DES="",CN=0
 F  S DES=$O(^OOPS(2263.3,"B",DES)) Q:DES=""  S NOI="" F  S NOI=$O(^OOPS(2263.3,"B",DES,NOI)) Q:NOI=""  D
 . S CODE=$P(^OOPS(2263.3,NOI,0),U,2)
 . I OPT="CA1",($E(CODE,1)="T") S RESULTS(CN)=NOI_":"_DES_" - "_CODE
 . I OPT="CA2",($E(CODE,1)'="T") S RESULTS(CN)=NOI_":"_DES_" - "_CODE
 . S CN=CN+1
 Q
ZIPCHK(RESULTS,DATA) ; patch 5 - validate zip code against file 5.12
 ;                 to ensure zip in file and has correct state.
 ;
 ;  Input:    DATA - contains ZIP CODE^STATE NAME
 ; Output: RESULTS - returns message with validation results
 ;
 N STATE,VALSTATE,VALZIP,ZIP,ZZIP
 S ZIP=$P($G(DATA),U,1),STATE=$P($G(DATA),U,2)
 S RESULTS=""
 I '$G(ZIP)!($G(STATE)="") S RESULTS="MISSING PARAMETERS" Q
 D POSTAL^XIPUTIL(ZIP,.ZZIP)
 I $G(ZZIP("ERROR"))'="" S RESULTS="ZIP CODE NOT FOUND" Q
 I STATE'=ZZIP("STATE") S RESULTS="STATE MISMATCH ON ZIP" Q
 S RESULTS="VALID ZIP/STATE"
 Q
AMEND(RESULTS,OLDIEN) ; File new Amended Case
 ;  Input:  OLDIEN - The ASISTS IEN for the case to have an
 ;                   amendment created for.
 ; Output: RESULTS - Single value with the new case number
 ;
 N DLAYGO
 Q:$P(^OOPS(2260,OLDIEN,0),"^",6)'=0   ;defensive code, should not occur
 S NUM=$P(^OOPS(2260,OLDIEN,0),U,1),SUF=$E(NUM,11)
 S $P(^OOPS(2260,OLDIEN,0),U,6)=3
 S NUM=$E(NUM,1,10)_$S(SUF="":"A",1:$CHAR($ASCII(SUF)+1))
 K DD,DO
 S DLAYGO=2260,DIC="^OOPS(2260,",DIC(0)="QLZ",X=NUM
 D FILE^DICN G:Y=-1 DONE
 S NEWIEN=+Y
 MERGE ^OOPS(2260,NEWIEN)=^OOPS(2260,OLDIEN)
 S OOP=^OOPS(2260,NEWIEN,0)
 S $P(OOP,U,1)=NUM,$P(OOP,U,6)=0,$P(OOP,U,11)="",$P(OOP,U,19)=""
 S ^OOPS(2260,NEWIEN,0)=OOP,$P(^OOPS(2260,NEWIEN,"CA"),U,6)=""
 S DIK="^OOPS(2260,",DA=NEWIEN D IX^DIK
 K ^OOPS(2260,NEWIEN,"2162ES")
 K ^OOPS(2260,NEWIEN,"CA1ES")
 K ^OOPS(2260,NEWIEN,"CA2ES")
 N IEN,X,WCPDUZ,WOK
 S WCPDUZ=$P($G(^OOPS(2260,NEWIEN,"WCES")),U)
 I $G(WCPDUZ) S WOK=1,X=WCPDUZ,IEN=OLDIEN D WK^OOPSUTL1
 K ^OOPS(2260,NEWIEN,"WCES")
 S RESULTS=NUM
DONE K DA,DIC,OLDIEN,NEWIEN,NUM,SUF,X,Y,DIK,OOP
 Q
SETDLOC(RESULTS,P1,DATA) ; files the detail location records
 ;  Input - P1 is the Location record IEN concatenated with the station
 ;              subrecord IEN. EX.  38^600  
 ;          DATA is a # subscripted array containing the detail loc data
 ;          in the format - detail location description^Detail Loc IEN  
 ; Output - RESULTS indicating the success of the filing.
 N CNT,IENS,FILE,LV1,LV2,LOC,MSG,REC,RECNO,STAFDA,STR
 S BAD=0,FILE=2261.4,LOC=$P(P1,U),STA=$P(P1,U,2),RESULTS=""
 I $D(DATA)<10 S RESULTS="NO DATA TO FILE, CANNOT CONTINUE" Q
 I '$G(STA) S RESULTS="NO STATION SENT, COULDN'T FILE" Q
 I '$G(LOC) S RESULTS="NO LOCATION SENT, COULDN'T FILE" Q
 I '$D(^OOPS(FILE,LOC,1,"B",STA)) D  I BAD Q
 .S IENS="+1,"_LOC_",",STAFDA(2261.43,IENS,.01)=STA
 .D UPDATE^DIE("","STAFDA","IENS","MSG")
 .I $D(MSG("DIERR")) D
 ..S RESULTS="PROBLEM FILING NEW STATION SUBRECORD",BAD=1
 ;KILL THE DETAIL LOCATION REC FOR STATION AND LOCATION PASSED IN
 S DIENS=$O(^OOPS(FILE,"E",STA,LOC,"")),LV1=$O(^OOPS(FILE,LOC,0))
 I $G(DIENS) D
 .S LV2=$O(^OOPS(FILE,LOC,LV1,DIENS,0))
 .I $G(LV2) K ^OOPS(FILE,LOC,LV1,DIENS,LV2)
 .I $D(^OOPS(FILE,"F",DIENS,LOC)) K ^OOPS(FILE,"F",DIENS,LOC)
 ;RE-FILE THE DETAIL LOCATION LEVEL RECORD
 K STAFDA S CNT=0,RECNO=0,REC=""
 F  S REC=$O(DATA(REC)) Q:REC=""  D
 .S STR=DATA(REC),RECNO=$P(STR,U,2),CNT=CNT+1
 .I RECNO="" S RECNO=CNT
 .S IENS="+"_RECNO_","_DIENS_","_LOC_","
 .S STAFDA(2261.431,IENS,.01)=$P(STR,U,1)
 D UPDATE^DIE("E","STAFDA","IENS","MSG")
 I '$D(MSG) S RESULTS="Filing Successful"
 K MSG,STR,Y,X,%DT
 Q
