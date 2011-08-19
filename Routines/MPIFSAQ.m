MPIFSAQ ;SF/CMC-STAND ALONE QUERY ; 10/7/08 12:41pm
 ;;1.0; MASTER PATIENT INDEX VISTA ;**1,3,8,13,17,21,23,28,35,52**;30 Apr 99;Build 7
 ;
VTQ(MPIVAR) ;
 D VTQ^MPIFSA2(.MPIVAR)
 Q
 ;
INTACTV ;Interactive standalone query - Display Only patient doesn't have to be in Patient file
 S FLG=0 K DIR,X,Y S DIR(0)="Y",DIR("B")="YES",DIR("A")="Is Patient in the PATIENT file " D ^DIR
 G:(Y'=1)&(Y'=0) END
 I Y=1 S FLG=1 D PAT(.MPIVAR)
 I Y'=1,'$D(MPIVAR) D NOPAT(.MPIVAR)
 I '$D(MPIVAR("DFN"))&(FLG'=0) G END
 I +$G(MPIVAR("DOB"))'>0 W !,"DOB is missing - Required field" G END
 D VTQ^MPIFSA2(.MPIVAR) K DIR,X,Y,MPIVAR,FLG
 Q
END K DIR,X,Y,MPIVAR,DIRUT,DTOUT,DUOUT
 Q
CLEAN(NAM) ;NAM is the name to be cleaned up, Returned from this function is a clean name
 N YY,I
 I NAM?.E1L.E F I=1:1:$L(NAM) S:$E(NAM,I)?1L NAM=$E(NAM,0,I-1)_$C($A(NAM,I)-32)_$E(NAM,I+1,$L(NAM)) ; only uppercase
 F YY=", ","  " F  Q:'$F(NAM,YY)  S NAM=$E(NAM,1,($F(NAM,YY)-2))_$E(NAM,$F(NAM,YY),$L(NAM)) ; no space after comma and no double spaces
 F  Q:$E(NAM,$L(NAM))'=" "  S NAM=$E(NAM,1,$L(NAM)-1) ; no space at the end
 Q NAM
PAT(MPIVAR) ;patient is in local Patient file
PATA N DIC,X,Y,DIQ,DR,DA,MPIFAR,DFN,DTOUT,DUOUT
 S DIC="^DPT(",DIC(0)="AEQZM",DIC("A")="Patient Name: " D ^DIC
 G:$D(DTOUT)!($D(DUOUT))!(Y="^")!(X="") END
 I +Y=-1 W !,"Patient not found.  Try Again" G PATA
 S (DFN,MPIVAR("DFN"))=+Y,MPIVAR("NM")=$P(Y(0),"^"),DIQ="MPIFAR",DR=".09;.03;.02;.131;.111;.112;.113;.114",DIC="^DPT(",DA=+Y,DIQ(0)="I" D EN^DIQ1 K DA
 S MPIVAR("DOB")=$G(MPIFAR(2,DFN,.03,"I")),MPIVAR("SSN")=$G(MPIFAR(2,DFN,.09,"I")) I MPIVAR("SSN")["P" S MPIVAR("SSN")=""
 S MPIVAR("SEX")=$G(MPIFAR(2,DFN,.02,"I")),MPIVAR("PHONE")=$G(MPIFAR(2,DFN,.131,"I"))
 S MPIVAR("ADDR1")=$G(MPIFAR(2,DFN,.111,"I")),MPIVAR("ADDR2")=$G(MPIFAR(2,DFN,.112,"I"))
 S MPIVAR("ADDR3")=$G(MPIFAR(2,DFN,.113,"I")),MPIVAR("CITY")=$G(MPIFAR(2,DFN,.114,"I"))
 Q
NOPAT(MPIVAR) ; patient is not in the local Patient file
 W !!,"When the patient is NOT in the local PATIENT file, you will be asked",!,"to provide as much information as possible to facilitate the query."  ;**52
 W !,"You will be asked for patient name, date of birth, Social Security Number,",!,"gender, phone number, and address.  Minimally, you must enter patient name",!,"and date of birth.",!!  ;**52
NAME N DTOUT,DUOUT,DIR,X,Y,%
 S DIR(0)="FU^::",DIR("A")="PATIENT NAME (last,first middle)"
 S DIR("?")="Enter name in the following format: last<comma>first<space>middle" D ^DIR  ;**52
 G:$D(DTOUT)!($D(DUOUT))!(Y="^") END
 I (Y="")!($L(Y)>45)!($L(Y)<3) W !,"Name must be 3 to 30 characters, entered as: last<comma>first<space>middle" G NAME  ;**52
 I (Y?1P.E)!(Y'?1A.ANP)!(Y'[",")!(Y[":")!(Y[";") W !,"Name must be 3 to 30 characters, entered as: last<comma>first<space>middle" G NAME  ;**52
 I Y'?.UNP F %=1:1:$L(Y) I $E(Y,%)?1L S Y=$E(Y,0,%-1)_$C($A(Y,%)-32)_$E(Y,%+1,999)
 S MPIVAR("NM")=$$CLEAN(Y)
DOB K DIR,X,Y S DIR(0)="DU^::AEP",DIR("A")="Date of Birth" D ^DIR
 G:$D(DTOUT)!($D(DUOUT)) END
 S MPIVAR("DOB")=Y
SSN ; ssn is optional
 K DIR,X,Y S DIR(0)="FUO^9:9:",DIR("A")="9 Digit SSN (No Dashes)" D ^DIR
 G:$D(DTOUT)!($D(DUOUT)) END
 I Y'="",Y'?9N W !,"SSN should be 9 numbers" G SSN
 S MPIVAR("SSN")=Y
GENDER ; Gender is optional
 K DIR,X,Y S DIR(0)="SAO^M:MALE;F:FEMALE",DIR("A")="Gender: " D ^DIR
 G:$D(DTOUT)!($D(DUOUT)) END
 S MPIVAR("SEX")=Y
PHONE ; Phone is optional
 K DIR,X,Y S DIR(0)="FAO^4:20",DIR("A")="Phone Number: " D ^DIR
 G:$D(DTOUT)!($D(DUOUT)) END
 S MPIVAR("PHONE")=Y
ADDR1 ;Address line 1 is optional
 K DIR,X,Y S DIR(0)="FAO^3:35",DIR("A")="Address Line 1: " D ^DIR
 G:$D(DTOUT)!($D(DUOUT)) END
 S MPIVAR("ADDR1")=Y
ADDR2 ;Address line 2 is optional
 K DIR,X,Y S DIR(0)="FAO^3:30",DIR("A")="Address Line 2: " D ^DIR
 G:$D(DTOUT)!($D(DUOUT)) END
 S MPIVAR("ADDR2")=Y
ADDR3 ;Address line 3 is optional
 K DIR,X,Y S DIR(0)="FAO^3:30",DIR("A")="Address Line 3: " D ^DIR
 G:$D(DTOUT)!($D(DUOUT)) END
 S MPIVAR("ADDR3")=Y
CITY ;City is optional
 K DIR,X,Y S DIR(0)="FAO^2:15",DIR("A")="City: " D ^DIR
 G:$D(DTOUT)!($D(DUOUT)) END
 S MPIVAR("CITY")=Y
 Q
SEG(SEGMENT,PIECE,CODE) ;Return segment from MPIDC array and kill node
 N MPINODE,MPIDATA,MPIDONE,MPIC,HOLD K MPIDONE
 I '$D(MPIC) S MPIC=$E(HL("ECH"))
 S MPINODE=0
 F  S MPINODE=$O(MPIDC(MPINODE)) Q:MPINODE=""!($D(MPIDONE))  D
 .S MPIDATA=MPIDC(MPINODE)
 .I ($P(MPIDATA,HL("FS"),1)=SEGMENT)&($P($P(MPIDATA,HL("FS"),PIECE),MPIC,1)=CODE) S MPIDONE=1 S HOLD(MPINODE)="" D
 ..I SEGMENT="RDT" F  S MPINODE=$O(MPIDC(MPINODE)) Q:MPINODE=""  Q:MPIDC(+MPINODE)=""  S MPIDATA=MPIDATA_MPIDC(MPINODE),HOLD(MPINODE)=""
 I $D(MPIDONE) S MPINODE=0 F  S MPINODE=$O(HOLD(MPINODE)) Q:MPINODE=""  K MPIDC(MPINODE)
 Q:$D(MPIDONE) $G(MPIDATA)
 Q ""
