IB20P240 ;ALB/RLC - Post-Init routine for IB*2.0*240; 8/19/2003
 ;;2.0;INTEGRATED BILLING;**240**;21-MAR-94
 ;
 ; This post-init routine is to change and update all references of
 ; CHAMPUS to TRICARE in numerous IB files.
 ;
EN ; entry point for post-init process
 S U="^"
 D EN1
 D EN2
 D EN3
 D EN4
 D EN5
 D EN6
 Q
 ;
EN1 ; root name ^IBE - files 350.1, 351.7, 355.1, 355.2, 355.97 and 363
 F FN=1:1 S FILENUM=$P($T(FILE1+FN),";;",2,999) Q:FILENUM=""  D
 . S (CHID,NODE0,FLD01,FLD02,FLD08)=""
 . F  S CHID=$O(^IBE(FILENUM,"B",CHID)) Q:CHID=""  D
 . .  Q:CHID'["CHAMPUS"
 . .  S DA=$O(^IBE(FILENUM,"B",CHID,0)) Q:'DA
 . .  S NODE0=$G(^IBE(FILENUM,DA,0))
 . .  S FLD01=$P(NODE0,U,1)
 . .  S STRING=""
 . .  I FLD01["(Tricare)" F X=1:1 S P(X)=$P(FLD01," ",X) Q:P(X)=""  S:P(X)'["(Tricare)" STRING=STRING_P(X)_" "
 . .  S STRING=$E(STRING,1,$L(STRING)-1)
 . .  I FLD01'["(Tricare)" S STRING=FLD01
 . .  I $E(STRING,1,2)="DG" S STRING=$E(STRING,1,3)_$TR($E(STRING,4,10),"CHAMPUS","TRICARE")_$E(STRING,11,$L(STRING))
 . .  E  I $E(STRING,1,2)'="DG" S STRING=$TR($E(STRING,1,7),"CHAMPUS","TRICARE")_$E(STRING,8,$L(STRING))
 . .  I FILENUM="350.1" D F3501 Q
 . .  I FILENUM="355.1" D F3551 Q
 . .  I FILENUM="355.2" D F3552 Q
 . .  L +^IBE(FILENUM)
 . .  S DIE="^IBE(FILENUM,",DR=".01////"_STRING D ^DIE
 . .  K DIE,DA,DR,STRING,FLD01,NODE0
 . .  L -^IBE(FILENUM)
 . Q
 K FN,FILENUM,CHID,NODE0,FLD01,FLD02,FLD08
 Q
 ;
F3501 ; for file 350.1 must also update fields .02 and .08, and cross-
 ; references "D" and "E".  Also, need to change external value for
 ; set of codes in field .11 to Tricare for internal code 7.
 S FLD02=$P(NODE0,U,2)
 I FLD02["CUS" S FLD02=$TR($E(FLD02,1,3),"CUS","TRI")_$E(FLD02,4,$L(FLD02))
 I FLD02["CAN" S FLD02=$E(FLD02,1,4)_$TR($E(FLD02,5),"C","T")_$E(FLD02,6,$L(FLD02))
 S FLD08=$P(NODE0,U,8)
 S FLD08=$TR($E(FLD08,1,7),"CHAMPUS","TRICARE")_$E(FLD08,8,$L(FLD08))
 L +^IBE(350.1)
 S DIE="^IBE(350.1,",DR=".01////"_STRING_";.02////"_FLD02_";.08////"_FLD08 D ^DIE
 L -^IBE(350.1)
 K DIE,DA,DR,FLD02,FLD08,STRING
 Q
 ;
F3551 ; for file 355.1 must also update field .02, and "D" cross-reference
 S FLD02=$P(NODE0,U,2)
 Q:FLD02'="CPS"&"CS"
 S:FLD02="CPS" FLD02=$TR($E(FLD02,1,3),"CPS","TRI")
 S:FLD02="CS" FLD02=$TR($E(FLD02,1,2),"CS","TS")
 L +^IBE(355.1)
 S DIE="^IBE(355.1,",DR=".01////"_STRING_";.02////"_FLD02 D ^DIE
 D F35510
 K DIE,DA,DR,FLD02,STRING,WP,DA1,X
 L -^IBE(355.1)
 Q
F35510 ; change references to Champus in description field
 Q:'$D(^IBE(FILENUM,DA,10))
 S DA1=0,(STRING,WP)=""
 F  S DA1=$O(^IBE(FILENUM,DA,10,DA1)) Q:'DA1  D
 .  S WP=$G(^IBE(FILENUM,DA,10,DA1,0))
 .  Q:WP'["CHAMPUS,"
 .  F X=1:1 S P(X)=$P(WP," ",X) Q:P(X)=""  S:P(X)="CHAMPUS," P(X)="TRICARE," S STRING=STRING_P(X)_" "
 .  S STRING=$E(STRING,1,$L(STRING)-1)
 .  S ^IBE(FILENUM,DA,10,DA1,0)=STRING
 K DA1,STRING,P,WP
 Q
 ;
F3552 ; must also update field .02 from CHS to TRI and "C" cross-reference
 S FLD02=$P(NODE0,U,2)
 S FLD02=$TR($E(FLD02,1,3),"CHS","TRI")
 L +^IBE(355.2)
 S DIE="^IBE(355.2,",DR=".01////"_STRING_";.02////"_FLD02 D ^DIE
 L -^IBE(355.2)
 K FLD02,DIE,DR,NODE0
 Q
 ;
EN2 ; root name ^IBA - file 355.3 change .03 field, along with "D", "ACCP"
 ; and "AGNA" cross references.  Files 364.5 and 364.7 change references 
 ; from Champus to Tricare in word-processing field
 F FN=1:1 S FILENUM=$P($T(FILE2+FN),";;",2,999) Q:FILENUM=""  D
 . I FILENUM="355.3" D EN21
 . I FILENUM="364.5" S CHID="N-OTHER INSURANCE CO TYPES" D EN22
 . I FILENUM="364.7" F CHID=805,1005 D EN22
 . Q
 K FN,FILENUM,CHID
 Q
 ;
EN21 ; update file 355.3
 S (CHID,NODE0,FLD03)=""
 F  S CHID=$O(^IBA(FILENUM,"D",CHID)) Q:CHID=""  D
 .  Q:CHID'["CHAMPUS"
 .  S DA=0
 .  F  S DA=$O(^IBA(FILENUM,"D",CHID,DA)) Q:'DA  D
 .  .  S NODE0=$G(^IBA(FILENUM,DA,0))
 .  .  S FLD03=$P(NODE0,U,3)
 .  .  S FLD03=$TR($E(FLD03,1,7),"CHAMPUS","TRICARE")_$E(FLD03,8,$L(FLD03))
 .  .  L +^IBA(FILENUM)
 .  .  S DIE="^IBA(355.3,",DR=".03////"_FLD03 D ^DIE
 .  .  L -^IBA(FILENUM)
 K CHID,DA,NODE0,FLD03,DIE,DR
 Q
 ;
EN22 ; update files 364.5 and 364.7
 S DA=$O(^IBA(FILENUM,"B",CHID,0)) Q:'DA
 Q:'$D(^IBA(FILENUM,DA,3))
 S DA1=0,(STRING,WP)=""
 F  S DA1=$O(^IBA(FILENUM,DA,3,DA1)) Q:'DA1  D
 .  S WP=$G(^IBA(FILENUM,DA,3,DA1,0))
 .  Q:WP'["CHAMPUS"
 .  S STRING=$TR(WP,"CHAMPUS","TRICARE")
 .  S ^IBA(FILENUM,DA,3,DA1,0)=STRING
 K DA,DA1,WP,STRING
 Q
 ;
EN3 ; root name ^DGCR - files 399.1 and 399.3
 S (NODE0,FLD01,FLD02,FLD03,FLD04)=""
 F FN=1:1 S FILENUM=$P($T(FILE3+FN),";;",2,999) Q:FILENUM=""  D
 . S CHID=""
 . F  S CHID=$O(^DGCR(FILENUM,"B",CHID)) Q:CHID=""  D
 . .  Q:CHID'["CHAMPUS"
 . .  S DA=$O(^DGCR(FILENUM,"B",CHID,0)) Q:'DA
 . .  S NODE0=$G(^DGCR(FILENUM,DA,0))
 . .  S FLD01=$P(NODE0,U,1)
 . .  S:FILENUM="399.3" FLD02=$P(NODE0,U,2),FLD03=$P(NODE0,U,3),FLD04=$P(NODE0,U,4)
 . .  S FLD01=$TR($E(FLD01,1,7),"CHAMPUS","TRICARE")_$E(FLD01,8,$L(FLD01))
 . .  I $D(FLD02) S:FLD02["CHAMPUS" FLD02=$TR($E(FLD02,1,7),"CHAMPUS","TRICARE")_$E(FLD02,8,$L(FLD02))
 . .  I $D(FLD03) S:FLD03["CHAMPUS" FLD03=$TR($E(FLD03,1,7),"CHAMPUS","TRICARE")_$E(FLD03,8,$L(FLD03))
 . .  I $D(FLD04) S:FLD04["CHAMPUS" FLD04=$TR($E(FLD04,1,7),"CHAMPUS","TRICARE")_$E(FLD04,8,$L(FLD04))
 . .  L +^DGCR(FILENUM)
 . .  S DIE="^DGCR(FILENUM,"
 . .  I FILENUM="399.3" S DR=".01////"_FLD01_";.02////"_FLD02_";.03////"_FLD03_";.04////"_FLD04 D ^DIE K DIE,DA,DR Q
 . .  S DR=".01////"_FLD01 D ^DIE
 . .  K DIE,DA,DR
 . .  L -^DGCR(FILENUM)
 K DIE,DA,DR,FILENUM,FN,FLD01,FLD02,FLD03,FLD04,NODE0,CHID
 Q
 ;
EN4 ; update .01 field in file 36
 S (CHID,NODE0,FLD01)=""
 F  S CHID=$O(^DIC(36,"B",CHID)) Q:CHID=""  D
 .  Q:CHID'["CHAMPUS"
 .  S DA=$O(^DIC(36,"B",CHID,0)) Q:'DA
 .  S NODE0=$G(^DIC(36,DA,0))
 .  S FLD01=$P(NODE0,U,1)
 .  S FLD01=$TR($E(FLD01,1,7),"CHAMPUS","TRICARE")_$E(FLD01,8,$L(FLD01))
 .  S DIE="^DIC(36,",DR=".01////"_FLD01 D ^DIE
 .  K DA,DIE,DR
 K CHID,FLD01,NODE0
 Q
 ;
EN5 ; change all occurrences of CHAMPUS to TRICARE for IB Menu option
 ; text displays.
 S NM="",DA=0
 F  S NM=$O(^DIC(19,"B",NM)) Q:NM=""  D
 .  Q:NM'["IB CHAMP"
 .  S (FLD01,STRG1,FLD02,STRING,NODE0)="" K P
 .  S DA=$O(^DIC(19,"B",NM,0)) Q:'DA
 .  S NODE0=$G(^DIC(19,DA,0))
 .  S FLD01=$P(NODE0,U,1)  ; Option name
 .  F X=1:1 S P(X)=$P(FLD01," ",X) Q:P(X)=""  S:P(X)="CHAMP" P(X)="TRICARE" S STRG1=STRG1_P(X)_" "
 .  S STRG1=$E(STRG1,1,$L(STRG1)-1)
 .  S FLD02=$P(^DIC(19,DA,0),U,2)  ; Menu text
 .  F X=1:1 S P(X)=$P(FLD02," ",X) Q:P(X)=""  S:P(X)="CHAMPUS" P(X)="TRICARE" S STRING=STRING_P(X)_" "
 .  S STRING=$E(STRING,1,$L(STRING)-1)
 .  S DIE="^DIC(19,",DR=".01////"_STRG1_";1////"_STRING D ^DIE
 .  K DIE,DR
 .  D DESC
 K X,NM,DA,NODE0,FLD01,FLD02,STRG1,STRING,P
 D IBJD
 Q
 ;
IBJD ; change text display for menu option
 S NM="IBJD FOLLOW-UP CHAMPVA/TRICARE"
 S DA="",DA=$O(^DIC(19,"B",NM,"")) Q:DA=""
 S STRING="CHAMPVA/TRICARE Follow-Up Report"
 S DIE="^DIC(19,",DR="1////"_STRING D ^DIE
 D DESC
 K DA,DA1,DIE,DR,STRING,NM,WP,P
 Q
 ;
DESC ; change any references from Champus to Tricare in the
 ; word-processing description multiple field
 Q:'$D(^DIC(19,DA,1))
 S DA1=0,(STRING,WP)=""
 F  S DA1=$O(^DIC(19,DA,1,DA1)) Q:'DA1  D
 .  S WP=^DIC(19,DA,1,DA1,0)
 .  Q:WP'["CHAMPUS"
 .  F X=1:1 S P(X)=$P(WP," ",X) Q:P(X)=""  S:P(X)="CHAMPUS" P(X)="TRICARE" S:P(X)="(Tricare)" P(X)="" S:P(X)'="" STRING=STRING_P(X)_" "
 .  S STRING=$E(STRING,1,$L(STRING)-1)
 .  S ^DIC(19,DA,1,DA1,0)=STRING
 Q
 ;
EN6 ; search for all records in file 355.3 that contain internal code
 ; CH in field .15 (Electronic Plan Type) and change it to TR.
 ; The external value for this field has been changed from CHAMPUS
 ; to TRICARE.
 S DA=0,(NODE0,PC)=""
 F  S DA=$O(^IBA(355.3,DA)) Q:'DA  D
 .  S NODE0=$G(^IBA(355.3,DA,0)),PC=$P(NODE0,U,15)
 .  Q:PC'="CH"
 .  S PC="TR"
 .  S DIE="^IBA(355.3,",DR=".15////"_PC D ^DIE
 K DA,DR,DIE,NODE0,PC
 Q
 ;
FILE1 ; file numbers with root name ^IBE that need to be updated
 ;;350.1
 ;;351.7
 ;;355.1
 ;;355.2
 ;;355.97
 ;;363
 ;
FILE2 ; file numbers with root name ^IBA that need to be updated
 ;;355.3
 ;;364.5
 ;;364.7
 ;
FILE3 ; file numbers with root name ^DGCR that need to be updated
 ;;399.1
 ;;399.3
