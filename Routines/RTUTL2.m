RTUTL2 ;MJK/TROY ISC;Utility Routine; ; 5/15/87  11:39 AM ;
 ;;v 2.0;Record Tracking;;10/22/91 
 K RTY,RT,RTS,RTC,RTC1,RTL,RTX S RTC1=0,U="^",IOP="" D ^%ZIS K IOP
 S RTIX="AA",RTIX("V")=+RTAPL S:$D(RTTY) RTIX="AT",RTIX("V")=+RTTY
 F I=0:0 S I=$O(^RT(RTIX,RTIX("V"),RTE,I)) Q:'I  I $D(^RT(I,0)) S (RT1,Y)=I D SCR^RTDPA D SORT:Y
 I 'RTC1 D D1 I D1 D HD W !!?3,"No '",$S($D(RTTY):$P($P(RTTY,"^"),";",2),1:$P($P(RTAPL,"^"),";",2)),"' records ",$S('$D(RT1):"on file.",1:"available.")
 I RTC1 D REC I '$D(RTESC),$D(RTSEL),RTC>RTC0 D SEL1
 K RTS,RTIX,RTLC,RTC0,RTC1,D1,RTL,T,V,O,I Q
 ;
SORT Q:'$D(^RT(I,0))  S V=999-$P(^(0),"^",7),O=$S($D(^DIC(195.2,+$P(^(0),"^",3),0)):+$P(^(0),"^",4),1:0) Q:'O  S T=$P(^(0),"^")
 S RT=I D DEMOS2^RTUTL1 S RTL(O,V)=I_"^"_T_"^"_(999-V)_"^"_RTD("B")_"^"_RTD("D")_"^"_RTD("P1")_"^"_$S($D(RTD("PROV")):RTD("PROV")_"^"_RTD("PROVP"),1:"^")_"^"_$P(^RT(I,0),"^",12),RTC1=RTC1+1 K RTD,RT Q
 ;
REC S RTLC=0 D D1 G REC1:'D1 D HD
 W !!?3,"Record Type",?21,"Vol",?26,"Current Borrower",?45,"Date Charged",?65,"Phone/Room #"
 W !?3,"-----------",?21,"---",?26,"----------------",?45,"------------",?65,"------------" S RTLC=RTLC+7
REC1 S (RTC,RTC0)=0 F O=0:0 S O=$O(RTL(O)) Q:'O  D LINE^RTUTL3:RTC&(D1) S:RTC&(D1) RTLC=RTLC+1 F V=0:0 S V=$O(RTL(O,V)) Q:'V  S X=RTL(O,V),RTC=RTC+1,RTS(RTC)=+X I D1 D PRT,SEL G REC1Q:$D(RTESC)
REC1Q Q
 ;
PRT W ! W:$D(RTSEL) RTC W ?3,$E($P(X,"^",2),1,16),?21,"V",$P(X,"^",3),?26,$E($P(X,"^",4),1,18),?45,$P(X,"^",5),?65,$E($P(X,"^",6),1,14) S RTLC=RTLC+1
 I $P(X,"^",7)]""!($P(X,"^",9)]"") W ! W:$P(X,"^",9)]"" ?3,"(",$P(X,"^",9),")" W:$P(X,"^",7)]"" ?26,"(",$P(X,"^",7),")" W:$P(X,"^",8)]"" ?65,"(",$P(X,"^",8),")" S RTLC=RTLC+1
 I $P(X,"^",4)["MISSING" W *7 I $D(^RTV(190.2,"AM","s",+X)) D FND^RTUTL1 S RTLC=RTLC+1
 I $D(^RT(+X,"I")),^("I"),DT>^("I") W !?3,"*** INACTIVE RECORD ***" S RTLC=RTLC+1
 I $D(^RT(+X,"COMMENT")),^("COMMENT")]"" W !?3,"(",^("COMMENT"),")" S RTLC=RTLC+1
 Q
 ;
SEL I $D(RTSEL),(RTLC+4)>20 S RTLC=0,RTZ("RTC")=RTC D SEL1 W ! S:'$D(RTY) RTC=RTZ("RTC") S:$D(RTESC) RTC0=RTC K RTZ Q
 I (RTLC+4)>20,IOST["C-" S RTLC=0 K RTESC D ESC^RTRD
 Q
 ;
SEL1 S RTRD("A")=$S($D(RTSEL("A")):RTSEL("A"),1:"Choose Record")_$S(RTSEL["S"&(RTC>1):"s",1:"")_" from List: " D SEL^RTRD K RTRD,RTESC
 S:$D(RTY)!(X="...") RTESC="" I RTC S ^DISV($S($D(DUZ)'[0:DUZ,1:0),"^RT(")=+RTY(RTC) I RTC=1,'D1 W !!?3,"...",$P(^DIC(195.2,+$P(^RT(+RTY(1),0),"^",3),0),"^"),"  V",+$P(^RT(+RTY(1),0),"^",7)
 Q
 ;
RECHD ;Entry point for record header w/X and RT defined
 ;              X = header
 ;             RT = file entry # to ^RT(
 Q:'$D(^RT(RT,0))  S RTE=$P(^(0),"^"),RTD("SAVE")="" D PTHD,LINE^RTUTL3 S H="UNKNOWN",P="UNKNOWN" I $D(^RTV(195.9,+$P(^RT(RT,0),"^",6),0)) S P=$S($P(^(0),"^",8)]"":$P(^(0),"^",8),1:P),Y=$P(^(0),"^") D NAME^RTB S H=Y
 W !,"Current   : ",$E(RTD("B"),1,19),?32,"Phone   : ",RTD("P"),?58,"|Home : ",$E(H,1,13),!,"Since...  : ",RTD("D"),?32,"Location: ",RTD("L"),?58,"|Phone: ",$E(P,1,13) D FND^RTUTL1:$D(^RTV(190.2,"AM","s",RT))
 W:$D(RTD("PROV")) !,"[Associated Borrower NAME/PHONE: ",RTD("PROV")," / ",RTD("PROVP"),"]"
 D EQUALS^RTUTL3 K H,P,RTD,% Q
 ;
PTHD ;Entry point to print entity(patient) demographics; RTE defined
 ;              RTE = variable pointer for entity [45;DPT(]
 Q:'$D(RTE)  W @IOF,?(80-$L(X1))/2,X1 D EQUALS^RTUTL3 S Y=RTE D DEMOS1^RTUTL1
 W !,"Name      : ",$E(RTD("N"),1,30) W:$D(RTD("SSN")) "  (",RTD("SSN"),")" W ?55,"Page: ",$S($D(RTPAGE):RTPAGE,1:1)
 W ! W:$D(RTD("DOB")) "Birth Date: ",RTD("DOB") W:$D(RTD("W")) ?26,"Ward: ",$E(RTD("W"),1,20) D NOW^%DTC S Y=$E(%,1,12) D D^DIQ W ?47,"Run Date: ",Y K % K:'$D(RTD("SAVE")) RTD
 I RTE["DPT(",$D(^DPT(+RTE,.35)),+^(.35) W !?20,"***** Date of Death: " S Y=+^(.35) D D^DIQ W Y W " *****"
 Q
 ;
D1 ;D1 is the flag that indicates whether data is displayed
 S D1=1 S:$S($D(RTSEL)[0:0,RTSEL["D":1,1:0) D1=$S(RTSEL["L":0,RTSEL["O"&(RTC1=1):0,RTSEL["S":1,1:0) Q
 ;
HD S X1="**** "_$P($P(RTAPL,"^"),";",2)_" Profile ****" D PTHD D EQUALS^RTUTL3 Q
