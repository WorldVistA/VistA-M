ECXSCLD1 ;ALB/DAN <CONT> Enter, Print and Edit Entries in 728.44 ;5/16/12  10:11
 ;;3.0;DSS EXTRACTS;**132,136**;Dec 22, 1997;Build 28
 ;
EXPORT ;Export clinic review data to spreedsheet
 N DIC,FLDS,BY,FR,L,DIOBEG
 W !!,"Turn on 'Capture Incoming Data...' and select your exported text file."
 W !,"To receive correct number of columns, select a large enough parameter."
 W !,"DEVICE: 0;225;99999 (example)."
 S DIC="^ECX(728.44,",FLDS="[ECX CLINIC REVIEW EXPORT]",BY="NUMBER",FR="",L=0
 S DIOBEG="W ""IEN^Clinic^Stop Code^Credit Stop Code^DSS Stop Code^DSS Credit Code^Action^Last Review Date^Nat Code^Inact Date^React Date^Clinic Type^App Len^Div^App Type^Non Cnt^OOS^OOS Calling Pkg^Variable Length Appt^DSS Prod Dept""" ;136
 D EN1^DIP
 W !!,"Turn off your capturing..."
 W !,"...Then, pull your export text file into your spreadsheet.",!
 I IO'=IO(0) D ^%ZISC
 D HOME^%ZIS
 Q
