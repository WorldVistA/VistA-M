PSO770PI ;BHAM/MFR - PSO*7*770 POST-INSTALL; 09/12/2024 11:24Am
 ;;7.0;OUTPATIENT PHARMACY;**770**;DEC 1997;Build 145
 ;
EN ; Entry Point
 N PSOROOT,MBMSITE,DIK,X,NEWC,NEWCODE,FDASCR,SCRIEN,PSOERR,TEXT1,TEXT2,II,DA,CODEIEN,CODEDESC,PROTCL,RPROTCL,REMCODE,DIC,DIE,DA
 D BMES^XPDUTL("Starting post-install for PSO*7*770 at "_$$FMTE^XLFDT($$NOW^XLFDT()))
 ;
 ; Fixing an issue caused by KIDS Build Installation
 S RPROTCL=$O(^ORD(101,"B","PSO ERX RESEND CHANGE REQUEST",0))
 S PROTCL=0 F  S PROTCL=$O(^ORD(101,PROTCL)) Q:'PROTCL  D
 . I '$D(^ORD(101,PROTCL,10,"B",RPROTCL)) Q
 . S SUBIEN=$O(^ORD(101,PROTCL,10,"B",RPROTCL,0)) I 'SUBIEN Q
 . I $$GET1^DIQ(101,PROTCL,.01)="PSO ERX HIDDEN ACTIONS" Q
 . K DIK S DIK="^ORD(101,"_PROTCL_",10,",DA(1)=PROTCL,DA=SUBIEN D ^DIK
 ;
 ; Renaming CAP code
 S CODEIEN=$O(^PS(52.45,"B","CAP",0))
 I CODEIEN D
 . S DIE="^PS(52.45,",DA=CODEIEN,DR=".02///UNABLE TO FIND ORIGINAL ERX" D ^DIE
 ;
 ; New Remove Codes
 F REMCODE="REM81","REM82","REM83" D
 . I $D(^PS(52.45,"B",REMCODE)) Q
 . K DIC S DIC="^PS(52.45,",DIC(0)="",X=REMCODE
 . I REMCODE="REM81" S DIC("DR")=".02///Prior Authorization Denied;.03///REM"
 . I REMCODE="REM82" S DIC("DR")=".02///No Community Care Authorization for this Prescription;.03///REM"
 . I REMCODE="REM83" S DIC("DR")=".02///Patient Not Found in Local VA Database;.03///REM"
 . D FILE^DICN
 ;
 ; Scheduling new DEA/DOJ Nightly Data Update Job
 D BMES^XPDUTL("Scheduling PSO DEA/DOJ NIGHTLY DATA UPDATE Job... "_$$FMTE^XLFDT($$NOW^XLFDT()))
 D OPTSTAT^XUTMOPT("PSO DEA/DOJ NIGHTLY DATA UPD",.PSOROOT)
 I '+$G(PSOROOT(1)) D RESCH^XUTMOPT("PSO DEA/DOJ NIGHTLY DATA UPD",$$FMADD^XLFDT(DT,1)+.02,"","24H","L")
 ;
 S MBMSITE=$S($$GET1^DIQ(59.7,1,102,"I")="MBM":1,1:0)
 ; Building "AVDRG" x-reference for the VistA Drug Name Search in Rx Medication Screen Search Queue(SQ)
 I '$D(^PS(52.49,"AVDRG")) D
 . D BMES^XPDUTL("Building VistA Drug x-reference... "_$$FMTE^XLFDT($$NOW^XLFDT()))
 . S DIK="^PS(52.49,",DIK(1)="3.2^AVDRG" D ENALL^DIK
 ;
 ; Killing (resetting) New Codes
 F II=1:1 S NEWC=$T(NEWCODES+II) Q:NEWC["END"  D
 . K NEWCODE S NEWCODE=$P(NEWC,";;",2),DIK="^PS(52.45,"
 . I $D(^PS(52.45,"B",$P(NEWCODE,"^",1))) S DA=$O(^PS(52.45,"B",$P(NEWCODE,"^",1),0)) I DA D ^DIK
 ;
 ; Adding new Codes
 F II=1:1 S NEWC=$T(NEWCODES+II) Q:NEWC["END"  D
 . K NEWCODE S NEWCODE=$P(NEWC,";;",2)
 . I '$D(^PS(52.45,"B",$P(NEWCODE,"^",1))) D
 . . K FDASCR
 . . S FDASCR(52.45,"+1,",.01)=$P(NEWCODE,"^",1)
 . . S FDASCR(52.45,"+1,",.02)=$P(NEWCODE,"^",2)
 . . S FDASCR(52.45,"+1,",.03)=$P(NEWCODE,"^",3)
 . . S FDASCR(52.45,"+1,",.04)=$S($P(NEWCODE,"^",2)="SCR":"SCRIPT CLARIFICATION REASON",1:"THERAPEUTIC INTERCHANGE/SUBSTITUTION REASON")
 . . D NEWTXTS($P(NEWCODE,"^",1),.FDASCR)
 . . K PSOERR,SCRIEN D UPDATE^DIE(,"FDASCR","SCRIEN","PSOERR")
 . . K FDASCR
 ;
 I 'MBMSITE D
 . F NEWCODE="PS","OS","P" D
 . . S CODEDESC=$S(NEWCODE="P":"Prior Authorization Required",NEWCODE="PS":"Product Selection Opportunity",1:"Out of Stock")
 . . S CODEIEN=$O(^PS(52.45,"D",CODEDESC,0)) I 'CODEIEN Q
 . . K FDASCR,PSOERR D NEWTXTS(NEWCODE,.FDASCR,CODEIEN) I '$D(FDASCR) Q
 . . K PSOERR,SCRIEN D UPDATE^DIE(,"FDASCR","SCRIEN","PSOERR")
 ;
 ; Update the FULL DESCRIPTION field for the following eRx Service Reason Codes (D, G, OS, P, S, T, and U)
 D UPDTESRC
 ; 
 ;create the new TIU NOTE title for Dispense Drug Replacement
 D CREATEPN("PHARMACY SERVICE","PHARMACY PROGRESS NOTE","PHARMACY RX DRUG REPLACEMENT") ;create new eRx Progress Notes Title in File #8925.1
 ;
 D BMES^XPDUTL("Post-install for PSO*7*770 completed successfully at "_$$FMTE^XLFDT($$NOW^XLFDT()))
 Q
 ;
NEWTXTS(SCRC,FDASCR,CODEIEN) ;
 Q:$G(SCRC)=""
 N SCRCODE,FOUND
 S SCRCODE=$P(SCRC,"^",1),FOUND=0
 K TEXT1 ;Full Description field #20
 K TEXT2 ;Change Request Reason Text field #21
 I SCRCODE="PRN" D
 . S TEXT1(1,0)="Indicates that the prescription received is missing dose and/or frequency"
 . S TEXT1(2,0)="guidelines."
 . S TEXT2(1,0)="VA policy prohibits filling prescriptions with only ""AS NEEDED"" for"
 . S TEXT2(2,0)="directions. Please indicate frequency of administration."
 . S FOUND=1
 ;
 I SCRCODE="UDD" D
 . S TEXT1(1,0)="Indicates that the prescription received is missing dose and/or frequency"
 . S TEXT1(2,0)="guidelines."
 . S TEXT2(1,0)="VA policy prohibits filling prescriptions with only ""AS DIRECTED"""
 . S TEXT2(2,0)="directions. Please indicate frequency of administration."
 . S FOUND=1
 ;
 I SCRCODE="COD" D
 . S TEXT1(1,0)="Indicates that the prescription received has conflicting directions."
 . S TEXT2(1,0)="This prescription contains conflicting directions. Please verify which"
 . S TEXT2(2,0)="directions are to be followed."
 . S FOUND=1
 ;
 I SCRCODE="MSD" D
 . S TEXT1(1,0)="Indicates that the prescription received has incomplete directions for use."
 . S TEXT2(1,0)="Please provide the complete set of patient instructions."
 . S FOUND=1
 ;
 I SCRCODE="RIJ" D
 . S TEXT1(1,0)="Indicates that the prescription received is missing the route of injection"
 . S TEXT1(2,0)="for medication."
 . S TEXT2(1,0)="Please verify the ROUTE of injection."
 . S FOUND=1
 ;
 I SCRCODE="VEF" D
 . S TEXT1(1,0)="Indicates that the prescription received is missing the formulation of"
 . S TEXT1(2,0)="medication to dispense."
 . S TEXT2(1,0)="Please verify which formulation should be dispensed."
 . S FOUND=1
 ;
 I SCRCODE="VLQ" D
 . S TEXT1(1,0)="Indicates the prescription received has a written quantity that is less"
 . S TEXT1(2,0)="than typical prescribing."
 . S TEXT2(1,0)="The quantity written is less than typically prescribed. Please verify the"
 . S TEXT2(2,0)="quantity to dispense."
 . S FOUND=1
 ;
 I SCRCODE="VPQ" D
 . S TEXT1(1,0)="Indicates the prescription received has a written quantity that is less"
 . S TEXT1(2,0)="than smallest available quantity to dispense from the pharmacy."
 . S TEXT2(1,0)="Please verify the quantity to dispense. Our filling sites are only able to"
 . S TEXT2(2,0)="provide this product in quantities of [QUANTITY], which is more than the"
 . S TEXT2(3,0)="total quantity prescribed."
 . S FOUND=1
 ;
 I SCRCODE="AUT" D
 . S TEXT1(1,0)="Indicates the Prescriber is not authorized by VA to see this patient."
 . S TEXT2(1,0)="VA records show this patient does not have active authorization for care"
 . S TEXT2(2,0)="from your office. This prescription will be removed from the VA system."
 . S TEXT2(3,0)="For authorization questions, patients or providers can call the VA Office"
 . S TEXT2(4,0)="of Community Care at [PHONE_NUMBER]."
 . S FOUND=1
 ;
 I SCRCODE="PS" D
 . S TEXT2(1,0)="Pharmacy is unable to provide this medication. Please approve an option"
 . S TEXT2(2,0)=" below or cancel rx."
 . S TEXT2(3,0)="VA Formulary:  https://www.domain.ext/formularyadvisor/"
 . S FOUND=1
 ;
 I SCRCODE="OS" D
 . S TEXT2(1,0)="The medication prescribed is currently out of stock. Please submit"
 . S TEXT2(2,0)="a new Rx from the option(s) below."
 . S TEXT2(3,0)="VA Formulary:  https://www.domain.ext/formularyadvisor/"
 . S FOUND=1
 ;
 I SCRCODE="P" D
 . S TEXT2(1,0)="This product requires a prior authorization. Please call the VA Pharmacy"
 . S TEXT2(2,0)="at [PHONE_NUMBER] to discuss."
 . S TEXT2(3,0)="VA Formulary:  https://www.domain.ext/formularyadvisor/"
 . S FOUND=1
 ;
 I SCRCODE="FMC" D
 . S TEXT1(1,0)="Indicates Pharmacy is unable to supply medication as prescribed."
 . S TEXT2(1,0)="Pharmacy is unable to supply medication as prescribed; however, alternative"
 . S TEXT2(2,0)="options may exist. Please approve an option below or Cancel Rx and send a"
 . S TEXT2(3,0)="replacement."
 . S FOUND=1
 ;
 I SCRCODE="DSC" D
 . S TEXT1(1,0)="Indicates a change in the days supply for the medication prescribed."
 . S TEXT2(1,0)="Pharmacy would like to dispense this medication for 90 days of supply"
 . S TEXT2(2,0)="instead 30 days. Please approve the 90-days option below or Cancel Rx and"
 . S TEXT2(3,0)="send a replacement."
 . S FOUND=1
 ;
 I FOUND D
 . S:$D(TEXT1) FDASCR(52.45,"+1,",1)="TEXT1"
 . S:$D(TEXT2) FDASCR(52.45,$S($G(CODEIEN):CODEIEN,1:"+1")_",",20)="TEXT2"
 Q
 ;
NEWCODES ; List of new Codes for file #52.45
 ;;PRN^PRN Directions^SCR
 ;;UDD^As Directed Directions^SCR
 ;;COD^Conflicting Directions^SCR
 ;;MSD^Missing Directions^SCR
 ;;RIJ^Route of Injection^SCR
 ;;VEF^Verify Formulation^SCR
 ;;VLQ^Verify Low Quantity^SCR
 ;;VPQ^Verify Package Quantity^SCR
 ;;AUT^Prescriber Not Authorized^SCR
 ;;DSC^Days Supply Change^TIS
 ;;FMC^Formulary Change^TIS
 ;;END
 Q
 ;
UPDTESRC ;Update ERX SERVICE REASON CODES
 S CODE=$O(^PS(52.45,"D","DUE (Drug Use Evaluation) ",0))
 I CODE D
 . K ^PS(52.45,CODE,1)
 . K TEXT,REATXT
 . S TEXT(1,0)="May be used to request a prescriber authorize a change to the patient's"
 . S TEXT(2,0)="current medication therapy, such as a dosing regimen or an alternative"
 . S TEXT(3,0)="medication that will have fewer, or no, adverse effects than the original"
 . S TEXT(4,0)="prescription."
 . S REATXT(52.45,CODE_",",1)="TEXT"
 . K DIERR D UPDATE^DIE("","REATXT")
 ;
 S CODE=$O(^PS(52.45,"D","Generic Substitution",0))
 I CODE D
 . K ^PS(52.45,CODE,1)
 . K TEXT,REATXT
 . S TEXT(1,0)="May be used to request a prescriber allow the dispensing of a generic"
 . S TEXT(2,0)="medication when substitution is not allowed by the prescriber or"
 . S TEXT(3,0)="regulations."
 . S REATXT(52.45,CODE_",",1)="TEXT"
 . K DIERR D UPDATE^DIE("","REATXT")
 ;
 S CODE=$O(^PS(52.45,"D","Out of Stock",0))
 I CODE D
 . K ^PS(52.45,CODE,1)
 . K TEXT,REATXT
 . S TEXT(1,0)="May be used to request a prescriber authorize a change to the original"
 . S TEXT(2,0)="prescription due to the pharmacy being out of stock of the requested"
 . S TEXT(3,0)="medication."
 . S REATXT(52.45,CODE_",",1)="TEXT"
 . K DIERR D UPDATE^DIE("","REATXT")
 ;
 S CODE=$O(^PS(52.45,"D","Prior Authorization Required",0))
 I CODE D
 . K ^PS(52.45,CODE,1)
 . K TEXT,REATXT
 . S TEXT(1,0)="May be used to request a prescriber review the drug requested and obtain a"
 . S TEXT(2,0)="prior authorization from the payer for the existing prescription."
 . ;S TEXT(3,0)="   NOTE: The PriorAuthorization RxChangeResponse, unlike the other"
 . ;S TEXT(4,0)="         responses, is not considered a fillable message, cannot"
 . ;S TEXT(5,0)="         be used for medication changes and does not have to be"
 . ;S TEXT(6,0)="         digitally signed."
 . S REATXT(52.45,CODE_",",1)="TEXT"
 . K DIERR D UPDATE^DIE("","REATXT")
 ;
 S CODE=$O(^PS(52.45,"D","Script Clarification",0))
 I CODE D
 . K ^PS(52.45,CODE,1)
 . K TEXT,REATXT
 . S TEXT(1,0)="May be used to request a prescriber clarify the original prescription."
 . S REATXT(52.45,CODE_",",1)="TEXT"
 . K DIERR D UPDATE^DIE("","REATXT")
 ;
 S CODE=$O(^PS(52.45,"D","Therapeutic Interchange/Substi",0))
 I CODE D
 . K ^PS(52.45,CODE,1)
 . K TEXT,REATXT
 . S TEXT(1,0)="May be used to request a prescriber authorize a therapy change to the"
 . S TEXT(2,0)="prescription. This includes the workflow where a pharmacy requests a"
 . S TEXT(3,0)="30-90 day quantity or a formulary change."
 . S REATXT(52.45,CODE_",",1)="TEXT"
 . K DIERR D UPDATE^DIE("","REATXT")
 ;
 S CODE=$O(^PS(52.45,"D","Prescriber Authorization",0))
 I CODE D
 . K ^PS(52.45,CODE,1)
 . K TEXT,REATXT
 . S TEXT(1,0)="May be used to request a prescriber authorization information, such as"
 . S TEXT(2,0)="confirming their DEA number or enrollment with the prescription benefit"
 . S TEXT(3,0)="plan. Denied and Validated are the only acceptable RxChangeResponse types"
 . S TEXT(4,0)="for this workflow. Use the elements in the Validated response type to return"
 . S TEXT(5,0)="the requested information."
 . S REATXT(52.45,CODE_",",1)="TEXT"
 . K DIERR D UPDATE^DIE("","REATXT")
 ;
 S CODE=$O(^PS(52.45,"D","Prescriber must enroll/re-enro",0))
 I CODE D
 . K ^PS(52.45,CODE,1)
 . K TEXT,REATXT
 . S TEXT(1,0)="Expired or no authorization on file with VA. Fax RFS Form (VA 10-10172) to"
 . S TEXT(2,0)="[ADD_TEXT_HERE] to request auth, or send Rx to non-VA pharmacy (not covered"
 . S TEXT(3,0)="by VA). Rx will be cancelled at this time, resend upon approval including"
 . S TEXT(4,0)="authorization #."
 . S REATXT(52.45,CODE_",",1)="TEXT"
 . K DIERR D UPDATE^DIE("","REATXT")
 Q
 ;
CREATEPN(PARNTDOC,STDTITLE,TITLE) ;
 ;Input: PARNTDOC - Name of the desired parent in File #8925.1
 ;       STDTITLE - Name of the VHA Enterprise Standard Title in File #8926.1
 ;       TITLE    - Name of the desired title in File #8925.1
 ;Output: Create a new entry TIU NOTE Title in File #8925.1
 ;
 N FOUNDDOC,FOUNDSTD,MES,RESULT
 ;check parent document class PHARMACY SERVICE
 S FOUNDDOC=$$FIND1^DIC(8925.1,"","X",PARNTDOC,"B")
 ;
 ; check VHA Enterprise Standard Title PHARMACY PROGRESS NOTE
 S FOUNDSTD=$$FIND1^DIC(8926.1,"","X",STDTITLE,"B")
 ;
 S MES(1)=""
 ;if PHARMACY SERVICE and PHARMACY PROGRESS NOTE exist, attach and map the new ERX RX CHANGE REQUEST NOTE TIU Note Title
 I +FOUNDDOC,+FOUNDSTD D  Q
 . S RESULT=$$CRDD^TIUCRDD(TITLE,"DOC","ACTIVE",PARNTDOC,STDTITLE)
 . I '+RESULT D  Q
 . . S MES(2)=$S(RESULT["already exists":$P(RESULT,U,2)_" No action taken.",1:"Installation Error: "_$P(RESULT,U,2))
 . . S MES(3)=""
 . . D MES^XPDUTL(.MES)
 . S MES(2)="Successfully created "_TITLE_" in File #8925.1."
 . S MES(3)=""
 . D MES^XPDUTL(.MES)
 ;
 ;Otherwise, do not attach and map the new ERX RX REQUEST NOTE TIU Note Title
 S MES(2)="Installation Error:"
 S MES(3)="    The creation of the ERX RX CHANGE REQUEST NOTE TIU Title failed."
 ;
 I '+FOUNDDOC,'+FOUNDSTD D  ;both parent doc class and std title does not exist at the site
 . S MES(4)="       * "_PARNTDOC_" Document Class not found."
 . S MES(5)="       * VHA Enterprise Standard Title "_STDTITLE_" not found."
 . S MES(6)=""
 ;
 I '+FOUNDDOC,+FOUNDSTD D  ;std title exist but parent doc class does not exist at the site
 . S MES(4)="       * "_PARNTDOC_" Document Class not found."
 . S MES(5)=""
 ;
 I +FOUNDDOC,'+FOUNDSTD D  ;parent doc exist but std title does not exist at the site
 . S MES(4)="       * VHA Enterprise Standard Title "_STDTITLE_" not found."
 . S MES(5)=""
 ;
 D MES^XPDUTL(.MES)
 Q
