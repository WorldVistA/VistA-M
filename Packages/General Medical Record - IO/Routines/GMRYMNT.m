GMRYMNT ;HIRMFO/YH-SITE CARE/MAINTENANCE/FLUSH ;8/13/96
 ;;4.0;Intake/Output;;Apr 25, 1997
EN1 ;IV SITE MAINTENANCE FOR OPEN SITE AND SITE CHECK FOR ALL IV SITES
 S GADD="N",GDCIV=0 D SEL1 G:GMROUT!(X="") Q1
DT S %DT("A")="Please enter date/time: ",%DT="AETXRS",%DT("B")="NOW" D ^%DT K %DT G:Y<1 Q1 S (GST,GST(1))=0 F  S GST(1)=$O(^GMR(126,DFN,"IV","SITE",GSITE,GST(1))) Q:GST(1)'>0  S GST=GST(1)
 S:GST>0 GST=9999999-GST I GST>Y W !!,"The date/time can not come before the time IV started"_$S(GOPT="MAINTN":" for the site.",1:"."),! G DT
 S (GX,X)=+Y S GMROUT(1)=0,GMROUT(1)=$$ADM^GMRYUT12(.GMROUT,DFN,GX) G:GMROUT Q1
 S GDCDT=0 D EN1^GMRYMNT1
Q1 K GDATA,ADD,GDCIV Q
SEL1 ;SELECT IV SITE FOR SITE CHECK OR MAINTENANCE
 I GMRXY=0 W !!,"There are no IV sites with IV(s) running.",! Q
 ;I GMRXY=1 S X=1,GSITE=$O(GMRXY(1,"")) W !,GSITE_":",! Q:GSITE=""  D WRITE G NXT
 S GSITE="" F I=1:1:GMRXY W !,I_". " S GSITE=$O(GMRXY(I,GSITE)) Q:GSITE=""  D WRITE1 S GDA="" F  S GDA=$O(GST(GSITE,GDA)) Q:GDA=""  W:GDA'="BLANK" !,?3,GDA S GDA(1)=0 F  S GDA(1)=$O(GST(GSITE,GDA,GDA(1))) Q:GDA(1)'>0  D
 . S GDATA=GST(GSITE,GDA,GDA(1),0) D WRITE
 I GOPT="ADDONLY" W !!,"Select an IV site to add additional solutions: "
 I GOPT="DCIV" W !!,"Select an IV site to discontinue: "
 I GOPT="MAINTN" W !!,"Select IV site for care/maintenance/flush: "
 I GOPT="FLUSH" W !!,"Select IV site to flush: "
 S X="" R X:DTIME I '$T!(X["^") S GMROUT=1 Q
 I X="" S GMROUT=1 Q
NXT I $D(GMRXY(+X)) S GSITE=$O(GMRXY(+X,"")),DA(1)=DFN,DA=$O(^GMR(126,DFN,"IVM","B",GSITE,0)) D   Q
 .S GSITE(GSITE)="" D FINDCA^GMRYCATH(.GSITE) S GCATH=GSITE(GSITE),GCATH(2)=$S($D(^GMRD(126.74,"B",GCATH)):$O(^GMRD(126.74,"B",GCATH,0)),1:"")
 I X=""!(X["?") W !,"Select an IV site which you wish to "_$S(GDCIV=6:"add solution",1:"enter data for the site description,"),!,$S(GDCIV'=6:"dressing change and tube change",1:""),! G SEL1
 G SEL1
SELSITE ;SELECT ALL CURRENT AND DISCONTINUED SITES WITHIN THE LAST 24 HR
 K GCT,GST,GMRXY D NOW^%DTC S X1=%,X2=-1 D C^%DTC S GIVDT=X-.0001
 S GSITE="",GMRXY=0 F  S GSITE=$O(^GMR(126,DFN,"IV","SITE",GSITE)) Q:GSITE=""  S GDT=0 F  S GDT=$O(^GMR(126,DFN,"IV","SITE",GSITE,GDT)) Q:GDT'>0  D SCREEN
 D DCDATE^GMRYMNT1
 S GMRXY=0,GSITE="" F  S GSITE=$O(GMRXY(GSITE)) Q:GSITE=""  S GMRXY=GMRXY+1,GMRXY(GMRXY,GSITE)=""
 Q
WRITE ;
 N X,I S X=$S($P(GDATA,"^",4)'["L":$P(GDATA,"^",3),1:"LOCK/PORT")_$S($P(GDATA,"^",4)'["L":" ("_$P(GDATA,"^",4)_")  "_$P(GDATA,"^",5)_" mls ",1:"")
 S Y=$P(GDATA,"^"),X=X_" ("_$E(Y,4,5)_"/"_$E(Y,6,7)_"/"_$E(Y,2,3)_"@"_$E($P(Y,".",2)_"0000",1,2)_":"_$E($P(Y,".",2)_"0000",3,4)_")"
 S GST(GSITE,GDA,GDA(1),2)=X
 S DIWR=70,DIWF="",DIWL=0 K ^UTILITY($J) D ^DIWP
 S I=0 F  S I=$O(^UTILITY($J,"W",0,I)) Q:I'>0  W !,?4,^UTILITY($J,"W",0,I,0)
 K ^UTILITY($J) Q
WRITE1 ;
 W GSITE_$S(GCT(GSITE)=0:" - IV discontinued on "_GMRXY(GSITE),1:" - "_GSITE(GSITE))
 Q
SCREEN ;SCREEN IV SITES DISCONTINUED WITHIN THE LAST 24 HRS
 S GDA=0 F  S GDA=$O(^GMR(126,DFN,"IV","SITE",GSITE,GDT,GDA)) Q:GDA'>0  S GDATA=^GMR(126,DFN,"IV",GDA,0) I $P(GDATA,"^",9)=""!($P(GDATA,"^",9)>GIVDT&(+$G(GGNN)=5)) D SET
 Q
SET ;
 S GMRXY(GSITE)="",GSITE(GSITE)="" S:'$D(GCT(GSITE)) GCT(GSITE)=0 D FINDCA^GMRYCATH(.GSITE)
 I $P(GDATA,"^",9)="" S GCT(GSITE)=GCT(GSITE)+1,GST=$S($G(^GMR(126,DFN,"IV",GDA,3))'="":^(3),1:"BLANK"),GST(GSITE,GST,GDA,0)=GDATA
 Q
