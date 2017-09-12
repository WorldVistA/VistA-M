PSS189PI ;BHAM-ISC/MFR - Post-install Routine for Patch PSS*1*189 ;07/26/06
 ;;1.0;PHARMACY DATA MANAGEMENT;**189**;9/30/97;Build 54
 ;
 ;Reference to ^PS(52.6 supported by DBIA #6338
 ;Reference to ^PS(52.7 supported by DBIA #6339
 ;
EN ; Environemnt Check Routine Entry Point
 N MSGBODY
 K ^TMP("PSS189PI",$J)
 D UPDATE
 D MSG(.MSGBODY)
 I $O(^TMP("PSS189PI",$J,0)) D MAIL(.MSGBODY)
 K ^TMP("PSS189PI",$J)
 ;
 ;Set up identifier for 52.6 field 12
 ;Set up identifier for 52.7 field 8
 N TXT
 S TXT="W:$G(^(""I"")) ""   "",$E($P(^(""I""),U,1),4,5)_""-""_$E($P(^(""I""),U,1),6,7)_""-""_$E($P(^(""I""),U,1),2,3)"
 S ^DD(52.6,0,"ID",12)=TXT ;IV Additives
 S ^DD(52.7,0,"ID",8)=TXT  ;IV Solutions
 Q
 ;
UPDATE ; Updating the USED IN IV FLUID ORDER ENTRY field (Setting to 'NO' for no longer IV Solutions)
 N OI,IVSOL,IVVOL,IVDRUG,OIINADT,DRGINADT,IVINADT
 S IVSOL=0
 F  S IVSOL=$O(^PS(52.7,IVSOL)) Q:'IVSOL  D
 . ; Not used in the IV Dialog
 . I '$$GET1^DIQ(52.7,IVSOL,17,"I") Q
 . ; Pharmacy Orderable Item
 . S OI=+$$GET1^DIQ(52.7,IVSOL,9,"I") I 'OI Q
 . ; IV Dispense Drug
 . S IVDRUG=$$GET1^DIQ(52.7,IVSOL,1,"I") I 'IVDRUG Q
 . ; IV Solution IVVOL
 . S IVVOL=$$GET1^DIQ(52.7,IVSOL,2) I IVVOL="" Q
 . ; At least one of IV Solution OR Orderable Item OR Dispense Drug is INACTIVE
 . S OIINADT=$$GET1^DIQ(50.7,OI,.04,"I"),DRGINADT=$$GET1^DIQ(50,IVDRUG,100,"I"),IVINADT=$$GET1^DIQ(52.7,IVSOL,8,"I")
 . I (OIINADT&(OIINADT<DT))!(DRGINADT&(DRGINADT<DT))!(IVINADT&(IVINADT<DT)) D  Q
 . . ; Setting USED IN THE IV FLUID ORDER ENTRY field to 'NO'
 . . S $P(^PS(52.7,IVSOL,0),"^",13)=0
 . . S ^TMP("PSS189PI",$J,OI,IVDRUG,IVSOL)=IVVOL
 Q
 ;
DUPSOL(OI,IVSOL,IVVOL,SKPIN) ; Check if there's a Duplicate IV Solution Marked to be Used in the IV Order Dialog
 ;  Input: OI    - PHARMACY ORDERABLE ITEM (#50.7) Pointer
 ;         IVSOL - IV SOLUTIONS (#52.7) Pointer
 ;         IVVOL - IV Solution Volume
 ;         SKPIN - Skip Inactive? (1/0)
 ;Output: DUPSOL - Duplicate IV SOLUTION (#52.7) Pointer (if any)
 ;
 N DUPSOL,OTHSOL,OTHVOL,OTHDRUG
 S (DUPSOL,OTHSOL)=0
 F  S OTHSOL=$O(^PS(52.7,"AOI",OI,OTHSOL)) Q:'OTHSOL!DUPSOL  D
 . ; Cannot check against itself
 . I (IVSOL=OTHSOL) Q
 . ; Not Used in the IV Order Dialog
 . I '$$GET1^DIQ(52.7,OTHSOL,17,"I") Q
 . ; Other IV Solution is INACTIVE
 . I SKPIN,$$GET1^DIQ(52.7,OTHSOL,8,"I"),$$GET1^DIQ(52.7,OTHSOL,8,"I")'>DT Q
 . ; Other IV Dispense Drug
 . S OTHDRUG=$$GET1^DIQ(52.7,OTHSOL,1,"I")
 . ; Other Dispense Drug is INACTIVE
 . I SKPIN,$$GET1^DIQ(50,OTHDRUG,100,"I"),$$GET1^DIQ(50,OTHDRUG,100,"I")'>DT Q
 . ; IV Solution Volume
 . S OTHVOL=$$GET1^DIQ(52.7,OTHSOL,2)
 . ; IV Solutions have different volumes
 . I (IVVOL'=OTHVOL) Q
 . ; Capturing the IV Solutions with issues
 . S DUPSOL=OTHSOL
 Q DUPSOL
 ;
MSG(MSGBODY) ; Creating the Mailman Message body
 N LN,OI,IVDRUG,IVSOL,DUPVOL
 D ADDLINE(.MSGBODY,"The list below shows IV Solutions in your database that had the field")
 D ADDLINE(.MSGBODY,"USED IN IV FLUID ORDER ENTRY set to 'NO' because either the Orderable")
 D ADDLINE(.MSGBODY,"Item, the Dispense Drug or the IV Solution itself was marked INACTIVE.")
 D ADDLINE(.MSGBODY,"")
 ;
 D ADDLINE(.MSGBODY,"Run Date/Time: "_$$FMTE^XLFDT($$NOW^XLFDT))
 S $P(LN,"-",80)="" D ADDLINE(.MSGBODY,LN)
 D ADDLINE(.MSGBODY,"ORDERABLE ITEM (IEN)")
 S LN="   IV DISPENSE DRUG (IEN)" D ADDLINE(.MSGBODY,LN)
 S LN="      IV SOLUTION (IEN/VOLUME)" D ADDLINE(.MSGBODY,LN)
 S LN="",$P(LN,"-",80)="" D ADDLINE(.MSGBODY,LN)
 ;
 S (OI,IVDRUG,IVSOL)=""
 F  S OI=$O(^TMP("PSS189PI",$J,OI)) Q:'OI  D
 . D ADDLINE(.MSGBODY,$$GET1^DIQ(50.7,OI,.01)_" ("_OI_")"_$S($$GET1^DIQ(50.7,OI,.04,"I"):"   *** INACTIVE DATE: "_$$GET1^DIQ(50.7,OI,.04)_" ***",1:""))
 . F  S IVDRUG=$O(^TMP("PSS189PI",$J,OI,IVDRUG)) Q:'IVDRUG  D
 . . S LN="   "_$$GET1^DIQ(50,+IVDRUG,.01)_" ("_+IVDRUG_")"_$S($$GET1^DIQ(50,IVDRUG,100,"I"):"   *** INACTIVE DATE: "_$$GET1^DIQ(50,IVDRUG,100)_" ***",1:"")
 . . D ADDLINE(.MSGBODY,LN)
 . . F  S IVSOL=$O(^TMP("PSS189PI",$J,OI,IVDRUG,IVSOL)) Q:'IVSOL  D
 . . . S DUPVOL=^TMP("PSS189PI",$J,OI,IVDRUG,IVSOL)
 . . . S LN="      "_$$GET1^DIQ(52.7,+IVSOL,.01)_" ("_+IVSOL_"/"_DUPVOL_")"_$S($$GET1^DIQ(52.7,IVSOL,8,"I"):"   *** INACTIVE DATE: "_$$GET1^DIQ(52.7,IVSOL,8)_" ***",1:"")
 . . . D ADDLINE(.MSGBODY,LN)
 . D ADDLINE(.MSGBODY,"")
 Q
 ;
MAIL(MSGTEXT) ; Compose/Send the Mailman message
 N XMDUZ,XMSUB,XMY,XMTEXT,RECPT,SECKEY,DIFROM
 S XMDUZ="Patch PSS*1*189",XMSUB="Auto-update of the IV Solution file"
 ;
 ; Sending the message to the holders of the PSIVMGR, PSJI MGR and PSNMGR security key + Patch installer
 F SECKEY="PSIVMGR","PSJI MGR","PSNMGR" D
 . S RECPT=0 F  S RECPT=$O(^XUSEC(SECKEY,RECPT)) Q:'RECPT  S XMY(RECPT)=""
 S XMY(DUZ)=""
 S XMTEXT="MSGTEXT(" D ^XMD
 Q
 ;
ADDLINE(MSG,TXT) ; Adds a line to the Mailman Message Text
 N LINE
 S LINE=$O(MSG(99999),-1)+1,MSG(LINE)=TXT
 Q
