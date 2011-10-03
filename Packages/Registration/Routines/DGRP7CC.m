DGRP7CC ;BAJ,EG - REGISTRATION SCREEN 7/CROSS REFERENCE CLEANUP ;10/24/2006
 ;;5.3;Registration;**657**;Aug 13, 1993;Build 19
EN ; entry point
 ;
 ; Code to TRIGGER deletion of field data.
 N DGENDA,DATA,VAL,ERROR,CNT,FIELD,X
 S DGENDA=DA
 I $$CHNGD(DFN) D
 . ;need to kill this node or the deletes won't work...
 . ;you get a message that patient is not a veteran
 . K ^DPT(DFN,"VET")
 . F CNT=1:1 S FIELD=$P($T(DATA+CNT),";;",3) Q:FIELD="QUIT"  D
 .. S VAL=$S(FIELD=.301:"N",1:"@")
 .. S DATA(FIELD)=VAL
 .. Q
 . S X=$$UPD^DGENDBS(2,DGENDA,.DATA,.ERROR)
 . ; delete Service Related Conditions if NON-Vet
 . D DELSVC(DFN)
 . ;remove service connected and compensation connected eligibilities
 . S X=$$OELIG(DFN)
 . S ^DPT(DFN,"VET")="N"
 . Q
 Q
 ;
 ;
CHNGD(DFN)  ; logic to determine if value has changed
 N Y,X
 ; if a new entry read the array
 I '$D(^DPT(DFN,"VET")) D  Q X
 . S Y(1)=$C(59)_$P($G(^DD(2,1901,0)),U,3) S X=$P($P(Y(1),$C(59)_Y(0)_":",2),$C(59))="NO"
 ; 
 ; else read the "VET" value
 S Y(2)=$C(59)_$P($G(^DD(2,1901,0)),U,3),Y(1)=$S($D(^DPT(DFN,"VET")):^DPT(DFN,"VET"),1:"") S X=$P($P(Y(2),$C(59)_$P(Y(1),U,1)_":",2),$C(59))="NO"
 ;
 ; Return 0 for VET, 1 for NON-Vet
 Q X
 ;
DELSVC(DFN) ; Delete Service Connected Conditions
 N DA,DIK
 S DIK="^DPT("_DFN_",.373,"
 S DA=0 F  S DA=$O(^DPT(DFN,.373,DA)) Q:DA=""  D ^DIK
 Q
 ;
OELIG(DFN) ;remove sc codes from other eligibility
 N DA,DIK,OLD,VAL,IEN,DE
 S DIK="^DPT("_DFN_","_$C(34)_"E"_$C(34)_","
 S DA=0 F  S DA=$O(^DPT(DFN,"E",DA)) Q:DA=""  D
 . S IEN=$P($G(^DPT(DFN,"E",DA,0)),"^",1) I IEN="" Q
 . S VAL=$P($G(^DIC(8,IEN,0)),"^",1)
 . I $T(NVETNSC)'[(";"_VAL_";") Q
 . S DA(1)=DFN
 . D ^DIK
 . Q
 Q 1
DATA ;These are the fields to be changed
 ;;Receiving A&A;;.36205
 ;;Amount of A&A;;.3621
 ;;Receiving Housebound;;.36215
 ;;Amount of Housebound;;.3622
 ;;Receiving VA Pension;;.36235
 ;;Service Connected;;.301
 ;;Service Connected %-age;;.302
 ;;SC Award Date;;.3012
 ;;Eff. Date Combined SC% Eval;;.3014
 ;;Rated Incompetent;;.293
 ;;Date Ruled Incompetent (VA);;.291
 ;;Date Ruled Incompetent (Civil);;.292
 ;;VA Disability;;.3025
 ;;Amount of VA Disability;;.303
 ;;Amount of VA Pension;;.3624
 ;;Total Check Amount;;.36295
 ;;POW Indicated;;.525
 ;;POW War;;.526
 ;;POW Date From;;.527
 ;;POW Date To;;.528
 ;;Mil Disab Retirement;;.3602
 ;;Discharge Due to Disab;;.3603
 ;;QUIT;;QUIT
 ;;
NVETNSC ;;SC LESS THAN 50%;SERVICE CONNECTED 50% to 100%;NSC, VA PENSION;AID & ATTENDANCE;HOUSEBOUND;ALLIED VETERAN;
