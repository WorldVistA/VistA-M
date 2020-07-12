ORNORC ; SLC/AJB - New Order Checks for Cancelled Orders ;Oct 15, 2018@05:49
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**377**;Dec 17, 1997;Build 582
 Q
CANCEL(CHECKS,DFN,PACKAGE,LOC,DATA,STRT) ; capture a cancelled order
 N ORDATA,ORIEN,ORITEMS,ORMSG
 S ORDATA(100.3,"+1,",.01)=$$NOW^XLFDT
 S ORDATA(100.3,"+1,",.02)=DFN
 S ORDATA(100.3,"+1,",.03)=DUZ
 S ORDATA(100.3,"+1,",.04)=+LOC
 S ORDATA(100.3,"+1,",.05)="C"
 S ORDATA(100.3,"+1,",.06)=PACKAGE
 S ORDATA(100.3,"+1,",.08)=STRT
 D UPDATE^DIE("","ORDATA","ORIEN","ORMSG") I +$D(ORMSG) Q
 ; get orderable item(s)
 N NUM S NUM=0 F  S NUM=$O(DATA(NUM)) Q:'+NUM  D
 . I NUM=1 S (ORITEMS,ORDATA(100.31,"+1,"_ORIEN(1)_",",.01))=+DATA(NUM)
 . I $P(DATA(NUM),U,2)="ORDERABLE",ORITEMS'[$P(DATA(NUM),U,4) D
 . . S ORDATA(100.31,"+1,"_ORIEN(1)_",",.01)=$P(DATA(NUM),U,4)
 . . S ORITEMS=$S(ORITEMS="":$P(DATA(NUM),U,4),1:ORITEMS_U_$P(DATA(NUM),U,4))
 . I +$D(ORDATA) D UPDATE^DIE("","ORDATA",,"ORMSG") I +$D(ORMSG) Q
 ; get order checks
 S NUM=0 F  S NUM=$O(CHECKS(NUM)) Q:'+NUM  D
 . N DATA,IEN,ORXTRA
 . S ORDATA(100.32,"+1,"_ORIEN(1)_",",.01)=$P(CHECKS(NUM),U,2)
 . S ORDATA(100.32,"+1,"_ORIEN(1)_",",.02)=$P(CHECKS(NUM),U,3)
 . S ORDATA(100.32,"+1,"_ORIEN(1)_",",1)=$P(CHECKS(NUM),U,4)
 . I ORDATA(100.32,"+1,"_ORIEN(1)_",",1)["||" D  ; check for extra data
 . . S ORXTRA=$P($P(ORDATA(100.32,"+1,"_ORIEN(1)_",",1),"||",2),"&")
 . . S ORDATA(100.32,"+1,"_ORIEN(1)_",",1)=$P(ORDATA(100.32,"+1,"_ORIEN(1)_",",1),"&",2)
 . . D GETXTRA^ORCHECK(.DATA,ORXTRA,ORDATA(100.32,"+1,"_ORIEN(1)_",",1))
 . D UPDATE^DIE("","ORDATA","IEN","ORMSG") I +$D(ORMSG) Q
 . I +$D(DATA) D WP^DIE(100.32,IEN(1)_","_ORIEN(1)_",",2,,"DATA","ORMSG") I +$D(ORMSG) Q
 ; set raw order data
 D WP^DIE(100.3,ORIEN(1)_",",3,,"DATA","ORMSG") I +$D(ORMSG) Q
 ; set xtmp to find entries to be removed (#100.03) if order is initially accepted
 S ^XTMP("ORCHECK-"_DUZ,0)=$$FMADD^XLFDT($$DT^XLFDT,1)_U_$$DT^XLFDT
 S ^XTMP("ORCHECK-"_DUZ,$J,DFN,$$DT^XLFDT,ORIEN(1))=ORITEMS
 Q
DELORC(ORVP,ORDIALOG) ; delete order checks from 100.3/avoid duplication in 100 & 100.05
 N LOC S LOC=$NA(ORDIALOG),ORVP=+ORVP
 I '+$D(^XTMP("ORCHECK-"_DUZ)) Q
 N JOB,ORCHECK,ORITEMS,ORDT,NUM
 S JOB=$J,ORDT=$$DT^XLFDT
 S ORCHECK="",ORCHECK=$O(^XTMP("ORCHECK-"_DUZ,JOB,ORVP,ORDT,ORCHECK),-1) ; get most recent IEN from 100.3 for the given user,job,patient,date
 I '+ORCHECK Q
 S NUM=0,ORITEMS="" F  S NUM=$O(@LOC@(4,NUM)) Q:'+NUM  D
 . S ORITEMS=$S(ORITEMS="":@LOC@(4,NUM),1:ORITEMS_U_@LOC@(4,NUM)) ; get all orderable items
 I ORITEMS=^XTMP("ORCHECK-"_DUZ,JOB,ORVP,ORDT,ORCHECK) D
 . N DA,DIK S DIK="^OR(100.3,",DA=ORCHECK D ^DIK ; remove entry from 100.3
 . K ^XTMP("ORCHECK-"_DUZ,JOB,ORVP) ; remove xtmp data
 Q
ORCAN(ORIEN,OCC) ; order has been cancelled/changed after acceptance
 N ORCHK
 D GETOC2^OROCAPI1(+ORIEN,.ORCHK) I '+$D(ORCHK) Q  ; quit if no order checks for the order
 N ORDATA,ORMSG
 S ORDATA(100.3,"+1,",.01)=$$NOW^XLFDT
 S ORDATA(100.3,"+1,",.02)=$G(DFN)
 S ORDATA(100.3,"+1,",.03)=DUZ
 S ORDATA(100.3,"+1,",.05)=OCC
 S ORDATA(100.3,"+1,",.07)=+ORIEN
 D UPDATE^DIE("","ORDATA","ORIEN","ORMSG") I +$D(ORMSG) Q
 D  ; get orderable items
 . N DATA,IEN D GETS^DIQ(100,ORIEN,".1*","I","DATA")
 . S IEN="" F  S IEN=$O(DATA(100.001,IEN)) Q:'+IEN  D
 . . N ORDATA S ORDATA(100.31,"+1,"_ORIEN(1)_",",.01)=DATA(100.001,IEN,.01,"I")
 . . D UPDATE^DIE("","ORDATA","","ORMSG")
 S ORCHK=0 F  S ORCHK=$O(ORCHK(ORIEN,ORCHK)) Q:'+ORCHK  D
 . N DATA,IEN,ORDATA D GETS^DIQ(100.05,ORCHK_",","5;6;8","I","DATA")
 . S ORDATA(100.32,"+1,"_ORIEN(1)_",",.01)=DATA(100.05,ORCHK_",",5,"I")
 . S ORDATA(100.32,"+1,"_ORIEN(1)_",",.02)=DATA(100.05,ORCHK_",",6,"I")
 . S ORDATA(100.32,"+1,"_ORIEN(1)_",",1)=DATA(100.05,ORCHK_",",8,1)
 . D UPDATE^DIE("","ORDATA","","ORMSG")
 Q
EN ; main entry for creating a delimited report via HOST FILE or displaying CANCELLED ORDERS via ListManager
 W @IOF
 N CONT,LOC,POP,SRCH,X,Y
 S CONT=0,LOC=$NA(^TMP("ORCHK",$J)) K @LOC ; set global location of entries
 D SETUP(.SRCH) ; setup search parameters from user
 I '+CONT W !!,"Search parameter entry aborted.",! Q
 D FIND(.SRCH,LOC) ; find entries that match search criteria
 I +$D(SRCH("DLM")) D  Q
 . N %ZIS,DSC,IOP,POP,RTN,ZTSAVE,ZTSK
 . S ZTSAVE("JOB")="",ZTSAVE("SRCH")="",ZTSAVE("LOC")=""
 . S %ZIS="Q" ;,%ZIS("HFSNAME")=SRCH("DLM"),IOP="Q;HFS"
 . S DSC="Cancelled Order Report",RTN="REPORT^ORNORC(LOC)"
 . W ! D EN^XUTMDEVQ(RTN,DSC,.ZTSAVE,.%ZIS,1)
 . I +$G(ZTSK) W !!,"Task #",ZTSK
 ; start ListManager
 D EN^OROCLM(.SRCH,LOC)
 K @LOC
 Q
SETUP(SRCH) ; user required input for search parameters
 N DIR,POP,SRCHCRIT,X,Y
 S DIR(0)="S^LM:ListManager;DLM:Delmited Data Host File"
 S DIR("A")="LM/DLM",DIR("B")="LM"
 S DIR("L",1)="Select which type of data output: "
 S DIR("L",2)=""
 S DIR("L",3)="   LM     ListManager Display"
 S DIR("L")="   DLM    Delimited Data via Host File"
 W ! D ^DIR I Y'["LM" Q
 I Y="DLM" S SRCH("DLM")=1 ; D
 ;. S SRCH("DLM")=$$DEFDIR^%ZISH()_$$UP^XLFSTR($TR($$FMTE^XLFDT(DT,8)," ","_"))_"_ORDER_CHECK_REPORT.CSV"
 ;. W !!,"Your report will be located:",!!,$P(SRCH("DLM"),U),$P(SRCH("DLM"),U,2)
LM ;
 D  I '+$D(SRCH("ADATE"))!'+$D(SRCH("BDATE")) Q  ; get a date range from user
 . N %DT,DIR,X,Y S %DT(0)=-$$DT^XLFDT,%DT="AEX",%DT("A")="Select Beginning DATE: ",%DT("B")=$$FMTE^XLFDT($$FMADD^XLFDT(DT,-30))
 . W ! D ^%DT K %DT Q:Y<0  S SRCH("ADATE")=Y
 . S DIR("A")="          Ending DATE: ",DIR("B")="TODAY",DIR(0)="DA"_U_SRCH("ADATE")_":"_$$DT^XLFDT_":EX"
 . S DIR("?",1)="Enter a date between "_$$FMTE^XLFDT(SRCH("ADATE"))_" and "_$$FMTE^XLFDT($$DT^XLFDT)_".",DIR("?")=" "
 . W ! D ^DIR Q:Y'>0  S SRCH("BDATE")=Y
 ;
 S DIR(0)="YA",DIR("A")="Would you like to select additional SEARCH CRITERIA? ",DIR("B")="NO"
 W ! D ^DIR I '+Y S CONT=$S(+$G(DIRUT):0,+$G(DUOUT):0,1:1) Q
 ;
 S SRCHCRIT=$$SRCHCRIT(.SRCHCRIT,"A","OCCURRENCE","ORCHK SRCHPARAM 1 MAIN MENU","Enter search criteria: ") Q:SRCHCRIT=-1
 S CONT=1 F X=1:1:SRCHCRIT D
 . I SRCHCRIT(X)["LOCATION" D  I SRCH("LOCATION")=-1 S X=SRCHCRIT,CONT=0 Q
 . . W ! S SRCH("LOCATION")=$$FLU(44)
 . I SRCHCRIT(X)["OCCURRENCE" D  I '+$D(SRCH("OCCURRENCE")) S SRCH("OCCURRENCE")=-1,X=SRCHCRIT,CONT=0 Q
 . . N SRCHCRIT,X S SRCHCRIT=$$SRCHCRIT(.SRCHCRIT,"A","CANCELLED","ORCHK SRCHPARAM 2 OCCURRENCE MENU","Enter OCCURRENCE(S): ") Q:SRCHCRIT=-1
 . . S SRCH("OCCURRENCE")="" F X=1:1:SRCHCRIT D
 . . . S SRCH("OCCURRENCE")=SRCH("OCCURRENCE")_$S($P(SRCHCRIT(X),U,3)="CANCELLED":"C",$P(SRCHCRIT(X),U,3)="ACCEPTED/CANCELLED":"AC",1:"RT")_$S(SRCHCRIT=X:"",1:U)
 . I SRCHCRIT(X)["PATIENT" D  I SRCH("PATIENT")=-1 S X=SRCHCRIT,CONT=0 Q
 . . W ! S SRCH("PATIENT")=$$FLU(2)
 . I SRCHCRIT(X)["USER" D  I SRCH("USER")=-1 S X=SRCHCRIT,CONT=0 Q
 . . W ! S SRCH("USER")=$$FLU(200)
 . I SRCHCRIT(X)["ORDERABLE ITEM" D  I SRCH("ORDITEM")=-1 S X=SRCHCRIT,CONT=0 Q
 . . W ! S SRCH("ORDITEM")=$$FLU(101.43)
 . I SRCHCRIT(X)["ORDER CHECK" D  I SRCH("ORDCHECK")=-1 S X=SRCHCRIT,CONT=0 Q
 . . W ! S SRCH("ORDCHECK")=$$FLU(100.8)
 . I SRCHCRIT(X)["CLINICAL DANGER LEVEL" D  I '+$D(SRCH("CDL")) S SRCH("CDL")=-1,X=SRCHCRIT,CONT=0 Q
 . . N SRCHCRIT,X S SRCHCRIT=$$SRCHCRIT(.SRCHCRIT,"A","HIGH","ORCHK SRCHPARAM 3 DANGER MENU","Enter CLINICAL DANGER LEVEL: ") I SRCHCRIT=-1 S CONT=0 Q
 . . S SRCH("CDL")="" F X=1:1:SRCHCRIT D
 . . . S SRCH("CDL")=SRCH("CDL")_$S($P(SRCHCRIT(X),U,3)="HIGH":"1",$P(SRCHCRIT(X),U,3)="MEDIUM":"2",1:"3")_$S(SRCHCRIT=X:"",1:U)
 Q
FIND(SRCH,LOC) ;
 N BDT,GBL,IEN S IEN=0,GBL=$NA(^OR(100.3))
 F BDT=SRCH("ADATE"):1:SRCH("BDATE") S IEN=0 F  S IEN=$O(@GBL@("B",BDT,IEN)) Q:'+IEN  D
 . N DATA,MATCH S MATCH=""
 . ; CANCELLED orders are only located in File #100.3
 . I $G(SRCH("OCCURRENCE"))'="C",+$D(@GBL@("ORDER",IEN)) D
 . . N OIEN S OIEN="",OIEN=$O(@GBL@("ORDER",IEN,OIEN)) Q:'+OIEN  D
 . . . N DATA1,ORCHK
 . . . D GETS^DIQ(100,OIEN_",",".02;3;6;.1*","IN","DATA1")
 . . . S DATA("PATIENT")=+DATA1(100,OIEN_",",.02,"I"),DATA("USER")=DATA1(100,OIEN_",",3,"I"),DATA("LOCATION")=+DATA1(100,OIEN_",",6,"I")
 . . . S (DATA1,DATA("ORDITEM"))="" F  S DATA1=$O(DATA1(100.001,DATA1)) Q:'+DATA1  D
 . . . . S DATA("ORDITEM")=DATA("ORDITEM")_DATA1(100.001,DATA1,.01,"I")_$S(+$O(DATA1(100.001,DATA1)):U,1:"")
 . . . D GETOC2^OROCAPI1(OIEN,.ORCHK)
 . . . S (DATA("ORDCHECK"),DATA("CDL"),ORCHK)="" F  S ORCHK=$O(ORCHK(OIEN,ORCHK)) Q:'+ORCHK  D
 . . . . D GETS^DIQ(100.05,ORCHK_",","5;6","IN","DATA1")
 . . . . S DATA("ORDCHECK")=DATA("ORDCHECK")_DATA1(100.05,ORCHK_",",5,"I")_$S(+$O(ORCHK(OIEN,ORCHK)):U,1:"")
 . . . . S DATA("CDL")=DATA("CDL")_DATA1(100.05,ORCHK_",",6,"I")_$S(+$O(ORCHK(OIEN,ORCHK)):U,1:"")
 . S SRCH="BDATE" F  S SRCH=$O(SRCH(SRCH)) Q:SRCH=""  D
 . . I SRCH="DLM" Q  ; not a search parameter
 . . S MATCH=MATCH_$$MATCH(SRCH,SRCH(SRCH),$G(DATA(SRCH)))_U
 . I +$L(MATCH,U)=1 S MATCH=1 ; if no failed search parameters, it's a match
 . I MATCH[0 Q
 . S @LOC@(IEN)=""
 Q
MATCH(INDEX,SRCHCRIT,DATA) ;
 I SRCHCRIT=DATA Q 1
 I +$D(@GBL@(INDEX,SRCH(INDEX),IEN)) Q 1
 N X,Y S Y=0
 I INDEX="CDL" F X=1:1:$L(SRCHCRIT,U) D
 . I +$D(@GBL@(INDEX,$P(SRCHCRIT,U,X),IEN)) S Y=1 Q
 . I DATA[$P(SRCHCRIT,U,X) S Y=1
 I INDEX="OCCURRENCE" F X=1:1:$L(SRCHCRIT,U) I +$D(@GBL@(INDEX,$P(SRCHCRIT,U,X),IEN)) S Y=1 Q
 I INDEX="ORDCHECK"!(INDEX="ORDITEM") F X=1:1:$L(DATA) D
 . I $P(DATA,U,X)=SRCHCRIT S Y=1 Q
 Q Y
FLU(FILE) ; file lookup
 N DIC,FINFO,X,Y
 D FILE^DID(FILE,,"NAME;GLOBAL NAME","FINFO")
 S DIC=FINFO("GLOBAL NAME"),DIC(0)="AEMQ",DIC("A")="Select "_FINFO("NAME")_": "
 D ^DIC
 Q +Y
SRCHCRIT(Y,PARAM,DEFAULT,MENU,PROMPT) ; get search criteria using menu & actions from the protocol file
 N I,X,XQORM
 S XQORM=+$O(^ORD(101,"B",MENU,0))_";ORD(101,"
 I '+XQORM Q "-1^Menu entry not found."
 S XQORM(0)=$G(PARAM),XQORM("A")=PROMPT,XQORM("B")=DEFAULT
 D EN^XQORM
 Q $G(Y)
REPORT(LOC) ; writes the data for the host file(s)
 N FCNT,FLDORD,IEN,IOM,SEQ S IOM=9999,SEQ=0 ; set sequence for fields
 N DELIM S DELIM="," ; set delimiter for report
 ;
 ; Call FILEDD(<file#>) and S FCNT(SEQ,X)=FCNT for each FILE to be in the host file
 ; FCNT is the total field count for each file for displaying FILE info above headers
 ;
 N X F X=100.3,100,100.05 S FCNT=0 D FILEDD(X) S FCNT(SEQ,X)=FCNT
 ;
 D HDR K FLDORD
 S IEN=0 F  S IEN=$O(@LOC@(IEN)) Q:'+IEN  D
 . N ORDER,ORCHK
 . D GODATA(100.3,IEN,1) ; main entry from File #100.3
 . S ORDER=+$$GET1^DIQ(100.3,IEN,.07) I +ORDER D  Q
 . . D GODATA(100,ORDER) ; main entry from File #100 (ORDER) - one ORDER per CANCELLED ORDER (#100.3)
 . . D GETOC2^OROCAPI1(ORDER,.ORCHK) ; get order checks for the ORDER
 . . N CNT S CNT=0,ORCHK="" F  S ORCHK=$O(ORCHK(ORDER,ORCHK)) Q:'+ORCHK  D
 . . . ; the main entry from File #100.05 (ORDER CHECK INSTANCES) - one or more per ORDER
 . . . S CNT=CNT+1 I CNT=1 D GODATA(100.05,ORCHK) W $C(182) Q
 . . . ; multi line results for an ORDER need "blank" entries for each file that precedes it
 . . . D GODATA(100.3,,1),GODATA(100),GODATA(100.05,ORCHK) W $C(182)
 . W $C(182)
 K @LOC
 Q
GODATA(FILE,IEN,STRT) ; get and output the file data
 N DATA,FLDORD
 N FN,FLD
 I +$G(FILE),+$G(IEN) S IEN=IEN_"," D GETS^DIQ(FILE,IEN,"**","N","DATA")
 W:+$G(STRT) ! W:'+$G(STRT) ","
 D FILEDD(FILE)
 S (SEQ,FN,FLD)=0 F  S SEQ=$O(FLDORD(SEQ)) Q:'+SEQ  F  S FN=$O(FLDORD(SEQ,FN)) Q:'+FN  F  S FLD=$O(FLDORD(SEQ,FN,FLD)) Q:'+FLD  D
 . N CNT,SIEN S (CNT,SIEN)=""
 . F  S SIEN=$O(DATA(FN,SIEN)) Q:'+SIEN  D
 . . I +$D(DATA(FN,SIEN,FLD)) D
 . . . S CNT=CNT+1
 . . . W:CNT=1 $C(34)
 . . . I $$GET1^DID(FN,FLD,,"TYPE")="WORD-PROCESSING" D
 . . . . N NUM S NUM=0 F  S NUM=$O(DATA(FN,SIEN,FLD,NUM)) Q:'+NUM  D
 . . . . . W $$QM(DATA(FN,SIEN,FLD,NUM)) W:+$O(DATA(FN,SIEN,FLD,NUM)) !
 . . . W:$$GET1^DID(FN,FLD,,"TYPE")'="WORD-PROCESSING" $$QM(DATA(FN,SIEN,FLD))
 . . . W:+$O(DATA(FN,SIEN)) !
 . I +CNT D  Q
 . . W $C(34)
 . . I +$O(FLDORD($S($$GET1^DID(FN,FLD,,"TYPE")="WORD-PROCESSING":(SEQ+1),1:SEQ))) W DELIM Q
 . I '+CNT D
 . . I +FLDORD(SEQ,FN,FLD),$$GET1^DID(FN,FLD,,"TYPE")="WORD-PROCESSING" D
 . . . W $$QM("")
 . . . I +$O(FLDORD((SEQ+1))) W DELIM Q
 . . I '+FLDORD(SEQ,FN,FLD),$$GET1^DID(FN,FLD,,"TYPE")'="WORD-PROCESSING" D
 . . . W $$QM("")
 . . . I +$O(FLDORD(SEQ)) W DELIM Q
 Q
FILEDD(FILENUM) ; establishes file/field sequence via the data dictionary ; IA #999
 ; FCNT,SEQ must be set prior to calling
 N NODE,PIECE,FLD S (NODE,PIECE,FLD)=""
 I +$D(^DD(FILENUM,"GL")) F  S NODE=$O(^DD(FILENUM,"GL",NODE)) Q:NODE=""  F  S PIECE=$O(^DD(FILENUM,"GL",NODE,PIECE)) Q:PIECE=""  F  S FLD=$O(^DD(FILENUM,"GL",NODE,PIECE,FLD)) Q:'+FLD  D
 . N NODE0 S NODE0=$G(^DD(FILENUM,FLD,0))
 . I +$P(NODE0,U,2) D  Q
 . . S SEQ=SEQ+1,FLDORD(SEQ,FILENUM,FLD)=+$P(NODE0,U,2)
 . . D FILEDD(+$P(NODE0,U,2))
 . S FCNT=FCNT+1,SEQ=SEQ+1,FLDORD(SEQ,FILENUM,FLD)=""
 Q
HDR ; write field names for the column headers
 N CNT,FILE,X
 S CNT=1,(FCNT,FILE)="" F  S FCNT=$O(FCNT(FCNT)) Q:'+FCNT  F  S FILE=$O(FCNT(FCNT,FILE)) Q:'+FILE  D
 . N NAME D FILE^DID(FILE,,"NAME","NAME")
 . S CNT=CNT+FCNT(FCNT,FILE)
 . S $P(X,DELIM,(CNT-FCNT(FCNT,FILE)))="File #"_FILE_" ["_NAME("NAME")_"]"
 W X,!
 ;
 N SEQ,FN,FLD
 S (SEQ,FN,FLD)=0 F  S SEQ=$O(FLDORD(SEQ)) Q:'+SEQ  F  S FN=$O(FLDORD(SEQ,FN)) Q:'+FN  F  S FLD=$O(FLDORD(SEQ,FN,FLD)) Q:'+FLD  D
 . I '+FLDORD(SEQ,FN,FLD) D  Q  ; not a multiple
 . . W $$QM($$GET1^DID(FN,FLD,,"LABEL"),1) I +$O(FLDORD(SEQ)) W DELIM ; field data & delim
 Q
QM(DATA,QM) ; for excel importing as csv, replace a single double quote with two double quotes
 I DATA[$C(34) N X S X("""")="""""" S DATA=$$REPLACE^XLFSTR(DATA,.X)
 Q $S(+$G(QM):$C(34)_DATA_$C(34),1:DATA)
