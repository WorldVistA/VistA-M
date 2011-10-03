ORWDCN32 ; SLC/KCM/REV - Consults calls [ 12/16/97  12:47 PM ] ;14:50 PM 01 MAR 2001
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**10,85**;Dec 17, 1997
 ;
DEF(LST,WHY)         ; load consult info    
 N ILST,NAM,IEN,X
 S ILST=0
 S LST($$NXT)="~ShortList" D SHORT
 I WHY="C" D
 . S LST($$NXT)="~Inpt Cslt Urgencies" D INCURG
 I WHY="P" D
 . S LST($$NXT)="~Inpt Proc Urgencies" D INPURG
 S LST($$NXT)="~Outpt Urgencies" D OUTURG
 S LST($$NXT)="~Inpt Place" D INPLACE
 S LST($$NXT)="~Outpt Place" D OUTPLACE
 Q
SHORT ;return list of Consults or Procedures quick orders
 N I,TMP
 Q:"CP"'[WHY
 S I=$O(^ORD(100.98,"B",$S(WHY="C":"CSLT",WHY="P":"PROC"),0))
 D GETQLST^ORWDXQ(.TMP,I,"Q")
 S I=0 F  S I=$O(TMP(I)) Q:'I  D
 . S LST($$NXT)="i"_TMP(I)
 Q
OUTPLACE ; load list of places
 N X
 F X="C^CONSULTANT'S CHOICE^C","E^EMERGENCY ROOM^E" D
 . S LST($$NXT)="i"_X
 S LST($$NXT)="d"_"C^CONSULTANT'S CHOICE^C"
 Q
INPLACE ; load list of places for outpatient
 N X
 F X="B^BEDSIDE^B","C^CONSULTANT'S CHOICE^C" D
 . S LST($$NXT)="i"_X
 S LST($$NXT)="d"_"B^BEDSIDE^B"
 Q
INCURG ; get list of urgencies for inpatient consults
 N IEN,GMRCURG,GMRCPRO,X
 S GMRCURG="",GMRCPRO=""
 F  S GMRCURG=$O(^ORD(101.42,"S.GMRCT",GMRCURG)) Q:GMRCURG=""  D
 . S GMRCPRO=$O(^ORD(101,"B","GMRCURGENCY - "_GMRCURG,0))
 . S LST($$NXT)="i"_$O(^ORD(101.42,"S.GMRCT",GMRCURG,0))_U_GMRCURG_U_GMRCPRO
 S IEN=$O(^ORD(101.42,"B","ROUTINE",0)),GMRCPRO=$O(^ORD(101,"B","GMRCURGENCY - ROUTINE",0))
 S LST($$NXT)="d"_IEN_U_"ROUTINE"_U_GMRCPRO
 Q
INPURG ; get list of urgencies for inpatient procedures
 N IEN,GMRCURG,GMRCPRO,X
 S GMRCURG="",GMRCPRO=""
 F  S GMRCURG=$O(^ORD(101.42,"S.GMRCR",GMRCURG)) Q:GMRCURG=""  D
 . S GMRCPRO=$O(^ORD(101,"B","GMRCURGENCY - "_GMRCURG,0))
 . S LST($$NXT)="i"_$O(^ORD(101.42,"S.GMRCR",GMRCURG,0))_U_GMRCURG_U_GMRCPRO
 S IEN=$O(^ORD(101.42,"B","ROUTINE",0)),GMRCPRO=$O(^ORD(101,"B","GMRCURGENCY - ROUTINE",0))
 S LST($$NXT)="d"_IEN_U_"ROUTINE"_U_GMRCPRO
 Q
OUTURG ; get list of urgencies for outpatient consults/procedures
 N IEN,GMRCURG,GMRCPRO,X
 S GMRCURG="",GMRCPRO=""
 F  S GMRCURG=$O(^ORD(101.42,"S.GMRCO",GMRCURG)) Q:GMRCURG=""  D
 . S GMRCPRO=$O(^ORD(101,"B","GMRCURGENCY - "_GMRCURG,0))
 . S LST($$NXT)="i"_$O(^ORD(101.42,"S.GMRCO",GMRCURG,0))_U_GMRCURG_U_GMRCPRO
 S IEN=$O(^ORD(101.42,"B","ROUTINE",0)),GMRCPRO=$O(^ORD(101,"B","GMRCURGENCY - ROUTINE",0))
 S LST($$NXT)="d"_IEN_U_"ROUTINE"_U_GMRCPRO
 Q
NXT() ; increments ILST
 S ILST=ILST+1
 Q ILST
LOOK200(VAL,X)     ; Lookup a person in 200
 S VAL=$$FIND1^DIC(200,"","",X)
 Q
ORDRMSG(Y,ORDITM) ;returns order message for this consult/procedure orderable
 N I
 S I=0 F  S I=$O(^ORD(101.43,ORDITM,8,I)) Q:I'>0  S Y(I)=^(I,0)
 Q
GETPROTO(Y,ORIEN) ;Get Protocol file IEN from OR IEN
 S Y=$P($G(^ORD(101.43,ORIEN,0)),U,2)
 Q
GETOINUM(Y,ORNUM) ;Get Orderable Item IEN from Protocol IEN
 S Y=$O(^ORD(101.43,"ID",ORNUM,0))
 Q
GETPRONM(Y,ORNAME) ;Get Protocol IEN given name
 S Y=$O(^ORD(101,"B",ORNAME,0))_";99PRO"
 Q
PROC(Y,FROM,DIR) ; Return a subset of orderable procedures
 ; .Return Array, Starting Text, Direction
 ; ^ORD(101.43,"S.PROC",UpperCase,DA)=Mne^MixedCase^InactvDt^.01IfMne
 ; Y(n)=IEN^.01 Name^.01 Name  -or-  IEN^Synonym <.01 Name>^.01 Name
 N I,IEN,CNT,X,DTXT,ORID,ORSVCCNT S I=0,CNT=44
 F  Q:I'<CNT  S FROM=$O(^ORD(101.43,"S.PROC",FROM),DIR) Q:FROM=""  D
 . S IEN=0 F  S IEN=$O(^ORD(101.43,"S.PROC",FROM,IEN)) Q:'IEN  D
 . . S X=^ORD(101.43,"S.PROC",FROM,IEN)
 . . I +$P(X,U,3),$P(X,U,3)<$$NOW^XLFDT Q
 . . S ORID=$P($G(^ORD(101.43,IEN,0)),U,2)
 . . ;I $P($G(^ORD(101,ORIEN,0)),U,3)'="" Q   ; Removed for v14
 . . D GETSVC^GMRCPR0(.ORSVCCNT,ORID) Q:+ORSVCCNT=0
 . . S I=I+1
 . . I 'X S Y(I)=IEN_U_$P(X,U,2)_U_$P(X,U,2)_U_ORID
 . . E  S Y(I)=IEN_U_$P(X,U,2)_$C(9)_"<"_$P(X,U,4)_">"_U_$P(X,U,4)_U_ORID
 Q
NEWDLG(Y,ORTYPE,ORLOC) ; Return order dialog info for New Consult OR PROCEDURE
 N DGRP,ID,IEN,TXT,TYP,X,X0,X5,ENT
 S ENT="ALL"
 I $G(ORLOC) S ORLOC=+ORLOC_";SC(",ENT=ENT_"^"_ORLOC
 I ORTYPE="C" S X=$$GET^XPAR(ENT,"ORWDX NEW CONSULT",1,"I")
 E  S X=$$GET^XPAR(ENT,"ORWDX NEW PROCEDURE",1,"I")
 S IEN=+X,X0=$G(^ORD(101.41,IEN,0)),X5=$G(^(5))
 S TYP=$P(X0,U,4),DGRP=+$P(X0,U,5),ID=+$P(X5,U,5),TXT=$P(X5,U,4)
 S Y=IEN_";"_ID_";"_DGRP_";"_TYP_U_TXT
 Q
