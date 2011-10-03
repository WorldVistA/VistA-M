ANRVOA ; HOIFO/CED - User, Patient and Parameter specifics for Patient Review. ; [01-07-2003 12:19]
 ;;4.0;VISUAL IMPAIRMENT SERVICE TEAM;**5**;AUG 21, 2003
ADD(X) ; [Procedure] Adds to RESULTS
 S @RESULTS@(+$O(@RESULTS@(""),-1)+1)=X
 Q
 ;
DELLST ; [Procedure] Delete list of parameters
 D NDEL^XPAR(ENT,PAR,.ERR)
 S:'$G(ERR) @RESULTS@(0)="1^All Instances Removed"
 Q
 ;
DELPAR ; [Procedure] Delete single parameter value
 D DEL^XPAR(ENT,PAR,INST,.ERR)
 S:'$G(ERR) @RESULTS@(0)="1^Instance Deleted"
 Q
 ;
ELECSIG ; [Procedure] Check Electronic Signature
 N X
 S X=DATA
 S X1=$S($D(DUZ)[0:"",$D(^VA(200,DUZ,20))[0:"",1:$P(^(20),U,4))
 I X1="" S @RESULTS@(0)="-1^Electronic Signature Not Found." Q
 D HASH^XUSHSHP
 I X1'=X S @RESULTS@(0)="0^Electronic Signature Incorrect." Q
 S @RESULTS@(0)="1^Electronic Signature Verified."
 Q
 ;
ENTVAL ; [Procedure] Return value of the entity
 I ENT="SYS" S ENT=$$KSP^XUPARAM("WHERE")
 E  I ENT="DIV" S ENT=$$GET1^DIQ(4,DUZ(2)_",",.01)
 E  I ENT="USR" S ENT=$$GET1^DIQ(200,DUZ_",",.01)
 E  S ENT=$$GET1^DIQ(+$P(ENT,"(",2),+ENT_",",.01)
 S @RESULTS@(0)=ENT
 Q
 ;
FULLSSN(LST,ID) ; [Procedure] Return a list of patients matching Full SSN entered
 N I,IEN
 S (I,IEN)=0
 F  S IEN=$O(^DPT("SSN",ID,IEN)) Q:'IEN  D
 . S I=I+1,LST(I)=IEN_U_$P(^DPT(IEN,0),U)_U_$$DOB^DPTLK1(IEN,2)_U_$$SSN^DPTLK1(IEN)  ; DG249
 Q
 ;
GETHDR ; [Procedure] Returns common header format
 S X=$$FIND1^DIC(8989.51,,"QX",PAR)
 I X S @RESULTS@(0)=X_";8989.51^"_PAR
 E  S @RESULTS@(0)="-1^No such parameter ["_PAR_"]"
 Q
 ;
GETLST ; [Procedure] Return all instances of a parameter
 D GETLST^XPAR(.RET,ENT,PAR,"E",.ERR)
 Q:$G(ERR,0)
 S TMP="RET"
 F  S TMP=$Q(@TMP) Q:TMP=""  D
 .S @RESULTS@($O(@RESULTS@(""),-1)+1)=@TMP
 S @RESULTS@(0)=$O(@RESULTS@(""),-1)
 Q
 ;
GETPAR ; [Procedure] Returns external value for a parameter
 S @RESULTS@(0)=$$GET^XPAR(ENT,PAR,INST,"E")
 Q
 ;
GETWP ; [Procedure] Returns WP text for a parameter
 D GETWP^XPAR(.RET,ENT,PAR,INST,.ERR)
 Q:$G(ERR,0)
 S TMP="RET"
 F  S TMP=$Q(@TMP) Q:TMP=""  D
 .S @RESULTS@($O(@RESULTS@(""),-1)+1)=@TMP
 S @RESULTS@(0)=$O(@RESULTS@(""),-1)_U_INST
 Q
 ;
LAST5(RESULTS,PTID) ; [Procedure] Get patients using last 5
 N I,IEN,XREF
 S (I,IEN)=0,XREF=$S($L(PTID)=5:"BS5",1:"BS")
 F  S IEN=$O(^DPT(XREF,PTID,IEN)) Q:'IEN  D
 .S I=I+1,RESULTS(I)=IEN_U_$P(^DPT(IEN,0),U)_U_$$DOB^DPTLK1(IEN,2)_U_$$SSN^DPTLK1(IEN)  ; DG249
 Q
 ;
LISTALL(RESULTS,FROM,DIR) ; [Procedure] Pt List
 N I,IEN,CNT S CNT=44,I=0
 F  S FROM=$O(^DPT("B",FROM),DIR) Q:FROM=""  D  Q:I=CNT
 .S IEN=0 F  S IEN=$O(^DPT("B",FROM,IEN)) Q:'IEN  D  Q:I=CNT
 ..S I=I+1 S RESULTS(I)=IEN_"^"_FROM
 Q
 ;
LOGSEC ; [Procedure] Logs secure and restricted record access
 D NOTICE^DGSEC4(.ANRVRET,DFN,DATA,1)
 S @RESULTS@(0)=$S(ANRVRET:"1^Logged",1:"-1^Unable to log")
 Q
 ;
PINF(RESULTS,PTDFN) ; [Procedure] Patient Information for verification
 N Y,GX,GE,NC,Z,X,I
 D GETS^DIQ(2,+PTDFN,".03;391;1901;.01;.02;.09;.301;.14;","","GX","GE")
 I $D(GE("DIERR",1)) S RESULTS="0^"_GE("DIERR",1,"TEXT",1)  Q
 S NC=+PTDFN_",",Z="1^"
 F I=.03,391,1901,.01,.02,.09,.301,.14 D
 .S X=GX(2,NC,I) S Z=Z_X_"^"
 S RESULTS=Z
 Q
 ;
RPC(RESULTS,OPTION,DFN,DATA) ; [Procedure] Main RPC Call Tag
 S RESULTS=$NA(^TMP($J)) K @RESULTS
 D:$T(@OPTION)]"" @OPTION
 D:'$D(@RESULTS)
 .S @RESULTS@(0)="-1^No results returned"
 D CLEAN^DILF
 Q
 ;
RPCA(RESULTS,OPTION,ENT,PAR,INST,VAL) ; [Procedure] Main RPC entry
 N ERR,TMP,RET,TXT,IEN,IENS,ROOT
 S INST=$G(INST,1)
 S PAR=$G(PAR,"ANRV")
 S RESULTS=$NA(^TMP($J)) K @RESULTS
 I PAR'?1"ANRV".E S ^TMP($J,0)="-1^Non VIST Outcomes Parameter" Q
 D:$T(@OPTION)]"" @OPTION
 I +$G(ERR) K @RESULTS S @RESULTS@(0)="-1^Error: "_(+ERR)_" "_$P(ERR,U,2)
 I '$D(^TMP($J)) S @RESULTS@(0)="-1^No data returned"
 D CLEAN^DILF
 Q
 ;
SELECT ; [Procedure] Select Patient
 NEW IENS,ANRVDFN,ANRVFLD,ANRVID,ANRVRET,ANRVX
 I '$D(^DPT(+$G(DFN),0))#2 S @RESULTS@(0)="-1^No such patient" Q
 S @RESULTS@(0)="1^Required Identifiers & messages"
 S IENS=DFN_","
 D FILE^DID(2,,"REQUIRED IDENTIFIERS","ANRVIDS")
 F ANRVX=0:0 S ANRVX=$O(ANRVIDS("REQUIRED IDENTIFIERS",ANRVX)) Q:'ANRVX  D
 .S ANRVFLD=ANRVIDS("REQUIRED IDENTIFIERS",ANRVX,"FIELD")
 .S ANRVID="$$PTID^"_$$GET1^DID(2,ANRVFLD,"","LABEL")
 .S ANRVID=ANRVID_U_$$GET1^DIQ(2,IENS,ANRVFLD)
 .D:ANRVFLD=.03
 ..S ANRVID=ANRVID_" ("_$$GET1^DIQ(2,IENS,.033)_")"
 ..S ANRVID=ANRVID_U_$$DOB^DPTLK1(+IENS)
 .D:ANRVFLD=.09
 ..S X=$P(ANRVID,U,3),X=$E(X,1,3)_"-"_$E(X,4,5)_"-"_$E(X,6,10)
 ..S $P(ANRVID,U,3)=X,$P(ANRVID,U,4)=$$SSN^DPTLK1(+IENS)
 .S @RESULTS@($O(@RESULTS@(""),-1)+1)=ANRVID
 K ANRVRET
 D GUIBS5A^DPTLK6(.ANRVRET,DFN) D:ANRVRET(1)=1
 .D ADD("$$MSGHDR^2^SAME LAST NAME AND LAST 4")
 .S ANRVX=1
 .F  S ANRVX=$O(ANRVRET(ANRVX)) Q:'ANRVX!(+$G(ANRVRET(ANRVX)))  D
 ..D ADD($P(ANRVRET(ANRVX),U,2))
 .D ADD(" ")
 .S ANRVX=1
 .F  S ANRVX=$O(ANRVRET(ANRVX)) Q:'ANRVX  D:+ANRVRET(ANRVX)
 ..S ANRVDFN=+$P(ANRVRET(ANRVX),U,2)
 ..D ADD($$GET1^DIQ(2,ANRVDFN_",",.01)_"    "_$$DOB^DPTLK1(ANRVDFN)_"    "_$$SSN^DPTLK1(ANRVDFN))
 .D ADD(" ")
 .D ADD("Please review carefully before continuing")
 .D ADD("$$MSGEND")
 K ANRVRET
 D PTSEC^DGSEC4(.ANRVRET,DFN) D:ANRVRET(1)'=0
 .D:ANRVRET(1)=3
 ..D ADD("$$MSGHDR^0^CAN'T ACCESS YOUR OWN RECORD!!")
 .D:ANRVRET(1)=-1
 ..D ADD("$$MSGHDR^0^INCOMPLETE INFORMATION - CAN'T PROCEED")
 .D:ANRVRET(1)=1
 ..D ADD("$$MSGHDR^1^SENSITIVE RECORD ACCESS")
 .D:ANRVRET(1)'=-1&(ANRVRET(1)'=3)&(ANRVRET(1)'=1)
 ..D ADD("$$MSGHDR^3^SENSITIVE RECORD ACCESS")
 .S ANRVX=1
 .F  S ANRVX=$O(ANRVRET(ANRVX)) Q:'ANRVX  D ADD($TR(ANRVRET(ANRVX),"*"," "))
 .D ADD("$$MSGEND")
 D GUIMTD^DPTLK6(.ANRVRET,DFN) D:ANRVRET(1)=1
 .D ADD("$$MSGHDR^1^NOTICE")
 .F ANRVX=1:0 S ANRVX=$O(ANRVRET(ANRVX)) Q:'ANRVX  D ADD(ANRVRET(ANRVX))
 .D ADD("$$MSGEND")
 Q
 ;
SETLST ; [Procedure] Set single value into a parameter
 N ANRVINS ; Instance Counter
 D DELLST(ENT,PAR)
 S ANRVINS=""
 F  S ANRVINS=$O(VAL(ANRVINS)) Q:ANRVINS=""  D
 .D EN^XPAR(ENT,PAR,ANRVINS,VAL(ANRVINS),.ERR)
 S:'$G(ERR) @RESULTS@(0)="1^List "_PAR_" rebuilt"
 Q
 ;
SETPAR ; [Procedure] Set single value into a parameter   
 D EN^XPAR(ENT,PAR,INST,VAL,.ERR)
 S:'$G(ERR) @RESULTS@(0)="1^Parameter updated"
 Q
 ;
SETWP ; [Procedure] Set WP text into a parameter
 S TXT=INST,TMP=""
 F  S TMP=$O(VAL(TMP)) Q:TMP=""  D
 .S TXT($O(TXT(""),-1)+1,0)=VAL(TMP)
 D EN^XPAR(ENT,PAR,INST,.TXT,.ERR)
 S:'$G(ERR) @RESULTS@(0)="1^WP Text Saved"
 Q
 ;
SIGNON ; [Procedure] Return signon information for user.
 S @RESULTS@(0)=DUZ
 S @RESULTS@(1)=$$GET1^DIQ(200,DUZ_",",.01) ; Name
 S @RESULTS@(2)=+$$FIND1^DIC(4.2,"","QX",$$KSP^XUPARAM("WHERE")) ;Domain
 S @RESULTS@(3)=$$KSP^XUPARAM("WHERE") ; Domain Name
 S @RESULTS@(4)=+$G(DUZ(2)) ; Division IEN
 S @RESULTS@(5)=$S(+$G(DUZ(2)):$$GET1^DIQ(4,DUZ(2)_",",.01),1:"UNKNOWN")
 S @RESULTS@(6)=$$GET1^DIQ(200,DUZ_",",8)
 S @RESULTS@(7)=""
 S @RESULTS@(8)=$G(DTIME,300)
 Q
 ;
