PRCB2B ;WISC/PLT-ENTERED, NOT APPROVED REQUESTS RPT ; 03/01/96  1:27 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 QUIT  ;invalid entry
 ;
EN0 ;control point entry
 N PRCFCP
 S PRCFCP=1
EN ;fiscal official entry point
 N PRCA,PRCB,PRCQCD,PRCOPT,PRCRI,PRCDI,PRCDUZ,PRC,PRCSST,PRCSTC
 N A,B,C,SI
Q1 ;station
 S PRCSST=1 D STA^PRCSUT S PRCSTC=SI G:$G(PRC("SITE"))=""!(Y<0)!(PRCSTC<1) EXIT
 S PRCRI(420)=+PRC("SITE")
 G:$G(PRCFCP) Q3
Q2 S B="O^1:All control points;2:Single control point"
 K X,Y S Y(1)="^W ""Enter an option number 1 to 2."""
 D SC^PRC0A(.X,.Y,"Select Number",B,"")
 S A=Y K X,Y
 G EXIT:A=""!(A["^")
 S PRCOPT=+A
 I PRCOPT=1 G Q4
 I "1"[PRCOPT G Q4
Q3 ;select control point
 S PRCDI="420;^PRC(420,;"_PRC("SITE")
 S $P(PRCDI,"~",2)="420.01;"_$P($P(PRCDI,"~"),";",2)_PRCRI(420)_",1,;"
 S X("S")="I ^(0)-9999" S:$G(PRCFCP) X("S")=X("S")_",$P(^(0),""^"",9)=""Y""!($D(^PRC(420,""A"",DUZ,PRC(""SITE""),+Y)))"
 D LOOKUP^PRC0B(.X,.Y,PRCDI,"AEOQS","Select Fund Control Point: ")
 I Y<0!(X="") S PRCQT="^" G Q2:'$G(PRCFCP),Q1:PRCSTC>1,EXIT
 K X S PRCRI(420.01)=+Y,PRC("CP")=$P($P(Y,"^")," ")
Q4 ;fiscal year - quarter
 S A=$P($G(^PRC(420,PRC("SITE"),0)),"^",9),A=$$DATE^PRC0C(A,"I")
 S PRCA=$P(A,"^")_"-"_$P(A,"^",2)_"^"_$P(A,"^",7)_"^"_$P(A,"^",8)
 D EN^DDIOL(" "),EN^DDIOL("The oldest OPEN quarter in file is "_$P(PRCA,"^",1)_".")
 S E="O^4:6^K:X'?2N.1""-"".1N&(X'?4N.1""-"".1N)!($P(X,""-"",2)<1)!($P(X,""-"",2)>4) X",Y(1)="Enter a 2 or 4 digit year followed by a '-' and quarter #, like 88-3 or 1988-3"
 D FT^PRC0A(.X,.Y,"For Budget Fiscal Year - Quarter (YY-Q)",E,"")
 I X["^"!(X="")!(Y'?2.4N.1"-".1N) G Q2:'$G(PRCFCP),Q1
 S $P(Y,"-")=+$$YEAR^PRC0C($P(Y,"-"))
 I "1995-1"]Y D EN^DDIOL("Report is not available for any quarters before '95-1'.") G Q4
 S $P(PRCOPT,"^",2)=Y,$P(PRCOPT,"^",3)=PRCRI(420),$P(PRCOPT,"^",4)=$G(PRCRI(420.01))
Q5 D YN^PRC0A(.X,.Y,"Ready to Print","O","YES")
 I X["^"!(X="")!'Y S PRCOPT=$P(PRCOPT,"^") G Q4
 S A=$P(PRCOPT,"^",2),A=$$QTRDATE^PRC0D(+A,$P(A,"-",2))
 S $P(PRCOPT,"^",5)=$P(A,"^",7)
 S PRC("SITE")=$P(PRCOPT,"^",3),PRCRI(420)=+PRC("SITE"),PRCRI(420.01)=$P(PRCOPT,"^",4),PRC("CP")=""
 I $P(PRCOPT,"^",4) S PRC("CP")=$P($G(^PRC(420,PRCRI(420),1,PRCRI(420.01),0)),"^"),PRCD=$P(PRCOPT,"^",5)_"-"_PRC("SITE")_"-"_$P(PRC("CP")," ")_"-",PRCE=PRCD_"~"
 E  S PRCD=$P(PRCOPT,"^",5)_"-"_PRC("SITE")_"-",PRCE=PRCD_"~"
 S L=0,DIC="^PRCS(410,",FLDS=".01,449;""RB QTR DATE"",20;""COMMIT COST""",DHD="IFCAP ENTERED, NOT APPROVED REQUESTS"
 S DIS(0)="I $P(^PRCS(410,D0,0),""^"",12)=""E"""
 S BY(0)="^PRCS(410,""RB"",",L(0)=2,FR(0,1)=PRCD,TO(0,1)=PRCE
 D EN1^DIP
EXIT QUIT
