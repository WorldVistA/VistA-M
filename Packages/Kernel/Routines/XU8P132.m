XU8P132 ;ALB/JEH - XU*8*132 - POST INIT - ADD SPECIALTY CODES ;04/18/2000  08:26
 ;;8.0;KERNEL;**132**;Jul 10, 1995
 ;
POST ;Update Person Class file with specialty codes
 S XUA(1)="",XUA(2)=">>>XU*8*132 Post-Install...",XUA(3)="" D MES^XPDUTL(.XUA) K XUA
 ;
EN ;Entry for processing specialty codes
 S XUCNT=0
 F XU1=1:1 S XUDATA=$P($T(DATA+XU1^XU8P1321),";;",2,99) Q:XUDATA="$END$"  D UPDATE
 F XU1=1:1 S XUDATA=$P($T(DATA+XU1^XU8P1322),";;",2,99) Q:XUDATA="$END$"  D UPDATE
 ;
ENQ ;Display record count, kill variables and quit
 S XUA(1)="",XUA(2)=">>>XU*8*132 Post-Install Complete..."_XUCNT_" specialty codes added",XUA(3)="" D MES^XPDUTL(.XUA)
 K XUREC,XUDATA,XUIEN,XUA,XUCNT,XU1
 Q
UPDATE ;Process to add new specialty codes
 I $P(XUDATA,U,3)="" Q  ;Quit if no specialty code
 S XUREC=$G(^USC(8932.1,+XUDATA,0)) I XUREC="" D  Q
 .S XUA(1)="",XUA(2)=">>>There is an IEN in the patch routine that does not exist in the",XUA(3)="   Person Class file.  Record # "_+XUDATA_" does not exist",XUA(4)="" D MES^XPDUTL(.XUA) K XUA
 S XUIEN=+XUDATA
 I $P(XUDATA,U,2)'=$P(XUREC,U,6) D  Q
 .S XUA(1)="",XUA(2)=">>>Person Class VA Code and the patch update VA Code do not match.",XUA(3)="   Could not update specialty code for record # "_XUIEN,XUA(4)="" D MES^XPDUTL(.XUA) K XUA
 L +^USC(8932.1,XUIEN):10 I '$T D  Q
 .S XUA(1)="",XUA(2)=">>>Record # "_XUIEN_" locked at time of patch installation.  Could not update.",XUA(3)="" D MES^XPDUTL(.XUA) K XUA
 S DIE="^USC(8932.1,",DA=XUIEN,DR="8///"_$P(XUDATA,U,3)
 D ^DIE K DIE,DA,DR
 L -^USC(8932.1,XUIEN)
 S XUCNT=XUCNT+1
 Q
