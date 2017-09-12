IBY377PO ;ALB/ESG - Post Install for IB patch 377 ;29-Nov-2007
 ;;2.0;INTEGRATED BILLING;**377**;21-MAR-94;Build 23
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
EN ;
 N XPDIDTOT S XPDIDTOT=5
 D XREF          ; 1. re-build DD cross reference
 D PND           ; 2. change one EDI reports menu mnemonic
 D REL2          ; 3. populate new field 2.312/4.03
 D REL355        ; 4. populate new field 355.33/60.14
 D EMAIL         ; 5. send email message to FSC
 ;
 ; remove identifier label from this field
 KILL ^DD(355.93,0,"ID",.09)    ; DBIA# 5131 
EX ;
 Q
 ;
XREF ; Re-build DD cross references
 NEW IBXR,IBRES,IBOUT,DIK
 D BMES^XPDUTL(" STEP 1 of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Re-building the ""C"" cross-reference in file 364.6 ...")
 KILL ^IBA(364.6,"C")                   ; kill whatever is there
 S IBXR("FILE")=364.6
 S IBXR("NAME")="C"
 S IBXR("TYPE")="R"
 S IBXR("USE")="LS"
 S IBXR("EXECUTION")="F"
 S IBXR("ACTIVITY")="IR"
 S IBXR("SHORT DESCR")="Field name lookup"
 S IBXR("VAL",1)=.1
 S IBXR("VAL",1,"SUBSCRIPT")=1
 S IBXR("VAL",1,"LENGTH")=40
 S IBXR("VAL",1,"COLLATION")="F"
 S IBXR("VAL",1,"XFORM FOR STORAGE")="S X=$$UP^XLFSTR(X)"
 D CREIXN^DDMOD(.IBXR,"SW",.IBRES,"IBOUT")
 S DIK="^IBA(364.6,",DIK(1)=".1^C"      ; set-up
 D ENALL^DIK                            ; rebuild it
XREFX ;
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(1)
 Q
 ;
PND ; Change one EDI reports menu mnemonic
 NEW MENUIEN,ITEMIEN,STOP,IBX,DIE,DA,DR
 D BMES^XPDUTL(" STEP 2 of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Updating EDI reports menu mnemonic ....")
 ;
 S MENUIEN=$O(^DIC(19,"B","IBCE TXMT MGMNT REPORTS",0)) I 'MENUIEN G PNDX
 S ITEMIEN=0,STOP=0
 F  S ITEMIEN=$O(^DIC(19,MENUIEN,10,ITEMIEN)) Q:'ITEMIEN  D  Q:STOP
 . S IBX=$P($G(^DIC(19,MENUIEN,10,ITEMIEN,0)),U,1) Q:'IBX
 . I $P($G(^DIC(19,IBX,0)),U,1)'="IBCE BATCHES PENDING TOO LONG" Q
 . S DIE="^DIC(19,"_MENUIEN_",10,"
 . S DA=ITEMIEN,DA(1)=MENUIEN
 . S DR="2////PND"
 . D ^DIE
 . S STOP=1
 . Q
PNDX ;
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(2)
 Q
 ;
REL2 ; Populate new pt. relation field 2.312/4.03
 ;
 N IBCNT,IEN2,IEN2312,NODE,WINS,X12CODE
 D BMES^XPDUTL(" STEP 3 of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Updating new patient relationship field in PATIENT file...")
 ; If this patch has been installed before, then this update has already been completed.
 I $$ICPLT() D MES^XPDUTL(" This field has already been updated. No further action.") G REL2X
 D MES^XPDUTL("Each ""."" represents 10,000 records.")
 D MES^XPDUTL("")
 S (IEN2,IBCNT)=0 F  S IEN2=$O(^DPT(IEN2)) Q:IEN2?1.A!(IEN2="")  D
 .S IBCNT=IBCNT+1 W:(IBCNT#10000=0)&'$D(ZTQUEUED) "."
 .Q:'$D(^DPT(IEN2,.312))  ; make sure file 2.312 exists for this patient
 .S IEN2312=0 F  S IEN2312=$O(^DPT(IEN2,.312,IEN2312)) Q:IEN2312?1.A!(IEN2312="")  D
 ..S NODE=$G(^DPT(IEN2,.312,IEN2312,0)),X12CODE=$$PRELCNV^IBCNSP1($P(NODE,U,16),1)
 ..; if we couldn't find a match, try to use WHOSE INSURANCE field
 ..S:X12CODE="" WINS=$P(NODE,U,6),X12CODE=$S(WINS="v":"18",WINS="s":"01",1:"")
 ..Q:X12CODE=""  ; still no valid code - skip this record
 ..N DIE,DR,DA
 ..S DIE="^DPT("_IEN2_",.312,",DA=IEN2312,DA(1)=IEN2,DR="4.03////"_X12CODE D ^DIE
 ..Q
 .Q
 D MES^XPDUTL(" Done.")
REL2X ;
 D UPDATE^XPDID(3)
 D CLEAN^DILF
 Q
 ;
REL355 ; Populate new pt. relation field 355.33/60.14
 ;
 N IEN355,NODE,WINS,X12CODE
 D BMES^XPDUTL(" STEP 4 of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Updating new patient relationship field in INSURANCE BUFFER file...")
 ; If this patch has been installed before, then this update has already been completed.
 I $$ICPLT() D MES^XPDUTL(" This field has already been updated. No further action.") G REL355X
 S IEN355=0 F  S IEN355=$O(^IBA(355.33,IEN355)) Q:IEN355?1.A!(IEN355="")  D
 .S NODE=$G(^IBA(355.33,IEN355,60)) Q:NODE=""  ; make sure that node 60 of file 355.33 exists
 .S X12CODE=$$PRELCNV^IBCNSP1($P(NODE,U,6),1)
 .; if we couldn't find a match, try to use WHOSE INSURANCE field
 .S:X12CODE="" WINS=$P(NODE,U,5),X12CODE=$S(WINS="v":"18",WINS="s":"01",1:"")
 .Q:X12CODE=""  ; still no valid code - skip this record
 .N DIE,DR,DA
 .S DIE=355.33,DA=IEN355,DR="60.14////"_X12CODE D ^DIE
 .Q
 D MES^XPDUTL(" Done.")
REL355X ;
 D UPDATE^XPDID(4)
 D CLEAN^DILF
 Q
 ;
ICPLT() ; Returns 1 if this patch has been successfully installed before, 0 otherwise
 N I,ICPLT,INST
 D FIND^DIC(9.7,,"@;.02I","QPX","IB*2.0*377",,,,,"INST")
 S (I,ICPLT)=0 F  S I=$O(INST("DILIST",I)) Q:I=""  S:+$P(INST("DILIST",I,0),U,2)=3 ICPLT=1 Q:ICPLT
 Q ICPLT
 ;
EMAIL ; Send an email message to Austin FSC to let them know this site has installed IB patch 377
 NEW SITE,SUBJ,MSG,XMTO,LN,GLO,GLB
 D BMES^XPDUTL(" STEP 5 of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Sending email notification to Austin FSC ... ")
 I '$$PROD^XUPROD(1) D MES^XPDUTL("No email sent for test account installation.") G EMAILX
 S SITE=$$SITE^VASITE
 S SUBJ="IB*2*377 installed at Station# "_$P(SITE,U,3)_" - "_$P(SITE,U,2)
 S SUBJ=$E(SUBJ,1,65)
 S MSG(1)="VistA patch IB*2.0*377 was installed successfully at the following site:"
 S MSG(2)=""
 S MSG(3)="        Name: "_$P(SITE,U,2)
 S MSG(4)="    Station#: "_$P(SITE,U,3)
 S MSG(5)="      Domain: "_$G(^XMB("NETNAME"))
 S MSG(6)="   Date/Time: "_$$FMTE^XLFDT($$NOW^XLFDT,"5ZPM")
 S MSG(7)=""
 S MSG(8)="This patch is eClaims Plus Iteration 3, Phase 2."
 ;
 S XMTO("fsc.edi-team@domain.ext")=""
 S XMTO("Eric.Gustafson@domain.ext")=""
 S XMTO("Yan.Gurtovoy@domain.ext")=""
 S XMTO("Mary.Simons@domain.ext")=""
 ;
 D SENDMSG^XMXAPI(DUZ,SUBJ,"MSG",.XMTO)
 I '$D(^TMP("XMERR",$J)) G EMAILX    ; no email problems
 ;
 D MES^XPDUTL("MailMan problem reported.  Please review messages.")
 S SUBJ="IB*2*377 email notification failure"
 K MSG S LN=0
 S LN=LN+1,MSG(LN)="MailMan reported the following error(s) when attempting to send the"
 S LN=LN+1,MSG(LN)="installation notification message for IB patch 377."
 S LN=LN+1,MSG(LN)=""
 S (GLO,GLB)="^TMP(""XMERR"","_$J
 S GLO=GLO_")"
 F  S GLO=$Q(@GLO) Q:GLO'[GLB  S LN=LN+1,MSG(LN)="   "_GLO_" = "_$G(@GLO)
 S LN=LN+1,MSG(LN)=""
 S LN=LN+1,MSG(LN)="Please contact EPS and report this problem by entering a Remedy ticket"
 S LN=LN+1,MSG(LN)="or by calling the VA Service Desk (ph. 1-888-596-4357)."
 S LN=LN+1,MSG(LN)=""
 S LN=LN+1,MSG(LN)="Austin FSC needs to be notified when this patch is installed."
 S LN=LN+1,MSG(LN)=""
 K XMTO
 S XMTO(DUZ)=""
 S XMTO("G.PATCHES")=""
 D SENDMSG^XMXAPI(DUZ,SUBJ,"MSG",.XMTO)
 D MES^XPDUTL(.MSG)
 ;
EMAILX ;
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(5)
 D CLEAN^DILF
 Q
 ;
