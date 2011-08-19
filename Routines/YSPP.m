YSPP ;ALB/ASF-INQUIRY PATIENT ;3/27/90  14:48 ;07/30/93 13:05
 ;;5.01;MENTAL HEALTH;;Dec 30, 1994
 S YSFHDR="Identifying Data <<section 1>>" D ENHD^YSFORM S:'$D(DA)&($D(YSDFN)) DA=YSDFN,DFN=YSDFN D DEM^VADPT,PID^VADPT
ENCN ;
 F I=0,.11,.111,.13,.21,.211,.24,.15,.3,.311,.31,.321,.32,.33,.331,.34,.362,.36,.52,1010.15 S A(I)="" S:$D(^DPT(DA,I))#10 A(I)=^(I)
 I $G(YSDFN)'>0 S YSDFN=+DA
 ;
ENCE ; Called indirectly from YSCEN31
 ;
 I $P(A(.15),U,2)?7N W !?20,"PATIENT LISTED AS INELIGIBLE",$C(7,7)
 W:$P(A(0),U,10)]"" !,"REMARKS: ",$P(A(0),U,10)
 W !?7,"ALIAS: " S I=0 F  S I=$O(^DPT(DA,.01,I)) Q:'I  W:$X>40 ! W ?15,$P(^(I,0),U),?40,"SSN: ",VA("PID")
 W !!,"",?9,"SEX: ",$P(VADM(5),U,2),?40,"ADDRESS: " S X=.11,X1=1,X2=1 D MOVE W S(1)
 W !,"MARITAL STAT: ",$P(VADM(10),U,2) W:$D(S("CC",.11)) ?39,S("CC",.11) W ?49,S(2)
 W !,"    RELIGION: ",$P(VADM(9),U,2),?49,S(3)
 W !?9,"POB: ",$P(A(0),U,11),$S($D(^DIC(5,+$P(A(0),U,12),0)):", "_$P(^(0),U,2),1:""),?49,$$ZIP4(+YSDFN,1,S(4)) S X=.111,X1=1,X2=1 D MOVE
LEG ;
 W !?3,"LEGAL ADD: ",S(1),?40,"PHONE 1: ",$P(A(.13),U),! W:$D(S("CC",.111)) ?4,S("CC",.111) W ?15,S(2),?40,"PHONE 2: ",$P(A(.13),U,2)
 W !?15,S(3),?40,"PHONE 3: ",$P(A(.13),U,3),!?15,S(4) W:$P(A(.13),U,4)]"" ?40,"PHONE 4: ",$P(A(.13),U,4)
EMER ;
 W !?3,"EMER CONT: ",$P(A(.33),U),?40,"E2-CONT: ",$P(A(.331),U) S X=.33,X1=1,X2=3 D MOVE S X=.331,X1=5,X2=3 D MOVE
 W !,"    RELATION: ",$P(A(.33),U,2),?39,"RELATION: ",$P(A(.331),U,2)
 W !?14,S(1),?49,S(5),!?14,$$ZIP4(+YSDFN,4,S(2)),?49,$$ZIP4(+YSDFN,5,S(6)),!?14,S(3),?49,S(7),!?14,S(4),?49,S(8)
 W !?7,"PHONE: ",$P(A(.33),U,9),?42,"PHONE: ",$P(A(.331),U,9)
 K YSCC,YSST Q:$D(YSNOFORM)  D WAIT1^YSUTL:'YST,ENFT^YSFORM:YST Q
MOVE ;
 S S(X1)=$P(A(X),U,X2),S(X1+1)=$P(A(X),U,X2+1),S(X1+2)=$P(A(X),U,X2+2),S(X1+3)=$P(A(X),U,X2+3)_$S($D(^DIC(5,+$P(A(X),U,X2+4),0)):", "_$P(^(0),U,2),1:"")_"  "_$P(A(X),U,X2+5)
 S:S(X1+2)="" S(X1+2)=S(X1+3),S(X1+3)="" S:S(X1+1)="" S(X1+1)=S(X1+2),S(X1+2)=S(X1+3),S(X1+3)="" S:S(X1)="" S(X1)=S(X1+1),S(X1+1)=S(X1+2),S(X1+2)=S(X1+3),S(X1+3)=""
 I X=.11!(X=.111) S YSCC=+$P(A(X),U,7) I YSCC>0 S YSST=+$P(A(X),U,5) I YSST>0,$D(^DIC(5,YSST,1,YSCC,0)) S S("YSCC",X)=" YSCC: "_$P(^(0),U,3) K YSCC,YSST
 Q
 ;
ZIP4(YSDFN,TYPE,OTHTXT) ;  Returns the ZIP+4 data for the TYPE zip specified
 N NODE,PIECE,YSI
 ;  TYPE:
 ;  1=ZIP CODE, 2=K2-ZIP CODE, 3=EMPLOYER ZIP CODE,
 ;  4=E-ZIP CODE, 5=E2-ZIP CODE, 6=D-ZIP CODE,
 ;  7=K-ZC, 8=TEMPORARY ZIP CODE, 9=ZC or TEMP (if current)
 ;
 ;  Other Text.. (At times "ARLINGTON, TX ZIP" will be passed)
 ;  If so, strip off Zip Code... print remainder (Ie., ARLINGTON, TX part ...
 ;  Let other code find and print proper zip code
 I $G(OTHTXT)]"" D
 .  F YSI=$L(OTHTXT):-1 QUIT:$E(OTHTXT,YSI)'?1N
 .  S OTHTXT=$E(OTHTXT,1,YSI)
 .  W OTHTXT," "
 K OTHTXT
 ;
 I $G(YSDFN)'>0!($G(TYPE)'?1N&(+$G(TYPE)>0)) QUIT "" ;->
 ;
 ;  If TYPE=9 the Temporary zip code should be printed if it exists...
 ;  (This is TYPE 8)
 ;  If not, the Zip Code (TYPE 1) should be printed...
 I +TYPE=9 D
 .  S TYPE=1 ;Assume Temporary address not existent...  Reset later if is.
 .  S X=$G(^DPT(+YSDFN,.121)) ;Watch it! Using X on following lines...
 .  S X("SD")=$P(X,U,7),X("ED")=$P(X,U,8)
 .  I X("SD")<(DT+1)&(X("ED")>DT) S TYPE=8
 ;
 ;  Set Old node and piece variables
 S NODE("O")=$P(".11^.211^.311^.33^.331^.34^.21^.121",U,+TYPE)
 S PIECE("O")=$P("6^8^8^8^8^8^8^6",U,+TYPE)
 ;
 ;  Set New node and piece variables
 S NODE("N")=$P(".11^.22^.22^.22^.22^.22^.22^.121",U,+TYPE)
 S PIECE("N")=$P("12^3^5^1^4^2^7^12",U,+TYPE)
 ;
 ;  Get NEW ZIP+4 and use it...
 S X=$P($G(^DPT(+YSDFN,+NODE("N"))),U,+PIECE("N"))
 ;
 ;  If NEW ZIP+$ not there, use old ZIP...
 I X']"" S X=$P($G(^DPT(+YSDFN,+NODE("O"))),U,+PIECE("O"))
 QUIT X
 ;
