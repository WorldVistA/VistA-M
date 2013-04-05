PRCHJS03 ;OI&T/KCL - IFCAP/ECMS INTERFACE RETRIEVE 2237 DATA CONT.;6/12/12
 ;;5.1;IFCAP;**167**;Oct 20, 2000;Build 17
 ;Per VHA Directive 2004-38, this routine should not be modified.
 ;
GET440(PRC440R,PRCWRK,PRCER) ;Get #440 data
 ;This function is used to retrieve specified data
 ;elements from from the VENDOR (#440) file and places
 ;them into ^TMP work global. Data is placed into the
 ;work global in both internal and external format.
 ;
 ;  Input:
 ;    PRC440R - (required) IEN of record in VENDOR (#440) file
 ;     PRCWRK - (required) name of work global containing data elements
 ;
 ; Output:
 ;   Function value - 1 on success, 0 on failure
 ;            PRCER - (optional) on failure, an error message is returned,
 ;                    pass by reference
 ;           PRCWRK - work global containing the #440 data elements:
 ;
 ;          Subscript  Field#  Data Element
 ;          ---------  ------  -------------------
 ;          VEDI       .2      EDI VENDOR?
 ;          VID        .4      VENDOR ID NUMBER
 ;          VACT       5.1     ACCOUNT NO.
 ;          VGDV       5.2     GUARANTEED DELIVERY VENDOR
 ;          VPAYCON    17      PAYMENT CONTACT PERSON
 ;          VPAYPH     17.2    PAYMENT PHONE NO.
 ;          VPAYAD1    17.3    PAYMENT ADDRESS1
 ;          VPAYAD2    17.4    PAYMENT ADDRESS2
 ;          VPAYAD3    17.5    PAYMENT ADDRESS3
 ;          VPAYAD4    17.6    PAYMENT ADDRESS4
 ;          VPAYCTY    17.7    PAYMENT CITY
 ;          VPAYST     17.8    PAYMENT STATE
 ;          VPAYZIP    17.9    PAYMENT ZIP CODE
 ;          VDUNS      18.3    DUN & BRADSTREET #
 ;          VFMSCD     34      FMS VENDOR CODE       
 ;          VFMSNM     34.5    FMS VENDOR NAME
 ;          VALTADD    35      ALT-ADDR-IND
 ;          VFAX       46      FAX #
 ;
 N PRCIENS ;iens string for GETS^DIQ
 N PRCFLDS ;results array for GETS^DIQ
 N PRCERR  ;error msg for GETS^DIQ
 N PRCRSLT ;function result
 ;
 S PRCRSLT=0
 S PRCER="Vendor record not found"
 ;
 I $G(PRC440R)>0,$D(^PRC(440,PRC440R)) D
 . ;
 . ;retrieve fields
 . S PRCIENS=PRC440R_","
 . D GETS^DIQ(440,PRCIENS,"*","IE","PRCFLDS","PRCERR")
 . I $D(PRCERR) S PRCER="Unable to retrieve Vendor record" Q
 . ;
 . ;place top level #440 fields into work global
 . S @PRCWRK@("VEDI")=$G(PRCFLDS(440,PRCIENS,.2,"I"))_U_$G(PRCFLDS(440,PRCIENS,.2,"E"))
 . S @PRCWRK@("VID")=$G(PRCFLDS(440,PRCIENS,.4,"I"))_U_$G(PRCFLDS(440,PRCIENS,.4,"E"))
 . S @PRCWRK@("VACT")=$G(PRCFLDS(440,PRCIENS,5.1,"I"))_U_$G(PRCFLDS(440,PRCIENS,5.1,"E"))
 . S @PRCWRK@("VGDV")=$G(PRCFLDS(440,PRCIENS,5.2,"I"))_U_$G(PRCFLDS(440,PRCIENS,5.2,"E"))
 . S @PRCWRK@("VPAYCON")=$G(PRCFLDS(440,PRCIENS,17,"I"))_U_$G(PRCFLDS(440,PRCIENS,17,"E"))
 . S @PRCWRK@("VPAYPH")=$G(PRCFLDS(440,PRCIENS,17.2,"I"))_U_$G(PRCFLDS(440,PRCIENS,17.2,"E"))
 . S @PRCWRK@("VPAYAD1")=$G(PRCFLDS(440,PRCIENS,17.3,"I"))_U_$G(PRCFLDS(440,PRCIENS,17.3,"E"))
 . S @PRCWRK@("VPAYAD2")=$G(PRCFLDS(440,PRCIENS,17.4,"I"))_U_$G(PRCFLDS(440,PRCIENS,17.4,"E"))
 . S @PRCWRK@("VPAYAD3")=$G(PRCFLDS(440,PRCIENS,17.5,"I"))_U_$G(PRCFLDS(440,PRCIENS,17.5,"E"))
 . S @PRCWRK@("VPAYAD4")=$G(PRCFLDS(440,PRCIENS,17.6,"I"))_U_$G(PRCFLDS(440,PRCIENS,17.6,"E"))
 . S @PRCWRK@("VPAYCTY")=$G(PRCFLDS(440,PRCIENS,17.7,"I"))_U_$G(PRCFLDS(440,PRCIENS,17.7,"E"))
 . S @PRCWRK@("VPAYST")=$G(PRCFLDS(440,PRCIENS,17.8,"I"))_U_$G(PRCFLDS(440,PRCIENS,17.8,"E"))
 . S @PRCWRK@("VPAYZIP")=$G(PRCFLDS(440,PRCIENS,17.9,"I"))_U_$G(PRCFLDS(440,PRCIENS,17.9,"E"))
 . S @PRCWRK@("VDUNS")=$G(PRCFLDS(440,PRCIENS,18.3,"I"))_U_$G(PRCFLDS(440,PRCIENS,18.3,"E"))
 . S @PRCWRK@("VFMSCD")=$G(PRCFLDS(440,PRCIENS,34,"I"))_U_$G(PRCFLDS(440,PRCIENS,34,"E"))
 . S @PRCWRK@("VFMSNM")=$G(PRCFLDS(440,PRCIENS,34.5,"I"))_U_$G(PRCFLDS(440,PRCIENS,34.5,"E"))
 . S @PRCWRK@("VALTADD")=$G(PRCFLDS(440,PRCIENS,35,"I"))_U_$G(PRCFLDS(440,PRCIENS,35,"E"))
 . S @PRCWRK@("VFAX")=$G(PRCFLDS(440,PRCIENS,46,"I"))_U_$G(PRCFLDS(440,PRCIENS,46,"E"))
 . ;
 . ;success
 . S PRCRSLT=1 K PRCER
 ;
 Q PRCRSLT
 ;
 ;
GET443(PRCTRAN,PRCWRK,PRCER) ;Get #443 data
 ;This function is used to retrieve specified data
 ;elements from the REQUEST WORKSHEET (#443) file for
 ;a 2237 Transaction Number and places them into a
 ;^TMP work global. It also obtains the Title of the
 ;Accountable Officer from the NEW PERSON (#200) file.
 ;Data is placed into the work global in both internal
 ;and external format.
 ;
 ; Supported ICR:
 ;   #4329: Allows retrieval of TITLE (#8) field from NEW PERSON (#200)
 ;          file using FM read.
 ;
 ;  Input:
 ;    PRCTRAN - (required) 2237 Transaction Number
 ;     PRCWRK - (required) name of work global containing data elements
 ;
 ;  Output:
 ;   Function value - 1 on success, 0 on failure
 ;            PRCER - (optional) on failure, an error message is returned,
 ;                    pass by ref
 ;           PRCWRK - work global containing the #443 & #200 data elements:
 ;
 ;           Subscript  File,Field#   Data Element
 ;           ---------  -----------   -------------------
 ;           AO         443,2         ACCOUNTABLE OFFICER
 ;           AOESIG     443,4         ESIG DATE/TIME
 ;           EXPEND     443,13        EXPENDABLE/NONEXPENDABLE
 ;           AOTITLE    200,8         TITLE
 ;
 N PRCIENS ;iens string for GETS^DIQ
 N PRCFLDS ;results array for GETS^DIQ
 N PRCERR  ;FM error array
 N PRCREC  ;ien of record in #443 file
 N PRCRSLT ;function result
 ;
 S PRCRSLT=0
 S PRCER="Request Worksheet record not found"
 ;
 ; drops out of DO block on failure
 I $G(PRCTRAN)]"" D
 . ;
 . ;lookup 2237 Transaction Number
 . S PRCREC=$$FIND1^DIC(443,"","X",$G(PRCTRAN),"","","PRCERR")
 . Q:('PRCREC)!($D(PRCERR))
 . ;
 . ;retrieve #443 fields
 . S PRCIENS=+$G(PRCREC)_","
 . D GETS^DIQ(443,PRCIENS,"2;4;13","IE","PRCFLDS","PRCERR")
 . I $D(PRCERR) S PRCER="Unable to retrieve Request Worksheet record" Q
 . ;
 . ;place #443 fields into work global
 . S @PRCWRK@("AO")=$G(PRCFLDS(443,PRCIENS,2,"I"))_U_$G(PRCFLDS(443,PRCIENS,2,"E"))
 . S @PRCWRK@("AOESIG")=$G(PRCFLDS(443,PRCIENS,4,"I"))_U_$G(PRCFLDS(443,PRCIENS,4,"E"))
 . S @PRCWRK@("EXPEND")=$G(PRCFLDS(443,PRCIENS,13,"I"))_U_$G(PRCFLDS(443,PRCIENS,13,"E"))
 . ;
 . ;retrieve Accountable Officer (Title)
 . S PRCIENS=+$G(@PRCWRK@("AO"))_"," ;ptr to #200 file
 . I +$G(PRCIENS) D GETS^DIQ(200,PRCIENS,"8","IE","PRCFLDS","PRCERR")
 . I $D(PRCERR) S PRCER="Unable to retrieve Accountable Officer (Title)" Q
 . S @PRCWRK@("AOTITLE")=$G(PRCFLDS(200,PRCIENS,8,"I"))_U_$G(PRCFLDS(200,PRCIENS,8,"E"))
 . ;
 . ;success
 . S PRCRSLT=1 K PRCER
 ;
 Q PRCRSLT
 ;
 ;
GET445(PRC445R,PRCWRK,PRCER) ;Get GENERIC INVENTORY (#445) data
 ;This function retrieves 2237 data elements from
 ;the GENERIC INVENTORY (#445) file and places them
 ;into a ^TMP work global. Data is placed into the work
 ;global in both internal and external format.
 ;
 ;   Input:
 ;    PRC445R - (required) IEN of record in GENERIC INVENTORY (#445) file
 ;     PRCWRK - (required) name of work global containing data elements
 ;
 ;  Output:
 ;   Function value - 1 on success, 0 on failure
 ;            PRCER - (optional) on failure, an error message is returned,
 ;                    pass by reference
 ;           PRCWRK - work global containing the #445 data elements:
 ;
 ;         Subscript   Field#  Data Element
 ;         ---------   ------  -------------------
 ;          INVPT      .01     INVENTORY POINT
 ;          INVABREV   .8      ABBREVIATED NAME
 ;
 N PRCIENS ;iens string for GETS^DIQ
 N PRCFLDS ;results array for GETS^DIQ
 N PRCERR  ;error array for GETS^DIQ
 N PRCRSLT ;function result
 ;
 S PRCRSLT=0
 S PRCER="Generic Inventory record not found"
 ;
 I $G(PRC445R)>0,$D(^PRCP(445,PRC445R)) D
 . ;
 . ;retrieve data from (#445) file
 . S PRCIENS=PRC445R_","
 . D GETS^DIQ(445,PRCIENS,"*","IE","PRCFLDS","PRCERR")
 . I $D(PRCERR) S PRCER="Unable to retrieve Generic Inventory record" Q
 . ;
 . ;place (#445) fields into work global
 . S @PRCWRK@("INVPT")=$G(PRCFLDS(445,PRCIENS,.01,"I"))_U_$G(PRCFLDS(445,PRCIENS,.01,"E"))
 . S @PRCWRK@("INVABREV")=$G(PRCFLDS(445,PRCIENS,.8,"I"))_U_$G(PRCFLDS(445,PRCIENS,.8,"E"))
 . ;
 . ;success
 . S PRCRSLT=1 K PRCER
 ;
 Q PRCRSLT
