EDPLOGA ;SLC/KCM - Add Entry to ED Log ;2/28/12 08:33am
 ;;2.0;EMERGENCY DEPARTMENT;;May 2, 2012;Build 103
 ;
 ;TODO:  add transaction processing
 ;
ADD(NEWPT,AREA,TIME,CHOICES) ; Create a new ED Log record for a patient
 ; add the new record to the returned XML
 ; NEWPT = dfn \T name \T dob \T ssn
 N DFN,NAME,SSN,STATUS,BED,ARR,REC,AMB,CLINIC,EDPLOG,EDPFAIL
 S EDPFAIL=0
 S AMB="(ambulance en route)"
 ;
 ; Set up the patient fields that were passed in
 D NVPARSE^EDPX(.REC,NEWPT)
 S DFN=REC("dfn"),NAME=REC("name"),SSN="",CLINIC=$G(REC("clinic"))
 I DFN S REC("name")=$P(^DPT(DFN,0),U),REC("ssn")=$P(^DPT(DFN,0),U,9)
 ;S SSN=REC("ssn") S:SSN="*SENSITIVE*" SSN="" --NtoL
 I 'DFN,(NAME="") S EDPFAIL=$$FAIL^EDPLOG("add",2300014) Q EDPFAIL
 ;
 ; Add default values to stub entry (should be based on config for area)
 S BED=$P(^EDPB(231.9,AREA,1),U,12)
 I $G(REC("name"))=AMB D
 . S ARR=$O(^EDPB(233.1,"B","edp.arrival.ambulance",0))
 . S BED=$P(^EDPB(231.9,AREA,1),U,11)
 S STATUS="" I BED S STATUS=$P(^EDPB(231.8,BED,0),U,8)
 ;
 I +DFN,$D(^EDP(230,"AP",EDPSITE,AREA,DFN)) S EDPFAIL=$$FAIL^EDPLOG("add",2300002) Q EDPFAIL
 I 'DFN,(NAME'=AMB),$D(^EDP(230,"AN",EDPSITE,AREA,NAME)) S EDPFAIL=$$FAIL^EDPLOG("add",2300002) Q EDPFAIL
 N ERR S ERR=$$VALID^EDPLOG1(.REC) I $L(ERR) S EDPFAIL=$$FAIL^EDPLOG("add",ERR) Q EDPFAIL
 S ^EDPB(231.9,AREA,230)=$H  ; last update timestamp
 ;
 ; Create a current log record
 N FDA,FDAIEN,DIERR,HIST,HISTIEN,LOGIEN
 S FDA(230,"+1,",.01)=TIME
 S FDA(230,"+1,",.02)=EDPSITE
 S FDA(230,"+1,",.03)=AREA
 S FDA(230,"+1,",.04)=NAME
 ;S FDA(230,"+1,",.05)=SSN --NtoL
 S FDA(230,"+1,",.06)=DFN
 S FDA(230,"+1,",3.2)=STATUS
 S FDA(230,"+1,",3.4)=BED
 I $L(SSN) S FDA(230,"+1,",.11)=$E(NAME)_$E(SSN,6,9)
 I NAME=AMB S FDA(230,"+1,",.11)="(amb)"
 I NAME'=AMB S FDA(230,"+1,",.08)=TIME
 I $G(ARR) S FDA(230,"+1,",.1)=ARR
 I CLINIC S FDA(230,"+1,",.14)=CLINIC
 I $G(REC("create")) S FDA(230,"+1,",.13)=REC("create")
 M HIST(230.1)=FDA(230)
 D UPDATE^DIE("","FDA","FDAIEN","ERR")
 I $D(DIERR) S EDPFAIL=$$FAIL^EDPLOG("add",2300004) Q EDPFAIL
 S LOGIEN=FDAIEN(1)
 ;
 ; Post new patient event
 I DFN,TIME D EVT(LOGIEN)
 ;
 ; Create the first history entry
 S HIST(230.1,"+1,",.01)=LOGIEN
 S HIST(230.1,"+1,",.02)=TIME
 S HIST(230.1,"+1,",.03)=EDPUSER
 K HIST(230.1,"+1,",.11) ; don't need last4
 K HIST(230.1,"+1,",.13) ; don't need creation source
 D UPDATE^DIE("","HIST","HISTIEN","ERR")
 I $D(DIERR) S EDPFAIL=$$FAIL^EDPLOG("add",2300004) Q EDPFAIL
 ;
 D XML^EDPX("<add status='ok' id='"_FDAIEN(1)_"' />")
 D GET^EDPQLE(FDAIEN(1),CHOICES)
 Q EDPFAIL
 ;
DEL(AREA,LOGID) ; Delete Stub Log Entry
 N I,CNT,DIK,DA
 S I=0,CNT=0 F  S I=$O(^EDP(230.1,"B",LOGID,I)) Q:'I  S CNT=CNT+1
 I $L($P($G(^EDP(230,LOGID,1)),U))!(CNT>1) D  Q
 . D FAIL^EDPLOG("upd","Does not appear to be a stub entry")
 ;
 ; Delete initial history entry
 S DIK="^EDP(230.1,",DA=$O(^EDP(230.1,"B",LOGID,0))
 I DA D ^DIK
 ; Delete stub log entry
 S DIK="^EDP(230,",DA=LOGID
 D ^DIK
 ;
 D XML^EDPX("<upd status='ok' />")
 Q
 ;
EVT(LOG) ; -- post new patient event [expects EDPSITE]
 N X0,DFN,SDT,SDCL,SDATA,SDAMEVT,X
 S X0=$G(^EDP(230,+$G(LOG),0)),DFN=+$P(X0,U,6),SDT=+$P(X0,U,8)
 I 'DFN!'SDT Q  ;missing data
 S SDCL=$$DFLTLOC^EDPLPCE(DFN) Q:'SDCL
 ; have patient, time, hosp loc -> post event
 S SDATA=U_DFN_U_SDT_U_SDCL,SDAMEVT=1
 S EDPDATA=LOG_SDATA
 S X=+$O(^ORD(101,"B","EDP NEW PATIENT",0))_";ORD(101,"
 D EN^XQOR
 K EDPDATA
 Q
