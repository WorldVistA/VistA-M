PSORLST2 ;BIRM/MFR - List of Patients/Prescriptions for Recall Notice ;12/30/09
 ;;7.0;OUTPATIENT PHARMACY;**348**;DEC 1997;Build 50
 ;
 ; Report Output fields ("^" separated):
 ; ------------------------------------
 ;    1. FILL TYPE (e.g.,\\ORIGINAL\)    2. RX #
 ;    3. DRUG NAME                       4. PATIENT NAME
 ;    5. SSN                             6. ADDRESS 1
 ;    7. ADDRESS 2                       8. ADDRESS 3
 ;    9. CITY                           10. STATE
 ;   11. ZIP                            12. PHONE (HOME)
 ;   13. PHONE (WORK)                   14. PHONE (CELL)
 ;   15. DECEASED?                      16. FILL #
 ;   17. ISSUE DATE                     18. FILL DATE
 ;   19. RELEASED DATE/TIME             20. EXPIRATION DATE
 ;   21. LOT #                          22. NDC
 ;   23. DIVISION                       24. PHARMACIST
 ;   25. PROVIDER                       26. PATIENT STATUS
 ;   27. QTY                            28. DAYS SUPPLY
 ;   29. # OF REFILLS                   30. MAIL/WINDOW
 ;   31. CMOP?                          32. PARTIAL REMARKS
 ;   33. TRANSMISSION NUMBER            34. SEQUENCE #
 ;   35. CMOP NDC                       36. DATE SHIPPED
 ;   37. CARRIER                        38. PACKAGE ID
 ;
PROCESS ; Use input search criteria to find matching orders, store in TMP global.
 N PSOFRMDT,PSOTODT,PSORX,PSOFILL,PSORDT,RXND0,RXND2,PSOPAT,REFILLS
 N PSORXDRG,NDC,LOT,PSODEAD,PTSTAT,OUTPUT,ISSDT,EXPDT,RX,FILL,PAT
 ;
 ; - Search Originals and Refills
 K ^TMP(+$J,"PSORLST")
 S PSOFRMDT=$P(PSODTRNG,"^"),PSOTODT=$P(PSODTRNG,"^",2)
 S PSORDT=$$FMADD^XLFDT(PSOFRMDT,,,,-1)
 F  S PSORDT=$O(^PSRX("AL",PSORDT)) Q:((PSORDT="")!(PSORDT>(PSOTODT_".24")))  D
 . S PSORX=0
 . F  S PSORX=$O(^PSRX("AL",PSORDT,PSORX)) Q:'PSORX  D
 . . S RXND0=$G(^PSRX(PSORX,0)),RXND2=$G(^PSRX(PSORX,2))
 . . S PSOPAT=$P(RXND0,"^",2) I 'PSOPAT Q
 . . S PSODEAD=+$G(^DPT(+PSOPAT,.35)) I ($G(PSOXDED))&$G(PSODEAD) Q
 . . S PSORXDRG=$P(RXND0,"^",6) I 'PSORXDRG Q
 . . I PSOMED'=1,'$D(PSODDRG(+PSORXDRG)) Q
 . . S PSOFILL=""
 . . F  S PSOFILL=$O(^PSRX("AL",PSORDT,PSORX,PSOFILL)) Q:PSOFILL=""  D
 . . . I '$$RXRLDT^PSOBPSUT(PSORX,PSOFILL) Q
 . . . I '$D(PSOSDIV(+$$RXSITE^PSOBPSUT(PSORX,PSOFILL))) Q
 . . . I PSOMED=1 S NDC=$$RAWNDC($$GETNDC^PSONDCUT(PSORX,PSOFILL)) Q:NDC=""  Q:'$D(PSONDC(NDC))
 . . . I PSOMED=2 S LOT=$$LOT(PSORX,PSOFILL) Q:LOT=""  Q:'$D(PSODDRG(+PSORXDRG,LOT))
 . . . S ^TMP($J,"PSORLST",$$GET1^DIQ(2,PSOPAT,.01),PSORX,PSOFILL)=""
 ;
 ; - Search Partials
 S PSORDT=$$FMADD^XLFDT(PSOFRMDT,,,,-1)
 F  S PSORDT=$O(^PSRX("AM",PSORDT)) Q:((PSORDT="")!(PSORDT>(PSOTODT_".24")))  D
 . S PSORX=0
 . F  S PSORX=$O(^PSRX("AM",PSORDT,PSORX)) Q:'PSORX  D
 . . S RXND0=$G(^PSRX(PSORX,0)),RXND2=$G(^PSRX(PSORX,2))
 . . S PSOPAT=$P(RXND0,"^",2) I 'PSOPAT Q
 . . S PSODEAD=+$G(^DPT(+PSOPAT,.35)) I ($G(PSOXDED))&$G(PSODEAD) Q
 . . S PSORXDRG=$P(RXND0,"^",6) I 'PSORXDRG Q
 . . I PSOMED'=1,'$D(PSODDRG(+PSORXDRG)) Q
 . . S PSOFILL=0
 . . F  S PSOFILL=$O(^PSRX("AM",PSORDT,PSORX,PSOFILL)) Q:'PSOFILL  D
 . . . I '$D(PSOSDIV(+$$GET1^DIQ(52.2,(+PSOFILL)_","_PSORX,.09,"I"))) Q
 . . . I PSOMED=1 S NDC=$$RAWNDC($$GET1^DIQ(52.2,(+PSOFILL)_","_PSORX,1)) S:NDC="" NDC=$$RAWNDC($P(RXND2,"^",7)) Q:NDC=""  Q:'$D(PSONDC(NDC))
 . . . I PSOMED=2 S LOT=$$LOT(PSORX,PSOFILL_"P") Q:LOT=""  Q:'$D(PSODDRG(+PSORXDRG,LOT))
 . . . S ^TMP($J,"PSORLST",$$GET1^DIQ(2,PSOPAT,.01),PSORX,PSOFILL_"P")=""
 ;
 M ^TMP("ANW")=^TMP($J,"PSORLST")
 I $D(^TMP($J,"PSORLST")) D
 . W !,"\\FILL TYPE\^RX #^DRUG NAME^PATIENT NAME^SSN^ADDRESS 1^ADDRESS 2^ADDRESS 3^"
 . W "CITY^STATE^ZIP^PHONE (HOME)^PHONE (WORK)^PHONE (CELL)^DECEASED?^FILL #^ISSUE DATE^"
 . W "FILL DATE^RELEASED DATE/TIME^EXPIRATION DATE^LOT #^NDC^DIVISION^PHARMACIST^PROVIDER^"
 . W "PATIENT STATUS^QTY^DAYS SUPPLY^# OF REFILLS^MAIL/WINDOW^CMOP?^PARTIAL REMARKS^"
 . W "TRANSMISSION NUMBER^SEQUENCE #^CMOP NDC^DATE SHIPPED^CARRIER^PACKAGE ID"
 . S (PAT,RX,FILL,OUTPUT)=""
 . F  S PAT=$O(^TMP($J,"PSORLST",PAT)) Q:PAT=""  D
 . . F  S RX=$O(^TMP($J,"PSORLST",PAT,RX)) Q:RX=""  D
 . . . S RXND0=$G(^PSRX(RX,0)),RXND2=$G(^PSRX(RX,2))
 . . . S ISSDT=$P(RXND0,"^",13) I ISSDT S ISSDT=$TR($$FMTE^XLFDT(ISSDT,2),"@"," ")
 . . . S EXPDT=$P(RXND2,"^",6) I EXPDT S EXPDT=$TR($$FMTE^XLFDT(EXPDT,2),"@"," ")
 . . . S PTSTAT=$P(RXND0,"^",3),PTSTAT=$P(^PS(53,+PTSTAT,0),"^")
 . . . S REFILLS=$P(RXND0,"^",9)
 . . . F  S FILL=$O(^TMP($J,"PSORLST",PAT,RX,FILL)) Q:FILL=""  D
 . . . . I FILL=0 D
 . . . . . S OUTPUT="\\ORIGINAL\^"_$$PATIENT(RXND0,RXND2)_"^"_$$ORIGINAL(RXND0,RXND2)_"^"_$$CMOP(RX,0)
 . . . . E  I FILL'["P" D
 . . . . . S OUTPUT="\\REFILL\^"_$$PATIENT(RXND0,RXND2)_"^"_$$REFILL(RX,FILL,RXND0,RXND2)_"^"_$$CMOP(RX,FILL)
 . . . . E  D
 . . . . . S OUTPUT="\\PARTIAL\^"_$$PATIENT(RXND0,RXND2)_"^"_$$PARTIAL(RX,+FILL,RXND0,RXND2)_"^^^^^^"
 . . . . S $P(OUTPUT,"^",17)=ISSDT
 . . . . S $P(OUTPUT,"^",20)=EXPDT
 . . . . S $P(OUTPUT,"^",26)=PTSTAT
 . . . . S $P(OUTPUT,"^",29)=REFILLS
 . . . . S $P(OUTPUT,"^",31)=$S($P(OUTPUT,"^",33)'="":"Y",1:"N")
 . . . . W !,OUTPUT
 E  D
 . W !!!?15,"*** NO RECORDS TO PRINT ***",!!!!
 ;
 K ^TMP($J,"PSORLST") D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
PATIENT(RXND0,RXND2) ; Build patient information (HEADER), store in ^TMP
 ; RXND0 - Prescription File (#52) zero node (^PSRX(RX,0))
 ; RXND2 - Prescription File (#52) two node (^PSRX(RX,2))
 ; Ouptput: RX #^DRUG NAME^PATIENT NAME^SSN^ADDRESS 1^ADDRESS 2^ADDRESS 3^CITY^STATE^ZIP^
 ;          PHONE (HOME)^PHONE (WORK)^PHONE (CELL)^DECEASED?
 ;
 N PATIENT,DFN,VADM,VAPA,DEAD,PHONES,RESID,WORK,CELL
 ;
 S DFN=$P(RXND0,"^",2) D DEM^VADPT,ADD^VADPT
 S DEAD=+$G(^DPT(+DFN,.35)),DEAD=$S(DEAD:"Y",1:"N")
 S PATIENT=$P(RXND0,"^")_"^"_$$GET1^DIQ(50,+$P(RXND0,"^",6),.01)_"^"_VADM(1)_"^"_$P(VADM(2),"^",2)
 S PATIENT=PATIENT_"^"_VAPA(1)_"^"_VAPA(2)_"^"_VAPA(3)_"^"_VAPA(4)_"^"_$P(VAPA(5),"^",2)_"^"_VAPA(6)
 S PHONES=$G(^DPT(+DFN,.13)),RESID=$P(PHONES,"^"),WORK=$P(PHONES,"^",2),CELL=$P(PHONES,"^",4)
 S PATIENT=PATIENT_"^"_RESID_"^"_WORK_"^"_CELL_"^"_DEAD
 Q PATIENT
 Q
 ;
ORIGINAL(RXND0,RXND2) ; Build output for specific original RX, store in ^TMP
 ; RXND0 - Prescription File (#52) zero node (^PSRX(RX,0))
 ; RXND2 - Prescription File (#52) two node (^PSRX(RX,2))
 ; Output: 0(Original)^ISSUE DATE^FILL DATE^RELEASED DATE/TIME^^LOT #^NDC^DIVISION (###)^
 ;         PHARMACIST^PROVIDER^^QTY^DAYS SUPPLY^# OF REFILLS^MAIL/WINDOW^^
 ;
 N ORIGINAL,FILLDT,RELDT,LOT,NDC,DIV,DIVNAM,DIVNUM,PHARM,PROV,MW,QTY,DAYS,Z
 ;
 S FILLDT=$P(RXND2,"^",2) I FILLDT S FILLDT=$TR($$FMTE^XLFDT(FILLDT,2),"@"," ")
 S RELDT=$P(RXND2,"^",13) I RELDT S RELDT=$TR($$FMTE^XLFDT(RELDT,2),"@"," ")
 S LOT=$P(RXND2,"^",4)
 S NDC=$P(RXND2,"^",7)
 S DIVNAM="",DIV=$P(RXND2,"^",9)
 S (DIVNAM,DIVNUM)="" I DIV S Z=$G(^PS(59,+DIV,0)),DIVNAM=$P(Z,"^"),DIVNUM=$P(Z,"^",6)
 S PHARM=$P($G(^VA(200,+$P(RXND2,"^",3),0)),"^")
 S PROV=$P($G(^VA(200,+$P(RXND0,"^",4),0)),"^")
 S QTY=$P(RXND0,"^",7),DAYS=$P(RXND0,"^",8)
 S MW=$S($P(RXND0,"^",11)="W":"WINDOW",1:"MAIL")
 S ORIGINAL="0^^"_FILLDT_"^"_RELDT_"^^"_LOT_"^"_NDC_"^"_DIVNAM_" ("_DIVNUM_")"
 S ORIGINAL=ORIGINAL_"^"_PHARM_"^"_PROV_"^^"_QTY_"^"_DAYS_"^^"_MW_"^^"
 Q ORIGINAL
 ;
REFILL(RX,REF,RXND0,RXND2) ; Build output for specific Refill, store in ^TMP
 ; REF - Refill Number
 ; RXND0 - Prescription File (#52) zero node (^PSRX(RX,0))
 ; RXND2 - Prescription File (#52) two node (^PSRX(RX,2))
 ; Output: FILL #^ISSUE DATE^FILL DATE^RELEASED DATE/TIME^^LOT #^NDC^DIVISION(###)^
 ;         PHARMACIST^PROVIDER^^QTY^DAYS SUPPLY^# OF REFILLS^MAIL/WINDOW^^
 ;
 N REFILL,RF0,RF1,RFILDT,RLSDT,QTY,DAYS,LOT,NDC,DIV,DIVNAM,DIVNUM,PROV,PHARM,MW,Z
 ;
 S RF0=$G(^PSRX(RX,1,REF,0))
 S RF1=$G(^PSRX(RX,1,REF,1))
 S RFILDT=$P(RF0,"^") I RFILDT S RFILDT=$TR($$FMTE^XLFDT(RFILDT,2),"@"," ")
 S RLSDT=$P(RF0,"^",18) I RLSDT S RLSDT=$TR($$FMTE^XLFDT(RLSDT,2),"@"," ")
 S LOT=$$LOT(RX,REF)
 S QTY=$P(RF0,"^",4)
 S DAYS=$P(RF0,"^",10)
 S NDC=$$GETNDC^PSONDCUT(RX,REF)
 S DIV=$P(RF0,"^",9) S:'DIV DIV=$P(RXND2,"^",9)
 S (DIVNAM,DIVNUM)="" I DIV S Z=$G(^PS(59,+DIV,0)),DIVNAM=$P(Z,"^"),DIVNUM=$P(Z,"^",6)
 S PHARM=$P(RF0,"^",5) S:'PHARM PHARM=$P(RXND2,"^",3) S PHARM=$P($G(^VA(200,+PHARM,0)),"^")
 S PROV=$P(RF0,"^",17) S:'PROV PROV=$P(RXND0,"^",4) S PROV=$P($G(^VA(200,+PROV,0)),"^")
 S MW=$S($P(RF0,"^",2)="W":"WINDOW",1:"MAIL")
 S REFILL=REF_"^^"_RFILDT_"^"_RLSDT_"^^"_LOT_"^"_NDC_"^"_DIVNAM_" ("_DIVNUM_")"
 S REFILL=REFILL_"^"_PHARM_"^"_PROV_"^^"_QTY_"^"_DAYS_"^^"_MW_"^^"
 Q REFILL
 ;
PARTIAL(RX,PAR,RXND0,RXND2) ; Build output for specific partial fill, store in ^TMP
 ; SEQ - Integer representing a specific Partial node from the Prescription file (#52)
 ; RXND0 - Prescription File (#52) zero node (^PSRX(RX,0))
 ; RXND2 - Prescription File (#52) two node (^PSRX(RX,2))
 ; Output: FILL #^ISSUE DATE^FILL DATE^RELEASED DATE/TIME^^LOT #^NDC^DIVISION(###)^
 ;         PHARMACIST^PROVIDER^^QTY^DAYS SUPPLY^# OF REFILLS^MAIL/WINDOW^CMOP?^REMARKS
 ;
 N PARTIAL,PT0,PARTDT,RLSDT,NDC,LOT,QTY,DAYS,DIV,DIVNUM,DIVNAM,PROV,PHARM,RMRKS,MW,RXNDP,Z
 S PT0=$G(^PSRX(RX,"P",PAR,0))
 S PARTDT=$P(PT0,"^") I PARTDT S PARTDT=$TR($$FMTE^XLFDT(PARTDT,2),"@"," ")
 S RLSDT=$P(PT0,"^",19) IF RLSDT S RLSDT=$TR($$FMTE^XLFDT(RLSDT,2),"@"," ")
 S LOT=$$LOT(RX,PAR_"P")
 S NDC=$P(PT0,"^",12) S:NDC="" NDC=$$GETNDC^PSONDCUT(RX,0)
 S QTY=$P(PT0,"^",4)
 S DAYS=$P(PT0,"^",10)
 S DIV=$P(PT0,"^",9) S:'DIV DIV=$P(RXND2,"^",9)
 S (DIVNAM,DIVNUM)="" I DIV S Z=$G(^PS(59,+DIV,0)),DIVNAM=$P(Z,"^"),DIVNUM=$P(Z,"^",6)
 S PHARM=$P(PT0,"^",5) S:'PHARM PHARM=$P(RXND2,"^",3) S PHARM=$P($G(^VA(200,+PHARM,0)),"^")
 S PROV=$P(PT0,"^",17) S:'PROV PROV=$P(RXND0,"^",4) S PROV=$P($G(^VA(200,+PROV,0)),"^")
 S MW=$S($P(PT0,"^",2)="W":"WINDOW",1:"MAIL")
 S RMRKS=$P(PT0,"^",3)
 S PARTIAL=PAR_"^^"_PARTDT_"^"_RLSDT_"^^"_LOT_"^"_NDC_"^"_DIVNAM_" ("_DIVNUM_")"
 S PARTIAL=PARTIAL_"^"_PHARM_"^"_PROV_"^^"_QTY_"^"_DAYS_"^^"_MW_"^N^"_RMRKS
 Q PARTIAL
 ;
CMOP(RX,FILL) ; Build output for CMOP fields
 ; RX   - Prescription file (#52) IEN
 ; FILL - Fill # (0 - Original, 1 - Refill #1, 2 - Refill #2, etc...)
 ; Output: TRANSMISSION NUMBER^SEQUENCE #^CMOP NDC^DATE SHIPPED^CARRIER^PACKAGE ID
 ;
 N CMOP,CMOPSEQ,Z0,Z1
 ;
 S CMOP="^^^^^"
 I '$D(^PSRX(RX,4)) Q CMOP
 ;
 S CMOPSEQ=0 F  S CMOPSEQ=$O(^PSRX(RX,4,CMOPSEQ)) Q:'CMOPSEQ  D
 . S Z0=$G(^PSRX(RX,4,CMOPSEQ,0))
 . I $P(Z0,"^",3)'=FILL!($P(Z0,"^",4)'=1) Q
 . S CMOP=$P(Z0,"^",1)_"^"_$P(Z0,"^",2)_"^"_$P(Z0,"^",8)
 . S Z1=$G(^PSRX(RX,4,CMOPSEQ,1))
 . S CMOP=CMOP_"^"_$TR($$FMTE^XLFDT($P(Z1,"^",2),2),"@"," ")_"^"_$P(Z1,"^",3)_"^"_$P(Z1,"^",4)
 ;
 Q CMOP
 ;
LOT(RX,FILL) ; Returns the LOT# for a specific Fill
 ; Input:  (r) RX   - Rx IEN (#52)
 ;         (r) FILL - Refill #/Partial # (note: Partials contain a "P", e.g. "1P")
 ; Output:     LOT  - Rx Drug Lot #
 N LOT S LOT=""
 I (FILL["P") D
 . S LOT=$$GET1^DIQ(52.2,(+FILL)_","_RX,.06)
 E  I (FILL>0) S LOT=$$GET1^DIQ(52.1,(+FILL)_","_RX,5)
 I (FILL=0)!(LOT="") D
 . S LOT=$$GET1^DIQ(52,RX,24)
 ;
 Q LOT
RAWNDC(NDC) ; Returns NDC without dashes ('-') or spaces (' ')
 Q $TR($TR(NDC,"-","")," ","")
