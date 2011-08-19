PRCHLO3 ;WOIFO/RLL-EXTRACT ROUTINE CLO REPORT SERVER ; 10/8/10 9:08am
 ;;5.1;IFCAP;**83,130,151**;Oct 20, 2000;Build 4
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ; Continuation of PRCHLO2
 ;
 ; PRCHLO3 routines are used to Write out the Header and data
 ; associated with each of the 23 tables created for the Clinical
 ; logistics Report Server. The files are built from the extracts
 ; located in the ^TMP($J) global.
 ;
 Q
POMASTH ; Po Master Table Header file
 W "PoIdNum^PurchaseOrderNum^PoDate^MonthYrRun^StationNum^Primary2237"
 W "^MethodOfProcessing^LocalProcReasonCode^ExpendableNonExpendable"
 W "^SupplyStatus^SupplyStatusOrder^FiscalStatusOrder^FCP"
 W "^Appropriation^CostCenter^SubAccount1^SubAmount1^SubAccount2"
 W "^SubAmount2^IENprimary2237^IENmethodOfProcessing^IENsupplyStatus"
 W "^IENsubaccount1^IENsubaccount2^Vendor^RequestingService^FobPoint"
 W "^OriginalDeliveryDate^EstCost^SourceCode^EstShipping"
 W "^ShippingLineItemNum^LineItemCount^PaPpmAuthBuyer"
 W "^AgentAssignedPo^DatePoAssigned^Remarks^OldPoRecord^NewPoRecord"
 W "^PaPpmAuthBuyerSVCint^PaPpmAuthBuyerSVCext"
 W "^AgentAssignedDuz^AgentAssignedSVCint^AgentAssignedSVCext"
 W "^PcdoVendor^PurchaseCardUser^PurchaseCost^PurchaseCardHolder"
 W "^Pcdo2237^TotalAmount^NetAmount"
 W "^PurchaseCardUserSVCint^PurchaseCardUserSVCext"
 W "^PurchaseCardHolderSVCint^PurchaseCardHolderSVCext^BBFY"
 W "^EndDateForServiceOrder^AutoAccrue^SubstationIEN^SubstationExternal"
 W "^VendorIEN^VendorFMSCode^VendorAlt-Addr-Ind^VendorDandB"
 W "^Month^Quarter^LastDigitFicalYear^Actual1358Balance"
 W "^Fiscal1358Balance^Est1358Balance^BulletinSent^InterfacePkgPrefix"
 W "^DocumentID/CommonNumber^DoYouWantToSendThisEDI"
 W "^ReasonNotCompeted^NumberOfOffers^PreAwardSynopsis"
 W "^AlternativeAdvertising^SolicitationProcedure^EvaluatedPreference"
 W "^FundingAgencyCode^FundingAgencyOfficeCode^MultiYear"
 W "^EPADesignatedProduct^ContractBundling^ExtentCompeted"
 W "^Perf.BasedServiceContract^ClingerCohen^PlaceOfPerfThisStation"
 W "^PlaceOfPerformance^SendtoFPDS^DuzPABuyer^DuzPCUser^DuzPCHolder"
 W "^RegionalACQcenter",!
 Q
POMASTW ; Write PO Master table data
 N GPOID,GPOND
 S GPOID=0,GPOND=""
 F  S GPOID=$O(^TMP($J,"POMAST",GPOID)) Q:GPOID=""  D
 . ;  W !  ; new line for each PO
 . F  S GPOND=$O(^TMP($J,"POMAST",GPOID,GPOND)) Q:GPOND=""  D
 . . W $G(^TMP($J,"POMAST",GPOID,GPOND))
 . . Q
 . W !  ; new line for each PO
 . Q
 Q
 ;
POOBHD ; PO Obligation Header
 ;
 W "PoIdNum^PurchaseOrderNum^PoDate^MonthYrRun^StationNum^"
 W "ObDataIdNum^Tdateref^ObligatedBy^TransactionAmount^"
 W "AmendmentNumber^Z1358Adjustment^DUZObligatedBy^IEN1358Adjustment^"
 W "DateSigned^ObligationProcessDate^"
 W "AccountingPeriod^ObligatedBySVCint^ObligatedBySVCext",!
 Q
 ;
POOBW ; Write PO Obligation data
 N POOBID,POOBID1
 S POOBID=0,POOBID1=0
 F  S POOBID=$O(^TMP($J,"POOBLG",POOBID)) Q:POOBID=""  D
 . F  S POOBID1=$O(^TMP($J,"POOBLG",POOBID,POOBID1)) Q:POOBID1=""  D
 . . W $G(^TMP($J,"POOBLG",POOBID,POOBID1)),!
 . . Q
 . Q
 Q
POPMEH ; Purchase Order Purchase Method Header
 W "PoIdNum^PurchaseOrderNum^PoDate^MonthYrRun^StationNum^"
 W "PurchaseMethodIdNum^PurchaseMethod",!
 Q
POPMEW ; Write Purchase Order Purchase Method Data
 N POMT1,POMT2
 S POMT1=0,POMT2=0
 F  S POMT1=$O(^TMP($J,"POPMETH",POMT1)) Q:POMT1=""  D
 . F  S POMT2=$O(^TMP($J,"POPMETH",POMT1,POMT2)) Q:POMT2=""  D
 . . W $G(^TMP($J,"POPMETH",POMT1,POMT2)),!
 . .Q
 . Q
 Q
 ;
POPART ; PO Partial Header
 W "PoIdNum^PurchaseOrderNum^PoDate^MonthYrRun^StationNum^"
 W "PartialIdNum^Date^ScheduledDeliveryDate^SubAccount1^Subamount1^"
 W "SubAccount2^SubAmount2^Final^Overage^TotalAmount^"
 W "DiscountPercentDays^Linecount^OriginalPartial^"
 W "AdjustmentAmendmentNumber",!
 Q
POPARTW ; PO Partial Data Write
 N POPR1,POPR2
 S POPR1=0,POPR2=0
 F  S POPR1=$O(^TMP($J,"POPART",POPR1)) Q:POPR1=""  D
 . F  S POPR2=$O(^TMP($J,"POPART",POPR1,POPR2)) Q:POPR2=""  D
 . . W $G(^TMP($J,"POPART",POPR1,POPR2)),!
 . . Q
 . Q
 Q
 ;
PO2237H ; Po 2237 Header
 W "PoIdNum^PurchaseOrderNum^PoDate^MonthYrRun^StationNum^"
 W "Z2237IdNum^Z2237RefNum^AccountableOfficer^DateSigned^"
 W "PurchasingAgent^TypeOfRequest^SourceOfRequest^InvDistPoint^"
 W "DuzPA^DuzAccountableOfficer^PASVCint^PASVCext^"
 W "AccountableOfficeSVCint^AccountableOfficeSVCext",!
 Q
 ;
PO2237W ; PO 2237 Write Data
 N PO37A,PO37B
 S PO37A=0,PO37B=0
 F  S PO37A=$O(^TMP($J,"PO2237",PO37A)) Q:PO37A=""  D
 . F  S PO37B=$O(^TMP($J,"PO2237",PO37A,PO37B)) Q:PO37B=""  D
 . . W $G(^TMP($J,"PO2237",PO37A,PO37B)),!
 . . Q
 . Q
 Q
POBOCH ; PO BOC Header
 W "PoIdNum^PurchaseOrderNum^PoDate^MonthYrRun^StationNum^"
 W "BocIdNum^Subaccount^SubAmount^FMSline",!
 Q
POBOCW ; PO BOC Write Data
 N POBOC,POBOC1
 S POBOC=0,POBOC1=0
 F  S POBOC=$O(^TMP($J,"POBOC",POBOC)) Q:POBOC=""  D
 . F  S POBOC1=$O(^TMP($J,"POBOC",POBOC,POBOC1)) Q:POBOC1=""  D
 . . W $G(^TMP($J,"POBOC",POBOC,POBOC1)),!
 . . Q
 . Q
 Q
POCMTSH ;PO Comments Header
 W "PoIdNum^PurchaseOrderNum^PoDate^MonthYrRun^StationNum^"
 W "CommentsIdNum^Comments",!
 Q
POCMTSW ; PO Comments Write Data
 N POCMT,POCMT1
 S POCMT=0,POCMT1=0
 F  S POCMT=$O(^TMP($J,"POCOMMENTS",POCMT)) Q:POCMT=""  D
 . W $G(^TMP($J,"POCOMMENTS",POCMT)),!
 . Q
 Q
PORMKH ; PO Remarks Header
 W "PoIdNum^PurchaseOrderNum^PoDate^MonthYrRun^StationNum^"
 W "RemarksIdNum^Remarks",!
 Q
PORMKW ; PO Remarks Write Data
 N PORMK
 S PORMK=0
 F  S PORMK=$O(^TMP($J,"POREMARKS",PORMK)) Q:PORMK=""  D
 . W $G(^TMP($J,"POREMARKS",PORMK)),!
 . Q
 Q
POPPTH ; Prompt Payment Terms Header
 W "PoIdNum^PurchaseOrderNum^PoDate^MonthYrRun^StationNum^"
 W "PaymentTermsIdNum^PromptPaymentPercent^DaysTerm^Contract^Astr",!
 Q
POPPTW ; Prompt Payment Terms Write Data
 N POPPT,POPPT1
 S POPPT=0,POPPT1=0
 F  S POPPT=$O(^TMP($J,"POPROMPT",POPPT)) Q:POPPT=""  D
 . F  S POPPT1=$O(^TMP($J,"POPROMPT",POPPT,POPPT1)) Q:POPPT1=""  D
 . . W $G(^TMP($J,"POPROMPT",POPPT,POPPT1,0)),!
 . . Q
 . Q
 Q
POAMTH ; PO Amount Header
 W "PoIdNum^PurchaseOrderNum^PoDate^MonthYrRun^StationNum^"
 W "AmountIdNum^Amount^TypeCode^CompStatusBusiness^PrefProgram^"
 W "Contract",!
 Q
POAMTW ; PO Amount Write Data
 N POAMT,POAMT1,POAMT2
 S POAMT=0,POAMT1=0
 F  S POAMT=$O(^TMP($J,"POAMT",POAMT)) Q:POAMT=""  D
 . F  S POAMT1=$O(^TMP($J,"POAMT",POAMT,POAMT1)) Q:POAMT1=""  D
 . . W $G(^TMP($J,"POAMT",POAMT,POAMT1,0)),!
 . . Q
 . Q
 Q
PAMTBKH ; PO Amount Breakout Code Header
 W "PoIdNum^PurchaseOrderNum^PoDate^MonthYrRun^StationNum^"
 W "AmountIdNum^AmountBrkCodeIdNum^BreakoutCode",!
 Q
POAMDH ; PO Amendment Header
 W "PoIdNum^PurchaseOrderNum^PoDate^MonthYrRun^StationNum^"
 W "AmendmentIdNum^Amendment^EffectiveDate^AmountChanged^"
 W "PappmAuthBuyer^AmendmentAdjStatus^"
 W "DuzPappmAuthBuyer^DuzFiscalApprover^NameFiscalApprover^"
 W "PappmAuthBuyerSVCint^PappmAuthBuyerSVCext^"
 W "FiscalApproverSVCint^FiscalApproverSVCext",!
 Q
POAMDW ; PO Amendment Write Data
 N POAMD,POAMD1,POAMD2
 S POAMD=0,POAMD1=0
 F  S POAMD=$O(^TMP($J,"POAMMD",POAMD)) Q:POAMD=""  D
 . F  S POAMD1=$O(^TMP($J,"POAMMD",POAMD,POAMD1)) Q:POAMD1=""  D
 . . W $G(^TMP($J,"POAMMD",POAMD,POAMD1,0)),!
 . . Q
 . Q
 Q
 ;
POAMDCH ; PO Amendment Changes Header
 W "PoIdNum^PurchaseOrderNum^PoDate^MonthYrRun^StationNum^"
 W "AmendmentIdNum^AmendmentChangeIdNum^Changes^AmendmentType",!
 Q
POAMDCW ; PO Amendment Changes Write Data
 N PAMDC,PAMDC1,PAMDC2,PAMDC3,PAMDC4
 S PAMDC=0,PAMDC1=0,PAMDC2=0,PAMDC3=0
 F  S PAMDC=$O(^TMP($J,"POAMMDCH",PAMDC)) Q:PAMDC=""  D
 . F  S PAMDC1=$O(^TMP($J,"POAMMDCH",PAMDC,PAMDC1)) Q:PAMDC1=""  D
 . . F  S PAMDC2=$O(^TMP($J,"POAMMDCH",PAMDC,PAMDC1,PAMDC2)) Q:PAMDC2=""  D
 . . . W $G(^TMP($J,"POAMMDCH",PAMDC,PAMDC1,PAMDC2,0)),!
 . . . Q
 . . Q
 . Q
 Q
PAMDDH ; PO Amendment Description Header
 W "PoIdNum^PurchaseOrderNum^PoDate^MonthYrRun^StationNum^"
 W "AmendmentIdNum^AmendmentDescIdNum^Description",!
 Q
 ;
PAMDDW ; PO Amendment Description Write Data
 N PAMD,PAMD1,PAMD2,PAMD3
 S PAMD=0,PAMD1=0,PAMD2=0
 F  S PAMD=$O(^TMP($J,"POAMMDDES",PAMD)) Q:PAMD=""  D
 . F  S PAMD1=$O(^TMP($J,"POAMMDDES",PAMD,PAMD1)) Q:PAMD1=""  D
 . . F  S PAMD2=$O(^TMP($J,"POAMMDDES",PAMD,PAMD1,PAMD2)) Q:PAMD2=""  D
 . . . W $G(^TMP($J,"POAMMDDES",PAMD,PAMD1,PAMD2,0)),!
 . . . Q
 . . Q
 . Q
 Q
PAMTBKW ; Write Breakout Code data
 N BCD,BCD1,BCD2,BCD3
 S BCD=0,BCD1=0,BCD2=0
 F  S BCD=$O(^TMP($J,"POBKCOD",BCD)) Q:BCD=""  D
 . F  S BCD1=$O(^TMP($J,"POBKCOD",BCD,BCD1)) Q:BCD1=""  D
 . . F  S BCD2=$O(^TMP($J,"POBKCOD",BCD,BCD1,BCD2)) Q:BCD2=""  D
 . . . ;
 . . . W $G(^TMP($J,"POBKCOD",BCD,BCD1,BCD2,0)),!
 . . Q
 . Q
 Q
CONTRPH ; Write File 410 header (Control Point Activities)
 W "TransactionNumber^TransactionIEN^StationNumber^MonthYrRun^TransactionType^FormType^"
 W "SubStationIEN^SubStationEXT^RunningBalQuarterDate^RunningBalStatus^"
 W "DateOfRequest^ClassOfRequestIEN^ClassOfRequestEXT^Vendor^"
 W "VendorAddress1^VendorAddress2^VendorAddress3^VendorAddress4^"
 W "VendorCity^VendorState^VendorZIPcode^VendorContact^VendorPhone^"
 W "VendorIEN^VendorName^VendorFMSCode^VendorAlt-Addr-Ind^"
 W "VendorDandB^VendorContractNumber^ControlPoint^CostCenter^"
 W "BOC1^BOC1Amount^AccountingData^FcpPrj^BBFY^"
 W "CommittedCost^DateCommitted^ObligatedActualCost^"
 W "DateObligated^PurchaseOrderObligationNumber^AdjustmentAmount^"
 W "DateOBLAjusted^TransactionAmount^"
 W "ObligatedByDUZ^ObligatedByName^ObligatedBySVCint^"
 W "ObligatedBySVCext^ObligationValCodeDateTime^"
 W "RequestorDUZ^RequestorName^RequestorSVCint^RequestorSVCext^"
 W "RequestorTitle^ApprovOfficialDUZ^ApprovOfficialName^"
 W "ApprovOfficialSVCint^ApprovOfficialSVCext^ApprovOfficialTitle^"
 W "DateSigned^ESCodeDateTime^"
 W "Justification^SortGroup^StationPONoIEN^StationPONoEXT^PoDate^Status^"
 W "Comments^ReasonForReturn^"
 ;added by patch 151 to support new fields
 W "AuthIEN^AuthCode^AuthDesc^SubAuthIEN^SubAuthCode^SubAuthDesc^"
 W "ServiceStartDate^ServiceEndDate",!
 Q
CONTRPW ; Write File 410 data (Control Point Activities)
 N GPOID,GPOND
 S GPOID=0,GPOND=""
 F  S GPOID=$O(^TMP($J,"CONTRP",GPOID)) Q:GPOID=""  D
 . F  S GPOND=$O(^TMP($J,"CONTRP",GPOID,GPOND)) Q:GPOND=""  D
 . . W $G(^TMP($J,"CONTRP",GPOID,GPOND))
 . . Q
 . W !    ; new line for each file #410 entry
 . Q
 Q
SUBCPH ; Write File 410.04 header (Sub Control Point)
 W "TransactionNumber^TransactionIEN^StationNumber^StationPONoIEN^StationPONoEXT^PoDate^MonthYrRun^SubControlPoint^Amount^SCPAMT",!
 Q
SUBCPW ; Write File 410.04 data (Sub Control Point)
 N GPOID,GPOND
 S GPOID=0,GPOND=""
 F  S GPOID=$O(^TMP($J,"SUBCP",GPOID)) Q:GPOID=""  D
 . F  S GPOND=$O(^TMP($J,"SUBCP",GPOID,GPOND)) Q:GPOND=""  D
 . . W $G(^TMP($J,"SUBCP",GPOID,GPOND)),!
 . . Q
 . Q
 Q
DR1358H ; Write File 424 header (1358 Daily Record)
 W "PoIdNum^PurchaseOrderNum^PoDate^MonthYrRun^StationNum^AuthorizationNumber^TransactionType^"
 W "LiquidationAmount^AuthBalance^ObligationAmount^DateTime^UserDUZ^"
 W "UserName^UserSVCint^UserSVCext^CompletedFlag^Reference^"
 W "LastSequenceUsed^AuthAmount^"
 W "OriginalAuthAmount^LastEditByDUZ^LastEditByName^LastEditBySVCint^"
 W "LastEditBySVCext^CPApointerIEN^CPApointerEXT^Comments^InterfaceID",!
 Q
DR1358W ; Write File 424 data (1358 Daily Record)
 N GPOID,GPOND
 S GPOID=0,GPOND=""
 F  S GPOID=$O(^TMP($J,"DR1358",GPOID)) Q:GPOID=""  D
 . F  S GPOND=$O(^TMP($J,"DR1358",GPOID,GPOND)) Q:GPOND=""  D
 . . W $G(^TMP($J,"DR1358",GPOID,GPOND)),!
 . . Q
 . Q
 Q
AD1358H ; Write File 424.1 header (1358 Authorization Detail)
 W "PoIdNum^PurchaseOrderNum^PoDate^MonthYrRun^StationNum^BillNumber^RecordType^AuthPointerIEN^AuthPointerEXT^AuthAmount^"
 W "DateTime^UserDUZ^UserName^UserSVCint^UserSVCext^"
 W "VendorInvoiceNumber^FinalBill^Reference^LastEditedByDUZ^"
 W "LastEditedByName^LastEditedBySVCint^LastEditedBySVCext^Description",!
 Q
AD1358W ; Write File 424.1 data (1358 Authorization Detail)
 N GPOID,GPOND
 S GPOID=0,GPOND=""
 F  S GPOID=$O(^TMP($J,"AD1358",GPOID)) Q:GPOID=""  D
 . F  S GPOND=$O(^TMP($J,"AD1358",GPOID,GPOND)) Q:GPOND=""  D
 . . W $G(^TMP($J,"AD1358",GPOID,GPOND)),!
 . . Q
 . Q
 Q
