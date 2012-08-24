PXRMENOD ;SLC/PKR - Clinical Reminders "E" node routines. ;05/13/2010
 ;;2.0;CLINICAL REMINDERS;**4,6,18**;Feb 04, 2005;Build 152
 ;
 ;========================================================
DEPLIST(IEN,DEP) ;Build the evaluation dependency list.
 N BDT,EDT,FI1,FI2,TEMP
 S FI1=0
 F  S FI1=+$O(^PXD(811.9,IEN,20,FI1)) Q:FI1=0  D
 . S TEMP=^PXD(811.9,IEN,20,FI1,0)
 . S BDT=$P(TEMP,U,8)
 . S EDT=$P(TEMP,U,11)
 . S DEP(FI1)=""
 . I BDT["FIEVAL" S FI2=$E(BDT,8,$F(BDT,",")-2),DEP(FI1,FI2)="BDT"
 . I EDT["FIEVAL" S FI2=$E(EDT,8,$F(EDT,",")-2),DEP(FI1,FI2)="EDT"
 Q
 ;
 ;========================================================
EVORDER(DEP,EORDER,NODEP,ERROR) ;Determine the evaluation order for findings
 ;that depend of the date of other findings. The structure of EORDER
 ;is EORDER(N)=finding number, where N is the evaluation order.
 N CLIST,DONE,IND,JND,KND,ONLIST,NUM
 ;Check for reflective dependencies.
 S IND="",ERROR=0
 F  S IND=$O(DEP(IND)) Q:IND=""  D
 . I $D(DEP(IND))=1 Q
 . S JND=IND-1
 . F  S JND=$O(DEP(IND,JND)) Q:JND=""  D
 .. I $D(DEP(JND,IND)) D
 ... W !,"Error: date of finding ",IND," depends of date of finding ",JND," and"
 ... W !,"       date of finding ",JND," depends on date of finding ",IND
 ... S ERROR=1
 I ERROR Q
 ;No errors found, build evaluation order lists.
 ;First check for findings with no dependencies.
 S IND=""
 F  S IND=$O(DEP(IND)) Q:IND=""  I $D(DEP(IND))=1 S NODEP(IND)=""
 ;Build the dependency list.
 S IND="",NUM=0
 F  S IND=$O(DEP(IND)) Q:IND=""  D
 . I $D(NODEP(IND)) Q
 . S JND=""
 . F  S JND=$O(DEP(IND,JND)) Q:JND=""  D
 .. I $D(NODEP(JND)) Q
 .. S KND="",ONLIST=0
 .. F  S KND=$O(EORDER(KND)) Q:KND=""  I EORDER(KND)=JND S ONLIST=1
 .. I 'ONLIST S NUM=NUM+1,EORDER(NUM)=JND
 . S KND="",ONLIST=0
 . F  S KND=$O(EORDER(KND)) Q:KND=""  I EORDER(KND)=IND S ONLIST=1
 . I 'ONLIST S NUM=NUM+1,EORDER(NUM)=IND
 I '$D(EORDER) Q
 ;Check for circular dependencies.
 S DONE=0
 S IND=EORDER(1),CLIST(IND)=""
 F  Q:DONE  D
 . S JND=$O(DEP(IND,""))
 . I JND="" S DONE=1 Q
 . I $D(CLIST(JND)) S (DONE,ERROR)=1 Q
 . S CLIST(JND)=""
 . S IND=JND
 I ERROR D
 . W !,"Error: found circular redundancy."
 . S IND=""
 . F  S IND=$O(CLIST(IND)) Q:IND=""  D
 .. S JND=$O(DEP(IND,""))
 .. W !," Finding ",IND," depends on finding ",JND
 Q
 ;
 ;========================================================
KENODE(X,DA) ;Kill the "E" node in the finding multiple for terms.
 ;Do not execute as part of a verify fields.
 I $G(DIUTIL)="VERIFY FIELDS" Q
 N DAS,GLOBAL,IEN
 S IEN=$P(X,";",1)
 S GLOBAL=$P(X,";",2)
 I GLOBAL="LAB(60," S IEN=$$LABDAS(IEN)
 S DAS=IEN
 I DAS="" Q
 K ^PXRMD(811.5,DA(1),20,"E",GLOBAL,DAS,DA)
 Q
 ;
 ;========================================================
KENODES(XX,DA) ;Kill the "E" and "EDEP" nodes in the finding multiple for
 ;definitions
 ;Do not execute as part of a verify fields.
 I $G(DIUTIL)="VERIFY FIELDS" Q
 N DAS,GLOBAL,IEN,IND
 S IEN=$P(XX,";",1)
 S GLOBAL=$P(XX,";",2)
 I GLOBAL="LAB(60," S IEN=$$LABDAS(IEN)
 S DAS=IEN
 I DAS="" Q
 K ^PXD(811.9,DA(1),20,"E",GLOBAL,DAS,DA)
 S IND=0
 F  S IND=$O(^PXD(811.9,DA(1),20,"EDEP",IND)) Q:IND=""  D
 . I '$D(^PXD(811.9,DA(1),20,"EDEP",IND,GLOBAL)) Q
 . K ^PXD(811.9,DA(1),20,"EDEP",IND,GLOBAL,DAS,DA)
 Q
 ;
 ;========================================================
LABDAS(IEN) ;Determine the DAS for lab findings.
 N SUB
 ;DBIA #91-A
 S SUB=$P(^LAB(60,IEN,0),U,4)
 I SUB="CH" Q IEN
 I (SUB="BB")!(SUB="WK") Q ""
 I SUB="MI" Q "M;T;"_IEN
 ;All other SUB values: AU, CY, EM, SP
 Q "A;T;"_IEN
 ;
 ;========================================================
SENODE(X,DA) ;Set the "E" node in the finding multiple for terms.
 ;Do not execute as part of a verify fields.
 I $G(DIUTIL)="VERIFY FIELDS" Q
 N DAS,GLOBAL,IEN
 S IEN=$P(X,";",1)
 S GLOBAL=$P(X,";",2)
 I GLOBAL="LAB(60," S IEN=$$LABDAS(IEN)
 S DAS=IEN
 I DAS="" Q
 S ^PXRMD(811.5,DA(1),20,"E",GLOBAL,DAS,DA)=""
 Q
 ;
 ;========================================================
SENODES(X,DA) ;Set the "E" and "EDEP" node in the finding multiple for
 ;definitions. X(1)=.01, X(2)=BEGINNING DATE/TIME, X(3)=ENDING DATE/TIME
 ;Do not execute as part of a verify fields.
 I $G(DIUTIL)="VERIFY FIELDS" Q
 N DAS,DEP,EORDER,ERROR,FBDT,FEDT,FI,GLOBAL,IEN,IND,JND,NODEP,PT01
 ;Build dependency list.
 D DEPLIST(DA(1),.DEP)
 D EVORDER(.DEP,.EORDER,.NODEP,.ERROR)
 ;If EVORDER returns an error quit.
 I ERROR Q
 K ^PXD(811.9,DA(1),20,"E"),^PXD(811.9,DA(1),20,"EDEP")
 ;Build the "E" index.
 S IND=""
 F  S IND=$O(NODEP(IND)) Q:IND=""  D
 . S PT01=$P(^PXD(811.9,DA(1),20,IND,0),U,1)
 . S IEN=$P(PT01,";",1)
 . S GLOBAL=$P(PT01,";",2)
 . I GLOBAL="LAB(60," S IEN=$$LABDAS(IEN)
 . S DAS=IEN
 . I DAS="" Q
 . S ^PXD(811.9,DA(1),20,"E",GLOBAL,DAS,IND)=""
 ;Build the "EDEP" index.
 S IND=0
 F  S IND=$O(EORDER(IND)) Q:IND=""  D
 . S FI=EORDER(IND)
 . S JND=0,(FBDT,FEDT)=""
 . F  S JND=$O(DEP(FI,JND)) Q:JND=""  D
 .. I DEP(FI,JND)="BDT" S FBDT=JND
 .. I DEP(FI,JND)="EDT" S FEDT=JND
 . S PT01=$P(^PXD(811.9,DA(1),20,FI,0),U,1)
 . S IEN=$P(PT01,";",1)
 . S GLOBAL=$P(PT01,";",2)
 . I GLOBAL="LAB(60," S IEN=$$LABDAS(IEN)
 . S DAS=IEN
 . I DAS="" Q
 . S ^PXD(811.9,DA(1),20,"EDEP",IND,GLOBAL,DAS,FI)=FBDT_U_FEDT
 Q
 ;
