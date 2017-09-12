MAGIPO61 ;WOIFO/JSL - Post init routine to queue site activity at install; 29 Sep 2005  9:00 AM
 ;;3.0;IMAGING;**61**;Feb 07, 2006
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
WARNMSG ;
 N DIWR,DIWL,DIWF K ^UTILITY($J,"W")
 S ANS="",DIWR=80,DIWL=1
 U IO(0) W !
 S X="|NOWRAP|" D ^DIWP
 S X="======================================================================" D ^DIWP
 S X=">>>                   PATIENT SAFETY WARNING                       <<<" D ^DIWP
 S X=">>>     Read This Notice Before Installing the Term Update File    <<<" D ^DIWP
 S X="======================================================================" D ^DIWP
 S X="|WRAP|" D ^DIWP
 S X="Index term files are nationally standard files that are maintained by the VistA Imaging Team. Sites are only permitted to modify the value of the STATUS" D ^DIWP
 S X="(active/inactive) field on two index term files : IMAGE INDEX FOR PROCEDRUE/EVENT and IMAGE INDEX FOR SPECIALTY/SUBSPECIALTY." D ^DIWP
 S X="Except for these two STATUS fields, NO LOCAL ADDITIONS, DELETIONS, OR MODIFICATIONS ARE PERMITTED to the index term files. Files to which additions, deletions and modifications are NOT to be made locally" D ^DIWP
 S X="include the following:" D ^DIWP
 S X="|NOWRAP|" D ^DIWP
 S X="    IMAGE INDEX FOR CLASS (#2005.82)" D ^DIWP
 S X="    IMAGE INDEX FOR TYPES (#2005.83)" D ^DIWP
 S X="    IMAGE INDEX FOR SPECIALTY/SUBSPECIALTY (#2005.84) (except the STATUS field)" D ^DIWP
 S X="    IMAGE INDEX FOR PROCEDURE/EVENT (#2005.85) (except the STATUS field)" D ^DIWP
 S X="|WRAP|" D ^DIWP
 S X="Additions, deletions or modifications to index term files by local sites risk overwriting or other loss of information as distributions from the VistA Imaging Team are installed." D ^DIWP
 S X="Loss of information that is used to make patient treatment decisions could have a negative impact on patient safety." D ^DIWP
 S X="If you believe that any entries on your index term files may have been added, deleted or modified locally, DO NOT INSTALL THIS UPDATE!" D ^DIWP
 S X="Instead, please place a Remedy call IMMEDIATELY to VistA Imaging Support." D ^DIWP
 D ^DIWW H 5
 Q
POST ;
 N FILE
 F FILE=2005.82,2005.83,2005.84,2005.85,2005.852 D
 . I $P(^DD(FILE,.01,0),U,2)'["I" S $P(^(0),U,2)=$P(^(0),U,2)_"I" ;no del
 . S ^DD(FILE,.01,"LAYGO",1,0)="I 0" ;no add
 . Q
 ;
 ;  disable 'Write' access for certain fields in the files
 S ^DD(2005.82,1,9)="^"  ;Class: Status
 S ^DD(2005.83,1,9)="^"  ;Type: Class
 S ^DD(2005.83,2,9)="^"  ;Type: Status
 S ^DD(2005.83,3,9)="^"  ;Type: Abbreviation
 S ^DD(2005.84,1,9)="^"  ;Spec/SubSpec: Class 
 S ^DD(2005.84,2,9)="^"  ;Spec/SubSpec: Spec Level
 S ^DD(2005.84,3,9)="^"  ;Spec/SubSpec: Abbreviation
 ; ^DD(2005.84,4)     =  ; STATUS - Leave Write access
 S ^DD(2005.85,1,9)="^"  ;Proc/Event: Class
 S ^DD(2005.85,2,9)="^"  ;Proc/Event: Specialty
 S ^DD(2005.85,3,9)="^"  ;Proc/Event: Abbreviation
 ; ^DD(2005.85,4)     =  ; STATUS - Leave Write access
 ; create and send the site installation message
 D REMTASK^MAGQE4
 D STTASK^MAGQE4
 D INS(XPDNM,DUZ,$$NOW^XLFDT,XPDA)
 Q
 ;
INS(XP,DUZ,DATE,IDA) ;
 N CT,CNT,COM,D,D0,D1,D2,DDATE,DG,DIC,DICR,DIW,MAGMSG,ST,XMID,XMY
 D GETENV^%ZOSV
 S CNT=0
 S CNT=CNT+1,MAGMSG(CNT)="PACKAGE INSTALL"
 S CNT=CNT+1,MAGMSG(CNT)="SITE: "_$$KSP^XUPARAM("WHERE")
 S CNT=CNT+1,MAGMSG(CNT)="PACKAGE: "_XP
 S CNT=CNT+1,MAGMSG(CNT)="Version: "_$$VER^XPDUTL(XP)
 S ST=$$GET1^DIQ(9.7,IDA,11,"I")
 S CNT=CNT+1,MAGMSG(CNT)="Start time: "_$$FMTE^XLFDT(ST)
 S CT=$$GET1^DIQ(9.7,IDA,17,"I") S:+CT'=CT CT=$$NOW^XLFDT
 S CNT=CNT+1,MAGMSG(CNT)="Completion time: "_$$FMTE^XLFDT(CT)
 S CNT=CNT+1,MAGMSG(CNT)="Run time: "_$$FMDIFF^XLFDT(CT,ST,3)
 S CNT=CNT+1,MAGMSG(CNT)="Environment: "_Y
 S COM=$$GET1^DIQ(9.7,IDA,6,"I")
 S CNT=CNT+1,MAGMSG(CNT)="FILE COMMENT: "_COM
 S CNT=CNT+1,MAGMSG(CNT)="DATE: "_DATE
 S CNT=CNT+1,MAGMSG(CNT)="Installed by: "_$$GET1^DIQ(9.7,IDA,9,"E")
 S CNT=CNT+1,MAGMSG(CNT)="Install Name: "_$$GET1^DIQ(9.7,IDA,.01,"E")
 S DDATE=$$GET1^DIQ(9.7,IDA,51,"I")
 S CNT=CNT+1,MAGMSG(CNT)="Distribution Date: "_$$FMTE^XLFDT(DDATE)
 S XMSUB=XP_" INSTALLATION"
 S XMID=$G(DUZ) S:'XMID XMID=.5
 S XMY(XMID)=""
 S XMY("G.MAG SERVER")=""
 S:$G(MAGDUZ) XMY(MAGDUZ)=""
 S XMSUB=$E(XMSUB,1,63)
 D SENDMSG^XMXAPI(XMID,XMSUB,"MAGMSG",.XMY,,.XMZ,)
 I $G(XMERR) M XMERR=^TMP("XMERR",$J) S $EC=",U13-Cannot send MailMan message,"
 Q
BASE ;baseline
 ;;(2005.82,1,0)|CLIN
 ;;(2005.82,7,0)|CLIN/ADMIN
 ;;(2005.82,1,0)|CLIN
 ;;(2005.82,7,0)|CLIN/ADMIN
 ;;(2005.82,8,0)|ADMIN
 ;;(2005.82,9,0)|ADMIN/CLIN
 ;;(2005.83,6,0)|INSURANCE FORM^8
 ;;(2005.83,7,0)|ELIGIBILITY/VA FORM 10-7131^8
 ;;(2005.83,11,0)|PATIENT RIGHTS AND RESPONSIBILITIES^8
 ;;(2005.83,45,0)|MISCELLANEOUS DOCUMENT^1
 ;;(2005.83,46,0)|MEANS TEST (10-10EZ)^8
 ;;(2005.83,47,0)|MEANS TEST (10-10F)^8
 ;;(2005.83,48,0)|ALLIED VETERAN^8
 ;;(2005.83,49,0)|APPT OF VSO AS CLAIMANT'S REP^8
 ;;(2005.83,50,0)|CORRESPONDENCE^8
 ;;(2005.83,51,0)|DD214 ENLISTED RECORD & RPT OF SEP^8
 ;;(2005.83,52,0)|DEATH CERTIFICATE^8
 ;;(2005.83,53,0)|DENIAL LETTER^8
 ;;(2005.83,54,0)|DISCHARGE AGAINST MEDICAL ADVICE^8
 ;;(2005.83,56,0)|FINANCIAL WORKSHEET^8
 ;;(2005.83,57,0)|INVENTORY OF FUNDS AND EFFECTS^8
 ;;(2005.83,58,0)|MEDICAL CERTIFICATE^8
 ;;(2005.83,59,0)|HEALTH INSURANCE CARDS^8
 ;;(2005.83,60,0)|PLENARY GUARDIANSHIP^8
 ;;(2005.83,61,0)|POWER OF ATTORNEY^8
 ;;(2005.83,62,0)|REPORT OF CONTACT^8
 ;;(2005.83,63,0)|REQUEST FOR INFORMATION^8
 ;;(2005.83,64,0)|VALUABLES / BELONGINGS CHECKLIST^8
 ;;(2005.83,65,0)|DESIGNATION OF HEALTHCARE SURROGATE^8
 ;;(2005.83,66,0)|CONSENT^1
 ;;(2005.83,67,0)|ADVANCE DIRECTIVE^7
 ;;(2005.83,68,0)|OUTSIDE MEDICAL RECORD (FEE)^1^I
 ;;(2005.83,69,0)|MEDICAL RECORD^1
 ;;(2005.83,70,0)|OUTSIDE MEDICAL RECORD (DOD)^1^I
 ;;(2005.83,71,0)|MEDICATION RECORD^1
 ;;(2005.83,72,0)|FLOWSHEET^1
 ;;(2005.83,73,0)|VISIT RECORD^1
 ;;(2005.83,74,0)|PROCEDURE RECORD^1
 ;;(2005.83,75,0)|IMAGE^1
 ;;(2005.83,76,0)|DIAGRAM^1
 ;;(2005.83,77,0)|MISCELLANEOUS^8
 ;;(2005.83,78,0)|DISCHARGE SUMMARY^1
 ;;(2005.83,80,0)|CONSULT^1
 ;;(2005.83,81,0)|COMMITMENT^9^A
 ;;(2005.83,82,0)|REQUEST FOR AUTOPSY^9
 ;;(2005.83,83,0)|RELEASE OF INFORMATION^9
 ;;(2005.83,84,0)|PHOTO ID^9^A
 ;;(2005.83,85,0)|PROGRESS NOTE^1^A
 ;;(2005.84,1,0)|INTERNAL MEDICINE^1
 ;;(2005.84,2,0)|CARDIOLOGY^1^1
 ;;(2005.84,3,0)|GASTROENTEROLOGY^1^1
 ;;(2005.84,4,0)|HEMATOLOGY, MEDICAL^1^1
 ;;(2005.84,5,0)|INFECTIOUS DISEASE^1^1
 ;;(2005.84,6,0)|ONCOLOGY^1^1
 ;;(2005.84,7,0)|NEPHROLOGY^1^1
 ;;(2005.84,8,0)|PULMONARY^1^1
 ;;(2005.84,9,0)|RHEUMATOLOGY^1^1
 ;;(2005.84,10,0)|CRITICAL CARE, MED^1^1
 ;;(2005.84,11,0)|GERIATRICS^1^47
 ;;(2005.84,12,0)|ENDOCRINOLOGY, DIABETES, METAB^1^1
 ;;(2005.84,14,0)|THORACIC SURGERY^1^48
 ;;(2005.84,15,0)|UROLOGY^1^48
 ;;(2005.84,16,0)|ORTHOPEDICS^1^48
 ;;(2005.84,17,0)|OPHTHALMOLOGY^1^57
 ;;(2005.84,18,0)|NEUROLOGIC SURGERY^1^48
 ;;(2005.84,19,0)|DERMATOLOGY^1^1
 ;;(2005.84,20,0)|COLON & RECTAL SURGERY^1^48
