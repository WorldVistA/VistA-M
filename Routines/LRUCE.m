LRUCE ;AVAMC/REG - LAB COMMENT EDIT ; 6/2/86  9:03 AM ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
DATE S %DT="AEX",%DT("A")="ENTER WORKLIST DATE: " D ^%DT Q:Y<1
 S LRAD=$S($P(^LRO(68,LRAA,0),"^",3)="Y":$E(Y,1,3)_"0000",1:Y),Y=LRAD D D^LRU S LRH(0)=Y
 I '$D(^LRO(68,LRAA,1,LRAD,0)) W $C(7),!!,"NO ",LRAA(1)," ACCESSIONS IN FILE FOR ",LRH(0),!! G DATE
LRAN W !!,LRH(0),?14," Acc # : " R LRAN:DTIME Q:LRAN=""!(LRAN["^")  I LRAN'?1N.N W $C(7),!!,"NUMBERS ONLY" G LRAN
 I '$D(^LRO(68,LRAA,1,LRAD,1,LRAN,0)) W $C(7),!!,"Accession #",LRAN," for ",LRH(0)," not in ACCESSION file",!! G LRAN
 S LRDFN=+^LRO(68,LRAA,1,LRAD,1,LRAN,0) Q:'$D(^LR(LRDFN,0))
 S LRPF=^DIC($P(^LR(LRDFN,0),"^",2),0,"GL"),LRFLN=+$P(@(LRPF_"0)"),"^",2),DFN=$P(^LR(LRDFN,0),"^",3),LRP=@(LRPF_DFN_",0)"),LRLLOC=$S($D(^(.1)):^(.1),1:"") W !,$P(LRP,"^"),?30,"ID: ",$P(LRP,"^",9),"  ",LRLLOC
 S LRI=$S($D(^LRO(68,LRAA,1,LRAD,1,LRAN,3)):$P(^(3),"^",5),1:"") Q:'LRI
ASK L +^LR(LRDFN,SBSC,LRI):1 I '$T W !?7,"Someone else is editing this Patient ",!!,$C(7) Q
 S DIE="^LR(LRDFN,SBSC,",DA=LRI,DR=".99;S LRC(5)=X" D ^DIE Q:$D(Y)
 S ^LRO(68,LRAA,1,LRAD,1,LRAN,3)=$P(^LRO(68,LRAA,1,LRAD,1,LRAN,3),"^",1,5)_"^"_LRC(5)
 L -^LR(LRDFN,SBSC,LRI) Q
