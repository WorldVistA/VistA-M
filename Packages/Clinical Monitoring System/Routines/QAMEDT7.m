QAMEDT7 ;HISC/DAD-PROGRAMMER EDIT DATA ELEMENTS FILE ;2/10/92  07:33
 ;;1.0;Clinical Monitoring System;;09/13/1993
 D HOME^%ZIS
ASKELEM ;
 S DIC="^QA(743.4,",DIC(0)="AELMNQ",DIC("A")="Select DATA ELEMENT: ",DLAYGO=743.4 W ! D ^DIC K DIC G:Y'>0 EXIT S (DA,QAMD0,QAMD0SAV)=+Y,DIE="^QA(743.4,",DR=".01;.03" D ^DIE W !
 G ASKELEM:($D(DA)[0)!($D(Y)),ASKDD:$O(^QA(743.4,QAMD0,"DD",0))'>0
 K QAMUNDL S QAMEDT7=1,QAMQUIT=0,$P(QAMUNDL,"=",81)="" D LOOP^QAMPINQ3 W ! S QAMD0=QAMD0SAV
ASKOK ;
 W !,"Is the path to this data element OK" S %=1 D YN^DICN G DONE2:%=1,ASKELEM:%=-1 I '% W !!?5,"Enter Y(es) to leave the path unchanged.",!?5,"Enter N(o) to rebuild the path for this element.",! G ASKOK
 W !!,"Deleting path to data element" F QAMD1=0:0 S QAMD1=$O(^QA(743.4,QAMD0,"DD",QAMD1)) Q:QAMD1'>0  S DIK="^QA(743.4,"_QAMD0_",""DD"",",(D0,DA(1))=QAMD0,(D1,DA)=QAMD1 D ^DIK W "."
 W !
ASKDD ;
 R !,"(SUB) DICT. #: ",X:DTIME S:('$T)!(X="") X="^" G:$E(X)="^" ASKELEM S (QAMDD,QAMDD(0))=$P(X,",")
 I QAMDD'=+QAMDD W:$E(QAMDD)'="?" " ??",*7 W !!?5,"Enter the (sub) dictionary number where the field you want resides.",!?5,"You may enter (sub) Dictionary#,Field# if you wish to bypass the",!?5,"(SUB) FIELD # prompt (e.g. 2.98,.001).",! G ASKDD
 I $D(^DD(QAMDD,0))[0 W " ??",*7,!!?5,"*** `",QAMDD,"' IS NOT A VALID (SUB) DICTIONARY NUMBER ***",! G ASKDD
 W "    ",$S($D(^DIC(QAMDD,0))#2:$P(^(0),"^")_" FILE",1:$P(^DD(QAMDD,0),"^")) I X["," S (QAMFLD,X)=$P(X,",",2) G FLD
ASKFLD ;
 R !,"(SUB) FIELD #: ",X:DTIME S:('$T)!(X="") X="^" G:$E(X)="^" ASKELEM S QAMFLD=X
FLD I QAMFLD'=+QAMFLD W:$E(QAMFLD)'="?" " ??",*7 W !!?5,"Enter the (sub) field number for this data element.",! G ASKFLD
 I $D(^DD(QAMDD,QAMFLD,0))[0 W " ??",*7,!!?5,"*** `",QAMFLD,"' IS NOT A VALID (SUB) FIELD NUMBER ***",! G ASKFLD
 I $P(^DD(QAMDD,QAMFLD,0),"^",2) W " ??",*7,!!?5,"*** YOU MAY NOT PICK THE TOP FIELD OF A MULTIPLE ***",! G ASKFLD
 W "    ",$P(^DD(QAMDD,QAMFLD,0),"^"),!!,"Building path to data element" S QAMCOUNT=1 K QAMPATH
LOOP ;
 W "." S QAMPATH(100-QAMCOUNT)=QAMDD_"^"_QAMFLD,QAMDD=$S($D(^DD(QAMDD,0,"UP"))#2:^("UP"),1:"") G:QAMDD'>0 DONE1 S QAMFLD=$O(^DD(QAMDD,"SB",QAMDD(0),0))
 I QAMFLD'>0 W !!?5,"*** THERE IS A PROBLEM WITH THE",*7,!?5,"*** ^DD(",QAMDD,",""SB"",",QAMDD(0),",",!?5,"*** CROSS REFERENCE",*7,! G ASKELEM
 S QAMDD(0)=QAMDD,QAMCOUNT=QAMCOUNT+1 G LOOP
DONE1 ;
 S QAMPARNT=$P(^QA(743.4,QAMD0,0),"^",3),QAMPARNT(0)=$S($D(^DIC(QAMPARNT,0))#2:$P(^(0),"^"),1:"")
 I $S($D(QAMPATH(100-QAMCOUNT))[0:1,+QAMPATH(100-QAMCOUNT)'=QAMPARNT:1,1:0) W !!,?5,"*** INVALID PATH FOR THE `",QAMPARNT(0),"' FILE (#",QAMPARNT,") ***",*7,! G ASKDD
 S:$D(^QA(743.4,QAMD0,"DD",0))[0 ^(0)="^743.42A^^" S QAMCOUNT=0 F QA=0:0 S QA=$O(QAMPATH(QA)) Q:QA'>0  S QAMCOUNT=QAMCOUNT+1 S ^QA(743.4,QAMD0,"DD",QAMCOUNT,0)=QAMPATH(QA)_"^"_QAMCOUNT
 S DIK="^QA(743.4,"_QAMD0_",""DD"",",(D0,DA(1))=QAMD0 D IXALL^DIK
 K QAMUNDL S QAMEDT7=1,QAMQUIT=0,$P(QAMUNDL,"=",81)="" D LOOP^QAMPINQ3 S QAMD0=QAMD0SAV
DONE2 ;
 S DIE="^QA(743.4,",DR="20;25;28;26;27;21;22;24;23;40",DA=QAMD0 W ! D ^DIE G ASKELEM
EXIT ;
 K %,%Y,BY,D0,D1,DA,DHD,DIC,DIE,DIK,DIOEND,DLAYGO,DQ,DR,FLDS,FR,IOP,J,L,QA,QAM,QAMCOUNT,QAMD0,QAMD0SAV,QAMD1,QAMDATA,QAMDD,QAMEDT7,QAMELEM,QAMFILE,QAMFLD,QAMHDR1,QAMHDR2,QAMPARNT,QAMPATH,QAMQUIT,QAMUNDL,TO,X,Y
 Q
