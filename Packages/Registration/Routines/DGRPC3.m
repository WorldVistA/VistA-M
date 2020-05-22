DGRPC3 ;ALB/PJR,LBD,BAJ,TDM - CHECK CONSISTENCY OF PATIENT DATA (CONT) ;10/20/10 3:40pm
 ;;5.3;Registration;**451,632,673,657,688,754,797,867,903,952**;Aug 13, 1993;Build 160
 ;Per VHA Directive 6402, this routine should not be modified.
 ;
 ; 315 subroutine added by patch DG*5.3*903 which was submitted to OSEHRA 
 ; on 04/02/2015 by HP. This update was authored by James Harris 2014-2015
 ;
79 ;; MSE Dates overlap
 ;; Don't check if MSE Dates Incomplete or if MSE TO precedes FROM
 ;; or unless at least 2 ranges
 S:'$G(MSECHK) MSECHK=$$MSCK^DGMSCK I MSDATERR!($L(ANYMSE)<2) D NEXT G @DGLST
 ;Use MSE data in DGPMSE array, if it exists (DG*5.3*797)
 I $D(DGPMSE) D  D NEXT G @DGLST
 .N MS,MSE,OUT S MS=0 F  S MS=$O(DGPMSE(MS)) Q:'MS!($G(OUT))  D
 ..I $P(DGPMSE(MS),U,7) Q  ;Don't check MSE verified by HEC
 ..S MSE=$O(DGPMSE(MS,0)) Q:'MSE
 ..I '$$OVRLPCHK^DGRPDT(DFN,$P(DGPMSE(MS),U),$P(DGPMSE(MS),U,2),1,"","",MSE) S X=79 D COMB S (MSERR,OUT)=1 Q
 ;Otherwise, use MSE data in DGP(.32)
 I ANYMSE[1,'$$OVRLPCHK^DGRPDT(DFN,$P(DGP(.32),"^",6),$P(DGP(.32),"^",7),1,".326^.327") S X=79 D COMB S MSERR=1 D NEXT G @DGLST
 I ANYMSE'[1,'$$OVRLPCHK^DGRPDT(DFN,$P(DGP(.32),"^",11),$P(DGP(.32),"^",12),1,".3292^.3293") S X=79 D COMB S MSERR=1 D NEXT G @DGLST
 D NEXT G @DGLST
80 ;; POW Dates not within MSE
 ;; Check turned off by EVC project (DG*5.3*688)
 D NEXT G @DGLST
81 ;; Combat Dates not within MSE
 I '$P(DGP(.52),"^",12) D NEXT G @DGLST ;; Don't check if no COMBAT Data
 ;; Don't check if COMBAT Data Incomplete or if COMBAT TO precedes FROM
 I ((","_DGER_",")[(",39,"))!((","_DGER_",")[(",40,")) D NEXT G @DGLST
 S:'$G(MSECHK) MSECHK=$$MSCK^DGMSCK S:'$G(MSESET) MSESET=$$MSFROMTO^DGMSCK
 ;; If COMBAT, but no MSE, then Range is NOT within MSE
 I 'ANYMSE S X=81 D COMB D NEXT G @DGLST
 I '$$RWITHIN^DGRPDT($P(MSESET,"^",1),$P(MSESET,"^",2),$P(DGP(.52),"^",13),$P(DGP(.52),"^",14)) S X=81 D COMB
 D NEXT G @DGLST
82 ;; Conflict Dates not within MSE
 S:'$G(CONCHK) CONCHK=$$CNCK^DGMSCK
 S:'$G(MSECHK) MSECHK=$$MSCK^DGMSCK S:'$G(MSESET) MSESET=$$MSFROMTO^DGMSCK
 S LOC="",I2=0 F I1=1:1 S LOC=$O(CONSPEC(LOC)) Q:LOC=""  I CONARR(LOC)=1 D
 .N FROMDAT,FROMPC,TODAT,TOPC,NODE,DATA
 .S DATA=CONSPEC(LOC)
 .S NODE=$P(DATA,",",1),FROMPC=$P(DATA,",",3),TOPC=$P(DATA,",",4)
 .S FROMDAT=$P(DGP(NODE),"^",FROMPC),TODAT=$P(DGP(NODE),"^",TOPC)
 .I '$$RWITHIN^DGRPDT($P(MSESET,"^",1),$P(MSESET,"^",2),FROMDAT,TODAT) S X=82 D COMB:'I2 S CONARR(LOC)=2,I2=1
 .Q
 ; Check OIF/OEF conflict dates
 N DGOEIF D GET^DGENOEIF(DFN,.DGOEIF,0,"",0)
 I $G(DGOEIF("COUNT")),DGER'[",82," D
 . N Z
 . S Z=0 F  S Z=$O(DGOEIF("IEN",Z)) Q:'Z  D  Q:DGER[",82,"
 .. S FROMDAT=$G(DGOEIF("FR",Z)),TODAT=$G(DGOEIF("TO",Z)),LOC=$G(DGOEIF("LOC",Z))
 .. I '$$RWITHIN^DGRPDT($P(MSESET,"^",1),$P(MSESET,"^",2),FROMDAT,TODAT) S X=82 D COMB S I2=1
 D NEXT G @DGLST
83 ;Merchant Seaman or Filipino Vet BOS requires service dates during WWII
 N BOS,BOSN,MS,MSE,OUT
 ;Use MSE data from DGPMSE array, if it exists (DG*5.3*797)
 I $D(DGPMSE) D  D NEXT G @DGLST
 .S MS=0 F  S MS=$O(DGPMSE(MS)) Q:'MS!($G(OUT))  D
 ..I $P(DGPMSE(MS),U,7) Q  ;Don't check MSE if verified by HEC
 ..S BOS=$P(DGPMSE(MS),U,3) Q:'BOS  S BOSN=$P(^DIC(23,BOS,0),U)
 ..S MSE=$O(DGPMSE(MS,0)) Q:'MSE  S MSE="MSE-"_MSE
 ..I $$BRANCH^DGRPMS(BOS_U_BOSN),'$$WWII^DGRPMS(DFN,"",MSE) S X=83 D COMB S OUT=1 Q
 ;Otherwise, get MSE data from DGP(.32)
 F MS=1:1:3 D  Q:$G(OUT)
 .I MS=2,$P(DGP(.32),U,19)'="Y" S OUT=1 Q
 .I MS=3,$P(DGP(.32),U,20)'="Y" S OUT=1 Q
 .S BOS=$P(DGP(.32),U,(5*MS)) Q:'BOS  S BOSN=$P($G(^DIC(23,BOS,0)),U)
 .S MSE=$S(MS=1:"MSL",MS=2:"MSNTL",1:"MSNNTL")
 .I $$BRANCH^DGRPMS(BOS_U_BOSN),'$$WWII^DGRPMS(DFN,"",MSE) S X=83 D COMB S OUT=1 Q
 D NEXT G @DGLST
84 ;Filipino Vet BOS requires Filipino Vet Proof
 N MS,BOS,OUT,MSE
 ;Use MSE data from DGPMSE array, if it exists (DG*5.3*797)
 I $D(DGPMSE) D  D NEXT G @DGLST
 .S MS=0 F  S MS=$O(DGPMSE(MS)) Q:'MS!($G(OUT))  D
 ..I $P(DGPMSE(MS),U,7) Q  ;Don't check MSE if verified by HEC
 ..S BOS=$P(DGPMSE(MS),U,3) Q:'BOS
 ..I $$FV^DGRPMS(BOS)=1,$P(DGP(.321),U,14)="" S X=84 D COMB S OUT=1 Q
 ;Otherwise use MSE data in DGP(.32)
 F MS=1:1:3 D  Q:$G(OUT)
 .I MS=2,$P(DGP(.32),U,19)'="Y" S OUT=1 Q
 .I MS=3,$P(DGP(.32),U,20)'="Y" S OUT=1 Q
 .S BOS=$P(DGP(.32),U,(5*MS))
 .I $$FV^DGRPMS(BOS)=1,$P(DGP(.321),U,14)="" S X=84 D COMB S OUT=1 Q
 D NEXT G @DGLST
85 ;Eligible Filipino Vet should have Veteran status = 'YES'
86 ;Ineligible Filipino Vet should have Veteran status = 'NO'
 N MS,BOS,FV,FILV,NOTFV,MSE,OUT
 ;Use MSE data from DGPMSE array, if it exists (DG*5.3*797)
 I $D(DGPMSE) D
 .S MS=0 F  S MS=$O(DGPMSE(MS)) Q:'MS!($G(OUT))  D
 ..I $P(DGPMSE(MS),U,7) Q  ;Don't check MSE if verified by HEC
 ..S BOS=$P(DGPMSE(MS),U,3),FV=$$FV^DGRPMS(BOS) I 'FV S NOTFV="" Q
 ..S MSE=$O(DGPMSE(MS,0)) Q:'MSE  S MSE="MSE-"_MSE
 ..I '$$WWII^DGRPMS(DFN,"",MSE) S FILV("I")="" Q
 ..I FV=2 S FILV("E")="" Q
 ..I $P(DGP(.321),U,14)=""!($P(DGP(.321),U,14)="NO") S FILV("I")="" Q
 ..S FILV("E")=""
 ;Otherwise, get MSE data from DGP(.32)
 E  F MS=1:1:3 D  Q:$G(OUT)
 .I MS=2,$P(DGP(.32),U,19)'="Y" S OUT=1 Q
 .I MS=3,$P(DGP(.32),U,20)'="Y" S OUT=1 Q
 .S BOS=$P(DGP(.32),U,(5*MS)),FV=$$FV^DGRPMS(BOS) I 'FV S NOTFV="" Q
 .S MSE=$S(MS=1:"MSL",MS=2:"MSNTL",1:"MSNNTL")
 .I '$$WWII^DGRPMS(DFN,"",MSE) S FILV("I")="" Q
 .I FV=2 S FILV("E")="" Q
 .I $P(DGP(.321),U,14)=""!($P(DGP(.321),U,14)="NO") S FILV("I")="" Q
 .S FILV("E")=""
 I $D(FILV) D
 .I DGVT'=1,$D(FILV("E")) S X=85 D COMB Q
 .I DGCHK'[(",86,") Q
 .I DGVT=1,'$D(NOTFV),'$D(FILV("E")),$D(FILV("I")) S X=86 D COMB
 S DGLST=86
 D NEXT G @DGLST
87 ; DG*5.3*657 BAJ 11/24/2005 CC #87 added
 ; SC Eligibility but no rated Disability Codes
 ; 1. Svc Connected is answered "YES"
 ; 2. Eligibility code is either SC < 50% or SC 50-100%
 ; 3. Svc connected %-age is 0 or greater
 ; 4. Patient has no rated disabilities
 ; .. VAEL(1) $P 1 = Primary Eligibility Code  $p 2 = Primary Elig External Value
 ; .. VAEL(3) $P 1 = SERVICE CONNECTED? $P 2 = SC %
 ; .. Rated Disabilities : ^DPT(DFN,.372,0) $P 4 is number of records  '($P($G(^DPT(DFN,.372,0)),"^",4)) is TRUE
 ;
 ; Get Eligibility info
 D ELIG^VADPT
 ;
 ; If not svc connected, don't check
 I '$G(VAEL(3)) D NEXT G @DGLST
 ;
 I +VAEL(3)=1!(+VAEL(3)=3) D
 . Q:$P(VAEL(3),"^",2)<0
 . Q:$P(VAEL(3),"^",2)=""
 . I '($P($G(^DPT(DFN,.372,0)),"^",4)) S X=87 D COMB
 D NEXT G @DGLST
 ;
88 ;Temporary Address check
 N STR88,J,DGI,DGERR,START,END
 S DGERR=0
 I $P(DGP(.121),U,9)="Y" D
 . ;check only if current date is within effective range
 . S START=$P(DGP(.121),U,7),END=$P(DGP(.121),U,8)
 . Q:START=""  I END="" S END=9999999
 . ; quit if current date is not within range
 . I '(DT'<START&(DT'>END)) Q
 . ; country is either NULL or non-numeric
 . I '$P(DGP(.122),U,3) S DGERR=1 Q
 . ; country is not in Country file
 . I '$D(^HL(779.004,$P(DGP(.122),U,3))) S DGERR=1 Q
 . S STR88="1,4,5,6" I $$FORIEN^DGADDUTL($P(DGP(.122),"^",3)) S STR88="1,4"
 . F J=1:1:$L(STR88,",") S DGI=$P(STR88,",",J) Q:DGERR  I $P(DGP(.121),U,DGI)="" S DGERR=1
 I DGERR S X=88 D COMB
 D NEXT G @DGLST
89 ;
 N DGPT,DGELIG
 S DGPT=$$GET1^DIQ(2,DFN_",",391),DGELIG=$$GET1^DIQ(2,DFN+",",.361)
 I DGELIG="EXPANDED MH CARE NON-ENROLLEE",DGPT'="NON-VETERAN (OTHER)" S X=89 D COMB
 D NEXT G @DGLST
99 ; synonymous with END
END I DGNCK S X=99 D COMB
 D OVER99CK
 I DGEDCN S DGCON=0 D TIME^DGRPC
 K C,C1,C2,DGCD,DGD,DGD1,DGD2,DGDATE,DGDEP,DGCHK,DGFL,DGINC,DGISYR,DGLST,DGMS,DGNCK,DGP,DGPMSE,DGPTYP,DGREL,DGSCT,DGT,DGTIME,DGTOT,DGVT,I,I2,I2,J,VAIN,X,X1
 G ^DGRPCF
 ;
COMB S DGCT=DGCT+1,DGER=DGER_X_",",DGLST=X Q
 ;;
NEXT S I=$F(DGCHK,(","_+DGLST_",")),DGLST=+$E(DGCHK,I,999) S:'DGLST DGLST="END"
 Q
 ;
OVER99CK N DGP,DGSD,RULE,FILERR
 D LOADPT^IVMZ07C(DFN,.DGP),LOADSD^IVMZ072(DFN,.DGSD)
 F RULE=301,303,304,306:1:308 S DGLST=RULE_"^IVMZ7CD" D @DGLST I $D(FILERR(RULE)) S X=RULE D COMB
 F RULE=402,403,406,407 S DGLST=RULE_"^IVMZ7CE" D @DGLST I $D(FILERR(RULE)) S X=RULE D COMB
 F RULE=501:1:507,516,517 S DGLST=RULE_"^IVMZ7CS" D @DGLST I $D(FILERR(RULE)) S X=RULE D COMB
 F RULE=313 S DGLST=RULE_"^DGRPC3" D @DGLST I $D(FILERR(RULE)) S X=RULE D COMB
 F RULE=314 S DGLST=RULE_"^DGRPC3" D @DGLST I $D(FILERR(RULE)) S X=RULE D COMB
 F RULE=315 S DGLST=RULE_"^DGRPC3" D @DGLST I $D(FILERR(RULE)) S X=RULE D COMB
 S DGLST="END"
 Q
 ;
313 ; NEWBORN REQUIRES SPONSOR
 N X
 S DOB=$P(^DPT(DFN,0),"^",3)
 D NOW^%DTC
 S NOW=X
 I $$FMDIFF^XLFDT(NOW,DOB,1)>365 Q  ;NOT A NEWBORN
 I $D(^IBA(355.81,"B",DFN)) Q  ;already has a sponsor
 S FILERR(RULE)=""
 Q
 ; 
314 ;NEWBORN SPONSOR MUST BE ELIGIBLE
 I '$D(^IBA(355.81,"B",DFN)) Q  ;Does not have a sponsor
 N X
 S DOB=$P(^DPT(DFN,0),"^",3)
 D NOW^%DTC
 S NOW=X
 I $$FMDIFF^XLFDT(NOW,DOB,1)>365 Q  ;NOT A NEWBORN
 N RELIEN,SPNIEN,SPNDFN,ELIG
 ;NEED TO FIND SPONSOR IN PATIENT FILE
 S RELIEN="",SPNIEN="",SPNDFN="",ELIG=""
 S RELIEN=$O(^IBA(355.81,"B",DFN,RELIEN))
 S SPNIEN=$$GET1^DIQ(355.81,RELIEN,.02,"I")
 S SPNDFN=$$GET1^DIQ(355.8,SPNIEN,.01,"I")
 S SPNDFN=$P(SPNDFN,";",1)
 S ELIG=$$GET1^DIQ(2,SPNDFN,.3611,"I")
 I ELIG'="" Q  ;sponsor has an eligibility status
 S FILERR(RULE)=""
 Q
 ;
315 ; MHV - subroutine added by patch DG*5.3*903
 Q:'$G(DFN)!'$G(DGPRFLG)
 ;This functionality will not be executed if "Enable MyHealtheVet Prompts?" (#1100.07  
 ;field in MAS PARAMETERS (43) file is not set to YES (internal value 1)
 Q:+$$MHVENABL^DGMHVUTL()'>0
 ;
 N DGFLDCHK,DGMHVACT,DGMHVOUT,DGMHVQ,X,Y,DIR
 Q:$$MHVOK^DGMHVAC(DFN) 
 ; Quit if MHV ENROLLED/Registered has not been answered, and enrollment/registration
 ; action is pending
 S DGMHVACT=$$ENQACHK^DGMHVUTL(DFN) Q:(DGMHVACT]"")&'$G(^DPT(DFN,2))
 S:'$$MHVOK^DGMHVAC(DFN) FILERR(315)=""
 Q
