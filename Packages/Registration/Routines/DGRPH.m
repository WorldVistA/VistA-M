DGRPH ;ALB/MRL,TMK,JAM,ARF,ASF,LEG,ARF - REGISTRATION HELP ROUTINE ;Mar 10, 2020@19:19
 ;;5.3;Registration;**114,343,397,415,489,545,638,624,689,842,941,985,997,1014,1056,1064**;Aug 13, 1993;Build 41
 ;
 S DGRPH="" D H^DGRPU K DGRPH
 ;LEG; DG*5.3*997; cosmetically adjusted the spacing around the word "listing" to account for if "and edit" text was/wasn't included
 W !,"Enter '^' to stop the display ",$S(DGRPV:"",1:"and edit "),"of data, '^N' to jump to screen #N (see ",$S(DGRPV:"listing ",1:""),!,$S(DGRPV:"",1:"listing "),"below), <RET> to continue on to the next available screen"
 I DGRPV,DGRPS'=11.5 W "." G M ;LEG; DG*5.3*1014 - added <11.5> processing 
 W " or enter",!,"the field group number(s) you wish to edit using commas and dashes as",!,"delimiters.  Those groups enclosed in brackets ""[]"" are editable while those",!,"enclosed in arrows ""<>"" are not."
 W "  Enter 'ALL' to edit all editable data",!,"elements on the screen."
M I DGRPS=9,DGRPSEL="V" W !!,"You may precede your selection with 'V' to denote veteran."
 I DGRPS=9,DGRPSEL]"V" W !!,"To edit a specific column, enter 'V'",$S($D(DGREL("S")):", 'S'",1:""),$S($D(DGREL("D")):", 'D'",1:"")," in front of the selected items."
 ;ASF; DG*5.3*997; added screen 11.5
 S Z="DATA GROUPS ON SCREEN "_DGRPS,DGRPCM=1 W ! D WW^DGRPV S DGRPCM=0 D:DGRPS=1.1 A1 D:DGRPS=11.5 A2 D:DGRPS'=1.1&(DGRPS'?1"11.5".E) @DGRPS D:$S(DGRPS<12:1,DGRPS=14:1,1:0) W D S W ! F I=$Y:1:20 W !
 ;S Z="Press RETURN key",DGRPCM=1 D WW^DGRPV S DGRPCM=0 W " to EXIT Screen ",DGRPS," HELP " R X:DTIME S X="" Q
 S DGRPW=0 W "Press " S Z="<RETURN>",DGRPCM=1 D WW^DGRPV W " KEY " S Z="TO EXIT" D WW^DGRPV W " SCREEN ",DGRPS," " S Z="HELP" D WW^DGRPV W " " R X:DTIME S (DGRPCM,DGRPW)=0 Q
 ;JAM; DG*5.3*941; Groups on screen 1 and 1.1 have changed so update help text to reflect new locations
 ;ARF; DG*5.3*985; Add 'Birth' to 'Sex' and 'Preferred Name of Patient' to the Help screen for PATIENT DEMOGRAPHIC SCREEN 1
1 S X="Name, SSN, DOB, Birth Sex^Alias Name & SSN (if applicable)^Remarks concerning this patient^Cell Phone, Pager, E-Mail^Date & Time, Preferred Language^Preferred Name of Patient" Q
 ;ARF; DG*5.3*1056 removed Permanent from the following address label
A1 S X="Residential Address^Mailing Address^Temporary Mailing Address^Confidential Mailing Address" Q
2 S X="POB, Parents, etc.^Dates/Locations of Previous Care^Race and Ethnicity^Date of Death Information^Emergency Response^Indian Attestation" Q   ;jam; DG*5.3*1064 - Added Groups 5 and 6
3 S X="Primary Next-of-Kin^Secondary Next-of-Kin^Primary Emergency Contact^Secondary Emergency Contact^Designee to receive personal effects" Q
4 S X="Applicant Employer, Address^Spouses Employer, Address" Q
5 S X="Unexpired Insurance Policies^Eligibile for Medicaid" Q
6 S X="Service History^Conflict Locations^Exposure Factors^Prisoner of War^Combat^Military Retirement/Disability^Dental History^Purple Heart Recipient^Medal of Honor^Class II Dental Indicator" Q
7 S X="Patient Type, SC Data, Claim Info^VA Monetary Benefits^POS, Eligibility Code(s)^SC Conditions relayed by applicant" Q
8 S X="Spouse's Demographic Info^Dependents' Demographic Info" Q
9 S X="Social Security^U.S. Civil Service^U.S. Railroad Retirement^Military Retirement^Unemployment^Other Retirement^Total Employment Income^Interest,Dividend,Annuity^Workers Comp or Black Lung^Other Income" Q
10 S X="Ineligible Patient Information^Missing Patient Information" Q
11 S X="Eligibility Verification^Monetary Benefits Verification^Service Record Verification^Rated Disabilities (VA)^VHA Profiles (VHAP)" Q
A2 S X="Caregiver Status Data^Community Care Program (CCP) Collateral Data" Q  ;LEG; DG*5.3*1014 added CCP
12 W !,"Four most recent admission episodes on file for this applicant are displayed",!,"in inverse order." Q
13 W !,"Four most recent applications for care (registrations) are displayed in",!,"inverse order." Q
14 S X="Clinics in which actively enrolled^Pending (future) appointments" Q
 ;LEG; DG*5.3*1014 added Q to end of line to resolve double AVAILABLE SCREENS display
15 W !,"Sponsor information is displayed for patients." Q
S W ! S Z="AVAILABLE SCREENS",DGRPCM=1 D WW^DGRPV S DGRPCM=0
 ;jam; DG*5.3*941; New wording for screens 1 and 1.1
 S X="Patient Demographic^Additional Patient Demographic^Patient^Contact^Employment^Insurance^Service Record^Eligibility^Family Demographic^Income Screening^Missing/Ineligible^Eligibility Verification^"
 ;LEG; DG*5.3.997 ;added new Additional Eligibility Verification screen
 S X=X_"Additional Elig Verification^Admission Info^Application Info^Appointment Info^Sponsor Demographics"
 ;S C=0 F I=1:1 S J=$P(X,"^",I) Q:J=""  I '$E(DGRPVV,I) S C=C+1,Z="^"_I,DGRPW=(C#2) D WW^DGRPV S Z=$S(I?1N:"  ",1:" ")_J_" Data",Z1=$S((C#2)&(I?1N):36,(C#2):35,1:1) D WW1^DGRPV:(C#2) I '(C#2) W Z
 N DGJ
 S DGJ=""
 S C=0 F I=1:1 S DGJ=$O(DGRPVV(DGJ)) Q:DGJ=""  I '$E(DGRPVV,DGJ) D
 .S C=C+1,Z="^"_DGJ,DGRPW=(C#2)
 .D WW^DGRPV
 .;jam; DG*5.3*941; Change column position to fit the text of the new wording for screens 1 and 1.1
 .S Z1=$S((C#2)&(DGJ?1N):33,(C#2):32,1:1)
 .S Z=$S(DGJ?1N:"  ",1:" ")_$P(X,U,I)_" Data"
 .;LEG; DG*5.3*997; added to Available Screens list
 .S:DGJ=11.5 Z=" Add'l Elig Verification Data",Z1=30
 .D WW1^DGRPV:(C#2)
 .I '(C#2) W Z
 Q
W ;LEG; DG*5.3*1014 added C2L check for string too long if in column 2
 F I=1:1 S J=$P(X,"^",I) Q:J=""  S Z=I,DGRPW=(I#2) D:'DGRPW C2L D WW^DGRPV S Z=$S(I<10:"  ",1:" ")_J,Z1=$S((I#2)&(I>10):36,(I#2):37,1:1) D WW1^DGRPV
 W:'DGRPW ! ;'((I-1)#2) ! ;Q
 Q
 ;LEG; DG*5.3*1014
C2L ;checks if string is too long for end of line display
 I ($L(J)+$S(I>10:36,1:37))>80 S DGRPW=1
 Q
