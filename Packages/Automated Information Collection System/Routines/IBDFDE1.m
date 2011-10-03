IBDFDE1 ;ALB/AAS - AICS Data Entry, Final check; 24-FEB-96 [ 11/12/96  2:12 PM ]
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**38,36**;APR 24, 1997
 ; -- calls IBDFRPC4 to pass data to pce
 ;
% G ^IBDFDE
 ;
FINAL ; -- display everything selected and check okay
 ; -- input IBDSEL :
 ;             $p1 := package interface ien (for input)
 ;             $p2 := code to send (may be internal or external)
 ;             $p3 := text to send
 ;             $p4 := hdr to send (optional)
 ;             $p5 := clinic lexicon pointer (optional) 
 ;             $p6 := qualifier (i.e. primary or secondary)
 ;             $P7 :=
 ;             $p8 :=
 ;             $p9 :=
 ;             $p10 := external value of code (optional)
 ;
 N I,X,DIR,DIRUT,DUOUT,DTOUT,PARAM,IBDCNT,MODSAVE,XX
 K IBDREDIT
 I $G(IBDSEL(0))<1,$G(IBDCO("CO"))="",$G(IBDCO("SC"))="",$G(IBDCO("AO"))="",$G(IBDCO("IR"))="",$G(IBDCO("EC"))="",$G(IBDCO("MST"))="" W !!,"Nothing Selected!!" S IBDF("NOTHING")=1 Q
 ;
 S (IBDCNT,IBQUIT)=0
 W !!,"You have entered the following:"
 D WRITE^IBDFDE0(IBDF("SDOE"),.IBDCNT)
 S I=0 F  S I=$O(IBDSEL(I)) Q:I=""  D
 . S IBDCNT=IBDCNT+1
 . K MODSAVE
 . D LINE(IBDCNT,IBDSEL(I)) D
 .. I $D(IBDSEL(I,"MODIFIER")) D MODLIST(I)
 S DIR(0)="Y",DIR("B")="No",DIR("A")="Is this Okay" D ^DIR
 I $D(DIRUT) S IBQUIT=1 W !!,"No action Taken",! G FINALQ
 I Y<1 D DEL S:'IBQUIT IBDREDIT=1 G FINALQ
 I Y'=1 G FINALQ
 M IBDF=IBDSEL
 ;I $G(^DPT(DFN,"S",IBDF("APPT"),0))="" D FNDAPPT I 'IBDOK W !!,"No action Taken",! Q
 I $G(IBDF("SAVE")) M ^TMP("IBD-SAVED",$J)=IBDF ;don't save checkout data
 M IBDF=IBDCO
 W !!,"Sending Data to PCE..."
 D SEND^IBDFRPC4(.RESULT,.IBDF)
 W $S($G(RESULT(0)):" Successful",1:" Unsuccessful"),!!
 I $D(IBDSTRT) S IBDFIN=$H S IBDTIME=$$HDIFF^XLFDT(IBDFIN,IBDSTRT,2)
 S PARAM=$P($G(^IBD(357.09,1,0)),"^",7)
 I PARAM=3 D DISP
 I PARAM,$D(PXCA("ERROR"))!($D(PXCA("WARNING"))) D ERR
 I $G(IBDTIME) D
 .W !!,"Elapsed time for data entry: ",IBDTIME," seconds.",!!
 .S IBDF("SECONDS")=IBDTIME,IBDF("USER")=DUZ
 .D ETIME^IBDFBK1(.RESULT,.IBDF)
 I '$G(IBDREDIT),$P($G(^IBD(357.09,1,0)),"^",6) D MAKAPPT
FINALQ K SDFN,ZTSK,SECONDS,LEX,ORVP,SEL1,PXCAVSIT,PXCA,PXCASTAT
 Q
 ;
DEL ; -- delete selected entry
 N I,J,DIR,DIRUT,DUOUT,DTOUT,CNT,CNTD,IBD,IBD1,IBDEL
 S CNT=0
 W !
 S DIR(0)="Y",DIR("B")="No",DIR("A")="Do you want to delete an item"
 S DIR("?")="Enter 'Yes' if you want to delete an item or 'No' to just add more items."
 D ^DIR K DIR
 I $D(DIRUT) S IBQUIT=1 Q
 Q:Y<1
 S IBD=0 F  S IBD=$O(IBDSEL(IBD)) Q:IBD=""  S CNT=CNT+1,IBDEL(CNT)=IBD D LINE(CNT,IBDSEL(IBD)) D
 . I $D(IBDSEL(IBD,"MODIFIER")) D MODLIST(IBD)
 Q:CNT<1
 S DIR(0)="L^1:"_CNT D ^DIR K DIR
 I $D(DIRUT) W !,"Nothing Deleted" Q
 F IBD1=1:1 S IBDEL=$P(Y,",",IBD1) Q:IBDEL=""  D
 .W !,"Deleting "_IBDEL
 .S QLFR=$P(IBDSEL(IBDEL(IBDEL)),"^",6)
 .I QLFR'="" K IBDPI(+IBDSEL(IBDEL(IBDEL)),QLFR)
 .K IBDPI(+IBDSEL(IBDEL(IBDEL)),IBDEL(IBDEL))
 .K IBDSEL(IBDEL(IBDEL))
 .K IBDEL(IBDEL)
 .S CNTD=$G(CNTD)+1
 I $G(CNTD)=CNT S IBDSEL(0)=0
 W !
DELQ Q
 ;
LINE(CNT,IBD) ; -- write one line of text
 W !,?3,CNT,?7,$S($P(IBD,"^",8)'="":$P(IBD,"^",8),1:$E($P($P($G(^IBE(357.6,+IBD,0)),"^"),"INPUT ",2),1,22)),?31,$E($P(IBD,"^",3),1,30)
 W ?62,$S($P(IBD,"^",10)'="":$P(IBD,"^",10),$P($G(^IBE(357.6,+IBD,0)),"^")="GMP INPUT CLINIC COMMON PROBLEMS":$$LEX($P(IBD,"^",2)),1:$P(IBD,"^",2))
 W ?70,$E($S($P(IBD,"^",9)'="":$P(IBD,"^",9),1:$P(IBD,"^",6)),1,10)
 S SLCTN=$P(IBD,"^",12) I SLCTN'="" D
 . ;list modifiers
 . N CODE
 . Q:'$D(^IBE(357.3,SLCTN,3))
 . S CODE=$P($G(^IBE(357.3,SLCTN,0)),"^") Q:CODE=""
 . W !?11,"Associated Modifier(s):    "
 . S MOD=0 F  S MOD=$O(^IBE(357.3,SLCTN,3,MOD)) Q:'MOD  D
 .. S MODSAVE=$P($G(^IBE(357.3,SLCTN,3,MOD,0)),"^")
 .. S MODSAVE(MODSAVE)=""
 .. S XX=$P($$MODP^ICPTMOD(CODE,MODSAVE,"E"),"^",2)
 .. W !,?15,MODSAVE,?20,XX
 Q
 ;
MODLIST(I) ; -- list modifiers if in array
 ;
 W !?11,"Selected during Data Entry Modifier(s):    "
 N CODE
 S CODE=$P($G(IBDSEL(I)),"^",2)
 S MOD=0 F  S MOD=$O(IBDSEL(I,"MODIFIER",MOD)) Q:'MOD  D
 .; --quitting if duplicate entry
 . Q:$D(MODSAVE(IBDSEL(I,"MODIFIER",MOD)))
 . S MODSAVE=IBDSEL(I,"MODIFIER",MOD)
 . S XX=$P($$MODP^ICPTMOD(CODE,MODSAVE,"E"),"^",2)
 . W !,?15,MODSAVE,?20,XX
 Q
LEX(VAL) ; -- get output of lexicon entry
 I $D(^LEX)>1 S X="LEXU" X ^%ZOSF("TEST") I $T S VAL=$$ICDONE^LEXU(VAL) S:$L(VAL)<1 VAL=799.9 Q VAL  ;clinical lexicon next version to be in ^LEX
 S X="GMPTU" X ^%ZOSF("TEST") I $T S VAL=$$ICDONE^GMPTU(VAL) S:$L(VAL)<1 VAL=799.9 Q VAL
 Q 799.9
 ;
MAKAPPT ; -- ask make appointment stuff
 N %I,%T,I,J,X,Y,DIC,DA,DIR,DIRUT,DUOUT,IBDFN,RTCLEX,SDALLE,SDATD,SDAV,SDCLN,SDDECOD,SDEC,SDEMP,SDFN,SDHX,SDLOCK,SDMADE,SDNOT,SDOEL,SDPL,SDRE,SDRT,SDSOH,SDT,SDTTM,SDY,VSITON,VSIT,XQXFLG
 ;
 I $G(IBDF("NOAPPT")) G MAKAPQ
 S DIR("?")="Enter 'Yes' to make another appointment for this patient or 'No' if no appointment is to be made."
 S DIR(0)="Y",DIR("A")="Do you wish to make a follow-up appointment for "_$P(^DPT(IBDF("DFN"),0),"^")
 D ^DIR K DIR
 I $D(DUOUT)!($D(DTOUT)) S IBQUIT=1 G MAKAPQ
 I Y<1 G MAKAPQ
 ;
 S (SDFN,IBDFN,DFN)=$G(IBDF("DFN")) ;use same patient, don't ask patient, ask clinic
 ;S SDCLN=IBDF("CLINIC") ;use same clinic, don't ask clinic
 D ^SDM
 S DFN=IBDFN K SDFN
MAKAPQ Q
 ;
ERR ; -- if processing of errors is on do display
 ;    ask if want to re-edit
 N I,J,ERR,LCNT,DIR,DIRUT,DUOUT
 S LCNT=0
 D EW^IBDFBK2(.ERR,.PXCA,.LCNT)
 ;
 W !!!,"The following Error(s) occurred while validating data in PCE for: ",$P($G(^DPT(IBDF("DFN"),0)),"^")
 S I=0 F  S I=$O(ERR(I)) Q:'I  W !?4,$E(ERR(I),1,75)  I $L(ERR(I))>75 W !?10,$E(ERR(I),76,140)
 W !
 Q:$G(IBDF("SAVE"))
 S DIR(0)="Y",DIR("B")="Yes",DIR("A")="Do you want to Re-Edit"
 D ^DIR K DIR
 I Y=1 D
 .S IBDREDIT=1
 .K IBDF("CO"),IBDF("IR"),IBDF("SC"),IBDF("EC"),IBDF("AO"),IBDF("MST")
 .S I=0 F  S I=$O(IBDF(I)) Q:'I  K IBDF(I)
 I $D(DIRUT) S IBQUIT=1
 Q
 ;
DISP ; -- display data based on pxca array
 N I,LST,LCNT
 S LCNT=0
 D LSTDATA^IBDFBK3(.LST,.PXCA,.LCNT)
 W !!!,"The following data was sent to PCE for: ",$P($G(^DPT(IBDF("DFN"),0)),"^")
 W !,?4,"Clinic: ",$P($G(^SC(+$P($G(PXCA("ENCOUNTER")),"^",3),0)),"^")," at ",$$FMTE^XLFDT(+$G(PXCA("ENCOUNTER")))
 S I=0 F  S I=$O(LST(I)) Q:'I  W !?4,$E(LST(I),1,75) I $L(LST(I))>75 W !?10,$E(LST(I),76,140)
 W !
 Q
 ;
FNDAPPT ; -- if form is not associated with an appointment see any in clinic
 I $G(IBDSAEOK) S IBDOK=1 G FNDQ
 N IBDI,IBDJ,X,NODE,CNT,IOINHI,IOINORM,NEWAPPT,CLNAM,FORMLST,DIR,DIRUT,DUOUT,DTOUT
 S X="IOINHI;IOINORM" D ENDR^%ZISS
 S IBDI=$E(IBDF("APPT"),1,7),IBDJ=IBDI+.24,CNT=0
 F  S IBDI=$O(^DPT(DFN,"S",IBDI)) Q:'IBDI!(IBDI>IBDJ)  D  G:CNT<1 FNDQ
 .S NODE=$G(^DPT(DFN,"S",IBDI,0))
 .Q:+NODE'=IBDF("CLINIC")
 .S CNT=CNT+1,CLNAM=$E($P(^SC(IBDF("CLINIC"),0),"^"),1,20),NEWAPPT(CNT)=IBDI
 .I CNT=1 W $C(7),!!,IOINHI,"Warning:","  You are about to create a stand alone visit for: ",IOINORM,!,$E($P(^DPT(DFN,0),"^"),1,25),?27,CLNAM,?49,$$FMTE^XLFDT(IBDF("APPT"))
 .S FORMLST=$$FINDID^IBDF18C(DFN,IBDI,"",1)
 .W !,IOINHI,"Patient has appointment in ",CLNAM,?49,$$FMTE^XLFDT(IBDI)," ID: ",$TR($E(FORMLST,1,($L(FORMLST)-1)),"^",","),IOINORM
 ;
 W ! S IBDOK=$$ASKYN^IBDFDE0("Okay to Create Stand Alone Encounter",0) W !
 I $G(IBDOK)<0 S IBDOK=0
 G:IBDOK FNDQ
 ;
 ; -- ask if want to use appt. date time
 I CNT=1 D
 .S IBDOK=$$ASKYN^IBDFDE0("Okay to use "_$$FMTE^XLFDT(NEWAPPT(1))_" appointment date/time",1) W !
 .I $G(IBDOK)<0 S IBDOK=0
 .I IBDOK S IBDF("APPT")=NEWAPPT(1)
 ;
 I CNT>1 D
 .S DIR("A")=""
 .S DIR(0)=""
FNDQ Q
