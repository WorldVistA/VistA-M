ECU1RPC ;ALB/ACS;Event Capture Spreadsheet Utilities ;07 Aug 01
 ;;2.0; EVENT CAPTURE ;**25,30,49,61**;8 May 96
 ;
 ;-----------------------------------------------------------------------
 ;
 ;INPUT     ECDATA  - Contains column headers or a row of Event Capture
 ;                    spreadshet data
 ;
 ;
 ;OTHER     ^TMP($J,"COLS" array will store the column header order
 ;
 ;-----------------------------------------------------------------------
 ;=======================================================================
 ;MODIFICATIONS:
 ;
 ;08/2001    EC*2.0*30   Changed column header from 'Station' to
 ;                       'Location'.
 ;=======================================================================
 ;
ECHDRS(ECDATA) ;
 ;
 ;--kill temporary file
 K ^TMP($J,"COLS")
 N PIECENUM,NUMCOLS
 ;
 ; --Set up column header order
 S NUMCOLS=$L(ECDATA,U)
 ;
 ; --Remove first piece "COLHEADERS" from colum header string--
 S ECDATA=$P(ECDATA,U,2,NUMCOLS)
 S NUMCOLS=$L(ECDATA,U)
 ;
 ; --Spin through each piece in string and assign 'piece' value 
 F PIECENUM=1:1 Q:PIECENUM>NUMCOLS  D
 . S DATA=$P(ECDATA,U,PIECENUM)
 . I DATA["Record Num" S ECRECPC=PIECENUM Q
 . I DATA["Location" S ECSTAPC=PIECENUM Q
 . I DATA["SSN" S ECSSNPC=PIECENUM Q
 . I DATA["Pat LName" S ECPATLPC=PIECENUM Q
 . I DATA["Pat FName" S ECPATFPC=PIECENUM Q
 . I DATA["Unit Name" S ECDSSPC=PIECENUM Q
 . I DATA["Unit Num" S ECDCMPC=PIECENUM Q
 . I DATA["Unit IEN" S ECUNITPC=PIECENUM Q
 . I DATA["Proc" S ECPROCPC=PIECENUM Q
 . I DATA["Volume" S ECVOLPC=PIECENUM Q
 . I DATA["Ordering Sect" S ECOSPC=PIECENUM Q
 . I DATA["Prov" S ECPRVLPC=PIECENUM Q
 . I DATA["Date/Time" S ECENCPC=PIECENUM Q
 . I DATA["Category" S ECCATPC=PIECENUM Q
 . I DATA["Diag" S ECDXPC=PIECENUM Q
 . I DATA["Assoc Clin" S ECCLNPC=PIECENUM Q
 . ;
 . I DATA["Pat Stat" S ECPSTATV=+DATA Q
 . I DATA["Override Deceased" S ECDECPAT=+DATA Q
 . I DATA["Override Duplicate" S ECFILDUP=+DATA
 ; 
 ;--Move column header piece numbers into Temp file ^TMP($J,"COLS")
 ;   for future reference
 ;
 K ^TMP($J,"COLS")
 S ^TMP($J,"COLS","ECRECPC")=ECRECPC
 S ^TMP($J,"COLS","ECSTAPC")=ECSTAPC
 S ^TMP($J,"COLS","ECSSNPC")=ECSSNPC
 S ^TMP($J,"COLS","ECPATLPC")=ECPATLPC
 S ^TMP($J,"COLS","ECPATFPC")=ECPATFPC
 S ^TMP($J,"COLS","ECDSSPC")=ECDSSPC
 S ^TMP($J,"COLS","ECDCMPC")=ECDCMPC
 S ^TMP($J,"COLS","ECUNITPC")=ECUNITPC
 S ^TMP($J,"COLS","ECPROCPC")=ECPROCPC
 S ^TMP($J,"COLS","ECVOLPC")=ECVOLPC
 S ^TMP($J,"COLS","ECOSPC")=ECOSPC
 S ^TMP($J,"COLS","ECPRVLPC")=ECPRVLPC
 S ^TMP($J,"COLS","ECENCPC")=ECENCPC
 S ^TMP($J,"COLS","ECCATPC")=ECCATPC
 S ^TMP($J,"COLS","ECDXPC")=ECDXPC
 S ^TMP($J,"COLS","ECCLNPC")=ECCLNPC
 S ^TMP($J,"COLS","ECPSTATV")=ECPSTATV
 S ^TMP($J,"COLS","ECDECPAT")=ECDECPAT
 S ^TMP($J,"COLS","ECFILDUP")=ECFILDUP
 ;
 Q
 ;
GETDATA(ECDATA) ;
 ;
 ;--Get data piece numbers and uploaded data values
 S ECRECPC=$G(^TMP($J,"COLS","ECRECPC"))
 S ECRECV=$P(ECDATA,U,ECRECPC)
 ;
 S ECSTAPC=$G(^TMP($J,"COLS","ECSTAPC"))
 S ECSTAV=$P(ECDATA,U,ECSTAPC)
 ;
 S ECSSNPC=$G(^TMP($J,"COLS","ECSSNPC"))
 I ECSSNPC S ECSSNV=$P(ECDATA,U,ECSSNPC)
 ;
 S ECPATLPC=$G(^TMP($J,"COLS","ECPATLPC"))
 S ECPATLV=$P(ECDATA,U,ECPATLPC)
 ;
 S ECPATFPC=$G(^TMP($J,"COLS","ECPATFPC"))
 S ECPATFV=$P(ECDATA,U,ECPATFPC)
 ; --concatenate patient name into one string, comma separated
 S ECPATV=ECPATLV_","_ECPATFV
 ;
 S ECDSSPC=$G(^TMP($J,"COLS","ECDSSPC"))
 S ECDSSV=$P(ECDATA,U,ECDSSPC)
 ;
 S ECDCMPC=$G(^TMP($J,"COLS","ECDCMPC"))
 S ECDCMV=$P(ECDATA,U,ECDCMPC)
 ;
 S ECUNITPC=$G(^TMP($J,"COLS","ECUNITPC"))
 S ECUNITV=$P(ECDATA,U,ECUNITPC)
 ;
 S ECPROCPC=$G(^TMP($J,"COLS","ECPROCPC"))
 S ECPROCV=$P(ECDATA,U,ECPROCPC)
 ;
 S ECVOLPC=$G(^TMP($J,"COLS","ECVOLPC"))
 S ECVOLV=$P(ECDATA,U,ECVOLPC)
 ;
 S ECOSPC=$G(^TMP($J,"COLS","ECOSPC"))
 S ECOSV=$P(ECDATA,U,ECOSPC)
 ;
 S ECPRVLPC=$G(^TMP($J,"COLS","ECPRVLPC"))
 S ECPROVV=$P(ECDATA,U,ECPRVLPC)
 ;
 S ECENCPC=$G(^TMP($J,"COLS","ECENCPC"))
 S ECENCV=$P(ECDATA,U,ECENCPC),ECENCV=$TR(ECENCV," ","")
 ;
 S ECCATPC=$G(^TMP($J,"COLS","ECCATPC"))
 S ECCATV=$P(ECDATA,U,ECCATPC)
 ;
 S ECDXPC=$G(^TMP($J,"COLS","ECDXPC"))
 S ECDXV=$P(ECDATA,U,ECDXPC)
 ;
 S ECCLNPC=$G(^TMP($J,"COLS","ECCLNPC"))
 S ECCLNV=$P(ECDATA,U,ECCLNPC)
 ;
 S ECPSTATV=$G(^TMP($J,"COLS","ECPSTATV"))
 ;
 S ECDECPAT=$G(^TMP($J,"COLS","ECDECPAT"))
 ;
 S ECFILDUP=$G(^TMP($J,"COLS","ECFILDUP"))
 ;
END Q
