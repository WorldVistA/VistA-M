DIFROMSS ;SCISC/DCL-DIFROM SERVER/DATA SORT LIST/SB-DD/HDR2P ;6/2/96  18:55
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 Q
SEL(DIFRFILE,DIFRX) ;Extrinsic function to return resolved value for
 ;freetext pointer
 ;FILE,X-VALUE
 N D,DIC,DIE,DIX,DIY,DO,DS,X,Y
 N %,%K,%Y,DA,D0,D1,D2,D3
 S DIC="^DIBT(",DIC(0)="QEMZ",X=DIFRX
 S DIC("S")="I $P(^(0),U,4)=DIFRFILE,$D(^(1))>9"
 D ^DIC
 Q:Y'>0 ""
 Q Y(0,0)
 ;
HELP(DIFRFILE) ;
 N D,DIC,DIE,DIX,DIY,DO,DS,X,Y
 N %,%K,%Y,DA,D0,D1,D2,D3
 S DIC="^DIBT(",DIC(0)="M",DIC("S")="I $P(^(0),U,4)=DIFRFILE,$D(^(1))>9",X="??"
 D ^DIC
 Q
 ;
SB(DIFRDD,DIFRFLG,DIFRTA,DIFRVAL) ;Returns a list of sub-DDs for any DD#
 ;DD#,FLAGS,TARGET ARRAY(by value)
 ;DD/SUB DD NUMBER (required)
 ;FLAGS "W"=Include Word-processing fields (optional)
 ;TARGET ARRAY (required)
 ;DIFRVAL - SET TARGET ARRAY EQUAL TO
 N DIFRSDD,DIFRSSDD,DIFRNW
 S DIFRSDD=0,DIFRNW=$G(DIFRFLG)'["W",DIFRVAL=$G(DIFRVAL)
 F  S DIFRSDD=$O(^DD(DIFRDD,"SB",DIFRSDD)) Q:DIFRSDD'>0  D
 .S DIFRSSDD=0
 .I DIFRNW,$P($G(^DD(DIFRSDD,.01,0)),"^",2)["W" Q
 .S @DIFRTA@(DIFRSDD)=DIFRVAL,DIFRSSDD=$O(^DD(DIFRSDD,"SB",0))
 .I DIFRSSDD D SB(DIFRSDD,$G(DIFRFLG),DIFRTA,DIFRVAL)
 .Q
 Q
 ;
HDR2P(DIFRDD) ;Header Node/2nd piece update
 Q:$G(DIFRDD)'>0 ""
 Q:'$D(^DIC(+DIFRDD,0,"GL")) "" S DIFRDD=$TR(DIFRDD_$P($P(@(^("GL")_"0)"),"^",2),+DIFRDD,2),"DPSVIs")
 N DIFRDDT
 I $D(^DD(+DIFRDD,0,"ID")) S DIFRDD=DIFRDD_"I"
 I $D(^DD(+DIFRDD,0,"SCR")) S DIFRDD=DIFRDD_"s"
 F DIFRDDT="D","P","S","V" I $P(^DD(+DIFRDD,.01,0),"^",2)[DIFRDDT S DIFRDD=DIFRDD_DIFRDDT Q
 Q DIFRDD
 ;
EXAM(TA) ;Examine what's in 2nd piece of data Header and put into array sub
 ;TA=Target Array
 Q:$G(TA)']""
 N FN,GR,P2
 S FN=0
 F  S FN=$O(^DIC(FN)) Q:FN'>0  I $D(^DIC(FN,0,"GL")) S GR=^("GL") D
 .Q:'$D(@(GR_"0)"))  S P2=$P(^(0),"^",2),P2=$P(P2,+P2,2)
 .S:P2]"" @TA@(P2)=FN
 .Q
 Q
 ;
VAL(DIFRFILE,DIFRIEN) ;Validate Edit and Print Template's and also Forms
 S DIFRFILE=$G(DIFRFILE),DIFRIEN=$G(DIFRIEN)
 Q:DIFRIEN'>0 0
 N ROOT,PIECE,FILE
 D
 .N X
 .S X=DIFRFILE
 .I X=.4!(X=.402)!(X=.403)!(X=.404) Q
 .S DIFRFILE=0
 .Q
 Q:DIFRFILE'>0 0
 S ROOT="^"_$P($P(".4;DIPT^.402;DIE^.403;DIST(.403)^.404;DIST(.404)",DIFRFILE_";",2),"^")
 S PIECE=$P($P(".4;4^.402;4^.403;8^.404;2",DIFRFILE_";",2),"^")
 Q:'$D(@ROOT@(DIFRIEN,0)) 0
 S FILE=$P(^(0),"^",PIECE)
 I DIFRFILE=.404&('FILE) Q 1
 Q:FILE'>0 0
 I DIFRFILE=.403 N BLOCK D  Q:'BLOCK 0
 .N PAGE,BLOCKP
 .S PAGE=0,BLOCK=1
 .F  S PAGE=$O(@ROOT@(DIFRIEN,40,PAGE)) Q:PAGE'>0  S BLOCKP=$P($G(^(PAGE,0)),"^",2) S:BLOCKP BLOCK=$$VAL(.404,BLOCKP) Q:'BLOCK  D  Q:'BLOCK
 ..N M40
 ..S M40=0
 ..F  S M40=$O(@ROOT@(DIFRIEN,40,PAGE,40,M40)) Q:M40'>0  S BLOCK=$$VAL(.404,M40) Q:'BLOCK
 ..Q
 .Q
 I DIFRFILE=.4,$P(@ROOT@(DIFRIEN,0),"^",8) Q 0
 Q $D(^DD(FILE,0))#2
