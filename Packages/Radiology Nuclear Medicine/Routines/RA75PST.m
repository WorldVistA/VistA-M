RA75PST ;Hines OI/GJC - Post-init Driver, patch 75 ;01/05/06  06:32
VERSION ;;5.0;Radiology/Nuclear Medicine;**75**;Mar 16, 1998;Build 4
 ;
 Q
 ;
EN ; entry point for the post-install logic
 ; make sure the [RA ORDER EXAM] (RACTOE*) & [RA QUICK EXAM ORDER] (RACTQE*) 
 ; input templates are re-compiled so user workflow is not interrupted.
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
 ; RAINP751=local array where input template specific data is stored
 ; RAINPNME=input template name
 ;
 N X,Y,DMAX K RACTNAM,RADMAX,RAINPERR,RAINPNME S RADMAX=$$ROUSIZE^DILF
 F RAINPNME="RA ORDER EXAM","RA QUICK EXAM ORDER" D
 .K RAINP751 S RAINPERR=0
 .;
 .;input template RA ORDER EXAM compiles routines in the namespace: RACTOE*
 .;input template RA QUICK EXAM ORDER compiles routines in the namespace: RACTQE*
 .;
 .S RACTNAM=$S(RAINPNME="RA ORDER EXAM":"RACTOE",1:"RACTQE")
 .;
 .D FIND^DIC(.402,"","","O",RAINPNME,"","","","","RAINP751","")
 .;
 .;If the input template record is missing quit but check the other input template.
 .;
 .I $G(RAINP751("DILIST",2,1))'>0 S RAINPERR=$$ERROR(RAINPNME) Q
 .;
 .;compile the input templates...
 .;
 .K DMAX,X,Y
 .;DMAX: maximum routine size
 .;   X: the name of the routine for the compiled input template; i.e. RACTOE
 .;   Y: the IEN of the input template to be compiled
 .S DMAX=RADMAX,X=RACTNAM,Y=$G(RAINP751("DILIST",2,1))
 .D EN^DIEZ
 .Q
XIT K RACTNAM,RADMAX,RAINP751,RAINPERR,RAINPNME
 Q
 ;
ERROR(N) ;This function set the error flag & records the error
 K RATXT S RATXT(1)="'"_N_"' was not found in the INPUT TEMPLATE (#.402) file."
 S RATXT(2)=" " D BMES^XPDUTL(.RATXT) K RATXT
 Q 1
 ;
