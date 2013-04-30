LRMISTF1 ;DALOI/STAFF - MASS DATA ENTRY INTO FILE 63.05 ;Jan 15, 2009
 ;;5.2;LAB SERVICE;**121,128,202,263,264,295,350**;Sep 27, 1994;Build 230
 ;
 ; from LRMISTF
 ;
ASK ;
 N LRAUTO,LRDUZ,LRIEN,LRPLREF
 ;
 F  D GET Q:LREND=99  D:'LREND ACC S:LREND LREND=0 D MORE Q:LREND  K LRAUTO
 Q
 ;
 ;
GET ;
 N DIR,DIRUT,DTOUT,DUOUT,LRSTUFF,X,Y
 ;
 S X1="",LREND=0
 I LRMODE<3 D
 . F  R !,"What do you want entered?: ",X1:DTIME Q:'$T!(X1[U)!(X1="")  D  I $L(X1),$E(X1)'="?" S LREND=0 Q
 . . I $S(X1[":":1,X1[";":1,1:0) S X1="?" D INFO Q
 . . S X=X1 S:X[";" X="?" D @$S($G(H9)=11.57:"PN^LRNUM",$G(H9)=24:"AFS^LRNUM",1:"^LRMIXPD") S:'$D(X) X1="?" Q:X1'="?"  D INFO
 I X1[U S LREND=99 Q
 ;
 S:LRMODE<3 LRSTUFF=X1
 W !,"I will ",$S(LRMODE=1:"automatically stuff ",1:"prompt "),LRMF W:$D(LRSTUFF) !,"with ",LRSTUFF
 F  W !,"   ...OK" S %=1 D YN^DICN Q:%  W !,"Answer 'Y'es or 'N'o"
 I %'=1 S LREND=1 Q
 ;
 I LRPF="P" S DR="S:$S($D(^LR(LRDFN,""MI"",LRIDT,"_LRSB_")):$P(^("_LRSB_"),U,2),1:"""")=""F"" Y="_$S(LRSB=1:11.55,LRSB=5:15.5,LRSB=8:19.5,LRSB=11:25.5,LRSB=16:35)_";"
 I LRPF="F" S DR=""
 S DR=DR_$S(LRSB=1:"11.5///"_LRPF_";11.55",LRSB=5:"15///"_LRPF_";15.5",LRSB=8:"19///"_LRPF_";19.5",LRSB=11:"23///"_LRPF_";25.5",1:"34///"_LRPF_";35")
 S DR=DR_"////"_DUZ_";"_H9_$S(LRMODE=1:"///"_LRSTUFF,LRMODE=2:"//"_LRSTUFF,1:"")
 ;
 K DIR
 S DIR(0)="YO",DIR("A")="Verify all work automatically",DIR("B")="Yes"
 D ^DIR
 I $D(DIRUT) S LREND=1 Q
 I Y=1 S DR=DR_";"_$S(LRSB=1:11,LRSB=5:14,LRSB=8:18,LRSB=11:22,1:33)_"///NOW",LRAUTO=""
 ;
 ;
 K DIR
 S DIR(0)="YO",DIR("A")="Designate the individual test as complete",DIR("B")="No"
 D ^DIR
 I $D(DIRUT) S LREND=1 Q
 S LRCO=+Y
 ;
 ;
 ; Ask for performing lab if automatically verifying.
 ; Setup array of fields to performing lab reference
 K LRDUZ,LRPLREF
 ;
 S LRPLREF(11.57)="1:6"
 S LRPLREF(11.58)="1;5"
 S LRPLREF(11.6)="2,0"
 S LRPLREF(13)="4,0"
 S LRPLREF(15.51)="24,0"
 S LRPLREF(17)="7,0"
 S LRPLREF(19.6)="15,0"
 S LRPLREF(21)="10,0"
 S LRPLREF(24)="11;3"
 S LRPLREF(27)="13,0"
 S LRPLREF(37)="18,0"
 ;
 I $D(LRAUTO) D
 . N DIR,DIRUT,DTOUT,DUOUT,LRDPL,X,Y
 . S LRDPL=$$GET^XPAR("USR","LR VER DEFAULT PERFORMING LAB",1,"Q")
 . I LRDPL<1 S LRDPL=DUZ(2)
 . S X=$$SELPL^LRVERA(LRDPL)
 . I X<1 S LREND=1 Q
 . I X'=DUZ(2) S LRDUZ(2)=X
 . S DIR(0)="S^1:Entire report;2:"_LRMF_" section of report"
 . S DIR("A")="Designate performing laboratory for"
 . S DIR("?")="Enter a code from the list or '^' to exit."
 . D ^DIR
 . I $D(DIRUT) S LREND=1 Q
 . I Y=1 S $P(LRPLREF(H9),"^")="0"
 Q
 ;
 ;
INFO ;
 W !,$$CJ^XLFSTR("What you enter will go through the input transform to be stored in the.",IOM)
 W !,$$CJ^XLFSTR("Result field of the test",IOM)
 W !,$$CJ^XLFSTR("The punctuations of ';' or ':'  are not allowed in Batch Data Entry.",IOM),!
 Q
 ;
 ;
ACC ;
 N DIC,DIR,DIRUT,DTOUT,DUOUT
 W !,"Enter the accessions you wish to edit." D LRAN^LRMIUT
 I +$O(LRAN(0))>0 W !,"Editing the following:" S (J,LRAN)=0 F  S LRAN=+$O(LRAN(LRAN)) Q:LRAN<1  W !,LRAN S J=J+1 I J#(IOSL-2)=0 R !,"Press return to continue or '^' to escape ",X:DTIME I X[U S LREND=1 Q
 Q:LREND
 ;
 S DIR(0)="YO",DIR("A")="Everything OK",DIR("B")="NO"
 D ^DIR
 I Y<1 Q
 ;
 S LRAN=0
 F  S LRAN=+$O(LRAN(LRAN)) Q:LRAN<1  D STUFF Q:LREND
 Q
 ;
 ;
STUFF ;
 N LREND
 ;
 I '$D(^LRO(68,LRAA,1,LRAD,1,LRAN,0))!'$D(^(3)) W !,"Acc: ",LRAN," not set up." Q
 I $P(^LRO(68,LRAA,1,LRAD,1,LRAN,3),U,4) W !,"Acc: ",LRAN," has been previously verified by a microbiology supervisor." Q
 ;
 S LRNOP=1,J=0 F  S J=+$O(^LRO(68,LRAA,1,LRAD,1,LRAN,4,J)) Q:J<1  I LRTEST=+^(J,0) S LRNOP=$P(^(0),U,5) Q
 I LRNOP=1 W !,"Acc: ",LRAN," doesn't have the test required." Q
 I LRNOP>1 W !,"Acc: ",LRAN," has been completed for the selected test." Q
 ;
 I H9=11.57!(H9=11.58) S LROK=0 D @$S(H9=11.57:"UR",1:"SPUT") I 'LROK W !,"Acc: ",LRAN," doesn't have the specimen required." Q
 ;
 W !,"Acc: ",LRAN
 S LRDFN=+^LRO(68,LRAA,1,LRAD,1,LRAN,0),LRLLOC=$P(^(0),U,7),LRODT=$S($P(^(0),U,4):$P(^(0),U,4),1:$P(^(0),U,3)),LRSN=$P(^(0),U,5)
 S LRDPF=$P(^LR(LRDFN,0),U,2),DFN=$P(^(0),U,3)
 D PT^LRX
 W ?15,PNM,?45,SSN,?65,LRWRD,!
 ;
 S LRCDT=+^LRO(68,LRAA,1,LRAD,1,LRAN,3),LRIDT=+$P(^(3),U,5),DIE="^LR("_LRDFN_",""MI"",",DA=LRIDT
 D ^DIE,UPDATE^LRPXRM(LRDFN,"MI",LRIDT)
 I $D(Y) S LREND=1 Q
 ;
 I LRCO D
 . S X=$P(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRTEST,0),U,5)
 . I X K ^LRO(68,LRAA,1,LRAD,1,"AD",$P(X,"."),LRAN),^LRO(68,LRAA,1,LRAD,1,"AC",X,LRAN)
 . S $P(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRTEST,0),U,4)=DUZ,$P(^(0),U,8)=$G(LRCDEF)
 . S Y=$$NOW^XLFDT
 . S $P(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRTEST,0),U,5)=Y
 . S ^LRO(68,LRAA,1,LRAD,1,"AD",$P(Y,"."),LRAN)="",^LRO(68,LRAA,1,LRAD,1,"AC",Y,LRAN)=""
 . N CORRECT S:$G(LRCORECT) CORRECT=1 D NEW^LR7OB1(LRODT,LRSN,"RE")
 ;
 I $D(LRAUTO) D PL,STF^LRMIUT,LEDI^LRVR0
 ;
 Q
 ;
 ;
MORE ;
 S LREND=1
 F  W !,"Do you wish to make a new entry for the ",LRMF," field" S %=2 D YN^DICN Q:%  W !,"Answer 'Y'es or 'N'o"
 I %=1 S LREND=0
 Q
 ;
 ;
UR ;
 S J=0
 F  S J=+$O(^LRO(68,LRAA,1,LRAD,1,LRAN,5,J)) Q:J<1  I LRURINE=+^(J,0) S LROK=1 Q
 Q
 ;
 ;
SPUT ;
 S J=0
 F  S J=+$O(^LRO(68,LRAA,1,LRAD,1,LRAN,5,J)) Q:J<1  I 360=+^(J,0) S LROK=1 Q
 Q
 ;
 ;
PL ; Store performing lab on automatic verification
 ;
 N LRPL,LRREF,LRX,LRY
 ;
 S LRY=$G(LRPLREF(H9))
 I LRY="" Q
 S LRREF=LRDFN_",MI,"_LRIDT_","_LRY
 S LRPL=$S($G(LRDUZ(2)):LRDUZ(2),1:DUZ(2))
 ;
 S LRX=$O(^LR(LRDFN,"PL","B",LRREF,0))
 I 'LRX D CNE^LRRPLU(LRDFN,LRREF,LRPL) Q
 I $P(^LR(LRDFN,"PL",LRX,0),"^",2)'=LRPL D UEE^LRRPLU(LRDFN,LRREF,LRPL)
 ;
 Q
