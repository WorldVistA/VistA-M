EEOEINP ;HISC/JWR - DETERMINES THE PROPER SEQUENCE OF DATES ENTERED FOR CERTAIN FIELDS ;09/09/93  13:35
 ;;2.0;EEO Complaint Tracking;;Apr 27, 1995
 ;Compares sequenciality of dates being entered in edit sessions and provides help for improper order.
 S (EEOO2,EEOO3)="",EO=EEOS D DD
 I $D(EEOSEQ) F EEE=1:1 S EO=$P(EEOSEQ,U,EEE) Q:EO=""  D DD,SEQ
 I $D(EEOREV) F EEE=1:1 S EO=$P(EEOREV,U,EEE) Q:EO=""  D DD,REV
 G PRINT
DD ;Gathers data dictionary information for fields being evaluated
 S EEOR=$G(^DD(785,EO,0)) Q:$P(EEOR,U,2)["C"  S EEOO(EO)=$P(EEOR,U,4),EEOOE(EO)=$P(EEOR,U)
DG ;Gathers information from this edit session for the field being tested.
 K EOO S EEOA=$P(EEOO(EO),";"),EEOB=$P(EEOO(EO),";",2) S:$D(DG(EEOO(EO))) EOO=DG(EEOO(EO))
GLOBE ;Gathers data from the EEOA node of the record being evaluated
 S EEOT=$G(^EEO(785,D0,EEOA))
 S EOO=$G(EOO) S:EOO="" $P(EEOO(EO),U,4)="D"
 Q:$P(EEOT,U,EEOB)=""&(EOO)=""
 S Y=$P(EEOT,U,EEOB) D DD^%DT S $P(EEOO(EO),U,2)=Y I EOO'="" S Y=EOO D DD^%DT S $P(EEOO(EO),U,3)=Y
 Q
SEQ ;Test the date entered against the other dates it is dependent on
 S EOO1=$P($G(EEOT),U,EEOB)
 Q:EOO'>0&(EOO1'>0)
 I EO>EEOS,X>EOO,EOO'="" D BAD
 I EO>EEOS&(X>EOO1)&(EOO="") D BAD
 I EO<EEOS,X<EOO,EOO'="" D BAD
 I EO<EEOS&(X<EOO1)&(EOO="") D BAD
 Q
BAD ;Makes a string of fields not matching the correct date sequence.
 Q:EOO'>0&(EOO1'>0)
 ;Q:$P(EEOO(EO),U,4)["D"
 S:EO>EEOS EEOO2=EEOO2_"^"_EO S:EO<EEOS EEOO3=EEOO3_"^"_EO
 Q
PRINT ;Prints a list of dates that must occur either before or after the date entered in the edit session
 G:$G(EEOO2)=""&($G(EEOO3)="") QUIT W "??",!
 I $G(EEOO2)'="" W !,"*** The following fields must occur after the date entered above: *** ",! S E3=1,EO1=EEOO2 D LIST
 G:$G(EEOO3)="" QUIT W !!,"*** The following fields must be prior to the date entered above: ***",! S E3=1,EO1=EEOO3
LIST ;List the dates that are out of sequence
 F EEOX=2:1:4 D
 .S EEOO1=$P(EO1,U,EEOX) Q:EEOO1=""  W !,"   * ",EEOOE(EEOO1)
 .W:$P($G(EEOO(EEOO1)),U,3)'="" $J($P(EEOO(EEOO1),U,3),50-$L(EEOOE(EEOO1)))
 .W:$P($G(EEOO(EEOO1)),U,3)="" $J($P(EEOO(EEOO1),U,2),50-$L(EEOOE(EEOO1)))
QUIT ;kills variables, quits
 I $G(EEOO2)'=""!($G(EEOO3)'="") S Y=X D DD^%DT W !!,EEOOE(EEOS)_": ("_Y_")"
 K EEOT,EEOO1,EEOS,EEOT,EEOR,EEOX,EEOOE,EEOO,EEOB,EEOA,EEOSCR,EOO,EEOO2,EEOO3,EEO("B"),EEOREV,EEOSEQ,EO
 Q
REV ;Comes here if Chronological sequence is different than field #'s order.
 S EOO1=$P($G(EEOT),U,EEOB)
 Q:EOO'>0&(EOO1'>0)
 I EO>EEOS,X<EOO,EOO'="" D OOPS
 I EO>EEOS&(X<EOO1)&(EOO="") D OOPS
 I EO<EEOS,X>EOO,EOO'="" D OOPS
 I EO<EEOS&(X>EOO1)&(EOO="") D OOPS
 Q
OOPS ;Checks for deleted records
 Q:$P(EEOO(EO),U,4)["D"
 S:EO<EEOS EEOO2=EEOO2_"^"_EO S:EO>EEOS EEOO3=EEOO3_"^"_EO Q
