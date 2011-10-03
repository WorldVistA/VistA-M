PXRMRPCA ; SLC/PJH - Functions returning REMINDER data ;11/04/2009
 ;;2.0;CLINICAL REMINDERS;**12,16**;Feb 04, 2005;Build 119
 Q
 ;
ALL(ORY) ;All active reminders
 ;print name^ien
 N ARR,DATA,NAME,ORREM,OCNT,SUB,USAGE
 S ORREM=0
 F  S ORREM=$O(^PXD(811.9,ORREM)) Q:'ORREM  D
 .;Include only CPRS reminders
 .S USAGE=$P($G(^PXD(811.9,ORREM,100)),U,4)
 .I USAGE["L" Q
 .I USAGE["O" Q
 .I USAGE'["C",USAGE'["*" Q
 .S DATA=$G(^PXD(811.9,ORREM,0)) Q:DATA=""
 .;Skip inactive reminders
 .I $P(DATA,U,6) Q
 .;Skip reminders with no name
 .S NAME=$P(DATA,U,3) I NAME="" Q
 .;Sort by name
 .S ARR(NAME_U_ORREM)=""
 ; Build output arrray
 S SUB="",OCNT=0
 F  S SUB=$O(ARR(SUB)) Q:SUB=""  D
 .S OCNT=OCNT+1
 .S ORY(OCNT)=SUB
 Q
 ;
APPL(ORY,ORPT,ORLOC) ;Applicable reminders for cover sheet
 ;format file 811.9 ien^reminder print name^date due^last occur^prty^due.
 N ORSRV,TMPLST,ERR,ORI,ORJ,ORIEN,ORTXT,ORX,ORLASTDT,ORDUEDT
 N ORDUE,ORPRI,ORSTA,PASS
 S ORJ=0
 S ORSRV=$$GET1^DIQ(200,DUZ,29)
 I ORLOC S PASS="USR^LOC.`"_$G(ORLOC)_"^SRV.`"_+$G(ORSRV)_"^DIV^SYS^PKG"
 I 'ORLOC S PASS="USR^SRV.`"_+$G(ORSRV)_"^DIV^SYS^PKG"
 D GETLST^XPAR(.TMPLST,PASS,"ORQQPX SEARCH ITEMS","Q",.ERR) ; DBIA #3076
 I ERR>0 S ORY(1)=U_"Error: "_$P(ERR,U,2) Q
 D AVAL(.TMPLST,2) ;Evaluate reminders
 Q
 ;
ALIST(ORY,ORPT,LIST) ;Evaluate specific reminders
 N ORSRV,ORI,ORJ,ORIEN,ORTXT,ORX,ORLASTDT,ORDUEDT,ORLOC
 N ORDUE,ORPRI,ORSTA
 S ORJ=0
 D AVAL(.LIST,1)
 Q
 ;
AVAL(ARRAY,POS) ;Evaluate array of reminders
 S ORI=0 F  S ORI=$O(ARRAY(ORI)) Q:'ORI  D
 .S ORIEN=$P(ARRAY(ORI),U,POS)
 .K ^TMP("PXRHM",$J)
 . I $$INACTIVE^PXRM(ORIEN) Q
 .;Evaluate reminder
 .D MAIN^PXRM(ORPT,ORIEN,1,1)
 .;Not applicable is default
 .S ORDUE=2 D  Q:ORTXT=""
 ..S ORTXT="",ORTXT=$O(^TMP("PXRHM",$J,ORIEN,ORTXT)) Q:ORTXT=""
 ..;Determine status
 ..S ORX=^TMP("PXRHM",$J,ORIEN,ORTXT) Q:ORX=""
 ..S ORSTA=$P(ORX,U)
 ..;Ignore reminders that are not applicable
 ..I (ORSTA=" ")!(ORSTA["NEVER")!(ORSTA="N/A") Q
 ..;Differentiate due and applicable
 ..S ORDUE=0 I ORSTA["DUE" S ORDUE=1
 ..I ORSTA["ERROR" S ORDUE=3
 ..I ORSTA["CNBD" S ORDUE=4
 ..;Get next due and last done dates 
 ..S ORDUEDT=$P(ORX,U,2),ORLASTDT=$P(ORX,U,3)
 ..S ORLASTDT=$S(+$G(ORLASTDT)>0:ORLASTDT,1:"")  ;null if not a date
 ..;Reminder priority
 ..S ORPRI=$P($G(^PXD(811.9,ORIEN,0)),U,10)
 ..;Default is 2 for medium
 ..I ORPRI="" S ORPRI=2
 ..S ORJ=ORJ+1
 ..S ORY(ORJ)=ORIEN_U_ORTXT_U_ORDUEDT_U_ORLASTDT_U_ORPRI_U_ORDUE_U_$$DLG(ORIEN)_U_U_U_U_$$DLGWIPE(ORIEN)
 .;Save not applicables also (IF a valid reminder)
 .I ORDUE=2 D
 ..S ORJ=ORJ+1
 ..S ORY(ORJ)=ORIEN_U_ORTXT_U_U_U_U_ORDUE_U_$$DLG(ORIEN)_U_U_U_U_$$DLGWIPE(ORIEN)
 K ^TMP("PXRHM",$J)
 Q
 ;
CATEGORY(ORY,ORPT,ORLOC) ;Reminder Categories
 ;type^name^ien^parent^child^etc
 N ERR,IC,ORSRV,PASS,TEMPLST
 ;Get user's service 
 ;S ORSRV=$G(^VA(200,DUZ,5)) I +ORSRV>0 S ORSRV=$P(ORSRV,U)
 S ORSRV=$$GET1^DIQ(200,DUZ,29)
 ;Build list of locations and services required
 I ORLOC S PASS="USR^LOC.`"_$G(ORLOC)_"^SRV.`"_+$G(ORSRV)_"^DIV^SYS^PKG"
 I 'ORLOC S PASS="USR^SRV.`"_+$G(ORSRV)_"^DIV^SYS^PKG"
 ;
 ;Get list of categories from GUI parameters file
 D GETLST^XPAR(.TMPLST,PASS,"PXRM CPRS LOOKUP CATEGORIES","Q",.ERR)
 ;If error return error type
 I ERR>0 S ORY(1)=U_"Error: "_$P(ERR,U,2) Q
 ;
 ;For each category build tree of reminders/subcategories
 N CNT,LEVEL,ORCAT,UNIQ
 S CNT="",IC=0,LEVEL=0,UNIQ=0
 ;For each category in 'PXRM CPRS LOOKUP CATEGORIES'
 F  S CNT=$O(TMPLST(CNT)) Q:'CNT  D
 .;Get category ien
 .S ORCAT=$P(TMPLST(CNT),U,2)
 .;Update unique number
 .S UNIQ=UNIQ+1
 .;Add category and associated reminders/subcategories to output array
 .D GETLST(0,ORCAT,0,UNIQ)
 Q
 ;
DLG(REM) ;Dialog check
 N DATA,DIEN,DOK
 S DIEN=$P($G(^PXD(811.9,REM,51)),U) Q:'DIEN 0
 S DATA=$G(^PXRMD(801.41,DIEN,0))
 I $P(DATA,U,4)="R",+$P(DATA,U,3)=0 Q 1
 Q 0
 ;
DLGWIPE(REM) ;Dialog check
 N DATA,DIEN,DOK
 S DIEN=$P($G(^PXD(811.9,REM,51)),U) Q:'DIEN 0
 I $P($G(^PXRMD(801.41,DIEN,0)),U,17)=1 Q 1
 Q 0
 ;
GETLST(D0,D1,LEVEL,PARENT) ;Add to output array
 N DATA,NAME,ORREM,ORSCAT,PCAT,SEQ,SUB,TEMP,USAGE
 ;Get category ien if this is a sub-category
 S PCAT=0 I LEVEL>0 D  Q:ORSCAT=""  S UNIQ=UNIQ+1,PARENT=UNIQ
 .S ORSCAT=$P($G(^PXRMD(811.7,D0,10,D1,0)),U),PCAT=PARENT
 ;Otherwise use passed ien
 I LEVEL=0 S ORSCAT=D1
 ;Get category name
 S NAME=$G(^PXRMD(811.7,ORSCAT,0)) I NAME="" Q
 ;
 ;Create category entry in output array
 ;unique number^type^name^parent^reminder ien
 ;
 S IC=IC+1,ORY(IC)=PARENT_U_"C"_U_NAME_U_PCAT_U
 ;Increment tab
 S LEVEL=LEVEL+1
 ;
 ;Sort Reminders from this category into display sequence
 S SUB=0 K TEMP
 F  S SUB=$O(^PXRMD(811.7,ORSCAT,2,SUB)) Q:SUB=""  D
 .S DATA=$G(^PXRMD(811.7,ORSCAT,2,SUB,0)) Q:DATA=""
 .S ORREM=$P(DATA,U) Q:ORREM=""
 .S SEQ=$P(DATA,U,2)_0
 .;Skip inactive reminders
 .S DATA=$G(^PXD(811.9,ORREM,0)) Q:DATA=""  Q:$P(DATA,U,6)
 .;Include only CPRS reminders
 .S USAGE=$P($G(^PXD(811.9,ORREM,100)),U,4) I USAGE'["C",USAGE'["*" Q
 .I USAGE["L"!(USAGE["O") Q
 .S NAME=$P(DATA,U) I NAME="" S NAME="Unknown"
 .;or printname
 .S NAME=$P(DATA,U,3)
 .S TEMP(SEQ)=NAME_U_ORREM
 ;
 ;Re-save reminders in output array for display
 ;unique number^type^name^parent^reminder ien
 ;
 S SEQ=""
 F  S SEQ=$O(TEMP(SEQ)) Q:SEQ=""  D
 .S NAME=$P(TEMP(SEQ),U),ORREM=$P(TEMP(SEQ),U,2)
 .S UNIQ=UNIQ+1
 .S IC=IC+1,ORY(IC)=UNIQ_U_"R"_U_NAME_U_PARENT_U_ORREM_U_$$DLG(ORREM)
 ;
 ;Sort Sub-Categories for this category into display order
 S SUB=0 K TEMP
 F  S SUB=$O(^PXRMD(811.7,ORSCAT,10,SUB)) Q:SUB=""  D
 .S DATA=$G(^PXRMD(811.7,ORSCAT,10,SUB,0)) Q:DATA=""
 .S SEQ=$P(DATA,U,2),TEMP(SEQ)=SUB
 ;
 ;Process sub-sub categories in the same manner
 S SEQ=""
 F  S SEQ=$O(TEMP(SEQ)) Q:SEQ=""  D
 .S SUB=TEMP(SEQ)
 .D GETLST(ORSCAT,SUB,LEVEL,PARENT)
 Q
 ;
LIST(ORY,ORPT,ORLOC) ;Reminders for this patient location (not evaluated)
 ;format file 811.9 ien
 N ORSRV,TMPLST,ERR,ORI,ORJ,ORIEN,ORTXT,ORX,ORLASTDT,ORDUEDT
 N CNT,ORIEN,ORDUE,ORPRI,ORSTA,PASS,SUB
 S ORJ=0
 ;
 S ORSRV=$$GET1^DIQ(200,DUZ,29)
 I ORLOC S PASS="USR^LOC.`"_$G(ORLOC)_"^SRV.`"_+$G(ORSRV)_"^DIV^SYS^PKG"
 I 'ORLOC S PASS="USR^SRV.`"_+$G(ORSRV)_"^DIV^SYS^PKG"
 D GETLST^XPAR(.TMPLST,PASS,"ORQQPX SEARCH ITEMS","Q",.ERR) ; DBIA #3076
 I ERR>0 S ORY(1)=U_"Error: "_$P(ERR,U,2) Q
 ;
 S CNT=0,SUB=""
 F  S SUB=$O(TMPLST(SUB)) Q:'SUB  D
 .S ORIEN=$P(TMPLST(SUB),U,2) Q:'ORIEN  Q:'$D(^PXD(811.9,ORIEN,0))
 .S CNT=CNT+1,ORY(CNT)=ORIEN
 Q
 ;
REMDET(ORY,ORPT,ORIEN) ;return detail for a pt's clinical reminder
 ; ORY - return array
 ; ORPT - patient DFN
 ; ORIEN - clinical reminder (811.9 ien)
 K ^TMP("PXRHM",$J)
 D MAIN^PXRM(ORPT,ORIEN,5,1)     ; 5 returns all reminder info
 N CR,I,J,ORTXT,SCT,STA,STA1,STA2,STA3 S I=1,J=0
 S ORTXT="",ORTXT=$O(^TMP("PXRHM",$J,ORIEN,ORTXT)) Q:ORTXT=""
 S STA=$G(^TMP("PXRHM",$J,ORIEN,ORTXT)) I STA'="" D
 .S STA(1)=$P(STA,U),STA(2)=$P(STA,U,2),STA(3)=$P(STA,U,3)
 .F SCT=1,2,3 I STA(SCT) S STA(SCT)=$$FMTE^XLFDT(STA(SCT),"5D")
 .S ORY(I)="  --STATUS--  --DUE DATE--  --LAST DONE--",I=I+1
 .S ORY(I)=$J(STA(1),10)_$J(STA(2),13)_$J(STA(3),14),I=I+1
 F  S J=$O(^TMP("PXRHM",$J,ORIEN,ORTXT,"TXT",J)) Q:J=""  D
 .S ORY(I)=^TMP("PXRHM",$J,ORIEN,ORTXT,"TXT",J),I=I+1
 K ^TMP("PXRHM",$J)
 Q
 ;
WEB(ORY,ORRM) ;web page call
 ;web site description^address
 N ADDR,CNT,DATA,DESC,LINE,SUB,TITLE,TXT,UNIQ
 S DESC="",CNT=0,UNIQ=0
 ;Get the reminder specific web sites in alpha order
 I ORRM]"" D
 .F  S DESC=$O(^PXD(811.9,ORRM,50,"B",DESC)) Q:DESC=""  D
 ..S SUB=0
 ..F  S SUB=$O(^PXD(811.9,ORRM,50,"B",DESC,SUB)) Q:'SUB  D
 ...S ADDR=$P($G(^PXD(811.9,ORRM,50,SUB,0)),U) Q:ADDR=""
 ...S TITLE=$P($G(^PXD(811.9,ORRM,50,SUB,0)),U,2)
 ...S UNIQ=UNIQ+1,CNT=CNT+1,ORY(CNT)=1_U_UNIQ_U_ADDR_U_TITLE,LINE=0
 ...F  S LINE=$O(^PXD(811.9,ORRM,50,SUB,1,LINE)) Q:'LINE  D
 ....S TXT=$G(^PXD(811.9,ORRM,50,SUB,1,LINE,0)) Q:TXT=""
 ....S CNT=CNT+1,ORY(CNT)=2_U_UNIQ_U_TXT
 ;Get the general web sites in alpha order
 F  S DESC=$O(^PXRM(800,1,1,"B",DESC)) Q:DESC=""  D
 .S SUB=0
 .F  S SUB=$O(^PXRM(800,1,1,"B",DESC,SUB)) Q:'SUB  D
 ..S ADDR=$P($G(^PXRM(800,1,1,SUB,0)),U) Q:ADDR=""
 ..S TITLE=$P($G(^PXRM(800,1,1,SUB,0)),U,2)
 ..S UNIQ=UNIQ+1,CNT=CNT+1,ORY(CNT)=1_U_UNIQ_U_ADDR_U_TITLE,LINE=0
 ..F  S LINE=$O(^PXRM(800,1,1,SUB,1,LINE)) Q:'LINE  D
 ...S TXT=$G(^PXRM(800,1,1,SUB,1,LINE,0)) Q:TXT=""
 ...S CNT=CNT+1,ORY(CNT)=2_U_UNIQ_U_TXT
 Q
