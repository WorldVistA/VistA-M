PXRMRPCD ;SLC/PJH - PXRM REMINDER DIALOG ;11/04/2009
 ;;2.0;CLINICAL REMINDERS;**16**;Feb 04, 2005;Build 119
 ;
 ; Used by CPRS - see DBIA #3295/#3296/#3332
 ;
 ;
CATEGORY(ORY,CIEN) ;Get category information
 ;
 ; Input parameter Category ien [#811.7]
 ;
 N DATA,IC,IEN,NAME,PNAME,RIEN,SEQ,SUB,TEMP,USAGE
 S IC=0
 ;Get category name
 S NAME=$G(^PXRMD(811.7,CIEN,0)) I NAME="" Q
 ;
 ;Sort Reminders from this category into display sequence
 S SUB=0 K TEMP
 F  S SUB=$O(^PXRMD(811.7,CIEN,2,SUB)) Q:SUB=""  D
 .S DATA=$G(^PXRMD(811.7,CIEN,2,SUB,0)) Q:DATA=""
 .S RIEN=$P(DATA,U) Q:'RIEN
 .S SEQ=$P(DATA,U,2)_0
 .;Include only CPRS reminders
 .S USAGE=$P($G(^PXD(811.9,RIEN,100)),U,4) I USAGE'["C",USAGE'["*" Q
 .I USAGE["L"!(USAGE["O") Q
 .;Skip inactive reminders
 .S DATA=$G(^PXD(811.9,RIEN,0)) Q:DATA=""  Q:$P(DATA,U,6)
 .S NAME=$P(DATA,U) I NAME="" S NAME="Unknown"
 .;or printname
 .S PNAME=$P(DATA,U,3)
 .S TEMP(SEQ)=RIEN_U_NAME_U_PNAME
 ;
 ;Re-save reminders in output array for display
 ;type^reminder ien^name
 ;
 S SEQ=""
 F  S SEQ=$O(TEMP(SEQ)) Q:SEQ=""  D
 .S IC=IC+1,ORY(IC)="R"_U_TEMP(SEQ)
 ;
 ;Sort Sub-Categories for this category into display order
 S SUB=0 K TEMP
 F  S SUB=$O(^PXRMD(811.7,CIEN,10,SUB)) Q:SUB=""  D
 .S DATA=$G(^PXRMD(811.7,CIEN,10,SUB,0)) Q:DATA=""
 .S IEN=$P(DATA,U) Q:'IEN
 .S SEQ=$P(DATA,U,2),TEMP(SEQ)=IEN
 ;
 ;Save sub categories
 S SEQ=""
 F  S SEQ=$O(TEMP(SEQ)) Q:SEQ=""  D
 .S SUB=TEMP(SEQ) Q:'SUB
 .S NAME=$P($G(^PXRMD(811.7,SUB,0)),U) Q:NAME=""
 .S IC=IC+1,ORY(IC)="C"_U_SUB_U_NAME
 Q
 ;
DIALOG(ORY,ORDLG,DFN) ;Load dialog
 ;
 ; Input parameter ORDLG - dialog ien [#801.41]
 ;
 I 'ORDLG S ORY(1)="-1^dialog ien not specified" Q
 ;
 ;Check if a reminder dialog and enabled
 N DATA
 S DATA=$G(^PXRMD(801.41,ORDLG,0))
 ;
 I $P(DATA,U,4)'="R" S ORY(1)="-1^reminder dialog invalid" Q
 ;
 I $P(DATA,U,3) S ORY(1)="-1^reminder dialog disabled" Q
 ;
 ;Load dialog lines into local array
 D LOAD^PXRMDLL(ORDLG,$G(DFN))
 Q
 ;
EDITPAR(PAR) ;Edit CPRS GUI Version 15 parameters
 ;
 ;This is an entry action in the PXRM CPRS CONFIGURATION menu options
 ;
 ;Check if Patch 85 has been installed
 I '$$FIND1^DIC(8989.51,"","AMX",PAR) D  Q
 .W !!,"This option requires CPRS GUI Version 15" H 1
 ;
 ;Edit Parameter Definition
 D EDITPAR^XPAREDIT(PAR)
 Q
 ;
SEL(ORY) ;Selectable reminders and categories
 N CIEN,CNAM,CNT,DATA,RCLASS,RNAM,RPNAM,RIEN,TYPE,USAGE
 ;
 ;Reminders in print name order
 S TYPE="R",RPNAM="",CNT=0
 F  S RPNAM=$O(^PXD(811.9,"D",RPNAM)) Q:RPNAM=""  D
 .S RIEN=0
 .F  S RIEN=$O(^PXD(811.9,"D",RPNAM,RIEN)) Q:'RIEN  D
 ..;Include only CPRS reminders
 ..S USAGE=$P($G(^PXD(811.9,RIEN,100)),U,4) I USAGE'["C",USAGE'["*" Q
 ..I USAGE["L"!(USAGE["O") Q
 ..;Skip inactive reminders
 ..S DATA=$G(^PXD(811.9,RIEN,0)) Q:DATA=""  Q:$P(DATA,U,6)
 ..S RNAM=$P(DATA,U),RCLASS=$P($G(^PXD(811.9,RIEN,100)),U)
 ..S CNT=CNT+1,ORY(CNT)=TYPE_U_RIEN_U_RPNAM_U_RNAM_U_RCLASS
 ;
 ;Categories in name order
 S TYPE="C",CNAM=""
 F  S CNAM=$O(^PXRMD(811.7,"B",CNAM)) Q:CNAM=""  D
 .S CIEN=$O(^PXRMD(811.7,"B",CNAM,"")) Q:'CIEN
 .S CNT=CNT+1,ORY(CNT)=TYPE_U_CIEN_U_CNAM
 Q
