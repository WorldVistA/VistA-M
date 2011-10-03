LRDPAREF ;DALOI/FHS - PENDING ORDER FILE PATIENT LOOKUP ; 12/3/1997
 ;;5.2;LAB SERVICE;**153,222,286**;Sep 27, 1994
 ; Special patient lookup of Lab Orders Pending File
 ;
EN ; From ^LRDPA
 ; Initialize array LRSD.
 ;  CDT=collection date/time
 ;  DFN=ien of patient in selected file
 ;  DOB=patient's date of birth
 ;  DPF=source file (2, or 67)
 ;  ERROR=0
 ;  LPC=longitudinal parity check
 ;  PNM=patient name
 ;  RIEN=IEN of ^LRT(67
 ;  RPSITE=primary sending site
 ;  RSITE=sending site
 ;  RSITEN=sending site name
 ;  RUID=specimen unique identifier
 ;  SEX=patient's sex
 ;  SSN=patient's SSN
 ;  LA7PNM=Patient Bar code read if lookup fails
 ;  On exit LRDPF set to '67^LRT(67, DFN=RIEN
 ;
 N DA,DIC,DIE,DIR,DIRUT,DTOUT,DUOUT
 ;
 K LRSD,LA7PNM
 ;
 F Y="CDT","DFN","DOB","DPF","ERROR","LPC","PNM","RIEN","RPSITE","RSITE","RUID","SEX","SSN" S LRSD(Y)=""
 S LREND=0
 D:'$D(LRLABKY) LABKEY^LRPARAM
 I $G(LRREFBAR) D  Q:$G(LREND)
 . D BAR K LA7PNM
 . I LRSD("ERROR") D
 . . D ERRMSG(LRSD("ERROR"),"Barcode error #")
 . . I +LRSD("ERROR")=1 D CLEAN
 I '$G(LRREFBAR)!(LRSD("ERROR")) D MAN
 I $G(LREND) D CLEAN Q
 I LRSD("ERROR") D  Q
 . I LRSD("ERROR") D ERRMSG(LRSD("ERROR"),"Error #")
 . D CLEAN
 S LRSD("RPSITE")=LRRSITE("RPSITE")
CK ;S PNM=LRSD("PNM"),SSN=LRSD("SSN"),DOB=LRSD("DOB"),SEX=LRSD("SEX"),LRXDPF=LRSD("DPF"),LRXDFN=LRSD("DFN")
 D ^LRDPAREX
 I $G(LREND)!($G(LRSD("ERROR"))) D  G CLEAN
 . S LRSD("ERROR",1)="12^Validation Failure "
 . W !,$C(7),$P(LRSD("ERROR"),"^",2),!
OK ;
 S:'$G(DFN) DFN=-1 S Y=DFN
 I DFN=-1 S LRDFN=-1 K DIC S VA200="" Q
 S X="^"_$P(LRDPF,"^",2)_Y_",""LR"")",LRDFN=+$S($D(@X):@X,1:-1) G E3:LRDFN>0
 L +^LR(0):999999
 S LRDFN=$P(^LR(0),U,3) S:LRDFN<1 LRDFN=1
 F LRDFN=LRDFN:1 Q:'$D(^LR(LRDFN,0))#2
 S ^LR(0)=$P(^LR(0),"^",1,2)_"^"_LRDFN_"^"_(1+$P(^(0),"^",4))
E2 L +^LR(LRDFN):999999
 S ^LR(LRDFN,0)=LRDFN_"^"_+LRDPF_"^"_DFN
 S ^LR("B",LRDFN,LRDFN)=""
 S @X=LRDFN,^LRT(67,LRSD("RIEN"),"LR")=LRDFN
 L -(^LR(0),^LR(LRDFN))
E3 I '$D(^LR(LRDFN,0))#2 D  Q
 . W !!,"Internal patient ID incorrect in ^LR( for ",PNM,"."
 . W !,"Contact Lab Coordinator.",$C(7)
 . S LRDFN=-1
 I LRDFN>0,$P(^LR(LRDFN,0),"^",2)'=+LRDPF!($P(^(0),"^",3)'=DFN) D  Q
 . W !,$C(7),"Internal patient ID incorrect for ",PNM,"."
 . W !,"Contact Lab Coordinator."
 . S LRDFN=-1
 D INF^LRX,PT^LRX
RUID ;
 I LRSD("RUID")="" D
 . N DIR,DIRUT,DTOUT,X,Y
 . ; If VA facility, require 10 character UID.
 . I LRRSITE("RSITE"),$$GET1^DIQ(4,+LRRSITE("RSITE")_",",95,"I")="V" D
 . . S DIR(0)="F^10:10^K:X'?1(10N,1U9N,2U8N,1N1U8N) X"
 . . S DIR("?")="Enter the sending facility's ten character UID for this specimen"
 . E  S DIR(0)="F^1:30",DIR("?")="Enter sending facility's specimen ID, 1-30 characters"
 . S DIR("A")="Enter Remote UID"
 . D ^DIR
 . I $D(DIRUT) D CLEAN Q
 . S LRSD("RUID")=Y
 ;
 Q
DUP W !?5,"There are duplicate SSNs in the Referral File <abort>",!,$C(7)
ERR ;
 S LRDFN=-1 W !,"ERROR",!
 Q
 ;
ERR1 ;
 S LRDFN=-1 W !,"ERROR1",!
 Q
 ;
CLEAN ;
 S LRDFN=-1,LREND=1
 Q
 ;
 ;
BAR ; Scan PD bar code for patient/specimen info
 ;
 N DA,DIC,DIR,DIRUT,DR,DTOUT,DUOUT
 ;
 D PT^LA7SBCR1(.LRSD,"Scan Patient/Accession Barcode (PD)",.LRRSITE)
 I LRSD("ERROR") Q
 D DIQ
 Q
 ;
 ;
MAN ; Manual referral patient lookup
 ;
 N DIR,DIC,DA,X,Y
 K ^DISV(DUZ,"^DPT("),^("^LRT(67,")
 ;
 ; Lookup using file #69.6 if manifest exists and not using bar code scanner
 I '$G(LRREFBAR),$G(LRRSITE("SMID-OK")),LRRSITE("SMID")'="",$D(^LRO(69.6,"D",LRRSITE("SMID"))) D MF696 Q
 ;
 ; Ask user for information
 S LRSD("ERROR")=""
 S DIR(0)="67,3",DIR("A")="Select Patient Name -'^M' To enter New Name "
 D ^DIR
 I $D(DIRUT) S LRSD("ERROR")="1^User timeout/abort or Up-arrow entered"
 I Y["DPT(" D DPTSET^LA7SBCR1(.LRSD,+Y)
 I Y["LRT(" D LRTSET^LA7SBCR1(.LRSD,+Y)
 I $E(X,1,2)="^M" D  Q
 . K DIRUT,DIR
 . D KEYIN^LRDPAREX
 . S:$G(LREND) LRSD("ERROR")="15^Manual Patient entry not complete"
 I LRSD("ERROR") Q
 D DIQ K DIR
 S DIR(0)="Y",DIR("A")="Is this the correct patient" D ^DIR
 I Y'=1 S LRSD("ERROR")="5^Unsuccessful patient lookup" D CLEAN
 Q
 ;
 ;
MF696 ; Manual lookup of file #69.6
 N DIR,DIC,LAIEN,LRSCN696,X,Y
 S Y=$$FIND1^DIC(64.061,"","OMX","In-Transit","","I $P(^LAB(64.061,Y,0),U,7)=""U""")
 I Y>0 S LRSCN696=+Y
 E  S LRSCN696=""
 S DIR(0)="PO^69.6:NEMQZ"
 S DIR("S")="I $P(^(0),U,10)="_LRSCN696_",$D(^LRO(69.6,""D"",LRRSITE(""SMID""),Y))"
 S DIR("A")="Enter UID of specimen"
 D ^DIR
 I $D(DIRUT) S LREND=1 Q
 S LAIEN=Y,(LA7Y(0),LAIEN(0))=Y(0)
 D GETS^DIQ(69.6,+LAIEN_",","*","IE","LAIEN")
 S LRSD("DPF")="67^LRT(67,"
 S LRSD("PNM")=LAIEN(69.6,+LAIEN_",",.01,"I")
 S LRSD("DOB")=LAIEN(69.6,+LAIEN_",",.03,"I")
 S LRSD("SEX")=LAIEN(69.6,+LAIEN_",",.02,"I")
 S LRSD("RACE")=LAIEN(69.6,+LAIEN_",",.06,"I")
 S LRSD("SSN")=LAIEN(69.6,+LAIEN_",",.09,"I")
 S LRSD("CDT")=LAIEN(69.6,+LAIEN_",",11,"I")
 S (LRRSITE("RPSITE"),LRSD("RPSITE"))=LAIEN(69.6,+LAIEN_",",1,"I")
 S LRSD("RSITE")=LAIEN(69.6,+LAIEN_",",2,"I")
 S LRSD("RSITEN")=$E(LAIEN(69.6,+LAIEN_",",2,"E"),1,19)
 S LRSD("RUID")=LAIEN(69.6,+LAIEN_",",3,"I")
 S LRSD("SMID")=LRRSITE("SMID")
 I LRSD("SSN")="" S LRSD("SSN")=LAIEN(69.6,+LAIEN_",",700.04,"I")
 I LRSD("SSN")="" S LRSD("ERROR")="2^Patient Identifier Absent" Q
 S LRSD("RIEN")=$O(^LRT(67,"C",LRSD("SSN"),0))
 I $G(LRSD("RIEN")),$G(^LRT(67,LRSD("RIEN"),"LR")) S LRSD("LRDFN")=^("LR"),LRSD("DFN")=LRSD("RIEN")
 Q
 ;
 ;
DIQ ; Display patient info
 Q:'$G(LRSD("DFN"))
 N DA,DIC,DX,S
 S DIC=$S(+LRSD("DPF")=2:"^DPT(",+LRSD("DPF")=67:"^LRT(67,",1:"")
 I DIC="" Q
 S DA=LRSD("DFN"),DR=0,S=0
 W @IOF
 D EN^LRDIQ
 Q
 ;
ERRMSG(X,Y) ; Display error message to user
 ; Call with X=error message code^error message text
 ;           Y=message prefix
 S X=Y_$P(LRSD("ERROR"),"^")_" - "_$P(LRSD("ERROR"),"^",2)
 D EN^DDIOL(X,"","!?5")
 Q
