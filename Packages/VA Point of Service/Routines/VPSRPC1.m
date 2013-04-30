VPSRPC1  ;BPOIFO/EL - Patient Demographic and Appointment RPC;11/20/11 15:30
 ;;1.0;VA POINT OF SERVICE (KIOSKS);**1**;Oct 21, 2011;Build 12
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; External Reference DBIA#
 ; ------------------------
 ; #2462 - ^DGEN( reference       (Controlled Sub) 
 ; #4425 - ^DGS( references       (Controlled Sub)
 ; #10035 - ^DPT( references      (Supported)
 ; #10040 - ^SC( references       (Supported)
 ; #2052 - DID call               (Supported)
 ; #2056 - DIQ call               (Supported)
 ; #3402 - DGSEC4 call            (Supported)
 ; #3403 - DGSEC4 call            (Supported)
 ; #4419 - IBBAPI call            (Supported)
 ; #2701 - MPIF001 call           (Supported)
 ; #4433 - SDAMA301 call          (Supported)
 ; #10061 - VADPT call            (Supported)
 ; #10103 - XLFDT call            (Supported)
 ; #10104 - XLFSTR call           (Supported)
 ; #4289 - PRCAHV call            (Controlled Sub)
 ; #3860 - DGPFAPI call           (Controlled Sub)
 Q
GETCLN(VPSARR,CLNAM) ; VPS GET CLINIC - RPC CLINIC NAME ENTRY
 ; VPSARR - passed in by reference; return array of clinics that matched input string (CLNAM)
 ; CLNAM - partial or full name of clinic; 
 ; Called by the MDWS web service Get Clinic operation which is an operation 
 ; triggered by the KIOSK (point of service) system.    
 ; The RPC will accept 2 parameters.  The first parameter represents the 
 ; return value as required by RPC Broker, and the 2nd parameter is
 ; single input value representing the name of the clinic (full or partial 
 ; name).  The output produced will be an array that returns all the 
 ; possible matches for the clinic (one to many clinics).  Values returned 
 ; will be the name of the clinic and the ien of the clinic.
 N CNT,VPSCLN,VPSCNAM,VPSFL,VPSIEN,VPSUPNAM,X,Y
 S CNT=0 K VPSARR
 I $G(CLNAM)="" S X="-1^CLINIC NAME NOT SENT" D WR G QUIT
 S VPSUPNAM=$$UP^XLFSTR(CLNAM)
 S VPSCNAM="",VPSFL=44
 F   S VPSCNAM=$O(^SC("B",VPSCNAM)) Q:$G(VPSCNAM)=""  I VPSCNAM[VPSUPNAM D
 . S VPSCLN="" F   S VPSCLN=$O(^SC("B",VPSCNAM,VPSCLN)) Q:$G(VPSCLN)=""  D
 . . S VPSIEN=VPSCLN
 . . S X=$$SET(VPSFL,VPSIEN,".001",VPSCLN,"CLINIC NUMBER") D WR
 . . S X=$$SET(VPSFL,VPSIEN,".01",VPSCNAM) D WR
 . . S Y=$$GET1^DIQ(VPSFL,VPSCLN_",",10,"E"),X=$$SET(VPSFL,VPSIEN,10,Y) D WR
 I $G(CNT)'>1 S X="-1^CLINIC COULD NOT BE FOUND." D WR G QUIT
 Q
 ;
GETDATA(VPSARR,SSN) ; VPS GET PATIENT DEMOGRAPHIC - RPC SSN ENTRY
 ; VPSARR - passed in by reference; return array of patient demographics,appts
 ; SSN - patient SSN
 ; Called by the MDWS web service Get Patient Demographic operation.  The 
 ; operation is triggered by the Vecna Kiosk (point of service) system.  
 ; The RPC will accept 2 parameters.  The first parameter represents the 
 ; return value as required by RPC Broker, the 2nd parameter is an input 
 ; value which is the patient SSN.  The RPC returns the patient 
 ; demographics, insurance, and up-coming appointments.
 N CNT,DFN,I,ICN,TMP,TODAY,X,Y,VPSAPT,VPSCL,VPSCLN,VPSCNAM,VPSDA,VPSDFN
 N VPSDS,VPSDT,VPSFL,VPSFLD,VPSFR,VPSIBB,VPSIBFLD,VPSICN,VPSIEN,VPSOUT
 N VPSREC,VPSSD,VPSSSN,VPSTO,VADM,VAEL,VAOA,VAPA,VAPD,VACNTRY,VAERR
 N DGOPT,DGMSG,DGRES,ACTION
 ;
 S CNT=0,TODAY=$$DT^XLFDT() K VPSARR
 ; 
 I $G(SSN)="" S X="-1"_U_"SSN NOT SENT." D WR G QUIT
 S VPSSSN=$TR(SSN,"- ")
 I +$G(VPSSSN)'>0 S X="-1"_U_"SSN SHOULD BE NUMERIC: "_SSN D WR G QUIT
 S VPSDFN=""
 S VPSDFN=$O(^DPT("SSN",VPSSSN,0))
 I +$G(VPSDFN)'>0 S X="-1"_U_"NO PATIENT FOUND WITH SSN: "_SSN D WR G QUIT
 S DFN=VPSDFN
 S X=$$SET(2,DFN,".001",DFN,"DFN") D WR
 S VPSICN=$$GETICN^MPIF001(DFN),ICN=$P(VPSICN,"V")
 I $G(ICN)'="" S X=$$SET(2,DFN,"991.01",ICN) D WR
 D DEM,SENLOG,ELIG,ENR,ADD,OAD,IBB,APT,REC,DGS,BAL
 K ^TMP($J,"SDAMA301")
 G QUIT
 ;
DEM ; Patient Demographic Data
 K VADM D DEM^VADPT
 I $G(VADM(1))'="" S X=$$SET(2,DFN,".01",VADM(1)) D WR
 S Y=$P(VADM(2),U) I $G(Y)'="" S X=$$SET(2,DFN,".09",Y) D WR
 S Y=$P(VADM(3),U) I $G(Y)'="" S X=$$SET(2,DFN,".03",Y) D WR  ; kiosk needs internal (FM) format for all dates
 S Y=$P(VADM(5),U,2) I $G(Y)'="" S X=$$SET(2,DFN,".02",Y) D WR
 S Y=$P(VADM(9),U,2) I $G(Y)'="" S X=$$SET(2,DFN,".08",Y) D WR
 S Y=$P(VADM(10),U,2) I $G(Y)'="" S X=$$SET(2,DFN,".05",Y) D WR
 I $G(VADM(11))'="" D
 . S I="",VPSFL="2.06"
 . F  S I=$O(VADM(11,I)) Q:$G(I)=""  S Y=$P(VADM(11,I),U,2) I $G(Y)'="" D
 . . S VPSIEN=DFN_";"_I,X=$$SET(VPSFL,VPSIEN,".01",Y) D WR
 I $G(VADM(12))'="" D
 . S I="",VPSFL="2.02"
 . F  S I=$O(VADM(12,I)) Q:$G(I)=""  S Y=$P(VADM(12,I),U,2) I $G(Y)'="" D
 . . S VPSIEN=DFN_";"_I,X=$$SET(VPSFL,VPSIEN,".01",Y) D WR
 Q
 ;
SENLOG ; Check Patient Sensitive Record File-38.1
 K DGRES S DGOPT=U_"VPS KIOSK-PATIENT-SELF-CHECKIN",DGMSG=1
 D PTSEC^DGSEC4(.DGRES,DFN,DGMSG,DGOPT)
 I $G(DGRES(1))=0 S Y="0;NON-SENSITIVE" G WRSEN
 I $G(DGRES(1))=1 D  G WRSEN
 . S Y="1;SENSITIVE & SEC-AUDIT LOG & KIOSK MACHINE LOGIN-DUZ HOLDING SECURITY KEY"
 I $G(DGRES(1))=2 D  D WR Q
 . S ACTION=1 D NOTICE^DGSEC4(.DGRES,DFN,DGOPT,ACTION)
 . S Y="2;SENSITIVE & SEC-AUDIT LOG & KIOSK MACHINE LOGIN-DUZ HOLDING NOSECURITY KEY"
 . S X=$$SET(38.1,DFN,"IA3403",Y,"SENSITIVE")
 I $G(DGRES(1))=3 D  G WRSEN
 . S Y="3;CANNOT CHECK SENSITIVE DUE TO KIOSK MACHINE LOGIN-DUZ ACCESSING OWN RECORD"
 I $G(DGRES(1))=4 D  G WRSEN
 . S Y="4;CANNOT CHECK SENSITIVE DUE TO KIOSK MACHINE LOGIN-DUZ MISSING SSN"
 S Y="-1;MISSING DFN IN SENSITIVE CHECK"
WRSEN ;
 I $G(Y)'="" S X=$$SET(38.1,DFN,"IA3402",Y,"SENSITIVE") D WR
 Q
 ;
ELIG ;
 K VAEL D ELIG^VADPT
 S Y=$$GET1^DIQ(2,DFN_",",.381,"E")
 I $G(Y)'="" S X=$$SET(2,DFN,".381",Y) D WR
 I $G(VAEL(5,1))'="" S Y=$P(VAEL(5,1),U,2) I $G(Y)'="" S X=$$SET(2,DFN,".152",Y) D WR
 I $G(VAEL(8))'="" S Y=$P(VAEL(8),U,2) I $G(Y)'="" S X=$$SET(2,DFN,".3611",Y) D WR
 I $G(VAEL(9))'="" S Y=$P(VAEL(9),U,2) I $G(Y)'="" S X=$$SET(2,DFN,".14",Y) D WR
 Q
 ;
ENR ; Enrollment
 S X="",X=$O(^DGEN(27.11,"C",DFN,X),-1) Q:$G(X)=""
 S Y="",Y=$$GET1^DIQ(27.11,X_",",.04,"E")
 I $G(Y)'="" S X=$$SET(27.11,DFN,".04",Y) D WR
 Q
 ;
ADD ;
 K VAPA D ADD^VADPT
 S Y=$P(VAPA(9),U) I $G(Y)="" G SETPERM
 I TODAY<$G(Y) G SETPERM
 S Y=$P(VAPA(10),U) I $G(Y)=""!(TODAY'>$G(Y)) G SETMP
SETPERM ;  PERM ADDRESS
 I $G(VAPA(1))'="" S Y=VAPA(1) S X=$$SET(2,DFN,".111",Y) D WR
 I $G(VAPA(2))'="" S Y=VAPA(2) S X=$$SET(2,DFN,".112",Y) D WR
 I $G(VAPA(3))'="" S Y=VAPA(3) S X=$$SET(2,DFN,".113",Y) D WR
 I $G(VAPA(4))'="" S Y=VAPA(4) S X=$$SET(2,DFN,".114",Y) D WR
 S Y=$P(VAPA(5),U,2) I $G(Y)'="" S X=$$SET(2,DFN,".115",Y) D WR
 S Y=$P(VAPA(7),U,2) I $G(Y)'="" S X=$$SET(2,DFN,".117",Y) D WR
 I $G(VAPA(8))'="" S Y=VAPA(8) S X=$$SET(2,DFN,".131",Y) D WR
 S Y=$P(VAPA(11),U,2) I $G(Y)'="" S X=$$SET(2,DFN,".1112",Y) D WR
 S Y=$P(VAPA(25),U,2) I $G(Y)'="" S X=$$SET(2,DFN,".1173",Y) D WR
 S Y=$$GET1^DIQ(2,DFN_",",.1171,"E")
 I $G(Y)'="" S X=$$SET(2,DFN,".1171",Y) D WR
 S Y=$$GET1^DIQ(2,DFN_",",.1172,"E")
 I $G(Y)'="" S X=$$SET(2,DFN,".1172",Y) D WR
 S Y=$$GET1^DIQ(2,DFN_",",.121,"E")
 I $G(Y)'="" S X=$$SET(2,DFN,".121",Y) D WR
 S Y=$$GET1^DIQ(2,DFN_",",.132,"E")
 I $G(Y)'="" S X=$$SET(2,DFN,".132",Y) D WR
 S Y=$$GET1^DIQ(2,DFN_",",.134,"E")
 I $G(Y)'="" S X=$$SET(2,DFN,".134",Y) D WR
 S Y=$$GET1^DIQ(2,DFN_",",.133,"E")
 I $G(Y)'="" S X=$$SET(2,DFN,".133",Y) D WR
 Q
 ;
SETMP ; SET TEMP ADD
 I $G(VAPA(1))'="" S Y=VAPA(1) S X=$$SET(2,DFN,".1211",Y) D WR
 I $G(VAPA(2))'="" S Y=VAPA(2) S X=$$SET(2,DFN,".1212",Y) D WR
 I $G(VAPA(3))'="" S Y=VAPA(3) S X=$$SET(2,DFN,".1213",Y) D WR
 I $G(VAPA(4))'="" S Y=VAPA(4) S X=$$SET(2,DFN,".1214",Y) D WR
 S Y=$P(VAPA(5),U,2) I $G(Y)'="" S X=$$SET(2,DFN,".1215",Y) D WR
 S Y=$P(VAPA(7),U,2) I $G(Y)'="" S X=$$SET(2,DFN,".12111",Y) D WR
 I $G(VAPA(8))'="" S Y=VAPA(8) S X=$$SET(2,DFN,".1219",Y) D WR
 S Y=$P(VAPA(9),U,2) I $G(Y)'="" S X=$$SET(2,DFN,".1217",Y) D WR
 S Y=$P(VAPA(10),U,2) I $G(Y)'="" S X=$$SET(2,DFN,".1218",Y) D WR
 S Y=$P(VAPA(11),U,2) I $G(Y)'="" S X=$$SET(2,DFN,".12112",Y) D WR
 S Y=$P(VAPA(25),U,2) I $G(Y)'="" S X=$$SET(2,DFN,".1223",Y) D WR
 S Y=$$GET1^DIQ(2,DFN_",",.1221,"E")
 I $G(Y)'="" S X=$$SET(2,DFN,".1221",Y) D WR
 S Y=$$GET1^DIQ(2,DFN_",",.1222,"E")
 I $G(Y)'="" S X=$$SET(2,DFN,".1222",Y) D WR
 K VAPA S VAPA("P")="" D ADD^VADPT
 G SETPERM
 ;
OAD ;
 K VAOA S VAOA("A")=7 D OAD^VADPT    ; NOK
 I $G(VAOA(1))'="" S Y=VAOA(1) S X=$$SET(2,DFN,".213",Y) D WR
 I $G(VAOA(2))'="" S Y=VAOA(2) S X=$$SET(2,DFN,".214",Y) D WR
 I $G(VAOA(3))'="" S Y=VAOA(3) S X=$$SET(2,DFN,".215",Y) D WR
 I $G(VAOA(4))'="" S Y=VAOA(4) S X=$$SET(2,DFN,".216",Y) D WR
 S Y=$P(VAOA(5),U,2) I $G(Y)'="" S X=$$SET(2,DFN,".217",Y) D WR
 I $G(VAOA(11))'="" S Y=$P(VAOA(11),U,2) S X=$$SET(2,DFN,".2207",Y) D WR
 I $G(VAOA(8))'="" S Y=VAOA(8) S X=$$SET(2,DFN,".219",Y) D WR
 I $G(VAOA(9))'="" S Y=VAOA(9) S X=$$SET(2,DFN,".211",Y) D WR
 I $G(VAOA(10))'="" S Y=VAOA(10) S X=$$SET(2,DFN,".212",Y) D WR
 S Y=$$GET1^DIQ(2,DFN_",",.21011,"E")
 I $G(Y)'="" S X=$$SET(2,DFN,".21011",Y) D WR
 ;
 K VAOA S VAOA("A")=3 D OAD^VADPT    ; Second NOK
 I $G(VAOA(1))'="" S Y=VAOA(1) S X=$$SET(2,DFN,".2193",Y) D WR
 I $G(VAOA(2))'="" S Y=VAOA(2) S X=$$SET(2,DFN,".2194",Y) D WR
 I $G(VAOA(3))'="" S Y=VAOA(3) S X=$$SET(2,DFN,".2195",Y) D WR
 I $G(VAOA(4))'="" S Y=VAOA(4) S X=$$SET(2,DFN,".2196",Y) D WR
 S Y=$P(VAOA(5),U,2) I $G(Y)'="" S X=$$SET(2,DFN,".2197",Y) D WR
 I $G(VAOA(11))'="" S Y=$P(VAOA(11),U,2) S X=$$SET(2,DFN,".2203",Y) D WR
 I $G(VAOA(8))'="" S Y=VAOA(8) S X=$$SET(2,DFN,".2199",Y) D WR
 I $G(VAOA(9))'="" S Y=VAOA(9) S X=$$SET(2,DFN,".2191",Y) D WR
 I $G(VAOA(10))'="" S Y=VAOA(10) S X=$$SET(2,DFN,".2192",Y) D WR
 S Y=$$GET1^DIQ(2,DFN_",",.211011,"E")
 I $G(Y)'="" S X=$$SET(2,DFN,".211011",Y) D WR
 ;
 K VAOA S VAOA("A")=1 D OAD^VADPT    ; Emergency Contact
 I $G(VAOA(1))'="" S Y=VAOA(1) S X=$$SET(2,DFN,".333",Y) D WR
 I $G(VAOA(2))'="" S Y=VAOA(2) S X=$$SET(2,DFN,".334",Y) D WR
 I $G(VAOA(3))'="" S Y=VAOA(3) S X=$$SET(2,DFN,".335",Y) D WR
 I $G(VAOA(4))'="" S Y=VAOA(4) S X=$$SET(2,DFN,".336",Y) D WR
 S Y=$P(VAOA(5),U,2) I $G(Y)'="" S X=$$SET(2,DFN,".337",Y) D WR
 I $G(VAOA(11))'="" S Y=$P(VAOA(11),U,2) S X=$$SET(2,DFN,".2201",Y) D WR
 I $G(VAOA(8))'="" S Y=VAOA(8) S X=$$SET(2,DFN,".339",Y) D WR
 I $G(VAOA(9))'="" S Y=VAOA(9) S X=$$SET(2,DFN,".331",Y) D WR
 I $G(VAOA(10))'="" S Y=VAOA(10) S X=$$SET(2,DFN,".332",Y) D WR
 S Y=$$GET1^DIQ(2,DFN_",",.33011,"E")
 I $G(Y)'="" S X=$$SET(2,DFN,".33011",Y) D WR
 ;
 K VAOA S VAOA("A")=4 D OAD^VADPT    ; Second Emergency Contact
 I $G(VAOA(1))'="" S Y=VAOA(1) S X=$$SET(2,DFN,".3313",Y) D WR
 I $G(VAOA(2))'="" S Y=VAOA(2) S X=$$SET(2,DFN,".3314",Y) D WR
 I $G(VAOA(3))'="" S Y=VAOA(3) S X=$$SET(2,DFN,".3315",Y) D WR
 I $G(VAOA(4))'="" S Y=VAOA(4) S X=$$SET(2,DFN,".3316",Y) D WR
 S Y=$P(VAOA(5),U,2) I $G(Y)'="" S X=$$SET(2,DFN,".3317",Y) D WR
 I $G(VAOA(11))'="" S Y=$P(VAOA(11),U,2) S X=$$SET(2,DFN,".2204",Y) D WR
 I $G(VAOA(8))'="" S Y=VAOA(8) S X=$$SET(2,DFN,".3319",Y) D WR
 I $G(VAOA(9))'="" S Y=VAOA(9) S X=$$SET(2,DFN,".3311",Y) D WR
 I $G(VAOA(10))'="" S Y=VAOA(10) S X=$$SET(2,DFN,".3312",Y) D WR
 S Y=$$GET1^DIQ(2,DFN_",",.331011,"E")
 I $G(Y)'="" S X=$$SET(2,DFN,".331011",Y) D WR
 ;
 K VAOA S VAOA("A")=5 D OAD^VADPT    ; Patient Employer
 I $G(VAOA(8))'="" S Y=VAOA(8) S X=$$SET(2,DFN,".3119",Y) D WR
 I $G(VAOA(9))'="" S Y=VAOA(9) S X=$$SET(2,DFN,".3111",Y) D WR
 K VAPD D OPD^VADPT
 S Y=$P(VAPD(7),U,2) I $G(Y)'="" S X=$$SET(2,DFN,".31115",Y) D WR
 S Y=$$GET1^DIQ(2,DFN_",",.31116,"E")
 I $G(Y)'="" S X=$$SET(2,DFN,".31116",Y) D WR
 ;
 K VAOA S VAOA("A")=6 D OAD^VADPT    ; Spouse's Employer
 I $G(VAOA(8))'="" S Y=VAOA(8) S X=$$SET(2,DFN,".258",Y) D WR
 I $G(VAOA(9))'="" S Y=VAOA(9) S X=$$SET(2,DFN,".251",Y) D WR
 S Y=$$GET1^DIQ(2,DFN_",",.2515,"E")
 I $G(Y)'="" S X=$$SET(2,DFN,".2515",Y) D WR
 S Y=$$GET1^DIQ(2,DFN_",",.2516,"E")
 I $G(Y)'="" S X=$$SET(2,DFN,".2516",Y) D WR
 Q
 ;
IBB ; Insurance Info
 S VPSIBFLD="1,10,11,13,14,21" K VPSIBB
 S Y=$$INSUR^IBBAPI(DFN,,"ABR",.VPSIBB,VPSIBFLD)
 I $G(Y)'>0 Q
 S (I,Y)=""
IBB2 ;
 S I=$O(VPSIBB("IBBAPI","INSUR",I)) Q:$G(I)=""
 S VPSFL="2.312",VPSIEN=DFN_";"_I
 ; Insurance Company Name
 S Y=$G(VPSIBB("IBBAPI","INSUR",I,1))
 I $G(Y)'="" S Y=$P(Y,U,2) S X=$$SET(36,VPSIEN,.01,Y) D WR
 ; Policy Effective Date
 S Y=$G(VPSIBB("IBBAPI","INSUR",I,10))
 I $G(Y)'="" S X=$$SET(VPSFL,VPSIEN,8,Y) D WR
 ; Policy Expiration Date
 S Y=$G(VPSIBB("IBBAPI","INSUR",I,11))
 I $G(Y)'="" S X=$$SET(VPSFL,VPSIEN,3,Y) D WR
 ; Subscribe Name
 S Y=$G(VPSIBB("IBBAPI","INSUR",I,13))
 I $G(Y)'="" S X=$$SET(VPSFL,VPSIEN,17,Y) D WR
 ; Subscribe ID
 S Y=$G(VPSIBB("IBBAPI","INSUR",I,14))
 I $G(Y)'="" S X=$$SET(VPSFL,VPSIEN,1,Y) D WR
 G IBB2
 ;
APT ;  Appointment Info
 K VPSSD S Y=""
 S VPSFR=TODAY,VPSTO=TODAY+20000,VPSSD(1)=VPSFR_":"_VPSTO
 S VPSSD(3)="R;I;NS;NSR;R;CP;CPR;CC;CCR;NT"
 S VPSSD(4)=DFN
 S VPSSD("FLDS")="1;2;3;10;16;19;20;21;22"
 S Y=$$SDAPI^SDAMA301(.VPSSD)
 I $G(Y)'>0 Q
SD10 S (VPSCL,VPSIEN)=""
SD20 S VPSCL=$O(^TMP($J,"SDAMA301",DFN,VPSCL)) Q:VPSCL=""
 S VPSDT=""
SD30 ;     
 S VPSDT=$O(^TMP($J,"SDAMA301",DFN,VPSCL,VPSDT)) G:VPSDT="" SD20
 S VPSAPT=^TMP($J,"SDAMA301",DFN,VPSCL,VPSDT)
 S VPSIEN=DFN_";"_VPSCL_";"_VPSDT
 ;
 ;   Clinic Info
 ; APPT CLINIC IEN/NAME #2
 S Y=$P(VPSAPT,U,2),VPSCLN=$P(Y,";"),VPSCNAM=$P(Y,";",2)
 I $G(VPSCLN)'=""  S X=$$SET(2.98,VPSIEN,".01",VPSCLN) D WR
 S VPSFL="44"
 I $G(VPSCNAM)'="" S X=$$SET(VPSFL,VPSIEN,".01",VPSCNAM) D WR
 ; HOSPITAL PHYSICAL LOCATION
 S Y=$$GET1^DIQ(VPSFL,VPSCLN_",",10,"E")
 I $G(Y)'="" S X=$$SET(VPSFL,VPSIEN,10,Y) D WR
 ;
 ;   Appt Info
 ; APPT DATE/TIME #1
 S VPSFL="2.98"
 S Y=$P(VPSAPT,U,1) I $G(Y)'="" D
 . S X=$$SET(VPSFL,VPSIEN,".001",Y,"APPOINTMENT DATE/TIME") D WR
 ; CURRENT STATUS #22
 S Y=$P($P(VPSAPT,U,22),";",3) I $G(Y)'="" S X=$$SET(VPSFL,VPSIEN,100,Y) D WR
 ; APPT TYPE IEN/NAME #10
 S Y=$P($P(VPSAPT,U,10),";",2) I $G(Y)'="" S X=$$SET(44,VPSIEN,2507,Y) D WR
 ; DATE APPT MADE #16
 S Y=$P(VPSAPT,U,16) I $G(Y)'="" S X=$$SET(VPSFL,VPSIEN,20,Y) D WR
 ; EKG DATE/TIME #19
 S Y=$P(VPSAPT,U,19) I $G(Y)'="" S X=$$SET(VPSFL,VPSIEN,7,Y) D WR
 ; X-RAY DATE/TIME #20
 S Y=$P(VPSAPT,U,20) I $G(Y)'=""  S X=$$SET(VPSFL,VPSIEN,6,Y) D WR
 ; LAB DATE/TIME #21
 S Y=$P(VPSAPT,U,21) I $G(Y)'=""  S X=$$SET(VPSFL,VPSIEN,5,Y) D WR
 G SD30
 ;
REC ; Patient Record Flag
 S TMP=$$GETACT^DGPFAPI(DFN,"VPSREC") I $G(TMP)'=1 Q
 S Y=$P(VPSREC(1,"FLAGTYPE"),U,2) I $G(Y)'="" S X=$$SET("26.13",DFN,".02",Y) D WR
 S TMP=""
R10 ;
 S TMP=$O(VPSREC(1,"NARR",TMP)) Q:$G(TMP)=""
 S Y=$G(VPSREC(1,"NARR",TMP,0)) I $G(Y)'="" S X=$$SET("26.132",DFN,".01",Y) D WR
 G R10
 ;
DGS ; Pre-Registration Audit
 S VPSFL="41.41"
 S (TMP,Y)="",TMP=$O(^DGS(VPSFL,"ADC",DFN,TMP),-1) I $G(TMP)="" Q
 I $G(TMP)'="" S X=$$SET(VPSFL,DFN,1,TMP) D WR
 Q 
 ;
BAL ; BALANCE-OWED
 S X=$$BALANCE^PRCAHV(.Y,ICN,"ALL") I $G(X)=1 S X=$$SET(430,DFN,"COMPUTED",Y,"BALANCE") D WR
 Q
 ;
SET(VPSFL,VPSIEN,VPSFLD,VPSDA,VPSDS) ;
 S X="" K VPSOUT
 I $G(VPSDS)="" D FIELD^DID(VPSFL,VPSFLD,"","LABEL","VPSOUT") S VPSDS=VPSOUT("LABEL")
 S X=VPSFL_U_VPSIEN_U_VPSFLD_U_VPSDA_U_VPSDS
 Q X
 ;
WR ;
 S CNT=CNT+1
 S VPSARR(CNT)=X
 Q
 ;
QUIT Q
