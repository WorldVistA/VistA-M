ORY269 ;ISP/RFR - DATA DICTIONARY CLEANUP ;12/15/2015  12:01
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**269**;Dec 17, 1997;Build 85
 Q
PRE ;Pre-install
 ;IF THE FILE ALREADY EXITS, DELETE THE DATA DICTIONARY
 I $D(^DIC(100.05))>0 D
 .N FILE
 .D FILE^DID(100.05,,"NAME","FILE")
 .D BMES^XPDUTL("Deleting existing "_$G(FILE("NAME"))_" data dictionary while preserving data...")
 .N DIU
 .S DIU="^ORD(100.05,",DIU(0)="T"
 .D EN^DIU2
 .D MES^XPDUTL("DONE")
 Q
POST ;Post-install
 I '$D(^ORD(100.8,99)) D
 .D BMES^XPDUTL("Creating new ORDER CHECKS entry...")
 .N FDA,IEN,DESCRIPTION,ERROR
 .S FDA(100.8,"+1,",.01)="REMOTE DATA UNAVAILABLE"
 .S FDA(100.8,"+1,",2)="DESCRIPTION"
 .S DESCRIPTION(1,0)="Triggered by the order checking system, this order check is generated when"
 .S DESCRIPTION(2,0)="the remote data interoperability (RDI) client is unable to obtain all"
 .S DESCRIPTION(3,0)="available data from the Health Data Repository (HDR)."
 .S IEN(1)=99
 .D UPDATE^DIE(,"FDA","IEN","ERROR")
 .I $D(ERROR) D ERROR("Unable to add the REMOTE DATA UNAVAILABLE entry",.ERROR)
 .I '$D(ERROR) D MES^XPDUTL("DONE")
 D ^ORY269ES
 N FILE
 I $Q(^ORD(100.05,0))']"^ORD(100.05," D BMES^XPDUTL("No data to convert.") Q
 D FILE^DID(100.05,,"NAME","FILE")
 D BMES^XPDUTL("Converting existing data in the "_$G(FILE("NAME"))_" file...")
 N XPDIDTOT,RECCOUNT
 S XPDIDTOT=+$P(^ORD(100.05,0),U,4),RECCOUNT=0
 D UPDATE^XPDID(RECCOUNT)
 N I
 S I=0 F  S I=$O(^ORD(100.05,I)) Q:'I  D
 .I $D(^ORD(100.05,I,2)) D
 ..N COUNT
 ..S COUNT=$O(^ORD(100.05,I,2,"?"),-1)
 ..I $P(^ORD(100.05,I,2,0),U,3,4)'=(COUNT_U_COUNT) S $P(^ORD(100.05,I,2,0),U,3,5)=COUNT_U_COUNT_U_DT
 .I $D(^ORD(100.05,I,4)),('$D(^ORD(100.05,I,5))) D
 ..N X,P01
 ..S X=0 F  S X=$O(^ORD(100.05,I,4,X)) Q:'X  D
 ...N DAT,DRG,CUA,INT,DB,LOC,OH,SEV
 ...S DAT=^ORD(100.05,I,4,X,0),DRG=$P(DAT,U),LOC=$P(DAT,U,2),CUA=$P(DAT,U,3),INT=$P(DAT,U,5),DB=$P(DAT,U,6)
 ...S OH=$P(DAT,U,7),SEV=$P(DAT,U,8)
 ...I $G(DRG)]"",($D(^PSDRUG(DRG))) D
 ....S ^ORD(100.05,I,5,0)="100.06PA^1^1",^ORD(100.05,I,5,1,0)=DRG,^ORD(100.05,I,5,"B",DRG,1)=""
 ....S $P(^ORD(100.05,I,4,X,0),U)="" K ^ORD(100.05,I,4,"B",DRG,X)
 ...I $G(INT)]"",($D(^APSPQA(32.4,INT))) S ^ORD(100.05,I,8)=INT,$P(^ORD(100.05,I,4,X,0),U,5)=""
 ...I $G(CUA)[";" D
 ....N NODE S NODE=U_$P(CUA,";",2)_$P(CUA,";")_")"
 ....I $D(@NODE) S $P(^ORD(100.05,I,4,X,0),U,2)=CUA,$P(^ORD(100.05,I,4,X,0),U,3)=""
 ...I "^L^R^"[(U_$G(LOC)_U) S $P(^ORD(100.05,I,4,X,0),U,3)=LOC
 ...I "^C^V^"[(U_$G(DB)_U) S $P(^ORD(100.05,I,8),U,4)=DB,$P(^ORD(100.05,I,4,X,0),U,6)=""
 ...I $P(^ORD(100.05,I,4,X,0),U)="" D
 ....I $P(^ORD(100.05,I,4,X,0),U,2)["50.605" D
 .....S $P(^ORD(100.05,I,4,X,0),U)=$$GET1^DIQ(50.605,$P($P(^ORD(100.05,I,4,X,0),U,2),";")_",",1)
 ....I $P(^ORD(100.05,I,4,X,0),U,2)'["50.605" D
 .....S $P(^ORD(100.05,I,4,X,0),U)=$$EXTERNAL^DILFD(100.517,2,,$P(^ORD(100.05,I,4,X,0),U,2))
 ....S P01=$P(^ORD(100.05,I,4,X,0),U) I P01'="" S ^ORD(100.05,I,4,"B",P01,X)=""
 ....I P01="" D 
 .....N MSGS S MSGS(1)="Record #"_I_" is corrupt.",MSGS(2)="The .01 field does not have a valid value."
 .....S MSGS(3)="Please contact your help desk for assistance in correcting this record."
 .....D BMES^XPDUTL(.MSGS)
 ...I "^O^H^"[(U_$G(OH)_U) S $P(^ORD(100.05,I,4,X,0),U,6)=OH,$P(^ORD(100.05,I,4,X,0),U,7)=""
 ...I "^1^2^3^"[(U_$G(SEV)_U) S $P(^ORD(100.05,I,4,X,0),U,7)=SEV,$P(^ORD(100.05,I,4,X,0),U,8)=""
 ...I $L(^ORD(100.05,I,4,X,0),U)=8 S ^ORD(100.05,I,4,X,0)=$P(^ORD(100.05,I,4,X,0),U,1,7)
 .I $D(^ORD(100.05,I,15)) D
 ..S $P(^ORD(100.05,I,11),U,3)=$P(^ORD(100.05,I,15),U,1)
 ..K ^ORD(100.05,I,15)
 .S RECCOUNT=RECCOUNT+1 D:'(RECCOUNT#100) UPDATE^XPDID(RECCOUNT)
 D UPDATE^XPDID(XPDIDTOT)
 D MES^XPDUTL("DONE")
 Q
ERROR(TEXT,ERROR) ;OUTPUT FILEMAN ERROR MESSAGE(S)
 N ORMSG,IDX
 S ORMSG(1)=" "
 S ORMSG(2)="ERROR: "_TEXT_"."
 S ORMSG(3)="VA FileMan Error #"_ERROR("DIERR",1)_":"
 F IDX=1:1:+$O(ERROR("DIERR",1,"TEXT","A"),-1) D
 .S ORMSG(IDX+2)=ERROR("DIERR",1,"TEXT",IDX)
 D BMES^XPDUTL(.ORMSG)
 Q
