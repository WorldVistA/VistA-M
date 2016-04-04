DDBR3 ;SFISC/DCL-SELECT FILE & WP FIELD TO BROWSE ;NOV 04, 1996@13:48
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
LIST(DDBLIST) ;DDBLIST=Target array for file number,ien,field,...
 S DDBLIST=-1  ;no selection
EN ;
 N %,%H,%ZISOS,A,D,D0,D1,DA,DDBB,DDBDDF,DDBDIC,DDBFRCD,DDBIEN,DDBRCR,DDBX,DIC,DICS,DIW,DIWF,DIWL,DIWR,DIWT,DK,DL,DN,DX,I,POP,S,X,Y
 ;S DIC=1,DIC(0)="AEMQ" D ^DIC Q:+Y'>0  ;Select file
 D ^DICRW Q:Y'>0
 S DIC="^DD("_+Y_",",DIC(0)="AEMQ"
M S DIC("W")="I $P(^(0),U,2) W $S($P(^DD(+$P(^(0),U,2),.01,0),U,2)[""W"":""  (word-processing)"",1:""  (multiple)"")"
 S DIC("S")="I $P(^(0),U,2)"
 D ^DIC I +Y'>0,$D(@(DIC_"0,""UP"")")) S DIC="^DD("_+^("UP")_"," G M ;Select field/back out of multiples
 Q:+Y'>0
 I $P(@(DIC_+Y_",0)"),U,2) S DIC="^DD("_+$P(^(0),U,2)_",",Y=.01 G D:$P(^DD(+$P(^(0),U,2),.01,0),U,2)["W",M
D ;
 K DIC("S")
 S DDBDIC=$$UP^DIQGU(+$P(DIC,"^DD(",2),.DDBDIC),(DDBX,DDBIEN)=""
 S DDBFRCD=$$GET^DIQGDD(DDBDIC,"","NAME")_":[",DDBB=0
 F  S DDBX=$O(DDBDIC(DDBX)) Q:DDBX'<0  D  Q:$G(Y)'>0
 .K DA D IEN(","_DDBIEN,.DA)
 .S DIC=$$ROOT^DIQGU(+DDBDIC(DDBX),","_DDBIEN),DIC(0)="AEMQ" Q:DIC']""
 .S DDBRCR=$$CREF^DILF(DIC)
 .I $P($G(@DDBRCR@(0)),U,4)'>0 D  K DDBIEN Q
 ..W $C(7),!!,"No Records at "_$S(DDBDIC=+DDBDIC(DDBX):"FILE",1:$P(^DD(+DDBDIC(DDBX),.01,0),U))_" Level.",!
 ..Q
 .D ^DIC I Y'>0 K DDBIEN Q
 .S DDBIEN=+Y_","_DDBIEN
 .S DDBFRCD=DDBFRCD_$S(DDBB:"\",1:"")_$$GET^DIQG(+DDBDIC(DDBX),DDBIEN,.01),DDBB=1
 .K DA D IEN(DDBIEN,.DA)
 .Q
DISP ;
 S DDBDDF=$O(^DD(+DDBDIC(-1),"SB",+DDBDIC(0),"")) Q:'DDBDDF
 S DDBFRCD=DDBFRCD_"] (wp): "_$P(^DD(DDBDIC(0),.01,0),"^")
 I $D(DDBIEN) D  Q
 .N DDBX S DDBX=$P($$GET^DIQG(+DDBDIC(-1),DDBIEN,DDBDDF,"B"),"$CREF$",2)
 .S DDBLIST=$D(@DDBX)
 .S DDBLIST(1)=+DDBDIC(-1)
 .S DDBLIST(2)=DDBIEN
 .S DDBLIST(3)=DDBDDF
 .S DDBLIST(4)="N"
 .S DDBLIST(5)=DDBFRCD
 .S DDBLIST(6)=DDBX
 .Q
 Q
IEN(IEN,DA) S DA=$P(IEN,",") N I F I=2:1 Q:$P(IEN,",",I)=""  S DA(I-1)=$P(IEN,",",I)
 Q
