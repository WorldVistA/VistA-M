DGRRLU0 ;alb/GAH - DG Replacement and Rehosting RPC for VADPT ;10/10/05  09:53
 ;;5.3;Registration;**538,725**;Aug 13, 1993;Build 12
 ;
 SET X="You Can't Enter DGRRLU0 at top of routine!"
 QUIT
 ;
BYFILTER(FILTER,FILTERV,BDATE,EDATE,SEARCH,VALUE,DELIM) ; -- search type by clinic, provider, or ward.
 NEW PCNT,OKAY,VAL
 K ^TMP("DGPTLKUP",$J)
 SET (OKAY,PCNT)=0
 ;
 DO ADD^DGRRUTL("<record count='0'>")
 SET LINENO=DGRRLINE
 FOR I=1:1 S VAL=$P(FILTERV,DELIM,I) QUIT:VAL=""  DO  Q:$$STOP^XOBVLIB()
 . IF FILTER="WARD" DO WARDPTS(VAL) S OKAY=1 Q
 . IF FILTER="CLINIC" DO CLINPTS(VAL,BDATE,EDATE) S OKAY=2 Q
 . IF FILTER="PROVIDER" D PROVPTS(VAL) S OKAY=3 Q
 . IF FILTER="SPECIALTY" D SPECPTS(VAL) S OKAY=4 Q
 ;
 IF OKAY<1 DO ADD^DGRRUTL("<error message='Filter not correctly specified'></error>")
 ;
 ; -- update the record count
 DO ADDPTS()
 SET @DGRRESLT@(LINENO)="<record count='"_PCNT_"'>"
 IF ($G(MAXSIZRE)<1) DO ADD^DGRRUTL("<maximum message=''></maximum>")
 DO ADD^DGRRUTL("<error message=''></error>")
 QUIT
 ;
FILTCHK(DFN,TYPE,VALUE) ; -- Filter search -
 ; -- check patients to match search type and search value for filter searches
 ; -- returns 1 if matches, 0 if no match
 ;
 SET VALUE=$$UP^XLFSTR(VALUE)
 Q:($G(VALUE)="")!($G(VALUE)="*") 1
 Q:($G(TYPE)="") 1
 Q:($G(DFN)<1) 0
 ;
 NEW I,J,OKAY,CHKVAL
 SET OKAY=0
 IF TYPE="NAME" DO
 . IF VALUE[", " SET VALUE=$P(VALUE,", ")_","_$P(VALUE,", ",2) ; REMOVE FIRST SPACE line added sgg 070104
 . SET CHKVAL=$P($G(^DPT(DFN,0)),"^",1)
 . IF $E(CHKVAL,1,$LENGTH(VALUE))=VALUE SET OKAY=1
 IF TYPE="SSN" DO
 . SET CHKVAL=$P($G(^DPT(DFN,0)),"^",9)
 . SET VALUE=$TR(VALUE," -","") ; REMOVE DASHES AND SPACES line added sgg 070104
 . IF $E(CHKVAL,1,$LENGTH(VALUE))=VALUE SET OKAY=1
 IF TYPE="ICN" DO
 . ;SET CHKVAL=$P($G(^DPT(DFN,"MPI")),"^",1)
 . S CHKVAL=+$$GETICN^MPIF001(DFN)
 . IF $E(CHKVAL,1,$LENGTH(VALUE))=VALUE SET OKAY=1
 IF TYPE="SSN4" DO
 . SET CHKVAL=$E($P($G(^DPT(DFN,0)),"^",1),1)_$E($P($G(^DPT(DFN,0)),"^",9),6,9)
 . IF $E(CHKVAL,1,$LENGTH(VALUE))=VALUE SET OKAY=1
 QUIT OKAY
 ;
WARDPTS(WARD) ; RETURN LIST OF PATIENTS IN A WARD
 ; Based on ORQPTQ2
 Q:+$G(WARD)<1 
 N DFN
 S DFN=0
 S WARD=$P(^DIC(42,WARD,0),"^")   ;GET WARD NAME FOR "CN"  LOOKUP
 Q:WARD=""
 F  D  Q:DFN'>0  Q:$$STOP^XOBVLIB()
 . S DFN=$O(^DPT("CN",WARD,DFN)) Q:DFN'>0
 . Q:'$$FILTCHK(DFN,SEARCH,VALUE)
 . S ^TMP("DGPTLKUP",$J,$P($G(^DPT(DFN,0)),"^",1),DFN)=""
 Q
 ;
PROVPTS(PROV) ;  RETURN LIST OF PATIENTS LINKED TO A PRIMARY PROVIDER
 ; Based on ORQPTQ2
 ; "APR" xref is on field PROVIDER in file 2 (2;.104)
 ; "AAP" xref is on field ATTENDING PHYSICIAN in file 2 (2;.1041)
 ; 
 Q:+$G(PROV)<1
 ;
 N DFN,XREF
 S DFN=0
 F XREF="AAP","APR" DO
 . F  S DFN=$O(^DPT(XREF,PROV,DFN)) Q:DFN'>0  D  Q:$$STOP^XOBVLIB()
 .. Q:'$$FILTCHK(DFN,SEARCH,VALUE)
 .. S ^TMP("DGPTLKUP",$J,$P($G(^DPT(DFN,0)),"^",1),DFN)=""
 Q
 ;
CLINPTS(CLIN,BDATE,EDATE) ; RETURN LIST OF PTS W/CLINIC APPT W/IN BEGINNING AND END DATES
 Q:+$G(CLIN)<1
 ;
 N DFN,NAME,I,J,X,Y,ORJ,ORSRV,ORNOWDT,CHKX,CHKIN,MAXAPPTS,ORC,CLNAM,NOWDT
 S MAXAPPTS=200
 S NOWDT=$$NOW^XLFDT
 ;
 S DFN=0,I=1
 IF $G(BDATE)="" S BDATE="T"
 IF $G(EDATE)="" S EDATE="T+1"
 ;CONVERT BDATE AND EDATE INTO FILEMAN DATE/TIME
 D DT^DILF("T",BDATE,.BDATE,"","")
 D DT^DILF("T",EDATE,.EDATE,"","")
 I (BDATE=-1)!(EDATE=-1) S Y(1)="^Error in date range." Q
 S EDATE=$P(EDATE,".")_.5  ;ADD 1/2 DAY TO END DATE
 ;
 D CLINPT2(+CLIN,BDATE,EDATE)
 QUIT
 ;
CLINPT2(CLIN,BEGIN,END) ; -- Use scheduling rehosting API from patches SD*5.3*253 and SD*5.3*275
 ; -- GETPLIST^SDAMA202(SDIEN,SDFIELDS,SDAPSTAT,SDSTART,SDEND,.SDRESULT,SDIOSTAT)
 ;
 K ^TMP($J,"SDAMA202","GETPLIST")
 NEW I,X,APPTS,APPTDT SET APPTS=""
 ;
 ; -- get appointment date/time, patient status, patient ien & name,
 ;    only get appointment status = "R" for scheduled or kept appointments.
 DO GETPLIST^SDAMA202(+CLIN,"1;3;4","R",BEGIN,END,.APPTS)
 ;
 ; -- check number of appointments
 I APPTS<1 K ^TMP($J,"SDAMA202","GETPLIST") Q
 ;
 ; -- check for an error, may need to pass message up.
 I $D(^TMP($J,"SDAMA202","GETPTLIST","ERROR")) QUIT
 ;
 ; -- move list of appointments to list of patients, ordered by name, dfn
 S (I,X)=""
 F  SET I=$O(^TMP($J,"SDAMA202","GETPLIST",I)) Q:I<1  S X=^(I,4) DO
 .  Q:'$$FILTCHK(+X,SEARCH,VALUE)  ;check if meets search criteria
 .  S APPTDT=$G(^TMP($J,"SDAMA202","GETPLIST",I,1))
 .  S ^TMP("DGPTLKUP",$J,$P(X,"^",2),+X,+APPTDT)=""
 K ^TMP($J,"SDAMA202","GETPLIST")
 QUIT
 ;
SPECPTS(SPEC) ;Returns a list of patients associated with a specialty
 ; "ATR" cross reference is on the Treating Specialty (#.103) field
 ; in the Patient (#2) file and is a pointer to the Facility 
 ; Treating Specialty (#45.7) file.
 ;
 Q:+$G(SPEC)<1
 N DFN
 S DFN=0
 F  S DFN=$O(^DPT("ATR",+SPEC,DFN)) Q:DFN'>0  D  Q:$$STOP^XOBVLIB()
 .Q:'$$FILTCHK(DFN,SEARCH,VALUE)
 .S ^TMP("DGPTLKUP",$J,$P($G(^DPT(DFN,0)),U),DFN)=""
 Q
 ;
ADDPTS() ;
 N NAME,DFN,DGRRFLG,DGRRAPTS,DGRRCTR
 S NAME=""
 S (DGRRFLG,DGRRCTR)=0
 S DGRRAPTS=$S(FILTER="CLINIC":1,1:0)
 FOR  SET NAME=$O(^TMP("DGPTLKUP",$J,NAME)) Q:NAME=""!(DGRRFLG=1)  DO
 . S DFN=""  FOR  SET DFN=$O(^TMP("DGPTLKUP",$J,NAME,DFN)) Q:DFN<1!(DGRRFLG=1)  DO
 .. S DGRRCTR=DGRRCTR+1
 .. I DGRRCTR>MAXSIZE S DGRRFLG=1 Q
 .. DO PTDATA^DGRRLUA(DFN,.PCNT)
 .. I FILTER'="CLINIC" Q
 .. D ADD^DGRRUTL("<appointments>")
 .. N APPTDT
 .. S APPTDT=""
 .. F  S APPTDT=$O(^TMP("DGPTLKUP",$J,NAME,DFN,APPTDT)) Q:'APPTDT  D
 ...D ADD^DGRRUTL("<appointmentTime>"_APPTDT_"</appointmentTime>")
 .. D ADD^DGRRUTL("</appointments>")
 .. D ADD^DGRRUTL("</patient>")
 I DGRRCTR>MAXSIZE D
 .IF $G(MAXSIZRE)<1 DO ADD^DGRRLU("<maximum message='Too many patients found (more than "_MAXSIZE_").  Please Limit Search.'></maximum>")
 .SET MAXSIZRE=1
 K ^TMP("DGPTLKUP",$J)
 ;IF ($G(MAXSIZRE)<1) DO ADD^DGRRUTL("<maximum message=''></maximum>")
 Q
 ;
NAMECOMP(DFN,DGRRCNT) ; ENTRY IS +$P($G(^DPT(DFN,"NAME")),"^",1)  
 ; 
 N LN,FN,MI,PR,SU,DE,DGA,DGNMC
 S DGA=+$P($G(^DPT(DFN,"NAME")),U)_","
 D GETS^DIQ(20,+DGA,"1:6","","DGNMC")
 S LN=$$CHARCHK^DGRRUTL($G(DGNMC(20,DGA,1)))
 S FN=$$CHARCHK^DGRRUTL($G(DGNMC(20,DGA,2)))
 S MI=$$CHARCHK^DGRRUTL($G(DGNMC(20,DGA,3)))
 S PR=$$CHARCHK^DGRRUTL($G(DGNMC(20,DGA,4)))
 S SU=$$CHARCHK^DGRRUTL($G(DGNMC(20,DGA,5)))
 S DE=$$CHARCHK^DGRRUTL($G(DGNMC(20,DGA,6)))
 DO ADD^DGRRUTL("<namecomp number='"_DGRRCNT_"' last='"_LN_"' first='"_FN_"' middle='"_MI_"' prefix='"_PR_"' suffix='"_SU_"' degree='"_DE_"' ></namecomp>")
 ;
