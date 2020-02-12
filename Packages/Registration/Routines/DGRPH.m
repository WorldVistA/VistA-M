DGRPH ;ALB/MRL,TMK,JAM,ARF - REGISTRATION HELP ROUTINE ;30 Oct 2017  3:03 PM
 ;;5.3;Registration;**114,343,397,415,489,545,638,624,689,842,941,985**;Aug 13, 1993;Build 15
 ;
 S DGRPH="" D H^DGRPU K DGRPH W !,"Enter '^' to stop the display ",$S(DGRPV:"",1:"and edit "),"of data, '^N' to jump to screen #N (see",!,"listing below), <RET> to continue on to the next available screen" I DGRPV W "." G M
 W " or enter",!,"the field group number(s) you wish to edit using commas and dashes as",!,"delimiters.  Those groups enclosed in brackets ""[]"" are editable while those",!,"enclosed in arrows ""<>"" are not."
 W "  Enter 'ALL' to edit all editable data",!,"elements on the screen."
M I DGRPS=9,DGRPSEL="V" W !!,"You may precede your selection with 'V' to denote veteran."
 I DGRPS=9,DGRPSEL]"V" W !!,"To edit a specific column, enter 'V'",$S($D(DGREL("S")):", 'S'",1:""),$S($D(DGREL("D")):", 'D'",1:"")," in front of the selected items."
 S Z="DATA GROUPS ON SCREEN "_DGRPS,DGRPCM=1 W ! D WW^DGRPV S DGRPCM=0 D:DGRPS=1.1 A1 D:DGRPS'=1.1 @DGRPS D:$S(DGRPS<11:1,DGRPS=14:1,1:0) W D S W ! F I=$Y:1:20 W !
 ;S Z="Press RETURN key",DGRPCM=1 D WW^DGRPV S DGRPCM=0 W " to EXIT Screen ",DGRPS," HELP " R X:DTIME S X="" Q
 S DGRPW=0 W "Press " S Z="<RETURN>",DGRPCM=1 D WW^DGRPV W " KEY " S Z="TO EXIT" D WW^DGRPV W " SCREEN ",DGRPS," " S Z="HELP" D WW^DGRPV W " " R X:DTIME S (DGRPCM,DGRPW)=0 Q
 ;JAM; DG*5.3*941; Groups on screen 1 and 1.1 have changed so update help text to reflect new locations
 ;ARF; DG*5.3*985; Add 'Birth' to 'Sex' and 'Preferred Name of Patient' to the Help screen for PATIENT DEMOGRAPHIC SCREEN 1
1 S X="Name, SSN, DOB, Birth Sex^Alias Name & SSN (if applicable)^Remarks concerning this patient^Cell Phone, Pager, E-Mail^Date & Time, Preferred Language^Preferred Name of Patient" Q
A1 S X="Residential Address^Permanent Mailing Address^Temporary Mailing Address^Confidential Mailing Address" Q
2 S X="POB, Parents, etc.^Dates/Locations of Previous Care^Race and Ethnicity^Date of Death Information" Q
3 S X="Primary Next-of-Kin^Secondary Next-of-Kin^Primary Emergency Contact^Secondary Emergency Contact^Designee to receive personal effects" Q
4 S X="Applicant Employer, Address^Spouses Employer, Address" Q
5 S X="Unexpired Insurance Policies^Eligibile for Medicaid" Q
6 S X="Service History^Conflict Locations^Exposure Factors^Prisoner of War^Combat^Military Retirement/Disability^Dental History^Purple Heart Recipient^Medal of Honor^Class II Dental Indicator" Q
7 S X="Patient Type, SC Data, Claim Info^VA Monetary Benefits^POS, Eligibility Code(s)^SC Conditions relayed by applicant" Q
8 S X="Spouse's Demographic Info^Dependents' Demographic Info" Q
9 S X="Social Security^U.S. Civil Service^U.S. Railroad Retirement^Military Retirement^Unemployment^Other Retirement^Total Employment Income^Interest,Dividend,Annuity^Workers Comp or Black Lung^Other Income" Q
10 S X="Ineligible Patient Information^Missing Patient Information" Q
11 S X="Eligibility Verification^Monetary Benefits Verification^Service Record Verification^Rated Disabilities (VA)" Q
12 W !,"Four most recent admission episodes on file for this applicant are displayed",!,"in inverse order." Q
13 W !,"Four most recent applications for care (registrations) are displayed in",!,"inverse order." Q
14 S X="Clinics in which actively enrolled^Pending (future) appointments" Q
15 W !,"Sponsor information is displayed for patients."
S W ! S Z="AVAILABLE SCREENS",DGRPCM=1 D WW^DGRPV S DGRPCM=0
 ;jam; DG*5.3*941; New wording for screens 1 and 1.1
 S X="Patient Demographic^Additional Patient Demographic^Patient^Contact^Employment^Insurance^Service Record^Eligibility^Family Demographic^Income Screening^Missing/Ineligible^Eligibility Verification^"
 S X=X_"Admission Info^Application Info^Appointment Info^Sponsor Demographics"
 ;S C=0 F I=1:1 S J=$P(X,"^",I) Q:J=""  I '$E(DGRPVV,I) S C=C+1,Z="^"_I,DGRPW=(C#2) D WW^DGRPV S Z=$S(I?1N:"  ",1:" ")_J_" Data",Z1=$S((C#2)&(I?1N):36,(C#2):35,1:1) D WW1^DGRPV:(C#2) I '(C#2) W Z
 N DGJ
 S DGJ=""
 S C=0 F I=1:1 S DGJ=$O(DGRPVV(DGJ)) Q:DGJ=""  I '$E(DGRPVV,DGJ) D
 .S C=C+1,Z="^"_DGJ,DGRPW=(C#2)
 .D WW^DGRPV
 .;jam; DG*5.3*941; Change column position to fit the text of the new wording for screens 1 and 1.1
 .S Z1=$S((C#2)&(DGJ?1N):33,(C#2):32,1:1)
 .S Z=$S(DGJ?1N:"  ",1:" ")_$P(X,U,I)_" Data"
 .D WW1^DGRPV:(C#2)
 .I '(C#2) W Z
 Q
W F I=1:1 S J=$P(X,"^",I) Q:J=""  S Z=I,DGRPW=(I#2) D WW^DGRPV S Z=$S(I<10:"  ",1:" ")_J,Z1=$S((I#2)&(I>10):36,(I#2):37,1:1) D WW1^DGRPV
 W:'((I-1)#2) ! Q
