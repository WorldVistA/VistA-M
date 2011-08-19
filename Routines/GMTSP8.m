GMTSP8 ;SLC/SBW - HS Component Installation Routine ; 8/4/96  18:06
 ;;2.7;Health Summary;**8**;Oct 20, 1995
HSCOMP ; Install Health Summary component
 Q:+$$VERSION^XPDUTL("GMTS")<2.7  ;Quit if HS 2.7 not installed
 N DIC,DLAYGO,DINUM,X,Y,INCLUDE
 D COMP1,COMP2
 W !,"Installing new components in AD HOC Health Summary."
 S INCLUDE=0 D ENPOST^GMTSLOAD
 Q
COMP1 ;VITAL SIGNS OUTPATIENT component
 N AD,DA,DIE,DR,GMX
 S (DIC,DLAYGO)=142.1,DIC(0)="NXL",(X,GMX)="VITAL SIGNS OUTPATIENT",DINUM=75
 S AD=$O(^GMT(142.1,"B",GMX,0)) I AD=75 W !,GMX," already exists in Health Summary Component (142.1) File!" Q
 D ^DIC
FILE1 I +Y'>0 W !!,"Could not install ",GMX," component",! Q
 W !,"Adding "_GMX_" component to HEALTH SUMMARY COMPONENT (142.1) file."
 S DIE=DIC,DA=+Y,DR="1///^S X=""OUTPAT""_$C(59)_""GMTSVS"";3///VSO"
 S DR=DR_";2///Y;4///Y;9///Vital Signs Outpat."
 D ^DIE
 S ^GMT(142.1,+DA,3.5,0)="^^7^7^"_DT_"^"
 S ^GMT(142.1,+DA,3.5,1,0)="This component contains outpatient vital measurements extracted"
 S ^GMT(142.1,+DA,3.5,2,0)="from the Vital/Measurements (Gen. Med. Rec. - Vitals) package.  Time and maximum"
 S ^GMT(142.1,+DA,3.5,3,0)="occurrence limits apply.  Data presented includes: measurement"
 S ^GMT(142.1,+DA,3.5,4,0)="date/time, blood pressure, (as SBP/DBP), pulse, temperature,"
 S ^GMT(142.1,+DA,3.5,5,0)="height, weight, and respiratory rate."
 S ^GMT(142.1,+DA,3.5,6,0)="Metric values will be displayed for temperature, height and weight."
 S ^GMT(142.1,+DA,3.5,7,0)="If there are no outpatient measurements, a message will be displayed and"
 S ^GMT(142.1,+DA,3.5,8,0)="the last non-outpatient measurements will be shown."
 W !,"Component Installed.",!
 D PDXINST(GMX)
 Q
COMP2 ;VITAL SIGNS SELECTED OUTPATIENT component
 N AD,DA,DIE,DR,GMX
 S (DIC,DLAYGO)=142.1,DIC(0)="NXL",(X,GMX)="VITAL SIGNS SELECTED OUTPAT.",DINUM=76
 S AD=$O(^GMT(142.1,"B",GMX,0)) I AD=76 W !,GMX," already exists in Health Summary Component (142.1) File!" Q
 D ^DIC
FILE2 I +Y'>0 W !!,"Could not install ",GMX," component",! Q
 W !,"Adding "_GMX_" component to HEALTH SUMMARY COMPONENT (142.1) file."
 S DIE=DIC,DA=+Y,DR="1///^S X=""OUTPAT""_$C(59)_""GMTSVSS"";3///SVSO"
 S DR=DR_";2///Y;4///Y;7///120.51;9///Vital Select Outpat."
 S DR(2,142.17)=".01"
 D ^DIE
 S ^GMT(142.1,+DA,3.5,0)="^^10^10^"_DT_"^"
 S ^GMT(142.1,+DA,3.5,1,0)="This component contains selected outpatient vital measurements"
 S ^GMT(142.1,+DA,3.5,2,0)="extracted from the Vital/Measurements (Gen. Med. Rec. - Vitals) package."
 S ^GMT(142.1,+DA,3.5,3,0)="Time and maximum occurrence limits apply and the user is allowed"
 S ^GMT(142.1,+DA,3.5,4,0)="to select any of the vital measurement types defined in the"
 S ^GMT(142.1,+DA,3.5,5,0)="GMRV Vital Type file (e.g., pulse, blood pressure, temperature, height,"
 S ^GMT(142.1,+DA,3.5,6,0)="weight, and respiration rate).  Data presented includes: measurement"
 S ^GMT(142.1,+DA,3.5,7,0)="date/time, measurement type and measurement value,"
 S ^GMT(142.1,+DA,3.5,8,0)="and metric values for temperature, height and weight."
 S ^GMT(142.1,+DA,3.5,9,0)="If there is no outpatient measurements, a message will be shown and"
 S ^GMT(142.1,+DA,3.5,10,0)="the last selected non-outpatient measurements will be shown."
 S ^GMT(142.1,+DA,3.5,11,0)="Note: Formatted display is horizontal."
 W !,"Component Installed.",!
 ;SELECTED COMPONENTS CAN'T BE USED IN PDX
 Q
PDXINST(COMP) ;Set PDX up to use new HS components
 N ERR,POINT,DASHES,DOTS,PDXCOMP
 W !,"Installing ",COMP," into PDX Data Segments.",!
 D INSTALL(COMP)
 Q
INSTALL(COMP) ;Install component in Data Segment (#394.71) file
 ;CONVERT TO PDX SEGMENT NAME
 S PDXCOMP=$$FIRSTUP^VAQUTL50(COMP)
 ;GET POINTER TO COMPONENT
 S POINT=+$O(^GMT(142.1,"B",COMP,0))
 I ('POINT) D  Q
 .W !!,$C(7),COMP," not found in HEALTH SUMMARY COMPONENT file."
 .W !,PDXCOMP," not added to VAQ - DATA SEGMENT file.",$C(7)
 ;CREATE DATA SEGMENT USING DEFAULT TIME & OCCURRENCE LIMITS
 S ERR=$$ADDSEG^VAQUTL50(POINT)
 I (ERR<0) W !,?5,$P(ERR,"^",2),$C(7) Q
 W !?3,PDXCOMP," added to VAQ - DATA SEGMENT file (#394.71)."
 W !
 Q
