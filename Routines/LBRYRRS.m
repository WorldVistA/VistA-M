LBRYRRS ;ISC2/DJM-LIBRARY REPRINT ROUTING SLIPS ;[ 05/23/97  12:13 PM ]
 ;;2.5;Library;**2**;Mar 11, 1996
 I $G(LBRYPTR)="" D  I $G(LBRYPTR)="" W !!,$C(7),"No Site has been selected" Q
 . D ^LBRYASK
START W @IOF,?5,"VA Library Serials Reprint Routing Slips"
 S Y=DT X ^DD("DD") W ?60,Y,!
 W !!,"Start reprinting routing slips FROM date and time.",!
 S %DT="AETX" D ^%DT G:Y<0 FINI S FROM=$S(Y'[".":Y_"."_"0",1:Y)
 W !!,"Continue reprinting routing slips TO date and time.",!
 S %DT="AETX" D ^%DT G:Y<0 FINI S TO=$S(Y'[".":Y_"."_"9999",1:Y)
DOIT S FROM=FROM-.0001
QUEUE S QUEUE=^LBRY(680.6,LBRYPTR,0),TERM=$P(QUEUE,U,3)
 S %ZIS="MQ",%IS("B")=$S(TERM]"":TERM,1:"")
 K IO("Q") D ^%ZIS G:POP FINI
 I '$D(IO("Q")) U IO D ^LBRYRRS0 D ^%ZISC G FINI
QUEUE1 S ZTIO=TERM,ZTDTH=$H,ZTRTN="^LBRYRRS0",ZTSAVE("LBRYPTR")=""
 S ZTSAVE("FROM")="",ZTSAVE("TO")="" D ^%ZTLOAD D ^%ZISC K ZTSK
FINI S XZ="EXIT//" D PAUSE^LBRYUTL
 K %DT,FROM,POP,QUEUE,TERM,TO,XZ,Y
 Q
