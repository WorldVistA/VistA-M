IBARXCFL ;ALB/MKN-CERNER RXCOPAY CHECK IF CERNER-CONVERTED ;30 Dec 2020
 ;;2.0;INTEGRATED BILLING;**676**;21-MAR-94;Build 34
 ;
 ;ICR #     Supports
 ; 2990     TFL^VAFCTFU2
 ;10112     $$SITE^VASITE
 ;
TFL(IBZ,DFN,CCR)  ;Call to ensure the Cerner and converted site entries are handled
 ;Returns a modified IBZ array. VAFCTFU2 is the new source of truth for Treating Fac List
 ;CCR is new parameter that determines what entries are to be left in the new IBZ array
 ; CCR=0    Remove all Converted sites and Cerner entry
 ; CCR=1    Remove all Converted sites Leave Cerner entry
 ; CCR=2    Leave Converted sites Leave Cerner entry
 ; CCR=3    Leave Converted remove Cerner
 ;
 N IBKEY
 I $G(CCR)="" S CCR=3
 S IBKEY=DFN_U_"PI"_U_"USVHA"_U_$P($$SITE^VASITE,"^",3)
 D TFL^VAFCTFU2(.IBTFL,IBKEY)
 Q:-$G(IBTFL(1))=1 0  ;This function quits if the array returns a -1
 N IBX  ;TRANSFER ARRAY FOR REBUILDING IBTFL TO LOOK LIKE IBZ
 ;
 ;REMOVE NON-PI SITES AND NON-USVHA SITES FROM IBTFL
 N CNT,CNTI,CNTT,IDTYPE,IDAA,SITEID,IDSTATUS,TFLDT,TFLNUM,STYPE,SITEIEN,SITENM
 S CNTI=0,CNTT=0
 F  S CNTI=$O(IBTFL(CNTI)) Q:CNTI=""  D
 . ;PIECE APART THE ELEMENTS OF THE ID
 . S IDTYPE=$P(IBTFL(CNTI),"^",2),IDAA=$P(IBTFL(CNTI),"^",3)
 . S SITEID=$P(IBTFL(CNTI),"^",4),IDSTATUS=$P(IBTFL(CNTI),"^",5)
 . ;Values set Now kill all entries we don't want
 . I SITEID["742V1"!(SITEID["741") K IBTFL(CNTI)  Q
 . I IDTYPE'="PI" K IBTFL(CNTI)  Q
 . I IDAA'="USVHA" K IBTFL(CNTI)  Q
 . I IDSTATUS="C" D
 . . I CCR>1 Q
 . . K IBTFL(CNTI)
 . Q:$G(IBTFL(CNTI))=""
 . I SITEID[200 D
 . . I SITEID'["CRNR" K IBTFL(CNTI) Q
 . . I CCR=1!(CCR=2) Q
 . . K IBTFL(CNTI)
 . Q:$G(IBTFL(CNTI))=""
 . S CNTT=CNTT+1
 . ;Rebuld the VAFCTFU1 array in the format used by VAFCTFU2 utility
 . S SITEIEN=$O(^DIC(4,"D",SITEID,0))
 . S SITENM=$$GET1^DIQ(4,SITEIEN_",",.01,"E")
 . S STYPE=$$GET1^DIQ(4,SITEIEN_",",13,"E")
 . D MATCH(.IBZ,CNTI)  ;See if you can match this entry to the VAFCTFU1 arry for two values
 . S IBX(CNTT)=SITEID_"^"_SITENM_"^"_TFLDT_"^"_TFLNUM_"^"_STYPE
 ;Now we have an IBX array that is built from VAFCTFU2 but with data from VAFCTFU1 replace IBZ
 K IBZ,IBTFL
 M IBZ=IBX
 K IBX
 S:$D(IBZ) IBZ=1
 ;Send new IBZ back
 Q IBZ
 ;
MATCH(IBZ,CNTI)  ;The VAFCTFU2 array lacks two entries from the 391.91 file. 
 ;Attempt to match to the VAFCTFU2 array and use the 3rd 4th and 5th piece from the TFL
 S TFLDT="",TFLNUM=""
 N CNTM,QUIT
 S CNTM=0,QUIT=0
 F  S CNTM=$O(IBZ(CNTM)) Q:CNTM=""!(QUIT)  D
 . Q:SITEID'=$P(IBZ(CNTM),"^",1)
 . S TFLDT=$P(IBZ(CNTM),"^",3)
 . S TFLNUM=$P(IBZ(CNTM),"^",4)
 . S QUIT=1
 . Q
 Q
 ;
