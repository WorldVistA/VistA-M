PXUTLSCC ;ISL/dee,ISA/KWP - Validates and corrects the Service Connected Conditions ;6/06/05
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**74,107,111,130,168**;Aug 12, 1996;Build 14
 Q
 ;
SCC(PXUPAT,PXUDT,PXUHLOC,PXUTLVST,PXUIN,PXUOUT,PXUERR) ;
 ;+Input Parameters:
 ;+  PXUPAT   IEN of patient
 ;+  PXUDT    date and time of the encounter
 ;+  PXUHLOC  Hospital Location of the enocunter
 ;+  PXUTLVST (optional) pointer to the visit that is being used
 ;+  PXUIN    service connected^agent orange^ionizing radiation
 ;+             ^enviromental contaminants^military sexual trauma
 ;+             ^head and/or neck cancer
 ;+           where 1 ::= yes, 0 ::= no, null ::= n/a
 ;+
 ;+Output Parameters:
 ;+  PXUOUT  this is PXUIN corrected so that the invalid answers
 ;+          are changed to null
 ;+  PXUERR  this is a six piece value one for each condition as follows:
 ;+      1   ::= should be yes or no, but it is null
 ;+      0   ::= no error
 ;+     -1   ::= not valued value
 ;+     -2   ::= value must be null
 ;+     -3   ::= must be null because SC is yes
 ;
 N PXUITEM,PXUPSCC,PXUSC,PXUAO,PXUIR,PXUEC,PXUMST,PXUHNC,PXUSHAD
 D SCCOND(PXUPAT,PXUDT,PXUHLOC,$G(PXUTLVST),.PXUPSCC) ;Set up array of the patients SCC
 S PXUOUT=PXUIN
 S PXUERR="0^0^0^0^0^0^0^0"
 S PXUSC=$P(PXUIN,"^",1)
 I '(PXUSC=1!(PXUSC=0)!(PXUSC="")) S $P(PXUERR,"^",1)=-1 S $P(PXUOUT,"^",1)=""
 E  I PXUSC="" D  ;it is ok
 . I $P(PXUPSCC("SC"),"^",1) S $P(PXUERR,"^",1)=1,$P(PXUOUT,"^",1)=$P(PXUPSCC("SC"),"^",2) ;should have had a value
 E  I PXUSC]"" D
 . I '$P(PXUPSCC("SC"),"^",1) S $P(PXUERR,"^",1)=-2 S $P(PXUOUT,"^",1)="" ;it must be null
 . E  ;it is ok
 S PXUSC=$P(PXUOUT,"^",1)
 S PXUAO=$P(PXUIN,"^",2)
 I '(PXUAO=1!(PXUAO=0)!(PXUAO="")) S $P(PXUERR,"^",2)=-1 S $P(PXUOUT,"^",2)=""
 E  I PXUAO="" D  ;it is ok
 . I $P(PXUPSCC("AO"),"^",1),'PXUSC S $P(PXUERR,"^",2)=1,$P(PXUOUT,"^",2)=$P(PXUPSCC("AO"),"^",2) ;should have had a value
 E  I PXUAO]"" D
 . I '$P(PXUPSCC("AO"),"^",1) S $P(PXUERR,"^",2)=-2 S $P(PXUOUT,"^",2)="" ;it must be null
 . E  I PXUSC,PXUAO]"" S $P(PXUERR,"^",2)=-3 S $P(PXUOUT,"^",2)="" ;it is SC so it must be null
 . ;E  ;it is ok
 S PXUIR=$P(PXUIN,"^",3)
 I '(PXUIR=1!(PXUIR=0)!(PXUIR="")) S $P(PXUERR,"^",3)=-1 S $P(PXUOUT,"^",3)=""
 E  I PXUIR="" D  ;it is ok
 . I $P(PXUPSCC("IR"),"^",1),'PXUSC S $P(PXUERR,"^",3)=1,$P(PXUOUT,"^",3)=$P(PXUPSCC("IR"),"^",2) ;should have had a value
 E  I PXUIR]"" D
 . I '$P(PXUPSCC("IR"),"^",1) S $P(PXUERR,"^",3)=-2 S $P(PXUOUT,"^",3)="" ;it must be null
 . E  I PXUSC,PXUIR]"" S $P(PXUERR,"^",3)=-3 S $P(PXUOUT,"^",3)="" ;it is SC so it must be null
 . ;E  ;it is ok
 S PXUEC=$P(PXUIN,"^",4)
 I '(PXUEC=1!(PXUEC=0)!(PXUEC="")) S $P(PXUERR,"^",4)=-1 S $P(PXUOUT,"^",4)=""
 E  I PXUEC="" D  ;it is ok
 . I $P(PXUPSCC("EC"),"^",1),'PXUSC S $P(PXUERR,"^",4)=1,$P(PXUOUT,"^",4)=$P(PXUPSCC("EC"),"^",2) ;should have had a value
 E  I PXUEC]"" D
 . I '$P(PXUPSCC("EC"),"^",1) S $P(PXUERR,"^",4)=-2 S $P(PXUOUT,"^",4)="" ;it must be null
 . E  I PXUSC,PXUEC]"" S $P(PXUERR,"^",4)=-3 S $P(PXUOUT,"^",4)="" ;it is SC so it must be null
 . ;E  ;it is ok
 S PXUMST=$P(PXUIN,"^",5) ;MST not dependent on SC question
 I '(PXUMST=1!(PXUMST=0)!(PXUMST="")) S $P(PXUERR,"^",5)=-1 S $P(PXUOUT,"^",5)="" ;not valid data
 E  I PXUMST="" D  ;it is ok
 . I $P(PXUPSCC("MST"),"^",1) S $P(PXUERR,"^",5)=1,$P(PXUOUT,"^",5)=$P(PXUPSCC("MST"),"^",2) ;should have had a value
 E  I PXUMST]"" D
 .I '$P(PXUPSCC("MST"),"^",1) S $P(PXUERR,"^",5)=-2 S $P(PXUOUT,"^",5)="" ;it must be null, not MST status
 ;PX*1*111 - Add Head & Neck
 S PXUHNC=$P(PXUIN,"^",6) ;HNC not dependent on SC question
 I '(PXUHNC=1!(PXUHNC=0)!(PXUHNC="")) S $P(PXUERR,"^",6)=-1 S $P(PXUOUT,"^",6)="" ;not valid data
 E  I PXUHNC="" D  ;it is ok
 . I $P(PXUPSCC("HNC"),"^",1) S $P(PXUERR,"^",6)=1,$P(PXUOUT,"^",6)=$P(PXUPSCC("HNC"),"^",2) ;should have had a value
 E  I PXUHNC]"" D
 .I '$P(PXUPSCC("HNC"),"^",1) S $P(PXUERR,"^",6)=-2 S $P(PXUOUT,"^",6)="" ;it must be null, not HNC status
 S PXUCV=$P(PXUIN,"^",7) ;CV not dependent on SC question
 I '(PXUCV=1!(PXUCV=0)!(PXUCV="")) S $P(PXUERR,"^",7)=-1 S $P(PXUOUT,"^",7)="" ;not valid data
 E  I PXUCV="" D  ;it is ok
 . I $P(PXUPSCC("CV"),"^",1) S $P(PXUERR,"^",7)=1,$P(PXUOUT,"^",7)=$P(PXUPSCC("CV"),"^",2) ;should have had a value
 E  I PXUCV]"" D
 .I '$P(PXUPSCC("CV"),"^",1) S $P(PXUERR,"^",7)=-2 S $P(PXUOUT,"^",7)="" ;it must be null, not CV status
 S PXUSHAD=$P(PXUIN,"^",8) ;SHAD not dependent on SC question
 I '(PXUSHAD=1!(PXUSHAD=0)!(PXUSHAD="")) S $P(PXUERR,"^",8)=-1 S $P(PXUOUT,"^",8)="" ;not valid data
 E  I PXUSHAD="" D  ;it is ok
 . I $P(PXUPSCC("SHAD"),"^",1) S $P(PXUERR,"^",8)=1,$P(PXUOUT,"^",8)=$P(PXUPSCC("SHAD"),"^",2) ;should have had a value
 E  I PXUSHAD]"" D
 .I '$P(PXUPSCC("SHAD"),"^",1) S $P(PXUERR,"^",8)=-2 S $P(PXUOUT,"^",8)="" ;it must be null, not SHAD status
 Q
 ;
 ;
SCCOND(DFN,APPDT,HLOC,VISIT,PXUDATA) ;Set up array of the patients
 ;  Service Connected Conditions
 ;
 ;Input Parameters:
 ;  DFN      IEN of patient
 ;  APPDT    date and time of the encounter
 ;  HLOC     Hospital Location of the enocunter
 ;  VISIT    (optional) The visit that is being used
 ;
 ;Output Parameters:
 ;  PXUDATA  this is an array subscriped by "SC","AO","IR","EC","MST","HNC"
 ;           that contains to piece each
 ;    first: 1 if the condition can be answered
 ;           0 if it should be null
 ;   second: the answer that Scheduling has if it has one
 ;           1 ::= yes,  0 ::= no
 ;
 N CLASSIF,XX,OUTENC,CL,END,X0,MNE
 S OUTENC=""
 I VISIT>0 D
 .S OUTENC=$O(^SCE("AVSIT",VISIT,0))
 .I OUTENC>0,$P(^SCE(OUTENC,0),U,6) S OUTENC=$P(^SCE(OUTENC,0),U,6)
 I 'VISIT D
 .; Call if they have an appointment for this hospital location
 .; and there is an Outpatient Encounter IEN;
 .; returns the answer that scheduling has if any
 .I $G(^DPT(DFN,"S",APPDT,0))]"" S XX=$G(^(0)) I +XX=HLOC D
 ..S OUTENC=$P(XX,U,20)
 .Q:OUTENC
 .;
 .; Find an Outpatient encouter matching DFN APPDT,HLOC if any.
 .S OUTENC=$$EXAE^SDOE(DFN,APPDT,APPDT) D VEROUT
 ;
 ;Do Outpatient Encounter checks
 I OUTENC D
 .I '$D(^SCE(OUTENC,0)) S OUTENC="" Q
 .S X0=^SCE(OUTENC,0),END=0 D ENCHK(OUTENC,X0)
 .I END S OUTENC=""
 I OUTENC>0 D CLOE^SDCO21(OUTENC,.CLASSIF)
 ;
 I '$G(OUTENC) D CL^SDCO21(DFN,APPDT,"",.CLASSIF)
 S XX=0
 F  S XX=$O(^SD(409.41,XX)) Q:XX'>0  D
 .S MNE=$P($G(^SD(409.41,XX,0)),U,7) I $D(MNE) D
 ..S PXUDATA(MNE)=$D(CLASSIF(XX))_U_$P($G(CLASSIF(XX)),U,2)
 Q
ENCHK(ENCOWNTR,X0) ;Do outpatient encounter checks
 N LOC,ORG,DFN
 S DFN=$P(X0,U,2),LOC=$P(X0,U,4),ORG=$P(X0,U,8)
 I $$REQ^SDM1A(+X0)'="CO" S END=1 Q  ;Check MAS Check out date parameter
 I ORG=1,'$$CLINIC^SDAMU(+LOC) S END=1 Q  ;Screen for valid clinic
 I "^1^2^"[("^"_ORG_"^"),$$INP^SDAM2(+DFN,+X0)="I" S END=1 Q  ;Inpat chk
 I $$EXOE^SDCOU2(ENCOWNTR) S END=1 Q  ;Chk exempt Outpt classification
 Q
VEROUT ;verify a clinic
 Q:'OUTENC
 S CL=$$GETOE^SDOE(OUTENC) I $P(CL,U,4)'=HLOC S OUTENC=""
 Q
 ;
