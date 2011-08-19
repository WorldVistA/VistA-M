LRAPUTL ;DALOI/WTY - AP UTILITIES;2/26/01
 ;;5.2;LAB SERVICE;**259,308**;Sep 27, 1994
 ;
 ;Reference  to EXTRACT^TIULQ supported by IA #2693
 ;
 Q
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
 N LRYR1,LRYR2
 W !!,"Data entry for ",LRYRIN," "
 S %=1 D YN^LRU
 I %<1 D END Q
 I %=1 S LRYROUT=0 K LRYRIN,LRAREA,LRAANM Q
 I %=2 D  I Y<1 D END Q
 .S %DT="AE",%DT(0)="-N",%DT("A")="Enter YEAR: " D ^%DT
 .Q:Y<1
 .S LRYR1=$E(Y,1,3)_"0000",LRYR2=$E(Y,1,3)+1700
 I '$O(^LRO(68,LRAREA,1,LRYR1,1,0)) D  Q
 .W $C(7),!!,"NO ",LRAANM," ACCESSIONS IN FILE FOR ",LRYR2,!!
 .S LRYROUT=-1
 .D END
 S LRYROUT=LRYR1_U_LRYR2
 Q
 ;
LOOKUP(LRDATA,LRYR1,LRAANM,LRAREA,LRYR2,LRAAN) ;
 ;Lookup by accession number or patient name
 K X,Y,LR("CK"),DIR
 S LRDATA=-1 W !
 S DIR(0)="FO",DIR("A")="Select Accession Number/Pt name"
 S DIR("?",1)="Enter the year "_LRYR1_" "_LRAANM_" accession number to"
 S DIR("?",1)=DIR("?",1)_" be updated"
 S DIR("?")="or locate the accession by entering the patient name."
 D ^DIR S LRAN=Y K DIR
 I LRAN=""!(LRAN[U) D END S LRDATA=-1 Q
 I LRAN'?1N.N D  Q
 .D PNAME^LRAPDA
 .I LRAN<1 S LRDATA=-1 Q
 .S LRDATA=LRDFN,LRDATA(1)=$S('LRAU:LRI,1:"")
 .D OE1^LR7OB63D
 D OE1^LR7OB63D
 W "  for "_LRYR1
 I '$D(^LRO(68,LRAAN,1,LRYR2,1,LRAN,0)) D  Q
 .S MSG="Accession # "_LRAN_" for "_LRYR1_" not in "_LRAANM
 .D EN^DDIOL(MSG,"","!!") K MSG
 .S LRDATA=0
 S X=^LRO(68,LRAAN,1,LRYR2,1,LRAN,0),LRDFN=+X
 Q:'$D(^LR(LRDFN,0))  S X=^LR(LRDFN,0) D ^LRUP
 W @IOF
 W !?3,PNM,?35,SSN,?55,"DOB: ",$$FMTE^XLFDT(DOB,1)
 S LRI=+$P($G(^LRO(68,LRAAN,1,LRYR2,1,LRAN,3)),"^",5)
 I LRAREA'="AU",'$D(^LR(LRDFN,LRAREA,LRI,0)) D  Q
 .W $C(7)
 .S MSG(1)="Inverse date missing or incorrect in Accession Area file "
 .S MSG(1)=MSG(1)_"for"
 .S MSG(1,"F")="!"
 .S MSG(2)=LRAANM_"  Year: "_$E(LRYR2,2,3)_"  Accession: "_LRAN
 .S MSG(2,"F")="!"
 .D EN^DDIOL(.MSG) K MSG
 .S LRDATA=-1
 D DEMGRPH(LRAN,LRAD,LRAA)
 S LRDATA=LRDFN,LRDATA(1)=LRI
 Q
DEMGRPH(LRAN,LRAD,LRAA) ;Demographics
 N LRIENS,DA,LRIDT,LRQUIT,LRSPECID,LREDT,LRIDT,LRCDT
 S LRQUIT=0
 S LRIENS=LRAN_","_LRAD_","_LRAA_","
 S LRSPECID="Acc #: "_$$GET1^DIQ(68.02,LRIENS,15,"E")
 S LRSPECID=LRSPECID_$$GET1^DIQ(68.02,LRIENS,16)
 S LREDT=$$GET1^DIQ(68.02,LRAN_","_LRAD_","_LRAA_",",9,"I")
 S LRIDT=+$$GET1^DIQ(68.02,LRAN_","_LRAD_","_LRAA_",",13.5,"I")
 I LREDT S LRCDT="Collection Date: "_$$FMTE^XLFDT(LREDT,1)
 W !?5,LRCDT
 W !?10,LRSPECID,!
 I $G(^LRO(68,LRAA,1,LRAD,1,LRAN,"PCE")) W !?15,"PCE ENC # "_^("PCE")
 I $L($G(LRSS)),$O(^LR(LRDFN,LRSS,LRIDT,.1,0)) D
 .N LRX
 .W !?5,"Tissue Specimen(s): ",!
 .S LRX=0 F  S LRX=$O(^LR(LRDFN,LRSS,LRIDT,.1,LRX)) Q:LRX<1!(LRQUIT)  D
 ..I $Y>(IOSL-10) D PG Q:$G(LRQUIT)  D
 ...W @IOF,!?3,PNM,?35,SSN,?55,"DOB: ",$$FMTE^XLFDT(DOB,1),!
 ..W ?15,$P($G(^LR(LRDFN,LRSS,LRIDT,.1,LRX,0)),U),!
 I $O(^LRO(68,LRAA,1,LRAD,1,LRAN,4,0)) D
 .W ?5,"Test(s): "
 .S LRX=0
 .F  S LRX=$O(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRX)) Q:LRX<1!($G(LRQUIT))  D
 ..I $Y>(IOSL-10) D PG Q:$G(LRQUIT)  W @IOF
 ..W ?15,$P($G(^LAB(60,+LRX,0)),U),!
 S:$G(LRQUIT) LRQUIT=0
 Q
GETDOCS(LRDOCS,LRDFN,LRSS,LRI,LRSF) ;Return PCP and provider
 N LRPF,DFN,LRIENS,LRFLD
 S:LRSS="AU" LRSF=63
 I '+$G(LRDFN)!($G(LRSS)="")!('+$G(LRSF)) S LRDOCS=0 Q
 I "AUSPCYEM"'[LRSS S LRDOCS=0 Q
 S LRPF=+$$GET1^DIQ(63,LRDFN_",",.02,"I")
 S DFN=$$GET1^DIQ(63,LRDFN_",",.03,"I")
 S LRDOCS(1)=0
 I LRPF=2 D
 .D INP^VADPT
 .S LRDOCS(1)=+VAIN(2)
 S LRIENS=LRDFN_","
 I LRSS'="AU" S LRIENS=LRI_","_LRIENS,LRFLD=.07
 S:LRSS="AU" LRFLD=13.5
 S LRDOCS(2)=$$GET1^DIQ(LRSF,LRIENS,LRFLD,"I")
 Q
RELEASE(LRRELEAS,LRDFN,LRSS,LRI) ;
 ;Determine if report has been released
 N LRFILE,LRFLDS,LRIENS,LRRELAR,LRCT
 I '+$G(LRDFN) S LRRELEAS=0 Q
 I $G(LRSS)=""!("AUSPEMCY"'[LRSS) S LRRELEAS=0 Q
 I LRSS'="AU",'+$G(LRI) S LRRELEAS=0 Q
 I LRSS="AU" D
 .S LRFILE=63,LRFLDS="14.7;14.8",LRIENS=LRDFN_","
 I LRSS'="AU" D
 .S LRFILE=$S(LRSS="SP":63.08,LRSS="CY":63.09,LRSS="EM":63.02,1:"")
 .S LRFLDS=".11;.13;.15"
 .S LRIENS=LRI_","_LRDFN_","
 Q:LRFILE=""
 D GETS^DIQ(LRFILE,LRIENS,LRFLDS,"I","LRRELAR")
 F LRCT=1:1:$S(LRSS="AU":2,1:3) D
 .S LRRELEAS(LRCT)=+$G(LRRELAR(LRFILE,LRIENS,$P(LRFLDS,";",LRCT),"I"))
 Q
TIUCHK(LRPTR,LRDFN,LRSS,LRI) ;
 ;Check to see if report is in TIU
 N LRTREC,LRROOT,LRFILE,LRIENS,LRFLD,LRREL
 I LRSS=""!("AUSPEMCY"'[LRSS) S LRPTR=0 Q
 I LRSS="AU" D
 .S LRROOT="^LR(LRDFN,101,""A"")",LRIENS=LRDFN_","
 .S LRFILE=63.101
 I LRSS'="AU" D
 .S LRROOT="^LR(LRDFN,LRSS,LRI,.05,""A"")"
 .S LRIENS=LRI_","_LRDFN_","
 .S LRFILE=$S(LRSS="SP":63.19,LRSS="CY":63.47,LRSS="EM":63.49,1:"")
 S LRTREC=$O(@(LRROOT),-1)
 I LRFILE=""!(LRTREC="") S LRPTR=0 Q
 S LRIENS=LRTREC_","_LRIENS
 S LRPTR=+$$GET1^DIQ(LRFILE,LRIENS,1,"I")
 S:LRPTR LRPTR("D")=+$$GET1^DIQ(LRFILE,LRIENS,.01,"I")
 I LRSS="AU" D
 .S LRFILE=63,LRIENS=LRDFN_",",LRFLD=14.7
 I LRSS'="AU" D
 .S LRFLD=$S(LRSS="CY":9,LRSS="SP":8,LRSS="EM":2,1:"")
 .Q:LRFLD=""
 .S LRFILE=+$$GET1^DID(63,LRFLD,"","SPECIFIER"),LRFLD=.11
 .Q:LRFILE=""
 .S LRIENS=LRI_","_LRDFN_","
 S LRREL=+$$GET1^DIQ(LRFILE,LRIENS,LRFLD,"I")
 I 'LRREL K LRPTR S LRPTR=0 Q
 I LRREL'=LRPTR("D") K LRPTR S LRPTR=0
 Q
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
NEWLN(LRTEXT,TAB) ;
 S LCT=$G(LCT)+1,BTAB=0
 S TAB=+TAB
 D GLBWRT(LRTEXT,TAB)
 Q
GLBWRT(LRTEXT,TAB) ;Write to global
 D GLB(LCT,TAB,BTAB,LRTEXT,GROOT,.ATAB)
 S BTAB=ATAB
 Q
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
 I TAB,TAB>BTAB D
 .S FTEXT=$E(LRSPC,1,TAB-BTAB)_TEXT
 S:'$D(@(ROOT_"0)")) @(ROOT_"0)")="^^^^"_DT_"^"
 S LRLINE=LINE,LINE=LINE_",0"
 S:'$D(@(ROOT_LINE_")")) @(ROOT_LINE_")")=""
 S @(ROOT_LINE_")")=@(ROOT_LINE_")")_FTEXT
 S $P(@(ROOT_"0)"),"^",3,4)=LRLINE_"^"_LRLINE
 S ATAB=TAB+$L(TEXT)
 Q
PROVIDR ;Entry of provider taken from PRO^LRCAPES        
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
REFRRL ;Display informational message on referrals
 S LRMSG2=$P(^DIC(LRDPF,0),"^")
 S LRMSG="*** NOTE: This "_LRMSG2_" report will not be stored in TIU,"
 S LRMSG(1)=$$CJ^XLFSTR(LRMSG,IOM)
 S LRMSG(1,"F")="!!"
 S LRMSG="  and therefore, does not have an electronic signature."
 S LRMSG(2)=$$CJ^XLFSTR(LRMSG,IOM)
 S LRMSG="A hardcopy signature will be required for this report."
 S LRMSG(3)=$$CJ^XLFSTR(LRMSG,IOM)
 D EN^DDIOL(.LRMSG)
 K LRMSG
 Q
PG ;Page break
 N DIR,DIRUT,DUOUT,DTOUT
 S DIR(0)="E" D ^DIR
 I $G(DIRUT) S LRQUIT=1
 Q
END ;
 K LRYRIN,LRAREA,LRAANM
 Q
