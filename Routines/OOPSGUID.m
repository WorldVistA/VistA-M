OOPSGUID ;WIOFO/LLH-RPC routine for GET/SET CA7 ;04/29/04
 ;;2.0;ASISTS;**8,15,20**;Jun 03, 2002;Build 2
 ;
SAVECA7 ; saves CA7 data to database
 S (RESULTS,RESULTS(1),RESULTS(2))=""
 I $G(IEN)="NEW" D NEWCA7 I $P(RESULTS(2),U,2)'="CA7 Created" Q
 ;
 S RESULTS(1)=IEN_U_"UPDATE FAILED"
 K DR S DIE="^OOPS(2264,",DA=IEN,DR=""
 S DR(1,2264,1)="1///^S X=ARR(6)"
 S DR(1,2264,2)="2////^S X=ARR(7)"
 S DR(1,2264,3)="3///^S X=ARR(8)"
 S DR(1,2264,4)="4///^S X=ARR(9)"
 S DR(1,2264,5)="5////^S X=ARR(10)"
 S DR(1,2264,6)="6///^S X=ARR(11)"
 S DR(1,2264,7)="7///^S X=ARR(12)"
 S DR(1,2264,8)="8///^S X=ARR(13)"
 S DR(1,2264,11)="9///^S X=ARR(14)"
 S DR(1,2264,12)="10///^S X=ARR(15)"
 S DR(1,2264,13)="11///^S X=ARR(16)"
 S DR(1,2264,14)="12///^S X=ARR(17)"
 S DR(1,2264,15)="13///^S X=ARR(18)"
 S DR(1,2264,16)="14///^S X=ARR(19)"
 S DR(1,2264,17)="15///^S X=ARR(20)"
 S DR(1,2264,18)="16///^S X=ARR(21)"
 S DR(1,2264,19)="17///^S X=ARR(22)"
 S DR(1,2264,20)="18///^S X=ARR(23)"
 S DR(1,2264,21)="19///^S X=ARR(24)"
 S DR(1,2264,22)="20///^S X=ARR(25)"
 S DR(1,2264,24)="21///^S X=ARR(26)"
 S DR(1,2264,25)="22///^S X=ARR(27)"
 S DR(1,2264,26)="23///^S X=ARR(28)"
 S DR(1,2264,27)="24///^S X=ARR(29)"
 S DR(1,2264,28)="25///^S X=ARR(30)"
 S DR(1,2264,29)="27///^S X=ARR(31)"
 S DR(1,2264,30)="28///^S X=ARR(32)"
 S DR(1,2264,31)="29///^S X=ARR(33)"
 S DR(1,2264,32)="30///^S X=ARR(34)"
 S DR(1,2264,33)="31///^S X=ARR(35)"
 S DR(1,2264,34)="32///^S X=ARR(36)"
 S DR(1,2264,35)="33///^S X=ARR(37)"
 S DR(1,2264,36)="34///^S X=ARR(38)"
 S DR(1,2264,37)="35///^S X=ARR(39)"
 S DR(1,2264,38)="36///^S X=ARR(40)"
 S DR(1,2264,39)="37///^S X=ARR(41)"
 S DR(1,2264,40)="38///^S X=ARR(42)"
 S DR(1,2264,41)="39///^S X=ARR(43)"
 S DR(1,2264,42)="40///^S X=ARR(44)"
 S DR(1,2264,43)="41///^S X=ARR(45)"
 S DR(1,2264,44)="41.3///^S X=ARR(46)"
 S DR(1,2264,45)="41.6///^S X=ARR(47)"
 S DR(1,2264,46)="42///^S X=ARR(48)"
 S DR(1,2264,47)="43///^S X=ARR(49)"
 S DR(1,2264,48)="44///^S X=ARR(50)"
 S DR(1,2264,49)="45///^S X=ARR(51)"
 S DR(1,2264,50)="46///^S X=ARR(52)"
 S DR(1,2264,51)="47///^S X=ARR(53)"
 S DR(1,2264,52)="48///^S X=ARR(54)"
 S DR(1,2264,53)="49///^S X=ARR(55)"
 S DR(1,2264,54)="50///^S X=ARR(56)"
 S DR(1,2264,55)="51///^S X=ARR(57)"
 D ^DIE
 I '($D(Y)=0) Q
 K DR S DIE="^OOPS(2264,",DA=IEN,DR=""
 S DR(1,2264,56)="52///^S X=ARR(58)"
 S DR(1,2264,57)="53///^S X=ARR(59)"
 S DR(1,2264,58)="54///^S X=ARR(60)"
 S DR(1,2264,59)="56///^S X=ARR(61)"
 S DR(1,2264,60)="57///^S X=ARR(62)"
 S DR(1,2264,61)="58///^S X=ARR(63)"
 S DR(1,2264,62)="59///^S X=ARR(64)"
 S DR(1,2264,63)="60///^S X=ARR(65)"
 S DR(1,2264,64)="62///^S X=ARR(66)"
 S DR(1,2264,65)="63///^S X=ARR(67)"
 S DR(1,2264,66)="64///^S X=ARR(68)"
 S DR(1,2264,67)="65///^S X=ARR(69)"
 S DR(1,2264,68)="67///^S X=ARR(70)"
 S DR(1,2264,69)="68///^S X=ARR(71)"
 S DR(1,2264,70)="69///^S X=ARR(72)"
 S DR(1,2264,71)="70///^S X=ARR(73)"
 S DR(1,2264,72)="71///^S X=ARR(74)"
 S DR(1,2264,73)="72///^S X=ARR(75)"
 S DR(1,2264,74)="73///^S X=ARR(76)"
 S DR(1,2264,75)="74///^S X=ARR(77)"
 S DR(1,2264,76)="75///^S X=ARR(78)"
 S DR(1,2264,77)="76///^S X=ARR(79)"
 S DR(1,2264,78)="78///^S X=ARR(80)"
 S DR(1,2264,79)="79///^S X=ARR(81)"
 S DR(1,2264,80)="80///^S X=ARR(82)"
 S DR(1,2264,81)="81///^S X=ARR(83)"
 S DR(1,2264,82)="82///^S X=ARR(84)"
 S DR(1,2264,83)="83///^S X=ARR(85)"
 S DR(1,2264,84)="84///^S X=ARR(86)"
 S DR(1,2264,85)="85///^S X=ARR(87)"
 S DR(1,2264,86)="86///^S X=ARR(88)"
 S DR(1,2264,87)="87///^S X=ARR(89)"
 S DR(1,2264,88)="88///^S X=ARR(90)"
 S DR(1,2264,89)="89///^S X=ARR(91)"
 S DR(1,2264,90)="90///^S X=ARR(92)"
 S DR(1,2264,91)="91///^S X=ARR(93)"
 S DR(1,2264,92)="92///^S X=ARR(94)"
 S DR(1,2264,93)="93///^S X=ARR(95)"
 S DR(1,2264,94)="94///^S X=ARR(96)"
 ; V2_P15, added new field llh
 S DR(1,2264,95)="98///^S X=ARR(97)"
 D ^DIE
 ;Check the return of ^DIE
 I $D(Y)=0 S RESULTS(1)=IEN_U_ARR(0)_U_"UPDATE COMPLETED"
 Q
NEWCA7 ; need to file the CA7 first, then file the remaining data
 N ACLAIM,CA7,DLAYGO,DR,DIC,I,X
 S CA7=""
 I '$G(ARR(3)) S (RESULTS,RESULTS(1))="No ASISTS IEN, cannot file" Q
 I '$D(^OOPS(2260,ARR(3),0)) D  Q
 . S (RESULTS,RESULTS(1))="ASISTS claim not on file, cannot continue"
 S ACLAIM=$$GET1^DIQ(2260,ARR(3),.01)
 I $G(ACLAIM)="" D  Q
 . S (RESULTS,RESULTS(1))="No ASISTS claim number, cannot continue"
 S ARR(0)=$$CA7NUM()
 I $G(ARR(0))="" D  Q
 . S (RESULTS,RESULTS(1))="Could not build CA7 Number, cannot continue"
 S ARR(1)=$$NOW()
 K DD,DO S DLAYGO=2264,DIC="^OOPS(2264,",DIC(0)="L",X=ARR(0)
 S DIC("DR")=".3////^S X=ARR(1);.5////^S X=DUZ;.7////^S X=ARR(3);.8////^S X=ARR(4);.9////^S X=ARR(5)"
 D FILE^DICN I +Y>0 D
 . S (RESULTS,RESULTS(2))=IEN_U_"CA7 Created"
 . S IEN=+Y
 Q
CA7NUM() ; gets next CA-7 number
 N CASE,NUM,CA7TEST
 S CA7TEST=ACLAIM_"-CA7"
 S CASE="^OOPS(2264,"_"""B"""_","""_CA7TEST_""")"
 F  S CASE=$Q(@CASE) Q:$P(CASE,",",3)'[ACLAIM  S CA7=$P(CASE,",",3)
 S NUM=$P(CA7,"-",4)+1,NUM=$E("000",1,3-$L(NUM))_NUM
 Q $P(CA7TEST,"-",1,3)_"-"_NUM
 ;
NOW() ; returns current date and time
 N %,%I,%H,X
 D NOW^%DTC
 Q %
DUAL(RESULTS,INPUT,DATA) ; new sub for filing DUAL node fields - 
 ;                         need to add parameters back
 ; for the Dual Benefit form answered from the CA1 or CA2
 ;
 ; Input:  INPUT - IEN^FORM; first piece is the record identifier
 ;                           2nd piece is the form, CA1 or CA2
 ;          DATA - data string, p1=fld 303, p2=304, p3=305, p4=306
 ;                 p5=307, p6=308
 ;                 data does not include electronic signature fields
 ;                 for the node 
 ;
 N ARR,CN,DA,DIE,DR,LP,IEN
 S RESULTS="No Changes Filed"
 S IEN=$P($G(INPUT),U)
 I '$G(IEN) S RESULTS="No IEN passed in - save failed" Q
 K DR S DIE="^OOPS(2260,",DA=IEN,DR=""
 I '$L($TR(DATA,"^","")) S RESULTS="No data to save" Q
 F LP=1:1:6 S ARR(LP)=$P($G(DATA),U,LP)
 S DR(1,2260,1)="303///^S X=ARR(1)"
 S DR(1,2260,2)="304///^S X=ARR(2)"
 S DR(1,2260,3)="305///^S X=ARR(3)"
 S DR(1,2260,4)="306///^S X=ARR(4)"
 S DR(1,2260,5)="307///^S X=ARR(5)"
 S DR(1,2260,6)="308///^S X=ARR(6)"
 D ^DIE
 I $D(Y)=0 S RESULTS="UPDATE COMPLETED"
 Q
SAVE2162 ; V2_P15 moved entire SAVE2162 subroutine from OOPSGUI5 to here
 ; due to size of OOPSGUI5
 K DR S DIE="^OOPS(2260,",DA=IEN,DR=""
 S DR(1,2260,1)="3///^S X=ARR(3)"
 S DR(1,2260,2)="5///^S X=ARR(5)"
 S DR(1,2260,3)="6///^S X=ARR(6)"
 S DR(1,2260,4)="7///^S X=ARR(7)"
 S DR(1,2260,5)="8///^S X=ARR(8)"
 S DR(1,2260,7)="9///^S X=ARR(9)"
 S DR(1,2260,9)="10///^S X=ARR(10)"
 S DR(1,2260,12)="11///^S X=ARR(11)"
 S DR(1,2260,15)="12///^S X=ARR(12)"
 S DR(1,2260,18)="13////^S X=ARR(13)"
 S DR(1,2260,21)="14///^S X=ARR(14)"
 S DR(1,2260,24)="15///^S X=ARR(15)"
 S DR(1,2260,27)="16///^S X=ARR(16)"
 S DR(1,2260,30)="17///^S X=ARR(17)"
 S DR(1,2260,33)="18///^S X=ARR(18)"
 S DR(1,2260,36)="26///^S X=ARR(19)"
 S DR(1,2260,39)="27////^S X=ARR(20)"
 S DR(1,2260,42)="29///^S X=ARR(21)"
 S DR(1,2260,45)="29.5///^S X=ARR(22)"
 S DR(1,2260,48)="30///^S X=ARR(23)"
 S DR(1,2260,51)="30.1///^S X=ARR(24)"
 S DR(1,2260,54)="31///^S X=ARR(25)"
 S DR(1,2260,57)="32///^S X=ARR(26)"
 S DR(1,2260,60)="33///^S X=ARR(27)"
 S DR(1,2260,63)="34///^S X=ARR(28)"
 S DR(1,2260,66)="35///^S X=ARR(29)"
 S DR(1,2260,69)="36///^S X=ARR(30)"
 S DR(1,2260,72)="37///^S X=ARR(31)"
 S DR(1,2260,75)="38///^S X=ARR(32)"
 S DR(1,2260,78)="41///^S X=ARR(33)"
 S DR(1,2260,81)="42///^S X=ARR(34)"
 S DR(1,2260,84)="42.5///^S X=ARR(35)"
 S DR(1,2260,87)="43///^S X=ARR(36)"
 S DR(1,2260,90)="53////^S X=ARR(45)"
 S DR(1,2260,93)="53.1////^S X=ARR(46)"
 S DR(1,2260,96)="60///^S X=ARR(52)"
 S DR(1,2260,99)="61///^S X=ARR(53)"
 S DR(1,2260,102)="62///^S X=ARR(54)"
 S DR(1,2260,105)="63///^S X=ARR(55)"
 S DR(1,2260,108)="70///^S X=ARR(60)"
 S DR(1,2260,111)="73///^S X=ARR(63)"
 S DR(1,2260,114)="82///^S X=ARR(72)"
 S DR(1,2260,117)="83////^S X=ARR(73)"
 S DR(1,2260,120)="84///^S X=ARR(74)"
 S DR(1,2260,123)="85///^S X=ARR(75)"
 S DR(1,2260,126)="86///^S X=ARR(76)"
 S DR(1,2260,129)="87///^S X=ARR(77)"
 S DR(1,2260,132)="88///^S X=ARR(78)"
 S DR(1,2260,135)="89///^S X=ARR(79)"
 S DR(1,2260,136)="335///^S X=ARR(85)"
 S DR(1,2260,138)="336///^S X=ARR(86)"
 S DR(1,2260,140)="337///^S X=ARR(87)"
 D ^DIE I '($D(Y)=0) Q
 S DR(1,2260,142)="338///^S X=ARR(88)"
 S DR(1,2260,144)="339///^S X=ARR(89)"
 S DR(1,2260,146)="340///^S X=ARR(90)"
 S DR(1,2260,148)="341///^S X=ARR(91)"
 S DR(1,2260,150)="342///^S X=ARR(92)"
 S DR(1,2260,152)="343///^S X=ARR(93)"
 S DR(1,2260,154)="344///^S X=ARR(94)"
 S DR(1,2260,156)="345///^S X=ARR(95)"
 S DR(1,2260,158)="346///^S X=ARR(96)"
 S DR(1,2260,159)="334///^S X=ARR(97)"
 S DR(1,2260,160)="348///^S X=ARR(98)"
 S DR(1,2260,161)="349///^S X=ARR(99)"
 S DR(1,2260,162)="350///^S X=ARR(100)"
 S DR(1,2260,163)="351///^S X=ARR(101)"
 S DR(1,2260,164)="352///^S X=ARR(102)"
 ; V2_P15 new fields
 S DR(1,2260,165)="354///^S X=ARR(103)"
 S DR(1,2260,166)="355///^S X=ARR(104)"
 S DR(1,2260,167)="356///^S X=ARR(105)"
 S DR(1,2260,168)="357///^S X=ARR(106)"
 S DR(1,2260,169)="358///^S X=ARR(107)"
 S DR(1,2260,170)="359///^S X=ARR(108)"
 ; v2_P20 new field for Column F on the OSHA 300 log
 S DR(1,2260,171)="384///^S X=ARR(109)"
 D ^DIE I $D(Y)=0 S RESULTS(1)="UPDATE COMPLETED"
 ; V2_15 send new bulletin if the INITIAL RETURN TO WORK STATUS is one of 2 values below
 I ARR(102)="DAYS AWAY WORK"!(ARR(102)="Job Transfer/Restriction") D CIO^OOPSMBUL(IEN)
 Q
