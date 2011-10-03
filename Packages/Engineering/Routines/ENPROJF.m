ENPROJF ;WISC/SAB-Project Tracking Enter/Edit Form Code ;9/12/97
 ;;7.0;ENGINEERING;**28**;Aug 17, 1993
 Q
BASEPR ;Block ENPRBASE pre-action
 ; set up variables used by DD screens of fields on block
 S ENFT=$$GET^DDSVAL(6925,DA,158)
 S ENPR=$$GET^DDSVAL(6925,DA,155)
 S ENPCI=$$GET^DDSVAL(6925,DA,158.1)
 ; check fields for applicability - If N/A then delete & make uneditable
 ; bonus category n/a?
 I "^NR^SL^"'[(U_ENPR_U) D PUT^DDSVAL(6925,DA,158.8,"@"),UNED^DDSUTL("BONUS","","",1)
 ; epa reportable n/a?
 I "NR"'=ENPR D PUT^DDSVAL(6925,DA,158.6,"@"),UNED^DDSUTL("EPAR","","",1)
 ; epa reporting category n/a?
 I $$GET^DDSVAL(6925,DA,158.6)'="Y" D PUT^DDSVAL(6925,DA,158.7,"@"),UNED^DDSUTL("EPAC","","",1)
 Q
 ;
PRPSC ;Block ENPRBASE Field PROGRAM post-action on change
 ; check fields for applicability - If N/A then delete & make uneditable
 ; bonus category field?
 I "^NR^SL^"[(U_X_U) D UNED^DDSUTL("BONUS","","",0)
 I "^NR^SL^"'[(U_X_U) D PUT^DDSVAL(6925,DA,158.8,"@"),UNED^DDSUTL("BONUS","","",1)
 ; epa reportable field?
 I "NR"=X D UNED^DDSUTL("EPAR","","",0)
 I "NR"'=X D
 . D PUT^DDSVAL(6925,DA,158.6,"@"),UNED^DDSUTL("EPAR","","",1)
 . D PUT^DDSVAL(6925,DA,158.7,"@"),UNED^DDSUTL("EPAC","","",1)
 ; if existing program changed, delete project & budget categories
 I DDSOLD]"" D
 . N ENTXT
 . S ENTXT="Please enter appropriate Project and Budget Categories for the new Program."
 . D HLP^DDSUTL(.ENTXT)
 Q
 ;
PCPSC ;Block ENPRBASE Field PROJECT CATEGORY post-action on change
 ; trigger budget catgory field
 I X]"",$G(ENPR)]"",$D(^OFM(7336.8,X,1))#10 D
 . N ENBC,ENBCI,ENTXT
 . S ENBCI=$P(^OFM(7336.8,X,1),U,$F("MA,MI,MM,NR,",ENPR)\3)
 . S ENBCI(0)=$$GET^DDSVAL(6925,DA,158.2)
 . Q:ENBCI=ENBCI(0)!'ENBCI
 . S ENBC(0)=$$GET^DDSVAL(6925,DA,158.2,"","E")
 . D PUT^DDSVAL(6925,DA,158.2,ENBCI,"","I")
 . S ENTXT="The Budget Category has automatically been changed to the default value for the new project category."
 . I ENBC(0)]"" S ENTXT=ENTXT_" (The previous value was "_ENBC(0)_")."
 . D HLP^DDSUTL(.ENTXT)
 Q
 ;
RPNPSC ;Block ENPRCH Field 'Reload Previous Progress Note' postaction on change
 D:X
 . S ENOTE=$$GET^DDSVAL(6925,DA,146.1)
 . I ENOTE']"" D HLP^DDSUTL("Previous Progress Note not found.") Q
 . D PUT^DDSVAL(6925,DA,146,ENOTE)
 D PUT^DDSVALF("LOADNOTE","","","") ; clear form only field
 Q
 ;
NHPR ;Page pre-action for pages contains blocks ENPRNHCU, ENPRNHCUCONV
 ; Inform user when this page must be populated
 N ENCAT,ENFT,ENPR
 S ENFT=$$GET^DDSVAL(6925,DA,158)
 S ENCAT="",ENPR=$$GET^DDSVAL(6925,DA,155)
 I "^NR^SL^"[(U_ENPR_U) S ENCAT=$$GET^DDSVAL(6925,DA,158.8,"","E")
 I "^MA^MI^MM^"[(U_ENPR_U) S ENCAT=$$GET^DDSVAL(6925,DA,158.1,"","E")
 I ENFT'="VHA"!(ENCAT'["NHCU") D HLP^DDSUTL("This page is optional since the project category is not NHCU.")
 I ENFT="VHA",ENCAT["NHCU" D HLP^DDSUTL("The NHCU data must be entered since the project category is NHCU.")
 Q
 ;
MSL(DA) ; Milestone List Extrinsic Function
 ; Returns value with pieces (true/false) which indicate applicability
 ; of the corresponding 22 milestones
 N ENAM,ENCM,ENCAF,ENPR,ENX
 S ENPR=$$GET^DDSVAL(6925,DA,155) ; program
 S ENAM=$$GET^DDSVAL(6925,DA,7,"","E") ; a/e (design) method
 S ENCM=$$GET^DDSVAL(6925,DA,8,"","E") ; construction method
 S ENCAF=$$GET^DDSVAL(6925,DA,4,"","E") ; construction approved funding
 D MSLAP^ENPRUTL
 Q ENX
 ;
 ;ENPROJF
