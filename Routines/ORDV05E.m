ORDV05E ; slc/jdl - Microbiology Extract Routine ;6/13/01  11:49
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**109,208**;Dec 17, 1997
 ;;Called from ORDV05, return ^TMP("ORM",$J in GCPR format
 ;;For Bacteriology,Sterility,Gram stain
GET ;Extract data from LR global
 N I,IX,IXO,PNM,AGE,SEX,LRDFN,ALL,FORMAT,DONE,OUTCNT
 S LRDFN="",ALL=1,FORMAT=0,DONE=0,OUTCNT=1 ;Parameters required by MI^LR7OGMM
 D DEMO^LR7OGU(DFN,.LRDFN,.PNM,.AGE,.SEX) ;Demograph required by LR7OGMM
 I '$G(LRDFN) Q
 S ^TMP("OR7OG",$J,"G")=DFN_U_PNM_U_LRDFN_U_AGE_U_SEX_"^8"
 S IX=GMTS1
 F IXO=1:1:GMTSNDM S IX=$O(^LR(LRDFN,"MI",IX)) Q:'IX!(IX>GMTS2)  D XTRCT
 Q
XTRCT N ACC,CDT,SS,CS,X,X0,DIC,DIQ,DA,DR,MICRO,LOC,RDT,MICCOM,RPT
 S RPT=IX,X0=^LR(LRDFN,"MI",IX,0),X=$P(X0,U),RDT=$P(X0,U,3),ACC=$P(X0,U,6),LOC=$P(X0,U,8)
 Q:'X  Q:'$P(X0,"^",5)
 S CDT=$$REGDTM4^ORDVU(X)
 D LABTEST(X,ACC)
 ; External format of site/specimen, collection sample, and comment
 S DIC=63,DIQ="MICRO",DIQ(0)="E",DA=LRDFN,DA(63.05)=IX,DR=5,DR(63.05)=".05;.055;.99"
 D EN^DIQ1
 S SS=MICRO(63.05,IX,.05,"E"),CS=MICRO(63.05,IX,.055,"E"),MICCOM=MICRO(63.05,IX,.99,"E")
 S ^TMP("ORM",$J,RPT,SS)=CDT_U_ACC_U_CS_U_SS_U_LRTSTS
 S ^TMP("ORM",$J,RPT,SS,"IMP")=MICCOM
 D ABXLEV,BACT,GRAM,STER,PARA^ORDV05X,MYCO^ORDV05X,TB^ORDV05X,VIRO^ORDV05X
 D MI^ORDV05T(LRDFN,IX,ALL,.OUTCNT,FORMAT,.DONE)
 I $D(^TMP("OR7OGX",$J,"OUTPUT"))>0 M ^TMP("ORM",$J,RPT,SS,"REPORT")=^TMP("OR7OGX",$J,"OUTPUT")
 K ^TMP("OR7OGX",$J,"OUTPUT")
 K LRTSTS
 Q
BACT ; Get Bacteriology Work-up
 N DA,DIC,DIQ,DR,STATUS,ISO,ORG,RMK,COM,SMEAR,ORGIEN
 I $D(^LR(LRDFN,"MI",IX,1)) D
 . S DIC=63,DA=LRDFN,DA(63.05)=IX,DR=5,DR(63.05)="11.5",DIQ="STATUS"
 . S DIQ(0)="E" D EN^DIQ1
 . S ^TMP("ORM",$J,RPT,SS)=^TMP("ORM",$J,RPT,SS)_U_STATUS(63.05,IX,11.5,"E")
 S ISO=0 F  S ISO=$O(^LR(LRDFN,"MI",IX,3,ISO)) Q:+ISO'>0  D
 . S ORGIEN=+^LR(LRDFN,"MI",IX,3,ISO,0)
 . D ORGNSM
 . S ^TMP("ORM",$J,RPT,SS,"RPT",ORGIEN)="B"_U_$S($D(EXPAND):ISO_";"_ORG,1:ORG)
 . I $O(^LR(LRDFN,"MI",IX,3,ISO,1)) D ANTIBX
 ; Bacteriology smear/prep
 S SMEAR=0
 F  S SMEAR=$O(^LR(LRDFN,"MI",IX,25,SMEAR)) Q:SMEAR'>0  S ^TMP("ORM",$J,RPT,SS,"IMP","BACT","SMEAR",SMEAR)=^(SMEAR,0)
 ; remark
 S RMK=0
 F  S RMK=$O(^LR(LRDFN,"MI",IX,4,RMK)) Q:RMK=""  S ^TMP("ORM",$J,RPT,SS,"IMP","BACT","RMK",RMK)=^(RMK,0)
 Q
ORGNSM N QTY
 S QTY=$P(^(0),U,2)
 S ORG=$$GET1^DIQ(61.2,ORGIEN,.01,"I")
 S ORG=ORG_U_QTY
 Q
ANTIBX ; Get Antibitiotic susceptibility results on demand
 N ABX S ABX=1
 F  S ABX=$O(^LR(LRDFN,"MI",IX,3,ISO,ABX)) Q:ABX=""!(ABX'<3)  D ABXSET
 Q
ABXSET ; Set Antibiotic Susceptability data, when appropriate
 ; Separate out by Susceptable, Intermediate, and Resistant
 N FOUND,GMTSR,GMABX,ABXI,ABXNM,ABXN
 S ABXI=$$ABXI(ABX),ABXNM=$$ABXNM(ABXI),ABXN=ABX_";"_ABXNM
 I $P(ABXN,";",2)']"" S $P(ABXN,";",2)="UNKNOWN"
 I ("A"[$P(^LR(LRDFN,"MI",IX,3,ISO,ABX),U,3)) D
 . S GMABX=$G(^LR(LRDFN,"MI",IX,3,ISO,ABX))
 . ;Check for interpreted result being S, I, or R first
 . S FOUND=0
 . S GMTSR=$P(GMABX,U,2) D SAVE Q:FOUND
 . ;If not found then check reported result for S, I, or R
 . S GMTSR=$P(GMABX,U) D SAVE Q:FOUND
 Q
ABXI(X) ; Antibiotic Susceptability IEN
 S X=$G(X) Q:'$L(X) 0 N D,DIC,DTOUT,DUOUT,Y S DIC="^LAB(62.06,",D="AD",DIC(0)="" D MIX^DIC1 S X=+($G(Y)) S:X'>0 X=0 Q X
ABXNM(X) ; Antibiotic Susceptability Name
 S X=$G(X) Q:+X'>0 "" S X=$$GET1^DIQ(62.06,+X,.01) Q X
ABXLEV ; Get Serum antibiotic level
 Q:'$D(^LR(LRDFN,"MI",IX,14))  N GMI S GMI=0
 F  S GMI=$O(^LR(LRDFN,"MI",IX,14,GMI)) Q:GMI'>0  S ^TMP("ORM",$J,"CABXL",GMI)=$G(^(GMI,0))
 Q
STER ; Get sterility results if they exist
 N RESULT,STER
 S STER=0
 F  S STER=$O(^LR(LRDFN,"MI",IX,31,STER)) Q:STER'>0  D
 . S DIQ(0)="E",DIC=63,DA=LRDFN,DA(63.05)=IX,DR=5,DR(63.05)=11.52
 . S DR(63.292)=.01,DIQ="RESULT"
 . S DA(63.292)=STER
 . D EN^DIQ1
 . S ^TMP("ORM",$J,RPT,SS,"IMP","BSTER",STER)=RESULT(63.292,STER,.01,"E")
 Q
GRAM ; Get Gram Stain Results
 N ISO
 Q:'$D(^LR(LRDFN,"MI",IX,2))
 S ISO=0
 F  S ISO=$O(^LR(LRDFN,"MI",IX,2,ISO)) Q:ISO=""  S ^TMP("ORM",$J,RPT,SS,"IMP","GRAM",ISO)=^(ISO,0)
 Q
LABTEST(SDT,LRACC) ;Get lab test names and results
 N X,Y,LRAA,LRAN,LRAD,LRBRR,LRTS
 K LRTSTS
 S LRTSTS="UNKNOWN"
 S LRAD=+$E(SDT)_$P(LRACC," ",2)_"0000",X=$P(LRACC," "),DIC=68,DIC(0)="M"
 Q:'$L(X)  D ^DIC S LRAA=+Y,LRAN=+$P(LRACC," ",3)
 S LRBRR=0
 F  S LRBRR=+$O(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRBRR)) Q:LRBRR'>0  D
 . S LRTS=+^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRBRR,0),LRTS(1)=$P(^(0),U,5)
 . Q:"BO"'[$P($G(^LAB(60,LRTS,0)),U,3)
 . S LRTSTS=$S($D(^LAB(60,LRTS,0)):$P(^(0),U),1:"deleted test")
 Q
SAVE ;If result = S, I, or R then save
 I $S(GMTSR="I":1,GMTSR="R":1,GMTSR="S":1,1:0) S ^TMP("ORM",$J,RPT,SS,"RPT",ORGIEN,ABX)=ABXNM_U_GMABX S FOUND=1
 Q
