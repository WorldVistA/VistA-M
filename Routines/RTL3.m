RTL3 ;JSM/TROY ISC;Label Print Fields Utility; ; 1/30/87  10:09 AM ;
 ;;v 2.0;Record Tracking;;10/22/91 
 ;Called from the Mumps Code To Set Variable field of 194.5
 ;expects: RT0 = entity record#;entity global name^...
 ;         RTJ = label print field internal # in 194.5
 ;looks at parent file multiple in 194.5 to get global;piece
 ;outputs: @RTVARNAM = print field value
 S RTVP=$P(RT0,"^") G VAR
EN ;enter here for BORROWER variable pointer fields with RTQ as zeroth node
 ;of request file (190.1)
 S RTVP=$P(RTQ,"^",5)
VAR S RTVARNAM=$P(^DIC(194.5,RTJ,0),U,5) G Q:RTVARNAM'?1"RTV("1N.N1")" S @RTVARNAM="Unknown"
 S RTG=$P(RTVP,";",2),RTDA=+RTVP G Q:RTG']""
 I @("$D(^"_RTG_"0))#10") S RTFN=+$P(^(0),"^",2) G Q:'$D(^DIC(194.5,RTJ,50,RTFN)) S RTGP=$P(^(RTFN,0),"^",3),RTGP1=$P(RTGP,";"),RTGP2=$P(RTGP,";",2)
 G Q:$S('$D(RTFN):1,'$D(RTGP1):1,'$D(RTGP2):1,RTGP1']"":1,RTGP2']"":1,1:0)
 S RTGP1=""""_RTGP1_"""" I @("'$D(^"_RTG_RTDA_","_RTGP1_"))#10") Q
 S Y=@("^"_RTG_RTDA_","_RTGP1_")"),Y=$S(+RTGP2:$P(Y,"^",RTGP2),1:$E(Y,$E($P(RTGP2,",",1),2,99),$P(RTGP2,",",2))),C=$P(^DD(RTFN,+$P(^DIC(194.5,RTJ,50,RTFN,0),"^",2),0),"^",2) D Y^DIQ S @RTVARNAM=Y
Q K Y,C,RTVP,RTGP1,RTGP2,RTGP,RTG,RTDA,RTFN,RTVARNAM Q
