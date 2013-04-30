PRCHJS02 ;OI&T/KCL - IFCAP/ECMS INTERFACE RETRIEVE 2237 DATA;6/12/12
 ;;5.1;IFCAP;**167**;Oct 20, 2000;Build 17
 ;Per VHA Directive 2004-38, this routine should not be modified.
 ;
GET410(PRC410R,PRCWRK,PRCER) ;Get CONTROL POINT ACTIVITY (#410) data
 ;This function retrieves 2237 data elements from the CONTROL POINT
 ;ACTIVITY (#410) file and places them into a ^TMP work global. Data
 ;is placed into the work global in both internal and external format.
 ;
 ;   Input:
 ;    PRC410R - (required) IEN of record in CONTROL POINT ACTIVITY (#410) file
 ;     PRCWRK - (required) name of work global containing data elements
 ;
 ;  Output:
 ;   Function value - 1 on success, 0 on failure
 ;            PRCER - (optional) on failure, an error message is returned,
 ;                    pass by reference
 ;           PRCWRK - work global containing the #410 data elements:
 ;
 ;         Subscript    Field#  Data Element
 ;         ---------    ------  -------------------
 ;          TRANUM      .01     TRANSACTION NUMBER
 ;          STANUM      .5      STATION NUMBER
 ;          FRMTYP      3       FORM TYPE
 ;          INVDIS      4       INVENTORY DISTRIBUTION POINT
 ;          RQSTDT      5       DATE OF REQUEST
 ;          RQSRV       6.3     REQUESTING SERVICE
 ;          DTREQ       7       DATE REQUIRED
 ;          PRI         7.5     PRIORITY OF REQUEST
 ;          REMARKS     9       SPECIAL REMARKS
 ;          VENDNM      11      VENDOR
 ;          VENDAD1     11.1    VENDOR ADDRESS1
 ;          VENDAD2     11.2    VENDOR ADDRESS2
 ;          VENDAD3     11.3    VENDOR ADDRESS3
 ;          VENDAD4     11.4    VENDOR ADDRESS4
 ;          VENDCTY     11.5    VENDOR CITY
 ;          VENDST      11.6    VENDOR STATE
 ;          VENDZIP     11.7    VENDOR ZIP
 ;          VENDCON     11.8    VENDOR CONTACT
 ;          VENDPH      11.9    VENDOR PHONE NUMBER
 ;          VENDPT      12      VENDOR POINTER
 ;          CTRLPT      15      CONTROL POINT
 ;          COSTCTR     15.5    COST CENTER
 ;          COMMIT      20      COMMITTED (ESTIMATED) COST
 ;          COMMITDT    21      DATE COMMITTED
 ;          TRANSAMT    27      TRANSACTION $ AMOUNT
 ;          ACTDATA     28      ACCOUNTING DATA
 ;          FCPPRJ      28.1    FCP/PRJ
 ;          BBFY        28.5    BBFY
 ;          REQ         40      REQUESTOR
 ;          REQTITLE    41      REQUESTOR TITLE
 ;          APOF        42      APPROVING OFFICIAL
 ;          APOFTIT     43      APPROVING OFFICIAL TITLE
 ;          ESIGDT      44.6    ES CODE DATE/TIME
 ;          JUSTIF      45      JUSTIFICATION
 ;          DELIVTO     46      DELIVER TO/LOCATION
 ;          ESTSHIP     48.1    EST. SHIPPING
 ;          COMMENT     60      COMMENTS
 ;          SUBSTA      448     SUBSTATION
 ;
 N PRCIENS ;iens string for GETS^DIQ
 N PRCFLDS ;results array for GETS^DIQ
 N PRCERR  ;error array for GETS^DIQ
 N PRCRSLT ;function result
 ;
 S PRCRSLT=0
 S PRCER="Control Point Activity record not found"
 ;
 I $G(PRC410R)>0,$D(^PRCS(410,PRC410R)) D
 . ;retrieve data from #410 top level fields
 . S PRCIENS=PRC410R_","
 . D GETS^DIQ(410,PRCIENS,"*","IE","PRCFLDS","PRCERR")
 . I $D(PRCERR) S PRCER="Unable to retrieve Control Point Activity record" Q
 . ;
 . ;place top level (#410) fields into work global
 . S @PRCWRK@("TRANUM")=$G(PRCFLDS(410,PRCIENS,.01,"I"))_U_$G(PRCFLDS(410,PRCIENS,.01,"E"))
 . S @PRCWRK@("STANUM")=$G(PRCFLDS(410,PRCIENS,.5,"I"))_U_$G(PRCFLDS(410,PRCIENS,.5,"E"))
 . S @PRCWRK@("FRMTYP")=$G(PRCFLDS(410,PRCIENS,3,"I"))_U_$G(PRCFLDS(410,PRCIENS,3,"E"))
 . S @PRCWRK@("INVDIS")=$G(PRCFLDS(410,PRCIENS,4,"I"))_U_$G(PRCFLDS(410,PRCIENS,4,"E"))
 . S @PRCWRK@("RQSTDT")=$G(PRCFLDS(410,PRCIENS,5,"I"))_U_$G(PRCFLDS(410,PRCIENS,5,"E"))
 . S @PRCWRK@("RQSRV")=$G(PRCFLDS(410,PRCIENS,6.3,"I"))_U_$G(PRCFLDS(410,PRCIENS,6.3,"E"))
 . S @PRCWRK@("DTREQ")=$G(PRCFLDS(410,PRCIENS,7,"I"))_U_$G(PRCFLDS(410,PRCIENS,7,"E"))
 . S @PRCWRK@("PRI")=$G(PRCFLDS(410,PRCIENS,7.5,"I"))_U_$G(PRCFLDS(410,PRCIENS,7.5,"E"))
 . S @PRCWRK@("VENDNM")=$G(PRCFLDS(410,PRCIENS,11,"I"))_U_$G(PRCFLDS(410,PRCIENS,11,"E"))
 . S @PRCWRK@("VENDAD1")=$G(PRCFLDS(410,PRCIENS,11.1,"I"))_U_$G(PRCFLDS(410,PRCIENS,11.1,"E"))
 . S @PRCWRK@("VENDAD2")=$G(PRCFLDS(410,PRCIENS,11.2,"I"))_U_$G(PRCFLDS(410,PRCIENS,11.2,"E"))
 . S @PRCWRK@("VENDAD3")=$G(PRCFLDS(410,PRCIENS,11.3,"I"))_U_$G(PRCFLDS(410,PRCIENS,11.3,"E"))
 . S @PRCWRK@("VENDAD4")=$G(PRCFLDS(410,PRCIENS,11.4,"I"))_U_$G(PRCFLDS(410,PRCIENS,11.4,"E"))
 . S @PRCWRK@("VENDCTY")=$G(PRCFLDS(410,PRCIENS,11.5,"I"))_U_$G(PRCFLDS(410,PRCIENS,11.5,"E"))
 . S @PRCWRK@("VENDST")=$G(PRCFLDS(410,PRCIENS,11.6,"I"))_U_$G(PRCFLDS(410,PRCIENS,11.6,"E"))
 . S @PRCWRK@("VENDZIP")=$G(PRCFLDS(410,PRCIENS,11.7,"I"))_U_$G(PRCFLDS(410,PRCIENS,11.7,"E"))
 . S @PRCWRK@("VENDCON")=$G(PRCFLDS(410,PRCIENS,11.8,"I"))_U_$G(PRCFLDS(410,PRCIENS,11.8,"E"))
 . S @PRCWRK@("VENDPH")=$G(PRCFLDS(410,PRCIENS,11.9,"I"))_U_$G(PRCFLDS(410,PRCIENS,11.9,"E"))
 . S @PRCWRK@("VENDPT")=$G(PRCFLDS(410,PRCIENS,12,"I"))_U_$G(PRCFLDS(410,PRCIENS,12,"E"))
 . S @PRCWRK@("CTRLPT")=$G(PRCFLDS(410,PRCIENS,15,"I"))_U_$G(PRCFLDS(410,PRCIENS,15,"E"))
 . S @PRCWRK@("COSTCTR")=$G(PRCFLDS(410,PRCIENS,15.5,"I"))_U_$G(PRCFLDS(410,PRCIENS,15.5,"E"))
 . S @PRCWRK@("COMMIT")=$G(PRCFLDS(410,PRCIENS,20,"I"))_U_$G(PRCFLDS(410,PRCIENS,20,"E"))
 . S @PRCWRK@("COMMITDT")=$G(PRCFLDS(410,PRCIENS,21,"I"))_U_$G(PRCFLDS(410,PRCIENS,21,"E"))
 . S @PRCWRK@("TRANSAMT")=$G(PRCFLDS(410,PRCIENS,27,"I"))_U_$G(PRCFLDS(410,PRCIENS,27,"E"))
 . S @PRCWRK@("ACTDATA")=$G(PRCFLDS(410,PRCIENS,28,"I"))_U_$G(PRCFLDS(410,PRCIENS,28,"E"))
 . S @PRCWRK@("FCPPRJ")=$G(PRCFLDS(410,PRCIENS,28.1,"I"))_U_$G(PRCFLDS(410,PRCIENS,28.1,"E"))
 . S @PRCWRK@("BBFY")=$G(PRCFLDS(410,PRCIENS,28.5,"I"))_U_$G(PRCFLDS(410,PRCIENS,28.5,"E"))
 . S @PRCWRK@("REQ")=$G(PRCFLDS(410,PRCIENS,40,"I"))_U_$G(PRCFLDS(410,PRCIENS,40,"E"))
 . S @PRCWRK@("REQTITLE")=$G(PRCFLDS(410,PRCIENS,41,"I"))_U_$G(PRCFLDS(410,PRCIENS,41,"E"))
 . S @PRCWRK@("APOF")=$G(PRCFLDS(410,PRCIENS,42,"I"))_U_$G(PRCFLDS(410,PRCIENS,42,"E"))
 . S @PRCWRK@("APOFTIT")=$G(PRCFLDS(410,PRCIENS,43,"I"))_U_$G(PRCFLDS(410,PRCIENS,43,"E"))
 . S @PRCWRK@("ESIGDT")=$G(PRCFLDS(410,PRCIENS,44.6,"I"))_U_$G(PRCFLDS(410,PRCIENS,44.6,"E"))
 . S @PRCWRK@("DELIVTO")=$G(PRCFLDS(410,PRCIENS,46,"I"))_U_$G(PRCFLDS(410,PRCIENS,46,"E"))
 . S @PRCWRK@("ESTSHIP")=$G(PRCFLDS(410,PRCIENS,48.1,"I"))_U_$G(PRCFLDS(410,PRCIENS,48.1,"E"))
 . S @PRCWRK@("SUBSTA")=$G(PRCFLDS(410,PRCIENS,448,"I"))_U_$G(PRCFLDS(410,PRCIENS,448,"E"))
 . ;
 . ;retrieve Special Remarks WP field and place into work global
 . D FORMTXT($G(PRC410R),PRCWRK,"REMARKS","RM")
 . ;
 . ;retrieve Justification WP field and place into work global
 . D FORMTXT($G(PRC410R),PRCWRK,"JUSTIF",8)
 . ;
 . ;retrieve Comments WP field and place into work global
 . D FORMTXT($G(PRC410R),PRCWRK,"COMMENT","CO")
 . ;
 . ;success
 . S PRCRSLT=1 K PRCER
 ;
 Q PRCRSLT
 ;
 ;
FORMTXT(PRC410R,PRCWRK,PRCSUB,PRCNODE,PRCWL,PRCWR) ;Format WP Text Utility
 ;This procedure is used to format Word Processing fields
 ;retrieved from the CONTROL POINT ACTIVITY (#410) file and
 ;place them into the ^TMP work global containing 2237 data elements.
 ;
 ;  Input:
 ;    PRC410R - (required) IEN of record in CONTROL POINT ACTIVITY (#410) file
 ;     PRCWRK - (required) name of work global containing 2237 data elements
 ;     PRCSUB - (required) work global subscript where text will be placed
 ;    PRCNODE - (required) node where WP fields reside in (#410) file
 ;      PRCWL - (optional) left margin for WP text, default=1
 ;      PRCWR - (optional) right margin for WP text, default=200
 ;
 ; Output: None
 ;
 N X    ;string of text to be added as input to the formatter
 N DIWL ;left margin for text
 N DIWR ;right margin for text
 N DIWF ;string of format control parameters
 N PRCI ;WP nodes subscript
 ;
 ;input params for ^DIWP
 S DIWL=$S($G(PRCWL)>0:PRCWL,1:1)
 S DIWR=$S($G(PRCWR)>0:PRCWR,1:200)
 S (DIWF,X)=""
 K ^UTILITY($J,"W") ;must kill before calling ^DIWP
 ;
 ;retrieve WP text and place formatted text into ^UTILITY($J,"W")
 S PRCI=0
 F  S PRCI=$O(^PRCS(410,$G(PRC410R),PRCNODE,PRCI)) Q:PRCI=""  D
 . S X=$G(^PRCS(410,$G(PRC410R),PRCNODE,PRCI,0))
 . D ^DIWP
 ;
 ;merge formatted text into work global
 I $D(^UTILITY($J,"W")) M @PRCWRK@(PRCSUB)=^UTILITY($J,"W",1)
 ;
 ;cleanup
 K ^UTILITY($J,"W")
 Q
 ;
 ;
GETITEMS(PRC410R,PRCWRK,PRCER) ;Get 2237 line items
 ;This function retrieves 2237 line item data elements
 ;and places them into a ^TMP work global. Data is placed
 ;into the work global in both internal and external format.
 ;
 ;  Input:
 ;   PRC410R - (required) IEN of record in CONTROL POINT ACTIVITY (#410) file
 ;    PRCWRK - (required) name of work global containing data elements
 ;
 ; Output:
 ;  Function value - 1 on success, 0 on failure
 ;           PRCER - (optional) on failure, an error message is returned,
 ;                    pass by reference
 ;          PRCWRK - work global containing the line item data elements:
 ;
 ;         Subscript                     Field#   Data Element
 ;         ---------                     ------   -------------------
 ;        ITEM (#410.02) multiple:
 ;          line_item#,ITLINE             .01    LINE ITEM NUMBER
 ;          line_item#,ITDESC             1      DESCRIPTION
 ;          line_item#,ITQTY              2      QUANTITY
 ;          line_item#,ITUOP              3      UNIT OF PURCHASE
 ;          line_item#,ITBOC              4      BOC
 ;          line_item#,ITMFN              5      ITEM MASTER FILE NO.
 ;          line_item#,ITSTOCK            6      STOCK NUMBER
 ;          line_item#,ITCOST             7      EST. ITEM (UNIT) COST
 ;          line_item#,ITDMID             17     DM DOC ID
 ;
 ;       DELIVERY SCHEDULE (#410.6) file: 
 ;        (Note: An item may have multiple delivery schedules)
 ;          line_item#,delivery_schedule#,DELREF  .01  REFERENCE 
 ;          line_item#,delivery_schedule#,DELDT   1    DELIVERY DATE
 ;          line_item#,delivery_schedule#,DELLOC  2    LOCATION
 ;          line_item#,delivery_schedule#,DELQTY  3    QTY TO BE DELIVERED
 ;
 ;       UNIT OF ISSUE (#420.5):
 ;          line_item#,UNITNM            .01   NAME
 ;          line_item#,UNITFNM           1     FULL NAME
 ;
 ;       ITEM MASTER (#441) file:
 ;          line_item#,IMNSN             5     NSN
 ;          line_item#,IMFSC             2     FSC
 ;          line_item#,IMMFG             19    MFG PART NO.
 ;          line_item#,IMFOOD            20    FOOD GROUP
 ;          line_item#,IMNIF             51    NIF ITEM NUMBER
 ;
 ;       VENDOR (#441.01) multiple:
 ;          line_item#,IMPKGM            1.6   PACKAGING MULTIPLE
 ;          line_item#,IMCTRCT           2     CONTRACT
 ;          line_item#,IMEXPDT           2.2   CONTRACT EXP. DATE
 ;          line_item#,IMNDC             4     NDC
 ;          line_item#,IMMIN             8     MINIMUM ORDER QTY
 ;          line_item#,IMMAX             8.5   MAXIMUM ORDER QTY  
 ;          line_item#,IMREQ             9     REQUIRED ORDER MULTIPLE
 ;          line_item#,IMUCF             10    UNIT CONVERSION FACTOR
 ;
 N PRCIENS,PRC4106,PRC4205,PRC441 ;iens string for GETS^DIQ
 N PRCFLDS,PRCDS,PRCUNIT,PRCIMF   ;results array for GETS^DIQ
 N PRCERR   ;error array for GETS^DIQ
 N PRCLINE  ;line item #
 N PRCITIEN ;ien of record in Item subfile
 N PRCI     ;item Description node subscript
 N PRCITM   ;item multiple subscript
 N PRCSUB1,PRCSUB2 ;file #410 global subscripts
 N PRCRSLT  ;function result
 ;
 S PRCRSLT=0
 S PRCER="Control Point Activity record not found"
 ;
 I $G(PRC410R)'>0 Q PRCRSLT
 I '$D(^PRCS(410,PRC410R)) Q PRCRSLT
 ;
 ;retrieve all fields and records in #410.02,10 multiple and place in ^TMP global
 S PRCIENS=PRC410R_","
 S PRCFLDS=$NA(^TMP("PRCHJITEM",$J)) K @PRCFLDS
 D GETS^DIQ(410,PRCIENS,"10*","IE",PRCFLDS,"PRCERR")
 I $D(PRCERR) S PRCER="Unable to retrieve line item data" Q PRCRSLT
 ;
 ;place line item fields into work global
 S PRCITM=""
 F  S PRCITM=$O(@PRCFLDS@(410.02,PRCITM)) Q:PRCITM=""  D
 . S PRCLINE=+$G(@PRCFLDS@(410.02,PRCITM,.01,"I"))
 . S @PRCWRK@(PRCLINE,"ITLINE")=$G(@PRCFLDS@(410.02,PRCITM,.01,"I"))_U_$G(@PRCFLDS@(410.02,PRCITM,.01,"E"))
 . S @PRCWRK@(PRCLINE,"ITQTY")=$G(@PRCFLDS@(410.02,PRCITM,2,"I"))_U_$G(@PRCFLDS@(410.02,PRCITM,2,"E"))
 . S @PRCWRK@(PRCLINE,"ITUOP")=$G(@PRCFLDS@(410.02,PRCITM,3,"I"))_U_$G(@PRCFLDS@(410.02,PRCITM,3,"E"))
 . S @PRCWRK@(PRCLINE,"ITBOC")=$G(@PRCFLDS@(410.02,PRCITM,4,"I"))_U_$G(@PRCFLDS@(410.02,PRCITM,4,"E"))
 . S @PRCWRK@(PRCLINE,"ITMFN")=$G(@PRCFLDS@(410.02,PRCITM,5,"I"))_U_$G(@PRCFLDS@(410.02,PRCITM,5,"E"))
 . S @PRCWRK@(PRCLINE,"ITSTOCK")=$G(@PRCFLDS@(410.02,PRCITM,6,"I"))_U_$G(@PRCFLDS@(410.02,PRCITM,6,"E"))
 . S @PRCWRK@(PRCLINE,"ITCOST")=$G(@PRCFLDS@(410.02,PRCITM,7,"I"))_U_$G(@PRCFLDS@(410.02,PRCITM,7,"E"))
 . S @PRCWRK@(PRCLINE,"ITDMID")=$G(@PRCFLDS@(410.02,PRCITM,17,"I"))_U_$G(@PRCFLDS@(410.02,PRCITM,17,"E"))
 . ;
 . ;resolve Line Item Number to Item entry's ien
 . S PRCITIEN=+$O(^PRCS(410,PRC410R,"IT","B",PRCLINE,0))
 . ;
 . ;place Item Description WP field into work global
 . N DIWL,DIWR,DIWF,X ;^DIWP input params
 . S DIWL=1,DIWR=200,DIWF="",PRCI=0
 . K ^UTILITY($J,"W") ;must kill before calling ^DIWP
 . ;loop thru Item Description nodes and place formatted text into ^UTILITY($J,"W")
 . F  S PRCI=$O(^PRCS(410,$G(PRC410R),"IT",PRCITIEN,1,PRCI)) Q:PRCI=""  D
 . . S X=$G(^PRCS(410,$G(PRC410R),"IT",PRCITIEN,1,PRCI,0)) D ^DIWP
 . ;merge formatted text into work global
 . I $D(^UTILITY($J,"W")) M @PRCWRK@(PRCLINE,"ITDESC")=^UTILITY($J,"W",1)
 . ;
 . ;for each item, place DELIVERY SCHEDULE (#410.6) fields into work global
 . S (PRCSUB1,PRCSUB2)=""
 . F  S PRCSUB1=$O(^PRCS(410,PRC410R,"IT",+PRCITM,2,"B",PRCSUB1)) Q:PRCSUB1=""  D
 . . S PRCSUB2=$O(^PRCS(410,PRC410R,"IT",+PRCITM,2,"B",PRCSUB1,PRCSUB2))
 . . Q:$G(PRCSUB2)'>0
 . . S PRC4106=$P($G(^PRCS(410,+$G(PRC410R),"IT",+PRCITM,2,PRCSUB2,0)),U,2)_"," ;ptr to #410.6
 . . K PRCDS
 . . I +PRC4106>0 D GETS^DIQ(410.6,PRC4106,"*","IE","PRCDS","PRCERR")
 . . Q:$D(PRCERR)
 . . S @PRCWRK@(PRCLINE,PRCSUB1,"DELREF")=$G(PRCDS(410.6,PRC4106,.01,"I"))_U_$G(PRCDS(410.6,PRC4106,.01,"E"))
 . . S @PRCWRK@(PRCLINE,PRCSUB1,"DELDT")=$G(PRCDS(410.6,PRC4106,1,"I"))_U_$G(PRCDS(410.6,PRC4106,1,"E"))
 . . S @PRCWRK@(PRCLINE,PRCSUB1,"DELLOC")=$G(PRCDS(410.6,PRC4106,2,"I"))_U_$G(PRCDS(410.6,PRC4106,2,"E"))
 . . S @PRCWRK@(PRCLINE,PRCSUB1,"DELQTY")=$G(PRCDS(410.6,PRC4106,3,"I"))_U_$G(PRCDS(410.6,PRC4106,3,"E"))
 . ;
 . ;quit if error encountered
 . Q:$D(PRCERR)
 . ;
 . ;for each item, place UNIT OF ISSUE (#420.5) fields into work global
 . S PRC4205=+$G(@PRCWRK@(PRCLINE,"ITUOP"))_","
 . K PRCUNIT
 . I +PRC4205>0 D GETS^DIQ(420.5,PRC4205,"*","IE","PRCUNIT","PRCERR")
 . I $D(PRCERR) S PRCER="Unable to retrieve Unit Of Issue record" Q
 . S @PRCWRK@(PRCLINE,"UNITNM")=$G(PRCUNIT(420.5,PRC4205,.01,"I"))_U_$G(PRCUNIT(420.5,PRC4205,.01,"E"))
 . S @PRCWRK@(PRCLINE,"UNITFNM")=$G(PRCUNIT(420.5,PRC4205,1,"I"))_U_$G(PRCUNIT(420.5,PRC4205,1,"E"))
 . ;
 . ;for each item, place ITEM MASTER (#441) fields into work global
 . S PRC441=+$G(@PRCWRK@(PRCLINE,"ITMFN"))_","
 . K PRCIMF
 . I +PRC441>0 D GETS^DIQ(441,PRC441,"**","IE","PRCIMF","PRCERR")
 . I $D(PRCERR) S PRCER="Unable to retrieve Item Master record" Q
 . S @PRCWRK@(PRCLINE,"IMFSC")=$G(PRCIMF(441,PRC441,2,"I"))_U_$G(PRCIMF(441,PRC441,2,"E"))
 . S @PRCWRK@(PRCLINE,"IMNSN")=$G(PRCIMF(441,PRC441,5,"I"))_U_$G(PRCIMF(441,PRC441,5,"E"))
 . S @PRCWRK@(PRCLINE,"IMMFG")=$G(PRCIMF(441,PRC441,19,"I"))_U_$G(PRCIMF(441,PRC441,19,"E"))
 . S @PRCWRK@(PRCLINE,"IMFOOD")=$G(PRCIMF(441,PRC441,20,"I"))_U_$G(PRCIMF(441,PRC441,20,"E"))
 . S @PRCWRK@(PRCLINE,"IMNIF")=$G(PRCIMF(441,PRC441,51,"I"))_U_$G(PRCIMF(441,PRC441,51,"E"))
 . ;
 . ;use Vendor ptr (#12) field of (#410) file to obtain the associated
 . ;VENDOR (#441.01) sub-file record and place field into work global
 . S PRC441=$$GET1^DIQ(410,PRC410R_",",12,"I")_","_PRC441
 . S @PRCWRK@(PRCLINE,"IMPKGM")=$G(PRCIMF(441.01,PRC441,1.6,"I"))_U_$G(PRCIMF(441.01,PRC441,1.6,"E"))
 . S @PRCWRK@(PRCLINE,"IMCTRCT")=$G(PRCIMF(441.01,PRC441,2,"I"))_U_$G(PRCIMF(441.01,PRC441,2,"E"))
 . S @PRCWRK@(PRCLINE,"IMEXPDT")=$G(PRCIMF(441.01,PRC441,2.2,"I"))_U_$G(PRCIMF(441.01,PRC441,2.2,"E"))
 . ;need to convert computed field CONTRACT EXP. DATE to internal FM date format
 . I $P(@PRCWRK@(PRCLINE,"IMEXPDT"),U)]"" D
 . . N X,Y ;input/output vars for ^%DT
 . . S X=$P(@PRCWRK@(PRCLINE,"IMEXPDT"),U)
 . . D ^%DT
 . . S $P(@PRCWRK@(PRCLINE,"IMEXPDT"),U)=$S(Y>0:Y,1:"")
 . S @PRCWRK@(PRCLINE,"IMNDC")=$G(PRCIMF(441.01,PRC441,4,"I"))_U_$G(PRCIMF(441.01,PRC441,4,"E"))
 . S @PRCWRK@(PRCLINE,"IMMIN")=$G(PRCIMF(441.01,PRC441,8,"I"))_U_$G(PRCIMF(441.01,PRC441,8,"E"))
 . S @PRCWRK@(PRCLINE,"IMMAX")=$G(PRCIMF(441.01,PRC441,8.5,"I"))_U_$G(PRCIMF(441.01,PRC441,8.5,"E"))
 . S @PRCWRK@(PRCLINE,"IMREQ")=$G(PRCIMF(441.01,PRC441,9,"I"))_U_$G(PRCIMF(441.01,PRC441,9,"E"))
 . S @PRCWRK@(PRCLINE,"IMUCF")=$G(PRCIMF(441.01,PRC441,10,"I"))_U_$G(PRCIMF(441.01,PRC441,10,"E"))
 ;
 ;cleanup ^TMP global
 K @PRCFLDS
 ;
 ;success
 S PRCRSLT=1 K PRCER
 ;
 Q PRCRSLT
