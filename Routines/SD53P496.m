SD53P496 ;ALB/ESW - SD*5.3*496 POST INIT; Oct 04, 2006 ; 10/23/06 5:40pm  ; 4/16/07 5:27pm
 ;;5.3;SCHEDULING;**496**;AUG 13, 1993;Build 11
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;Clean ^GMR(123,"F"  cross-reference, used to search by patient to
 ;get REQUEST/CONSULTATION ien, through verification that each cross-
 ;reference entry has its corresponding REQUEST/CONSULTATION entry pointed to.
 Q
 ;
POST ;
 N SDA
 S SDA(1)="",SDA(2)="    SD*5.3*496 Post-Install .....",SDA(3)="" D ATADDQ
 S SDA(1)="  >> Verifying if )'^GMR(123,""F"",SDPT,SDIN)' have corresponding"
 S SDA(2)="     '0' entries in the REQUEST/CONSULTATION file (# 123), and remove them if not."
 N SDPT,SDIN,DA,SDREF,CNT S CNT=0
 S SDPT="" F  S SDPT=$O(^GMR(123,"F",SDPT)) Q:SDPT'>0  D
 .S SDIN="" F  S SDIN=$O(^GMR(123,"F",SDPT,SDIN)) Q:SDIN=""  D
 ..I $G(^GMR(123,SDIN,0))="" S CNT=CNT+1 D  S SDREF=^GMR(123,"F",SDPT,SDIN) K ^(SDIN),SDREF
 ...N SDA
 ...S SDA(1)="Entry "_SDIN_" - Patient DFN= "_SDPT_" does not have '0' node"
 ...S SDA(2)="      ""F"" - cross-reference deleted."
 ...D ATADDQ
 I 'CNT N SDA S SDA(1)=" No bad ""F"" cross-references identified"
 E  N SDA S SDA(1)="  "_CNT_" 'hanging' ""F"""_" cross-references identified"
 S SDA(2)="  SD*5.3*496 Post-Install finished."
 D ATADDQ
 Q
 ;
ATADDQ D MES^XPDUTL(.SDA) K SDA
 Q
