PRSXP132 ;WCIOFO/PLT - PRS PATCH 132 PRE/POST INSTALL ;3/26/12  21:51
 ;;4.0;PAID;**132**;Sep 21, 1995;Build 13
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 QUIT
 ;
 ;
POSTINS ;post install of patch 132
 ;set new entries of telework indicator of sufile 454.0131 of file #454
 N PRSA,PRSB,PRSC
 F PRSA=1:1 S PRSB=$P($T(TW+PRSA),";",3) QUIT:PRSB=""  I PRSB]"" D
 . N PRSFDA
 . S PRSC="?+1,1,"
 . S PRSFDA(454.0131,PRSC,.01)=$P(PRSB,U)
 . S PRSFDA(454.0131,PRSC,1)=$P(PRSB,U,2)
 . S PRSFDA(454.0131,PRSC,2)=$P(PRSB,U,3)
 . D UPDATE^DIE("","PRSFDA") D:$G(DIERR)'="" MES^XPDUTL("The entry '"_$P(PRSB,U)_"' is not added and the adding fails.")
 . D CLEAN^DILF
 . QUIT
 QUIT
 ;
TW ;telework indicator entries of subfile 454.0131
 ;;P^Employee regularly teleworks three or more days per pay period.^Y
 ;;R^Employee regularly teleworks one or two days per pay period.^Y
 ;;S^Employee regularly teleworks one day per month.^Y
 ;;A^Ad Hoc Telework. Employee teleworks only on an as-needed basis. This includes Continuity of Operations, National/Regional emergencies, situational basis (temporary), and Office of Workers Compensation-related telework.^Y
 ;;X^Position is suitable for telework and employee is eligible, but no telework agreement in place.^N
 ;;Y^Position is suitable for telework but employee is not eligible to telework.^N
 ;;Z^Position is not suitable for telework. This code is used only when the employee's position makes teleworking impossible.^N
 ;;V^Employee who is virtual.^N
 ;;E^Employee regularly teleworks three or more days per work week.^Y
 ;
