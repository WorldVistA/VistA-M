RCEVUTL1 ;WASH-ISC@ALTOONA,PA/LDB-Generic Event Utilities ;2/28/95  8:36 AM
V ;;4.5;Accounts Receivable;;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
DATE(RANGE) ;Select date range or range of activity
 ;RANGE=$P1 (Prompt for type of range)
 ;      $P2 (Prompt for default for beginning of range) NULL is FIRST
 ;      $P3 (Prompt for default for end of range) NULL is LAST
 ;      $P4 (%DT variable will be set to this type of date)
 ;      $P5 (%DT(0) variable will be set to this date constraint)
 N %DT,DATE,FDT,X,Y
BEG ;Select beginnning of range
 S %DT=$S($P(RANGE,"^",4)]"":$P(RANGE,"^",4),1:"T")
 S:$P(RANGE,"^",5)]"" %DT(0)=$P(RANGE,"^",5)
 S FDT=$S($P(RANGE,"^",2)]"":$$SLH^RCFN01($P(RANGE,"^",2)),1:"FIRST")
 W !,"Enter the beginning "_$S($P(RANGE,"^")]"":$P(RANGE,"^"),1:"DATE")_" : "_FDT_"// " R X:DTIME
 I '$T!(X="^") S Y=-1 Q Y
 I X="?" W !,"Examples of Valid Date: JAN 20 1957 or 20 JAN 57 or 1/20/57 or 012057" G BEG
 I X="" S (X,Y)=$P(RANGE,"^",2)
 I X]"" D ^%DT G:Y=-1 BEG
 S DATE=+Y X ^DD("DD") W " ",Y
 ;
END ;Select ending of range
 S %DT=$S($P(RANGE,"^",4)]"":$P(RANGE,"^",4),1:"T")
 S:$P(RANGE,"^",5)]"" %DT(0)=$P(RANGE,"^",5)
 W !,"Enter the ending "_$S($P(RANGE,"^")]"":$P(RANGE,"^"),1:"DATE")_" : "_$S($P(RANGE,"^",3)]"":$$SLH^RCFN01($P(RANGE,"^",3)),1:"LAST")_"// " R X:DTIME
 I '$T!(X="^") S Y=-1 Q Y
 I X="?" W !,"Examples of Valid Date: JAN 20 1957 or 20 JAN 57 or 1/20/57 or 012057" G END
 I X="" S X=$S($P(RANGE,"^",3)]"":$P(RANGE,"^",3),1:"")
 I X="" S Y=0 S DATE=DATE_"^"_Y Q DATE
 I X]"" D ^%DT D  G:Y=-1 END
 .I Y<DATE W !,*7,"Must be equal to or greater than beginning "_$S($P(RANGE,"^")]"":$P(RANGE,"^",2),1:"DATE"),!,*7 S Y=-1
 S DATE=DATE_"^"_+Y X ^DD("DD") W " ",Y
 Q DATE
 ;
