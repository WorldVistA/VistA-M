ORWDBA7 ;;SLC/GSS Billing Awareness (CIDC-Clinical Indicators Data Capture)
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**195,215,243**;Dec 17, 1997;Build 242
 ;
BDOEDIT ; Backdoor entered orders edit in CPRS - entry point
 ; Data Flow> Ancillary creates a back door order which is incomplete
 ;            and thus edited in CPRS GUI. The ancillary needs to know
 ;            what Dx and TF's are edited thus this tag calls three
 ;            ancillary APIs, passing the Dx and TF data to them.
 ;
 ; Variable  Description
 ; ANCILARY  Acronym of ancillary/package relative to order
 ; DXN       Diagnosis sequence number in ^OR file
 ; MSG       Error message
 ; ORDX      Array of diagnoses (1-n) with value from ICD file (#80)
 ; ORIFN     Order internal reference number (defined in ORCSEND)
 ; ORITEM    Package reference or ^OR(100,ORIFN,4)
 ; ORSCEI    String of Treatment Factors in table SD008 order/format
 ; PTIEN     Patient IEN
 ; TAGROU    Tag^Routine of ancillary routine to store edited data
 ; TFO       Treatment Factors in ^OR (GBL) order
 ;
 ; If CIDC master switch set, then no back door orders to store
 I $$BASTAT^ORWDBA1=0 Q  ;CIDC (nee BA) not used
 ; If ORIFN not defined (God only knows why) then log error and quit
 I '$D(ORIFN) S MSG="ORIFN not defined" D VAR,EN^ORERR(MSG,"",.VAR) Q
 ;
 N ANCILARY,DXN,MSG,ORDX,ORITEM,ORSCEI,PTIEN,RT,SUCCESS,TAGROU,TFO,VAR
 ;
 S DXN=0,(RT,SUCCESS)="",PTIEN=+$P($G(^OR(100,ORIFN,0)),U,2)
 ; Package (ancillary) reference data
 S ORITEM=$G(^OR(100,ORIFN,4))
 ; Create an array (ORDX) of diagnoses
 F  S DXN=$O(^OR(100,ORIFN,5.1,DXN)) Q:'DXN  D
 . S ORDX(DXN)=$G(^OR(100,ORIFN,5.1,DXN,0))
 ; Treatment Factors - converted and reformatted
 S ORSCEI=$$TFGBLTBL($G(^OR(100,ORIFN,5.2)))
 ; Get the acronym of the package generating this order
 S ANCILARY=$P($G(^DIC(9.4,$P($G(^OR(100,ORIFN,0)),U,14),0)),U,2)
 ; Send data to the appropriate ancillary API based on package
 D OUTPUT
 ; If ancillary routine or tag w/in the routine doesn't exist check
 I 'RT D
 . S MSG="NON-EXISTANT ROUTINE/TAG FOR "_ANCILARY
 . D VAR,EN^ORERR(MSG,"",.VAR)
 ; If we don't get back a thumbs-up from the ancillary re: the order data
 I 'SUCCESS,RT D
 . S MSG="ANCILLARY API RETURNED ERROR FOR CPRS EDITED BACK DOOR DATA"
 . D VAR,EN^ORERR(MSG,"",.VAR)
 Q
 ;
OUTPUT ; Call ancillary's API to store data after checking for it's existence
 ;
 ; Laboratory
 I ANCILARY?1"LR".U D  Q
 . S RT=$$CKROUTAG("UPDOR^LRBEBA4") Q:'RT
 . S SUCCESS=$$UPDOR^LRBEBA4(PTIEN,ORITEM,ORIFN,.ORDX,ORSCEI)  ;IA 4775
 ;
 ; Pharmacy
 I ANCILARY?1"PS".U D  Q
 . S RT=$$CKROUTAG("EN^PSOHLNE3") Q:'RT
 . S SUCCESS=$$EN^PSOHLNE3(PTIEN,ORITEM,ORIFN,.ORDX,ORSCEI)  ;IA 4666
 ;
 ; Radiolgy
 I ANCILARY?1"RA".U D  Q
 . S RT=$$CKROUTAG("CPRSUPD^RABWORD1") Q:'RT
 . S SUCCESS=$$CPRSUPD^RABWORD1(PTIEN,ORITEM,ORIFN,.ORDX,ORSCEI) ;IA 4771
 Q
 ;
CKROUTAG(TAGROU) ;Check if valid tag and routine
 ; Temporary check until all the ancillaries have their API's built
 Q $L($T(@TAGROU))
 ;
TFGBLTBL(GBL) ;Convert Tx Factors from Global to TBL (HL7) order & format
 ; Note: this does not set Tx Factors in ZCL segment format but rather
 ;       AO^IR^SC^EC^MST^HNC^CV^SHD ('^' delimited string) format
 ;
 ; Input:  GBL in 1^1^0^0^^^0^ (global) format
 ; Output: TBL in 0^0^1^^1^^0^ (TBL) format (also reordered)
 ;
 N J,NTF,TBL,TF,TFGBL,TFGUI,TFTBL
 S TBL="",NTF=8  ;NCI=# of TxF
 ; Get Treatment Factor sequence order strings
 D TFSTGS^ORWDBA1
 ; Convert from GBL to TBL format and sequence
 F J=1:1:NTF S TF=$P(GBL,U,J) D
 . ;OK..just in case there is a '?' we'll return a null for a '?'
 . S TF($P(TFGBL,U,J))=$S(TF=1:1,TF=0:0,TF="?":"",1:"")
 F J=1:1:NTF S TBL=TBL_U_TF($P(TFTBL,U,J))
 ; Remove the first '^' and pass TBL formatted TF's
 Q $E(TBL,2,99)
 ;
VAR ;Create VAR array for tracking error in ^ORYX("ORERR",err#)
 S VAR("DFN")=PTIEN
 S VAR("ORITEM")=ORITEM
 S VAR("ORIFN")=ORIFN
 M VAR("ORDX")=ORDX
 S VAR("ORSCEI")=ORSCEI
 Q
 ;
ISWITCH(Y,DFN) ;Return 0 if don't ask (no ins) or 1 to ask CIDC quest (yes ins)
 S Y=$$CIDC^IBBAPI(DFN)
 Q
 ;
GETIEN9(Y,ICD9) ;Return IEN for an ICD9 code (RPC: ORWDBA7 GETIEN9)
 S Y=$P($$CODEN^ICDCODE(ICD9,80),"~")
 Q
 ;
CONDTLD ;Consult Detailed Display Compile for CIDC/BA (called by GMRCSLM2)
 ; Input:  ORIFN and GMRCCT defined in GMRCSLM2
 ; Output: CIDCARY = array of CIDC display lines for GMRCSLM2 display
 N BGNRCCT,DXIEN,DXOF,DXV,EYE,ICD9,ICDR,LINE,OCT,ORFMDAT,TF
 S BGNRCCT=GMRCCT,OCT=0
 ; Get the date of the order for CSV/CTD usage
 S ORFMDAT=$$ORFMDAT^ORWDBA3(ORIFN)
 ; $O through diagnoses for an order
 F  S OCT=$O(^OR(100,ORIFN,5.1,OCT)) Q:OCT'?1N.N  D
 . S DXOF="               "
 . ; DXIEN=Dx IEN
 . S DXIEN=+^OR(100,ORIFN,5.1,OCT,0)
 . ; Get Dx record for date ORFMDAT
 . S ICDR=$$ICDDX^ICDCODE(DXIEN,ORFMDAT)
 . ; Get Dx verbiage and ICD code
 . S DXV=$P(ICDR,U,4),ICD9=$P(ICDR,U,2)
 . I OCT=1 D
 .. S CIDCARY(GMRCCT,0)=" ",GMRCCT=GMRCCT+1 ;blank line
 .. S CIDCARY(GMRCCT,0)="Clinical Indicators",GMRCCT=GMRCCT+1
 .. S DXOF="Diagnosis of:  "
 . S LINE=DXOF_ICD9_" - "_DXV
 . S CIDCARY(GMRCCT,0)=LINE,GMRCCT=GMRCCT+1
 I OCT'="" D  ;if there are diagnoses then show Treatment Factors
 . S LINE="For conditions related to:    "
 . F EYE=1:1:8 S TF=$P(^OR(100,ORIFN,5.2),U,EYE) I TF D
 .. S CIDCARY(GMRCCT,0)=LINE_$$SC^ORQ21(EYE)
 .. S X=$$REPEAT^XLFSTR(" ",30),GMRCCT=GMRCCT+1
 Q
