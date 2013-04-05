PSJDDUT2 ;BIR/LDT-INPATIENT MEDICATIONS DD UTILITY ; 7/28/09 6:48am
 ;;5.0;INPATIENT MEDICATIONS ;**184,248**;16 DEC 97;Build 6
 ;
ENDLP ;Called from Inpatient User Parameters file (53.45), Label Printer
 ;field .07 (Replaces ENDLP^PSGSET)
 ;BHW - HD168525 - Don't default when user exits (POP) if LABEL DEVICE or REPORT DEVICE already defined.
 ;PSJ*5*248 - Fix label and report devices
 I POP,(DIFLD=13)&($L($P($G(^PS(59.5,DA,0)),U,2))) S X=$P($G(^PS(59.5,DA,0)),U,2) Q  ;HD168525 - Check LABEL DEVICE
 I POP,(DIFLD=14)&($L($P($G(^PS(59.5,DA,0)),U,3))) S X=$P($G(^PS(59.5,DA,0)),U,3) Q  ;HD168525 - Check REPORT DEVICE
 S PSGION=$S($D(ION):ION,1:"HOME") K %ZIS S %ZIS="QN",IOP=X D ^%ZIS I POP S IOP=PSGION D ^%ZIS K %ZIS,IOP,PSGION S X="" Q
 D EN^DDIOL($S(X=$E(ION,1,$L(X)):$E(ION,$L(X)+1,$L(ION)),1:"  "_ION),"","?0") S X=ION D ^%ZISC K %ZIS,PSGION,IOP Q
 ;
ADTM ;Called from Unit Dose Multiple of the Pharmacy Patient file (55.06),
 ;Admin Times field 41
 S PSJHLP(1)="THE TIMES MUST BE TWO (2) OR FOUR (4) DIGITS, SEPARATED WITH DASHES"
 S PSJHLP(2)="(-), AND BE IN ASCENDING ORDER. (IE. 01-05-13)"
 D WRITE
 Q
 ;
 ;
SITE ;Called from Inpatient Site file (59.4), field .01 (Replaces ^PSGRPNT)
 S Q=0 F QQ=-1:1 S Q=$O(^PS(59.4,Q)) Q:'Q
 I 'QQ S PSJHLP(1)="THIS IS YOUR ONLY SITE!",PSJHLP(1,"F")="$C(7),!!",PSJHLP(2)="(You must create another site before you can delete this one.)",PSJHLP(2,"F")="!" D WRITE Q
 ;
ENMARD() ; validate MAR SELECTION DEFAULT string in WARD PARMS file (59.6).
 ;(Replaces ENMARD^PSJUTL())
 N PSJANS,PSJX1,PSJX2,RANGE,Q
 S RANGE="1:6" F PSJX1=1:1:6 S RANGE(PSJX1)=""
 S:$E(X)="-" X=+RANGE_X S:$E($L(X))="-" X=X_$P(RANGE,":",2)
 S PSJANS="" F Q=1:1:$L(X,",") S PSJX1=$P(X,",",Q) D FS Q:'$D(PSJANS)
 Q:'$G(PSJANS) 0
 S PSJANS=$E(PSJANS,1,$L(PSJANS)-1) F Q=1:1:$L(PSJANS,",") D  Q:'$D(PSJANS)
 .I $P(PSJANS,",",Q)=1,$L(PSJANS,",")>1 D EN^DDIOL("All Medications (1) may not be selected in combination with other types.","","!!") K PSJANS Q
 .D EN^DDIOL($P(PSJANS,",",Q)_" - "_$P($T(@$P(PSJANS,",",Q)),";;",2),"","!?47")
 S:$G(PSJANS) X=PSJANS Q $G(PSJANS)
 ;
FS ;
 I $S(PSJX1?1.N1"-"1.N:0,PSJX1'?1.N:1,'$D(RANGE(PSJX1)):1,1:","_PSJANS[PSJX1) K PSJANS Q
 I PSJX1'["-" S PSJANS=PSJANS_PSJX1_"," Q
 S PSJX2=+PSJX1,PSJANS=PSJANS_PSJX2_","
 F  S PSJX2=$O(RANGE(PSJX2)) K:$S(X="":1,","_PSJANS[PSJX2:1,1:PSJX2>$P(PSJX1,"-",2)) PSJANS Q:'$D(PSJANS)  S PSJANS=PSJANS_PSJX2_"," Q:PSJX2=$P(PSJX1,"-",2)
 Q
 ;
ENMARDH ;Help text for MAR default answer. (Replaces ENMARDH^PSJUTL)
 S PSJHLP(1)="Enter the number corresponding to the type of orders to be included on"
 S PSJHLP(1,"F")="!!?2"
 S PSJHLP(2)="MARs printed for this ward. Multiple types (except 1) may be selected"
 S PSJHLP(3)="using ""-"" or "","" as delimiters."
 S PSJHLP(4)="Choose from: "
 S PSJHLP(4,"F")="!!"
 S PSJHLP(5)="1 - All Medications"
 S PSJHLP(5,"F")="!?13"
 S PSJHLP(6)="2 - Non-IV Medications only"
 S PSJHLP(6,"F")="!?13"
 S PSJHLP(7)="3 - IV Piggybacks"
 S PSJHLP(7,"F")="!?13"
 S PSJHLP(8)="4 - LVPs"
 S PSJHLP(8,"F")="!?13"
 S PSJHLP(9)="5 - TPNs"
 S PSJHLP(9,"F")="!?13"
 S PSJHLP(10)="6 - Chemotherapy Medications (IV)"
 S PSJHLP(10,"F")="!?13"
 D WRITE
 Q
 ;
ENSTH ;Executable help for type of schedule. (Replaces ENSTH^PSJSV0)
 N PSJX S PSJX=1
 S PSJHLP(PSJX)="The TYPE OF SCHEDULE determines how the schedule will be processed."
 S PSJHLP(PSJX,"F")="!!?2",PSJX=PSJX+1
 S PSJHLP(PSJX)="A CONTINUOUS schedule is one in which an action is to take place on a"
 S PSJHLP(PSJX,"F")="!!?2",PSJX=PSJX+1
 S PSJHLP(PSJX)="regular basis, such as 'three times a day' or 'once every two days'."
 S PSJHLP(PSJX,"F")="!",PSJX=PSJX+1
 S PSJHLP(PSJX)="A DAY OF THE WEEK schedule is one in which the action is to take"
 S PSJHLP(PSJX,"F")="!?2",PSJX=PSJX+1
 S PSJHLP(PSJX)="place only on specific days of the week.  This type of schedule"
 S PSJHLP(PSJX,"F")="!",PSJX=PSJX+1
 S PSJHLP(PSJX)="should have admin times entered with it.  If not, the start time of"
 S PSJHLP(PSJX,"F")="!",PSJX=PSJX+1
 S PSJHLP(PSJX)="the order is used as the admin time.  Whenever this type is chosen,"
 S PSJHLP(PSJX,"F")="!",PSJX=PSJX+1
 S PSJHLP(PSJX)="the name of the schedule must be in the form of 'MO-WE-FR'."
 S PSJHLP(PSJX,"F")="!",PSJX=PSJX+1
 G:$S('$D(PSJPP):1,PSJPP="":1,1:PSJPP="PSJ") HOT
 S PSJHLP(PSJX)="A DAY OF THE WEEK-RANGE schedule is one in which the action to take"
 S PSJHLP(PSJX,"F")="!?2",PSJX=PSJX+1
 S PSJHLP(PSJX)="place only on specific days of the week, but at no specific time of"
 S PSJHLP(PSJX,"F")="!",PSJX=PSJX+1
 S PSJHLP(PSJX)="day (no admin times).  Whenever this type is chosen, the name of the"
 S PSJHLP(PSJX,"F")="!",PSJX=PSJX+1
 S PSJHLP(PSJX)="schedule must be in the form of 'MO-WE-FR'."
 S PSJHLP(PSJX,"F")="!",PSJX=PSJX+1
HOT S PSJHLP(PSJX)="A ONE-TIME schedule is one in which the action is to take place once"
 S PSJHLP(PSJX,"F")="!?2",PSJX=PSJX+1
 S PSJHLP(PSJX)="only at a specific date and time."
 S PSJHLP(PSJX,"F")="!",PSJX=PSJX+1
 I $S('$D(PSJPP):1,PSJPP="":1,1:PSJPP="PSJ") D WRITE Q
 S PSJHLP(PSJX)="A RANGE schedule is one in which the action will take place within a"
 S PSJHLP(PSJX,"F")="!?2",PSJX=PSJX+1
 S PSJHLP(PSJX)="given date range."
 S PSJHLP(PSJX,"F")="!",PSJX=PSJX+1
 S PSJHLP(PSJX)="A SHIFT schedule is one in which the action will take place within a"
 S PSJHLP(PSJX,"F")="!?2",PSJX=PSJX+1
 S PSJHLP(PSJX)="given range of times of day."
 S PSJHLP(PSJX,"F")="!",PSJX=PSJX+1
 D WRITE
 Q
WRITE ;Calls EN^DDIOL to write text
 D EN^DDIOL(.PSJHLP) K PSJHLP
 Q
1 ;;All Medications
2 ;;Non-IV Medications only
3 ;;IV Piggybacks
4 ;;LVPs
5 ;;TPNs
6 ;;Chemotherapy Medications (IV)
