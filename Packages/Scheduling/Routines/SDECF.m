SDECF ;ALB/SAT - VISTA SCHEDULING RPCS ;JAN 15, 2016
 ;;5.3;Scheduling;**627**;Aug 13, 1993;Build 249
 ;
 Q
 ;
MSG(DATA,PRE,POST) ;EP; -- writes line to device
 NEW I,FORMAT
 S FORMAT="" I $G(PRE)>0 F I=1:1:PRE S FORMAT=FORMAT_"!"
 D EN^DDIOL(DATA,"",FORMAT)
 I $G(POST)>0 F I=1:1:POST D EN^DDIOL("","","!")
 Q
 ;
ZIS(X,BDGRTN,BDGDESC,BDGVAR,BDGDEV,BDGCOP) ;EP
 ; -- called to select device and send print
 N ZTDESC,ZTDTH,ZTRTN,ZTSAVE
 K %ZIS,IOP,POP,ZTIO
 I X="F" D     ;forced queuing; no user interaction
 . S ZTIO=BDGDEV,ZTDTH=$H
 I X'="F" D  Q:'$D(IO("Q"))
 . S %ZIS=X
 . I $G(BDGDEV)]"" S %ZIS("B")=BDGDEV
 . D ^%ZIS
 . Q:POP
 . Q:$D(IO("Q"))
 . I $G(BDGCOP)>1 D  Q
 .. N J
 .. F J=1:1:BDGCOP D @BDGRTN
 . D @BDGRTN
 I $G(BDGCOP)>1 D  Q
 . N K
 . F K=1:1:BDGCOP D  ;changed from k to j
 .. K IO("Q") S ZTRTN=BDGRTN,ZTDESC=BDGDESC
 .. I $G(BDGDTH)]"" S ZTDTH=BDGDTH  ;if time is already put in then set to that
 .. F I=1:1 S J=$P(BDGVAR,";",I) Q:J=""  S ZTSAVE(J)=""
 .. D ^%ZTLOAD
 .. S BDGDTH=$G(ZTSK("D"))  ;set time equal to what they put in the first time
 .. K ZTSK
 . D ^%ZISC
 . K BDGDTH
 K IO("Q") S ZTRTN=BDGRTN,ZTDESC=BDGDESC
 F I=1:1 S J=$P(BDGVAR,";",I) Q:J=""  S ZTSAVE(J)=""
 D ^%ZTLOAD K ZTSK D ^%ZISC
 Q
 ;
READ(TYPE,PROMPT,DEFAULT,HELP,SCREEN,DIRA) ;EP; calls reader, returns response
 NEW DIR,Y,DIRUT,DLAYGO
 S DIR(0)=TYPE
 I $E(TYPE,1)="P",$P(TYPE,":",2)["L" S DLAYGO=+$P(TYPE,U,2)
 I $D(SCREEN) S DIR("S")=SCREEN
 I $G(PROMPT)]"" S DIR("A")=PROMPT
 I $G(DEFAULT)]"" S DIR("B")=DEFAULT
 I $D(HELP) S DIR("?")=HELP
 I $D(DIRA(1)) S Y=0 F  S Y=$O(DIRA(Y)) Q:Y=""  S DIR("A",Y)=DIRA(Y)
 D ^DIR
 Q Y
 ;
TIME(DATE) ;EP returns time in 12:00 PM format for date send
 Q $$UP^XLFSTR($E($$FMTE^XLFDT($E(DATE,1,12),"P"),14,21))
