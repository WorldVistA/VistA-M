IBY400PO ;ALB/ESG - Post Install for IB patch 400 ;27-Aug-2008
 ;;2.0;INTEGRATED BILLING;**400**;21-MAR-94;Build 52
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
EN ;
 N XPDIDTOT S XPDIDTOT=9
 D PPS            ; 1. fire new trigger to set PPS field
 D BP             ; 2. populate the list of valid billing provider facility types
 D BFLD           ; 3. remove obsolete fields associated with boxes 32/33 on cms-1500
 D BPTAX          ; 4. manually set the new billing provider taxonomy code field
 D XREFCL         ; 5. build new x-ref in file 399 and remove existing triggers
 D XREFRX         ; 6. build new x-ref in file 362.4
 D RIT            ; 7. recompile input template
 D VC             ; 8. add value codes
 D TMOPT          ; 9. schedule option in TaskManager
EX ;
 Q
 ;
PPS ; Fire new FileMan trigger to set the new PPS field on all applicable claims
 NEW DIK,FOUND,STOP,CNT,IBIFN
 D BMES^XPDUTL(" STEP 1 of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Fire trigger for default claim PPS (DRG) ... ")
 ;
 ; try to determine if this has already been run by looking at recent inpatient claims
 ; the "ABT" x-ref is by the .05 field, "1" being regular inpatient claims
 S (FOUND,STOP,CNT)=0
 S IBIFN=" " F  S IBIFN=$O(^DGCR(399,"ABT",1,IBIFN),-1) Q:'IBIFN!FOUND!STOP  D  Q:FOUND!STOP
 . I $$FT^IBCEF(IBIFN)'=3 Q    ; it must be a UB claim
 . S CNT=CNT+1
 . I CNT>500 S STOP=1 Q        ; stop after looking at 500 inpatient, UB claims
 . I +$P($G(^DGCR(399,IBIFN,"U1")),U,15) S FOUND=1 Q     ; found an example where new field# 170 exists
 . Q
 ;
 I FOUND D MES^XPDUTL("Already completed previously.") G PPSX
 ;
 ; call FileMan to fire this new trigger
 S DIK="^DGCR(399,"
 S DIK(1)=".08^7"
 D ENALL^DIK
PPSX ;
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(1)
 Q
 ;
BP ; Populate the list of billing provider facility types
 NEW BPZ,MSG,TYPE,SITE,SUBJ,XMTO,LN
 D BMES^XPDUTL(" STEP 2 of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Populating the list of valid billing provider facility types ...")
 ;
 ; This is the list of CBO-defined billing provider facility types (7-Oct-2008)
 S BPZ("CBOC")=""           ; COMMUNITY BASED OUTPATIENT CLINIC
 S BPZ("HCS")=""            ; HEALTH CARE SYSTEM
 S BPZ("M&ROC")="1"         ; MEDICAL AND REGIONAL OFFFICE CENTER
 S BPZ("OC")="1"            ; OUTPATIENT CLINIC (INDEPENDENT)
 S BPZ("OPC")=""            ; OUT PATIENT CLINIC
 S BPZ("PHARM")=""          ; PHARMACY
 S BPZ("RO-OC")="1"         ; REGIONAL OFFICE - OUTPATIENT CLINIC
 S BPZ("VAMC")="1"          ; VA MEDICAL CENTER
 ;
 K MSG
 S TYPE=""
 F  S TYPE=$O(BPZ(TYPE)) Q:TYPE=""  D
 . N IEN,X,Y,DIC,DA,DLAYGO,DO
 . S IEN=+$$FIND1^DIC(4.1,,"BX",TYPE,"B")    ; find single entry, exact match only
 . I 'IEN D ERR(TYPE) Q                      ; log an error if type not found
 . I $D(^IBE(350.9,1,20,"B",IEN)) Q          ; already in the list
 . S X=IEN
 . S DIC="^IBE(350.9,1,20,",DIC(0)="L",DA(1)=1,DLAYGO=350.9005
 . I BPZ(TYPE) S DIC("DR")=".02////1"        ; file the pay-to provider flag
 . D FILE^DICN
 . I $P(Y,U,3)'=1 D ERR(TYPE,IEN)            ; log an error if not added
 . Q
 ;
 I '$D(MSG) G BPX             ; no errors found
 I '$$PROD^XUPROD(1) G BPX    ; not a production account
 ;
 S SITE=$$SITE^VASITE
 S SUBJ="IB*2*400 post-install errors - #"_$P(SITE,U,3)_" - "_$P(SITE,U,2)
 S SUBJ=$E(SUBJ,1,65)         ; subject must be <= 65 chars or mail will fail
 S XMTO("Eric.Gustafson@domain.ext")=""
 S LN=$O(MSG(""),-1)
 S LN=LN+1,MSG(LN)=""
 S LN=LN+1,MSG(LN)="Please contact EPS and report this problem by entering a Remedy ticket"
 S LN=LN+1,MSG(LN)="or by calling the VA Service Desk (ph. 1-888-596-4357)."
 S LN=LN+1,MSG(LN)=""
 S LN=LN+1,MSG(LN)="One or more billing provider facility types were NOT added successfully."
 S LN=LN+1,MSG(LN)=""
 D SENDMSG^XMXAPI(DUZ,SUBJ,"MSG",.XMTO)
 D MES^XPDUTL(.MSG)
BPX ;
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(2)
 Q
 ;
ERR(TYPE,IEN) ; log an error in MSG array
 N Z S Z=$O(MSG(""),-1)+1
 S MSG(Z)="Error adding billing provider facility type "_TYPE_"."
 I $G(IEN) S MSG(Z)=MSG(Z)_"  IEN="_IEN_"."
ERRX ;
 Q
 ;
BFLD ; remove obsolete fields in files 399 and 350.9 dealing with printing of data in boxes 32/33 on a CMS-1500 claim
 NEW IEN,DIK,DA,PCE
 D BMES^XPDUTL(" STEP 3 of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Removing obsolete fields for CMS-1500 Box 32/33 Data ... ")
 I '$$VFIELD^DILFD(399,401) D MES^XPDUTL("Already completed previously.") G BFLDX
 ;
 ; Delete the 401 field from file 399
 S DIK="^DD(399,",DA=401,DA(1)=399 D ^DIK
 ;
 ; Delete the 2.12 field from file 350.9
 S DIK="^DD(350.9,",DA=2.12,DA(1)=350.9 D ^DIK
 S $P(^IBE(350.9,1,2),U,12)=""   ; blank out any data
 ;
 ; Remove the Agent Cashier name and address data from file 350.9
 F PCE=1:1:6,10 S $P(^IBE(350.9,1,2),U,PCE)=""
 ;
BFLDX ;
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(3)
 Q
 ;
XREFCL ; Build a new-style x-ref in file 399 for the default taxonomy codes
 N IBXR,VAL
 D BMES^XPDUTL(" STEP 5 of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Constructing a new x-ref for file 399 ... ")
 S IBXR("FILE")=399
 S IBXR("NAME")="ABP"
 ;
 ; check to see if xref is already installed (don't do this part for this patch)
 ;S VAL(1)=IBXR("FILE"),VAL(2)=IBXR("NAME")
 ;I $$FIND1^DIC(.11,"","X",.VAL,"BB") D MES^XPDUTL("Already completed previously.") G XREFCLX
 ;
 S IBXR("TYPE")="MU"
 S IBXR("USE")="A"
 S IBXR("EXECUTION")="R"
 S IBXR("ACTIVITY")="IR"
 S IBXR("SHORT DESCR")="Update default taxonomy codes and billing provider IDs"
 S IBXR("DESCR",1)="Whenever the fields in this x-ref are changed in any way (add/edit/delete)"
 S IBXR("DESCR",2)="the billing provider and service facility for the claim may change so we"
 S IBXR("DESCR",3)="need to recalculate the default values of the billing provider taxonomy"
 S IBXR("DESCR",4)="code, the service facility taxonomy code, and the billing provider"
 S IBXR("DESCR",5)="secondary IDs and Qualifiers for every payer on the claim."
 S IBXR("DESCR",6)=" "
 S IBXR("DESCR",7)="Please note that this x-ref will potentially update the values of 8"
 S IBXR("DESCR",8)="fields in file 399:"
 S IBXR("DESCR",9)=" "
 S IBXR("DESCR",10)="399,243 - SERVICE FACILITY TAXONOMY"
 S IBXR("DESCR",11)="399,252 - BILLING PROVIDER TAXONOMY"
 S IBXR("DESCR",12)="399,122 - PRIMARY PROVIDER #"
 S IBXR("DESCR",13)="399,123 - SECONDARY PROVIDER #"
 S IBXR("DESCR",14)="399,124 - TERTIARY PROVIDER #"
 S IBXR("DESCR",15)="399,128 - PRIMARY ID QUALIFIER"
 S IBXR("DESCR",16)="399,129 - SECONDARY ID QUALIFIER"
 S IBXR("DESCR",17)="399,130 - TERTIARY ID QUALIFIER"
 S IBXR("SET")="D TAX^IBCEF79(DA)"
 S IBXR("KILL")="D TAX^IBCEF79(DA)"
 S IBXR("VAL",1)=.22
 S IBXR("VAL",1,"COLLATION")="F"
 S IBXR("VAL",2)=232
 S IBXR("VAL",2,"COLLATION")="F"
 S IBXR("VAL",3)=136
 S IBXR("VAL",3,"COLLATION")="F"
 S IBXR("VAL",4)=.19
 S IBXR("VAL",4,"COLLATION")="F"
 D CREIXN^DDMOD(.IBXR,"W")
 ;
 ; Remove 7 existing triggers from the DEFAULT DIVISION field (#.22).
 ; These fields are included in this new style xref.
 D DELIX^DDMOD(399,.22,1)
 D DELIX^DDMOD(399,.22,2)
 D DELIX^DDMOD(399,.22,3)
 D DELIX^DDMOD(399,.22,4)
 D DELIX^DDMOD(399,.22,5)
 D DELIX^DDMOD(399,.22,6)
 D DELIX^DDMOD(399,.22,8)
 ;
 ; Remove 1 existing trigger from the FORM TYPE field (#.19).
 ; Trigger#4 on field .19 calls BILLPNS^IBCU(DA) which sets the same fields as this new style xref.
 D DELIX^DDMOD(399,.19,4)
 ;
XREFCLX ;
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(5)
 Q
 ;
XREFRX ; Build a new-style x-ref in file 362.4 for the default taxonomy codes
 N IBXR,VAL
 D BMES^XPDUTL(" STEP 6 of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Constructing a new x-ref for file 362.4 ... ")
 S IBXR("FILE")=362.4
 S IBXR("NAME")="ABP"
 ;
 ; check to see if xref is already installed (don't do this part for this patch)
 ;S VAL(1)=IBXR("FILE"),VAL(2)=IBXR("NAME")
 ;I $$FIND1^DIC(.11,"","X",.VAL,"BB") D MES^XPDUTL("Already completed previously.") G XREFRXX
 ;
 S IBXR("TYPE")="MU"
 S IBXR("USE")="A"
 S IBXR("EXECUTION")="F"
 S IBXR("ACTIVITY")="IR"
 S IBXR("SHORT DESCR")="Update default taxonomy codes and billing provider IDs"
 S IBXR("DESCR",1)="When a claim is entered into this file it is considered a pharmacy claim"
 S IBXR("DESCR",2)="and the billing provider for this claim becomes the dispensing pharmacy"
 S IBXR("DESCR",3)="institution.  When a claim is removed from this file, it ceases to be a "
 S IBXR("DESCR",4)="pharmacy claim and the billing provider will change with this action."
 S IBXR("DESCR",5)=" "
 S IBXR("DESCR",6)="This x-ref will update the billing provider and service facility default "
 S IBXR("DESCR",7)="taxonomy codes based on a potential new billing provider and service "
 S IBXR("DESCR",8)="facility.  It will also update the billing provider secondary IDs and "
 S IBXR("DESCR",9)="Qualifiers for every payer on the claim."
 S IBXR("DESCR",10)=" "
 S IBXR("DESCR",11)="Please note that this x-ref will potentially update the values of 8 "
 S IBXR("DESCR",12)="fields in file 399:"
 S IBXR("DESCR",13)=" "
 S IBXR("DESCR",14)="399,243 - SERVICE FACILITY TAXONOMY"
 S IBXR("DESCR",15)="399,252 - BILLING PROVIDER TAXONOMY"
 S IBXR("DESCR",16)="399,122 - PRIMARY PROVIDER #"
 S IBXR("DESCR",17)="399,123 - SECONDARY PROVIDER #"
 S IBXR("DESCR",18)="399,124 - TERTIARY PROVIDER #"
 S IBXR("DESCR",19)="399,128 - PRIMARY ID QUALIFIER"
 S IBXR("DESCR",20)="399,129 - SECONDARY ID QUALIFIER"
 S IBXR("DESCR",21)="399,130 - TERTIARY ID QUALIFIER"
 S IBXR("SET")="D TAX^IBCEF79(X(1))"
 S IBXR("KILL")="D TAX^IBCEF79(X(1))"
 S IBXR("VAL",1)=.02
 S IBXR("VAL",1,"COLLATION")="F"
 D CREIXN^DDMOD(.IBXR,"W")
 ;
XREFRXX ;
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(6)
 Q
 ;
BPTAX ; manually set the new field# 252 - billing provider taxonomy code field
 ; set for non-cancelled claims in cases of retransmission of existing claims - go back 1 year
 N IBIFN,BPZ,BPTAX,FOUND,STOP,CNT,STEVD
 D BMES^XPDUTL(" STEP 4 of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Setting the billing provider taxonomy code default.")
 ;
 ; try to determine if this has been run previously
 S (FOUND,STOP,CNT)=0
 S IBIFN=" " F  S IBIFN=$O(^DGCR(399,IBIFN),-1) Q:'IBIFN!FOUND!STOP  D  Q:FOUND!STOP
 . I $P($G(^DGCR(399,IBIFN,0)),U,13)=7 Q   ; skip cancelled claims
 . S CNT=CNT+1
 . I CNT>500 S STOP=1 Q                    ; stop after looking thru 500 claims
 . I +$P($G(^DGCR(399,IBIFN,"U3")),U,11) S FOUND=1 Q    ; found one!
 . Q
 ;
 I FOUND D MES^XPDUTL("Already completed previously.") G BPTAXX
 ;
 ; It has not been done yet, so loop thru claims
 I '$D(ZTQUEUED) D MES^XPDUTL("Each ""."" represents 10,000 claims  ")
 S CNT=0
 S STEVD=$$FMADD^XLFDT(DT,-367)    ; 1 year ago
 F  S STEVD=$O(^DGCR(399,"D",STEVD)) Q:'STEVD  S IBIFN=0 F  S IBIFN=$O(^DGCR(399,"D",STEVD,IBIFN)) Q:'IBIFN  D
 . S CNT=CNT+1 I CNT#10000=0,'$D(ZTQUEUED) W "."
 . I $P($G(^DGCR(399,IBIFN,0)),U,13)=7 Q      ; not for cancelled claims
 . S BPZ=+$$B^IBCEF79(IBIFN) I 'BPZ Q         ; get the billing provider to continue
 . S BPTAX=+$P($$TAXORG^XUSTAX(BPZ),U,2)      ; taxonomy/person class ien to file 8932.1
 . I 'BPTAX Q
 . S $P(^DGCR(399,IBIFN,"U3"),U,11)=BPTAX     ; set the field
 . Q
 D MES^XPDUTL("Total # of claims in the past year = "_$FN(CNT,","))
 ;
BPTAXX ;
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(4)
 Q
 ;
RIT ; Recompile input templates for billing screens
 ; Billing screen 4 is included here because of field# 158 which was modified.
 ; There were no changes to this input template, but it has to be recompiled at the target facility
 ; in order for the changes to become effective.
 NEW X,Y,DMAX
 D BMES^XPDUTL(" STEP 7 of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Recompiling Input Template for Billing Screen 4 ...")
 S X="IBXSC4",Y=$$FIND1^DIC(.402,,"X","IB SCREEN4","B"),DMAX=8000
 I Y D EN^DIEZ
RITX ;
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(7)
 Q
 ;
VC ; Add value codes to file 399.1
 NEW IBCNT,VCD,VCH,DO,IBVCDB,CODE,IEN,DLAYGO,DIC,X,Y,IBVCIEN,HLPTXT,IENS,IBVCACA
 D BMES^XPDUTL(" STEP 8 of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Adding UB-04 Value Codes ...")
 ;
 S IBCNT=0
 ;
 ; *** NOTE *** - any new value codes should also be added to routine IBCVC
 ;
 S VCD(80)="COVERED DAYS"
 S VCH(80,1)="Enter the number of days covered by the primary payer"
 S VCH(80,2)="as qualified by the payer."
 ;
 S VCD(81)="NON-COVERED DAYS"
 S VCH(81,1)="Enter the number of days of care not covered by the primary payer."
 ;
 S VCD(82)="CO-INSURANCE DAYS"
 S VCH(82,1)="Enter the number of inpatient Medicare days occurring after"
 S VCH(82,2)="the 60th day and before the 91st day or inpatient SNF/Swing"
 S VCH(82,3)="Bed days occurring after the 20th and before the 101st day"
 S VCH(82,4)="in a single spell of illness."
 ;
 ; loop thru each one and add it to file 399.1
 S CODE=""
 F  S CODE=$O(VCD(CODE)) Q:CODE=""  D
 . ;
 . ; check to see if this value code is already in file 399.1
 . S (IEN,IBVCDB)=0 F  S IEN=$O(^DGCR(399.1,"C",CODE,IEN)) Q:'IEN!IBVCDB  I $P($G(^DGCR(399.1,IEN,0)),U,11) S IBVCDB=IEN Q
 . I IBVCDB D MES^XPDUTL("Value Code "_CODE_" ("_$P($G(^DGCR(399.1,IBVCDB,0)),U,1)_") is already on file.") Q
 . ;
 . ; add the value code to file 399.1
 . S DLAYGO=399.1,DIC="^DGCR(399.1,",DIC(0)="L",X=VCD(CODE) D FILE^DICN
 . I Y<1 D MES^XPDUTL("ERROR - Value Code "_CODE_" ("_VCD(CODE)_") was not added.") Q
 . S IBVCIEN=+Y,IBCNT=IBCNT+1
 . ;
 . ; update the rest of the value code fields
 . K HLPTXT,IBVCACA
 . M HLPTXT=VCH(CODE)
 . S IENS=IBVCIEN_","
 . S IBVCACA(399.1,IENS,.02)=CODE        ; value code
 . S IBVCACA(399.1,IENS,.18)=1           ; value code flag
 . S IBVCACA(399.1,IENS,.19)=0           ; value code dollar amount flag
 . S IBVCACA(399.1,IENS,1)="HLPTXT"      ; value code help text
 . D FILE^DIE(,"IBVCACA")
 . Q
 ;
VCX ;
 D MES^XPDUTL(IBCNT_" UB-04 Value Codes added to file# 399.1")
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(8)
 Q
 ;
TMOPT ; Schedule the TaskMan option to run once a month
 ;
 NEW IBZ,T,FST,TMERR,OPTNM,DIFROM
 D BMES^XPDUTL(" STEP 9 of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Schedule option in TaskManager ...")
 ;
 I '$$PROD^XUPROD(1) D MES^XPDUTL("Not a production account. No TaskMan job scheduled.") G TMOPTX
 ;
 S OPTNM="IBCN INS BILL PROV FLAG RPT"     ; option name to be scheduled
 D OPTSTAT^XUTMOPT(OPTNM,.IBZ)
 S T=$G(IBZ(1))
 I +T,$$NOW^XLFDT'>$P(T,U,2),$P(T,U,3)["1M" D MES^XPDUTL("Option is already scheduled properly. No further action taken."),TMDISP(T) G TMOPTX
 ;
 S FST=$$FMADD^XLFDT(DT,14)_".20"     ; first run is 2 weeks from today at 8pm
 D RESCH^XUTMOPT(OPTNM,FST,,"1M(1@2AM)","L",.TMERR)   ; schedule it
 I $G(TMERR)=-1 D MES^XPDUTL("Scheduling Error - Option not found!")
 K IBZ
 D OPTSTAT^XUTMOPT(OPTNM,.IBZ)
 S T=$G(IBZ(1))
 D TMDISP(T)
 ;
TMOPTX ;
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(9)
 Q
 ;
TMDISP(T) ; display task information
 D MES^XPDUTL("           Option: "_OPTNM)
 D MES^XPDUTL("      Task Number: "_$P(T,U,1))
 D MES^XPDUTL("    Queued to Run: "_$$FMTE^XLFDT($P(T,U,2),"5ZPM"))
 D MES^XPDUTL("Rescheduling Freq: "_$P(T,U,3))
 Q
 ;
