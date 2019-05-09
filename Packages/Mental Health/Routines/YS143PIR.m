YS143PIR ;HPS-CS/JSG - YS*5.01*143 POST INSTALL ROUTINE;JAN 2, 2019@10:30
 ;;5.01;MENTAL HEALTH;**143**;Jan 2, 2019;Build 3
 ;Examines the SEQUENCE and CHOICE ID fields in the CHOICETYPES file (#601.751) to
 ;determine if they are set incorrectly and need to be updated for CHOICETYPE ID 336.
 ;
 D MES^XPDUTL("Checking the MH CHOICETYPES file for suitability to apply changes")
 S YSPIRCT=$P($G(^YTT(601.751,1272,0)),U) I YSPIRCT'=336 D  Q
 .D MES^XPDUTL("CHOICETYPE value is not as expected - no update.")
 S YSPIRSEQ=$P($G(^YTT(601.751,1272,0)),U,2) I YSPIRSEQ=1 D  Q
 .D MES^XPDUTL("SEQUENCE value is not as expected - no update.")
 S YSPIRCID=$P($G(^YTT(601.751,1272,0)),U,3) I YSPIRCID=1054 D  Q
 .D MES^XPDUTL("CHOICE ID value is not as expected - no update.")
SET ;Correct the values (CHOICETYPE ID 336 IEN = 1272)
 S DIE=601.751,DA=1272
 S DR="1////1;2////1054"
 D ^DIE
 D MES^XPDUTL("The SEQUENCE and CHOICE ID values are updated.")
 ;
LED ;Update the LAST DATE MODIFIED for SCL9R
 D MES^XPDUTL("Update modification date for SCL9R")
 S YSPIRIEN=$O(^YTT(601.71,"B","SCL9R",0))
 S DIE=601.71,DA=YSPIRIEN
 S YSPIRLED=$$NOW^XLFDT,YSPIRLEB="YS*5.01*143"
 S DR="17////"_YSPIRLEB_";18////"_YSPIRLED
 D ^DIE
 D MES^XPDUTL("Update modification date for SCL9R")
END ;
 K YSPIRCT,YSPIRSEQ,YSPIRCID,YSPIRLEB,YSPIRLED
 Q
