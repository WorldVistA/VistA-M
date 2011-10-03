ORWDCSLT ; SLC/KCM - Consults calls [ 08/04/96  7:36 PM ]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;;Dec 17, 1997
 ;
DEF(LST)         ; load consult info    
 N ILST,NAM,IEN,X
 S ILST=0
 S LST($$NXT)="~Services" D SRVC
 S LST($$NXT)="~Inpt Urgencies" D INURG
 S LST($$NXT)="~Outpt Urgencies" D OUTURG
 S LST($$NXT)="~Inpt Place" D INPLACE
 S LST($$NXT)="~Outpt Place" D OUTPLACE
 Q
SRVC ; get list of consulting services
 ; S NAM="" F  S NAM=$O(^ORD(101.43,"S.CSLT",NAM)) Q:NAM=""  D
 ; . S IEN=$O(^ORD(101.43,"S.CSLT",NAM,0))
 ; . S LST($$NXT)="i"_IEN_U_NAM
 ; Q
 N TMPLST,IEN,I
 D GETLST^XPAR(.TMPLST,"ALL","ORWD CONSULT SERVICES")
 S I=0 F  S I=$O(TMPLST(I)) Q:'I  D
 . S IEN=$P(TMPLST(I),U,2)
 . S LST($$NXT)="i"_IEN_U_$P(^ORD(101.43,IEN,0),U,1)
 Q
INURG ; get list of urgencies for inpatient consults
 F X="STAT","ROUTINE","WITHIN 48 HOURS","WITHIN 72 HOURS" D
 . S IEN=$O(^ORD(101.42,"B",X,0))
 . S LST($$NXT)="i"_IEN_U_X
 S LST($$NXT)="dROUTINE"
 Q
OUTURG ; get list of urgencies for outpatient consults
 F X="STAT","TODAY","NEXT AVAILABLE","ROUTINE","WITHIN 72 HOURS","WITHIN 1 WEEK","WITHIN 1 MONTH" D
 . S IEN=$O(^ORD(101.42,"B",X,0))
 . S LST($$NXT)="i"_IEN_U_X
 S LST($$NXT)="dROUTINE"
 Q
OUTPLACE ; load list of places
 F X="C^Consultant's Choice","E^Emergency Room" S LST($$NXT)="i"_X
 S LST($$NXT)="dConsultant's Choice"
 Q
INPLACE ; load list of places for outpatient
 F X="B^Bedside","C^Consultant's Choice" S LST($$NXT)="i"_X
 S LST($$NXT)="dBedside"
 Q
NXT() ; increments ILST
 S ILST=ILST+1
 Q ILST
LOOK200(VAL,X)     ; Lookup a person in 200
 S VAL=$$FIND1^DIC(200,"","",X)
 Q
