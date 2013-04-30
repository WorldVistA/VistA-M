RORP018 ;BPOIFO/CLR  POST INSTALL PATCH 18 ;7/25/2012
 ;;1.5;CLINICAL CASE REGISTRIES;**18**;;Build 25
 ; This routine uses the following IAs:
 ;
 ; #2263    XPAR (supported)
 ; #10141   XPDUTL (supported)
 ;*****************************************************************************
 ;ICD9   Add Other depression
 ;*****************************************************************************
 N RORVALUE,RORERR,RORENTITY,RORPARAMETER,RORINSTANCE
 S RORENTITY="PKG.CLINICAL CASE REGISTRIES"
 S RORPARAMETER="ROR REPORT PARAMS TEMPLATE"
 S RORINSTANCE="13::Other Depression"
 ;delete it first (in case it already exists)
 D DEL^XPAR(RORENTITY,RORPARAMETER,RORINSTANCE,.RORERR)
 S RORVALUE="CCR Predefined Report Template"
 S RORVALUE(1,0)="<?xml version="_"""1.0"""_" encoding="_"""UTF-8"""_"?>"
 S RORVALUE(2,0)="<PARAMS>"
 S RORVALUE(3,0)="<ICD9LST>"
 S RORVALUE(4,0)="<GROUP ID="_"""OtherDepression"""_">"
 S RORVALUE(5,0)="<ICD9 ID="_"""293.83"""_">MOOD DISORDER IN COND CLASS ELSEWHERE</ICD9>"
 S RORVALUE(6,0)="<ICD9 ID="_"""296.90"""_">UNSPEC EPISODIC MOOD DISORDER</ICD9>"
 S RORVALUE(7,0)="<ICD9 ID="_"""296.99"""_">OTHER SPEC EPISODIC MOOD DISORDER</ICD9>"
 S RORVALUE(8,0)="<ICD9 ID="_"""298.0"""_">DEPRESS TYPE PSYCHOSIS</ICD9>"
 S RORVALUE(9,0)="<ICD9 ID="_"""300.4"""_">DYSTHYMIC DISORDER</ICD9>"
 S RORVALUE(10,0)="<ICD9 ID="_"""301.12"""_">CHR DEPRESs PERSONALITY DISORDER</ICD9>"
 S RORVALUE(11,0)="<ICD9 ID="_"""309.0"""_">ADJ DISORDER W DEPRESS MOOD</ICD9>"
 S RORVALUE(12,0)="<ICD9 ID="_"""309.1"""_">ADJ REACTION W PROLONG DEPRESs REACTION</ICD9>"
 S RORVALUE(13,0)="<ICD9 ID="_"""311."""_">DEPRESS DISORDER, NOT ELSEWHERE CLASS</ICD9>"
 S RORVALUE(14,0)="</GROUP>"
 S RORVALUE(15,0)="</ICD9LST>"
 S RORVALUE(16,0)="<PANELS>"
 S RORVALUE(17,0)="<PANEL ID="_"""160"""_"/>"
 S RORVALUE(18,0)="</PANELS>"
 S RORVALUE(19,0)="</PARAMS>"
 ;add it
 D ADD^XPAR(RORENTITY,RORPARAMETER,RORINSTANCE,.RORVALUE,.RORERR)
 D BMES^XPDUTL("Adding Other Depression common template...")
 ;*****************************************************************************
 ;ICD9  Add Major depression ;
 ;*****************************************************************************
 N RORVALUE,RORERR,RORENTITY,RORPARAMETER,RORINSTANCE
 S RORENTITY="PKG.CLINICAL CASE REGISTRIES"
 S RORPARAMETER="ROR REPORT PARAMS TEMPLATE"
 S RORINSTANCE="13::Major Depression"
 ;delete it first (in case it already exists)
 D DEL^XPAR(RORENTITY,RORPARAMETER,RORINSTANCE,.RORERR)
 S RORVALUE="CCR Predefined Report Template"
 S RORVALUE(1,0)="<?xml version="_"""1.0"""_" encoding="_"""UTF-8"""_"?>"
 S RORVALUE(2,0)="<PARAMS>"
 S RORVALUE(3,0)="<ICD9LST>"
 S RORVALUE(4,0)="<GROUP ID="_"""MajorDepression"""_">"
 S RORVALUE(5,0)="<ICD9 ID="_"""296.20"""_">MAJ DEPRESS AFF DIS, SING EPISODE, UNSPEc DEG</ICD9>"
 S RORVALUE(6,0)="<ICD9 ID="_"""296.21"""_">MAJ DEPRESs AFF DIS, SING EPISODE, MILD DEG</ICD9>"
 S RORVALUE(7,0)="<ICD9 ID="_"""296.22"""_">MAJ DEPRESS AFF DIS, SING EPISODE, MODERATE DEGR</ICD9>"
 S RORVALUE(8,0)="<ICD9 ID="_"""296.23"""_">MAJ DEPRESS AFF DIS, SING EPISODE, SEVERE DEGR, WO MENTION OF PSYCHOTIC BEHAVIOR</ICD9>"
 S RORVALUE(9,0)="<ICD9 ID="_"""296.24"""_">MAJ DEPRESS AFF DIS, SING EPISODE, SEVERE DEGR, SPEC AS W PSYCHOTIC BEHAVIOR</ICD9>"
 S RORVALUE(10,0)="<ICD9 ID="_"""296.25"""_">MAJ DEPRESS AFF DIS, SING EPISODE, IN PART OR UNSPEC REMISS</ICD9>"
 S RORVALUE(11,0)="<ICD9 ID="_"""296.26"""_">MAJ DEPRESS AFF DIS, SING EPISODE, IN FULL REMISS</ICD9>"
 S RORVALUE(12,0)="<ICD9 ID="_"""296.30"""_">MAJ DEPRESS AFF DIS, RECUR EPISODE, UNSPEC DEGREE</ICD9>"
 S RORVALUE(13,0)="<ICD9 ID="_"""296.31"""_">MAJ DEPRESS AFF DIS, RECUR EPISODE, MILD DEG</ICD9>"
 S RORVALUE(14,0)="<ICD9 ID="_"""296.32"""_">MAJ DEPRESS AFF DIS, RECUR EPISODE, MODERATE DEG</ICD9>"
 S RORVALUE(15,0)="</GROUP>"
 S RORVALUE(16,0)="</ICD9LST>"
 S RORVALUE(17,0)="<PANELS>"
 S RORVALUE(18,0)="<PANEL ID="_"""160"""_"/>"
 S RORVALUE(19,0)="</PANELS>"
 S RORVALUE(20,0)="</PARAMS>"
 ;add it
 D ADD^XPAR(RORENTITY,RORPARAMETER,RORINSTANCE,.RORVALUE,.RORERR)
 D BMES^XPDUTL("Adding Major Depression common template...")
 ;*****************************************************************************
 ;ICD9 Delete Depression
 ;*****************************************************************************
 N RORVALUE,RORERR,RORENTITY,RORPARAMETER,RORINSTANCE
 S RORENTITY="PKG.CLINICAL CASE REGISTRIES"
 S RORPARAMETER="ROR REPORT PARAMS TEMPLATE"
 S RORINSTANCE="13::Depression"
 ;delete it 
 D DEL^XPAR(RORENTITY,RORPARAMETER,RORINSTANCE,.RORERR)
 D BMES^XPDUTL("Deleting Depression common template...")
 ;*****************************************************************************
 ;Update to ROR METADATA
 ;*****************************************************************************
 N FILE,IX,ERRCNT,NODE,IENS
 N DA,DIK,RORFDA,RORDATA,RORIEN,RORIENS,DIERR
 S DA=45,DIK="^ROR(799.2," I $D(^ROR(799.2,45))>0 D ^DIK  ;delete if exists
 S ERRCNT=0
 S RORIEN(1)=45
 S RORFDA(799.2,"+1,",.01)=45
 S RORFDA(799.2,"+1,",1)=2
 F I=1:1:13 S RORDATA=$P($T(META45+I),";",2) Q:RORDATA=""  D
 . S RORIENS="+"_(I+1)_",+1,"
 . S RORFDA(799.22,RORIENS,.01)=$P(RORDATA,U)
 . S RORFDA(799.22,RORIENS,.02)=$P(RORDATA,U,2)
 . S RORFDA(799.22,RORIENS,2)=$P(RORDATA,U,3)
 . S RORFDA(799.22,RORIENS,4)=$P(RORDATA,U,4)
 . S RORFDA(799.22,RORIENS,1)=$P(RORDATA,U,5)
 . S RORFDA(799.22,RORIENS,6)=$P(RORDATA,U,6)
 D UPDATE^DIE(,"RORFDA","RORIEN","RORMSG")
 I $D(DIERR) S ERRCNT=ERRCNT+1
 I ERRCNT>0 D BMES^XPDUTL("Update to ROR METADATA <<FAILED>>") Q
 S FILE=9000010.07
 S IX=0 F  S IX=$O(^ROR(799.2,FILE,2,IX)) Q:IX'>0  D
 . S NODE=$G(^ROR(799.2,FILE,2,IX,0))
 . I $P(NODE,U)="POV" D
 . . S IENS=IX_","_FILE_","
 . . S RORFDA(799.22,IENS,4)="Internal"
 . . S RORFDA(799.22,IENS,4.2)="01"
 . . D FILE^DIE(,"RORFDA","RORMSG")
 . . I $D(DIERR) S ERRCNT=ERRCNT+1
 S FILE=9000011
 S IX=0 F  S IX=$O(^ROR(799.2,FILE,2,IX)) Q:IX'>0  D
 . S NODE=$G(^ROR(799.2,FILE,2,IX,0))
 . I $P(NODE,U)="DIAGNOSIS" D
 . . S IENS=IX_","_FILE_","
 . . S RORFDA(799.22,IENS,4)="EI"
 . . S RORFDA(799.22,IENS,4.2)="1^.01"
 . . D FILE^DIE(,"RORFDA","RORMSG")
 . . I $D(DIERR) S ERRCNT=ERRCNT+1
 I ERRCNT>0 D BMES^XPDUTL("Update to ROR METADATA <<FAILED>>") Q
 E  D BMES^XPDUTL("Updating ROR METADATA...")
 ;******************************************************************************
 ;Add new entries to the ROR LIST ITEM file (#799.1)
 ; TEXT^TYPE^REGIEN^CODE 
 ;******************************************************************************
 N RORDATA,RORTAG,RORFDA,I,TEXT,TYPE,REGISTRY,CODE,RORERR,ERRCNT
 S ERRCNT=0
 ; add items for auto confirm registries
 S REGISTRY=0 F  S REGISTRY=$O(^ROR(798.1,"C",1,REGISTRY)) Q:REGISTRY'>0  D
 . F I=1:1 S RORDATA=$P($T(LIST+I),";",2) Q:RORDATA=""  D
 . . S TEXT=$P(RORDATA,"^",1) ;TEXT to add
 . . S TYPE=$P(RORDATA,"^",2) ;TYPE to add
 . . S CODE=$P(RORDATA,"^",4) ;CODE to add
 . . ;don't add if it's already in the global
 . . Q:$D(^ROR(799.1,"KEY",TYPE,REGISTRY,CODE))
 . . S RORFDA(799.1,"+1,",.01)=TEXT
 . . S RORFDA(799.1,"+1,",.02)=TYPE
 . . S RORFDA(799.1,"+1,",.03)=REGISTRY
 . . S RORFDA(799.1,"+1,",.04)=CODE
 . . D UPDATE^DIE(,"RORFDA",,"RORERR")
 . . I $D(DIERR) S ERRCNT=ERRCNT+1
 I ERRCNT>0 D BMES^XPDUTL("Update to ROR LIST ITEM <<FAILED>>") Q 
 E  D BMES^XPDUTL("Updating ROR LIST ITEM...")
 Q
 ;
 ;******************************************************************************
 ; Data to be added to ROR METADATA file (#799.2)
 ; DATA NAME^CODE^REQUIRED^VALUE TYPE^LOADER API^FIELD NUMBER
 ;******************************************************************************
META45 ;
 ;PRINCIPAL DIAGNOSIS^101^1^Internal^1^79
 ;SECONDARY DIAGNOSIS 1^102^1^Internal^1^79.16
 ;SECONDARY DIAGNOSIS 2^103^1^Internal^1^79.17
 ;SECONDARY DIAGNOSIS 3^104^1^Internal^1^79.18
 ;SECONDARY DIAGNOSIS 4^105^1^Internal^1^79.19
 ;SECONDARY DIAGNOSIS 5^106^1^Internal^1^79.201
 ;SECONDARY DIAGNOSIS 6^107^1^Internal^1^79.21
 ;SECONDARY DIAGNOSIS 7^108^1^Internal^1^79.22
 ;SECONDARY DIAGNOSIS 8^109^1^Internal^1^79.23
 ;SECONDARY DIAGNOSIS 9^110^1^Internal^1^79.24
 ;PRINCIPAL DIAGNOSIS pre 1986^111^1^Internal^1^80
 ;FACILITY^131^1^Internal^1^3
 ;SUFFIX^132^1^Internal^1^5
 ;
 ;******************************************************************************
 ; Data to be added to ROR LIST ITEM file (#799.1)
 ; TEXT^TYPE^REGIEN^CODE
 ;
 ;******************************************************************************
LIST ;
 ;Registry Lab^3^^1
 ;BMI^5^^1
 ;MELD^6^^1
 ;MELD-Na^6^^2
 ;APRI^6^^3
 ;FIB-4^6^^4
 ;Creatinine clearance by Cockcroft-Gault^7^^1
 ;eGFR by MDRD^7^^2
 ;eGFR by CKD-EPI^7^^3
