ENXSIPS ;WIRMFO/DH-Patch Post-init (EN*7*37) ;10.9.96
 ;;7.0;ENGINEERING;**37**;Aug 17, 1993
AOCHK ;Repeat a check first attempted in EN*7*33
 ;Check for incorrect AO CODES (CMR 69x) - Ambulatory Care
 N AMBC,ENX,ENI,X,ENDA,COUNT,DIFROM
 K ^TMP($J)
 S (COUNT("TOT"),COUNT("FAP"),COUNT("EXP"))=0
 S ENI=0 F  S ENI=$O(^ENG(6914.1,ENI)) Q:ENI'>0  I $E($P(^(ENI,0),U),1,2)=69 S AMBC(ENI)=""
 I $D(AMBC) D
 . D BMES^XPDUTL("You may have some Equipment Records with an incorrect AO CODE and") D MES^XPDUTL("incorrect EQUITY ACCOUNT. Checking further...")
 . S ENI=0 F  S ENI=$O(AMBC(ENI)) Q:ENI'>0  D
 .. S ENDA=0 F  S ENDA=$O(^ENG(6914,"AD",ENI,ENDA)) Q:ENDA'>0  D
 ... I $$GET1^DIQ(6914,ENDA,63,"I")=4 D
 ....S ENX=$$CHKFA^ENFAUTL(ENDA),$P(^ENG(6914,ENDA,9),U,8)=3 S:$P(^(9),U,9)'=3402 $P(^(9),U,9)=3299
 .... S COUNT("TOT")=COUNT("TOT")+1
 .... S:$P(ENX,U) ^TMP($J,"CMR69",ENDA)=$$GET1^DIQ(6915.2,$P(ENX,U,4),24)_U_$E($$GET1^DIQ(6914,ENDA,3),1,30)_U_$$GET1^DIQ(6914,ENDA,12),COUNT("FAP")=COUNT("FAP")+1
 .... I '$P(ENX,U) S COUNT("EXP")=COUNT("EXP")+1
 . I COUNT("TOT")=0 D MES^XPDUTL("            ... no problems found.") Q
 . ;Report the problems
 . D BMES^XPDUTL(COUNT("TOT")_" defective records were found and corrected in AEMS-MERS.") D MES^XPDUTL(COUNT("FAP")_" of these have been reported to the Fixed Assets Package (FAP).")
 . D MES^XPDUTL(COUNT("EXP")_" are not in FAP and are presumably expensed.")
 . D BMES^XPDUTL("The FAP database will be corrected centrally and all AEMS-MERS records have") D MES^XPDUTL("just been fixed. You will now see a list of the defective records that were")
 . D MES^XPDUTL("sent to FAP from Ambulatory Care CMRs, but no corrective action is required") D MES^XPDUTL("of your site.")
 . D BMES^XPDUTL("   FIXED ASSET NUMBER     MANUFACTURER EQUIPMENT NAME   TOTAL ASSET VALUE")
 . D MES^XPDUTL("   ==================     ===========================   =================")
 . S ENDA=0 F  S ENDA=$O(^TMP($J,"CMR69",ENDA)) Q:ENDA'>0  K X D
 .. S X(1)=$P(^TMP($J,"CMR69",ENDA),U),X(2)=$P(^(ENDA),U,2),X(3)=$P(^(ENDA),U,3)
 .. F  Q:$L(X(1))>14  S X(1)=X(1)_" "
 .. F  Q:$L(X(2))>29  S X(2)=X(2)_" "
 .. F  Q:$L(X(3))>9  S X(3)=" "_X(3)
 .. D MES^XPDUTL("   "_X(1)_"        "_X(2)_"       "_X(3))
MSG1 ;Mail message to developers
 ;Data may be made available to FMS
 S (ENX,X)=0 F  S X=$O(^TMP($J,"CMR69",X)) Q:X'>0  S ENX=ENX+$P(^(X),U,3)
 I COUNT("FAP")=0 S ^TMP($J,"CMR69",1)="No FAs transmitted.",^TMP($J,"CMR69",2)=^ENG(6914,0) D PS
 E  S ENI=$O(^TMP($J,"CMR69",9999999999),-1),^TMP($J,"CMR69",ENI+1)="FAP Records from CMRs 69x Total $"_ENX,^TMP($J,"CMR69",ENI+2)=^ENG(6914,0) D PS
 S XMY("HEIBY,D@DOMAIN.EXT")="",XMY(DUZ)="",XMDUZ=.5
 S XMSUB="FAP Records in EIL 69",XMTEXT="^TMP($J,""CMR69"","
 D ^XMD
 K XMY,XMDUZ,XMSUB,XMTEXT
 ;
PAT33 ;Clean up EQUITY ACCOUNTS set by 8.16.96 version of ENLIB3
 ;Start with EXPENSED NX
 D BMES^XPDUTL("Looping thru Equipment File to correct AO CODE vs EQUITY mismatches.")
 D MES^XPDUTL("This will take a few minutes.")
 N DA,FADATE,AO,EQUITY,STATION,XMCHAN
 S DA("EQ")=0,XMCHAN=1
 ;Clean errors in entries other than CAPITALIZED NX
 F  S DA("EQ")=$O(^ENG(6914,DA("EQ"))) Q:'DA("EQ")  D:'(DA("EQ")#500) MES^XPDUTL("ENTRY # "_DA("EQ")) S EQUITY=$P($G(^ENG(6914,DA("EQ"),9)),U,9) I EQUITY]"",EQUITY'=3402 D
 . I $P($G(^ENG(6914,DA("EQ"),8)),U,2),$P($$CHKFA^ENFAUTL(DA("EQ")),U) Q  ;Will check these entries in FA segment
 . S AO=$P(^ENG(6914,DA("EQ"),9),U,8) Q:'AO  ;Wasn't set via ENLIB3
 . I AO=3,EQUITY=3210 S $P(^ENG(6914,DA("EQ"),9),U,9)=3299
 . I "4^5"[AO,EQUITY=3299 S $P(^ENG(6914,DA("EQ"),9),U,9)=3210
FA ;Now we'll look at the FAP stuff
 S FADATE=2960801 ;Earlest possible date for install of EN*7*33
 K ^TMP($J) D BMES^XPDUTL("Checking for FAP Equipment Records in need of correction. Corrections (if")
 D MES^XPDUTL("needed) will be made centrally. Site action is not required.")
 F  S FADATE=$O(^ENG(6915.2,"D",FADATE)) Q:'FADATE  D
 . S DA("FA")=$O(^ENG(6915.2,"D",FADATE,0)) Q:'DA("FA")
 . S DA("EQ")=$P(^ENG(6915.2,DA("FA"),0),U) Q:'DA("EQ")
 . Q:'$D(^ENG(6914,DA("EQ"),9))
 . S PO("E")=$P($G(^ENG(6914,DA("EQ"),2)),U,2) Q:PO("E")']""
 . S PO("I")=$$FIND1^DIC(442,"","X",PO("E"),"C^B") Q:'PO("I")
 . S STATION=$P($$GET1^DIQ(442,PO("I"),.01),"-")
 . I $L(STATION)<5 S STATION=$E(STATION_"  ",1,5)
 . I $P(^ENG(6914,DA("EQ"),9),U,8)=3,$P(^(9),U,9)=3210 D
 .. S ^TMP($J,1,DA("EQ"))="FAP Equip Record '"_STATION_DA("EQ")_"' should have EQUITY of 3299 (MEDICAL).",$P(^ENG(6914,DA("EQ"),9),U,9)=3299
 .. D MES^XPDUTL(^TMP($J,1,DA("EQ")))
 . I ($E(STATION)=3!("4^5"[$P(^ENG(6914,DA("EQ"),9),U,8))),$P(^(9),U,9)=3299 D
 .. S ^TMP($J,1,DA("EQ"))="FAP Equip Record '"_STATION_DA("EQ")_"' should have EQUITY of 3210 (NON-MEDICAL).",$P(^ENG(6914,DA("EQ"),9),U,9)=3210
 .. D MES^XPDUTL(^TMP($J,1,DA("EQ")))
MSG2 ;Feedback to developers
 ;Information may be shared with FMS
 I $D(^TMP($J)) D
 . S ^TMP($J,1,.1)="The following Equipment Records were given an incorrect EQUITY ACCOUNT when"
 . S ^TMP($J,1,.2)="they were added to AEMS/MERS. The AEMS/MERS Equipment Record has been"
 . S ^TMP($J,1,.3)="corrected, and the FAP file in Austin will be corrected centrally."
 . S ^TMP($J,1,.4)=" "
 . S ^TMP($J,1,.5)="NOTE TO INSTALLER OF EN*7.0*37:"
 . S ^TMP($J,1,.6)="   This message is a courtesy copy only. No site action is required."
 . S ^TMP($J,1,.7)=" "
 . S XMY("HEIBY,D@DOMAIN.EXT")="",XMY(DUZ)="",XMDUZ=.5
 . S XMSUB="INCORRECT EQUITY (EN*7*33)",XMTEXT="^TMP($J,1,"
 . D ^XMD
 . K XMY,XMDUZ,XMSUB,XMTXT
 K ^TMP($J)
 Q  ;Design EXIT
 ;
PS ;Note to installer
 S ENI=$O(^TMP($J,"CMR69",9999999999),-1)
 S ^TMP($J,"CMR69",ENI+1)="",^(ENI+2)="NOTE TO INSTALLER OF EN*7.0*37:",^(ENI+3)="This message is a courtesy copy only. No action is required of your site."
 Q
 ;ENXSIPS
