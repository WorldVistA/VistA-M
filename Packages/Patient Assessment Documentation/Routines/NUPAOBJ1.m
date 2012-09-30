NUPAOBJ1  ;PHOENIX/KLD; 6/23/09; PULL PATIENT INFO; 1/11/12  8:38 AM
 ;;1.0;NUPA;;;Build 105
 ;;Object code taken from my NUPAOB package
 ;;IAs used: 2400, 4245, 4246, 4791, 5047
ST Q
 ;
BMI(N) ;Body Mass Index  |BMI;N;nY|
 N NUPA,X S NUPA("T")=$P(N,U,2),NUPA("N")=+$G(N,1)
 S:NUPA("T")="" NUPA("T")="2Y"
 D AGO S NUPA("ED")=ED,NUPA("AGO")=9999999-NUPA("ED"),NUPA("C")=0,X="BODY MASS INDEX" D K,NONE(X)
 S NUPA("BMI")="",NUPA("C")=0,X=$$VIS(NUPA("N"),NUPA("T"),8)
 F NUPA("I")=0:0 S NUPA("I")=$O(^TMP("NUPA",$J,NUPA("I"))) Q:'NUPA("I")  D
 .S NUPA("C")=NUPA("C")+1,NUPA("HT",NUPA("I"))=^TMP("NUPA",$J,NUPA("I"),0)
 S:NUPA("C")=1&('$P($G(NUPA("HT",1)),U,2)) NUPA("C")=0 ;Invalid height
 I 'NUPA("C") D SET(X_" - NO HEIGHTS FOUND") G BMIQ
 S NUPA("C")=0,X=$$VIS(NUPA("N"),NUPA("T"),9)
 F NUPA("I")=0:0 S NUPA("I")=$O(^TMP("NUPA",$J,NUPA("I"))) Q:'NUPA("I")  D
 .S NUPA("C")=NUPA("C")+1,NUPA("WT",NUPA("I"))=^TMP("NUPA",$J,NUPA("I"),0)
 S:NUPA("C")=1&('$P($G(NUPA("WT",1)),U,2)) NUPA("C")=0 ;Invalid weight
 I 'NUPA("C") D SET(X_" - NO WEIGHTS FOUND") G BMIQ
 S NUPA("C")=0 ;D:NUPA("N")>1 SET(X) 
 F NUPA("I")=1:1:NUPA("N") D:$D(NUPA("WT",NUPA("I")))
 .S NUPA("HT")=0 S:$P($G(NUPA("HT",NUPA("I"))),U,2) NUPA("HT")=$P(NUPA("HT",NUPA("I")),U,2) S NUPA("WT")=$P(NUPA("WT",NUPA("I")),U,2)
 .S NUPA("H")=NUPA("HT")*.0254,NUPA("H")=NUPA("H")*NUPA("H"),NUPA("WT")=NUPA("WT")/2.2,X=$$D(+NUPA("WT",NUPA("I"))) ;_"   "
 .S:NUPA("H") X=$J((NUPA("WT")/NUPA("H")),4,1)_" ("_X_")"
 .D:NUPA("N")=1 SET("BODY MASS INDEX - "_X) D:NUPA("N")>1 SET("   "_X)
BMIQ Q "~@^TMP(""NUPA"","_$J_")"
 ;
AM(N) ;Active meds, OP, IV, UD.  N=number of days back
 N NUPA,X,X1,X2,Y S:$G(N)="" N=45 S $P(NUPA("SP")," ",50)="",X1=DT,X2=-N
 D C^%DTC S NUPA("AGO")=X,X1=DT,X2=(-N-365) D C^%DTC S NUPA("AGO",1)=X
 S NUPA("C")=0 D K,NONE("ACTIVE MEDS")
 ;Go back an additonal year in the next call to capture RXs dispensed then,
 ;who's days of supply would then extend into the proper time period.
 D OCL^PSOORRL(DFN,NUPA("AGO",1),DT,0) ;IA 2400
 F NUPA("I")=0:0 S NUPA("I")=$O(^TMP("PS",$J,NUPA("I"))) Q:'NUPA("I")  D
 .S NUPA("TYPE")=$P(^TMP("PS",$J,NUPA("I"),0),U)
 .I NUPA("TYPE")[";I" Q:$P(^TMP("PS",$J,NUPA("I"),0),U,4)<NUPA("AGO")  ;IV/Unit Dose
 .I NUPA("TYPE")["N;O" Q:$P(^TMP("PS",$J,NUPA("I"),0),U,9)'="ACTIVE"  ;Non-VA Meds
 .I NUPA("TYPE")["R;O" S X1=$P(^TMP("PS",$J,NUPA("I"),0),U,10),X2=$P(^TMP("PS",$J,NUPA("I"),0),U,11) D C^%DTC Q:X<NUPA("AGO")  ;OP RX Last Dispense date + Days supply not in range
 .S NUPA("C")=NUPA("C")+1
 .S X=$S(NUPA("TYPE")["N;O":"N",NUPA("TYPE")["R;O":"O",NUPA("TYPE")["U;I":"U",NUPA("TYPE")["V;I":"V",1:"UNK")
 .S ^TMP("NUPA",$J,"SORT",X,$P(^TMP("PS",$J,NUPA("I"),0),U,2),NUPA("C"))=$P(^TMP("PS",$J,NUPA("I"),0),U,10,11)_U_$P(^TMP("PS",$J,NUPA("I"),0),U,4)_U_NUPA("TYPE")
 S NUPA("C")=0
 F NUPA("SUB")="O","V","U" D
 .D SET("*** "_$S(NUPA("SUB")="O":"Outpatient",NUPA("SUB")="V":"IV",1:"Unit Dose")_"  ***")
 .D:'$D(^TMP("NUPA",$J,"SORT",NUPA("SUB"))) NF S NUPA("RX")=""
 .F  S NUPA("RX")=$O(^TMP("NUPA",$J,"SORT",NUPA("SUB"),NUPA("RX"))) Q:NUPA("RX")=""  D
 ..F NUPA("I")=0:0 S NUPA("I")=$O(^TMP("NUPA",$J,"SORT",NUPA("SUB"),NUPA("RX"),NUPA("I"))) Q:'NUPA("I")  D
 ...S X="  Drug: "_($E(NUPA("RX")_NUPA("SP"),1,45))
 ...S:NUPA("SUB")="O" X=X_"  Last Dispensed: "_$$D($P(^TMP("NUPA",$J,"SORT",NUPA("SUB"),NUPA("RX"),NUPA("I")),U))_" ("_$P(^TMP("NUPA",$J,"SORT",NUPA("SUB"),NUPA("RX"),NUPA("I")),U,2)_" days)"
 ...S:NUPA("SUB")'="O" X=X_"  Stop Date: "_$$D($P(^TMP("NUPA",$J,"SORT",NUPA("SUB"),NUPA("RX"),NUPA("I")),U,3))
 ...D SET(X)
 K ^TMP("NUPA",$J,"SORT"),^TMP("PS",$J)
 Q "~@^TMP(""NUPA"","_$J_")"
 ;
ONE(X) ;Single lab test in a time period object.
 ;X should be "Data name^# of occurances^time period (nM, nD, or nY)"
 ;or X could be "Print string^# of occurances^time period (nM, nD, or nY)^Data name number^Print completed time"
 N NUPA S NUPA("TN")=X,C=0,$P(NUPA("SP")," ",50)=""
 S NUPA("N")=$P(NUPA("TN"),U,2),NUPA("T")=$P(NUPA("TN"),U,3)
 S:'NUPA("N") NUPA("N")=99 S:NUPA("T")="" NUPA("T")="99Y"
 S:'$P(NUPA("TN"),U,4) NUPA("TEST")=$O(^DD(63.04,"B",$P(NUPA("TN"),U),0))
 S:$P(NUPA("TN"),U,4) NUPA("TEST")=$P(NUPA("TN"),U,4)
 I 'NUPA("TEST") D  Q "~@^TMP(""NUPA"","_$J_")"
 .D K S ^TMP("NUPA",$J,1,0)=$P(NUPA("TN"),U)_" - INVALID TEST NAME"
 F NUPA("I")=1:1:NUPA("N") S NUPA("TEST",NUPA("I"))=0,NUPA("TEST",NUPA("I"),NUPA("TEST"))=""
 S X=$$TEST^LRPXAPIU(NUPA("TEST")),NUPA("VALIDTESTS",X)=NUPA("TEST"),NUPA("VALIDTESTS","B",NUPA("TEST"))=X ;IA 4246
 S (NUPA("CHK",1),NUPA("CHK",2))=NUPA("TEST") D GET
 I NUPA("TEST",1) S X=$E($P(NUPA("TN"),U)_NUPA("SP"),1,26)_" " D
 .I 'NUPA("TEST",1) S X=X_" NO DATA ON FILE" D SET(X) Q
 .F NUPA("I")=1:1:NUPA("N")-1 D:NUPA("TEST",NUPA("I"))
 ..S X=$S(NUPA("I")=1:X,1:$E(NUPA("SP"),1,27))_$$D1(NUPA("TEST",NUPA("I")))_NUPA("SP")
 ..S X=$E(X,1,45)_$P(NUPA("TEST",NUPA("I"),NUPA("CHK",1)),U)_" "_$P(NUPA("TEST",NUPA("I"),NUPA("CHK",1)),U,2)
 ..S:$P(NUPA("TN"),U,5) X=$E(X_NUPA("SP"),1,55)_$$CONV2($P(NUPA("TEST",NUPA("I")),U,2))
 ..D SET(X)
 D:$P(NUPA("TN"),U,5)  ;also display Verify Date
 .F NUPA("I")=9E9:0 S NUPA("I")=$O(^TMP("NUPA",$J,NUPA("I")),-1) Q:'NUPA("I")  D
 ..S ^TMP("NUPA",$J,NUPA("I")+2,0)=^TMP("NUPA",$J,NUPA("I"),0)
 .S ^TMP("NUPA",$J,1,0)="  TEST                   COLLECTION DATE    RESULT      VERIFY DATE"
 .S ^TMP("NUPA",$J,2,0)=""
ONEQ Q "~@^TMP(""NUPA"","_$J_")"
 ;
GET ;Get data from ^LR(DFN,"CH")
 N NUPATEST,ED,LRDFN,T,X S T=NUPA("T") D K,NONE($P(NUPA("TN"),U)),AGO S NUPA("ED")=ED
 S NUPA("N")=1,LRDFN=$$GETL() Q:'LRDFN
 D RESULTS^LRPXAPI(.NUPATEST,DFN,"C",999,"","",DT,NUPA("ED")) ;IA 4245
 F NUPA("I")=0:0 S NUPA("I")=$O(NUPA("VALIDTESTS",NUPA("I"))) Q:'NUPA("I")  D
 .S NUPA("VALIDTESTS","B",NUPA("VALIDTESTS",NUPA("I")))=NUPA("I")
 S X="" F  S X=$O(NUPATEST(X)) Q:X=""  D
 .Q:'$P(NUPATEST(X),U,2)  Q:'$D(NUPA("VALIDTESTS",$P(NUPATEST(X),U,2)))
 .S ^TMP("NUPA",$J,"SORT",-NUPATEST(X),$P(NUPATEST(X),U,2))=$P(NUPATEST(X),U,4,5)
 F NUPA("I")=-9E9:0 S NUPA("I")=$O(^TMP("NUPA",$J,"SORT",NUPA("I"))) Q:'NUPA("I")  D
 .S NUPA("FLAG")=0
 .F NUPA("II")=0:0 S NUPA("II")=$O(^TMP("NUPA",$J,"SORT",NUPA("I"),NUPA("II"))) Q:'NUPA("II")  D
 ..Q:'$D(^TMP("NUPA",$J,"SORT",NUPA("I"),NUPA("VALIDTESTS","B",NUPA("CHK",1))))!('$D(^TMP("NUPA",$J,"SORT",NUPA("I"),NUPA("VALIDTESTS","B",NUPA("CHK",2)))))
 ..S NUPA("TEST")=NUPA("VALIDTESTS",NUPA("II")) Q:'$D(NUPA("TEST",NUPA("N"),NUPA("TEST")))
 ..S:'NUPA("TEST",NUPA("N"),NUPA("TEST")) NUPA("TEST",NUPA("N"),NUPA("TEST"))=^TMP("NUPA",$J,"SORT",NUPA("I"),NUPA("II")),NUPA("FLAG")=1
 .S:NUPA("FLAG") NUPA("TEST",NUPA("N"))=-NUPA("I"),NUPA("N")=NUPA("N")+1
 K ^TMP("NUPA",$J,"SORT") Q
 ;
GETL() ;Get LRDFN
 S DFN=+$G(DFN) Q $$LRDFN^LRPXAPIU(DFN)  ;IA 4246
 ;
CONV() Q $$CONV2($$LRIDT^LRPXAPIU(NUPA("TEST",NUPA("I"))))  ;IA 4246
CONV2(X) N XX S XX=$E($P(X,".",2)_"0000",1,4)
 S X=X_$E(XX,1,2)_":"_$E(XX,3,4)
 S X=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)_" @ "
 S X=X_$E(XX,1,2)_":"_$E(XX,3,4) Q X
 ;
VIS(NUPAHOWMANY,NUPABACK,NUPATYPE,NUPAQUALIFERS) ;
 ;NUPAHOWMANY Should be set to how many results you want back
 ;NUPABACK should contain the starting date to go back to
 ;NUPATYPE Is the vital ien that you want to report on this is in file (#120.51) NOTE THIS CAN LOOK LIKE "1;2;8;22"
 ;NUPAQUALIFERS Set this to 1 if you want to see the Qualifiers in the output
 ;  0: Date, description, value, no qualifiers
 ;  1: Date, description, value, qualifiers
 ;  2: Value, date, qualifiers, no description
 ;  3: Description, value, date, no qualifiers
 ;  4: Description, value, date, qualifiers
 ;You must have the users DFN in your table before calling the VIS tag.
 N C,ED,I,II,X,X1,X2,NUPACNT,NUPAREVDT,NUPAIEN,NUPAFIELDS,NUPAPIECE1,NUPAPIECE2,NUPASPACE,NUPATEMP,NUPAZZ,GMRVSTR
 S (C,NUPACNT)=0
 K ^UTILITY($J,"GMRVD")
 ;------------------------------------
 S NUPAALL=NUPATYPE F NUPALOOP=1:1  S NUPATYPE=$P(NUPAALL,";",NUPALOOP) Q:NUPATYPE=""  D V2
 ;-------------------------------------
 S X=$$FIELD^GMVGETVT(NUPATYPE,1,"E")
 I $D(^UTILITY($J,"GMRVD"))=0 S X="No "_$S(X=-1:"",1:X)_"vitals found." D SET(X) ;IA 5047
 K NUPACNT,NUPAREVDT,NUPAIEN,NUPAFIELDS,NUPAPIECE1,NUPAPIECE2,NUPASPACE,NUPATEMP,NUPAZZ
 K NUPAHOWMANY,NUPABACK,NUPATYPE,NUPAQUALIFERS,NUPAALL,NUPALOOP
 K ^UTILITY($J,"GMRVD")
 Q "~@^TMP(""NUPA"","_$J_")"
 ;-------------------------------------
V2 ;
 K NUPAVITNAM,T,ED,NUPAFIELDS,NUPATEMP,NUPAZZ,X
 D K K ^UTILITY($J,"GMRVD")
 S NUPAVITNAM=$$FIELD^GMVGETVT(NUPATYPE,2,"I") ;IA 5047
 I $G(NUPAVITNAM)="" S X="No Vital type on file" D SET(X) Q
 S T=NUPABACK D AGO
 S GMRVSTR=NUPAVITNAM,GMRVSTR(0)=ED_"^"_(DT+.9999)_"^"_NUPAHOWMANY_"^"_1
 D EN1^GMVHS ;IA 4791
 S NUPAREVDT="" F  S NUPAREVDT=$O(^UTILITY($J,"GMRVD",NUPAREVDT)) Q:(NUPAREVDT="")!('+NUPAREVDT)  D
 .S NUPACNT=NUPACNT+1
 .S NUPAIEN=0 F  S NUPAIEN=$O(^UTILITY($J,"GMRVD",NUPAREVDT,NUPAVITNAM,NUPAIEN)) Q:(NUPAIEN="")!('+NUPAIEN)  D BUILD
 Q
BUILD ;
 K NUPAFIELDS
 S NUPAFIELDS(.01)="2"
 S NUPAFIELDS(5)=5
 D EN^GMVPXRM(.NUPAFIELDS,NUPAIEN,"B")
 S NUPAPIECE1=$S($D(NUPA("BMI")):+$G(NUPAFIELDS(1)),1:$P($G(NUPAFIELDS(1)),U,2)) ;$$FMTE^XLFDT($P($G(NUPAFIELDS(1)),U,1),"5"))
 S NUPAPIECE2=$S($D(NUPA("BMI")):"",1:$P($G(NUPAFIELDS(3)),U,2)_": ")_$P($G(NUPAFIELDS(7)),U,2)
 S NUPASPACE=$J("",35-$L(NUPAPIECE1))
 I $G(NUPASORT)="VIT" S ^TMP("NUPA",$J,"PRE",NUPAREVDT,NUPAPIECE1,NUPATYPE,0)=$P($G(NUPAPIECE2),":",2) Q
 I $G(NUPASORT)="PVI" S ^TMP("NUPA",$J,"PRE",NUPAREVDT,NUPAPIECE1,NUPATYPE,0)=$P($G(NUPAPIECE2),":",2) Q
 D:$G(NUPAQUALIFERS)<2
 .S:$D(NUPA("BMI")) X=NUPAPIECE1_U_NUPAPIECE2
 .S:'$D(NUPA("BMI")) X=$E(NUPAPIECE1_NUPASPACE,1,24)_NUPAPIECE2_$$KG() D SET(X)
 I $G(NUPAQUALIFERS)=2 S X=$E($P(NUPAPIECE2,": ",2)_$$KG()_NUPASPACE,1,24)_NUPAPIECE1 D SET(X)
 I $G(NUPAQUALIFERS)=3!($G(NUPAQUALIFERS)=4) S X=$E(NUPAPIECE2_$$KG()_NUPASPACE,1,24)_NUPAPIECE1 D SET(X)
 S NUPATEMP="" K X
 S NUPAZZ=0 F  S NUPAZZ=$O(NUPAFIELDS(12,NUPAZZ)) Q:(NUPAZZ="")!('+NUPAZZ)  D
 .Q:$G(NUPAFIELDS(12,NUPAZZ))="^"
 .I NUPAZZ>1 S NUPATEMP=NUPATEMP_", "
 .S NUPATEMP=NUPATEMP_$P($G(NUPAFIELDS(12,NUPAZZ)),U,2)
 Q:'$G(NUPAQUALIFERS)!($G(NUPAQUALIFERS)=3)
 ;I $G(NUPAQUALIFERS)=1,$L(NUPATEMP)>1 
 S X="  Qualifier"_$S(NUPATEMP[",":"s: ",1:": ")_NUPATEMP D SET(X)
 I NUPAFIELDS(3)["PULSE OX" S X="  Supplemental O2: "_$P(NUPAFIELDS(8),U) D SET(X)
 Q 
KG() Q $S(+NUPAFIELDS(3)'=9:"",1:" lb. ("_$J((+NUPAFIELDS(7)/2.2),5,1)_" kg.)")
 ;
K K ^TMP("NUPA",$J) Q
NONE(X) S ^TMP("NUPA",$J,1,0)=X_" - NONE FOUND" Q
NF D SET("  ***  NONE FOUND  ***") Q
SET(X) S:$G(C)&('$G(NUPA("C"))) NUPA("C")=C S NUPA("C")=$G(NUPA("C"))+1,^TMP("NUPA",$J,NUPA("C"),0)=X Q
 ;
AGO S:$D(NUPA("T"))&($G(T)="") T=NUPA("T")
 N X1,X2 S X1=DT,X2=+T,X=$P(T,X2,2),X2=-X2
 S X2=X2*$S(X="M":30,X="W":7,X="D":1,1:365) D C^%DTC S (NUPA("ED"),ED)=X Q
 ;
D(Y) D DD^%DT Q Y
D1(Y) Q $E(Y,4,5)_"/"_$E(Y,6,7)_"/"_$E(Y,2,3)_" @ "_$E($P(Y,".",2)_"0000",1,4)
