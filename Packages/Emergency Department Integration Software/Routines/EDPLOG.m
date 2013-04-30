EDPLOG ;SLC/KCM - Update ED Log Update ;2/28/12 08:33am
 ;;2.0;EMERGENCY DEPARTMENT;;May 2, 2012;Build 103
 ;
 ;TODO:  add transaction processing
 ;
UPD(REQ,REMOVE,RESTORE) ; Update a record
 N REC,EDPFAIL D NVPARSE^EDPX(.REC,REQ)
 S EDPFAIL=0
 N IEN S IEN=$$VAL("id")
 I '$G(IEN) D FAIL("upd",2300007) Q EDPFAIL
 I '$D(^EDP(230,IEN,0)) D FAIL("upd",2300006) Q EDPFAIL
 N ERR S ERR=$$VALID^EDPLOG1(.REC) I $L(ERR) D FAIL("upd",ERR) Q EDPFAIL
 N AMB S AMB="(ambulance en route)"
 ;
 ; compute the local time & "no value" ien
 N TIME S TIME=$$NOW^XLFDT
 N EDPNOVAL S EDPNOVAL=+$O(^EDPB(233.1,"B","edp.reserved.novalue",0))
 ; before allowing remove, check the required fields
 S REMOVE=$G(REMOVE,0)!$P(^EDP(230,IEN,0),U,7)  ; removing or closed
 S RESTORE=$G(RESTORE,"") ; restoring to board
 I REMOVE D RDY2RMV I 'REC("closed") Q EDPFAIL
 I REMOVE S REC("closedBy")=$G(DUZ) ; if we are removing, set up the 'closedBy' and 'closed' value
 ;
 ; get the existing log entry
 N X0,X1,X2,X3,AREA,I
 S X0=^EDP(230,IEN,0),X1=$G(^(1)),X2=$G(^(2)),X3=$G(^(3))
 S AREA=$P(X0,U,3),^EDPB(231.9,AREA,230)=$H  ; last update timestamp
 ;
 ; if we are restoring to the board, set 'closed' to "" (removing the closed status)
 ; and set the bed to the waiting room
 I RESTORE D
 .S REC("closed")="",REC("bed")=$P(^EDPB(231.9,AREA,1),U,12),REC("restoredBy")=$G(DUZ),REC("restorePatient")=1,REC("outTS")=""
 ;
 N NAME,DFN,SSN,PCE
 S NAME=$$VAL("name"),DFN=$$VAL("dfn"),SSN=""
 I DFN S SSN=$P(^DPT(DFN,0),U,9)
 I '$P(X0,U,8),((NAME'=AMB)!DFN) S REC("inTS")=TIME
 ; Update any fields that have values passed in
 N FDA,FDAIEN,DIERR,HIST
 D SETFDA(X0,4,"name",.04)
 ;D SETFDA(X0,5,"ssn",.05) -- NtoL
 D SETFDA(X0,6,"dfn",.06)
 D SETFDA(X0,7,"closed",.07)
 D SETFDA(X0,8,"inTS",.08)
 D SETFDA(X0,9,"outTS",.09)
 D SETFDA(X0,10,"arrival",.1)
 D SETFDA(X0,14,"clinic",.14)
 D SETFDA(X1,1,"complaint",1.1)
 D SETFDA(X2,1,"compLong",2)
 D SETFDA(X3,2,"status",3.2)
 D SETFDA(X3,3,"acuity",3.3)
 D SETFDA(X3,4,"bed",3.4)
 D SETFDA(X3,5,"provider",3.5)
 D SETFDA(X3,6,"nurse",3.6)
 D SETFDA(X3,7,"resident",3.7)
 D SETFDA(X3,8,"comment",3.8)
 D SETFDA(X1,5,"delay",1.5)
 D SETFDA(X1,2,"disposition",1.2)
 ; 10-18-2011 bwf: add handling of fields related to removal and restoring of patient to the board
 I $G(REMOVE) D
 .D SETFDA(X0,16,"closedBy",.072) ; DFN of the user who 'closed' this record.
 I $G(RESTORE) D
 .; bwf - 2/16/2012
 .; The following fields should only be set if this record is actually being restored to the board
 .; There is a trigger x-ref that we need to stay consistent and not be changing every time we save the log entry.
 .D SETFDA(X0,17,"restorePatient",.073) ; flag - if the entry is found to have been 'Removed In Error'
 .D SETFDA(X0,18,"restoredBy",.074) ; DFN of the user who 'restored' this patient to the board. Triggers Restored By Date/Time field
 ; end changes
 D UPDHOLD^EDPLOGH(.FDA,IEN,$P(X3,U,4))
 I $G(FDA(230,IEN_",",1.2)) S FDA(230,IEN_",",1.3)=TIME
 I $L(NAME)&$L(SSN) S FDA(230,IEN_",",.11)=$E(NAME)_$E(SSN,6,9)
 I $$VAL("updDiag") S HIST(230.1,"+1,",9.1)=$G(HIST(230.1,"+1,",9.1))_"4;"
 ;
 L +^EDP(230,IEN):3 E  D FAIL("upd",2300015) Q EDPFAIL
 ; be sure to unlock before quitting!
 I $$COLLIDE^EDPLOGH(IEN,$$VAL("loadTS")) L -^EDP(230,IEN) Q EDPFAIL
 I $$BEDGONE^EDPLOGH(AREA,$P(X3,U,4),$P(X3,U,9),$$VAL("bed")) D FAIL("upd",2300016) L -^EDP(230,IEN) Q EDPFAIL
 I $D(HIST)>9 D SAVE^EDPLOGH(IEN,TIME,.HIST)
 I $D(FDA)>9 D FILE^DIE("","FDA","ERR")
 I '$D(DIERR),$$VAL("updDiag") D UPDDIAG
 L -^EDP(230,IEN)
 I $D(DIERR) D FAIL("upd",2300008) Q EDPFAIL
 ;
 D UPDVISIT^EDPLPCE(IEN,.PCE)
 ;
 I (DFN&'$P(X0,U,6))!($G(REC("inTS"))&'$P(X0,U,8)) D EVT^EDPLOGA(IEN)
 ;
 D XML^EDPX("<upd status='ok' id='"_IEN_"' />")
 Q EDPFAIL
UPDDIAG ; process diagnoses
 ; called from UPD^EDPLOG
 ; expects REC,PCE,IEN,TIME,AREA to be defined
 N DIAG,I,FDA,FDAIEN,ERR,CODED,CODE
 S DIAG="diagnosis-0",I=0,CODED=$P($G(^EDPB(231.9,AREA,1)),U,2)
 F  S DIAG=$O(REC(DIAG)) Q:$E(DIAG,1,10)'="diagnosis-"  D
 . S I=I+1,REC("diagnosis",I)=REC(DIAG)
 . I CODED S PCE($P(REC(DIAG),U),I)=REC(DIAG)
 I $D(REC("diagnosis"))<10 Q
 ; replace the diagnosis multiple
 D DELDIAG(IEN)
 S FDA(230,IEN_",",1.4)=TIME
 S I=0 F  S I=$O(REC("diagnosis",I)) Q:'I  D
 . Q:$P(REC("diagnosis",I),U,6)  ; entry being removed
 . S CODE=$P(REC("diagnosis",I),U,2)
 . S CODE=$S(+CODE:$$ICDONE^LEXU(CODE,TIME),1:"")
 . S:'$L(CODE) CODE=$P($P(REC("diagnosis",I),U,3),"/",1)
 . S:$L(CODE) CODE=+$O(^ICD9("BA",CODE_" ",0))
 . S FDA(230.04,"+"_I_","_IEN_",",.01)=$P(REC("diagnosis",I),U,4)
 . S FDA(230.04,"+"_I_","_IEN_",",.02)=CODE
 . S FDA(230.04,"+"_I_","_IEN_",",.03)=$P(REC("diagnosis",I),U,8)
 D UPDATE^DIE("","FDA","FDAIEN","ERR")
 Q
DELDIAG(IEN) ; delete the diagnosis multiple
 I '$O(^EDP(230,IEN,4,0)) Q  ; no child nodes
 N DA,DIK S DA=0,DA(1)=IEN,DIK="^EDP(230,"_DA(1)_",4,"
 F  S DA=$O(^EDP(230,IEN,4,DA)) Q:'DA  D ^DIK
 Q
HAVEDIAG() ; return true if a diagnosis is present
 ; expects REC to be defined
 N FOUND S FOUND=0
 N DIAG S DIAG="diagnosis-0"
 F  S DIAG=$O(REC(DIAG)) Q:$E(DIAG,1,10)'="diagnosis-"  D  Q:FOUND
 . I '$P(REC(DIAG),U,6) S FOUND=1  ; 6th piece is delete flag
 Q FOUND
 ;
RDY2RMV ; check required fields & set up so ready to remove
 ; called from UPD, expects REC and IEN and TIME
 ;
 ; check special dispositions first
 N DISP,CLOSE
 S DISP=+$$VAL("disposition"),CLOSE=0
 I DISP=+$O(^EDPB(233.1,"B","edp.disposition.error",0)) S CLOSE=1
 I DISP=+$O(^EDPB(233.1,"B","edp.disposition.nec",0)) S CLOSE=1
 I DISP=+$O(^EDPB(233.1,"B","edp.disposition.left",0)) S CLOSE=1
 I CLOSE S:'$$VAL("outTS") REC("outTS")=TIME S REC("closed")=1 Q
 ;
 ; check the generally required fields
 N MISSING S MISSING=""
 S REC("closed")=0
 I '$L($$VAL("complaint")) S MISSING=MISSING_"Complaint "
 I '$$VAL("bed") S MISSING=MISSING_"Room/Area "
 I '$$VAL("provider") S MISSING=MISSING_"Provider "
 I $$NOVAL("acuity") S MISSING=MISSING_"Acuity "
 ;
 ; check the other disposition required fields
 N X1,AREA,MIN,STS,OUT
 S AREA=$P(^EDP(230,IEN,0),U,3),STS=$P($G(^(3)),U,2)
 S X1=$G(^EDPB(231.9,AREA,1))
 S MIN=$$VAL("inTS") S:'MIN MIN=$P(^EDP(230,IEN,0),U,8)
 S OUT=$$VAL("outTS") S:'OUT OUT=TIME
 S MIN=$$FMDIFF^XLFDT(OUT,MIN,2)\60
 I $P(X1,U,1),'$$HAVEDIAG S MISSING=MISSING_"Diagnosis "
 I $P(X1,U,3),$$NOVAL("disposition") S MISSING=MISSING_"Disposition "
 ; (client parses for string "Delay Reason" to know whether to enable delay reason control)
 I $P(X1,U,4),(MIN>$P(X1,U,5)),$$NOVAL("delay"),'$$OBS(STS) S MISSING=MISSING_"Delay Reason "
 I $L(MISSING) D FAIL("upd","Fields required for removal are missing:  "_MISSING) Q
 S:'$$VAL("outTS") REC("outTS")=TIME S REC("closed")=1
 Q
VAL(X) ; Returns parameter value or null
 ; HTTP passes HTML-escaped values in an array as REC(param)
 Q $G(REC(X))
 ;
NOVAL(X) ; Returns true if value is empty, 0, or edp.reserved.novalue
 ; expects EDPNOVAL to be defined
 I +$G(REC(X))=0 Q 1
 I +$G(REC(X))=EDPNOVAL Q 1
 Q 0
 ;
OBS(X) ; Returns 1 or 0, if observation status X
 Q ($P($G(^EDPB(233.1,+$G(X),0)),U,5)["O")
 ;
SETFDA(NODE,P,SUB,FLD) ; Creates value in FDA & HIST arrays as appropriate
 ; from UPD, expects REC, FDA, HIST to be defined
 Q:'$D(REC(SUB))               ; value not sent in message
 Q:$P(NODE,U,P)=REC(SUB)       ; value is the same
 ; don't save switch from null to 0 or NOVAL to 0
 ; since 0 is always sent as none value for combo box fields
 I (REC(SUB)=0),($P(NODE,U,P)=""),("^.1^1.2^1.5^3.2^3.3^3.4^3.5^3.6^3.7^"[(U_FLD_U)) Q
 I (REC(SUB)=0),($P(NODE,U,P)=EDPNOVAL),("^.1^1.2^1.5^3.2^3.3^"[(U_FLD_U)) Q
 ;
 I REC(SUB)="" S REC(SUB)="@"  ; we must be deleting field if empty
 S FDA(230,IEN_",",FLD)=REC(SUB)
 ; save the changed fields in the history
 I $L(REC(SUB)) D
 . S HIST(230.1,"+1,",9.1)=$G(HIST(230.1,"+1,",9.1))_FLD_";"
 . S:FLD=.07 FLD=.0701    ; closed
 . S:FLD=1.1 FLD=.07      ; complaint
 . S:FLD=1.2 FLD=.11      ; disposition
 . S:FLD=1.5 FLD=.12      ; delay
 . S HIST(230.1,"+1,",FLD)=REC(SUB)
 . ; check for updated providers
 . S:FLD=3.5 PCE("PRV",1)=REC(SUB),PCE("PRI")=REC(SUB)  ; primary provider
 . S:FLD=3.6 PCE("PRV",2)=REC(SUB)                      ; nurse
 . S:FLD=3.7 PCE("PRV",3)=REC(SUB)                      ; resident
 Q
FAIL(ELEM,MSG) ; creates failure node for returned XML
 N X,EDPFAIL
 S EDPFAIL=0
 I +MSG S MSG=$$MSG^EDPX(MSG)
 S X="<"_ELEM_" id='"_$$VAL("id")_"' status='fail' msg='"_MSG_"' />"
 D XML^EDPX(X)
 S EDPFAIL=1
 Q EDPFAIL
