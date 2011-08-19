RORRP026 ;HCIOFO/SG - RPC: CDC UTILITIES ; 5/19/06 2:52pm
 ;;1.5;CLINICAL CASE REGISTRIES;**1**;Feb 17, 2006;Build 24
 ;
 ;--------------------------------------------------------------------
 ; Registry: [VA HIV]
 ;--------------------------------------------------------------------
 Q
 ;
 ;***** POPULATES THE FDA WITH THE CDC DATA
 ;
 ; IENS          IENS of the record in the ROR HIV STUDY file
 ;
 ; TBLREF        Reference to a field table in the source code
 ;
 ; SRCBUF        Source data segment
 ;
 ; .FDA          Reference to a local variable where the FDA
 ;               nodes are created
 ;
 ; [.CACHE]      Reference to a local variable where the field
 ;               lists are cached.
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
CDCFDA(IENS,TBLREF,SRCBUF,RORFDA,CACHE) ;
 N BUF,FLD,I,POS,RC,RESULT,RORMSG,TGET,TMP,VAL
 S RC=0
 ;--- Prepare the fields (if they are not in the cache already)
 I $D(CACHE("CDCFLDS",TBLREF))<10  D  Q:RC<0 RC
 . S TGET="S BUF=$T("_$P(TBLREF,"^")_"+I^"_$P(TBLREF,"^",2)_")"
 . F I=1:1  X TGET  S BUF=$P(BUF,";;",2,999)  Q:BUF=""  D
 . . S FLD=$TR($P(BUF,U,2)," ")  Q:FLD'>0
 . . S TMP=+$TR($P(BUF,U)," ")
 . . I TMP'>0  S CACHE("CDCFLDS",TBLREF,+FLD)=""  Q
 . . S:FLD["D" TMP=TMP_"D" ; MM/YY field
 . . S:FLD["R" TMP=TMP_"R" ; Read-only field
 . . S CACHE("CDCFLDS",TBLREF,+FLD,$S(FLD["E":"E",1:"I"))=TMP
 ;--- Store the data into the FDA
 S FLD="",RC=0
 F  S FLD=$O(CACHE("CDCFLDS",TBLREF,FLD))  Q:FLD=""  D  Q:RC
 . S POS=$G(CACHE("CDCFLDS",TBLREF,FLD,"I"))
 . I POS'>0  S POS=$G(CACHE("CDCFLDS",TBLREF,FLD,"E"))  Q:POS'>0
 . Q:POS["R"  ; Skip read-only fields
 . S VAL=$P(SRCBUF,U,+POS)
 . I VAL=""  S RORFDA(799.4,IENS,FLD)=""  Q
 . ;--- Process the 'YY/MM' date field
 . I POS["D"  D  Q
 . . S TMP=$$DATE1(VAL)
 . . I TMP<0  S RC=(+POS)_U_$P(SRCBUF,U)  Q
 . . S RORFDA(799.4,IENS,FLD)=TMP
 . ;--- Precede the internal pointer value with the "`"
 . I +VAL=VAL  S:$$GET1^DID(799.4,FLD,,"TYPE")="POINTER" VAL="`"_VAL
 . ;--- Validate the value and store it into the FDA
 . D VAL^DIE(799.4,IENS,FLD,"FU",VAL,.RESULT,"RORFDA","RORMSG")
 . S:RESULT="^" RC=(+POS)_U_$P(SRCBUF,U)
 Q RC
 ;
 ;***** FORMATS THE FILEMAN DATE AS 'MM/YY' OR 'YYYY'
DATE(DATE) ;
 Q:DATE'>0 ""
 N MMYY,MONTH
 S MMYY=$TR($$FMTE^XLFDT(DATE,"6DF")," ","0")
 S MONTH=$P(MMYY,"/",2)
 Q $S(MONTH'="00":MONTH_"/"_$E($P(MMYY,"/",3),3,4),1:$P(MMYY,"/",3))
 ;
 ;***** CONVERTS THE 'MM/YY' OR 'YYYY' INTO THE FILEMAN DATE
DATE1(MMYY) ;
 Q:$G(MMYY)="" ""
 N DATE
 ;--- Just a year (YY or YYYY)
 I MMYY?.1(2N)2N  D  Q $G(DATE,-1)
 . D DT^DILF("EP",MMYY,.DATE)
 ;--- Month and year
 D DT^DILF("EP",$P(MMYY,"/",2),.DATE)
 I $G(DATE)>0  D  D DT^DILF("P",MMYY,.DATE)
 . S $P(MMYY,"/",2)=$G(DATE(0))
 Q $G(DATE,-1)
 ;
 ;***** LOADS THE DATA FROM THE 'ROR HIV STUDY' FILE
 ;
 ; IENS          IENS of the record in the ROR HIV STUDY file
 ;
 ; TBLREF        Reference to a field table in the source code
 ;
 ; DSTBUF        Reference to a local variable where the data
 ;               is returned to
 ;
 ; [.RORBUF]     Reference to a local variable where the source
 ;               field values are returned to (by GETS^DIQ)
 ;
 ; [.CACHE]      Reference to a local variable where the field
 ;               lists are cached.
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
LOAD(IENS,TBLREF,DSTBUF,RORBUF,CACHE) ;
 N BUF,FLD,I,RC,RORMSG,TGET,TMP
 S RC=0
 ;--- Prepare the fields (if they are not in the cache already)
 I $D(CACHE("CDCFLDS",TBLREF))<10  D  Q:RC<0 RC
 . S TGET="S BUF=$T("_$P(TBLREF,"^")_"+I^"_$P(TBLREF,"^",2)_")"
 . F I=1:1  X TGET  S BUF=$P(BUF,";;",2,999)  Q:BUF=""  D
 . . S FLD=$TR($P(BUF,U,2)," ")  Q:FLD'>0
 . . S TMP=+$TR($P(BUF,U)," ")
 . . I TMP'>0  S CACHE("CDCFLDS",TBLREF,+FLD)=""  Q
 . . S:FLD["D" TMP=TMP_"D"
 . . S CACHE("CDCFLDS",TBLREF,+FLD,$S(FLD["E":"E",1:"I"))=TMP
 . ;--- Create the list of fields for the GETS^DIQ
 . S (CACHE("CDCFLDS",TBLREF),FLD)=""
 . F  S FLD=$O(CACHE("CDCFLDS",TBLREF,FLD))  Q:FLD=""  D
 . . S CACHE("CDCFLDS",TBLREF)=CACHE("CDCFLDS",TBLREF)_FLD_";"
 ;--- Load the data from the file
 D GETS^DIQ(799.4,IENS,CACHE("CDCFLDS",TBLREF),"EI","RORBUF","RORMSG")
 I $G(DIERR)  D  Q RC
 . S RC=$$DBS^RORERR("RORMSG",-9,,,799.4,IENS)
 ;--- Store the data into the output buffer
 S FLD=""
 F  S FLD=$O(CACHE("CDCFLDS",TBLREF,FLD))  Q:FLD=""  D
 . S I=""
 . F  S I=$O(CACHE("CDCFLDS",TBLREF,FLD,I))  Q:I=""  D
 . . S TMP=CACHE("CDCFLDS",TBLREF,FLD,I)
 . . I '(TMP["D")  S $P(DSTBUF,U,+TMP)=$G(RORBUF(799.4,IENS,FLD,I))  Q
 . . S $P(DSTBUF,U,+TMP)=$$DATE($G(RORBUF(799.4,IENS,FLD,"I")))
 Q $S(RC<0:RC,1:0)
 ;
 ;***** RETURNS DATE FIELD NUMBER FOR THE POSITIVE HIV DETECTION TEST
PHIVFLD(TYPE) ;
 Q $S(TYPE=1:18.01,TYPE=2:18.02,TYPE=3:18.03,1:0)
 Q
 ;
CDCFLDS ;***** CDC FIELD TABLE
HDR ;
 ;;  3 ^  9.01I  ^ DATE CDC FORM COMPLETED
 ;;  4 ^         ^ CDC FORM COMPLETED BY (DUZ)
 ;;  5 ^         ^ CDC FORM COMPLETED BY (Name)
 ;;  6 ^         ^ Phone number of the person completed the form
CDM ;
 ;;  3 ^  9.02I  ^ STATUS AT REPORT
 ;;    ^  9.03I  ^ AGE AT HIV DIAGNOSIS
 ;;    ^  9.04I  ^ AGE AT AIDS DIAGNOSIS
 ;;  5 ^  9.9ER  ^ PATIENT STATUS
 ;;  6 ^  9.06I  ^ STATE/TERRITORY OF DEATH
 ;;  7 ^  9.07I  ^ COUNTRY OF BIRTH
 ;;    ^  9.08I  ^ DEPENDENCY OR POSSESSION NAME
 ;;    ^  9.09I  ^ OTHER COUNTRY DESCRIPTION
 ;;  9 ^  9.1I   ^ ONSET OF ILLNESS/AIDS- CITY
 ;; 10 ^  9.11I  ^ ONSET OF ILLNESS/AIDS- COUNTY
 ;; 11 ^  9.12I  ^ ONSET OF ILLNESS/AIDS- STATE (IEN)
 ;; 12 ^  9.12E  ^ ONSET OF ILLNESS/AIDS- STATE (Name)
 ;; 13 ^  9.13I  ^ ONSET OF ILLNESS/AIDS- COUNTRY
 ;; 14 ^  9.14I  ^ ONSET OF ILLNESS/AIDS- ZIP
FD ;
 ;;  3 ^ 12.01I  ^ AIDS DX - HOSPITAL
 ;;  4 ^ 12.02I  ^ AIDS DX - CITY
 ;;  5 ^ 12.03I  ^ AIDS DX - STATE (IEN)
 ;;  6 ^ 12.03E  ^ AIDS DX - STATE (Name)
 ;;  7 ^ 12.04I  ^ AIDS DX - COUNTRY
 ;;  8 ^ 12.05I  ^ AIDS DX - FACILITY SETTING
 ;;  9 ^ 12.06I  ^ AIDS DX - FACILITY TYPE
 ;; 10 ^ 12.07I  ^ AIDS DX - OTHER FACILITY TYPE
 ;
PH ;
 ;;  3 ^ 14.01I  ^ SEX RELATIONS W/MALE PARTNER
 ;;  4 ^ 14.02I  ^ SEX RELATIONS W/FEMALE PARTNER
 ;;  5 ^ 14.03I  ^ IV DRUGS AFTER 77 AND PRE HIV
 ;;  6 ^ 14.04I  ^ REC'D CLOTTING FACTORS
 ;;  7 ^ 14.05I  ^ TYPE OF HEMOPHILIA
 ;;  8 ^ 14.06I  ^ OTHER HEMOPHILIA DESCRIPTION
 ;;  9 ^ 14.07I  ^ SR WITH IV DRUG USER
 ;; 10 ^ 14.08I  ^ SR WITH BISEXUAL MAN
 ;; 11 ^ 14.09I  ^ SR W HEMOPHILIA/COAG DISORDER
 ;; 12 ^ 14.1I   ^ SR W TRANS RECIPIENT WITH AIDS
 ;; 13 ^ 14.11I  ^ TRANSPLANT RECIP-DOCUMNTD HIV
 ;; 14 ^ 14.12I  ^ SR W AIDS/HIV INFECTION
 ;; 15 ^ 14.13I  ^ TRANS AFTER 77 AND BEFORE HIV
 ;; 16 ^ 14.14ID ^ DATE OF FIRST TRANSFUSION
 ;; 17 ^ 14.15ID ^ DATE OF LAST TRANSFUSION
 ;; 18 ^ 14.16I  ^ TRANSPLANT OR ARTIF INSEMIN
 ;; 19 ^ 14.17I  ^ WORK IN HEALTH CARE OR LAB
 ;; 20 ^ 14.18I  ^ OCCUPATION
LD1 ;
 ;;  3 ^ 16.01I  ^ HIV-1 EIA
 ;;  4 ^ 16.02ID ^ HIV-1 EIA DATE
 ;;  5 ^ 16.03I  ^ HIV-1/HIV-2 EIA
 ;;  6 ^ 16.04ID ^ HIV-1/HIV-2 EIA DATE
 ;;  7 ^ 16.05I  ^ HIV-1 WESTERN BLOT/IFA
 ;;  8 ^ 16.06ID ^ HIV-1 WESTERN BLOT/IFA DATE
 ;;  9 ^ 16.07I  ^ OTHER HIV ANTIBODY TEST
 ;; 10 ^ 16.08ID ^ OTHER HIV ANTIBODY TEST DATE
 ;; 11 ^ 16.09I  ^ OTHER HIV ANTIBODY TEST DESC
 ;; 12 ^ 18.13I  ^ POSITIVE HIV DETECTION TEST
 ;;    ^ 18.01I  ^ HIV CULTURE DETECTION TEST
 ;;    ^ 18.02I  ^ HIV ANTIGEN DETECTION TEST
 ;;    ^ 18.03I  ^ HIV PCR, DNA, OR RNA PROBE
 ;; 14 ^ 18.04I  ^ TYPE OF OTHER POSITIVE TEST
 ;; 15 ^ 18.05ID ^ DATE OTHER POS DETECTION TEST
 ;; 16 ^ 18.1I   ^ DETECTABLE VIRAL LOAD TEST
 ;; 17 ^ 18.11I  ^ DETECTABLE VIRAL LOAD RESULT
 ;; 18 ^ 18.12ID ^ DETECTABLE VIRAL LOAD DATE
LD2 ;
 ;;  3 ^ 18.07I  ^ TYPE FOR LAST NEG TEST
 ;;  4 ^ 18.06ID ^ LAST DOCUMNTD NEG HIV TEST
 ;;  5 ^ 18.08I  ^ PHYS DOCUMNTD DIAGNOSIS?
 ;;  6 ^ 18.09ID ^ DATE PHYS DOCUMNTD DIAG
 ;;  7 ^ 20.01I  ^ CD4+ COUNT FOR CDC
 ;;  8 ^ 20.02ID ^ CD4+ COUNT FOR CDC DATE
 ;;  9 ^ 20.03I  ^ CD4+ PERCENT FOR CDC
 ;; 10 ^ 20.04ID ^ CD4+ PERCENT FOR CDC DATE
 ;; 11 ^ 20.05I  ^ CD4 COUNT FIRST <200
 ;; 12 ^ 20.06ID ^ CD4 COUNT FIRST <200 DATE
 ;; 13 ^ 20.07I  ^ CD4 PERCENT FIRST <14%
 ;; 14 ^ 20.08ID ^ CD4 PERCENT FIRST <14% DATE
CS ;
 ;;  3 ^ 11.01I  ^ RECORD REVIEWED
 ;;  4 ^ 11.02ID ^ DATE ASYMPTOMATIC
 ;;  5 ^ 11.03ID ^ DATE SYMPTOMATIC
 ;;  6 ^ 11.05I  ^ RVCT CASE NO.
 ;;  7 ^ 11.04I  ^ IMMUNODEF THAT DISQUALIFIES
TS1 ;
 ;;  3 ^ 22.01I  ^ PATIENT BEEN INFORMED OF HIV
 ;;  4 ^ 22.02I  ^ PARTNERS NOTIFIED BY
 ;;  5 ^ 22.03I  ^ HIV RELATED MED SERVICES
 ;;  6 ^ 22.09I  ^ SUBSTANCE ABUSE TREATMENT
 ;;  7 ^ 22.04I  ^ RCVD ANTI-RETROVIRAL THERAPY
 ;;  8 ^ 22.05I  ^ RECEIVED PCP PROPHYLAXIS
 ;;  9 ^ 22.06I  ^ ENROLLED AT CLINCAL TRIAL
 ;; 10 ^ 22.07I  ^ ENROLLED AT CLINIC
 ;; 11 ^ 22.08I  ^ PRIMARY REIMBURSER FOR MED RX
TS2 ;
 ;;  3 ^ 23.01I  ^ GYNECOLOGY OR OBSTETRIC CARE
 ;;  4 ^ 23.02I  ^ CURRENTLY PREGNANT
 ;;  5 ^ 23.03I  ^ DELIVERED LIVE BORN INFANT
 ;;  6 ^ 23.04I  ^ CHILD'S DATE OF BIRTH
 ;;  7 ^ 23.05I  ^ CHILD'S HOSPITAL OF BIRTH
 ;;  8 ^ 23.06I  ^ CHILD'S HOSPITAL - CITY
 ;;  9 ^ 23.07I  ^ CHILD'S HOSPITAL - STATE
