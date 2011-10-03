ENXOIPS1 ;WIRMFO/DH-POST INIT (continued) ;8.14.96
 ;;7.0;ENGINEERING;**33**;AUG 17, 1993
AOCHK ;Check for incorrect A.O. Codes (CMR 69x)
 N AMBC,ENX,ENI,X,ENDA,COUNT K ^TMP($J,"CMR69")
 S (COUNT("TOT"),COUNT("FAP"),COUNT("EXP"))=0
 S ENI=0 F  S ENI=$O(^ENG(6914.1,ENI)) Q:ENI'>0  I $E($P(^(ENI,0),U),1,2)=69 S AMBC(ENI)=""
 I $D(AMBC) D
 . D BMES^XPDUTL("You may have some Equipment Records with an incorrect A.O. Code and") D MES^XPDUTL("incorrect Equity Account. Checking further...")
 . S ENI=0 F  S ENI=$O(AMBC(ENI)) Q:ENI'>0  D
 .. S ENDA=0 F  S ENDA=$O(^ENG(6914,"AD",ENI,ENDA)) Q:ENDA'>0  D
 ... I $$GET1^DIQ(6914,ENDA,63,"I")=4 D
 ....S ENX=$$CHKFA^ENFAUTL(ENDA),$P(^ENG(6914,ENDA,9),U,8)=3,$P(^(9),U,9)=3299
 .... S COUNT("TOT")=COUNT("TOT")+1
 .... S:$P(ENX,U) ^TMP($J,"CMR69",ENDA)=$$GET1^DIQ(6915.2,$P(ENX,U,4),24)_U_$E($$GET1^DIQ(6914,ENDA,3),1,30)_U_$$GET1^DIQ(6914,ENDA,12),COUNT("FAP")=COUNT("FAP")+1
 .... I '$P(ENX,U) S COUNT("EXP")=COUNT("EXP")+1
 . I COUNT("TOT")=0 D MES^XPDUTL("            ... no problems found.") Q
 . ;Report the problems
 . D BMES^XPDUTL(COUNT("TOT")_" defective records were found and corrected in AEMS-MERS.") D MES^XPDUTL(COUNT("FAP")_" of these have been reported to the Fixed Assets Package (FAP).")
 . D MES^XPDUTL(COUNT("EXP")_" are not in FAP and are presumably expensed.")
 . D BMES^XPDUTL("The FAP database will be corrected in FAP and all AEMS-MERS records have") D MES^XPDUTL("just been fixed. You will now see a list of the defective records that")
 . D MES^XPDUTL("were sent to FAP from Ambulatory Care CMRs, but no corrective action is") D MES^XPDUTL("required of your site.")
 . D BMES^XPDUTL("   FIXED ASSET NUMBER     MANUFACTURER EQUIPMENT NAME   TOTAL ASSET VALUE")
 . D MES^XPDUTL("   ==================     ===========================   =================")
 . S ENDA=0 F  S ENDA=$O(^TMP($J,"CMR69",ENDA)) Q:ENDA'>0  K X D
 .. S X(1)=$P(^TMP($J,"CMR69",ENDA),U),X(2)=$P(^(ENDA),U,2),X(3)=$P(^(ENDA),U,3)
 .. F  Q:$L(X(1))>14  S X(1)=X(1)_" "
 .. F  Q:$L(X(2))>29  S X(2)=X(2)_" "
 .. F  Q:$L(X(3))>9  S X(3)=" "_X(3)
 .. D MES^XPDUTL("   "_X(1)_"        "_X(2)_"       "_X(3))
MSG ;Mail message to developer
 ;Data may be made available to FMS
 S (ENX,X)=0 F  S X=$O(^TMP($J,"CMR69",X)) Q:X'>0  S ENX=ENX+$P(^(X),U,3)
 I COUNT("FAP")=0 S ^TMP($J,"CMR69",1)="No FAs transmitted.",^TMP($J,"CMR69",2)=^ENG(6914,0) D PS
 E  S ENI=$O(^TMP($J,"CMR69",9999999999),-1),^TMP($J,"CMR69",ENI+1)="FAP Records from CMRs 69x Total $"_ENX,^TMP($J,"CMR69",ENI+2)=^ENG(6914,0) D PS
 S XMY("HEIBY,D@FORUM.VA.GOV")="",XMY(DUZ)="",XMDUZ=.5
 S XMSUB="FAP Records in EIL 69",XMTEXT="^TMP($J,""CMR69"","
 D ^XMD
 K XMY,XMDUZ,XMSUB,XMTEXT
 K ^TMP($J)
 Q
PS ;Note to installer
 S ENI=$O(^TMP($J,"CMR69",9999999999),-1)
 S ^TMP($J,"CMR69",ENI+1)="",^(ENI+2)="NOTE TO INSTALLER OF EN*7.0*33:",^(ENI+3)="This message is a courtesy copy only. No action is required of your site."
 Q
 ;ENXOIPS1
