DVBA239P ;ALB/JDG - AMIE EXAM (#396.6) FILE ENTRY ; 12/30/21@09:30
 ;;2.7;AMIE;**239**;Apr 10, 1995;Build 1
 ;
 ;this routine is used as a post-init in a KIDS build
 ;to modify the AMIE EXAM file (#396.6)
 ;
 Q
 ;
 ;
EN ;
 N DVBAMES,DVBI,DVBJ,DVBAREF,DIC,X
 S DVBAMES=0
 D BMES^XPDUTL("Updating the AMIE EXAM file (#396.6)...")
 D DVBANEW ; addition of new exam entry
 Q:DVBAMES=1  D BMES^XPDUTL("Update to the AMIE EXAM file (#396.6) completed.")
 Q
DVBANEW ;Add new exams
 F DVBI=1:1 S DVBJ=$P($T(NEWEXAM+DVBI),";;",2) Q:DVBJ="QUIT"  D
 .S DVBAREF=$P((DVBJ),"^",1)
 .I $D(^DVB(396.6,"B",DVBAREF)) D DVBAERR Q
 .K DO
 .S DIC="^DVB(396.6,",DIC(0)="L",DIC("DR")=$P((DVBJ),"^",2),X=DVBAREF
 .D FILE^DICN
 .D BMES^XPDUTL("** "_DVBAREF_" has been added to the AMIE EXAM file (#396.6) **")
 Q
DVBAERR ;Message to the user that the file entry already exists.
 D BMES^XPDUTL("*** A FILE ENTRY FOR EXAM NAME "_DVBAREF_" HAS ALREADY BEEN CREATED ***") S DVBAMES=1
 Q
NEWEXAM ;exam to be added
 ;;DBQ Spina bifida^.01///DBQ Spina bifida;.5///A;6///DBQ SPINA BIFIDA;2///SPECIAL;7///DVBCQDRV
 ;;QUIT
 Q
