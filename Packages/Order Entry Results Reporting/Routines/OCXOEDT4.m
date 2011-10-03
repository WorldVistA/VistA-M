OCXOEDT4 ;SLC/RJS,CLA -  Rule Editor (Activate/Inactivate Rules) ;10/29/98  12:37
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**32**;Dec 17,1997
 ;;  ;;ORDER CHECK EXPERT version 1.01 released OCT 29,1998
 ;
 ;
S ;
 ;
 N OCXERR,OCXR,DIE,DIC,DR,X,Y
 ;
 S OCXERR=0 F  W !! Q:$$DIE($$DIC)
 ;
 Q
 ;
DIC() N DIC,X,Y S DIC="^OCXS(860.2,",DIC(0)="AEQM" D ^DIC Q:(Y<0) 0 Q +Y
 ;
DIE(DA) Q:'DA 1 N DIC,DIE,DR,X,Y S (DIC,DIE)="^OCXS(860.2,",DR=".02" D ^DIE Q ($G(DTOUT)!$G(DUOUT))
 ;
