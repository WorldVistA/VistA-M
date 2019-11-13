LRWU5 ;SLC/RWF/BA - ADD A NEW DATA NAME TO FILE 63 ; 5/15/87  22:53 ;
 ;;5.2;LAB SERVICE;**140,171,177,206,316,519**;Sep 27, 1994;Build 16
 ;
 ; Reference to ^DD(63.04 supported by DBIA #7053
 ; Reference to ^XMB(1 supported by DBIA #10091
 ; Reference to ^XUSEC supported by DBIA #10076
 ;
ACCESS ;
 I '$D(^XUSEC("LRLIASON",DUZ)) W $C(7),!,"You do not have access to this option" Q
BEGIN ;
 N LRMOD
 S U="^",LREND=0,DTIME=$S($D(DTIME):DTIME,1:300),LRMOD=0
 W !!,"This option will add a new data name to the lab package." D DT^LRX,TEST
END ;
 K %,DA,DIC,DIK,DIR,I,LRDEC,LREND,LRI,LRLO,LMX,LRMIN,LRNAME,LROK,LRPIECE,LRSET,LRTYPE,LROK1,Q1,Q2,Q3,Q4,Q5,X,Y
 I $G(DA)]"" L -^DD(63.04,DA)
 Q
TEST ;
 F I=0:0 S LROK=1,DA=0 R !,"DATA NAME: ",X:DTIME Q:'$T!(X[U)!'$L(X)  S:X["?" X="=" D CHECK Q:LROK!(LREND)
 Q:LREND=1
 I 'DA Q:'$T!(X[U)!'$L(X)
 F I=0:0 R !,"Enter data type for test: (N)umeric, (S)et of Codes, or (F)ree text? ",X:DTIME Q:X[U!(X="")!(X="N")!(X="S")!(X="F")  W !,"Enter 'N', 'S', 'F', or '^'"
 I X=""!(X[U) Q
 ;VMP OIFO BAY PINES;VGF;LR*5.2*316; H 5 IF ERROR
 S Q1=X D @$S(Q1="N":"NUM",Q1="S":"CODES",1:"FREE") I 'LROK W !,"Nothing has been added." H 5 Q
 ;
 S $P(^DD(63.04,0),U,4)=$P(^DD(63.04,0),U,4)+1
 S DIK="^DD(63.04,",DA(1)=63.04 D IX1^DIK
 W !!,"'",LRNAME,"' added as a new data name" D DISPLAY^LRWU6 W !!,"You must now add a new test in the LABORATORY TEST file and use",!,LRNAME," as the entry for the DATA NAME field."
 Q
CHECK ;
 X $P(^DD(0,.01,0),U,5) I '$D(X) W $C(7)," ??",!,"ANSWER MUST BE 2-30 CHARACTERS AND NOT CONTAIN '='" S LROK=0 Q
 S LRNAME=X,DIC="^DD(63.04,",DIC(0)="XM" D ^DIC I Y>0 W $C(7),!,"This data name already exists" S LROK=0 Q
 ;checking "B" cross reference since non-locking in FileMan
 ;could create data corruption - LR*5.2*519
 I $D(^DD(63.04,"B",LRNAME)) D  Q
 . S LROK=0
 . W $C(7),!,"This data name exists in the ^DD(63.04,""B"" cross reference only."
 . W !,"Enter a support ticket if assistance is needed to correct this file."
 S DA=$S($P($G(^XMB(1,1,"XUS")),U,17):$P(^("XUS"),U,17),1:0)*1000 D:'DA SITE Q:'LROK  F I=0:0 S DA=DA+1 Q:'$D(^DD(63.04,DA))
 ;
LOCK ;
 ;adding lock - LR*5.2*519
 ;not attempting to determine the next IEN by checking the
 ;zero node because last ien pointer appears to be inaccurate
 ;in several environments
 ;
 W !!,"Please wait a maximum of "_$G(DILOCKTM,5)_" seconds while it is"
 W !,"determined whether internal entry number "_DA_" is available....."
 L +^DD(63.04,DA):$G(DILOCKTM,5)
 I '$T D  G:'$G(DUOUT)&'$G(DTOUT) LOCK I $G(DUOUT)!($G(DTOUT)) S LREND=1
 . W !!,"Someone else is defining this internal entry number."
 . W !,"Trying again to find a new internal entry number."
 . F I=0:0 S DA=DA+1 Q:'$D(^DD(63.04,DA))
 . ;giving the user a chance to exit gracefully in case the process
 . ;of trying to find a new IEN ends up in an endless loop due to too 
 . ;many users defining new entries.
 . W !
 . S DIR(0)="E",DIR("A")="Press ENTER to continue or ^ to exit" D ^DIR
 Q:LREND
 W !!,"Internal entry number "_DA_" is available.",!!
 F I=0:0 W !,"ARE YOU ADDING ",LRNAME," (SUBFIELD # ",DA,") AS A NEW DATA NAME" S %=2 D YN^DICN Q:%  W " Answer 'Y'es or 'N'o."
 I %'=1 S LROK=0 Q
 Q
SITE ;
 W !,"Your site number is not defined, indicating that fileman was not ",!,"installed correctly.  Contact your site manager!"
 S LROK=0,LREND=1 Q
NUM ;
 ;
MIN ;
 K DTOUT,DUOUT
 S DIR(0)="F"
 S DIR("A")="Minimum value: "
 ;S DIR("B")=1
 S DIR("?")="The smallest result value: "
 D ^DIR
 I $D(DUOUT)!($D(DTOUT)) S LROK=0 QUIT
 S Q3=Y
MAX ;
 K DTOUT,DUOUT
 S DIR(0)="F"
 S DIR("A")="Maximum value: "
 S DIR("B")=1
 S DIR("?")="The maximum result THIS TEST will ever be: "
 D ^DIR
 I $D(DUOUT)!($D(DTOUT))!(Y<0) S LROK=0 QUIT
 S Q4=Y
DECIMAL ;
 K DTDOUT,DUTOU
 S DIR(0)="F"
 S DIR("A")="Decimal value: "
 S DIR("B")=1
 S DIR("?")="The number of decimal places this result will need: "
 D ^DIR
 I $D(DUOUT)!($D(DTOUT))!(Y<0) S LROK=0 QUIT
 S Q5=Y
 ;
 D NAME
 Q:'LROK
 S ^DD(63.04,DA,0)=LRNAME_"^NXJ"_($L(Q4)+Q5+$S(Q5:1,1:0))_","_Q5_"^^"_DA_";1^"_"S Q9="""_Q3_","_Q4_","_Q5_""" D ^LRNUM",^(3)="TYPE A "_$S(Q5:"",1:"WHOLE ")_"NUMBER BETWEEN "_Q3_" AND "_Q4,^("DT")=DT
 Q
CODES ;
 S Q2="",LROK1=1 F I=0:0 R !,"INTERNALLY-STORED CODE: // ",X:DTIME D CHK1 Q:'LROK1  R "   WILL STAND FOR: // ",X:DTIME D CHK2 Q:'LROK1
 I '$L(Q2) S LROK=0 Q
 D NAME
 Q:'LROK
 S ^DD(63.04,DA,0)=LRNAME_"^S^"_Q2_"^"_DA_";1^Q",^(3)="",^("DT")=DT
 Q
CHK1 I X[U!'$T!'$L(X) S LROK1=0 Q
 ;VMP OIFO BAY PINES;VGF;LR*5.2*316
 I X[";"!(X[":") W !,": and ; not allowed ",$C(7) S Q3="",LROK1=0 Q
 S Q3=X
 Q
CHK2 I X[U!'$T!'$L(X) S LROK1=0 Q
 ;VMP OIFO BAY PINES;VGF;LR*5.2*316
 I X[";"!(X[":") W !,": and ; not allowed ",$C(7) S Q2="",LROK1=0 Q
 S Q4=X,Q2=Q2_Q3_":"_Q4_";" I $L(Q2)+$L(LRNAME)+9>245 W !,"Too many codes* ",$C(7) S Q2="",LROK1=0
 Q
FREE ;
 F I=0:0 R !,"Minimum length: ",X:DTIME Q:X[U!'$T!(X'<1&(X'>20)&(+X=X))  W " Enter a whole number from 1 to 20"
 I X[U!'$T S LROK=0 Q
 S Q3=X
 ;---LR*5.2*140 Changed max length from 80 to 50
 F I=0:0 R !,"Maximum length: ",X:DTIME Q:X[U!'$T!(X'<Q3&(X'>50)&(+X=X))  W " Enter a whole number between ",Q3," to 50"
 I X[U!'$T S LROK=0 Q
 S Q4=X
 D NAME
 Q:'LROK
 S ^DD(63.04,DA,0)=LRNAME_"^F^^"_DA_";1^K:$L(X)>"_Q4_"!($L(X)<"_Q3_") X",^(3)="ANSWER MUST BE "_Q3_"-"_Q4_" CHARACTERS IN LENGTH",^("DT")=DT
 Q
 ;
NAME ;check before filing to make sure a user on another session
 ;isn't filing the same name under a different IEN
 ;Variable LRMOD is passed as 1 from LRWU6 from the option
 ;"Modify an Existing Data Name"
 ;
 I $D(^DD(63.04,"B",LRNAME)),'$G(LRMOD) D
 . S LROK=0
 . W !,"This data name has already been added by someone else"
 . W !,"in another session after you selected the data name."
 . W !,"Nothing is being saved from your session since the data name is now on file."
 Q
