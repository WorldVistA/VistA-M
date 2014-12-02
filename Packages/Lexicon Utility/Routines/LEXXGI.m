LEXXGI ;ISL/KER - Global Import (^LEXM) ;04/21/2014
 ;;2.0;LEXICON UTILITY;**4,25,26,27,28,29,46,49,50,41,59,73,80**;Sep 23, 1996;Build 1
 ;              
 ;              
 ;               
 ; Global Variables
 ;    ^LEXM
 ;               
 ; External References
 ;    HOME^%ZIS           ICR  10086
 ;    ^%ZTLOAD            ICR  10063
 ;    $$GET1^DIQ          ICR   2056
 ;    $$FMTE^XLFDT        ICR  10103
 ;    $$NOW^XLFDT         ICR  10103
 ;    BMES^XPDUTL         ICR  10141
 ;    MES^XPDUTL          ICR  10141
 ;               
 ; NEWed or KILLed by Lexicon Environment Check routine LEX20nn
 ;    LEXBUILD  Build
 ;    LEXFY     Fiscal Year
 ;    LEXIGHF   Global Host File
 ;    LEXLREV   Revision
 ;    LEXPTYPE  Patch Type
 ;    LEXQTR    Quarter
 ;    LEXREQP   Required Patches/Builds
 ;              
 ; NEWed or KILLed by KIDS during the Install of a patch/build
 ;    XPDNM     Intall Flag
 ;     
EN ; Main Entry Point for Installing LEXM in Post-Installs
 ;                
 ; Requires 
 ;                
 ;   LEXBUILD - the name of the patch/build being installed
 ;                
 ; Uses
 ;                
 ;   LEXMSG   - If this variable exist, then an install message
 ;              message will be set to G.LEXICON
 ;              
 ;   LEXSHORT - If this variable exist, the install message
 ;              will be an abbreviated message, without the 
 ;              file totals and checksums
 ;               
 ;              Abbreviated Install Message
 ;               
 ;                Date and Time Installed
 ;                Account where the Data was Installed
 ;                Who Installed the Data
 ;                The Name of the Build Installed
 ;                The Name of the Global Host File
 ;                Protocol Invoked
 ;                Date and time Protocol was Invoked
 ;                Install Start Date/Time
 ;                Install Complete Date/Time
 ;                Install Elapsed Time
 ;               
 ;              Long Install Message
 ;               
 ;                All of the elements above plus:
 ;               
 ;                   File Versions/Revisions
 ;                   File Checksums
 ;                   File Record Counts
 ;              
 ;   LEXNOPRO - If this variable exist, the protocol LEXICAL
 ;              SERVICES UPDATE will not be invoked.
 ;              
 ;   LEXPTYPE - Patch Type
 ;   LEXLREV  - Revision
 ;   LEXREQP  - Required Patches/Builds
 ;   LEXIGHF  - The patch Export Global Host Filename
 ;   LEXFY    - Fiscal Year
 ;   LEXQTR   - Quarter
 ;   LEXCRE   - Import Global Creation Date
 ;                
 D IMPORT D KALL^LEXXGI2
 Q
TASK ; Queue Lexicon Update with Taskman
 N Y,ZTRTN,ZTDESC,ZTIO,ZTDTH,ZTSK,ZTSAVE,ZTQUEUED,ZTREQ S:$D(LEXBUILD) ZTSAVE("LEXBUILD")="" S:$D(LEXMSG) ZTSAVE("LEXMSG")=""
 S:$D(LEXSHORT) ZTSAVE("LEXSHORT")="" S:$D(LEXPTYPE) ZTSAVE("LEXPTYPE")="" S:$D(LEXLREV) ZTSAVE("LEXLREV")="" S:$D(LEXREQP) ZTSAVE("LEXREQP")=""
 S:$D(LEXIGHF) ZTSAVE("LEXIGHF")="" S:$D(LEXFY) ZTSAVE("LEXFY")="" S:$D(LEXQTR) ZTSAVE("LEXQTR")="" S:$D(LEXCRE) ZTSAVE("LEXCRE")=""
 S ZTRTN="EN^LEXXGI",ZTDESC="Importing Updated Lexicon Data" S ZTIO="",ZTDTH=$H D ^%ZTLOAD,HOME^%ZIS
 Q
LEXM ; Force Install of LEXM w/o a Post-Install
 N LEXBUILD,LEXBLD,LEXB,LEXBO,LEXCHK,LEXSHORT,LEXTYPE,LEXMSG,LEXPOST,LEXNDS,LEXNOPRO,LEXVER
 S LEXNOPRO="",LEXBO=$G(^LEXM(0,"BUILD")),(LEXBUILD,LEXBLD,LEXB,^LEXM(0,"BUILD"))="LEX*2.0*NN"
 S:$L($G(LEXBO)) (LEXBUILD,LEXBLD,LEXB,^LEXM(0,"BUILD"))=LEXBO
 S LEXSHORT="",LEXTYPE=LEXB S:$L(LEXB) LEXTYPE=LEXTYPE_" (Forced)" S LEXMSG="",LEXPOST=""
 S LEXCHK=+($G(^LEXM(0,"CHECKSUM"))) W !,"   Running checksum routine on the ^LEXM import global, please wait"
 S LEXNDS=+($G(^LEXM(0,"NODES"))),LEXVER=+($$VC^LEXXGI2(LEXCHK,LEXNDS)) W !
 W:LEXVER>0 !,"     Checksum is ok",!
 I LEXVER=0 W !!,"   Import global ^LEXM is missing.  Please obtain a copy of ^LEXM before",!,"   continuing." Q
 I LEXVER<0 D  Q
 . I LEXVER'=-3 W !,"   Unable to verify checksum for import global ^LEXM (possibly corrupt)"
 . I LEXVER=-3 W !,"   Import global ^LEXM failed checksum"
 . W !!,"     Please KILL the existing import global ^LEXM from your system and"
 . W !,"     obtain a new copy of ^LEXM before continuing with the installation."
 D EN
 Q
IMPORT ; Import Data during a Patch Installation
 S:$D(ZTQUEUED) ZTREQ="@" S:$L($G(LEXPTYPE)) LEXPTYPE=$G(LEXPTYPE) S:$L($G(LEXLREV)) LEXLREV=$G(LEXLREV) S:$L($G(LEXREQP)) LEXREQP=$G(LEXREQP)
 S:$L($G(LEXBUILD)) LEXBUILD=$G(LEXBUILD) S:$L($G(LEXIGHF)) LEXIGHF=$G(LEXIGHF) S:$L($G(LEXFY)) LEXFY=$G(LEXFY)
 S:$L($G(LEXQTR)) LEXQTR=$G(LEXQTR) K LEXSCHG,LEXCHG
 N LEXB,LEXCD,LEXSTR,LEXLAST,LEXRES,LEXSTART,DG,DIC,DICR,DILOCKTM,DIW,XMDUN,XMZ,ZTSK
 S U="^",LEXSTR=$G(LEXPTYPE),LEXB=$G(^LEXM(0,"BUILD")),LEXSTART=$$NOW^XLFDT
 S:$L($G(LEXFY))&($L($G(LEXQTR)))&($L(LEXSTR)) LEXSTR=LEXSTR_" for "_$G(LEXFY)_" "_$G(LEXQTR)_" Quarter"
 S:$L(LEXB) LEXBLD=LEXB S:'$L(LEXBLD)&($L(LEXBUILD)) LEXBLD=LEXBUILD
 I '$L(LEXB)!(LEXB'=LEXBUILD) D
 . N X,LEXBLD I '$L(LEXB) D  Q
 . . S X=" Invalid export global, aborting data install" W:'$D(XPDNM) !!,X D:$D(XPDNM) BMES^XPDUTL(X) W:'$D(XPDNM) ! D:$D(XPDNM) MES^XPDUTL(" ")
 . I '$L(LEXBUILD) D  Q
 . . S X=" Undefined KIDS Build, aborting data install" W:'$D(XPDNM) !!,X D:$D(XPDNM) BMES^XPDUTL(X) W:'$D(XPDNM) ! D:$D(XPDNM) MES^XPDUTL(" ")
 I $L(LEXB)&(LEXB=LEXBUILD) D
 . N LEXFI,LEXID,LEXPROC S X="Installing Data for patch "_LEXB W:'$D(XPDNM) !!,X D:$D(XPDNM) BMES^XPDUTL(X) W:'$D(XPDNM) ! D:$D(XPDNM) MES^XPDUTL(" ")
 . K LEXSCHG S LEXCHG=0,LEXFI=0 F  S LEXFI=$O(^LEXM(LEXFI)) Q:+LEXFI'>0  D
 . . S LEXID=$S($P(LEXFI,".",1)=80:"ICD",$P(LEXFI,".",1)=81:"CPT",$P(LEXFI,".",1)=757:"LEX",1:"") S:$L(LEXID) LEXSCHG(LEXID)=0,LEXSCHG("LEX")=0
 . S:$D(LEXSCHG("CPT"))!($D(LEXSCHG("ICD"))) LEXSCHG("PRO")="",LEXCHG=1,LEXSCHG(0)=1
 . D LOAD K LEXPROC I '$D(LEXNOPRO) D NOTIFY^LEXXGI2
 . I +($G(DUZ))>0,$L($$GET1^DIQ(200,(+($G(DUZ))_","),.01)) D
 . . D HOME^%ZIS N DIFROM,LEXPRO,LEXPRON,LEXLAST S LEXPRON="LEXICAL SERVICES UPDATE",LEXPRO=$G(^LEXM(0,"PRO"))
 . . D:$D(LEXMSG) POST^LEXXFI
 Q
LOAD ; Load Data from ^LEXM into IC*/LEX Files
 Q:'$L($G(LEXB))  S:$D(ZTQUEUED) ZTREQ="@"
 N LEXBEG,LEXELP,LEXEND,LEXMSG,LEXOK,LEXFL,LEXTXT
 D:'$D(^LEXM) NF^LEXXGI2 Q:'$D(^LEXM)
 S LEXOK=0 S:$O(^LEXM(0))>0 LEXOK=1 D:'LEXOK IG^LEXXGI2 Q:'LEXOK
 S LEXBEG=$$HACK^LEXXGI2 D FILES^LEXXGI3 S LEXEND=$$HACK^LEXXGI2,LEXELP=$$ELAP^LEXXGI2(LEXBEG,LEXEND)
 S:LEXELP="" LEXELP="00:00:00"
 S LEXRES=$$RESULTS^LEXXII2
 S LEXTXT="  Data Update" S:$L(LEXRES) LEXTXT=LEXTXT_":   "_$G(LEXRES)
 D PB^LEXXGI2(LEXTXT)
 D PB^LEXXGI2(("     Started:    "_$TR($$FMTE^XLFDT(LEXBEG),"@"," ")))
 D TL^LEXXGI2(("     Finished:   "_$TR($$FMTE^XLFDT(LEXEND),"@"," ")))
 D TL^LEXXGI2(("     Elapsed:    "_LEXELP))
 Q
 ;                     
NOTIFY ; Notify by Protocol - LEXICAL SERVICES UPDATE
 I '$D(LEXNOPRO) D NOTIFY^LEXXGI2,KALL^LEXXGI2
 Q
AWRD ; Recalculate ASL Cross-Reference in 757.01
 D:$L($T(AWRD^LEXXGI4)) AWRD^LEXXGI4
 Q
ASL ; Recalculate ASL Cross-Reference in 757.01
 D:$L($T(ASL^LEXXGI4)) ASL^LEXXGI4
 Q
SUB ; Re-Index Subset file 757.21 (set logic only)
 D:$L($T(SUB^LEXXGI4)) SUB^LEXXGI4
 Q
SCHG ;   Save Change File Changes (for NOTIFY)
 N LEXFI,LEXID K LEXSCHG S LEXCHG=0
 N LEXFI S LEXFI=0 F  S LEXFI=$O(^LEXM(LEXFI)) Q:+LEXFI'>0  D
 . S LEXID=$S(LEXFI=80!(LEXFI=80.1):"ICD",LEXFI=81!(LEXFI=81.1)!(LEXFI=81.2)!(LEXFI=81.3):"CPT",$P(LEXFI,".",1)=757:"LEX",1:"UNK")
 . S LEXSCHG(LEXFI,0)=+($G(^LEXM(LEXFI,0))),LEXSCHG("B",LEXFI)="" S LEXSCHG("C",LEXID,LEXFI)=""
 S:$D(LEXSCHG("C","CPT"))!($D(LEXSCHG("C","ICD"))) LEXSCHG("D","PRO")=""
 S:$D(^LEXM(80))!($D(^LEXM(80.1)))!($D(^LEXM(81)))!($D(^LEXM(81.2)))!($D(^LEXM(81.3)))!($D(LEXSCHG("D","PRO"))) LEXCHG=1,LEXSCHG(0)=1
 Q
INV(X,Y) ; Protocol Invoked
 N LEXN,LEXP,LEXPD,LEXDT,LEXSAB S LEXSAB=$G(X) Q:"^LEX^ICD^CPT^"'[("^"_LEXSAB_"^")  S LEXP=$S(X="LEX":1,X="ICD":2,X="CPT":3,1:"") Q:+LEXP'>0
 S LEXPD=LEXP+(.5),LEXDT=$G(Y) S:$P(LEXDT,",",1)'?7N LEXDT=$$NOW^XLFDT S:'$D(^LEXT(757.2,1,200,0)) ^LEXT(757.2,1,200,0)="^757.201PA^.5^1"
 S ^LEXT(757.2,1,200,.5,0)=.5,^LEXT(757.2,1,200,.5,LEXP)=LEXSAB,^LEXT(757.2,1,200,.5,LEXPD)=LEXN
 Q
ZTQ ; Taskman Quit
 K ZTDESC,ZTDTH,ZTIO,ZTQUEUED,ZTREQ,ZTRTN,ZTSAVE,ZTSK
 Q
CHECKSUM ; Check ^LEXM Checksum
 D CS^LEXXGI2
 Q
