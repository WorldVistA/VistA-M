IVMPREC6 ;ALB/KCL,BRM,CKN,TDM,PWC,LBD,KUM - PROCESS INCOMING (Z05 EVENT TYPE) HL7 MESSAGES ;09-02-2019 8:06AM
 ;;2.0;INCOME VERIFICATION MATCH;**3,4,12,17,34,58,79,102,115,140,144,121,151,152,165,167,171,164,188**;21-OCT-94;Build 12
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; This routine will process batch ORU demographic (event type Z05) HL7
 ; messages received from the IVM center.  Format of HL7 batch message:
 ;
 ;       BHS
 ;       {MSH
 ;        PID
 ;        ZPD
 ;        ZTA
 ;        ZAV
 ;        ZGD
 ;        ZCT (1 episode required, multiple possible)
 ;        ZEM (Veteran)
 ;        ZEM (Spouse - Optional)
 ;        RF1 (optional, multiple possible)
 ;       }
 ;       BTS
 ;
 ;
EN ; - entry point to process HL7 patient demographic message 
 ;
 N DGENUPLD,VAFCA08,DGRUGA08,COMP,DODSEG,GUARSEG,IVMCSDT,IVMCEDT,IVMCAFG,IVMCAVL,IVMPMAST,IVMCMAST
 ;N MULTDONE,XREP
 N XIVMA,IVMALADT,MULTIDONE
 N IVMPHDFG S IVMPHDFG=0 ; IVM*2*171 - add new variable IVMPHDFG to check for PHH deletion
 S IVMPMAST=""
 ;
 ; Setup array to hold all the Allowed Address Types
 ;F XIVMA="N","P","VAB1","VAB2","VAB3","VAB4" S IVMALADT(XIVMA)=""
 ; IVM*2.0*164 - Allow Residential and Confidential Addresses
 F XIVMA="P","R","CA","VAB1","VAB2","VAB3","VAB4" S IVMALADT(XIVMA)=""
 ; Define the Confidential Address Categories
 ; IVM*2.0*164 - Uncomment below five lines to enable all confidential address categories
 S IVMALADT("VACAE")="CA^1"      ; ELIGIBILITY/ENROLLMENT
 S IVMALADT("VACAA")="CA^2"      ; APPOINTMENT/SCHEDULING
 S IVMALADT("VACAC")="CA^3"      ; COPAYMENTS/VETERAN BILLING
 S IVMALADT("VACAM")="CA^4"      ; MEDICAL RECORDS
 S IVMALADT("VACAO")="CA^5"      ; ALL OTHERS
 ; prevent a return Z07 when uploading a Z05 (Patient file triggers)
 S DGENUPLD="ENROLLMENT/ELIGIBILITY UPLOAD IN PROGRESS"
 ;
 ; prevent MPI A08 message when uploading Z05 (Patient file triggers)
 S VAFCA08=1  ;MPI/CIRN A08 suppression flag
 ;
 S IVMFLG=0,IVMADFLG=0
 ; - get incoming HL7 message from HL7 Transmission (#772) file
 F IVMDA=0:0 S IVMDA=$O(^TMP($J,IVMRTN,IVMDA)) Q:'IVMDA  S IVMSEG=$G(^(IVMDA,0)) I $E(IVMSEG,1,3)="MSH" D
 .K HLERR,ZEMADRUP
 .S IVMTSTPT=""                          ;Initialize Temp Addr County
 .;
 .; - message control id from MSH segment
 .S MSGID=$P(IVMSEG,HLFS,10),HLMID=MSGID
 .;
 .; - perform demographics message consistency check
 .D EN^IVMPRECA Q:$D(HLERR)
 .;
 .;Set array of Email, Cell, Pager fields
 .D EPCFLDS(.EPCFARY,.EPCDEL)
 .D AUPBLD(.AUPFARY,.UPDAUPG)
 .; - get next msg segment
 .D NEXT I $E(IVMSEG,1,3)'="PID" D  Q
 ..S HLERR="Missing PID segment" D ACK^IVMPREC
 .;
 .F I=1:1 D NEXT Q:$E(IVMSEG,1,4)="ZPD^"  ;Go through all PID
 .; - patient IEN (DFN) from PID segment
 .;Use IVMPID array created in IVMPRECA while performing consistency
 .;to process PID segment
 .;
 .;I '$G(IVMDFN) S HLERR="Invalid DFN" D ACK^IVMPREC  Q
 .S DFN=$G(IVMDFN)
 .;I ('DFN!(DFN'=+DFN)!('$D(^DPT(+DFN,0)))) D  Q
 .;.S HLERR="Invalid DFN" D ACK^IVMPREC
 .;I IVMPID(19)'=$P(^DPT(DFN,0),"^",9) D  Q
 .;.S HLERR="Couldn't match HEC SSN with DHCP SSN" D ACK^IVMPREC
 .;
 .; - check for entry in IVM PATIENT file, otherwise create stub entry
 .S IVM3015=$O(^IVM(301.5,"B",DFN,0))
 .I 'IVM3015 S DGENUPLD="",IVM3015=$$LOG^IVMPLOG(DFN,DT),DGENUPLD="ENROLLMENT/ELIGIBILITY UPLOAD IN PROGRESS" ;IVM*2.0*165
 .I 'IVM3015 D  Q
 ..S HLERR="Failed to create entry in IVM PATIENT file"
 ..D ACK^IVMPREC
 .;
 .; - compare PID segment fields with DHCP fields
 .S IVMSEG="PID"  ;Setting IVMSEG to PID before it calls COMPARE
 .I 'DODSEG,'GUARSEG D COMPARE(IVMSEG) Q:$D(HLERR)
 .;
 .; - get next msg segment -decrement the counter so it can pickup ZPD
 .S IVMDA=IVMDA-1 D NEXT I $E(IVMSEG,1,3)'="ZPD" D  Q
 ..S HLERR="Missing ZPD segment" D ACK^IVMPREC
 .;Convert "" to null in ZPD segment except seq. 8,9, 31 and 32
 .S IVMSEG=$$CLEARF^IVMPRECA(IVMSEG,HLFS,",9,10,32,33,")
 .;
 .; - compare ZPD segment fields with DHCP fields
 .D COMPARE(IVMSEG)
 .;
 .; - get next msg segment
 .D NEXT I $E(IVMSEG,1,3)="ZEL" D  Q
 ..S HLERR="ZEL segment should not be sent in Z05 message" D ACK^IVMPREC
 .;
 .I $E(IVMSEG,1,3)'="ZTA" D  Q
 ..S HLERR="Missing ZTA segment" D ACK^IVMPREC
 .;Convert "" to null in ZTA segment seq. 7
 .I $P(IVMSEG,HLFS,8)=HLQ S $P(IVMSEG,HLFS,8)=""
 .;
 .; - compare ZTA segment fields with DHCP fields
 .I 'DODSEG,'GUARSEG D COMPARE(IVMSEG)
 .;
 .; - get next msg segment
 .; KUM - ZAV Segment Processing (CASS field) 
 .D NEXT
 .I $E(IVMSEG,1,3)'="ZAV" D  Q
 ..S HLERR="Missing ZAV segment" D ACK^IVMPREC
 .S IVMSEG=$$CLEARF^IVMPRECA(IVMSEG,HLFS)
 .I 'DODSEG,'GUARSEG D COMPARE(IVMSEG) ;Process 1st ZAV
 .S MULTDONE=0 F XREP=1:1 D  Q:MULTDONE  ;Handle possible mult ZAVs
 ..D NEXT I $E(IVMSEG,1,3)'="ZAV" S MULTDONE=1 Q
 ..S IVMSEG=$$CLEARF^IVMPRECA(IVMSEG,HLFS)
 ..I 'DODSEG,'GUARSEG D COMPARE(IVMSEG)
 .;D NEXT
 .;
 .; - get next msg segment
 .I $E(IVMSEG,1,3)'="ZGD" D  Q
 ..S HLERR="Missing ZGD segment" D ACK^IVMPREC
 .;
 .; - compare ZGD segment fields with DHCP fields
 .; convert "" to null for ZGD segment
 .S IVMSEG=$$CLEARF^IVMPRECA(IVMSEG,HLFS,",7,") ;ignore seq. 6
 .; convert seq. 6 separately
 .S $P(IVMSEG,HLFS,7)=$$CLEARF^IVMPRECA($P(IVMSEG,HLFS,7),$E(HLECH))
 .D COMPARE(IVMSEG)
 .;S IVMFLG=0
 .;
 .;S MULTDONE=0 F XREP=1:1 D  Q:MULTDONE  ;Skip ZCT & ZEM -coming later
 .;.D NEXT
 .;.I ($E(IVMSEG,1,3)'="ZCT")&($E(IVMSEG,1,3)'="ZEM") S MULTDONE=1 Q
 .;S IVMDA=IVMDA-1
 .;
 .; - get next msg segment
 .D NEXT
 .I $E(IVMSEG,1,3)'="ZCT" D  Q
 ..S HLERR="Missing ZCT segment" D ACK^IVMPREC
 .;KUM - Donot convert "" to null in ZCT segment 
 .;IVM*2.0*188 - Comment below line.  Allow double quotes to stay in ZCT segment, otherwise double quotes will be replaced with null
 .;S IVMSEG=$$CLEARF^IVMPRECA(IVMSEG,HLFS)
 .I 'DODSEG,'GUARSEG D COMPARE(IVMSEG)   ;Process 1st ZCT
 .S MULTDONE=0 F XREP=1:1 D  Q:MULTDONE  ;Handle possible mult ZCTs
 ..D NEXT I $E(IVMSEG,1,3)'="ZCT" S MULTDONE=1 Q
 ..;KUM - Donot convert "" to null in ZCT segment 
 ..;IVM*2.0*188 - Comment below line.  Allow double quotes to stay in ZCT segment, otherwise double quotes will be replaced with null
 ..;S IVMSEG=$$CLEARF^IVMPRECA(IVMSEG,HLFS)
 ..I 'DODSEG,'GUARSEG D COMPARE(IVMSEG)
 .;
 .S IVMDA=IVMDA-1 D NEXT
 .I $E(IVMSEG,1,3)'="ZEM" D  Q
 ..S HLERR="Missing ZEM segment" D ACK^IVMPREC
 .I 'DODSEG,'GUARSEG D COMPARE(IVMSEG)   ;Process 1st ZEM
 .S MULTDONE=0 F XREP=1:1 D  Q:MULTDONE  ;Handle possible mult ZEMs
 ..D NEXT I $E(IVMSEG,1,3)'="ZEM" S MULTDONE=1 Q
 ..I 'DODSEG,'GUARSEG D COMPARE(IVMSEG)
 .S IVMDA=IVMDA-1
 .;
 .; - check for RF1 segment and get segment if it exists
 .;     This process will automatically update patient address data
 .;     in the Patient (#2) file if the incoming address is more
 .;     recent than the existing one.
 .;Modified code to handle multiple RF1 segment - IVM*2*115
 .S (UPDEPC("SAD"),UPDEPC("CPH"),UPDEPC("PNO"),UPDEPC("EAD"),UPDEPC("PHH"))=0
 .S QFLG=0 I $$RF1CHK(IVMRTN,IVMDA) F I=1:1 D  Q:QFLG
 ..D NEXT
 ..S IVMSEG=$$CLEARF^IVMPRECA(IVMSEG,HLFS,",7,") ;ignore seq. 6
 ..S $P(IVMSEG,HLFS,7)=$$CLEARF^IVMPRECA($P(IVMSEG,HLFS,7),$E(HLECH))
 ..I $P(IVMSEG,HLFS,4)="" S QFLG=1 Q  ;Quit if RF1 is blank
 ..D COMPARE(IVMSEG)
 ..I '$$RF1CHK(IVMRTN,IVMDA) S QFLG=1
 .; KUM - IVM*2.0*164 - Set Confidential Active flag
 .S IVMCSDT="",IVMCEDT="",IVMCAFG=.14105,IVMCAVL="Y"
 .S IVMCSDT=$P($P($G(ADDRESS("CA")),"~",12),"&",1)
 .S IVMCSDT=$$FMDATE^HLFNC(IVMCSDT)
 .S IVMCEDT=$P($P($G(ADDRESS("CA")),"~",12),"&",2)
 .S IVMCEDT=$$FMDATE^HLFNC(IVMCEDT)
 .I IVMCSDT="" D
 ..;I $G(UPDAUPG("CA"))'=1 Q
 ..S IVMCAVL="N"
 .D AUTOAUP^IVMPREC9(DFN,.UPDAUP,.UPDAUPG)
 .S IVMFLG=0
 ; - send mail message if necessary
 ; This bulletin has been disabled.  IVM*2*140
 ;I IVMCNTR D MAIL^IVMUFNC()
 ; Cleanup variables if no msg necessary
 I 'IVMCNTR K IVMTEXT,XMSUB
 ;
ENQ ; - cleanup variables
 K DA,DR,DFN,IVMADDR,IVMADFLG,IVMDA,IVMDHCP,IVMFLAG,IVMFLD,IVMPHDFG,IVMPIECE,IVMSEG,IVMSTART,IVMXREF,DGENUPLD,IVMPID,PIDSTR,ADDRESS,TELECOM,UPDEPC,EPCFARY,IVMDFN,DODSEG,EPCDEL,GUARSEG,UPDAUP,IVMRACE,IVMTSTPT,IVMPMAST
 Q
 ;
 ;
NEXT ; - get the next HL7 segment in the message from HL7 Transmission (#772) file
 ;
 S IVMDA=$O(^TMP($J,IVMRTN,IVMDA)),IVMSEG=$G(^(+IVMDA,0))
 Q
 ;
 ;
COMPARE(IVMSEG) ; - compare incoming HL7 segment/fields with DHCP fields
 ;
 ;  Input:  IVMSEG  --  as the text of the incoming HL7 message
 ;
 ; Output:  None
 ;
 ; - get 3 letter HL7 segment name
 S IVMXREF=$P(IVMSEG,HLFS,1),IVMSTART=IVMXREF
 ;
 ; - strip off HL7 segment name
 S IVMSEG=$P(IVMSEG,HLFS,2,99)
 ;
 ; - roll through "C" x-ref in IVM Demographic Upload Fields (#301.92) file
 F  S IVMXREF=$O(^IVM(301.92,"C",IVMXREF)) Q:IVMXREF']""  D
 .S IVMDEMDA=$O(^IVM(301.92,"C",IVMXREF,"")) Q:IVMDEMDA']""
 .I $$INACTIVE(IVMDEMDA) Q
 .;
 .; - compare incoming HL7 segment fields with DHCP fields
 .I IVMXREF["PID",(IVMSTART["PID") D PID^IVMPREC8
 .I IVMXREF["ZPD",(IVMSTART["ZPD") D ZPD^IVMPREC8
 .I IVMXREF["ZTA",(IVMSTART["ZTA") D ZTA^IVMPREC8
 .; KUM IVM*2.0*164 - ZAV Segment Processing
 .I IVMXREF["ZAV",(IVMSTART["ZAV") D ZAV^IVMPREC8
 .;
 .I IVMXREF["ZGD",(IVMSTART["ZGD") D ZGD^IVMPREC8
 .I IVMXREF["ZCT",(IVMSTART["ZCT") D ZCT^IVMPREC8
 .I IVMXREF["ZEM",(IVMSTART["ZEM") D ZEM^IVMPREC8
 .I IVMXREF["RF1",(IVMSTART["RF1") D RF1^IVMPREC8
 Q
 ;
 ;
DEMBULL ; -  build mail message for transmission to IVM mail group notifying
 ;    them that patients with updated demographic data has been received
 ;    from the IVM Center and may now be uploaded into DHCP.
 ;
 ; If record is auto uploaded, don't add veteran to bulletin
 I $$CKAUTO Q
 ;
 S IVMPTID=$$PT^IVMUFNC4(DFN)
 S XMSUB="IVM - DEMOGRAPHIC UPLOAD for "_$P($P(IVMPTID,"^"),",")_" ("_$P(IVMPTID,"^",3)_")"
 S IVMTEXT(1)="Updated demographic information has been received from the"
 S IVMTEXT(2)="Health Eligibilty Center.  Please select the 'Demographic Upload'"
 S IVMTEXT(3)="option from the IVM Upload Menu in order to take action on this"
 S IVMTEXT(4)="demographic information.  If you have any questions concerning the"
 S IVMTEXT(5)="information received, please contact the Health Eligibility Center."
 S IVMTEXT(7)=""
 S IVMTEXT(8)="The Health Eligibilty Center has identified the following"
 S IVMTEXT(9)="patients as having updated demographic information:"
 S IVMTEXT(10)=""
 S IVMCNTR=IVMCNTR+1
 S IVMTEXT(IVMCNTR+10)=$J(IVMCNTR_")",5)_"  "_$P(IVMPTID,"^")_" ("_$P(IVMPTID,"^",3)_")"
 Q
 ;
INACTIVE(IVMDEMDA) ;Check if field is inactive in Demographic Upload
 ; Input  -- IVMDEMDA IVM Demographic Upload Fields IEN
 ; Output -- 1=Yes and 0=No
 Q +$P($G(^IVM(301.92,IVMDEMDA,0)),U,9)
 ;
RF1CHK(IVMRTN,IVMDA) ;does an RF1 segment exist in this message?
 N RF1
 S RF1=$O(^TMP($J,IVMRTN,IVMDA))
 I $E($G(^(+RF1,0)),1,3)'="RF1" Q 0
 Q 1
 ;
CKAUTO() ;
 ; Chect if message qualifies for an auto upload.
 N AUTO,IVMI,DOD
 S AUTO=0,IVMI=$O(^IVM(301.92,"C","ZPD09",""))
 I IVMI=IVMDEMDA  D
 .I +IVMFLD'>0 S AUTO=1 Q
 .S DOD=$P($G(^DPT(DFN,.35)),U)
 .I DOD=IVMFLD S AUTO=1 Q
 ;
 Q AUTO
BLDPID(PIDTMP,IVMPID) ;Build IVMPID subscripted by sequence number
 N STR,X1,X2,N,TEXT,C,L
 S STR="",X1=1,(N,X2)=0
 F  S N=$O(PIDTMP(N)) Q:N=""  S TEXT=PIDTMP(N) F L=1:1:$L(TEXT) S C=$E(TEXT,L) D
 . I C="^" D  Q
 . . I X2 S X2=X2+1,IVMPID(X1,X2)=STR
 . . E  S IVMPID(X1)=STR
 . . S STR="",X1=X1+1,X2=0
 . I C="|" D  Q
 . . S X2=X2+1,IVMPID(X1,X2)=STR,STR=""
 . S STR=STR_C
 I $G(C)'="",$G(C)'="^",$G(C)'="|" D
 . I X2 S X2=X2+1,IVMPID(X1,X2)=STR Q
 . S IVMPID(X1)=STR
 Q
ADDRCHNG(DFN) ;Store Address Change Date/time, Source and site if necessary
 ;Store Residence Number Change Date/Time, Source and Site (IVM*2*152)
 N IVMVALUE,IVMFIELD
 I '$D(^TMP($J,"CHANGE UPDATE")) Q
 S IVMFIELD=0 F  S IVMFIELD=$O(^TMP($J,"CHANGE UPDATE",IVMFIELD)) Q:IVMFIELD=""  D
 . S IVMVALUE=$G(^TMP($J,"CHANGE UPDATE",IVMFIELD))
 . S DIE="^DPT(",DA=DFN,DR=IVMFIELD_"////^S X=IVMVALUE"
 . D ^DIE K DA,DIE,DR
 .; - delete inaccurate Addr Change Site data if Source is not VAMC
 . I IVMFIELD=.119,IVMVALUE'="VAMC" S FDA(2,+DFN_",",.12)="@" D UPDATE^DIE("E","FDA")
 .; - delete inaccurate Residence Number Change Site data if Source
 .;   is not VAMC (IVM*2*152)
 . I IVMFIELD=.1322,IVMVALUE'="VAMC" S FDA(2,+DFN_",",.1323)="@" D UPDATE^DIE("E","FDA")
 K ^TMP($J,"CHANGE UPDATE")
 Q
EPCFLDS(EPCFARY,EPCDEL) ;
 ;EPCFARY - Contains IENs of Pager, email, Cell phone and Home phone records in 301.92 File - Passed by reference
 ;EPCDEL - Contains field # of Pager, Email, Cell phone and Home phone fields in Patient(#2) file. - Passed by reference
 I (DODSEG)!(GUARSEG) Q
 S EPCFARY("PNO")=$O(^IVM(301.92,"B","PAGER NUMBER",0))_"^"_$O(^IVM(301.92,"B","PAGER CHANGE DT/TM",0))_"^"_$O(^IVM(301.92,"B","PAGER CHANGE SITE",0))_"^"_$O(^IVM(301.92,"B","PAGER CHANGE SOURCE",0))
 S EPCFARY("CPH")=$O(^IVM(301.92,"B","CELLULAR NUMBER",0))_"^"_$O(^IVM(301.92,"B","CELL PHONE CHANGE DT/TM",0))_"^"_$O(^IVM(301.92,"B","CELL PHONE CHANGE SITE",0))_"^"_$O(^IVM(301.92,"B","CELL PHONE CHANGE SOURCE",0))
 S EPCFARY("EAD")=$O(^IVM(301.92,"B","EMAIL ADDRESS",0))_"^"_$O(^IVM(301.92,"B","EMAIL CHANGE DT/TM",0))_"^"_$O(^IVM(301.92,"B","EMAIL CHANGE SITE",0))_"^"_$O(^IVM(301.92,"B","EMAIL CHANGE SOURCE",0))
 ; IVM*2.0*167 - Make Home phone records auto-upload to Patient File
 S EPCFARY("PHH")=$O(^IVM(301.92,"B","PHONE NUMBER [RESIDENCE]",0))_"^"_$O(^IVM(301.92,"B","RESIDENCE NUMBER CHANGE DT/TM",0))_"^"_$O(^IVM(301.92,"B","RESIDENCE NUMBER CHANGE SITE",0))_"^"_$O(^IVM(301.92,"B","RESIDENCE NUMBER CHANGE SOURCE",0))
 S EPCDEL("PNO")=".135^.1312^.1313^.1314"
 S EPCDEL("CPH")=".134^.139^.1311^.13111"
 S EPCDEL("EAD")=".133^.136^.137^.138"
 ; IVM*2.0*167 - Make Home phone records auto-upload to Patient File
 ; IVM*2.0*171 - Comment out line to fix the home phone deletion issue
 ;S EPCDEL("PHH")=".131^.1321^.1322^.1323"
 Q
 ;
AUPBLD(AUPFARY,UPDAUPG) ; Set up array containing fields for auto upload.
 ;AUPFARY - Contains fields in 301.92 File-Passed by reference
 ;UPDAUPG - Contains all groups initialized to '0'
 N AUPSTR,AUPGRP,AUPFLST,AUPPCE,AUPSGSQ,AUPDA
 F I=3:1 S AUPSTR=$P($T(AUPLST+I),";;",2,3) Q:$P(AUPSTR,";")="QUIT"  D
 .S AUPGRP=$P(AUPSTR,";"),AUPFLST=$P(AUPSTR,";",2)
 .F AUPPCE=1:1:$L(AUPFLST,"^") D
 ..S AUPSGSQ=$P(AUPFLST,"^",AUPPCE) Q:AUPSGSQ=""
 ..S AUPDA=$O(^IVM(301.92,"C",AUPSGSQ,0)) Q:AUPDA=""
 ..S AUPFARY(AUPDA)=AUPGRP
 ..S:AUPGRP'="" UPDAUPG(AUPGRP)=0  ; Default group update flags to '0'
 Q
 ;
 ; IVM*2.0*164 - ZAV01,ZAV02 AND ZAV04 are added for Auto Upload.  
 ; Residential Address (RA) group is added
 ; Confidential Address (CA) group is uncommented
AUPLST ; P1;P2
 ; P1 = Group Name (treat all entries as this group if present)
 ; P2 = .01 field(s) from 301.92 seperated by '^'
 ;;D1;ZCT03D1^ZCT04D1^ZCT051D1^ZCT052D1^ZCT053D1^ZCT054D1^ZCT055D1^ZCT06D1^ZCT07D1^ZCT10D1
 ;;E1;ZCT03E1^ZCT04E1^ZCT051E1^ZCT052E1^ZCT053E1^ZCT054E1^ZCT055E1^ZCT06E1^ZCT07E1^ZCT10E1
 ;;E2;ZCT03E2^ZCT04E2^ZCT051E2^ZCT052E2^ZCT053E2^ZCT054E2^ZCT055E2^ZCT06E2^ZCT07E2^ZCT10E2
 ;;K1;ZCT03K1^ZCT04K1^ZCT051K1^ZCT052K1^ZCT053K1^ZCT054K1^ZCT055K1^ZCT06K1^ZCT07K1^ZCT10K1
 ;;K2;ZCT03K2^ZCT04K2^ZCT051K2^ZCT052K2^ZCT053K2^ZCT054K2^ZCT055K2^ZCT06K2^ZCT07K2^ZCT10K2
 ;;TA;ZTA02^ZTA03^ZTA04^ZTA051^ZTA052^ZTA053^ZTA054^ZTA055^ZTA056^ZTA058^ZTA059^ZTA07^ZTA08^ZTA09^ZTA054F^ZTA055F^ZAV04
 ;;CA;PID111C^PID112C^PID113C^PID114C^PID114CF^PID115C^PID115CF^PID116C^PID117C^PID118C^PID119C^PID1110C^PID1112C^PID1113C^PID13CA^RF161CA^RF171CA^ZAV02
 ;;RA;PID111R^PID112R^PID113R^PID114R^PID114RF^PID115R^PID115RF^PID116R^PID117R^PID118R^PID119R^PID1110R^PID1112R^PID1113R^PID13RA^RF161RA^RF162RA^RF171RA^ZAV01
 ;;;ZEM03^ZEM04^ZEM05^ZEM061^ZEM062^ZEM063^ZEM064^ZEM065^ZEM068^ZEM07^ZEM09
 ;;;ZEM03S^ZEM04S^ZEM05S^ZEM061S^ZEM062S^ZEM063S^ZEM064S^ZEM065S^ZEM068S^ZEM07S^ZEM09S
 ;;;PID06^PID10^PID16^PID17^PID22^ZPD30^ZPD06^ZPD07
 ;;QUIT
 ;;
 ;;The following have been disabled until further notice
 ;;;PID113N^PID114N^PID24^PID13W
 ;;CA;PID111C^PID112C^PID113C^PID114C^PID114CF^PID115C^PID115CF^PID116C^PID117C^PID118C^PID119C^PID1112C1^PID1112C2^PID13CA^RF161CA^RF171CA
