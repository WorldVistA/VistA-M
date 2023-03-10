VAFCTFNP ;BIR/DRI - NEW PERSON TREATING FACILITY MFU PROCESSING ;4/28/21  16:58
 ;;5.3;Registration;**1042,1050**;Aug 13, 1993;Build 2
 ;
 ;Reference to $$HLDATE^HLFNC supported by IA# 10106
 ;Reference to $$SITE^VASITE supported by IA# 10112
 ;Reference to $$NOW^XLFDT supported by IA# 10103
 ;Reference to $$IEN^XUAF4 supported by IA# 2171
 ;
 ;
 ;**1042, VAMPI-8215 (dri) - New Person Treating Facility Update Processing
 ;
 ; Since the MPI controls the treating facility update messages we
 ; can assume the inbound array will contain a complete list of
 ; the treating facilities found on the MPI.
 ;
EN(MFI,MFA) ;entry point to process the inbound treating facility list
 ; Input (example of incoming treating facility list from MPI):
 ;   MFI="MFI^TFL^^REP^^^NE^101~CENTRAL OFFICE"
 ;   MFI("1008785167V219208",500,1)="^^MAD^^^^12596^A^USDVA^PN"   
 ;   MFI("1008785167V219208","200AD",1)="^^MAD^^^^23107^A^USDVA^PN"
 ;   MFI("1008785167V219208","200M",1)="^^MAD^^^^12596^A^USDVA^PN"
 ;   MFI("1008785167V219208","200PIV",1)="^^MAD^^^^512388^A^USDVA^EI"
 ;   MFI("1008785167V219208","200PROV",1)="^^MAD^^^^1008785167^A^USDVA^PN"
 ;   MFI("1008785167V219208","200UPN",1)="^^MAD^^^^DAN.XXXXXXXXX^A^USDVA^PN"
 ;
 ; Output (example of response/ack messages returned):
 ;   MFA(500,1)="MFA^MAD^500-1^20210305114020-0600^S"
 ;   MFA("200AD",1)="MFA^MAD^200AD-1^20210305114020-0600^S"
 ;   MFA("200M",1)="MFA^MAD^200M-1^20210305114020-0600^S"
 ;   MFA("200PIV",1)="MFA^MAD^200PIV-1^20210305114020-0600^S"
 ;   MFA("200PROV",1)="MFA^MAD^200PROV-1^20210305114020-0600^S"
 ;   MFA("200UPN",1)="MFA^MAD^200UPN-1^20210305114020-0600^S"
 ;
 N AA,ERROR,FDA,GLO,ICN,IDENSTAT,IDTYP,LOC,MATCH,MFECNT,NPIEN,NPTFIEN,SOURCEID,SOURCESYS,SOURCESYSIEN,STANUM,UPDATE,UPDTYP,VAFCARR,VAFCERR,VAFCFDA,VAFCIEN
 ;
 S STANUM=$P($$SITE^VASITE(),"^",3) ;station number of this site
 ;
 ;Find the first active identifier for THIS site, should be the person's
 ;DUZ from the new person (#200) file.  This will become the ien (#.01)
 ;for the new person treating facility (#391.92) file. Also get the ICN
 S NPIEN=0,ICN=""
 S LOC="MFI(0)" F  S LOC=$Q(@LOC) Q:LOC=""  Q:$QS(LOC,1)'["V"  I $QS(LOC,2)=STANUM,+$P(@LOC,"^",7),$D(^VA(200,+$P(@LOC,"^",7),0)),($P(@LOC,"^",8)="A"),($P(@LOC,"^",9)="USDVA"),($P(@LOC,"^",10)="PN") S ICN=$QS(LOC,1),NPIEN=$P(@LOC,"^",7) Q
 ;
 ;if we're this far without an icn or npien, bigger issue with the message
 ;these will end up in the response/ack message back to the mpi
 I 'NPIEN S ERROR(STANUM)="Update at Station: "_STANUM_" failed due to invalid New Person ID"
 I ICN="" S ERROR(STANUM)="Update at Station: "_STANUM_" failed due to invalid ICN"
 ;
 ;file the icn as an identifier for this new person so the icn can be
 ;used as a lookup by the 'VAFC LOCAL GETCORRESPONDINGIDS' rpc to return
 ;the tf's from the NEW PERSON TREATING FACILITY LIST (#391.92) file
 ;remember to screen this record below when doing compares to the inbound
 ;tf list because it will never be found in that list
 I NPIEN,(ICN'=""),'$O(^DGCN(391.92,"AISS",ICN,"NI","USVHA",$$IEN^XUAF4("200M"),0)) D
 .S FDA(391.92,"+1,",.01)=NPIEN
 .S FDA(391.92,"+1,",.02)=$$IEN^XUAF4("200M")
 .S FDA(391.92,"+1,",.03)=ICN
 .S FDA(391.92,"+1,",.04)="NI"
 .S FDA(391.92,"+1,",.05)="USVHA"
 .S FDA(391.92,"+1,",.06)="A"
 .D ADD(.FDA,.ERROR)
 ;
COMP1 ;compare existing new person tf's to incoming tf's to see what needs deleted
 ;removing deleted tf's first reduce overall number of tf's to add/update
 I NPIEN S GLO="^DGCN(391.92,""APAT"",NPIEN)" F  S GLO=$Q(@GLO) Q:GLO=""  Q:$QS(GLO,2)'="APAT"  Q:$QS(GLO,3)'=NPIEN  S NPTFIEN=$QS(GLO,5) I NPTFIEN D
 .K VAFCARR D GETS^DIQ(391.92,NPTFIEN_",",".02;.03;.04;.05;.06","I","VAFCARR")
 .I VAFCARR(391.92,NPTFIEN_",",.02,"I")=$$IEN^XUAF4("200M"),(VAFCARR(391.92,NPTFIEN_",",.03,"I")=ICN),(VAFCARR(391.92,NPTFIEN_",",.04,"I")="NI"),(VAFCARR(391.92,NPTFIEN_",",.05,"I")="USVHA") Q  ;don't compare icn identifier used for rpc lookup
 .;
 .S MATCH=0
 .S LOC="MFI(0)" F  S LOC=$Q(@LOC) Q:LOC=""  D  I MATCH Q  ;incoming tf's
 ..S ICN=$QS(LOC,1)
 ..S SOURCESYS=$QS(LOC,2),SOURCESYSIEN=+$$IEN^XUAF4(SOURCESYS)
 ..S MFECNT=$QS(LOC,3)
 ..S UPDTYP=$P(@LOC,"^",3) ;MUP - update tf, MAD - add tf, MDL - delete tf, MDC - deactivate/merged tf
 ..S SOURCEID=$P(@LOC,"^",7)
 ..S IDENSTAT=$P(@LOC,"^",8)
 ..S AA=$P(@LOC,"^",9)
 ..S IDTYP=$P(@LOC,"^",10)
 ..I VAFCARR(391.92,NPTFIEN_",",.02,"I")=SOURCESYSIEN,(VAFCARR(391.92,NPTFIEN_",",.03,"I")=SOURCEID),(VAFCARR(391.92,NPTFIEN_",",.04,"I")=IDTYP),(VAFCARR(391.92,NPTFIEN_",",.05,"I")=AA) S MATCH=1 Q  ;tf exists
 .;
 .I 'MATCH D  Q  ;tf doesn't currently exist, delete
 ..S FDA(391.92,NPTFIEN_",",.01)="@"
 ..D UPDATE(NPTFIEN,.FDA,.ERROR) Q
 ..;note - local deletes don't require mfa response/ack
 ;
COMP2 ;compare incoming tf's to existing tf's to see what needs added or updated
 S LOC="MFI(0)" F  S LOC=$Q(@LOC) Q:LOC=""  D  ;incoming tf's
 .S ICN=$QS(LOC,1)
 .S SOURCESYS=$QS(LOC,2),SOURCESYSIEN=+$$IEN^XUAF4(SOURCESYS)
 .S MFECNT=$QS(LOC,3)
 .S UPDTYP=$P(@LOC,"^",3) ;MUP - update tf, MAD - add tf, MDL - delete tf, MDC - deactivate/merged tf
 .S SOURCEID=$P(@LOC,"^",7)
 .S IDENSTAT=$P(@LOC,"^",8)
 .S AA=$P(@LOC,"^",9)
 .S IDTYP=$P(@LOC,"^",10)
 .;
 .S MATCH=0,UPDATE=0
 .I NPIEN S NPTFIEN=0 F  S NPTFIEN=$O(^DGCN(391.92,"APAT",NPIEN,SOURCESYSIEN,NPTFIEN)) Q:'NPTFIEN  D  I MATCH!UPDATE Q
 ..K VAFCARR D GETS^DIQ(391.92,NPTFIEN_",",".02;.03;.04;.05;.06","I","VAFCARR")
 ..I VAFCARR(391.92,NPTFIEN_",",.02,"I")=$$IEN^XUAF4("200M"),(VAFCARR(391.92,NPTFIEN_",",.03,"I")=ICN),(VAFCARR(391.92,NPTFIEN_",",.04,"I")="NI"),(VAFCARR(391.92,NPTFIEN_",",.05,"I")="USVHA") Q  ;don't compare icn identifier used for rpc lookup
 ..I VAFCARR(391.92,NPTFIEN_",",.02,"I")=SOURCESYSIEN,(VAFCARR(391.92,NPTFIEN_",",.03,"I")=SOURCEID),(VAFCARR(391.92,NPTFIEN_",",.04,"I")=IDTYP),(VAFCARR(391.92,NPTFIEN_",",.05,"I")=AA) S MATCH=1 ;tf exists
 ..I MATCH,(VAFCARR(391.92,NPTFIEN_",",.06,"I")'=IDENSTAT) S UPDATE=1 ;tf needs updated due to status change
 .;
 .I NPIEN,'MATCH D  Q  ;tf doesn't currently exist, add tf
 ..S FDA(391.92,"+1,",.01)=NPIEN
 ..S FDA(391.92,"+1,",.02)=SOURCESYSIEN
 ..S FDA(391.92,"+1,",.03)=SOURCEID
 ..S FDA(391.92,"+1,",.04)=IDTYP
 ..S FDA(391.92,"+1,",.05)=AA
 ..S FDA(391.92,"+1,",.06)=IDENSTAT
 ..D ADD(.FDA,.ERROR)
 ..S MFA(SOURCESYS,MFECNT)="MFA"_HL("FS")_UPDTYP_HL("FS")_SOURCESYS_"-"_MFECNT_HL("FS")_$$HLDATE^HLFNC($$NOW^XLFDT)_HL("FS")_$S('$D(ERROR):"S",1:"U"_HLCOMP_$G(ERROR("DIERR",1,"XT",1))_HL("FS")) ;repond successful or if error unsuccessful
 .;
 .I NPIEN,UPDATE D  Q  ;identifier status has changed, update tf
 ..S FDA(391.92,NPTFIEN_",",.06)=IDENSTAT
 ..D UPDATE(NPTFIEN,.FDA,.ERROR)
 ..S MFA(SOURCESYS,MFECNT)="MFA"_HL("FS")_UPDTYP_HL("FS")_SOURCESYS_"-"_MFECNT_HL("FS")_$$HLDATE^HLFNC($$NOW^XLFDT)_HL("FS")_$S('$D(ERROR):"S",1:"U"_HLCOMP_$G(ERROR("DIERR",1,"XT",1))_HL("FS")) ;repond successful or if error unsuccessful
 .;
 .;if no add or updates respond/ack as successful
 .;if error with message respond/ack as unsuccessful
 .S MFA(SOURCESYS,MFECNT)="MFA"_HL("FS")_UPDTYP_HL("FS")_SOURCESYS_"-"_MFECNT_HL("FS")_$$HLDATE^HLFNC($$NOW^XLFDT)_HL("FS")_$S('$D(ERROR(STANUM)):"S",1:"U"_HLCOMP_$G(ERROR(STANUM))_HL("FS"))
 ;
 Q
 ;
ADD(VAFCFDA,VAFCERR) ;add new person treating facilities
 K VAFCERR
 D UPDATE^DIE(,"VAFCFDA",,"VAFCERR")
 Q
 ;
UPDATE(VAFCIEN,VAFCFDA,VAFCERR) ;update or delete new person treating facilities
 K VAFCERR
 L +^DGCN(391.92,VAFCIEN):10 I '$T Q
 D FILE^DIE("","VAFCFDA","VAFCERR")
 L -^DGCN(391.92,VAFCIEN)
 Q
 ;
CLEANUP(ICN) ;delete new person treating facilities from #391.92 when person becomes a patient ;**1050, VAMPI-9501 (dri)
 N FDA,NPIEN,NPTFIEN
 S NPTFIEN=+$O(^DGCN(391.92,"AISS",ICN,"NI","USVHA",$$IEN^XUAF4("200M"),0)) ;find icn ien in 391.92
 S NPIEN=$P($G(^DGCN(391.92,NPTFIEN,0)),"^",1) ;find new person ien
 I NPIEN S NPTFIEN=0 F  S NPTFIEN=$O(^DGCN(391.92,"B",NPIEN,NPTFIEN)) Q:'NPTFIEN  S FDA(391.92,NPTFIEN_",",.01)="@" D UPDATE(NPTFIEN,.FDA) ;remove all of a new person's tf's
 Q
 ;
