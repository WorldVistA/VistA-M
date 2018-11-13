GMTSPST4 ;BHAM/RMS - TIU OBJECT FOR REMOTE MEDS VIA RDI ;06/28/17  10:31
 ;;2.7;Health Summary;**94**;Oct 20, 1995;Build 41
 ;
 ;Reference to ORRDI1 supported by DBIA 4659
 ;Reference to ^XTMP("ORRDI","PSOO" supported by DBIA 4660
 ;Reference to ^XTMP("ORRDI","OUTAGE INFO" supported by DBIA 5440
 ;
RDI(DFN,TARGET) ;
 ;OBJECT METHOD IS: S X=$$RDI^GMTSPST4(DFN,"^TMP($J,""GMTSRDI"")")
 K @TARGET
 N GMTSHDR,GMTSRET,GMTSMED,GMTSLINE,GMTSQTY,GMTSSIG,GMTSSTAT,GMTSRDI,GMTSDOWN,GMTSISSU
 G:'$G(DFN) RDIOUT
 S GMTSHDR=$$HAVEHDR^ORRDI1 I '+$G(GMTSHDR) D  G RDIOUT
 . S @TARGET@(1,0)="Remote Data from HDR not available"
 D  G:$G(GMTSDOWN) RDIOUT
 . I $D(^XTMP("ORRDI","OUTAGE INFO","DOWN")) H $$GET^XPAR("ALL","ORRDI PING FREQ")/2
 . I $D(^XTMP("ORRDI","OUTAGE INFO","DOWN")) S GMTSDOWN=1 D
 .. S @TARGET@(1,0)="WARNING: Connection to Remote Data Currently Down"
 D  ;RDI/HDR CALL ENCAPSULATION
 . D SAVDEV^%ZISUTL("GMTSHFS")
 . S GMTSRET=$$GET^ORRDI1(DFN,"PSOO")
 . D USE^%ZISUTL("GMTSHFS")
 . D RMDEV^%ZISUTL("GMTSHFS")
 I +GMTSRET=-1 D  G RDIOUT
 . S @TARGET@(1,0)="Connection to Remote Data Not Available"
 I '$D(^XTMP("ORRDI","PSOO",DFN)) D  G RDIOUT
 . S @TARGET@(1,0)="No Remote Data available for this patient"
OBJ S GMTSLINE=5
 S GMTSMED=0 F  S GMTSMED=$O(^XTMP("ORRDI","PSOO",DFN,GMTSMED)) Q:'+GMTSMED  D
 . S GMTSSTAT=$G(^XTMP("ORRDI","PSOO",DFN,GMTSMED,5,0))
 . Q:"ACTIVE^SUSPENDED^HOLD"'[GMTSSTAT
 . Q:$G(^XTMP("ORRDI","PSOO",DFN,GMTSMED,7,0))']""  ;Special case #1 for DoD data, quit if there is no expiration date listed
 . D  Q:GMTSISSU<$$FMADD^XLFDT(DT,-366)  ;Special case #2 for DoD data; quit if the ISSUE DATE is more than a year ago.  (May still show beyond expiration for Controlled Substances)
 .. N %DT,X,Y
 .. S X=$G(^XTMP("ORRDI","PSOO",DFN,GMTSMED,8,0))
 .. D ^%DT
 .. S GMTSISSU=+Y
 . S @TARGET@(GMTSLINE,0)=$G(^XTMP("ORRDI","PSOO",DFN,GMTSMED,2,0)) D INC
 . S GMTSSIG=$G(^XTMP("ORRDI","PSOO",DFN,GMTSMED,14,0)) D  ;
 .. I $L(GMTSSIG)>60 D  D INC Q
 ... N WORDS,COUNT
 ... S WORDS=$L(GMTSSIG," ")
 ... S @TARGET@(GMTSLINE,0)="Sig: "
 ... F COUNT=1:1:WORDS D
 .... S @TARGET@(GMTSLINE,0)=$G(@TARGET@(GMTSLINE,0))_$P(GMTSSIG," ",COUNT)_" "
 .... I $L(@TARGET@(GMTSLINE,0))>60 D INC S @TARGET@(GMTSLINE,0)="     "
 .. S @TARGET@(GMTSLINE,0)="Sig: "_GMTSSIG D INC
 . S GMTSQTY=$G(^XTMP("ORRDI","PSOO",DFN,GMTSMED,6,0)) S @TARGET@(GMTSLINE,0)="Quantity: "_+$P(GMTSQTY,";")_"    Days Supply: "_$P($P(GMTSQTY,";",2),"D",2) D INC
 . S @TARGET@(GMTSLINE,0)="Rx Expiration Date: "_$G(^XTMP("ORRDI","PSOO",DFN,GMTSMED,7,0)) D INC
 . S @TARGET@(GMTSLINE,0)="Last filled "_$G(^XTMP("ORRDI","PSOO",DFN,GMTSMED,9,0))_" at "_$G(^XTMP("ORRDI","PSOO",DFN,GMTSMED,1,0))
 . S @TARGET@(GMTSLINE,0)=@TARGET@(GMTSLINE,0)_" ("_$S(GMTSSTAT["ACT":"Active",GMTSSTAT["SUSP":"Active/Suspended",GMTSSTAT["HOLD":"Hold",1:"Status Unknown")_")" D INC
 . S @TARGET@(GMTSLINE,0)=" " D INC
 I GMTSLINE=5 D  G RDIOUT
 . S @TARGET@(1,0)="No Active Remote Medications for this patient"
 S @TARGET@(1,0)="Active Medications from Remote Data"
 S @TARGET@(2,0)="NOTE: Remote meds display is limited to those items matched to"
 S @TARGET@(3,0)="National Drug File at the originating site."
 S @TARGET@(4,0)=" "
RDIOUT Q "~@"_$NA(@TARGET)
INC S GMTSLINE=$G(GMTSLINE)+1
    Q
 ;-----------------------------
ENHS ;ENTRY POINT OF REMOTE DATA MEDICATIONS AS A HEALTH SUMMARY
 N GMTSHS,GMTSWRT
 Q:'$G(DFN)
 S GMTSHS=$$RDI(DFN,"^TMP($J,""GMTSRDI"")")
 S GMTSWRT=0 F  S GMTSWRT=$O(^TMP($J,"GMTSRDI",GMTSWRT)) Q:'+GMTSWRT  D
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W !,^TMP($J,"GMTSRDI",GMTSWRT,0)
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 Q
