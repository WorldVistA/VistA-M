PSOTPHL1 ;BPFO/EL-CREATE HL7 BATCH MESSAGE FILE ;09/10/03
 ;;7.0;OUTPATIENT PHARMACY;**146,153,227**;DEC 1997
 ;
 ; Summary:
 ; Use of ^VAFCQRY API is approved under private IA #3630
 ; For initial run, makes sure the "Transmission End Date" (#46.2) in 
 ;    File 59.7 - Pharmacy System File is null.
 ; If field (#46.2) is null, the system will pick up all DFN in File 52.91 
 ;    from the first date of file creation to the "RunDate"-1.
 ; If field (#46.2) has a date, the system will pick up DFN starting 
 ;    from the last "Transmission End Date"+1 to the "RunDate"-1.
 ; This program only runs on Sunday.  RunTime will be 6pm.
 ; Tab: EN^PSOTPHL1(RDT,EDT,.SDT) is the ad-hoc entry point if user 
 ;    wants to run it at certain "Transmission Begin Date", 
 ;    "Transmission End Date", & return actual "Transmission Begin Date".       
 ; If run is success, an audit node will be placed at File 59.7 as:
 ;    ^PS(59.7,D0,46)=TransmissionStartDt_"^"_TransmissionEndDt_"^"_MshID_"^"_MshCnt_"^"_LineCnt
 ;
 ; At the end of each run, this program will send out mail to the mail
 ;   group "PSO TPB HL7 EXTRACT" except the non-Sunday TaskMan check
 ;
 Q  ; placed out of order by PSO*7*227
 N A,B,C,CK,EDT,ERR,FRTIME,I,L,R,RDT,SDT,SET,X
 N BCNT,DATA,DFN,EVENT,LN,MCNT,PGM,PS,PSO
 N BBDT,BEDT,DADT,EXC,INS,PADT,PN,REASON,STA,WAITYP
 ;
START S CK=0 D DATE I CK=1 G ENDS
 ;  
 D EN^PSOTPHL1(RDT,EDT,.SDT)
 Q
 ;
DATE ; Check if first time run or Sunday
 S (EDT,FRTIME,PS,SET)=0,PS=59.7
 S EDT=$$GET1^DIQ(PS,"1,46",46.2,"I"),EDT=+EDT
 D NOW^%DTC
 D DW^%DTC
 I EDT'>0 S FRTIME=1 G GDATE
 I X'["SUN" S CK=1 Q
 ;
 S SDT=EDT+1
GDATE S RDT="",SET=1
 S RDT=$S(EDT:EDT,1:0)
 S EDT=DT-1
 Q
 ;
INIT ; Variable Initialization
 S (BCNT,LN,MCNT,CK)=0
 S PGM="PSOTPHL1"
 S PSO=52.91
 D INHL7
 ;
 K ^TMP("HLS",$J),^TMP(PGM,$J,EDT)
 ;
 Q
 ;
INHL7 S EVENT="PSO TPB EV"
 I '$D(U) S U="^"
 D INIT^HLFNC2(EVENT,.HL)
 I $G(HL) S ERR=$P(HL,"^",2),CK=1 Q
 D CREATE^HLTF(.HLMID,.HLDA,.HLDT,.HLDT1)
 D INHD
 Q
 ;
INHD I '$D(DTIME) S DTIME=0
 I '$D(HL("DTM")) S HL("DTM")=HLDT1
 I '$D(HL("FS")) S HL("FS")="^"
 I '$D(HL("ECH")) S HL("ECH")="~|\&"
 I '$D(HL("ETN")) S HL("ETN")="S12"
 I '$D(HL("MTN")) S HL("MTN")="SIU"
 I '$D(HL("MTN_ETN")) S HL("MTN_ETN")="SIU_S12"
 I '$D(HL("PID")) S HL("PID")="P"
 I '$D(HL("Q")) S HL("Q")=""""
 I '$D(HL("VER")) S HL("VER")="2.4"
 I '$D(HL("CC")) S HL("CC")="US"
 I '$D(HL("ACAT")) S HL("ACAT")="AL"
 I '$D(HL("APAT")) S HL("APAT")="NE"
 I '$D(HL("SAN")) S HL("SAN")="PSO TPB-PHARM"
 I '$D(HL("RAN")) S HL("RAN")="PSO TPB-ACC"
 ;
 Q
 ;
BHS ; CREATE "BHS" SEGMENT
 S BCNT=BCNT+1
 S LN=LN+1
 ;
 Q
 ;
EN(RDT,EDT,SDT) ; ENTRY POINT FOR PROCESS
 D INIT I CK=1 G OUT
 D BHS
 D PROCESS
 D BTS
 G OUT
 ;
PROCESS ; Sort and Process the message body
 I '$D(SET) S SDT=RDT,RDT=RDT-1
 I $G(FRTIME)=1 D FRTIME
P10 S RDT=$O(^PS(PSO,"AX",RDT)) G P30:(RDT>EDT)!(RDT="")
 I SDT>RDT S SDT=RDT
 S DFN=""
P20 S DFN=$O(^PS(PSO,"AX",RDT,DFN)) G P10:DFN=""
 I '$D(^PS(PSO,DFN,0)) K ^PS(PSO,"AX",RDT,DFN) G P20
 S ^TMP(PGM,$J,EDT,"ZZ",DFN)=RDT
 G P20
 ;
FRTIME ; To generate a complete data set for the frist time 
 S (DFN,RDT,X)=""
 S SDT=999999999
F10 S DFN=$O(^PS(PSO,DFN)) Q:(DFN'?1N.N)!(DFN="")
 I '$D(^PS(PSO,DFN,0)) G F10
 S X=$P(^PS(PSO,DFN,0),"^",2)
 I SDT>X S SDT=X
 S ^TMP(PGM,$J,EDT,"ZZ",DFN)=X
 G F10
 ;
P30 I '$D(^TMP(PGM,$J,EDT,"ZZ")) D  G GEN
 .  S MCNT=0
 .  D MSH^HLFNC2(.HL,HLMID_"-"_MCNT,.X,"")
 .  D WRITE
 ;
 S DFN=""
DFN S DFN=$O(^TMP(PGM,$J,EDT,"ZZ",DFN)) G GEN:DFN=""
 S RDT=^TMP(PGM,$J,EDT,"ZZ",DFN)
 D EXTRACT
 D MSH
 D SCH
 D PID
 G DFN
 ;
GEN S HLP="" D GENERATE^HLMA(EVENT,"GB",1,.R,HLDA,.HLP)
 Q
 ;
EXTRACT ; Extract data from File 52.91
 S (A,B,BBDT,BEDT,C,DADT,DATA,EXC,INS,PADT,PN,REASON,STA,WAITYP,X)=""
 S X=^PS(PSO,DFN,0)
 S DATA="PN,BBDT,BEDT,REASON,DADT,WAITYP,STA,INS,EXC,PADT"
 F I=1:1:10 S @$P(DATA,",",I)=$P(X,"^",I)
 I $D(PADT) S PADT=$P(PADT,".")
 I +BBDT=+RDT S HL("ETN")="S12"
 E  S HL("ETN")="S14"
 S HL("MTN_ETN")=HL("MTN")_"_"_HL("ETN")
 S A="BBDT,BEDT,DADT,PADT"
 F I=1:1:4 S B=$P(A,",",I) I $G(@B)>0 S C=$$HLDATE^HLFNC(@B,"DT"),@$P(A,",",I)=C
 Q
 ;
MSH ; CREATE "MSH" SEGMENT
 S MCNT=MCNT+1
 D MSH^HLFNC2(.HL,HLMID_"-"_MCNT,.X,"")
 ;
 D WRITE
 Q
 ;
SCH ; CREATE "SCH" SEGMENT
 K SCH S (X,A,B,C)="",I=0 S:REASON>9 REASON=9
 S X="Seen by VA Provider,No/Show/Cancellation,Patient Ended"
 S X=X_",Non-Formulary Rx not accepted,Patient Expired,All Rx's Inactive"
 S X=X_",Exclusion,Patient Refused Appointment,Patient Unreachable"
 S A=$P(X,",",REASON)
 ;
 S X="" S:EXC>3 EXC=3
 S X="Excluded due to active Rx#"
 S X=X_",Excluded due to actual appt<30 days from desired appt date"
 S X=X_",Exclued due to active Rx# and actual appt<30 days from desired appt date"
 S B=$P(X,",",EXC)
 ;
 I WAITYP="E" S C="EWL"
 E  I WAITYP="M" S C="Manual"
 E  I WAITYP="S" S C="Schedule"
 E  S C="S\T\E"
 ;
 S X=""
 S X=HL("FS")_HL("FS")_HL("FS")_HL("FS")_HL("FS")_HL("FS")_REASON_"~"_A
 S X=X_HL("FS")_EXC_"~"_B_HL("FS")_WAITYP_"~"_C
 S X=X_HL("FS")_HL("FS")_HL("FS")
 S I=I+1,SCH(I)="SCH"_X
 ;
 S X="",X=X_"~~~"_DADT_"~~~~Desired Appointment Date|~~~"
 S X=X_PADT_"~~~~Primary Care Scheduled Appointment Date|~~~"
 S X=X_BBDT_"~~~~Date Pharmacy Benefit Began|~~~"
 S X=X_BEDT_"~~~~Inactivation of Benefit Date|~~~"
 S X=X_$$HLDATE^HLFNC(RDT,"DT")_"~~~~Record Change Date"
 I $L(SCH(I)_X)<246 S SCH(I)=SCH(I)_X
 E  S I=I+1,SCH(I)=X
 ;
 S X="",$P(X,"^",12)=STA_"~~~"_INS_"&"_$$GET1^DIQ(4,INS_",0",.01)
 I $L(SCH(I)_X)<246 S SCH(I)=SCH(I)_X
 E  S I=I+1,SCH(I)=X
 ;
 F I=1:1 S X=$G(SCH(I)) Q:X=""  D
 . I I=1 D WRITE
 . E  D WRITEN
 Q
 ;
PID ; CREATE "PID" SEGMENT
 K PID
 D DEM^VADPT,ADD^VADPT
 D BLDPID^PSOTPHL2(DFN,1,.PID,.HL,.ERR)
 Q:$G(PID(1))=""
 S X=""
 F I=1:1 S X=$G(PID(I)) Q:X=""  D
 . I I=1 D WRITE
 . E  D WRITEN
 Q
 ;
BTS ; CREATE "BTS" SEGMENT
 S LN=LN+1
 Q
 ;
WRITE ; Write single line
 S LN=LN+1
 S ^TMP("HLS",$J,LN)=X
 Q
 ;
WRITEN ; Write multiple lines
 S ^TMP("HLS",$J,LN,I-1)=X
 Q
 ;
CLEANUP ; Clean up variables
 K A,B,C,CK,EDT,ERR,I,L,R,RDT,SDT,X
 K BCNT,DATA,DFN,EVENT,LN,MCNT,PGM,PS,PSO
 K BBDT,BEDT,DADT,EXC,INS,PADT,PN,REASON,STA,WAITYP
 Q
 ;
OUT ; End of compilation
 I CK=1 G END
 K ^TMP("HLS",$J),^TMP(PGM,$J,EDT),PID,SCH
 I SDT>EDT S SDT=EDT
 I $G(SET)=1 S ^PS(PS,1,46)=SDT_"^"_EDT_"^"_HLDA_"^"_MCNT_"^"_LN
 ;
END D MAIL
 I $G(SET)'=1 D CLEANUP
ENDS I $G(FRTIME)=1 D RESET
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
RESET ; Reset to run tomorrow
 D RESCH^XUTMOPT("PSO TPB HL7 EXTRACT","T+1@18:00","","24H","L")
 Q
 ;
RESET1 ; Reset to run tomorrow
 D RESET,EDIT^XUTMOPT("PSO TPB HL7 EXTRACT")
 Q
 ;
MAIL ;Send mail message
 I '$G(DUZ) Q
 K PSOTTEXT,XMY S (XMDUZ,XMSUB,XMTEST,A,B,C,I,L,R,X)=""
 S C="G.PSO TPB HL7 EXTRACT"
 S XMY(C)=""
 S PSOTTEXT(1)="SENT TO: "_C
 S XMDUZ="PSO TPB HL7 EXTRACT"
 S (A,B)=""
 I '$D(SET) S A="Ad-Hoc"
 E  S A=$S(($G(FRTIME)=1):"first-time",1:"weekly")
 S B=$S(($G(CK)=1):"unsuccessful",1:"successful")
 S XMSUB="PSO TPB HL7 "_A_" update ** "_B_" **"
 S A=XMSUB
 I $G(CK)=1 D FAIL
 E  D SUCC
 S PSOTTEXT(2)=" "
 S PSOTTEXT(3)="The weekly generation of the HL7 Message of"
 S PSOTTEXT(3.2)="TPB Patient Information was "_B
 S PSOTTEXT(4)=""
 S PSOTTEXT(5)=I
 S PSOTTEXT(6)=L
 S PSOTTEXT(6.2)=R
 S PSOTTEXT(6.4)=X
 S PSOTTEXT(7)=" "
 D NOW^%DTC S Y=% X ^DD("DD") S PSOTTEXT(8)="The job ended at "_$G(Y)
 S PSOTTEXT(9)=" "
 S XMTEXT="PSOTTEXT(" N DIFROM D ^XMD
 I $D(XMMG),(XMMG["Error =") D
 .  K XMY(C)
 .  S XMSUB=A,XMY(DUZ)="",PSOTTEXT(1)=PSOTTEXT(1)_"   ("_XMMG_")",XMMG=""
 .  S XMTEXT="PSOTTEXT(" D ^XMD
 K PSOTTEXT,XMDUZ,XMSUB,XMTEXT,XMY
 Q
FAIL ; Msg for unsuccessful run
 S I="Reason: "_$S(($D(ERR)):ERR,1:"Check Event Server Protocol OR the run date")
 S L=" "
 S R="Please contact National Help Desk @888-596-4357"
 S X=" "
 Q
 ;
SUCC ; Msg for successful run
 S I="Please check the PSOTPBAAC HL7 Logical Link to ensure"
 S L="successful transmission to the Austin Automation Center."
 S R=" "
 S X="MSH-ID: "_HLDA
 Q
 ;
