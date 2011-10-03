RA86PST ;Hines OI/GJC - Post-init Driver, patch 86 ;06/26/07  10:44
VERSION ;;5.0;Radiology/Nuclear Medicine;**86**;Mar 16, 1998;Build 7
 ;
 ;Supported IA #10013 reference to ^DIK
 ;Removed the auditing for Requesting Location Field of file #75.1
 ;
 Q
 ;
PRE ;entry point for the pre-install logic.
 S DIK="^DD(75.1,",DA(1)=75.1,DA=22 D ^DIK
 K DA,DIK
 Q
 ;
EN ; entry point for the post-install logic
 ; re-compile RA REGISTER input template
 N X,Y,DMAX K RACTNAM,RADMAX,RAINPERR,RAINPNME S RADMAX=$$ROUSIZE^DILF
 S RAINPNME="RA REGISTER"
 S RACTNAM="RACTRG"
 D FIND^DIC(.402,"","","X",RAINPNME,"","B","","","RAINPARY","")
 I $P($G(RAINPARY("DILIST",0)),U)=0 S RAINPERR=$$ERROR(RAINPNME,0) Q
 I $P($G(RAINPARY("DILIST",0)),U)>1 S RAINPERR=$$ERROR(RAINPNME,-1) Q
 K DMAX,X,Y
 ;DMAX: maximum routine size
 ;   X: the name of the routine for the compiled input template; i.e. RACTRG
 ;   Y: the IEN of the input template to be compiled
 S DMAX=RADMAX,X=RACTNAM,Y=$G(RAINPARY("DILIST",2,1))
 D EN^DIEZ
 ;
 K RACTNAM,RADMAX,RAINPARY,RAINPERR,RAINPNME
 Q
 ;
 ; Integration Agreements utilized in this software
 ; 
 ; tag     routine  number   usage      custodian
 ; --------------------------------------------------
 ; EN      DIEZ     10002    supported  VA FileMan
 ; BMES    XPDUTL   10141    supported  KERNEL
 ; FIND    DIC      2051     supported  VA FileMan
 ; ROUSIZE DILF     2649     supported  VA FileMan
 ;
 ;   RADMAX=maximum routine size (bytes) for this system
 ;  RACTNAM=compiled input template name (fixed to input template)
 ; RAINPERR=error flag - default value is zero (no error condition)
 ;          a value of one if: the input template lookup failed or
 ;          expected compiled input template name is not associated
 ;          with the proper input template
 ; RAINPARY=local array where input template specific data is stored
 ; RAINPNME=input template name
 ;
ERROR(N,Y) ;This function set the error flag & records the error
 K RATXT
 S:Y=0 RATXT(1)="'"_N_"' was not found in the INPUT TEMPLATE (#.402) file."
 I Y=-1 D
 .S RATXT(1)="Multiple versions of '"_N_"' were found"
 .S RATXT(2)="in the INPUT TEMPLATE (#.402) file. Fix the"
 .S RATXT(3)="problem and manually recompile the input template using"
 .S RATXT(4)="the 'Template Compilation' [RA COMPILE TEMPLATES] option."
 .Q
 D BMES^XPDUTL(.RATXT) K RATXT
 Q 1
