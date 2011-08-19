PSOORNW1 ;ISC BHAM/SAB - continuation of finish of new order ;5/10/07 8:30am
 ;;7.0;OUTPATIENT PHARMACY;**23,46,78,117,131,133,172,148,222,268,206,251**;DEC 1997;Build 202
 ;Reference ^YSCL(603.01 supported by DBIA 2697
 ;Reference ^PS(55 supported by DBIA 2228
 ;Reference ^PSDRUG( supported by DBIA 221
 ;Reference to $$GETNDC^PSSNDCUT supported by IA 4707
 ;
2 I $G(ORD) D
 .S INST=0 F  S INST=$O(^PS(52.41,ORD,2,INST)) Q:'INST  S (MIG,INST(INST))=^PS(52.41,ORD,2,INST,0) D
 ..W !!,"Instructions: "
 ..F SG=1:1:$L(MIG," ") W:$X+$L($P(MIG," ",SG)_" ")>IOM !?14 W $P(MIG," ",SG)_" "
 .S:'$D(PSODRUG("OI")) PSODRUG("OI")=$P(OR0,"^",8)
 .K INST,TY,MIG,SG
 S (PSDC,PSI)=0 W !!,"The following Drug(s) are available for selection:"
 F PSI=0:0 S PSI=$O(^PSDRUG("ASP",PSODRUG("OI"),PSI)) Q:'PSI  I $S('$D(^PSDRUG(PSI,"I")):1,'^("I"):1,DT'>^("I"):1,1:0),$S($P($G(^PSDRUG(PSI,2)),"^",3)'["O":0,1:1) D
 .S PSDC=PSDC+1 W !,PSDC_". "_$P(^PSDRUG(PSI,0),"^")_$S($P(^(0),"^",9):"     (N/F)",1:"")
 .S PSDC(PSDC)=PSI
 I PSDC=0 D
 . N X,DRG
 . S DRG=+$P($G(^PS(52.41,+$G(ORD),0)),"^",9)
 . S X=$$GET1^DIQ(50,DRG,100)
 . I X'="",(DT>X) D
 . . W !!,"   This Dispense Drug is now Inactive. You may select a"
 . . W !,"    new Orderable Item, or you can enter a new Order with"
 . . W !,"    an Active Drug.",!
 . E  W !!,"No drugs available!",!
 . K DIR S DIR(0)="E",DIR("?")="Press Return to continue",DIR("A")="Press return to continue"
 . D ^DIR K DIR
 G:'PSDC ETX I $G(PSOBDRG),'$D(PSOBDR) M PSOBDR=PSODRUG
 I PSDC'=1 D
 .I $P($G(^PSDRUG(+$G(PSODRUG("IEN")),2)),"^")=$G(PSODRUG("OI")) Q
 .K PSODRUG("NAME"),PSODRUG("IEN")
 W ! D KV S DIR(0)="N^1:"_PSDC,DIR("A")="Select Drug by number" D ^DIR
 I $D(DIRUT) S OUT=1 G EX
 D KV K PSOY S PSOY=PSDC(Y),PSOY(0)=^PSDRUG(PSOY,0),PSOCSIG=0
 I $G(PSOBDR("IEN")),PSOBDR("IEN")'=+PSOY D:$G(ORD)  G:$D(DIRUT) EX
 .D KV S DIR(0)="Y",DIR("B")="YES",DIR("A",1)="You have changed the dispense drug from",DIR("A",2)=PSOBDR("NAME")_" to "_$P(^PSDRUG(+PSOY,0),"^")_".",DIR("A")="Do You want to Edit the SIG"
 .D ^DIR I $D(DIRUT) S OUT=1 Q
 .S:Y PSOCSIG=1
 .I 'Y D URX I $D(DIRUT) S OUT=1 Q
 D KV
CT1 I $P($G(^PSDRUG(PSOY,"CLOZ1")),"^")="PSOCLO1",'$O(^YSCL(603.01,"C",PSODFN,0)) D  Q
 .S VALMSG="Patient Not Registered in Clozapine Program",VALMBCK="Q" K PSOY,PSDC
 I $G(ORD) S ^TMP("PSORXPO",$J,ORD,0)=1
 S PSODRUG("IEN")=+PSOY,PSODRUG("VA CLASS")=$P(PSOY(0),"^",2),PSODRUG("NAME")=$P(PSOY(0),"^")
 S PSODRUG("NDF")=$S($G(^PSDRUG(+PSOY,"ND"))]"":+^("ND")_"A"_$P(^("ND"),"^",3),1:0)
 S PSODRUG("MAXDOSE")=$P(PSOY(0),"^",4),PSODRUG("DEA")=$P(PSOY(0),"^",3),PSODRUG("CLN")=$S($D(^PSDRUG(+PSOY,"ND")):+$P(^("ND"),"^",6),1:0)
 S PSODRUG("SIG")=$P(PSOY(0),"^",5),PSODRUG("NDC")=$$GETNDC^PSSNDCUT(+PSOY,$G(PSOSITE)),PSODRUG("STKLVL")=$G(^PSDRUG(+PSOY,660.1))
 S PSODRUG("DAW")=+$$GET1^DIQ(50,+PSOY,81)
 ;I $G(^PSDRUG(+PSOY,660))']"" D:'$G(PSOFIN)&('$G(PSOCOPY)) POST^PSODRG G ETX
 S PSOX1=$G(^PSDRUG(+PSOY,660)),PSODRUG("COST")=$P($G(PSOX1),"^",6),PSODRUG("UNIT")=$P($G(PSOX1),"^",8),PSODRUG("EXPIRATION DATE")=$P($G(PSOX1),"^",9)
 ;D:'$G(PSOFIN)&('$G(PSOCOPY)) POST^PSODRG
 I $G(PSORX("DFLG")) K PSODRUG N LST Q:$G(PSOAC)!($G(NEWEDT))  D DSPL^PSOORFI1 S VALMBCK="Q" Q
ETX D REF S VALMBCK="R" I 'PSDC S VALMSG="NO dispense drugs tied to this orderable item!" S PSOQFLG=1
TX D KV K PSDC,PSI,X,Y,PSOX1,PSOY
 Q
EX M PSODRUG=PSOBDR K PSOBDR,PSOBDRG S PSOQFLG=1,VALMBCK="R" D MP1^PSOOREDX
 D TX Q
URX D KV S DIR(0)="Y",DIR("A")="Are You Sure You Want to Update Rx",DIR("B")="Yes"
 D ^DIR S:$D(DIRUT)!('Y) DIRUT=1
 I Y S ^TMP("PSORXPO",$J,ORD,0)=1 ;screens 4 order checks
 Q
REF Q:'$D(PSODRUG("DEA"))!('$G(PSODRUG("IEN")))!('$G(^PS(55,PSODFN,"PS")))
 S PSONEW("CS")=0,PTRF=$S(+$G(^PS(55,PSODFN,"PS"))&($P(^PS(53,+$G(^PS(55,PSODFN,"PS")),0),"^",4)]""):$P(^PS(53,+$G(^PS(55,PSODFN,"PS")),0),"^",4),1:5)
 F DEA=1:1 Q:$E(PSODRUG("DEA"),DEA)=""  I $E(+PSODRUG("DEA"),DEA)>1,$E(+PSODRUG("DEA"),DEA)<6 S $P(PSONEW("CS"),"^")=1 S:$E(+PSODRUG("DEA"),DEA)=2 $P(PSONEW("CS"),"^",2)=1
 I $P($G(PSONEW("CS")),"^",2)=1 S PSONEW("# OF REFILLS")=0 Q
 I +PSONEW("CS") D
 .S PSOX=$S($P($G(OR0),"^",11)>5:5,1:+$P($G(OR0),"^",11))
 .S PSOX=$S(PSOX>PTRF:PTRF,1:PSOX)
 .S PSONEW("# OF REFILLS")=PSOX
 E  D
 .S PSOX=$S($P($G(OR0),"^",11)'>PTRF&($P($G(OR0),"^",11)'>11):11,1:PTRF)
 I '$D(CLOZPAT) I PSODRUG("DEA")["A"&(PSODRUG("DEA")'["B")!(PSODRUG("DEA")["F")!(PSODRUG("DEA")[1)!(PSODRUG("DEA")[2) S PSOX=0,PSONEW("# OF REFILLS")=0 K PSDY,PSDY1,PTRF Q
 I $D(CLOZPAT) S (PSOX,PSONEW("N# REF"),PSONEW("# OF REFILLS"))=$S(CLOZPAT=2&($G(PSONEW("# OF REFILLS"))>2):3,CLOZPAT&($G(PSONEW("# OF REFILLS"))>1):1,1:0),PSONEW("DAYS SUPPLY")=7,ORCHK=1 K PSDY,PSDY1,PTRF Q
 S PSONEW("# OF REFILLS")=$S($G(PSONEW("# OF REFILLS"))'="":$G(PSONEW("# OF REFILLS")),1:PSOX) K PSDY,PSDY1,PTRF
 Q
EDNEW K PSMAX,PSFMAX F DEA=1:1 Q:$E(PSODEA,DEA)=""  I $E(+PSODEA,DEA)>1,$E(+PSODEA,DEA)<6 S CS=1
 I CS D
 .S PSOX1=$S(PTRF>5:5,1:PTRF),PSOX=$S(PSOX1=5:5,1:PSOX1)
 .S PSOX=$S('PSOX:0,PSDAYS=90:1,1:PSOX),PSDY1=$S(PSDAYS<60:5,PSDAYS'<60&(PSDAYS'>89):2,PSDAYS=90:1,1:0) S MAX=$S(PSOX'>PSDY1:PSOX,1:PSDY1)
 E  D
 .S PSOX1=PTRF,PSOX=$S(PSOX1=11:11,1:PSOX1),PSOX=$S('PSOX:0,PSDAYS=90:3,1:PSOX)
 .S PSDY1=$S(PSDAYS<60:11,PSDAYS'<60&(PSDAYS'>89):5,PSDAYS=90:3,1:0) S MAX=$S(PSOX'>PSDY1:PSOX,1:PSDY1)
 I PSRF>MAX D
 .W $C(7),!!,PSRF_" refills are not correct for a "_PSDAYS_" day supply.",!,"Please enter correct # of refills for a "_PSDAYS_" day supply. Max refills allowed is "_MAX_".",!
 .S (PSMAX("MAX"),PSFMAX("MAX"))=MAX,(PSMAX("RF"),PSFMAX("RF"))=PSRF,(PSMAX("DAYS"),PSFMAX("DAYS"))=PSDAYS,(PSMAX,PSFMAX)=1
 K PSTMAX D EDSTAT
 Q
STATDAY K PSMAX,PSRMAX,PSFMAX,PSTMAX S PSDAYS=$P(^PSRX(DA,0),"^",8),PSRF=$P(^PSRX(DA,0),"^",9),PTST=$P(^PS(53,X,0),"^"),PTDY=$P(^(0),"^",3),PTRF=$P(^(0),"^",4)
EDSTAT I PSRF>PTRF W !,$C(7),PSRF_" refills are greater than "_PTRF_" allowed for "_$P(PTST,"^")_" Rx Patient Status.",! S PSTMAX=1,PSTMAX("PTRF")=PTRF,PSTMAX("PSRF")=PSRF,PSTMAX("PT")=$P(PTST,"^")
 Q
OERF S DIR(0)="N^0:"_PSOX,DIR("A")="# OF REFILLS"
 S DIR("B")=$S($G(POERR):PSONEW("# OF REFILLS"),$G(PSONEW("N# REF"))]"":PSONEW("N# REF"),$G(PSONEW("# OF REFILLS"))]"":PSONEW("# OF REFILLS"),$G(PSOX1)]""&(PSOX>PSOX1):PSOX1,1:PSOX)
 S DIR("?")="Enter a whole number.  The maximum is set by the Rx Patient Status because there is no Dispense Drug."
 D ^DIR G:$D(DIRUT) REFX
 S (PSONEW("N# REF"),PSONEW("# OF REFILLS"))=Y
REFX S:'$D(PSONEW("# OF REFILLS")) PSONEW("# OF REFILLS")=$S($G(PSONEW("N# REF"))]"":PSONEW("N# REF"),$G(PSOX1)]""&($G(PSOX)>PSOX1):PSOX1,1:PSOX)
 K X,Y,PSOX,PSOX1,PSDY,PSDY1,DEA
KV K DIR,DIRUT,DUOUT,DTOUT
 Q
