DG53754B ;ALB/TDM - POST-INSTALL DG*5.3*754 ; 12/16/10 9:53am
 ;;5.3;Registration;**754**;Aug 13, 1993;Build 46
 Q
EN ;Post-install entry point
 N X,Y,DMAX,ZTMP
 S DMAX=$$ROUSIZE^DILF
 D BMES^XPDUTL("Re-compiling input templates")
 D ADDPTID
 D RECOMP("DG LOAD EDIT SCREEN 7","DGRPX7")
 Q
 ;
RECOMP(ZTMP,X) ;Recompile Input Templates
 Q:((ZTMP="")!(X=""))
 S Y=$$FIND1^DIC(.402,"","MX",ZTMP)
 I Y<0 D BMES^XPDUTL("Error re-compiling '"_ZTMP_"' input template") Q
 D EN^DIEZ
 D BMES^XPDUTL("' "_ZTMP_"' input template has been re-compiled.")
 Q
 ;
ADDPTID ; DBIA #4139 - This is a one-time agreement to allow Registration to
 ; set the IDENTIFIER node as follows for the PATIENT (#2) file:
 ; ^DD(2,0,"ID",.03)="D EN^DDIOL($TR($$DOB^DPTLK1(Y,1),""/"",""-""),,""?$X+2"")"
 ; 
 ; This api will add the IDENTIFIER parameter back to the PATIENT
 ; file (#2).  It was an unknown fact that the IDENTIFIER parameter
 ; would be removed when the DG*5.3*754 pre-init routine (DG53754P)
 ; initialized the field definition for the DATE OF BIRTH field (#.03)
 ; from the PATIENT file (#2).
 ;
 S ^DD(2,0,"ID",.03)="D EN^DDIOL($TR($$DOB^DPTLK1(Y,1),"_"""/"""_","_"""-"""_"),,"_"""?$X+2"""_")"
 Q
