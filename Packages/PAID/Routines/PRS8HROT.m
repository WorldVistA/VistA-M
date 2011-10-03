PRS8HROT ;JAH/WCIOFO-Calc time over 8/day &/or 40/week ;07/14/2008
 ;;4.0;PAID;**29,42,52,102,117**;Sep 21, 1995;Build 32
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
OVER840 ;
 ;     If overtime coded & either holiday worked or holiday excused
 ;     Then set type of time to Holiday Hrs (shift Day, 2 or 3).
 ;
 I VAL="O",HOLWKEX S X=TOUR+28 D CHK^PRS8HRSV Q:X
 ;
 ;     If > 8 hrs & not compressed ** results of G8
 ;
 I HT>32 D G8^PRS8HRSV Q:X
 ;
 I "1235nHMLSWNARUXYVJFGDZq"[VAL,NH>319 Q
 ;
 ;     If Baylor Plan
 ;
 I TYP["B" D  Q:X
 .;
 .;     IF weeks hours greater than 8 & TIME not coded as comp-time
 .;     THEN set TIME to OT-Total Hrs (shift Day, 2 or 3)
 .;
 .I HT>32 S X=$S("Ee"'[VAL:TOUR+19,1:7) D CHK^PRS8HRSV Q:X
 .;
 .;     IF Total Hours for the current week are <= 40 
 .;     THEN TIME gets unscheduled regular.
 .;
 .I TH(W)'>160 S X=9 D CHK^PRS8HRSV Q:X
 .;
 .;     IF Total Hours for the current week ARE > 40
 .;       AND total hours for today are <= 8
 .;         AND Time is not comp-time
 .;         THEN Time gets Unscheduled regular.
 .;
 .I TH(W)>160,HT<33,"Ee"'[VAL S X=9 D CHK^PRS8HRSV Q:X
 ;
 ;     IF not comp-time THEN Time = Overtime, otherwise
 ;     part timers get unscheduled reg until 8/day, 40/week
 ;     UNSCHEDULED REGULAR WILL BE CODED AS OT for over 8/day
 ;
 S X=$S("Ee"'[VAL:TOUR+19,1:7)
 D CHK^PRS8HRSV
 ;
 ;-------------------------------------------------------------------
 Q
