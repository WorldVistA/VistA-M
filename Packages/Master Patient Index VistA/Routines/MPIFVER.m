MPIFVER ;ALB/CKN,VISTA ENTERPRISE REGISTRATION ; 7/16/15 4:18pm
 ;;1.0;MASTER PATIENT INDEX VISTA;**61**;30 Apr 99;Build 3
 Q
ENP(RESULTS,ALTRSHLD,TKTRSHLD) ;
 N XCNT,XCNTR,DFN,TMPRESLT
 S XCNT="",XCNTR="",DFN=""
 D DISPLAY
 I XCNTR'="" D
 . M TMPRESLT(1)=RESULTS(XCNTR)
 . K RESULTS M RESULTS=TMPRESLT
 S DFN=$$BR(XCNTR)
 Q DFN
BR(XCNTR) ;Business rules
 N ICN,SSN,MPIIDS
 ;If no record is selected by user, return empty RESULTS and no DFN
 I XCNTR="" K RESULTS  Q ""
 ;
 S ICN=$G(RESULTS(1,"ICN")),SSN=$G(RESULTS(1,"SSN"))
 ;If user select record with NO ICN value, return no DFN and single
 ;record in RESULTS
 I ICN="" Q DFN
 ;If user select record with ICN value, check PATIENT file for
 ;ICN. If it exist, return DFN. If it does not exist, check for
 ;SSN. If SSN exist, Notify user and return empty DFN and RESULTS to
 ;go back to select patient prompt.
 I $D(^DPT("AICN",+ICN)) D  Q DFN
 . S DFN=$O(^DPT("AICN",+ICN,""))
 . K RESULTS
 I SSN'="",($D(^DPT("SSN",SSN))) D  Q DFN
 . N IEN,NAME
 . S IEN=$O(^DPT("SSN",SSN,"")),NAME=$P($G(^DPT(IEN,0)),"^"),DFN=-1
 . W !,"SSN in selected record already exist in PATIENT file..."
 . K RESULTS
 ;If existing patient not found in VistA,
 ;Call Enterprise Get Corresponding IDs, confirm MVI doesn't know
 ;this site already (active record) - if the site is already known
 ;need use that DFN.
 D GETIDS^MPIFXMLG(.MPIIDS,RESULTS(1,"ICN"))
 N ID,CN,STNUM,QFLG
 S STNUM=$P($$SITE^VASITE(),"^",3),QFLG=0
 S CN=0 F  S CN=$O(MPIIDS(CN)) Q:+CN=0!(QFLG)  D
 . I $G(MPIIDS(CN,"IDType"))="PI",($G(MPIIDS(CN,"Source"))=STNUM) D  Q
 .. S DFN=$G(MPIIDS(CN,"ID")),QFLG=1
 .. K RESULTS
 .;If 200ESR is one of the site, set a flag to trigger Z11 query.
 . I $G(MPIIDS(CN,"Source"))="200ESR" S RESULTS(1,"Z11")=1
 Q DFN
DISPLAY ;
 N CNT1,NAME,FNAME,SCORE,SSN,DOB,ICN,SEX,LNAME,M,XMPIVER,EFLG,ECNT
 S CNT1=0,EFLG=0
 F  S CNT1=$O(RESULTS(CNT1)) Q:+CNT1=0  D
 . S FNAME=$G(RESULTS(CNT1,"FirstName")),SSN=$G(RESULTS(CNT1,"SSN"))
 . S DOB=$G(RESULTS(CNT1,"DOB")),ICN=$G(RESULTS(CNT1,"ICN"))
 . S SEX=$G(RESULTS(CNT1,"Gender")),LNAME=$G(RESULTS(CNT1,"Surname"))
 . S SCORE=+$G(RESULTS(CNT1,"Score")),NAME=LNAME_","_FNAME
 . I ICN="",($D(RESULTS(CNT1,"IDS"))) D
 .. S EFLG=1,ECNT=0 F  S ECNT=$O(RESULTS(CNT1,"IDS",ECNT)) Q:+ECNT=0  D
 ... I $G(RESULTS(CNT1,"IDS",ECNT,"SOURCE"))="200DOD" S ICN=$G(RESULTS(CNT1,"IDS",ECNT,"ID"))  ;Get EDIPI instead of ICN if from DoD
 . S M=$S(SCORE>=ALTRSHLD:"E",1:"P")
 . ;Rearranging array for sectional view display
 . S XMPIVER("MPIVER",M,SCORE,CNT1)=NAME_"^"_SSN_"^"_DOB_"^"_SEX_"^"_ICN
DISP2 ;
 N DIR,DA,DR,Y,X,DATA,ENOUGH,COUNT,I,SCORE,CNTR
 S COUNT=0
 W @IOF
 F I="E","P" D
 . I $D(XMPIVER("MPIVER",I)) D HDR($S(I="E":"",I="P":" POTENTIAL",1:""))
 . S SCORE=9999999 F  S SCORE=$O(XMPIVER("MPIVER",I,SCORE),-1) Q:SCORE=""  D
 .. S CNTR=0 F  S CNTR=$O(XMPIVER("MPIVER",I,SCORE,CNTR)) Q:CNTR=""  D
 ... S COUNT=COUNT+1
 ... S XMPIVER("MPIVER",I,SCORE,CNTR,COUNT)=""
 ... S DATA=$G(XMPIVER("MPIVER",I,SCORE,CNTR))
 ... D HDR1
 ... W !,COUNT_") ",?3,$P(DATA,"^",5),?21,$P(DATA,"^"),?53,$P(DATA,"^",2),?64,$$FMTE^XLFDT($P(DATA,"^",3),2),?76,$P(DATA,"^",4)
 S XMPIVER("COUNT")=$G(COUNT)
 S ENOUGH=0
 W !
 D ASK I ENOUGH G ASK2
 I XCNT'="" W !,"Please wait..." D EXDISP(XCNT)
 W !!
 K DIR,DA S DIR(0)="Y",DIR("B")="NO",DIR("A")="Would you like to see another record" D ^DIR
 I $D(DTOUT)!($D(DUOUT))!(Y=0) S ENOUGH=1 G ASK2
 I Y G DISP2
EXIT K DA,X,Y,XMPIVER("MPIVER") W !! Q
HDR(HDL) ;Header
 W !,"--- Records meet the"_HDL_" MATCH criteria ---"
 Q
HDR1 ;Repeating header
 W !,?3,$S(EFLG=1:"EDIPI",1:"ICN"),?21,"NAME",?53,"SSN",?64,"DOB",?76,"SEX"
 Q
ASK ;
 N COUNT,DIR,DA,DR,ND,SC,CNTR,BC,QFLG
 S BC=1,COUNT=$G(XMPIVER("COUNT"))
 K DIR,X,Y S DIR(0)="NA^"_BC_":"_COUNT,DIR("A")="Enter the Number to display the details: ",DIR("?")="Enter the number from range of "_BC_" to "_COUNT D ^DIR
 I $D(DTOUT)!($D(DUOUT)) S ENOUGH=1 Q
 I Y S XCNT=$$CNTR(Y)
 Q
 ;
CNTR(Y) ;
 N SC,ND,CNTR,QFLG
 S QFLG=0,XCNT=""
 F I="E","P" D
 . S SC=0 F  S SC=$O(XMPIVER("MPIVER",I,SC)) Q:+SC=0!(QFLG)  D
 .. S CNTR=0 F  S CNTR=$O(XMPIVER("MPIVER",I,SC,CNTR)) Q:+CNTR=0!(QFLG)  D
 ... S ND=$O(XMPIVER("MPIVER",I,SC,CNTR,""))
 ... I ND=+Y S QFLG=1,XCNT=CNTR
 Q XCNT
ASK2 ;
 N X,Y,DIR,DA,DR,BC,COUNT
 S BC=1
 S COUNT=$G(XMPIVER("COUNT"))
 K DIR,X,Y S DIR(0)="Y",DIR("B")="YES",DIR("A")="Would you like to select a patient from above Enterprise Search" D ^DIR
 I $D(DTOUT)!($D(DUOUT)) S ENOUGH=1 G EXIT
 I Y D
 .K DIR,X,Y S DIR(0)="NA^"_BC_":"_COUNT,DIR("A")="Enter the Number to select the patient: ",DIR("?")="Enter the number from range of "_BC_" to "_COUNT D ^DIR
 I $D(DTOUT)!($D(DUOUT)) Q
 I Y S XCNTR=$$CNTR(Y) D
 .;W !,"Patient: "_XCNTR_" selected"
 Q
EXDISP(XCNT) ;Extended display for selected patient
 ;Get all traits from original results
 N FNAME,LNAME,MNAME,CITY,COUNTRY,DOB,GENDER,ICN,L1,L2,L3,MMN,PCODE
 N POBCTY,POBCNTRY,POBST,PREF,SUFFIX,PROVINCE,RESCITY,RESCNTRY
 N RESADD1,RESADD2,RESADD3,RESPCODE,RESPROV,RESST,RESZIP,RESPHN
 N SSN,ALFNM,ALLNM,ALSSN,ALSFX,ALCNT,ALMNM
 S FNAME=$G(RESULTS(XCNT,"FirstName")),LNAME=$G(RESULTS(XCNT,"Surname"))
 S MNAME=$G(RESULTS(XCNT,"MiddleName")),DOB=$G(RESULTS(XCNT,"DOB"))
 S GENDER=$G(RESULTS(XCNT,"Gender")),ICN=$G(RESULTS(XCNT,"ICN"))
 S MMN=$G(RESULTS(XCNT,"MMN")),POBCTY=$G(RESULTS(XCNT,"POBCity"))
 S POBCNTRY=$G(RESULTS(XCNT,"POBCountry")),POBST=$G(RESULTS(XCNT,"POBState"))
 S PREF=$G(RESULTS(XCNT,"Prefix")),SUFFIX=$G(RESULTS(XCNT,"Suffix"))
 S RESCITY=$G(RESULTS(XCNT,"ResAddCity")),RESCNTRY=$G(RESULTS(XCNT,"ResAddCountry"))
 S RESADD1=$G(RESULTS(XCNT,"ResAddL1")),RESADD2=$G(RESULTS(XCNT,"ResAddL2"))
 S RESADD3=$G(RESULTS(XCNT,"ResAddL3")),RESPCODE=$G(RESULTS(XCNT,"ResAddPCode"))
 S RESPROV=$G(RESULTS(XCNT,"ResAddProvince")),SSN=$G(RESULTS(XCNT,"SSN"))
 S RESST=$G(RESULTS(XCNT,"ResAddState")),RESZIP=$G(RESULTS(XCNT,"ResAddZip4"))
 S RESPHN=$G(RESULTS(XCNT,"ResPhone"))
 W !
 W !,?5,"ICN",?17,": "_ICN
 W !,?5,"Name",?17,": "_LNAME_","_FNAME_" "_MNAME
 W !,?5,"SSN",?17,": "_SSN
 W !,?5,"DOB",?17,": "_$$FMTE^XLFDT(DOB)
 W !,?5,"Gender",?17,": "_GENDER
 W !,?5,"MMN",?17,": "_MMN
 I POBCTY'="" W !,?5,"POB City",?17,": "_POBCTY
 I POBST'="" W !,?5,"POB State",?17,": "_POBST
 I POBCNTRY'="" W !,?5,"POB Country",?17,": "_POBCNTRY
 I RESADD1'=""!(RESADD2'="")!(RESADD3'="")!(RESCNTRY'="")!(RESCITY'="")!(RESST'="")!(RESPCODE'="")!(RESPROV'="")!(RESZIP'="") D
 . W !!,"Address:"
 . I RESADD1'="" W !,?5,RESADD1
 . I RESADD2'="" W !,?5,RESADD2
 . I RESADD3'="" W !,?5,RESADD3
 . I RESCNTRY'="",(RESCNTRY="USA") D
 .. W !,?5,RESCITY_","_RESST_" "_RESZIP
 . I RESCNTRY'="",(RESCNTRY'="USA") D
 .. W !,?5,RESCITY_","_RESPROV_" "_RESPCODE
 I RESCNTRY'="" W !,?5,RESCNTRY
 I RESPHN'="" W !,?5,"Phone: "_RESPHN
 I $D(RESULTS(XCNT,"ALIAS")) D
 . W !!,"ALIAS Information"
 . W !,?5,"NAME",?45,"SSN"
 . S ALCNT=0 F  S ALCNT=$O(RESULTS(XCNT,"ALIAS",ALCNT)) Q:+ALCNT=0  D
 .. S ALFNM=$G(RESULTS(XCNT,"ALIAS",ALCNT,"FirstName"))
 .. S ALLNM=$G(RESULTS(XCNT,"ALIAS",ALCNT,"Surname"))
 .. S ALSSN=$G(RESULTS(XCNT,"ALIAS",ALCNT,"SSN"))
 .. S ALSFX=$G(RESULTS(XCNT,"ALIAS",ALCNT,"Suffix"))
 .. S ALMNM=$G(RESULTS(XCNT,"ALIAS",ALCNT,"MiddleName"))
 .. W !,?5,ALLNM_","_ALFNM_" "_ALMNM_" "_ALSFX,?45,ALSSN
 Q
