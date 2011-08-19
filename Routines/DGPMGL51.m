DGPMGL51 ;ALB/MRL - G&L PARAMETER ENTRY/EDIT; 28 JUN 89
 ;;5.3;Registration;;Aug 13, 1993
 F I=1:1 S J=$P($T(@DGPM+I),";;",2) Q:J="QUIT"  W !,J
 K I,J Q
1 ;
 ;;Please enter the date on which you wish to initialize your Gains & Losses Sheet
 ;;and Bed Status Report.  The date selected must be on or after October 1, 1988.
 ;;Bed Status statistics will be calculated from this date only.
 ;;QUIT
2 ;
 ;;The Gains & Losses Sheet allows one to print only the last four numbers of the
 ;;patient's Social Security Number or the entire number.  Please determine
 ;;how you'd like this number to appear on your G&L.  If the entire number is
 ;;printed the two-column G&L will always be produced.
 ;;QUIT
3 ;
 ;;This G&L is designed to display current Means Test Status (where applicable) if
 ;;you wish.  Simply respond YES to this prompt in order to display this data on
 ;;your daily Gains and Losses Sheet.
 ;;QUIT
4 ;
 ;;The next prompt is for the purpose of determining whether or not you wish for
 ;;the exact Treating Specialty to which a patient is assigned to display on the
 ;;G&L whenever a movement is displayed.  The information will appear immediately
 ;;to the right of the assigned ward location.  If this parameter is "turned-on" a
 ;;two-column G&L will always be produced.
 ;;QUIT
5 ;
 ;;Please select whether you wish the patient listing (G&L) to display names in a
 ;;two or three column format.  Certain transaction types, i.e., Transfers in/out,
 ;;will always appear as a single column output regardless, however, this feature
 ;;may reduce the amount of paper required to generate this listing.
 ;;QUIT
6 ;
 ;;Answer YES to the following prompt should you wish for non-movements, i.e.,
 ;;Treating Specialty Change to appear on the G&L otherwise answer NO.
 ;;QUIT
7 ;
 ;;Please enter the date from which you wish to recalculate totals which must be
 ;;on or after the G&L Initialization Date.  The purpose of this parameter is to
 ;;allow you the flexibility to maintain an "old" initialization date without the
 ;;worry that a correction entered say, for five years ago, will cause a recal-
 ;;culation process to commence which may take days to complete.  It is strongly
 ;;suggested that recalculation always be accomplished for, at a minumum, the
 ;;current fiscal reporting year.
 ;;QUIT
8 ;
 ;;Answer YES if you wish to calculate vietnam era veteran's remaining at the end
 ;;of each day.  If you choose to do so the length of processing time may be in-
 ;;creased up to 20 minutes per day.  Please note that this information is no
 ;;longer reported on any AMIS Segment.
 ;;QUIT
9 ;
 ;;Answer YES to the following prompt if you wish to calculate patient's over 65
 ;;years in age remaining at the end of each census date.  If you choose to do so
 ;;processing time for recalculation may be increased up to 30 minutes per date.
 ;;Please note that this information is no longer reported on any AMIS Segment.
 ;;QUIT
10 ;
 ;;Once we start collecting Treating Specialty statistics it will be necessary to
 ;;capture those data where a Treating Specialty may not have been assigned to a
 ;;particular patient.  Please respond to the following prompt with the DEFAULT
 ;;Treating Specialty to which you want these statistical data associated.  Perhaps
 ;;one might want to create a Treating Specialty called UNKNOWN, UNDEFINED, etc.,
 ;;and utilize this.
 ;;QUIT
