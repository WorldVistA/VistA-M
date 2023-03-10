DGPPAPI ;SLC/SS - Presumptive Psychosis APIs ; 09/22/2020
 ;;5.3;Registration;**1029**;Aug 13, 1993;Build 19
 ;
 ;ICRs:
 ;$$INSUR^IBBAPI - DBIA4419 
 ;
 ;/** Returns PP information from the file (#2)
 ;Input:
 ; DFN - IEN in the file (#2)
 ;Output:
 ; Piece #1: 
 ;       ""  patient does not have information about Presumptive Psychosis category in the file (#2)
 ;       "Y" patient registered as Presumptive Psychosis patient in the file (#2)
 ;       "N" patient settings in the file (#2) contradict with the PP status  - cannot be PP because he/she is not a veteran 
 ; Piece #2: internal code for the PP category 
 ; Piece #3: full name of the PP category
 ;Example:
 ; Y^REJ^REJECTED DUE TO INCOME
 ;*/
PPINFO(DFN) ;
 N RETVAL
 N DGARR
 D GETS^DIQ(2,DFN_",",".5601;1901","IE","DGARR")
 I $G(DGARR(2,DFN_",",1901,"I"))="N" Q "N"  ;patient in not a veteran so she/he can be PP patient
 I $G(DGARR(2,DFN_",",.5601,"I"))="" Q ""
 S RETVAL="Y"_U_$G(DGARR(2,DFN_",",.5601,"I"))_U_$G(DGARR(2,DFN_",",.5601,"E"))
 Q RETVAL
 ;
 ;/** Was patient registered by using PP workaround methods
 ; a.Eligibility Status Data screen 7, section 1
 ;   Patient Type       = SC VETERAN
 ;   VETERAN (Y/N)?     = Yes
 ;   SERVICE CONNECTED? = Yes
 ; b.Primary Eligibility screen 7, section 3 = SC LESS THAN 50%
 ; c.RATED DISABILITIES screen 11, section 4 = SC%:0 
 ; d.RATED DISABILITY screen 11, section 4 = 9410
 ; e.screen 5, field 1 is not null  (insurance buffer entry)
 ;
 ;Input parameter
 ; DFN - IEN of the patient file #2
 ;Return values:
 ; N - No: there are no workaround PP settings
 ; Y - Yes, there are workaround PP settings
 ;*/
PPWRKARN(DGDFN) ;
 N RETVAL,DGSCL50,DGARR
 ; a.Eligibility Status Data screen 7, section 1
 ;   Patient Type       = SC VETERAN
 ;   VETERAN (Y/N)?     = Yes
 ;   SERVICE CONNECTED? = Yes
 I $$PTYPE(DGDFN)="N" Q "N"
 ;b.Primary Eligibility screen 7, section 3 = SC LESS THAN 50%
 I $$SCLES50(DGDFN)="N" Q "N"
 D GETS^DIQ(2,DGDFN_",",".302;.3721*","I","DGARR")
 ;c.RATED DISABILITIES screen 11, section 4 = SC%:0 
 I $G(DGARR(2,DGDFN_",",.302,"I"))'=0 Q "N"  ;2,.302 SERVICE CONNECTED PERCENTAGE
 ;d.RATED DISABILITY screen 11, section 4 = 9410 (2,.3721  RATED DISABILITIES (VA) .372;0 POINTER Multiple #2.04)
 I '$$DISABL(.DGARR) Q "N"
 ;e.screen 5, field 1 is not null  (insurance buffer entry)
 I '$$INSBUFF(DGDFN) Q "N"
 Q "Y"
 ;
 ; a.Eligibility Status Data screen 7, section 1
 ;   Patient Type       = SC VETERAN (2,391)
 ;   VETERAN (Y/N)?     = Yes (2,1901)
 ;   SERVICE CONNECTED? = Yes (2,.301)
 ;Input parameter
 ; DFN - IEN of the patient file #2
 ;Return values:
 ; N - No  
 ; Y - Yes
PTYPE(DFN) ;
 N VAEL,VAERR,PTYPE
 D ELIG^VADPT
 ;Patient Type   = SC VETERAN (2,391)
 ;VETERAN (Y/N)? = Yes
 ;SERVICE CONNECTED? = Yes (2,.301)
 S PTYPE="N"
 I $P(VAEL(6),U,2)="SC VETERAN",+VAEL(4),+VAEL(3) S PTYPE="Y"
 D KVAR^VADPT
 Q PTYPE
 ;
 ;/** Patient's primary insurance = "SC LESS THAN 50%"?
 ;2,.361 PRIMARY ELIGIBILITY CODE
 ;Input parameter
 ; DFN - IEN of the patient file #2
 ;Return values:
 ; N - No
 ; Y - Yes
 ;*/
SCLES50(DFN) ;
 N VAEL,X
 D ELIG^VADPT
 I +VAEL(1)>0,$$GET1^DIQ(8,+VAEL(1)_",",8)="SC LESS THAN 50%" Q "Y"
 Q "N"
 ;
 ;/** Does patient have an entry in the insurance buffer?
 ;Input parameter
 ; DFN - IEN of the patient file #2
 ;Return values:
 ; N - No
 ; Y - Yes
 ;*/
INSBUFF(DFN) ;
 N DGX,DGRTN
 S DGX=$$INSUR^IBBAPI(DFN,"","RAB",.DGRTN,"*")
 I $G(DGRTN("BUFFER"))>0 Q 1
 Q 0
 ;
 ;/** Return the disability DX CODE
 ;Input parameter
 ; IEN31 - IEN of the file #31
 ;Return values:
 ; DX CODE
 ;*/
DXCODE(IEN31) ;
 N DGARR
 D GETS^DIQ(31,IEN31_",","2","I","DGARR")
 Q $G(DGARR(31,IEN31_",",2,"I"))
 ;
 ;/** check for PP disability settings
 ;Input parameter
 ; IEN31 - IEN of the file #31
 ;Return values:
 ; 1 - PP settings 
 ; 0 - no PP settings
 ;*/
 ; 
DISABL(DGARR) ;
 N DGZ,DG31,DGRET
 S DGRET=0
 S DGZ=$O(DGARR(2.04,""))
 I '$G(DGZ) Q 0
 S DG31=$G(DGARR(2.04,DGZ,.01,"I")) ;IEN of the file #31
 I $$DXCODE(DG31)=9410,$G(DGARR(2.04,DGZ,2,"I"))=0 S:'$O(DGARR(2.04,DGZ)) DGRET=1
 Q DGRET
 ;
