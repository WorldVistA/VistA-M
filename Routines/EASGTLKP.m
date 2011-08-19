EASGTLKP ;ALB/CKN - GMT THRESHOLD LOOKUP ; 10/11/02 1:23pm
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**13**;MAR 15,2001
 Q
EP ;
 N STR,ZIP,COUNTY,STATE,DONE,TXT1,THRSHLD
 S DONE=0,$P(STR,"=",79)="="
 S TXT1="GMT Threshold Lookup by Zip Code or City"
 W !,TXT1,!,$E(STR,1,$L(TXT1))
 F  D  Q:DONE
 . D ASKZIP Q:DONE
 . D PROC
 Q
ASKZIP ;Prompt user for valid Postal code
 N Y,TXT
 S DIR(0)="P^5.12:QEM",DIR("A")="ZIP Code"
 S TXT="Zip Code is invalid; there is no GMT Threshold associated with this value."
 S DIR("PRE")="I $$CHK^EASGTLKP(X) W !!,TXT,!"
 S DIR("?")="Enter the ZIP code [5 - 12 characters] that you wish to select."
 D ^DIR K DIR
 I $D(DIRUT) S DONE=1 Q
 I $D(DUOUT) S DONE=1 Q
 S ZIP=$P(Y,"^",2)
 Q
 ;
CHK(X) ;
 I +X=0 Q 0
 I X'="",X'="^",'$D(^XIP(5.12,"B",X)),'$D(^XIP(5.12,"C",X)) Q 1
 Q 0
 ;
PROC ;Lookup in GMT threshold file 712.5 for appropriate GMT Thresholds
 N FIPS,DATA,YR,XIP,REC513,REC7125
 S DATA=$$FIPS^EASAILK(ZIP)  ;get FIPS code for entered ZIP code
 I '+DATA W !,"GMT Thresholds not found for entered ZIP code." Q
 S YR=($E($$NOW^XLFDT(),1,3)-1)_"0000"
 S REC7125=$P($G(DATA),"^",3),FIPS=$P($G(DATA),"^")
 I '+REC7125 W !,"GMT Threshold is not available for entered ZIP code." Q
 S STATE=$P($G(^EAS(712.5,REC7125,0)),"^",3)
 I STATE'="" S STATE=$P($G(^DIC(5,STATE,0)),"^")
 S COUNTY=$P($G(^EAS(712.5,REC7125,0)),"^",4)
 D PRINT
 Q
PRINT ;Display GMT thresholds
 N J,K,TEXT
 W !!,"County Name: ",COUNTY
 I STATE'="" W !,"State: ",STATE,!,STR
 W !,"Year",?10,"ZIP Code",?27,"FIPS Code",?40,"# in Household",?60,"GMT Threshold"
 W !,STR
 F J=1:1:8 D
 . S THRSHLD=$P($G(^EAS(712.5,REC7125,1)),"^",J) W !
 . I J=1 W $$FMTE^XLFDT(YR),?12,ZIP,?29,FIPS
 . W ?46,(J),?63,"$"_$FN(THRSHLD,",")
 W !,STR
 S DIR(0)="E" D ^DIR K DIR
 W @IOF
 F K=1:1 S TEXT=$P($T(NOTE+K),";;",2) Q:TEXT="EXIT"  W !,TEXT
 Q
NOTE ;;
 ;;
 ;;**NOTE**
 ;;
 ;;Family Size Adjustments
 ;;The statutory guidance governing income limits requires that income limits are
 ;;to be higher for larger families and lower for smaller families. The same family
 ;;size adjustments are used for all income limits. They are as follows:
 ;;
 ;;Number of Persons in Family and Percentage Adjustments
 ;; 1       2       3       4       5       6       7       8
 ;;70%     80%     90%    Base     108%    116%    124%    132%
 ;;
 ;;Income limits for families with more than eight persons are not included in the
 ;;printed lists because of space limitations. For each person in excess of eight,
 ;;8% of the four-person base should be added to the eight-person income limit.
 ;;(For example, the nine-person limit equals 140 percent[132+8] of the relevant
 ;;base income limit.) Income limits are rounded to the nearest $50.
 ;;(Source of information - HUD)
 ;;
 ;;EXIT
