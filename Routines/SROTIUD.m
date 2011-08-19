SROTIUD ;BIR/SJA - SURGERY E-SIG UTILITY ; [ 12/19/03  09:27 AM ]
 ;;3.0; Surgery ;**100**;24 Jun 93
 ;
OS(SRTN) ; Delete the TIU OPERATIVE SUMMARY pointer and call TIU to re-establish a new stub entry.
 ; SRTN   - case number in file 130
 ;
 N ZTDESC,ZTRTN,ZTIO,ZTDTH,ZTSAVE,ZTSK
 I $P($G(^SRF(SRTN,"NON")),"^")="Y" Q
 S ZTDESC="Surgery Operation Report Stub",ZTRTN="OR^SROTIUD",ZTIO="",ZTDTH=$H,ZTSAVE("SRTN")="" D ^%ZTLOAD
 Q
OR K DR S DA=SRTN,DR="1000///@",DIE=130 D ^DIE K DR
 D OR^SROESX
 Q
NON(SRTN) ; Delete the TIU PROCEDURE REPORT (NON-OR) pointer and call TIU to re-establish a new stub entry.
 ; SRTN   - case number in file 130
 ;
 N ZTDESC,ZTRTN,ZTIO,ZTDTH,ZTSAVE,ZTSK
 I '$P($G(^SRF(SRTN,"NON")),"^",5)!'$P($G(^SRF(SRTN,"TIU")),"^",5) Q
 S ZTDESC="Surgery Non-OR Procedure Report Stub",ZTRTN="NOR^SROTIUD",ZTIO="",ZTDTH=$H,ZTSAVE("SRTN")="" D ^%ZTLOAD
 Q
NOR K DR S DA=SRTN,DR="1002///@",DIE=130 D ^DIE K DR
 D PR^SROESXP
 Q
ANES(SRTN) ; Delete the TIU ANESTHESIA REPORT pointer and call TIU to re-establish a new stub entry.
 ; SRTN   - case number in file 130
 ;
 N ZTDESC,ZTRTN,ZTIO,ZTDTH,ZTSAVE,ZTSK
 I '$P($G(^SRF(SRTN,"TIU")),"^",4) Q
 S ZTDESC="Surgery Anesthesia Report Stub",ZTRTN="ANS^SROTIUD",ZTIO="",ZTDTH=$H,ZTSAVE("SRTN")="" D ^%ZTLOAD
 Q
ANS K DR S DA=SRTN,DR="1003///@",DIE=130 D ^DIE K DR
 D AR^SROESXA
 Q
NURS(SRTN) ; Delete the TIU NURSE INTRAOP REPORT pointer and call TIU to re-establisha new stub entry.
 ; SRTN   - case number in file 130
 N ZTDESC,ZTRTN,ZTIO,ZTDTH,ZTSAVE,ZTSK
 I '$P($G(^SRF(SRTN,"TIU")),"^",2) Q
 S ZTDESC="Surgery Nurse Interaop Report",ZTRTN="NUR^SROTIUD",ZTIO="",ZTDTH=$H,ZTSAVE("SRTN")="" D ^%ZTLOAD
 Q
NUR K DR S DA=SRTN,DR="1001///@",DIE=130 D ^DIE K DR
 D NR^SROESX
 Q
