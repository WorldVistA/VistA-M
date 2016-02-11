EASPREC6 ;ALB/BD,MNH,LMD - ROUTINE TO PROCESS INCOMING (Z06 EVENT TYPE) HL7 MESSAGES ;6/16/04 9:28am
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**111,113**;21-OCT-94;Build 53
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;** Warning ** currently only one ZMT seg per Z06 can be processed.
 ;
 ;EAS*1*113 Send Bulletin if BTFI is different than what is on file
 ; - added DGMTYPT and passed down thru all calls that need.
 ; o DGMTYPT = 1 (Means Test, MT)
 ; o DGMTYPT = 2 (RX Copay Test, CT)
 ;
 ; This routine will process (validate) batch ORU Means Test(event type
 ; Z06) HL7 messages received from the IVM center. Format of batch:
 ; BHS
 ; {MSH
 ; PID
 ; ZIC
 ; ZIR
 ; {ZDP
 ; ZIC
 ; ZIR
 ; }
 ; ZMT
 ; ZIV
 ; }
 ; BTS
 ;
EN ; entry point to validate Means Test messages 
 ;
 N DEPFLG,EDB,CANCFLG,CASEFLG,SEGSTR,SEGMENTS,MISSING,ERRFLG,Z06COM
 N IVM2,IVM3,IVM7,IVM8,IVM10,IVM12,IVM17,IVM18,IVM20,IVM25,IVM26,IVM32,IVMIY   ;Add BT indicator EAS*1*113
 N IVMDA,IVMPAT,IVMMTSTS,MTFND,UPMTS,MTDATE,TYPE,EASMTDT,EASZ06,EXPIRED
 N IVM5,EASZ06D,DGMTYPT
 S SEGSTR="00000000000"      ;One byte for each segment in message
 S SEGMENTS="BHS,MSH,PID,PID,ZIC,ZIR,ZDP,ZIC,ZIR,ZMT,ZIV,BTS"
 S Z06COM="Z06 MT via Edb"
 S (CASEFLG,DEPFLG,ERRFLG,HLERR,IVMDA,IVMFLGC,MTFND,UPMTS)=0
EN1 F  S IVMDA=$O(^TMP($J,IVMRTN,IVMDA)) Q:'IVMDA  D  I $D(HLERR) D ACK^IVMPREC S ERRFLG=1 Q 
 .K HLERR
 .D GET
 .D @IVMSEG1                            ;process each segment type
 Q:ERRFLG                               ;Error detected do not continue
 S MISSING=$F(SEGSTR,0) ;Ensure all required segments
 I MISSING D  I $D(HLERR) D ACK^IVMPREC,CLEANUP Q
 . S TYPE=$S(MISSING=3!(MISSING=4):"Veteran's",MISSING>4&(MISSING<8):"Spouse's",1:"")
 . S HLERR="Missing "_TYPE_" "_$P(SEGMENTS,",",(MISSING-1))_" Segment"
 D PROCESS
 I $D(HLERR) D ACK^IVMPREC
 ; cleanup
CLEANUP K DGLY,DGMTP,IVMDAP,IVMDAS,IVMDAZ,IVMDGLY,CANCFLG,IVMFLGC,IVMMT31
 K IVMMTDT,IVMMTIEN,IVMSEG,IVMSEG1,IVMSTAT,IVMTEXT,XMSUB,HLERR,CLOSFLG
 K IVMZ10,IVMDAV,ZIVSEG,ZMTSEG
 Q
 ;
 ;Dependent upon type of Z06 sent perform the following;
 ;IVM Case Status:
 ; Value of 1 = Create/Update Z06 MT/CT, Close Case & Mark REASON CODE
 ; as 'Converted'
 ; Value of 0 = Cancel Z06 MT/CT and Mark REASON CODE as 'Not Convert'
 ;
 ; If Z06 MT/CT and IVM Case Status is 1 and Z06 MT/CT doesn't exist then
 ; Create new Z06 MT/CT (new Z06 MT/CT becomes primary and existing
 ; MT/CT becomes non-primary)
 ; Assign REASON CODE of 'Converted' in #301.5
 ; If Z06 MT/CT already exists then
 ; If IVM Case Status is 0 Then
 ; Delete Z06 MT/CT for income year and return old MT/CT to primary
 ; Change REASON CODE from 'Converted' to 'Not Converted' in #301.5
 ; If IVM Case Status is 1 Then
 ; Update MT/CT Z06 and Close/Convert Case
 ; Else (Z06 MT/CT, IVM Case Status=0 and Z06 MT/CT does not exist)
 ; Send back 'AE' to Edb indicating MT/CT Z06 not available for 
 ; cancellation
 ;
PROCESS N DIC,%,%H,%I,IVMDATE
 D NOW^%DTC
 S IVMDATE=%
 I '$D(ZMTSEG) S HLERR="ZMT Segment is Missing" Q
 S EASZ06=1,EXPIRED=0
 S:DGMTYPT=2 IVMCEB=$P($$RXST^IBARXEU(DFN),"^",2) ;prev RX sts
 I $G(IVMMTIEN)="" D  ; Find any primary for the same year/test type
 . S CURMT=$$LST^DGMTU(DFN,IVMMTDT,DGMTYPT)
 . I $E($P(CURMT,U,2),1,3)'=$E(IVMMTDT,1,3) Q  ;TMK
 . S IVMMTIEN=$P(CURMT,"^",1)
 . S IVMMTDT=$P(CURMT,"^",2)
 . S IVMMTSTS=$P(CURMT,"^",3)
 I $G(IVMMTIEN)]"" D                   ;dgmtp is event driver variable
 . S (IVMMT31,DGMTP)=$G(^DGMT(408.31,IVMMTIEN,0))
 ;
 ; EAS*1*113
 ; Send BT Bulletin if BTFI is different than what is on file
 ;
 ; Input:
 ; DFN = IEN of Patient
 N DT,DGCAT,FININD
 ; DFN = IEN of Patient
 ; DT = Today's Date
 S DT=IVMDATE
 ; DGCAT = Current Means Test Status
 S DGCAT=$P($G(^DG(408.32,IVM3,0)),"^",1)
 ; IVMCEB = Previous Means Test Status
 ; IVM10 = Date/Time Test Completed
 S FININD="" I $D(IVMMTIEN) S FININD=$G(^DGMT(408.31,IVMMTIEN,4)) ;financial indicator EAS*1*113
 ;
 I IVM32'=FININD D SET^EASBTBUL(DFN,DT,DGCAT,$G(IVMCEB),$G(IVM10))
 ;
 ;
 ; No previous 408.31 test on file
 I 'MTFND D  Q
 . I CASEFLG D                                ;Case=1 Close/Converted
 . . ;change old MT/CT to non-primary
 . . I $G(IVMMTIEN)>0 D
 . . . S DA=IVMMTIEN,DIE="^DGMT(408.31,",DR="2////0;"
 . . . D ^DIE K DA,DIE,DR
 . . ;
 . . S IVMMTDT=EASMTDT
 . . D ^EASUM6 ;Copied from EASUM1 Create New Z06 MT/CT
 . . I $G(IVMMTDT)="" S IVMMTDT=EASMTDT
 . . I $$EXPIRED^EASPTRN1(DFN,$G(IVMMTDT)) D
 . . . S EXPIRED=1,IVMZ10="UPLOAD IN PROGRESS"
 . . D CLOSE(IVMIY,DFN,1,6) ;Close Case/Converted
 . ;
 . I 'CASEFLG D  Q
 . . S:DGMTYPT=1 HLERR="Existing Z06 MT not found"
 . . S:DGMTYPT=2 HLERR="Existing Z06 CT not found"
 ;
 ; Previous 408.31 test on file
 I MTFND D
 . I 'CASEFLG D                             ;Case=0 Close/Not Convert
 . . ; Check to see if MT/CT Z06 exists prior to trying to delete
 . . ; If NOT defined then send an AE back to Edb
 . . I 'UPMTS D  Q                          ;Existing Z06 not found
 . . . S:DGMTYPT=1 HLERR="Existing Z06 MT not found"
 . . . S:DGMTYPT=2 HLERR="Existing Z06 CT not found"
 . . I UPMTS D  Q
 . . . N CURMT,IVMMTI,IVMDFN,DGCAT
 . . . S IVMDFN=DFN                         ;Save off DFN
 . . . I $$EXPIRED^EASPTRN1(DFN,$G(IVMMTDT)) D
 . . . . S EXPIRED=1,IVMZ10="UPLOAD IN PROGRESS"
 . . . S DGCAT=$P($G(^DG(408.32,IVM3,0)),"^",1),IVM5=""
 . . . S EASZ06D=1 ;Set del flag for IB event
 . . . D ^EASUM9 ;Delete Z06 MT/CT
 . . . S DFN=IVMDFN
 . . . I $G(IVMMTDT)="" S IVMMTDT=EASMTDT
 . . . D CLOSE(IVMIY,DFN,1,7) ;Close Case/Not Converted
 . ;
 . I CASEFLG D                              ;Case=1 Close/Converted
 . . Q:$G(IVMMTIEN)<1
 . . S DA=IVMMTIEN,DIE="^DGMT(408.31,"
 . . S DR=".03////^S X=IVM3;.12////^S X=IVM8;.07////^S X=IVM10;"
 . . S DR=DR_".09////^S X=IVM25;.11////^S X=IVM7;.18////^S X=IVM12;"
 . . S DR=DR_".23////^S X=IVM18;.25////^S X=IVM20;"
 . . S DR=DR_"2.02////^S X=IVMDATE;2.03////^S X=IVM26;"
 . . S DR=DR_"4////^S X=IVM32;" ;BT Financial Indicator EAS*1*113
 . . D ^DIE K DA,DIE,DR                     ;Update existing Z06
 . . I $G(IVMMTDT)="" S IVMMTDT=EASMTDT
 . . I $$EXPIRED^EASPTRN1(DFN,$G(IVMMTDT)) D
 . . . S EXPIRED=1,IVMZ10="UPLOAD IN PROGRESS"
 . . D CLOSE(IVMIY,DFN,1,6) ;Close Case/Converted
 . . S DGCAT=$P($G(^DG(408.32,IVM3,0)),"^",1),IVM5=""
 . . D MTBULL^EASUM9,MAIL^IVMUFNC() ;Send Bulletin
 Q
 ;
MSH S (HLMID,MSGID)=$P(IVMSEG,HLFS,10) ;Message control id from MSH
 Q
PID ;Handle wrapped PID segment
 N I,IVMPID,PIDSTR,COMP,CNTR,NOPID,TMPARY,PID3ARY,CNTR2
 S CNTR=1,NOPID=0,PIDSTR(CNTR)=$P(IVMSEG,"^",2,999)
 F  D  Q:NOPID
 .S IVMDA=$O(^TMP($J,IVMRTN,IVMDA)),IVMSEG=$G(^(+IVMDA,0))
 .I $E(IVMSEG,1,4)="ZIC^" S NOPID=1,IVMDA=IVMDA-1 Q
 .S CNTR=CNTR+1,PIDSTR(CNTR)=IVMSEG
 .S SEGSTR=$E(SEGSTR,1,IVMDA-1)_"1"_$E(SEGSTR,IVMDA,$L(SEGSTR)) ;Extend SEGSTR for wrapped PID
 D BLDPID^IVMPREC6(.PIDSTR,.IVMPID) ;Create IVMPID subscripted by seq #
 ;convert "" to null for PID segment
 S CNTR="" F  S CNTR=$O(IVMPID(CNTR)) Q:CNTR=""  D
 .I $O(IVMPID(CNTR,"")) D  Q
 ..S CNTR2="" F  S CNTR2=$O(IVMPID(CNTR,CNTR2)) Q:CNTR2=""  D
 ...S IVMPID(CNTR,CNTR2)=$$CLEARF^IVMPRECA(IVMPID(CNTR,CNTR2),$E(HLECH))
 .I IVMPID(CNTR)=HLQ S IVMPID(CNTR)=""
 M TMPARY(3)=IVMPID(3) D PARSPID3^IVMUFNC(.TMPARY,.PID3ARY)
 S DFN=$G(PID3ARY("PI")),ICN=$G(PID3ARY("NI"))
 K TMPARY,PID3ARY
 I '$$MATCH^IVMUFNC(DFN,ICN,"","","I",.ERRMSG) S HLERR=ERRMSG Q
 S IVMDAP=IVMDA ;Save IVMDA for veteran PID segment
 Q
ZIC I 'DEPFLG S IVMDGLY=$P(IVMSEG,"^",3) ;Income year
 Q
ZIR Q
ZDP S DEPFLG=1
 Q
 ;Get primary means test
 ; IVMMTDT - means test date
 ; DGLY - income year
 ; If Means Test not in DHCP, don't upload IVM Means Test 
 ;
ZMT N IVMIEN,MTCODE                                             ;EAS*1*42
 S IVMDAZ=IVMDA,ZMTSEG=IVMSEG            ;ZMT segment ivmda
 D PARSEZMT(ZMTSEG) ;Retrieve ZMT Values
 ;Means test date from ZMT segment
 S (EASMTDT,IVMMTDT)=$$FMDATE^HLFNC($P(IVMSEG,HLFS,3))
 S DGMTYPT=$G(IVM17) ;int type of test
 S:DGMTYPT="" DGMTYPT=1 ;insure type defined
 S DGLY=$$LYR^DGMTSCU1(IVMMTDT) ;Get means test to be updated
 S MTDATE=-IVMMTDT
 S IVMIEN=""
 S MTFND=0
 F  S IVMIEN=$O(^DGMT(408.31,"AID",DGMTYPT,DFN,MTDATE,IVMIEN)) Q:MTFND!(IVMIEN="")  D
 . S IVMMTIEN=IVMIEN
 . ; match to MT Z06 from Edb
 . S MTCODE=$P($G(^DGMT(408.31,IVMIEN,0)),"^",3)
 . I (MTCODE=6)!(MTCODE=16)!(MTCODE=8) D  ;Previous Converted MT/CT - EAS*1.0*111 
 . . S UPMTS=IVMIEN
 . . S MTFND=1
 I IVM7="" S (UPMTS,MTFND)=1  ;- EAS*1.0*111 need override for reversal.
 Q
ZIV S IVMDAV=IVMDA,ZIVSEG=IVMSEG
 S IVMIY=$P(IVMSEG,HLFS,3)
 S IVMIY=$$FMDATE^HLFNC(IVMIY)
 I $E(IVMIY,4,7)'="0000"!($E(IVMIY,1,3)<292) D  Q
 . S HLERR="Invalid Income Year"
 I "01"'[$P(IVMSEG,HLFS,9) D  Q
 . S HLERR="Case Status not 0 or 1"
 I $P(IVMSEG,HLFS,9)=1 S CASEFLG=1 ;Close/Convert Case Flag
 I $P(IVMSEG,HLFS,9)=0 S CASEFLG=0 ;Delete/Not Converted MT Flag
BHS Q
BTS Q
 ;
GET ; get HL7 segment from ^TMP
 ;S IVMDA=$O(^TMP($J,IVMRTN,+IVMDA))
 S IVMSEG=$G(^TMP($J,IVMRTN,+IVMDA,0))
 S IVMSEG1=$E(IVMSEG,1,3)
 S $E(SEGSTR,IVMDA)=1
 Q
 ;
 ;Parse ZMT Segment for MT Data
 ;
PARSEZMT(ZSEG) ;
 N CMPDATE
 S IVM2=$$FMDATE^HLFNC($P(ZSEG,"^",3)) ;Means Test Date
 S IVM3=$O(^DG(408.32,"C",$P(ZSEG,"^",4),"")) ;Means Test Status 
 ;S IVM7=$S($P(ZSEG,"^",8)="Y":1,$P(ZSEG,"^",8)=1:1,$P(ZSEG,"^",8)="":"",1:0) ;Agrees To Deductible
 S IVM7=$S($P(ZSEG,"^",8)]"Yy":1,$P(ZSEG,"^",8)=1:1,$P(ZSEG,"^",8)="":"",1:0) ;Agrees To Deductible
 S IVM8=$P(ZSEG,"^",9) ;Threshold A
 S CMPDATE=$P(ZSEG,"^",11) S:$E($G(CMPDATE),9,14)="000000" CMPDATE=$E(CMPDATE,1,8) S:+CMPDATE=0 CMPDATE="" S IVM10=$$FMDATE^HLFNC(CMPDATE) ;Date/Time Completed
 S IVM12=$P(ZSEG,"^",13) ;Number of Dependents
 S IVM17=$P(ZSEG,"^",18) ;Type of Test
 S IVM18=$P(ZSEG,"^",19) ;Source of Test
 S IVM20=$$FMDATE^HLFNC($P(ZSEG,"^",21)) ;IVM Verified MT
 S IVM25=$$FMDATE^HLFNC($P(ZSEG,"^",26)) ;D/T Last Changed
 S IVM26=$O(^DG(408.32,"C",$P(ZSEG,"^",27),"")) ;Test Determined Status
 S IVM32=$P(ZSEG,"^",32) ;EAS*1*113
 ;S IVM32=$S(IVM32="Y":1,IVM32="N":0,1:IVM32) ;BT Financial Indicator EAS*1*113
 S IVM32=$S(IVM32["""":"",1:IVM32) ;BT Financial Indicator
 Q
 ;
CLOSE(IVMIY,DFN,IVMCS,IVMCR) ; Close IVM case record for a patient
 ; Input: DFN -- Pointer to the patient in file #2
 ; IVMIY -- Income year of the closed case
 ; IVMCS -- Closure source [1=IVM | 2=DHCP]
 ; IVMCR -- Pointer to the closure reason in file #301.93
 ;
 N DA,DIE,DR,X,Y,EVENTS,STATUS,EAEVENT,IVEVENT
 I '$G(IVMIY)!'$G(DFN)!'$G(IVMCS)!'$G(IVMCR) G CLOSEQ
 S IVMDELMT=1 ; flag indicates deletion
 S DA=$O(^IVM(301.5,"APT",+DFN,+IVMIY,0))
 I $G(^IVM(301.5,+DA,0))']"" G CLOSEQ
 ;
 ;don't want closing a case to stop transmission of an enrollment event
 S STATUS=1
 I ($$STATUS^IVMPLOG(+DA,.EVENTS)=0),EVENTS("ENROLL")=1 S STATUS=0
 ;
 ; If previous years event make sure Enrollment Event does not get 
 ; updated, and the IVM Event does
 ;
 ;S EAEVENT=1,IVEVENT=2
 ;I $G(EXPIRED)=1 S EAEVENT=2,STATUS=0,IVEVENT=1
 ;I $G(EXPIRED)=0 S EAEVENT=1,STATUS=0
 D NOW^%DTC S DR=".03////"_STATUS_";.04////1;1.01////"_IVMCR_";1.02////"_IVMCS_";1.03////"_%_";30.01////2;30.02////2"
 S DIE="^IVM(301.5," D ^DIE
CLOSEQ Q
 ;
