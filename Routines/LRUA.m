LRUA ;AVAMC/REG/WTY - ANAT PATH UTILITY ;10/23/01
 ;;5.2;LAB SERVICE;**72,173,201,213,259**;Sep 27, 1994
 ;
 ;Reference to ^DIC supported by IA #916
 ;Reference to ^DIC(7 supported by IA #2252
 ;
 S LRPF=^DIC($P(^LR(LRDFN,0),"^",2),0,"GL"),LRFLN=+$P(@(LRPF_"0)"),"^",2)
 S DFN=$P(^LR(LRDFN,0),"^",3),LRDPF=$P(^(0),U,2),W=^(LRSS,LRI,0)
 S LRW(1)=$E($P(W,"^",10),2,3)
 S LRLLOC=$P(W,"^",8),LRAC=$P(W,"^",6),LRPMD=$P(W,"^",2)
 S LRRMD=$P(W,"^",4),LRMD=$P(W,"^",7),LRW(5)=$P(W,"^",5)
 S LRW(9)=$P(W,"^",9),SSN=@(LRPF_DFN_",0)")
 S Y=+W D DATE S LRTK=Y,Y=$P(W,"^",10) D DATE S LRTK(1)=Y
 I LRMD S X=LRMD D D S LRMD=X
 I LRPMD S X=LRPMD D D S LRPMD=X
 I LRRMD S X=LRRMD D D S LRRMD=X
 S (LRADM,LRADX,DOB)=""
 S Y=$P(W,"^",3) D DATE S LRRC=$S(Y["1700":"",1:Y)
 S LRP=$P(SSN,"^"),SEX=$P(SSN,"^",2),(X2,Y)=$P(SSN,"^",3)
 S SSN=$P(SSN,"^",9) D SSN^LRU
 D DEM^LRX,DD^LRX S DOB=Y
 I LRPF="^DPT(" K VAIN D INPPT^LRX S LRADX=VAIN(9),LRADM=$P(VAIN(7),U,2)
 Q
SET ;
 S X=$G(^LRO(69.2,LRAA,0)),LR(69.2,.03)=$P(X,U,3),LR(69.2,.04)=$P(X,U,4),LR(69.2,.05)=$P(X,U,5),LR(69.2,.13)=$P(X,U,13),LR(69.2,.14)=$P(X,U,14)
 ;
EN ;
 S X=+$O(^LRO(68,"B","AUTOPSY",0)),X=$S($D(^LRO(69.2,X,0)):^(0),1:""),LRAU(1)=$P(X,"^",3),LRAU(2)=$P(X,"^",4)
 D FIELD^DID(63.819,.01,"","POINTER","LR") S LR("SP")=LR("POINTER")
 D FIELD^DID(63.219,.01,"","POINTER","LR") S LR("EM")=LR("POINTER")
 D FIELD^DID(63.919,.01,"","POINTER","LR") S LR("CY")=LR("POINTER")
 D FIELD^DID(63.26,.01,"","POINTER","LR") S LR("AU")=LR("POINTER")
 D FIELD^DID(63,13.7,"","POINTER","LR") S LRAU("T")=LR("POINTER")
 D FIELD^DID(63,14.5,"","POINTER","LR") S LRAU("L")=LR("POINTER")
 D FIELD^DID(63.26,.01,"","POINTER","LR") S LRAU("S")=LR("POINTER")
 Q
C ;
 S X("L")="" F X(1)=1:1:$L(X) S X("L")=X("L")_$C($A(X,X(1))+($E(X,X(1))?1U*32))
 S X=X("L") Q
 ;string X => lower case do C; upper case do U
U S X("U")="" F X(1)=1:1:$L(X) S X("U")=X("U")_$C($A(X,X(1))-($E(X,X(1))?1L*32))
 S X=X("U") Q
P S LRMD(1)="" D D S LRMD=X Q
 ;
D ;Name formatting
 I $D(^VA(200,X,0)) D
 .Q:'$D(LRSS)
 .I LRSS'="BB" D
 ..N LRNAME,FMTNAM
 ..S LRNAME("FILE")=200,LRNAME("FIELD")=.01,LRNAME("IENS")=X_","
 ..S LRMD(1)=X,X=+$P($G(^VA(200,X,"PS")),"^",5)
 ..S FMTNAM=$$NAMEFMT^XLFNAME(.LRNAME,"G","D")
 ..S X=FMTNAM
 .I LRSS="BB" D
 ..S LRMD(1)=X,X(2)=$P(^(0),"^"),X=+$P($G(^("PS")),"^",5)
 ..S X(1)=$P($G(^DIC(7,X,0)),"^",2)
 ..S X=$P(X(2),",",2)_" "_$P(X(2),",")_" "_X(1)
 Q
EN1 ;
 W !?21,"1.  Add patient(s) to report print queue",!?21,"2.  Delete report print queue",!?21,"3.  Print single report only",!?21,"4.  Print all reports on print queue"
 R !,"Select print option: ",LRAPX:DTIME I LRAPX=""!(X[U) K LRAPX Q
 I LRAPX<1!(LRAPX>4) W $C(7),"   SELECT A NUMBER FROM 1-4",! G EN1
 Q
EN2 ; set variable for accession prefix
 S LRQ(8)=$S($D(^LRO(69.2,LRAA,0)):$P(^(0),"^",8),1:"")
 Q
 ;
DATE ; Returns date in Mon day,year  time (if appropriate) format
 S Y=$TR($$FMTE^XLFDT(Y,"M"),"@"," ")
 Q
