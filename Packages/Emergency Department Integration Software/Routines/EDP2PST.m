EDP2PST ;SLC/BWF - Post-init for facility install ;5/28/12 10:30am
 ;;2.0;EMERGENCY DEPARTMENT;**6**;Feb 24, 2012;Build 200
 ;
 D CONVERT,UPDWKS,DEFROOM,REMX9999
 Q
 ;
CONVERT ; convert old role values (set of codes) to new pointer structure
 ; old role values of 'P','R', and 'N' must match one of the new role
 ; abbreviations in the CPE role file.
 N IEN,DAT,OROLE,NROLEPTR,ERR
 S IEN=0 F  S IEN=$O(^EDPB(231.7,IEN)) Q:'IEN  D
 .S DAT=$G(^EDPB(231.7,IEN,0))
 .S OROLE=$P(DAT,U,6) Q:OROLE=""!(OROLE>0)
 .; if OROLE is numeric, it has already been converted, so quit.
 .I OROLE,$D(^EDPB(232.5,OROLE)) Q
 .; if this particular role cannot be mapped, set it to null.
 .S NROLEPTR=$O(^EDPB(232.5,"C",OROLE,"")) S:'NROLEPTR NROLEPTR=""
 .S FDA(231.7,IEN_",",.06)=NROLEPTR D FILE^DIE(,"FDA","ERR") K FDA
 Q
UPDWKS ; update all worksheets with the proper institution/area
 N WKS,EDPSITE,EDPSTA
 Q:'$D(DUZ)
 S EDPSITE=DUZ(2),EDPSTA=$$STA^XUAF4(DUZ(2))
 S WKS=0 F  S WKS=$O(^EDPB(232.6,WKS)) Q:'WKS  D
 .S FDA(232.6,WKS_",",.02)=EDPSITE
 .S FDA(232.6,WKS_",",.03)=EDPSTA
 .D FILE^DIE(,"FDA")
 Q
DEFROOM ;
 N INST,AREA,DEFSTAT,NEWIEN,NRIEN
 ; do not add EDIS_DEFAULT if it already exists.
 Q:$D(^EDPB(231.8,"B","EDIS_DEFAULT"))
 S INST=$G(DUZ(2)) I 'INST D  Q
 .D MES^XPDUTL("Missing or invalid institution. Cannot Continue.")
 .S XPDABORT=1
 S AREA=$O(^EDPB(231.9,"C",DUZ(2),0))
 I 'AREA D  Q
 .D MES^XPDUTL("Missing or invalid Area. Please check your TRACKING AREA file and insure there is an area associated with your institution.")
 .S XPDABORT=1
 S DEFSTAT=$O(^EDPB(233.1,"B","edp.status.waiting",0))
 S FDA(231.8,"+1,",.01)="EDIS_DEFAULT"
 S FDA(231.8,"+1,",.02)=INST
 S FDA(231.8,"+1,",.03)=AREA
 S FDA(231.8,"+1,",.05)=.1
 S FDA(231.8,"+1,",.06)="EDIS_DEFAULT"
 S FDA(231.8,"+1,",.07)=0
 S FDA(231.8,"+1,",.08)=DEFSTAT
 S FDA(231.8,"+1,",.09)=1
 S FDA(231.8,"+1,",.11)=""
 S FDA(231.8,"+1,",.13)=1
 D UPDATE^DIE(,"FDA","NEWIEN")
 S NRIEN=0,NRIEN=$O(NEWIEN(NRIEN)) S NRIEN=$G(NEWIEN(NRIEN))
 Q
REMX9999 ; Loop through all display boards and rebuild definitions, removing '@last4' and '@alerts'.
 N AREA,BID,BATT,BATTDAT,ATTRIB,CTR
 S AREA=0 F  S AREA=$O(^EDPB(231.9,AREA)) Q:'AREA  D
 .S CTR=0
 .S PTNM=$$SRCHPTNM(AREA)
 .I 'PTNM S CTR=$G(CTR)+1,ATTRIB(CTR)=$$PTNM()
 .S BID=0 F  S BID=$O(^EDPB(231.9,AREA,4,BID)) Q:'BID  D
 ..S IENS=BID_","_AREA_","
 ..S BATT=0 F  S BATT=$O(^EDPB(231.9,AREA,4,BID,1,BATT)) Q:'BATT  D
 ...S BATTDAT=$G(^EDPB(231.9,AREA,4,BID,1,BATT,0))
 ...Q:BATTDAT["@last4"!(BATTDAT["@alerts")
 ...S CTR=$G(CTR)+1,ATTRIB(CTR)=BATTDAT
 ..D WP^DIE(231.94,IENS,1,"K","ATTRIB") K ATTRIB
 Q
SRCHPTNM(AREA) ;
 N BID,X,RET
 S RET=0
 S BID=0 F  S BID=$O(^EDPB(231.9,AREA,4,BID)) Q:'BID  D
 .S X=0 F  S X=$O(^EDPB(231.9,AREA,4,BID,1,X)) Q:'X!(RET)  D
 ..I $G(^EDPB(231.9,AREA,4,BID,1,X,0))["@ptNm" S RET=1
 Q RET
PTNM() ;
 Q "<col att=""@ptNm"" header=""Patient"" color="""" width=""60"" label=""Patient Name""/>"
