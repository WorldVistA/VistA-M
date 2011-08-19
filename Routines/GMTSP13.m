GMTSP13 ; SLC/SBW - HS Component Installation Routine ;12/31/96
 ;;2.7;Health Summary;**13**;Oct 20, 1995
HSCOMP ; Install Health Summary component
 Q:+$$VERSION^XPDUTL("GMTS")<2.7  ;Quit if HS 2.7 not installed
 N DIC,DLAYGO,DINUM,X,Y
 S (DIC,DLAYGO)=142.1,DIC(0)="NXL",X="SPINAL CORD DYSFUNCTION",DINUM=74
 S AD=$O(^GMT(142.1,"B",X,0)) I AD=74 W !,X," already exists in Health Summary Component (142.1) File!" Q
 D ^DIC
FILE I +Y'>0 W !!,"Could not install ",X," component",! Q
 W !,"Adding component to HEALTH SUMMARY COMPONENT (142.1) file."
 S DIE=DIC,DA=+Y,DR="1///^S X=""MAIN""_$C(59)_""GMTSSCD"";3///SCD"
 S DR=DR_";2///Y;4///Y;9///Spinal Cord Dysfunct"
 D ^DIE
 S ^GMT(142.1,+DA,3.5,0)="^^7^7^"_DT_"^"
 S ^GMT(142.1,+DA,3.5,1,0)="This component provides patient data from the Spinal Cord Dysfuction"
 S ^GMT(142.1,+DA,3.5,2,0)="package. A patient's registration status, highest level of injury,"
 S ^GMT(142.1,+DA,3.5,3,0)="information source for SCD, completeness of injury and extent of paralysis"
 S ^GMT(142.1,+DA,3.5,4,0)="will be displayed. The following data will be displayed with time and maximum"
 S ^GMT(142.1,+DA,3.5,5,0)="occurrence limits applied:  date of onset, etiology, onset of SCD caused"
 S ^GMT(142.1,+DA,3.5,6,0)="by trauma, date recorded, motor score, cognitive score, total score and"
 S ^GMT(142.1,+DA,3.5,7,0)="record type."
 W !,"Component Installed.",!
 W !,"Installing new component in AD HOC Health Summary."
 S INCLUDE=0 D ENPOST^GMTSLOAD
 K AD,DA,DIE,DR,INCLUDE
 D PDXINST
 Q
PDXINST ;Set PDX up to use new HS components
 N ERR,POINT,COMP,DASHES,DOTS,PDXCOMP
 S COMP="SPINAL CORD DYSFUNCTION"
 W !,"Adding ",COMP," into PDX Data Segments.",!
 S X="VAQUTL50" X ^%ZOSF("TEST") I '$T D  Q
 . W !!,"Adding this segment requires patch VAQ*1.5*11 (CREATE"
 . W !,"SEGMENT USING HLTH SUMM COMP) to be installed."
 . W !,"Install VAQ*1.5*11 and then DO PDXINST^GMTSP13"
 . W !,"to add the segment to the VAQ - Data Segment file."
 . Q
 D INSTALL
 Q
INSTALL ;Install SCD component in Data Segment (#394.71) file
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
