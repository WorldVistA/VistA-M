PRCB1A2 ;WISC/PLT-FCP ACTIVATE/DEACTIVATE ; 01/11/94  10:40 AM
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 QUIT  ;invalid entry
 ;
REA ;reactivate an inactive fund control point
 N PRCDD,PRCDR,PRCDI,PRCRI,PRCPR,PRCAED,PRCQT,PRCU,A,B,X,Y S PRCU="^"
 N PRCFA S PRCFA("REACTIVATE")=""
 S PRCF("X")="AS" D ^PRCFSITE G:'% EXIT1
 S PRCDD=420,PRCRI(420)=PRC("SITE")
 I '$O(^PRC(420,PRCRI(420),1,"B","")) D EN^DDIOL("No Control Point in file!") G EXIT1
 S PRCLOCK=$$DICGL^PRC0B1(PRCDD)_PRCRI(PRCDD)_",",Y=3 D ICLOCK^PRC0B(PRCLOCK,.Y)
 I 'Y D EN^DDIOL("File is in use, please try later!") G EXIT1
 F  D EN^DDIOL(" ") D  Q:PRCQT=1
 . N PRCDD,PRCAED,PRCDI
 . S PRCDD=420.01,PRCQT=""
 . S X(0)="AENOQS",X("S")="I X-9999,$P(^(0),U,19)=1"
 . D LKUP^PRCB1A Q:PRCQT
 . D EDIT1
 . QUIT
 D DCLOCK^PRC0B(PRCLOCK)
EXIT1 QUIT
 ;
EDIT1 ;edit inactive/active
 D EDIT^PRC0B(.X,PRCDI,"20Active/Inactive Control Point","") I X=0 S PRCQT=2
 K A D PIECE^PRC0B(PRCDI,20,"I","A")
 S X=$G(A(PRCDD,PRCRI(PRCDD),"1~20","I")) K A
 S X=$S(X=1:"23////^S X=DUZ;24///NOW",1:"23///^S X=""@"";24///^S X=""@""")
 D EDIT^PRC0B(.X,PRCDI,X)
 QUIT
 ;
DEA ;deactivate an active fund control point
 N PRCDD,PRCDR,PRCDI,PRCRI,PRCPR,PRCAED,PRCQT,PRCU,A,B,X,Y S PRCU="^"
 K PRCFA S PRCF("X")="AS" D ^PRCFSITE G:'% EXIT2
 S PRCDD=420,PRCRI(420)=PRC("SITE")
 I '$O(^PRC(420,PRCRI(420),1,"B","")) D EN^DDIOL("No Control Point in file!") G EXIT2
 S PRCLOCK=$$DICGL^PRC0B1(PRCDD)_PRCRI(PRCDD)_",",Y=3 D ICLOCK^PRC0B(PRCLOCK,.Y)
 I 'Y D EN^DDIOL("File is in use, please try later!") G EXIT2
 F  D EN^DDIOL(" ") D  Q:PRCQT=1
 . N PRCDD,PRCAED,PRCDI
 . S PRCDD=420.01,PRCQT=""
 . S X(0)="AENOQS",X("S")="I X-9999,$P(^(0),U,19)'=1"
 . D LKUP^PRCB1A Q:PRCQT
 . D EDIT2
 . QUIT
 D DCLOCK^PRC0B(PRCLOCK)
EXIT2 QUIT
 ;
EDIT2 ;edit active/inactive
 D EDIT^PRC0B(.X,PRCDI,"20Active/Inactive Control Point","") I X=1 S PRCQT=2
 K A D PIECE^PRC0B(PRCDI,"1~20","I","A")
 S X=$G(A(PRCDD,PRCRI(PRCDD),20,"I")) K A
 S X=$S(X=1:"23////^S X=DUZ;24///NOW",1:"23///^S X=""@"";24///^S X=""@""")
 D EDIT^PRC0B(.X,PRCDI,X)
 QUIT
 ;
