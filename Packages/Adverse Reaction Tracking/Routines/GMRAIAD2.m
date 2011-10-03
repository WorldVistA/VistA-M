GMRAIAD2 ;BPOIFO/JG - BUILD HL7 ORU^R01 MESSAGE FOR ADVERSE REACTION - PART 2 ; 5 Oct 2005 8:57 AM
 ;;4.0;Adverse Reaction Tracking;**22,23**;Mar 29, 1996
 ; Creates HL7 V2.4 ORU^R01 message for allergy adverse reaction
 ;
 ; This routine uses the following IAs:
 ;   #4248 - VDEFEL calls        (conrolled)
 ;   #3630 - VAFCQRY calls       (controlled)
 ;   #2196 - ^PS(50.416,IEN,0)   (controlled)
 ;
 ; This routine is called as a subroutine by GMRAIAD1
 ;
 Q
 ;
ENTRY ; Entry point from GMRAIAD1
 ;
 ; OBX3 - QUESTIONS 1 thru 10
OBX3 S Y="",ALRDATA=^GMR(120.85,KEY,0)
 F I=3:1:7,9:1:11,16,17 S Y=Y_$P(ALRDATA,U,I)_U
 F I=1:1:10 D
 . Q:$P(Y,U,I)=""  S S=S+1,OUTX=1_HLFS_"CE"_HLFS
 . S VAL="Q"_I_HLCM_$P($T(QSTNS+(I)),";",3),$P(OUTX,HLFS,3)=VAL
 . S X=$P(Y,U,I),X=$S(X="y":"Y",X="n":"N",1:""),VAL=X_HLCM
 . S X=$S(X="Y":"YES",X="N":"NO",1:"")
 . S VAL=VAL_X_HLCM_"HL70136",$P(OUTX,HLFS,5)=VAL,$P(OUTX,HLFS,11)="F"
 . S OUTX="OBX"_HLFS_OUTX D SAVE^GMRAIAD1
 ;
 ; OBX4 - # Days in Hospital
OBX4 S X=$P(ALRDATA,U,8)+0 G OBX5:X=0
 S S=S+1,OUTX=1_HLFS_"NM"_HLFS_"DAYS IN HOSPITAL"
 S $P(OUTX,HLFS,5)=X,$P(OUTX,HLFS,11)="F"
 S OUTX="OBX"_HLFS_OUTX D SAVE^GMRAIAD1
 ;
 ; OBX5 - Other related history
OBX5 S X=$G(^GMR(120.85,KEY,14,1,0)) G OBX6:X=""
 F I=2:1 S Y=$G(^GMR(120.85,KEY,14,I,0)) Q:Y=""  S X=X_" "_Y
 S S=S+1,OUTX=1_HLFS_"TX"_HLFS_"Other History"_HLFS_HLFS_$$HL7RC^GMRAIAD1(X)
 S $P(OUTX,HLFS,11)="F",OUTX="OBX"_HLFS_OUTX D SAVE^GMRAIAD1
 ;
 ; OBX6 - FDA Questions
OBX6 S PTC=$G(^GMR(120.85,KEY,"PTC1")) G OBX8:PTC=""
 F I=1:1:5 D
 . S S=S+1,OUTX=1_HLFS_"CE"_HLFS
 . S VAL="FDAQ"_I_HLCM_$P($T(FDAQ+I),";",3),$P(OUTX,HLFS,3)=VAL
 . S VAL=$P(PTC,U,I+(I=5*8)),VAL=VAL_HLCM_$S(VAL="y":"Yes",VAL="n":"No",1:"Unknown")_HLCM_"HL70136"
 . S $P(OUTX,HLFS,5)=VAL,$P(OUTX,HLFS,11)="F",OUTX="OBX"_HLFS_OUTX D SAVE^GMRAIAD1
 ;
 ; OBX7 - P & T Questions
OBX7 F I=1:1:3 D
 . S S=S+1,OUTX=1_HLFS_"CE"_HLFS,Y=$$HL7RC^GMRAIAD1("P&T")_" ACTION "
 . S Y=Y_$P("FDA^MFR^RCPM",U,I)_" REPORT",VAL="PTQ"_I_HLCM_Y,$P(OUTX,HLFS,3)=VAL
 . S VAL=$P(X,U,I+8),VAL=VAL_HLCM_$S(VAL="y":"Yes",VAL="n":"No",1:"Unknown")_HLCM_"HL70136"
 . S $P(OUTX,HLFS,5)=VAL,$P(OUTX,HLFS,11)="F",OUTX="OBX"_HLFS_OUTX D SAVE^GMRAIAD1
 ;
 ; OBX8 - P & T Addendum
OBX8 S PTC=$O(^GMR(120.85,KEY,"PTC2",0)) G OBX9:PTC="" S IEN=0
 S VAL=$$TS^VDEFEL(^GMR(120.85,KEY,"PTC2",1,0))
 F  S IEN=$O(^GMR(120.85,KEY,"PTC2",1,1,IEN)) Q:IEN=""  D
 . S S=S+1,OUTX=1_HLFS_"TX"_HLFS_$$HL7RC^GMRAIAD1("P&T Addendum")
 . S $P(OUTX,HLFS,5)=$$HL7RC^GMRAIAD1(^GMR(120.85,KEY,"PTC2",1,1,IEN,0))
 . S $P(OUTX,HLFS,11)="F",$P(OUTX,HLFS,14)=VAL
 . S OUTX="OBX"_HLFS_OUTX D SAVE^GMRAIAD1
 ;
 ; OBX9 - Notification Dates
OBX9 S VAL=$P(^GMR(120.85,KEY,0),U,12) I VAL'="" D
 . ;
 . ; Date MD notified
 . S VAL=$$TS^VDEFEL(VAL) S S=S+1,OUTX=1_HLFS_"DT"_HLFS_"DATE MD NOTIFIED"
 . S $P(OUTX,5,HLFS)=VAL,$P(OUTX,11,HLFS)="F"
 . S OUTX="OBX"_HLFS_OUTX D SAVE^GMRAIAD1
 ;
 ; Dates reported to FDA, MFR, RCPM, VAERS
 S PTC=$G(^GMR(120.85,KEY,"PTC1")) G RETURN:PTC=""
 F I=1:1:5 S VAL=$P(PTC,U,I+4) I VAL'="" D
 . S VAL=$$TS^VDEFEL(VAL) S S=S+1,OUTX=1_HLFS_"DT"_HLFS_$P($T(RPTXT+I),";",3)
 . S $P(OUTX,HLFS,5)=VAL,$P(OUTX,HLFS,11)="F"
 . S OUTX="OBX"_HLFS_OUTX D SAVE^GMRAIAD1
 ;
 ; Return to GMRAIAD1
RETURN Q
 ;
QSTNS ; Question 1-10 Set
 ;;Patient died from reaction?
 ;;Patient treated with RX drug?
 ;;Life threatening illness?
 ;;Required ER/MD visit?
 ;;Required hospitalization?
 ;;Prolonged hospitalization?
 ;;Resulted in permanent disability?
 ;;Patient recovered?
 ;;Is this event a congenital anomaly?
 ;;Did this event require intervention to prevent impairment or damage?
 ;
FDAQ ; FDA Questions
 ;;Serious ADR?
 ;;ADR related to new drug? (Marketed within last 2 yrs.)
 ;;Unexpected ADR?
 ;;ADR related to therapeutic failure?
 ;;Dose related?
 ;
RPTXT ; Dates Reported Texts
 ;;DATE REPORTED TO FDA
 ;;DATE OF PATIENT CONSENT TO MFR
 ;;DATE SENT TO MFR
 ;;DATE SENT TO RCPM
 ;;DATE SENT TO VAERS
