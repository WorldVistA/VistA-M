QANPST3 ;HISC/DAD-Set OUT OF ORDER field for old PRM options ;9/16/93  08:47
 ;;2.0;Incident Reporting;**1,4,20**;08/07/1992
 S QANSOPT="PRM"
 F  S QANSOPT=$O(^DIC(19,"B",QANSOPT)) Q:(QANSOPT="")!($E(QANSOPT,1,3)'="PRM")  F QANSD0=0:0 S QANSD0=$O(^DIC(19,"B",QANSOPT,QANSD0)) Q:QANSD0'>0  D
 . Q:$P($G(^DIC(19,QANSD0,0)),"^")'=QANSOPT
 . Q:"CORW"'[$E(QANSOPT,4)
 . S DIE="^DIC(19,",DA=QANSD0
 . S DR="2///PACKAGE NO LONGER SUPPORTED, CONTACT THE HINES ISC"
 . D ^DIE
 . Q
 D INACT ;Inactivate 'WITHIN 24 HOURS' in QA Type of Death file.
 D NATCHK ;Check 'National Status' for incidents.
EXIT ;Kill and quit
 K A1,A2,A3,C,DA,DIE,DR,QANINACT,QANNCDNT,QANOK,QANSD0,QANSLEV,QANSOPT
 K X,Y
 Q
INACT ;Inactivate 'WITHIN 24 HOURS' in QA Type of Death file.
 S QANINACT=+$O(^QA(742.14,"BUPPER","WITHIN 24 HOURS OF ADMISSION (EX. DOA'S AND TERMINALS)",0))
 Q:QANINACT'>0  ;Quit if data missing.
 S DIE="^QA(742.14,",DR=".02///"_"@",DA=QANINACT D ^DIE ;Stuff 'null'
 Q
NATCHK ;Check 'National Status' for incidents.
 ; *** Variable List ***
 ; A1       ---> Incident (742.1) IEN
 ; A2       ---> IEN for file 742.4
 ; A3       ---> IEN for file 742
 ; QANNCDNT ---> Passed into INCK^QANFULL0 incident type (free text)
 ; QANOK    ---> Boolean for National Case Status, true or false
 ; QANSLEV  ---> Severity Level, passed into INCK^QANFULL0
 ;
 N QANINCD ;Protect this variable
 F A1=0:0 S A1=$O(^QA(742.4,"BINC",A1)) Q:A1'>0  D
 . S QANOK=0
 . F A2=0:0 S A2=$O(^QA(742.4,"BINC",A1,A2)) Q:A2'>0  D
 .. F A3=0:0 S A3=$O(^QA(742,"BCS",A2,A3)) Q:A3'>0  D
 ... S QANSLEV=+$P($G(^QA(742,A3,0)),U,10)
 ... S QANNCDNT=$P($G(^QA(742.1,A1,0)),U)
 ... S QANINCD=$$UP^XLFSTR(QANNCDNT)
 ... D INCK^QANFULL0 ;Check for a 'National' incident.
 ... S Y=$P($G(^QA(742.4,A2,0)),U,15) ;No need to '@' a null field
 ... I 'QANOK,(Y]"") K DA,DIE,DR S DA=A2,DIE="^QA(742.4,",DR=".17///@" ;Null implies a non-national incident.
 ... I 'QANOK,(Y]"") W !,"Changing Incident Record number: ",A2
 ... I 'QANOK,(Y]"") W !,"Changing the National Case Status from: " S Y=$P($G(^QA(742.4,A2,0)),U,15),C=$P(^DD(742.4,.17,0),U,2) D:Y]"" Y^DIQ W $S(Y="":"N/A",1:Y)
 ... I 'QANOK,(Y]"") W !,"To Deleted!",!
 ... I 'QANOK,(Y]"") D ^DIE K DA,DIE,DR
 ... Q
 .. Q
 . Q
 Q
