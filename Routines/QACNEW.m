QACNEW ;HISC/RS,CEW,DAD-Enter a new Patient representative record ; 11/24/00 1:40pm
 ;;2.0;Patient Representative;**3,5,8,10,11,13,16,17**;07/25/1995
 S DIR("A")="Enter Date of Contact: ",DIR(0)="DOA^2010101:"_DT_":PEX"
 S DIR("?")="^D HELP^%DTC",DIR("??")="^D HELP^QACNEW"
 D ^DIR K DIR
 G QUIT:$D(DIROUT)!($D(DIRUT))
 S QACDOC=Y
 K DA S DIR("A")="Enter Patient Name",DIR(0)="745.1,2"
 D ^DIR K DIR
 G QUIT:$D(DIROUT)!($D(DTOUT))!($D(DUOUT))
 ;
 N QACNAME,QACPAT,QACPSRV,QACGWV,RECNR
 ;
 S QACPN=$P(Y,"^",1)
 S QACINCR=0
 G:QACPN="" QACRECN
SHOW S (QACELI,QACCAT,QACSSN,QACDOB)="",QACY=+Y
 I QACPN'="" S QACDATA=$G(^DPT(QACPN,0)),QACNAME=$P(QACDATA,"^") D
 .S QACSSN=$P(QACDATA,"^",9),QACDOB=$P(QACDATA,"^",3),QACSEX=$P(QACDATA,"^",2) S DFN=QACPN D ELIG^VADPT S QACELI=$P($G(VAEL(1)),"^",2),QACCAT=$P($G(VAEL(9)),"^",2)
 I QACPN'="" S QACPSRV=$P($G(^DPT(QACPN,.32)),U,3)
 I QACPN'="" S QACGWV=$P($G(^DPT(QACPN,.322)),U,10)
 W @IOF,!!,?15,"Enter New Patient Representative Contact",!
 I QACPN'="" S QACPAT=^DPT(QACPN,0)
 W !,"Patient Name:",?20,$P($G(QACPAT),U)
 W ?47,"Patient SSN:",?66,$P($G(QACPAT),U,9)
 S Y=$P($G(QACPAT),U,3) D DD^%DT W !,"Patient DOB: ",?20,$G(Y)
 W ?47,"Patient Sex:",?66,$P($G(QACPAT),U,2)
 W !,"Eligibility Status:",?20,$G(QACELI)
 W ?47,"Patient Category:",?66,$G(QACCAT)
 I $G(QACPSRV)]"" W !,"Period of Service: ",?20,$P(^DIC(21,$G(QACPSRV),0),U)
 W ?47,"Persian Gulf War?: ",?66,$S($G(QACGWV)="Y":"YES",$G(QACGWV)="N":"NO",$G(QACGWV)="U":"UNKNOWN",1:"Not Entered")
 N CNT1,CNT2,J,K,L,M,N,QACCODE,QACCSS,QACFLG,QACNUM,QACOPEN,QACROC,QACSS
 I QACPN'="" S J="",CNT1=0 F  S J=$O(^QA(745.1,"E",QACPN,J)) Q:'J  D
 . S CNT1=CNT1+1
 . S QACROC(CNT1)=J
 I $G(CNT1)>0 D
 . W !!,"Last ROC for ",QACNAME,": ",$P(^QA(745.1,QACROC(CNT1),0),U)
 . S Y=$P(^QA(745.1,QACROC(CNT1),0),U,2) D DD^%DT
 . W "  Date: ",Y
 . I $G(^QA(745.1,QACROC(CNT1),3,0))]"" S QACNUM=QACROC(CNT1) D CODES
 I QACPN'="" S DFN=QACPN D DIS^DGRPDB
 I $G(CNT1)>0 D
 . S K=0,CNT2=0 F  S K=$O(QACROC(K)) Q:'K  Q:QACROC(K)'>0  D
 . . I '$D(^XUSEC("QAC EDIT",DUZ))#2,(DUZ'=$P(^QA(745.1,QACROC(K),0),U,7)) Q
 . . I $P($G(^QA(745.1,QACROC(K),7)),U,2)="O" S CNT2=CNT2+1,QACOPEN(CNT2)=QACROC(K)
 I $G(CNT2)'>0,(QACPN'="") W !!,"There are no open Contacts on patient ",$P(^DPT(QACPN,0),U),"."
 N %
 I $G(CNT2)>0 W !!,"Would you like to edit open ROC(s) at this time" S %=0 D YN^DICN W:%'=1 !! I %=1 D
 . I CNT2>1,(QACPN'="") D
EDOPEN . . ; If user chooses, can edit open ROCs on this patient.
 . . W !!?10,"Edit an open Report of Contact on ",$P(^DPT(QACPN,0),U)
 . . W !,"Choose from: "
 . . S L=0 F  S L=$O(QACOPEN(L)) Q:'L  D
 . . . I $D(^XUSEC("QAC EDIT",DUZ))#2!(DUZ=$P(^QA(745.1,QACOPEN(L),0),U,7)) W !,L,"   ",$P(^QA(745.1,QACOPEN(L),0),U) S Y=$P(^QA(745.1,QACOPEN(L),0),U,2) D DD^%DT W ?40,"Date: ",Y S QACNUM=QACOPEN(L) D CODES
 . . S DIR(0)="NO",DIR("S")="I X>0,(X<QACLAST+1)"
 . . S DIR("?")="Enter the list number of your selection."
 . . D ^DIR Q:$D(DIRUT)
 . . S (RECNR,Y)=QACOPEN(X),QACFLG=1,DIE=745.1
 . . D EDT^QACEDIT G EDOPEN
 . . W !!!!,"****Returning to 'Enter New Contact' session.****",!!
 . I CNT2=1 D
 . . S (Y,RECNR,QACNUM)=QACOPEN(CNT2),QACFLG=1
 . . W !!!,$P(^QA(745.1,QACNUM,0),U) S Y=$P(^QA(745.1,QACNUM,0),U,2) D DD^%DT W ?40,"Date: ",Y
 . . D CODES
 . . S Y=QACNUM D EDT^QACEDIT
 . . W !!!!,"****Returning to 'Enter New Contact' session.****",!!
 S QACINCR=0
QACRECN ; Build next contact number
 N QACLEN,QACLEN1,QACNO,QACNT S QACNT=0
 S QACYR=$E(DT,2,3),(QACRCFLG,QAC)=+$P($G(^QA(745.1,0)),U,3)
 I $G(QACRCFLG) D
 . S QAC=$O(^QA(745.1," "),-1) Q:QAC'>0  S QACRCFLG=QAC
 . S QACRCD(1)=$P($G(^QA(745.1,QACRCFLG,0)),U)
 . S QACRCD(2)=$P($$SITE^VASITE(DT),U,3) ;QAC*2*13 - use api for station # QAC*2*16 - access 3rd piece
 . S QACLEN1=$L(QACRCD(2))
 . S QACRCD(3)=$E(QACRCD(1),QACLEN1+1,999)
 . I QACYR'=$E(QACRCD(3),2,3) S QACRCD="."_QACYR_"000"_1+QACINCR Q
 . ; splitting off contact number from year to allow for >9999 records
 . ; per year.  patch QAC*2*8 - ERC
 . S QACRCD(4)=$E(QACRCD(3),4,999)
 . S QACRCD(4)=QACRCD(4)+1+QACINCR
 . S QACLEN=$L(QACRCD(4))
 . S QACRCD="."_QACYR_QACRCD(4)
 . I QACLEN<4 S QACRCD="."_QACYR_$E("000",1,(4-QACLEN))_QACRCD(4)
 E  S QACRCD="."_QACYR_"000"_1+QACINCR
 S QACCASE=QACRCD(2)_QACRCD
 I $O(^QA(745.1,"B",QACCASE,0))>0 S QACINCR=QACINCR+1 G QACRECN
 S QACLC="L +X"_$P(QACCASE,".",2)_":0"
 X QACLC I '$T S QACINCR=QACINCR+1 G QACRECN
 K DIC,DD,DO,DINUM,DLAYGO S X=QACCASE
 S DIC("DR")="",DIC(0)="EMQLZ",(DIC,DLAYGO)=745.1 D ^DIC K DIC
 S QACLC="L -X"_$P(QACCASE,".",2) X QACLC G END:Y<0
 S QACDA=+Y
 Q:$G(DUOUT)
 D DIVLIST
 ;S DIE="^QA(745.1,",DR=37 D ^DIE
 ;S QACDA=QAC+1
 S QACALERT=1
 S DIE="^QA(745.1,",DA=QACDA,DR="1////"_QACDOC_";2////"_$G(QACPN)_";9////"_DUZ_";27///^S X=""O"";6////"_$G(QACELI)_";7///"_$G(QACCAT)_";31////"_$G(QACPSRV)_";32////"_$G(QACGWV) D ^DIE
 K DIC,DIQ,DR
 ;I QACPN'="" S DFN=QACPN D DIS^DGRPDB
 K TMP,DFN,CODE,DIQ,DIR,DR,LINE,N1,N2,QAC,QACCASE,QACCAT,QACDATA,QACDOB,QACDOC,QACELI,QACFL1,QACRCD,QACRCD(1),QACRCD(2),QACRCFLG,QACSEX,QACSITE,QACSSN,QACYR,TAB,TEXT,VAEL,QACY
EDIT ;FILL IN REST OF DATA FIELDS
 W ! S DIE="^QA(745.1,"
 S DA=QACDA
 I $G(QACPN)]"" S DR=16.5 D ^DIE
 S DR="[QAC CONTACT ENTER/EDIT]"
 D ^DIE
END K D,D0,DA,DD,DI,DIC,DIE,DIR,DLAYGO,DTOUT,DO,DR,DUOUT,FLD,J,TEMPY,X,Y
 K QACALERT,QACCASE,QACD1,QACDA,QACDFLT,QACFL1,QACINCR,QACLAST,QACLC,QACN,QACOPEN,QACOUT,QACPN,QACY,QACDVNAM
 W !! G ^QACNEW
HELP ;
 W !!,"This is the date the Patient Representative was initially contacted."
 W !,"Enter a date no later than TODAY."
 Q
TEXT ;
1 ;;0^Contact Number:^W ?20,QACDATA
100 ;;47^Date of Contact:^W ?66,QACDATA
200 ;;0^Patient Name:^W ?20,QACDATA
300 ;;47^Patient SSN (c):^W ?66,QACDATA
400 ;;0^Patient DOB (c):^S Y=QACDATA D DD^%DT S QACDATA=Y W ?20,QACDATA
500 ;;47^Patient sex (c):^W ?66,QACDATA
600 ;;0^Eligibility Status:^W ?20,QACDATA
700 ;;47^Patient Category:^W ?66,QACDATA
 ;
QUIT K DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 K QACALERT,QACDOC,QACFL1,QACPN,QACRCD,QACY
 Q
CODES ; Display Issue Codes and Customer Service Standards with ROC
 W !?3,"Issue Code(s):"
 S M=0
 F  S M=$O(^QA(745.1,QACNUM,3,M)) Q:'M  S QACCODE=^QA(745.1,QACNUM,3,M,0) D
 . W !,$P(^QA(745.2,QACCODE,0),U)_"-"_$P(^QA(745.2,QACCODE,0),U,3)
 . S QACCSS=$P(^QA(745.2,QACCODE,0),U,7)
 . I $G(QACCSS)]"" S N="" S QACSS=$O(^QA(745.6,"B",QACCSS,N)) W "(*",$P(^QA(745.6,QACSS,0),U,2),")"
 Q
DIVLIST ;
 ;W !!,"DIVISION: "
 N QAC,QACC
 S (QAC,QACC)=0
 F  S QACC=$O(^DG(40.8,"AD",QACC)) Q:QACC'>0  D
 . S QAC=QAC+1
 . S QAC(QAC)=QAC
 . S QACC(QAC)=QACC
 . I $D(^DIC(4,QACC,0)) W !,"    "_QAC(QAC)_"  "_$P(^DIC(4,QACC,0),U)
 S DIR(0)="NA"
 S DIR("A")="Enter your Division: "
 S DIR("?")="Choose the number of your division."
 D ^DIR K DIR
 Q:$G(DIRUT)
 I $G(QAC(+Y))]"" S QAC=$P($G(^DIC(4,QACC(+Y),0)),U)
 S DR="37///^S X=QAC",DIE="^QA(745.1,",DA=QACDA D ^DIE
 Q
