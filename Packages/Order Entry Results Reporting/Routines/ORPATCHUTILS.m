ORPATCHUTILS ;SLC/AGP - PRE/POST INSTALL OR*3.0*508 ;Apr 09, 2025@10:39:19
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**508**;Dec 17, 1997;Build 39
 ;
 ;
 Q
 ;============================== ALERTS FILE #100.9 ========================================
 ; Alert sections array structure:
 ;
 ; ARRAY(IEN,"name")=NAME
 ; ARRAY(IEN,"error")=""
 ; ARRAY(IEN,"parameters",PARAMNAME)=VALUE
 ;
 ; IEN = Number the entry must be installed at in file 100.9
 ; NAME =.01 File: 100.9
 ; PARAMNAME = Parameter name to update VALUE = Value to store at the package precedents in the parameter
 ;
 ; each external API returns a 1 or 0, if 1 it is okay to continue to the next step of the install
 ;                                     if 0 an error will be return in the entry "error" subscript
ENVCHKALERTS(ALERTS) ;
 N IDX,RESULT
 S RESULT=1
 S IDX=0 F  S IDX=$O(ALERTS(IDX)) Q:IDX'>0!(RESULT=0)  D
 .I '$D(^ORD(100.9,IDX)) Q
 .I $P($G(^ORD(100.9,IDX,0)),U)'=ALERTS(IDX,"name") S ALERTS(IDX,"error")="Entry found in file 100.9",RESULT=0
 Q RESULT
 ;
 ;
SETALERTSTUB(ALERTS,DISPLAY) ;
 N DA,DIK,ID,IDX,FDA,IENS,MSG,RESULT
 S DISPLAY=+$G(DISPLAY)
 I DISPLAY D BMES^XPDUTL("Setting notifications stub entries...")
 S IDX=0,RESULT=1 F  S IDX=$O(ALERTS(IDX)) Q:IDX'>0  D
 . I +$D(DISPLAY) D BMES^XPDUTL("  "_ALERTS(IDX,"name"))
 . S ID=IDX_","
 . I $D(^ORD(100.9,IDX)),$P($G(^ORD(100.9,IDX,0)),U)'=ALERTS(IDX,"name") D
 .. I DISPLAY D BMES^XPDUTL("   "_$P(^ORD(100.9,IDX,0),U)_" will be overriden")
 .. S DIK="^ORD(100.9,",DA=IDX
 .. D ^DIK
 .. S ID="+1,"
 . K FDA,IENS,MSG
 . S FDA(100.9,ID,.01)=ALERTS(IDX,"name")
 . S IENS(1)=IDX
 . D UPDATE^DIE("","FDA","IENS","MSG")
 . I $D(MSG) D  Q
 ..I DISPLAY D BMES^XPDUTL("   "_ALERTS(IDX,"name")_" did not get created")
 ..S ALERTS(IDX,"error")="Failed UPDATE^DIE" S RESULT=0
 . I +$G(IENS(1))'=IDX D
 ..I DISPLAY D BMES^XPDUTL("   "_ALERTS(IDX,"name")_" IEN is not correct")
 ..S ALERTS(IDX,"error")="IEN is not correct" S RESULT=0
 I DISPLAY D BMES^XPDUTL("Done"_$S('RESULT:" took errors",1:""))
 Q RESULT
 ;
SETALERTPARAMS(ALERTS,DISPLAY) ;
 N ENT,IDX,INST,LINE,ORERROR,PARAM,RESULT,VALUE
 S DISPLAY=+$G(DISPLAY)
 I DISPLAY D BMES^XPDUTL("Setting package level parameters new notifications...")
 S ENT="PKG"
 S RESULT=1
 S IDX=0 F  S IDX=$O(ALERTS(IDX)) Q:IDX'>0  D
 .K INST,ORERROR,PARAM,VALUE
 .S INST=ALERTS(IDX,"name")
 .I DISPLAY D BMES^XPDUTL("  Notification "_INST)
 .S PARAM="" F  S PARAM=$O(ALERTS(IDX,"parameters",PARAM)) Q:PARAM=""  D
 ..S VALUE=$G(ALERTS(IDX,"parameters",PARAM))
 ..I DISPLAY D BMES^XPDUTL("   Setting Parameter "_PARAM)
 ..D EN^XPAR(ENT,PARAM,INST,VALUE,.ORERROR)
 ..I +ORERROR D
 ...I DISPLAY D BMES^XPDUTL("   Error setting values")
 ...S ALERTS(IDX,"error")="Failed updating "_PARAM,RESULT=0
 I +$D(DISPLAY) D BMES^XPDUTL("Done"_$S('RESULT:" took errors",1:""))
 Q RESULT
 ;
 ;============================== ALERTS FILE #100.9 ========================================
 ;
SETPARAMS(INPUTS,DISPLAY) ;
 N ENT,ERROR,PARAM,INST,TEXT,VALUE
 S DISPLAY=+$G(DISPLAY)
 S PARAM="" F  S PARAM=$O(INPUTS(PARAM)) Q:PARAM=""  D
 .I DISPLAY D BMES^XPDUTL("  "_PARAM)
 .S ENT="" F  S ENT=$O(INPUTS(PARAM,ENT)) Q:ENT=""  D
 ..S INST="" F  S INST=$O(INPUTS(PARAM,ENT,INST)) Q:INST=""  D
 ...S VALUE=$G(INPUTS(PARAM,ENT,INST))
 ...K ERROR D EN^XPAR(ENT,PARAM,INST,VALUE,.ERROR)
 ...I +ERROR>0,DISPLAY D  Q
 ....S TEXT(1)="  Error updating inputs:"
 ....S TEXT(2)="    Entity: "_ENT
 ....S TEXT(3)="  Instance: "_INST
 ....S TEXT(4)="     Value: "_VALUE
 ....D BMES^XPDUTL(.TEXT)
 Q
 ;
