DG53862I ; SLC/PKR - Update cross-references for Clinical Reminders Index. ;04/18/2014
 ;;5.3;Registration;**862**;Aug 13, 1993;Build 138
 ;
 Q
 ;===========================================
AWRITE(REF) ;Write all the descendants of the array.
 N DONE,IND,LEN,LN,PROOT,ROOT,START,TEMP,TEXT
 I REF="" Q
 S LN=0
 S PROOT=$P(REF,")",1)
 ;Build the root so we can tell when we are done.
 S TEMP=$NA(@REF)
 S ROOT=$P(TEMP,")",1)
 S REF=$Q(@REF)
 I REF'[ROOT Q
 S DONE=0
 F  Q:(REF="")!(DONE)  D
 . S START=$F(REF,ROOT)
 . S LEN=$L(REF)
 . S IND=$E(REF,START,LEN)
 . S LN=LN+1,TEXT(LN)=PROOT_IND_"="_@REF
 . S REF=$Q(@REF)
 . I REF'[ROOT S DONE=1
 D MES^XPDUTL(.TEXT)
 Q
 ;
 ;===========================================
CPTFXR ;Create all the cross-references.
 D BMES^XPDUTL("Creating Clinical Reminders Index cross-references.")
 D CPTFDXR
 D CPTFPXR
 Q
 ;
 ;===========================================
CPTFDXR ;Update cross-references for PTF ICD diagnosis data.
 ;Fields: 45,79; 45,80; 45,79.16 45,79.17; 45,79.18;
 ;45,79.19; 45,79.201; 45,79.21; 45,79.22; 45,79.22; 45.79.23;
 ;45,79.24; 45,79.241; 45,79.242; 45,79.243; 45,79.244
 ;By name these nodes are: DXLS, PRINCIPAL DIAGNOSIS, SECONDARY
 ;DIAGNOSIS 1, through SECONDARY DIAGNOSIS 12.
 N FIELD,IND,MSG,NAME,NODE,ONAME,RESULT,XREF
 D BMES^XPDUTL("Creating PTF ICD diagnosis cross-references.")
 ;Set the XREF nodes that are the same for all cross-references.
 S XREF("FILE")=45
 S XREF("ROOT FILE")=45
 S XREF("TYPE")="MU"
 S XREF("SHORT DESCR")="Clinical Reminders Index for ICD diagnosis code lookup."
 S XREF("DESCR",1)="This cross-reference builds two indexes, one for finding"
 S XREF("DESCR",2)="all patients with a particular ICD diagnosis code and one for finding all"
 S XREF("DESCR",3)="the ICD diagnosis codes a patient has."
 S XREF("DESCR",4)="The indexes are stored in the Clinical Reminders Index global as:"
 S XREF("DESCR",5)=" ^PXRMINDX(45,CODESYS,""INP"",CODE,NAME,DFN,DATE,DAS) and"
 S XREF("DESCR",6)=" ^PXRMINDX(45,CODESYS,""PNI"",DFN,NAME,CODE,DATE,DAS)"
 S XREF("DESCR",7)="respectively."
 S XREF("DESCR",8)="CODESYS is the standard three-character abbreviation for the coding system."
 S XREF("DESCR",9)="DATE is the discharge date. If it does not"
 S XREF("DESCR",10)="exist then the admission date is used."
 S XREF("EXECUTION")="R"
 S XREF("ACTIVITY")="IR"
 S XREF("VAL",1)=.01
 S XREF("VAL",1,"SUBSCRIPT")=1
 S XREF("VAL",2)=2
 S XREF("VAL",2,"SUBSCRIPT")=2
 S XREF("VAL",3)=11
 S XREF("VAL",3,"SUBSCRIPT")=3
 S XREF("VAL",5)=70
 ;
 ;These XREF nodes change for each cross-reference.
 S XREF("DESCR",11)="NAME is the name of the field where the code is stored. An example is DXLS."
 S XREF("DESCR",12)="If the TYPE OF RECORD is CENSUS then the entry is not indexed."
 S XREF("DESCR",13)="For complete details, see the Clinical Reminders Index Technical Guide/Programmer's Manual."
 S XREF("NAME")="ACRDDXLS"
 S XREF("VAL",4)=79
 S XREF("VAL",4,"SUBSCRIPT")=4
 S XREF("SET")="D SPTFDD^DGPTDDCR(.X,.DA,""DXLS"")"
 S XREF("KILL")="D KPTFDD^DGPTDDCR(.X,.DA,""DXLS"")"
 ;Remove any existing cross-references before creating the new one.
 D DELIXN^DDMOD(45,"ACR9DXLS","","MSG")
 D DELIXN^DDMOD(45,XREF("NAME"),"","MSG")
 K MSG
 D CREIXN^DDMOD(.XREF,"",.RESULT,"","MSG")
 I RESULT="" D DCERRMSG^DG53862I(.MSG,.XREF)
 ;
 S XREF("DESCR",11)="NAME is the name of the field where the code is stored. An example is PDX."
 S XREF("DESCR",12)="If the TYPE OF RECORD is CENSUS then the entry is not indexed."
 S XREF("DESCR",13)="For complete details, see the Clinical Reminders Index Technical Guide/Programmer's Manual."
 S XREF("NAME")="ACRDPDX"
 S XREF("VAL",4)=80
 S XREF("VAL",4,"SUBSCRIPT")=4
 S XREF("SET")="D SPTFDD^DGPTDDCR(.X,.DA,""PDX"")"
 S XREF("KILL")="D KPTFDD^DGPTDDCR(.X,.DA,""PDX"")"
 ;Remove any existing cross-references before creating the new one.
 D DELIXN^DDMOD(45,"ACR9PDX","","MSG")
 D DELIXN^DDMOD(45,XREF("NAME"),"","MSG")
 K MSG
 D CREIXN^DDMOD(.XREF,"",.RESULT,"","MSG")
 I RESULT="" D DCERRMSG^DG53862I(.MSG,.XREF)
 ;
 S IND=0
 F FIELD=79.16,79.17,79.18,79.19,79.201,79.21,79.22,79.23,79.24,79.241,79.242,79.243,79.244 D
 . S IND=IND+1
 . S XREF("DESCR",11)="NAME is the name of the field where the code is stored. An example is D SD"_IND_", where D SD signifies it is a discharge secondary diagnosis."
 . S XREF("DESCR",12)="If the TYPE OF RECORD is CENSUS then the entry is not indexed."
 . S XREF("DESCR",13)="For complete details, see the Clinical Reminders Index Technical Guide/Programmer's Manual."
 . S NAME="SD"_IND
 . S NODE="D "_NAME
 . S ONAME="ACR9D"_NAME
 . S XREF("NAME")="ACRD"_NAME
 . S XREF("VAL",4)=FIELD
 . S XREF("VAL",4,"SUBSCRIPT")=4
 . S XREF("SET")="D SPTFDD^DGPTDDCR(.X,.DA,"""_NODE_""")"
 . S XREF("KILL")="D KPTFDD^DGPTDDCR(.X,.DA,"""_NODE_""")"
 .;Remove any existing cross-references before creating the new one.
 . D DELIXN^DDMOD(45,ONAME,"","","MSG")
 . D DELIXN^DDMOD(45,XREF("NAME"),"","","MSG")
 . K MSG
 . D CREIXN^DDMOD(.XREF,"W",.RESULT,"","MSG")
 . I RESULT="" D DCERRMSG^DG53862I(.MSG,.XREF)
 ;
 ;Add the movement nodes.
 K XREF("VAL")
 S XREF("ROOT FILE")=45.02
 S XREF("VAL",1)=10
 S XREF("DESCR",7)="respectively."
 S XREF("DESCR",8)="CODESYS is the standard three-character abbreviation for the coding system."
 S XREF("DESCR",9)="DATE is the movement date."
 S XREF("DESCR",11)="If the TYPE OF RECORD is CENSUS then the entry is not indexed."
 S XREF("DESCR",12)="For complete details, see the Clinical Reminders Index Technical Guide/Programmer's Manual."
 K XREF("DESCR",13)
 S IND=0
 F FIELD=5,6,7,8,9,11,12,13,14,15 D
 . S IND=IND+1
 . S XREF("DESCR",10)="NAME is the name of the field where the code is stored. An example is M ICD"_IND_", where M signifies it is a movement diagnosis."
 . S NAME="ICD"_IND
 . S NODE="M "_NAME
 . S ONAME="ACR9M"_NAME
 . S XREF("NAME")="ACRDM"_IND
 . S XREF("VAL",2)=FIELD
 . S XREF("VAL",2,"SUBSCRIPT")=1
 . S XREF("SET")="D SPTFMD^DGPTDDCR(.X,.DA,"""_NODE_""")"
 . S XREF("KILL")="D KPTFMD^DGPTDDCR(.X,.DA,"""_NODE_""")"
 .;Remove any existing cross-references before creating the new one.
 . D DELIXN^DDMOD(45,ONAME,"","","MSG")
 . D DELIXN^DDMOD(45,XREF("NAME"),"","","MSG")
 . K MSG
 . D CREIXN^DDMOD(.XREF,"",.RESULT,"","MSG")
 . I RESULT="" D DCERRMSG^DG53862I(.MSG,.XREF)
 Q
 ;
 ;===========================================
CPTFPXR ;Update cross-references for PTF ICD procedure data.
 ;For node 401 surgery node:
 ;Fields: 45.01,8; 45.01,9; 45.01,10; 45.01,11; 45.01,12
 ;For node 601, procedure node:
 ;Fields: 45.05,4; 45.05,5; 45.05,6; 45.05,7; 45.05,8
 N IND,MSG,NAME,NODE,ONAME,NODENUM,RESULT,XREF
 D BMES^XPDUTL("Creating PTF ICD procedure cross-references.")
 ;Set the XREF nodes that are the same for all cross-references.
 S XREF("FILE")=45
 S XREF("TYPE")="MU"
 S XREF("SHORT DESCR")="Clinical Reminders Index for ICD procedure code lookup."
 S XREF("DESCR",1)="This cross-reference builds two indexes, one for finding"
 S XREF("DESCR",2)="all patients with a particular ICD procedure code and one for finding all"
 S XREF("DESCR",3)="the ICD procedure codes a patient has."
 S XREF("DESCR",4)="The indexes are stored in the Clinical Reminders Index global as:"
 S XREF("DESCR",5)=" ^PXRMINDX(45,CODESYS,""INP"",CODE,NODE,DFN,DATE,DAS) and"
 S XREF("DESCR",6)=" ^PXRMINDX(45,CODESYS,""PNI"",DFN,NODE,CODE,DATE,DAS)"
 S XREF("DESCR",7)="respectively."
 S XREF("DESCR",8)="CODESYS is the standard three-character abbreviation for the coding system."
 S XREF("DESCR",9)="DATE is the surgery/procedure date."
 S XREF("USE")="ACTION"
 S XREF("EXECUTION")="R"
 S XREF("ACTIVITY")="IR"
 ;
 ;These XREF nodes change for each cross-reference.
 S XREF("ROOT FILE")=45.01
 S XREF("VAL",1)=.01
 S XREF("VAL",1,"SUBSCRIPT")=1
 S XREF("VAL",2,"SUBSCRIPT")=2
 S IND=0,NODE="S"
 S XREF("DESCR",10)="NODE is S (for surgery) followed by operation code number. For example,"
 S XREF("DESCR",12)="For complete details, see the Clinical Reminders Index Technical Guide/Programmer's Manual."
 F NODENUM=8,9,10,11,12 D
 . S IND=IND+1
 . S XREF("DESCR",11)=NODE_IND_" means it was found on the S node and it was Operation Code "_IND_"."
 . S ONAME="ACR0S"_IND
 . S XREF("NAME")="ACRPS"_IND
 . S XREF("VAL",2)=NODENUM
 . S XREF("SET")="D SPTFP^DGPTDDCR(.X,.DA,"""_NODE_""","_IND_")"
 . S XREF("KILL")="D KPTFP^DGPTDDCR(.X,.DA,"""_NODE_""","_IND_")"
 .;Remove any existing cross-references before creating the new one.
 . D DELIXN^DDMOD(45,ONAME,"","","MSG")
 . D DELIXN^DDMOD(45,XREF("NAME"),"","","MSG")
 . K MSG
 . D CREIXN^DDMOD(.XREF,"W",.RESULT,"","MSG")
 . I RESULT="" D DCERRMSG^DG53862I(.MSG,.XREF)
 ;
 S XREF("ROOT FILE")=45.05
 S XREF("VAL",1)=.01
 S XREF("VAL",1,"SUBSCRIPT")=1
 S XREF("VAL",2,"SUBSCRIPT")=2
 S IND=0,NODE="P"
 S XREF("DESCR",10)="NODE is P (for procedure) followed by procedure code number. For example,"
 S XREF("DESCR",12)="For complete details, see the Clinical Reminders Index Technical Guide/Programmer's Manual."
 F NODENUM=4,5,6,7,8 D
 . S IND=IND+1
 . S XREF("DESCR",11)=NODE_IND_" means it was found on the P node and it was Procedure Code "_IND_"."
 . S ONAME="ACR0P"_IND
 . S XREF("NAME")="ACRPP"_IND
 . S XREF("VAL",2)=NODENUM
 . S XREF("SET")="D SPTFP^DGPTDDCR(.X,.DA,"""_NODE_""","_IND_")"
 . S XREF("KILL")="D KPTFP^DGPTDDCR(.X,.DA,"""_NODE_""","_IND_")"
 .;Remove any existing cross-references before creating the new one.
 . D DELIXN^DDMOD(45,ONAME,"","","MSG")
 . D DELIXN^DDMOD(45,XREF("NAME"),"","","MSG")
 . K MSG
 . D CREIXN^DDMOD(.XREF,"W",.RESULT,"","MSG")
 . I RESULT="" D DCERRMSG^DG53862I(.MSG,.XREF)
 Q
 ;
 ;===========================================
DCERRMSG(MSG,XREF) ;Display cross-reference creation errors.
 D BMES^XPDUTL("A cross-reference could not be created. The error message is:")
 D AWRITE^DG53862I("MSG")
 D BMES^XPDUTL("Cross-reference information:")
 D AWRITE^DG53862I("XREF")
 Q
 ;
 ;===========================================
POST ;Post-init
 ;Update the cross-references.
 D CPTFXR^DG53862I
 ;Rebuild the Index in the new format.
 D REINDEX^DG53862I
 Q
 ;
 ;===========================================
REINDEX ;Rebuild the PTF portion of the Clinical Reminders Index.
 N TEXT,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSK
 ;If the Index has already been restructured don't do it again.
 I $D(^PXRMINDX(45,"ICD")),$D(^PXRMINDX(45,"DATE BUILT")) D
 . S TEXT(1)="The PTF Index has already been rebuilt, skipping another rebuild."
 I $D(^PXRMINDX(45,"ICD")),'$D(^PXRMINDX(45,"DATE BUILT")) D
 . S TEXT(1)="The PTF Index has been partially rebuilt; not starting another rebuild in case a rebuild is in progress."
 . S TEXT(2)="Please make sure the Index is completely rebuilt."
 I $D(TEXT(1)) D BMES^XPDUTL(.TEXT) Q
 S ZTRTN="INDEX^DGPTDDCR"
 S ZTDESC="PTF Clinical Reminders Index rebuild"
 S ZTDTH=$H
 S ZTIO=""
 D ^%ZTLOAD
 S TEXT(1)="PTF Clinical Reminders Index rebuild queued."
 S TEXT(2)="The task number is "_ZTSK_"."
 D MES^XPDUTL(.TEXT)
 Q
 ;
