ECUERPC1 ;ALB/JAM;Event Capture Data Entry Broker Util ; 5/21/01 7:30pm
 ;;2.0; EVENT CAPTURE ;**25,33,42,46,47,54,72,76**;8 May 96;Build 6
PATINF(RESULTS,ECARY) ;
 ;Broker entry point to get various types of data from EVENT CAPTURE 
 ;PATIENT FILE #721
 ;        RPC: EC GETPATINFO
 ;INPUTS   ECARY  - Contains the following subscripted elements
 ;          ECIEN - Event Capture Patient ien
 ;          ECTYP - Data type to return
 ;
 ;OUTPUTS  RESULTS - Array of Event Capture Patient data
 ;
 N ECTYP,ECIEN
 S ECARY=$G(ECARY),ECIEN=$P(ECARY,U),ECTYP=$P(ECARY,U,2) I ECIEN="" Q
 I '$D(^ECH(ECIEN)) Q
 D SETENV^ECUMRPC
 I ECTYP="DXS" D PATDXS(ECIEN) Q
 I ECTYP="MOD" D PATMOD(ECIEN) Q
 I ECTYP="CLASS" D PATCLASS(ECIEN) Q
 I ECTYP="OTH" D PATOTH(ECIEN) Q
 I ECTYP="PRV" D PATPRV^ECUERPC2(ECIEN) Q
 Q
PATDXS(ECIEN) ;
 ;Returns to broker a patient secondary DXs entries from EVENT 
 ;CAPTURE PATIENT FILE #721
 ;INPUTS   ECIEN - Event Capture Patient ien
 ;
 ;OUTPUTS  RESULTS - Array of Event Capture Patient file contains
 ;          721 IEN^secondary dx ien #80^secondary dx code^dx description
 ;
 N DXS,DXSIEN,DXSD,CNT
 I '$D(^ECH(ECIEN,"DX")) Q
 K ^TMP($J,"ECDXS")
 S (CNT,DXS)=0 F  S DXS=$O(^ECH(ECIEN,"DX",DXS)) Q:'DXS  D
 . S DXSIEN=$G(^ECH(ECIEN,"DX",DXS,0)) I DXSIEN="" Q
 . S DXSD=$$ICDDX^ICDCODE(DXSIEN,$P($G(^ECH(ECIEN,0)),U,3))
 . S DXSD=$P(DXSD,U,2)_"   "_$P(DXSD,U,4)
 . S CNT=CNT+1,^TMP($J,"ECDXS",CNT)=ECIEN_U_DXSIEN_U_DXSD
 S RESULTS=$NA(^TMP($J,"ECDXS"))
 Q
PATMOD(ECIEN) ;
 ;Returns to broker a patient procedure modifier from EVENT CAPTURE
 ;PATIENT FILE #721
 ;INPUTS   ECIEN - Event Capture Patient ien
 ;
 ;OUTPUTS  RESULTS - Array of procedure modifiers
 ;          721 IEN^modifier ien #81.3^modifier^modifier name
 ;
 N MOD,MODIEN,CNT,MODS
 I '$D(^ECH(ECIEN,"MOD")) Q
 K ^TMP($J,"ECMOD")
 S (CNT,MOD)=0 F  S MOD=$O(^ECH(ECIEN,"MOD",MOD)) Q:'MOD  D
 . S MODIEN=$G(^ECH(ECIEN,"MOD",MOD,0)) I MODIEN="" Q
 . S MODS=$$MOD^ICPTMOD(MODIEN,"I",$P($G(^ECH(ECIEN,0)),U,3)) I +MODS<0 Q
 . S CNT=CNT+1
 . S ^TMP($J,"ECMOD",CNT)=ECIEN_U_$P(MODS,U,1,2)_"  "_$P(MODS,U,3)
 S RESULTS=$NA(^TMP($J,"ECMOD"))
 Q
PATCLASS(ECIEN) ;
 ;Returns to broker a patient classification & eligibility data from
 ;EVENT CAPTURE PATIENT FILE #721
 ; INPUTS   ECIEN - Event Capture Patient ien
 ; OUTPUTS  RESULTS - Array of procedure modifiers
 ;  721 IEN^agent orange^radiation exposure^service connect^environmental
 ;  contaminants/SWAC^military sexual trauma^eligibility code #8^
 ;  eligibility description^head/neck cancer^combat veteran^P112/SHAD
 ;
 N CLA,ELIG,ELCOD,ECAO,ECIR,ECEC,ECSC,ECMST,STR,ECHNC,ECCV,ECSHAD
 I '$D(^ECH(ECIEN,"P")),'$D(^ECH(ECIEN,"PCE")) Q
 K ^TMP($J,"ECLASS")
 S ELIG=$P($G(^ECH(ECIEN,"PCE")),"~",17),ELCOD="",CLA=$G(^ECH(ECIEN,"P"))
 S:ELIG'="" ELCOD=$P($G(^DIC(8,ELIG,0)),U)
 S ECAO=$P(CLA,U,3),ECIR=$P(CLA,U,4),ECEC=$P(CLA,U,5),ECSC=$P(CLA,U,6)
 S ECMST=$P(CLA,U,9),ECHNC=$P(CLA,U,10),ECCV=$P(CLA,U,11),ECSHAD=$P(CLA,U,12)
 S STR=ECIEN_U_ECAO_U_ECIR_U_ECSC_U_ECEC_U_ECMST
 S STR=STR_U_ELIG_U_ELCOD_U_ECHNC_U_ECCV_U_ECSHAD,^TMP($J,"ECLASS",1)=STR
 S RESULTS=$NA(^TMP($J,"ECLASS"))
 Q
PATOTH(ECIEN) ;
 ;Returns to broker a patient remaining data from EVENT CAPTURE
 ;PATIENT FILE #721
 ;INPUTS   ECIEN - Event Capture Patient ien
 ;
 ;OUTPUTS  RESULTS - Array of procedure modifiers
 ;          721 IEN^procedure reason
 ;
 N REAS,ECX
 K ^TMP($J,"ECOTH")
 S ECX=^ECH(ECIEN,0)
 S REAS=$$GET1^DIQ(721,ECIEN,34,"E")
 S ^TMP($J,"ECOTH",1)=REAS
 S RESULTS=$NA(^TMP($J,"ECOTH"))
 Q
PATCLAST(RESULTS,ECARY) ;
 ;Returns to broker a patient status (in/out) and classification
 ;     RPC: EC GETPATCLASTAT
 ;INPUTS  ECARY  - Contains the following subscripted elements  
 ;         ECDFN - Patient ien (#2)
 ;         ECD   - DSS Unit ien (#724)
 ;         ECDT  - Procedure date and time (fileman format)
 ;OUTPUTS  RESULTS - Patient status and classifications delimited by (^)
 ;         Patient Status: I for inpatient or O for outpatient
 ;         Classification: 2- Agent Orange, 3- Ionizing Radiation
 ;          4- SC Condition, 5- Environment Contaminants/SWAC 6- Military
 ;          Sexual Trauma    7- Head/Neck Cancer 8- Combat Veteran
 ;          9- Project 112/SHAD
 ;         Data after the '~' refers to those class. that must be asked 
 ;         by Delphi appl. when the answer to SC=No.
 ;         Data after "~"  1- Agent Orange  2- Ionizing Radi. 3- Env Cont/SWAC
 N ECDFN,ECDT,ECX,I,ECCLARY,SCDAT,PATSTAT
 D SETENV^ECUMRPC
 S ECDFN=$P(ECARY,U),ECD=$P(ECARY,U,2),ECDT=$P(ECARY,U,3) Q:ECDFN=""
 I ECDT="" D NOW^%DTC S ECDT=%
 S PATSTAT=$$INOUTPT^ECUTL0(ECDFN,ECDT),RESULTS="^^^^^^",SCDAT=";;;"
 I PATSTAT="I" D  Q  ;added to be consistent w roll-n-scroll 11/25/03 JAM
 .S RESULTS=PATSTAT_"^"_RESULTS_$S(SCDAT'="":"~"_SCDAT,1:"")
 I '$$CHKDSS^ECUTL0(+$G(ECD),PATSTAT) D  Q
 .S RESULTS=PATSTAT_"^"_RESULTS_$S(SCDAT'="":"~"_SCDAT,1:"")
 D CL^SDCO21(ECDFN,ECDT,"",.ECCLARY) F ECX=3,1,2,4,5,6,7,8 D
 .I ECX=1,$P($G(^DPT(ECDFN,.321)),"^",2)'="Y" Q
 .I ECX=2,$P($G(^DPT(ECDFN,.321)),"^",3)'="Y" Q
 .I ECX=4,$P($G(^DPT(ECDFN,.322)),"^",13)'="Y",'$$EC^SDCO22(ECDFN,"") Q
 .I ECX=3,$D(ECCLARY(ECX)) F I=1,2,4 S ECCLARY(I)="SC"
 .I '$D(ECCLARY(ECX)) Q
 .;Check SC, if answer to SC is NO then these questions will be asked
 .I ECCLARY(ECX)="SC" S $P(SCDAT,";",ECX)="E"
 .E  S $P(RESULTS,"^",ECX)="E"
 S RESULTS=PATSTAT_"^"_RESULTS_$S(SCDAT'="":"~"_SCDAT,1:"")
 Q
ENCDXS(RESULTS,ECARY) ;
 ;Broker call returns a patient encounter primary & secondary dx (#721)
 ;     RPC: EC GETENCDXS
 ;INPUTS   ECDFN - Patient ien (#2)
 ;         ECDT  - Procedure date and time (fileman format)
 ;         ECL   - Location ien
 ;         EC4   - Clinic ien
 ;
 ;OUTPUTS  RESULTS - array of patient encounter diagnosis
 ;         primary/secondary flag^DX ien^DX code  DX description.
 ;
 N ECDFN,ECDT,ECL,EC4,ECPDX,ECDX,ECDXN,ECDXS,CNT,STR,ECPDX,SDXCNT
 D SETENV^ECUMRPC
 K ^TMP($J,"ECENCDXS")
 S ECDFN=$P(ECARY,U),ECDT=+$P(ECARY,U,2),ECL=$P(ECARY,U,3)
 S EC4=$P(ECARY,U,4) I ECDT="" D NOW^%DTC S ECDT=%
 I ECDFN=""!(ECL="")!(EC4="") Q
 S (ECDX,ECDXN)="",ECPDX=$$PDXCK^ECUTL2(ECDFN,ECDT,ECL,EC4) I ECDX="" Q
 S IEN="",STR=1_U_ECDX_U_ECDXN_"   "_$P($$ICDDX^ICDCODE(ECDX,ECDT),U,4)
 S CNT=1,^TMP($J,"ECENCDXS",CNT)=STR
 ;*ACS concat description to 2nd diag code, in the order entered by the user
 F  S IEN=$O(ECDXS(IEN)) Q:IEN=""  D
 . S CNT=CNT+1,^TMP($J,"ECENCDXS",CNT)=0_U_ECDXS(IEN)_U_IEN_"   "_$P($$ICDDX^ICDCODE(ECDXS(IEN),ECDT),U,4)
 S RESULTS=$NA(^TMP($J,"ECENCDXS"))
 Q
 ;
PROCBAT(RESULTS,ECARY) ;
 ;Broker call returns the entries from EVENT CAPTURE PATIENT FILE #721
 ;for patients for a specific procedure
 ;        RPC: EC GETBATPROCS
 ;INPUTS   ECARY - Contains the following subscripted elements
 ;          ECLOC - Location ien
 ;          ECUNT - DSS unit ien
 ;          ECC   - Category ien
 ;          ECP   - Procedure ien
 ;          ECSD  - Start Date
 ;          ECED  - End Date
 ;
 ;OUTPUTS  RESULTS - Array of Event Capture Patient data containing:-
 ;          721 IEN^Patient name^Procedure Date/Time^Primary Dx
 ;          ^Ordering Section^Associated Clinic
 ;^SSN^DOB^Procedure Date and Time
 ;
 N IEN,CNT,ECLOC,ECUNT,NODE,DATA,PXDT,ECV,ECC,ECP,ECSD,ECED,DATE,DFN
 N CAT,ECI,VADM,ORC,ASC,ECDX
 S ECV="ECLOC^ECUNT^ECC^ECP^ECSD^ECED"
 D PARSE^ECUERPC(ECV,ECARY)
 I (ECLOC="")!(ECUNT="")!(ECC="")!(ECP="") Q
 D SETENV^ECUMRPC K ^TMP($J,"ECBATPX") S CNT=0
 S %DT="STX" F ECI="ECSD","ECED" S X=@ECI D ^%DT S @ECI=Y
 S ECSD=$S(ECSD=-1:DT,1:ECSD)-.0001,ECED=$S(ECED=-1:DT,1:ECED)+.9999
 Q:ECED'>ECSD  S DATE=ECSD
 F  S DATE=$O(^ECH("AC1",ECLOC,DATE)) Q:'DATE!(DATE>ECED)  S IEN=0 D
 . F  S IEN=$O(^ECH("AC1",ECLOC,DATE,IEN)) Q:'IEN  D
 . . S NODE=$G(^ECH(IEN,0))  Q:NODE=""  Q:$P(NODE,U,7)'=ECUNT
 . . Q:$P(NODE,U,8)'=ECC  Q:$P(NODE,U,9)'=ECP
 . . S ECDX=$P($G(^ECH(IEN,"P")),U,2) I ECDX'="" D
 . . . S ECDX=$$ICDDX^ICDCODE(ECDX,DATE)
 . . . S ECDX=$P(ECDX,U,2)_"  "_$P(ECDX,U,4)
 . . S ASC=$P(NODE,U,19) S:ASC'="" ASC=$$GET1^DIQ(44,ASC,.01,"I")
 . . S ORC=$P(NODE,U,12) S:ORC'="" ORC=$$GET1^DIQ(723,ORC,.01,"I")
 . . S Y=DATE X ^DD("DD") S PXDT=Y,DFN=$P(NODE,U,2) D DEM^VADPT
 . . S DATA=$E(VADM(1),1,30)_U_PXDT_U_ECDX_U_ORC_U_ASC
 . . S CNT=CNT+1,^TMP($J,"ECBATPX",CNT)=IEN_U_DATA
 S RESULTS=$NA(^TMP($J,"ECBATPX"))
 Q
 ;
CLHLP(RESULTS,ECARY) ;RPC Broker entry point for classification help
 ;        RPC: EC CLASHELP
 ;INPUTS   ECARY - Contains the following elements for report printing
 ;          ECDFN  - Patient DFN from file (#2)
 ;          ECKY   - Key to provide help on
 ;
 ;OUTPUTS  RESULTS - Array of help text for classification
 ;
 N ECFILER,ECERR,ECDIRY,ECUFILE,ECDFN,ECKY,ECHNDL
 D SETENV^ECUMRPC
 K ^TMP("ECMSG",$J)
 S ECERR=0,ECDFN=$P(ECARY,U),ECKY=$P(ECARY,U,2) D  I ECERR D CLEND Q
 .I ECDFN="" S ECERR=1,^TMP("ECMSG",$J,1)="0^Patient IEN not defined" Q
 .I ECKY="" S ECERR=1,^TMP("ECMSG",$J,1)="0^Help Key not defined" Q
 .S DIC=2,DIC(0)="NMZX",X=ECDFN D ^DIC I Y<0 D
 ..S ECERR=1,^TMP("ECMSG",$J,1)="0^Patient IEN not found"
 S ECHNDL="ECLASHLP" D HFSOPEN^ECRRPC(ECHNDL) I ECERR D CLEND Q
 U IO
 I ECKY="SC" D SC^SDCO23(ECDFN)
 D HFSCLOSE^ECRRPC(ECFILER)
CLEND ;
 I $D(^TMP("ECMSG",$J)) S RESULTS=$NA(^TMP("ECMSG",$J)) Q
 S RESULTS=$NA(^TMP($J))
 Q
ECDEF(RESULTS,ECARY) ;RPC Broker entry point to get a default for space bar
 ;        RPC: EC SPACEBAR
 ;INPUTS   ECARY - Contains the following elements for report printing
 ;          ECFILE - File to obtain value from
 ;
 ;OUTPUTS  RESULTS - IEN^Description of Text
 ;
 N DIC,ECFILE,X,Y
 D SETENV^ECUMRPC
 S ECFILE=$P(ECARY,U)
 I ECFILE="" S ECERR=1,RESULTS="0^File not defined" Q
 S X=" ",DIC(0)="MZX",DIC=ECFILE D ^DIC I Y<0 D  I ECERR Q
 . S ECERR=1,RESULTS="0^Nothing found"
 S RESULTS=Y
 Q
