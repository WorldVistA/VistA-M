GMTSXAW3 ; SLC/KER - List Parameters/Allowable 2           ; 08/27/2002
 ;;2.7;Health Summary;**47,49,56**;Oct 20, 1995
 ;
 ; External References in GMTSXAW2
 ;   DBIA  2051  FIND^DIC
 ;   DBIA  2051  $$FIND1^DIC
 ;   DBIA  2051  LIST^DIC
 ;   DBIA  2056  $$GET1^DIQ
 ;   DBIA  2541  $$KSP^XUPARAM
 ;   DBIA  2324  $$CLNAME^USRLM
 ;   DBIA  2324  WHATIS^USRLM
 ;   DBIA 10112  $$PRIM^VASITE
 ;   DBIA 10006  ^DIC
 ;   DBIA  2054  $$CREF^DILF
 ;   DBIA 10076  ^XUSEC("GMTSMGR")
 ;   DBIA 10060  ^VA(200
 ;   DBIA 10114  ^%ZIS(1,
 ;   DBIA 10048  ^DIC(9.4,
 ;   DBIA 10090  ^DIC(4,
 ;   DBIA 10093  ^DIC(49,
 ;   DBIA  3005  ^OR(100.21
 ;   DBIA  1996  ^DIC(4.2,
 ;   DBIA  2324  ^USR(8930.3,
 ;   DBIA  2324  ^USR(8930,
 ;   DBIA  3407  ^XTV(8989.51,     Pending
 ;   DBIA  3408  ^XTV(8989.518,    Pending
 ;   DBIA 10103  $$DT^XLFDT
 ;            
 Q
SET(GMTSA,GMTSP,GMTSN,GMTSALW,GMTSI,GMTSF) ; Create Array Entry
 ;            
 ;   GMTSA    Identifier    SYS          USR           Req
 ;   GMTSP    Variable Ptr  97;DIC(4.2,  1118;VA(200,  Req
 ;   GMTSN    Name          System       User          Req
 ;  .GMTSALW  Array Root    GMTSALW(                   Req
 ;   GMTSI    Array IEN     GMTSALW(GMTSI)             Req
 ;   GMTSF    Value Flag    Include only values        Opt
 ;            
 Q:'$L(GMTSA)  Q:'$L(GMTSP)  Q:'$L(GMTSN)  I +($G(GMTSF))>0 D  Q
 . N GMTSD S GMTSD=";"_$P(GMTSP,";",2)
 . S GMTSALW("CHK",GMTSP,GMTSD)="" Q:+($G(GMTSF))>1
 . S GMTSALW("ENT",GMTSA,GMTSP)=""
 . S GMTSALW("VAL",GMTSP,GMTSA)=""
 N GMTS2 S GMTSI=+($G(GMTSI)) Q:GMTSI=0
 S GMTS2=$O(GMTSALW(GMTSI,GMTSA," "),-1)+1
 S GMTSALW(GMTSI,GMTSA,GMTS2)=GMTSP_"^"_GMTSN
 S GMTSALW(GMTSI,GMTSA,"VAL",GMTSP,GMTS2)=""
 S GMTSALW("ENT",GMTSA,GMTSP,GMTSI,GMTS2)=""
 S GMTSALW("VAL",GMTSP,GMTSI,GMTS2)=GMTSA
 Q
 ; Lookups
LST(X,Y) ;   Default Entities    8989.513  Lookup    .01, .02
 Q:+($G(X))'>0  N GMTSM,GMTSP S GMTSP=+($G(X)) Q:+($G(GMTSP))'>0
 D LIST^DIC(8989.513,(","_+GMTSP_","),".01;.02","I","*",,,,,.Y,.GMTSM)
 Q
OTL(X,GMTSOTL) ;   OR Team List        100.21    Lookup    .01
 N GMTSNM S GMTSNM=$G(X) Q:'$L($G(GMTSNM))  N GMTSM
 D FIND^DIC(100.21,,".01",,GMTSNM,"*","C",,,"GMTSOTL","GMTSM")
 Q
UCL(X,GMTS) ;   User Classes        8930.3    Lookup    .01, .02, .03, .04
 N USRT S X=+($G(X)) Q:X=0  D WHATIS^USRLM(X,"USRT")
 N GMTSNM,GMTSCT,GMTSI,GMTSIEN,GMTSC,GMTSCLS,GMTSEFF,GMTSEXP,GMTSCLN,GMTSU,GMTSUN
 S GMTSU=+($G(USRT(0))),GMTSUN=$P($G(USRT(0)),"^",2),GMTSC=$P($G(USRT(0)),"^",3)
 S GMTSC=0,GMTSI="" F  S GMTSI=$O(USRT(GMTSI)) Q:GMTSI=""  D
 . S GMTSIEN=$P($G(USRT(GMTSI)),"^",2) Q:+GMTSIEN=0  S GMTSCLS=$P($G(USRT(GMTSI)),"^",1),GMTSEFF=$P($G(USRT(GMTSI)),"^",4),GMTSEXP=$P($G(USRT(GMTSI)),"^",5),GMTSCLN=$P($G(USRT(GMTSI)),"^",3)
 . S GMTSC=GMTSC+1,GMTS("ID",GMTSC,.01)=GMTSUN,GMTS("ID",GMTSC,.01,"E")=GMTSU,GMTS("ID",GMTSC,.02)=GMTSCLS,GMTS("ID",GMTSC,.03)=GMTSEFF,GMTS("ID",GMTSC,.04)=GMTSEXP,GMTS("ID",GMTSC,"IEN")=GMTSIEN
 Q
HSD(X) ;   HS Definition
 S X=$$PDI("ORWRP HEALTH SUMMARY TYPE LIST") Q X
SI(X) ;   System Infor        4.2       Lookup
 Q $$FIND1^DIC(4.2,"","QX",$$KSP^XUPARAM("WHERE"))
ABR(X) ;   Abbreviation        8989.518  .02
 N GMTS S X=$G(X) Q:'$L(X) "XXX"
 S:X[";" X=$P(X,";",2) S:X'["^" X="^"_X
 S:$E(X,$L(X))'="("&(X["(")&(X'[",") X=X_"," S X=X_"0"
 S GMTS=$$CREF^DILF(X) I X'=GMTS,GMTS["0" D  Q X
 . S X=+($P($G(@GMTS),"^",2)) I +X'>0 S X="XXX" Q
 . S X=$$UP^GMTSXA($$GET1^DIQ(8989.518,(X_","),.02))
 . S:$L(X)'=3 X="XXX"
 Q "XXX"
ETI(X) ;   Entity IEN          8989.518  Lookup
 Q:$L($G(X))'=3 0 N GMTSM
 Q $$FIND1^DIC(8989.518,,"CO",$G(X),"C",,.GMTSM)
EFN(X) ;   Entity File #       8989.518  .001
 Q $$GET1^DIQ(8989.518,(+($G(X))_","),.001)
ENM(X) ;   Entity Name         8989.518  .01
 Q $$GET1^DIQ(8989.518,(+($G(X))_","),.01)
EAB(X) ;   Entity Abbrv        8989.518  .02
 Q $$GET1^DIQ(8989.518,(+($G(X))_","),.02)
EMC(X) ;   Entity Mix Case     8989.518  .03
 Q $$GET1^DIQ(8989.518,(+($G(X))_","),.03)
PDI(X) ;   Param Def IEN       8989.51    Lookup
 S X=$G(X) Q:'$L(X) "" N DIC,DTOUT,DUOUT,Y,GMTSM
 Q $$FIND1^DIC(8989.51,,"CO",$G(X),.GMTSM)
PDN(X) ;   Param Def Name      8989.51   .01
 Q $$GET1^DIQ(8989.51,(+($G(X))_","),.01)
UVP(X) ;   User Var Ptr        200
 N GMTS S GMTS=+($G(X)) Q:'$L($$UNM(GMTS)) ""
 S X=GMTS_";VA(200," Q X
USR(X) ;   Get User            200       Lookup
 N DIC,Y,DTOUT,DUOUT,GMTSN,GMTSP S GMTSN=$$UNM(+($G(DUZ))),GMTSP=$G(X),DIC="^VA(200,",DIC(0)="AEMQ",DIC("A")="Select User:  "
 S:$L(GMTSP) DIC("A")=GMTSP S DIC("S")="I $$ACTIVE^XUSER(+($G(Y)))>0" S:$L(GMTSN) DIC("B")=GMTSN D ^DIC S X=+Y
 Q X
UNM(X) ;   User Name           200       .01
 Q $$GET1^DIQ(200,(+($G(X))_","),.01)
MGR(X) ;   HS Manager
 Q $S(((+($G(DUZ))>0)&($D(^XUSEC("GMTSMGR",+($G(DUZ)))))):1,1:0)
PK(X) ;   Package             9.4       Lookup
 S X=$G(X) Q:'$L(X) "" N DIC,DTOUT,DUOUT,Y,GMTSM
 Q $$FIND1^DIC(9.4,,"CO",$G(X),"C",,.GMTSM)
DEV(X) ;   Device Name         3.5       .01
 Q $$GET1^DIQ(3.5,(+($G(X))_","),.01)
DIV(X) ;   Division Name       4         .01
 Q $$GET1^DIQ(4,(+($G(X))_","),.01)
UD(X) ;   User's Division     200.02    .01
 N GMTSINST,GMTSDIV,GMTSUSR,GMTSMD,GMTSKS,GMTSKSM,GMTSDS,GMTSDSM,GMTSDZ,GMTSDZM
 S:+($G(DT))'>0 DT=$$DT^XLFDT S U="^",GMTSUSR=+($G(X))
 S GMTSKS=$$KSP^XUPARAM("INST"),GMTSKSM=$$GET1^DIQ(4,(+GMTSKS_","),5,"I"),GMTSKSM=$S(GMTSKSM["Y":1,1:0)
 S GMTSDS=$O(^VA(200,GMTSUSR,2,"AX1",1,0)),GMTSDSM=$$GET1^DIQ(4,(+GMTSDS_","),5,"I"),GMTSDSM=$S(GMTSDSM["Y":1,1:0)
 S GMTSDZ=+($G(DUZ(2))),GMTSDZM=$$GET1^DIQ(4,(+GMTSDZ_","),5,"I"),GMTSDZM=$S(GMTSDZM["Y":1,1:0)
 S GMTSMD=GMTSDZM+GMTSDSM+GMTSKSM
 ;     Not a Multi-Divisional Institution
 I +GMTSMD'>0&(+GMTSKS>0) S X=+GMTSKS_";DIC(4," Q X
 ;     Login Division          
 I +GMTSDZ>0,$D(^DIC(4,+GMTSDZ)) S X=+GMTSDZ_";DIC(4," Q X
 ;     No Login Division
 I +GMTSDS'>0&(+GMTSDZ'>0)&(+GMTSKS>0) S X=+GMTSKS_";DIC(4," Q X
 ;     Default Division
 I +GMTSDS>0 S X=+GMTSDS_";DIC(4," Q X
 Q ""
DD(X) ;   Division (Default)  200.02    .01
 Q:+($G(X))'>0 ""  K ^TMP("DILIST",$J) D DS(+($G(X)),.Y)
 N GMTSDD,GMTSI S GMTSDD=""
 S GMTSI=0 F  S GMTSI=$O(^TMP("DILIST",$J,"ID",GMTSI)) Q:+GMTSI=0!($L(GMTSDD))  D
 . I $G(^TMP("DILIST",$J,"ID",GMTSI,1))=1 S GMTSDD=$G(^TMP("DILIST",$J,"ID",GMTSI,.01))
 K ^TMP("DILIST",$J) S X=$G(GMTSDD) Q X
DS(X,Y) ;   Divisions           200.02    Lookup    .01, 1
 Q:+($G(X))'>0  N GMTSM,GMTSP S GMTSP=+($G(X)) Q:+($G(GMTSP))'>0
 D LIST^DIC(200.02,(","_+GMTSP_","),".01;1","I","*",,,,,.Y,.GMTSM)
 Q
DE(X) ;   Division (Primary)  40.8      Lookup    .07
 N PRIM S PRIM=$$PRIM^VASITE S X=$$GET1^DIQ(40.8,(PRIM_","),.07,"I")
 Q X
SYS(X) ;   System Name         4.2       .01
 Q $$GET1^DIQ(4.2,(+($G(X))_","),.01)
PKG(X) ;   Package Name        9.4       .01
 Q $$GET1^DIQ(9.4,(+($G(X))_","),.01)
SRI(X) ;   Service (I)         200        29
 Q $$GET1^DIQ(200,(+($G(X))_","),29,"I")
SRV(X) ;   Service Name        49        .01
 Q $$GET1^DIQ(49,(+($G(X))_","),.01)
CLS(X) ;   User Class Name     8930      .01
 Q $$UP^GMTSXA($$CLNAME^USRLM(+($G(X))))
SYSV(X) ;   System Var Ptr
 N GMTSYS S GMTSYS=$$KSP^XUPARAM("WHERE") I $L(GMTSYS) D  Q:'$L(GMTSYS) ""
 . N DIC,DTOUT,DUOUT,X,Y S DIC="^DIC(4.2,",X=GMTSYS,DIC(0)="MXO"
 . D ^DIC S GMTSYS=+Y S:GMTSYS'>0 GMTSYS="" S GMTSYS=$S(+GMTSYS>0:(GMTSYS_";"_$P(DIC,"^",2)),1:"")
 S X=GMTSYS Q X
USRV(X) ;   User Var Ptr
 N GMTSU,GMTSUV S GMTSU=$G(X) I $L($$UNM(+($G(X)))) S X=+($G(X))_";VA(200," Q X
 N DIC,DTOUT,DUOUT,X,Y S DIC="^VA(200,",X=GMTSU,DIC(0)="MXO" D ^DIC S GMTSU=+Y,GMTSUV=""
 S:GMTSU'>0 GMTSUV="" S:GMTSU>0 GMTSUV=GMTSU_";"_$P(DIC,"^",2) S X=GMTSUV Q X
