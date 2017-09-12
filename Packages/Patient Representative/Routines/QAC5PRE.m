QAC5PRE ;WCIOFO/ERC-Change wording of Issue Code TI05 ;11/17/97
 ;;2.0;Patient Representative;**5**;07/25/1995
 ; This routine will change the wording of Issue Code TI05.
 ; It will also add an additional Discipline to file 745.5
 ; The routine will be run as a pre-install.
 ;
ISS ;issue code wording
 N QACISNUM
 S QACISNUM=0
 S QACISNUM=$O(^QA(745.2,"B","TI05",QACISNUM))
 I $G(QACISNUM)]"" D
 . S $P(^QA(745.2,QACISNUM,0),U,3)="Delay in Scheduling Appt Outside Medical Center"
 . Q
DISC ;add discipline Extended Care to 745.5 and Service/Discipline to 745.55
 S DIC="^QA(745.5,"
 S X="EX"
 S DIC(0)="L"
 D ^DIC K DIC
 S $P(^QA(745.5,12,0),U,2)="Extended Care"
 S (DIC,DLAYGO)="^QA(745.55,",DIC(0)="L"
 S DIC("DR")=".01///EXTENDED CARE"
 D ^DIC
 S DIE=DIC,DA=+Y,DR="1///^S X=""EX"";2///^S X=12"
 D ^DIE
 K DIC,DIE,DLAYGO,DA,DR
 Q
