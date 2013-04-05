GMRAXPST ;HIRMFO/WAA,RM-POST INIT FOR ALLERGY/ADVERSE REACTION ; 1/15/93
 ;;4.0;Adverse Reaction Tracking;;Mar 29, 1996
EN1 ; POST INIT PROCEDURES FOR GMRA PACKAGE
 I $G(GMRAVER,3)<4 D EN1^GMRAXNKA ; Move NKA data out of file 120.8
 D MAILGRP ; update mail groups.
 ; Add mail groups to bulletins??
 D FILESEC ; Check File security for all the files
 D TITLE ; Change the title in file 121.2
 Q
TITLE ; This code will update the title in the progress note package
 N GMRACW
 S GMRACW=0 F  S GMRACW=$O(^GMR(121.2,"B","ALLERGY/ADVERSE REACTION",GMRACW)) Q:GMRACW<1  I $P($G(^GMR(121.1,$P($G(^GMR(121.2,GMRACW,0)),U,2),0)),U)="GENERAL NOTE" Q
 Q:GMRACW<1
 N DIE,DA,DR
 S DIE="^GMR(121.2,",DA=GMRACW,DR=".01///ADVERSE REACTION/ALLERGY"
 D ^DIE
 N GMRATXT
 S GMRATXT(1)="The Progress Note Title of ALLERGY/ADVERSE REACTION with a note type of"
 S GMRATXT(2)="GENERAL NOTE has been changed to ADVERSE REACTION/ALLERGY."
 D MES^XPDUTL(.GMRATXT)
 Q
MAILGRP ; Procedure to update the mail groups for ART bulletins.
 N GMRAA,GMRAB,GMRAC,GMRAD,GMRAG,GMRACNT
 S GMRAB=0 ;Make groups public
 S GMRAC=0 ;Will make postmaster
 S GMRAD=1 ;No self enrollment
 S GMRAG=1 ;Silent call
 F GMRACNT=1:1:5 D
 .N GMRAA,GMRAX,GMRAF,GMRATXT
 .S GMRAA=$P($T(TEXT+GMRACNT),";",3) ; Mail group name
 .S GMRAF(0)=$P($T(DESC+GMRACNT),";",3) ;Mail group Description
 .S GMRAX=$$MG^XMBGRP(GMRAA,GMRAB,GMRAC,GMRAD,"",.GMRAF,GMRAG)
 .I GMRAX D  ;Mail group has been added
 ..S GMRATXT(1)="The "_GMRAA_" mail group has been added."
 ..D MES^XPDUTL(.GMRATXT)
 ..Q
 .E  D  ;Error happened and mail group was not added
 ..S GMRATXT(1)="The "_GMRAA_" Mail Group was not added to the system"
 ..S GMRATXT(2)="Please read the ART 4.0 Installation Guide for the"
 ..S GMRATXT(3)="instruction on how to create this  Mail Group."
 ..D BMES^XPDUTL(.GMRATXT)
 ..Q
 .Q
 Q
FILESEC ; This routine is to check the file security and make the update if
 ; different
 N GMRACNT,GMRATX
 F GMRACNT=1:1:7 S GMRATX=$T(FLSEC+GMRACNT) Q:GMRATX=""  D SEC($P(GMRATX,";",3))
 Q
SEC(FILE) ;This Function will set the security for my file
 N FILENUM,PIECE,NODE,NODE2
 S NODE="^AUDIT^DD^DEL^LAYGO^RD^WR"
 S FILENUM=$P(FILE,U)
 F PIECE=2:1:7 I $P(FILE,U,PIECE)'="" S NODE2=$P(NODE,U,PIECE) S:$G(^DIC(FILENUM,0,NODE2))'=$P(FILE,U,PIECE) ^DIC(FILENUM,0,NODE2)=$P(FILE,U,PIECE)
 S GMRATXT(1)="Updating File security on file "_FILENUM_"."
 D BMES^XPDUTL(.GMRATXT)
 Q
FLSEC ; FILE#^AUDIT^DD^DEL^LAYGO^RD^WR
 ;;120.8^@^@^@^@^^@
 ;;120.82^@^@^@^^^
 ;;120.83^@^@^@^^^
 ;;120.84^@^@^@^@^@^@
 ;;120.85^@^@^@^@^^@
 ;;120.86^@^@^@^@^@^@
 ;;120.87^@^@^@^@^^@
TEXT ; This is the mail groups that are being added
 ;;GMRA MARK CHART
 ;;GMRA VERIFY DRUG ALLERGY
 ;;GMRA VERIFY FOOD ALLERGY
 ;;GMRA VERIFY OTHER ALLERGY
 ;;GMRA P&T COMMITTEE FDA
DESC ; This is the Description for the mail groups
 ;;This is a list of users who will need to mark a patient's chart that an adverse reaction/allergy was recorded.  
 ;;This is a complete list of all the verifiers who will need to be sent Drug reaction information.
 ;;This is a complete list of all the verifiers who will need to be sent Food reaction information.
 ;;This is a complete list of all the verifiers who will need to be sent Other reaction information.
 ;;This mail group contains the members of the Pharmacy and Therapeutic (P&T) committee.  Whenever an agent is signed off the committee will get a message.  
