DGPFDBRS ;SLC/SS - PRF DBRS ; 12/26/17
 ;;5.3;Registration;**951**;Aug 13, 1993;Build 135
 ;
 ;The API to get the DBRS information
 ;Implements the ICR# 6874
 ;Parameters:
 ; DGDFN - patient's DFN
 ; DGRETARR - array to return information in the format:
 ;   ARR(1)="DBRS#^DBRS date^DBRS other information"
 ;   ARR(2)="DBRS#^DBRS date^DBRS other information"
 ;   ...
 ;   ARR(n)="DBRS#^DBRS date^DBRS other information"
 ; Note: the DBRS entries are listed in the reversed order. 
 ;   ARR(1) contains the latest entry
 ; DGFLAG - for which flag the DBRS entry data need to be returned 
 ;   Note: Default is "BEHAVIORAL"
 ;
 ;Returns:
 ; the latest entry ARR(1) - if any entries exist
 ;or
 ; "" - if no entries found
 ; "" - if the patient doesn't have a PRF flag
 ;
GETDBRS(DGDFN,DGRETARR,DGFLAG) ;
 N DG2613,DGARR,DGIEN,DGCNT,DGCURFLG
 S DGFLAG=$G(DGFLAG,"BEHAVIORAL")
 S DG2613=0 F  S DG2613=$O(^DGPF(26.13,"B",DGDFN,DG2613)) Q:+DG2613=0  D
 . K DGARR
 . D GETS^DIQ(26.13,DG2613_",",".02;2*","E","DGARR")
 . S DGCURFLG=$G(DGARR(26.13,DG2613_",",.02,"E"))
 . I DGCURFLG']"" Q
 . S DGIEN="Z",DGCNT=0
 . F  S DGIEN=$O(DGARR(26.131,DGIEN),-1) Q:DGIEN']""  D
 . . S DGCNT=DGCNT+1 S DGRETARR(DGCURFLG,DGCNT)=DGARR(26.131,DGIEN,.01,"E")_U_DGARR(26.131,DGIEN,.02,"E")
 I '$D(DGRETARR) Q ""
 Q $G(DGRETARR(DGFLAG,1))
 ;
