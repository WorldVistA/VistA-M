SPNADR ;HISC/DAD-AD HOC REPORTS: INTERFACE FOR THE SCD (SPINAL CORD) REGISTRY FILE (#154) ;10/31/2001
 ;;2.0;Spinal Cord Dysfunction;**11,12,13,14,15,16**;01/02/1997
 ;;2.0;QM Integration Module;;Apr 06, 1994
 ; *** Set up required and optional variables and call Ad Hoc Rpt Gen
 S SPNMRTN="MENU^SPNADR",SPNORTN="OTHER^SPNADR",SPNDIC=154
 S SPNMHDR="Registration"
 D ^SPNAHOC0
 Q
MENU ; *** Build the menu array
 S SPNMENU=1
 F SP=1:1 S X=$P($T(TEXT+SP),";",3,99) Q:X=""  D
 . S SPNMENU(SPNMENU)=X,SPNMENU=SPNMENU+1
 . Q
 G MENU^SPNADR1
OTHER ; *** Set up other (optional) EN1^DIP variables
 S DISUPNO=0
 S DIS(0)="I $$EN2^SPNPRTMT(D0)"
 Q
MACRO ; *** Check/update macro checksums
 S SPNMRTN="MENU^SPNADR",SPNDIC=154
 D MACCHK^SPNAHOC5
 Q
TEXT ;;*** Sort Yes/No ^ Menu Text ^ ~Field # ^ DIR(0)
 ;;1^Patient^~.01;"Patient"^PAO^2:AEMNQZ^D POINTER^SPNAHOC2
 ;;1^SSN^~999.01^FAO^1:60^
 ;;1^Date of Birth^~999.02;"Date Of Birth"^DAO^::AETS^D DATE^SPNAHOC2
 ;;1^Date of Death^~999.09;"Date Of Death"^DAO^::AETS^D DATE^SPNAHOC2
 ;;1^Age^~999.025;"Age"^FAO^1:60^
 ;;1^Registration Date^~.02;"Registration Date"^DAO^::AETS^D DATE^SPNAHOC2
 ;;1^Registration Status^~.03;"Registration Status"^SAOM^0:NOT SCD;1:SCD - CURRENTLY SERVED;2:SCD - NOT CURRENTLY SERVED;X:EXPIRED;^D SET^SPNAHOC2
 ;;1^Date of Last Update^~.05;"Date Of Last Update"^DAO^::AETS^D DATE^SPNAHOC2
 ;;1^Last Updated By^~.06;"Last Updated By"^PAO^200:AEMNQZ^D POINTER^SPNAHOC2
 ;;1^Division^12,~.01;"Division"^PAO^40.8:AEMNQZ^D POINTER^SPNAHOC2
 ;;1^SCI Network^~1.1;"SCI Network"^SAOM^1:YES;0:NO;^D SET^SPNAHOC2
 ;;1^SCI Level^~2.1;"SCI Level"^PAO^154.01:AEMNQZ^D POINTER^SPNAHOC2
 ;;1^VA SCI Status^~2.6;"VA SCI Status"^SAOM^1:PARAPLEGIA-TRAUMATIC;2:QUADRIPLEGIA-TRAUMATIC;3:PARAPLEGIA-NONTRAUMATIC;4:QUADRIPLEGIA-NONTRAUMATIC;X:VA NOT APPLICABLE^D SET^SPNAHOC2
 ;;1^Amount VA is Used^~3.1;"Amount VA is Used"^SAOM^1:VA ONLY;2:MOSTLY VA/SOME NON-VA;3:HALF VA/HALF NON-VA;4:SOME VA/MOSTLY NON-VA;5:NON-VA ONLY;6:DID NOT SEE DOCTOR/NURSE LAST 5 YRS;^D SET^SPNAHOC2
 ;;1^Primary Care VAMC^~3.2;"Primary Care VAMC"^PAO^4:AEMNQZ^D POINTER^SPNAHOC2
 ;;1^Annual Rehab VAMC^~3.3;"Annual Rehab VAMC"^PAO^4:AEMNQZ^D POINTER^SPNAHOC2
 ;;1^Additional Care VAMC^~3.4;"Additional Care VAMC"^PAO^4:AEMNQZ^D POINTER^SPNAHOC2
 ;;0^Non-VA Care^~3.5;"Non-VA Care"^FAO^1:60^
 ;;1^Etiology^4,~.01;"Etiology"^PAO^154.03:AEMNQZ^D POINTER^SPNAHOC2
 ;;1^Date of Onset^4,~.02;"Date Of Onset"^DAO^::AETS^D DATE^SPNAHOC2
 ;;0^Describe Other^4,~.03;"Describe Other"^FAO^1:60^
 ;;1^Onset by Trauma^4,~999.01;"Onset Of SCD Cause By Trauma"^FAO^1:60^
 ;;1^MS Subtype^~2.2;"MS Subtype"^SAOM^UN:UNKNOWN;RR:RELAPSING-REMITTING;PP:PRIMARY PROGRESSIVE;SP:SECONDARY PROGRESSIVE;PR:PROGRESSIVE RELAPSING;^D SET^SPNAHOC2
 ;;1^Had Brain Injury?^~5.02;"Had Brain Injury?"^SAOM^0:NO;1:YES;^D SET^SPNAHOC2
 ;;1^Had Amputation?^~5.03;"Had Amputation?"^SAOM^0:NO;1:YES;^D SET^SPNAHOC2
 ;;1^Memory/Think Affected^~5.04;"Memory/Thinking Affected"^SAOM^0:NO;1:YES;^D SET^SPNAHOC2
 ;;1^Eyes Affected^~5.05;"Eyes Affected"^SAOM^0:NO;1:YES;^D SET^SPNAHOC2
 ;;1^One Arm Affected^~5.06;"One Arm Affected"^SAOM^0:NO;1:YES;^D SET^SPNAHOC2
 ;;1^One Leg Affected^~5.07;"One Leg Affected"^SAOM^0:NO;1:YES;^D SET^SPNAHOC2
 ;;1^Both Arms Affected^~5.08;"Both Arms Affected"^SAOM^0:NO;1:YES;^D SET^SPNAHOC2
 ;;1^Both Legs Affected^~5.09;"Both Legs Affected"^SAOM^0:NO;1:YES;^D SET^SPNAHOC2
 ;;1^Other Body Prt Affected^~5.1;"Other Body Part Affected"^SAOM^0:NO;1:YES;^D SET^SPNAHOC2
 ;;0^Descr Other Body Part^~2.5;"Describe Other Body Part"^FAO^1:60^
 ;;1^Extent of Movement^~5.11;"Extent Of Movement"^SAOM^1:FULL USEFUL MOVEMENT;2:SOME USEFUL MOVEMENT;3:NO USEFUL MOVEMENT;^D SET^SPNAHOC2
 ;;1^Extent of Feeling^~5.12;"Extent Of Feeling"^SAOM^1:FULL FEELING;2:SOME FEELING;3:NO FEELING;^D SET^SPNAHOC2
 ;;1^Bowel Affected^~5.13;"Bowel Affected"^SAOM^0:NO;1:YES;^D SET^SPNAHOC2
 ;;1^Bladder Affected^~5.14;"Bladder Affected"^SAOM^0:NO;1:YES;^D SET^SPNAHOC2
 ;;0^Remarks^~11;"Remarks"^FAO^1:80
