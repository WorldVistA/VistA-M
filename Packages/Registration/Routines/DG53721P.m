DG53721P ;ALB/MHG - post-install for DG*5.3*721
 ;;5.3;Registration;**721**;Aug 13, 1993;Build 3
EN ;
 ;recompile input templates
 N X,Y,DMAX,MESS
 S X="DGPMX6"
 S Y=$$FIND1^DIC(.402,"","MX","DGPM SPECIALTY TRANSFER")
 I Y<0 S MESS="Error in re-compiling DGPM SPECIALTY TRANSFER input template." D MESS Q
 S DMAX=8000
 D EN^DIEZ
 S MESS="DGPM SPECIALTY TRANSFER input template has been re-compiled."
 D MESS
 Q
 ;
MESS ;
 D MES^XPDUTL("")
 D BMES^XPDUTL(MESS)
 Q
