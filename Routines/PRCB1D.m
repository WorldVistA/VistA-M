PRCB1D ;WISC/PLT-RESET FCP YEARLY FMS ACCOUNTING ELEMENT AND BBFY ACT CODE ; 03/14/94  2:06 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 QUIT  ;invalid entry
 ;
EN N PRCRI,PRC,PRCZ,PRCDD,PRCDI,PRCQT,PRCB,PRCB1,PRCD,PRCD1,PRCSTU
 N A,B,C,X,Y
 F  S PRCQT=1 D LG1 QUIT:PRCQT["^"  D  Q:PRCQT["^"&($G(PRCSTU)<2)
 . F  S PRCQT=2 D LG2 QUIT:PRCQT["^"
 . QUIT
EXIT QUIT
 ;
LG1 K PRC S PRCDI="420;^PRC(420,;" D
 . S PRCSTU=0,PRCRI(411)=0 F  S PRCRI(411)=$O(^PRC(411,PRCRI(411))) Q:'PRCRI(411)  S:$D(^PRC(420,PRCRI(411),2,DUZ)) PRCSTU=PRCSTU+1_"^"_PRCRI(411)
 I 'PRCSTU D EN^DDIOL("Station access is not allowed") S PRCQT="^" G LG1X
 I +PRCSTU=1 S PRC("SITE")=$P(^PRC(420,+$P(PRCSTU,"^",2),0),"^") D EN^DDIOL("STATION: "_PRC("SITE")) G LG1E
 S X("S")="I $D(^PRC(420,+Y,2,DUZ))"
 D LOOKUP^PRC0B(.X,.Y,PRCDI,"ACEFNO","Select Station: ")
 S:X=""!(X["^") PRCQT="^"
 S PRC("SITE")=$P(Y,"^",2)
LG1E S PRCRI(420)=+PRC("SITE"),PRCDI=PRCDI_PRCRI(420)_";"
LG1X QUIT
 ;
LG2 ;
 S $P(PRCDI,"~",2)="420.01;"_$P($P(PRCDI,"~"),";",2)_PRCRI(420)_",1,;"
Q2 K PRCZ D EN^DDIOL($TR($J("",78)," ","-")) S X("S")="I ^(0)-9999"
 D LOOKUP^PRC0B(.X,.Y,PRCDI,"AEOQS","Select Fund Control Point: ")
 I Y<0!(X="") S PRCQT="^" QUIT
 K X S PRCRI(420.01)=+Y,PRC("CP")=$P($P(Y,"^")," ")
 S PRCDI=PRCDI_PRCRI(420.01)_";"
 ;
Q3 S E="O^2:4^K:X'?2N&(X'?4N) X",Y(1)="Enter a 2 or 4 digit year."
 D FT^PRC0A(.X,.Y,"For Budget Fiscal Year",E,"")
 G:X["^"!(X="") Q2
 S PRC("FY")=$P($$YEAR^PRC0C(Y),"^",2),PRCRI(420.06)=PRC("FY")
 S PRCD=$G(^PRC(420,PRCRI(420),1,PRCRI(420.01),4,PRCRI(420.06),2))
 ;I PRCD="" D EN^DDIOL("   The yearly FMS accounting elements are not in file yet.") G Q3
 D DIS(PRC("SITE")_"^"_PRC("CP")_"^"_PRC("FY"))
Q4 D YN^PRC0A(.X,.Y,"Reset the fiscal year "_PRC("FY")_" Suballowance Account","O","NO")
 G:X["^"!(X="")!(Y<1) Q2
 S PRCZ(4)=Y
Q5 ;D SC^PRC0A(.X,.Y,"Select FMS SA-doc ACT code","OM^A:for suballowance account NOT in FMS yet;C:for suballowance account is in FMS","")
 ;G:X["^"!(X="") Q2
 S Y="C"
 S PRCZ(5)=Y
Q6 D YN^PRC0A(.X,.Y,"Ready to File","O","NO")
 G:X["^"!(X="")!'Y Q2
 I '$P(PRCB1,"^",11) D EN^DDIOL("BBFY missing in FCP set up") G Q2
 S A=$$FUND^PRC0C($P(PRCB1,"^",10),$P(PRCB1,"^",11))
 I 'A D EN^DDIOL("Fund code "_$P(PRCB1,"^",10)_" with beginning year "_$P(PRCB1,"^",11)_" is not in fund file (420.14)") G Q2
 S PRC("BBFY")=$$BBFY^PRCSUT(PRCRI(420),PRC("FY"),PRCRI(420.01),1)
 I $G(PRCZ(4))=1 D  G:'$G(PRC("BBFY")) Q2
 . S:$P(PRCD1,"^",10)="" $P(PRCD1,"^",10)=$P(PRCB1,"^",10) S A=$$FUND^PRC0C($P(PRCD1,"^",10),PRC("BBFY"))
 . I 'A D EN^DDIOL("Fund code "_$P(PRCD1,"^",10)_" with beginning year "_PRC("BBFY")_" is not in fund file (420.14).") K PRC("BBFY")
 . QUIT
 S PRCLOCK=$P($P(PRCDI,"~",2),";",2)_PRCRI(420.01)_","
 D ICLOCK^PRC0B(PRCLOCK,.Y)
 I 'Y D EN^DDIOL("This FCP File is in use, please try later!") G Q2
 D FILE D DCLOCK^PRC0B(PRCLOCK)
 G Q2
 ;
FILE ;filing
 I $G(PRCZ(4))=1 D
 . ;delete old entry in file 420.141
 . S C=$$ACC^PRC0C(PRC("SITE"),PRC("CP")_"^"_PRC("FY")_"^"_PRC("BBFY"))
 . S A=$$FMSACC^PRC0D(PRC("SITE"),C)
 . S B=$$FIRST^PRC0B1("^PRCD(420.141,""B"","""_A_""",",0)
 . I B D DELETE^PRC0B1(.X,";^PRCD(420.141,;"_B)
 . ;reset fiscal yearly accounting elements
 . D:'$D(^PRC(420,PRCRI(420),1,PRCRI(420.01),4,PRCRI(420.06))) EBAL^PRCSEZ(PRCRI(420)_"^"_PRCRI(420.01)_"^"_PRCRI(420.06)_"^1^0","C")
 . S ^PRC(420,PRCRI(420),1,PRCRI(420.01),4,PRCRI(420.06),2)=PRCB
 ;add new entry if action code is 'C', delete if code is A
 S C=$$ACC^PRC0C(PRC("SITE"),PRC("CP")_"^"_PRC("FY")_"^"_PRC("BBFY"))
 S A=$$FMSACC^PRC0D(PRC("SITE"),C)
 S B=$$FIRST^PRC0B1("^PRCD(420.141,""B"","""_A_""",",0)
 I $G(PRCZ(5))="A",B D DELETE^PRC0B1(.X,";^PRCD(420.141,;"_B)
 I $G(PRCZ(5))="C",'B S B=$$A420D141^PRC0F(A,PRCRI(420.01))
 QUIT
 ;
 ;PRCA data ^1=station, ^2=control point, ^3=fiscal year
DIS(PRCA) ;display fms accounting data
 D  ;get acc element from fcp
 . N Z
 . S Z("ST")=PRCRI(420),Z("CP")=PRCRI(420.01)
 . S PRCB=$$SUBALL^PRCSEZ
 . QUIT
 S PRCD=$G(^PRC(420,PRCRI(420),1,PRCRI(420.01),4,PRCRI(420.06),2))
 S PRCB1=$$ACC(PRCB),PRCD1=$$ACC(PRCD)
 S A=$P($G(^PRC(420,PRCRI(420),1,PRCRI(420.01),5)),"^",8),$P(PRCB1,"^",11)=+$$DATE^PRC0C(A,"F")
 S $P(PRCD1,"^",11)=PRC("FY")
 W !,"CURRENT FCP ACCOUNTING ELEMENTS",?40,"FISCAL YEAR FCP ACCOUNTING ELEMENTS"
 S B=0 F A=11,10,9,4:1:8 S B=B+1,C=$P("BBFY~FUND~APPROPRI~A/O~PROGRAM~FCP/PRJ~OBJECT CLASS~JOB","~",B) W !,$J(C,12),": ",$P(PRCB1,"^",A) S:C="BBFY" C="FISCAL YEAR" W ?40,$J(C,12),": ",$P(PRCD1,"^",A)
 QUIT
 ;
ACC(A) ;get external format of prca
 S:$P(A,"^",4) $P(A,"^",4)=$$NP^PRC0B("^PRCD(420.15,$P(A,""^"",4),",0,1)
 S:$P(A,"^",5) $P(A,"^",5)=$$NP^PRC0B("^PRCD(420.13,$P(A,""^"",5),",0,1)
 S:$P(A,"^",6) $P(A,"^",6)=$$NP^PRC0B("^PRCD(420.131,$P(A,""^"",6),",0,1)
 S:$P(A,"^",7) $P(A,"^",7)=$$NP^PRC0B("^PRCD(420.132,$P(A,""^"",7),",0,1)
 S:$P(A,"^",8) $P(A,"^",8)=$$NP^PRC0B("^PRCD(420.133,$P(A,""^"",8),",0,1)
 QUIT A
 ;
