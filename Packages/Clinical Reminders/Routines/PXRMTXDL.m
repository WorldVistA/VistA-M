PXRMTXDL ;SLC/PKR - Reminder Dialog Taxonomy edit routines ;10/31/2013
 ;;2.0;CLINICAL REMINDERS;**26**;Feb 04, 2005;Build 404
 ;
 ;===================================
CODEPOST ;Post Action on Change for the Code field of Use in Dialog Codes.
 N CODE,CODESYS,ERROR
 S CODE=$$GET^DDSVAL(811.24,.DA,.01,.ERROR)
 S CODESYS=$$GETCSYS^PXRMLEX(CODE)
 D PUT^DDSVAL(811.24,.DA,1,CODESYS,.ERROR)
 Q
 ;
 ;===================================
POSTSAVE(IEN) ;Form Post Save. Store changes in lists of codes.
 N CODE,CODESYS,CSYIND,FDA,KCSYSIND,KFDA,MSG,NSEL,NUID,PDS
 N PDS
 ;Make sure Patient Data Source index is built.
 S PDS=$$GET^DDSVAL(811.2,IEN,"PATIENT DATA SOURCE")
 I PDS="" D SPDS^PXRMPDS(IEN,PDS)
 Q
 ;
 ;===================================
SELECT ;Select the taxonomy to create or edit.
 N DIC,DLAYGO,IEN,Y
 S (DIC,DLAYGO)=811.2,DIC(0)="AEKL"
 S DIC("S")="I $P(^(100),U,1)'=""N"""
 D FULL^VALM1
 D ^DIC
 S IEN=$P(Y,U,1)
 I IEN=-1 S VALMBCK="R" Q
 ;Edit the taxonomy
 D SMANEDIT^PXRMTXSM(IEN,0,"PXRM DIALOG TAXONOMY EDIT")
 S VALMBCK="R"
 Q
 ;
