EDPQDB ;SLC/KCM - Display Active Log Entries ;2/28/12 08:33am
 ;;2.0;EMERGENCY DEPARTMENT;;May 2, 2012;Build 103
 ;
GET(AREA,BOARD,LAST) ; Get display board contents
 ;I $G(^EDPB(231.9,AREA,230))=TOKEN D XML^EDPX("<rows status='same' />") Q
 ;
 N EDPTIME S EDPTIME=$$NOW^XLFDT
 N SEQ,BED,LOG,BEDS,DWHEN,DUP,ACU,LSTUPD,RELOAD,ATT
 ;
 S LSTUPD=$P($G(^EDPB(231.9,AREA,0)),U,3),RELOAD="true",LAST=$G(LAST)
 I (LAST="")!(LAST=LSTUPD) S RELOAD="false"
 S ATT("status")="new"
 S ATT("reloadConfig")=RELOAD
 S ATT("configLastUpdated")=LSTUPD
 S ATT("version")=$$VERSRV^EDPQAR
 D XML^EDPX($$XMLA^EDPX("rows",.ATT,""))
 ;
 ; Get a list of all the beds in sequence for this area
 S BOARD=$G(BOARD)
 S BED=0 F  S BED=$O(^EDPB(231.8,"C",EDPSITE,AREA,BED)) Q:'BED  D
 . S SEQ=$P(^EDPB(231.8,BED,0),U,5) S:'SEQ SEQ=99999
 . Q:$P(^EDPB(231.8,BED,0),U,4)  ; inactive bed
 . S BEDS(SEQ,BED)="",BEDS("B",BED,SEQ)=""
 ;
 ; Insert the active log entries into the correct sequence for the beds 
 S BED=0 F  S BED=$O(^EDP(230,"AL",EDPSITE,AREA,BED)) Q:'BED  D
 . S LOG=0 F  S LOG=$O(^EDP(230,"AL",EDPSITE,AREA,BED,LOG)) Q:'LOG  D
 . . I '$D(BEDS("B",BED)) S BEDS(99999,BED)="",BEDS("B",BED,99999)=""
 . . S SEQ=$O(BEDS("B",BED,0))
 . . S ACU=$P($G(^EDP(230,LOG,3)),U,3) S:'ACU ACU=99
 . . S BEDS(SEQ,BED,ACU,LOG)=""
 ;
 ; Loop thru the sequence of beds to create display board rows
 D BLDDUP^EDPQLP(.DUP,AREA)
 S SEQ=0 F  S SEQ=$O(BEDS(SEQ)) Q:'SEQ  D
 . S BED=0 F  S BED=$O(BEDS(SEQ,BED)) Q:'BED  D
 . . I $L(BOARD),($P(^EDPB(231.8,BED,0),U,11)'=BOARD) Q
 . . S DWHEN=$P(^EDPB(231.8,BED,0),U,7)
 . . ; never display DWHEN=2
 . . Q:DWHEN=2
 . . ; always display DWHEN=1
 . . I ($D(BEDS(SEQ,BED))<10)&(DWHEN=1) D EMPTY(BED) Q
 . . ; display if occupied DWHEN=0
 . . S ACU=0 F  S ACU=$O(BEDS(SEQ,BED,ACU)) Q:'ACU  D
 . . . S LOG=0 F  S LOG=$O(BEDS(SEQ,BED,ACU,LOG)) Q:'LOG  D OCCUPIED(LOG,.DUP)
 ;
 D XML^EDPX("</rows>")
 Q
EMPTY(BED) ; add row if unoccupied be should show
 N ROW
 S ROW("bed")=BED
 S ROW("bedNm")=$P(^EDPB(231.8,BED,0),U,6)
 D XML^EDPX($$XMLA^EDPX("row",.ROW))
 Q
OCCUPIED(LOG,DUP) ; add log entry row
 N X0,X1,X3,X7,ROW
 S X0=^EDP(230,LOG,0),X1=$G(^(1)),X3=$G(^(3)),X7=$G(^(7))
 S ROW("id")=LOG
 ;S ROW("bed")=$$BEDNM(BED,$P(X3,U,9))
 S ROW("bed")=BED
 S ROW("bedNm")=$P(^EDPB(231.8,BED,0),U,6)
 S ROW("ptNm")=$P($P(X0,U,4),",")
 S ROW("ptDfn")=$P(X0,U,6)
 S ROW("last4")=$P(X0,U,11)
 S ROW("visit")=($P(X0,U,12)!$P(X0,U,13))
 S ROW("clinic")=$P(X0,U,14)
 S ROW("clinicNm")=$$LOCNM($P(X0,U,14))
 S ROW("complaint")=$P(X1,U,1)
 S ROW("comment")=$P(X3,U,8)
 S ROW("md")=$P(X3,U,5)
 S ROW("mdNm")=$$INITIAL($P(X3,U,5))
 S ROW("rn")=$P(X3,U,6)
 S ROW("rnNm")=$$INITIAL($P(X3,U,6))
 S ROW("res")=$P(X3,U,7)
 S ROW("resNm")=$$INITIAL($P(X3,U,7))
 S ROW("status")=$P(X3,U,2)
 S ROW("statusNm")=$$CAB(EDPSTA_".status",$P(X3,U,2))
 S ROW("acuity")=$P(X3,U,3)
 S ROW("acuityNm")=$$CAB(EDPSTA_".acuity",$P(X3,U,3))
 S ROW("emins")=$$HHMM($$MIN($P(X0,U,8)))
 S ROW("lmins")=$$HHMM($$LMIN(LOG))
 S ROW("similar")=$$SIM^EDPQLP(ROW("ptNm"),ROW("last4"),.DUP)
 ;
 N STS D ORDSTS(LOG,.STS)
 ; ROW("lab")=STS("LP")_"/"_STS("LC")             ; lab pending / lab complete
 S ROW("lab")=STS("LP")_"/"_STS("LC") ; lab pending / lab complete
 S ROW("labUrg")=$S(STS("LS"):2,STS("LP"):1,1:0)  ; any STAT labs?
 ; ROW("rad")=STS("RP")_"/"_STS("RC")             ; img pending / img complete
 S ROW("rad")=STS("RP")_"/"_STS("RC")
 S ROW("radUrg")=$S(STS("RS"):2,STS("RP"):1,1:0)  ; any STAT imgs?
 S ROW("ordNew")=STS("ON")                        ; number of new orders
 S ROW("minLab")=STS("LO")                        ; oldest pending/active lab
 S ROW("minRad")=STS("RO")                        ; oldest pending/active img
 S ROW("minVer")=STS("OO")                        ; oldest "new" order
 D XML^EDPX($$XMLA^EDPX("row",.ROW,"")) K ROW
 ;
 S ROW("num")=STS("LP")_"/"_STS("LC")             ; lab pending / lab complete
 D XML^EDPX($$XMLA^EDPX("labs",.ROW,""))
 I $O(STS("L",0)) D
 . N ORD M ORD=STS("L") D ADDORD(.ORD,"lab")
 D XML^EDPX("</labs>") K ROW
 ;
 S ROW("num")=STS("RP")_"/"_STS("RC")             ; img pending / img complete
 D XML^EDPX($$XMLA^EDPX("rads",.ROW,""))
 I $O(STS("R",0)) D
 . N ORD M ORD=STS("R") D ADDORD(.ORD,"rad")
 D XML^EDPX("</rads>")
  ;
 I $P(X7,U,2) D                                   ; vitals due
 . N LAST,DUE D XML^EDPX("<alerts>")
 . S LAST=$$LAST^EDPVIT($P(X0,U,6)),DUE=$$FMADD^XLFDT(LAST,,,+X7)
 . S ROW("name")="vitals",ROW("isDue")="false"
 . I DUE<$$NOW^XLFDT S ROW("isDue")="true",ROW("timeDue")=DUE
 . D XML^EDPX($$XMLA^EDPX("alert",.ROW)) K ROW
 . D XML^EDPX("</alerts>")
 ;
 D XML^EDPX("</row>")
 Q
 ;
ADDORD(LIST,TAG) ; add order detail to XML
 N ROW,IFN,OI,X,I
 S IFN=0 F  S IFN=+$O(LIST(IFN)) Q:IFN<1  K ROW D
 . S ROW("orderId")=IFN
 . S ROW("status")=$$GET1^DIQ(100,IFN_",",5)
 . S OI=$$OI^ORX8(IFN),ROW("name")=$P(OI,U,2),X=""
 . I $E(TAG)="l" S X=$$GET1^DIQ(60,+$P(OI,U,3)_",",51)
 . I $E(TAG)="r" S I=+$O(^ORD(101.43,+OI,2,0)),X=$G(^(I,0))
 . S:$L(X) ROW("abbre")=X
 . D XML^EDPX($$XMLA^EDPX(TAG,.ROW))
 Q
 ;
INITIAL(LOCID) ; Return initials
 Q:'LOCID ""
 Q $P(^VA(200,LOCID,0),U,2)
 ;
LOCNM(LOC) ; Return clinic name from 44
 Q:'LOC ""
 N X S X=$G(^SC(LOC,0))  ; IA#10040
 Q:'$L(X) ""
 I $L($P(X,U,2)) Q $P(X,U,2)
 Q $P(X,U)
 ;
BEDNM(CURBED,HELDBED) ; Return string for bed
 N X S X=$P(^EDPB(231.8,CURBED,0),U,6)
 I +HELDBED S X=X_" ("_$P(^EDPB(231.8,HELDBED,0),U,6)_")"
 Q X
 ;
CAB(LST,IEN) ; Return code abbreviation
 Q:'IEN ""
 N LSTDA,ABB,XSITE,XNATL
 S LSTDA=$O(^EDPB(233.2,"AS",LST,IEN,0))
 S ABB="",XSITE="",XNATL=""
 I LSTDA S XSITE=^EDPB(233.2,"AS",LST,IEN,LSTDA)
 S ABB=$P(XSITE,U,1) Q:$L(ABB) ABB  ;site abbreviation
 S XNATL=^EDPB(233.1,IEN,0)
 S ABB=$P(XNATL,U,3) Q:$L(ABB) ABB  ;nat'l abbreviation
 S ABB=$P(XSITE,U,2) Q:$L(ABB) ABB  ;site name
 S ABB=$P(XNATL,U,2) Q:$L(ABB) ABB  ;nat'l name
 Q ""
 ;
MIN(START) ; Return elapse time
 I 'START Q ""
 Q $$FMDIFF^XLFDT(EDPTIME,START,2)\60
 ;
LMIN(LOG) ; Return time at location
 N IEN,TS,TM S TM=0
 S TS="" F  S TS=$O(^EDP(230.1,"ADF",LOG,TS),-1) Q:'TS  D  Q:TM
 . S IEN=0 F  S IEN=$O(^EDP(230.1,"ADF",LOG,TS,IEN)) Q:'IEN  D  Q:TM
 . . I +$P($G(^EDP(230.1,IEN,3)),U,4) S TM=$P($G(^EDP(230.1,IEN,0)),U,2)
 I TM Q $$FMDIFF^XLFDT(EDPTIME,TM,2)\60
 Q 0
 ;
HHMM(MIN) ; Format as hours:minutes
 Q MIN  ;(the colon messed up the calculations for elapsed time)
 ;
 N H,M
 S H=MIN\60,M=MIN#60
 S:$L(M)=1 M="0"_M
 Q H_":"_M
 ;
ORDSTS(LOG,STS) ; compute statuses of orders
 N IEN,X0
 S STS("OO")=9999999,STS("ON")=0 ; oldest order, new orders
 S STS("LP")=0,STS("LO")=9999999,STS("LS")=0,STS("LC")=0
 S STS("RP")=0,STS("RO")=9999999,STS("RS")=0,STS("RC")=0
 S IEN=0 F  S IEN=$O(^EDP(230,LOG,8,IEN)) Q:'IEN  D
 . S X0=^EDP(230,LOG,8,IEN,0)
 . S:$L($P(X0,U,2)) STS($P(X0,U,2),+X0)=""
 . I ($P(X0,U,3)="N")!($P(X0,U,3)="A") D
 . . I $P(X0,U,5)<STS("OO") S STS("OO")=$P(X0,U,5)      ; oldest order
 . . I $P(X0,U,2)="L" D
 . . . S STS("LP")=STS("LP")+1                          ; pending labs
 . . . I $P(X0,U,5)<STS("LO") S STS("LO")=$P(X0,U,5)    ; oldest lab
 . . . I $P(X0,U,4) S STS("LS")=1                       ; stat lab
 . . I $P(X0,U,2)="R" D
 . . . S STS("RP")=STS("RP")+1                          ; pending radiology
 . . . I $P(X0,U,5)<STS("RO") S STS("RO")=$P(X0,U,5)    ; oldest radiology
 . . . I $P(X0,U,4) S STS("RS")=1                       ; stat radiology
 . I $P(X0,U,3)="N" S STS("ON")=STS("ON")+1
 . I $P(X0,U,3)="C" D
 . . I $P(X0,U,2)="L" S STS("LC")=STS("LC")+1           ; completed labs
 . . I $P(X0,U,2)="R" S STS("RC")=STS("RC")+1           ; completed radiology
 S STS("OO")=$S(STS("OO")=9999999:0,1:$$MIN(STS("OO")))
 S STS("LO")=$S(STS("LO")=9999999:0,1:$$MIN(STS("LO")))
 S STS("RO")=$S(STS("RO")=9999999:0,1:$$MIN(STS("RO")))
 Q
