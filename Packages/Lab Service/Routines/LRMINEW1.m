LRMINEW1 ;DALOI/STAFF - NEW DATA TO BE REVIEWED/VERIFIED ;May 14, 2008
 ;;5.2;LAB SERVICE;**295,350**;Sep 27, 1994;Build 230
 ;
 ;
VER ;
 N DIR,DIRUT,DIROUT,DTOUT,DUOUT,X,Y
 ;
 W !!,"Indicate those you wish to exclude from verification."
 D CHECK
 ;
 I $O(LRAN(0))>0 D
 . W !,"Verifying all but the following:"
 . S LRAN=0
 . F  S LRAN=$O(LRAN(LRAN)) Q:LRAN=""  W !,LRAN
 ;
 S DIR(0)="YO"
 S DIR("A")="Want the approved reports to be printed at the requesting locations"
 S DIR("B")="NO"
 D ^DIR
 I $D(DIRUT) Q
 S LRMIQUE=+Y
 ;
 K DIR
 S DIR(0)="YO"
 S DIR("A")="Are you ready to verify",DIR("B")="NO"
 S DIR("?",1)="If you're not sure, it's not too late to quit."
 S DIR("?")="Enter either 'Y' or 'N'."
 D ^DIR
 I Y'=1 Q
 ;
 S LRAN=0 F  S LRAN=+$O(LRAN(LRAN)) Q:LRAN<1  K ^LRO(68,LRAA,1,LRAD,"AC",LRSB,LRAN)
 S LRAN=0 F  S LRAN=+$O(^LRO(68,LRAA,1,LRAD,"AC",LRSB,LRAN)) Q:LRAN<1  I +^(LRAN)=LRDXZ!(LRDXZ=0) D STUFF
 W !,"ALL DONE"
 ;
 Q
 ;
 ;
STUFF ;
 Q:'$D(^LRO(68,LRAA,1,LRAD,1,LRAN,0))  Q:'$D(^(3))
 ;
 S Y=^LRO(68,LRAA,1,LRAD,1,LRAN,0),LRDFN=+Y,LRLLOC=$P(Y,U,7),LRODT=$S($P(Y,U,4):$P(Y,U,4),1:$P(Y,U,3)),LRSN=$P(Y,U,5)
 S LRIDT=$P(^LRO(68,LRAA,1,LRAD,1,LRAN,3),"^",5)
 I LRIDT="" S LRIDT=9999999-^LRO(68,LRAA,1,LRAD,1,LRAN,3)
 ;
 S LRDPF=$P(^LR(LRDFN,0),U,2),DFN=$P(^(0),U,3)
 D PT^LRX
 ;
 S DT=$$DT^XLFDT
 S $P(^LR(LRDFN,"MI",LRIDT,LRSB),U)=DT,$P(^(LRSB),U,$S(LRSB=11:5,1:3))=DUZ
 ;
 I LRDPF=2 D UPDATE^LRPXRM(LRDFN,"MI",LRIDT)
 I $G(LRSS)="" S LRSS="MI"
 D SETRL^LRVERA(LRDFN,LRSS,LRIDT,DUZ(2))
 I LRDPF=67 D SETTMP^LRVRMI5
 ;
 S LRCDT=$P(^LRO(68,LRAA,1,LRAD,1,LRAN,3),"^")
 S Y=DT D VT^LRMIUT1
 K ^LRO(68,LRAA,1,LRAD,"AC",LRSB,LRAN)
 D:LRMIQUE TSKM^LRMIUT
 Q
 ;
 ;
CHECK ;from LRMINEW
 D LRAN^LRMIUT
 S LRAN=0
 F  S LRAN=+$O(LRAN(LRAN)) Q:LRAN<1  S LROK=1 D CHECK1 I 'LROK K LRAN(LRAN)
 Q
 ;
 ;
CHECK1 ;
 I '$D(^LRO(68,LRAA,1,LRAD,"AC",LRSB,LRAN)) W !,LRAN," is not defined." S LROK=0 Q
 I LRDXZ'=0,+^LRO(68,LRAA,1,LRAD,"AC",LRSB,LRAN)'=LRDXZ W !,LRAN," is not your accession." S LROK=0
 Q
