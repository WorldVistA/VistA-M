LRPHITE1 ;SLC/CJS-LRPHITEM, CONT ;7/19/88  12:15
 ;;5.2;LAB SERVICE;**100,121,198,202,208,221**;Sep 27, 1994
ZAP ;from LRPHITE3
 I '$D(T(LRIX)) W $C(7)," ??" Q
 N LRXNODE
 S LRSN=+T(LRIX),LRITN=$P(T(LRIX),U,2),(LRXNODE,X)=^LRO(69,DT,1,LRSN,2,LRITN,0),LRTST=$P(X,U),LRAD=$P(X,U,3),LRAA=+$P(X,U,4),LRAN=+$P(X,U,5),LRNOP=0,LRACC="??"
 I $P(X,"^",6) W !,LRORD_" has been combined with order # "_$P(X,"^",6) S LRNOP=1 Q
 I '$D(^LRO(68,+$G(LRAA),1,+$G(LRAD),1,+$G(LRAN),0)) G ZAP1
 I $P(^LRO(69,DT,1,LRSN,1),"^",4)="C",$D(^LRO(68,LRAA,1,LRAD,1,LRAN,.2)) W !,LRORD_" has already been collected and is assigned to accession "_^(.2),!,"Do you really want to cancel #"_LRORD S %=2 D YN^DICN I %'=1 S LRNOP=1 Q
 D P16^LRPHITEM Q:LRNOP
ZAP1 ;
 K T(LRIX)
 I $$VER^LR7OU1<3 S ORIFN=$P(^LRO(69,DT,1,LRSN,2,LRITN,0),U,7) I ORIFN D DC^LRCENDE1
 N I,LRMSTATI,LRCCOM1
 S I(LRTST)=""
 D:'$D(LRNATURE) DC^LROR6(1,1)
 I $L($P($G(LRNATURE),U,5)) S LRCCOM1=$P(LRNATURE,U,5)
 D SINGLE^LRPHITEM
 S LRFLAG=0,J=0 F  S J=$O(^LRO(69,DT,1,LRSN,2,J)) Q:J<1  I $P(^(J,0),"^",3) S LRFLAG=1 Q
 S:LRFLAG=0 $P(^LRO(69,DT,1,LRSN,1),"^",4)="U" S:LRFLAG=1 $P(^LRO(69,DT,1,LRSN,1),"^",4)=""
 S $P(^LRO(69,DT,1,LRSN,2,LRITN,0),U,9)="CA",$P(^(0),U,10)="L",$P(^(0),U,11)=DUZ
 D NEW^LR7OB1(LRODT,LRSN,$S($G(LRMSTATI)=""!($G(LRMSTATI)=1):"OC",1:"SC"),$G(LRNATURE),.1,$G(LRMSTATI))
 Q
COMH ;from LRPHITEM
 S LRFIRST=0 W !,"CAUTION:  Entering a comment at the next prompt will automatically CANCEL all",!,"tests for the order numbers previously entered and they will receive a status",!,"of ""NOT COLLECTED""."
 W "  The comment will be common to all orders canceled at this",!,"point.",!?10,"If you do not want to cancel the entire order, press carriage"
 W !,"return at the next 3 prompts:  1-'Enter Order Comment:'  2-'OK? YES//'",!,"3-'Enter Order #(s) :'.  You must then answer NO to the prompt 'Cancel",!,"entire Order # xxxx? YES//'"
 W " in order to cancel individual items on the",!,"order."
 Q
END ;from LRPHITEM
 K DIC,LRBATCH,LRLLOC,LRAA,LRAD,LRAN,LRDFN,LRSS,LRITN,LRIDT,LROID,T,LRSN,I,%,A,K,LRCCOM,LREXP,LRFIRST,LRFLAG,LRFORD,LRGCOM,LRNOCOM,LRNT,LRODT,LROR,LRRB,LRSAMP,LRSPEC,LRTSTNM,O,X,Y,Z,%H,%X,%Y,DIWL,DIWR,DO,DPF,J1,LRBED,LRCSN,LRCSS,LRDC
 K LRTEST,LRDTO,LRFLOG,LRIOZERO,LRIX,LRLWC,LRM,LRORDR,LRORDTIM,LROUTINE,LRPR,LRRND,LRSSX,LRSTIK,LRTSN,LRUNQ,LRUR,LRWPC,POP,LROLLOC,LRTREA
 K LRSN0,LRWD,LRCOM,LRCCOMX
 D END^LRCENDEL
 Q
