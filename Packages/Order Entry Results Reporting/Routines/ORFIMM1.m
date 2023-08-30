ORFIMM1 ;SLC/AGP - GENERIC EDIT IMMUNIZATION CONT ;Jan 18, 2023@15:00:42
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**405,597**;Dec 17, 1997;Build 3
 ;
 ; Reference to IMMGRP^PXAPIIM in ICR #6387
 ; Reference to IMMROUTE^PXVRPC2 in ICR #7283
 ; Reference to GETUNITS^PXVRPC4 in ICR #7284
 ; Reference to ARTAPI^PXVUTIL in ICR #7398
 ;
 Q
 ;
BLD(RESULTS,LIST,INPUTS) ;
 N ADMINDATE,CAT,CNT,DATE,EXT,HASERR,ID,IDX,IMNAME,INT,MSG,NAME,NODE,NOTEARR,NOTEINP,PARM,PARR,PRMPTS,VIS,VISCNT
 N PIECE,X,DELSTR,DELSTR1,DELSTR2,DELSTR3
 N LOC,DATETIME,ENCTYPE,TYPE,VISITSTR,ORLOT
 ;
 S ID=$G(INPUTS("ID")),IMNAME=$G(INPUTS("NAME"))
 S TYPE=$G(INPUTS("DOCUMENTTYPE"))
 S VISITSTR=$G(INPUTS("VISITSTR"))
 S LOC=$P(VISITSTR,";"),DATETIME=$P(VISITSTR,";",2),ENCTYPE=$P(VISITSTR,";",3)
 ;
 S DELSTR=$S(TYPE=2:"ICR+"_U_U_U_U,TYPE=3:"ICR+"_U_U_U_U,1:"IMM+"_U_ID_U_U_IMNAME)
 S DELSTR1="COM"_U_1_U_"@",$P(DELSTR,U,$S(TYPE=5:29,1:10))=1
 I TYPE'=5 S DELSTR2="COM"_U_2_U_"@",$P(DELSTR,U,24)=2
 S HASERR=0,CNT=0
 ;
 D BLDPRMPT^ORFEDT(.PRMPTS)
 D BLDPARR^ORFEDT(.PARR)
 ;
 S VISCNT=0,VIS=""
 S IDX=0 F  S IDX=$O(LIST(IDX)) Q:IDX'>0!(HASERR=1)  D
 .S NODE=LIST(IDX)
 .S NAME=$P(NODE,U),INT=$P(NODE,U,2),EXT=$P(NODE,U,3)
 .S PARM=$G(PARR(NAME))
 .I PARM?1(1"pnumComment",1"pnumImmOverride"),$L(NODE,"^")>3 D  Q
 ..S RESULTS(CNT)="-1^"_$S(PARM="pnumImmOverride":"Override Reason",1:"Comment")_" cannot contain a caret symbol"
 ..S HASERR=1
 .I PARM="pnumIMMVIS" D  Q
 ..I VIS="" S VIS=INT_"/"_$P(ADMINDATE,".") Q
 ..I VIS'="" S VIS=VIS_";"_INT_"/"_$P(ADMINDATE,".")
 .;
 .I PARM="pnumAdminDate" D  Q
 ..S PIECE=+$G(PRMPTS(PARM))
 ..I INT>$$GETMAXDT() D  Q  ; don't allow future admin/read times (unless over the dateline, allow up to T+1@23:59)
 ...S RESULTS(CNT)="-1^"_$S(TYPE=5:"Read",1:"Administration")_" Date"_$S(TYPE=1:"",1:"/Time")_" cannot be a future date"_$S(TYPE=1:"",1:"/Time")_"."
 ...S HASERR=1
 ..S ADMINDATE=INT
 ..S $P(DELSTR,U,$S(TYPE=5:27,1:PIECE))=INT
 .;
 .I PARM="pnumImmLot" D
 ..I TYPE=1 S INT=""
 ..I TYPE=0 S ORLOT=INT
 .I PARM="" Q
 .S PIECE=+$G(PRMPTS(PARM)) I PIECE=0 Q
 .D BLDSTRS(.RESULTS,.CNT,PARM,TYPE,EXT,INT,PIECE,ID,IMNAME,LOC,.DELSTR,.DELSTR1,.DELSTR2,.MSG)
 .I $P($G(RESULTS(CNT)),U)=-1 S HASERR=1
 ;
 I TYPE=0,$G(ORLOT)="",'HASERR D
 .S RESULTS(CNT)="-1^Lot Number is required."
 .S HASERR=1
 ;
 I HASERR=1 Q
 S CNT=0
 S $P(DELSTR,U,PRMPTS("pnumIMMVIS"))=VIS
 I TYPE=0 S $P(DELSTR,U,12)="00"
 S RESULTS(CNT)=1_U_$S(+$G(ADMINDATE)>0:ADMINDATE,1:DATETIME)
 D GETTEXT(.NOTEARR,.LIST,ID,IMNAME,TYPE,DATETIME,LOC,0)
 ;
 S IDX=0 F  S IDX=$O(NOTEARR(IDX)) Q:IDX'>0  S CNT=CNT+1,RESULTS(CNT)="NOTE"_U_NOTEARR(IDX)
 S CNT=CNT+1,RESULTS(CNT)="DATA"_U_DELSTR
 S CNT=CNT+1,RESULTS(CNT)="DATA1"_U_$G(DELSTR1)
 S CNT=CNT+1,RESULTS(CNT)="DATA2"_U_$G(DELSTR2)
 S IDX=0 F  S IDX=$O(MSG(IDX)) Q:IDX'>0  S CNT=CNT+1,RESULTS(CNT)="MSG"_U_MSG(IDX)
 Q
 ;
BLDSTRS(RESULT,CNT,PARM,TYPE,EXT,INT,PIECE,ID,NAME,LOC,DELSTR,DELSTR1,DELSTR2,MSG) ;
 N IDX,TEMP
 I PARM?1(1"pnumAdminByPolicy",1"pnumImmOrderByIEN",1"pnumImmSite",1"pnumImmSeries",1"pnumWarnDate") D
 . I INT="" S INT="@"
 I PARM="pnumDataSource" S $P(DELSTR,U,PIECE)=EXT_";"_INT Q
 I PARM="pnumImmDosage" D DOSECHK(.RESULT,.CNT,.DELSTR,INT,ID,LOC,PIECE) Q
 I PARM="pnumImmRoute" S $P(DELSTR,U,PIECE)=EXT_";;"_INT Q
 I PARM="pnumImmSite" D  Q
 .D CHK^DIE(9000010.11,1303,,$$TRIM^XLFSTR(EXT),.TEMP)
 .I TEMP="^",(EXT'=""!(INT=-1)),INT'="@" S RESULT(CNT)="-1^Anatomic Location is not a valid selection" Q
 .S $P(DELSTR,U,PIECE)=EXT_";;"_INT Q
 I PARM="pnumImmLot" S $P(DELSTR,U,PIECE)=EXT_";"_INT Q
 I PARM="pnumImmManufacturer" S $P(DELSTR,U,PIECE)=EXT Q
 I PARM="pnumExpirationDate" S $P(DELSTR,U,PIECE)=$S(EXT:$$FMTE^XLFDT(EXT,"2D"),1:EXT) Q
 I PARM="pnumImmOrderByIEN" D
 .S $P(DELSTR,U,PIECE)=INT
 .I INT=""!(INT="@") S $P(DELSTR,U,31)=1
 .I INT>0 S $P(DELSTR,U,31)="@"
 I PARM="pnumImmSeries" D  Q
 .S TEMP=$$EXTERNAL^DILFD(9000010.11,.04,,INT)
 .I TEMP="",(EXT'=""!(INT=-1)),INT'="@" S RESULT(CNT)="-1^Series is not a valid selection" Q
 .S $P(DELSTR,U,PIECE)=INT Q
 I PARM="pnumProvider" S $P(DELSTR,U,$S(TYPE=5:28,1:PIECE))=INT Q
 I PARM="pnumComment",EXT'="" D  Q
 .I $L(EXT)>245 S RESULT(CNT)="-1^Comment cannot exceed 245 characters" Q
 .S DELSTR1="COM"_U_1_U_EXT
 I PARM="pnumImmOverride",EXT'="" D  Q
 .I $L(EXT)>245 S RESULT(CNT)="-1^Override Reason cannot exceed 245 characters" Q
 .S $P(DELSTR,U,23)=1,DELSTR2="COM"_U_2_U_EXT
 I PARM="pnumDataSource" S $P(DELSTR,U,PIECE)=";"_INT Q
 I PARM="pnumImmContra" D  Q
 .S $P(DELSTR,U,2)=INT_";PXV(920.4,",$P(DELSTR,U,4)=EXT,$P(DELSTR,U,5)=ID_";"_NAME
 .I $$ARTAPI^PXVUTIL(INT)>0 D
 ..S IDX=$O(MSG(""),-1)
 ..I IDX>0 S IDX=IDX+1,MSG(IDX)=" "
 ..S IDX=IDX+1,MSG(IDX)="You are recording an allergy/adverse reaction contraindication reason. This"
 ..S IDX=IDX+1,MSG(IDX)="information should also be recorded in the Adverse Reaction Tracking package"
 ..S IDX=IDX+1,MSG(IDX)="if it is not already present there."
 I PARM="pnumWarnDate" D  Q
 .I +INT>0,INT<$$NOW^XLFDT() S RESULT(CNT)="-1^Choose reschedule date cannot be in the past."
 .S $P(DELSTR,U,PIECE)=INT
 I PARM="pnumImmRefused" S $P(DELSTR,U,2)=INT_";PXV(920.5,",$P(DELSTR,U,4)=EXT,$P(DELSTR,U,5)=ID_";"_NAME Q
 I PARM="pnumSkinResults" S $P(DELSTR,U,25)=INT Q
 I PARM="pnumSkinReading" S $P(DELSTR,U,26)=EXT Q
 I PARM="pnumReadingIEN" S $P(DELSTR,U,30)=INT Q
 I PARM="pnumRefusedGroup" S $P(DELSTR,U,9)=$S(INT=1:0,1:1)
 Q
 ;
DOSECHK(RESULT,CNT,DELSTR,INT,ID,LOC,PIECE) ;
 N TEMP
 I INT="" Q
 S INT=$$TRIM^XLFSTR(INT,"LR")
 ;check for any alpha characters
 I INT?.E1A.E S RESULT(CNT)="-1^Incorrect format for dose. Dose must be a number between 0 and 999, up to two fractional digits." Q
 ;check for any punctuation characters beside a period
 S TEMP=$TR(INT,".","") I TEMP?.E1P.E S RESULT(CNT)="-1^Incorrect format for dose. Dose must be a number between 0 and 999, up to two fractional digits." Q
 ;check for control characters
 I INT?.E1C.E S RESULT(CNT)="-1^Incorrect format for dose. Cannot contains a control character" Q
 I INT["." D  Q
 .S TEMP=$P(INT,".",2) I $L(TEMP)>2 S RESULT(CNT)="-1^Incorrect format for dose. Dose must be a number between 0 and 999, up to two fractional digits." Q
 .S TEMP=$P(INT,".") I (TEMP>999)!(TEMP<0) S RESULT(CNT)="-1^Incorrect format for dose. Dose must be a number between 0 and 999, up to two fractional digits." Q
 .S TEMP=$$GETUNITS^PXVRPC4(ID,LOC)
 .S $P(DELSTR,U,PIECE)=INT_";"_$P(TEMP,U,2)
 I (INT>999)!(INT<0) S RESULT(CNT)="-1^Incorrect format for dose. Dose must be a number between 0 and 999, up to two fractional digits." Q
 K TEMP S TEMP=$$GETUNITS^PXVRPC4(ID,LOC)
 S $P(DELSTR,U,PIECE)=INT_";"_$P(TEMP,U,2)
 Q
 ;
 ;
GETROUTE(RESULT,CNT,DEFAULT,LOCLIST) ;
 N DEF,DATALST,ISLOC,X
 S DEF=+$G(DEFAULT("ADMIN ROUTE"))
 D IMMROUTE^PXVRPC2(.DATALST,"S:A",1)
 S ISLOC=0
 S X=0 F  S X=$O(DATALST(X)) Q:X'>0  D
 .I DATALST(X)'[U Q
 .I DEF>0,+$P(DATALST(X),U)>0,DEF=+$P(DATALST(X),U) S ISLOC=1
 .I DEF>0,+$P(DATALST(X),U)>0,DEF'=+$P(DATALST(X),U) S ISLOC=0
 .I ISLOC,$P(DATALST(X),U)="SITE" S LOCLIST($P(DATALST(X),U,2))=""
 .S CNT=CNT+1,RESULT(CNT)="DATA"_U_"ADMIN ROUTE"_U_DATALST(X)
 Q
 ;
GETTEXT(OUTPUT,LIST,ID,IMMNAME,TYPE,DATETIME,LOC,FORMAT) ;
 ;scheduling ICR 10040
 N I,J,DIV,NODE,ORGRPS,TEMP,TEMPARR,XLOC,VISCNT
 I FORMAT=0 D BLDDEFLS^ORFEDT(.LIST,.TEMPARR)
 I FORMAT=1 M TEMPARR=LIST
 S I=0
 I TYPE=2!(TYPE=3) D  Q
 .D FORMAT(.OUTPUT,.I,IMMNAME,"Immunization: ")
 .I TYPE=2 D FORMAT(.OUTPUT,.I,$P(TEMPARR("CONTRAINDICATED"),U,2),"Contraindication/Precaution Reason: ")
 .I TYPE=3 S I=I+1,OUTPUT(I)="Refusal Reason: "_$P(TEMPARR("REFUSAL"),U,2)
 .I $P($G(TEMPARR("STOP")),U)=1 S I=I+1,OUTPUT(I)="Cancel Series and stop forecasting: Yes"
 .I $P($G(TEMPARR("WARN")),U,2)'="" S I=I+1,OUTPUT(I)="Warn Until: "_$TR($$FMTE^XLFDT($P(TEMPARR("WARN"),U,2),"2ZM"),"@"," ")
 .I TYPE=3,$P($G(TEMPARR("CVXONLY")),U)'="" D
 ..I +$P($G(TEMPARR("CVXONLY")),U)=0 D  Q
 ...D IMMGRP^PXAPIIM(.ORGRPS,ID)
 ...S TEMP=$O(ORGRPS("VG",""))
 ...D FORMAT(.OUTPUT,.I,$S(TEMP'="":"Patient refuses all immunization(s) in the "_TEMP_" group",1:"Patient refuses all immunization(s) in the group"))
 ..D FORMAT(.OUTPUT,.I,"Patient refuses the "_IMMNAME_" immunization")
 .I $P($G(TEMPARR("COMMENTS")),U,2)'="" D FORMAT(.OUTPUT,.I,$P(TEMPARR("COMMENTS"),U,2),"Comment: ")
 .S I=I+1,OUTPUT(I)="Date Documented: "_$TR($$FMTE^XLFDT($$NOW^XLFDT,"2ZM"),"@"," ")
 ;
 S TEMP=$S(TYPE=0:"Administered",TYPE=1:"Documented",TYPE=2:"Contraindicated/Precaution",TYPE=3:"Refusal",TYPE=5:"Read",1:"")
 D FORMAT(.OUTPUT,.I,IMMNAME,TEMP_": ")
 S TEMP=$S(TYPE=1:"Historical Date Administered",TYPE=5:"Date Read",1:"Date Administered")_": "
 I TYPE=1 D
 .S TEMP=TEMP_$$FMTE^XLFDT($P($G(TEMPARR("VISIT DATE TIME")),U,2),1)
 .I $E($P($G(TEMPARR("VISIT DATE TIME")),U,2),4,5)="00" S TEMP=TEMP_" Exact date unknown" Q
 .I $E($P($G(TEMPARR("VISIT DATE TIME")),U,2),6,7)="00" S TEMP=TEMP_" Exact date unknown" Q
 I TYPE'=1 S TEMP=TEMP_$TR($$FMTE^XLFDT($P($G(TEMPARR("VISIT DATE TIME")),U,2),1),"@"," ")
 ;determine label depending on admin vs historical
 S I=I+1,OUTPUT(I)=$$LJ^XLFSTR(TEMP,50)
 I $P($G(TEMPARR("SERIES")),U,2)'="" S OUTPUT(I)=OUTPUT(I)_$$LJ^XLFSTR("Series: "_$P(TEMPARR("SERIES"),U,2),50)
 I $P($G(TEMPARR("MANUFACTURER")),U,2)'="" D FORMAT(.OUTPUT,.I,$P(TEMPARR("MANUFACTURER"),U,2),"Manufacturer: ")
 S:$P($G(TEMPARR("LOT NUMBER")),U,2)'="" I=I+1,OUTPUT(I)=$$LJ^XLFSTR("Lot: "_$P(TEMPARR("LOT NUMBER"),U,2),50)_"Exp Date: "_$S($P($G(TEMPARR("EXPIRATION DATE")),U,2)'="":$$FMTE^XLFDT($P(TEMPARR("EXPIRATION DATE"),U,2),"1D"),1:"Unknown")
 S:$P($G(TEMPARR("LOT NUMBER")),U,7)'="" I=I+1,OUTPUT(I)=$$LJ^XLFSTR("NDC: "_$P(TEMPARR("LOT NUMBER"),U,7),50)
 ;
 ;determine label depending on admin vs historical
 I +LOC=LOC S LOC=$$GET1^DIQ(44,LOC,.01)
 S XLOC=""
 I TYPE=1 S TEMP="Outside Location: " S XLOC=$P(TEMPARR("LOCATION"),U,2)
 ;I TYPE=0 S TEMP="Location: ",XLOC=LOC
 S TEMP=TEMP_XLOC
 I XLOC'="" S I=I+1,OUTPUT(I)=$$LJ^XLFSTR(TEMP,60)
 ;
 S:$P($G(TEMPARR("ADMIN ROUTE")),U,2)'="" I=I+1,OUTPUT(I)="Admin Route/Site: "_$P(TEMPARR("ADMIN ROUTE"),U,2)_"/"_$P($G(TEMPARR("ADMIN SITE")),U,2)
 I $P($G(TEMPARR("DOSE")),U,2)'="" D
 .S DIV=$S(+$P($G(^SC(+LOC,0)),U,15)>0:+$P($G(^SC(+LOC,0)),U,15),1:DUZ(2))
 .S TEMP=$$GETUNITS^PXVRPC4(ID,DIV)
 .S I=I+1,OUTPUT(I)="Dosage: "_$P(TEMPARR("DOSE"),U,2)_$S($P(TEMP,U,2)'="":$P(TEMP,U,2),$P(TEMP,U,3)'="":$P(TEMP,U,3),1:"")
 S:$P($G(TEMPARR("INFO SOURCE")),U,2)'="" I=I+1,OUTPUT(I)="Information Source: "_$P(TEMPARR("INFO SOURCE"),U,2)
 ;
 I $D(TEMPARR("VIS OFFERED")) D
 .S I=I+1,OUTPUT(I)="Vaccine Information Statement(s):"
 .I $D(TEMPARR("VIS OFFERED"))=1 D FORMAT(.OUTPUT,.I,$P($P(TEMPARR("VIS OFFERED"),U,2),";"),"   ") Q
 .S VISCNT=0 F  S VISCNT=$O(TEMPARR("VIS OFFERED",VISCNT)) Q:VISCNT'>0  D
 ..D FORMAT(.OUTPUT,.I,$P($P(TEMPARR("VIS OFFERED",VISCNT),U,2),";"),"   ")
 I TYPE=0 S I=I+1,OUTPUT(I)="Order By: "_$S($P($G(TEMPARR("ORDERING PROVIDER")),U,2)'="":$P(TEMPARR("ORDERING PROVIDER"),U,2),1:"Policy")
 I $P($G(TEMPARR("ENCOUNTER PROVIDER")),U,2)'="" D
 .S I=I+1,OUTPUT(I)=$S(TYPE=5:"Read By:",TYPE=0:"Administered By: ",1:"Documented By: ")_$P(TEMPARR("ENCOUNTER PROVIDER"),U,2)
 I $P($G(TEMPARR("COMMENTS")),U,2)'="" D FORMAT(.OUTPUT,.I,$P(TEMPARR("COMMENTS"),U,2),"Comment: ")
 I $P($G(TEMPARR("OVERRIDE REASON")),U,2)'="" D FORMAT(.OUTPUT,.I,$P(TEMPARR("OVERRIDE REASON"),U,2),"Override Reason: ")
 I $P($G(TEMPARR("PLACEMENT IEN")),U,2)'="" S I=I+1,OUTPUT(I)="Measurements: "_$P($G(TEMPARR("READING")),U,2)
 I $P($G(TEMPARR("RESULTS")),U,2)'="" S I=I+1,OUTPUT(I)="Interpretation: "_$P($G(TEMPARR("RESULTS")),U,2)
 S I=I+1,OUTPUT(I)="   "
 Q
 ;
FORMAT(OROUTPUT,ORLINE,ORTEXT,ORTITLE) ;
 N DIWL,DIWR,DIWF,X,ORX,ORINDENT
 N I,J,TEMP,TEMPARR
 K ^UTILITY($J,"W")
 S DIWL=1
 S DIWR=80
 S DIWF="|"
 I $G(ORTITLE)'="" D
 . S ORINDENT=$L(ORTITLE)
 . S DIWF=DIWF_"I"_ORINDENT
 S X=$G(ORTEXT)
 D ^DIWP
 ;
 S ORX=0
 F  S ORX=$O(^UTILITY($J,"W",1,ORX)) Q:'ORX  D
 . S ORLINE=ORLINE+1
 . S ORTEXT=$G(^UTILITY($J,"W",1,ORX,0))
 . I $G(ORINDENT) D
 . . S ORTEXT=ORTITLE_$E(ORTEXT,ORINDENT+1,999)
 . . S ORINDENT=0
 . S OROUTPUT(ORLINE)=ORTEXT
 ;
 K ^UTILITY($J,"W")
 Q
 ;
GETMAXDT() ; Get the Max date/time for the admin/read date/time fields
 N OROVERDL,ORMAXDT
 ;
 S OROVERDL=0
 D OVERDL^ORWU(.OROVERDL)  ; get value of ORPARAM OVER DATELINE
 ;
 S ORMAXDT=$$NOW^XLFDT()
 I OROVERDL S ORMAXDT=$$FMADD^XLFDT($$DT^XLFDT,1,23,59)
 Q ORMAXDT
