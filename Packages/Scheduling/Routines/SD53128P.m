SD53128P ;ALB/JRP - ENV CHECK / PRE-INIT / POST-INIT;29-JUL-97
 ;;5.3;Scheduling;**128**;AUG 13, 1993
 ;
ENV ;Environment check entry point
 ;
 ;Declare variables
 N TMP,ROUTINE
 ;Check for installation of SD*5.3*66 (released after 128)
 Q:('$$PATCH^XPDUTL("SD*5.3*66"))
 ;Site installed patch 66
 S TMP(1)=" "
 S TMP(2)="***  Patch SD*5.3*66 has been installed at this site.    ***"
 S TMP(3)="***                                                      ***"
 S TMP(3)="***  Although patches SD*5.3*66 and SD*5.3*128 modified  ***"
 S TMP(4)="***  some common routines, they could not be released    ***"
 S TMP(5)="***  as a single patch.                                  ***"
 S TMP(6)="***                                                      ***"
 S TMP(7)="***  Routines common to pathes SD*5.3*66 and SD*5.3*128  ***"
 S TMP(8)="***  will not be installed.                              ***"
 S TMP(9)=" "
 D MES^XPDUTL(.TMP)
 ;Tell KIDS to skip overlap routines during installation
 F ROUTINE="SCDXMSG","SCDXMSG2","SCDXFU02" D
 .D BMES^XPDUTL("Telling KIDS to skip installation of "_ROUTINE)
 .I ($$RTNUP^XPDUTL(ROUTINE,2)) D MES^XPDUTL("Done") Q
 .;Error - abort install
 .K TMP
 .S TMP(1)="  >>"
 .S TMP(2)="  >> Unable to tell KIDS to skip installation of "_ROUTINE
 .S TMP(3)="  >> Installation will be aborted"
 .S TMP(4)="  >>"
 .D MES^XPDUTL(.TMP)
 .S XPDQUIT=1
 ;Done
 Q
 ;
PRE ;Pre-init entry point
 ;
 Q
 ;
POST ;Post-init entry point
 ;
 ;Declare variables
 N TMP,COUNT,SEED
 ;Get seed date (quit if not found - means question wasn't asked)
 S SEED=+$G(XPDQUES("POSSEED"))
 Q:('SEED)
 ;Seed ACRP Transmission History file (#409.77) with xmit & ack
 ; information in Transmitted Outpatient Encounter file (#409.73)
 S TMP(1)=" "
 S TMP(2)="Seeding ACRP Transmission History file (#409.77) with"
 S TMP(3)="transmission and acknowledgement information currently"
 S TMP(4)="contained in the Transmitted Outpatient Encounter file"
 S TMP(5)="(#409.73).  Seeding will be based on transmissions that"
 S TMP(6)="occurred between "_$$FMTE^XLFDT(SEED)_" and "_$$FMTE^XLFDT($$DT^XLFDT())_"."
 S TMP(7)=" "
 D MES^XPDUTL(.TMP)
 S COUNT=$$SEEDHIST^SD53128A(SEED)
 K TMP
 S TMP(1)=" "
 S TMP(2)=COUNT_" entries in the ACRP Transmission History file"
 S TMP(3)="have been created"
 S TMP(4)=" "
 D MES^XPDUTL(.TMP)
 ;Done
 Q
