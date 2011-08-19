SDRPA07 ;BP-OIFO/ESW - APPOINTMENT BATCH TRANSMISSION BUILDER; ; 9/14/04 9:20am  ; Compiled April 24, 2006 17:00:51  ; Compiled June 20, 2008 08:32:32
 ;;5.3;Scheduling;**290,333,349,376,446,528**;AUG 13 1993;Build 4
 ;
 ;
SNDS19(ZTSK,SDBCID,SDMCID) ;Main entry point for the sending of SIU-S19 batch messages to
 ; the National Patient Care Database
 ;
 ;Input  : ZTSK
 ;Output : SDBCID - Batch Control ID
 ;         SDMCID - Message Control ID
 ;
 ;
 ;Declare variables
 N X,X1,X2,%H
 N BATCHC,MSGN,CURLINE
 N LINEN,MSHLINE,XMITERR,HL7XMIT,ERROR,ORIGENT,ORIGMNT
 N HLEID,HL,HLECH,HLFS,HLQ,HLMID,HLMTIEN,HLDT,HLDT1,MSGID,HLRESLT,HLP
 ;Set message count limit for batch message
 ;Initialize global locations
 S XMITERR="^TMP(""SD-PAIT-BLD"","_$J_",""ERRORS"")"
 S HL7XMIT="^TMP(""HLS"","_$J_")"
 K @XMITERR,@HL7XMIT
 ;Initiate
 D INIT^HLFNC2("SD-PAIT-EVENT",.HL)
 ;Unable to initiate HL7 variable - send error bulletin - done
 ;I ($O(HL(""))="") D ERRBUL($P(HL,U,2)) Q  ; create ERRBUL later
 ;Create batch message
 D CREATE^HLTF(.HLMID,.HLMTIEN,.HLDT,.HLDT1)
 ;HLMID - value of batch ID
 ;HLMTIEN - IEN of Message Text file entry
 ;HLDT - current date/time in FM internal format
 ;HLDT1 - current date/time in HL7 format
 N SDA,SDDT S SDA=HLMID,SDDT=HLDT ; to be used to file later
 ;Unable to create batch message - send error bulletin - done
 ;I ('HLMTIEN) D ERRBUL("Unable to create batch HL7 message") Q
 ;Initialize message count
 S BATCHC=0
 ;Initialize message number
 S MSGN=0
 ;Initialize line count
 S LINEN=1
 S CURLINE=LINEN
 ;Loop through list of appointments requiring transmission
 N RUNID S RUNID=$O(^SDWL(409.6,"AD",ZTSK,""))
 N DFN,SD25,SD6,SD8,SD7,SDPATCL S DFN="" F  S DFN=$O(^TMP("SDDPT",$J,DFN)) Q:DFN=""  D
 .N SDP,ICN,SSN,SNM,FNM,MNM,DOB,SDSC,SDSCP,SDENRO,SDAPPT S SDP=^TMP("SDDPT",$J,DFN)
 .S ICN=$P(SDP,U),SSN=$P(SDP,U,2),SNM=$P(SDP,U,3),FNM=$P(SDP,U,4)
 .S MNM=$P(SDP,U,5),DOB=$P(SDP,U,6),SDSC=$P(SDP,U,7),SDSCP=$P(SDP,U,8),SDENRO=$P(SDP,U,9)
 .N SDADT S SDADT="" F  S SDADT=$O(^TMP("SDDPT",$J,DFN,SDADT)) Q:SDADT=""  D
 ..N SDPT,SDCDATE,SDADID,SDSDDT,SDSTAT,SDNAVA,SDCHKOUT,SDCDT,SDARF,SDARDT,SDNEW,SDCL,SDCLNUM,SDSTOP,SDCSTOP,SDFAC,SDDAM,SDCLNM,SDSTOPD,SDCSTOPD
 ..N SDSTOPDD,SD8RD
 ..S SDPT=^TMP("SDDPT",$J,DFN,SDADT),SDADID=$P(SDPT,U),SDDAM=$P(SDPT,U,2),SDSDDT=$P(SDPT,U,3),SDNAVA=$P(SDPT,U,5)
 ..S SDCHKOUT=$P(SDPT,U,6),SDCDT=$P(SDPT,U,7),SDARDT=$P(SDPT,U,9),SDNEW=$P(SDPT,U,10),SDCL=$P(SDPT,U,12),SDCLNM=$P(SDPT,U,13)
 ..S SDSTOP=$P(SDPT,U,14),SDCSTOP=$P(SDPT,U,15),SDFAC=$P(SDPT,U,16),SDPATCL=$P(SDPT,U,4)
 ..S SDAPPT=^TMP("SDDPT",$J,DFN,SDADT,"SCH"),SD25=$P(SDAPPT,"^",2),SD6=$P(SDAPPT,"^",3),SD8=$P(SDAPPT,"^",4),SD8RD=$P(SDAPPT,"^",7)
 ..S SDSTOPDD=^TMP("SDDPT",$J,DFN,SDADT,"STDC"),SDSTOPD=$P(SDSTOPDD,"^"),SDCSTOPD=$P(SDSTOPDD,"^",2)
 ..;calculate consult date if applicable; 446
 ..N SEQ S SEQ=0,SDCDATE="" F  S SEQ=$O(^SC(SDCL,"S",SDADT,1,SEQ)) Q:+SEQ'=SEQ  I $P($G(^SC(SDCL,"S",SDADT,1,SEQ,0)),"^")=DFN D  Q  ;SD/528 added $G
 ...S SDCSLT=$$GET1^DIQ(44.003,SEQ_","_SDADT_","_SDCL_",",688,"I")  ; consult
 ...Q:SDCSLT=""
 ...I $D(^GMR(123,SDCSLT)) S SDCDATE=$$DTCONV^SDRPA08($$GET1^DIQ(123,SDCSLT_",",3,"I")) ;date converted to HL7
 ..;Calculate message control ID
 ..S MSGN=MSGN+1
 ..S MSGID=HLMID_"-"_MSGN
 ..;Build MSG segment
 ..I (MSGID'="") D
 ...;remember orig message and event type
 ...S ORIGMNT="SIU"
 ...S ORIGENT="S12"
 ...S HL("MNT")="SIU",HL("ETN")=$P(SDAPPT,"^")
 ...;build MSH segment
 ...K RESULT D MSH^HLFNC2(.HL,MSGID,.RESULT)
 ...;reset message & event type to its orig values
 ...S HL("MNT")=ORIGMNT
 ...S HL("ETN")=ORIGENT
 ...;copy MSH segment into HL7 message
 ...S @HL7XMIT@(CURLINE)=RESULT
 ...N SDFACL S SDFACL=$P($$SITE^VASITE(),"^",3)
 ...S $P(@HL7XMIT@(CURLINE),U,4)=SDFACL ;sending facility station #
 ...S $P(@HL7XMIT@(CURLINE),U,5)="SD-AAC-PAIT" ;Receiving Application
 ...S $P(@HL7XMIT@(CURLINE),U,6)=200 ; Receiving Facility
 ...I ($D(RESULT(1))) D
 ....S @HL7XMIT@(CURLINE,1)=RESULT(1)
 ....S CURLINE=CURLINE+1
 ...E  S CURLINE=CURLINE+1
 ..;get list of segments
 ..N SDSCH S SDSCH="SCH"_HLFS_1_"^^^^^"
 ..S SD7=SDNAVA
 ..;S ^TMP("HLS",$J,CURLINE)
 ..S @HL7XMIT@(CURLINE)=SDSCH_SD6_"^"_SD7_"^"_SD8_"^^^"
 ..N SDDAT S SDDAT="~~~"_SDDAM_"~~~"_"Date Appt Created|~~~"_SDSDDT_"~~~"_"Desired Date|~~~"_SDADID_"~~~"_"Appt Date"
 ..S SDDAT=SDDAT_"|~~~"_SDCHKOUT_"~~~"_"Checkout Date"
 ..S SDDAT=SDDAT_"|~~~"_SDCDT_"~~~"_"Cancellation Date"
 ..S SDDAT=SDDAT_"|~~~"_SDARDT_"~~~"_"Auto-rebook Date"
 ..S SDDAT=SDDAT_"|~~~"_SD8RD_"~~~"_"Resched Date"
 ..S SDDAT=SDDAT_"|~~~"_SDCDATE_"~~~"_"Consult Date"
 ..;S $P(SDSCH,U,12)=SDDAT,$P(SDSCH,U,26)=SDSTAT
 ..S @HL7XMIT@(CURLINE,1)=SDDAT_"^^^^^^^^^^^^^^"_SD25
 ..S CURLINE=CURLINE+1
 ..S @HL7XMIT@(CURLINE)=$$EN^VAFHLPID(DFN,"1,3,5,7,11,19",1,1)
 ..N SDCDFN S SDCDFN=$P(@HL7XMIT@(CURLINE),"^",4),SDCDFN=SDCDFN_"|"_DFN_"~~~USVHA&&L~PI" I $P(SDCDFN,"~")["V" S $P(SDCDFN,"~",2)=""
 ..S $P(@HL7XMIT@(CURLINE),"^",4)=SDCDFN
 ..N SDZIP S SDZIP=$P(@HL7XMIT@(CURLINE),U,12),SDZIP=$P(SDZIP,"~",5) S $P(@HL7XMIT@(CURLINE),U,12)="~~~~"_SDZIP
 ..S CURLINE=CURLINE+1
 ..;get Admission Type
 ..N SDCR1,SDAT,SDCR S SDCR1=$E(SDDAM,5,8)_$E(SDDAM,1,4) D DT^DILF(,SDCR1,.SDCR) S SDAT=$$POV^SDRPA20(DFN,SDADT,SDCL,SDCR)
 ..S @HL7XMIT@(CURLINE)="PV1^1^"_SDPATCL_"^^"_SDAT_"^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"_SDFAC
 ..S CURLINE=CURLINE+1
 ..S SDNEW=$S(SDNEW=1:"NSF",SDNEW=2:"OPN",SDNEW=3:"SHB")
 ..S @HL7XMIT@(CURLINE)="PV2^^^^^^^^^^^^^^^^^^^^^^^^"_SDNEW
 ..S CURLINE=CURLINE+1
 ..I $D(^TMP("SDDPT",$J,DFN,SDADT,"ROL")) D
 ...N SDCNT,SDAIP S SDAIP="AIP^" S SDCNT="" F  S SDCNT=$O(^TMP("SDDPT",$J,DFN,SDADT,"ROL",SDCNT)) Q:SDCNT=""  D
 ....N SDPOVID,SDPROVNM,SDROLS
 ....S SDROLS=^TMP("SDDPT",$J,DFN,SDADT,"ROL",SDCNT)
 ....S SDPOVID=$P(SDROLS,U,3),SDPROVNM=$P(SDROLS,U,4),SDPROVNM=$TR(SDPROVNM,",","~")
 ....S SDPROVNM=$TR(SDPROVNM," ","~")
 ....I $L(SDPROVNM,"~")=2 S SDPROVNM=SDPROVNM_"~~"
 ....E  I $L(SDPROVNM,"~")=3 S SDPROVNM=SDPROVNM_"~"
 ....S @HL7XMIT@(CURLINE)=SDAIP_SDCNT_"^^"_SDPOVID_"~"_SDPROVNM_"^"_"Provider"
 ....S CURLINE=CURLINE+1
 ..S @HL7XMIT@(CURLINE)="AIL^1^^"_SDCL_"~~~~~~~~"_SDCLNM_"^"_SDSTOP_"~"_SDSTOPD_"~DSS Clinic ID^"_SDCSTOP_"~"_SDCSTOPD_"~DSS Credit Stop"
 ..S CURLINE=CURLINE+1
 ..N SDCNT S SDCNT="" F  S SDCNT=$O(^TMP("SDDPT",$J,DFN,SDADT,"ZCL",SDCNT)) Q:SDCNT=""  D
 ...S @HL7XMIT@(CURLINE)=^TMP("SDDPT",$J,DFN,SDADT,"ZCL",SDCNT,0)
 ...S CURLINE=CURLINE+1
 ..;create ZEN only if enrollment was retrieved
 ..I SDENRO>0 S @HL7XMIT@(CURLINE)="ZEN^1^^^^^^^^"_SDENRO,CURLINE=CURLINE+1
 ..S @HL7XMIT@(CURLINE)="ZSP^1^"_SDSC_"^"_SDSCP
 ..S CURLINE=CURLINE+1
 ..;ZEL
 ..N SDZEL D EN1^VAFHLZEL(DFN,"1,37,38",1,.SDZEL) D
 ...;need to modify 37 WITH THE CREATION DATE
 ...N SDDAMV S SDDAMV=$$HL7TFM^XLFDT(SDDAM)
 ...N SDVC S SDVC=$$CVEDT^DGCV(DFN,SDDAMV),SDVC=$P(SDVC,"^",3) D
 ....S $P(SDZEL(1),"^",38)=$S(SDVC=1:1,SDVC=0:0,1:"U")
 ....I $P(SDZEL(1),"^",39)'?8N S $P(SDZEL(1),"^",39)=""
 ...S @HL7XMIT@(CURLINE)=SDZEL(1)
 ..S CURLINE=CURLINE+1
 ..;ZMH
 ..N SAR D ENTER^VAFHLZMH(DFN,"SAR","1,5,10","3,4",HL("FS"),HL("ECH"),"")
 ..S $P(SAR(1,0),"^",4)="" ;
 ..;service separation date
 ..;combat indication and location;gulf war indication
 ..S $P(SAR(1,0),"^",5)="~"_$P($P(SAR(1,0),"^",5),"~",2)
 ..N SS F SS=2,3 D
 ...S $P(SAR(SS,0),"^",5)=""
 ..I $E($P(SAR(2,0),"^",4))'="Y" S $P(SAR(2,0),"^",4)="N~"
 ..I $E($P(SAR(3,0),"^",4))'="Y" S $P(SAR(3,0),"^",4)="N"
 ..N SDD F SDD=1,2,3 S @HL7XMIT@(CURLINE)=SAR(SDD,0) S CURLINE=CURLINE+1
 ..;file MSGID into 409.69 separately as batch # and ID #
 ..N DIE,DA D
 ...S DIE="^SDWL(409.6,"_RUNID_",1,",DA(1)=RUNID
 ...S DA=$O(^SDWL(409.6,"AC",DFN,SDADT,RUNID,"")) D
 ....I $P(^SDWL(409.6,RUNID,1,DA,0),"^",3)'="" S DA=$O(^SDWL(409.6,"AC",DFN,SDADT,RUNID,DA))
 ...S DR="2///"_+MSGID_";3///"_$P(MSGID,"-",2) D ^DIE
 D GENERATE^HLMA("SD-PAIT-EVENT","GB",1,.HLRESLT,HLMTIEN,.HLP) K @HL7XMIT
 N DA,DIE,DR S DA=RUNID,DIE=409.6,DR="1.1///"_+$G(MSGID) D ^DIE
 S SDMCID=+$G(SDMCID)
 ;file message control ID # and batch control ID number
 N DIC,DA,X,Y D
 .S DIC="^SDWL(409.6,"_RUNID_",2,",DA(1)=RUNID,DIC("P")=409.7,DIC(0)="X"
 .S SDBCID=+$G(HLRESLT)
 .K DO S X=+$G(SDBCID) D FILE^DICN
 .S DA=+Y,DIE=DIC,DR=".02///"_+$G(SDDT)_";.03///"_+$G(SDA) D ^DIE
 Q
