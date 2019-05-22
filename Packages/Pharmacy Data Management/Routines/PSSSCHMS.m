PSSSCHMS ;BIR/MV-Frequency utilities routine ;09/13/10
 ;;1.0;PHARMACY DATA MANAGEMENT;**178,206,231**;9/30/97;Build 4
 ;;Reference to INP^VADPT supported by DBIA #10061
 ;
OLDSCH(PSSFWSCC) ;Get IEN for .01 of the schedule file from the Old Schedule name
 ;Input:
 ; PSSFWSC - Schedule name from the order
 ;Output:
 ; Schedule Name(.01)^51.1 IEN(if old schedule found) 
 ;
 NEW PSSOLDNM,PSSSCH,PSSIEN,PSSOSN
 I $G(PSSFWSCC)="" Q ""
 ; Skip looking for the old schedule name if there is an exact matched for the original schedule
 I $O(^PS(51.1,"APPSJ",PSSFWSCC,0)) Q PSSFWSCC
 S PSSOLDNM=PSSFWSCC
 S PSSIEN=+$O(^PS(51.1,"D",PSSOLDNM,0))
 ; If there is an exact matched to the old schedule name then use it. Otherwise retain the original schedule
 I 'PSSIEN Q PSSFWSCC
 S PSSSCH=$G(^PS(51.1,PSSIEN,0))
 I $P(PSSSCH,U)]"",($P(PSSSCH,U,4)="PSJ") S PSSFWSCC=$P(PSSSCH,U),PSSOSN=+PSSIEN
 Q PSSFWSCC_U_$G(PSSOSN)
 ;
OLD51(PSSFWSCC) ;Get IEN for .01 of the Med Instruction file from the Old Med Instruction name
 ;Input:
 ; PSSFWSC - Schedule name from the order
 ;Output:
 ; Med instruction name(.01)^51 IEN(If old med Instruction found)
 ;
 NEW PSSOLDNM,PSSSCH,PSSIEN,PSSOMEDN
 I $G(PSSFWSCC)="" Q ""
 I $O(^PS(51,"B",PSSFWSCC,0)) Q PSSFWSCC
 S PSSOLDNM=PSSFWSCC
 S PSSIEN=+$O(^PS(51,"D",PSSOLDNM,0))
 I 'PSSIEN Q PSSFWSCC
 S PSSSCH=$P($G(^PS(51,PSSIEN,0)),U)
 S:PSSSCH]"" PSSFWSCC=PSSSCH,PSSOMEDN=+PSSIEN
 Q PSSFWSCC_U_$G(PSSOMEDN)
 ;
DCFSCH(PSSIEN,PSSDDIEN,PSSFWDRL) ;Dosing Check Frequency process for 51.1
 ;Input:
 ; PSSIEN - IEN from 51.1
 ; PSSDDIEN - IEN from file 50
 ; PSSFWDRL - The order duration
 ;Output:
 ; PSSDCF - P1(adjust if order duration is passed in)^P2(#51.1 - 0;11)
 ;
 Q:'+$G(PSSIEN) ""
 NEW PSSDCF,PSSDCFLG,PSSDCF1,PSSFRQF,PSSNODD
 S PSSDCFLG=0
 S PSSDCF=$P($G(^PS(51.1,+PSSIEN,0)),U,11)
 Q:PSSDCF="" ""
 ; If no dispense drug is defined in 51.1 then return DCF if available
 I '$O(^PS(51.1,+PSSIEN,4,0)) S PSSDCFLG=1
 I $G(PSSDBIFL) D  Q:+PSSNODD ""
 .S PSSNODD=$$NOTALLDD(+$G(PSSDBFDB("OI")),PSSIEN)
 .S:'+PSSNODD PSSDDIEN=$P(PSSNODD,U,2)
 ; If the dispense drug is defined, then verify if PSSDDIEN existed
 I 'PSSDCFLG,+$G(PSSDDIEN),$D(^PS(51.1,+PSSIEN,4,"B",+PSSDDIEN)) S PSSDCFLG=1
 I 'PSSDCFLG Q ""
 I $G(PSSFWDRL)]"" S PSSFRQF=$P($G(^PS(51.1,PSSIEN,0)),"^",3),PSSDCF1=$$DCFSCHD(PSSIEN,PSSFWDRL,PSSDCF,PSSFRQF) Q $S($G(PSSDCF1)]"":PSSDCF1,1:"")_U_PSSDCF
 Q $S($G(PSSDCF1)]"":PSSDCF1,1:PSSDCF)_U_PSSDCF
 ;
DCFSCHD(PSSIEN,PSSFWDRL,PSSDCF,PSSFRQF) ;Adjusting the frequency based on the order duration
 ;PSSDRL - The order duration (in minute)
 ;PSSFRQF - Frequency value from 51 or 51.1
 ;Return the adjusted frequency
 ;Note - the frequency is rounded up when needed. (ex: Q4H for 6 hours (order duration), the frequency = 2; 
 ; the reason is that the pt received dose 1 in the first hour and 2nd dose 4 hours later.
 NEW PSSDRL,PSSFRQ,PSSDCFN,PSSDCFD,PSSDCF1
 Q:$G(PSSDCF)="" ""
 Q:$G(PSSFWDRL)="" ""
 S PSSDRL=$$DRT^PSSDSAPD(PSSFWDRL)
 I PSSDRL'<1440 Q ""
 S PSSDCF1=""
 ; Adjust frequency for Q#H
 I PSSDCF?1"Q"1N.N1"H" D  Q PSSDCF1
 . S PSSDCFN=+$E(PSSDCF,2,$L(PSSDCF))*60
 . S PSSDCFD=PSSDRL/PSSDCFN
 . I PSSDCFD<1 S PSSDCF1="" Q
 . S PSSDCF1=$S((PSSDCFD?.N):PSSDCFD,1:$J((PSSDCFD+.5),0,0))
 ; Adjust frequency for X#D (# per day)
 I +$G(PSSFRQF),(PSSDCF?1"X"1N.N1"D") D  Q PSSDCF1
 . I '+$G(PSSIEN) S PSSDCF1="" Q
 . S PSSFRQ=PSSDRL/PSSFRQF
 . S PSSFRQ=$S((PSSFRQ?.N):PSSFRQ,1:$J((PSSFRQ+.5),0,0))
 . S (PSSDCFN,PSSDCF1)=+$E(PSSDCF,2,$L(PSSDCF))
 . I PSSDCFN>PSSFRQ S PSSDCF1=PSSFRQ
 Q $G(PSSDCF1)
 ;
DCF51(PSSIEN,PSSDDIEN,PSSFWDRL) ;Dosing Check Frequency process for Med Instruction file
 ;Input:
 ; PSSIEN - IEN from 51
 ; PSSDDIEN - IEN from file 50
 ; PSSFWDRL - Order duration
 ;Output:
 ; PSSDCF - P1(adjust if order duration is passed in)^P2(#51 - 0;9)
 ;
 Q:'+$G(PSSIEN) ""
 NEW PSSDCF,PSSDCFLG,PSSDCF1,PSSFRQF
 S PSSDCFLG=0
 S PSSDCF=$P($G(^PS(51,+PSSIEN,0)),U,9)
 Q:PSSDCF="" ""
 ; check if the dispense drug is specified in 51
 I '$O(^PS(51,+PSSIEN,5,0)) S PSSDCFLG=1
 I 'PSSDCFLG,+$G(PSSDDIEN),$D(^PS(51,+PSSIEN,5,"B",+PSSDDIEN)) S PSSDCFLG=1
 I 'PSSDCFLG Q ""
 I $G(PSSFWDRL)]"" S PSSFRQF=$P($G(^PS(51,PSSIEN,0)),U,8),PSSDCF1=$$DCFSCHD(PSSIEN,PSSFWDRL,PSSDCF,PSSFRQF)
 Q $S($G(PSSDCF1)]"":PSSDCF1,1:PSSDCF)_U_PSSDCF
 ;
MULTSCH(PSSMSCH,PSSFWFR,PSSFWPK,PSSFWDRL) ;Return Frequency for PSSMSCHD with multi schedules
 ;Piece out each word (schedule) in PSSMSCH
 ;PSSMSCH - Multi-schedules
 ;PSSFWSCC - Single schedule (pieced out)
 ;PSSFRQ - Return 2 pieces - p1 = adjusted frequency (duration); p2 = the frequency
 ;It is necessary to set PSSDBAR("TYPE")="SINGLE DOSE" when the schedule is determined for "Once" or "ONCALL".
 ;PSSDBAR array came from DOSE^PSSDSAPD
 NEW PSSFRQ,PSSFWSCC,PSSDOW,PSSDOWAT,PSSONCE,PSSODRL,PSSOSCH,PSSOUT1,PSSOUTD,PSSOUTX,PSSP1,PSSX
 S PSSFRQ="^",PSSONCE=0,PSSDOW=0,PSSODRL=$G(PSSFWDRL),PSSOSCH=""
 I $G(PSSMSCH)="" Q "^"
 F PSSX=1:1:$L(PSSMSCH," ") S PSSFWSCC=$P(PSSMSCH," ",PSSX) D  Q:PSSONCE
 . I $G(PSSFWSCC)="" S PSSFRQ="^"
 . S PSSFWSCC=$$ADDAT(PSSFWSCC)
 . I $$ONETIME(PSSFWSCC) S PSSONCE=1 Q
 . I PSSFWSCC["@" S PSSFWFR="D",PSSDOW=1
 . ; $$FRQZ^PSSDSAPI needs PSSFWFR="D" for DOW schedule
 . S PSSOUT1=$$FRQZ^PSSDSAPI()
 . ;I PSSFWSCC["@" S PSSDOWAT=PSSOUT1
 . I PSSFWSCC["@" S:$G(PSSOUT1)]"" PSSOUTD(PSSOUT1,PSSFWSCC)=""
 . I PSSOUT1]"" S PSSOUTX(PSSOUT1,PSSFWSCC)="" S:PSSOSCH="" PSSOSCH=PSSFWSCC
 ;
 I $G(PSSONCE) S PSSDBAR("TYPE")="SINGLE DOSE" Q "1^1"
 I $D(PSSOUTD) D  Q $S($G(PSSP1)]"":PSSP1_"^"_PSSP1,1:"^")
 . S PSSP1=$O(PSSOUTD("")) I $O(PSSOUTD(PSSP1))]"" S PSSP1="" Q
 ; Check if the schedules have the same frequency.
 S PSSP1=$O(PSSOUTX("")) I $O(PSSOUTX(PSSP1))]"" Q "^"
 I $G(PSSFWDRL)="" Q PSSP1_U_PSSP1
 ; Get the frequency for piece 2 without the duration factor in 
 I $G(PSSP1)]"",($G(PSSFWDRL)]""),($G(PSSOSCH)]"") S PSSFWDRL="",PSSFWSCC=PSSOSCH,PSSFRQ=PSSP1_U_$$FRQZ^PSSDSAPI(),PSSFWDRL=PSSODRL
 Q PSSFRQ
ONETIME(PSSSCHD) ;check for one-time, now, oncall schedules
 ;Return 1 if schedule is one-time, now
 ; 0 if not
 NEW PSSX,PSSASIEN,PSSOUT
 I $G(PSSSCHD)="" Q 0
 S PSSOUT=0
 F PSSASIEN=0:0 S PSSASIEN=$O(^PS(51.1,"APPSJ",PSSSCHD,PSSASIEN)) Q:'PSSASIEN  D  Q:PSSOUT
 . S PSSX=$P($G(^PS(51.1,PSSASIEN,0)),U,5)
 . S:PSSX="O"!(PSSX="OC") PSSOUT=1
 Q PSSOUT
 ;
DOWAT(PSSFWSCC,PSSDDIEN) ;
 ;Process day of week with admin times (ex SU-MO@12)
 NEW PSSIEN,PSSSCH1,PSSSCH2
 Q:$G(PSSFWSCC)="" ""
 S PSSSCH1=$P(PSSFWSCC,"@"),PSSSCH2=$P(PSSFWSCC,"@",2)
 S PSSIEN=$$DOWIEN(PSSFWSCC,PSSSCH1,PSSSCH2)
 I 'PSSIEN S PSSIEN=$$DOWIEN(PSSSCH1_"@"_PSSSCH2,PSSSCH1,PSSSCH2)
 I 'PSSIEN S PSSIEN=$$DOWIEN(PSSSCH1_"@"_$$AT(PSSSCH2,2),PSSSCH1,PSSSCH2)
 I 'PSSIEN S PSSIEN=$$DOWIEN(PSSSCH1_"@"_$$AT(PSSSCH2,4),PSSSCH1,PSSSCH2)
 I 'PSSIEN S PSSIEN=$$DOWIEN(PSSSCH1,PSSSCH1,PSSSCH2)
 I 'PSSIEN Q ""
 ;Get DCF(the order duration is ignored when it's DOW schedule)
 Q $$DCFSCH(PSSIEN,$G(PSSDDIEN))
 ;
DOWIEN(PSSSCH,PSSSCH1,PSSSCH2) ;
 ;Return 51.1 IEN (if more than one matched, return the DOW, else the first matched)
 NEW PSSIEN,PSSX,PSSFLG
 Q:$G(PSSSCH)="" ""
 S PSSIEN=0,PSSFLG=0
 F PSSX=0:0 S PSSX=$O(^PS(51.1,"APPSJ",PSSSCH,PSSX)) Q:'PSSX  D  Q:PSSFLG
 . I '$$SCHAT(PSSX,$G(PSSSCH1),$G(PSSSCH2)) Q
 . ; store the first IEN found
 . I 'PSSIEN S PSSIEN=PSSX
 . I $P($G(^PS(51.1,PSSX,0)),U,5)="D" S PSSIEN=PSSX,PSSFLG=1 Q
 Q PSSIEN
 ;
AT(PSSAT,PSSDIG) ;return admin time(s) in 2 or 4 digits format
 ;PSSDIG - set admin time to 2 digits or 4 digits format (ex: 09 or 0900)
 NEW PSSY,PSSX
 Q:$G(PSSAT)="" ""
 I '+$G(PSSDIG) S PSSDIG=4
 S PSSX=""
 F PSSY=1:1:$L(PSSAT,"-") S PSSX=PSSX_$S(PSSX="":"",1:"-")_$E($P(PSSAT,"-",PSSY)_"0000",1,PSSDIG)
 Q PSSX
 ;
SCHAT(PSSIEN,PSSSCH1,PSSSCH2) ;return PSSIEN from 51.1 for DOW
 NEW PSSFL1,PSSFL2,PSSAT,PSSIEN0
 Q:'+$G(PSSIEN) 0
 S PSSIEN0=$G(^PS(51.1,PSSIEN,0))
 S PSSAT=$P(PSSIEN0,U,2),(PSSFL1,PSSFL2)=0
 ; Return IEN if there is no admin time define and schedule matched .01
 I (PSSAT=""),($G(PSSSCH1)_"@"_$G(PSSSCH2))=$P(PSSIEN0,U) Q PSSIEN
 I (PSSAT=""),($G(PSSSCH1)_"@"_$$AT($G(PSSSCH2),2))=$P(PSSIEN0,U) Q PSSIEN
 I (PSSAT=""),($G(PSSSCH1)_"@"_$$AT($G(PSSSCH2),4))=$P(PSSIEN0,U) Q PSSIEN
 ; If admin is not defined in 51.1 but was entered with order
 I (PSSAT=""),(PSSSCH2]"") S PSSFL1=1
 ; There maybe multiple entries with the same DOW. Tried to find the one with the same admin time 
 ; Check for schedule and admin times from 51.1(in 2 & 4 digit format) matched to the admin time entered for the order
 I (PSSAT]""),($G(PSSSCH1)_"@"_$$AT(PSSAT,2))'=($G(PSSSCH1)_"@"_$$AT($G(PSSSCH2),2)) S PSSFL1=1
 I (PSSAT]""),($G(PSSSCH1)_"@"_$$AT(PSSAT,4))'=($G(PSSSCH1)_"@"_$$AT($G(PSSSCH2),4)) S PSSFL1=1
 ; Only return PSSIEN if the schedule and admin time from 51.1 matched order's Admin time
 I PSSFL1 S PSSIEN=0
 Q PSSIEN
ADDAT(PSSFWSCC) ;concatenate admin times from 51.1 to the schedule name for DOW
 ;PSSFWSCC - Schedule name
 NEW PSSASIEN,PSSX,PSSXFG
 I $G(PSSFWSCC)="" Q ""
 S PSSXFG=0
 F PSSASIEN=0:0 S PSSASIEN=$O(^PS(51.1,"APPSJ",PSSFWSCC,PSSASIEN)) Q:'PSSASIEN  D  Q:PSSXFG
 . I PSSFWSCC["@" S PSSXFG=1 Q
 . S PSSX=$G(^PS(51.1,PSSASIEN,0))
 . I $P(PSSX,U,5)'="D" S PSSXFG=1 Q
 . I $P(PSSX,U,2)]"" S PSSFWSCC=PSSFWSCC_"@"_$P(PSSX,U,2) S PSSXFG=1
 Q PSSFWSCC
CONVSCH(PSSFRQ) ;Convert numeric frequency to a schedule
 ;PSSFRQ - Frequency in minutes
 ;Return null or Schedule_0/1
 I '+$G(PSSFRQ) Q ""
 NEW PSSFWBAM,PSSFWBMN,PSSFWBNM,PSSFWRST,PSSFWBWK,PSSFWBXW,PSSFWBXL,PSSFWFLG
 S PSSFWFLG=0
 S PSSFWBAM=PSSFRQ/1440
 I PSSFWBAM'?.N Q ""
 I PSSFWBAM?.N D  Q PSSFWRST_U_PSSFWFLG
 .S PSSFWBMN=PSSFWBAM/30 I PSSFWBMN?.N S PSSFWFLG=1,PSSFWRST="Q"_PSSFWBMN_"L" Q
 .S PSSFWBWK=PSSFWBAM/7 I PSSFWBWK?.N S PSSFWFLG=1,PSSFWRST="Q"_PSSFWBWK_"W" Q
 .S PSSFWFLG=1,PSSFWRST="Q"_PSSFWBAM_"D" Q
 I PSSFRQ'>10080 S PSSFWBXW=10080/PSSFRQ I PSSFWBXW?.N S PSSFWFLG=1,PSSFWRST="X"_PSSFWBXW_"W" Q PSSFWRST_U_PSSFWFLG
 S PSSFWBXL=43200/PSSFRQ I PSSFWBXL?.N S PSSFWFLG=1,PSSFWRST="X"_PSSFWBXL_"L" Q PSSFWRST_U_PSSFWFLG
 Q ""
NOTALLDD(PSSGTOI,PSSIEN) ;When only OI is sent from CPRS, all DDs must be defined in 51.1 in order for the DCF value to be used. 
 ;PSSNOTDD=1 if not all dispense drugs are defined in in 51.1 and the last good DD
 ;PSSGOI - Orderable Item
 ;PSSIEN - 51.1 ien
 NEW PSSDD,PSSDDIEN,PSSDDACT,PSSNODD
 Q:'+$G(PSSGTOI) 0
 Q:'+$G(PSSIEN) 0
 I '$O(^PS(51.1,+PSSIEN,4,0)) Q 0  ;PSS*1*231 Correct issue with orphan 0 node
 S PSSNODD=0
 F PSSDDIEN=0:0 S PSSDDIEN=$O(^PSDRUG("ASP",PSSGTOI,PSSDDIEN)) Q:'PSSDDIEN!PSSNODD  D
 .I $$EXMT^PSSDSAPI(PSSDDIEN) Q
 .S PSSDDACT=$P($G(^PSDRUG(PSSDDIEN,"I")),"^") I PSSDDACT,PSSDDACT<DT Q
 .S PSSDD=PSSDDIEN
 .I '$D(^PS(51.1,+PSSIEN,4,"B",+PSSDDIEN)) S PSSNODD=1
 Q PSSNODD_U_$G(PSSDD)
CHKIPDUR() ;Check if CPRR IP has a duration <24hrs
 ;*************************************************************************
 ;*** MOCHA 2.1b - only perform daily dose if it is not a complex order ***
 ;*************************************************************************
 ;This is for CPRS IP order
 ;Check: only one sequence(not complex); EFD (expected first dose); Duration <24h;
 ;Return: 0 or 1^# of dose(s) for admin times within the duration.
 NEW PSSDUR,PSSADMIN,PSSDSCNT,PSSX
 I '$D(PSSDBFDB)!'$D(PSSDBDS) Q 0
 I $O(PSSDBFDB(1)) Q 0
 I $G(PSSDBFDB("PACKAGE"))'="I" Q 0
 I $G(PSSDBDS(1,"EFD"))="" Q 0
 S PSSX=$G(PSSDBDS(1,"DRATE"))
 S PSSDUR=$S((PSSX["H"):(+PSSX*60),(PSSX["M"):+PSSX,1:0)
 I 'PSSDUR Q 0
 I PSSDUR'<1440 Q 0
 S PSSADMIN=$$ADMIN($G(PSSDBDFN),$G(PSSDBDS(1,"SCHEDULE")))
 I PSSADMIN="" Q 0
 S PSSDSCNT=$$DOSECNT^PSSSCHMS(PSSDBDS(1,"EFD"),PSSADMIN,PSSDUR)
 Q 1_U_PSSDSCNT
ADMIN(DFN,PSSSCHD) ;Determine if admin times for the ward should be used
 NEW VAIN,PSSWARD,PSSIEN,PSSADM,PSSWDADM
 I $G(PSSSCHD)="" Q ""
 ;I '+$G(DFN) Q ""
 D:+$G(DFN) INP^VADPT
 S PSSWARD=+$G(VAIN(4))
 S (PSSADM,PSSWDADM)=""
 F PSSIEN=0:0 S PSSIEN=$O(^PS(51.1,"APPSJ",PSSSCHD,PSSIEN)) Q:(PSSIEN="")!(PSSWDADM]"")  D
 . S:PSSADM="" PSSADM=$P($G(^PS(51.1,PSSIEN,0)),U,2)
 . S PSSWDADM=$P($G(^PS(51.1,PSSIEN,1,+PSSWARD,0)),U,2)
 I PSSWDADM]"" Q PSSWDADM
 Q PSSADM
DOSECNT(PSSEFD,PSSAT,PSSDUR) ;count # of dose for duration <24h
 ;PSSEFD - Expected First Dose (dt.time)^Admin times from CPRS
 ;PSSDUR - duration in minutes
 ;Calculate # of doses for CPRS IP order with a duration
 ;Return p1^p2 (p1=0 unable to figure, 1 use p2 for count; p2=# doses need for this duration)
 NEW PSSEDT,PSSCNT,PSSSTRTM,PSSSTPTM,PSSDTFLG,PSSADMIN,PSSX
 Q:$G(PSSEFD)="" 0
 Q:$G(PSSAT)="" 0
 Q:'+$G(PSSDUR) 0
 S PSSEDT=$$FMADD^XLFDT(PSSEFD,,,+PSSDUR)
 S PSSCNT=0
 S PSSSTRTM=$E($P(PSSEFD,".",2)_"0000",1,4)
 S PSSSTPTM=$E($P(PSSEDT,".",2)_"0000",1,4)
 S PSSDTFLG=0
 I $P(PSSEFD,".")=$P(PSSEDT,".") S PSSDTFLG=1
 F PSSX=1:1 S PSSADMIN=$P(PSSAT,"-",PSSX) Q:PSSADMIN=""  D
 . S PSSADMIN=$E($P(PSSAT,"-",PSSX)_"0000",1,4)
 . I PSSDTFLG D  Q
 .. I (PSSSTRTM'>PSSADMIN),(PSSADMIN<PSSSTPTM) S PSSCNT=PSSCNT+1
 . I (PSSSTRTM'>PSSADMIN) S PSSCNT=PSSCNT+1
 . I (PSSSTPTM>PSSADMIN) S PSSCNT=PSSCNT+1
 Q PSSCNT
SCHD ;^PSSDSAPD is too big - move it here.
 N PSSDBSCD,PSSDBSCP,PSSDBSCF,PSSDBSCG,PSSDBSCH,PSSDCF
 S PSSDBAR("FREQ")=""
 ;I $D(PSSDBFDB(PSSDBLP,"FREQ")) S PSSDBAR("FREQ")=PSSDBFDB(PSSDBLP,"FREQ") Q
 I PSSDBAR("TYPE")="SINGLE DOSE" S PSSDBAR("FREQ")="" Q
 ;I $G(PSSDBDS(PSSDBLP,"DRATE"))'="",$$DRT(PSSDBDS(PSSDBLP,"DRATE"))<1440 S PSSDBSDR=1
 S PSSDBSCD=$G(PSSDBDS(PSSDBLP,"SCHEDULE"))
 I PSSDBSCD="",'$D(PSSDBFDB(PSSDBLP,"FREQ")) S PSSDBCAZ(PSSDBFDB(PSSDBLP,"RX_NUM"),"FRQ_ERROR")="" Q
 S (PSSDBSCF,PSSDBSCH)="" S PSSDBSCP=$P(PSSDBFDB(PSSDBLP,"RX_NUM"),";")
 I $G(PSSDBSCD)'="" F PSSDBSCG=0:0 S PSSDBSCG=$O(^PS(51.1,"APPSJ",PSSDBSCD,PSSDBSCG)) Q:'PSSDBSCG!(PSSDBSCH)  D
 .I $P($G(^PS(51.1,PSSDBSCG,0)),"^",5)="D" S PSSDBSCF="D"
 .I $P($G(^PS(51.1,PSSDBSCG,0)),"^",5)="O"!($P($G(^PS(51.1,PSSDBSCG,0)),"^",5)="OC") S PSSDBSCH=1
 I PSSDBSCH,'$D(PSSDBFDB(PSSDBLP,"FREQ")) S PSSDBAR("FREQ")=1 Q
 I $G(PSSDBSCD)["@" S PSSDBSCF="D"
 I $G(PSSDBSCD)'="" D
 . S PSSDBSCP=$S(PSSDBSCP="I":"I",1:"O")
 . S PSSDBAR("FREQZZ")=$$FRQ^PSSDSAPI(PSSDBSCD,PSSDBSCF,PSSDBSCP,$G(PSSDBDS(PSSDBLP,"DRATE")),$G(PSSDBFDB(PSSDBLP,"DRUG_IEN")))
 . S PSSDCF=$P(PSSDBAR("FREQZZ"),U,2)
 . I PSSDCF?1"X"1N.N1"D" S PSSDBAR("FREQZZ")=PSSDCF_U_PSSDCF,PSSDBFDB(PSSDBLP,"FREQ")=PSSDCF
 . S PSSDBAR("FREQ")=$P(PSSDBAR("FREQZZ"),"^")
 I $D(PSSDBFDB(PSSDBLP,"FREQ")) S PSSDBAR("FREQ")=PSSDBFDB(PSSDBLP,"FREQ") Q
 S:PSSDBAR("FREQ")="" PSSDBCAZ(PSSDBFDB(PSSDBLP,"RX_NUM"),"FRQ_ERROR")=""
 Q
