XUMFX ;ISS/RAM - XUMF API's;04/15/02
 ;;8.0;KERNEL;**299,382,383**;Jul 10, 1995
 ;
 Q
 ;
 ;
MFE(IFN,PKV,HLCS,IEN,ERROR) ; -- update
 ;
 N IENS,MFE,I,X,ID,XREF,NAME,FLD,FDA,DIC,Y
 ;
 S IFN=$G(IFN),IEN=$G(IEN),HLCS=$G(HLCS),ERROR=$G(ERROR)
 S:HLCS="" HLCS="~"
 ;
 Q:ERROR
 ;
 I 'IFN S ERROR="1^Error - IFN required HLNODE: "_HLNODE Q
 ;
 I $P(PKV,HLCS)=""!($P(PKV,HLCS,2)="")!($P(PKV,HLCS,4)="") D  Q:ERROR
 .Q:$G(XUMFSDS)="1H"
 .S ERROR="1^Error - PKV not valid HLNODE: "_HLNODE
 .D EM^XUMFH(ERROR,.ERR)
 ;
 S MFE=$G(^DIC(4.001,IFN,"MFE")),XREF=$P(MFE,U,8)
 I XREF="" D  Q
 .S ERROR="1^Error - MFE parameter XREF missing HLNODE: "_HLNODE
 .D EM^XUMFH(ERROR,.ERR)
 ;
 ;I IFN=4.001 D  Q
 ;.S IEN=$$FIND1^DIC(1,,"BX",$P(PKV,HLCS))
 ;.I 'IEN D  Q
 ;..S ERROR="1^not a valid IEN in MFE - HLNODE: "_HLNODE
 ;..D EM^XUMFH(ERROR,.ERR)
 ;.Q:$D(^DIC(4.001,IEN))
 ;.S NAME=$P(PKV,HLCS)
 ;.K FDA
 ;.S FDA(IFN,"?+1,",.01)=NAME
 ;.D UPDATE^DIE("E","FDA",,"ERR")
 ;.I $D(ERR) D  Q
 ;..S ERROR="1^MFE UPDATE FAILED for .01 File#: "_IFN
 ;..D EM^XUMFH(ERROR,.ERR)
 ;
 ;lookup an active VUID
 S VUID=$P(PKV,HLCS)
 I $G(XUMFSDS)="1H" S VUID=$P(PKV,HLCS,4)
 S ROOT=$$ROOT^DILFD(IFN,,1)
 I '$L(ROOT) D  Q
 .S ERROR="1^Error - MFE no root file#: "_IFN
 .D EM^XUMFH(ERROR,.ERR)
 S IEN=$O(@ROOT@("AMASTERVUID",VUID,1,0))
 ;
 ;reactivate an existing inactive VUID
 I 'IEN D
 .S IEN=$O(@ROOT@("AMASTERVUID",VUID,0,0)) Q:'IEN
 .K FDA,ERR
 .S IENS=IEN_","
 .S FDA(IFN,IENS,99.98)=1
 .D FILE^DIE("E","FDA","ERR")
 .I $D(ERR) D
 ..S ERROR="1^flag update error for IFN: "_IFN_" IEN: "_IEN_" PKV: "_PKV
 ..D EM^XUMFH(ERROR,.ERR)
 ..K ERR
 ;
 Q:IEN
 ;
 I $G(XUMFSDS)="1H",'IEN D  Q
 .S ERROR="1^SDS history could not find owning record PKV: "_PKV
 .D EM^XUMFH(ERROR,.ERR)
 ;
 I 'IEN D
 .S KEY=$P(PKV,HLCS,4)
 .S IEN=$O(@ROOT@(XREF,KEY,0))
 ;
 I 'IEN D  Q:ERROR
 .S NAME=$P(PKV,HLCS,2)
 .D CHK^DIE(IFN,.01,,NAME,.X)
 .I X="^" D  Q
 ..S ERROR="1^Error - PKV .01 is invalid"_" File #: "_IFN_" PKV="_PKV
 ..D EM^XUMFH(ERROR,.ERR)
 .K DIC S DIC=IFN,DIC(0)="F" D FILE^DICN K DIC
 .I Y="-1" D  Q
 ..S ERROR="1^stub entry for "_PKV_" failed PKV: "_PKV
 ..D EM^XUMFH(ERROR,.ERR)
 .S IEN=+Y
 ;
 S IENS=IEN_","
 ;
 I $L($P(MFE,U)),$P(MFE,U)'=99.99 Q
 S FDA(IFN,IENS,99.99)=$P(PKV,HLCS,1)
 S FDA(IFN,IENS,99.98)=1
 ;
 K ERR
 ;
 D FILE^DIE("E","FDA","ERR")
 I $D(ERR) D
 .S ERROR="1^VUID update error for IFN: "_IFN_" IEN: "_IEN_" PKV: "_PKV
 .D EM^XUMFH(ERROR,.ERR)
 .K ERR
 ;
 Q
 ;
VUID(FILE,FIELD,VUID,X) ; -- If value type pointer and VUID may be used,
 ; get IEN and set it as internal value
 N XVUID,X1
 Q:'$L(FILE)!'FIELD!'$L(VUID) 0
 Q:$E(X,1,$L(VUID))'=VUID 0
 S XVUID=$E(X,$L(VUID)+1,$L(X))
 D FIELD^DID(FILE,FIELD,,"POINTER","X1")
 S X1=$G(X1("POINTER"))
 Q:'$L(X1) 0
 S X1=U_X1_"""AMASTERVUID"",XVUID,1,0)"
 S X1=$O(@X1)
 Q +X1
 ;
VAL(FILE,FIELD,VUID,VALUE,IENS) ; convert to internal
 ;
 N RESULT,ERR
 ;
 I $L(VUID) D  Q RESULT
 .I VUID="SDS" S VALUE=VUID_+VALUE
 .S RESULT=$$VUID(FILE,FIELD,VUID,VALUE)
 .I 'RESULT D
 ..S RESULT="^",ERROR="1^VUID lookup failed on "_VALUE
 ..D EM("VUID lookup failed on "_VALUE)
 ;
 I VALUE["\F\" F  Q:VALUE'["\F\"  D
 .S VALUE=$P(VALUE,"\F\")_"^"_$P(VALUE,"\F\",2,9999)
 I VALUE["\T\" F  Q:VALUE'["\T\"  D
 .S VALUE=$P(VALUE,"\T\")_"&"_$P(VALUE,"\T\",2,9999)
 ;
 D VAL^DIE(FILE,IENS,FIELD,,VALUE,.RESULT,,"ERR")
 I $D(ERR) D EM("validation error",.ERR)
 I RESULT="^" S ERROR="1^data validation error"
 ;
 Q RESULT
 ;
EM(ERROR,ERR,XMSUB,XMY) ; -- error message
 ;
 N X,XMTEXT,XMDUZ,GROUP
 ;
 D MSG^DIALOG("AM",.X,80,,"ERR")
 ;
 S X(.1)="HL7 message ID: "_$G(HL("MID"))
 S X(.2)="",X(.3)=$G(ERROR)
 S X(.4)="",X(.5)="Key: "_$G(KEY),X(.6)=""
 S:$G(XMSUB)="" XMSUB="MFS ERROR/WARNING/INFO"
 S XMY("G.XUMF ERROR")="",XMDUZ=.5
 S GROUP=$P($G(^DIC(4.001,+IFN,0)),U,6)
 I GROUP'="" S GROUP="G."_GROUP,XMY(GROUP)=""
 S XMTEXT="X("
 ;
 M ^TMP("XUMF ERROR",$J,$O(^TMP("XUMF ERROR",$J,9999999999999),-1)+1)=X
 ;
 D ^XMD
 ;
 Q
 ;
