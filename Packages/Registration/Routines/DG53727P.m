DG53727P ;ALB/DHH - post-install for DG*5.3*727 ; 8/14/2006
 ;;5.3;Registration;**727**;Aug 13, 1993
EN ;
 ;recompile input templates
 N X,Y,DMAX,MESS
 S X="DGX5F"
 S Y=$$FIND1^DIC(.402,"","MX","DG501F")
 I Y<0 S MESS="Error in re-compiling DG501F input template." D MESS Q
 S DMAX=8000
 D EN^DIEZ
 S MESS="DG501F input template has been re-compiled."
 D MESS
 Q
 ;
MESS ;
 D MES^XPDUTL("")
 D BMES^XPDUTL(MESS)
 Q
