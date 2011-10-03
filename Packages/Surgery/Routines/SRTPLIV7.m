SRTPLIV7 ;BIR/SJA - LIVER-DONOR INFORMATION ;03/04/08
 ;;3.0; Surgery ;**167**;24 Jun 93;Build 27
 I '$D(SRTPP) W !!,"A Transplant Assessment must be selected prior to using this option.",!!,"Press <RET> to continue  " R X:DTIME G END
 N SRX,SRY,SRZ
START Q:SRSOUT  D DISP
 W !!,"Select Transplant Information to Edit: " R X:DTIME I '$T!(X["^") S SRSOUT=1 G END
 I X="" G END
 S:X="a" X="A" I '$D(SRAO(X)),(X'?.N1":".N),(X'="A") D HELP G:SRSOUT END G START
 I X?1.2N1":"1.2N S Y=$P(X,":"),Z=$P(X,":",2) I Y<1!(Z>SRX)!(Y>Z) D HELP G:SRSOUT END G START
 I X="A" S X="1:"_SRX
 D HDR^SRTPUTL
 I X?1.2N1":"1.2N D RANGE G START
 I $D(SRAO(X)),+X=X S SREMIL=X D ONE G START
END D:'SRSOUT ^SRTPCOM W @IOF
 Q
HELP W @IOF,!!!!,"Enter the number or range of numbers you want to edit.  Examples of proper",!,"responses are listed below."
 W !!,"1. Enter 'A' to update all items.",!!,"2. Enter a number (1-"_SRX_") to update the information in that field.  (For example,",!,"   enter '1' to update Donor Race)"
 W !!,"3. Enter a range of numbers (1-"_SRX_") separated by a ':' to enter a range",!,"   of items.  (For example, enter '1:4' to update items 1, 2, 3 and 4.)",!
 W ! K DIR S DIR("A")="Press the return key to continue or '^' to exit: ",DIR(0)="FOA" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1
 Q
RANGE ; range of numbers
 S SRNOMORE=0,SRSHEMP=$P(X,":"),SRCURL=$P(X,":",2) F SREMIL=SRSHEMP:1:SRCURL Q:SRNOMORE  D ONE
 Q
ONE ; edit one item
 I SREMIL=1 D ^SRTPRACE Q
 K DR,DIE S DA=SRTPP,DR=$P(SRAO(SREMIL),"^",2)_"T",DIE=139.5 D ^DIE K DR S:$D(Y) SRNOMORE=1
 I SREMIL=11,($P($G(^SRT(SRTPP,3)),"^",2)'=""&($P($G(^SRT(SRTPP,3)),"^",2)'="NS")) S $P(^SRT(SRTPP,3),"^")="NS" Q
 I SREMIL=10,($P($G(^SRT(SRTPP,3)),"^")'=""&($P($G(^SRT(SRTPP,3)),"^")'="NS")) S $P(^SRT(SRTPP,3),"^",2)="NS" Q
 Q
DISP ; display fields
 S SRHPG="DONOR INFORMATION",SRPAGE="PAGE: "_$S(SRNOVA:"7",1:"5")_" OF "_$S(SRNOVA:7,1:5) D HDR^SRTPUTL
 K DR,SRAO S (DR,SRDR)="45;31;36;70;46;48;49;77;69;103;104;64;65;66;73;67;72" S SRAO(1)=""
 K DA,DIC,DIQ,SRX,SRY,SRZ S DIC="^SRT(",DA=SRTPP,DIQ="SRY",DIQ(0)="E",DR=SRDR D EN^DIQ1 K DA,DIC,DIQ,DR
 S (SRX,SRZ)=0 F I=1:1 S SRZ=$P(SRDR,";",I) Q:'SRZ  S SRX=I,SRAO(I+1)=SRY(139.5,SRTPP,SRZ,"E")_"^"_SRZ
 S SRX=SRX+1
 ; race information
 K SRY,SRZ S DIC="^SRT(",DR=44,DA=SRTPP,DR(139.544)=".01"
 S (II,JJ)=0 F  S II=$O(^SRT(SRTPP,44,II)) Q:'II  S SRACE=$G(^SRT(SRTPP,44,II,0)) D  K SRY
 .S DA(139.544)=II,DIQ="SRY",DIQ(0)="E" D EN^DIQ1
 .S JJ=JJ+1,SRZ(139.544,JJ)=SRACE_"^"_$G(SRY(139.544,II,.01,"E")),SRZ(139.544)=JJ
 D RACE
 W !,"1.  Donor Race:" S SRAO(1)="" I $G(SRZ(139.544)) F D=1:1:SRNUM1-1 W:D=1 ?21,SROL(D) W:D'=1 !,?21,SROL(D)
 W !,"2.  Donor Gender:",?21,$P(SRAO(2),"^")
 W !,"3.  Donor Height:",?21,$P(SRAO(3),"^"),?42,"HLA Typing (#,#,#)"
 W !,"4.  Donor Weight:",?21,$P(SRAO(4),"^"),?42,"=================="
 W !,"5.  Donor DOB:",?21,$P(SRAO(5),"^"),?42,"13. Donor HLA-A:  ",$P(SRAO(13),"^")
 W !,"6.  Donor Age:",?21,$P(SRAO(6),"^"),?42,"14. Donor HLA-B:  ",$P(SRAO(14),"^")
 W !,"7.  ABO Blood Type:",?21,$P(SRAO(7),"^"),?42,"15. Donor HLA-C:  ",$P(SRAO(15),"^")
 W !,"8.  Donor CMV:",?21,$P(SRAO(8),"^"),?42,"16. Donor HLA-DR: ",$P(SRAO(16),"^")
 W !,"9.  Substance Abuse:",?21,$P(SRAO(9),"^"),?42,"17. Donor HLA-BW: ",$P(SRAO(17),"^")
 W !,"10. Deceased Donor:",?21,$P($P(SRAO(10),"^"),"("),?42,"18. Donor HLA-DQ: ",$P(SRAO(18),"^")
 W !,"11. Living Donor:",?21,$P(SRAO(11),"^")
 W !,"12. With Malignancy:",?21,$P(SRAO(12),"^")
 W !!,SRLINE
 Q
RACE ;Find all race entries and place into a string with commas inbetween
 K SROL S SRORC=0,C=1,SRORACE="",SROLINE="",N=1,SROL=""
 F  S SRORC=$O(SRZ(139.544,SRORC)) Q:SRORC=""  Q:C=11  D
 .I $D(SRZ(139.544,SRORC)) S SRORACE(C)=$P(SRZ(139.544,SRORC),"^",2)
 .I SROLINE'="" S SROLINE=SROLINE_", "_SRORACE(C)
 .I SROLINE="" S SROLINE=SRORACE(C)
 .S C=C+1
 ;Find total length of 'race' string and wrap the text if necessary
 I $L(SROLINE)=45!$L(SROLINE)<45 S SROL(N)=SROLINE,SRNUM1=2
 I $L(SROLINE)>45 D WRAP
 K SROLINE,SRORC,SRORACE,SROLN,SROLN1,SROWRAP
 Q
WRAP ;Wrap multiple race entries so that wrapped line
 ;does not break in the middle of a word
 ;
 S SROLNGTH=$L(SROLINE),E=45,SROWRAP="",SROLN="",SROLN1="",SROL=""
 F I=1:45:SROLNGTH S SROLN(I)=SROWRAP_$E(SROLINE,I,E) D
 .F K=45:-1:1 I $E(SROLN(I),K)[" " D  Q    ;Break lines at space
 ..S SROLN1(I)=$E(SROLN(I),1,K-1)
 ..S SROWRAP=$E(SROLN(I),K+1,E)
 .S E=E+45
 ;
 S:'$D(SROLN1(I)) SROLN1(I)=SROLN(I),SROWRAP=""
 I $L(SROLN1(I))+$L(SROWRAP)>44 S SROLN1(I+1)=SROWRAP   ;Last line 
 I $L(SROLN1(I))+$L(SROWRAP)'>44 S SROLN1(I)=SROLN1(I)_" "_SROWRAP
 ;
 ;Renumber the SROLN1 array to be in numeric order
 S SRNUM=0,SRNUM1=1
 F  S SRNUM=$O(SROLN1(SRNUM)) Q:SRNUM=""  D
 .S SROL(SRNUM1)=SROLN1(SRNUM)
 .S SRNUM1=SRNUM1+1
 Q
