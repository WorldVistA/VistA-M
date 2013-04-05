RORP015 ;BP/ACS CCR PRE/POST-INIT PATCH 15 ; 6/23/11 10:57am
 ;;1.5;CLINICAL CASE REGISTRIES;**15**;Feb 17, 2006;Build 27
 ;
 ; This routine uses the following IAs:
 ;
 ; #2053    UPDATE^DIE (supported)
 ; #10075   OPTION file r/w
 N RORPARM S RORPARM("DEVELOPER")=1
 ;
 ;********************************************************************
 ;Remove erroneous NON-VA MEDS entry from the ROR HISTORICAL DATA
 ;EXTRACT file.  Entry will be re-added during installation.
 ;********************************************************************
PRE ;
 N RORIEN,X,DIK S RORIEN=$O(^RORDATA(799.6,"B","NON-VA MEDS",0))
 I $G(RORIEN) D
 . N DIK,DA
 . S DIK="^RORDATA(799.6,",DA=RORIEN D ^DIK
 Q
POST ;
 ;
 ;*******************************************************************
 ;
 ;Delete entries in ROR GENERIC DRUG with unresolved pointers
 ;
 ;********************************************************************
 ;clean up 799.51 if pointers are bad
 N DIC,X,DIK,DA,RORNAME,Y
 S DIC=799.51,DIC(0)="MNZ"
 F RORNAME="TELAPREVIR","BOCEPREVIR","RILPIVIRINE" D
 .S X=RORNAME D ^DIC Q:+Y<0
 .Q:+$P(Y(0),U,4)>0
 .S DA=+Y,DIK="^ROR(799.51," D ^DIK
 Q
