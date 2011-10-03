ORWDBA3 ; SLC/GSS Billing Awareness (CIDC) [8/20/03 9:19am]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**190,195,243**;Dec 17, 1997;Build 242
 ;
ORFMDAT(ORDFN) ; Return date in FM format regarding order for CSV/CTD/HIPAA
 ; Pass in Order IEN
 Q ($P($G(^OR(100,ORDFN,8,1,0)),"^",16)\1)
 ;
DISPLAY ; Display of BA data from original copied order (ORIT = ORIEN)
 ; Displayed in window with all order info and user can accept/edit
 ; Note: TxF = Treatment Factor
 ; BA data (Dx,TxF's) not editable but in signature window, not in above
 ; ORIT defined in ORWDXM1, DISPLAY called from ORWDXM2
 ;
 ; Input:
 ;  ORIT, ILST, and LST() from ORWDXM* routines
 ; Output:
 ;  ILST and LST() appropriately incremented/populated for order display
 ; Variables:
 ;  CUN     = TxF's in C, U, or N format
 ;  I       = counter
 ;  ILST    = line counter, initially from ORWDXM* routines
 ;  LST()   = array of lines to output, initially from ORWDXM* routines
 ;  NTF     = # of Treatment Factors
 ;  ORITARY = ORIT array of 1 needed to access GETTFCI^ORWDBA4
 ;  SPCS    = # of characters to space to left of ':'
 ;  TF1     = first TxF output? (0/1)
 ;  TFGBL   = TxF's in Global stored order
 ;  TFGUI   = TxF's in GUI returned order
 ;  TFV     = TxF verbiage
 ;
 N CUN,I,NTF,ORITARY,SPCS,TF1,TFGBL,TFGUI,TFV,Y
 S NTF=8,SPCS=28,ORITARY(1)=+ORIT
 ; Get Y(+ORIT) string in ORIEN^CUUUCCN^Dx1^Desc1^Dx2^Desc2^... format
 D GETTFCI^ORWDBA4(.Y,.ORITARY)
 S CUN=$P($G(Y(1)),U,2)  ;CUN = Treatment Factors in CUN syntax
 ; First output Diagnosis information - if any
 F I=3:2:9 I $P($G(Y(1)),U,I)'="" D
 . S ILST=ILST+1,LST(ILST)=$S(I=3:"Diagnoses",1:"")
 . S LST(ILST)=LST(ILST)_":"_$P(Y(1),U,I)_" - "_$P(Y(1),U,I+1)
 . D FRMTLST
 ; Get GUI and GBL Treatment Factor sequence strings
 D TFSTGS^ORWDBA1
 ; Assumes SC will always be first in sequence! - not likely to change
 S ILST=ILST+1
 S LST(ILST)="Service Connected:"_$S($E(CUN)="C":"YES",1:"NO")
 D FRMTLST
 S ILST=ILST+1,LST(ILST)="Treatment Factors:"
 ; If no TxF's (no 'C'hecked) {SC output above} then output '<none>'
 I '$F($E(CUN,2,NTF),"C") S LST(ILST)=LST(ILST)_"<none>" D FRMTLST Q
 S TF1=0  ;No TxF yet output
 ; Verbiage for TxF's
 S TFV("MST")="MILITARY SEXUAL TRAUMA",TFV("AO")="AGENT ORANGE"
 S TFV("IR")="IONIZING RADIATION",TFV("EC")="ENVIRONMENTAL CONTAMINANTS"
 S TFV("HNC")="HEAD AND NECK CANCER",TFV("CV")="COMBAT VETERAN"
 S TFV("SHD")="SHIPBOARD HAZARD"
 ; Output Checked TxF's
 F I=2:1:NTF I $E(CUN,I)="C" D
 . I 'TF1 S LST(ILST)=LST(ILST)_TFV($P(TFGUI,U,I)),TF1=1 D FRMTLST Q
 . S ILST=ILST+1,LST(ILST)=":"_TFV($P(TFGUI,U,I)) D FRMTLST
 Q
 ;
FRMTLST ; Format the variable LST(ILST) for DISPLAY tag
 S LST(ILST)=$J($P(LST(ILST),":"),SPCS)_": "_$P(LST(ILST),":",2)
 Q
 ;
HINTS(Y) ; Return HINTS for ORBA Treatment Factors - used by Delphi
 ; The hints returned in the Y array will be used in the CPRS GUI and
 ; displayed on fly-over of the cursor over the TxF text in the window
 ;
 ; Input
 ;  <none>
 ; Output
 ;  Y array of the hints for TxF's> Y(#)=TxFA ^ TxF line # ^ hint text
 ;    where TxFA is Treatment Factor acronym, e.g., CV=Combat Veteran
 ; Variables
 ;  CT      = line number count, used in Y(#) where #=CT
 ;  I       = incrementor index #
 ;  ORTFIEN = the IEN for the TxF in the Help Frame (^DIC(9.2)) file
 ;  TF      = TxF acronym
 ;  TFLN    = TxF text line number, e.g., ^DIC(9.2,ORTFIEN,1,TFLN,0)
 ;  TFS     = string of TxF acronyms
 ;  TFV     = TxF description/text
 ;
 N CT,I,ORTFIEN,TF,TFLN,TFS,TFV
 ;
 S TFS="SC^MST^AO^IR^EC^HNC^CV^SHD",CT=0
 ; Get next TxF from TFS
 F I=1:1 S TF=$P(TFS,U,I) Q:TF=""  D
 . S ORTFIEN=$O(^DIC(9.2,"B","ORBA-"_TF,"")),TFV="",TFLN=0
 . ; Get next line of hint text
 . F  S TFLN=$O(^DIC(9.2,ORTFIEN,1,TFLN)) Q:'TFLN  D
 .. S CT=CT+1,Y(CT)=TF_U_TFLN_U_^DIC(9.2,ORTFIEN,1,TFLN,0)
 Q
 ;
DG1(ORDFN,COUNTER,CTVALUE) ; Create DG1 segment(s) & make call for ZCL seg.
 ;
 ;  Input
 ;    ORDFN      Internal Order ID#
 ;    COUNTER    Variable used as counter from calling routine
 ;    CTVALUE    Value of COUNTER when DG1 called
 ;  Output
 ;    DG1 & ZCL HL7 segments
 ;
 I $$BASTAT^ORWDBA1=0 Q  ;BA not used
 N DG13,DXIEN,DXR,DXV,FROMFILE,ICD9,OCT,OREC,ORFMDAT
 ; zero order count variable
 S OCT=0
 ; Get the date of order (for CSV/CTD usage)
 S ORFMDAT=$$ORFMDAT(ORDFN)
 ; Get the diagnoses for an order
 F  S OCT=$O(^OR(100,ORDFN,5.1,OCT)) Q:OCT'?1N.N  D
 . S OREC=^OR(100,ORDFN,5.1,OCT,0)
 . S DXIEN=$P(OREC,U)  ; DXIEN=pointer to diagnosis (ICD9) file #80
 . ; the DXIEN pointer should point to a valid diagnosis (after all is
 . ;   was previously entered .. but just in case ...)
 . S (DXV,ICD9)=""
 . I DXIEN'="" D
 .. S DXR=$$ICDDX^ICDCODE(DXIEN,ORFMDAT) Q:+DXR=-1
 .. ; Get diagnosis verbiage and ICD code
 .. S DXV=$P(DXR,U,4),ICD9=$P(DXR,U,2)
 . S FROMFILE=80
 . S DG13=DXIEN_U_DXV_U_FROMFILE_U_ICD9_U_DXV_U_"ICD9"
 . S CTVALUE=CTVALUE+1
 . S ORMSG(CTVALUE)="DG1"_"|"_OCT_"||"_DG13_"|||||||||||||"
 . D ZCL
 S @COUNTER=CTVALUE
 Q
 ;
ZCL ;create all the ZCL segments (currently 8 TxF's) for order number OCT
 ;
 N I,J,TABLE,TF,TFGBL,TFGUI,TFTBL,TFIN,TFS,VALUE
 D TFSTGS^ORWDBA1  ;set string sequence of treatment factors
 ; TFS is TxF data in ^OR(100,ORIEN,5.2) order
 S TFS=$G(^OR(100,ORDFN,5.2)),TABLE=""
 ; conversion order from ^OR stored data and Table SD008 for HL7 msg
 ; convert so that the ZCL segments will be in Table SD008 order (1-8)
 F I=1:1:8 S TF=$P(TFTBL,U,I) F J=1:1:8 I $P(TFGBL,U,J)=TF S TABLE=TABLE_J Q
 F TFIN=1:1:8 D
 . ; ORMSG counter incremented
 . S CTVALUE=CTVALUE+1
 . ; TF VALUE=0 for no or 1 for yes (only if not req. is it null)
 . S VALUE=$P(TFS,U,$E(TABLE,TFIN))
 . I VALUE="?" S VALUE=0  ;temp fix if sending '?' to ancillary???
 . ; for Table SD008: OCT=Set ID, SCIN=O/P Classif. Type, VALUE=Value
 . S ORMSG(CTVALUE)="ZCL|"_OCT_"|"_TFIN_"|"_VALUE
 Q
 ;
BDOSTR ;Store backdoor order DG1 and ZCL messages from HL7
 ;Processes one order per entry into BDOSTR, e.g., ROUT(1)
 ;Depends upon ORM* routines to set-up a number of variables including
 ;  ORMSG array and ORIFN.
 ;ORM* routines calling BDOSTR: ORMGMRC, ORMLR, ORMPS, & ORMRA
 ;
 ; Input:   HL7 messages and related data
 ; Output:  ROUT array in Delphi GUI format, i.e.
 ;          OrderIEN;11CNNNCNN^exDx1^exDx2^exDx3^exDx4
 ;
 ; Variables Used
 ;  DG1      = sequential numbered array with a value of DXIEN
 ;  I,J      = counters
 ;  GUITF    = GUI order treatment factors (TxF)
 ;  NDX      = number of diagnoses being passed
 ;  NTF      = number of TxF
 ;  OBX      = @ORMSG Dx array element # (max of 4 diagnoses stored)
 ;  REC      = set to sequential HL7 messages, contains HL7 message data
 ;  ROUT     = record sent for storage processing to RCVORCI
 ;  TF       = individual TxF values
 ;  TFGBL    = TxF acronyms in ^ delimited string in ^OR sequence
 ;  TFGUI    = TxF acronyms in ^ delimited string in from GUI sequence
 ;  TFTBL    = TxF acronyms in ^ delimited string in Table SD008 sequence
 ;  VAL      = individual TxF values
 ;  ZCL      = TxF in Table SD008 format and sequence
 ;
 ; See if CIDC master switch set, if not then no DG1/ZCL seg, to store
 I $$BASTAT^ORWDBA1=0 Q  ;CIDC (nee BA) not used
 ;
 N CPNODE,CT,DG1,I,J,GUITF,NDX,NTF,OBX,REC,ROUT,ORSDCARY,SDCARYA
 N TF,TFGBL,TFGUI,TFTBL,VAL,X,ZCL
 ;
 K ORSDCARY,SDCARYA
 D TFSTGS^ORWDBA1  ;set string sequence of treatment factors
 S (CT,NDX,OBX)=0,NTF=8,(CPNODE,GUITF,TF,Y,ZCL)="",X="T"
 ; Call API to acquire Treatment Factors in force
 D NOW^%DTC,CL^SDCO21(DFN,%,"",.ORSDCARY)  ;DBIA 406
 ; Retrved array order: AO,IR,SC,EC,MST,HNC,CV,SHD, e.g., ORSDCARY(3) for SC
 ; Convert to character array, e.g., SDCARYA("SC")=""
 F I=1:1:NTF S:$D(ORSDCARY(I)) SDCARYA($P("AO^IR^SC^EC^MST^HNC^CV^SHD",U,I))=""
 ; Process only four DG1 segments and first set of ZCL segments
 F  S OBX=$O(@ORMSG@(OBX)) Q:OBX'>0  S J=$E(@ORMSG@(OBX),1,3) I J="DG1"!(J="ZCL"&($P(@ORMSG@(OBX),"|",2)=1)) D
 . S REC=@ORMSG@(OBX)
 . ; Setting DG1(#)=DXIEN where # is Dx sequence # (1=primary)
 . I J="DG1"&(NDX<4) S DG1($P(REC,"|",2))=$P(REC,U,4),NDX=NDX+1 Q
 . ; Create ZCL string of TxFs, e.g., 1101011
 . I J="ZCL" D
 .. S:$P(REC,"|",4)="" $P(REC,"|",4)=" "
 .. S $E(ZCL,$P(REC,"|",3))=$P(REC,"|",4)
 ; convert order and format from Table SD008 to GUI
 F I=1:1:NTF S TF=$P(TFGUI,U,I) F J=1:1:NTF I $P(TFTBL,U,J)=TF D
 . ; If patient does not have that Tx Factor (TF) then ghost in GUI ("N")
 . I '$D(SDCARYA(TF)) S GUITF=GUITF_"N" Q
 . ; If patient has TF then format for GUI (C=ck'd, U=unck'd, ?=not ans)
 . S VAL=$E(ZCL,J),GUITF=GUITF_$S(VAL=1:"C",VAL=0:"U",1:"?")
 ; Create output string in a format that can be stored by RCVORCI^ORWDBA1
 S ROUT(1)=ORIFN_";11"_GUITF_U_$G(DG1(1))_U_$G(DG1(2))_U_$G(DG1(3))_U_$G(DG1(4))
 ; Store diagnoses and treatment factors
 D RCVORCI^ORWDBA1(Y,.ROUT)
 Q
 ;
ERRMSG(VISIT) ; Error handling and message
 ; to be determined
 Q
