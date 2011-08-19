QAMC24 ;ISC7/LJA,DAD-CONDITION: PATIENTS WITH 2+ RXS FOR SAME DRUG CLASS ;9/3/93  13:22
 ;;1.0;Clinical Monitoring System;;09/13/1993
EN1 ; *** CONDITION CODE
 S QAMDCL=$S($D(^QA(743,QAMD0,"COND",QAMD1,"P1"))#2:+^("P1"),1:0)
 ;
 F QAMID=QAMTODAY-.0000001:0 S QAMID=$O(^PSRX("AD",QAMID)) Q:(QAMID'>0)!(QAMID>(QAMTODAY+.9999999))!(QAMID\1'?7N)  D
 . F QAMRXN=0:0 S QAMRXN=$O(^PSRX("AD",+QAMID,QAMRXN)) Q:QAMRXN'>0  D
 .. S QAMRX0=$G(^PSRX(QAMRXN,0)),QAMDFN=+$P(QAMRX0,U,2)
 .. Q:('$P(QAMRX0,U,6))!('QAMDFN)  ; No drug / patient
 .. Q:"^11^12^13^"[("^"_$P(QAMRX0,"^",15)_"^")  ; Status
 .. S QA=+$P($G(^PSDRUG(+$P(QAMRX0,U,6),"ND")),U,6) ; Class
 .. Q:$O(^QA(743.5,QAMDCL,"GRP","AB",QA,0))'>0
 .. S QAMEXP=QAMTODAY
 .. F  S QAMEXP=$O(^PS(55,QAMDFN,"P","A",QAMEXP)) Q:QAMEXP'>0  F QAMRXD0=0:0 S QAMRXD0=$O(^PS(55,QAMDFN,"P","A",QAMEXP,QAMRXD0)) Q:QAMRXD0'>0  D
 ... Q:QAMRXN=QAMRXD0
 ... S QAMRX0=$G(^PSRX(QAMRXD0,0))
 ... Q:'$P(QAMRX0,U,6)  ; No drug found
 ... Q:"^11^12^13^"[("^"_$P(QAMRX0,"^",15)_"^")  ; Status
 ... S QA=+$P($G(^PSDRUG(+$P(QAMRX0,U,6),"ND")),U,6) ; Class
 ... Q:$O(^QA(743.5,QAMDCL,"GRP","AB",QA,0))'>0
 ... S ^UTILITY($J,"QAM CONDITION",QAMD1,QAMDFN)=""
 ... S ^UTILITY($J,"QAM CONDITION",QAMD1,QAMDFN,QAMID)=QAMRXN
 ... Q
 .. Q
 . Q
 K QAMDCL,QAMEXP,QAMRX0,QAMRXD0,QAMRXN
 Q
 ;
EN2 ; *** PARAMETER CODE
 K DIC,DIR,DIRUT
 S DIC=743.5,DIC(0)="EMNQZ",DIC("A")="DRUG CLASS GROUP: "
 S DIC("B")=$P($G(^QA(743,QAMD0,"COND",QAMD1,"P1")),"^",2)
 K:DIC("B")="" DIC("B")
 S DIC("S")="I $P(^QA(743.5,+Y,0),""^"",2)=50.605"
 S DIC("W")="W ""   "",$P(^(0),""^"",2)"
 S DIR("?",1)="Enter the DRUG CLASS group you wish to monitor.  All 'TODAY-1'"
 S DIR("?")="fills will be scanned for duplicate fills for this group."
 S QAMPARAM="P1" D EN2^QAMUTL1 I $D(DIRUT) S Y=-1 G Y
 S:Y]"" ^QA(743,QAMD0,"COND",QAMD1,"P1")=+Y_"^"_Y(0,0)
 ;
EXIT K Y
 K QAMPARAM
Y Q
