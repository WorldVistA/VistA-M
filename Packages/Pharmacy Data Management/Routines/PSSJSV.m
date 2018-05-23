PSSJSV ;BIR/CML3/WRT-SCHEDULE VALIDATION ;06/24/96
 ;;1.0;PHARMACY DATA MANAGEMENT;**20,38,56,59,110,121,143,149,146,189,201,210**;9/30/97;Build 9
 ;
 ; Reference to ^PS(51.15 is supported by DBIA #2132
 ; Reference to $$UP^XLFSTR(P1) is supported by DBIA #10104
 ;
EN ;
 S X=PSJX,(PSJAT,PSJM,PSJTS,PSJY,PSJAX)="" I $S(X["""":1,$A(X)=45:1,X'?.ANP:1,$L(X," ")>2:1,$L(X)>70:1,$L(X)<1:1,X["P RN":1,1:X["PR N") K PSJX,X Q
 I X["PRN"!(X="ON CALL")!(X="ONCALL")!(X="ON-CALL") G DONE
 I X?1."?" D:'$D(PSJNE) ENSVH^PSSJSV0 Q
 I X["@" D DW S:$D(X) PSJAT=$P(X,"@",2) G DONE
 S X0=X,(XT,Y)="" I X,X'["X",(X?2.4N1"-".E!(X?2.4N)) D ENCHK S:$D(X) PSJAT=X G DONE
 I $S($D(^PS(51.1,"AC",PSJPP,X)):1,1:$E($O(^(X)),1,$L(X))=X) D DIC G:$S(PSJY:PSJTS'="C",1:PSJM) DONE
 I $S(X="NOW":1,X="ONCE":1,X="STAT":1,X="ONE TIME":1,X="ONETIME":1,X="1TIME":1,X="1-TIME":1,X="1 TIME":1,1:X="ONE-TIME") S PSJTS="O" W:'$D(PSJNE) "  (ONCE ONLY)" G DONE
 S:PSJTS="" PSJTS="C" I PSJAT="" W:'$D(PSJNE) "  (Non standard schedule)" S X=PSJX
 I $E(X,1,2)="AD" K X G DONE
 I $E(X,1,3)="BID"!($E(X,1,3)="TID")!($E(X,1,3)="QID") S PSJM=1440\$F("BTQ",$E(X)) G DONE
 S:$E(X)="Q" X=$E(X,2,99) S:'X X="1"_X S X1=+X,X=$P(X,+X,2),X2=0 S:X1<0 X1=-X1 S:$E(X)="X" X2=X1,X=$E(X,2,99) I 'X2,$E(X)="O" S X2=.5,X=$E(X,2,99)
 S XT=$S(X["'":1,(X["D"&(X'["AD"))!(X["AM")!(X["PM")!(X["HS"&(X'["THS")):1440,X["H"&(X'["TH"):60,X["AC"!(X["PC"):480,X["W":10080,X["M":40320,1:-1) I XT<0,PSJAT="" K X G DONE
 S X=PSJX I XT S:X2 XT=XT\X2 S:'X2 XT=XT*X1
 S PSJM=XT
 ;
DONE ;
 K:$D(X)[0 PSJX K D,DIC,Q,QX,SDW,SWD,X,X0,X1,X2,XT,Y,Z Q
 ;
ENCHK ; admin times
 N SCHED
 I $S($L($P(X,"-"))>4:1,$L(X)>119:1,$L(X)<2:1,X'>0:1,1:X'?.ANP) K X Q
 S X(1)=$P(X,"-") I X(1)'?2N,X(1)'?4N K X Q
 S X(1)=$L(X(1)) F X(2)=2:1:$L(X,"-") S X(3)=$P(X,"-",X(2)) I $S($L(X(3))'=X(1):1,X(3)>$S(X(1)=2:24,1:2400):1,1:X(3)'>$P(X,"-",X(2)-1)) K X Q
 Q:'$D(X)
 S X(1)=$L(X,"-")
 S SCHED=$S($G(DA(1)):$$GET1^DIQ(52.61,+$G(DA)_","_DA(1),4),$G(DA):$$GET1^DIQ(52.6,+DA,4),1:"")
 Q:(SCHED="")
 S IENS=$O(^PS(51.1,"B",SCHED,0))
 S X(4)=$S($G(PSSJSE)&($G(PSSSCT)]""):PSSSCT,1:$$GET1^DIQ(51.1,IENS,5,"I"))
 I X(4)="D" D  Q  ;DOW schedules require at least one admin time
 . I X(1)>0 K:$D(X) X(1),X(2),X(3) Q
 . K X
 I X(4)="O" D  Q
 . I $L(X,"-")>1 K X Q  ;One Time schedules allow one admin time
 . I X="" K X Q  ;One Time schedules require one admin time
 S X(2)=$S($G(PSSJSE)&($G(PSSFRQ)):PSSFRQ,1:$$GET1^DIQ(51.1,IENS,2,"I"))
 I X(2)="" K:$D(X) X(1),X(2),X(3) Q
 I X(2)>0,X(2)<1440,(1440/X(2))'=X(1) K X Q  ;PSS*1*143 Admin times must match frequency
 I X(2)>0,X(2)<1440,(1440#X(2))'=0,X(1)>0 K X Q  ;PSS*1*143 Odd schedules cannot have admin times
 I X(2)>1440,(X(2)#1440)'=0,X(1)>1 K X Q  ;PSS*1*143 Odd schedules cannot have admin times
 I X(2)>1439,$L(X,"-")'=1 K X Q  ;PSS*1*143 Schedules with frequency equal to or greater than 1 day can only have one admin time.
 K:$D(X) X(1),X(2),X(3)
 Q
 ;
DIC ; 51.1 look-up
 S DIC="^PS(51.1,",DIC(0)=$E("E",'$D(PSJNE))_"ISZ",DIC("W")="I '$D(PSJNE) D DICW^PSSJSV0",D="AP"_PSJPP
 D IX^DIC K DIC Q:Y'>0  S PSJY=+Y,(PSJX,X,X0)=Y(0,0),PSJM=$P(Y(0),"^",3),PSJTS=$P(Y(0),"^",5),PSJAX=$P(Y(0),U,7) S:PSJTS="" PSJTS="C" Q:PSJTS="O"!(PSJTS["R")  I $D(PSJW),$D(^PS(51.1,+Y,1,+PSJW,0)) S PSJAT=$P(^(0),"^",PSJTS="S"+2)
 E  S PSJAT=$P(Y(0),"^",PSJTS="S"*4+2)
 Q:PSJTS'="S"
 F Y=1:1:$L(PSJAT,"-") S Y(1)=$P(PSJAT,"-",Y),PSJAT(Y(1))="",Y(2)=$O(^PS(51.15,"ACP",PSJPP,Y(1),0)) I Y(2),$D(^PS(51.15,Y(2),0)) S PSJAT(Y(1))=$P(^(0),"^",3) I $D(PSJW),$D(^(1,PSJW,0)),$P(^(0),"^",2)]"" S PSJAT(Y(1))=$P(^(0),"^",2)
 Q
 ;
DW ;  week days
 S SWD="SUNDAYS^MONDAYS^TUESDAYS^WEDNESDAYS^THURSDAYS^FRIDAYS^SATURDAYS",SDW=X,X=$P(X,"@",2) D ENCHK Q:'$D(X)
 S X=$P(SDW,"@"),X(1)="-" I X?.E1P.E,X'["-" F QX=1:1:$L(X) I $E(X,QX)?1P S X(1)=$E(X,QX) Q
 F Q=1:1:$L(X,X(1)) K:SWD="" X Q:SWD=""  S Z=$P(X,X(1),Q) D DWC Q:'$D(X)
 K X(1) S:$D(X) X=SDW Q
DWC I $L(Z)<2 K X Q
 F QX=1:1:$L(SWD,"^") S Y=$P(SWD,"^",QX) I $P(Y,Z)="" S SWD=$P(SWD,Y,2) S:$L(SWD) SWD=$E(SWD,2,50) Q
 E  K X
 Q
 ;
ENSNV ; schedule name
 I $S(X["""":1,$A(X)=45:1,X'?.ANP:1,$L(X)>20:1,$L(X)<2:1,1:X?1P.E) K X Q
 I $S('$D(PSJPP):0,PSJPP="":1,PSJPP'?.ANP:1,1:'$$VERSION^XPDUTL(PSJPP)) K X
 I $D(DA),$D(^PS(51.1,DA,0)),$P(^(0),"^",5)["D" S ZX=X D DNVX S:$D(X) X=ZX K Z1,Z2,Z3,Z4,ZX
 Q
 ;
ENSHV ;  shift in 51.1
 I $S($L(X)>11:1,$L(X)<1:1,'$D(PSJPP):1,PSJPP="":1,PSJPP'?.ANP:1,1:'$$VERSION^XPDUTL(PSJPP)) K X Q
 F X(1)=1:1:$L(X,"-") S X(2)=$P(X,"-",X(1)) I $S(X(2)="":1,X(2)'?.ANP:1,1:'$D(^PS(51.15,"ACP",PSJPP,X(2)))) K X Q
 K X(1),X(2) Q
 ;
ENVSST ;  shift start/stop times
 I X'?2N1"-"2N,X'?4N1"-"4N K X Q
 F X(1)=1,2 I $P(X,"-",X(1))>$S($L($P(X,"-",X(1)))<4:24,1:2400) K X Q
 K X(1) Q
 ;
ENFQD ; frequency default
 N X1,X2,Z S Z=$S($D(^PS(51.1,DA,0)):$P(^(0),"^"),1:""),X=""
 S X=$P(Z,"^",3) I Z]"" Q
 S Z=DA I $E(Z,1,2)="AD" Q
 I $E(Z,1,3)="BID"!($E(Z,1,3)="TID")!($E(Z,1,3)="QID") S X=1440/$F("BTQ",$E(Z)) Q
 E  S:$E(Z)="Q" Z=$E(Z,2,99) S:'Z Z="1"_Z S X1=+Z,Z=$P(Z,+Z,2),X2=0 S:$E(Z)="X" X2=X1,Z=$E(Z,2,99) I 'X2,$E(Z)="O" S X2=.5,Z=$E(Z,2,99)
 S X=$S(Z["'":1,(Z["D"&(Z'["AD"))!(Z["AM")!(Z["PM")!(Z["HS"&(Z'["THS")):1440,Z["H"&(Z'["TH"):60,Z["AC"!(Z["PC"):480,Z["W":10080,Z["M":40320,1:"") Q:'X  S:X2 X=X\X2 S:'X2 X=X*X1 Q
 ;
ENFREQ ; validate frequency
 K:+X'=X!(X>525600)!(X<1)!(X?.E1"."1N.N) X
 Q
 ;
DFCHK ; validate dosing check frequency **pss_1_201**
 N PSSX1,PSSX2 S PSSX1="",X=$$UP^XLFSTR(X),PSSX2=$E(X,$L(X))
 ;
 I $L(X)>4!($L(X)<3) K X Q
 ;
 I '+($E(X,2)) K X Q
 I $L(X)=4 S PSSX1=($E(X,2,3)) I PSSX1'?.N K X Q
 ;
 I $L(X)=3,$E(X,1)="Q",PSSX2="L",$E(X,2)'<7 K X Q
 I $G(PSSX1),$E(X,1)="Q",PSSX2="L",PSSX1'<7 K X Q
 I $G(PSSX1),$E(X,1)="Q",PSSX2="W",PSSX1'<29 K X Q
 ;
 I $E(X,1)="Q"&(PSSX2="H"!(PSSX2="D")!(PSSX2="W")!(PSSX2="L")) Q
 I $E(X,1)="X"&(PSSX2="D"!(PSSX2="W")!(PSSX2="L")) Q
 E  K X Q
 ;
HPDCHK ; help prompt with specified formats for the dosing check frequency fields **pss_1_201**
 N MSG,PSSHFLG S (MSG,PSSHFLG)=""
 ;
 I $G(X)="??" S PSSHFLG=1
 ;
 I 'PSSHFLG D  Q
 .S MSG(1)="     The numeric limit is 99, except for the following formats:"
 .S MSG(2)=""
 .S MSG(3)="     Q#W - Maximum 28 weeks allowed"
 .S MSG(4)="     Q#L - Maximum 6 months allowed"
 .S MSG(5)=""
 .S MSG(6)="     Enter '??' to view the available dosing check frequency formats"
 .S MSG(7)="     for this field."
 .S MSG(8)=""
 .D EN^DDIOL(.MSG,"","!")
 Q
 ;
OASCHK ; check the 'D' cross reference to see if duplicates exist **pss_1_201**
 N MSG,PSSCNT,PSSD,PSSFLG,PSSDA,PSSDONE,PSSAIEN S (MSG,PSSAIEN)="",(PSSCNT,PSSD,PSSFLG)=0,PSSDA=$G(DA),PSSDONE=$G(DA(1))
 ;
 I $G(X)="@" S PSSD=1,DIR(0)="YAO",DIR("A")="SURE YOU WANT TO DELETE? " D ^DIR
 I $G(Y)=1 F  S PSSCNT=$O(^PS(51.1,$G(DA),5,PSSCNT)) Q:PSSCNT=""!(PSSFLG=1)  D
 .I $G(^PS(51.1,$G(DA),5,PSSCNT,0))=$P(PSSRN,"//",1) S PSSFLG=1 S DIE=DIC,DA(1)=$G(DA),DA=PSSCNT,DR=".01///@" D ^DIE K DIR,X
 .S DA=PSSDA,DA(1)=PSSDONE,PSSRN=$$OASLE^PSSOAS(DA),DIC("A")="Select OLD SCHEDULE NAME(S): "_$G(PSSRN)
 I $G(PSSD)=1 K X Q
 I $L($G(X))>20!($L($G(X))<2) D EN^DDIOL("Answer must be 2-20 characters in length.","","!") K X Q
 ;
 S X=$$UP^XLFSTR($G(X))
 ;
 N PSSRCHK,PSSRFL,MSG S (PSSRCHK,PSSRFL)=""
 F  S PSSRCHK=$O(^PS(51.1,"D",PSSRCHK)) Q:PSSRCHK']""!($G(PSSRFL))  D
 .I PSSRCHK=$G(X) S PSSRFL=1 F  S PSSAIEN=$O(^PS(51.1,"D",PSSRCHK,PSSAIEN)) Q:PSSAIEN'=""
 I $G(PSSRFL)=1,$G(PSSAIEN)'=$G(PSSDA) K X D  Q
 .S MSG(1)=""
 .S MSG(2)="      Duplicate exists in Old Schedule Name multiple for the entry"
 .S MSG(3)="      "_$P(^PS(51.1,$G(PSSAIEN),0),U,1)_" ("_$G(PSSAIEN)_") in the file.  Please enter a new name."
 .D EN^DDIOL(.MSG,"","!")
 ;
 N PSSMCHK,PSSMFL S PSSMCHK="",PSSMFL=0
 I $G(Y)=-1,$G(DA) F  S PSSMCHK=$O(^PS(51.1,$G(DA),5,PSSMCHK)) Q:PSSMCHK']""!($G(PSSMFL))  D
 .I $G(^PS(51.1,$G(DA),5,PSSMCHK,0))=$G(X) S PSSMFL=1
 I $G(PSSMFL)=1 K X Q
 Q
 ;
ENDNV ; day of the week name
 N Z1,Z2,Z3,Z4,PSSDASH,PSSTIME,PSSXTIME,PSSTIMCT
 S X=$S($D(^PS(51.1,DA,0)):$P(^(0),"^"),1:"") I X="" K X Q
 ;
DNVX ; validate day of the week name
 S Z2=1,Z4="-" I X'["-",X?.E1P.E F Z1=1:1:$L(X) I $E(X,Z1)?1P S Z4=$E(X,Z1) Q
 F Z1=1:1:$L(X,Z4) Q:'Z2  S Z2=0 I $L($P(X,Z4,Z1))>1 F Z3="MONDAYS","TUESDAYS","WEDNESDAYS","THURSDAYS","FRIDAYS","SATURDAYS","SUNDAYS" I $P(Z3,$P(X,Z4,Z1))="" S Z2=1 Q
 I Z2=0 K X
 S PSSXTIME=$P(ZX,"@",2),PSSDASH=$L(PSSXTIME,"-")
 F PSSTIMCT=1:1:PSSDASH S PSSTIME=$P(PSSXTIME,"-",PSSTIMCT)
 I $L(PSSTIME)>4 K X
 I '$D(X) S PSSDOW=1
 S:Z2 X="D"
 Q
 ;
ENPSJ ;validate schedule names for PSJ package **pss_1_201**
 N A,B,I,PSSCNT,PSSFLG SET (PSSFLG,PSSDOW)=0
 ;
 S X=$$UP^XLFSTR(X)
 I $G(X)'="",+$G(Y) D OASCHK I $G(X)="" Q
 I $G(PSSON)'="",$G(X)'=$G(PSSON) D ENOAS(PSSON,X)
 ;
 I $G(PSJPP)'="PSJ" Q
 S A=$TR(X,".","") I A="OTHER" K X Q
 F I=1:1:$L(A," ") S B=$P(A," ",I) I B="QD"!(B="QOD")!(B="HS")!(B="TIW") K X ;;>> *149 RJS
 Q:'$D(X)
 S DOW=0,ZX=X S X=$P(X,"@") D DNVX I $G(X)="" S X=ZX K ZX
 I X="D" S X=ZX,DOW=1 D:X["@" CHKORD I $D(X),$G(PSSCNT)>1 D  S:'$D(X) X=ZX K Z1,Z2,Z3,Z4,ZX
 .N MSG
 .S MSG(1)="",MSG(2)="The day of the week schedule must be in the correct day of week order."
 .S MSG(3)="The correct order is: SU-MO-TU-WE-TH-FR-SA"
 .D EN^DDIOL(.MSG,"","!")
 .Q
 ;
ENOAS(PSSOLD,PSSX) ; entry for new OLD SCHEDULE NAME(S) into the multiple **pss_1_201**
 N PSSMCHK,PSSRCHK,PSSBCHK,PSSCCHK,PSSMFL,PSSRFL,PSSBFL,PSSNNM,PSSDA,MSG S (PSSRCHK,PSSBCHK,MSG)="",(PSSMCHK,PSSCCHK,PSSMFL,PSSRFL,PSSBFL)=0,PSSNNM=$$UP^XLFSTR($G(X)),PSSDA=$G(DA)
 N PSSCHK,PSSAIEN,PSSDFL S (PSSCHK,PSSAIEN)="",PSSDFL=0
 ;
 I $G(DA) F  S PSSMCHK=$O(^PS(51.1,$G(DA),5,PSSMCHK)) Q:'+PSSMCHK!($G(PSSMFL))  D
 .I $G(^PS(51.1,$G(DA),5,PSSMCHK,0))=$G(PSSX) S PSSMFL=1
 I $G(PSSMFL)=1 S X=$G(PSSOLD) D  Q
 .S MSG(1)=""
 .S MSG(2)="A duplicate exists in the OLD SCHEDULE NAME(S) multiple for this entry."
 .S MSG(3)=""
 .D EN^DDIOL(.MSG,"","!")
 ;
 I $G(X)'="" F  S PSSCHK=$O(^PS(51.1,"D",PSSCHK)) Q:PSSCHK=""!($G(PSSDFL))  D
 .I $G(PSSCHK)=$G(X) S PSSDFL=1 F  S PSSAIEN=$O(^PS(51.1,"D",PSSCHK,PSSAIEN)) Q:PSSAIEN'=""
 .I $G(PSSDFL)=1 S X=$G(PSSOLD) D  Q
 ..S MSG(1)=""
 ..S MSG(2)="A duplicate exists in the OLD SCHEDULE NAME(S) multiple for the entry"
 ..S MSG(3)=$P(^PS(51.1,$G(PSSAIEN),0),U,1)_" ("_$G(PSSAIEN)_")."
 ..S MSG(4)=""
 ..D EN^DDIOL(.MSG,"","!")
 ;
 I $G(X)["""" F  S PSSBCHK=$O(^PS(51.1,"B",PSSBCHK)) Q:PSSBCHK']""!($G(PSSBFL))  D
 .I $G(PSSBCHK)=$G(PSSOLD) S PSSBFL=1
 ;
 I $G(X)'["""" F  S PSSBCHK=$O(^PS(51.1,"B",PSSBCHK)) Q:PSSBCHK']""!($G(PSSBFL))  D
 .F  S PSSCCHK=$O(^PS(51.1,"B",PSSBCHK,PSSCCHK)) Q:PSSCCHK']""!($G(PSSBFL))  D
 ..I $G(PSSBCHK)=$G(PSSOLD),$G(PSSCCHK)'=$G(DA) S PSSBFL=1
 ;
 F  S PSSRCHK=$O(^PS(51.1,"D",PSSRCHK)) Q:PSSRCHK']""!($G(PSSRFL))  D
 .I $G(PSSRCHK)=$G(PSSOLD) S PSSRFL=1
 I '$G(PSSMFL),'$G(PSSRFL),'$G(PSSBFL),'$G(PSSDFL),$G(DA),$G(X)'="",$G(X)'?." " K DO S X=$G(PSSON),DA(1)=$G(DA),DIC=DIC_DA(1)_",5,",DIC(0)="L" D FILE^DICN S X=PSSNNM,DIC="^PS(51.1,"
 ;
 Q
 ;
SCRN ;LOGIC TO SCREEN OUT @ IF NOT DAILY
 S (PSSFLG,PSSDFLG,PSSTFLG,PSSAFLG)=0
 Q:X'["@"
 I $G(PSSCNT) K PSSCNT,X Q
 D DAYS,TIMECHK
 I $L(X)<2!($L(X)>20) D MSG1
 I $G(PSSAFLG) D MSG4
 I $G(PSSTFLG) D MSG3
 I $G(PSSDFLG) D MSG2
 I $G(PSSFLG) S MSG(4)="",MSG(5)="  "_X D EN^DDIOL(.MSG,"","!") K MSG
 K:$G(PSSFLG) X
 K PSSFLG,PSSDFLG,PSSTFLG,PSSAFLG
 Q
 ;
ENPSJT ; Validate schedule type (one-time PRN conflict)
 N A,B
 S A=$$GET1^DIQ(51.1,DA,.01),B=""
 I A["PRN",X'="P" D
 . S B="Conflict: Schedule Name contains PRN but selected Schedule Type is not PRN."
 . K X
 I A'["PRN",X="P" D
 . S B="Conflict: Schedule Name does not contain PRN but selected Schedule Type is PRN."
 . K X
 I $G(X)="D",$G(PSSDOW) D
 . S B="Conflict: Schedule Name contains free text but selected Schedule Type is Day of the Week."
 . K X
 I $L(B)>0 D EN^DDIOL(.B,"","!") Q
 S A=$$GET1^DIQ(51.1,DA,2),B=""
 Q
 ;
CHKORD ;Check order of days in DOW schedule name
 N I,J,L,N,P,W
 S N=$P(X,"@"),L=0,P=$L(N,"-"),W="SUNDAYS,MONDAYS,TUESDAYS,WEDNESDAYS,THURSDAYS,FRIDAYS,SATURDAYS",PSSCNT=0
 F I=1:1:P F J=1:1:7 I $P(W,",",J)=$P(N,"-",I) K:J'>L X Q:'$D(X)  S:J>L L=J,PSSCNT=PSSCNT+1
 Q
 ;
RMTIME ;Remove ward times when schedule becomes odd
 N R
 S R=0 F  S R=$O(^PS(51.1,D0,1,R)) Q:R=""  K ^PS(51.1,D0,1,R)
 Q
DAYS ; check days of week for correct order sequence
 N PSSD2,PSSD3,PSSD4,PSSD1,PSSD5,PSSD6,PSSFND
 S PSSD1=$P(X,"@"),PSSD4=0,PSSD5=$L(PSSD1,"-"),PSSD6="SU,MO,TU,WE,TH,FR,SA",PSSFND=0
 F PSSD2=1:1:PSSD5 Q:'$D(PSSD1)  D
 .F PSSD3=1:1:7 D  Q:'$D(PSSD1)
 ..I $P(PSSD6,",",PSSD3)=$P(PSSD1,"-",PSSD2) K:PSSD3'>PSSD4 PSSD1 Q:'$D(PSSD1)  S PSSFND=PSSFND+1 S:PSSD3>PSSD4 PSSD4=PSSD3
 ..I $L($P(PSSD1,"-",PSSD2))>2 K PSSD1
 .K:PSSFND'=PSSD2 PSSD1
 I ('$D(PSSD1)!('$D(PSSFND))) S PSSDFLG=1
 Q
MSG1 ; max length exceeded message
 S MSG(1)="",MSG(2)="The Administration Schedule you entered has "_$L(X)_" characters."
 S MSG(3)="Answer must be 2-20 characters in length."
 D EN^DDIOL(.MSG,"","!")
 S PSSFLG=1
 K MSG
 Q
MSG2 ; day of week order squence message
 S MSG(1)="",MSG(2)="The day of the week schedule must be in the correct day of week order."
 S MSG(3)="The correct order is: SU-MO-TU-WE-TH-FR-SA"
 D EN^DDIOL(.MSG,"","!")
 S PSSFLG=1
 K MSG
 Q
MSG3 ; time input message
 S MSG(1)="",MSG(2)="The time must be between 0001 - 2400."
 S MSG(3)="A correct time entry would be: 0800-1200-1600 etc."
 D EN^DDIOL(.MSG,"","!")
 S PSSFLG=1
 K MSG
 Q
MSG4 ; time sequence message
 S MSG(1)="",MSG(2)="The time must be entered in ascending order."
 S MSG(3)="A correct time entry would be: 0800-1200-1600 etc."
 D EN^DDIOL(.MSG,"","!")
 S PSSFLG=1
 K MSG
 Q
TIMECHK ; time validation
 N PSSXTIME,PSSTLN,PSSLOOP,PSSTCHR,PSSDASH,PSSLEN,PSSTCHK,PSSTIMCT,PSSTIME
 I $L(X,"@")>2 S (PSSDFLG,PSSTFLG)=1 Q
 S PSSXTIME=$P(X,"@",2),PSSTLN=$L(PSSXTIME),PSSTFLG=0,PSSDASH=$L(PSSXTIME,"-")
 I PSSXTIME=0 S PSSTFLG=1 Q
 F PSSTIMCT=1:1:PSSDASH S PSSTIME=$P(PSSXTIME,"-",PSSTIMCT) D
 .S PSSTCHK(PSSTIMCT)=PSSTIME,PSSLEN=$L(PSSTIME)
 .I $L(PSSTCHK(PSSTIMCT))=2 S PSSTCHK(PSSTIMCT)=PSSTCHK(PSSTIMCT)_"00"
 .F PSSLOOP=1:1:PSSLEN D
 ..S PSSTCHR=$E(PSSTIME,PSSLOOP)
 ..I $A(PSSTCHR)<48!($A(PSSTCHR)>57) S PSSTFLG=1
 .I ((PSSTIME<1)!(PSSLEN=1)!(PSSLEN=3)!(PSSLEN>4)) S PSSTFLG=1
 F PSSTIMCT=1:1:PSSDASH D
 .I $G(PSSTCHK(PSSTIMCT+1)),PSSTCHK(PSSTIMCT)>PSSTCHK(PSSTIMCT+1) S PSSAFLG=1
 .I $L(PSSTCHK(PSSTIMCT))=4 D
 ..I $E(PSSTCHK(PSSTIMCT),1,4)>2400 S PSSTFLG=1
 ..I $E(PSSTCHK(PSSTIMCT),1,2)<24 D
 ...I $E(PSSTCHK(PSSTIMCT),3,4)>59 S PSSTFLG=1
 Q
