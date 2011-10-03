BPSSCRCU ;BHAM ISC/SS - ECME SCREEN CONTINUOUS UPDATE AND CHANGE VIEW ;05-APR-05
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5,7**;JUN 2004;Build 46
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
CU ;
 N BPKEY,BPTIME,X,Y
 S BPTIME=15 ;update every 15 seconds
 D RE^VALM4
 W "Press ""Q"" to quit."
 F  D  S BPKEY=$$READ^XGF(1,BPTIME) Q:(BPKEY="Q")!(BPKEY="q")
 . D UD^BPSSCRUD
 . D RE^VALM4
 . N %
 . D NOW^%DTC S Y=% X ^DD("DD")
 . W "The screen has been updated on "_Y_". Press ""Q"" to quit."
 Q
 ;
 ; Select Insurance using IB API - IA 4721
 ; Input:  BPARR passed by ref to store user selection
 ;         BPDUZ - User DUZ
 ; Output: RETV = -1 if timeout or user enters "^"
 ;         BPARR(1.11)="I" for individual insurance or "A" for all
 ;         BPARR("INS")=semi-colon list of IENs from file 36 if individual insurances selected
 ; Example output: BPARR(1.11)="I" BPARR("INS")=";7;499;200;"
INSURSEL(BPARR,BPDUZ) ;
 N RETV,BPQ,BPINP,BPINSARR,Y,BPCNT
 S (BPARR(1.11),BPARR(2.04),BPARR("INS"))=""
 S (BPINS,BPCNT)=0
 S RETV=$$EDITFLD^BPSSCRCV(1.11,+BPDUZ,"S^I:SPECIFIC INSURANCE(S);A:ALL","Select Certain (I)NSURANCE or (A)LL)","ALL",.BPARR)
 ; Quit if timeout or ^ entered
 Q:RETV<0 +RETV
 ; Quit if ALL selected
 Q:$P(RETV,U,2)="A" +RETV
 ; Get selected insurances from parameters and display them
 I $$GETINS(BPDUZ,.BPINSARR) D DISPINS(.BPINSARR)
 ; Select specific Insurances to add to BPARR("INS") array
 S BPQ=0 F  D  Q:BPQ'=0
 . S BPINP=$$SELINSUR^IBNCPDPI("Select INSURANCE","")
 . S:+BPINP=-1 BPQ=-1 I BPQ'=0 Q
 . ;
 . ; Handle deletes
 . I $D(BPINSARR(+BPINP)) D  Q
 . . W !
 . . S Y=$$PROMPT^BPSSCRCV("S^Y:YES;N:NO","Delete "_$P(BPINP,U,2)_" from your list?","NO")
 . . I Y="Y" K BPINSARR(+BPINP),BPINSARR("B",$P(BPINP,U,2),+BPINP)
 . . ; Display a list of selected Insurance Companies
 . . D DISPINS(.BPINSARR)
 . ; Save selection in Insurance Company array
 . S BPINSARR(+BPINP)=BPINP,BPINSARR("B",$P(BPINP,U,2),+BPINP)=""
 . ; Display a list of selected Insurance Companies
 . D DISPINS(.BPINSARR)
 ; Save selected Insurances in BPARR("INS") to be saved in instance 1.14 when filed.
 S BPARR("INS")=""
 F BPCNT=1:1 S BPINS=$O(BPINSARR(BPINS)) Q:+BPINS=0  D
 . S BPARR("INS")=$G(BPARR("INS"))_";"_BPINS
 S (BPARR("INS"),BPARR(2.04))=$G(BPARR("INS"))_";"
 Q +RETV
 ;
 ;Reads insurance selection from the USER PROFILE file
 ;Input: BPDUZ7 - DUZ
 ;       BPINSUR by ref - array to return insurances saved in 2.04 Parameter : BPINSUR(IEN of file 36)
 ;Return value:
 ; 0 nothing saved
 ; n number of IENs of #36 selected by the user and stored in BPINSUR
 ;Returned by reference:
 ; BPINSUR - array with IENs to file #36
GETINS(BPDUZ7,BPINSUR) ;
 N BPINS,BPCNT
 S BPARRAY("INS")=$$GETPARAM^BPSSCRSL("2.04",BPDUZ7)
 F BPCNT=1:1:20 S BPINS=$P($G(BPARRAY("INS")),";",BPCNT+1) Q:+BPINS=0  D
 . S BPINSUR(BPINS)=BPINS,BPINSUR("B",$$INSNM^IBNCPDPI(BPINS),BPINS)=""
 Q BPCNT-1
 ;
 ;Display selected Insurances
 ;Input: BPINSARR = Array of insurances to display
 ; BPINSARR("B",INSURANCE COMPANY NAME)
DISPINS(BPINSARR) ;
 I $D(BPINSARR)>9 D
 . N X
 . W !,?2,"Selected:"
 . S X="" F  S X=$O(BPINSARR("B",X)) Q:X=""  W ?12,X,!
 . K X
 Q
 ;
 ;Check if PLAN ID for selected BP59 matches selected insurances
 ;Input: BPPLAN = Insurance company IEN from PLAN ID field in BPS TRANSACTION file
 ;       BPINS = Semi-colon separated list of insurances selected by the user.
 ;               See INSURSEL
 ;Output: 1 = Yes a match was found
 ;        0 = No match found
CHKINS(BPPLAN,BPINS) ;
 N BPIN,BPRETV
 S BPRETV=0
 F I=2:1 S BPIN=$P($G(BPINS),";",I) Q:BPIN=""  D  Q:BPRETV
 . S BPRETV=$S(BPIN=BPPLAN:1,1:0)
 Q BPRETV
 ;
