VAFHDD ;ALB/JLU;receives DD changes
 ;;5.3;Registration;**91**;Jun 06, 1996
 ;
EN(VAFHA,VAFHDFN,VAFHBEF) ;
 ;this is the main entry point to process any changes to a patient's
 ;record through the patient file DD.  This routine now only handles 
 ;merges from the cross-ref on dd(2,.363,  primary long id.
 ;
 ;Input
 ;VAFHA - contains a 'M'.  This tells the software that the change
 ;    is a result of a Merge.  Only a change to the Primary
 ;    Long ID can cause a Merge message to be fired.
 ;
 ;VAFHDFN - The DFN of the current patient.
 ;VAFHBEF - is only to be defined in a merge message case it will
 ;    contain the before value of Primary Long ID.
 ;
 ;Outputs
 ;there are no output variables
 ;
 I VAFHA="A" Q
 I '$$SEND^VAFHUTL() G EX
 I VAFHA="M" D
 . ;B
 . N PRIMELIG
 . I $G(VAFHDFN) S PRIMELIG=$P($G(^DPT(VAFHDFN,.36)),"^",3)
 . I PRIMELIG'=$G(VAFHBEF) D A34 ;merge needs to be generated
 I VAFHA="U" D UA08 ;update message to be generated
EX D EXIT
 Q
 ;
 ;
A34 ;this line tag will start a job that will build an A34 and A08 message.
 ;
 S ZTRTN="TA34^VAFHDD",ZTDESC="Generating A34 MERGE message"
 S ZTDTH=$H,ZTIO="",(ZTSAVE("VAFHBEF"),ZTSAVE("VAFHDFN"))=""
 D ^%ZTLOAD
 K ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTSAVE
 Q
 ;
 ;
TA34 ;This line tag is the job that will generate the message to send
 ;an A34.
 ;
 S VAFHPID="1,2,4,6,7,8,11,12,13,14,16,19"
 S VAFHZPD="2,3,4,5,6,7,8,9,10,11,12,13,14,15"
 K HLERR
 S VAFHGBL="^TMP(""HLS"","_$J_")"
 K ^TMP("HLS",$J)
 K HL D INIT^HLFNC2("VAFH A34",.HL)
 I $D(HL)=1 DO  G ET34
 . S HLERR="-1^Unable to generate an A34 for "_VAFHDFN_" error in "_$P(HL,"^",2)
 ;
 S HLMTN="ADT"_$E(HL("ECH"))_"A34"
 S CTR=1
 ;;the next two lines were for a batch message that may need to be sent
 ;;if a followup A08 is needed as a result of a merge message.  It was
 ;;determined late that this is not needed yet.
 ;;S @VAFHGBL@(CTR)=$$BHS^HLFNC1(HLMTN) ;builds the batch header
 ;;S CTR=CTR+1
 S VAFHVAR=$$EN^VAFHLA34(VAFHDFN,VAFHGBL,CTR,HLMTN,VAFHBEF,"05",VAFHPID,VAFHZPD) ;this call creates the A34 message
 I 'VAFHVAR S HLERR="-1^Unable to generate an A34 for "_VAFHDFN_" "_$P(VAFHVAR,U,2) G ET34
 S CTR=$P(VAFHVAR,U,2)
 S CTR=CTR+1
 ;;D MA08 ;creates the A08 follow message
 S HLEVN=1
 S HLSDT="VAFHMRG" ;this set is necessary do not remove.
 D GENERATE^HLMA("VAFH A34","GM",1,.HLRST,,)
ET34 D EXIT
 Q
 ;
EXIT ;cleans up the variables
 I $D(HLERR)!($D(HL)=1) DO
 .N ERR
 .S ERR="ERR"
 .S @ERR@(1)=$G(HLERR)
 .S @ERR@(2)=$G(HL)
 .S @ERR@(3)=$G(HLRST)
 .S:'$D(VAFHDT) VAFHDT=DT
 .S:'$D(VAFHPIV) VAFHPIV=""
 .D EBULL^VAFHUTL2(VAFHDFN,VAFHDT,+VAFHPIV,ERR) ;if an error call the bulletin routine to send an error bulletin.
 .Q
 D KILL^HLTRANS
 K VAFHVAR,^TMP("HLS",$J),VAFHPV1F,VAFHDG1F,VAFHPID,VAFHZPD,VAFHGBL,VAFHVAR,CTR,ERR,VAFHDT,VAFHPIV,VAFHPTR,VAFHPIV1,VAFHLTD,VAFHTYPE,VAFHA08
 K HLEVN,HLSDT,HLEVN,HLMTN,HLNDAP
 Q
 ;
UA08 ;This will build the A08 message for an update event.
 ;
 S VAFHPTR=VAFHDFN_";DPT("
 S VAFHDT=$P(DT,".")
 S VAFHPIV=$$PIVNW^VAFHPIVT(VAFHDFN,VAFHDT,4,VAFHPTR) ;since no entry make a new one
 I +VAFHPIV<0 S HLERR="-1^Could not create update entry in Pivot file."
 Q:$D(HLERR)
 S VAFHPIV1=$$SETTRAN^VAFHPIV2(+VAFHPIV) ;set the transmit field in the pivot entry
 I +VAFHPIV1<0 S HLERR="-1^Could not set the Transmit field for Pivot entry "_VAFHPIV
 Q
 ;
MA08 ;creates an A08 message for a merge event
 S VAFHLTD=$$LTD^VAFHUTL(VAFHDFN) ;get the last activity for the veteran
 I VAFHLTD<0 DO  ;if no activity send an update a08 with like UA08
 .S VAFHTYPE=4
 .S VAFHPTR=VAFHDFN_";DPT("
 .S VAFHDT=$P(DT,".")
 .Q
 I VAFHLTD>0 DO  ;if activity send that pivot number and A08 type
 .S VAFHTYPE=$S($P(VAFHLTD,U,2)="R":3,"ID"[$P(VAFHLTD,U,2):1,"AS"[$P(VAFHLTD,U,2):2,1:4)
 .S VAFHPTR=$P(VAFHLTD,U,4)
 .S VAFHDT=$P(VAFHLTD,U)
 .Q
 S VAFHPIV=$$PIVNW^VAFHPIVT(VAFHDFN,VAFHDT,VAFHTYPE,VAFHPTR) ;creates a new Pivot entry
 I VAFHPIV<0 S HLERR=VAFHPIV Q
 S VAFHPV1F=$S(34[VAFHTYPE:50,1:"A")
 S VAFHDG1F=$S(34[VAFHTYPE:"",1:"A")
 I VAFHTYPE=1 ;     DO RICH'S
 I VAFHTYPE>1 DO
 .S VAFHPV1F=$S(34[VAFHTYPE:50,1:"A")
 .S VAFHDG1F=$S(34[VAFHTYPE:"",1:"A")
 .S VAFHA08=$$UP^VAFHCA08(VAFHDFN,+VAFHPIV,$P(VAFHPIV,U,2),CTR,VAFHGBL,VAFHPID,VAFHZPD,VAFHPV1F,VAFHDG1F) ;creates the A08 for the type of event (outpatient) ONLY TO USE VISIT NUMBER FOR REGISTRATIONS
 .I VAFHA08<0 S HLERR=VAFHA08
 Q
