IVM2034Z ;HEC/KSD - Correction software for HL7 Upgrade ; 7/10/02 10:13am
 ;;2.0;INCOME VERIFICATION MATCH;**60,59**;
 Q
 ;
EN ; fix the ACK routine for the QRY-Z10 and QRY-Z11 in the
 ; server protocol.
 ;
 N SITE,PROT,DGENDA,DATA,ERROR,RETURN,FILE
 ;
 S FILE=101
 S SITE=$P($$SITE^VASITE,"^",3)
 S PROTSTUB="VAMC "_SITE_" QRY-"
 S DATA(772)="D ORF^IVMCM"
 ;
 ; Update Financial Query
 S PROTOCOL=PROTSTUB_"Z10 SERVER"
 S DGENDA=+$O(^ORD(101,"B",PROTOCOL,""))
 S DATA(.01)=PROTOCOL
 S RETURN=$$UPD^DGENDBS(FILE,.DGENDA,.DATA,.ERROR)
 I ERROR'=""!(+RETURN=0) W "ERROR in Updating Financial Query" Q
 ;
 ; Update Enrollment/Eligibility Query
 S PROTOCOL=PROTSTUB_"Z11 SERVER"
 S DGENDA=+$O(^ORD(101,"B",PROTOCOL,""))
 S DATA(.01)=PROTOCOL
 S RETURN=$$UPD^DGENDBS(FILE,.DGENDA,.DATA,.ERROR)
 I ERROR'=""!(+RETURN=0) W "ERROR in Updating Enrollment/Eligibility Query" Q
 Q
 ;
ADSIN ;Entry Point;
 ;The ADS x-ref is being deleted by the #301.6 Status field Kill
 ;logic when the ORU-Z07 is retransmitted after 3 days.  When the
 ;ORU-Z07 ACK is returning the Message Control ID is unable to find
 ;the original ORU-Z07.  Code falls into wrong processing and gets
 ;an allocation error.
 ;1. modify Kill logic to NOT remove x-ref (done by patch)
 ;2. reset ADS x-ref for 30 days into the past
 N RTN,IEN,STOP,TRANSDT,BEGDT,ENDDT,MSGCID,X1,X2,NO2,NODE
 ;
 S RTN="IVM2034Z"
 S DESC="Temporary re-setting of ADS x-ref"
 S ^XTMP(RTN,0)=$$HTFM^XLFDT($H+90,1)_"^"_$$DT^XLFDT()_"^"_DESC
 ;
 ; Reset the ADS x-ref beginning at 30 days in the past.
 S (NOW,X1)=$P($$NOW^XLFDT,"."),X2=-30
 D C^%DTC
 S BEGDT=X
 S X1=NOW,X2=-1
 D C^%DTC
 S ENDDT=X
 S (IEN,STOP)=0
 F  S IEN=$O(^IVM(301.6,IEN)) Q:IEN=""  D  Q:STOP
 . S NODE=$G(^IVM(301.6,IEN,0))
 . S TRANSDT=+$P($P(NODE,"^",2),".")
 . Q:TRANSDT<BEGDT
 . I TRANSDT>ENDDT S STOP=1 Q
 . S MSGCID=$P(NODE,"^",5)
 . S ^IVM(301.6,"ADS",MSGCID,IEN)=""
 . S ^XTMP(RTN,MSGCID,IEN)=""
 Q
 ;
ADSOUT ;Entry Point;
 ;The ADSIN line label reset the ADS x-ref for entries a week
 ;before the time of running.  This software will undo that
 ;change.  It will remove all the ADS x-ref's that were added.
 ;
 N RTN,IEN,MSGCID
 ;
 S RTN="IVM2034Z"
 ;
 ; Remove the ADS x-ref's set by the ADSIN running.
 ;
 S MSGCID=0
 F  S MSGCID=$O(^XTMP(RTN,MSGCID)) Q:MSGCID=""  D
 . S IEN=""
 . F  S IEN=$O(^XTMP(RTN,MSGCID,IEN)) Q:IEN=""  D
 . . K ^IVM(301.6,"ADS",MSGCID,IEN)
 Q
