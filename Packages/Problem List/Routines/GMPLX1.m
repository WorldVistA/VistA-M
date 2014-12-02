GMPLX1 ; SLC/MKB/KER/TC - Problem List Person Utilities ;11/27/12  08:28
 ;;2.0;Problem List;**3,26,35,36,42**;Aug 25, 1994;Build 46
 ;
 ; External References
 ;   DBIA   348  ^DPT(
 ;   DBIA  3106  ^DIC(49
 ;   ICR   5747  $$CSI/SAB/CODECS^ICDEX
 ;   ICR   5699  $$ICDDATA^ICDXCODE
 ;   DBIA   872  ^ORD(101
 ;   DBIA 10060  ^VA(200
 ;   DBIA 10062  7^VADPT
 ;   DBIA 10062  DEM^VADPT
 ;   DBIA  2716  $$GETSTAT^DGMSTAPI
 ;   DBIA  3457  $$GETCUR^DGNTAPI
 ;   DBIA 10104  $$REPEAT^XLFSTR
 ;   DBIA 10006  ^DIC
 ;   DBIA 10018  ^DIE
 ;   DBIA 10026  ^DIR
 ;
PAT() ; Select patient -- returns DFN^NAME^BID
 N DIC,X,Y,DFN,VADM,VA,PAT,AUPNSEX
P1 S DIC="^AUPNPAT(",DIC(0)="AEQM" D ^DIC I +Y<1 Q -1
 I $P(Y,U,2)'=$P(^DPT(+Y,0),U) W $C(7),!!,"ERROR -- Please check your Patient Files #2 and #9000001 for inconsistencies.",! G P1
 S DFN=+Y,PAT=Y D DEM^VADPT
 S PAT=PAT_U_$E($P(PAT,U,2))_VA("BID"),AUPNSEX=$P(VADM(5),U)
 I VADM(6) S PAT=PAT_U_+VADM(6) ; date of death
 Q PAT
 ;
VADPT(DFN) ; Get Service/Elig Flags
 ;
 ; Returns = 1/0/"" if Y/N/unknown
 ;   GMPSC     Service Connected
 ;   GMPAGTOR  Agent Orange Exposure
 ;   GMPION    Ionizing Radiation Exposure
 ;   GMPGULF   Persian Gulf Exposure
 ;   GMPMST    Military Sexual Trauma
 ;   GMPHNC    Head and/or Neck Cancer
 ;   GMPCV     Combat Veteran
 ;   GMPSHD    Shipboard Hazard and Defense
 ;
 N VAEL,VASV,VAERR,HNC,X D 7^VADPT S GMPSC=VAEL(3),GMPAGTOR=VASV(2)
 S GMPION=VASV(3),X=$P($G(^DPT(DFN,.322)),U,10),GMPGULF=$S(X="Y":1,X="N":0,1:"")
 S GMPCV=0 I +$G(VASV(10)) S:DT'>$P($G(VASV(10,1)),U) GMPCV=1  ;CV
 S GMPSHD=+$G(VASV(14,1))  ;SHAD
 S X=$P($$GETSTAT^DGMSTAPI(DFN),"^",2),GMPMST=$S(X="Y":1,X="N":0,1:"")
 S X=$$GETCUR^DGNTAPI(DFN,"HNC"),X=+($G(HNC("STAT"))),GMPHNC=$S(X=4:1,X=5:1,X=1:0,X=6:0,1:"")
 Q
SCS(PROB,SC) ; Get Exposure/Conditions Strings
 ;
 ;   Input     PROB  Pointer to Problem #9000011
 ;
 ;   Returns   SC Array passed by reference
 ;             SC(1)="AO/IR/EC/HNC/MST/CV/SHD"
 ;             SC(2)="A/I/E/H/M/C/S"
 ;             SC(3)="AIEHMCS"
 ;
 ;   NOTE:  Military Sexual Trauma (MST) is suppressed
 ;          if the current device is a printer.
 ;
 N ND,DA,FL,AO,IR,EC,HNC,MST,CV,SHD,PTR S DA=+($G(PROB)) Q:+DA=0
 S ND=$G(^AUPNPROB(+DA,1)),AO=+($P(ND,"^",11)),IR=+($P(ND,"^",12))
 S EC=+($P(ND,"^",13)),HNC=+($P(ND,"^",15)),MST=+($P(ND,"^",16))
 S CV=+($P(ND,"^",17)),SHD=+($P(ND,"^",18))
 S PTR=$$PTR^GMPLUTL4
 I +AO>0 D
 . S:$G(SC(1))'["AO" SC(1)=$G(SC(1))_"/AO" S:$G(SC(2))'["A" SC(2)=$G(SC(2))_"/A" S:$G(SC(3))'["A" SC(3)=$G(SC(3))_"A"
 I +IR>0 D
 . S:$G(SC(1))'["IR" SC(1)=$G(SC(1))_"/IR" S:$G(SC(2))'["I" SC(2)=$G(SC(2))_"/I" S:$G(SC(3))'["I" SC(3)=$G(SC(3))_"I"
 I +EC>0 D
 . S:$G(SC(1))'["EC" SC(1)=$G(SC(1))_"/EC" S:$G(SC(2))'["E" SC(2)=$G(SC(2))_"/E" S:$G(SC(3))'["E" SC(3)=$G(SC(3))_"E"
 I +HNC>0 D
 . S:$G(SC(1))'["HNC" SC(1)=$G(SC(1))_"/HNC" S:$G(SC(2))'["H" SC(2)=$G(SC(2))_"/H" S:$G(SC(3))'["H" SC(3)=$G(SC(3))_"H"
 I +MST>0 D
 . S:$G(SC(1))'["MST" SC(1)=$G(SC(1))_"/MST" S:$G(SC(2))'["M" SC(2)=$G(SC(2))_"/M" S:$G(SC(3))'["M" SC(3)=$G(SC(3))_"M"
 I +CV>0 D
 . S:$G(SC(1))'["CV" SC(1)=$G(SC(1))_"/CV" S:$G(SC(2))'["C" SC(2)=$G(SC(2))_"/C" S:$G(SC(3))'["C" SC(3)=$G(SC(3))_"C"
 I +PTR'>0 D
 . I +SHD>0 S:$G(SC(1))'["SHD" SC(1)=$G(SC(1))_"/SHD" S:$G(SC(2))'["D" SC(2)=$G(SC(2))_"/S" S:$G(SC(3))'["S" SC(3)=$G(SC(3))_"S"
 S:$D(SC(1)) SC(1)=$$RS(SC(1)) S:$D(SC(2)) SC(2)=$$RS(SC(2))
 Q
SCCOND(DFN,SC) ; Get Service/Elig Flags (array)
 ; Returns local array .SC passed by value
 N HNC,VAEL,VASV,VAERR,X D 7^VADPT
 S SC("DFN")=$G(DFN),SC("SC")=$P(VAEL(3),"^",1)
 S SC("AO")=$P(VASV(2),"^",1)
 S SC("IR")=$P(VASV(3),"^",1)
 S X=$P($G(^DPT(DFN,.322)),U,10),SC("PG")=$S(X="Y":1,X="N":0,1:"")
 S SC("CV")=0 I +$G(VASV(10)) S:DT'>$P($G(VASV(10,1)),U) SC("CV")=1  ;CV
 S SC("SHD")=+$G(VASV(14,1))  ;SHAD
 S X=$P($$GETSTAT^DGMSTAPI(DFN),"^",2),SC("MST")=$S(X="Y":1,X="N":0,1:"")
 S X=$$GETCUR^DGNTAPI(DFN,"HNC"),X=+($G(HNC("STAT"))),SC("HNC")=$S(X=4:1,X=5:1,X=1:0,X=6:0,1:"")
 Q
 ;
CKDEAD(DATE) ; Dead patient ... continue?  Returns 1 if YES, 0 otherwise
 N DIR,X,Y S DIR(0)="YA",DIR("B")="NO"
 S DIR("A")="Are you sure you want to continue? "
 S DIR("?",1)="   Enter YES to continue and add new problem(s) for this patient:",DIR("?")="   press <return> to select another action."
 W $C(7),!!,"DATE OF DEATH: "_$$EXTDT^GMPLX(DATE)
 D ^DIR
 Q +Y
 ;
REQPROV() ; Returns requesting provider
 N DIR,X,Y,DUOUT,DTOUT
 I $D(GMPLUSER) S Y=DUZ_U_$P(^VA(200,DUZ,0),U) Q Y
 S DIR("?")="Enter the name of the provider responsible for this data."
 S DIR(0)="PA^200:AEQM",DIR("A")="Provider: "
 S:$G(GMPROV) DIR("B")=$P(GMPROV,U,2) W ! D ^DIR
 I $D(DUOUT)!($D(DTOUT))!(+Y'>0) Q -1
 Q Y
 ;
NAME(USER) ; Formats user name into "Lastname,F"
 N NAME,LAST,FIRST
 S NAME=$P($G(^VA(200,+USER,0)),U) I '$L(NAME) Q ""
 S LAST=$P(NAME,","),FIRST=$P(NAME,",",2)
 S:$E(FIRST)=" " FIRST=$E(FIRST,2,99)
 Q $E(LAST,1,15)_","_$E(FIRST)
 ;
SERVICE(USER,INCNPC) ; Returns User's service/section from file #49
 ; USER - Integer # (User ID - DUZ) of person in question
 ; [INCNPC] - Optional Boolean Defaults to 0 (false)
 N X S X=+$P($G(^VA(200,USER,5)),U),INCNPC=+$G(INCNPC)
 I 'INCNPC,($P($G(^DIC(49,X,0)),U,9)'="C") S X=0
 S:X>0 X=X_U_$P($G(^DIC(49,X,0)),U) S:X'>0 X=""
 Q X
 ;
SERV(X) ; Return service name abbreviation
 N NODE,ABBREV
 S NODE=$G(^DIC(49,+X,0)) I NODE="" Q ""
 S ABBREV=$P(NODE,U,2) I ABBREV="" S ABBREV=$E($P(NODE,U),1,4)
 Q ABBREV_"/"
 ;
CLINIC(LAST) ; Returns clinic from file #44
 N X,Y,DIC,DIR,DTOUT,DUOUT S Y="" G:$E(GMPLVIEW("VIEW"))="S" CLINQ
 S DIR(0)="FAO^1:30",DIR("A")="Clinic: " S:$L(LAST) DIR("B")=$P(LAST,U,2)
 S DIR("?")="Enter the clinic to be associated with these problems, if available"
 S DIR("??")="^D LISTCLIN^GMPLMGR1 W !,DIR(""?"")_""."""
CLIN1 ; Ask Clinic
 D ^DIR S:$D(DUOUT)!($D(DTOUT)) Y="^" S:Y="@" Y="" G:("^"[Y) CLINQ
 S DIC="^SC(",DIC(0)="EMQ",DIC("S")="I $P(^(0),U,3)=""C"""
 D ^DIC I Y'>0 W !?5,"Only clinics are allowed!",! G CLIN1
CLINQ ; Quit Asking
 Q Y
 ;
VIEW(USER) ; Returns user's preferred view
 N X S X=$P($G(^VA(200,USER,125)),U)
 Q X
 ;
VOCAB() ; Select search vocabulary
 N DIR,X,Y S DIR(0)="SAOM^N:NURSING;I:IMMUNOLOGIC;D:DENTAL;S:SOCIAL WORK;P:GENERAL PROBLEM"
 S DIR("A")="Select Specialty Subset: ",DIR("B")="GENERAL PROBLEM"
 S DIR("?",1)="Because many discipline-specific terms are synonyms to other terms,"
 S DIR("?",2)="they are not accessible unless you specify the appropriate subset of the"
 S DIR("?",3)="Clinical Lexicon to select from.  Choose from:  Nursing"
 S DIR("?",4)=$$REPEAT^XLFSTR(" ",48)_"Immunologic"
 S DIR("?",5)=$$REPEAT^XLFSTR(" ",48)_"Dental"
 S DIR("?",6)=$$REPEAT^XLFSTR(" ",48)_"Social Work"
 S DIR("?")=$$REPEAT^XLFSTR(" ",48)_"General Problem"
 D ^DIR S X=$S(Y="N":"NUR",Y="I":"IMM",Y="D":"DEN",Y="S":"SOC",Y="P":"PL1",1:"^")
 Q X
 ;
PARAMS ; Edit pkg parameters in file #125.99
 N DIE,DA,DR,OLDVERFY,VERFY,BLANK S BLANK="       "
 S OLDVERFY=+$P($G(^GMPL(125.99,1,0)),U,2)
 S DIE="^GMPL(125.99,",DA=1,DR="1:2;4:6" D ^DIE
 Q:+$P($G(^GMPL(125.99,1,0)),U,2)=OLDVERFY
 S DA(1)=$O(^ORD(101,"B","GMPL PROBLEM LIST",0)) Q:'DA(1)
 S VERFY=$O(^ORD(101,"B","GMPL VERIFY",0)) W "."
 S DA=$O(^ORD(101,DA(1),10,"B",VERFY,0)) Q:'DA
 S DR=$S(OLDVERFY:"2///@;6///^S X=BLANK",1:"2////$;6///@") W "."
 S DIE="^ORD(101,"_DA(1)_",10,"
 D ^DIE W "."
 Q
RS(X) ; Remove Slashes
 S X=$G(X) F  Q:$E(X,1)'="/"  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'="/"  S X=$E(X,1,($L(X)-1))
 Q X
WRAP(TEXT,LENGTH) ; Breaks text string into substrings of length LENGTH
 N GMPI,GMPJ,LINE,GMPX,GMPX1,GMPX2,GMPY
 I $G(TEXT)']"" Q ""
 F GMPI=1:1 D  Q:GMPI=$L(TEXT," ")
 . S GMPX=$P(TEXT," ",GMPI)
 . I $L(GMPX)>LENGTH D
 . . S GMPX1=$E(GMPX,1,LENGTH),GMPX2=$E(GMPX,LENGTH+1,$L(GMPX))
 . . S $P(TEXT," ",GMPI)=GMPX1_" "_GMPX2
 S LINE=1,GMPX(1)=$P(TEXT," ")
 F GMPI=2:1 D  Q:GMPI'<$L(TEXT," ")
 . S:$L($G(GMPX(LINE))_" "_$P(TEXT," ",GMPI))>LENGTH LINE=LINE+1,GMPY=1
 . S GMPX(LINE)=$G(GMPX(LINE))_$S(+$G(GMPY):"",1:" ")_$P(TEXT," ",GMPI),GMPY=0
 S GMPJ=0,TEXT="" F GMPI=1:1 S GMPJ=$O(GMPX(GMPJ)) Q:+GMPJ'>0  S TEXT=TEXT_$S(GMPI=1:"",1:"|")_GMPX(GMPJ)
 Q TEXT
SCTMAP(GMPSCT,GMPICD,GMPORD) ; API for updating ICD Code when mapping changes
 ; GMPSCT = SNOMED CT Concept CODE (e.g., 53974002 for Kniest Dysplasia)
 ; GMPICD = ICD-9/10-CM CODE (as string literal, so that terminal 0's aren't truncated.
 ;          e.g., "756.9" for Musculoskeletal Anom NEC/NOS)
 ; GMPORD = Order or sequence (integer) number (starting from 1) to accommodate SNOMED
 ;          Concepts with multiple target ICD code mappings (e.g., for Diabetic
 ;          Neuropathy (SNOMED CT 230572002 ICD-9-CM 250.60/355.9) the order for
 ;          250.60 would be 1, and the order for 355.9 would be 2
 ;
 N GMPID,GMPCSYS
 I '$D(^AUPNPROB("ASCT",GMPSCT)) Q  ; No problems with SNOMED-CT code
 S GMPCSYS=$$SAB^ICDEX(+$$CODECS^ICDEX(GMPICD,80,DT),DT)
 I +$$ICDDATA^ICDXCODE(GMPCSYS,GMPICD,DT,"E")<0 Q  ;valid ICD code only
 S GMPID=0
 S GMPORD=$G(GMPORD,1) ; Order defaults to 1
 F  S GMPID=$O(^AUPNPROB("ASCT",GMPSCT,GMPID)) Q:+GMPID'>0  D
 . N PL,PLY,GMPI,GMPICDS,GMPDX,GMPDXC,GMPDXCS,GMPL0,GMPL802,GMPDXDT
 . Q:'$D(^AUPNPROB(GMPID))
 . ; acquire lock
 . L +^AUPNPROB(GMPID):$G(DILOCKTM,1)
 . E  Q
 . S GMPICDS=$S(GMPCSYS="ICD":"799.9",1:"R69.")
 . S GMPL0=$G(^AUPNPROB(GMPID,0)),GMPL802=$G(^(802)),GMPDX=+GMPL0 ; Current Primary Dx IEN
 . S GMPDXDT=$S(+$P(GMPL802,U,1):$P(GMPL802,U,1),1:$P(GMPL0,U,8)) ; Current Primary Dx Date of Interest
 . S GMPDXCS=$S($P(GMPL802,U,2)]"":$P(GMPL802,U,2),1:$$SAB^ICDEX($$CSI^ICDEX(80,GMPDX),DT)) ; Current Primary Dx Coding System
 . S GMPDXC=$P($$ICDDATA^ICDXCODE(GMPDXCS,GMPDX,DT,"I"),U,2) ; Current Primary Dx Code
 . I GMPORD=1 D
 . . S GMPDX=+$$ICDDATA^ICDXCODE(GMPCSYS,GMPICD,DT,"E"),GMPDXC=GMPICD
 . S $P(GMPICDS,"/",1)=GMPDXC
 . S GMPI=0
 . ; If additional mapped targets exist, append them to the GMPICDS string
 . F  S GMPI=$O(^AUPNPROB(GMPID,803,GMPI)) Q:+GMPI'>0  D
 . . N GMPL803,GMPDXCDT,GMPDXCSY S GMPL803=$G(^AUPNPROB(GMPID,803,GMPI,0))
 . . S GMPDXC=+GMPL803,GMPDXCSY=$S($P(GMPL803,U,2)["ICD9":"ICD",1:$P(GMPL803,U,2))
 . . S GMPDXCDT=$P(GMPL803,U,3)
 . . S $P(GMPICDS,"/",(GMPI+1))=$S(GMPDXC]"":GMPDXC,1:$P($$NOS^GMPLX(GMPDXCSY,GMPDXCDT),U,2))
 . I GMPORD>1 S $P(GMPICDS,"/",GMPORD)=GMPICD
 . ; Replace empty "/"-pieces with 799.9 (ICD-9-CM) or R69 (ICD-10-CM) as appropriate
 . F GMPI=1:1:$L(GMPICDS,"/") S:'$L($P(GMPICDS,"/",GMPI)) $P(GMPICDS,"/",GMPI)=$P($$NOS^GMPLX(GMPDXCS,GMPDXDT),U,2)
 . S PL("PROBLEM")=GMPID,PL("PROVIDER")=.5 ; user is POSTMASTER (evaluate alternatives)
 . S PL("DIAGNOSIS")=GMPDX_U_GMPICDS
 . ; if order is 1, only update entries where .01 is 799.9
 . I GMPORD=1,(+GMPL0'=+$$NOS^GMPLX(GMPDXCS,GMPDXDT)) L -^AUPNPROB(GMPID) Q
 . D UPDATE^GMPLUTL(.PL,.PLY)
 . ; release lock
 . L -^AUPNPROB(GMPID)
 Q
