FSCTIME ;SLC/STAFF-NOIS Time Conversion ;1/11/98  18:53
 ;;1.1;NOIS;;Sep 06, 1998
TIME(X) ; from dd7103, dd7103.1, dd7103.2, dd7105.2
 ; format X else kill it
 N OK,X1
 I X?1"12".A S X=$S(X="12M":"MID",X="12N":"NOON",1:X)
 I X?1.A S X=$S(X["MID":2400,X["NOON":1200,1:"")
 I $E(X,$L(X))="M" S X=$E(X,1,$L(X)-1)
 S X1=$E(X,$L(X)) I X1?1U,"AP"'[X1 K X Q
 S X1=$P(X,":",2)
 I X1'="",X1'?2N1.2U K X Q
 I X'?4N,$S($L(+X)<3:+X,1:+X\100)>12 K X Q
 S X=$P(X,":",1)_$P(X,":",2),X1=X
 I X'?4N S OK=1 D  I 'OK K X Q
 .I X'?1.4N1.2U S OK=0
 .S:X<13 X=X*100 I X1["A" S:X>1259 OK=0 Q:'OK  S X=$S(X=1200:2400,X>1159:X-1200,1:X)
 .I X1'["A",X<1200,X1["P"!(X<600) S X=X+1200 I X<1300 S OK=0
 I X>2400!('X&(X'="0000"))!(X#100>59) K X Q
 S X1=+X I 'X1!(X1=1200)!(X1=2400) S X=$S(X1=1200:"NOON",1:"MID") Q
 S X1=$S(X1>1259:X1-1200,1:X1),X1=$E("000",0,4-$L(X1))_X1_$S(X=2400:"A",X>1159:"P",1:"A")
 I "00^15^30^45"'[$E(X1,3,4) K X Q
 S X=$E(X1,1,2)_":"_$E(X1,3,5)
 Q
 ;
CNV ; Convert Start/Stop to minutes
 ; X=start_"^"_stop  Output: Y=start(min)_"^"_stop(min)
 S CNX=X,X=$P(CNX,"^",1),Y=0 D MIL S Y=Y\100*60+(Y#100),$P(CNX,"^",1)=Y
 S X=$P(CNX,"^",2),Y=1 D MIL S Y=Y\100*60+(Y#100)
 S Y=$P(CNX,"^",1)_"^"_Y K CNX Q
 ;
MIL(X) ; $$(AM/PM time) -> military time
 ; X=time Y: 0=Mid=0,1=Mid=2400 Output: Y=time in 2400
 N Y
 I X="NOON" Q "1200"
 I X="MID" Q "2400"
 S Y=$P(X,":",1)_$P(X,":",2),Y=+Y
 I X["A" Q Y
 I Y<1200 S Y=Y+1200
 Q Y
 ;
CONVERT(TIME,FROMZONE,TOZONE) ; $$(time,from timezone,to timezone) -> time
 N TOFFSET,FOFFSET,DIFF
 I '$L(TIME)!('$L(FROMZONE))!('$L(TOZONE)) Q TIME
 S TOFFSET=$P($G(^FSC("TIMEZONE",+$O(^FSC("TIMEZONE","B",TOZONE,0)),0)),U,2)
 S FOFFSET=$P($G(^FSC("TIMEZONE",+$O(^FSC("TIMEZONE","B",FROMZONE,0)),0)),U,2)
 I 'TOFFSET Q TIME
 I 'FOFFSET Q TIME
 S DIFF=FOFFSET-TOFFSET
 S TIME=TIME-(DIFF*100)
 I $L(TIME)=3 S TIME="0"_TIME
 Q TIME
 ;
HLP ; Time Help
 W !?5,"Time may be entered as 8A or 8a, 8:00A, 8:15A, 8:15AM or military"
 W !?5,"time: 0800, 1300; or MID or 12M for midnight; NOON or 12N for noon."
 W !?5,"Time must be in quarter hours; e.g., 8A or 8:15A or 8:30A or 8:45A.",!
 Q
