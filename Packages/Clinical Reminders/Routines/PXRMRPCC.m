PXRMRPCC ;SLC/PJH - PXRM REMINDER DIALOG ;11/26/2007
 ;;2.0;CLINICAL REMINDERS;**6**;Feb 04, 2005;Build 123
 ;
ACTIVE(ORY,ORREM) ;Check if active dialog exist for reminders
 ;
 ; input parameter ORREM is array of reminder ien [.01#811.9]
 N DDIS,DIEN,OCNT,RIEN,RSTA
 S OCNT=0,RIEN=0
 ;Get reminder ien from array
 F  S RIEN=$O(ORREM(RIEN)) Q:'RIEN  D
 .;Dialog ien for reminder
 .S DIEN=$P($G(^PXD(811.9,RIEN,51)),U),RSTA=0
 .;Dialog status
 .I DIEN S DDIS=$P($G(^PXRMD(801.41,DIEN,0)),U,3)
 .;If dialog and dialog not disabled
 .I DIEN,DDIS="" S RSTA=1
 .;Return reminder and if active dialog exists
 .S OCNT=OCNT+1,ORY(OCNT)=RIEN_U_RSTA
 Q
 ;
 ;
DIALOG(ORY,ORREM,DFN) ;Load reminder dialog associated with the reminder
 ;
 ; input parameter ORREM - reminder ien [.01,#811.9]
 ;
 S RIEN=ORREM
 N DATA,DIEN
 S DIEN=$G(^PXD(811.9,ORREM,51))
 ;
 ;Quit if no dialog for this reminder
 I 'DIEN S ORY(1)="-1^no dialog for this reminder" Q
 ;
 ;Check if a reminder dialog and enabled
 S DATA=$G(^PXRMD(801.41,DIEN,0))
 ;
 I $P(DATA,U,4)'="R" S ORY(1)="-1^reminder dialog invalid" Q
 ;
 I $P(DATA,U,3) S ORY(1)="-1^reminder dialog disabled" Q
 ;
 ;Load dialog lines into local array
 S ORY(0)=0_U_+$P($G(^PXRMD(801.41,DIEN,0)),U,17)
 D LOAD^PXRMDLL(DIEN,$G(DFN))
 Q
 ;
HDR(ORY,ORLOC) ;Progress Note Header by location/service/user
 N ORSRV,PASS
 ;S ORSRV=$G(^VA(200,DUZ,5)) I +ORSRV>0 S ORSRV=$P(ORSRV,U)
 S ORSRV=$$GET1^DIQ(200,DUZ,29,"I")
 S PASS=DUZ_";VA(200,"
 I +$G(ORLOC) S PASS=PASS_"^LOC.`"_ORLOC
 I ORSRV>0 S PASS=PASS_"^SRV.`"_+$G(ORSRV)
 S ORY=$$GET^XPAR(PASS_"^DIV^SYS^PKG","PXRM PROGRESS NOTE HEADERS",1,"Q")
 Q
 ;
PROMPT(ORY,ORDLG,ORDCUR,ORFTYP) ;Load additional prompts for a dialog element
 ;
 ; input parameters
 ;
 ; ORDLG  - dialog element ien [.01,#801.41]
 ; ORDCUR - 0 = current, 1 = Historical for taxonomies only
 ; ORFTYP - finding type (CPT/POV) for taxonomies only
 ;
 ; These fields can be found in the output array of DIALOG^PXRMRPCC
 ;
 D LOAD^PXRMDLLA(ORDLG,ORDCUR,$G(ORFTYP))
 Q 
 ;
RES(ORY,ORREM) ; Reminder Resources/Inquiry
 ;
 ; input parameter ORREM - reminder ien [.01,#811.9]
 ;
 D REMVAR^PXRMINQ(.ORY,ORREM)
 Q
 ;
MH(ORY,OTEST) ; Mental Health dialog
 ;
 ; Input mental health instrument NAME
 ;
 K ^TMP($J,"YSQU")
 N ARRAY,CNT,CNT1,FNODE,FSUB,IC,NODE,OCNT,SUB,YS
 ;DBIA #5056
 S YS("CODE")=OTEST D SHOWALL^YTQPXRM5(.ARRAY,.YS)
 S OCNT=0,CNT=0
 S SUB="ARRAY",OCNT=0
 F  S SUB=$Q(@SUB) Q:SUB=""  D
 .S FSUB=$P($P(SUB,"(",2),")"),FNODE=""
 .F IC=1:1 S NODE=$P(FSUB,",",IC) Q:NODE=""  D
 ..I $E(NODE)="""" S NODE=$P(NODE,"""",2)
 ..S $P(FNODE,";",IC)=NODE
 .Q:FNODE=""
 .S OCNT=OCNT+1,ORY(OCNT)=FNODE_U_@SUB
 Q
 ;
MHR(ORY,RESULT,ORES) ; Mental Health score and P/N text
 ;
 ; Input MH result IEN and mental health instrument response
 ;
 D START^PXRMDLR(.ORY,RESULT,.ORES)
 ;
 Q
 ;
MHS(ORY,YS) ; Mental Health save response
 ;
 ; Input mental health instrument response
 N ANS,ARRAY,X
 S ANS=$G(YS("R1")) K YS("R1")
 S YS("ADATE")=YS("ADATE")_"."_$P($$NOW^XLFDT,".",2)
 F X=1:1:$L(ANS) I $E(ANS,X)'="X" S YS(X)=X_U_$E(ANS,X)
 ;DBIA #4463
 D SAVECR^YTQPXRM4(.ARRAY,.YS)
 Q
 ;
MST(ORY,DFN,DGMSTDT,DGMSTSC,DGMSTPR,FTYP,FIEN,RESULT) ; File MST status
 ;This is obsolete and can be removed when the GUI is changed not
 ;to use it.
 Q
 ;
WH(ORY,RESULT) ;
 N CNT,CNT1,CNT2,NODE,PIECNT,PUR,TYPE,TYP1,WVIEN,WVRESULT,WVNOT,WVPURIEN
 N PRINT
 K ^TMP("WV RPT",$J)
 I '$D(RESULT) Q
 S (CNT2,WVPURIEN,PUR)=0
 S CNT=0 F  S CNT=$O(RESULT(CNT)) Q:CNT=""  D
 . I $P($G(RESULT(CNT)),U)["WHIEN" D
 . . S CNT2=CNT2+1
 . . S WVIEN=$P($P($G(RESULT(CNT)),U),":",2),WVRESULT(CNT2)=$G(WVIEN)
 . . S WVRESULT(CNT2)=WVRESULT(CNT2)_U_$P($P($G(RESULT(CNT)),U,3),":",2)
 . I $P($G(RESULT(CNT)),U)["WHPur" D
 . . S NODE=$G(RESULT(CNT)),PUR=$P($P($G(NODE),U),":",2)
 . . S CNT1=1,TYPE=$P($G(NODE),U,2)
 . . I TYPE'[":" D
 ...S WVNOT(PUR,CNT1)=$P($G(NODE),U,5)_U_$P($G(NODE),U,2)_U_$P($G(NODE),U,3)_U_$P($P($G(NODE),U,4),":",2)
 ..I TYPE[":" D
 ...S PIECNT=0
 ...F X=1:1:$L(TYPE) I $E(TYPE,X)=":" S PIECNT=PIECNT+1 I PIECNT>0 D
 ....S PRINT=""
 ....S TYP1=$P($G(TYPE),":",PIECNT)
 ....I TYP1="L" S PRINT=$P($G(NODE),U,3)
 ....S WVNOT(PUR,CNT1)=$P($G(NODE),U,5)_U_$G(TYP1)_U_$G(PRINT)_U_$P($P($G(NODE),U,4),":",2),CNT1=CNT1+1
 ...S PIECNT=PIECNT+1
 ...S PRINT=""
 ...S TYP1=$P($G(TYPE),":",PIECNT)
 ...I TYP1="L" S PRINT=$P($G(NODE),U,3)
 ...S WVNOT(PUR,CNT1)=$P($G(NODE),U,5)_U_$G(TYP1)_U_$G(PRINT)_U_$P($P($G(NODE),U,4),":",2)
 K WHMUFIND,WHFIND,WHNAME
 ;DBIA #4104
 D NEW^WVRPCNO(.WVRESULT,.WVNOT)
 Q
 ;
