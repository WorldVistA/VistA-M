ORRHCR ; SLC/KCM/JLI - Hepatitis C Reporting Tools; [4/4/02 2:07pm]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**153**;Dec 17, 1997
 ;
NXT() ; Increment ILST
 S ILST=ILST+1
 Q ILST
 ;
TAG(NAM,VAL)    ; Set Name=Value (was <XMLTag>Value</XMLTag>)
 Q NAM_"="_VAL
 ;
GENRPT(LST) ; Retrun a list of Generic reports
 ; LST(n)="IEN^DisplayText"
 N NM,ORIG,IEN,ILST S ILST=0
 ; loop thru the reports for all users
 S NM="RPT ",ORIG=NM
 F  S NM=$O(^ORD(102.21,"B",NM)) Q:$E(NM,1,4)'=ORIG  D RPTLST1
 Q
RPTLST(LST)     ; Return a list of reports for a user
 ; LST(n)="IEN^DisplayText"
 N NM,ORIG,IEN,ILST S ILST=0
 ; loop thru the reports for all users
 S NM="RPT ",ORIG=NM
 F  S NM=$O(^ORD(102.21,"B",NM)) Q:$E(NM,1,4)'=ORIG  D RPTLST1
 S LST($$NXT)="0^    "
 ; loop thru the user's reports
 Q:'DUZ
 S NM="RPTU"_DUZ_" ",ORIG=NM
 F  S NM=$O(^ORD(102.21,"B",NM)) Q:$E(NM,1,$L(ORIG))'=ORIG  D RPTLST1
 Q
RPTLST1 S IEN=0 F  S IEN=$O(^ORD(102.21,"B",NM,IEN)) Q:'IEN  D
 . Q:$P(^ORD(102.21,IEN,0),U,4)'="R"
 . Q:$L($P(^ORD(102.21,IEN,0),U,3))
 . S LST($$NXT)=IEN_U_$P(^ORD(102.21,IEN,0),U,2)
 Q
TAGDEF(LST,TAG) ; Return a critieron definition given a tag
 N RPTID
 S RPTID=$O(^ORD(102.21,"T",TAG,0)) Q:'RPTID
 G RPTDEF1
RPTDEF(LST,RPTID)       ; Return a report definition for a given report
 ; LST(n)="Name=Value"
RPTDEF1 I RPTID=0 S RPTID=$O(^ORD(102.21,"B","RPT BASELINE STUB",0))
 N SEQ,IEN,X0,X1,X4,I,CID,CAP,CNM,EID,ILST,TYP,PAR S ILST=0
 S X0=^ORD(102.21,RPTID,0),TYP=$P(X0,U,4)
 S LST($$NXT)=$$TAG("Name",$P(X0,U))
 S LST($$NXT)=$$TAG("DisplayText",$P(X0,U,2))
 S SEQ=0 F  S SEQ=$O(^ORD(102.21,RPTID,1,"B",SEQ)) Q:'SEQ  D
 . S IEN=0 F  S IEN=$O(^ORD(102.21,RPTID,1,"B",SEQ,IEN)) Q:'IEN  D
 . . S X0=^ORD(102.21,RPTID,1,IEN,0)
 . . S CID=$P(X0,U,2),CNM=$P(X0,U,3),CAP=$P(X0,U,4),EID=""
 . . I 'CID,TYP="C" S CID=RPTID
 . . I CID S CID=$P(^ORD(102.21,CID,0),U,7)
 . . I CNM S X=^ORD(102.22,CNM,0),CNM=$P(X,U),EID=$P(X,U,2)
 . . S LST($$NXT)=$$TAG("QueryText",SEQ)
 . . I CID S LST($$NXT)=$$TAG("CriterionTag",CID)
 . . S LST($$NXT)=$$TAG("Caption",CAP)
 . . I $L(CNM) S LST($$NXT)=$$TAG("ConstraintName",CNM)
 . . I EID S LST($$NXT)=$$TAG("EditorID",EID)
 . . S I=0 F  S I=$O(^ORD(102.21,RPTID,1,IEN,1,I)) Q:'I  D
 . . . S LST($$NXT)=$$TAG("Value",^ORD(102.21,RPTID,1,IEN,1,I,0))
 S SEQ="" F  S SEQ=$O(^ORD(102.21,RPTID,2,"B",SEQ)) Q:SEQ=""  D
 . S IEN=0 F  S IEN=$O(^ORD(102.21,RPTID,2,"B",SEQ,IEN)) Q:'IEN  D
 . . S X1=^ORD(102.21,RPTID,2,IEN,0)
 . . S X4=^ORD(102.24,$P(X1,U,2),0)
 . . S LST($$NXT)=$$TAG("ColumnName",$P(X4,U,1))
 . . S LST($$NXT)=$$TAG("ColumnHeader",$P(X4,U,3))
 . . S LST($$NXT)=$$TAG("ColumnWidth",$P(X1,U,3))
 Q
CTPLST(LST)     ; Return a list of all criteria and parents
 ; LST(n)=CriteriaTag=ParentTag
 N NM,ORIG,IEN,X0,PAR,TAG,PTAG,ILST
 S NM="CT",ORIG=NM,ILST=0
 F  S NM=$O(^ORD(102.21,"B",NM)) Q:$E(NM,1,2)'=ORIG  D
 . S IEN=0 F  S IEN=$O(^ORD(102.21,"B",NM,IEN)) Q:'IEN  D
 . . S X0=^ORD(102.21,IEN,0),PAR=+$P(X0,U,6),TAG=+$P(X0,U,7),PTAG=0
 . . I PAR S PTAG=+$P($G(^ORD(102.21,PAR,0)),U,7)
 . . S LST($$NXT)=PTAG_"="_TAG
 Q
USRRPT(IEN,DTX) ; Return the IEN of a user report given report name
 N RNM
 Q:$E(DTX,1,4)'="RPTU"
 S RNM=$$UP^XLFSTR(DTX)
 S IEN=+$O(^ORD(102.21,"B",RNM,0))
 Q
SAVDEF(RIEN,DEF) ; Save a report definition
 N I,SEQ,NAM,VAL,RPTDEF,DTX,RNM,QIEN,VIEN,FIEN,CTN,CNM,CAP,WID
 N RPTID,RPTNM,OLDDTX
 S RPTID=0,(RPTNM,OLDDTX)=""
 S SEQ=0
 S I=0 F  S I=$O(DEF(I)) Q:'I  D
 . S NAM=$P(DEF(I),"="),VAL=$P(DEF(I),"=",2) Q:'$L(NAM)
 . I $E(NAM,1,6)="Column" D  Q  ;columns in separate subscript
 . . I NAM="Column" S SEQ=VAL
 . . I NAM'="Column" S RPTDEF("COL",SEQ,NAM)=VAL
 . I NAM="QueryText" S SEQ=VAL
 . I NAM'="Value" S RPTDEF(SEQ,NAM)=VAL
 . I NAM="Value" S RPTDEF(SEQ,NAM,I)=VAL
 S:$G(RPTDEF(0,"IEN")) RPTID=RPTDEF(0,"IEN")
 S RPTNM=$G(RPTDEF(0,"Name"))
 S DTX=$G(RPTDEF(0,"DisplayText"))
 I '$L(DTX) S RIEN="0^Name of report not found" Q
 I RPTID,($E(RPTNM,1,4)'="RPT ") S RIEN=RPTID
 S RNM="RPTU"_DUZ_" "_$$UP^XLFSTR(DTX)
 S:'+$G(RIEN) RIEN=$O(^ORD(102.21,"C",RNM,0))
 I RIEN D  Q:'RIEN
 . N DIK,DA
 . S DIK="^ORD(102.21,",DA=RIEN D ^DIK
 . I 'DA S RIEN="0^Error deleting existing report"
 S RIEN=$$NEWRPT(RNM,DTX)
 I 'RIEN S RIEN="0^Error adding new report" Q
 S SEQ=0 F  S SEQ=$O(RPTDEF(SEQ)) Q:'SEQ  D
 . S CTN=$G(RPTDEF(SEQ,"CriterionTag"))
 . I CTN S CTN=$O(^ORD(102.21,"T",CTN,0))
 . S CNM=$G(RPTDEF(SEQ,"ConstraintName"))
 . I $L(CNM) S CNM=$O(^ORD(102.22,"B",CNM,0))
 . S CAP=$G(RPTDEF(SEQ,"Caption"))
 . S QIEN=$$NEWQTX(RIEN,SEQ,CTN,CNM,CAP)
 . S I=0 F  S I=$O(RPTDEF(SEQ,"Value",I)) Q:I=""  D
 . . S VIEN=$$NEWVAL(RIEN,QIEN,$G(RPTDEF(SEQ,"Value",I)))
 S SEQ="" F  S SEQ=$O(RPTDEF("COL",SEQ)) Q:SEQ=""  D
 . S NAM=$G(RPTDEF("COL",SEQ,"ColumnName"))
 . S WID=$G(RPTDEF("COL",SEQ,"ColumnWidth"))
 . S FIEN=$$NEWCOL(RIEN,SEQ,NAM,WID)
 Q
NEWRPT(RNM,DTX) ; Add top level criterion
 N FDA,FDAIEN,DIERR,IENS,ERR
 S FDA(102.21,"+1,",.01)=RNM
 S FDA(102.21,"+1,",2)=DTX
 S FDA(102.21,"+1,",4)="R"
 S FDA(102.21,"+1,",5)=DUZ
 D UPDATE^DIE("","FDA","FDAIEN","ERR")
 Q FDAIEN(1)
NEWQTX(RIEN,SEQ,CTN,CNM,CAP)    ; Add new querytext record for DEF
 N FDA,FDAIEN,DIERR,IENS,ERR
 S IENS="+1,"_RIEN_","
 S FDA(102.211,IENS,.01)=SEQ
 I $L(CTN) S FDA(102.211,IENS,2)=CTN
 I $L(CNM) S FDA(102.211,IENS,3)=CNM
 I $L(CAP) S FDA(102.211,IENS,4)=CAP
 D UPDATE^DIE("","FDA","FDAIEN","ERR")
 Q FDAIEN(1)
NEWVAL(RIEN,QIEN,VAL)   ; Add new value record to Query Text
 N FDA,FDAIEN,DIERR,IENS,ERR
 S IENS="+1,"_QIEN_","_RIEN_","
 S FDA(102.2111,IENS,.01)=VAL
 D UPDATE^DIE("E","FDA","FDAIEN","ERR")
 Q FDAIEN(1)
NEWCOL(RIEN,SEQ,NAM,WID)        ; Add new format record for DEF
 N FDA,FDAIEN,DIERR,IENS,ERR
 S IENS="+1,"_RIEN_","
 S FDA(102.212,IENS,.01)=SEQ
 I $L(NAM) S FDA(102.212,IENS,2)=NAM
 I $L(WID) S FDA(102.212,IENS,3)=WID
 D UPDATE^DIE("E","FDA","FDAIEN","ERR")
 Q FDAIEN(1)
OWNED(VAL,RPT)  ; Return 1 is this report is owned by the current user
 S VAL=0
 I $P($G(^ORD(102.21,RPT,0)),U,5)=DUZ S VAL=1
 Q
DELETE(OK,DA)   ; Delete a report
 N DIK
 S DIK="^ORD(102.21,"
 D ^DIK
 Q
