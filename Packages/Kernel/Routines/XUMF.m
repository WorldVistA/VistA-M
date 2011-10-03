XUMF ;OIFO-OAK/RAM - XUMF API's;04/15/02
 ;;8.0;KERNEL;**218,335,416**;Jul 10, 1995;Build 5
 ;
 Q
 ;
IEN(IFN,CDSYS,ID) ; -- Internal Entry Number
 ;
 N IEN,ROOT
 ;
 S IFN=$G(IFN),CDSYS=$G(CDSYS),ID=$G(ID)
 ;
 Q:'IFN "0^IFN required"
 Q:CDSYS="" "0^CDSYS required"
 Q:ID="" "0^ID required"
 ;
 S ROOT=$$ROOT^DILFD(IFN,,1) Q:ROOT="" "0^invalid IFN"
 S IEN=$O(@ROOT@("XUMFIDX",CDSYS,ID,0))
 ;
 Q $S(IEN:IEN,1:"0^not found")
 ;
FLD(FILE,FIELD) ; field
 ;
 N Y,DA,X
 ;
 S Y=$$FIELD(FILE,FIELD,"LABEL")
 ;
 Q $S(Y'="":1,1:0)
 ;
LBL(FILE,FIELD) ; field label
 ;
 Q $$FIELD(FILE,FIELD,"LABEL")
 ;
TYP(FILE,FIELD) ; field type
 ;
 Q $$FIELD(FILE,FIELD,"TYPE")
 ;
PTR(FILE,FIELD) ; pointer field?
 ;
 Q $S($$TYP(FILE,FIELD)="POINTER":1,1:0)
 ;
FIELD(FILE,FIELD,ATT) ; field attributes
 ;
 N Y,DA,X
 ;
 Q:'$G(FILE) ""
 Q:'$G(FIELD) ""
 Q:$G(ATT)="" ""
 ;
 D FIELD^DID(FILE,FIELD,"N",ATT,"Y")
 ;
 Q $G(Y(ATT))
 ;
FILE(FILE,ATT) ; file attributes
 ;
 N Y,DA,X
 ;
 Q:'$G(FILE) ""
 Q:$G(ATT)="" ""
 ;
 D FILE^DID(FILE,,ATT,"Y")
 ;
 Q $G(Y(ATT))
 ;
ECHO(FILE,IDX,X,XUMF) ; validate field exists and echo name
 ;
 Q:'$$F(+$G(XUMF)) 0
 ;
 N SUBFILE,NAME
 ;
 S SUBFILE=$P($G(^DIC(4.001,+$G(FILE),1,+$G(IDX),0)),U,4)
 ;
 S NAME=$$LBL($S(SUBFILE:SUBFILE,1:+$G(FILE)),X)
 ;
 Q:NAME="" 0
 ;
 ;W " "_NAME
 ;
 Q 1
 ;
F(XUMF) ; constrain edits to standard values
 ;
 Q $S($G(XUMF):1,1:0)
 ;
PKV(IFN,IEN,HLCS) ; Primary Key Value - MFE.4
 ;
 S IFN=$G(IFN),IEN=$G(IEN),HLCS=$G(HLCS)
 ;
 N MFE,NODE,ID,TEXT,CDSYS,IENS
 ;
 S NODE=$G(^DIC(4.001,IFN,"MFE"))
 Q:NODE="" "1Error - MFS parameter not defined for IFN "_IFN
 ;
 S:HLCS="" HLCS="~"
 S CDSYS=$P(NODE,U,3)
 ;
 Q:IEN="NEW" IEN_HLCS_"NEW ENTRY"_HLCS_CDSYS
 ;
 Q:'IFN "1Error - IFN required"
 Q:'IEN "1Error - IEN required"
 ;
 S IENS=IEN_","
 ;
 S FIELD=$P(NODE,U,1),ID=$$GET1^DIQ(IFN,IENS,FIELD)
 S FIELD=$P(NODE,U,2),TEXT=$$GET1^DIQ(IFN,IENS,FIELD)
 ;
 S MFE=ID_HLCS_TEXT_HLCS_CDSYS
 ;
 Q:'$P(NODE,U,4) MFE
 ;
 S FIELD=$P(NODE,U,4),ID=$$GET1^DIQ(IFN,IENS,FIELD)
 S FIELD=$P(NODE,U,5),TEXT=$$GET1^DIQ(IFN,IENS,FIELD)
 S CDSYS=$P(NODE,U,6)
 ;
 Q MFE_HLCS_ID_HLCS_TEXT_HLCS_CDSYS
 ;
MFE(IFN,PKV,HLCS,IEN,ERROR) ; -- update
 ;
 N IENS,MFE,I,X,ID,XREF,NAME,FLD,FDA,DIC
 ;
 S IFN=$G(IFN),IEN=$G(IEN),HLCS=$G(HLCS),ERROR=$G(ERROR)
 S:HLCS="" HLCS="~"
 ;
 Q:ERROR
 ;
 I 'IFN S ERROR="1Error - IFN required" Q
 ;
 I IFN'=4.001 D  Q:ERROR
 .S MFE=$G(^DIC(4.001,IFN,"MFE")),XREF=$P(MFE,U,8)
 .I '$P(MFE,U,1) D  Q
 ..S ERROR="1MFS PARAM MFE.4.1 null"
 ..D EM^XUMFH(ERROR,.ERR)
 .I '$P(MFE,U,2) D  Q
 ..S ERROR="1MFS PARAM MFE.4.2 null"
 ..D EM^XUMFH(ERROR,.ERR)
 .I XREF="" D  Q
 ..S ERROR="1MFS PARAM MFE XREF not defined"
 ..D EM^XUMFH(ERROR,.ERR)
 ;
 I IFN=4.001 D  Q
 .S IEN=$$FIND1^DIC(1,,"BX",$P(PKV,HLCS))
 .I 'IEN D  Q
 ..S ERROR="1not a valid IEN in MFE XUMF"
 ..D EM^XUMFH(ERROR,.ERR)
 .Q:$D(^DIC(4.001,IEN))
 .X HLNEXT
 .I $P(HLNODE,HLFS)'="ZZZ" D  Q
 ..S ERROR="1MFP error in MFE XUMF"
 ..D EM^XUMFH(ERROR,.ERR)
 .S MFE=$P(HLNODE,HLFS,7,12),MFE=$TR(MFE,HLFS,U)
 .S X="" F I=5,4,2,1 S:$P(MFE,U,I)=.01 X=I
 .I 'X D  Q
 ..S ERROR="1MFS PARAM no .01 in MFE"
 ..D EM^XUMFH(ERROR,.ERR)
 .S NAME=$P(PKV,HLCS,X) K X
 .K FDA
 .S FDA(IFN,"?+1,",.01)=NAME
 .D UPDATE^DIE("E","FDA")
 ;
 S ID=$P(PKV,HLCS)
 I ID="" D  Q
 .S ERROR="1MFS PARAM MFE PKV ID null"
 .D EM^XUMFH(ERROR,.ERR)
 S ROOT=$$ROOT^DILFD(IFN,,1)
 I $D(@ROOT@(XREF)),'$G(IEN) S IEN=$O(@ROOT@(XREF,ID,0))
 S:'IEN IEN=$$FIND1^DIC(IFN,,"B",ID)
 ;
 I 'IEN D  Q:ERROR
 .S X="" F I=5,4,2,1 S:$P(MFE,U,I)=.01 X=I
 .I 'X D  Q
 ..S ERROR="1MFS PARAM no .01 in MFE"
 ..D EM^XUMFH(ERROR,.ERR)
 .S NAME=$P(PKV,HLCS,X) K X
 .I NAME="" S ERROR="1MFS PARAM MFE PKV .01 is null" Q
 .D CHK^DIE(IFN,.01,,NAME,.X)
 .I X="^" D  Q
 ..S ERROR="1MFS PARAM MFE PKV .01 is invalid"
 ..D EM^XUMFH(ERROR,.ERR)
 .K DIC S DIC=IFN,DIC(0)="F" D FILE^DICN K DIC
 .I Y="-1" D  Q
 ..S ERROR="1MFS PARAM MFE FileDICN unsuccessful"
 ..D EM^XUMFH(ERROR,.ERR)
 .S IEN=+Y
 ;
 S IENS=IEN_","
 ;
 F I=1,2,4,5 D
 .S FLD=$P(MFE,U,I) Q:'FLD
 .S FDA(IFN,IENS,FLD)=$P(PKV,HLCS,I)
 ;
 D FILE^DIE("E","FDA","ERR")
 I $D(ERR) D
 .D EM^XUMFH("1FILE DIE error msg in MFE of XUMF",.ERR)
 .K ERR
 ;
 Q
 ;
MFP(IFN,ERR) ; -- validate Master File Parameters entry FALSE=valid
 ;
 Q:'$G(IFN) "IFN null"
 ;
 D ZERO(IFN,.ERR)
 D MFE1(IFN,.ERR)
 D SEQ(IFN,.ERR)
 ;
 Q $S($D(ERR("FATAL")):1,$D(ERR("WARNING")):2,1:0)
 ;
ZERO(IFN,ERR) ; -- zero node
 ;
 N X,CNT
 ;
 S X=$G(^DIC(4.001,+IFN,0)),CNT=1
 I $P(X,U,2)="" D
 .S ERR("FATAL","ZERO",CNT)="Z SEGMENT is null",CNT=CNT+1
 I $P(X,U,3)="" D
 .S ERR("FATAL","ZERO",CNT)="MFI CODE is null",CNT=CNT+1
 I $P(X,U,4)="" D
 .S ERR("WARNING","ZERO",CNT)="PRE-UPDATE ROUTINE is null",CNT=CNT+1
 I $P(X,U,5)="" D
 .S ERR("WARNING","ZERO",CNT)="POST-UPDATE ROUTINE is null",CNT=CNT+1
 I $P(X,U,6)="" D
 .S ERR("WARNING","ZERO",CNT)="MAIL GROUP is null",CNT=CNT+1
 ;
 Q
 ;
MFE1(IFN,ERR) ; -- MFE node
 ;
 N X,I,CNT
 ;
 S X=$G(^DIC(4.001,+IFN,"MFE")),CNT=1
 F I=1:1:6 I $P(X,U,I)="" D
 .S ERR("FATAL","MFE",CNT)="MFE ID & ALT ID field and codsys required"
 .S CNT=CNT+1
 I $P(X,U,8)="" D
 .S ERR("FATAL","MFE",CNT)="MFE PKV X-REF required",CNT=CNT+1
 F I=11,12,14,15 I $P(X,U,I)="" D
 .S ERR("WARNING","MFE",CNT)="MFE PKV types are null",CNT=CNT+1
 I $P(X,U,9)="" D
 .S ERR("WARNING","MFE",CNT)="ASSIGNING AUTHORITY is null",CNT=CNT+1
 ;
 Q
 ;
SEQ(IFN,ERR) ; -- sequence nodes
 ;
 N SEQ,MULT,X,I,Y
 ;
 S SEQ=0
 F  S SEQ=$O(^DIC(4.001,IFN,1,SEQ)) Q:'SEQ  D
 .S X=$G(^DIC(4.001,IFN,1,SEQ,0))
 .I $$TYP($S($P(X,U,4):$P(X,U,4),1:IFN),$P(X,U,2))="POINTER" D
 ..Q:$P(X,U,7)'=""
 ..S Y=$S($P(X,U,4):$P(X,U,4),1:IFN),Y=$$LBL(Y,$P(X,U,2))
 ..S Y="field "_Y_" is pointer EXTENDED POINTER LKUP is NULL"
 ..S ERR("WARNING",SEQ)=Y
 .S MULT=$S($P(X,U,4):1,1:0)
 .I '$P(X,U,2) S ERR("FATAL",SEQ)=" missing FIELD NUMBER"
 .I MULT,$P(X,U,8)="" D
 ..S ERR("FATAL",SEQ)=" MULT IEN FUNCTION is null"
 .I MULT,$P(X,U,6),$P(X,U,5)'="" D
 ..S ERR("FATAL",SEQ)=" SUBFILE KEY LKUP/KEY SEQ mismatch"
 .I MULT,'$P(X,U,6),$P(X,U,5)="" D
 ..S ERR("FATAL",SEQ)=" SUBFILE KEY LKUP/KEY SEQ mismatch"
 .I 'MULT F I=5,6,8 D
 ..Q:$P(X,U,I)=""
 ..S ERR("FATAL",SEQ)=" SUBFILE null with subfile parameters"
 ;
 Q
 ;
BG(IFN,IEN,TYP) ; -- background job
 ;
 ; type (5=file, 7=array)
 ;
 N ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTSAVE
 ;
 S TYP=$G(TYP) S:'TYP TYP=5
 S IEN=$G(IEN) S:IEN="" IEN="ALL"
 ;
 S ZTDTH=$$NOW^XLFDT,ZTRTN="BG1^XUMF",ZTIO=""
 S ZTSAVE("IFN")="",ZTSAVE("TYP")="",ZTSAVE("IEN")=""
 S ZTDESC="XUMF get "_$$FILE^XUMF(IFN,"NAME")_" using MFS"
 ;
 D ^%ZTLOAD
 ;
 Q
 ;
BG1 ; -- get file
 ;
 D MFS(IFN,IEN,TYP,.ERROR),EXIT
 ;
 Q
 ;
LOAD(IFN) ; -- query and file
 ;
 D MFS(IFN,"ALL",5,.ERROR)
 ;
 Q
 ;
ARRAY(IFN) ; -- query and put in array
 ;
 D MFS(IFN,"ALL",7,.ERROR)
 ;
 Q
 ;
GETCE(IFN,IEN,TYP,ERROR) ; -- get master file provide coded element
 ;
 Q
 ;
MFS(IFN,IEN,TYP,ERROR) ; -- get file from Master File Server
 ;
 ; TYP (5=query/file, 7=query/tmp_array)
 ;
 N TEST
 ;
 S (ERROR,TEST)=0
 ;
 S IFN=$G(IFN),IEN=$G(IEN),TYP=$G(TYP)
 ;
 I 'IFN S ERROR="1IFN not valid MFS in XUMF" Q
 I IEN="" S ERROR="1IEN not valid MFS in XUMF" Q
 I TYP'=5,TYP'=7 S ERROR="1type not support by MFS in XUMF" Q
 ;
 I $P($$PARAM^HLCS2,U,3)="T" S TEST=1
 ;
 S PARAM("LLNK")="XUMF MFR^XUMF "_$S('TEST:"FORUM",1:"TEST")
 S PARAM("PROTOCOL")=$O(^ORD(101,"B","XUMF MFQ",0))
 ;
 D MAIN^XUMFP(IFN,"ALL",TYP,.PARAM,.ERROR) Q:ERROR
 D MAIN^XUMFI(IFN,"ALL",TYP,.PARAM,.ERROR) Q:ERROR
 D MAIN^XUMFH
 ;
 Q
 ;
 ;
EXIT ; -- cleanup and quit
 ;
 K ^TMP("XUMF MFS",$J),^TMP("DIERR",$J)
 ;
 S ZTREQ="@"
 ;
 Q
 ;
NPI ; -- NPI
 ;
 N COL,X,FDA,NPIDT,NPISTAT,NPI,TAX,TAXPC,TAXSTAT,ERR
 ;
 D SEGPRSE^XUMFXHL7("HLNODE","COL")
 ;
 S NPIDT=$$FMDATE^HLFNC(COL(17))
 S NPISTAT=COL(18)
 S NPI=COL(19)
 S TAX=COL(20)
 S TAXPC=COL(21)
 S TAXSTAT=COL(22)
 ;
 S X=$$NPI^XUSNPI("Organization_ID",IEN,NPIDT)
 I $S(X=0:1,$$UP^XLFSTR($P(X,U,3))'=NPISTAT:1,NPI'=+X:1,1:0) D
 .S X=$$ADDNPI^XUSNPI("Organization_ID",IEN,NPI,NPIDT,$S(NPISTAT="ACTIVE":1,1:0))
 ;
 S IENS="?+1,"_IEN_","
 K FDA
 S FDA(4.9999,IENS,.01)="NPI"
 S FDA(4.9999,IENS,.02)=NPI
 D UPDATE^DIE("E","FDA",,"ERR")
 ;
 K FDA
 S IENS="?+1,"_IEN_","
 S FDA(4.043,IENS,.01)=TAX
 S FDA(4.043,IENS,.02)=TAXPC
 S FDA(4.043,IENS,.03)=TAXSTAT
 D UPDATE^DIE("E","FDA",,"ERR")
 ;
 S SEQ=22
 ;
 Q
 ;
CDSYS(CDSYS,ID,IEN) ; udpate coding system / ID
 ;
 N IENS,FDA
 ;
 S IENS="?+1,"_IEN_","
 K FDA
 S FDA(4.9999,IENS,.01)=CDSYS
 S FDA(4.9999,IENS,.02)=ID
 D
 .N IEN,VALUE
 .D UPDATE^DIE("E","FDA")
 ;
 Q
 ;
