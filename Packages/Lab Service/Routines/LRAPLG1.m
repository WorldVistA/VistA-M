LRAPLG1 ;DALOI/CKA/JMC - LOG-IN CONT. ;07/16/12  11:11
 ;;5.2;LAB SERVICE;**72,121,248,308,350**;Sep 27, 1994;Build 230
 ;
 ; Reference to DISP^SROSPLG supported by IA #893
 ;
START ; Start logging in the specimens.
 N LRFND,LRMSG,LRXX
 ;
 ; Lock ^LR( and ^LRO
 D LOCK^DILF("^LR(LRDFN,LRSS)")
 I '$T D  Q
 . S LRMSG="This record is locked by another user. Please try later."
 . D EN^DDIOL(LRMSG,"","!!")
 ;
 D LOCK^DILF("^LRO(68,LRAA,1,LRAD,1,0)")
 I '$T D  Q
 . L -^LR(LRDFN,LRSS)
 . S LRMSG="Someone else is logging in specimens.  Please wait and try again."
 . D EN^DDIOL(LRMSG,"","!!")
 ;
 ; Check that accession date exists first
 D CHECK68^LRWLST1(LRAA,LRAD)
 ;
EN ;
 S LRAN=+$P(^LRO(68,LRAA,1,LRAD,1,0),U,3),(LRI,LRIDT)=""
 F  Q:'$D(^LRO(68,LRAA,1,LRAD,1,LRAN))  S LRAN=LRAN+1
 W !!,"Assign ",LRO(68)," (",LRABV,") accession #: ",LRAN S %=1 D YN^LRU
 I %<1 L -^LRO(68,LRAA,1,LRAD,1,0),-^LR(LRDFN,LRSS) Q
 ;
 I %=1,$D(LRXREF),$D(^LR(LRXREF,LRH(2),LRABV,LRAN)) D  Q:$D(LRFND)
 . I $D(^LRO(68,LRAA,1,LRAD,1,LRAN,0)),$P(^(0),U) S X=LRAN D ^LRUTELL S LRFND=1
 . I '$D(LRFND) D ^LRAPLG2
 . I $D(LRFND) L -^LRO(68,LRAA,1,LRAD,1,0),-^LR(LRDFN,LRSS) Q
 . S %=0
 ;
 I %=1 D CRE868 I $D(LRMSG) G EN
 ;
 I %=2 D OS I $D(LRFND) K LRFND L -^LRO(68,LRAA,1,LRAD,1,0),-^LR(LRDFN,LRSS) Q
 ;
 L -^LRO(68,LRAA,1,LRAD,1,0)
 ;
 S LRAC=$P(^LRO(68,LRAA,0),U,11)_" "_$S(LRAD["0000":$E(LRAD,2,3),1:$E(LRAD,4,7))_" "_LRAN
 ;
AU ; Autopsy Specific
 I LRSS="AU" D ^LRAUAW Q
 S:'$D(^LR(LRDFN,LRSS,0)) ^(0)="^"_LRSF_"DA^0^0"
 ;
 ; If orginal login then create entry in file #63
LR7OFA0 ;
 I LRIDT="" D CRE863
 I LRI="" Q
 ;
 K DA,DTOUT,DIWESUB
 ;S DIWESUB=$E(PNM,1,27-$L(LRACC))_" ["_LRACC_"]"
 S LR(.07)=$S($D(SRDOC):SRDOC,1:"") K SRDOC
 S:LR(.07) LR(.07)=$P($G(^VA(200,LR(.07),0)),"^")
 S DA=LRI,DA(1)=LRDFN
 S DIC(0)="EQLMF",DLAYGO=63,DIE="^LR(LRDFN,LRSS,"
 D @LR("L")
 D ^DIE K DLAYGO
 S:'$D(LRRC) LRRC=LRNT
 ;
 ; Check if topography and collection sample entered on each specimen.
 ; If not entered then define Y to cause entry to be deleted.
 I LRSS?1(1"SP",1"CY",1"EM") D
 . N I,LRJ,X
 . S LRJ=0
 . F  S LRJ=$O(^LR(LRDFN,LRSS,LRI,.1,LRJ)) Q:LRJ<1  D  Q:$D(Y)
 . . S X=$G(^LR(LRDFN,LRSS,LRI,.1,LRJ,0))
 . . F I=6,7 I $P(X,"^",I)="" S Y="" Q
 ;
 ; Delete entry if prompts not answered unless report has been released.
 I $D(DTOUT)!$D(Y) D  Q
 . N DA,DIK
 . I LRSS?1(1"SP",1"CY",1"EM"),($P(^LR(LRDFN,LRSS,LRI,0),"^",11)!$P(^LR(LRDFN,LRSS,LRI,0),"^",15)) Q
 . W $C(7),!!,"All Prompts not answered - <ENTRY DELETED>"
 . S DA(1)=LRDFN,DA=LRI
 . S DIK="^LR("_DA(1)_","""_LRSS_""","
 . D ^DIK,X,END
 ;
 D GETSTCS ; Store specimen topography, coll sample in temp array
 ;
TST ; Get the ordered test and store in temp array
 N II
 D ORDTST
 ; Delete entry if no ordered tests unless report has been released.
 I II=2 D  Q
 . I LRSS?1(1"SP",1"CY",1"EM"),($P(^LR(LRDFN,LRSS,LRI,0),"^",11)!$P(^LR(LRDFN,LRSS,LRI,0),"^",15)) Q
 . N DA,DIK
 . W $C(7),!!,"No ordered test selected - <ENTRY DELETED>"
 . S DA(1)=LRDFN,DA=LRI,DIK="^LR("_DA(1)_","""_LRSS_""","
 . D ^DIK,X,END
 ;
 I LRSS="CY",LRCAPA D CK^LRAPCWK
 ;
 ; Check for surgery case references and move info if user wants surgical case info copied to Lab.
 I LRSS="SP" D SPMOVE
 ;
 ; Fill out the stub accession with related info
 I '$D(LRC(5)) S LRC(5)=""
 D ^LRUWLF
 ;
 I LRCAPA D
 . I LRSS="CY" D ^LRAPCWK
 . I LRSS?1(1"SP",1"EM") D ^LRAPSWK
 ;
 I LRSS?1(1"SP",1"CY",1"EM") D ^LRSPGD
 ;
 D OERR^LR7OB63D,LDSI
 ;
 Q
 ;
 ;
LDSI ; LDSI tasks
 ;
 N LRLLOC,LRALOC,LRPRAC,LROUTINE,LROPL,LRODT,LRNT,LRFILE,LRIENS,LRORD,LRSRDT,LRTST
 ;
 ; Get variables for ORUT node
 S LROUTINE=$P($G(^LAB(69.9,1,3)),"^",2)    ;default urgency
 S LRPROVL=LRMD(1)    ;Ordering provider-CKA
 ; Get ORDER TYPE
 ;S LROT=??
 S LRORDR="SP" ;Default to 'Send Patient' for now
 S LRNT=$$NOW^XLFDT() ;Date ordered = current date/time
 S LRODT=$P(LRNT,".")
 ; Get Provider, Location abbrev, Collection date/time
 S LRFILE=$S(LRSS="SP":63.08,LRSS="CY":63.09,LRSS="EM":63.02,1:"")
 S LRIENS=LRI_","_LRDFN_","
 S LRPRAC=+$$GET1^DIQ(LRFILE,LRIENS,.07,"I")
 S LRLLOC=$$GET1^DIQ(LRFILE,LRIENS,.08,"I")
 I LRLLOC="" S LRLLOC="NO ABRV"
 S LRSDT=+$$GET1^DIQ(LRFILE,LRIENS,.01,"I")
 S LRSRDT=$$GET1^DIQ(LRFILE,LRIENS,.1,"I") ; Specimen received date/time
 ; Get CPRS Order #
 S ORIFN="" ; Default to blank for now
 ;
 ; Get Lab Order #, update file #69 and #68
 S (LRORD,LRSPEC,LRTST,LRSAMP,LRADD,LROT)="",LRCNT=1
 F  S LRSPEC=$O(LRXX(LRSPEC)) Q:'LRSPEC  D
 . N LRRECINF
 . S LRSAMP=$P(LRXX(LRSPEC),"^",1),LRNLT=$P(LRXX(LRSPEC),"^",2),LRTST=$P(LRXX(LRSPEC),"^",3)
 . Q:'LRTST
 . ; Add entry in #69 for each specimen
 . I LRORD S LRADD=1 D ZSN^LR7OFAO("",.LRRECINF)
 . ; Get Lab Order # first time thru
 . D:'LRORD EN^LR7OFAO(LRODT,LRDFN,LRSAMP,LRORDR,LRNT,LRPRAC,LRLLOC,LRSDT,ORIFN,LRSPEC,LRSS,LRTST,LRUID,.LRRECINF)
 . S LRSN=+$P(^LRO(68,LRAA,1,LRAD,1,LRAN,0),U,5),LRCDT=0,LREAL=""
 . I LRSN>0 S LRCDT=$P($G(^LRO(69,LRODT,1,LRSN,1)),"^",1,2),LREAL=$P(LRCDT,"^",2),LRCDT=+LRCDT
 . D UPD68,UPD63
 . S LRCNT=LRCNT+1
 ;
 Q
 ;
 ;
UPD68 ; Update #68 with required test data
 N LRFILE,LRERR,IEN,LRIEN
 S LRFILE=68.04,IEN(1)=LRTST
 S LRIEN="?+1,"_LRAN_","_LRAD_","_LRAA_","
 S FDA(3,LRFILE,LRIEN,.01)=LRTST
 S FDA(3,LRFILE,LRIEN,1)=LROUTINE
 D UPDATE^DIE("","FDA(3)","IEN","LRERR(3)")
 I $D(LRERR(3)) D LRMSG("UPD68-3~LRAPLG1",.LRERR)
 ;. S ^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRTST,0)=LRTST_"^"_LROUTINE
 ;
 ; Update #68 with specimen data
 K LRFILE,FDAIEN,IEN
 S LRFILE=68.05
 ; Check or Set top node for 68.05
 S FDAIEN="?+"_LRCNT_","_LRAN_","_LRAD_","_LRAA_","
 S FDA(31,LRFILE,FDAIEN,.01)=LRSPEC
 S FDA(31,LRFILE,FDAIEN,1)=LRSAMP
 D UPDATE^DIE("","FDA(31)","IEN","LRERR(31)")
 I $D(LRERR(31)) D LRMSG("UPD68-31~LRAPLG1",.LRERR)
 ;
 Q
 ;
 ;
UPD63 ; Update ORUT Node in #63
 S LRTSORU=LRTST,LRURG=9,LRI=LRIDT
 D SLRSS^LRWLST11
 D ORUT^LRWLST11
 ;. S ^LR(LRDFN,LRSS,LRI,"ORUT",LRCNT,0)=LRNLT_"^"_LROUTINE_"^"_ORIFN_"^"_LRORD_"^"_LROT_"^"_LRPRAC_"^^"_LRSPEC_"^"_LRSAMP
 ;
 Q
 ;
 ;
X ; from LRAUAW
 I "CYEMSP"[LRSS K ^LR(LRXREF,LRH(2),LRABV,LRAN)
 I LRSS="AU" D
 . I $D(^LR(LRDFN,"AV")) K ^LR(LRDFN,"AV")
 . I $D(^LR(LRDFN,"AW")) K ^LR(LRDFN,"AW")
 . I $D(^LR(LRDFN,"AWI")) K ^LR(LRDFN,"AWI")
 . I $D(LRRC) K ^LR("AAUA",+$E(LRRC,1,3),LRABV,LRAN),^LR("AAU",+LRRC,LRDFN)
 I $G(LRRC)>1 K:LRSS?1(1"SP",1"CY",1"EM") ^LR(LRXR,LRRC,LRDFN,LRI)
 K LRRC
 Q
 ;
 ;
OS ; User choosing accession number
 N DIR,DIROUT,DIRUT,DTOUT,LRSPEC,X,Y
 S DIR(0)="N^1:999999:0^D OSDIR^LRAPLG1"
 S DIR("A")="Enter Accession #"
 D ^DIR
 I $D(DIRUT) S LRFND=1 Q
 S LRAN=Y
 ;
 I $G(^LRO(68,LRAA,1,LRAD,1,LRAN,0)) D  Q
 . I $D(LRXREF),$D(^LR(LRXREF,LRH(2),LRABV,LRAN,LRDFN)) D
 . . S (LRI,LRIDT)=$O(^LR(LRXREF,LRH(2),LRABV,LRAN,LRDFN,0))
 . . I LRIDT S LRSD=$P($G(^LR(LRDFN,LRSS,LRIDT,0)),"^")
 ;
 I $D(LRXREF),$D(^LR(LRXREF,LRH(2),LRABV,LRAN)) D ^LRAPLG2 Q
 ;
 D CRE868
 I $D(LRMSG) S LRFND=1
 Q
 ;
 ;R !!,"Enter Accession #: ",X:DTIME I X=""!(X[U) S LRFND=1 Q
 ;I X'?1N.N!(X<1)!(X>99999) W $C(7),!!,"ENTER A WHOLE NUMBER FROM 1 TO 99999",! G OS
 ;I $D(^LRO(68,LRAA,1,LRAD,1,X,0)),$P(^(0),U) D ^LRUTELL G OS
 ;S LRAN=X
 ;S ^LRO(68,LRAA,1,LRAD,1,X,0)=LRDFN
 ;I $D(LRXREF),$D(^LR(LRXREF,LRH(2),LRABV,X)) D
 ;. D ^LRAPLG2 S LRFND=1
 ;L -^LRO(68,LRAA,1,LRAD,1,0)
 ;
 ;
OSDIR ; Called from DIR call in OS above
 ;
 ;ZEXCEPT: LRAA,LRAD,LRDFN,X
 ;
 ; Accession number doesn't exist in file #68 - quit, OK to use this number
 I $O(^LRO(68,LRAA,1,LRAD,1,+X,""))="" Q
 ;
 N LRX
 S LRX=$G(^LRO(68,LRAA,1,LRAD,1,+X,0))
 I LRX<1 K X Q
 ;
 ; Stub entry which matches on LRDFN
 I LRX=LRDFN Q
 ;
 I $P(LRX,U)'=LRDFN S X=+X D ^LRUTELL K X
 ;
 Q
 ;
 ;
ORDTST ; Prompt for ordered test(s); translate to NLT code for storage in ORUT
 ; Add NLT code to temp array LRXX (This code currently assumes one ordered test per accession)
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,LRNLT,LRWKCD,XX
 S (LRNLT,LRWKCD)="",II=0
 S DIR(0)="P^LAB(60,:AEMOQ",DIR("B")=$G(LRTST(0))
 S DIR("S")="I $P(^LAB(60,Y,0),""^"",4)=LRSS,""IBO""[$P(^LAB(60,Y,0),""^"",3),$P($G(^LAB(60,Y,64)),""^"")"
 D ^DIR
 I $D(DIRUT) S II=2 Q
 S LRWKCD=+$G(^LAB(60,+Y,64)),LRNLT=$P($G(^LAM(LRWKCD,0)),"^",2),II=1
 S XX=0
 F  S XX=$O(LRXX(XX)) Q:'XX  S $P(LRXX(XX),"^",2)=LRNLT_"^"_+Y
 ;
 Q
 ;
 ;
GETSTCS ;Get spec top and coll samp
 N LRI
 K LRXX
 S LRI=0,(LRXX,X)=""
 F  S LRI=$O(^LR(LRDFN,LRSS,LRIDT,.1,LRI)) Q:'LRI  D
 . S X=$G(^LR(LRDFN,LRSS,LRIDT,.1,LRI,0))
 . I $P(X,"^",6)'="" S LRXX($P(X,"^",6))=$P(X,"^",7)_"^"
 Q
 ;
 ;
CRE868 ; Create accession number in file 68
 N LRFDA,LRFDAIEN,LRIEN
 K LRMSG
 S LRIEN="+1,"_LRAD_","_LRAA_","
 S LRFDAIEN(1)=LRAN
 S LRFDA(1,68.02,LRIEN,.01)=LRDFN
 D UPDATE^DIE("S","LRFDA(1)","LRFDAIEN","LRMSG")
 I $D(LRMSG) S LRSD=LRAD D LRMSG("EN~LRAPGL1",.LRMSG) Q
 S X=LRAN
 Q
 ;
 ;
CRE863 ; Create entry in file #63
 ;
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="DO^:NOW:ET"
 S DIR("A")="Date/time Specimen taken",DIR("B")="NOW"
 D ^DIR K DIR
 I Y<1 D END Q
 S (LRY,LRSD)=Y,LRI=9999999-LRY
 ;
 ; Process and get unique LRI
 F  Q:'$D(^LR(LRDFN,LRSS,LRI,0))  D
 . S (LRSD,LRY)=$$FMADD^XLFDT(LRY,,,,1)
 . S LRI=9999999-LRY
 ;
 N LRFDA,LRIEN,LRFILE,LRFDAIEN
 K DIERR,LRMSG
 S LRACC=LRAC,LRNT=$$NOW^XLFDT()
 S LRFILE=$S(LRSS="SP":63.08,LRSS="CY":63.09,LRSS="EM":63.02,1:63.08)
 S LRFDAIEN(1)=LRI
 S LRIEN="+1,"_LRDFN_","
 S LRFDA(2,LRFILE,LRIEN,.01)=LRSD
 S LRFDA(2,LRFILE,LRIEN,.06)=LRACC
 ;
 D UPDATE^DIE("","LRFDA(2)","LRFDAIEN","LRMSG")
 L -^LR(LRDFN,LRSS)
 I $D(LRMSG) D LRMSG("F~LRAPLG1",.LRMSG) Q
 ;
 S (LRI,LRIDT)=LRFDAIEN(1)
 ;
 Q
 ;
 ;
SPMOVE ; Copy surgery information into lab package
 ;  - store surgery package reference to retrieve surgeon/attending.
 ;  - LRFLAG used to determine if data copied from Surgery packge and moved to Lab and generate notice.
 ;         if no data before and data after call to SROSPLG then add disclaimer.
 ;
 S X="SROSPLG" X ^%ZOSF("TEST")
 I '$T Q
 ;
 N I,LRFIELD,LRFLAG,LRJ,LRSREF,LRSRTN,LRWP
 S LRFLAG="",LRSRTN=$G(SRTN)
 I LRSRTN D
 . N LRDATA,LRDIE
 . S LRDATA(.01)=LRDFN_","_LRSS_","_LRI_",0"
 . S LRDATA(.02)=1
 . S LRDATA(1)=LRSRTN_";SRF("
 . D SETREF^LRUEPR(LRDFN,LRDATA(.01),.LRDATA,1)
 . F I=.2,.3,.4,.5 I '$O(^LR(LRDFN,LRSS,LRI,I,0)) S $P(LRFLAG,"^",I*10)=1
 ;
 D DISP^SROSPLG
 ;
 ; Create notation on where info came from if site wants reference.
 ;  also store referece as external package reference.
 S LRSREF=$$GET^XPAR("DIV^PKG","LR AP SURGERY REFERENCE",1,"Q")
 S LRFIELD(.013)="(#60) BRIEF CLIN HISTORY"
 S LRFIELD(.014)="(#32) PRINCIPAL PRE-OP DIAGNOSIS, (#.72) OTHER PREOP DIAGNOSIS"
 S LRFIELD(.015)="(#59) OPERATIVE FINDINGS"
 S LRFIELD(.016)="(#34) PRINCIPAL POST-OP DIAG, (#.74) OTHER POSTOP DIAGS"
 S LRWP(1)=" "
 F LRJ=.2,.3,.4,.5 I $P(LRFLAG,"^",LRJ*10),$O(^LR(LRDFN,LRSS,LRI,LRJ,0)) D
 . N LRDATA,LRDIE
 . S LRFIELD=$P("^.013^.014^.015^.016","^",LRJ*10)
 . S LRWP(2)="Information automatically documented from SURGERY package case #"_LRSRTN_" Field "_LRFIELD(LRFIELD)
 . I LRSREF=1 D WP^DIE(63.08,LRI_","_LRDFN_",",LRFIELD,"A","LRWP","LRDIE(LRFIELD)")
 . S LRDATA(.01)=LRDFN_","_LRSS_","_LRI_","_LRJ_",0"
 . S LRDATA(.02)=1
 . S LRDATA(1)=LRSRTN_";SRF(;"_LRWP(2)
 . D SETREF^LRUEPR(LRDFN,LRDATA(.01),.LRDATA,1)
 ;
 Q
 ;
 ;
LRMSG(LRRNAME,LRFMERR) ;
 ; Filing error notification
 ; Inputs
 ;  LRRNAME: Routine name  (TAG~RTN)
 ;  LRFMERR:<byref> FileMan error local array
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,LRDIE
 S LRRNAME=$TR($G(LRRNAME),"^","~")
 M LRDIE=LRFMERR
 D MAILALRT^LRWLST12(LRRNAME,.LRFMERR)
 S DIR(0)="EA"
 S DIR("A",1)="Filing error in "_LRRNAME_" for this accession/specimen"
 S DIR("A")="Press the return key to continue"
 D ^DIR
 Q
 ;
 ;
OUT ;
 ; Exit point
 Q
 ;
 ;
END ; from LRAUAW, LRAPLG2
 ; Lock Accession file
 D LOCK^DILF("^LRO(68,LRAA,1,LRAD,1,0)")
 I '$T D EN^DDIOL("Someone else is logging in specimens.  Please wait and try again.","","!!") Q
 ;
 N DIK,DA
 S DA=LRAN,DA(1)=LRAD,DA(2)=LRAA
 S DIK="^LRO(68,"_DA(2)_",1,"_DA(1)_",1,"
 D ^DIK
 ;
 L -^LRO(68,LRAA,1,LRAD,1,0)
 Q
 ;
 ;
FIX ; Entry point to delete an orphan AP entry in file #63
 ;
 N DA,DFN,DIC,DIK,DIR,DIROUT,DIRUT,DIQ,DR,DTOUT
 N LRAA,LRABV,LRAC,LRAD,LRAN,LRDFN,LRDPA,LRDPF,LRH,LRI,LRRC,LRSS,LRWHN,LRXR,LRXREF
 N AGE,PNM,SEX,X,Y
 ;
 D ^LRAP Q:'$D(Y)
 D XR^LRU
 ;
 I LRSS'?1(1"SP",1"CY",1"EM") W !,"This program only supports SP, CY and EM subscripts",! Q
 ;
 S LRH(2)=$E(LRAD,1,3),LRWHN=$E(LRAD,2,3)
 ;
 D EN1^LRUPS Q:LRAN=-1
 I $P(^LR(LRDFN,LRSS,LRI,0),"^",11)'="" W !,"Report has been released!",! Q
 I $D(^LR(LRDFN,LRSS,LRI,2005)) D  Q
 . W !,"Report has associated images in IMAGING package!"
 . W !,"Disposition these images before deleting this entry!",!
 ;
 K DR
 S DIC="^LR("_LRDFN_","""_LRSS_""",",DA(1)=LRDFN,DA=LRI,DIQ(0)="ACR"
 D EN^DIQ
 ;
 S DIR(0)="Y",DIR("A")="DELETE this entry",DIR("B")="NO"
 D ^DIR
 I Y<1 Q
 ;
 K DIR
 S DIR(0)="Y",DIR("A")="Are you sure",DIR("B")="NO"
 D ^DIR
 I Y<1 Q
 ;
 ; Lock record
 D LOCK^DILF("^LR(LRDFN,LRSS,LRI)")
 I '$T D  Q
 . D EN^DDIOL("Someone else is accessing this record.  Please wait and try again.","","!!")
 . D KVA^VADPT,V^LRU
 ;
 K DA,DIK
 S DA=LRI,DA(1)=LRDFN,DIK="^LR("_DA(1)_","""_LRSS_""","
 D ^DIK
 ;
 ; Cleanup some cross-references.
 I LRSS?1(1"SP",1"CY",1"EM") D
 . K ^LR(LRXREF,LRH(2),LRABV,LRAN,LRDFN,LRI)
 . I $G(LRRC)>1 K ^LR(LRXR,LRRC,LRDFN,LRI)
 ;
 I LRSS="AU" D
 . I $D(^LR(LRDFN,"AV")) K ^LR(LRDFN,"AV")
 . I $D(^LR(LRDFN,"AW")) K ^LR(LRDFN,"AW")
 . I $D(^LR(LRDFN,"AWI")) K ^LR(LRDFN,"AWI")
 . I $D(LRRC) K ^LR("AAUA",+$E(LRRC,1,3),LRABV,LRAN),^LR("AAU",+LRRC,LRDFN)
 ;
 ; Release lock
 L -^LR(LRDFN,LRSS,LRI)
 ;
 W !!,"Entry deleted",!
 D KVA^VADPT,V^LRU
 ;
 Q
