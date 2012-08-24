PSOBPSU2 ;BIRM/MFR - BPS (ECME) Utilities 2 ;10/15/04
 ;;7.0;OUTPATIENT PHARMACY;**260,287,289,341,290,358,359,385**;DEC 1997;Build 27
 ;Reference to File 200 - NEW PERSON supported by IA 10060
 ;Reference to DUR1^BPSNCPD3 supported by IA 4560
 ;Reference to $$NCPDPQTY^PSSBPSUT supported by IA 4992
 ;Reference to $$CLAIM^BPSBUTL supported by IA 4719
 ; 
MWC(RX,RFL) ; Returns whether a prescription is (M)ail, (W)indow or (C)MOP
 ;Input: (r) RX   - Rx IEN (#52)
 ;       (o) RFL  - Refill #  (Default: most recent)
 ;Output: "M": MAIL / "W": WINDOW / "C": CMOP
 ;
 N MWC
 ;
 I '$D(RFL) S RFL=$$LSTRFL^PSOBPSU1(RX)
 ;
 ; - MAIL/WINDOW fields (Original and Refill)
 I RFL S MWC=$$GET1^DIQ(52.1,RFL_","_RX,2,"I")
 E  S MWC=$$GET1^DIQ(52,RX,11,"I")
 S:MWC="" MWC="W"
 ;
 ; - Checking the RX SUSPENSE file (#52.5)
 I $$GET1^DIQ(52,RX,100,"I")=5 D
 . N RXS S RXS=+$O(^PS(52.5,"B",RX,0)) Q:'RXS
 . I $$GET1^DIQ(52.5,RXS,3,"I")'="" S MWC="C" Q
 . S MWC="M"
 ;
 ; - Checking the CMOP EVENT sub-file (#52.01)
 I MWC'="C" D
 . N CMP S CMP=0
 . F  S CMP=$O(^PSRX(RX,4,CMP)) Q:'CMP  D  I MWC="C" Q
 . . I $$GET1^DIQ(52.01,CMP_","_RX,2,"I")=RFL S MWC="C"
 ;
 Q MWC
 ;
RXACT(RX,RFL,COMM,TYPE,USR) ; - Add an Activity to the ECME Activity Log (PRESCRIPTION file)
 ;Input: (r) RX   - Rx IEN (#52)
 ;       (o) RFL  - Refill #  (Default: most recent)
 ;       (r) COMM - Comments (up to 75 characters)
 ;       (r) TYPE - Comments type: (M-ECME,E-Edit, etc...) See file #52 DD for all values
 ;       (o) USR  - User logging the comments (Default: DUZ)
 ;
 S:'$D(RFL) RFL=$$LSTRFL^PSOBPSU1(RX) S:'$D(USR) USR=DUZ
 S:'$D(^VA(200,+USR,0)) USR=DUZ S COMM=$E($G(COMM),1,75)
 ;
 I COMM="" Q
 I '$D(^PSRX(RX)) Q
 ;
 N PSOTRIC S PSOTRIC="",PSOTRIC=$$TRIC^PSOREJP1(RX,RFL,PSOTRIC)
 I PSOTRIC=1,$E(COMM,1,7)'="TRICARE" S COMM=$E("TRICARE-"_COMM,1,75)
 I PSOTRIC=2,$E(COMM,1,7)'="CHAMPVA" S COMM=$E("CHAMPVA-"_COMM,1,75)
 N X,DIC,DA,DD,DO,DR,DINUM,Y,DLAYGO
 S DA(1)=RX,DIC="^PSRX("_RX_",""A"",",DLAYGO=52.3,DIC(0)="L"
 S DIC("DR")=".02///"_TYPE_";.03////"_USR_";.04///"_$S(TYPE'="M"&(RFL>5):RFL+1,1:RFL)_";.05///"_COMM
 S X=$$NOW^XLFDT() D FILE^DICN
 Q
 ;
ECMENUM(RX,RFL) ; Returns the ECME number for a specific prescription and fill
 N ECMENUM
 I $G(RX)="" Q ""
 ; Check ECME # for Refill passed in
 I $G(RFL)'="" S ECMENUM=$$GETECME(RX,RFL) Q ECMENUM
 ; If Refill is null, check last refill
 S RFL=$$LSTRFL^PSOBPSU1(RX),ECMENUM=$$GETECME(RX,RFL) I ECMENUM'="" Q ECMENUM
 ; If no ECME # for last refill, step back through refills in reverse order
 F  S RFL=RFL-1 Q:(RFL<0)!(ECMENUM'="")  S ECMENUM=$$GETECME(RX,RFL)
 Q ECMENUM
 ;
GETECME(RX,RFL) ;
 ;Internal function used by ECMENUM to get the ECME # from BPS
 N ECMENUM
 I $G(RX)="" Q ""
 I $G(RFL)="" Q ""
 S ECMENUM=$P($$CLAIM^BPSBUTL(RX,RFL),U,6)
 Q ECMENUM
 ;
RXNUM(ECME) ; Returns the Rx number for a specific ECME number
 ;
 N FOUND,MAX,LFT,RAD,I,DIR,RX,X,Y,DIRUT
 S ECME=+ECME,LFT=0,FOUND=0
 S MAX=$O(^PSRX(9999999999999),-1)  ; MAX = largest Rx ien on file
 ;
 ; Attempt left digit matching logic in this case only
 I $L(MAX)>7,$L(ECME)'>7 D
 . S LFT=$E(MAX,1,$L(MAX)-7)  ; LFT = left most digits
 . F RAD=LFT:-1:0 S RX=RAD*10000000+ECME I $D(^PSRX(RX,0)),$$ECMENUM(RX)'="" S FOUND=FOUND+1,FOUND(FOUND)=RX
 . Q
 ;
 ; Otherwise attempt a normal lookup
 E  S RX=ECME I $D(^PSRX(RX,0)),$$ECMENUM(RX)'="" S FOUND=FOUND+1,FOUND(FOUND)=RX
 ;
 I 'FOUND S FOUND=-1 G RXNUMX            ; Rx not found
 I FOUND=1 S FOUND=FOUND(1) G RXNUMX     ; exactly 1 found
 ;
 ; More than 1 found so build a list and ask
 W ! F I=1:1:FOUND W !?5,I,". ",$$GET1^DIQ(52,FOUND(I),.01),?25,$$GET1^DIQ(52,FOUND(I),6)
 W ! S DIR(0)="NA^1:"_FOUND,DIR("A")="Select one: ",DIR("B")=1
 D ^DIR I $D(DIRUT) S FOUND=-1 G RXNUMX
 S FOUND=FOUND(Y)
 ;
RXNUMX ;
 Q FOUND
 ;
ELIG(RX,RFL,PSOELIG) ;Stores eligibility flag
 I RFL>0,'$D(^PSRX(RX,1,RFL,0)) QUIT
 N DA,DIE,X,Y,PSOTRIC
 I 'RFL S DA=RX,DIE="^PSRX(",DR="85///"_PSOELIG D ^DIE
 I RFL S DA=RFL,DA(1)=RX,DIE="^PSRX("_DA(1)_",1,",DR="85///"_PSOELIG D ^DIE
 Q
 ;
ECMESTAT(RX,RFL) ;called from local mail
 ;Input: 
 ; RX = Prescription File IEN
 ; RFL = Refill
 ;Output:
 ; 0 for not allowed to print from suspense
 ; 1 for allowed to print from suspense
 ;
 N STATUS,SHDT,PSOTRIC,TRICCK
 S STATUS=$$STATUS^PSOBPSUT(RX,RFL)
 ;IN PROGRESS claims - try again.  If still IN PROGRESS, do not allow to print
 I STATUS["IN PROGRESS" H 5 S STATUS=$$STATUS^PSOBPSUT(RX,RFL) I STATUS["IN PROGRESS" Q 0
 ;no ECME status, allow to print.  This will eliminate 90% of the cases
 I STATUS="" Q 1
 ;check for TRICARE/CHAMPVA rejects, not allowed to go to print until resolved.
 ;it does not matter much for this API but usually TRICARE/CHAMPVA processing is done first.
 S PSOTRIC="",PSOTRIC=$$TRIC^PSOREJP1(RX,RFL,.PSOTRIC)
 ;Add TRIAUD - if RX/RFL is in audit, allow to print even if not payable; PSO*7*358, cnf
 I PSOTRIC,STATUS'["PAYABLE",'$$TRIAUD^PSOREJU3(RX,RFL) Q 0
 ;DUR (88)/RTS (79) reject codes are not allowed to print until resolved.
 I $$FIND^PSOREJUT(RX,RFL,,"79,88") Q 0
 ;check for suspense hold date/host reject errors
 I $$DUR(RX,RFL)=0 Q 0
 Q 1
 ;
 ;Description:
 ;This function checks to see if a RX should be submitted to ECME
 ;Submit when:
 ;  RX/Fill was not submitted before (STATUS="")
 ;  Previous submission had Host Reject Error Code(s)
 ;Input:
 ;  RX = Prescription file #52 IEN
 ;  RFL = Refill number
 ;Returns:
 ;  1 = OK to resubmit
 ;  0 = Don't resubmit
ECMEST2(RX,RFL) ;
 N STATUS
 S STATUS=$$STATUS^PSOBPSUT(RX,RFL)
 ; Never submitted before, OK to submit
 I STATUS="" Q 1
 ; If status other than E REJECTED, don't resubmit
 I STATUS'="E REJECTED" Q 0
 ; Check for host reject codes(s)
 Q $$HOSTREJ(RX,RFL,1)
 ;
 ;Description: ePharmacy
 ;This subroutine checks an RX/FILL for Host Reject Errors returned
 ;from previous ECME submissions. The host reject errors checked are M6, M8, NN, and 99.
 ;Note that host reject errors do not pass to the pharmacy reject worklist so it's necessary
 ;to check ECME for these type errors.
 ;Input: 
 ; RX = Prescription File IEN
 ; RFL = Refill
 ; ONE = Either 1 or 0 - Defaults to 1
 ; If 1, At least ONE reject code associated with the RX/FILL must 
 ;   match either M6, M8, NN, or 99.
 ; If 0, ALL reject codes must match either M6, M8, NN, or 99
 ; REJ = (o) reject information from called from routine to be passed back. (contains data returned from DUR1^BPSNCPD3)
 ;Return:
 ; 0 = no host rejects exists based on ONE parameter
 ; 1 = host reject exists based on ONE parameter
HOSTREJ(RX,RFL,ONE) ; called from PSXRPPL2 and this routine
 N IDX,TXT,CODE,HRCODE,HRQUIT,RETV,REJ,I
 S IDX="",(RETV,HRQUIT)=0
 I '$D(ONE) S ONE=1
 ;for print from suspense there will only be primary insurance or an index of 1 in REJ array
 D DUR1^BPSNCPD3(RX,RFL,.REJ) ; Get reject list from last submission if not present
 S TXT=$G(REJ(1,"REJ CODE LST"))
 Q:TXT="" 0
 I ONE=0,TXT'["," S ONE=1
 F I=1:1:$L(TXT,",") S CODE=$P(TXT,",",I) D  Q:HRQUIT
 . F HRCODE=99,"M6","M8","NN" D  Q:HRQUIT
 . . I CODE=HRCODE S RETV=1 I ONE S HRQUIT=1 Q
 . . I CODE'=HRCODE,RETV=1 S RETV=0,HRQUIT=1 Q
 Q RETV
 ;
 ;Description: 
 ;Input: RX = Prescription file #52 IEN
 ; RFL = Refill number
 ;Returns: A value of 0 (zero) will be returned when reject codes M6, M8,
 ;NN, and 99 are present OR if on susp hold which means the prescription should not 
 ;be printed from suspense. Otherwise, a value of 1(one) will be returned.
DUR(RX,RFL) ;
 N REJ,IDX,TXT,CODE,SHOLD,SHCODE,ESTAT,SHDT
 S SHOLD=1,IDX=""
 I '$D(RFL) S RFL=$$LSTRFL^PSOBPSU1(RX)
 S SHDT=$$SHDT(RX,RFL) ; Get suspense hold date for rx/refill
 I SHDT'="",SHDT'<$$FMADD^XLFDT(DT,1) Q 0
 I $$HOSTREJ^PSOBPSU2(RX,RFL,1) I SHDT="" S SHOLD=0 D SHDTLOG(RX,RFL)
 Q SHOLD
 ;
 ;Description: This subroutine sets the EPHARMACY SUSPENSE HOLD DATE field
 ;for the rx or refill to tomorrow and adds an entry to the SUSPENSE Activity Log.
 ;Input: RX = Prescription File IEN
 ; RFL = Refill
SHDTLOG(RX,RFL) ;
 N DA,DIE,DR,COMM,SHDT
 I '$D(RFL) S RFL=$$LSTRFL^PSOBPSU1(RX)
 S SHDT=$$FMADD^XLFDT(DT,1)
 S COMM="SUSPENSE HOLD until "_$$FMTE^XLFDT(SHDT,"2D")_" due to host reject error."
 I RFL=0 S DA=RX,DIE="^PSRX(",DR="86///"_SHDT D ^DIE
 E  S DA=RFL,DA(1)=RX,DIE="^PSRX("_DA(1)_",1,",DR="86///"_SHDT D ^DIE
 D RXACT(RX,RFL,COMM,"S",+$G(DUZ)) ; Create Activity Log entry
 Q
 ;
 ;Description: This function returns the EPHARMACY SUSPENSE HOLD DATE field
 ;for the rx or refill
 ;Input: RX = Prescription File IEN
 ; RFL = Refill
SHDT(RX,RFL) ;
 N FILE,IENS
 I '$D(RFL) S RFL=$$LSTRFL^PSOBPSU1(RX)
 S FILE=$S(RFL=0:52,1:52.1),IENS=$S(RFL=0:RX_",",1:RFL_","_RX_",")
 Q $$GET1^DIQ(FILE,IENS,86,"I")
 ;
ELOG(RESP) ; - due to size of PSOBPSU1 exceeding limit 
 ; -Logs an ECME Activity Log if Rx Qty is different than Billing Qty
 I '$G(RESP),$T(NCPDPQTY^PSSBPSUT)'="" D
 . N DRUG,RXQTY,BLQTY,BLDU,Z
 . S DRUG=$$GET1^DIQ(52,RX,6,"I")
 . S RXQTY=$S('RFL:$$GET1^DIQ(52,RX,7,"I"),1:$$GET1^DIQ(52.1,RFL_","_RX,1))/1
 . S Z=$$NCPDPQTY^PSSBPSUT(DRUG,RXQTY),BLQTY=Z/1,BLDU=$P(Z,"^",2)
 . I RXQTY'=BLQTY D
 . . D RXACT(RX,RFL,"BILLING QUANTITY submitted: "_$J(BLQTY,0,$L($P(BLQTY,".",2)))_" ("_BLDU_")","M",DUZ)
 Q
 ;
UPDFL(RXREC,SUB,INDT) ;update fill date with release date when NDC changes at CMOP and OPAI auto-release
 ;Input: RXREC = Prescription File IEN
 ;         SUB = Refill
 ;        INDT = Release date
 N DA,DIE,DR,PSOX,SFN,DEAD,SUB,XOK,OLD,X,II,EXDAT,OFILLD,COM,CNT,RFCNT,RF
 S DEAD=0,SFN=""
 S EXDAT=INDT I EXDAT["." S EXDAT=$P(EXDAT,".")
 I '$D(SUB) S SUB=0 F II=0:0 S II=$O(^PSRX(RXREC,1,II)) Q:'II  S SUB=+II
 I 'SUB S OFILLD=$$GET1^DIQ(52,RXREC,22,"I") Q:OFILLD=EXDAT  D
 .S (X,OLD)=$P(^PSRX(RXREC,2),"^",2),DA=RXREC,DR="22///"_EXDAT_";101///"_EXDAT,DIE=52
 .D ^DIE K DIE,DA
 I SUB S (OLD,X)=+$P($G(^PSRX(RXREC,1,SUB,0)),"^"),DA(1)=RXREC,DA=SUB,OFILLD=$$GET1^DIQ(52.1,DA_","_RXREC,.01,"I") Q:OFILLD=EXDAT  D
 . S DIE="^PSRX("_DA(1)_",1,",DR=".01///"_EXDAT D ^DIE K DIE S $P(^PSRX(RXREC,3),"^")=EXDAT
 Q:$D(DTOUT)!($D(DUOUT))
 S DA=RXREC
 D AREC^PSOSUCH1
FIN ;
 Q
