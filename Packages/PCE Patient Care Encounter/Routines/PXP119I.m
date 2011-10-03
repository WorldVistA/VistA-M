PXP119I ;SLC/PKR,JVS - Create cross-references. ;10/12/2004
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**119**;Aug 12, 1996
 ;
 Q
 ;===============================================================
AED ;Reindex Health Factor "AED" Index
 Q:$D(^AUPNVHF("AED"))
 D BMES^XPDUTL(" The installation will pause while the index is being populated.")
 D BMES^XPDUTL(" If you have a large V Health Factor file this could take awhile.")
 N CNT,IEN,DA,DIK
 S CNT=0
 S DIK="^AUPNVHF("
 S DIK(1)="81203^AED"
 S XPDIDTOT=$P($G(^AUPNVHF(0)),"^",4)
 S IEN=0 F  S IEN=$O(^AUPNVHF(IEN)) Q:IEN<1  S CNT=CNT+1 D
 .I '$D(^AUPNVHF(IEN,12)) Q
 .I +$P($G(^AUPNVHF(IEN,12)),"^",1)=0 Q
 .I '$D(^AUPNVHF(IEN,812)) Q
 .I +$P($G(^AUPNVHF(IEN,812)),"^",3)=0 Q
 .S DA=IEN
 .D EN1^DIK
 .I $D(XPDNM),'(CNT#1000) D UPDATE^XPDID(CNT)
 Q
 ;
 ;===============================================================
CVCPT ;Create cross-reference for V CPT.
 N MSG,RESULT,UITEM,XREF
 D BMES^XPDUTL("Creating V CPT cross-reference.")
 ;Set the XREF nodes
 S XREF("FILE")=9000010.18
 S XREF("ROOT FILE")=9000010.18
 S XREF("SET")="D SVFILEC^PXPXRM(9000010.18,.X,.DA)"
 S XREF("KILL")="D KVFILEC^PXPXRM(9000010.18,.X,.DA)"
 S XREF("WHOLE KILL")="K ^PXRMINDX(9000010.18)"
 D SXREFVF(.XREF,"CPT code")
 S UITEM="CPT CODE"
 S XREF("DESCR",5)=" ^PXRMINDX("_XREF("FILE")_",""IPP"","_UITEM_",PP,DFN,VISIT DATE,DAS) and"
 S XREF("DESCR",6)=" ^PXRMINDX("_XREF("FILE")_",""PPI"",DFN,PP,"_UITEM_",VISIT DATE,DAS)"
 S XREF("DESCR",7)="respectively. PP is the principal procedure code. Possible values are Y (yes), N (no) or U (undefined)."
 S XREF("DESCR",8)="For all the details, see the Clinical Reminders Index Technical Guide/Programmer's Manual."
 S XREF("VAL",4)=.07
 D CREIXN^DDMOD(.XREF,"k",.RESULT,"","MSG")
 I RESULT="" D DCERRMSG^PXRMP12I(.MSG,.XREF)
 Q
 ;
 ;===============================================================
CVFILE ;Create all the V file cross-references.
 D BMES^XPDUTL("Creating V file cross-references.")
 D CVCPT
 D CVHF
 D CVIMM
 D CVPATED
 D CVPOV
 D CVSK
 D CVXAM
 Q
 ;
 ;===============================================================
CVHF ;Create cross-reference for V HEALTH FACTOR.
 N MSG,RESULT,XREF
 D BMES^XPDUTL("Creating V Health Factor cross-reference.")
 ;Set the XREF nodes
 S XREF("FILE")=9000010.23
 S XREF("ROOT FILE")=9000010.23
 S XREF("SET")="D SVFILE^PXPXRM(9000010.23,.X,.DA)"
 S XREF("KILL")="D KVFILE^PXPXRM(9000010.23,.X,.DA)"
 S XREF("WHOLE KILL")="K ^PXRMINDX(9000010.23)"
 D SXREFVF(.XREF,"health factor")
 D CREIXN^DDMOD(.XREF,"k",.RESULT,"","MSG")
 I RESULT="" D DCERRMSG^PXRMP12I(.MSG,.XREF)
 ;
 N PXREF
 K MSG,RESULT
 D BMES^XPDUTL("Creating V Health Factor AED cross-reference.")
 S PXREF("FILE")=9000010.23
 S PXREF("ROOT FILE")=9000010.23
 S PXREF("WHOLE KILL")="K ^AUPNVHF(""AED"")"
 S PXREF("NAME")="AED"
 S PXREF("TYPE")="R"
 S PXREF("SHORT DESCR")="AED,EVENT DATE AND TIME,DATA SOURCE,DA"
 S PXREF("DESCR",1)="This cross-reference creates an index of the Event"
 S PXREF("DESCR",2)="Date and Time field and the Data Source field."
 S PXREF("USE")="S"
 S PXREF("EXECUTION")="R"
 S PXREF("ACTIVITY")="IR"
 S PXREF("VAL",1)=1201
 S PXREF("VAL",1,"SUBSCRIPT")=1
 S PXREF("VAL",2)=81203
 S PXREF("VAL",2,"SUBSCRIPT")=3
 S PXREF("VAL",3)=.02
 S PXREF("VAL",3,"SUBSCRIPT")=2
 D CREIXN^DDMOD(.PXREF,"k",.RESULT,"","MSG")
 I RESULT="" D DCERRMSG^PXRMP12I(.MSG,.XREF)
 D AED
 Q
 ;
 ;===============================================================
CVIMM ;Create cross-reference for V IMMUNIZATION.
 N MSG,RESULT,XREF
 D BMES^XPDUTL("Creating V Immunization cross-reference.")
 ;Set the XREF nodes
 S XREF("FILE")=9000010.11
 S XREF("ROOT FILE")=9000010.11
 S XREF("SET")="D SVFILE^PXPXRM(9000010.11,.X,.DA)"
 S XREF("KILL")="D KVFILE^PXPXRM(9000010.11,.X,.DA)"
 S XREF("WHOLE KILL")="K ^PXRMINDX(9000010.11)"
 D SXREFVF(.XREF,"immunization")
 D CREIXN^DDMOD(.XREF,"k",.RESULT,"","MSG")
 I RESULT="" D DCERRMSG^PXRMP12I(.MSG,.XREF)
 Q
 ;
 ;===============================================================
CVPATED ;Create cross-reference for V PATIENT ED.
 N MSG,RESULT,XREF
 D BMES^XPDUTL("Creating V Patient Ed cross-reference.")
 ;Set the XREF nodes
 S XREF("FILE")=9000010.16
 S XREF("ROOT FILE")=9000010.16
 S XREF("SET")="D SVFILE^PXPXRM(9000010.16,.X,.DA)"
 S XREF("KILL")="D KVFILE^PXPXRM(9000010.16,.X,.DA)"
 S XREF("WHOLE KILL")="K ^PXRMINDX(9000010.16)"
 D SXREFVF(.XREF,"education topic")
 D CREIXN^DDMOD(.XREF,"k",.RESULT,"","MSG")
 I RESULT="" D DCERRMSG^PXRMP12I(.MSG,.XREF)
 Q
 ;
 ;===============================================================
CVPOV ;Create cross-reference for V POV.
 N MSG,RESULT,UITEM,XREF
 D BMES^XPDUTL("Creating V POV cross-reference.")
 ;Set the XREF nodes
 S XREF("FILE")=9000010.07
 S XREF("ROOT FILE")=9000010.07
 S XREF("SET")="D SVFILEC^PXPXRM(9000010.07,.X,.DA)"
 S XREF("KILL")="D KVFILEC^PXPXRM(9000010.07,.X,.DA)"
 S XREF("WHOLE KILL")="K ^PXRMINDX(9000010.07)"
 D SXREFVF(.XREF,"ICD9 code")
 S UITEM="ICD9 CODE"
 S XREF("DESCR",5)=" ^PXRMINDX("_XREF("FILE")_",""IPP"","_UITEM_",PS,DFN,VISIT DATE,DAS) and"
 S XREF("DESCR",6)=" ^PXRMINDX("_XREF("FILE")_",""PPI"",DFN,PS,"_UITEM_",VISIT DATE,DAS)"
 S XREF("DESCR",7)="respectively. PS is the primary/secondary code. Possible values are P (primary), S (secondary) or U (undefined)."
 S XREF("DESCR",8)="For all the details, see the Clinical Reminders Index Technical Guide/Programmer's Manual."
 S XREF("VAL",4)=.12
 D CREIXN^DDMOD(.XREF,"k",.RESULT,"","MSG")
 I RESULT="" D DCERRMSG^PXRMP12I(.MSG,.XREF)
 Q
 ;
 ;===============================================================
CVSK ;Create cross-reference for V SKIN TEST.
 N MSG,RESULT,XREF
 D BMES^XPDUTL("Creating V Skin Test cross-reference.")
 ;Set the XREF nodes
 S XREF("FILE")=9000010.12
 S XREF("ROOT FILE")=9000010.12
 S XREF("SET")="D SVFILE^PXPXRM(9000010.12,.X,.DA)"
 S XREF("KILL")="D KVFILE^PXPXRM(9000010.12,.X,.DA)"
 S XREF("WHOLE KILL")="K ^PXRMINDX(9000010.12)"
 D SXREFVF(.XREF,"skin test")
 D CREIXN^DDMOD(.XREF,"k",.RESULT,"","MSG")
 I RESULT="" D DCERRMSG^PXRMP12I(.MSG,.XREF)
 Q
 ;
 ;===============================================================
CVXAM ;Create cross-reference for V EXAM.
 N MSG,RESULT,XREF
 D BMES^XPDUTL("Creating V Exam cross-reference.")
 ;Set the XREF nodes
 S XREF("FILE")=9000010.13
 S XREF("ROOT FILE")=9000010.13
 S XREF("SET")="D SVFILE^PXPXRM(9000010.13,.X,.DA)"
 S XREF("KILL")="D KVFILE^PXPXRM(9000010.13,.X,.DA)"
 S XREF("WHOLE KILL")="K ^PXRMINDX(9000010.13)"
 D SXREFVF(.XREF,"exam")
 D CREIXN^DDMOD(.XREF,"k",.RESULT,"","MSG")
 I RESULT="" D DCERRMSG^PXRMP12I(.MSG,.XREF)
 Q
 ;
 ;===============================================================
DCERRMSG(MSG,XREF) ;Display creation error message.
 W !,"Cross-reference could not be created!"
 W !,"Error message:"
 D AWRITE^PXRMUTIL("MSG")
 W !!,"Cross-reference information:"
 D AWRITE^PXRMUTIL("XREF")
 Q
 ;
 ;===============================================================
SXREFVF(XREF,ITEM) ;Set XREF array nodes common for all V files.
 N UITEM
 S UITEM=$$UP^XLFSTR(ITEM)
 S XREF("TYPE")="MU"
 S XREF("NAME")="ACR"
 S XREF("SHORT DESCR")="Clinical Reminders index."
 S XREF("DESCR",1)="This cross-reference builds two indexes, one for finding"
 S XREF("DESCR",2)="all patients with a particular "_ITEM_" and one for finding all"
 S XREF("DESCR",3)="the "_ITEM_"s a patient has."
 S XREF("DESCR",4)="The indexes are stored in the Clinical Reminders index global as:"
 S XREF("DESCR",5)=" ^PXRMINDX("_XREF("FILE")_",""IP"","_UITEM_",DFN,VISIT DATE,DAS) and"
 S XREF("DESCR",6)=" ^PXRMINDX("_XREF("FILE")_",""PI"",DFN,"_UITEM_",VISIT DATE,DAS)"
 S XREF("DESCR",7)="respectively."
 S XREF("DESCR",8)="For all the details, see the Clinical Reminders Index Technical Guide/Programmer's Manual."
 S XREF("USE")="ACTION"
 S XREF("EXECUTION")="R"
 S XREF("ACTIVITY")="IR"
 S XREF("VAL",1)=.01
 S XREF("VAL",1,"SUBSCRIPT")=1
 S XREF("VAL",2)=.02
 S XREF("VAL",2,"SUBSCRIPT")=2
 S XREF("VAL",3)=.03
 S XREF("VAL",3,"SUBSCRIPT")=3
 Q
 ;
 ;===============================================================
VHFAED     ;Reindex Health Factor "AED" Index
 S DIK="^AUPNVHF("
 S DIK(1)="81203^AED"
 D ENALL^DIK
 Q
 ;
 ;===============================================================
VHFTSK ;Task off Health Factor AED Cross ref build
 S ZTRTN="VHFAED^PXP119I"
 S ZTDESC="V Health Factors Index AED x-ref"
 S ZTIO=""
 S ZTDTH=$H
 D ^%ZTLOAD
 Q
 ;
