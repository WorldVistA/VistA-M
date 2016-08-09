FBUTL135 ;DSS/LJF - FEE BASIS UTILITY FOR UNIQUE CLAIM ID - FEE5010 ;3/23/2012
 ;;3.5;FEE BASIS;**135,166**;JAN 30, 1995;Build 7
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
UCLAIMNO(FBSTA,FBSRC,FBINT,FBCLT,FBCLAIMS) ; Unique Claim Identifier for patch 135
 N FBFDA,FBHELD,FBYEAR,FBINTDF,FBCLTDF,FBSRCDF,FBSTADF
 ; Input:  FBSTA = Station
 ;         FBSRC = Source
 ;         FBINT = Initiation Type
 ;         FBCLT = Claim Type
 ;         FBCLAIMS = FPPS CLAIM ID - replaces sequence number
 ; Output: 21 character string composed of the following characters:
 ;           1-5    5 Character Station ID - left justified with trailing Zero's
 ;           6      1 Character Source - 1=Fee, 2=FBCS, 3=VAPM, 4-9 - Future Use, default is 1
 ;           7      1 character Initiation Type - (S)canned, (E)DI, (M)anual   ; default is M
 ;           8      1 Character Claim Type - (I)nstitutional, (P)rofessional, (D)ental, (N)on-Standard    ; default is N
 ;           9-12   4 digit year
 ;           13     1 character "-" 
 ;           14-28  15 character SEQUENCE NUMBER unique to the year - reinitialized when year changes
 ;                  or:  the number supplied in FBCLAIMS - NOTE: this value will be limited to 15 digits
 ; UCID example without FBCLAIMS supplied : 500001MN2012-291
 ;
 S FBSRCDF="1",FBINTDF="M",FBCLTDF="N",FBCLAIMS=$G(FBCLAIMS)   ; Defaults
 S FBSTA=$E($S($G(FBSTA)]"":FBSTA,1:$$STATION)_"00000",1,5)   ; Station
 ; Get first non space character for each input string;
 S FBSRC=$E($S(+$G(FBSRC):+FBSRC,1:FBSRCDF),1)              ; Source
 S FBINT=$E($TR($G(FBINT,FBINTDF)," ")),FBINT=$S(FBINT="":FBINTDF,"SEM"[FBINT:FBINT,1:FBINTDF)   ; Initiation Type
 S FBCLT=$E($TR($G(FBCLT,FBCLTDF)," ")),FBCLT=$S(FBCLT="":FBCLTDF,"IPDN"[FBCLT:FBCLT,1:FBCLTDF)  ; Claim Type
 I FBCLAIMS="" S FBCLAIMS=$$CLAIMNO                                             ; Generate Claim number if needed
 Q (FBSTA_FBSRC_FBINT_FBCLT_$E(FBCLAIMS,1,20))
 ;
CLAIMNO() ; Return the value of field 39: UNIQUE CLAIM IDENTIFIER SEQ from file 161.4: FEE BASIS SITE PARAMETERS - incremented by one
 N FBCLAIMS,FBYEAR
 S FBCLAIMS=$E($TR($$NOW^XLFDT,".")_"000000000",1,15)  ;default if can't lock global
 ; Lock the global node and set sequence number
 F FBHELD=1:1:10 L +^FBAA(161.4,1,2):$G(DILOCTM,3) I  D  L -^FBAA(161.4,1,2) Q
 . S FBCLAIMS=$$GET1^DIQ(161.4,1,39,"I"),FBYEAR=+$P($$HTE^XLFDT($H)," ",3)
 . I FBYEAR'=$P(FBCLAIMS,"-") S FBCLAIMS="-0" ;reinit sequence when year changes
 . S FBCLAIMS=FBYEAR_"-"_(1+$P(FBCLAIMS,"-",2))
 . S FBFDA(161.4,"1,",39)=FBCLAIMS D FILE^DIE(,"FBFDA") ; increment and file
 Q FBCLAIMS
 ;
VALIDATE(TYPE,UCID) ;
 N VALID,FBSTA,FBSRC,FBINT,FBCLMT
 S VALID=0
 I TYPE="I" D  Q VALID
 . I $L(UCID)<14 Q  ; needs to be at least 14 characters long
 . S FBSTA=$E(UCID,1,5)
 . S FBSRC=$E(UCID,6)
 . S FBINT=$E(UCID,7)
 . S FBCLMT=$E(UCID,8)
 . S $E(UCID,1,8)=""
 . I FBSRC,"SEM"[FBINT,FBCLMT="I",UCID?4N1"-"1.15N S VALID=1
 I TYPE="O" D  Q VALID
 . I $L(UCID)<14 Q  ; needs to be at least 14 characters long
 . S FBSTA=$E(UCID,1,5)
 . S FBSRC=$E(UCID,6)
 . S FBINT=$E(UCID,7)
 . S FBCLMT=$E(UCID,8)
 . S $E(UCID,1,8)=""
 . I FBSRC,"SEM"[FBINT,"PDN"[FBCLMT,UCID?4N1"-"1.15N S VALID=1
 Q VALID
 ;
STATION() ;  Set station
 N FBAASN,FBPOP,FBSITE,FBSN,FB
 D STATION^FBAAUTL S FBSN=$E(FBSN_"00000",1,5)
 Q FBSN
 ;
INVUCID(FBAAIN,FBSTA,FBSRC,FBINTYP,FBCLAIMS)  ; populates file 162.5 field UCID and returns UCID
 N UCID,FBDAT,FBMSG,FBCLTYP
 ;FBAAIN = IEN of entry in file 162.5
 ;FBSTA = Station ID
 ;FBSRC = Source - 1=Fee, 2=FBCS, 3=VAPM, 4-9 - Future Use
 ;FBINTYP = Initiation Type - (S)canned, (E)DI, (M)anual
 ;FBCLAIMS = Claim Number in format YYYY-nnnn format
 ;
 S UCID="-1",FBCLTYP="I" ;- Claim Type is always - 'I'nstitution - for this API
 I $G(FBAAIN),$G(FBSTA)]"",$G(FBSRC)]"",$G(FBINTYP)]"",$G(FBCLAIMS)]""     ; Validate all input parameters populated
 E  D  Q UCID
 . S:'$G(FBAAIN) UCID=UCID_U_"UNDEFINED INVOICE IEN" S:$G(FBSTA)="" UCID=UCID_U_"UNDEFINED STATION"
 . S:$G(FBSRC)="" UCID=UCID_U_"UNDEFINED SOURCE" S:$G(FBINTYP)="" UCID=UCID_U_"UNDEFINED INITIATION TYPE"
 . S:$G(FBCLAIMS)="" UCID=UCID_U_"UNDEFINED CLAIM NUMBER"
 ; Validate paramaters contain acceptable values
 I $L(FBSTA)<3 S UCID=UCID_U_"INVALID STATION PARAMETER"
 I FBSRC,FBSRC?1N
 E  S UCID=UCID_U_"INVALID SOURCE PARAMETER"
 I "SEM"[FBINTYP,$L(FBINTYP)=1
 E  S UCID=UCID_U_"INVALID INITIATION TYPE PARAMETER"
 I FBCLAIMS'?4N1"-"1.15N S UCID=UCID_U_"INVALID CLAIM NUMBER PARAMETER"
 I '$D(^FBAAI(FBAAIN)) S UCID=UCID_U_"INVALID ENTRY IN FILE 162.5: "_$NA(^FBAAI(FBAAIN))
 I $L(UCID)>2 Q UCID
 ; parameters passed muster
 S UCID=$$UCLAIMNO(FBSTA,FBSRC,FBINTYP,FBCLTYP,FBCLAIMS)
 S FBDAT(162.5,FBAAIN_",",85)=UCID
 D FILE^DIE(,"FBDAT","FBMSG")
 I $D(FBMSG("DIERR")) S UCID="-1^"_"DIERR TEXT: "_$G(FBMSG("DIERR","1","TEXT",1))_$NA(^FBAAI(FBAAIN))_"^UCID: "_UCID
 Q UCID
 ;
PAYUCID(DFN,FBV,FBSDI,FBAACPI,FBSTA,FBSRC,FBINTYP,FBCLTYP,FBCLAIMS)  ;populates file 162 field UCID and returns UCID - Outpatient
 N C,UCID,FBDAT,FBMSG
 ;DFN = IEN of PATIENT in 162
 ;FBV = IEN of VENDOR in 162
 ;FBSDI = IEN of INITIAL TREATMENT DATE multiple in 162
 ;FBAACPI = IEN of SERVICE PROVIDED multiple in 162
 ;FBSTA = Station ID
 ;FBSRC = Source - 1=Fee, 2=FBCS, 3=VAPM, 4-9 - Future Use
 ;FBINTYP = Initiation Type - (S)canned, (E)DI, (M)anual
 ;FBCLTYP = Claim Type - (I)nstitutional, (P)rofessional, (D)ental, (N)on-Standard
 ;FBCLAIMS = Claim Number in format YYYY-nnnn format
 ;
 S C=",",UCID="-1"
 I $G(DFN),$G(FBV),$G(FBSDI),$G(FBAACPI),$G(FBSTA)]"",$G(FBSRC),$G(FBINTYP)]"",$G(FBCLTYP)]"",$G(FBCLAIMS)]""  ; Validate all input parameters populated
 E  D  Q UCID
 . S:'$G(DFN) UCID=UCID_U_"UNDEFINED IEN of PATIENT" S:'$G(FBV) UCID=UCID_U_"UNDEFINED IEN of VENDOR"
 . S:'$G(FBSDI) UCID=UCID_U_"UNDEFINED IEN of INITIAL TREATMENT DATE" S:'$G(FBAACPI) UCID=UCID_U_"UNDEFINED IEN of SERVICE PROVIDED"
 . S:$G(FBSTA)="" UCID=UCID_U_"UNDEFINED STATION" S:'$G(FBSRC) UCID=UCID_U_"UNDEFINED SOURCE VALUE"
 . S:$G(FBINTYP)="" UCID=UCID_U_"UNDEFINED INITIATION TYPE" S:$G(FBCLTYP)="" UCID=UCID_U_"UNDEFINED CLAIM TYPE"
 . S:$G(FBCLAIMS)="" UCID=UCID_U_"UNDEFINED CLAIM NUMBER"
 ; Validate paramaters contain acceptable values
 I $L(FBSTA)<3 S UCID=UCID_U_"INVALID STATION PARAMETER"
 I FBSRC,FBSRC?1N
 E  S UCID=UCID_U_"INVALID SOURCE PARAMETER"
 I "SEM"[FBINTYP,$L(FBINTYP)=1
 E  S UCID=UCID_U_"INVALID INITIATION TYPE PARAMETER"
 I "PDN"[FBCLTYP,$L(FBCLTYP)=1
 E  S UCID=UCID_U_"INVALID CLAIM TYPE PARAMETER"
 I FBCLAIMS'?4N1"-"1.15NUL S UCID=UCID_U_"INVALID CLAIM NUMBER PARAMETER"
 I '$D(^FBAAC(DFN,1,FBV,1,FBSDI,1,FBAACPI)) S UCID=UCID_U_"INVALID ENTRY IN FILE 162: "_$NA(^FBAAC(DFN,1,FBV,1,FBSDI,1,FBAACPI))
 I $L(UCID)>2 Q UCID
 ; parameters passed muster
 S UCID=$$UCLAIMNO(FBSTA,FBSRC,FBINTYP,FBCLTYP,FBCLAIMS)
 S FBDAT(162.03,FBAACPI_C_FBSDI_C_FBV_C_DFN_C,81)=UCID
 D FILE^DIE(,"FBDAT","FBMSG")
 I $D(FBMSG("DIERR")) S UCID="-1^"_"DIERR TEXT: "_$G(FBMSG("DIERR","1","TEXT",1))_$NA(^FBAAC(DFN,1,FBV,1,FBSDI,1,FBAACPI))_"^UCID: "_UCID
 Q UCID
 ;
OCLMTYP(FBCURVAL) ; Get Outpatient Claim Type from the user
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DTOCNT
 S FBCURVAL=$G(FBCURVAL) I $G(FBCURVAL)]"","PDN"[FBCURVAL S DIR("B")=FBCURVAL
 S DIR(0)="SO^P:P;D:D;N:N"
 S DIR("L",1)="Select the Claim Type:"
 S DIR("L",2)=""
 S DIR("L")=" P - Professional,  D - Dental, N - Non-Standard"
 S DTOCNT=0
 F  D ^DIR D  Q:Y]""
 . I $G(DTOUT) S Y=$S(FBCURVAL]"":FBCURVAL,1:"N") Q  ; time out - set to "N"on-standard if no current value exists
 . I Y="" W !!,"This is a required response." Q
 . I Y="^" S Y="" W !!,"This is a required response. '^' is not allowed." K DUOUT Q
 . I Y="^^" S Y="" W !!,"This is a required response. '^' is not allowed." K DUOUT Q
 . I Y]"","PDN"[Y Q
 . S Y="" W !,"Enter a code from the list."
 Q Y
 ;
UCIDUTL()  ;EP for TEST report to validate UCID information for FB PATCH 135
 ;
 N DIR,FBQUIT,Y,FBSTG1,FBSRVC,FBPROG,FBID,DA,DUOUT,DIRUT,DTOUT,FBDONE
 ;
 S FBQUIT=0
 S FBDONE=0
 ;
 I $G(DUZ(2))="" D
 .W !,"DUZ NOT IDENTIFIED - PLEASE LOG IN BEFORE USING FB 135 TESTING UTILTIES"
 .S FBDONE=1
 ;
 D CLEAR()
 W !,?5,"FEE BASIS PATCH 135 UNIQUE CLAIM IDENTIFIER DISPLAY"
 F  Q:FBDONE  D
 .S DIR("A",1)="Select the UCID REPORT or the PROGRAM you are testing"
 .S DIR("A",2)="ENTER '^' or leave blank to EXIT"
 .S DIR("A")="SELECT"
 .S DIR(0)="SO^1:Outpatient and Inpatient UCID Display by Date Range Report"
 .S DIR(0)=DIR(0)_";3:Outpatient UCID Screen Display"
 .S DIR(0)=DIR(0)_";9:Inpatient UCID Screen Display"
 .S DIR("B")=""
 .D ^DIR
 .K DIR("A")
 .I $D(DUOUT) S FBDONE=1 ;DEFINED IF USER ENTERS ONE UP ARROW
 .I $D(DIRUT) S FBDONE=1 ;DEFINED IF USER ENTERS TWO UP ARROWS
 .I $D(DTOUT) S FBDONE=1  ;DEFINED IF USER TIMES OUT
 .I '+Y S FBDONE=1
 .Q:FBDONE
 .S FBPROG=+Y
 .I FBPROG=1 D UCIDRPT()
 .I FBPROG=9 D   ;INPATIENT
 ..S FBQUIT=0
 ..F  Q:FBQUIT  D
 ...S DIC=162.5  ;162.5 -- FEE BASIS INVOICE FILE
 ...S DIC(0)="AE"
 ...;S DIC("S")="I $P(^(0),U,9)="""""
 ...D ^DIC
 ...I $D(DUOUT) S FBQUIT=1
 ...I $D(DIRUT) S FBQUIT=1
 ...I $D(DTOUT) S FBQUIT=1
 ...I Y<0 S FBQUIT=1
 ...Q:FBQUIT
 ...I (Y>0) D
 ....;W !,"UCID: "_$P($G(^FBAAI(+Y,5)),U,5)
 ....S FBIEN=$P(Y,U,2)
 ....S FBNODE=^FBAAI(FBIEN,0)
 ....S FBDATE=$P(FBNODE,U,2)
 ....S FBVET=$P(FBNODE,U,4)   ;POINTER TO 161 - FEE BASIS PATIENT
 ....S FBPAT=$P(^FBAAA(FBVET,0),U,1)   ;POINTER TO FILE 2 - PATIENT
 ....S FBVNDR=$P(FBNODE,U,3)  ;POINTER TO FB VENDOR FILE
 ....S Y=FBDATE
 ....D DD^%DT
 ....W !,$P(^DPT(FBPAT,0),U,1)_"    "_$P(^FBAAV(FBVNDR,0),U,1)_"    "_Y
 ....W !?10,"UCID: "_$P($G(^FBAAI(FBIEN,5)),U,5)
 ....H:('FBDONE)&('FBQUIT) 3
 ...W !!
 .I FBPROG=3 D  ;OUTPATIENT
 ..S FBQUIT=0
 ..F  Q:FBQUIT  D
 ...S DIC="^FBAAC(" ;  162 -- FEE BASIS PAYMENT FILE
 ...S DIC(0)="AE"   ;
 ...D ^DIC   ;PATIENT SELECTION
 ...I $D(DUOUT) S FBQUIT=1
 ...I $D(DIRUT) S FBQUIT=1
 ...I $D(DTOUT) S FBQUIT=1
 ...Q:FBQUIT
 ...S DA(1)=+Y
 ...Q:'+$O(^FBAAC(DA(1),1,0))
 ...S DIC="^FBAAC("_DA(1)_",1,"
 ...D ^DIC
 ...I $D(DUOUT) S FBQUIT=1
 ...I $D(DIRUT) S FBQUIT=1
 ...I $D(DTOUT) S FBQUIT=1
 ...Q:FBQUIT
 ...I +Y<0 W !,"No Fee Basis Invoice Vendors found for this patient!" Q
 ...S DA(2)=DA(1)
 ...S DA(1)=+Y
 ...Q:'+$O(^FBAAC(DA(2),1,DA(1),1,0))
 ...S DIC="^FBAAC("_DA(2)_",1,"_DA(1)_",1,"     ;INITIAL TREATMENT DATE SELECTION
 ...D ^DIC
 ...I $D(DUOUT) S FBQUIT=1
 ...I $D(DIRUT) S FBQUIT=1
 ...I $D(DTOUT) S FBQUIT=1
 ...Q:FBQUIT
 ...I +Y<0 W !,"No Fee Basis Invoice DATE OF SERVICE found for this Vendor!" Q
 ...S DA(3)=DA(2)
 ...S DA(2)=DA(1)
 ...S DA(1)=+Y
 ...Q:'+$O(^FBAAC(DA(3),1,DA(2),1,DA(1),1,0))
 ...S FBSRVC=0
 ...F  S FBSRVC=$O(^FBAAC(DA(3),1,DA(2),1,DA(1),1,FBSRVC)) Q:'+FBSRVC  D
 ....S FBPNTR=$P($G(^FBAAC(DA(3),1,DA(2),1,DA(1),1,FBSRVC,0)),U,1)  ;POINTER TO 81 - CPT FILE
 ....W !,"SERVICE: ",$P($$CPT^ICPTCOD(FBPNTR),U,2),"  ",$P($$CPT^ICPTCOD(FBPNTR),U,3),?50,"UCID: "_$P($G(^FBAAC(DA(3),1,DA(2),1,DA(1),1,FBSRVC,5)),U,5) ;FB*3.5*166 - Update direct global reads of 81 file to API
 ...H:('FBDONE)&('FBQUIT) 3
 ...W !!
 .D CLEAR()
 Q
CLEAR()   ;CLEAR SCREEN
 N FBLINE
 F FBLINE=1:1:10 W !
 Q
UCIDRPT()  ;PROVIDES A REPORT OF ALL UCIDS IN THE SYSTEM FOR A DATE RANGE
 ;
 N DIR,FBQUIT,FBSTRT,FBEND,Y,FBSDATE,FBEDATE,FBDATE,FBINTLDT,FBPAT
 S FBQUIT=0
 S Y=DT
 D DD^%DT
 S FBTODAY=Y
 S DIR("A")="Enter the START DATE for UCID report"
 S DIR(0)="D"
 S DIR("B")=FBTODAY
 D ^DIR
 I $D(DUOUT) S FBQUIT=1
 I $D(DIRUT) S FBQUIT=1
 I $D(DTOUT) S FBQUIT=1
 S FBSTRT=Y
 I 'FBQUIT D
 .S DIR("A")="Enter the END DATE for UCID report"
 .S DIR(0)="D"
 .S DIR("B")=FBTODAY
 .D ^DIR
 .I $D(DUOUT) S FBQUIT=1
 .I $D(DIRUT) S FBQUIT=1
 .I $D(DTOUT) S FBQUIT=1
 .S FBEND=Y
 I 'FBQUIT D
 .D ^%ZIS
 .I 'POP D
 ..U IO
 ..S Y=FBSTRT
 ..D DD^%DT
 ..S FBSDATE=Y
 ..S Y=FBEND
 ..D DD^%DT
 ..S FBEDATE=Y
 ..W !,"OUTPATIENT INVOICES INITIAL SERVICES FROM: ",FBSDATE," TO: "_FBEDATE
 ..D OUTDSPLY(FBSTRT,FBEND)
 ..W !!,"CIVIL HOSPITAL INVOICES DATE RECEIVED FROM: ",FBSDATE," TO: "_FBEDATE
 ..D INDSPLY(FBSTRT,FBEND)
 .D ^%ZISC
 Q
OUTDSPLY(FBSTRT,FBEND)  ;DISPLAY OUTPATIENT UCID INFORMATION FOR A DATE RANGE
 ; INPUT : FBSTRT : A FM DATE REPRESENTING THE STARTING DATE FOR REPORT
 ;         FBEND  : A FM DATE REPRESENTING THE ENDING DATE FOR REPORT
 ;
 N FBIEN,FBVNDR,FBINTLDT,FBSRVC,FBSNUM
 S FBIEN=0
 F  S FBIEN=$O(^FBAAC(FBIEN)) Q:'+FBIEN  D
 .S FBVNDR=0
 .F  S FBVNDR=$O(^FBAAC(FBIEN,1,FBVNDR))  Q:'+FBVNDR  D
 ..S FBINTLDT=0
 ..F  S FBINTLDT=$O(^FBAAC(FBIEN,1,FBVNDR,1,FBINTLDT)) Q:'+FBINTLDT  D
 ...S FBDATE=$P(^FBAAC(FBIEN,1,FBVNDR,1,FBINTLDT,0),U,1)
 ...I (FBSTRT<=FBDATE)&(FBDATE<=FBEND) D
 ....W !
 ....;NOW PRINT OUT PATIENT NAME, VENDOR NAME, TREATMENT DATE, AND EACH SERVICE AND UCID
 ....S Y=FBDATE
 ....D DD^%DT
 ....W !,$P(^DPT(FBIEN,0),U,1)_"    "_$P(^FBAAV(FBVNDR,0),U,1)_"    "_Y
 ....S FBSNUM=0
 ....F  S FBSNUM=$O(^FBAAC(FBIEN,1,FBVNDR,1,FBINTLDT,1,FBSNUM)) Q:'+FBSNUM  D
 .....S FBSRVC=$P(^FBAAC(FBIEN,1,FBVNDR,1,FBINTLDT,1,FBSNUM,0),U,1)
 .....W !,"SERVICE: ",$P($$CPT^ICPTCOD(FBSRVC),U,2),"  ",$P($$CPT^ICPTCOD(FBSRVC),U,3),?50,"UCID: "_$P($G(^FBAAC(FBIEN,1,FBVNDR,1,FBINTLDT,1,FBSNUM,5)),U,5) ;FB*3.5*166 - Update direct global reads of 81 file to API
 Q
 ;
INDSPLY(FBSTRT,FBEND)  ;DISPLAY CIVIL HOSPITAL UCID INFORMATION FOR A DATE RANGE
 ; INPUT : FBSTRT : A FM DATE REPRESENTING THE STARTING DATE FOR REPORT
 ;         FBEND  : A FM DATE REPRESENTING THE ENDING DATE FOR REPORT
 N FBIEN,DBDATE,FBVET,FBPAT,FBVNDR
 S FBIEN=0
 F  S FBIEN=$O(^FBAAI(FBIEN)) Q:'+FBIEN  D
 .S FBNODE=^FBAAI(FBIEN,0)
 .S FBDATE=$P(FBNODE,U,2)
 .I (FBSTRT<=FBDATE)&(FBDATE<=FBEND) D
 ..W !
 ..S FBVET=$P(FBNODE,U,4)   ;POINTER TO 161
 ..S FBPAT=$P(^FBAAA(FBVET,0),U,1)   ;POINTER TO FILE 2
 ..S FBVNDR=$P(FBNODE,U,3)
 ..S Y=FBDATE
 ..D DD^%DT
 ..W !,$P(FBNODE,U,1)_"   "_$P(^DPT(FBPAT,0),U,1)_"   "_$P(^FBAAV(FBVNDR,0),U,1)_"   "_Y
 ..W !?10,"UCID: "_$P($G(^FBAAI(FBIEN,5)),U,5)
 Q
