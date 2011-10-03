PSOPXRMU ;BHM/MFR - Set/Kill of Clinical Reminders Index;07/12/2004
 ;;7.0;OUTPATIENT PHARMACY;**118**;DEC 1997
 ;Reference to ^PXRMINDX supported by DBIA 4114
 ;
SKIDX(X,DA,NODE,CMD) ;Set/Kill Clinical Reminder Index
 ;Input: X(1) - DAYS SUPPLY, X(2)=RELEASED DATE/TIME
 ;       DA   - PRESCRIPTION file IEN
 ;       NODE - "O":Original; "R":Refill; "P":Partial
 ;       CMD  - "S":Set; "K": Kill
 ;
 N D0,DAS,DATE,DFN,DRUG,Z
 S D0=$S(NODE="O":DA,1:DA(1))
 S Z=$G(^PSRX(D0,0)),DFN=$P(Z,U,2),DRUG=$P(Z,U,6)
 I DFN=""!(DRUG="") Q
 S DATE=+$$FMADD^XLFDT(X(2),X(1))
 S DAS=DA_";2"
 S:NODE="R" DAS=DA(1)_";1;"_DA_";0"
 S:NODE="P" DAS=DA(1)_";P;"_DA_";0"
 ;
 I CMD="S" D
 . S ^PXRMINDX(52,"IP",DRUG,DFN,X(2),DATE,DAS)=""
 . S ^PXRMINDX(52,"PI",DFN,DRUG,X(2),DATE,DAS)=""
 I CMD="K" D
 . K ^PXRMINDX(52,"IP",DRUG,DFN,X(2),DATE,DAS)
 . K ^PXRMINDX(52,"PI",DFN,DRUG,X(2),DATE,DAS)
 Q
 ;
 ;=============================================
KNVA(X,DA) ;Delete index for NVA node.
 N DAS,START,STOP
 ;Reference to ^PXRMINDX("55NVA" is supported by DBIA# 4114.
 S START=$S(X(3)'="":X(3),1:X(2))
 S STOP=$S(X(4)'="":X(4),1:"U"_DA(1))
 S DAS=DA(1)_";NVA;"_DA_";0"
 K ^PXRMINDX("55NVA","IP",X(1),DA(1),START,STOP,DAS)
 K ^PXRMINDX("55NVA","PI",DA(1),X(1),START,STOP,DAS)
 Q
 ;
 ;=============================================
SNVA(X,DA) ;Set index for NVA node
 ;X(1)=PHARMACY ORDERABLE ITEM,X(2)=DOCUMENTED DATE,
 ;X(3)=START DATE (optional), X(4)=DISCONTINUED DATE (optional)
 ;Reference to ^PXRMINDX(55 is supported by DBIA# 4114.
 N DAS,START,STOP
 S START=$S(X(3)'="":X(3),1:X(2))
 S STOP=$S(X(4)'="":X(4),1:"U"_DA(1))
 S DAS=DA(1)_";NVA;"_DA_";0"
 S ^PXRMINDX("55NVA","IP",X(1),DA(1),START,STOP,DAS)=""
 S ^PXRMINDX("55NVA","PI",DA(1),X(1),START,STOP,DAS)=""
 Q
 ;
