SDSCRPT2 ;ALB/JAM/RBS - ASCD SB/Reports for Service Connected Automated Monitor ; 3/5/07 12:11pm
 ;;5.3;Scheduling;**495**;Aug 13, 1993;Build 50
 ;;MODIFIED FOR NATIONAL RELEASE from a Class III software product
 ;;known as Service Connected Automated Monitoring (SCAM).
 ;
 ; Routine should be called at specified tags only.
 Q
HEADER ; Display an appropriate header for this report.
 ; Do standard header setup
 D STDHDR Q:$G(SDABRT)=1
 W "O/P ENCOUNTERS THAT ARE "_$S('SDOPT:"NOT ",1:"")_"SERVICE CONNECTED" W:SDOPT=2 " & NON SERVICE CONNECTED" W ?67,"PAGE: ",P
 W !,?5,"ENCOUNTERS DATED ",$$FMTE^XLFDT(SDSCTDT,2)," THRU ",$$FMTE^XLFDT(SDEDT,2)
 I $G(SDSCDNM)'="" W "  By Division: "_SDSCDNM
 W !,"DATE",?18,"PATIENT",?50,"ENCOUNTER",?65,"SC VALUE",!,!
 Q
 ;
ENCBDDT ; Detailed Body of the Disability/POV Encounter report
 I L+3+$S(SDDET:$$CTPOV(),1:0)>IOSL D HEADER Q:$G(SDABRT)=1
 ; Display the Encounter date
 W $$FMTE^XLFDT(SDOEDT,"5MZ")
 N DFN,VADM S DFN=SDPAT D DEM^VADPT
 ; Display the patient name and last 4 SSN.
 W ?18,$E(VADM(1),1,25)_" ("_$E($P(VADM(2),U),6,9)_")"
 D KVA^VADPT
 ; Display the ENCOUNTER Number
 W ?50,SDOE,?65,$S(SCVAL:"YES",SCVAL=0:"NO",1:"TBD"),! S L=L+1
 ; If summary report, quit.
 Q:SDDET=0
 ; Display all ICD CODES and DIAGNOSES for the specified encounter.
 I L+2+$$CTPOV()>IOSL D HEADER Q:$G(SDABRT)=1
 D POV2S
 I L+2+$$CTDIS()>IOSL D HEADER Q:$G(SDABRT)=1
 D DIS2S
 I L+4>IOSL D HEADER Q:$G(SDABRT)=1
 W !,! S L=L+2
 Q
 ;
NBILLHD ; Display an appropriate header for this report.
 ; Do standard header setup
 D STDHDR Q:$G(SDABRT)=1
 W SDHDR,?67,"PAGE: ",P
 W !,?5,"FOR ENCOUNTERS DATED ",$$FMTE^XLFDT(SDSCTDT,2)," THRU ",$$FMTE^XLFDT(SDEDT,2)
 I $G(SDSCDNM)'="" W "  By Division: "_SDSCDNM
 W !,"DATE",?18,"PATIENT",?50,"ENCOUNTER",!,!
 Q
 ;
NBILLBD ; Body of the Non Service Connected Billable Encounter reports
 I L+2>IOSL D NBILLHD Q:$G(SDABRT)=1
 ; Display the Encounter date
 W $$FMTE^XLFDT(SDOEDT,"5MZ")
 ; Display the patient name and last 4 SSN.
 N DFN,VADM S DFN=SDPAT D DEM^VADPT
 W ?18,$E(VADM(1),1,25)_" ("_$E($P(VADM(2),U),6,9)_")"
 ; Display the ENCOUNTER Number
 W ?50,SDOE,! S L=L+1
 I L+5>IOSL D NBILLHD Q:$G(SDABRT)=1
 Q
 ;
PRVHD ; Display the header for the Provider Service Connected Review Report.
 ; Do standard header setup
 D STDHDR Q:$G(SDABRT)=1
 S SDNWPV=1
 W SDHDR,?67,"PAGE: ",P
 W !,?5,"FOR ENCOUNTERS DATED ",$$FMTE^XLFDT(SDSCTDT,2)," THRU ",$$FMTE^XLFDT(SDEDT,2)
 I $G(SDSCDNM)'="" W "  By Division: "_SDSCDNM
 W !,?5,"ENCOUNTER DATE",?23,"PATIENT NAME",?56,"ENC #",?65,"VBA SC",?73,"USER SC",!,!
 Q
 ;
PRVBD ; Body of the Provider Service Connected Review Report
 ; This routine will display the Activity during a review
 ; Start a new page for every provider.
 N SDSCCVB,SDSCCUB,DFN,VADM
 I L+3+$S(SDDET:$$CTPOV(),1:0)>IOSL D PRVHD Q:$G(SDABRT)=1  S SDPVCN=1
 ; Display the Provider, reset new provider print flag
 I SDNWPV=1 D
 . W $$UP^XLFSTR($$NAME^XUSER(SDPROV,"F"))
 . S SDNWPV=0
 . I SDPVCN=1 W " (cont'd)" S SDPVCN=0
 . W ! S L=L+1
 . Q
 ; Display the Encounter date
 W ?5,$$FMTE^XLFDT(SDOEDT,"5MZ")
 ; Display the Patient Name
 S DFN=SDPAT D DEM^VADPT
 W ?23,$E(VADM(1),1,25)_" ("_$E($P(VADM(2),U),6,9)_")"
 D KVA^VADPT
 ; Display the ENCOUNTER Number,VBA/ICD Connected,VBA by User.  Increment Line Count.
 S SDSCCVB=$$GET1^DIQ(409.48,SDOE,.09,"E")
 S SDSCCUB=$$GET1^DIQ(409.48,SDOE,.06,"E")
 I SDSCCUB="" S SDSCCUB="TBD"
 W ?56,SDOE,?65,SDSCCVB,?73,SDSCCUB
 I 'SDDET W ! S L=L+1
 I SDDET D  Q:$G(SDABRT)=1
 . ; check for enough room for return prompt and data.
 . I L+2+$$CTPOV()>IOSL D RVWHD Q:$G(SDABRT)=1  S SDPVCN=1
 . D POV2S
 . I L+2+$$CTDIS()>IOSL D RVWHD Q:$G(SDABRT)=1  S SDPVCN=1
 . D DIS2S
 . I L+4>IOSL D RVWHD Q:$G(SDABRT)=1  S SDPVCN=1
 . W !,! S L=L+2
 . Q
 I L+3>IOSL D PRVHD Q:$G(SDABRT)=1  S SDPVCN=1
 Q
 ;
RVWHD ; Display the header for the User Service Connected Review Report.
 ; Do standard header setup
 D STDHDR Q:$G(SDABRT)=1
 S SDNWPV=1
 W SDHDR,?67,"PAGE: ",P
 W !,?5,"FOR ENCOUNTERS DATED ",$$FMTE^XLFDT(SDSCTDT,2)," THRU ",$$FMTE^XLFDT(SDEDT,2)
 I $G(SDSCDNM)'="" W "  By Division: "_SDSCDNM
 W !,?5,"ENCOUNTER DATE",?23,"ENC #",?33,"VBA SC",?40,"USER SC",?50,"STATUS",?60,"DATE LAST EDITED",!,!
 Q
 ;
RVWBD ; Body of the User Service Connected Review Report
 ; This routine will display the Activity during a review
 ; Start a new page for every user.
 N SDSCCVB,SDSCCUB
 I L+3+$S(SDDET:$$CTPOV(),1:0)>IOSL D RVWHD Q:$G(SDABRT)=1  S SDPVCN=1
 ; Display the Encounter date
 I SDNWPV=1 D
 . W $$UP^XLFSTR($$NAME^XUSER(SDLEB,"F"))
 . S SDNWPV=0
 . I SDPVCN=1 W " (cont'd)" S SDPVCN=0
 . W ! S L=L+1
 ; Display the Encounter date
 W ?5,$$FMTE^XLFDT(SDOEDT,"5MZ")
 ; Display the ENCOUNTER Number,VBA/ICD Connected,VBA by User, and Status.  Increment Line Count.
 S SDSCCVB=$$GET1^DIQ(409.48,SDOE,.09,"E")
 S SDSCCUB=$$GET1^DIQ(409.48,SDOE,.06,"E")
 I SDSCCUB="" S SDSCCUB="TBD"
 W ?23,SDOE,?33,SDSCCVB,?40,SDSCCUB
 W ?48,$$GET1^DIQ(409.48,SDOE,.05,"E")
 W ?60,$$FMTE^XLFDT($$GET1^DIQ(409.48,SDOE,.02,"E"),"5MZ")
 I 'SDDET W ! S L=L+1
 I SDDET D  Q:$G(SDABRT)=1
 . ; check for enough room for return prompt and data.
 . I L+2+$$CTPOV()>IOSL D RVWHD Q:$G(SDABRT)=1  S SDPVCN=1
 . D POV2S
 . I L+2+$$CTDIS()>IOSL D RVWHD Q:$G(SDABRT)=1  S SDPVCN=1
 . D DIS2S
 . I L+4>IOSL D RVWHD Q:$G(SDABRT)=1  S SDPVCN=1
 . W !,! S L=L+2
 I L+3>IOSL D RVWHD Q:$G(SDABRT)=1  S SDPVCN=1
 Q
 ;
CTPOV() ; Count all POV entries for the specified visit.
 N SDCT,SDVPOV0
 S SDCT=2
 S SDVPOV0=0 F  S SDVPOV0=$O(^AUPNVPOV("AD",SDV0,SDVPOV0)) Q:'SDVPOV0  S SDCT=SDCT+1
 Q SDCT
 ;
CTDIS() ; Count all rated disabilities for this patient.
 N I,I3,SCRD
 S I3=2,I=0
 D RDIS^DGRPDB(SDPAT,.SCRD)
 F  S I=$O(SCRD(I)) Q:'I  S I3=I3+1
 Q I3
 ;
POV2S ; Loop through and display all POV entries for the specified visit.
 N SDICD,SDVPOV0
 W !!,?10,"POVs/ICDs:" S L=L+2
 S SDVPOV0=0 F  S SDVPOV0=$O(^AUPNVPOV("AD",SDV0,SDVPOV0)) Q:'SDVPOV0  D
 . S SDPOV=$P($G(^AUPNVPOV(SDVPOV0,0)),U),SDICD=$$ICDDX^ICDCODE(SDPOV)
 . W !?15,$P(SDICD,U,2),?23,$P(SDICD,U,4) S L=L+1
 . Q
 Q
 ;
DIS2S ; Loop through and display all rated disabilities for this patient.
 W !!,?10,"Rated Disabilities:" S L=L+2
 N I,I1,I2,I3,SCRD
 D RDIS^DGRPDB(SDPAT,.SCRD)
 S I3=0,I=0 F  S I=$O(SCRD(I)) Q:'I  D
 . S I1=SCRD(I)
 . S I2=$S($D(^DIC(31,+I1,0)):$P(^(0),U,3)_"    "_$P(^(0),"^",1)_" ("_+$P(I1,"^",2)_"%-"_$S($P(I1,"^",3):"SC",$P(I1,"^",3)']"":"not specified",1:"NSC")_")",1:""),I3=I3+1
 . W !,?15,I2 S L=L+1
 . Q
 Q
 ;
STDHDR ; tag for all of the standard report header calls
 ; Do not ask 'RETURN' before first page on CRT.
 I $E(IOST,1,2)="C-",P N DIR,Y S DIR(0)="E" D ^DIR I 'Y S SDABRT=1 Q
 ; Do not print a form feed before first page on printer. Top of form is set at end of previous report.
 I $E(IOST,1,2)="C-"!P W @IOF
 S P=P+1,L=5
 Q
