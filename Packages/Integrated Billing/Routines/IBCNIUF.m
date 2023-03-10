IBCNIUF ;AITC/TAZ - IIU FILER ;01/14/21 2:23p.m.
 ;;2.0;INTEGRATED BILLING;**687**;21-MAR-94;Build 88
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;IA/ICR #2990 and #10112 Used in tag TFL
 ;
 Q
 ;
LOC(DFN,INSCOIEN,IEN312,AUTO,BUFFER,SOI,ICB) ; Entry point to file locally generated data
 ;INPUT:
 ;  DFN              - Pointer to Patient file
 ;  IEN312           - Pointer to the INSURANCE TYPE record
 ;  AUTO             - AUTO UPDATE Yes/No
 ;  BUFFER           - Pointer to Buffer File
 ;  SOI              - Source of Information
 ;  ICB              - ICB processed buffer Yes/No
 ;                     ICB was set in routine IBCNICB. It will be used to set ICB PROCESSED BUFFER (365.19,1.08)
 ;
 ;OUTPUT:
 ;  None
 ;
 N DATA,IBDFDA,IEN,IENS,PIEN,SITE,SITES
 ;
 ;If Manila and not participating in IIU, quit and don't file into #365.19
 I (+$P($$SITE^VASITE,U,3)=358),$$GET1^DIQ(350.9,"1,",51.33,"I")="N" G LOCQ
 ;
 ;Quit if the IIU MASTER SWITCH is off
 I $$GET1^DIQ(350.9,1_",",53.01,"I")'="Y" G LOCQ
 ;
 S PIEN=$$GET1^DIQ(36,INSCOIEN_",",3.1,"I") ; payer IEN associated with ins company
 S IENS=IEN312_","_DFN_","
 ;
 I '$$OKTOFILE G LOCQ  ;Not a valid policy for IIU
 ;
 ;Set Header Nodes
 S DATA(.01)=DFN
 S DATA(.02)=$$NOW^XLFDT
 S DATA(.03)="S"
 ;
 ;Set SENDER nodes
 S DATA(1.01)="W"                               ;SENDER STATUS
 S DATA(1.02)=PIEN                              ;Pointer to the Payer File (#365.12)
 S DATA(1.03)=IEN312                            ;Pointer to INSURANCE TYPE subfile (#2.312)
 S DATA(1.04)=$G(AUTO,0)                        ;Auto Updated Yes/No
 S DATA(1.05)=$G(BUFFER)                        ;Pointer to the INSURANCE VERIFICATION PROCESSOR File (#355.33)
 I $G(AUTO) D
 . S DATA(1.06)=$$GET1^DIQ(2.312,IENS,7.02,"I") ;Subscriber ID to be sent to remote facility
 . S DATA(1.07)=$$GET1^DIQ(2.312,IENS,.2,"I")   ;Coordination of Benefits to be sent to remote facility
 S DATA(1.08)=+$G(ICB)                          ;ICB Processed Buffer Yes/No
 ;
 ; File Main Level Data
 S IEN=$$ADD^IBDFDBS(365.19,,.DATA)
 K DATA
 ;
 ; File VAMC Level
 S SITE=0
 F  S SITE=$O(SITES(SITE)) Q:'SITE  D
 . N X
 . S IBDFDA(1)=IEN
 . S DATA(.01)=SITE
 . S DATA(.02)="R"
 . S DATA(.03)=$$NOW^XLFDT
 . S X=$$ADD^IBDFDBS(365.191,.IBDFDA,.DATA)
 . K DATA
 ;
 ;Send to remote site in real time
 D RT^IBCNIUHL(IEN)
 ;
LOCQ ;Exit Local processing
 Q
 ;====================================
OKTOFILE() ; Confirm that we can/should send to remote facilities
 N OK
 S OK=0
 K SITES  ;array of sites that will receive the verified active policy
 ;
 ;Check Insurance Co
 I "^VACAA-WNR^CAMPLEJEUNE-WNR^IVF-WNR^VHADIRECTIVE1029WNR"[$TR($$GET1^DIQ(36,INSCOIEN_",",.01,"E")," ","") G OKTOFILEQ
 ;
 ;Check Payer
 I '$$PYRAPP^IBCNEUT5("IIU",PIEN) G OKTOFILEQ ;Payer is not IIU
 I $$PYRDEACT^IBCNINSU(PIEN) G OKTOFILEQ ;Payer is Deactivated
 ;
 ;Check Patient
 I $$GET1^DIQ(2,DFN_",",.6,"I") G OKTOFILEQ ;Is a test patient
 I $E($$GET1^DIQ(2,DFN_",",.09,"I")="P") G OKTOFILEQ  ;Has Pseudo SSN
 ;
 ;Check Policy
 I ",INTERFACILITY INS UPDATE,INSURANCE IMPORT,"[(","_SOI_",") G OKTOFILEQ ;Source of Information is IMPORT OR IIU
 I '$$ACTIVE() G OKTOFILEQ
 I '$$TOP() G OKTOFILEQ
 ;
 ;Check Sites
 S SITES=$$TFL(DFN,.SITES) ;Build list of remote facilities visited.
 I 'SITES G OKTOFILEQ ;No sites were visited
 ;
 ;IIU days before sending violated
 ; check the combination of patient, policy, and facility we sent it to
 N DEST,DESTDT,DESTIEN,DESTSTAT,IEN,SHAREDT
 ; TODAY - IIU MIN DAYS BEFORE SHARING (#53.04) to determine if it is too soon
 S SHAREDT=$$FMADD^XLFDT(DT,-$$GET1^DIQ(350.9,1_",",53.04,"I"))
 I $D(^IBCN(365.19,"D",DFN,IEN312)) D
 . S IEN="" F  S IEN=$O(^IBCN(365.19,"D",DFN,IEN312,IEN)) Q:'IEN  D
 . . S DESTIEN=0 F  S DESTIEN=$O(^IBCN(365.19,IEN,1.1,DESTIEN)) Q:'DESTIEN  D
 . . . S DEST=$$GET1^DIQ(365.191,DESTIEN_","_IEN_",",.01,"I")
 . . . S DESTSTAT=$$GET1^DIQ(365.191,DESTIEN_","_IEN_",",.02,"I")
 . . . I DESTSTAT="R",$D(SITES(DEST)) K SITES(DEST) S SITES=SITES-1 Q  ; waiting to send to site
 . . . S DESTDT=$P($$GET1^DIQ(365.191,DESTIEN_","_IEN_",",.03,"I"),".") ;date only
 . . . ;
 . . . ; SUBTRACT IIU MIN DAYS BEFORE SHARING (#53.04) from Today.  If the date is less than DATE/TIME CREATED (#.02) it is too soon.
 . . . I SHAREDT<DESTDT K SITES(DEST) S SITES=SITES-1
 ;
 I 'SITES G OKTOFILEQ ;No sites to send to
 ;
 S OK=1
 ;
OKTOFILEQ ;
 Q OK
 ;
TFL(DFN,IBT,DIR) ; returns treating facility list (pass IBT by reference)
 ;INPUT:
 ;    DFN  - Patient's IEN in the Patient File
 ;    IBT  - Array of visited facilities
 ;    DIR  - Direction of data flow
 ;           S = Sending
 ;           R = Receiving
 ;OUTPUT:
 ;    IBT  - Array of sites
 ;           Can have multiple entries for Sending
 ;           Will have 1 entry for receiving
 ; supported references IA #2990 and #10112, value returned is count
 ; needed to new Y because VAFCTFU1 will kill it
 N FTLIEN,IBC,IBZ,IBS,IBFT,Y
 ;
 K IBT
 S DIR=$G(DIR,"S")
 D TFL^VAFCTFU1(.IBZ,DFN) Q:-$G(IBZ(1))=1 0
 ; Setup current site and initialize variables
 S IBS=+$P($$SITE^VASITE,"^",3),(IBZ,IBC)=0
 ; Return only remote facilities of certain types:
 S IBFT="^VAMC^"
 F  S IBZ=$O(IBZ(IBZ)) Q:IBZ<1  I +IBZ(IBZ)>0 D
 . I (+IBZ(IBZ)=358),$$GET1^DIQ(350.9,"1,",51.33,"I")="N" Q  ;Manila is not participating
 . S FTLIEN=$$FIND1^DIC(4,,"X",+IBZ(IBZ),"D") I 'FTLIEN Q
 . ;If it is the current site and Sending, Q.  If receiving set array.
 . I +IBZ(IBZ)=IBS Q:(DIR'="R")  S IBT(FTLIEN)=IBZ(IBZ),IBC=IBC+1 Q
 . ; build array for sending sites
 . I DIR="R" Q
 . I $$INSTS^IBCNINSL(FTLIEN) S IBT(FTLIEN)=IBZ(IBZ),IBC=IBC+1
 Q IBC
 ;
ACTIVE() ;Check active policy status
 N OK,EFFDT,EXPDT
 S OK=0
 S EFFDT=$$GET1^DIQ(2.312,IENS,8,"I")
 S EXPDT=$$GET1^DIQ(2.312,IENS,3,"I")
 I 'EFFDT G ACTIVEQ
 I EXPDT,(EXPDT<DT) G ACTIVEQ
 S OK=1
 ;
ACTIVEQ ;
 Q OK
 ;
TOP() ;Screen Type of Plan
 N GRPIEN,OK,TOP
 S OK=0
 S GRPIEN=$$GET1^DIQ(2.312,IENS,.18,"I")
 S TOP=$$GET1^DIQ(355.3,GRPIEN_",",.09,"E")
 I "^ACCIDENT AND HEALTH INSURANCE^AUTOMOBILE^AVIATION TRIP INSURANCE^CATASTROPHIC INSURANCE^"[("^"_TOP_"^") G TOPQ
 I "^COINSURANCE^DUAL COVERAGE^INCOME PROTECTION (INDEMNITY)^KEY-MAN HEALTH INSURANCE^"[("^"_TOP_"^") G TOPQ
 I "^MEDI-CAL^MEDICAID^MEDICARE/MEDICAID (MEDI-CAL)^NO-FAULT INSURANCE^QUALIFIED IMPAIRMENT INSURANCE^"[("^"_TOP_"^") G TOPQ
 I "^SPECIAL CLASS INSURANCE^SPECIAL RISK INSURANCE^SPECIFIED DISEASE INSURANCE^TORT FEASOR^"[("^"_TOP_"^") G TOPQ
 I "^VA SPECIAL CLASS^WORKERS' COMPENSATION INSURANCE^"[("^"_TOP_"^") G TOPQ
 ;
 S OK=1
 ;
TOPQ ;
 Q OK
 ;
