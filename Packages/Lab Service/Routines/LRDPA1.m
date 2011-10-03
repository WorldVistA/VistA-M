LRDPA1 ;AVAMC/REG/DALISC/FHS - PT LOOKUP IN FILES FOR LAB ;9/6/94  09:03 ;
 ;;5.2;LAB SERVICE;**1,153,201,310**;Sep 27, 1994
 N X
EN K LREXP S (LRS,LRS(1),LRSVC,LRAWRD,LRMD,LRMD(1),LRADX,LRADM)="",LRPF="^"_$P(LRDPF,"^",2),LRPFN=+LRDPF,LRFNAM=$P(^DIC(LRPFN,0),"^")
 S LRP=PNM
 S:$D(VAIN(2)) LRMD(2)=+VAIN(2),LRMD=$P(VAIN(2),U,2)
 I '$G(LRMD(2)) S X=$S($D(^LR(LRDFN,.2)):+^(.2),1:"") I X,$D(^VA(200,X,0)) S LRMD=$P(^(0),U),LRMD(1)=X
 S LRCAPLOC=$S($G(^LR(LRDFN,.092)):^(.092),1:"") S:LRCAPLOC="" LRCAPLOC="Z"
 I $G(VAIN(4)) S LRLLOC=$P($G(^SC(+$G(^DIC(42,+VAIN(4),44)),0)),U,2),LRCAPLOC="W"
 E  S LRLLOC=$G(^LR(LRDFN,.1)) I $L(LRLLOC) S X=+$O(^SC("B",LRLLOC,0)) I $D(^SC(X,0)) S LRSVC=$P(^(0),"^",20)
 S:LRLLOC="" LRLLOC="???"
 W !,LRP," ID: ",SSN," " W:LRMD]"" "Physician: ",LRMD,!
 I $D(LRSS),LRSS="BB" S X=^LR(LRDFN,0),LRPABO=$P(X,"^",5),LRPRH=$P(X,"^",6) W !,"ABO group: ",LRPABO,"  Rh type: ",LRPRH
 I $D(^LR(LRDFN,.091)),^(.091)]"" W !!,"Infection control warning:",$C(7),!?5,^(.091),!
 S:$G(VAIN(3)) (LRS(1),LRSVC)=+VAIN(3),LRS=$P(VAIN(3),U,2)
 I $G(VADM(3)) S DOB=$P(VADM(3),U,2)
 E  S DOB=$$FMTE^XLFDT(DOB)
 I $D(@(LRPF_DFN_",.35)")),$P(@(LRPF_DFN_",.35)"),"^") S (LREXP,Y)=+^(.35) D D^LRU S (LRLLOC,^LR(LRDFN,.1))="DIED "_Y W $C(7),!!,?34,"",LRLLOC,"",! Q
 W:AGE !,"AGE: ",AGE W "  DATE OF BIRTH: ",DOB
 D:+LRDPF=2 A
L I '$D(LRQ),$D(LRLABKY) S LRSVC="" D ASK^LRWU S:X["^"!(X="") (LRDFN,DFN)=-1 Q:DFN=-1  S LRLLOC=$G(^LR(LRDFN,.1)) I $L(LRLLOC) S X=+$O(^SC("B",LRLLOC,0)) I $D(^SC(X,0)) S LRSVC=$P(^(0),"^",20)
 I $D(LRSS),LRSS="BB" D ^LRDPA2
 Q
A I $A(LRLLOC)<33 W $C(7),!!,"Patient in hospital but Ward Location begins with a space !!!",!,"Location =>",LRLLOC,"<=",!,"Ask MAS to fix it",! S LRLLOC="???"
 Q:+$G(LRDPF)'=2!('$G(VAIN(1)))  S:$D(VAIN(9)) LRADX=VAIN(9)
 S:$G(VAIN(7)) LRADM=$P(VAIN(7),U,2)
 I $G(VAIN(7)) S VAIP("D")=$P(VAIN(7),U) D
 . N X,I,N,Y
 . D IN5^VADPT I $G(VAIP(5)) S LRAWRD=$P($G(^SC(+$G(^DIC(42,+VAIP(5),44)),0)),U,2)
 W !,"Ward on Adm: ",LRAWRD,"  Service: ",LRS,!,"Adm Date: ",LRADM,"  Adm DX: ",LRADX,!,"Present Ward: ",LRLLOC,?30,"Primary MD: ",LRMD
 W:$G(VAIN(11)) !?28,"Attending MD: ",$P(VAIN(11),U,2)
 K VAIP
 Q
