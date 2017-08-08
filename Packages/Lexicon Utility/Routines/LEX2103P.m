LEX2103P ;ISL/KER - LEX*2.0*103 Pre/Post Install ;05/23/2017
 ;;2.0;LEXICON UTILITY;**103**;Sep 23, 1996;Build 2
 ;               
 ; Global Variables
 ;    ^LEX(757.3)         SACC 1.3
 ;               
 ; External References
 ;    HOME^%ZIS           ICR  10086
 ;    ^%ZTLOAD            ICR  10063
 ;    DESC^%ZTLOAD        ICR  10063
 ;    STAT^%ZTLOAD        ICR  10063
 ;    ENALL^DIK           ICR  10013
 ;    IX1^DIK             ICR  10013
 ;    ^DIK                ICR  10013
 ;    EN^DIU2             ICR  10014
 ;    MES^XPDUTL          ICR  10141
 ;               
 Q
PRE ; Pre-Install
 N DIU
 S DIU="^LEX(757.01,",DIU(0)="" D EN^DIU2
 S DIU="^LEX(757.02,",DIU(0)="" D EN^DIU2
 S DIU="^LEX(757.33,",DIU(0)="" D EN^DIU2
 Q
POST ; Post-Install
 D CON,REPAIR,MSG
 Q
CON ; Data Conversions/Edits
 D SUB,FIL,RIX,REM
 Q
SUB ; ICD-10-CM Preferred Terms Subset
 N DA,DIK S DA=50,DIK="^LEXT(757.2," I $D(^LEXT(757.2,DA)) D ^DIK
 S ^LEXT(757.2,50,0)="ICD-10-CM Preferred Terms"
 S ^LEXT(757.2,50,1)="^LEX(757.01,"
 S ^LEXT(757.2,50,2)="XTLK^LEXHLP"
 S ^LEXT(757.2,50,3)="XTLK^LEXPRNT"
 S ^LEXT(757.2,50,4)="10D"
 S ^LEXT(757.2,50,5)="XDX^WRD^0^757.01^^0^1"
 S ^LEXT(757.2,50,6)="I $L($$PRF^LEXU(+Y,+($G(LEXVDT)),30))"
 S ^LEXT(757.2,50,7)="10D"
 S ^LEXT(757.2,50,100,0)="^^5^5^3160425^"
 S ^LEXT(757.2,50,100,1,0)="This subset is artificially created through the use of a filter"
 S ^LEXT(757.2,50,100,2,0)="which will filters out all entries not linked to an active ICD-10"
 S ^LEXT(757.2,50,100,3,0)="diagnostic code and not flagged as the preferred term for the"
 S ^LEXT(757.2,50,100,4,0)="ICD-10 diagnostic code.  Synonyms, Lexical Variants and Orphans"
 S ^LEXT(757.2,50,100,5,0)="will not be returned."
 S DA=50,DIK="^LEXT(757.2," D IX1^DIK
 Q
FIL ; ICD-10-CM Preferred Terms Filter
 S DA=16,DIK="^LEX(757.3," I $D(^LEXT(757.3,DA)) D ^DIK
 S ^LEX(757.3,16,0)="ICD-10-CM Preferred Terms^A"
 S ^LEX(757.3,16,1)="I $L($$PRF^LEXU(+Y,+($G(LEXVDT)),30))"
 S ^LEX(757.3,16,2,0)="^757.305^4^4^3160425^^"
 S ^LEX(757.3,16,2,1,0)="This screen filters out all entries not linked"
 S ^LEX(757.3,16,2,2,0)="to an active ICD-10 diagnostic code and not"
 S ^LEX(757.3,16,2,3,0)="flagged as the preferred term for the ICD-10"
 S ^LEX(757.3,16,2,4,0)="diagnostic code."
 S ^LEX(757.3,16,3,0)="^757.36^3^3"
 S ^LEX(757.3,16,3,1,0)="ICD"
 S ^LEX(757.3,16,3,2,0)="10D"
 S ^LEX(757.3,16,3,3,0)="WRD"
 S DA=16,DIK="^LEX(757.3," D IX1^DIK
 Q
 ;
REM ; Remove Fields in files 757.01 and 757.02
 N ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTQUEUED,ZTREQ,ZTPRI
 S ZTRTN="REMT^LEX2103P" S ZTDESC="Remove unused fields from EXPRESSIONS file #757.01"
 S ZTIO="",ZTDTH=$H,ZTPRI=1 D ^%ZTLOAD D HOME^%ZIS
 Q
REMT ;   Remove Fields in files 757.01 and 757.02 - Tasked
 ;
 ;     EXPRESSION file 757.01 - Approved Mon 10/24/2016 11:11 AM
 ;       Remove Data if it exist
 N DA,DIK S DA=0 F  S DA=$O(^LEX(757.01,DA)) Q:+DA'>0  D
 . N ND1,CTL S (CTL,ND1)=$G(^LEX(757.01,DA,1))
 . ;             5    2;1     DISTINGUISHING TEXT
 . K ^LEX(757.01,DA,2)
 . ;            10    1;6     MODIFIER FLAG
 . S $P(ND1,"^",6)=""
 . ;            11    1;7     MODIFIER TYPE
 . S $P(ND1,"^",7)=""
 . ;            12    1;8     DESCENDANT FLAG
 . S $P(ND1,"^",8)=""
 . ;            13    1;9     PARENT
 . S $P(ND1,"^",9)=""
 . ;            14    1;10    ORDER
 . S $P(ND1,"^",10)=""
 . S ND1=$$TM(ND1,"^") S:ND1'=CTL ^LEX(757.01,DA,1)=ND1
 ;       Remove field if it exist
 S DIK="^DD(757.01,",DA=5,DA(1)=757.01 D:$D(@(DIK_DA_",0)")) ^DIK
 S DIK="^DD(757.01,",DA=10,DA(1)=757.01 D:$D(@(DIK_DA_",0)")) ^DIK
 S DIK="^DD(757.01,",DA=11,DA(1)=757.01 D:$D(@(DIK_DA_",0)")) ^DIK
 S DIK="^DD(757.01,",DA=12,DA(1)=757.01 D:$D(@(DIK_DA_",0)")) ^DIK
 S DIK="^DD(757.01,",DA=13,DA(1)=757.01 D:$D(@(DIK_DA_",0)")) ^DIK
 S DIK="^DD(757.01,",DA=14,DA(1)=757.01 D:$D(@(DIK_DA_",0)")) ^DIK
 ; 
 ;     CODES file 757.02 - Pending
 ;       Remove Data if it exist
 N DA,DIK S DA=0 F  S DA=$O(^LEX(757.02,DA)) Q:+DA'>0  D
 . N ND0,CTL S (CTL,ND0)=$G(^LEX(757.02,DA,0))
 . ;             5    0;6     DEACTIVATION FLAG
 . S $P(ND0,"^",6)=""
 . S ND0=$$TM(ND0,"^") S:ND0'=CTL ^LEX(757.02,DA,0)=ND0
 K ^LEX(757.02,"ACODE"),^LEX(757.02,"ADC"),^LEX(757.02,"ADCODE")
 ;       Remove field if it exist
 S DIK="^DD(757.02,",DA=5,DA(1)=757.02 D:$D(@(DIK_DA_",0)")) ^DIK
 Q
 ;
MSG ; Install Message
 N LEXBUILD,LEXFILES,LEXEFFDT
 S LEXBUILD="LEX*2.0*103"
 S LEXFILES="757.01^757.02^757.07^757.071^757.2^757.3^757.33"
 S LEXEFFDT="3170101"
 D MSG^LEXXGI(LEXBUILD,LEXFILES,LEXEFFDT)
 Q
 ;
REPAIR ; Repair Special Lookup Indexes - task
 N Y,ZTRTN,ZTDESC,ZTIO,ZTDTH,ZTSAVE,ZTQUEUED,ZTREQ,LEXTN,LEXT,LEXMAIL
 S LEXMAIL="",ZTRTN="ALL^LEXXGP1",(LEXTN,ZTDESC)="LEX*2.0*103 post install repair",ZTSAVE("LEXMAIL")=""
 I $D(LEXHOME) S LEXHOME=1,ZTSAVE("LEXHOME")=""
 S ZTIO="",ZTDTH=$H D ^%ZTLOAD,HOME^%ZIS I +($G(ZTSK))>0 D
 . N LEXT S LEXT="  "_$G(LEXTN)_" tasked (#"_+($G(ZTSK))_")"
 . D MES^XPDUTL(LEXT)
 K X,Y,ZTRTN,ZTDESC,ZTIO,ZTDTH,ZTSAVE,ZTQUEUED,ZTREQ,LEXTN,LEXT,LEXMAIL,LEXHOME
 Q
RIX ;   Repair non-Special Lookup Indexes
 N ZTREQ,ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE D RAH,RB,ADT
 Q
RAH ;     Repair "AH" Index 
 N ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTQUEUED,ZTREQ,ZTPRI
 S ZTRTN="RAH^LEXRXC" S ZTDESC="Set AH index in EXPRESSIONS file #757.01"
 S ZTIO="",ZTDTH=$H,ZTPRI=1 D ^%ZTLOAD D HOME^%ZIS
 Q
RB ;     Repair "B" Index
 N ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTQUEUED,ZTREQ,ZTPRI
 S ZTRTN="RB^LEXRXC" S ZTDESC="Set B index in EXPRESSIONS file #757.01"
 S ZTIO="",ZTDTH=$H,ZTPRI=1 D ^%ZTLOAD D HOME^%ZIS
 Q
ADT ;     Repair "ADTERM" Index
 N ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTQUEUED,ZTREQ,ZTPRI
 S ZTRTN="RADTERM^LEXRXC" S ZTDESC="Set ADTERM index in EXPRESSIONS file #757.01"
 S ZTIO="",ZTDTH=$H,ZTPRI=1 D ^%ZTLOAD D HOME^%ZIS
 Q
RUN(X) ;     Task running
 N LEXD,LEXLIST,ZTSK,LEXOK S LEXD="LEX*2.0*103 post install repair"
 D DESC^%ZTLOAD(LEXD,"LEXLIST")
 S LEXOK="0^LEX*2.0*103 post install repair task is not running"
 S ZTSK=" " F  S ZTSK=$O(LEXLIST(ZTSK),-1) Q:+ZTSK'>0  D
 . D STAT^%ZTLOAD I +($G(ZTSK(0)))'>0 K LEXLIST(ZTSK) Q
 . I "^1^2^"'[("^"_+($G(ZTSK(1)))_"^") K LEXLIST(ZTSK) Q
 . Q:+LEXOK>0  S:+($G(ZTSK(1)))=1 LEXOK="1^"_LEXD_" - task pending (task #"_+($G(ZTSK))_")^"_+($G(ZTSK))
 . S:+($G(ZTSK(1)))=2 LEXOK="1^"_LEXD_" - task running (task #"_+($G(ZTSK))_")^"_+($G(ZTSK))
 S X=LEXOK
 Q X
 ;
 ; Miscellaneous
TM(X,Y) ;   Trim Character Y - Default " "
 S X=$G(X) Q:X="" X  S Y=$G(Y) S:'$L(Y) Y=" "
 F  Q:$E(X,1)'=Y  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=Y  S X=$E(X,1,($L(X)-1))
 Q X
