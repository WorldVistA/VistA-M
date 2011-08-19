PSSWRNA ;BIR/EJW-API TO RETRIEVE WARNING LABEL LIST ;04/09/04
 ;;1.0;PHARMACY DATA MANAGEMENT;**87**;9/30/97
 ;
 ;Reference to ^PSNDF(50.68 supported by DBIA 3735
 ;Reference to ^PS(50.625 supported by DBIA 4445
 ;Reference to ^PS(50.626 supported by DBIA 4446
 ;Reference to ^PS(50.627 supported by DBIA 4448
DRUG(XX,DFN) ; Return warning labels numbers associated with this drug
 ;
 ; entry point from Outpatient Pharmacy and Consolidated Mail Outpatient Pharmacy
 ; Calling method: S WARN=$$DRUG^PSSWRNA(DRUG,DFN)
 ;
 ; Input: DRUG = IEN from the DRUG file (50)  ** REQUIRED **
 ; Input: DFN = IEN from the PATIENT file (2)  ** OPTIONAL **
 ;
 ; Output: WARN = List of warning numbers, separated by commas, associated with this drug. Warning numbers from the new data source will be followed by an "N".
 ;
 N I,PSSWSITE
 S PSSWRN=""
 S PSSWSITE=+$O(^PS(59.7,0)) I $P($G(^PS(59.7,PSSWSITE,10)),"^",9)="N" D WARNLST
 I PSSWRN="" S PSSWRN=$P($G(^PSDRUG(XX,0)),"^",8)
 D CHECKLST
 D CHECK20
 Q PSSWRN
 ;
CHECK20 ; WARNING LABEL 20 - 'DO NOT TRANSFER' REQUIRED FOR CONTROLLED SUBSTANCES
 N I
 S DEA=$P($G(^PSDRUG(XX,0)),"^",3)
 I DEA="" Q
 I "12345"'[$E(DEA) Q
 I ","_$P(PSSWRN,",",1,5)_","[",20," Q
 I $L(PSSWRN,",")<5 S PSSWRN=$S(PSSWRN="":20,1:PSSWRN_",20") Q
 S PSSWRN=$P(PSSWRN,",",1,4)_",20,"_$P(PSSWRN,",",5,99)
 F I=6:1:$L(PSSWRN,",") I $P(PSSWRN,",",I)=20 S PSSWRN=$P(PSSWRN,",",1,I-1) I $P(PSSWRN,",",I+1,99)'="" S PSSWRN=PSSWRN_","_$P(PSSWRN,",",I+1,99)_$P(PSSWRN,",",I+1,99) Q
 Q
 ;
WARNLST ; GET WARNING LIST FROM NEW DATA SOURCE OR USER-DEFINED NEW WARNING LABEL LIST
 S PSSWRN=$P($G(^PSDRUG(XX,"WARN")),"^") I PSSWRN'="" Q
 ; GET WARNINGS FROM NEW COMMERCIAL SOURCE
 N PSOPROD,GCNSEQNO,SEQ,NEWWARN,I
 S PSOPROD=$P($G(^PSDRUG(XX,"ND")),"^",3) I PSOPROD="" Q
 S GCNSEQNO=$$GET1^DIQ(50.68,PSOPROD,11,"I")
 I GCNSEQNO="" Q
GCN S I="" F  S I=$O(^PS(50.627,"B",GCNSEQNO,I)) Q:'I  I I D
 .S NEWWARN=$G(^PS(50.627,I,0)) I $P(NEWWARN,"^")=GCNSEQNO S SEQ=+$P(NEWWARN,"^",3) I SEQ>0 S NEWWARN(SEQ)=+$P(NEWWARN,"^",2)
 S SEQ=0 F  S SEQ=$O(NEWWARN(SEQ)) Q:'SEQ  S PSSWRN=$S(PSSWRN'="":PSSWRN_",",1:"")_NEWWARN(SEQ)_"N"
 Q
WARN54 ; VERIFY ENTRY EXISTS. IF NOT, REMOVE FROM WARNING LIST
 I '$D(^PS(54,WARN,1)) S PSSWRN=$P(PSSWRN,",",1,I-1)_$S(I=1:"",1:",")_$P(PSSWRN,",",I+1,99),I=I-1
 Q
NEWWARN ;
 I '$D(^PS(50.625,WARN,1)) S PSSWRN=$P(PSSWRN,",",1,I-1)_$S(I=1:"",1:",")_$P(PSSWRN,",",I+1,99),I=I-1
 Q
CHECKLST ;
 N WARN
 F I=1:1:$L(PSSWRN,",") S WARN=$P(PSSWRN,",",I) I WARN'="" D
 .I WARN'["N" D WARN54 Q
 .S WARN=+WARN D GENDER I WARN'="" D NEWWARN
 I $E(PSSWRN,$L(PSSWRN))="," S PSSWRN=$E(PSSWRN,1,($L(PSSWRN)-1))
 Q
GENDER ;
 I $G(DFN)="" Q
 N SEX,GENDER
 S GENDER=$$GET1^DIQ(50.625,WARN,2,"I") I GENDER="" Q
 I GENDER'="F",GENDER'="M" Q
 S SEX=$$GET1^DIQ(2,DFN,.02,"I")
 I $G(SEX)="" Q
 I SEX'="F",SEX'="M" Q
 I SEX'=GENDER,$$GET1^DIQ(50,XX,8.2,"I")="N" D
 .S PSSWRN=$P(PSSWRN,",",1,I-1)_$S(I=1:"",1:",")_$P(PSSWRN,",",I+1,99),I=I-1
 Q
WTEXT(WARN,LAN) ;
 ;
 ; entry point from Outpatient Pharmacy and Consolidated Mail Outpatient Pharmacy
 ; Calling method: S TEXT=$$WTEXT^PSSWRNA(WARN,LAN)
 ;
 ; Input: WARN = A warning label number from the old RX Consult file (#54) or the new WARNING LABEL-ENGLISH file (#50.625) followed by an "N".  ** REQUIRED **
 ; Note: there is a one-to-one correspondence for entries in the WARNING LABEL-ENGLISH file (#50.625) and the WARNING LABEL-SPANISH file (#50.626).
 ;
 ; LAN = Patient's PMI language preference. 2=Spanish. Anything less than 2 is English  ** OPTIONAL **
 ;
 ; Output: TEXT = Warning label text for the warning number. If LAN=2 the text will be returned in Spanish if a translation is available, otherwise the text will be returned in English.
 ;
 S TEXT=""
 I WARN'["N" D
 . I $G(LAN)=2 D
 .. I $D(^PS(54,WARN,3)) S TEXT=^(3)
 . I TEXT="" S JJJ=0 F  S JJJ=$O(^PS(54,WARN,1,JJJ)) Q:('JJJ)  D
 .. I $D(^PS(54,WARN,1,JJJ,0)) S TEXT=TEXT_$S(TEXT="":"",1:" ")_^(0)
 I WARN["N" D
 .I $G(LAN)'=2 D  Q 
 .. S PSOWRNN=+WARN I $D(^PS(50.625,PSOWRNN)) D
 ... S TEXT="",JJJ=0
 ... F  S JJJ=$O(^PS(50.625,PSOWRNN,1,JJJ)) Q:('JJJ)  D
 .... I $D(^PS(50.625,PSOWRNN,1,JJJ,0)) S TEXT=TEXT_$S(TEXT="":"",1:" ")_^(0)
 . S PSOWRNN=+WARN I $D(^PS(50.626,PSOWRNN)) D
 .. S TEXT="",JJJ=0
 .. F  S JJJ=$O(^PS(50.626,PSOWRNN,1,JJJ)) Q:('JJJ)  D
 ... I $D(^PS(50.626,PSOWRNN,1,JJJ,0)) S TEXT=TEXT_$S(TEXT="":"",1:" ")_^(0)
 Q TEXT
 ;
GENDER2 ;
 N I,WARN
 S GENDER=""
 I $G(PSSWRN)'["N" Q
 F I=1:1 S WARN=$P(PSSWRN,",",I) Q:WARN=""  D  Q:GENDER'=""
 .I WARN'["N" Q
 .S WARN=+WARN,GENDER=$$GET1^DIQ(50.625,WARN,2,"I")
 Q
 ;
