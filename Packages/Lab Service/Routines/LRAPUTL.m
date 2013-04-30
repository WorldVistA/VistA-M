LRAPUTL ;DALOI/STAFF - AP UTILITIES ;06/21/12  12:06
 ;;5.2;LAB SERVICE;**259,308,350**;Sep 27, 1994;Build 230
 ;
 ; Reference to EXTRACT^TIULQ supported by IA #2693
 ; Reference to ADM^VADPT2 supported by DBIA #325
 ;
 Q
 ;
 ;
ACCYR(LRYROUT,LRYRIN,LRAREA,LRAANM) ;
 ; Return variable (passed by reference):
 ;      LRYROUT = Accession Year LRAD^LRH(0)
 ;                 where LRAD is format 3010000
 ;                       LRH(0) is format 2001
 ;              = -1 - Error Condition
 ;              =  0 - No change from default value (LRYRIN)
 ;
 ; Input parameters:
 ;      LRYRIN  = Default accession year in yyyy format
 ;      LRAREA  = Accession Area Mnemonic (ex. AU,CY,EM,SP)
 ;      LRAANM  = Accession Area Name (ex. SURGICAL PATHOLOGY)
 ;
 S LRYROUT=-1
 Q:LRAREA=""!(LRYRIN="")!(LRAANM="")
 N LRYR1,LRYR2,%DT
 W !!,"Data entry for ",LRYRIN," "
 S %=1 D YN^LRU
 I %<1 D END Q
 I %=1 S LRYROUT=0 K LRYRIN,LRAREA,LRAANM Q
 I %=2 D  I Y<1 D END Q
 . S %DT="AE",%DT(0)="-N",%DT("A")="Enter YEAR: " D ^%DT
 . Q:Y<1
 . S LRYR1=$E(Y,1,3)_"0000",LRYR2=$E(Y,1,3)+1700
 I '$O(^LRO(68,LRAREA,1,LRYR1,1,0)) D  Q
 . W $C(7),!!,"NO ",LRAANM," ACCESSIONS IN FILE FOR ",LRYR2,!!
 . S LRYROUT=-1
 . D END
 S LRYROUT=LRYR1_U_LRYR2
 Q
 ;
 ;
LOOKUP(LRDATA,LRYR1,LRAANM,LRAREA,LRYR2,LRAAN) ;
 ; Call with LRDATA = array to return data (pass by reference)
 ;            LRYR1 = Year portion of accession date , i.e. 2009
 ;           LRAANM = Accession area name
 ;           LRAREA = File #63 subscript
 ;            LRYR2 = FileMan accession date
 ;            LRAAN = Accession number
 ; Lookup by accession number or patient name or UID
 N STOP,X,Y,DIR
 ; preserve if caller sets LRSEL, some expect LRSEL back
 I $D(LRSEL) N LRSEL
 K LR("CK"),LRIDT
 S (STOP,LREND)=0
 S LRDATA=0 W !
 S LRSEL=$$SELBY("Select one")
 I 'LRSEL S LRDATA=-1 S LREND=1 D END Q
 ;
 ; Select by accession number
 I LRSEL=1 D  I STOP D END Q
 . S DIR(0)="NO",DIR("A")="Enter Accession Number"
 . S DIR("?")="Enter the year "_LRYR1_" "_LRAANM_" accession number to be updated"
 . D ^DIR S LRAN=Y K DIR
 . I LRAN=""!(LRAN[U) S LRDATA=-1 S STOP=1 S LREND=1
 ;
 ; Select by patient name
 I LRSEL=3 D  I STOP D END Q
 . S DIR(0)="FO",DIR("A")="Enter Patient Name"
 . S DIR("?")="Locate the accession by entering the patient name."
 . D ^DIR S LRPNM=Y K DIR
 . I LRPNM=""!(LRPNM[U) S LRDATA=-1 S STOP=1 S LREND=1 Q
 . D PNAME^LRAPDA
 . I LRAN<1 S STOP=1 Q
 . S LRDATA=LRDFN,LRDATA(1)=$S('LRAU:LRI,1:"")
 ;
 ; Select by UID
 I LRSEL=2 D  Q:LRUID=""
 . N LRQUIT
 . S LRQUIT=0
 . F  D  Q:LRQUIT
 . . S LRUID="" D UID^LRVERA
 . . I LRUID="" S LRQUIT=1 Q
 . . I LRAA=LRAAN,LRAD=LRYR2 S LRQUIT=1 Q
 . . W !!,$C(7),"UID: ",LRUID," not associated with Accession Area: ",LRAANM,!,?32,"and Accession Year: ",LRYR1,!
 ;
 D OE1^LR7OB63D
 W "  for "_LRYR1
 I '$D(^LRO(68,LRAAN,1,LRYR2,1,LRAN,0)) D  Q
 . S MSG="Accession # "_LRAN_" for "_LRYR1_" not in "_LRAANM
 . D EN^DDIOL(MSG,"","!!") K MSG
 . S LRDATA=-1
 ;
 S LRAA=LRAAN,LRAD=LRYR2
 S X=^LRO(68,LRAAN,1,LRYR2,1,LRAN,0),LRDFN=+X
 S LRODT=$P(X,U,4)
 Q:'$D(^LR(LRDFN,0))  S X=^LR(LRDFN,0) D ^LRUP
 W @IOF
 W !?3,PNM,?35,SSN,?55,"DOB: ",$$FMTE^XLFDT(DOB,1)
 S (LRIDT,LRI)=+$P($G(^LRO(68,LRAAN,1,LRYR2,1,LRAN,3)),"^",5)
 S LRORU3=$G(^LRO(68,LRAAN,1,LRYR2,1,LRAN,.3))
 I LRAREA'="AU",'$D(^LR(LRDFN,LRAREA,LRI,0)) D  Q
 . W $C(7)
 . S MSG(1)="Inverse date missing or incorrect in Accession Area file for"
 . S MSG(1,"F")="!"
 . S MSG(2)=LRAANM_"  Year: "_$E(LRYR2,2,3)_"  Accession: "_LRAN
 . S MSG(2,"F")="!"
 . D EN^DDIOL(.MSG) K MSG
 . S LRDATA=-1
 D DEMGRPH(LRAN,LRAD,LRAA)
 S LRDATA=LRDFN,LRDATA(1)=LRI
 Q
 ;
 ;
DEMGRPH(LRAN,LRAD,LRAA) ; Demographics
 N LRIENS,DA,LRIDT,LRQUIT,LRSPECID,LREDT,LRB
 S LRQUIT=0
 S LRIENS=LRAN_","_LRAD_","_LRAA_","
 S LRSPECID="Acc #: "_$$GET1^DIQ(68.02,LRIENS,15,"E")
 S LRSPECID=LRSPECID_" ["_$$GET1^DIQ(68.02,LRIENS,16)_"]"
 S LREDT=$$GET1^DIQ(68.02,LRAN_","_LRAD_","_LRAA_",",9,"I")
 S LRIDT=+$$GET1^DIQ(68.02,LRAN_","_LRAD_","_LRAA_",",13.5,"I")
 W !?5,"Collection Date: "_$S(LREDT:$$FMTE^XLFDT(LREDT,1),1:"<None on file>")
 W !?10,LRSPECID,!
 I $G(^LRO(68,LRAA,1,LRAD,1,LRAN,"PCE")) W !?15,"PCE ENC # "_^("PCE")
 I $G(LRSS)'="",$O(^LR(LRDFN,LRSS,LRIDT,.1,0)) D
 . N LRX
 . W !?5,"Tissue Specimen(s): ",!
 . S LRX=0 F  S LRX=$O(^LR(LRDFN,LRSS,LRIDT,.1,LRX)) Q:LRX<1!(LRQUIT)  D
 . . I $Y>(IOSL-10) D PG Q:$G(LRQUIT)  D
 . . . W @IOF,!?3,PNM,?35,SSN,?55,"DOB: ",$$FMTE^XLFDT(DOB,1),!
 . . W ?15,$P($G(^LR(LRDFN,LRSS,LRIDT,.1,LRX,0)),U),!
 I $O(^LRO(68,LRAA,1,LRAD,1,LRAN,4,0)) D
 . W ?5,"Test(s): "
 . S LRX=0
 . F  S LRX=$O(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRX)) Q:LRX<1!($G(LRQUIT))  D
 . . I $Y>(IOSL-10) D PG Q:$G(LRQUIT)  W @IOF
 . . W ?15,$P($G(^LAB(60,+LRX,0)),U)," ",$P(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRX,0),U,6),!
 S LRB=0
 F  S LRB=$O(^LR(LRDFN,LRSS,LRIDT,99,LRB)) Q:'LRB  D
 . W !,"COMMENTS:",^LR(LRDFN,LRSS,LRIDT,99,LRB,0)
 ;
 Q
 ;
 ;
GETDOCS(LRDOCS,LRDFN,LRSS,LRI,LRSF) ; Return PCP(inpatient PC/attending/outpt PC/outpt assoc PC/outpt attending) and ordering provider
 N DFN,LRDPF,LRIENS,LRFLD,LRPROVIDER,LRX,X
 S:LRSS="AU" LRSF=63
 S LRDOCS=0
 I '+$G(LRDFN)!($G(LRSS)="")!('+$G(LRSF)) Q
 I "AUSPCYEM"'[LRSS Q
 ;
 I LRSS'="AU" S LRIENS=LRI_","_LRDFN,LRFLD=.07
 E  S LRIENS=LRDFN_",",LRFLD=12.1
 S LRPROVIDER=$$GET1^DIQ(LRSF,LRIENS,LRFLD,"I")
 I LRPROVIDER>0 S LRDOCS=LRDOCS+1,LRDOCS(LRDOCS)=LRPROVIDER_"^"_$$NAME^XUSER(LRPROVIDER,"F")_"^Ordering Provider"
 ;
 S LRDPF=$P($G(^LR(LRDFN,0)),"^",2),DFN=$P($G(^LR(LRDFN,0)),"^",3)
 I LRDPF'=2 Q
 ;
 N LRDT,VADMVT,VAINDT
 I LRSS="AU" S LRDT=$P($G(^LR(LRDFN,"AU")),"^")
 E  S LRDT=$P($G(^LR(LRDFN,LRSS,LRI,0)),"^")
 I LRDT<1 S LRDT=DT
 S VAINDT=LRDT D ADM^VADPT2
 I VADMVT D
 . N VAHOW,VAIN,VAROOT
 . D INP^VADPT
 . I VAIN(2) S LRDOCS=LRDOCS+1,LRDOCS(LRDOCS)=+VAIN(2)_"^"_$$NAME^XUSER(+VAIN(2),"F")_"^Inpatient Primary Care Provider"
 . I VAIN(11) S LRDOCS=LRDOCS+1,LRDOCS(LRDOCS)=+VAIN(11)_"^"_$$NAME^XUSER(+VAIN(11),"F")_"^Inpatient Attending Provider"
 S LRX=$$OUTPTPR^SDUTL3(DFN,LRDT,1)
 I LRX>0 S LRDOCS=LRDOCS+1,LRDOCS(LRDOCS)=+LRX_"^"_$$NAME^XUSER(+LRX,"F")_"^Outpatient Primary Care Provider"
 S LRX=$$OUTPTPR^SDUTL3(DFN,LRDT,2)
 I LRX>0 S LRDOCS=LRDOCS+1,LRDOCS(LRDOCS)=+LRX_"^"_$$NAME^XUSER(+LRX,"F")_"^Outpatient Attending Provider"
 ;
 ; Check for surgery case reference and retrieve surgeon and attending
 K LRIENS
 S LRIENS=LRDFN_","_LRSS_","_LRI_",0"
 S LRX=$O(^LR(LRDFN,"EPR","AD",LRIENS,1,0))
 I LRX>0 D
 . N LRDATA,LRJ,LRREF,LRSRDATA,LRSRTN,LRTITLE
 . S LRREF=LRX_","_LRDFN_","
 . D GETDATA^LRUEPR(.LRDATA,LRREF)
 . S LRSRTN=LRDATA(63.00013,LRREF,1,"I")
 . I $P(LRSRTN,";",2)'="SRF(" Q
 . D SRCASE^LRUEPR(.LRSRDATA,+LRSRTN)
 . I $G(LRSRDATA("ERR")) D  Q
 . . S LRMD("ERR")=LRSRDATA("ERR")
 . . D SRCASERR^LRUEPR(LRREF,LRSRTN,LRSRDATA("ERR"))
 . F LRJ=.14,.164,123,124 D
 . . S LRX=LRSRDATA(130,+LRSRTN_",",LRJ,"I")
 . . I LRX="" Q
 . . S LRTITLE=$S(LRJ=.14:"Surgeon",LRJ=.164:"Attending Surgeon",LRJ=123:"Provider",LRJ=124:"Attending Provider",1:"")
 . . I LRPROVIDER,LRX=LRPROVIDER S LRDOCS(1)=LRDOCS(1)_"/"_LRTITLE Q
 . . S LRDOCS=LRDOCS+1,LRDOCS(LRDOCS)=LRX_"^"_$$NAME^XUSER(LRX,"F")_"^"_LRTITLE
 Q
 ;
 ;
RELEASE(LRRELEAS,LRDFN,LRSS,LRI) ;
 ; Determine if report has been released
 N LRFILE,LRFLDS,LRIENS,LRRELAR,LRCT
 I '+$G(LRDFN) S LRRELEAS=0 Q
 I $G(LRSS)=""!("AUSPEMCY"'[LRSS) S LRRELEAS=0 Q
 I LRSS'="AU",'+$G(LRI) S LRRELEAS=0 Q
 I LRSS="AU" D
 . S LRFILE=63,LRFLDS="14.7;14.8",LRIENS=LRDFN_","
 I LRSS'="AU" D
 . S LRFILE=$S(LRSS="SP":63.08,LRSS="CY":63.09,LRSS="EM":63.02,1:"")
 . S LRFLDS=".11;.13;.15"
 . S LRIENS=LRI_","_LRDFN_","
 Q:LRFILE=""
 D GETS^DIQ(LRFILE,LRIENS,LRFLDS,"I","LRRELAR")
 F LRCT=1:1:$S(LRSS="AU":2,1:3) D
 . S LRRELEAS(LRCT)=+$G(LRRELAR(LRFILE,LRIENS,$P(LRFLDS,";",LRCT),"I"))
 Q
 ;
 ;
TIUCHK(LRPTR,LRDFN,LRSS,LRI) ;
 ; Check to see if report is in TIU
 N LRTREC,LRROOT,LRFILE,LRIENS,LRFLD,LRREL
 I LRSS=""!("AUSPEMCY"'[LRSS) S LRPTR=0 Q
 I LRSS="AU" D
 . S LRROOT="^LR(LRDFN,101,""A"")",LRIENS=LRDFN_","
 . S LRFILE=63.101
 I LRSS'="AU" D
 . S LRROOT="^LR(LRDFN,LRSS,LRI,.05,""A"")"
 . S LRIENS=LRI_","_LRDFN_","
 . S LRFILE=$S(LRSS="SP":63.19,LRSS="CY":63.47,LRSS="EM":63.49,1:"")
 S LRTREC=$O(@(LRROOT),-1)
 I LRFILE=""!(LRTREC="") S LRPTR=0 Q
 S LRIENS=LRTREC_","_LRIENS
 S LRPTR=+$$GET1^DIQ(LRFILE,LRIENS,1,"I")
 S:LRPTR LRPTR("D")=+$$GET1^DIQ(LRFILE,LRIENS,.01,"I")
 I LRSS="AU" D
 . S LRFILE=63,LRIENS=LRDFN_",",LRFLD=14.7
 I LRSS'="AU" D
 . S LRFLD=$S(LRSS="CY":9,LRSS="SP":8,LRSS="EM":2,1:"")
 . Q:LRFLD=""
 . S LRFILE=+$$GET1^DID(63,LRFLD,"","SPECIFIER"),LRFLD=.11
 . Q:LRFILE=""
 . S LRIENS=LRI_","_LRDFN_","
 S LRREL=+$$GET1^DIQ(LRFILE,LRIENS,LRFLD,"I")
 I 'LRREL K LRPTR S LRPTR=0 Q
 I LRREL'=+$G(LRPTR("D")) K LRPTR S LRPTR=0
 Q
 ;
 ;
ESIGINF(LRESINF,LRDFN,LRSS,LRI) ;Return Esig Info
 N LRTIUDA,LRESINF1
 Q:'$D(LRDFN)!('$D(LRSS))
 Q:LRSS=""!("AUSPEMCY"'[LRSS)
 D TIUCHK(.LRTIUDA,LRDFN,LRSS,$G(LRI))
 Q:'+$G(LRTIUDA)
 D EXTRACT^TIULQ(LRTIUDA,"LRESINF1(""ESIG"")",,,,,,1)
 Q:'$D(LRESINF1("ESIG",LRTIUDA))
 S LRESINF(1)=$G(LRESINF1("ESIG",LRTIUDA,1501,"E"))
 S LRESINF(2)=$G(LRESINF1("ESIG",LRTIUDA,1503,"E"))
 Q
 ;
 ;
NEWLN(LRTEXT,TAB) ;
 S LCT=$G(LCT)+1,BTAB=0
 S TAB=+TAB
 D GLBWRT(LRTEXT,TAB)
 Q
 ;
 ;
GLBWRT(LRTEXT,TAB) ;Write to global
 D GLB(LCT,TAB,BTAB,LRTEXT,GROOT,.ATAB)
 S BTAB=ATAB
 Q
 ;
 ;
GLB(LINE,TAB,BTAB,TEXT,ROOT,ATAB) ;
 ; This subroutine is used to store report text to a global.
 ; Input variables:
 ; LINE = Current line number
 ; TAB  = Desired tab position (not required)
 ; BTAB = Current tab position BEFORE text is stored
 ; TEXT = Text string to be stored
 ; ROOT = Global root
 ;
 ; Output variables:
 ; ATAB = Current tab position after text storage
 ;
 N LRSPC,LRINC,FTEXT,LRLINE
 S LRSPC="" F LRINC=1:1:80 S LRSPC=LRSPC_" "
 S:BTAB="" BTAB=0
 S:+TAB=0 TAB=BTAB
 S FTEXT=TEXT
 I TAB,TAB>BTAB S FTEXT=$E(LRSPC,1,TAB-BTAB)_TEXT
 S:'$D(@(ROOT_"0)")) @(ROOT_"0)")="^^^^"_DT_"^"
 S LRLINE=LINE,LINE=LINE_",0"
 S:'$D(@(ROOT_LINE_")")) @(ROOT_LINE_")")=""
 S @(ROOT_LINE_")")=@(ROOT_LINE_")")_FTEXT
 S $P(@(ROOT_"0)"),"^",3,4)=LRLINE_"^"_LRLINE
 S ATAB=TAB+$L(TEXT)
 Q
 ;
 ;
PROVIDR ; Entry of provider taken from PRO^LRCAPES
 S LREND=0
 D
 . N LRPRONM,DIR,DIRUT,DUOUT,X,Y
 . S LRPRONM=$$GET1^DIQ(200,+$G(LRPRO),.01,"I")
 . I $L(LRPRONM),$D(^VA(200,"AK.PROVIDER",LRPRONM,+$G(LRPRO)))#2,$$GET^XUA4A72(+$G(LRPRO),DT)>0 S DIR("B")=LRPRONM
 . S DIR("A")="Provider"
 . S LRPRO=0,DIR(0)="PO^200:ENMZ"
 . S DIR("S")="I $D(^VA(200,""AK.PROVIDER"",$P(^(0),U),+Y)),$$GET^XUA4A72(+Y,DT)>0"
 . D ^DIR
 . I Y>1 S LRPRO=+Y
 I '$G(LRPRO) D  D END^LRCAPES Q
 . W !?5,"No Active Provider Selected",!
 . S LRNOP=1
 . S LRQUIT=1
 I '$D(^LRO(68,LRAA,1,LRAD,1,LRAN,0))#2 D  D END^LRCAPES
 . W !?5,"The accession is corrupt - missing zero node",!
 . S LRNOP="7^Corrupt Accession"
 . S LRQUIT=1
 Q
 ;
 ;
REFRRL ; Display informational message on referrals
 N LRMSG
 S LRMSG(1)=$$CJ^XLFSTR("*** NOTE: This "_$P(^DIC(LRDPF,0),"^")_" report will not be stored in TIU",IOM),LRMSG(1,"F")="!!"
 S LRMSG(2)=$$CJ^XLFSTR("and therefore does not have an electronic signature.",IOM)
 S LRMSG(3)=$$CJ^XLFSTR("A hardcopy signature will be required for this report.",IOM)
 D EN^DDIOL(.LRMSG)
 Q
 ;
 ;
PG ; Page break
 N DIR,DIRUT,DUOUT,DTOUT
 S DIR(0)="E" D ^DIR
 I $G(DIRUT) S LRQUIT=1
 Q
 ;
 ;
END ;
 K LRYRIN,LRAREA,LRAANM
 Q
 ;
 ;
SELBY(X1) ; Select by accession number or unique identifier(UID) or patient name
 ; Call with X1= message prompt
 ; Returns Y=0 (abort)
 ;          =1 (accession number)
 ;          =2 (unique identifier)
 ;          =3 (patient name)
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="SO^1:Accession number;2:Unique Identifier (UID);3:Patient Name",DIR("A")=X1
 S X=$$GET^XPAR("USR^DIV^PKG","LR AP REPORT SELECTION",1,"Q")
 S DIR("B")=$S(X:X,1:1)
 D ^DIR
 I $D(DIRUT) S Y=0
 Q Y
 ;
 ;
GETPCP(LRPCP,LRDFN,LRSS,LRIDT) ; Return PCP(inpatient PC/attending/outpt PC)
 ;
 ; Call with LRPCP = primary care provider array (pass by reference)
 ;           LRDFN = internal entry in file #63
 ;            LRSS = file #63 subscript
 ;           LRIDT = file #63 specimen inverse date/time
 ;
 ; Returns   LRPCP    = IEN of provider in file #200 (0 if none)
 ;           LRPCP(1) = standardized formatted name (null if none)
 ;
 N DFN,LRDPF,LRDT,LRX,VADMVT,VAINDT
 ;
 S LRPCP=0,LRPCP(1)=""
 I +$G(LRDFN)<0 Q
 ;
 I LRSS'?1(1"SP",1"CY",1"EM",1"AU") Q
 ;
 S LRDPF=$P($G(^LR(LRDFN,0)),"^",2),DFN=$P($G(^LR(LRDFN,0)),"^",3)
 I LRDPF'=2 Q
 ;
 ; Retreive specimen collection date/time otherwise default to today
 I LRSS="AU" S LRDT=$P($G(^LR(LRDFN,"AU")),"^")
 E  S LRDT=$P($G(^LR(LRDFN,LRSS,LRIDT,0)),"^")
 I LRDT<1 S LRDT=DT
 ;
 ; Check if patient was inpatient on specimen date/time
 ;  and retrieve inpatient primary care provider (VAIN(2)) or attending (VAIN(11))
 S VAINDT=LRDT D ADM^VADPT2
 I VADMVT D
 . N VAHOW,VAIN,VAROOT
 . D INP^VADPT
 . I VAIN(2) S LRPCP=+VAIN(2) Q
 . I VAIN(11) S LRPCP=+VAIN(11)
 ;
 ; If no inpatient primary care/attending then check for outpatient PCP
 ;    1 - PC Practitioner
 ;      then   2 - Attending
 I LRPCP<1 D
 . S LRX=$$OUTPTPR^SDUTL3(DFN,LRDT,1)
 . I LRX>0 S LRPCP=+LRX Q
 . S LRX=$$OUTPTPR^SDUTL3(DFN,LRDT,2)
 . I LRX>0 S LRPCP=+LRX Q
 ;
 ; If primary care provider then return formatted name
 I LRPCP D
 . N LRNAME
 . S LRNAME("FILE")=200,LRNAME("FIELD")=.01,LRNAME("IENS")=LRPCP_","
 . S LRPCP(1)=$$NAMEFMT^XLFNAME(.LRNAME,"G","DcMP")
 ;
 Q
