IVMUFNC1 ;ALB/SEK - INPATIENT/OUTPATIENT CALCULATIONS ; 06/19/2003
 ;;2.0;INCOME VERIFICATION MATCH ;**3,11,80**; 21-OCT-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN(DFN,IVMMTDT,IVMQUERY) ; number of inpatient and outpatient days since IVMMTDT date to
 ; IVMENDT (earliest of day before next means test and day before current date).
 ;  Input:  DFN    --  pointer to patient in file #2
 ;          IVMMTDT  --  Means Test date/time for the patient
 ;          IVMQUERY("OVIS") -- # of the QUERY that is currently open or
 ;                      undefined, zero, or null if no QUERY opened for
 ;                      finding outpatient visits
 ; Output:  1^2 where piece 1 = # of inpatient days
 ;                    piece 2 = # of outpatient days
 ;
 N IVMAD,IVMADMDT,IVMD,IVMDCN,IVMDT,IVMDGPM,IVMDISDT,IVMENDT,IVMF,IVMI,IVMIN,IVMOUT
 N IVMASIH,IVMADPTR,IVMDATE,VAINDT,VADMVT,VAIP,VAERR
 ;
 S (IVMIN,IVMOUT)=0
 I '$G(IVMMTDT) G EPQ
 S IVMMTDT=$P($$LST^DGMTU(DFN,IVMMTDT),"^",2)
 I '$G(IVMMTDT) G EPQ
 S IVMMTDT=$P(IVMMTDT,".")
 K ^TMP($J,"IVMUFNC1")
 ;
 ; - quit if the effective date of the test is today
 I IVMMTDT=DT G EPQ
 ;
 ; Calculate number of inpatient days
 ;
 ; get end date
 S IVMENDT=$$END^IVMUFNC2(DFN,IVMMTDT)
 ;
 ; - find if patient was an inpatient on IVMMTDT
 S VAINDT=IVMMTDT D ADM^VADPT2
 I VADMVT S IVMASIH=$P($G(^DGPM(VADMVT,0)),"^",21) D
 .I IVMASIH D  Q
 ..S IVMIN=IVMIN+$$LOS(VADMVT,IVMMTDT)
 ..S IVMADPTR=$P($G(^DGPM(IVMASIH,0)),"^",14)
 ..S IVMDATE=$$CHK(IVMADPTR,IVMMTDT)
 ..S IVMIN=IVMIN+$$LOS(IVMADPTR,IVMDATE)
 .S VAIP("D")=IVMMTDT D IN5^VADPT
 .I 'VAIP(10) S IVMDATE=$$CHK(VADMVT,IVMMTDT)
 .S IVMIN=IVMIN+$$LOS(VADMVT,$S('VAIP(10):IVMDATE,1:IVMMTDT))
 ;
 ; - find admissions after IVMMTDT to end date
 S IVMD="" F  S IVMD=$O(^DGPM("ATID1",DFN,IVMD)) Q:'IVMD!(9999999.9999999-IVMD<IVMMTDT)  I 9999999.9999999-IVMD'>IVMENDT S IVMIN=IVMIN+$$LOS(+$O(^(IVMD,0)))
 ;
 ; Calculate number of outpatient days
 ;
 D EN^IVMUFNC2(.IVMQUERY)
 ;
EPQ K ^TMP($J,"IVMUFNC1")
 Q IVMIN_"^"_IVMOUT
 ;
 ;
LOS(IVMDG,IVMST) ; Calculate the length of stay for an admission.
 ;  Input:    IVMDG   --  Pointer to the admission in file #405
 ;            IVMST   --  [Optional] Date after the admission on
 ;                        which to begin calculation of the LOS.
 ;  Output:       X   --  Length of stay (in days)
 ;
 N A,D,DFN,DGE,DGS,I,X,X1,X2,LOP,LOA,LOAS,LOS
 S (LOP,LOA,LOAS)=0
 I $S('$D(IVMDG):1,'$D(^DGPM(+IVMDG,0)):1,$P(^(0),"^",2)'=1:1,1:0) S X=0 G Q
 S X=^DGPM(+IVMDG,0),DFN=$P(^(0),"^",3),(X2,A)=+X,D=$S($D(^DGPM(+$P(X,"^",17),0)):+^(0),1:""),(X1,D)=$S('D:IVMENDT,D>IVMENDT:IVMENDT,1:D)
 I $G(IVMST)'<$P(D,".") S X=0 G Q
 S:$G(IVMST) (X2,A)=IVMST
 D ^%DTC S LOS=$S(X:X,1:1) ; LOS = elapsed time between admission and discharge (or end date)
 F I=A:0 S I=$O(^DGPM("APCA",DFN,IVMDG,I)) Q:'I  S DGS=$O(^(I,0)) I $D(^DGPM(+DGS,0)) S DGS=^(0) Q:+DGS>IVMENDT  I "^1^2^3^13^43^44^45^"[("^"_$P(DGS,"^",18)_"^") S X2=+DGS,DGS=$P(DGS,"^",18) D ABS Q:'I
 S X=LOS-LOA-LOAS
Q Q X
 ;
ABS ; If patient was out on absence, find return
 S X1=0 F I=I:0 S I=$O(^DGPM("APCA",DFN,IVMDG,I)) Q:'I  S DGE=$O(^(I,0)) I $D(^DGPM(+DGE,0)) S DGE=^(0) I "^14^22^23^24^"[("^"_$P(DGE,"^",18)_"^") S X1=+DGE,DGE=$P(DGE,"^",18) Q
 ; if no return from absence, use discharge or end date
 ; if return from absence greater then end date use end date
 I 'X1!(X1>D) S X1=D
 D ^%DTC S X=$S(X:X,1:1) I DGS=1,$S('$D(DGE):1,DGE'=25:1,1:0) S LOP=LOP+X Q  ;if TO AA <96, but not FROM AA<96, count as absence, not pass
 I "^1^2^3^25^26^"[("^"_DGS_"^") S LOA=LOA+X Q
 S LOAS=LOAS+X Q
 ;
CHK(ADPTR,DATE) ; Determine date that patient returned from leave
 ;  Input:   ADPTR  --  Pointer to admission in file #405
 ;            DATE  --  Date the patient was on leave or ASIH
 ;  Output:     X1  --  Date the patient returned from leave
 N X,Y,I,%,X1,X2,DIS,DGE
 S X=^DGPM(+ADPTR,0),DIS=$S($D(^DGPM(+$P(X,"^",17),0)):+^(0),1:""),DIS=$S('DIS:IVMENDT,DIS>IVMENDT:IVMENDT,1:DIS)
 S X1=0 F I=DATE:0 S I=$O(^DGPM("APCA",DFN,ADPTR,I)) Q:'I  S DGE=$O(^(I,0)) I $D(^DGPM(+DGE,0)) S DGE=^(0) I "^14^22^23^24^"[("^"_$P(DGE,"^",18)_"^") S X1=+DGE Q
 Q $P($S(X1:X1,1:DIS),".")
