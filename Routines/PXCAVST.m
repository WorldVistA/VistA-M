PXCAVST ;ISL/dee & LEA/Chylton - Validates data from the PCE Device Interface for the Visit and Providers ;6/6/05
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**14,33,74,111,116,130,168**;Aug 12, 1996;Build 14
 Q
 ;
ENCOUNT(PXCA,PXCABULD,PXCAERRS,PXCAEVAL) ;
 I '($D(PXCA("ENCOUNTER"))#2) S PXCA("ERROR","ENCOUNTER",0,0,0)="ENCOUNTER node of the local data array is missing" Q
 N PXCAENC
 N PXCAITEM,PXCAITM2,PXCAOUT,PXCAERR
 S PXCAENC=$G(PXCA("ENCOUNTER"))
 I PXCAENC="" S PXCA("ERROR","ENCOUNTER",0,0,0)="ENCOUNTER data missing" Q
 I '($D(^DPT(PXCAPAT,0))#2) S PXCA("ERROR","ENCOUNTER",0,0,2)="Patient missing or invalid in file 2^"_PXCAPAT
 I '($D(^AUPNPAT(PXCAPAT,0))#2) S PXCA("ERROR","ENCOUNTER",0,0,2)="Patient missing or invalid in file 9000001^"_PXCAPAT
 S PXCAITEM=+$P(PXCAENC,"^",1)
 I 'PXCAITEM S PXCA("ERROR","ENCOUNTER",0,0,1)="Encounter Data/Time Missing^"_PXCAITEM
 E  I $D(^DPT(PXCAPAT,"S",PXCAITEM,0)),$D(^SC(+PXCAHLOC,0)),^DPT(PXCAPAT,"S",PXCAITEM,0),PXCAHLOC D
 . ;Have an appointment at this time
 . N VASD,VAERR
 . S VASD("W")=345678
 . S VASD("F")=PXCAITEM-.0000001
 . S VASD("T")=PXCAITEM+.0000001
 . S VASD("C",PXCAHLOC)=""
 . D SDA^VADPT
 . I $D(^UTILITY("VASD",$J)) S PXCA("ERROR","ENCOUNTER",0,0,1)="Appointment is No Show or Canceled^"_PXCAITEM
 I '$D(^DPT(PXCAPAT,"S",PXCAITEM,0))!(+$G(^DPT(PXCAPAT,"S",PXCAITEM,0))'=PXCAHLOC),'(+$P(PXCAENC,"^",5)),'$D(PXCA("PROCEDURE")),'$D(^AUPNVCPT("AD",+PXCAVSIT)) D
 . S PXCA("ERROR","ENCOUNTER",0,0,1)="Encounters that do not have an appointment must have a procedure^"
 E  I PXCAITEM>(DT+.7) S PXCA("ERROR","ENCOUNTER",0,0,1)="Encounter Date/Time is later that today^"_PXCAITEM
 I '$D(^SC(PXCAHLOC,0)) S PXCA("ERROR","ENCOUNTER",0,0,3)="HOSPITAL LOCATION Missing is not in file 44^"_PXCAHLOC
 ;Allow a disposition clinic to be used as HOSPITAL LOCATION  ;PX*1.0*116
 ;I $D(^PX(815,1,"DHL","B",PXCAHLOC)) S PXCA("ERROR","ENCOUNTER",0,0,3)="HOSPITAL LOCATION Can not be a disposition clinic^"_PXCAHLOC
 D EVALCODE^PXCAVST2(.PXCAEVAL)
 D SCC^PXUTLSCC(PXCAPAT,PXCADT,PXCAHLOC,PXCAVSIT,$P(PXCAENC,"^",6,11),.PXCAOUT,.PXCAERR)
 S PXCAITEM=$P(PXCAERR,"^",1)
 I PXCAITEM=-1 S PXCA("ERROR","ENCOUNTER",0,0,6)="SC flag bad^"_$P(PXCAENC,"^",6)
 I PXCAITEM=-2,$P(PXCAENC,"^",6)=1 S PXCA("WARNING","ENCOUNTER",0,0,6)="SC flag must be N/A not YES for this patient^"_$P(PXCAENC,"^",6)
 I PXCAITEM=1,$P($G(^PX(815,1,"DI")),"^",1) S PXCA("WARNING","ENCOUNTER",0,0,6)="SC flag is missing^"_$P(PXCAENC,"^",6)
 S PXCAITEM=$P(PXCAERR,"^",2)
 I PXCAITEM=-1 S PXCA("ERROR","ENCOUNTER",0,0,7)="AO flag bad^"_$P(PXCAENC,"^",7)
 I PXCAITEM=-2,$P(PXCAENC,"^",7)=1 S PXCA("WARNING","ENCOUNTER",0,0,7)="AO flag must be N/A not YES for this patient^"_$P(PXCAENC,"^",7)
 I PXCAITEM=-3,$P(PXCAENC,"^",7)=1 S PXCA("WARNING","ENCOUNTER",0,0,7)="AO flag must be N/A not YES because SC flag is true^"_$P(PXCAENC,"^",7)
 I PXCAITEM=1,$P($G(^PX(815,1,"DI")),"^",1) S PXCA("WARNING","ENCOUNTER",0,0,7)="AO flag is missing^"_$P(PXCAENC,"^",7)
 S PXCAITEM=$P(PXCAERR,"^",3)
 I PXCAITEM=-1 S PXCA("ERROR","ENCOUNTER",0,0,8)="IR flag bad^"_$P(PXCAENC,"^",8)
 I PXCAITEM=-2,$P(PXCAENC,"^",8)=1 S PXCA("WARNING","ENCOUNTER",0,0,8)="IR flag must be N/A not YES for this patient^"_$P(PXCAENC,"^",8)
 I PXCAITEM=-3,$P(PXCAENC,"^",8)=1 S PXCA("WARNING","ENCOUNTER",0,0,8)="IR flag must be N/A not YES because SC flag is true^"_$P(PXCAENC,"^",8)
 I PXCAITEM=1,$P($G(^PX(815,1,"DI")),"^",1) S PXCA("WARNING","ENCOUNTER",0,0,8)="IR flag is missing^"_$P(PXCAENC,"^",8)
 S PXCAITEM=$P(PXCAERR,"^",4)
 I PXCAITEM=-1 S PXCA("ERROR","ENCOUNTER",0,0,9)="EC flag bad^"_$P(PXCAENC,"^",9)
 I PXCAITEM=-2,$P(PXCAENC,"^",9)=1 S PXCA("WARNING","ENCOUNTER",0,0,9)="EC flag must be N/A not YES for this patient^"_$P(PXCAENC,"^",9)
 I PXCAITEM=-3,$P(PXCAENC,"^",9)=1 S PXCA("WARNING","ENCOUNTER",0,0,9)="EC flag must be N/A not YES because SC flag is true^"_$P(PXCAENC,"^",9)
 I PXCAITEM=1,$P($G(^PX(815,1,"DI")),"^",1) S PXCA("WARNING","ENCOUNTER",0,0,9)="EC flag is missing^"_$P(PXCAENC,"^",9)
 S PXCAITEM=$P(PXCAERR,"^",5)
 I PXCAITEM=-1 S PXCA("ERROR","ENCOUNTER",0,0,10)="MST flag bad^"_$P(PXCAENC,"^",10)
 I PXCAITEM=-2,$P(PXCAENC,"^",10)=1 S PXCA("WARNING","ENCOUNTER",0,0,10)="MST flag must be N/A not YES for this patient^"_$P(PXCAENC,"^",10)
 S PXCAITEM=$P(PXCAERR,"^",17)
 I PXCAITEM=-1 S PXCA("ERROR","ENCOUNTER",0,0,17)="HNC flag bad^"_$P(PXCAENC,"^",17)
 I PXCAITEM=-2,$P(PXCAENC,"^",11)=1 S PXCA("WARNING","ENCOUNTER",0,0,17)="HNC flag must be N/A not YES for this patient^"_$P(PXCAENC,"^",17)
 S PXCAITEM=$P(PXCAERR,"^",18)
 I PXCAITEM=-1 S PXCA("ERROR","ENCOUNTER",0,0,18)="CV flag bad^"_$P(PXCAENC,"^",18)
 I PXCAITEM=-2,$P(PXCAENC,"^",11)=1 S PXCA("WARNING","ENCOUNTER",0,0,18)="CV flag must be N/A not YES for this patient^"_$P(PXCAENC,"^",18)
 S PXCAITEM=$P(PXCAERR,"^",19)
 I PXCAITEM=-1 S PXCA("ERROR","ENCOUNTER",0,0,19)="PROJ 112/SHAD flag bad^"_$P(PXCAENC,"^",19)
 I PXCAITEM=-2,$P(PXCAENC,"^",11)=1 S PXCA("WARNING","ENCOUNTER",0,0,19)="PROJ 112/SHAD flag must be N/A not YES for this patient^"_$P(PXCAENC,"^",19)
 S $P(PXCAENC,"^",6,11)=PXCAOUT
 S PXCAITEM=+$P(PXCAENC,"^",13)
 I PXCAITEM D
 . N PXCADILF,DIERR
 . S PXCAITM2=$$EXTERNAL^DILFD(9000010,.21,"",PXCAITEM,"PXCADILF")
 . I $D(DIERR) S PXCA("ERROR","ENCOUNTER",0,0,13)="Eligibility code not in File 8^"_PXCAITEM
 . E  I PXCAITEM=$P($G(PXCAPAT("ELIG")),"^",1)
 . E  I $D(PXCAPAT("ELIG",PXCAITEM))=1
 . E  S PXCA("ERROR","ENCOUNTER",0,0,13)="Eligibility code is not one of this patient's Eligibilities^"_PXCAITEM
 S PXCAITEM=+$P(PXCAENC,"^",14)
 I PXCAITEM=0
 E  I PXCAITEM>(DT+.7) S PXCA("ERROR","ENCOUNTER",0,0,14)="Check-out Date and Time is later that today^"_PXCAITEM
 E  I PXCAITEM#1=0 S PXCA("ERROR","ENCOUNTER",0,0,14)="Time is required for Check-out Date and Time^"_PXCAITEM
 I PXCACSTP'="" D
 . I '$D(^DIC(40.7,+PXCACSTP,0)) S PXCA("ERROR","ENCOUNTER",0,0,17)="Optional CREDIT STOP not in File 40.7^"_PXCACSTP
 . E  I $P(^DIC(40.7,+PXCACSTP,0),"^",3),PXCADT'<$P(^(0),"^",3) S PXCA("ERROR","ENCOUNTER",0,0,17)="Optional CREDIT STOP is inactive in file 40.7^"_PXCACSTP
 ;
 I PXCABULD&'$D(PXCA("ERROR","ENCOUNTER"))!PXCAERRS D VST^PXCAVST1(PXCAENC)
 ;
 D PROVIDER^PXCAVST2
 ;
 Q
 ;
