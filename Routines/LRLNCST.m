LRLNCST ;DALOI/FHS-LIST OF LOINC DEPRECIATED CODES ; 5/14/07 12:56pm
 ;;5.2;LAB SERVICE;**334**;Sep 27, 1994;Build 12
EN ;
 K LRIO,%ZIS,LRIO
 K DIR,LRANS,Y
 S DIR(0)="SO^L: List of Deprecated codes;M: Mapped Deprecated codes in use"
 S DIR("?")="Listing of LOINC deprecated codes"
 S DIR("?",1)="L = List of all LOINC deprecated codes"
 S DIR("?",2)="M = List of mapped LOINC deprecated codes"
 D ^DIR G END:$G(DIRUT)!($G(Y)="")
 S LRANS=Y
DEVICE ;
 S %ZIS="NQO",%ZIS("A")="Select Device: ",%ZIS("B")=""
 D ^%ZIS I $G(POP) D END Q
 I IO'=IO(0) D LOAD D END Q
 I LRANS="M" D LNK,END Q
 I LRANS="L" D LST,END
 Q
LOAD ;
 N ZTRTN,ZTIO,ZTDESC,ZTDTH
 S ZTRTN=$S(LRANS="L":"LST^LRLNCST",1:"LNK^LRLNCST")
 S ZTDTH=$H,ZTDESC="Print laboratory LOINC deprecated codes"
 S ZTIO=IO
 D ^%ZTLOAD
 W !,$S($G(ZTSK):"Tasked to "_ION_" "_ZTSK,1:"Not Tasked")
 Q
LST ;Print list of deprecated code
 I $D(ZTQUEUED) S ZTREQ="@"
 S LRHDR="List of deprecated codes"
 S (LRPG,LRLNC)=0 D HDR
 F  S LRLNC=$O(^LAB(95.3,"AD",1,LRLNC)) Q:LRLNC<1  D
 . K LRANS,ERR
 . D GETS^DIQ(95.3,LRLNC,".01;80","E","LRANS","ERR")
 . Q:$D(ERR)
 . W !,$G(LRANS(95.3,LRLNC_",",.01,"E")),"    ",$E($G(LRANS(95.3,LRLNC_",",80,"E")),1,60)
 . I $Y>(IOSL-4) D HDR
 D END Q
LNK ;Provide list of mapped deprecated LOINC codes
 I $D(ZTQUEUED) S ZTREQ="@"
 S (LRPG,LRIEN)=0,LRNM="",LRPLINE=0
 S LRHDR="List of mapped LOINC deprecated codes" D HDR
 S $P(LRPLN,"+",79)=""
 F  S LRNM=$O(^LAB(60,"B",LRNM)) Q:LRNM=""  D
 . S LRIEN=0 F  S LRIEN=$O(^LAB(60,"B",LRNM,LRIEN)) Q:LRIEN<1  D
 . . Q:$G(^LAB(60,"B",LRNM,LRIEN))
 . . S LR60NM="["_LRIEN_"] "_LRNM_" ",LRPLINE=0
 . . D LK64
 D END Q
LK64 ;Start looking for NLT linked fields.
 S LR64=$G(^LAB(60,LRIEN,64)),LRONLT=+LR64,LRRNLT=$P(LR64,U,2)
 I LRONLT D ORDER
 I LRRNLT D RESULT
 Q
RESULT ;Look up result NLT codes
 S LRFLD=1
 D CHK(LRRNLT,LRFLD) Q:$G(LRNOP)
 D LNC(LRRNLT,LRFLD)
 Q
ORDER ;Look up NLT order codes
 S LRFLD=2
 D CHK(LRONLT,LRFLD) Q:$G(LRNOP)
 D DEF(LRONLT,LRFLD)
 Q
DEF(LRNLT,FLD) ;Check LOINC default code
 S LRDEF=+$G(^LAM(LRNLT,9)) I LRDEF D
 . S LRNLTNM=$P(^LAM(LRNLT,0),U)_"  "_$P(^(0),U,2)
 . I $G(^LAB(95.3,LRDEF,4)) D
 . . I $Y>(IOSL-6) D HDR
 . . D:'$G(LRPLINE) PLN
 . . W !,"Test Name: ",LR60NM
 . . W !,$S(FLD=1:"RESULT NLT Code LOINC Default ",1:"ORDER NLT Code LOINC Default ")
 . . W !,"NLT Code: ",LRNLTNM
 . . W !,LRDEF_"-"_$P(^LAB(95.3,LRDEF,0),U,15)_"  "_$G(^LAB(95.3,LRDEF,80)),!
 Q
CHK(LRP,FLD) ;Check for valid node
 S LRNOP=0 I '$D(^LAM(LRP,0)) D  Q
 . D:'$G(LRPLINE) PLN
 . S LRTXT="is not valid"
 . S LRMSG="["_LRIEN_"] "_LRNM_$S(FLD=2:" Order NLT ",1:" Result NLT ")_LRTXT
 . D MSG(LRMSG) S LRNOP=1
 S LRNODE=^LAM(LRP,0),LRCC=$P($P(^(0),U,2),".")
 Q
MSG(MSG) ;Print
 W !,$$CJ^XLFSTR(MSG,IOM)
 Q
LNC(LRNLT,LRFLD) ;Check for LOINC in suffixed NLT codes
 S:'LRFLD LRFLD=1
 K LRNOP,LRCC,LRQ,LRQB,NODE
 S LRCC=$P(^LAM(LRNLT,0),U,2) Q:'LRCC!($G(LRNOP))  D
 . S LRQB=$P(LRCC,".")
 . S LRQ=""""_$P(LRCC,".")_".0""",NODE="^LAM(""E"","_LRQ_")"
 . S NODE=$Q(@NODE) I $P($QS(NODE,2),".")'=LRQB S LRNOP=1 Q
 . S LRINLT=$QS(NODE,3) D DEF(LRINLT,LRFLD)
 . D SPEC(LRINLT,3)
 Q
SPEC(LRNLT,LRFLD) ;Check specimen time aspect LOINC
 S LRSPEC=0 F  S LRSPEC=$O(^LAM(LRNLT,5,LRSPEC)) Q:LRSPEC<1  D
 . S LRSPECN=$P($G(^LAB(61,LRSPEC,0)),U)
 . S LRTASP=0 F  S LRTASP=$O(^LAM(LRNLT,5,LRSPEC,1,LRTASP)) Q:LRTASP<1  D
 . . S LRTASPN=$P($G(^LAB(64.061,LRTASP,0)),U)
 . . S LRLNC=+$G(^LAM(LRNLT,5,LRSPEC,1,LRTASP,1))
 . . I LRLNC,$G(^LAB(95.3,LRLNC,4)) D DISP
 Q
DISP ;
 I $Y>(IOSL-5) D HDR
 D:'$G(LRPLINE) PLN
 W !,"Test Name: ",LR60NM
 W !,"NLT Code: ",$P($G(^LAM(LRNLT,0)),U)," ",$P(^(0),U,2)
 W !,"  ("_LRSPEC_") "_LRSPECN
 W !,"LOINC Code: ",LRTASPN_"  ["_LRLNC_"-"_$P(^LAB(95.3,LRLNC,0),U,15)_"]"
 W !,"LOINC Name: ",$G(^LAB(95.3,LRLNC,80))
 Q
PLN ;
 I $Y>(IOSL-6) D HDR
 W !,LRPLN,!
 S LRPLINE=1
 Q
END ;
 W !
 W:$E($G(IOST),1,2)="P-" @IOF
 D ^%ZISC
 K ZTSK,ERR,DIRUT,LR64,LRMSG,LRNM,LRNODE,LRNOPE,LRSPEC,LRTXT
 K DIR,LR60NM,LRANS,LRCC,LRDEF,LRFLD,LRHDR,LRIEN,LRINLT,LRNLTNM,LRONLT,LRPG,LRPLINE
 K LRLNC,LRPLN,LRQ,LRQB,LRRNLT,LRSPECN,LRTASP,LRTASPN,NODE,POP,X,Y
 Q
HDR ;
 S LRPG=$G(LRPG)+1
 W @IOF,LRHDR,"     Page: ",LRPG,!
 Q
