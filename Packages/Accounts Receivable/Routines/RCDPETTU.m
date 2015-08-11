RCDPETTU ; ePayments/CNF, hrubovcak - EDI Testing Tool Utilities ;Jun 06, 2014@19:11:19
 ;;4.5;Accounts Receivable;**298**; 20 Dec 2013;Build 121
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
ARRAY(RCMSG,RCARRAY) ; Retrieve message object text, put in array
 ;
 ;Input:
 ;  RCMSG - IEN
 ;Output:
 ;  RCARRAY - Array of data
 ;
 N RCDATA,RCX
 D GETS^DIQ(344.81,RCMSG,"**","","RCDATA")
 S RCX=$O(RCDATA(344.81,""))
 M RCARRAY=RCDATA(344.81,RCX,2)
 Q
 ;
COPY(RCTYPE) ; Copy message
 ;Input RCTYPE - ERA, EFT, MRA
 ;
 N DIR,J,RCEEOB,RCEXP,RCMSG,RCOB,RCIEN,X,Y
 S RCIEN=$$SELECT^RCDPETTU(RCTYPE) Q:'(RCIEN>0)
 D ARRAY^RCDPETTU(+RCIEN,.RCEEOB)
 I '$D(RCEEOB) W !,"No lines to copy. Exiting.",! Q
 ;
 ; set to auto-import
 S RCOB("AUTOIMP")=1,RCOB("IEN")=0
 ; user response cannot contain '^'
 S DIR(0)="FOA",DIR("A")=$S(RCTYPE="EFT":"EFT Detail Line",1:"EEOB")_" Description: "
 D ^DIR I Y="" W !,"Description is required. Exiting.",! Q
 S RCOB("XMZ")=0  ; no MM message number
 ;
 S RCOB("XMZ",0)=Y  ; instead of the MM message zero node
 ; create text for a single object
 F J=1:1 Q:'$D(RCEEOB(J))  S RCEXP(1,J)=RCEEOB(J)
 S RCEXP("TYPE")=RCTYPE,RCEXP=1
 D NWOBJ^RCDPETTU(.RCOB,.RCEXP)
 ;
 I '$G(RCOB("IEN")) W !,"* Entry not created! *" Q
 S J=$O(RCOB("IEN",0)) W:J !!,"Created #"_J_" "_$P(^RCY(344.81,J,0),U),!
 ;
 Q
 ;
DEL(RCTYPE) ; delete object
 ;Input RCTYPE - ERA, EFT, MRA
 ;
 N DA,DIR,DIK,RCFLNO,RCIEN,X,Y
 S RCIEN("Y")=$$SELECT^RCDPETTU(RCTYPE),RCIEN=+RCIEN("Y")
 I '(RCIEN>0) W !,"Nothing selected, exiting",! Q
 S RCFLNO=344.81,RCIEN("USER")=$$GET1^DIQ(RCFLNO,RCIEN,.02),RCIEN("WHEN")=$$GET1^DIQ(RCFLNO,RCIEN,.02)
 W !!,"Entry #"_RCIEN_" Name: "_$P(RCIEN("Y"),U,2)
 W !,"Created by: "_RCIEN("USER")_" at "_RCIEN("WHEN"),!
 S DIR(0)="YA",DIR("A")="Delete this entry? ",DIR("B")="NO"
 D ^DIR I 'Y W !,"Nothing deleted." Q
 S DA=RCIEN,DIK="^RCY(344.81," D ^DIK
 W !,"Deleted entry #"_RCIEN
 ;
 Q
 ;
DONOTUSE ;Do Not Use Banner
 ;
 W !!
 W !,"****************************************************************"
 W !,"** Do not use this functionality in a production environment. **"
 W !,"****************************************************************"
 Q
 ;
EDITOBJ(RCNTRY) ; edit entry, RCNTRY - ien in file 344.81
 Q:'($G(RCNTRY)>0)  ; required
 Q:'$D(^RCY(344.81,RCNTRY,0))  ; entry must exist
 ; RCFLDNO - field number
 ; RCIENS - for FileMan calls
 ; RCFLNUM - file number (344.81)
 ; RCTYP - object type
 N RCFLDNO,RCFLNUM,RCIENS,RCTYP
 S RCIENS=RCNTRY_",",RCFLNUM=344.81
 ; exclusive access
 L +^RCY(RCFLNUM,RCNTRY):DILOCKTM E  W !,$C(7)_"Another user is editing this entry." Q
 S RCTYP=$P(^RCY(RCFLNUM,RCNTRY,1),U)  ; no $GET, the 1 node should always exist
 ; use DIR for DD type call
 F RCFLDNO=.01,.05 D
 .N D0,DA,DR,DIC,DIE,DIR,RCDDTXT,RCOLD,RCDIERR,RCRSLT,RCVAL,X,Y
 .; get original value in the field
 .S RCOLD=$$GET1^DIQ(RCFLNUM,RCIENS,RCFLDNO,"","","RCDIERR")
 .D FIELD^DID(RCFLNUM,RCFLDNO,"","LABEL;","RCDDTXT","RCDIERR")  ; field label from DD
 .; user prompt in ^DIR based on object type
 .S DIR(0)=RCFLNUM_","_RCFLDNO_"A",DA=RCNTRY,DIR("A")=$S(RCTYP="EFT":"EFT Detail Line",1:"EEOB")_" "_RCDDTXT("LABEL")_": "
 .I RCFLDNO=.05 S DIR("A")="Name of "_$S(RCTYP="EFT":"EFT Detail Line Grouping: ",1:"EEOB Grouping: ")
 .D ^DIR
 .; prevent embedded '^' in name, deletion not allowed
 .I Y[U!(Y="@") W !,$C(34)_Y_$C(34,7)_" not allowed." S Y=""
 .Q:Y=""  S RCVAL=$$UP(Y)
 .Q:RCVAL=RCOLD  ; don't update if unchanged
 .; validate user response in case ^DIR doesn't catch something
 .D VAL^DIE(RCFLNUM,RCIENS,RCFLDNO,"",RCVAL,.RCRSLT,"","RCDIERR")
 .I RCRSLT=U W !,$C(7)_"Invalid response." Q
 .S DR=RCFLDNO_"///"_RCRSLT,DIE=RCFLNUM,DA=RCNTRY D ^DIE
 ;
 D LOG("File "_RCFLNUM_" entry "_RCNTRY_" updated")
 ; unlock before exit
 L -^RCY(RCFLNUM,RCNTRY)
 Q
 ;
HFSFL ; read HFS file into global, send as MailMan message
 ;
 D DT^DICRW,HOME^%ZIS  ; kernel variables
 N C,DELIM,DIR,FLPATH,FLNM,FLSPEC,J,L,RCBODY,RCSUBJ,RCTO,RCXMZR,X,Y
 ; FLNM - HFS file name
 ; FLSPEC - complete file specification w. path
 ; RCBODY - root of message body
 ; RCSUBJ - message subject
 ; RCTO - recipients
 ; RCXMZR - message number returned
 K ^TMP($J),^TMP("XMERR",$J)
 W !,$J($$NOW,30),!,"Send Host File System file as MailMan message.",!
 ; ask for file specifications.
 S DIR(0)="F^3:245",DIR("A")="File Name",DIR("?")="Enter an HFS file name."
 W ! D ^DIR
 ; no answer, etc.
 I $D(DTOUT)!$D(DUOUT)!(Y="") Q
 ;if no file, then quit
 Q:Y=""  S FLSPEC=Y
 ; "\" for Windows, "]" for OpenVMS
 S DELIM=$S(FLSPEC["\":"\",FLSPEC["]":"]",1:"")  ; file name delimiter
 D:DELIM]""  ; parse file spec
 .S L=$L(FLSPEC,DELIM),FLNM=$P(FLSPEC,DELIM,L),FLPATH=$P(FLSPEC,DELIM,1,L-1)
 .S:FLPATH]"" FLPATH=FLPATH_DELIM
 ;
 ; get default directory if no path specified
 S:FLPATH="" FLPATH=$$DEFDIR^%ZISH
 ;
 ; start with line 1 in global specification
 S FLSPEC("POP")=$$FTG^%ZISH(FLPATH,FLNM,$NA(^TMP($J,"RCMSG",1,0)),3)
 I 'FLSPEC("POP") W !!,"Problem opening "_FLSPEC,!,"No action taken."_$C(7),!
 ;
 ;
 ; put file text into FileMan W-P format
 S (J,C)=0 F  S J=$O(^TMP($J,"RCMSG",J)) Q:'J  S X=$G(^(J,0)) D:X]""
 .S C=C+1,^TMP($J,"TXT",C,0)=X
 .I $L(X)>245 W !,"longer than 245"
 ;
 W !!," "_C_" line"_$E("s",'(C=1))_" found",!
 I 'C W !,"No text to send, exiting." Q
 ; send via MailMan
 S RCSUBJ="HFS Message "_$$FMTE^XLFDT($$NOW^XLFDT)
 S RCTO(DUZ)=""
 ;
 D SENDMSG^XMXAPI(DUZ,RCSUBJ,$NA(^TMP($J,"TXT")),.RCTO,,.RCXMZR)
 ;
 ;
 I $D(^TMP("XMERR",$J)) D  ; error from MailMan
 .W !,$$NOW,!," MailMan returned an error; check the ^XTMP('RCDPTOOL') log."
 .D LOGARY($NA(^TMP("XMERR",$J)))
 ;
 ;check for success
 I $G(RCXMZR) S X="MailMan Message #"_RCXMZR_" sent" W !,X_" to you.",!,"Subj: "_RCSUBJ,! D LOG(X)
 ;
 Q
 ;
LGZROND ; update zero node for XTMP(log), 3 months (91 days)
 N EXP S EXP=$$HTFM^XLFDT($H+91,1)
 S ^XTMP("RCDPTOOL",0)=EXP_"^"_$$NOW^XLFDT_"^ePayments Testing Tool"
 Q
 ;
LOG(TXT) ; log, save TXT in ^XTMP
 ;
 Q:'$L($G(TXT))
 N H,T S H=$H,T=$$HTFM^XLFDT(H)
 ; ^XTMP("RCDPTOOL","LOG", inverse $horolog, job# , now in FM format) = log text
 S ^XTMP("RCDPTOOL","LOG",-H,$J,T)=TXT
 D LGZROND
 Q
 ;
LOGARY(TXTARY) ; log array in ^XTMP, TXTARY is name of storage location
 Q:'$D(@TXTARY)
 N C,H,LOG,T,V S H=$H,T=$$HTFM^XLFDT(H)
 S C=0,V=TXTARY,LOG=$NA(^XTMP("RCDPTOOL","LOG",-H,$J,T))
 ; ^XTMP("RCDPTOOL","LOG", inverse $horolog, job# , now in FM format, line count) = log text
 F  S V=$Q(@V) Q:V=""  S C=C+1,@LOG@(C,"NM")=V,@LOG@(C,"VAL")=@V
 D LGZROND
 ;
 Q
 ;
LZ(A,L) ;function, pad with leading zeros
 ;A - value to pad
 ;L - total field length
 ;Y - return value
 ;
 N NEG,ZERO,Y
 S NEG=0 S:A<0 NEG=1,A=-A  ;Negative indicator
 I A["." S A=$P(A,".",1)_$P(A,".",2)  ;Remove decimal 
 S $P(ZERO,"0",21)=""  ;Create string of 20 zeros
 S Y=$E(ZERO,1,(L-$L(A)))_A
 I NEG S Y="-"_$E(Y,2,99)  ;remove a zero and add negative sign
 Q Y
 ;
NOW() Q $$HTE^XLFDT($H,"S")  ; extrinsic variable, NOW in external format
 ;
NTRY(T) ; log user entry into an Option
 Q:'$L($G(T))
 D LOG(T_" "_$$GET1^DIQ(200,DUZ_",",.01)_" "_$$NOW) Q
 ;
NWOBJ(RCOB,RCEXP) ; create new object for each EEOB
 ; RCOB - array for new object, required, passed by ref.
 ; RCEXP - parsed EOB text, required, passed by ref.
 ; RCUSRIN - the user's initials from the NEW PERSON file
 S RCOB("IEN")=0  ; count of new entries, new entry IENs stored on RCOB("IEN",new IEN 1), etc.
 N C,J,RCDIERR,RCIENRT,RCIENS,RCINTXT,RCNEW,RCNTR,RCUSRIN,RCWP
 S RCUSRIN=$$STRLSP($$GET1^DIQ(200,DUZ,1))  ; ^DD(200,1,0) = INITIAL
 S C=$$STRLSP($G(RCOB("AUTOTXT")))  ; user may have entered default text
 S RCINTXT=$S($L(C):C,1:$$STRLSP($P(RCOB("XMZ",0),U)))  ; name suffix from MailMan subject for new entry
 ; add user's initials if they're not already there
 I $L(RCUSRIN) I RCUSRIN'=$E(RCINTXT,1,$L(RCUSRIN)) S RCINTXT=RCUSRIN_" "_RCINTXT
 ;
 S RCNTR=0 F  S RCNTR=$O(RCEXP(RCNTR)) Q:'RCNTR  D  ; put EEOB items into file
 .K RCDIERR,RCIENS,RCIENRT,RCWP  ; delete residue
 .; create new entry
 .S RCIENS(344.81,"+1,",.01)=$$UP($E(RCINTXT_" "_RCNTR,1,30))  ; 30 uppercase chars.
 .S RCIENS(344.81,"+1,",.02)=DUZ
 .S RCIENS(344.81,"+1,",.03)=$$NOW^XLFDT
 .S RCIENS(344.81,"+1,",1.01)=RCEXP("TYPE")  ; 3 upper case characters only
 .S RCIENS(344.81,"+1,",1.02)=+$G(RCOB("AUTOIMP"))  ; zero or one for each new object
 .D UPDATE^DIE("","RCIENS","RCIENRT","RCDIERR")
 .D:$D(RCDIERR) LOGARY("RCDIERR")
 .S RCNEW=+$G(RCIENRT(1))  ; new IEN
 .Q:'RCNEW  ; entry not created
 .S RCOB("IEN")=RCOB("IEN")+1,RCOB("IEN",RCNEW)=""
 .S (J,C)=0 F  S J=$O(RCEXP(RCNTR,J)) Q:'J  S C=C+1,RCWP(C,0)=RCEXP(RCNTR,J)  ; w-p format
 .I '$O(RCWP(0)) S RCWP(1,0)="* error: no EEOB found *" ; no w-p text available
 .; add w-p text to new entry
 .K RCDIERR D WP^DIE(344.81,RCNEW_",",2,"","RCWP","RCDIERR")
 .I $D(RCDIERR) D LOGARY("RCDIERR") K RCDIERR
 ;
 Q
 ;
PRSEOB(RSLT,RCTXT) ; parse EEOB text
 ; RSLT - results of parsing, passed by ref.
 ; RCTXT - message text location, FileMan w-p format
 ; on error, RSLT=-1
 K RSLT S RSLT=0
 N BLNUM,BLTXT,ERR,LN,MTYP,Q,R,X,Y
 S Q=$C(34)  ; quote for result text
 ; verify header
 S Y=$G(@RCTXT@(1,0)) S:'($E(Y,1,9)="RACUBOTH ") RSLT=-1,RSLT(-1)="Invalid Message Header"
 Q:RSLT<0
 S Y=$G(@RCTXT@(2,0)),X=$P(Y,U) S:'($E(X,1,3)="835") RSLT=-1,RSLT(-1)="Not 835 Message"
 Q:RSLT<0
 S MTYP=$E(X,4,$L(X)) S:'("^ERA^EOB^EFT^"[(U_MTYP_U)) RSLT=-1,RSLT(-1)="Message Type "_Q_X_Q_" Unknown"
 Q:RSLT<0
 ;
 S ERR=0  ; error flag
 F LN=3:1 Q:ERR!'$D(@RCTXT@(LN,0))  S Y=$G(@RCTXT@(LN,0)) D
 .Q:Y="NNNN"!(Y="99^$")  ; ignore terminators
 .I Y="" S ERR=1,ERR("M")="Null record, line "_LN Q
 .S R=$P(Y,U) I '(R?2N) S ERR=1,ERR("M")="Invalid Record Type "_Q_R_Q_" line "_LN Q
 .I MTYP="ERA" Q:R<5  ; ignore records 01 to 04 in an ERA
 .S BLNUM=$P(Y,U,2)  ; bill number
 .I BLNUM="" S ERR=1,ERR("M")="Bill Number missing in line "_LN Q
 .S BLTXT(BLNUM,LN)=Y  ; save text by bill number
 ;
 I ERR S RSLT=-1,RSLT(-1)=ERR("M") Q  ; parsing error
 ;
 I $O(BLTXT(""))="" S RSLT=-1,RSLT(-1)="No bills found" Q
 ; no errors, assemble results array
 S BLNUM="" F  S BLNUM=$O(BLTXT(BLNUM)) Q:BLNUM=""  D
 .S RSLT=RSLT+1 N J,C S (J,C)=0
 .F  S J=$O(BLTXT(BLNUM,J)) Q:'J  S C=C+1,RSLT(RSLT,C)=BLTXT(BLNUM,J)
 ;
 ; done, add message type to result
 S RSLT("TYPE")=MTYP
 ;
 Q
 ;
SELECT(RCEOBTYP) ; function, select EEOB of type RCEOBTYP
 ; returns Y from FileMan, Y = "ien ^ .01 field"
 ;
 Q:$G(RCEOBTYP)="" ""  ; type is required
 Q:'("^ERA^EFT^MRA^"[(U_RCEOBTYP_U)) ""  ; only these allowed
 N D0,DA,DIC,X,Y
 D NTRY("Selection of "_RCEOBTYP_" type object")
 S DIC=344.81,DIC(0)="AEQ",DIC("A")="Select "_$S(RCEOBTYP="EFT":"EFT Detail Line: ",1:"EEOB Object: ")
 ; EOB TYPE must match, OBJECT STATUS must be non-zero, and there has to be W-P text
 S DIC("S")="N RC S RC=$G(^RCY(344.81,+Y,1)) I $P(RC,U,2),$P(RC,U)=RCEOBTYP,+$O(^RCY(344.81,+Y,2,0))"
 D ^DIC
 Q Y  ; could be -1 on lookup failure
 ;
SELECT1(RCEOBTYP) ; function, select EEOB description of type RCEOBTYP
 ; returns Y from FileMan, Y = "ien ^ .01 field"
 ;
 Q:$G(RCEOBTYP)="" ""  ; type is required
 Q:'("^ERA^EFT^MRA^"[(U_RCEOBTYP_U)) ""  ; only these allowed
 N D,D0,DA,DIC,X,Y
 D NTRY("Selection of "_RCEOBTYP_" type object")
 S DIC="^RCY(344.81,",DIC(0)="AEQ",DIC("B")="",D="C"
 S DIC("A")="Select Name of "_$S(RCEOBTYP="EFT":"EFT Detail Line Grouping: ",1:"EEOB Grouping: ")
 D IX^DIC
 Q Y  ; could be -1 on lookup failure
 ;
STRLSP(A) ; function, strip leading spaces
 Q:$E($G(A))'=" " A  ; nothing to strip
 F  Q:'($E(A)=" ")  S A=$E(A,2,$L(A))
 Q A
 ;
UP(A) Q $TR(A,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;
Y4MD() Q 17000000+$$DT^XLFDT  ; today as YYYYMMDD
 ;
