PSS192PO ; ALB/ESG - ePharmacy Compliance Phase 3 PSS patch post install ;10/9/2015
 ;;1.0;PHARMACY DATA MANAGEMENT;**192**;9/30/97;Build 25
 ;
 D BMES^XPDUTL("Starting post-install for PSS*1*192 ... ")
 D DRUGS
 D MES^XPDUTL("Finished with post-install for PSS*1*192.")
 Q
 ;
DRUGS ; loop through DRUG file and make changes
 ;
 ; Examine all drugs and build a scratch global:
 ;   ^TMP(RTN,$J,1,DRUGNAME,DRUGIEN) = OLD DEA ^ NEW DEA ^ CHARACTERS REMOVED
 ;   ^TMP(RTN,$J,2,DRUGNAME,DRUGIEN) = ""    <---  For drugs with BLANK DEA fields
 ;   ^TMP(RTN,$J,3,DRUGIEN)=""               <---  For Billable Drugs
 ;   ^TMP(RTN,$J,4,DRUGIEN)=""               <---  For Non-Billable Drugs
 ;   ^TMP(RTN,$J,5,DRUGIEN)=""               <---  For Sensitive Diagnosis Drugs
 ;
 D MES^XPDUTL("   Examining all Drugs in the Drug file (#50) ... ")
 ;
 N RTN,DRGIEN,DRUGNM,OLDDEA,NEWDEA,STOP,G,EPHBL
 S RTN="PSS192PO"
 K ^TMP(RTN,$J)
 ;
 ; check the drug file data to see if this patch post-install has already been run
 S STOP=0
 S DRGIEN=0 F G=1:1:100 S DRGIEN=$O(^PSDRUG(DRGIEN)) Q:'DRGIEN  D  Q:STOP
 . S EPHBL=$P($G(^PSDRUG(DRGIEN,"EPH")),U,4)
 . I EPHBL'="" S STOP=1 Q      ; already been run, get out
 . Q
 I STOP D MES^XPDUTL("      Patch post-install has already been run. No Changes Made.") G DRGX
 ;
 S DRGIEN=0 F  S DRGIEN=$O(^PSDRUG(DRGIEN)) Q:'DRGIEN  D
 . S DRUGNM=$P($G(^PSDRUG(DRGIEN,0)),U,1) S:DRUGNM="" DRUGNM="~missing drug name"
 . S OLDDEA=$$TRIM^XLFSTR($P($G(^PSDRUG(DRGIEN,0)),U,3))
 . ;
 . ; check for missing DEA, SPECIAL HDLG field
 . I OLDDEA="" D  Q
 .. S ^TMP(RTN,$J,2,DRUGNM,DRGIEN)=""  ; save in scratch for later display
 .. S ^TMP(RTN,$J,4,DRGIEN)=""         ; save drug in non-billable list
 .. Q
 . ;
 . ; Do this block of code for billable/non-billable determination for each drug
 . D
 .. ; Contains M or 0:  Non-Billable
 .. I OLDDEA["M"!(OLDDEA["0") S ^TMP(RTN,$J,4,DRGIEN)="" Q
 .. ;
 .. ; Contains any of these and does not contain "E":  Non-Billable
 .. I (OLDDEA["I"!(OLDDEA["S")!(OLDDEA["9"))!(OLDDEA["N"),OLDDEA'["E" S ^TMP(RTN,$J,4,DRGIEN)="" Q
 .. ;
 .. ; otherwise, drug is billable
 .. S ^TMP(RTN,$J,3,DRGIEN)=""
 .. Q
 . ;
 . ; now work on removing the "E" and the "U" characters
 . I OLDDEA["E",OLDDEA["U" D DEA("EU")     ; DEA indicates both billable and sensitive dx
 . I OLDDEA["E",OLDDEA'["U" D DEA("E")     ; DEA indicates billable only
 . I OLDDEA'["E",OLDDEA["U" D DEA("U")     ; DEA indicates sensitive dx only
 . Q
 ;
 ; Now loop through the Scratch global areas and make changes to the database
 D MES^XPDUTL("   Updating the values of the DEA, SPECIAL HDLG field ... ")
 S DRUGNM="" F  S DRUGNM=$O(^TMP(RTN,$J,1,DRUGNM)) Q:DRUGNM=""  S DRGIEN=0 F  S DRGIEN=$O(^TMP(RTN,$J,1,DRUGNM,DRGIEN)) Q:'DRGIEN  D
 . N DIE,DA,DR
 . S NEWDEA=$P($G(^TMP(RTN,$J,1,DRUGNM,DRGIEN)),U,2) S:NEWDEA="" NEWDEA="@"
 . S DIE=50,DA=DRGIEN,DR="3////"_NEWDEA D ^DIE
 . Q
 ;
 D MES^XPDUTL("   Updating the values of the ePharmacy Billable field ... ")
 ; Billable area
 S DRGIEN=0 F  S DRGIEN=$O(^TMP(RTN,$J,3,DRGIEN)) Q:'DRGIEN  D
 . N DIE,DA,DR
 . S DIE=50,DA=DRGIEN,DR="84////1" D ^DIE     ; billable
 ;
 ; Non-Billable area
 S DRGIEN=0 F  S DRGIEN=$O(^TMP(RTN,$J,4,DRGIEN)) Q:'DRGIEN  D
 . N DIE,DA,DR
 . S DIE=50,DA=DRGIEN,DR="84////0" D ^DIE     ; non-billable
 . Q
 ;
 D MES^XPDUTL("   Updating the values of the Sensitive Diagnosis Drug field ... ")
 S DRGIEN=0 F  S DRGIEN=$O(^TMP(RTN,$J,5,DRGIEN)) Q:'DRGIEN  D
 . N DIE,DA,DR
 . S DIE=50,DA=DRGIEN,DR="87////1" D ^DIE     ; sensitive diagnosis drug
 . Q
 ;
 D MES^XPDUTL("   Generating and sending the ePharmacy Drug File Changes report ... ")
 D EMAIL
 ;
DRGX ;
 D MES^XPDUTL("   Done with ePharmacy Drug File Changes.")
 K ^TMP(RTN,$J)
 Q
 ;
DEA(CHAR) ; remove characters from DEA and save new DEA and drug action to be taken
 S NEWDEA=$TR(OLDDEA,CHAR)                                  ; remove characters from DEA value
 S ^TMP(RTN,$J,1,DRUGNM,DRGIEN)=OLDDEA_U_NEWDEA_U_CHAR      ; save drug for DEA changes
 I CHAR["U" S ^TMP(RTN,$J,5,DRGIEN)=""                      ; add drug to sensitive dx list if "U"
 I NEWDEA="" S ^TMP(RTN,$J,2,DRUGNM,DRGIEN)=""              ; if the new DEA field is now blank, save it for display
 Q
 ;
EMAIL ; send email when patch is installed and this post-install message is run
 N SUBJ,MSG,XMTO,GLO,GLB,XMINSTR,NOTIF,SITE,G,DEACNT,DRUGNM,DRGIEN,NILCNT,USR
 S SITE=$$SITE^VASITE
 S SUBJ="ePharmacy Drug File Changes: PSS*1*192 #"_$P(SITE,U,3)_" #"_$P(SITE,U,2)
 S SUBJ=$E(SUBJ,1,65)
 S G=0
 S G=G+1,MSG(G)="VistA patch PSS*1*192 was successfully installed at your site."
 S G=G+1,MSG(G)=""
 S G=G+1,MSG(G)="        Name: "_$P(SITE,U,2)
 S G=G+1,MSG(G)="    Station#: "_$P(SITE,U,3)
 S G=G+1,MSG(G)="   Date/Time: "_$$FMTE^XLFDT($$NOW^XLFDT,"5ZPM")
 S G=G+1,MSG(G)="          By: "_$P($G(^VA(200,DUZ,0)),U,1)
 S G=G+1,MSG(G)=""
 S G=G+1,MSG(G)="The following entries in your DRUG file (#50) have been modified to remove"
 S G=G+1,MSG(G)="characters ""E"" Electronically Billable and ""U"" Sensitive Diagnosis from the"
 S G=G+1,MSG(G)="DEA, Special Handling field. The functions of both characters have been"
 S G=G+1,MSG(G)="replaced by the following new DRUG file (#50) fields to maintain consistency"
 S G=G+1,MSG(G)="throughout the VA:"
 S G=G+1,MSG(G)=""
 S G=G+1,MSG(G)="     (Field #84)   ePharmacy Billable:"
 S G=G+1,MSG(G)="     (Field #85)     ePharmacy Billable (TRICARE):"
 S G=G+1,MSG(G)="     (Field #86)     ePharmacy Billable (CHAMPVA):"
 S G=G+1,MSG(G)="     (Field #87)   Sensitive Diagnosis Drug:"
 S G=G+1,MSG(G)=""
 S G=G+1,MSG(G)="1.  The ePharmacy Billable field and the Sensitive Diagnosis Drug field have"
 S G=G+1,MSG(G)="    been answered YES or NO based on the data in the DEA, Special Handling"
 S G=G+1,MSG(G)="    field."
 S G=G+1,MSG(G)=""
 S G=G+1,MSG(G)="2.  Drug file entries without the E and U were also marked as ePharmacy"
 S G=G+1,MSG(G)="    Billable Yes or No, depending on the existing DEA, Special Handling field"
 S G=G+1,MSG(G)="    configuration at the time PSS*1*192 was loaded, using the following"
 S G=G+1,MSG(G)="    criteria:"
 S G=G+1,MSG(G)=""
 S G=G+1,MSG(G)="        DEA, Special Handling"
 S G=G+1,MSG(G)="        Field Criteria                      Billable"
 S G=G+1,MSG(G)="        --------------------------------------------"
 S G=G+1,MSG(G)="        Null                                   N"
 S G=G+1,MSG(G)="        Contains ""M"" or ""0"" (Zero)             N"
 S G=G+1,MSG(G)="        Contains ""I"" or ""S"" or ""N"" or ""9"""
 S G=G+1,MSG(G)="           and DOES NOT contain ""E""            N"
 S G=G+1,MSG(G)="        Contains ""I"" or ""S"" or ""N"" or ""9"""
 S G=G+1,MSG(G)="           and DOES contain ""E""                Y"
 S G=G+1,MSG(G)="        All Other Entries                      Y"
 S G=G+1,MSG(G)=""
 S G=G+1,MSG(G)="3.  It is an exception to have a Null DEA, Special Handling field for a Drug"
 S G=G+1,MSG(G)="    file item.  If you have items on this list whose DEA, Special Handling"
 S G=G+1,MSG(G)="    field was null, it is suggested that you populate the DEA, Special Handling"
 S G=G+1,MSG(G)="    field and mark those items as billable, if appropriate."
 S G=G+1,MSG(G)=""
 S G=G+1,MSG(G)="    Here is a Legend for the existing DEA, Special Handling field values:"
 S G=G+1,MSG(G)="         0          MANUFACTURED IN PHARMACY"
 S G=G+1,MSG(G)="         1          SCHEDULE 1 ITEM"
 S G=G+1,MSG(G)="         2          SCHEDULE 2 ITEM"
 S G=G+1,MSG(G)="         3          SCHEDULE 3 ITEM"
 S G=G+1,MSG(G)="         4          SCHEDULE 4 ITEM"
 S G=G+1,MSG(G)="         5          SCHEDULE 5 ITEM"
 S G=G+1,MSG(G)="         6          LEGEND ITEM"
 S G=G+1,MSG(G)="         9          OVER-THE-COUNTER"
 S G=G+1,MSG(G)="         L          DEPRESSANTS AND STIMULANTS"
 S G=G+1,MSG(G)="         A          NARCOTICS AND ALCOHOLS"
 S G=G+1,MSG(G)="         P          DATED DRUGS"
 S G=G+1,MSG(G)="         I          INVESTIGATIONAL DRUGS"
 S G=G+1,MSG(G)="         M          BULK COMPOUND ITEMS"
 S G=G+1,MSG(G)="         C          CONTROLLED SUBSTANCES - NON NARCOTIC"
 S G=G+1,MSG(G)="         R          RESTRICTED ITEMS"
 S G=G+1,MSG(G)="         S          SUPPLY ITEMS"
 S G=G+1,MSG(G)="         B          ALLOW REFILL (SCH. 3, 4, 5 ONLY)"
 S G=G+1,MSG(G)="         W          NOT RENEWABLE"
 S G=G+1,MSG(G)="         F          NON REFILLABLE"
 S G=G+1,MSG(G)="         N          NUTRITIONAL SUPPLEMENT"
 S G=G+1,MSG(G)=""
 S G=G+1,MSG(G)=""
 S G=G+1,MSG(G)="-------------------------------------------------------------------------------"
 S G=G+1,MSG(G)="                                             DEA Special Handling Field"
 S G=G+1,MSG(G)="GENERIC NAME                                OLD        NEW       REMOVED"
 S G=G+1,MSG(G)="-------------------------------------------------------------------------------"
 ;
 ; loop through the 1 area of the scratch global and populate the message with the DEA changes
 S DEACNT=0
 S DRUGNM="" F  S DRUGNM=$O(^TMP(RTN,$J,1,DRUGNM)) Q:DRUGNM=""  S DRGIEN=0 F  S DRGIEN=$O(^TMP(RTN,$J,1,DRUGNM,DRGIEN)) Q:'DRGIEN  D
 . N AB
 . S AB=$G(^TMP(RTN,$J,1,DRUGNM,DRGIEN))
 . I $P(AB,U,2)="" S $P(AB,U,2)="-"
 . S G=G+1,MSG(G)=$$LJ^XLFSTR(DRUGNM,44)_$$LJ^XLFSTR($P(AB,U,1),11)_$$LJ^XLFSTR($P(AB,U,2),11)_$P(AB,U,3)
 . S DEACNT=DEACNT+1
 . Q
 ;
 S G=G+1,MSG(G)=""
 S G=G+1,MSG(G)="Total Drugs Modified:  "_DEACNT
 S G=G+1,MSG(G)=""
 S G=G+1,MSG(G)="No other changes were made to the DEA, Special Handling field for any other"
 S G=G+1,MSG(G)="Drug File entries."
 S G=G+1,MSG(G)=""
 S G=G+1,MSG(G)=""
 S G=G+1,MSG(G)="The following drugs do not have any value in the DEA Special Handling Field."
 S G=G+1,MSG(G)=""
 S G=G+1,MSG(G)="----------------------------------------"
 S G=G+1,MSG(G)="GENERIC NAME"
 S G=G+1,MSG(G)="----------------------------------------"
 ;
 ; loop through the 2 area of the scratch global to display drugs with Blank DEA fields
 S NILCNT=0
 S DRUGNM="" F  S DRUGNM=$O(^TMP(RTN,$J,2,DRUGNM)) Q:DRUGNM=""  S DRGIEN=0 F  S DRGIEN=$O(^TMP(RTN,$J,2,DRUGNM,DRGIEN)) Q:'DRGIEN  D
 . S G=G+1,MSG(G)=DRUGNM
 . S NILCNT=NILCNT+1
 . Q
 ;
 S G=G+1,MSG(G)=""
 S G=G+1,MSG(G)="Total Drugs with Blank DEA Special Handling:  "_NILCNT
 S G=G+1,MSG(G)=""
 S G=G+1,MSG(G)=""
 ;
 ; Now we need to address the message
 ;   - send it to holders of the PSO EPHARMACY SITE MANAGER key
 ;   - send it to the installer (DUZ)
 ;   - send it to Gregory Laird in VA Outlook (production only)
 ;   - send it to selected project team members (production only)
 S USR=0 F  S USR=$O(^XUSEC("PSO EPHARMACY SITE MANAGER",USR)) Q:'USR  S XMTO(USR)=""
 S XMTO(DUZ)=""
 I $$PROD^XUPROD(1) D
 . S XMTO("Gregory.Laird@domain.ext")=""
 . S XMTO("Eric.Gustafson@domain.ext")=""
 . S XMTO("lucille.harmon@domain.ext")=""
 . Q
 ;
 S XMINSTR("FROM")="PSS.1.192.POST"
 ;
 D SENDMSG^XMXAPI(DUZ,SUBJ,"MSG",.XMTO,.XMINSTR)
 I '$D(^TMP("XMERR",$J)) G EMAILX    ; no email problems so get out
 ;
 D MES^XPDUTL("MailMan reported a problem trying to send the PSS patch install/Drug File report message.")
 D MES^XPDUTL("  ")
 S (GLO,GLB)="^TMP(""XMERR"","_$J
 S GLO=GLO_")"
 F  S GLO=$Q(@GLO) Q:GLO'[GLB  D MES^XPDUTL("   "_GLO_" = "_$G(@GLO))
 D MES^XPDUTL("  ")
 ;
EMAILX ;
 Q
 ;
