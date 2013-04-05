RA47PST ;Hines OI/GJC - Post-init Driver, patch 47 ;04/17/07  11:30
 ;;5.0;Radiology/Nuclear Medicine;**47**;Mar 16, 1998;Build 21
 ;
VERSION Q
 ;
EN ; entry point for the post-install logic
 ; make sure the [RA REGISTER] (RACTRG*) input template is
 ; re-compiled so user workflow is not interrupted.
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
 ; RAINP70=local array where input template specific data is stored
 ; RAINPNME=name on the input template to be compiled RA REGISTER
 ;
 N X,Y,DMAX S RADMAX=$$ROUSIZE^DILF
 ;
 ;input template RA REGISTER compiles routines in the namespace: RACTRG*
 ;
 S RACTNAM="RACTRG",RAINPNME="RA REGISTER"
 ;
 D FIND^DIC(.402,"","","O",RAINPNME,"","","","","RAINP70","")
 ;
 ;If the input template record is missing quit but check the other input
 ;template.
 ;
 I $G(RAINP70("DILIST",2,1))'>0 S RAINPERR=$$ERROR(RAINPNME) D XIT Q
 ;
 ;compile the input templates...
 ;
 ;DMAX: maximum routine size
 ;   X: the name of the routine for the compiled input template; i.e.
 ;      RACTRG
 ;   Y: the IEN of the input template to be compiled
 S DMAX=RADMAX,X=RACTNAM,Y=$G(RAINP70("DILIST",2,1))
 D EN^DIEZ
 ;
XIT ;clean up symbol table and exit
 K RACTNAM,RADMAX,RAINP70,RAINPERR,RAINPNME
 Q
 ;
ERROR(N) ;This function set the error flag & records the error
 K RATXT S RATXT(1)="'"_N_"' was not found in the INPUT TEMPLATE (#.402) file."
 S RATXT(2)=" " D BMES^XPDUTL(.RATXT) K RATXT
 Q 1
 ;
