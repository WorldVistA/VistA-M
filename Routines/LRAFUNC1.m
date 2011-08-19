LRAFUNC1 ;SLC/MRH/FHS -  FUNCTION CALL  DATE/TIME  A5AFUNC1
 ;;5.2;LAB SERVICE;**201**;Sep 27, 1994
 ;
 N I,X
 W !!,"Routine: "_$T(+0),! F I=8:1 S X=$T(LRAFUNC1+I) Q:'$L(X)  I X[";;" W !,X
 W !!
 Q
 ;
DT() ;; $$VAR
 ;; Returns current Date in Fileman form
 ;; YYYMMDD
 ;; Eg.  S DT=$$DT^LRAFUNC1
 Q $$NOW\1
 ;;
LRODT0() ;; $$VAR
 ;; Returns current date in MM/DD/YY format
 ;; Eg. S LRODT0=$$LRODT0^LRAFUNC1
 N Y S Y=$$NOW\1
 Q $$FMTE^XLFDT(Y,"5D")
 ;;
NOW() ;; $$VAR 
 ;; Returns Date-Time in Fileman form
 ;; YYYMMDD.HHMMSS
 ;; Eg.  S X=$$NOW^LRAFUNC1
 Q $$CDHTFM($H)
 ;;
DOW(X) ;; 
 ;; Call by value
 ;; X is in $H or Fileman form
 ;; Returns string day of week
 ; Help from DIDTC
 N LRPER,LRPERD,LRPERH,LRPERM,LRPERT,LRPERY,X1
 I X'?7N.E S X1=X,X=$$CDHTFM(X)
 D COMP
 Q $P("SUN^MON^TUES^WEDNES^THURS^FRI^SATUR","^",LRPERY+1)_"DAY"
 ;;
CDHTFM(X1) ;; convert $H Date-Time to Fileman Date-Time form
 ;; Call by value
 ;; X = Date-Time in $H format NNNNN,NNNNN
 ;; Returns Date-Time in Fileman format YYYMMDD.HHMMSS
 ;; eg. S X=$$CDHTFM($H)
 ; help from DIDTC
 N X,LRPER,LRPERD,LRPERI,LRPERM,LRPERY
 S LRPER=X1>21608+X1-.1,LRPERY=LRPER\365.25+141,LRPER=LRPER#365.25\1
 S LRPERD=LRPER+306#(LRPERY#4=0+365)#153#61#31+1,LRPERM=LRPER-LRPERD\29+1
 S X=LRPERY_"00"+LRPERM_"00"+LRPERD
 S LRPERI(1)=LRPERM,LRPERI(2)=LRPERD,LRPERI(3)=LRPERY
 S LRPER=$P(X1,",",2)
 S LRPER=LRPER#60/100+(LRPER#3600\60)/100+(LRPER\3600)/100
 S LRPER=X_$S(LRPER:LRPER,1:"")
 Q LRPER
 ;;
CFMTDH(X) ;; converts Fileman Date-Time to $H Date-time
 ;; Call by value
 ;; D = Date-Time in Fileman form  YYYMMDD.HHMMSS
 ;; Returns Date-Time in $H form  NNNNN,NNNNN
 ;; eg.  S X=$$CFMTDH(2901225.1234)
 ; Help from DIDTC
 N LRPER,LRPERD,LRPERH,LRPERM,LRPERT,LRPERY
 I X<1410000 Q 0
 D COMP
 I LRPERT>86400 S LRPERT=LRPERT-86400,D1=1
 S LRPERH=LRPERH+$G(D1)
 Q LRPERH_","_LRPERT
 ;;
DDDATE(Y1,Y2) ;; 
 ;; $$DDDATE(Y1,Y2)
 ;; Call by value
 ;; Y1 Date-Time in Fileman Format
 ;; Returns External form of Date-Time MMM DD,YYYY (@HH:MM:SS) depending
 ;; on the value of Y2
 ;; if Y1 is NOT passed $$NOW^LRAFUNC1 will be used for the date
 ;; if Y2=0 no time will return
 ;; if Y2=1 time will be returned in hours and minutes
 ;; if Y2=2 time will be returned in hours, minutes and seconds
 ;  with help from DD^DIDT
 N Y
 I '$G(Y1) S Y1=$$NOW
 S Y=$S($E(Y1,4,5):$P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC","^",+$E(Y1,4,5))_" ",1:"")_$S($E(Y1,6,7):+$E(Y1,6,7)_",",1:"")_($E(Y1,1,3)+1700) Q:'$G(Y2) Y
 S Y=Y_$P("@"_$E(Y1_0,9,10)_":"_$E(Y1_"000",11,12),"^",Y1[".") Q:$G(Y2)'>1 Y
 S Y=Y_$S($E(Y1,13,14):":"_$E(Y1_0,13,14),1:"")
 Q Y
 ;;
ADDDATE(D,D1,H,M,S) ;; Adds Days, hours minutes seconds to D
 ;; D date in Fileman format to which is to be added
 ;; D1 Days * optional *
 ;; H Hours * optional *
 ;; M Minutes * optional *
 ;; S Seconds * optional *
 ;; Returns DATE in fileman Format
 ;; eg. S X=$$ADDDATE(DT,0,12) would add 12 hours to the value of DT
 ;N LRPER,LRPERD,LRPERH,LRPERM,LRPERT,LRPERY,X,LRPERA
 I '$G(D) Q 0
 S D1=+$G(D1),H=+$G(H),M=+$G(M),S=+$G(S)
 S LRPERH=$$CFMTDH(D),LRPERT=$P(LRPERH,",",2),LRPERH=$P(LRPERH,",")
 S LRPERH=LRPERH+D1,LRPERT=(LRPERT+(H*3600)+(M*60)+S)
 S A=LRPERT\86400
 S:A LRPERH=LRPERH+A,LRPERT=(LRPERT-(86400*A))
 Q $$CDHTFM(LRPERH_","_LRPERT)
 ;;
DTC(X1,X2,X3) ;;   Date-Time Compare 
 ;; Call by value
 ;; X1 and X2 the dates for comparison
 ;; X3 = 0 returns difference in whole days eg. 1
 ;; X3 = 1 return difference in days and hours eg. 1.01 or 1.14
 ;; X3 = 2 returns difference in days, hours and minutes 1.0103 or 1.1423
 ;; X3 = 3 returns difference in days, hours, minutes and seconds
 ;;      1.010234 or 1.142322
 ; Help from DIDTC
 N LRPERD,LRPERH,LRPERM,LRPERY,X12,X22,X
 I '$G(X1)!'$G(X2) Q ""
 S X=X1,X(1)=$P(X1,".",2) D COMP S X1=LRPERH,X12=LRPER
 S X=X2,X(1)=$P(X2,".",2) D COMP S X22=LRPER
 S X=X1-LRPERH
 I $G(X3) D
 . S LRPER=X12-X22,LRPER=LRPER#60/100+(LRPER#3600\60)/100+(LRPER\3600)/100
 . S LRPER=$E(LRPER,1,$S(X3=1:3,X3=2:5,1:7))
 . S X=X_LRPER
 Q X
 ;
COMP ;
 I X<1410000 S LRPERH=0,LRPERY=-1 Q
 S LRPERY=$E(X,1,3),LRPERM=$E(X,4,5),LRPERD=$E(X,6,7)
 S LRPERT=$E(X_0,9,10)*60+$E(X_"000",11,12)*60+$E(X_"00000",13,14)
 S LRPERH=LRPERM>2&'(LRPERY#4)+$P("^31^59^90^120^151^181^212^243^273^304^334","^",LRPERM)+LRPERD
 S LRPER='LRPERM!'LRPERD,LRPERY=LRPERY-141,LRPERH=LRPERH+(LRPERY*365)+(LRPERY\4)-(LRPERY>59)+LRPER,LRPERY=$S(LRPER:-1,1:LRPERH+4#7)
 I $G(X(1)) D
 . S LRPER=$E(X(1)_"0",1,2)*60+$E(X(1)_"000",3,4)*60+$E(X(1)_"00000",5,6)
 Q
DTF(Y1) ;; Convert Fileman Date format to mmm dd yyyy:hhmm.ss
 N Y
 S Y=$S($E(Y1,4,5):$P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC","^",+$E(Y1,4,5))_" ",1:"")_$S($E(Y1,6,7):+$E(Y1,6,7)_",",1:"")_($E(Y1,1,3)+1700)
 S Y=Y_$P("@"_$E(Y1_0,9,10)_":"_$E(Y1_"000",11,12),"^",Y1[".")
 S Y=Y_$S($E(Y1,13,14):":"_$E(Y1_0,13,14),1:"")
 Q Y
 ;
