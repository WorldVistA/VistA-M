VBECLU0 ;HOIFO/BNT - VBECS Patient Lookup Utility ;
 ;;2.0;VBEC;;Jun 05, 2015;Build 4
 ;
 ; Note: This routine supports data exchange with an FDA registered
 ; medical device. As such, it may not be changed in any way without
 ; prior written approval from the medical device manufacturer.
 ; 
 ; Integration Agreements:
 ;
 SET X="You Can't Enter VBECLU0 at top of routine!"
 QUIT
 ;
BYFILTER(FILTER,FILTERV,BDATE,EDATE,SEARCH,VALUE,DELIM) ; -- search type by clinic, provider, or ward.
 NEW PCNT,OKAY,VAL
 K ^TMP("PTLKUP",$J)
 SET (OKAY,PCNT)=0
 ;W:$D(ALAN(1)) !,"In ByFilter"
 ;
 DO ADD^VBECLU("<record count='0'>")
 SET LINENO=VBECLINE
 FOR I=1:1 S VAL=$P(FILTERV,DELIM,I) QUIT:VAL=""  DO  Q:$$STOP^XOBVLIB()
 . IF FILTER="WARD" DO WARDPTS(VAL) S OKAY=1 Q
 . IF FILTER="CLINIC" DO CLINPTS(VAL,BDATE,EDATE) S OKAY=2 Q
 . IF FILTER="PROVIDER" D PROVPTS(VAL) S OKAY=3 Q
 ;
 IF OKAY<1 DO ADD^VBECLU("<error message='Filter not correctly specified'></error>")
 ;
 ; -- update the record count
 DO ADDPTS()
 SET @VBECRSLT@(LINENO)="<record count='"_PCNT_"'>"
 IF ($G(MAXSIZRE)<1) DO ADD^VBECLU("<maximum message=''></maximum>")
 DO ADD^VBECLU("<error message=''></error>")
 QUIT
 ;
FILTCHK(DFN,TYPE,VALUE) ; -- Filter search -
 ; -- check patients to match search type and search value for filter searchs
 ; -- returns 1 if matchs, 0 if no match
 ;
 ;W:$D(ALAN(1)) !,"In FilterCheck"
 SET VALUE=$$UP^XLFSTR(VALUE)
 Q:($G(VALUE)="")!($G(VALUE)="*") 1
 Q:($G(TYPE)="") 1
 Q:($G(DFN)<1) 0
 ;
 NEW I,J,OKAY
 SET OKAY=0
 IF TYPE="NAME" DO
 . SET CHKVAL=$P($G(^DPT(DFN,0)),"^",1)
 . IF $E(CHKVAL,1,$LENGTH(VALUE))=VALUE SET OKAY=1
 IF TYPE="SSN" DO
 . SET CHKVAL=$P($G(^DPT(DFN,0)),"^",9)
 . IF $E(CHKVAL,1,$LENGTH(VALUE))=VALUE SET OKAY=1
 IF TYPE="ICN" DO
 . SET CHKVAL=$P($G(^DPT(DFN,"MPI")),"^",1)
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
 . S ^TMP("PTLKUP",$J,$P($G(^DPT(DFN,0)),"^",1),DFN)=""
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
 .. S ^TMP("PTLKUP",$J,$P($G(^DPT(DFN,0)),"^",1),DFN)=""
 Q
 ;
CLINPTS(CLIN,BDATE,EDATE) ; RETURN LIST OF PTS W/CLINIC APPT W/IN BEGINNING AND END DATES
 Q:+$G(CLIN)<1
 ;
 N DFN,NAME,I,J,X,ORJ,ORSRV,ORNOWDT,CHKX,CHKIN,MAXAPPTS,ORC,CLNAM
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
 NEW I,X,APPTS SET APPTS=""
 ;
 ; -- get appointment date/time, patient status, patient ien & name,
 ;    only get appointment status = "R" for scheduled or kept appointments.
 DO GETPLIST^SDAMA202(+CLIN,"1;3;4","R",BEGIN,END,.APPTS)
 ;
 ; -- check number of appointments
 Q:APPTS<1
 ;
 ; -- check for an error, may need to pass message up.
 I $D(^TMP($J,"SDAMA202","GETPTLIST","ERROR")) QUIT
 ;
 ; -- move list of appointments to list of patients, ordered by name, dfn
 S (I,X)=""
 F  SET I=$O(^TMP($J,"SDAMA202","GETPLIST",I)) Q:I<1  S X=^(I,4) DO
 .  Q:'$$FILTCHK(+X,SEARCH,VALUE)  ;check if meets search criteria
 .  S ^TMP("PTLKUP",$J,$P(X,"^",2),+X)=""
 QUIT
 ;
ADDPTS() ;
 N NAME,DFN
 S NAME=""
 FOR  SET NAME=$O(^TMP("PTLKUP",$J,NAME)) Q:NAME=""  DO
 . S DFN=""  FOR  SET DFN=$O(^TMP("PTLKUP",$J,NAME,DFN)) Q:DFN<1  DO
 .. DO PTDATA^VBECLU(DFN,.PCNT)
 ;IF ($G(MAXSIZRE)<1) DO ADD^VBECLU("<maximum message=''></maximum>")
 Q
 ;
NAMECOMP(DFN,VBECCNT) ; ENTRY IS +$P($G(^DPT(DFN,"NAME")),"^",1)  
 ; -- FROM VBECDPT0  does this need to be incorporated?
 N A,LN,FN,MI,PR,SU,DE
 S A=$G(^VA(20,+$P($G(^DPT(DFN,"NAME")),"^",1),1))
 S LN=$$CHARCHK^XOBVLIB($P(A,"^",1))
 S FN=$$CHARCHK^XOBVLIB($P(A,"^",2))
 S MI=$$CHARCHK^XOBVLIB($P(A,"^",3))
 S PR=$$CHARCHK^XOBVLIB($P(A,"^",4))
 S SU=$$CHARCHK^XOBVLIB($P(A,"^",5))
 S DE=$$CHARCHK^XOBVLIB($P(A,"^",6))
 DO ADD^VBECLU("<namecomponent number='"_VBECCNT_" last='"_LN_"' first='"_FN_"' middle='"_MI_"' prefix='"_PR_"' suffix='"_SU_"' degree='"_DE_"' ></namecomponents>")
 ;
