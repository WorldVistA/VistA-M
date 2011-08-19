ECMUTL ;ALB/ESD - Utilities for Multiple Dates/Mult Procs ;20 AUG 1997 13:56
 ;;2.0; EVENT CAPTURE ;**5,10,18,33,47,63**;8 May 96
 ;
ASKLOC() ; Get Location
 ;   Input:      None
 ;
 ;  Output:      ECL = Location (Division file pointer) ien
 ;              ECLN = Location name
 ;
 D ^ECL
 K ECOUT,LOC
 Q $S($D(ECL):1,1:0)
 ;
 ;
ASKPRDT(DSSU,ONE) ; Get Procedure Start Date/Time
 ;   Input:      ECD = DSS Unit ien
 ;               ONE = Ask procedure start date/time once
 ;
 ;  Output:   ^TMP("ECPRDT",$J) = procedure date/time array
 ;
 N DTOUT,DUOUT,ECCNT,ECDUP,ECERR
 S (ECCNT,ECDUP,ECERR)=0
 I '$G(DSSU) G ASKPRDTQ
 I $P($G(^ECD(DSSU,0)),"^",12)="N" S DIR("B")="NOW"
AGAIN N DIRUT,Y
 S DIR("A")="Select "_$S(+ECDUP:"Another Procedure Date and Time",1:"Procedure Date and Time")
 S DIR("?")="Enter both date AND time procedure was performed. Future dates are not allowed."
 S DIR(0)="DO^:NOW:EXR"
 D ^DIR K DIR
 I $D(DTOUT)!($D(DUOUT)) S ECERR=1
 I +Y S ECDUP=1,^TMP("ECPRDT",$J,Y)="" G @($S('$G(ONE):"AGAIN",1:"ASKPRDTQ"))
 ;
ASKPRDTQ Q $S(ECERR:0,(+$G(ONE)&(+Y)):1,('$G(ONE))&($D(^TMP("ECPRDT",$J))):1,1:0)
 ;
 ;
ASKCAT(ECL,ECD) ; Get category
 ;   Input:      ECL = Location ien
 ;               ECD = DSS Unit ien
 ;
 ;  Output:   ECATEG = Category ien (may be 0 if no categories)
 ;
 N CATS,DIRUT,ECATEG,ECMAX,X
 S ECATEG=0_"^No Categories",(ECMAX,X)=0
 I '$G(ECL)!('$G(ECD)) G ASKCATQ
 D CATS^ECHECK1
 I $O(ECC(0))']"" G ASKCATQ
 W !!,"Categories within "_$P($G(^ECD(+ECD,0)),"^")_":",!
 F  S X=$O(ECC(X)) Q:'X  W !?5,X_". ",$P(ECC(X),"^",2) S ECMAX=X
 W ! S DIR(0)="NA^1:"_ECMAX,DIR("A")="Select Number: "
 D ^DIR K DIR
 I 'Y!($D(DIRUT)) K ECATEG G ASKCATQ
 I +Y S ECATEG=$G(ECC(Y))
ASKCATQ K CNT,ECAT,ECC
 Q $G(ECATEG)
 ;
 ;
ASKPRO(ECL,ECD,ECC,NUM) ; Ask procedures
 ;   Input:      ECL = Location ien
 ;               ECD = DSS Unit ien
 ;               ECC = Category ien
 ;               NUM = Only ask procedure once
 ;
 ;  Output:  ^TMP("ECPROC",$J) = procedure array
 ;
 N CNT,ECERR,ECOUNT,ECOUT,ECPCNT,ECP,ECPNM,ECPREV,ECREAS,ECVOLU,ECEXIT
 N ECX,ECMOD,ECMODS,ECCPT,ECDT
 I '$D(ECL)!('$D(ECD)) G ASKPROQ
 S ECC=+$G(ECC)
 S ECOUNT=0
 S ECDT=$O(^TMP("ECPRDT",$J,0))
 D PROS^ECHECK1
 I '$O(^TMP("ECPRO",$J,0)) D  G ASKPROQ
 . W !!,"Within the ",ECLN," location there are no procedures defined",!
 . W "for the DSS Unit ",$P(ECDSSU,"^",2),".",!
 . S DIR(0)="E" D ^DIR K DIR,Y
 ;
SEL ;
 K ECPNAME,ECMOD
 S (ECPNM,ECPREV,ECREAS,ECX)="",(CNT,ECPCNT,ECP,ECVOLU,ECEXIT)=0
 S DIR("?")="^D LISTPR^ECMUTL"
 W ! S ECX=$$GETPRO^ECDSUTIL
 I +$G(ECX)=-1,('ECOUNT) D MSG^ECBEN2U,KILLV^ECDSUTIL G ASKPROQ
 I +$G(ECX)=-1,ECOUNT G ASKPROQ
 I +$G(ECX)=1 S ECPREV=$P(ECX,"^",2) D SRCHTM^ECDSUTIL(ECX)
 S ECPCNT=+$G(ECPCNT)
 I ECPCNT=-1!(ECPCNT=-2) D  G SEL
 . D @($S(ECPCNT=-1:"ERRMSG^ECDSUTIL",ECPCNT=-2:"ERRMSG2^ECDSUTIL"))
 . D KILLV^ECDSUTIL
 I ECPCNT>0 D  D CONTINU G:$G(ECERR) ASKPROQ
 . S CNT=ECPCNT
 . I ECPREV="L" W $P($G(^TMP("ECPRO",$J,+$G(^TMP("ECLKUP",$J,"LAST")))),"^",4)
 . I ECPREV="X"!(ECPREV="N") W "   "_$P($G(^TMP("ECPRO",$J,+CNT)),"^",4)
 I 'ECPCNT,$D(ECPNAME) D  G:CNT=-1!($G(ECERR)) ASKPROQ
 . S CNT=$$PRLST^ECDSUTIL
 . I CNT=-1 D MSG^ECBEN2U,KILLV^ECDSUTIL Q
 . I CNT>0 D
 .. W "   "_$S(ECPREV="S":$P($G(^TMP("ECPRO",$J,+CNT)),"^",3),1:$P($G(^TMP("ECPRO",$J,+CNT)),"^",4))
 .. D CONTINU
 ;
 I CNT>0,($G(ECP)'=""),(ECVOLU>0) D
 . S ECOUNT=$S(+$G(NUM)=-99:1,+$G(NUM)>0:NUM,1:(ECOUNT+1))
 . S ^TMP("ECPROC",$J,(ECOUNT))=ECP_"^"_ECPNM_"^"_+ECREAS_"^"_$S(+ECREAS:$P($G(^ECR($P($G(^ECL(+ECREAS,0)),"^"),0)),"^"),1:"Reason Not Defined")_"^"_ECVOLU
 . S ECCPT=$S(ECP["EC":$P($G(^EC(725,+ECP,0)),"^",5),1:+ECP)
 . I ECCPT'="",$O(ECMOD(ECCPT,""))'="" D
 . . M ^TMP("ECPROC",$J,ECOUNT,"MOD")=ECMOD(ECCPT)
 I '$G(NUM) G SEL
ASKPROQ K ^TMP("ECPRO",$J),^TMP("ECLKUP",$J),JJ,OK
 D KILLV^ECDSUTIL
 Q
 ;
CONTINU ;
 D SETP
 S ECCPT=$S(ECP["EC":$P($G(^EC(725,+ECP,0)),"^",5),1:+ECP)
 I ECCPT'="" D  I $G(ECERR) G CONTINUQ
 . S ECMODS=$G(ECMODS)
 . S ECMODF=$$ASKMOD^ECUTL(ECCPT,ECMODS,ECDT,.ECMOD,.ECERR)
 . K ECMODF,ECMODS
 S ECREAS=$$ASKREAS(ECL,ECD,ECC,ECP,.ECERR)
 G:$G(ECERR) CONTINUQ
 S ECVOLU=$$ASKVOL(ECL,ECD,ECC,ECP,.ECERR)
CONTINUQ Q
 ;
SETP ;
 S ^TMP("ECLKUP",$J,"LAST")=CNT
 S ECP=$P($G(^TMP("ECPRO",$J,CNT)),"^"),ECPNM=$P($G(^TMP("ECPRO",$J,CNT)),"^",4)
 Q
 ;
LISTPR ;- List available procedures
 ;   Input:        None
 ;
 ;  Output:        None (display on screen)
 ;
 N DIR,DIRUT,ECI,Y
 S ECI=0
 D PROCHDR
 F   S ECI=$O(^TMP("ECPRO",$J,ECI)) Q:'ECI!(ECEXIT)  D
 . I ($Y+5>IOSL) S DIR(0)="E" D ^DIR S:'Y!$D(DIRUT) ECEXIT=1 I +Y D PROCHDR
 . Q:ECEXIT
 . W !,ECI_".",?5,$E($P(^TMP("ECPRO",$J,ECI),"^",4),1,30),?38,$E($P(^(ECI),"^",3),1,30),?72,$P(^(ECI),"^",5)
 Q:ECEXIT
 W !!?5,"Select by number, CPT or national code, procedure name, or synonym.",!?5,"Synonym must be preceded by the & character  (example:  &TESTSYN).",!
 W ?2,"** Modifier(s) can be appended to a CPT code (ex: CPT code-mod1,mod2,mod3) **",!
LISTPRQ Q
 ;
PROCHDR ;- Procedure display header
 ;
 W @IOF
 W !,"Available Procedures within "_$P(ECDSSU,"^",2)_": ",!
 W ?72,"National",!,?5,"Procedure Name",?40,"Synonym",?72,"Number",!
 Q
 ;
 ;
ASKREAS(ECL,ECD,ECC,ECP,ECOUT) ;-Ask procedure reason
 ;   Input:      ECL = Location ien
 ;               ECD = DSS Unit ien
 ;               ECC = Category ien
 ;               ECP = Procedure ien
 ;
 ;  Output:  ECPRPTR = Link file ien (from file #720.5)
 ;             ECOUT = 0 if successful
 ;                     1 if uparrowed or timed out
 ;                     (passed by reference)
 ;
 N DTOUT,DUOUT,ECPRPTR,ECSCR
 S (ECOUT,ECPRPTR,ECSCR)=0
 S ECC=+$G(ECC)
 I '$D(ECL)!('$D(ECD))!('$D(ECP)) G ASKREASQ
 I $G(ECP)]"" S ECSCR=+$O(^ECJ("AP",+ECL,+ECD,+ECC,ECP,0))
 I ECSCR>0,(+$P($G(^ECJ(ECSCR,"PRO")),"^",5)),(+$O(^ECL("AD",ECSCR,0))) D
 . S DIC="^ECL(",DIC(0)="QEAM"
 . S DIC("A")="Procedure Reason: ",DIC("S")="I $P(^(0),U,2)=ECSCR"
 . D ^DIC K DIC
 . I +Y>0 S ECPRPTR=+Y
 . I $D(DTOUT)!($D(DUOUT)) S ECOUT=1
ASKREASQ Q +ECPRPTR
 ;
 ;
ASKVOL(ECL,ECD,ECC,ECP,ECOUT) ;- Ask procedure volume
 ;   Input:    ECL = Location ien
 ;             ECD = DSS Unit ien
 ;             ECC = Category ien
 ;             ECP = Procedure ien
 ;
 ;  Output:  ECVOL = volume
 ;           ECOUT = 0 if successful
 ;                   1 if uparrowed or timed out
 ;                   (passed by reference)
 ;
 N DIR,DIRUT,DTOUT,DUOUT,ECSCR,ECVOL
 S (ECOUT,ECSCR,ECVOL)=0
 S ECC=+$G(ECC)
 I '$D(ECL)!('$D(ECD))!('$D(ECP)) G ASKVOLQ
 I $G(ECP)]"" S ECSCR=+$O(^ECJ("AP",+ECL,+ECD,+ECC,ECP,0))
 S DIR(0)="N^^K:(X<1)!(X>99) X",DIR("A")="Volume"
 S DIR("?")="Type a Number between 1 and 99, 0 Decimal Digits"
 S DIR("B")=$S($P($G(^ECJ(ECSCR,"PRO")),"^",3):$P($G(^ECJ(ECSCR,"PRO")),"^",3),1:1)
 D ^DIR
 I +Y S ECVOL=Y
 I $D(DIRUT) S ECOUT=1
ASKVOLQ Q +ECVOL
 ;
 ;
PROV(ECDT,ECPROVS) ;get providers - new providers function
 ;- This is the same function as PROV^ECPRVUTL
 ;- Select provider(s) with active person class
 ;- No updating of file #721 record is done here
 ;
 ;   input
 ;   ECDT    = date/time of procedure (required)
 ;   ECPROVS = local array, passed by reference (required)
 ;    
 ;   output
 ;   ECU(1)  = provider #1 (mandatory) ien^provider #1 name^person class
 ;   ECU(2)  = provider #2 (optional) ien^provider #2 name^person class
 ;   ECU(3)  = provider #3 (optional) ien^provider #3 name^person class
 ;
 ;   returns
 ;       0 ==> prov selection successful; at least prov #1 selected
 ;       1 ==> selection unsuccessful or user timed-out
 ;       2 ==> selection unsuccessful or user entered "^"
 ;
 N ECU,ECU2,ECU3,ECDA
 D GET^ECPRVUTL("",ECDT,.ECU,.ECU2,.ECU3,.ECOUT)
 S ECPROVS(1)=ECU,ECPROVS(2)=ECU2,ECPROVS(3)=ECU3
 Q ECOUT
 ;
ONEUNIT(ECDSSU) ;- Create ECDSSU containing DSS Unit
 ;  Checks for validity and access to Unit
 ;
 ;   input
 ;   ECDSSU = passed by reference
 ;
 ;   output
 ;   ECDDSU = ien in file #724^name of DSS unit  OR
 ;            undefined
 ;
 ;   returns ECOUT = 0  if unit selection sucessful  OR
 ;                   1  if user times out; selection unsuccessful
 ;                   2  if user up-arrows out; selection unsuccessful
 ;   Note: if selection is unsuccessful, variable ECDSSU will be undefined.
 ;
 N Y,DIRUT,DUOUT,ECKEY,ECOUT
 S ECKEY=$S($D(^XUSEC("ECALLU",DUZ)):1,1:0)
 F  S ECOUT=0 D  Q:$G(ECOUT)  Q:$G(ECDSSU)
 .K DUOUT,DTOUT,DIRUT,Y
 .W !
 .S DIC=724,DIC("A")="Select DSS Unit: ",DIC(0)="QEAMZ"
 .S DIC("S")="I ECKEY!($D(^VA(200,DUZ,""EC"",+Y)))"
 .D ^DIC K DIC
 .S:$D(DTOUT) ECOUT=1 S:$D(DUOUT) ECOUT=2
 .Q:$G(ECOUT)
 .I +Y>0 D  Q
 .. I $$VALID(+Y) S ECDSSU=Y
 .. I '$$VALID(+Y) D
 ...S Y=-1
 ...W !!,?5,"This DSS Unit is either inactive or cannot be used"
 ...W !,?5,"in Event Capture.  Please select a different DSS Unit.",!
 .I +Y<0 D  Q
 ..W !!,?5,"A response is required...try again."
 ..W !,?5,"You must enter an ""^"" to exit."
 .K DIR,DUOUT,DTOUT,DIRUT
 .W ! S DIR(0)="YA",DIR("A")="Is this correct? ",DIR("B")="YES"
 .S DIR("?")="Answer YES to accept the unit, NO to start over."
 .D ^DIR K DIR
 .I $D(DIRUT) S:$D(DTOUT) ECOUT=1 S:$D(DUOUT) ECOUT=2 K ECDSSU Q
 .I '$G(Y) K ECDSSU
 Q ECOUT
 ;
VALID(IEN) ;- Check DSS Unit for use by Event Capture
 ;
 N NODE,NO,YES,VAL
 S NODE=$G(^ECD(IEN,0))
 ;piece 6 is 'inactive'; piece 8 is 'use with EC'
 S NO=$P(NODE,"^",6),YES=$P(NODE,"^",8)
 ;start out with 'valid'
 S VAL=1 D
 .;if 'inactive', then 'not valid'
 .I NO S VAL=0 Q
 .;if not 'use with EC', then 'not valid'
 .I 'YES S VAL=0
 Q VAL
