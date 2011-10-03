PRSARC04 ;WOIFO/JAH - Recess Tracking Functions ;11/1/06
 ;;4.0;PAID;**112**;Sep 21, 1995;Build 54
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
GETFSCYR(PRSDT) ; Given a date get the 9-month AWS fiscal year.
 ; This is the fiscal year during which the 9-month AWS is effective.
 ; The fiscal year for 2006 (FY06, sometimes written FY05-06) is from
 ; October 1, 2005 through September 30, 2006.  However, the fiscal
 ; year for purposes of the 9-month AWS will be governed also by
 ; complete pay periods, since the nurses normal hours=80 and duty
 ; basis = part-time, must be in effect for the entire pay period.
 ; Thus some 9-month AWS fiscal years may have 50, 52 or 54 weeks. 
 ; The fiscal year is defined as the 12 months from the first full
 ; pay period after October 1 through the pay period that contains
 ; September 30.  In the example below September 30, 2007 is the
 ; first day of the pay period 20 and thus the entire pay period is
 ; included in the weeks for the 9-month AWS schedule for FY07. 
 ;          
 ;            Week    PayPd Sun Mon Tue Wed Thu Fri Sat
 ;          
 ;                    =============Oct 2006============
 ;              1     06-20   1   2   3   4   5   6   7
 ;              2             8   9  10  11  12  13  14
 ;              3     06-21  15  16  17  18  19  20  21
 ;              ...
 ;          
 ;             51     07-19  16  17  18  19  20  21  22
 ;             52            23  24  25  26  27  28  29
 ;             53     07-20  30   1   2   3   4   5   6
 ;                    =============Oct 2007============
 ;             54             7   8   9  10  11  12  13
 ;
 ; Get pay period with PRSDT and the 1st day of that pp
 N X1,X2,%H,X,D1,PPE,YR,DAY,TMPYR,FFPPE,PPE,FISCALYR,PPDT1,FY1,FY2,FYLONG
 S D1=PRSDT D PP^PRSAPPU
 S FFPPE=PPE
 S X2=(1-DAY),X1=PRSDT D C^%DTC S PPDT1=X
 S TMPYR=$E(PPDT1,1,3)
 S FISCALYR=$S(PPDT1'>(TMPYR_"0930"):TMPYR,1:TMPYR+1)_"0000"
 S YR=$E(FISCALYR,1,3)
 S FY1=$E($E(YR,1,3)-1,2,3)
 S FYLONG=1700+YR
 S FY2=$E(YR,2,3)
 Q FISCALYR_"^"_"FY"_FYLONG_"^"_"FY"_FY1_"-"_FY2
 ;
FYDAYS(FSCYR) ; Given a fiscal year get the PAID ETA start and stop
 ; dates (i.e. the first day of the first pay period of the fiscal
 ; year and the last day of the last pay period in the fiscal year.
 ; see GETFSCYR for fiscal year info
 ;
 Q:($G(FSCYR)'>1992)!($G(FSCYR)>2106) "input date out of range"
 ;
 N X1,X2,%H,X,D1,PPE,DAY,END,START,ENDPPE,FYENDT,FYSTDT,STRTPPE
 ;
 ; The start pay period can't contain the date Sept 30.
 ;
 S START=FSCYR-1701
 S D1=START_"0930" D PP^PRSAPPU
 S X2=(15-DAY),X1=D1 D C^%DTC S FYSTDT=X
 S D1=FYSTDT D PP^PRSAPPU
 S STRTPPE=PPE
 ;
 ; the end pay period must contain sept 30
 ;
 S END=FSCYR-1700
 S D1=END_"0930" D PP^PRSAPPU
 S ENDPPE=PPE
 S X2=(14-DAY),X1=D1 D C^%DTC S FYENDT=X
 ;
 Q FYSTDT_"^"_FYENDT_"^"_STRTPPE_"^"_ENDPPE
 ;
GETPPDY(PRSDT) ; Given FM date--PRSDT--Get pay period + 1st day of that pp
 N X1,X2,%H,X,D1,PPE,PPD1
 S D1=PRSDT D PP^PRSAPPU
 S FFPPE=PPE
 S X2=(1-DAY),X1=PRSDT D C^%DTC S PPD1=X
 Q PPD1_U_PPE
 ;
ALLFYAWS() ; Ask user if AWS will cover the entire Fiscal Year
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT,FY
 S DIR(0)="Y"
 S DIR("B")="NO"
 S DIR("A")="Does the AWS cover the entire fiscal year"
 S DIR("?")="Enter Y for Yes or N for No."
 S DIR("?",1)="  If the Nurse is starting the fiscal year on the"
 S DIR("?",2)="  9 Month AWS then answer YES.  If they are starting"
 S DIR("?",3)="  the AWS in a pay period after the 1st pay period"
 S DIR("?",4)="  of the fiscal year then answer NO."
 D ^DIR
 Q:$D(DIRUT) -1
 Q Y
 ; 
 ;
 ;
FYWEEKS(WKARRAY,FY,SD) ; RETURN ARRAY WITH WEEKS
 ; INPUT:
 ;   FY - fiscal year in 4 digit format
 ;   SD - (optional) set to 1 if you want week numbers in the subscript
 ;        otherwise subscript will be fmdates.
 ;
 N FD,LD,PRSFYRNG
 ;
 ; get range of dates for FY (PRS
 ; cleaned up at exit from LM)
 ;
 S PRSFYRNG=$$FYDAYS(FY)
 ;
 S FD=$P(PRSFYRNG,U,1)
 S LD=$P(PRSFYRNG,U,2)
 ; Build an array with FMdate for first day of each week in the FY
 ;
 D WKSDAY1(.WKARRAY,FD,LD,$G(SD))
 Q
 ;
GETAVHRS(FMWKS,PRSDT) ; calculate the number of weeks in the AWS fiscal year
 ; from the input date and the hours available for recess from that
 ; date
 ; INPUT: PRSDT-must be a first day of a pay period in the input array
 ;        FMWKS-array produced from FYWEEKS call in this routine.
 ; OUTPUT: 
 ;  # of FY weeks from PRSDT ^ available recess hrs ^ avail recess weeks
 ;
 N FRSTWK,LASTWK,WKS,HRS,AVWKS
 Q:'$D(FMWKS($G(PRSDT))) 0
 S FRSTWK=$G(FMWKS(PRSDT))
 S LASTWK=$O(FMWKS(9999999),-1),LASTWK=$G(FMWKS(LASTWK))
 S WKS=LASTWK-FRSTWK+1
 S HRS=WKS*40*.25
 S AVWKS=WKS*.25
 Q WKS_U_HRS_U_AVWKS
 ;
 ;
WKSDAY1(WKARRAY,FD,LD,SF) ;Build FY week array
 ;
 ; INPUT FD = fm first day of ETA type fiscal year (i.e. Sunday of pp)
 ;       LD = last day ETA fiscal year
 ;       SF = optional subscript flag = 1 use week otherwise use FMDAY
 ;
 ; OUTPUT WKARRAY = ARRAY for weeks in a Fiscal Year with
 ;                 (Subscript) = FMdate 
 ;                     Value   = FY WEEK of 1st day of week.
 ;
 N SUBS,WKD1,WEEK,X1,X2,X,VALUE
 I $G(SF)=1 S SUBS="WEEK",VALUE="WKD1"
 E  S SUBS="WKD1",VALUE="WEEK"
 S WKD1=FD,WEEK=1
 F  D  Q:WKD1>$G(LD)
 .  S WKARRAY(@SUBS)=@VALUE
 .  S WEEK=WEEK+1
 .  S X2=7,X1=WKD1 D C^%DTC S WKD1=X
 Q
ALLOKEY(PRSNURSE) ; Allocate security key to the NURSE if they don't hold it
 ;
 ; determine associated NEW PERSON entry
 Q:+$G(PRSNURSE)'>0
 Q:'$O(^PRST(458.8,"B",+PRSNURSE,0))
 N SSN,IEN200
 S SSN=$$GET1^DIQ(450,+PRSNURSE_",",8,"I")
 S IEN200=$S(SSN="":"",1:$O(^VA(200,"SSN",SSN,0)))
 I 'IEN200 D  Q
 . W $C(7),!!,"Can't find this nurse in the NEW PERSON file.  This must"
 . W !,"be corrected before they can view their schedule and the"
 . W !,"PRSAWS9 security key may need to be allocated to this nurse."
 . S SSN=$$ASK^PRSLIB00(1)
 ;
 I '$D(^XUSEC("PRSAWS9",IEN200)) D
 . W !,"... allocating PRSAWS9 security key for this nurse." H 1 W !!
 . N KEYIEN,PRSFDA,PRSIENS
 . S KEYIEN=$$FIND1^DIC(19.1,,"X","PRSAWS9")
 . I 'KEYIEN D  Q
 . . W !!,"The PRSAWS9 key is missing from file 19.1."
 . S PRSFDA(200.051,"?+1,"_IEN200_",",.01)=KEYIEN
 . S PRSIENS(1)=KEYIEN
 . D UPDATE^DIE("","PRSFDA","PRSIENS"),MSG^DIALOG()
 ;
 Q
