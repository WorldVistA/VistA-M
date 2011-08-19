PRCGF424 ;;VMP/RGB  IFCAP 424/424.1 FILE CLEANSING ;12/10/97  9:48 AM
V ;;5.1;IFCAP;**115**;Oct 20, 2000;Build 12
 ;Cleanse files 424 and 424.1:
 ;FIND OLD 424.1-1358 DETAIL WITH 10 YEAR OLD 424-1358 DAILY REC
 ;  1. Find 424 with missing 0 node
 ;  2. Find 424 entries with null file #442-Obligation pointer
 ;  3. Find 424 entries with invalid file #442-Obligation pointer
 ;
 ;  5. Find 424.1 with missing 0 node
 ;  6. Find 424.1 with null file #424-1358 Daily record pointer
 ;  7. Find 424.1 with invalid file #424-1358 Daily record pointer
 ;  8. Find 424.1 with file #424-1358 Daily record pointer 10 yrs in future
 ;      due to re-using fiscal year single LAST digit in Auth #
 ;  9. Find 424.1 with missing date
 ; 10. Find 424 with missing date
 Q
CHK ;START FILE 424 CLEANSING
 D NOW^%DTC
 S CFY=$E(X,1,3)+1700,CFY=$S(+$E(X,4,5)>9:CFY+1,1:CFY)
 F  D  Q:AFY>0!($D(OUT))
 . S DIR(0)="D^::E",DIR("A")="Select the Fiscal Year thru which this option is to run"
 . S DIR("?",1)="Enter a valid FileMan date.  If you select an exact date, I will",DIR("?")="convert it to the last day of the FISCAL YEAR."
 . D ^DIR
 . S AFY=0
 . I X["^"!(X="") S X="<  No action taken>*" D MSG^PRCFQ S OUT=1 QUIT
 . Q:Y<0
 . S FY=Y
 . I $E(FY,4,5)>9 S FY=($E(FY,1,3)+1)_"0930"
 . E  S FY=$E(FY,1,3)_"0930"
 . S AFY=$E(FY,1,3)+1700,LFY=$E(FY,3)
 . I CFY-AFY<3 S X="You may only select for archive those documents which are greater than 2 Fiscal Years old.*" D MSG^PRCFQ S AFY=0 QUIT
 I $D(OUT) K OUT QUIT
0 ;SAVE FILES
BUILD W ! K ^XTMP("PRCGF424") D NOW^%DTC S RMSTART=%
 S ^XTMP("PRCGF424","START COMPILE")=RMSTART
 S ^XTMP("PRCGF424","END COMPILE")="RUNNING"
 S ^XTMP("PRCGF424",0)=$$FMADD^XLFDT(RMSTART,90)_"^"_RMSTART
1 ;CHECK 424 OBLIGATION POINTER TO 442
 S IEN=0,U="^",TH=1
2 S IEN=$O(^PRC(424,IEN)) G CHK1:IEN=""!(IEN]"@")
 S X=$P($H,",",2) I X'=TH,X#5=0 W "." S TH=X
 S R=$G(^PRC(424,IEN,0)),OBNO=$P(R,U,2)
 I R="" S TYP=1 G 3
 I OBNO="" S TYP=2 G 3
 I $D(^PRC(442,OBNO,0)) G 2
 S TYP=3
3 ;KILL BAD 424 RECORD
 S ^XTMP("PRCGF424",424,TYP,IEN,0)=R
 S DA=IEN,DIK="^PRC(424," D ^DIK K DA,DIK
 G 2
CHK1 ;START FILE 424.1 CLEANSING
 S U="^",IEN=0
10 S IEN=$O(^PRC(424.1,IEN)) G EXIT:IEN=""!(IEN]"@")
 S X=$P($H,",",2) I X'=TH,X#5=0 W "." S TH=X
 S R=$G(^PRC(424.1,IEN,0))
 I R="" S TYP=5 G 11
 S IEN424=$P(R,U,2),DT=$P(R,U,4),DT1=$E(DT,1,3)
 I IEN424="" S TYP=6 G 11
 S R4=$G(^PRC(424,IEN424,0))
 I R4="" S TYP=7 G 11
 I DT1="" S TYP=9 G 11
 S DTA=$P(R4,U,7) I DTA="" S TYP=10 G 11
 S DTA1=$E(DTA,1,3)
 I DTA1-DT1<9 G 10
 S TYP=8
 S TYP=8
11 ;KILL BAD 424.1 RECORD
 S ^XTMP("PRCGF424",424.1,TYP,IEN,0)=R S:TYP>7 ^XTMP("PRCGF424",424.1,TYP,IEN,1)=R4
 I TYP>8 G 10
 S DA=IEN,DIK="^PRC(424.1," D ^DIK K DA,DIK
 G 10
EXIT ;
 D NOW^%DTC S RMEND=%
 S ^XTMP("PRCGF424","END COMPILE")=RMEND
 W !!,"CLEANSING OF FILES 424/424.1 COMPLETED"
 K CFY,X,Y,AFY,OUT,FY,LFY,RMSTART,RMEND,IEN,TH,R,R4,OBNO,TYP,DA,DIK,IEN424,DT1,DTA,DTA1,A
 Q
LOOK ;SEARCH POINTERS
 S A=0
 F I=1:1 S A=$O(^PRC(424,"C",99627662,A)) Q:A=""  D
 . S R=^PRC(424,A,0)
 . W !,A," - ",R
 Q 
