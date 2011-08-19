YSAST ;ALB/ASF/692/DCL-ASI TIME FUNCTION ;7/30/96  11:20
 ;;5.01;MENTAL HEALTH;**24**;Dec 30, 1994
 ;CODE TAKEN FROM PRSATIM ROUTINE
 Q
X(X) Q:$G(X)="" ""
 N X1
 S X=$TR(X,"adimnop","ADIMNOP")
 I X?1"12".A S X=$S(X="12M":"MID",X="12N":"NOON",1:X)
 I X?1.A S X=$S(X["MID":2400,X["NOON":1200,1:"")
 S:$E(X,$L(X))="M" X=$E(X,1,$L(X)-1) S X1=$E(X,$L(X)) I X1?1U,"AP"'[X1 Q ""
 S X1=$P(X,":",2) I X1'="",X1'?2N1.2U Q ""
 I X'?4N,$S($L(+X)<3:+X,1:+X\100)>12 Q ""
 S X=$P(X,":",1)_$P(X,":",2),X1=X
 G:X?4N A I X'?1.4N1.2U Q ""
 S:X<13 X=X*100 I X1["A" Q:X>1259 "" S X=$S(X=1200:2400,X>1159:X-1200,1:X)
 E  I X<1200,X1["P"!(X<600) S X=X+1200 I X<1300 Q ""
A I X>2400!('X&(X'="0000"))!(X#100>59) Q ""
 S X1=+X I 'X1!(X1=1200)!(X1=2400) S X=$S(X1=1200:"NOON",1:"MID") Q X
 S X1=$S(X1>1259:X1-1200,1:X1),X1=$E("000",0,4-$L(X1))_X1_$S(X=2400:"A",X>1159:"P",1:"A")
 ;I "00^15^30^45"'[$E(X1,3,4) Q ""  ;NOT NEEDED FOR THIS PROJECT
 S X=$E(X1,1,2)_":"_$E(X1,3,5)
 Q X
 ;
DNE K X1 Q
ERR K X,X1 Q
 ;
CNV(X) ; Convert Start/Stop to minutes AFTER MIDNIGHT  RETURN startmin^stopmin
 ;PASS START^STOP 
 N CNX,Y
 ; X=start_"^"_stop  Output: Y=start(min)_"^"_stop(min)
 S CNX=X,X=$P(CNX,"^",1),Y=0,Y=$$MIL(X,Y),Y=Y\100*60+(Y#100),$P(CNX,"^",1)=Y
 S X=$P(CNX,"^",2),Y=1,Y=$$MIL(X,Y),Y=Y\100*60+(Y#100)
 S Y=$P(CNX,"^",1)_"^"_Y
 Q Y
 ;
MIL(X,Y) ; Convert from AM/PM to 2400
 ; X=time Y: 0=Mid=0,1=Mid=2400 Output: Y=time in 2400
 I X="MID"!(X="NOON") S Y=$S(X="NOON":1200,Y:2400,1:0) Q Y
 S Y=$P(X,":",1)_$P(X,":",2),Y=+Y Q:X["A" Y
 S:Y<1200 Y=Y+1200
 Q Y
 ;
DVAL051 ;
 N YSAS
 S YSAS=$$GET^DDSVAL(DIE,.DA,.052)
 Q:YSAS=""
 S YSAS=$$CNV(X_"^"_YSAS)
 Q:$P(YSAS,"^",2)'<$P(YSAS,"^")
 W $C(7)
 S DDSERROR=1
 D HLP^DDSUTL(YSASI1_" * * >> Time Begun cannot be after Time Ended << * *"_YSASI0)
 Q
 ;
DVAL052 ;
 N YSAS
 S YSAS=$$GET^DDSVAL(DIE,.DA,.051)
 Q:YSAS=""
 S YSAS=$$CNV(YSAS_"^"_X)
 Q:$P(YSAS,"^",2)'<$P(YSAS,"^")
 W $C(7)
 S DDSERROR=1
 D HLP^DDSUTL(YSASI1_" * * >> Time Ended cannot be before Time Begun << * *"_YSASI0)
 Q
 ;
 ;
HELP ; Time Help
 W !?5,"Time may be entered as 8A or 8a, 8:00A, 8:15A, 8:15AM or military"
 W !?5,"time: 0800, 1300; or MID or 12M for midnight; NOON or 12N for noon."
 W !?5,"Time must be in quarter hours; e.g., 8A or 8:15A or 8:30A or 8:45A.",!
 Q
HLP ;
 N YSAS
 S YSAS(1)="Time may be entered as 8A or 8a, 8:00A, 8:15A, 8:15AM or military"
 S YSAS(2)="time: 0800, 1300; or MID or 12M for midnight; NOON or 12N for noon."
 S YSAS(3)="Time must be in quarter hours; e.g., 8A or 8:15A or 8:30A or 8:45A."
 D HLP^DDSUTL(.YSAS)
 Q
