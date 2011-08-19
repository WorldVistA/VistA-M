SCDXPRN1 ;ALB/JRP - HISTORY FILE REPORTS;21-JUL-1997
 ;;5.3;Scheduling;**128,140**;AUG 13, 1993
 ;
PATHIST ;Print transmission history report for patient
 ; - Report based within the ACRP Transmission History file (#409.77)
 ; - User prompted for patient and encounter date range
 ; - Report formatted for 80 columns (allows output to screen)
 ;
 ;Declare variables
 N DFN,BEGDATE,ENDDATE
 N DIC,L,FLDS,BY,FR,TO,DISPAR,DHD,X,Y,DTOUT,DUOUT
 ;Get patient
 W !!!,">> PATIENT SELECTION <<",!
 S DIC=2
 S DIC(0)="AEMQZ"
 D ^DIC
 Q:(($D(DTOUT))!($D(DUOUT))!(Y<0))
 S DFN=+Y
 ;Get date range
 W !!!,">> DATE RANGE SELECTION <<",!
 ; Earliest and latest date allowed
 S BEGDATE=2961001
 S ENDDATE=$$DT^XLFDT()
 ; Begin date help text
 S FR(1)="Enter encounter date to begin search from"
 S FR(2)=" "
 S FR(3)=$$FMTE^XLFDT(BEGDATE)_" is the earliest date allowed"
 S FR(4)=$$FMTE^XLFDT(ENDDATE)_" will be the latest date allowed"
 S FR(5)=" "
 S FR(6)="Note: Encounter date does not always match date of"
 S FR="      transmission to the National Patient Care Database"
 ; End date help text
 S TO(1)="Enter encounter date to end search at"
 S TO(2)=" "
 S TO(3)=$$FMTE^XLFDT(ENDDATE)_" is the latest date allowed"
 S TO(4)=$$FMTE^XLFDT(BEGDATE)_" was the earliest date allowed"
 S TO(5)=" "
 S TO(6)="Note: Encounter date does not always match date of"
 S TO="      transmission to the National Patient Care Database"
 S L=$$GETDTRNG^SCDXUTL1(BEGDATE,ENDDATE,"FR","TO")
 Q:(L<0)
 S BEGDATE=+$P(L,"^",1)
 S ENDDATE=+$P(L,"^",2)
 K FR,TO
 ;Make end date midnight
 S ENDDATE=$$FMADD^XLFDT(ENDDATE,0,23,59,59)
 ;Define sort criteria
 S DIC="^SD(409.77,"
 S L=0
 S BY="+.06;S"
 S FR=""
 S TO=""
 ;Pre-sort accomplished through ADFN x-ref
 S BY(0)="^SD(409.77,""ADFN"","
 S L(0)=3
 S FR(0,1)=DFN
 S TO(0,1)=DFN
 S FR(0,2)=BEGDATE
 S TO(0,2)=ENDDATE
 ;Define subheader
 S DISPAR(0,1)="^;""PATIENT: """
 S DISPAR(0,1,"OUT")="N DFN,VA,VAERR S DFN=Y D PID^VADPT S Y=$P($G(^DPT(DFN,0),""BAD DFN""),""^"",1)_""  (""_$S(VAERR:(""#""_DFN),1:VA(""BID""))_"")"""
 ;Define print fields
 S FLDS="[SCDX XMIT HIST FOR PATIENT]"
 ;Define header
 S DHD="ACRP TRANSMISSIONS FOR ENCOUNTERS OCCURRING BETWEEN "_$$FMTE^XLFDT(BEGDATE,"5D")_" AND "_$$FMTE^XLFDT(ENDDATE,"5D")
 ;Print report
 D EN1^DIP
 ;Done
 Q
