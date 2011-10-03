DGPFUT1 ;ALB/RBS - PRF UTILITIES CONTINUED ; 6/9/06 10:56am
 ;;5.3;Registration;**425,607,650**;Aug 13, 1993;Build 3
 ;
 Q  ;no direct entry
 ;
DISPACT(DGPFAPI) ;Display all ACTIVE Patient Record Flag's for a patient
 ; Input:   DGPFAPI() = Array of patients active flags
 ;                      (passed by reference)
 ;                      See $$GETACT^DGPFAPI for array format.
 ; Output:  None
 ;
 I '$G(DGPFAPI) Q  ;no flags
 ;
 N DGPF,DGPFIEN,DGPFFLAG,DGPFCAT,IORVON,IORVOFF
 N DGCNT  ;flag display count
 N DGRET  ;return
 ;
 I $D(DDS) D CLRMSG^DDS
 W:'$D(DDS) !! W ">>> Active Patient Record Flag(s):"
 ;
 ; setup for reverse video display
 ;
 S (IORVON,IORVOFF)=""
 D:$D(IOST(0))
 . N X S X="IORVON;IORVOFF" D ENDR^%ZISS
 ;
 ; loop all returned Active Record Flag Assignment ien's
 S DGCNT=0
 S DGPFIEN="" F  S DGPFIEN=$O(DGPFAPI(DGPFIEN)) Q:DGPFIEN=""  D
 . I $D(DDS),DGCNT=4 D
 . . W !,"Press RETURN to continue..."
 . . R DGRET:$S('$D(DTIME):300,1:DTIME)
 . . D CLRMSG^DDS
 . . W ">>> Active Patient Record Flag(s):"
 . . S DGCNT=0
 . S DGPFFLAG=$P($G(DGPFAPI(DGPFIEN,"FLAG")),U,2)
 . Q:(DGPFFLAG'["")
 . S DGPFCAT=$P($P($G(DGPFAPI(DGPFIEN,"CATEGORY")),U,2)," ")
 . W !?5,IORVON,"<"_DGPFFLAG_">",IORVOFF,?45,"CATEGORY ",DGPFCAT
 . S DGCNT=DGCNT+1
 W:'$D(DDS) !
 Q
 ;
ASKDET() ;does user want to display flag details?
 ;
 ; Input:
 ;   None
 ;
 ; Output:
 ;  Function value - return 1 on YES; otherwise 0
 ;
 N YN,%,%Y
 F  D  Q:"^YN"[YN
 . W !,"Do you wish to view active patient record flag details"
 . S %=1  ;default to YES
 . D YN^DICN
 . S YN=$S(%=-1:"^",%=1:"Y",%=2:"N",1:"?")
 . I YN="?" D:$D(DDS) CLRMSG^DDS W !,"Enter either 'Y' or 'N'."
 Q (YN="Y")
 ;
DISPPRF(DGDFN) ; Patient Record Flags screen Display
 ;
 ; Supported References:
 ;   DBIA #10096 Z OPERATING SYSTEM FILE (%ZOSF)
 ;   DBIA #10150 ScreenMan API: Form Utilities
 ;
 ; Input:  
 ;   DGDFN - pointer to patient in PATIENT (#2) file
 ;
 ; Output:
 ;   none
 ;
 ; patient ien not setup
 S DGDFN=+$G(DGDFN)
 Q:'DGDFN
 ;
 N DGPFAPI
 ;
 ; call API to get the display array for ALL Active Assignments
 S DGPFAPI=$$GETACT^DGPFAPI(DGDFN,"DGPFAPI")  ;DBIA #3860
 ;
 ; quit if no Active Record Flags to display
 Q:'+DGPFAPI
 ;
 ; call api to display Active Record Flags
 D DISPACT(.DGPFAPI)
 ;
 ; prompt and display assignment details
 I $$ASKDET() D EN^DGPFLMD(DGDFN,.DGPFAPI)  ;ListMan
 ;
 ; cleanup display for ScreenMan
 I $D(DDS) D  D CLRMSG^DDS D REFRESH^DDSUTL
 . ;set right margin to zero - needed for Cache
 . N X
 . S X=0 X ^%ZOSF("RM")
 Q
 ;
SELPAT(DGPAT) ;This procedure is used to perform a patient lookup for an existing patient in the PATIENT (#2) file.
 ;
 ;  Input: None
 ;
 ; Output:
 ;   DGPAT - result array containing the patient selection on success,
 ;           pass by reference. Array will have same structure as the Y
 ;           variable returned by the ^DIC call.
 ;            Array Format:
 ;            -------------
 ;                 DGPAT = IEN of patient in PATIENT (#2) file on
 ;                         success, -1 on failure
 ;              DGPAT(0) = zero node of entry selected
 ;            DGPAT(0,0) = external form of the .01 field of the entry
 ;
 ;- int input vars for ^DIC call
 N DIC,DTOUT,DUPOT,X,Y
 S DIC="^DPT(",DIC(0)="AEMQZV"
 ;
 ;- lookup patient
 D ^DIC K DIC
 ;
 ;- result of lookup
 S DGPAT=Y
 ;
 ;- if success, setup return array using output vars from ^DIC call
 I (+DGPAT>0) D
 . S DGPAT=+Y              ;patient ien
 . S DGPAT(0)=$G(Y(0))     ;zero node of patient in (#2) file
 . S DGPAT(0,0)=$G(Y(0,0)) ;external form of the .01 field
 ;
 Q
 ;
GETFLAG(DGPFPTR,DGPFLAG) ;retrieve a single FLAG record
 ;  This function acts as a wrapper around the $$GETLF and $$GETNF
 ;  API's. Function will be used to obtain a single flag record from
 ;  either the PRF LOCAL FLAG (#26.11) file or the PRF NATIONAL FLAG
 ;  (#26.15) file depending on the value of the DGPFPTR input parameter.
 ;
 ;  Input:
 ;   DGPFPTR - (required) IEN of patient record flag in PRF NATIONAL
 ;             FLAG (#26.15) file or PRF LOCAL FLAG (#26.11) file.
 ;             [ex: "1;DGPF(26.15,"]
 ;
 ; Output:
 ;  Function Value - returns 1 on success, 0 on failure
 ;         DGPFLAG - (required) result array passed by reference. See the
 ;                   $$GETLF and $$GETNF for the result array structure.
 ;
 N RESULT   ;returned function value
 N DGPFIEN  ;ien of PRF local or national flag file
 N DGPFILE  ;file # of PRF local or national flag file
 ;
 S RESULT=0
 ;
 D
 . ;-- quit if pointer is not valid
 . Q:$G(DGPFPTR)']""
 . Q:'$$TESTVAL^DGPFUT(26.13,.02,DGPFPTR)
 . ;
 . ;-- get ien and file from pointer value
 . S DGPFIEN=+$G(DGPFPTR)
 . S DGPFILE=$P($G(DGPFPTR),";",2)
 . ;
 . ;-- if local flag file, get local flag into DGPFLAG array
 . I DGPFILE["26.11" D
 . . Q:'$$GETLF^DGPFALF(+DGPFIEN,.DGPFLAG)
 . . S RESULT=1  ;success
 . ;
 . ;-- if national flag file, get national flag into DGPFLAG array
 . I DGPFILE["26.15" D
 . . Q:'$$GETNF^DGPFANF(+DGPFIEN,.DGPFLAG)
 . . S RESULT=1  ;success
 ;
 Q RESULT
 ;
PARENT(DGCHILD) ;lookup and return the parent of a child
 ;
 ;  Input:
 ;    DGCHILD - pointer to INSTITUTION (#4) file
 ;
 ;  Output:
 ;   Function value - INSTITUTION file pointer^institution name^station# 
 ;                    of parent facility on success; 0 on failure
 ;
 N DGPARENT  ;function value
 N DGPARR    ;return array from XUAF4
 ;
 S DGCHILD=+$G(DGCHILD)
 D PARENT^XUAF4("DGPARR","`"_DGCHILD,"PARENT FACILITY")
 S DGPARENT=+$O(DGPARR("P",0))
 I DGPARENT S DGPARENT=DGPARENT_U_$P(DGPARR("P",DGPARENT),U)_U_$P(DGPARR("P",DGPARENT),U,2)
 Q DGPARENT
 ;
FMTPRNT(DGCHILD) ;lookup and return parent of a child in display format
 ;
 ;  Input:
 ;    DGCHILD - pointer to INSTITUTION (#4) file
 ;
 ;  Output:
 ;   Function value - formatted name of parent institution on success;
 ;                    null on failure
 ;
 N DGPARENT  ;parent facility name
 S DGCHILD=+$G(DGCHILD)
 S DGPARENT=$P($$PARENT(DGCHILD),U,2)
 Q $S(DGPARENT]"":"("_DGPARENT_")",1:"")
 ;
CNTRECS(DGFILE) ;return number of records of a file
 ;
 ;  Input:
 ;    DGFILE - (Required) file number to search
 ;
 ;  Output:
 ;    Function Value - number of records found
 ;
 N DGCNT    ;returned function value
 N DGERR    ;FM error message array
 N DGLIST   ;FM array of record ien's
 ;
 S DGCNT=0
 I $G(DGFILE)]"" D
 . D LIST^DIC(DGFILE,"","@","Q","*","","","","","","DGLIST","DGERR")
 . Q:$D(DGERR)
 . S DGCNT=+$G(DGLIST("DILIST",0))
 Q DGCNT
