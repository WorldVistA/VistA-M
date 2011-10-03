ORQPTQ2 ; slc/CLA - Functions which return patient lists and list sources pt 2 ;3/14/05  10:50
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**9,10,85,187,190,195,215**;Dec 17, 1997
 ;
 ; Ref. to ^UTILITY via IA 10061
 ; DBIA 3869   GETPLIST^SDAMA202   ^TMP($J,"SDAMA202")
 ; 
CLIN(Y) ; RETURN LIST OF CLINICS
 N ORLST,IEN,I
 D GETLST^XPAR(.ORLST,"ALL","ORWD COMMON CLINIC")
 S I=0 F  S I=$O(ORLST(I)) Q:'I  D
 . S IEN=$P(ORLST(I),U,2) I $$ACTLOC^ORWU(IEN)=1 D
 .. S Y(I)=IEN_U_$P(^SC(IEN,0),U,1)
 Q
 ;
CLINPTS(Y,CLIN,ORBDATE,OREDATE) ; RETURN LIST OF PTS W/CLINIC APPT W/IN BEGINNING AND END DATES
 ; PKS-8/2003: Modified for new scheduling pkg APIs.
 I +$G(CLIN)<1 S Y(1)="^No clinic identified" Q 
 I $$ACTLOC^ORWU(CLIN)'=1 S Y(1)="^Clinic is inactive or Occasion Of Service" Q
 N DFN,NAME,I,J,X,ORJ,ORSRV,ORNOWDT,CHKX,CHKIN,MAXAPPTS,ORC,CLNAM,ORFLDS,ORCLIN,ORRESULT,ORSTART,OREND,ORSTAT,ORASTAT,ORERR,ORI,ORPT,ORPTSTAT,ORMAX,ORHOLD
 S MAXAPPTS=200
 S ORNOWDT=$$NOW^XLFDT
 S ORSRV=$G(^VA(200,DUZ,5)) I +ORSRV>0 S ORSRV=$P(ORSRV,U)
 S DFN=0,I=1
 I ORBDATE="" S ORBDATE=$$UP^XLFSTR($$GET^XPAR("USR^SRV.`"_+$G(ORSRV)_"^DIV^SYS^PKG","ORLP DEFAULT CLINIC START DATE",1,"E"))
 I OREDATE="" S OREDATE=$$UP^XLFSTR($$GET^XPAR("USR^SRV.`"_+$G(ORSRV)_"^DIV^SYS^PKG","ORLP DEFAULT CLINIC STOP DATE",1,"E"))
 ;
 ; Convert ORBDATE, OREDATE to FM Date/Time:
 D DT^DILF("T",ORBDATE,.ORBDATE,"","")
 D DT^DILF("T",OREDATE,.OREDATE,"","")
 I (ORBDATE=-1)!(OREDATE=-1) S Y(1)="^Error in date range." Q 
 S OREDATE=$P(OREDATE,".")_.5 ; Add 1/2 day to end date.
 ; IA# 3869:
 K ^TMP($J,"SDAMA202","GETPLIST") ; Clean house before starting.
 S ORRESULT=""
 S ORCLIN=+CLIN,ORFLDS="1;3;4;12",ORASTAT="R;NT",ORSTART=ORBDATE,OREND=OREDATE,ORSTAT="" ; Assign parameters.
 ; ORFLDS: 1;3;4;12 = ApptDateTime;ApptStatus;IEN^PtName;PtStatus.
 D GETPLIST^SDAMA202(ORCLIN,ORFLDS,ORASTAT,ORSTART,OREND,.ORRESULT,ORSTAT) ; DBIA 3869.
 ;
 ; Deal with server errors:
 S ORERR=$$CLINERR^ORQRY01
 I $L(ORERR) S Y(1)=U_ORERR Q
 ;
 ; Reassign ^TMP array to local array:
 S (ORPT,ORI)=0,ORMAX=MAXAPPTS
 I ORRESULT'>0 S Y(1)="^No appointments." Q
 F  S ORPT=$O(^TMP($J,"SDAMA202","GETPLIST",ORPT)) Q:ORPT=""!(ORI>ORMAX)  D   ;DBIA 3869
 .S ORI=ORI+1
 .S Y(ORI)=$G(^TMP($J,"SDAMA202","GETPLIST",ORPT,4)) ; IEN^Name.
 .S Y(ORI)=Y(ORI)_U_ORCLIN ; ^Clinic IEN.
 .S Y(ORI)=Y(ORI)_U_$G(^TMP($J,"SDAMA202","GETPLIST",ORPT,1)) ; App't.
 .S ORPTSTAT=$G(^TMP($J,"SDAMA202","GETPLIST",ORPT,12)) ; Pt Status.
 .S ORPTSTAT=$S(ORPTSTAT="I":"IPT",ORPTSTAT="O":"OPT",1:"")
 .S ORHOLD=$G(^TMP($J,"SDAMA202","GETPLIST",ORPT,3)) ; Appt Status.
 .I ORPTSTAT=""&(ORHOLD="NT") S ORPTSTAT="NT" ; "No Action Taken."
 .S Y(ORI)=Y(ORI)_U_U_U_U_U_ORPTSTAT ; Pt I or O status (or "NT").
 ;
 K ^TMP($J,"SDAMA202","GETPLIST") ; Clean house after finishing.
 ;
 Q
 ;
CDATRANG(ORY) ; return default start and stop dates for clinics in form start^stop
 N ORBDATE,OREDATE,ORSRV
 S ORSRV=$G(^VA(200,DUZ,5)) I +ORSRV>0 S ORSRV=$P(ORSRV,U)
 S ORBDATE=$$UP^XLFSTR($$GET^XPAR("USR^SRV.`"_+$G(ORSRV)_"^DIV^SYS^PKG","ORLP DEFAULT CLINIC START DATE",1,"E"))
 S OREDATE=$$UP^XLFSTR($$GET^XPAR("USR^SRV.`"_+$G(ORSRV)_"^DIV^SYS^PKG","ORLP DEFAULT CLINIC STOP DATE",1,"E"))
 S ORBDATE=$S($L($G(ORBDATE)):ORBDATE,1:""),OREDATE=$S($L($G(OREDATE)):OREDATE,1:"")
 S ORY=$$UP^XLFSTR(ORBDATE)_"^"_$$UP^XLFSTR(OREDATE)
 Q
PTAPPTS(Y,DFN,ORBDATE,OREDATE,CLIN) ; return appts for a patient between beginning and end dates for a clinic, if no clinic return all appointments
 ;I +$G(CLIN)<1 S Y(1)="^No clinic identified" Q 
 I +$G(CLIN)>0,$$ACTLOC^ORWU(CLIN)'=1 S Y(1)="^Clinic is inactive or Occasion Of Service" Q
 N ERR,ERRMSG,VASD,NUM,CNT,INVDT,INT,EXT,ORSRV,VAERR K ^UTILITY("VASD",$J) S NUM=0,CNT=1  ;IA 10061
 I (ORBDATE="")!(OREDATE="") D  ;get user's service and set up entities:
 .S ORSRV=$G(^VA(200,DUZ,5)) I +ORSRV>0 S ORSRV=$P(ORSRV,U)
 I ORBDATE="" D
 .I '$L(CLIN) S ORBDATE=$$UP^XLFSTR($$GET^XPAR("USR^SRV.`"_+$G(ORSRV)_"^DIV^SYS^PKG","ORQQEAPT ENC APPT START",1,"E"))
 .S:ORBDATE="" ORBDATE="T" ;default start date across all clinics is today
 I OREDATE="" D
 .I '$L(CLIN) S OREDATE=$$UP^XLFSTR($$GET^XPAR("USR^SRV.`"_+$G(ORSRV)_"^DIV^SYS^PKG","ORQQEAPT ENC APPT STOP",1,"E"))
 .S:OREDATE="" OREDATE="T" ;default end date across all clinics is today
 ;CONVERT ORBDATE AND OREDATE INTO FILEMAN DATE/TIME
 D DT^DILF("T",ORBDATE,.ORBDATE,"","")
 D DT^DILF("T",OREDATE,.OREDATE,"","")
 I (ORBDATE=-1)!(OREDATE=-1) S Y(1)="^Error in date range." Q 
 S VASD("F")=ORBDATE
 S VASD("T")=$P(OREDATE,".")_.5  ;ADD 1/2 DAY TO END DATE
 I $L($G(CLIN)) S VASD("C",CLIN)=""
 D SDA^ORQRY01(.ERR,.ERRMSG)
 I ERR K ^UTILITY("VASD",$J) S Y(1)=ERRMSG Q
 F  S NUM=$O(^UTILITY("VASD",$J,NUM)) Q:'NUM  D
 .S INT=^UTILITY("VASD",$J,NUM,"I"),INVDT=9999999-$P(INT,U)
 .S EXT=^UTILITY("VASD",$J,NUM,"E")
 .S Y(CNT)=$P(INT,U)_U_$P(EXT,U,2)_U_$P(EXT,U,3)_U_$P(EXT,U,4)_U_INVDT
 .S CNT=CNT+1
 S:+$G(Y(1))<1 Y(1)="^No appointments."
 K ^UTILITY("VASD",$J)
 Q
PROV(Y) ; RETURN LIST OF PROVIDERS
 N I,IEN,NAME,TDATE
 S I=1,NAME=""
 F  S NAME=$O(^VA(200,"B",NAME)) Q:NAME=""  S IEN=0,IEN=$O(^(NAME,IEN))  D
 .Q:$E(NAME)="*"
 .I $D(^XUSEC("PROVIDER",IEN)),$$ACTIVE^XUSER(IEN) S Y(I)=IEN_"^"_NAME,I=I+1
 Q
PROVPTS(Y,PROV) ; RETURN LIST OF PATIENTS LINKED TO A PRIMARY PROVIDER
 I +$G(PROV)<1 S Y(1)="^No provider identified" Q
 N ORI,DFN
 S ORI=1,DFN=0
 F  S DFN=$O(^DPT("APR",PROV,DFN)) Q:DFN'>0  S Y(ORI)=+DFN_"^"_$P(^DPT(+DFN,0),"^"),ORI=ORI+1
 S:+$G(Y(1))<1 Y(1)="^No patients found."
 Q
SPEC(Y) ; RETURN LIST OF TREATING SPECIALTIES
 N I,NAME,IEN
 S I=1,NAME=""
 ;access to DIC(45.7 global granted under DBIA #519:
 F  S NAME=$O(^DIC(45.7,"B",NAME)) Q:NAME=""  S IEN=0,IEN=$O(^(NAME,IEN)) I $$ACTIVE^DGACT(45.7,IEN) S Y(I)=IEN_"^"_NAME,I=I+1
 Q
SPECPTS(Y,SPEC) ; RETURN LIST OF PATIENTS LINKED TO A TREATING SPECIALTY
 I +$G(SPEC)<1 S Y(1)="^No specialty identified" Q 
 N ORI,DFN
 S ORI=1,DFN=0
 F  S DFN=$O(^DPT("ATR",SPEC,DFN)) Q:DFN'>0  S Y(ORI)=+DFN_"^"_$P(^DPT(+DFN,0),"^"),ORI=ORI+1
 S:+$G(Y(1))<1 Y(1)="^No patients found."
 Q
WARD(Y) ; RETURN LIST OF ACTIVE WARDS
 N I,IEN,NAME,D0
 S I=1,NAME=""
 ;access to DIC(42 global granted under DBIA #36:
 F  S NAME=$O(^DIC(42,"B",NAME)) Q:NAME=""  S IEN=$O(^(NAME,0)) D
 . S D0=IEN D WIN^DGPMDDCF
 . I X=0 S Y(I)=IEN_"^"_NAME,I=I+1
 Q
WARDPTS(Y,WARD) ; RETURN LIST OF PATIENTS IN A WARD
 ; SLC/PKS - Modifications for Room/Bed data on  1/19/2001.
 I +$G(WARD)<1 S Y(1)="^No ward identified" Q 
 N ORI,DFN,RBDAT
 S ORI=1,DFN=0
 ; Access to DIC(42 global granted under DBIA #36:
 S WARD=$P(^DIC(42,WARD,0),"^")   ;GET WARD NAME FOR "CN"  LOOKUP
 ; Next section modified 1/19/2001 by PKS:
 F  D  Q:DFN'>0
 .S DFN=$O(^DPT("CN",WARD,DFN)) Q:DFN'>0
 .S Y(ORI)=+DFN_"^"_$P(^DPT(+DFN,0),"^")
 .S RBDAT=""
 .; Add patient room/bed information where data exists:
 .S RBDAT=$P($G(^DPT(+DFN,.101)),U)
 .I RBDAT'="" D                                   ; Any R/B data?
 ..I $L(RBDAT)<4 S RBDAT=RBDAT_"   "              ; Add if < 4 chars.
 ..S RBDAT=$E(RBDAT,1,4)                          ; Get first 4 only.
 .S Y(ORI)=Y(ORI)_U_RBDAT                         ; Add R/B to string
 .S ORI=ORI+1                                     ; Increment counter.
 ;
 S:+$G(Y(1))<1 Y(1)="^No patients found."
 Q
NLIST(ORQY) ; return a null list
 S ORQY(1)=""
 Q
