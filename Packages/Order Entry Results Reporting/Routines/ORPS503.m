ORPS503 ;HPS/DJH - Save data before rebuilding index OR*3.0*503 ;Jan 11, 2019@14:33
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**503**;Dec 17, 1997;Build 6
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q  ; 
 ; This routine will save off the C index of file 100.9 and then rebuilding the C index
 ; OR*3.0*503 djh
 ;
EN ;
 N DIK,ORNOT,ORIEN
 ; save existing C index
 S ^XTMP("ORPS503",0)=$$FMADD^XLFDT(DT,730)_U_DT
 S ORNOT=""
 F  S ORNOT=$O(^ORD(100.9,"C",ORNOT)) Q:ORNOT=""  D
 . S ORIEN=0
 . F  S ORIEN=$O(^ORD(100.9,"C",ORNOT,ORIEN)) Q:'ORIEN  D
 . . S ^XTMP("ORPS503",ORNOT,ORIEN)=""
 ; kill C index before rebuilding
 K ^ORD(100.9,"C")
 S DIK="^ORD(100.9,",DIK(1)=".02^C"
 D ENALL^DIK  ;rebuild the C x-ref
 Q
