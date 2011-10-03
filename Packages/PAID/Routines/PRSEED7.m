PRSEED7 ;HISC/MD/MH-PRSE NON-LOCAL C.E. ATTENDANCE UPDATE CON'T ;MAY 93 [ 01/19/95  2:44 PM ]
 ;;4.0;PAID;;Sep 21, 1995
 ; LAST MODIFIED BY MD 10/19/93
RECHK ; CHECK M.I. MULTIPLE FOR DUPLICATE ENTRIES
 S NOUT=0,PRSENAM(0)=PRSENAM I $E(PRSENAM)="`" S PRSENAM(0)=$P($G(^PRSE(452.1,+$P(PRSENAM,"`",2),0)),U)
 I $D(^PRSE(452,"AA",PRSESEL,VA200DA,PRSENAM(0),9999999-PRSEDT)) S NDUPSW=1,Y=PRSEDT D DD^%DT W !!,?9,$C(7),PRSESTUD_" has completed "_PRSENAM(0)_" on "_Y,!?9,"Do you want to [D]elete or [E]dit this entry? " D EDTDEL Q:NOUT  G:X=-1 RECHK
 S PRSESW=1 Q
EDTDEL R X:DTIME I '$T!(U[X) Q
 S X=$S(X?1L:$C($A(X)-32),1:X)
 I $S(X["?":1,'(X="E")&'(X="D"):1,1:0) D HELP S X=-1 Q
 W ! S (PRSEDA(1),DA)=+$O(^PRSE(452,"AA",PRSESEL,VA200DA,PRSENAM(0),(9999999-PRSEDT),0)) I X="E" D
 .   I (+DA>0) K DR S DIE=452
 .   I PRSESEL="M" S DR="2;13;4T;33;2.1;13.5;15;20"
 .E  D
 ..S PRSELNG=+$P($G(^PRSE(452,DA,0)),U,16)
 ..S PRSENTR="",DR="2;13;6;4T;4.1;2.1;2.2//^S X=PRSELNG;2.3;"_"D SUPPR^PRSEED12;S:PRSENTR="""" Y=""@4"";"_"2.4///^S X=PRSENTR;D LOC^PRSEED3;13.5///^S X=PRSELOC;@4;11;15;20;I '(PRSESEL=""C"") S Y=""@1"";8;9;9.1;@1;33"
 ..Q
 .   D ^DIE
 .   I PRSESEL="C" D AAINFO
 .   K DIE,DR Q
 I X="D" D
 .   S DIK="^PRSE(452," I +DA>0 D ^DIK S NOUT=1
 .   W !,"** Entry Deleted **" K DIK
 .   Q
 Q
HELP W !!,$C(7),?9,"Answer 'D' to [D]elete 'E' to [E]dit or Press return to continue:",!
 Q
VALENT ;
 S PRSEBAD=0 F PRSE1=1:1 S PRSE2=$P(PRX,",",PRSE1) Q:PRSE2=""  D VAL0 Q:PRSEBAD
 Q
VAL0 I +PRSE2>PRSEMAX!(+PRSE2<1) S PRSEBAD=1
 I PRSE2["-",$P(PRSE2,"-")'?.N!($P(PRSE2,"-",2)'?.N)!(+$P(PRSE2,"-",2)>PRSEMAX)!(+$P(PRSE2,"-",2)<1)!(+PRSE2>PRSEMAX)!(+PRSE2<1) S PRSEBAD=1
 I PRSE2'["-",PRSE2'?.N!(+PRSE2>PRSEMAX)!(+PRSE2<1) S PRSEBAD=1
 I (PRX["?"!(PRSEBAD)) D  Q
 . W:PRX'?2"?" !!,?5,$C(7),"Make a selection from the screen display, a range of numbers can be",!,?5,"selected by using a HYPHEN, multiple selections can be made by"
 . W !,?5,"separating them by COMMAS, ",$S($G(PRSENALL)'>0:"select ALL ",1:""),"or '^' to exit."
 . W:PRX'?2"?" !,?15,"E.G. 1    1-2    1,3    1-2,4-5    1,3-4"
 . W:$G(PRSENALL)'>0 "    ALL"
 . W !,?22,"Are examples of valid selections" S:PRX?2."?" PRSESTRT=1
 . Q
 Q
AAINFO ;
 W !!,"Are you entering funding and A/A information into the student's record" S %=2 D YN^DICN I %=0 W $C(7),!!,"Answer YES or NO." G AAINFO
 G OUT:'(%=1)
 K DR S DR="7;18;19;16;17;55;66;77",DR(2,452.055)=".01;S:X=""N"" Y=""@1"";1;@1",DR(2,452.066)=".01;S:X=""N"" Y=""@2"";1//;@2" D ^DIE K DIE,DR
OUT I 'NDUPSW,'NSW W !!?9,PRSENAM(0),"   ",PRSESTUD,"   " S Y=PRSEDT D DT^DIQ S NSW=1
 Q
