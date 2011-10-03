DG53478I ; SLC/PKR - Create cross-references for clinical reminder index. ;10/12/2004
       ;;5.3;Registration;**478**;Aug 13, 1993
 ;
 Q
 ;===============================================================
CDGPTXR ;Create all the cross-references.
 D CDGPT0
 D CDGPT9
 D CHLOC
 Q
 ;
 ;===============================================================
CDGPT0 ;Create cross-references for PTF ICD0 data.
 ;For node 401 surgery node:
 ;ICD0 from nodes: 45.01,8; 45.01,9; 45.01,10; 45.01,11; 45.01,12
 ;For node 601, procedure node:
 ;ICD0 from nodes: 45.05,4; 45.05,5; 45.05,6; 45.05,7; 45.05,8
 N IND,MSG,NAME,NODE,NODENUM,RESULT,XREF
 D BMES^XPDUTL("Creating PTF ICD0 cross-references.")
 ;Set the XREF nodes that are the same for all cross-references.
 S XREF("FILE")=45
 S XREF("WHOLE KILL")="K ^PXRMINDX(45,""ICD0"")"
 S XREF("TYPE")="MU"
 S XREF("SHORT DESCR")="Clinical Reminders index for ICD0 lookup."
 S XREF("DESCR",1)="This cross-reference builds two indexes, one for finding"
 S XREF("DESCR",2)="all patients with a particular ICD0 code and one for finding all"
 S XREF("DESCR",3)="the ICD0 codes a patient has."
 S XREF("DESCR",4)="The indexes are stored in the Clinical Reminders index global as:"
 S XREF("DESCR",5)=" ^PXRMINDX(45,""ICD0"",""INP"",ICD0,NODE,DFN,DATE,DAS) and"
 S XREF("DESCR",6)=" ^PXRMINDX(45,""ICD0"",""PNI"",DFN,NODE,ICD0,DATE,DAS)"
 S XREF("DESCR",7)="respectively. DATE is the surgery/procedure date."
 S XREF("USE")="ACTION"
 S XREF("EXECUTION")="R"
 S XREF("ACTIVITY")="IR"
 ;
 ;These XREF nodes change for each cross-reference.
 S XREF("ROOT FILE")=45.01
 S XREF("VAL",1)=.01
 S XREF("VAL",1,"SUBSCRIPT")=1
 S XREF("VAL",2,"SUBSCRIPT")=2
 S IND=0
 S NODE="S"
 S XREF("DESCR",8)="NODE is S followed by code number. For example,"
 S XREF("DESCR",10)="For all the details, see the Clinical Reminders Index Technical Guide/Programmer's Manual."
 F NODENUM=8,9,10,11,12 D
 . S IND=IND+1
 . S XREF("DESCR",9)=NODE_IND_" means it was found on the S node and it was operation code "_IND_"."
 . S NAME="ACR0S"_IND
 . S XREF("NAME")=NAME
 . S XREF("VAL",2)=NODENUM
 . S XREF("SET")="D SDGPT0^DGPTDDCR(.X,.DA,"""_NODE_""","_IND_")"
 . S XREF("KILL")="D KDGPT0^DGPTDDCR(.X,.DA,"""_NODE_""","_IND_")"
 . D CREIXN^DDMOD(.XREF,"k",.RESULT,"","MSG")
 . I RESULT="" D DCERRMSG^PXRMP12I(.MSG,.XREF)
 ;
 S XREF("ROOT FILE")=45.05
 S XREF("VAL",1)=.01
 S XREF("VAL",1,"SUBSCRIPT")=1
 S XREF("VAL",2,"SUBSCRIPT")=2
 S IND=0
 S NODE="P"
 S XREF("DESCR",8)="NODE is S followed by code number. For example,"
 S XREF("DESCR",10)="For all the details, see the Clinical Reminders Index Technical Guide/Programmer's Manual."
 F NODENUM=4,5,6,7,8 D
 . S IND=IND+1
 . S XREF("DESCR",9)=NODE_IND_" means it was found on the P node and it was operation code "_IND_"."
 . S NAME="ACR0P"_IND
 . S XREF("NAME")=NAME
 . S XREF("VAL",2)=NODENUM
 . S XREF("SET")="D SDGPT0^DGPTDDCR(.X,.DA,"""_NODE_""","_IND_")"
 . S XREF("KILL")="D KDGPT0^DGPTDDCR(.X,.DA,"""_NODE_""","_IND_")"
 . D CREIXN^DDMOD(.XREF,"k",.RESULT,"","MSG")
 . I RESULT="" D DCERRMSG^PXRMP12I(.MSG,.XREF)
 Q
 ;
 ;===============================================================
CDGPT9 ;Create cross-references for PTF ICD9 data.
 ;ICD9 from nodes: 45,79; 45,80; 45,79.16 45,79.17; 45,79.18;
 ;45,79.19; 45,79.201; 45,79.21; 45,79.22; 45,79.22; 45.79.23;
 ;45,79.24; 45,79.241; 45,79.242; 45,79.243; 45,79.244
 ;By name these nodes are: DXLS, PRINCIPAL DIAGNOSIS, SECONDARY
 ;DIAGNOSIS 1, through SECONDARY DIAGNOSIS 12.
 N IND,MSG,NAME,NODE,RESULT,XREF
 D BMES^XPDUTL("Creating PTF ICD9 cross-references.")
 ;Set the XREF nodes that are the same for all cross-references.
 S XREF("FILE")=45
 S XREF("ROOT FILE")=45
 S XREF("WHOLE KILL")="K ^PXRMINDX(45)"
 S XREF("TYPE")="MU"
 S XREF("SHORT DESCR")="Clinical Reminders index for ICD9 lookup."
 S XREF("DESCR",1)="This cross-reference builds two indexes, one for finding"
 S XREF("DESCR",2)="all patients with a particular ICD9 code and one for finding all"
 S XREF("DESCR",3)="the ICD9 codes a patient has."
 S XREF("DESCR",4)="The indexes are stored in the Clinical Reminders index global as:"
 S XREF("DESCR",5)=" ^PXRMINDX(45,""ICD9"",""INP"",ICD9,NAME,DFN,DATE,DAS) and"
 S XREF("DESCR",6)=" ^PXRMINDX(45,""ICD9"",""PNI"",DFN,NAME,ICD9,DATE,DAS)"
 S XREF("DESCR",7)="respectively. DATE is the discharge date. If it does not"
 S XREF("DESCR",8)="exist then the admission date is used."
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
 S XREF("DESCR",9)="NAME is the name of the ICD9 code field. An example is DXLS."
 S XREF("DESCR",10)="If the TYPE OF RECORD is CENSUS then the entry is not indexed."
 S XREF("DESCR",11)="For all the details, see the Clinical Reminders Index Technical Guide/Programmer's Manual."
 S XREF("NAME")="ACR9DXLS"
 S XREF("VAL",4)=79
 S XREF("VAL",4,"SUBSCRIPT")=4
 S XREF("SET")="D SDGPT9D^DGPTDDCR(.X,.DA,""DXLS"")"
 S XREF("KILL")="D KDGPT9D^DGPTDDCR(.X,.DA,""DXLS"")"
 D CREIXN^DDMOD(.XREF,"k",.RESULT,"","MSG")
 I RESULT="" D DCERRMSG^PXRMP12I(.MSG,.XREF)
 ;
 S XREF("DESCR",9)="NAME is the name of the ICD9 code field. An example is PDX."
 S XREF("DESCR",10)="If the TYPE OF RECORD is CENSUS then the entry is not indexed."
 S XREF("DESCR",11)="For all the details, see the Clinical Reminders Index Technical Guide/Programmer's Manual."
 S XREF("NAME")="ACR9PDX"
 S XREF("VAL",4)=80
 S XREF("VAL",4,"SUBSCRIPT")=4
 S XREF("SET")="D SDGPT9D^DGPTDDCR(.X,.DA,""PDX"")"
 S XREF("KILL")="D KDGPT9D^DGPTDDCR(.X,.DA,""PDX"")"
 D CREIXN^DDMOD(.XREF,"k",.RESULT,"","MSG")
 I RESULT="" D DCERRMSG^PXRMP12I(.MSG,.XREF)
 ;
 ;Remove the cross-references using the original names (this applies to
 ;test sites).
 S IND=1
 F FIELD=79.16,79.17,79.18,79.19,79.201,79.21,79.22,79.23,79.24 D
 . S IND=IND+1
 . S NAME="ACR9DICD"_IND
 . D DELIXN^DDMOD(45,NAME,"","","MSG")
 . I RESULT="" D DCERRMSG^PXRMP12I(.MSG,.XREF)
 ;Remove ACR9DSD14, it was created in error.
 D DELIXN^DDMOD(45,"ACR9DSD14","","","MSG")
 I RESULT="" D DCERRMSG^PXRMP12I(.MSG,.XREF)
 ;
 S IND=0
 F FIELD=79.16,79.17,79.18,79.19,79.201,79.21,79.22,79.23,79.24,79.241,79.242,79.243,79.244 D
 . S IND=IND+1
 . S XREF("DESCR",9)="NAME is the name of the ICD9 code field. An example is D SD"_IND_", where D SD tells us it is a discharge secondary diagnosis."
 . S XREF("DESCR",10)="If the TYPE OF RECORD is CENSUS then the entry is not indexed."
 . S XREF("DESCR",11)="For all the details, see the Clinical Reminders Index Technical Guide/Programmer's Manual."
 . S NAME="SD"_IND
 . S NODE="D "_NAME
 . S XREF("NAME")="ACR9D"_NAME
 . S XREF("VAL",4)=FIELD
 . S XREF("VAL",4,"SUBSCRIPT")=4
 . S XREF("SET")="D SDGPT9D^DGPTDDCR(.X,.DA,"""_NODE_""")"
 . S XREF("KILL")="D KDGPT9D^DGPTDDCR(.X,.DA,"""_NODE_""")"
 . D CREIXN^DDMOD(.XREF,"k",.RESULT,"","MSG")
 . I RESULT="" D DCERRMSG^PXRMP12I(.MSG,.XREF)
 ;
 ;Add the movement nodes.
 K XREF("VAL")
 S XREF("ROOT FILE")=45.02
 S XREF("VAL",1)=10
 S XREF("VAL",1,"SUBSCRIPT")=1
 S XREF("DESCR",7)="respectively. DATE is movement date."
 K XREF("DESCR",8),XREF("DESCR",9),XREF("DESCR",10),XREF("DESCR",11)
 S XREF("DESCR",9)="If the TYPE OF RECORD is CENSUS then the entry is not indexed."
 S XREF("DESCR",10)="For all the details, see the Clinical Reminders Index Technical Guide/Programmer's Manual."
 S IND=0
 F FIELD=5,6,7,8,9,11,12,13,14,15 D
 . S IND=IND+1
 . S XREF("DESCR",8)="NAME is the name of the ICD9 code field. An example is M ICD"_IND_", where M tells us it is a movement diagnosis."
 . S NAME="ICD"_IND
 . S NODE="M "_NAME
 . S XREF("NAME")="ACR9M"_NAME
 . S XREF("VAL",2)=FIELD
 . S XREF("VAL",2,"SUBSCRIPT")=2
 . S XREF("SET")="D SDGPT9M^DGPTDDCR(.X,.DA,"""_NODE_""")"
 . S XREF("KILL")="D KDGPT9M^DGPTDDCR(.X,.DA,"""_NODE_""")"
 . D CREIXN^DDMOD(.XREF,"k",.RESULT,"","MSG")
 . I RESULT="" D DCERRMSG^PXRMP12I(.MSG,.XREF)
 Q
 ;
 ;===============================================================
CHLOC ;Create cross-references for Hospital Location.
 N MSG,RESULT,XREF
 D BMES^XPDUTL("Creating Hospital Location cross-references.")
 S XREF("FILE")=44
 S XREF("ROOT FILE")=44
 S XREF("TYPE")="R"
 S XREF("USE")="SORTING ONLY"
 S XREF("EXECUTION")="F"
 S XREF("ACTIVITY")="IR"
 S XREF("SHORT DESCR")="Index credit stop codes"
 S XREF("DESCR",1)="This index can be used to find all hospital locations in a"
 S XREF("DESCR",2)="credit stop code."
 S XREF("WHOLE KILL")="K ^SC(""ACST"")"
 S XREF("VAL",1)=2503
 S XREF("VAL",1,"SUBSCRIPT")=1
 S XREF("NAME")="ACST"
 S XREF("SET")="S ^SC(""ACST"",X,DA)"
 S XREF("KILL")="K ^SC(""ACST"",X,DA)"
 D CREIXN^DDMOD(.XREF,"kS",.RESULT,"","MSG")
 I RESULT="" D DCERRMSG^PXRMP12I(.MSG,.XREF)
 ;
 S XREF("SHORT DESCR")="Index stop codes"
 S XREF("DESCR",1)="This index can be used to find all hospital locations in a"
 S XREF("DESCR",2)="stop code."
 S XREF("WHOLE KILL")="K ^SC(""AST"")"
 S XREF("VAL",1)=8
 S XREF("VAL",1,"SUBSCRIPT")=1
 S XREF("NAME")="AST"
 S XREF("SET")="S ^SC(""AST"",X,DA)"
 S XREF("KILL")="K ^SC(""AST"",X,DA)"
 K MSG
 D CREIXN^DDMOD(.XREF,"kS",.RESULT,"","MSG")
 I RESULT="" D DCERRMSG^PXRMP12I(.MSG,.XREF)
 ;Eliminate the original CST and ST indexes.
 D DELIXN^DDMOD(44,"CST")
 D DELIXN^DDMOD(44,"ST")
 K ^SC("CST")
 K ^SC("ST")
 Q
 ;
