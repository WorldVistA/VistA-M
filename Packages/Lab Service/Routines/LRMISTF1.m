LRMISTF1 ;SLC/CJS/BA/DALOI/FHS - MASS DATA ENTRY INTO FILE 63.05 ;2/25/03  22:24
 ;;5.2;LAB SERVICE;**121,128,202,263,264,295**;Sep 27, 1994
 ; Reference to ^DPT( Supported by Reference #10035
 ; Reference to ^ORD(100.99 Supported by Reference #2414
 ; Reference to YN^DICN Supported by Reference #10009
 ; Reference to ^DIE Supported by Reference #10018
 ; Reference to $$NOW^XLFDT Supported by Reference #10103
 ; Reference to $$CJ^XLFSTR  Supported by Reference #10104
 ;from LRMISTF
ASK F I=0:0 D GET Q:LREND=99  D:'LREND ACC S:LREND LREND=0 D MORE Q:LREND  K LRAUTO
 Q
GET S X1="",LREND=0 I LRMODE<3 D
 . F  R !,"What do you want entered?: ",X1:DTIME Q:'$T!(X1[U)!(X1="")  D  I $L(X1),$E(X1)'="?" S LREND=0 Q
 . . I $S(X1[":":1,X1[";":1,1:0) S X1="?" D INFO Q
 . . S X=X1 S:X[";" X="?" D @$S($G(H9)=11.57:"PN^LRNUM",$G(H9)=24:"AFS^LRNUM",1:"^LRMIXPD") S:'$D(X) X1="?" Q:X1'="?"  D INFO
 I X1[U S LREND=99 Q
 S:LRMODE<3 LRSTUFF=X1 W !,"I will ",$S(LRMODE=1:"automatically stuff ",1:"prompt "),LRMF W:$D(LRSTUFF) !,"with ",LRSTUFF
 F  W !,"   ...OK" S %=1 D YN^DICN Q:%  W !,"Answer 'Y'es or 'N'o"
 I %'=1 S LREND=1 Q
 I LRPF="P" S DR="S:$S($D(^LR(LRDFN,""MI"",LRIDT,"_LRSB_")):$P(^("_LRSB_"),U,2),1:"""")=""F"" Y="_$S(LRSB=1:11.55,LRSB=5:15.5,LRSB=8:19.5,LRSB=11:25.5,LRSB=16:35)_";"
 I LRPF="F" S DR=""
 S DR=DR_$S(LRSB=1:"11.5///"_LRPF_";11.55",LRSB=5:"15///"_LRPF_";15.5",LRSB=8:"19///"_LRPF_";19.5",LRSB=11:"23///"_LRPF_";25.5",1:"34///"_LRPF_";35")
 S DR=DR_"////"_DUZ_";"_H9_$S(LRMODE=1:"///"_LRSTUFF,LRMODE=2:"//"_LRSTUFF,1:"")
 F  W !,"Verify all work automatically" S %=1 D YN^DICN Q:%  W !,"Answer 'Y'es or 'N'o"
 I %=-1 S LREND=1 Q
 I %=1 S DR=DR_";"_$S(LRSB=1:11,LRSB=5:14,LRSB=8:18,LRSB=11:22,1:33)_"///T",LRAUTO=""
 S LRCO=0 F  W !,"Designate the individual test as complete" S %=2 D YN^DICN Q:%  W !,"Answer 'Y'es or 'N'o"
 S:%=1 LRCO=1 S:%=-1 LREND=1
 Q
INFO W !,$$CJ^XLFSTR("What you enter will go through the input transform to be stored in the.",IOM)
 W !,$$CJ^XLFSTR("Result field of the test",IOM)
 W !,$$CJ^XLFSTR("The punctuations of ';' or ':'  are not allowed in Batch Data Entry.",IOM),!
 Q
ACC K LRSTUFF,DIC W !,"Enter the accessions you wish to edit." D LRAN^LRMIUT
 I +$O(LRAN(0))>0 W !,"Editing the following:" S (J,LRAN)=0 F  S LRAN=+$O(LRAN(LRAN)) Q:LRAN<1  W !,LRAN S J=J+1 I J#(IOSL-2)=0 R !,"Press return to continue or '^' to escape ",X:DTIME I X[U S LREND=1 Q
 Q:LREND
 F  W !,"Everything OK" S %=2 D YN^DICN Q:%  W !,"Answer 'Y'es or 'N'o"
 Q:%'=1
 S LRAN=0 F  S LRAN=+$O(LRAN(LRAN)) Q:LRAN<1  D STUFF Q:LREND
 Q
STUFF I '$D(^LRO(68,LRAA,1,LRAD,1,LRAN,0))!'$D(^(3)) W !,"Acc: ",LRAN," not set up." Q
 I $P(^LRO(68,LRAA,1,LRAD,1,LRAN,3),U,4) W !,"Acc: ",LRAN," has been previously verified by a microbiology supervisor." Q
 S LRNOP=1,J=0 F  S J=+$O(^LRO(68,LRAA,1,LRAD,1,LRAN,4,J)) Q:J<1  I LRTEST=+^(J,0) S LRNOP=$P(^(0),U,5) Q
 I LRNOP=1 W !,"Acc: ",LRAN," doesn't have the test required." Q
 I LRNOP>1 W !,"Acc: ",LRAN," has been completed for the selected test." Q
 I H9=11.57!(H9=11.58) S LROK=0 D @$S(H9=11.57:"UR",1:"SPUT") I 'LROK W !,"Acc: ",LRAN," doesn't have the specimen required." Q
 W !,"Acc: ",LRAN S LRDFN=+^LRO(68,LRAA,1,LRAD,1,LRAN,0),LRLLOC=$P(^(0),U,7),LRODT=$S($P(^(0),U,4):$P(^(0),U,4),1:$P(^(0),U,3)),LRSN=$P(^(0),U,5)
 S LRDPF=$P(^LR(LRDFN,0),U,2),DFN=$P(^(0),U,3) D PT^LRX W ?15,PNM,?45,SSN I LRDPF=2,$D(^DPT(DFN,.1)) W ?65,^(.1)
 I LRDPF=2,DFN,$P($G(^ORD(100.99,1,"CONV")),"^")=0 D EN^LR7OV2(DFN_";DPT(",1)
 W ! S LRCDT=+^LRO(68,LRAA,1,LRAD,1,LRAN,3),LRIDT=+$P(^(3),U,5),DIE="^LR("_LRDFN_",""MI"",",DA=LRIDT D ^DIE,UPDATE^LRPXRM(LRDFN,"MI",LRIDT) I $D(Y) S LREND=1 Q
 I LRCO S X=$P(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRTEST,0),U,5) K:X ^LRO(68,LRAA,1,LRAD,1,"AD",$P(X,"."),LRAN),^LRO(68,LRAA,1,LRAD,1,"AC",X,LRAN)
 I LRCO D
 . S $P(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRTEST,0),U,4)=DUZ,$P(^(0),U,8)=$G(LRCDEF)
 . S Y=$$NOW^XLFDT
 . S $P(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRTEST,0),U,5)=Y
 . S ^LRO(68,LRAA,1,LRAD,1,"AD",$P(Y,"."),LRAN)="",^LRO(68,LRAA,1,LRAD,1,"AC",Y,LRAN)=""
 . I $$VER^LR7OU1<3 N I S I=LRTEST D V^LROR ;OE/RR 2.5
 . N CORRECT S:$G(LRCORECT) CORRECT=1 D NEW^LR7OB1(LRODT,LRSN,"RE")
 I $D(LRAUTO) D STF^LRMIUT
 Q
MORE S LREND=1 F  W !,"Do you wish to make a new entry for the ",LRMF," field" S %=2 D YN^DICN Q:%  W !,"Answer 'Y'es or 'N'o"
 I %=1 S LREND=0
 Q
UR S J=0 F  S J=+$O(^LRO(68,LRAA,1,LRAD,1,LRAN,5,J)) Q:J<1  I LRURINE=+^(J,0) S LROK=1 Q
 Q
SPUT S J=0 F  S J=+$O(^LRO(68,LRAA,1,LRAD,1,LRAN,5,J)) Q:J<1  I 360=+^(J,0) S LROK=1 Q
 Q
