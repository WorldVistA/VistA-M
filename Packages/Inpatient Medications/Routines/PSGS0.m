PSGS0 ;BIR/CML3 - SCHEDULE PROCESSOR ;06/22/09 7:12 PM
 ;;5.0;INPATIENT MEDICATIONS;**12,25,26,50,63,74,83,116,110,111,133,138,174,134,213,207,190,113,245,227**;DEC 16, 1997;Build 1
 ;
 ; Reference to ^PS(51.1 is supported by DBIA 2177.
 ; Reference to ^PS(55   is supported by DBIA 2191.
 ;
ENA ; entry point for train option
 D ENCV^PSGSETU Q:$D(XQUIT)
 F  S (PSGS0Y,PSGS0XT)="" R !!,"Select STANDARD SCHEDULE: ",X:DTIME W:'$T $C(7) S:'$T X="^" Q:"^"[X  D:X?1."?" ENQ^PSGSH I X'?1."?" D EN W:$D(X)[0 $C(7),"  ??" I $D(X)#2,'PSGS0Y,PSGS0XT W "  Every ",PSGS0XT," minutes"
 K DIC,DIE,PSGS0XT,PSGS0Y,Q,X,Y,PSGDT Q
 ;
EN3 ;
 S PSGST=$P($G(^PS(53.1,DA,0)),"^",7) G EN
 ;
EN5 ;
 S PSGST=$P($G(^PS(55,DA(1),5,DA,0)),"^",7)
 ;
EN ; validate
 K PSGS0Y
 I X[""""!($A(X)=45)!(X?.E1C.E)!($L(X)>70)!($L(X)<1) K X Q
 S:X'=" " X=$$TRIM^XLFSTR(X,"R"," ") ;PSJ*5*227 - Prevent schedule crash
 I X?.E1L.E S X=$$ENLU^PSGMI(X) I '$D(PSGOES) D EN^DDIOL("  ("_X_")")
 ;
ENOS ; order set entry
 N X0,Y0,PSJXI,PSJDIC2,TMPAT
 I $G(X)="",$G(P(2)),$G(P(3)) S X=$G(P(9))
 I $G(X)="" Q
 S PSGXT=$G(PSGS0XT),(PSGS0XT,PSGS0Y,XT,Y,PSJNSS)=""
 S X0=X I X?2.4N1"-".E!(X?2.4N) D ENCHK S:$D(X) Y=X G Q
 ; * GUI 27 CHANGES * Check for admin times to be derived from 'base' schedule
 I X["@" S TMPAT=$P(X,"@",2) I TMPAT]"" D
 .I '$D(^PS(51.1,"AC","PSJ",TMPAT)) K TMPAT Q
 .I '$$DOW^PSIVUTL($P(X,"@")) K TMPAT Q
 .N LYN,ZZND,PSGS0XT,PSGS0Y,X S (PSGS0Y,PSGS0XT,X)=""
 .S X=TMPAT D DIC I $G(Y0)>0 S TMPAT=Y0
 I $G(TMPAT) S (PSGS0Y,$P(X,"@",2))=TMPAT,PSGS0XT="D"
 ; * GUI 27 CHANGES *
 I X["PRN",$$PRNOK(X),'$D(^PS(51.1,"AC","PSJ",X)) D  G Q
 .;PSJ*5*190 Check for One-time PRN
 .I $$ONE^PSJBCMA($G(DFN),$G(ON),X)="O" S XT="O" Q
 .I X["@"!$$DOW^PSIVUTL($P(X," PRN")) N DOW D  I $G(DOW) S (Y0,Y,PSGS0Y)=$P($P(X,"@",2)," ")
 ..N TMP S TMP=X N X S X=$P(TMP," PRN") D DW I $G(X)]"" S DOW=1
 ..I $G(DOW),$G(PSGST)]"" I ",P,R,"'[(","_PSGST_",") S (XT,PSGS0XT)="D"
 D DIC I $G(XT)]""!$G(Y0)!($G(X)]""&$G(PSJXI)) D  Q:'$D(X)  I $G(X)]"",PSGS0XT'="D" G:$D(^PS(51.1,"AC","PSJ",X)) Q3 I $P(X,"@")]"" G:$D(^PS(51.1,"AC","PSJ",$P(X,"@"))) Q3
 .S PSGS0XT=XT S:$G(Y0) (Y,PSGS0Y)=Y0 S:'PSGS0Y&((PSGS0XT)="D")&(X["@") PSGS0Y=$P(X,"@",2)
 .S PSGS0Y=$P(PSGS0Y," ")
 .; If entering from Verify action, and schedule exists in schedule file, and order's schedule is continuous,
 .; OR the order's schedule type is fill on request and the order's schedule is defined as continuous in schedule file,
 .; AND the order's schedule is not a PRN schedule, the order must have admin times.
 .Q:$G(PSGOES)'=2  Q:'$D(^PS(51.1,"AC","PSJ",X))
 .I $G(PSGST)="C"!($G(PSGST)="R"&($P($G(ZZND),"^",3))) I ($G(PSGST)'="P"),($G(PSGSCH)'[" PRN"),('$G(PSGAT)&'$G(PSGS0Y)),'$$ODD^PSGS0($G(PSGS0XT)) Q:($P($G(ZZND),"^",5)="O")  Q:$$ODD^PSGS0($P(ZZND,"^",3))  K X Q
 N TMPSCHX S TMPSCHX=X I $L(X,"@")<3 S TMPX=X D DW I $G(X)]"" K PSJNSS S (PSGS0XT,XT)="D" D  G Q
 .S Y=$S(($G(TMPSCHX)["@"):$P(TMPSCHX,"@",2),1:"")
 .I Y,(X'["@"),(TMPSCHX["@") S X=TMPSCHX
 S X=TMPSCHX
 I X'="" I $D(^PS(51.1,"AC","PSJ",X)) K PSJNSS G Q
 ;
NS I ($G(X)="^")!($G(X)="") K X S Y="" Q
 N NS S NS=0,PSJNSS=0
 I $G(Y)'>0 S X=X0,Y="",NS=1,PSJNSS=1
Q ;
 S PSGS0XT=$S(XT]"":XT,1:$G(PSGS0XT)),PSGS0Y=$S($G(Y):Y,$G(PSGS0Y):PSGS0Y,1:"") S:PSGS0XT<0 PSGS0XT=""
 I ('$G(PSGS0Y)&'$G(PSJDIC2)&$G(PSGAT))&'$G(PSJNEWOE)&$G(PSGS0XT) I PSGS0XT<1441 I ($L($G(PSGAT),"-")=PSGS0XT/1440)!($G(X)]""&($G(PSGSCH)=$G(X))) S PSGS0Y=$G(PSGAT)
Q2 K YY
 I '$G(PSJNSS),'$G(PSGS0Y),$G(YY) S PSGS0Y=YY
 I $G(X)]"",$$SCHREQ^PSJLIVFD(.P) D
 .I $$DOW^PSIVUTL(X)!$$PRNOK(X)!$D(^PS(51.1,"AC","PSJ",X)) S PSJNSS=0 Q
 .I $G(P(2))&$G(P(3)) D NSSCONT(X,PSGS0XT) S TMPX="" K X
 I ($G(PSJNSS)&($G(VALMBCK)'="Q"))!($G(PSJNSS)&$G(PSJLIFNI))!($G(PSJNSS)&$G(PSJTUD)) D
 .I $G(P(2))&$G(P(3)) Q
 .I ($G(X)]"") I ($G(PSGS0XT)'="D") D NSSCONT(X,PSGS0XT) S TMPX="" K X
Q3 I $G(X)]"" I $D(^PS(51.1,"AC","PSJ",X)) K PSJNSS
 K QX,SDW,SWD,X0,XT,Z Q
 ;
NSSCONT(SCH,FREQ) ;
 Q:SCH=""!($G(VALMBCK)]"")!$G(PSGMARSD)!$G(PSIVFN1)
 I $G(PSGOES),'$G(NSFF) Q
 N PSGS0XT,PSGSCH,DIR,X,Y S PSGSCH=SCH,PSGS0XT=FREQ,PSJNSS=1
 D NSSMSG I ($L(PSJNSS)>2),'$G(PSJXI) W !!,PSJNSS,! S PSJNSS=1
 S DIR(0)="EA",DIR("A")="Press Return to continue..." D ^DIR
 K NSFF Q
 ;
NSSMSG ;
 Q:$G(PSJXI)
 I '(",O,"[(","_$G(PSGST)_",")),$G(PSJNSS),$G(PSGSCH)]"" D
 .S PSJNSS=" WARNING - "_PSGSCH_" is an invalid schedule."
 S PSGSCH="",PSGS0XT=""
 Q
 ;
NSO(FQ) ;
 Q:'FQ!(FQ<0)!(",D,O,"[(","_$G(PSGST)_",")) ""
 K FRQOUT S FRQOUT=$S(FQ<60:(FQ_"minute"),(FQ<1440)&(FQ#60):(FQ_" minute"),(FQ<1440)!(FQ#1440):(FQ/60_" hour"),1:(FQ/1440_" day")) D
 . S:(+FRQOUT'=1) FRQOUT=FRQOUT_"s"
 Q FRQOUT
 ;
ENCHK ;
 N H,I
 I $S($L($P(X,"-"))>4:1,$L(X)>119:1,$L(X)<2:1,X'>0:1,1:X'?.ANP) K X Q
 S X(1)=$P(X,"-") I X(1)'?2N,X(1)'?4N K X Q
 S X(1)=$L(X(1)) I X'["-"&((X>$E(2400,1,X(1))!($E(X,3,4)>59))) K X Q
 F X(2)=2:1:$L(X,"-") S X(3)=$P(X,"-",X(2)) I $S($L(X(3))'=X(1):1,X(3)>$E(2400,1,X(1)):1,$E(X(3),3,4)>59:1,1:X(3)'>$P(X,"-",X(2)-1)) K X Q
 Q:'$D(X)
 F X(2)=1:1:$L(X,"-") S X(3)=$P(X,"-",X(2)) I $E(X(3),3,4)>59 K X Q
 Q:'$D(X)
 S X(1)=$L(X,"-"),X(2)=$G(PSGS0XT),PSGSCH=$S($G(PSGSCH)]"":PSGSCH,1:$G(P(9)))
 I $G(PSGSCH)="" Q  ;No schedule info, so just validate the numbers and quit.
 I $D(^PS(51.1,"AC","PSJ",PSGSCH)) S H=+$O(^PS(51.1,"AC","PSJ",PSGSCH,0)) S I=$P($G(^PS(51.1,H,0)),"^",5)
 I $G(I)="" S I=$S(PSGSCH["PRN":"P",1:"C")
 I I="D",$L(X,"-")>0 K:$D(X) X(1),X(2),X(3) S I="C" Q  ;DOW schedules require at least one admin time
 I $G(I)="O" D  Q  ;One Time schedules
 . I $L(X,"-")>1 K X Q  ;One Time schedules allow one admin time
 I X(2)="" Q  ;No frequency - cannot validate admin times to frequency
 I X(2)>1439,$L(X,"-")>1 K X Q  ;PSJ*5*113 Schedules with frequency greater than 1 day can only have one admin time.
 I X(2)>0,X(2)<1440,X(1)>(1440/X(2)) K X Q  ;PSJ*5*113 Admin times must match frequency or fewer
 I X(2)>0,X(2)<1440,1440#X(2)'=0,X(1)>0 K X Q  ;PSJ*5*113 Odd schedules cannot have admin times
 I X(2)>0,X(2)>1440,X(2)#1440'=0,X(1)>1 K X Q  ;PSJ*5*113 Odd schedules cannot have admin times
 K:$D(X) X(1),X(2),X(3)
 Q
 ;
DIC ; Check for schedule's existence in ADMINISTRATION SCHEDULE file (#51.1)
 ; Input:    
 ;           X = Schedule Name
 ;     PSJSLUP = If $G(PSJSLUP), perform interactive fileman lookup (optional).
 ;     PSGSFLG = If $G(PSGSFLG), return schedule IEN in PSGSCIEN variable (optional)
 ;    PSJLIFNI = Flag indicating a U/D order is being finished as an IV (optional).
 ;      PSGOES = If PSGOES=1, IX^DIC is called silently. If PSGOES=2, IX^DIC is not called (optional).
 ;      PSJPWD = IEN of Inpatient Ward associated with the patient/order/schedule combination (optional).
 ; Output:
 ;           X = Schedule Name if valid Input Schedule X, undefined if invalid Input Schedule X.
 ;     PSGS0XT = Frequency of validated schedule.
 ;     PSGS0Y  = Default Admin Times of validated schedule.
 ;    PSGSCIEN = IEN of validated schedule, if PSGSLFG is passed in and is evaluated to TRUE.
 ;
 K Y0,PSJXI N Y,PSGS0ST
 S Z=0 F PSJXI=0:1 S Z=$O(^PS(51.1,"AC","PSJ",X,Z)) Q:'Z
 I $G(X)]"",'$G(PSJSLUP) D
 .I $D(^PS(51.1,"AC","PSJ",X)) D  Q:$G(PSGS0Y)&($G(PSGS0XT)]"")
 ..I $$DOW^PSIVUTL(X) S PSGS0XT="D",PSJNSS=0 S:X["@" (Y0,PSGS0Y)=$P(X,"@",2) Q
 ..I $G(NSFF) S Y0=$S($G(PSGS0Y):PSGS0Y,$G(PSGAT)&'$G(PSJNEWOE):PSGAT,1:"") S:Y0 PSGS0Y=Y0
 .; Check for duplicate schedules - force selection
 .Q:PSJXI>1&('$G(PSGOES))&($G(PSGS0XT)]"")
 .I $D(^PS(51.1,"AC","PSJ",X)) N FREQ,ADMATCH S FREQ=$G(PSGS0XT) D
 ..N PSGS0XT,PSGS0Y,PSGST D ADMIN^PSJORPOE S:$G(PSGS0XT) XT=PSGS0XT S:$G(PSGS0Y) (Y0,Y)=PSGS0Y I $G(PSGST)'="" S PSGS0ST=PSGST
 ..;Check flag PSGSFLG to determine whether to return the schedule IEN in PSGSCIEN.
 .S:$G(XT)]"" PSGS0XT=XT S:$G(Y) PSGS0Y=Y
 .I $$DOW^PSIVUTL(X) S:PSGS0XT="" (XT,PSGS0XT)="D" S:PSGS0Y="" (Y0,PSGS0Y)=$S($P(X,"@",2):$P(X,"@",2),1:"")
 I $G(PSJLIFNI)!($G(P(4))]""&($G(P(2))]"")) I '$D(^PS(51.1,"AC","PSJ",X))!($G(PSJXI)>1) S PSJSLUP=1
 I $G(NSFF),$G(PSJXI)>1 D
 .I $G(PSGS0XT)="",$G(NSFF),$G(PSGXT)]"" S PSGS0XT=PSGXT Q
 .I $G(PSGS0XT)=""!($G(PSGS0Y)="") S PSJSLUP=1
 I '$G(PSJSLUP) Q:$G(PSGS0XT)]""&($G(PSGS0Y)]"")  Q:($G(PSGS0XT)="D"&('$D(^PS(51.1,"AC","PSJ",X))))
 Q:$G(PSGOES)=2
 Q:$G(PSGS0XT)]""&(PSJXI=1)
 I $G(PSGS0ST)="O",PSJXI=1 Q  ;one-time order,exact match (PSJ*5*207)
 K PSJSLUP
 ;
 K DIC S DIC="^PS(51.1,",DIC(0)=$E("E",'$D(PSGOES))_"ISZ",DIC("W")="W ""  "","_$S('$D(PSJPWD):"$P(^(0),""^"",2)",'PSJPWD:"$P(^(0),""^"",2)",1:"$S($D(^PS(51.1,+Y,1,+PSJPWD,0)):$P(^(0),""^"",2),1:$P(^PS(51.1,+Y,0),""^"",2))"),D="APPSJ"
 S PSJDIC2=1
 D IX^DIC K DIC S:$D(DIE)#2 DIC=DIE I Y'>0 D  Q
 .I '$$DOW^PSIVUTL(X),'$$PRNOK(X),'$$ODD($G(PSGS0XT)),'$$ODD($P($G(ZZND),"^",3)),($P($G(ZZND),"^",5)'="O") S X="",PSJNSS=1,XT="",PSJXI=""
 S XT=$S("C"[$P(Y(0),"^",5):$P(Y(0),"^",3),1:$P(Y(0),"^",5))
 S X=+Y,Y="" I $D(PSJPWD),$D(^PS(51.1,+X,1,+PSJPWD,0)) S Y=$P(^(0),"^",2)
 ;Check flag PSGSFLG to determine whether to return the schedule IEN in PSGSCIEN.
 I $G(PSGSFLG) S PSGSCIEN=X
 S (X,X0)=Y(0,0) S:$G(Y)="" Y=$P(Y(0),"^",2)
 S (PSGS0Y,Y0)=$G(Y),Y0(0)=Y(0) I $P(Y(0),"^",3) S XT=$P(Y(0),"^",3)
 I $G(PSGS0XT)="",$$DOW^PSIVUTL(X) S (XT,PSGS0XT)="D"
 Q
 ;
DW ;
 N Y
 Q:($L(X,"@")>2)
 N AT I X["@" S AT=$P(X,"@",2)
 S SWD="SUNDAYS^MONDAYS^TUESDAYS^WEDNESDAYS^THURSDAYS^FRIDAYS^SATURDAYS",SDW=X,X=$P(X,"@",2) N XABB S XABB=""
 I X]"" D ENCHK Q:'$D(X)
 S X=$P(SDW,"@"),X(1)="-" I X?.E1P.E,X'["-"  ;F QX=1:1:$L(X) I $E(X,QX)?1P S X(1)=$E(X,QX) Q
 F Q=1:1:$L(X,X(1)) K:SWD="" X Q:SWD=""  S Z=$P(X,X(1),Q) D DWC Q:'$D(X)
 I $D(X) F II=1:1:$L(X,X(1)) S XABB=$G(XABB)_$E($P(X,X(1),II),1,2)_"-"
 K X(1) S:$D(X) X=SDW I $G(X)]"" I $TR(XABB,"-")]"" S X=$E($G(XABB),1,$L(XABB)-1)
 I $G(AT) S PSGS0Y=AT
 Q
DWC I $L(Z)<2 K X Q
 F QX=1:1:$L(SWD,"^") S Y=$P(SWD,"^",QX) I $P(Y,Z)="" S SWD=$P(SWD,Y,2) S:$L(SWD) SWD=$E(SWD,2,50) Q
 E  K X
 Q
 ;
PRNOK(PSCH) ;
 Q:PSCH'["PRN" 0
 I $TR(PSCH," ")="PRN" Q 1
 N BASE,I,OK S OK=0 S I=$P(PSCH," PRN") I I]"",$D(^PS(51.1,"AC","PSJ",I)) S OK=1
 I 'OK D
 .I PSCH["@" I $D(^PS(51.1,"AC","PSJ",$P(PSCH,"@")))!$$DOW^PSIVUTL($P(PSCH,"@")) S OK=1 Q
 .I $$DOW^PSIVUTL($P(PSCH," PRN")) S OK=1
 Q OK
ODD(PSF) ;determine if this is an odd schedule
 I PSF>1439,PSF#1440 Q 1
 I PSF,PSF<1440,1440#PSF Q 1
 Q 0
