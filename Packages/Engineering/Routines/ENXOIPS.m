ENXOIPS ;WIRMFO/SAB-POST INIT ;8.7.96
 ;;7.0;ENGINEERING;**33**;AUG 17, 1993
 ;
 D BMES^XPDUTL("Performing Post-Init...")
 ; set up fund conversion table
 N ENFUNDT
 S ENFUNDT(4537)="4537B"
 S ENFUNDT(5014)="5014A1"
 S ENFUNDT(8129)="8129G"
 S ENFUNDT(8180)="8180S"
 D MES^XPDUTL("  Updating NX FUND (#6914.6) names...")
 K ENFDA
 S ENDA=0 F  S ENDA=$O(^ENG(6914.6,ENDA)) Q:'ENDA  D
 . S ENFUND=$P($G(^ENG(6914.6,ENDA,0)),U)
 . I ENFUND]"",$D(ENFUNDT(ENFUND)) D
 . . S ENFDA(6914.6,ENDA_",",.01)=ENFUNDT(ENFUND)
 . . S:ENFUND=8129 ENFDA(6914.6,ENDA_",",1)="National Cemetery Gift Fund"
 . . D MES^XPDUTL("    FUND "_ENFUND_" being changed to "_ENFUNDT(ENFUND))
 I $D(ENFDA) D FILE^DIE("","ENFDA") D MSG^DIALOG()
 D MES^XPDUTL("  Updating FUND values in FA DOCUMENT LOG")
 S ENDA=0 F  S ENDA=$O(^ENG(6915.2,ENDA)) Q:'ENDA  D
 . S ENFUND=$P($G(^ENG(6915.2,ENDA,3)),U,10)
 . I ENFUND]"",$D(ENFUNDT(ENFUND)) S $P(^ENG(6915.2,ENDA,3),U,10)=ENFUNDT(ENFUND)
 D MES^XPDUTL("  Updating FUND values in FR DOCUMENT LOG")
 S ENDA=0 F  S ENDA=$O(^ENG(6915.6,ENDA)) Q:'ENDA  D
 . S ENFUND=$P($G(^ENG(6915.6,ENDA,3)),U,9)
 . I ENFUND]"",$D(ENFUNDT(ENFUND)) S $P(^ENG(6915.6,ENDA,3),U,9)=ENFUNDT(ENFUND)
 K ENDA,ENFDA,ENFUND,ENFUNDT
 D MES^XPDUTL("  Completed NX FUND changes")
 ;
 K ENX
 S ENX(1)=" "
 S ENX(2)="  The asset value of an equipment item in the Equipment Inventory"
 S ENX(3)="  (#6914) file was not being correctly adjusted after creation of"
 S ENX(4)="  an FC Document that changed the asset value of an earlier"
 S ENX(5)="  FA Document to 0.00. The incorrect asset value would result"
 S ENX(6)="  in the Voucher Summary report overstating the actual effect of"
 S ENX(7)="  subsequent FD and FR Documents on the general ledger balance."
 ;
 S ENX(8)=" "
 S ENX(9)="  The problem has been corrected by patch EN*7*33. This routine"
 S ENX(10)="  will examine FAP Documents to identify any equipment entries"
 S ENX(11)="  that were affected by the problem. If any equipment items are"
 S ENX(12)="  identified, then this routine will make appropriate corrections."
 S ENX(13)="  Any changes will be reported."
 S ENX(14)=" "
 D MES^XPDUTL(.ENX) K ENX
 ;
IDEQ ; loop thru FC DOCUMENT LOG to identify equipment that must be checked
 D MES^XPDUTL("  Checking for FC Documents with value 0.00")
 K ^TMP($J)
 S ENC("EQ")=0 ; count of equipment
 S ENI=0 F  S ENI=$O(^ENG(6915.4,ENI)) Q:'ENI  D
 . Q:$P($G(^ENG(6915.4,ENI,3)),U,8)'="00"  ; not FC to FA
 . Q:$P($G(^ENG(6915.4,ENI,4)),U,6)']""  ; FC did not update value
 . Q:$P($G(^ENG(6915.4,ENI,4)),U,6)  ; FC not 0 value
 . ; this FC Document would have been incorrecly processed
 . ; save the associated equipment entry for later
 . S ENDA=$P($G(^ENG(6915.4,ENI,0)),U)
 . I ENDA,'$D(^TMP($J,ENDA)) S ^TMP($J,ENDA)="",ENC("EQ")=ENC("EQ")+1
 ;
 I ENC("EQ")=0 D  G EXIT
 . D MES^XPDUTL("  No FC Documents found with betterment '00' and zero value.")
 . D MES^XPDUTL("  No corrections are required.")
 D MES^XPDUTL("  The asset values of "_ENC("EQ")_" equipment entries may have")
 D MES^XPDUTL("  been incorrectly adjusted due to the fault. Checking further...")
 ;
CHKEQ ; check equipment
 ; load FA Type -> SGL conversion table
 K ENFATT S I=0 F  S I=$O(^ENG(6914.3,I)) Q:'I  S X=^(I,0) I $P(X,U)]"",$P(X,U,3)]"" S ENFATT($P(X,U,3))=$P(X,U)
 S ENFAPDT=DT+1 ; initialize earliest date of a corrected FAP Document
 ; loop thru identified equipment entries
 S ENDA=0 F  S ENDA=$O(^TMP($J,ENDA)) Q:'ENDA  D
 . D BMES^XPDUTL("  -----------------------------------------")
 . D MES^XPDUTL("  Checking Equipment with Entry #"_ENDA)
 . K ENVAL
 . ; lock equipment entry
 . L +^ENG(6914,ENDA):5 I '$T D MES^XPDUTL("  Someone else is editing this equipment item. Please reinstall this patch later.") Q
 . ; obtain chrono list of FAP Documents for this equipment entry
 . K ENDOC
 . F ENFILE=6915.2:.1:6915.6 D
 . . S ENI=0 F  S ENI=$O(^ENG(ENFILE,"B",ENDA,ENI)) Q:'ENI  D
 . . . S ENDT=$$GET1^DIQ(ENFILE,ENI,1,"I")
 . . . S:ENDT ENDOC(ENDT,ENFILE,ENI)=""
 . ; loop thru chrono list of FAP Documents and check asset values
 . S ENDT="" F  S ENDT=$O(ENDOC(ENDT)) Q:ENDT=""  D
 . . S ENFILE="" F  S ENFILE=$O(ENDOC(ENDT,ENFILE)) Q:ENFILE=""  D
 . . . S ENI=0 F  S ENI=$O(ENDOC(ENDT,ENFILE,ENI)) Q:'ENI  D
 . . . . D @("DOC"_$P(ENFILE,".",2))
 . ; now check current value in equipment file
 . S ENVAL("EQ")=$P($G(^ENG(6914,ENDA,2)),U,3) ; equipment value
 . S ENVAL("EX")=$$DEC^ENFAUTL(ENVAL("IFA")+ENVAL("FB")) ; expected value
 . S ENVAL("CO")=$$DEC^ENFAUTL(ENVAL("FA")+ENVAL("FB")) ; correct value
 . I ENVAL("CO")'=ENVAL("EQ") D
 . . D BMES^XPDUTL("  The TOTAL ASSET VALUE in the Equipment file is "_ENVAL("EQ"))
 . . D MES^XPDUTL("  The expected value due to the fault (based on FAP Documents) is "_ENVAL("EX"))
 . . D MES^XPDUTL("  The correct value (based on FAP Documents) is "_ENVAL("CO"))
 . . ;
 . . D MES^XPDUTL("  Changing Equipment file to "_ENVAL("CO")_"...")
 . . S DA=ENDA,DR="12////^S X=ENVAL(""CO"")",DIE="^ENG(6914," D ^DIE
 . . I +$$CHKFA^ENFAUTL(ENDA) D BMES^XPDUTL("  NOTE: The equipment item is currently established in Fixed Assets.")
 . . I '+$$CHKFA^ENFAUTL(ENDA) D BMES^XPDUTL("  NOTE: The equipment item is not currently established in Fixed Assets and") D MES^XPDUTL("    it's value can be edited on the first equipment screen.")
 . D MES^XPDUTL("  Completed check of equipment with Entry #"_ENDA_".")
 . ; unlock equipment item
 . L -^ENG(6914,ENDA)
 I ENFAPDT<DT D
 . D BMES^XPDUTL("-----------------------------------------")
 . D MES^XPDUTL("You may wish to reprint the Voucher Summary reports") D MES^XPDUTL("starting with "_$$FMTE^XLFDT($E(ENFAPDT,1,5)_"00")_" since adjustments have been made.")
 D ^ENXOIPS1
 D BMES^XPDUTL("Completed Post-Init.")
EXIT ;
 K ^TMP($J)
 K ENC,ENDA,ENDT,ENFAPDT,ENFAT,ENFATT,ENFILE,ENFND,ENFNDN,ENI
 K ENSGL,ENSN,ENSTN,ENTRC,ENTRN,ENVAL
 Q
DOC2 ; FA document
 S ENTRC="FA"
 S ENTRN=$E($$GET1^DIQ(ENFILE,ENI,10),1,9)
 S ENSN=$E($$GET1^DIQ(ENFILE,ENI,24),1,5)
 S ENFND=$$GET1^DIQ(ENFILE,ENI,29)
 S ENFAT=$$GET1^DIQ(ENFILE,ENI,25)
 S ENVAL=$$GET1^DIQ(ENFILE,ENI,53)
 S (ENVAL("FA"),ENVAL("IFA"))=ENVAL,ENVAL("FB")=0 ; reset values
 Q
DOC3 ; FB document
 S ENTRC="FB "_$$GET1^DIQ(ENFILE,ENI,23)
 S ENTRN=$E($$GET1^DIQ(ENFILE,ENI,10),1,9)
 S ENSN=$E($$GET1^DIQ(ENFILE,ENI,21),1,5)
 S ENFAT=$$GET1^DIQ(ENFILE,ENI,22)
 S ENVAL=$$GET1^DIQ(ENFILE,ENI,36)
 S ENVAL("FB")=ENVAL("FB")+ENVAL ; increment FB value
 Q
DOC4 ; FC document
 S ENTRC="FC "_$$GET1^DIQ(ENFILE,ENI,27)
 S ENTRN=$E($$GET1^DIQ(ENFILE,ENI,10),1,9)
 S ENSN=$E($$GET1^DIQ(ENFILE,ENI,25),1,5)
 S ENFAT=$$GET1^DIQ(ENFILE,ENI,26)
 S ENVAL=$$GET1^DIQ(ENFILE,ENI,54)
 ; adjust value
 I ENTRC["00",ENVAL]"" D
 . I ENVAL S ENVAL("IFA")=ENVAL-ENVAL("FA")+ENVAL("IFA")
 . S ENVAL("FA")=ENVAL
 I ENTRC'["00",ENVAL]"" S ENVAL("FB")=ENVAL("FB")+(ENVAL-$$GET1^DIQ(ENFILE,ENI,103))
 Q
DOC5 ; FD document
 S ENTRC="FD "_$$GET1^DIQ(ENFILE,ENI,100,"I")
 S ENTRN=$E($$GET1^DIQ(ENFILE,ENI,10),1,9)
 S ENSN=$E($$GET1^DIQ(ENFILE,ENI,27),1,5)
 S ENFAT=$$GET1^DIQ(ENFILE,ENI,28)
 S ENVAL=""
 S ENVAL("FD")=$$GET1^DIQ(ENFILE,ENI,101) ; asset value at time of FD
 S ENVAL("CO")=$$DEC^ENFAUTL(ENVAL("FA")+ENVAL("FB")) ; correct value
 I ENVAL("CO")'=ENVAL("FD") D
 . D BMES^XPDUTL("  FD-"_ENTRN_" asset value incorrectly recorded as "_ENVAL("FD"))
 . D MES^XPDUTL("    Correct value calculated as "_ENVAL("CO"))
 . D MES^XPDUTL("    Updating document log for FD-"_ENTRN_"...")
 . S DR="101///^S X=ENVAL(""CO"")",DIE="^ENG(6915.5,",DA=ENI D ^DIE
 . I ENDT<ENFAPDT S ENFAPDT=ENDT ; save earliest date of a corrected doc
 . ; adjust balance
 . S ENVAL("DIF")=ENVAL("CO")-ENVAL("FD")
 . S ENVAL("DIF")=-ENVAL("DIF") ; FD deletes value
 . D:ENVAL("DIF") ADJBAL
 Q
DOC6 ; FR document
 S ENTRC="FR"
 S ENTRN=$E($$GET1^DIQ(ENFILE,ENI,10),1,9)
 S ENSN=$E($$GET1^DIQ(ENFILE,ENI,24),1,5)
 S ENFNDN=$$GET1^DIQ(ENFILE,ENI,28) ; new fund
 S ENFAT=$$GET1^DIQ(ENFILE,ENI,25)
 S ENVAL=""
 S ENVAL("FR")=$$GET1^DIQ(ENFILE,ENI,107)
 S ENVAL("CO")=$$DEC^ENFAUTL(ENVAL("FA")+ENVAL("FB"))
 I ENVAL("CO")'=ENVAL("FR") D
 . D BMES^XPDUTL("  FR-"_ENTRN_" asset value incorrectly recorded as "_ENVAL("FR"))
 . D MES^XPDUTL("    Correct value calculated as "_ENVAL("CO"))
 . D MES^XPDUTL("    Updating document log for FR-"_ENTRN_"...")
 . I ENDT<ENFAPDT S ENFAPDT=ENDT ; save earliest date of a corrected doc
 . S DR="107///^S X=ENVAL(""CO"")",DIE="^ENG(6915.6,",DA=ENI D ^DIE
 . S ENVAL("DIF")=ENVAL("CO")-ENVAL("FR")
 . I ENFNDN]"",ENFND'=ENFNDN,ENVAL("DIF") D
 . . D MES^XPDUTL("    Since this FR Document changed the FUND from "_ENFND_" to "_ENFNDN)
 . . D MES^XPDUTL("    the $ balance will need to be adjusted.")
 . . ; apply negative difference (ENVAL("DIF")) to the old fund
 . . S ENVAL("DIF")=-ENVAL("DIF")
 . . D ADJBAL
 . . ; update fund for asset
 . . S ENFND=ENFNDN
 . . ; apply positive difference (ENVAL("DIF")) to the new fund
 . . S ENVAL("DIF")=-ENVAL("DIF")
 . . D ADJBAL
 Q
ADJBAL ; Adjust Balance
 ; Input Variables
 ; ENSN  - 5 character station number (may be padded)
 ; ENFND - Fund
 ; ENFAT - FA Type
 ; ENDT  - data/time
 ; ENVAL("DIF") - amount to adjust
 S ENSTN=$TR(ENSN," ","")
 S ENSGL("I")=$O(^ENG(6914.3,"B",ENFATT(ENFAT),0))
 S ENFND("I")=$O(^ENG(6914.6,"B",ENFND,0))
 D MES^XPDUTL("    Applying difference ("_ENVAL("DIF")_") to $ balance of SGL...")
 D MES^XPDUTL("      Adjusting Station: "_ENSTN_"  FUND: "_ENFND_"  SGL: "_ENFATT(ENFAT)_" from "_$$FMTE^XLFDT($E(ENDT,1,5)_"00")_"  by $"_$FN(ENVAL("DIF"),",",2))
 D ADJBAL^ENFABAL(ENSTN,ENFND("I"),ENSGL("I"),$P(ENDT,"."),ENVAL("DIF"))
 Q
 ;ENXOIPS
