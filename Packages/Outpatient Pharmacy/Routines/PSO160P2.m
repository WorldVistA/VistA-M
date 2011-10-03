PSO160P2 ;BIR/MR-Patch 160 Post Install routine - Part 2 ;11/27/03
 ;;7.0;OUTPATIENT PHARMACY;**160**;DEC 1997
 ;External reference ^SCE( supported by DBIA 402
 ;
EN N DAT,ENC,TODAY,INACT,DIE,DA,DR,CLI,SORT
 ;
 ; - Patient is already TPB Inactive (INACTIVATION OF BENEFIT DATE)
 I PSOTIBD'="" Q
 ;   
 ; - At least one active TPB prescription found, if NOT Quit
 I $$ACTRX^PSOTPCUL(PSOTDFN,1) Q
 ;
 S DAT=PSOTDBG-1,(ENC,INACT)=0 D NOW^%DTC S TODAY=%\1
 F  S DAT=$O(^SCE("ADFN",PSOTDFN,DAT)) Q:'DAT  D  I INACT Q
 . F  S ENC=$O(^SCE("ADFN",PSOTDFN,DAT,ENC)) Q:'ENC  D  I INACT Q
 . . ;
 . . ; - NOT an Appointment
 . . I $$GET1^DIQ(409.68,ENC,.08,"I")'=1 Q
 . . ;
 . . ; - Appointment is not CHECKED OUT
 . . I $$UP^XLFSTR($TR($$GET1^DIQ(409.68,ENC,.12),"- "))'="CHECKEDOUT" Q
 . . ;
 . . ; - STOP CODE for the Encounter Location not TPB
 . . I '$$TPBSC^PSOTPCUL($$GET1^DIQ(409.68,ENC,.04,"I")) Q
 . . ;
 . . ; - Inactivate TPB benefits for the patient
 . . S DIE=52.91,DA=PSOTDFN,DR="2///"_TODAY_";3///1" D ^DIE K DIE,DR,DA
 . . ;
 . . ; - Set ^XTMP("PSO160P2",$J) for the Mailman Message
 . . S CLI=$$GET1^DIQ(409.68,ENC,.04)
 . . ;
 . . ; - Sets ^TMP global for Mailman Message
 . . S SORT=$E(PATNAM,1,23)_"("_PATSSN_")"
 . . S ^XTMP("PSO160P2",$J,"T",SORT)=DAT_"^"_CLI
 . . S INACT=1
 ;
 Q
 ;
MAIL ; Sends Mailman message to PSO TPB GROUP mail group with list of
 ; patients that have been inactivated.
 N DFN,XMTEXT,XMDUZ,XMSUB,DASH,LINE,HDR,XMY,CNT,DASH,DATA,DIFROM,TEXT
 N PNAM
 ;
 S XMDUZ="PATCH PSO*7*160" D SXMY^PSOTPCUL("PSO TPB GROUP")
 S XMY(DUZ)="",XMSUB="PSO*7*160 - LIST OF TPB PATIENTS INACTIVATED"
 ;
 ; Mailman Message - Header
 S $P(DASH,"-",79)="",LINE=0
 D SETLN("The Post-Install process for PSO*7*160 - Part 2 successfully completed.")
 D SETLN(" ")
 D SETLN("Started on: "_$$FMTE^XLFDT($G(^XTMP("PSO160DR",$J,"START"))))
 D SETLN("Finished on: "_$$FMTE^XLFDT($G(^XTMP("PSO160DR",$J,"FINISH"))))
 D SETLN(" ")
 ;
 ;If no entries created above, skip reporting
 I '$D(^XTMP("PSO160P2",$J,"T")) D  G SEND
 . D SETLN("No patients have been inactivated from TPB (Transitional Pharmacy Benefit).")
 ;
 D SETLN("The following patients had their TPB (Transitional Pharmacy Benefit) benefit")
 D SETLN("automatically inactivated because the following appointment was found: ")
 D SETLN(" "),SETLN(DASH)
 S HDR="PATIENT (LAST4SSN)",$E(HDR,31)="APPOINTMENT DATE"
 S $E(HDR,50)="VA CLINIC" D SETLN(HDR),SETLN(DASH)
 ;
 ; Mailman Message - Body
 S PNAM="",CNT=0
 F  S PNAM=$O(^XTMP("PSO160P2",$J,"T",PNAM)) Q:PNAM=""  D
 . S DATA=$G(^XTMP("PSO160P2",$J,"T",PNAM))
 . S TEXT=PNAM,$E(TEXT,31)=$$FMTE^XLFDT($P(DATA,"^"))
 . S $E(TEXT,50)=$E($P(DATA,"^",2),1,30)
 . D SETLN(TEXT) S CNT=CNT+1
 ;
 ; Mailman Messae - Footer
 D SETLN(" "),SETLN("Total: "_CNT_" Patient(s)")
 ;
SEND ; - Calls ^XMD to send the message
 S XMTEXT="^XTMP(""PSO160P2"",$J,""M""," D ^XMD
 K ^XTMP("PSO160P2",$J,"M")
 Q
 ;
SETLN(TXT)   ; Sets a line in the XTMP global for the Mailman Message
 S LINE=$G(LINE)+1
 S ^XTMP("PSO160P2",$J,"M",LINE)=TXT
 Q
