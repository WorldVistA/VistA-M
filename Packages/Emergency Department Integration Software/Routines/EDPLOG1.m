EDPLOG1 ;SLC/KCM - Update ED Log Validate ;2/28/12 08:33am
 ;;2.0;EMERGENCY DEPARTMENT;;May 2, 2012;Build 103
 ;
VALID(REC) ; validate the entries passed in REC
 D XLATE("arrival")
 D XLATE("clinic")
 D XLATE("bed")
 D XLATE("acuity")
 D XLATE("status")
 D XLATE("provider")
 D XLATE("nurse")
 D XLATE("resident")
 D XLATE("disposition")
 D XLATE("delay")
 ;
 N ERR S ERR=""
 D ADDTXT(.ERR,$$CHECK("name",230,.04,"Patient Name"))
 D ADDTXT(.ERR,$$CHECK("complaint",230,1.1,"Complaint"))
 D ADDTXT(.ERR,$$CHECK("compLong",230,2,"Long Complaint"))
 D ADDTXT(.ERR,$$CHECK("comment",230,3.8,"Comment"))
 ;
 N DIAG S DIAG="diagnosis-0"
 F  S DIAG=$O(REC(DIAG)) Q:$E(DIAG,1,10)'="diagnosis-"  D
 . S REC("edpDiagnosis")=$P(REC(DIAG),U,2)
 . D ADDTXT(ERR,$$CHECK("edpDiagnosis",230.04,.01,"Diagnosis"))
 Q ERR
 ;
CHECK(NAME,FILE,FIELD,MSG) ; return error msg if field is not valid
 ; called from VALID, assumes REC is defined
 N VAL,EDPRSLT
 S VAL=$G(REC(NAME))
 I VAL="" Q ""
 D CHK^DIE(FILE,FIELD,"",VAL,.EDPRSLT)
 I EDPRSLT="^" Q MSG_" is not valid."
 Q ""
ADDTXT(X,NEW) ; add new text comma delimited
 I $L(NEW),$L(X) S X=X_", "_NEW
 I $L(NEW),'$L(X) S X=NEW
 Q
XLATE(NAME) ; set up pointer fields for FDA array
 Q:'$D(REC(NAME))
 ;I REC(NAME)=0 S REC(NAME)="" ; store 0 when removing staff
 I REC(NAME)=-1 S REC(NAME)="@"
 Q
