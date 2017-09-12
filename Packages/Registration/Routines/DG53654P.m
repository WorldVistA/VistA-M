DG53654P ;ALB/BAJ - Synchronize the PERIOD OF SERVICE file (#21);09/01/2005
 ;;5.3;Registration;**654**;Aug 13, 1993
 ;
 ; This routine will will update the PERIOD OF SERVICE file (#21).  It modifies
 ; data in specific fields. This routine will neither add nor delete records
 ; from the file
 ;
 ; "B" VALUE         FIELD#      FIELD NAME              FROM                           TO
 ; ---------------------------------------------------------------------------------------------------------------
 ; CHAMPUS           .01         NAME                 CHAMPUS                        TRICARE
 ; CHAMPUS           .02         ABBREVIATION         CHA                            TRI
 ; CHAMPUS            20         BRIEF DESCRIPTION    CHAMPUS PTS AT VA FACILITY     TRICARE PTS AT VA FACILITY
 ; PERSIAN GULF WAR   20         BRIEF DESCRIPTION    PERSUAN GULF WAR VETERAN       (On or after 8/2/1990)
 ; POST-VIETNAM      .05         END DATE             <blank>                        8/1/1990
 ; POST-VIETNAM       20         BRIEF DESCRIPTION    (On or after 5/8/75)           (5/8/75 - 8/1/1990)
 ; PRE-KOREAN         20         BRIEF DESCRIPTION    (Peacetime before 6/27/50)     Peacetime before 6/27/1950
 ; KOREAN             20         BRIEF DESCRIPTION    (6/27/50-1/31/55)              (6/27/1950-1/31/1955)
 ; MERCHANT MARINE    20         BRIEF DESCRIPTION    (12/41-8/15/45)                (12/1941-8/15/1945)
 ; POST-KOREAN        20         BRIEF DESCRIPTION    (2/1/55-2/27/61)               (2/1/1955-2/27/1961)
 ; VIETNAM ERA        20         BRIEF DESCRIPTION    (2/28/61-5/7/75)               (2/28/1961-5/7/1975)
 ; WORLD WAR I        20         BRIEF DESCRIPTION    (4/6/17-11/11/18)              (4/6/1917-11/11/1918)
 ; WORLD WAR II       20         BRIEF DESCRIPTION    (12/7/41-12/31/46)             (12/7/1941-12/31/1946)
 ; 
 ;
 Q
EN ; Driver - Initialize variables and populate file
 ;
 ; Populate file using API UPD^DGENDBS
 ;       UPD^DGENDBS takes the following parameters:
 ;   FILE - File or sub-file number
 ;   DGENDA - New name for traditional DA array, with same meaning.
 ;            Pass by reference.
 ;   DATA - Data array to file (pass by reference)
 ;          Format: DATA(<field #>)=<value>
 ; 
 ; Additional variables
 ; MSGARR - array to manage data sent to message APIs
 ; XDATA  - array to manage data sent to DGENDBS API
 ;  
 N MSGARR,XDATA
 ; log start of install
 D BMES^XPDUTL(">>>Installing DG*5.3*654...")
 K ^TMP($J)
 ; 
 ; populate work arrays
 D SETUP
 ;
 ; call API to update records
 D UPDATE
 ;
 ; notify user if errors encountered
 I $D(^TMP($J,"ERRORS")) D
 . D BMES^XPDUTL("Errors encountered... Job # "_$J)
 . D MES^XPDUTL(" Please contact the CIO Field Office for assistance")
 . D MES^XPDUTL(" and record the Job number (above) for reference.")
 ;
 D BMES^XPDUTL(">>>Install of DG*5.3*654 complete")
 Q
 ;
UPDATE ; update records
 N DATA,DGENDA,ERR,FILE,POS
 ; period of service file is 21
 S FILE=21,(POS,ERR)=""
 F  S POS=$O(XDATA(POS)) Q:POS=""  D
 . D MES^XPDUTL("Updating "_MSGARR(POS))
 . M DATA=XDATA(POS)
 . I '$$UPD^DGENDBS(FILE,.POS,.DATA,.ERR) D
 . . ;S ^TMP($J,"ERRORS",POS)=ERR_"^"_MSGARR(POS)_"^"_$H
 . . D MES^XPDUTL("Error in filing "_MSGARR(POS)_" values")
 . . S ERR=""
 . K DATA
 Q
 ;
SETUP ; setup message and data arrays
 ; PBNAME        = Data Index pointer in "B" x-ref
 ; POS           = Data Index (D0 value)
 ; PFNUM         = Field number
 ; PBDATA        = New data to change/insert (per table in DATA tag)
 ; 
 ; Arrays created
 ; MSGARR array contains a pointer to the index record
 ; MSGARR(POS) = PBNAME
 ;       
 ; XDATA array contains the items to change
 ; XDATA(POS,PFNUM) = PDATA
 ; 
 ;
 N POS,PBNAME,PFNUM,PDATA,X,K
 F K=1:1 S X=$P($T(DATA+K),";;",2) Q:X=""  D             ;assemble pointers and data strings
 . S PBNAME=$P(X,"^",1)
 . S POS=$$LOOKUP(PBNAME) I POS="ERROR" D  Q
 . . ;S ^TMP($J,"ERRORS")="NO SUCH RECORD^"_PBNAME_"^"_$H
 . . D MES^XPDUTL("Error in filing "_PBNAME_" values")
 . S PFNUM=$P(X,"^",2)
 . S PDATA=$P(X,"^",3)
 . S MSGARR(POS)=PBNAME
 . S XDATA(POS,PFNUM)=PDATA
 ;
 Q
 ;
LOOKUP(PBNAME) ; Return IEN for POS File #21, using the "B" x-ref
 N RETVAL
 S RETVAL=$O(^DIC(21,"B",PBNAME,""))
 I 'RETVAL Q "ERROR"
 Q RETVAL
 ;
DATA ; POS values to lookup *** Data table, DO NOT ADJUST ***
 ;;CHAMPUS^.01^TRICARE
 ;;CHAMPUS^.02^TRI
 ;;CHAMPUS^20^TRICARE PTS AT VA FACILITY
 ;;KOREAN^20^(6/27/1950-1/31/1955)
 ;;MERCHANT MARINE^20^(12/7/1941-8/15/1945)
 ;;PERSIAN GULF WAR^20^(On or after 8/2/1990)
 ;;POST-VIETNAM^.05^2900801
 ;;POST-VIETNAM^20^(5/8/1975-8/1/1990)
 ;;POST-KOREAN^20^(2/1/1955-2/27/1961)
 ;;PRE-KOREAN^20^Peacetime before 6/27/1950
 ;;VIETNAM ERA^20^(2/28/1961-5/7/1975)
 ;;WORLD WAR I^20^(4/6/1917-11/11/1918)
 ;;WORLD WAR II^20^(12/7/1941-12/31/1946)
 ;;
 Q
 ;
