HMPCAC ;SLC/AGP,ASMR/RRB - HMP CAC Tools;Nov 24, 2015 20:05:06
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**;Feb 06, 2014;Build 63
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
ASK(YESNO,PROMPT) ;
 N X,Y,TEXT
 K DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="YA0"
 S DIR("A")=PROMPT
 S DIR("B")="N"
 S DIR("?")="Enter Y or N. For detailed help type ??"
 W !
 D ^DIR K DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 S YESNO=$E(Y(0))
 Q
 ;
ADDSVR() ;
 N DEF,DIC,DLAYGO,SITE,SYS,Y
 S SITE=$$SITE^VASITE()
 S SYS=$$SYS^HMPUTILS()
 W !,"Station Number: "_$P(SITE,U,3)
 W !,"HMP System Identifier: "_SYS
 S DEF=$S($P($G(^HMP(800000,0)),U,4)=1:$P($G(^HMP(800000,1,0)),U),1:"") I DEF'="" S DIC("B")=DEF
 S DIC="^HMP(800000,",DIC(0)="AEMQL",DIC("A")="Select HMP server instance: ",DLAYGO=800000
 D ^DIC
 Q Y
 ;
 ;DE2818, documented code below
OPTASGN() ; called by Option: Add Health Management Platform User [HMPM ADD HMP USER]
 N ARGS,DIC,DLAYGO,FDA,HASOPT,HMPERR,HMPOPT,IEN,LIST,MSG,OPTNAME,PAT,RESULT,SVR,Y,YESNO
 S OPTNAME="HMP UI CONTEXT"
 S HMPOPT=$$FIND1^DIC(19,"","B",OPTNAME,,,"MSG") I HMPOPT'>0 W !,"Error: Could not find 'HMP UI CONTEXT' option." Q
 ;
 S Y=$$ADDSVR() I Y<0 Q
 S SVR=$P($G(^HMP(800000,+Y,0)),U)
 ;
 K DLAYGO
 S DIC="^VA(200,",DIC(0)="AEMQ",DIC("A")="Select user to provide access to HMP: "
 D ^DIC
 I Y<0 Q
 S IEN=+Y
 ;
 S HASOPT=$$ACCESS^XQCHK(IEN,HMPOPT)
 I +HASOPT>0 D  Q
 .W !,"User has 'HMP UI CONTEXT' already assigned." D ASK(.YESNO,"Sync user default CPRS patient list: ") I YESNO'="Y" Q
 .I $G(YESNO)="Y" D GETPATS(.RESULT,IEN,SVR)
 ;
 K YESNO
 D ASK(.YESNO,"Assign 'HMP UI CONTEXT': ")
 I YESNO'="Y" Q
 S FDA(200.03,"+2,"_IEN_",",.01)=HMPOPT
 D UPDATE^DIE("","FDA","","HMPERR")
 I $D(HMPERR) D  Q
 .D EN^DDIOL("Update failed, UPDATE^DIE returned the following error message.")
 .S IC="HMPERR"
 .F  S IC=$Q(@IC) Q:IC=""  W !,IC,"=",@IC
 D GETPATS(.RESULT,IEN,SVR)
 Q
 ;
GETPATS(RESULT,IEN,SRV) ;
 N ARGS,LIST,PAT
 D GETDFLST(.LIST,IEN)
 I '$D(LIST) W !,"No default patient list found." Q
 S ARGS("command")="putPtSubscription"
 S ARGS("server")=SRV
 S PAT=0 F  S PAT=$O(LIST(PAT)) Q:PAT'>0  D
 .;check to see if patient is already sync for the server.
 .I $G(^HMP(800000,"AITEM",PAT,SRV))>0 W !,"Patient "_PAT_" already synced." Q
 .S ARGS("localId")=PAT
 .W !,"Starting sync on patient: "_PAT
 .D API^HMPDJFS(.RESULT,.ARGS)
 Q
 ;
 ;
BLDLIST(LIST,HMPY) ;
 N I,CNT,NODE
 S I=0 F  S I=$O(HMPY(I)) Q:I'>0  D
 .S NODE=$G(HMPY(I)) I +NODE'>0 Q
 .;S CNT=$O(HMPY(I),-1)+1
 .S LIST(+$P(NODE,U))=""
 Q
 ;
 ;
 ;The appointment list date range is designed to query for full dates, 
 ;so when the search result exceeds 200 appointments, 
 ;the display will end with the last appointment of the last day before the maximum was reached. 
CLINPTS2(Y,USER,CLIN,BDATE,EDATE) ; WRAPPER FUNCTION FOR USE BY RPC CALL ORQPT CLINIC PATIENTS
 N MAXAPPTS,APPTBGN,APPTEND,NUMAPPTS
 S MAXAPPTS=200 I BDATE=EDATE S MAXAPPTS=0  ; if we only want one day, don't limit answer.
 D CLINPTS(.Y,USER,CLIN,BDATE,EDATE,MAXAPPTS,.APPTBGN,.APPTEND)
 S NUMAPPTS=$O(Y(""),-1)
 I MAXAPPTS,NUMAPPTS'<MAXAPPTS D
 . N ORI
 . S ORI=0 S APPTEND=$P(APPTEND,".")
 . F  S ORI=$O(Y(ORI)) Q:'ORI  D  ;erase last day's appts since we assume it to be partial
 .. I APPTEND<$P(Y(ORI),U,4) K Y(ORI) S NUMAPPTS=NUMAPPTS-1 ;erase an appointment
 . S Y(MAXAPPTS+1)="^ *** UNABLE TO SHOW ALL APPOINTMENTS ***"
 . S Y(MAXAPPTS+2)="^ Showing the first "_NUMAPPTS_" appointments from "_$$FMTE^XLFDT(APPTBGN,"D")_" to "_$$FMTE^XLFDT(APPTEND-1,"D")
 . S Y(MAXAPPTS+3)="^"_$C(160)_" Modify the appointment list date range to start on "_$$FMTE^XLFDT(APPTEND,"D")_" to see additional appointments." ;add blank line
 . S Y(MAXAPPTS+4)="^"_$C(160)_$C(160) ;add blank line
 ;
 Q  ; DE2818, added QUIT here to prevent code falling through
 ;
CLINPTS(Y,USER,CLIN,BDATE,EDATE,MAXAPPTS,APPTBGN,APPTEND) ; RETURN LIST OF PTS W/CLINIC APPT W/IN BEGINNING AND END DATES
 ; PKS-8/2003: Modified for new scheduling pkg APIs.
 I $G(CLIN)<1 S Y(1)="^No clinic identified" Q 
 I $$ACTLOC^ORWU(CLIN)'=1 S Y(1)="^Clinic is inactive or Occasion Of Service" Q
 N ORSRV,ORRESULT,ORERR,ORI,ORPT,ORPTSTAT,ORAPPT,ORCLIN,SDARRAY,NODE
 I $L($G(MAXAPPTS))=0 S MAXAPPTS=200
 S ORSRV=$G(^VA(200,USER,5)) I +ORSRV>0 S ORSRV=$P(ORSRV,U)
 I BDATE="" S BDATE=$$UP^XLFSTR($$GET^XPAR("USR^SRV.`"_+$G(ORSRV)_"^DIV^SYS^PKG","ORLP DEFAULT CLINIC START DATE",1,"E"))
 I EDATE="" S EDATE=$$UP^XLFSTR($$GET^XPAR("USR^SRV.`"_+$G(ORSRV)_"^DIV^SYS^PKG","ORLP DEFAULT CLINIC STOP DATE",1,"E"))
 ;
 ; Convert BDATE, EDATE to FM Date/Time:
 D DT^DILF("T",BDATE,.BDATE,"","")
 D DT^DILF("T",EDATE,.EDATE,"","")
 I (BDATE=-1)!(EDATE=-1) S Y(1)="^Error in date range." Q 
 S EDATE=$P(EDATE,".")_.5 ; Add 1/2 day to end date.
 ;
 K ^TMP($J,"SDAMA301") ; clear residual data
 S ORRESULT=""
 S ORCLIN=+CLIN
 S SDARRAY(1)=BDATE_";"_EDATE
 S SDARRAY(2)=+CLIN
 S SDARRAY(3)="R;I;NT"
 S SDARRAY("SORT")="P" ;no clinic index
 S SDARRAY("FLDS")="3;4"  ;ApptStatus^IEN;PtName
 I MAXAPPTS S SDARRAY("MAX")=MAXAPPTS
 ;
 S ORRESULT=$$SDAPI^SDAMA301(.SDARRAY) ; DBIA 4433
 ;
 ; Deal with server errors:
 I ORRESULT<0 D  S Y(1)=U_ORERR Q
 .S ORERR=""
 .N IDXERR S IDXERR=$O(^TMP($J,"SDAMA301","")) Q:IDXERR'>0
 .S ORERR=^TMP($J,"SDAMA301",IDXERR)
 ;
 ; add ^TMP results to local array
 S (ORPT,ORI)=0
 I ORRESULT'>0 S Y(1)="^No appointments." Q
 F  S ORPT=$O(^TMP($J,"SDAMA301",ORPT)) Q:ORPT=""  D
 .S ORAPPT=""
 .F  S ORAPPT=$O(^TMP($J,"SDAMA301",ORPT,ORAPPT)) Q:ORAPPT=""  D
 ..S ORI=ORI+1
 ..S NODE=^TMP($J,"SDAMA301",ORPT,ORAPPT)
 ..S Y(ORI)=$TR($P(NODE,U,4),";","^") ; IEN^Name.
 ..S Y(ORI)=Y(ORI)_U_ORCLIN ; ^Clinic IEN.
 ..S Y(ORI)=Y(ORI)_U_ORAPPT ; App't.
 ..I $L($G(APPTEND))=0 S APPTEND=ORAPPT,APPTBGN=ORAPPT
 ..I ORAPPT>APPTEND S APPTEND=ORAPPT
 ..I ORAPPT<APPTBGN S APPTBGN=ORAPPT
 ..S ORPTSTAT=$P($P(NODE,U,3),";",1) ;appt status, will be transformed to pt status.
 ..S ORPTSTAT=$S(ORPTSTAT="I":"IPT",ORPTSTAT="R":"OPT",ORPTSTAT="NT":"OPT",1:"") ; Pt Status.
 ..S Y(ORI)=Y(ORI)_U_U_U_U_U_ORPTSTAT ; Pt I or O status (or "NT").
 K ^TMP($J,"SDAMA301") ; Clean house after finishing.
 ;
 Q
 ;
COMBPTS(LIST,USER,PTR,BDATE,EDATE) ;
 N FILE,MAXAPPTS,MSG,PTR,RTN,SRC,TXT,HMPERR,HMPY
 ;
 ; Do preliminary settings, cleanup, look for an existing user record:
 S MSG=""                                       ; Default.
 S MAXAPPTS=$S(BDATE=EDATE:0,1:200)         ; If date range is only one day then no max, otherwise 200
 S RTN=$$FIND1^DIC(100.24,"","QX",USER,"","","HMPERR")
 K HMPERR
 D CLEAN^DILF ; Clean up after DB call.
 ;
 ; If no combination record, then punt:
 I +RTN<1 S MSG="No combination entry." Q
 ;
 ;
 ; Order through the user's combination source entries:
 S SORT="A" ; Required variable for PTSCOMBO^ORQPTQ5.
 S SRC=0
 ;DE2818, ^OR(100.24) - ICR 6283
 F  S SRC=$O(^OR(100.24,RTN,.01,SRC)) Q:'SRC  D
 .K ORY  ; Clean up each time.
 .S TXT=$G(^OR(100.24,RTN,.01,SRC,0))  ; Get record's value.
 .;
 .; In case of error, punt:
 .I TXT="" S MSG="Combination source entry error." Q
 .S PTR=$P(TXT,";")                       ; Get pointer.
 .S FILE="^"_$P(TXT,";",2)                ; Get file.
 .;
 .; Get info for each source entry and build HMPY array accordingly.
 .I FILE="^DIC(42," D  Q  ; Wards
 ..D WARDPTS^ORQPTQ2(.HMPY,PTR)
 ..I $D(HMPY) D BLDLIST(.LIST,.HMPY)
 .I FILE="^VA(200," D  Q  ; Providers
 ..D PROVPTS^ORQPTQ2(.HMPY,PTR)
 ..I $D(HMPY) D BLDLIST(.LIST,.HMPY)
 .I FILE="^DIC(45.7," D  Q  ; Specialties
 ..D SPECPTS^ORQPTQ2(.HMPY,PTR)
 ..I $D(HMPY) D BLDLIST(.LIST,.HMPY)
 .I FILE="^OR(100.21," D  Q  ; Team Lists
 ..D TEAMPTS^ORQPTQ1(.HMPY,PTR)
 ..I $D(HMPY) D BLDLIST(.LIST,.HMPY)
 .I FILE="^SC(" D  Q  ; Clinics
 ..N APPTBGN,APPTEND S (APPTBGN,APPTEND)=""
 ..D CLINPTS^ORQPTQ2(.HMPY,PTR,BDATE,EDATE,MAXAPPTS,.APPTBGN,.APPTEND)
 ..I $D(HMPY) D BLDLIST(.LIST,.HMPY)
 ;
 Q
 ;
GETDFLST(LIST,USER) ;
 N API,BEG,END,IEN,SRC,SRV,HMPSRC,HMPY,X
 S SRV=$G(^VA(200,USER,5)) I +SRV>0 S SRV=$P(SRV,U)
 S SRC=$$GET^XPAR("USR.`"_USER_"^SRV.`"_+$G(SRV),"ORLP DEFAULT LIST SOURCE",1,"Q")
 ;
 I SRC="T" S IEN=$$GET^XPAR("USR.`"_USER_"^SRV.`"_+$G(SRV),"ORLP DEFAULT TEAM",1,"Q") D:+$G(IEN)>0 TEAMPTS^ORQPTQ1(.HMPY,IEN)
 I SRC="W" S IEN=$$GET^XPAR("USR.`"_USER_"^SRV.`"_+$G(SRV),"ORLP DEFAULT WARD",1,"Q") D:+$G(IEN)>0 BYWARD^ORWPT(.HMPY,IEN)
 I SRC="P" S IEN=$$GET^XPAR("USR.`"_USER_"^SRV.`"_+$G(SRV),"ORLP DEFAULT PROVIDER",1,"Q") D:+$G(IEN)>0 PROVPTS^ORQPTQ2(.HMPY,IEN)
 I SRC="S" S IEN=$$GET^XPAR("USR.`"_USER_"^SRV.`"_+$G(SRV),"ORLP DEFAULT SPECIALTY",1,"Q") D:+$G(IEN)>0 SPECPTS^ORQPTQ2(.HMPY,IEN)
 I SRC'="C",SRC'="M" D BLDLIST(.LIST,.HMPY) Q
 ;
 I SRC="C" D  Q
 .F X="Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday" D
 ..S API="ORLP DEFAULT CLINIC "_$$UP^XLFSTR(X),IEN=$$GET^XPAR("USR.`"_USER_"^SRV.`"_+$G(SRV),API,1,"Q") I +$G(IEN)>0 D
 ...S BEG=$$UP^XLFSTR($$GET^XPAR("USR.`"_USER_"^SRV.`"_+$G(SRV)_"^DIV^SYS^PKG","ORLP DEFAULT CLINIC START DATE",1,"E"))
 ...I BEG="T+0" S BEG=$$FMTE^XLFDT(DT,BEG)
 ...S END=$$UP^XLFSTR($$GET^XPAR("USR.`"_USER_"^SRV.`"_+$G(SRV)_"^DIV^SYS^PKG","ORLP DEFAULT CLINIC STOP DATE",1,"E"))
 ...I END="T+0" S END=$$FMTE^XLFDT(DT,END)
 ...D CLINPTS2(.HMPY,USER,+$G(IEN),BEG,END)
 ...D BLDLIST(.LIST,.HMPY)
 I SRC="M" D  Q  ;DE2818, ^OR(100.24) - ICR 6283
 .S IEN=$D(^OR(100.24,USER,0)) I +$G(IEN)>0 S IEN=USER D
 ..S BEG=$$UP^XLFSTR($$GET^XPAR("USR.`"_USER_"^SRV.`"_+$G(SRV)_"^DIV^SYS^PKG","ORLP DEFAULT CLINIC START DATE",1,"E"))
 ..I BEG="T+0" S BEG=$$FMTE^XLFDT(DT,BEG)
 ..S END=$$UP^XLFSTR($$GET^XPAR("USR.`"_USER_"^SRV.`"_+$G(SRV)_"^DIV^SYS^PKG","ORLP DEFAULT CLINIC STOP DATE",1,"E"))
 ..I END="T+0" S END=$$FMTE^XLFDT(DT,END)
 ..D COMBPTS(.LIST,USER,+$G(IEN),BEG,END) ; "0"= GUI RPC call.
 Q
 ;
 ;
 ;REMOPT(IEN,OPT) ;
 ;Q
 ;
