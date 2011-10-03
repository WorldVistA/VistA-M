ECXUSUR1 ;ALB/TJL-Surgery Extract Unusual Volume Report ; 1/8/08 9:58am
 ;;3.0;DSS EXTRACTS;**49,71,105,111,128**;Dec 22, 1997;Build 19
EN ;
 N ECHEAD,COUNT,TIMEDIF,ECXPROC
 S ECHEAD="SUR"
 S (COUNT,QFLG)=0,ECED=ECED+.3,ECD=ECSD1
 F  S ECD=$O(^SRF("AC",ECD)) Q:('ECD)!(ECD>ECED)!(QFLG)  D
 .S ECD0=0
 .F  S ECD0=$O(^SRF("AC",ECD,ECD0)) Q:'ECD0  D
 ..I $D(^SRF(ECD0,0)) S ECXDFN=+$P(^(0),U,1) D STUFF Q:QFLG
 Q
 ;
STUFF ;gather data
 N J,DATA1,DATA2,DATAOP,ECXNONL,ECXSTOP
 S ECXDATE=ECD,ECXERR=0,ECXQ=""
 Q:'$$PATDEM^ECXUTL2(ECXDFN,ECXDATE,"1;2;3;5;")
 S EC0=^SRF(ECD0,0)
 S DATA1=$S($D(^SRF(ECD0,.1)):^(.1),1:"")
 S DATA2=$S($D(^SRF(ECD0,.2)):^(.2),1:"")
 S DATAOP=$S($D(^SRF(ECD0,"OP")):^("OP"),1:"")
 S DATAPA=$S($D(^SRF(ECD0,1.1)):^(1.1),1:"")
 S ECNO=$G(^SRF(ECD0,"NON"))
 ;get data
 S ECSS=$P($G(^SRO(137.45,+$P(EC0,U,4),0)),U,2)
 S ECSS=$$RJ^XLFSTR($P($G(^DIC(45.3,+ECSS,0)),U),3,0)
 S:ECSS="000" ECSS="999"
 ;look for non-OR
 S (ECNT,ECNL,ECXNONL,ECXSTOP)=""
 I $P(ECNO,U)="Y" D
 .S A1=$P(ECNO,U,5)
 .S A2=$P(ECNO,U,4)
 .S TIME="##"
 .D:(A1&A2) TIME S ECNT=TIME
 .S ECXNONL=+$P(ECNO,U,2)
 .S ECNL=$P($G(^ECX(728.44,ECXNONL,0)),U,9)
 .I ECNL="" S ECNL="UNKNOWN"
 .;
 .; Get DSS Stop Code to use in encounter number
 .S ECXSTOP=$P($G(^ECX(728.44,ECXNONL,0)),U,4)
 ;
 ;retrieving anesthesia times first, then operation and patient
 ;times, then storing in following order:
 ;ecode0="recovery room time^pt hold area time^or clean time^patient
 ;time^operation time^anesthesia time
 S ECODE0=""
 F J="1,4","2,3","10,12","13,14","15,10" D
 .S A2=$P(DATA2,U,$P(J,","))
 .S A1=$P(DATA2,U,$P(J,",",2))
 .S TIME="##"
 .I (A1&A2) D TIMEDIF(A1,A2) D
 ..I +J'=2 D TIME
 ..I +J=2 D  ;-Operation Time
 ...S TIME=$TR($J(TIMEDIF,4,0)," ")
 ...;I TIME<0 S TIME="###"
 .S ECODE0=TIME_U_ECODE0 K TIME
 ;
 ;retrieve recovery room (PACU) time
 S A2=$P($G(DATAPA),U,7)
 S A1=$P($G(DATAPA),U,8)
 S TIME="##"
 I (A1&A2) D TIME
 S ECODE0=TIME_U_ECODE0 K TIME
 ;Place the NON-OR PROCEDURE into the operation time for the report ECX*128
 I ECNL]"" S $P(ECODE0,U,5)=ECNT
 ;
 ;- Was surgery cancelled/aborted
 S ECCAN=$P($G(^SRF(ECD0,30)),U)
 I +ECCAN S ECCAN=$$CANC^ECXUTL4(ECNL,$P(DATA2,U,10))
 ;
 I ECXFLAG D FILE  Q
 N PIECE,FILE
 S FILE="NO"
 F PIECE=1,2,3,4,5,6 D
 . I $P(ECODE0,U,PIECE)>ECTHLD S FILE="YES"
 . I $P(ECODE0,U,PIECE)<0 S FILE="YES"
 ;
 I FILE="YES" D FILE Q:ECXERR
 Q
 ;
FILE ; Store unusual records for display later
 N OK,SURPAT,SURNAME,SURSSN,SURDT,VOL
 S OK=$$PAT^ECXUTL3(ECXDFN,$P(ECD,"."),"1;",.SURPAT)
 I 'OK Q
 S SURNAME=SURPAT("NAME")
 S SURSSN=SURPAT("SSN")
 S SURDT=$E(ECXDATE,4,5)_"/"_$E(ECXDATE,6,7)_"/"_$E(ECXDATE,2,3)
 ;
 ; Observation Patient Indicator (yes/no)
 S ECXOBS=$$OBSPAT^ECXUTL4(ECXA,ECXTS,ECNL)
 ;
 ; Principal Procedure
 S ECXPROC=$E($P(DATAOP,U),1,15)
 ;
 ; If no encounter number don't file record
 S ECXENC=$$ENCNUM^ECXUTL4(ECXA,ECXSSN,ECXADMDT,ECXDATE,ECXTS,ECXOBS,ECHEAD,ECXSTOP,ECSS) Q:ECXENC=""
 ;
 S VOL=$P(ECODE0,U)
 I $P(ECODE0,U,2)>VOL S VOL=$P(ECODE0,U,2)
 I $P(ECODE0,U,3)>VOL S VOL=$P(ECODE0,U,3)
 S ^TMP($J,-VOL,-ECD0)=SURNAME_U_SURSSN_U_SURDT_U_ECD0_U_ECXENC_U_ECODE0_U_ECXPROC_U_ECCAN
 S COUNT=COUNT+1
 I COUNT#100=0 I $$S^ZTLOAD S (ZSTOP,ECXERR)=1
 Q
 ;
TIME ; given date/time get increment
 N CON
 S CON=$P($G(^SRF(ECD0,"CON")),U)
 D TIMEDIF(A1,A2)
 I 'CON D
 .S TIME=$J($TR($J(TIMEDIF,4,0)," "),2,1)
 .S:TIME>"99.0" TIME="99.0"
 I CON D
 .S TIME=$J(($TR($J(TIMEDIF,4,0)," ")/2),2,1)
 .S:TIME>"99.5" TIME="99.5"
 ;S:TIME<0 TIME="###"
 Q
 ;
TIMEDIF(START,FINISH) ; Set values to be compared, in seconds
 ;
 S TIMEDIF=$$FMDIFF^XLFDT(START,FINISH,2)/900
 I (TIMEDIF>0)&(TIMEDIF<.5) S TIMEDIF=.5
 Q
 ;
EXIT S ECXERR=1 Q
