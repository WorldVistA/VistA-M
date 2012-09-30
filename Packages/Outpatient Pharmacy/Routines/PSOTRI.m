PSOTRI ;BIRM/BNT - OP TRICARE/CHAMPVA Audit Log Utilities ;07/21/2010
 ;;7.0;OUTPATIENT PHARMACY;**358,385**;DEC 1997;Build 27
 ;
 ; Reference to DUR1^BPSNCPD3 supported by IA 4560
 ;
 Q
 ;
 ;
AUDIT(RX,RFL,RXCOB,JST,AUD,ELIG) ;
 ; Main entry to create a new record in the PSO AUDIT LOG file #52.87
 ; INPUT: RX    (r) = Prescription IEN
 ;        RFL   (o) = Prescription Fill # (Default is original zero fill)
 ;        RXCOB (o) = Coordination of Benefits
 ;                   1 = Primary (Default)
 ;                   2 = Secondary
 ;        JST   (o) = Justification text
 ;        AUD   (r) = Audit Type
 ;                   R = NCPDP REJECT - Associated with an Override audit action
 ;                   N = NON BILLABLE RX - Associated with an Override audit action
 ;                   I = INPATIENT - Associated with a Bypass audit action
 ;                   P = PARTIAL FILL
 ;        ELIG  (r) = Eligibility Type
 ;                   T = TRICARE
 ;                   C = CHAMPVA
 ; RETURN: Successful Audit entry will return the IEN of the new entry in file 52.87
 ;         Unsuccessful Audit entry will return "0^Error Description"
 ;
 N PSOTRIC,PSODIV,RXFLDS,RFLFLDS,RXECME,PSOFDA,FN,SFN,PSOIEN,PSOIENS,PSOUSER,PSOTC,PSOET
 N I,PSOAIEN,PSOREJ,DFN,PSODOA,PSODOS,PSOERR,PSOX,PSOY,RXARR,RFLARR,PSOPHRM,PSOQTY
 Q:'$D(^PSRX(RX,0)) "0^Prescription does not exist"
 ; Verify refill exists
 I RFL=""!RFL<0 S RFL=$$LSTRFL^PSOBPSU1(RX)
 ;
 ; Not original fill
 I RFL Q:'$D(^PSRX(RX,1,RFL)) "0^Refill "_RFL_" does not exist"
 ;
 ; Verify RX is for a TRICARE or CHAMPVA patient
 S (PSOTRIC,PSOTC)="",PSOTRIC=$$TRIC^PSOREJP1(RX,RFL,PSOTRIC)
 Q:'PSOTRIC "0^Not a TRICARE or CHAMPVA RX"
 ;
 ; Verify Audit Type
 I ("/R/N/I/P/")'[("/"_AUD_"/") Q "0^Invalid Audit Type "_AUD
 ;
 ; Verify Eligibility Type
 I ("/T/C/")'[("/"_ELIG_"/") Q "0^Invalid Eligibility Type "_ELIG
 ;
 ; Coordination of Benefits (default is Primary)
 S RXCOB=+$G(RXCOB) I RXCOB=0 S RXCOB=1
 ; Audit File and Reject subfile
 S FN=52.87,SFN=52.8713
 ;
 ; Fields for original fill:
 ; PROVIDER;NDC;DRUG NAME;QUANTITY;PATIENT;PATIENT STATUS;PHARMACIST;UNIT PRICE OF DRUG
 S RXFLDS="4;27;6;7;2;3;23;17"
 ; Fields for refills
 ; PROVIDER;NDC;QUANTITY;PHARMACIST
 S RFLFLDS="15;11;1;4"
 ;
 ; Get data from RX
 D GETS^DIQ(52,RX,RXFLDS,"I","RXARR")
 ; Get data from Refill
 I RFL D GETS^DIQ(52.1,RFL_","_RX,RFLFLDS,"I","RFLARR")
 ; Get Division
 S PSODIV=$$RXSITE^PSOBPSUT(RX,RFL)
 ; ECME Number, if exists
 S RXECME=$$ECMENUM^PSOBPSU2(RX,RFL)
 ; Date of Action is NOW
 S PSODOA=$$NOW^XLFDT()
 ; Date of Service
 S PSODOS=$$DOS^PSOBPSU1(RX,RFL)
 ; User (If null OR Audit Type is Inpatient set to POSTMASTER)
 S PSOUSER=DUZ
 I (PSOUSER="")!(AUD="I") S PSOUSER=.5
 ; Quantity
 S PSOQTY=$S(RFL>0:$G(RFLARR(52.1,RFL_","_RX_",",1,"I")),1:$G(RXARR(52,RX_",",7,"I")))
 ;
 ; Set up FDA array
 S PSOIEN="+1,"
 S PSOAIEN=$P($G(^PS(52.87,0)),U,3)+1
 ; AUDIT ID field
 S PSOFDA(FN,PSOIEN,.01)=PSOAIEN
 ; PRESCRIPTION field
 S PSOFDA(FN,PSOIEN,1)=RX
 ; FILL field
 S PSOFDA(FN,PSOIEN,2)=RFL
 ; PATIENT field
 S PSOFDA(FN,PSOIEN,3)=$G(RXARR(52,RX_",",2,"I"))
 ; DIVISOIN field
 S PSOFDA(FN,PSOIEN,4)=PSODIV
 ; PROVIDER field
 S PSOFDA(FN,PSOIEN,5)=$S(RFL>0:$G(RFLARR(52.1,RFL_","_RX_",",15,"I")),1:$G(RXARR(52,RX_",",4,"I")))
 ; NDC field
 S PSOFDA(FN,PSOIEN,6)=$S(RFL>0:$G(RFLARR(52.1,RFL_","_RX_",",11,"I")),1:$G(RXARR(52,RX_",",27,"I")))
 ; DRUG field
 S PSOFDA(FN,PSOIEN,7)=$G(RXARR(52,RX_",",6,"I"))
 ; BILL COST field (This needs to be verified)
 S PSOFDA(FN,PSOIEN,8)=$G(RXARR(52,RX_",",17,"I"))*PSOQTY+8
 ; ECME NUMBER field
 S PSOFDA(FN,PSOIEN,9)=RXECME
 ; QTY field
 S PSOFDA(FN,PSOIEN,10)=PSOQTY
 ; PATIENT STATUS field
 S PSOFDA(FN,PSOIEN,11)=$G(RXARR(52,RX_",",3,"I"))
 ; AUDIT TYPE field
 S PSOFDA(FN,PSOIEN,12)=AUD
 ; USER field
 S PSOFDA(FN,PSOIEN,14)=PSOUSER
 ; DATE OF ACTION field
 S PSOFDA(FN,PSOIEN,15)=PSODOA
 ; DATE OF SERVICE field
 S PSOFDA(FN,PSOIEN,16)=PSODOS
 ; TRICARE JUSTIFICATION field
 S PSOFDA(FN,PSOIEN,17)=JST
 ; Eligibility Code
 S PSOFDA(FN,PSOIEN,18)=ELIG
 D DUR1^BPSNCPD3(RX,RFL,.PSOREJ,.PSOERR,RXCOB)
 S PSOET=$$PSOET^PSOREJP3(RX,RFL)    ;check to see if eT or eC is the reject code as no ecme claim.
 I PSOET S PSOTC=$S(PSOTRIC=1:"eT",PSOTRIC=2:"eC",1:"")
 I PSOTC]"",'$D(PSOREJ(RXCOB,"REJ CODES")) S PSOREJ(RXCOB,"REJ CODES",1,PSOTC)="",PSOREJ(RXCOB,"REJ CODE LST")=PSOTC
 I $G(PSOREJ(RXCOB,"REJ CODE LST"))]"" D
 . S PSOX="",PSOY=1 F I=1:1 S PSOX=$O(PSOREJ(RXCOB,"REJ CODES",I,0)) Q:PSOX=""  D
 . . S PSOY=PSOY+1,PSOIENS=PSOY_","_PSOIEN
 . . S PSOFDA(SFN,"+"_PSOIENS,.01)=PSOX
 ;
 D UPDATE^DIE("","PSOFDA","","PSOERR")
 I $D(PSOERR("DIERR")) D BMES^XPDUTL(PSOERR("DIERR",1,"TEXT",1))
 Q
