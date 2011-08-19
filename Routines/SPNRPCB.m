SPNRPCB ;SD/WDE - Returns Radiology Report / Impression / Clinical history text;JUL 01, 2008
 ;;3.0;Spinal Cord Dysfunction;;OCT 01,2006;Build 39
 ;
 ;
 ;dbia reference  IA# 2479 
 ;       
COL(RESULTS,SPNRAIEN,SPNTYPE) ;
 ;  Input:
 ;  SPNRAIEN is the ien in ^RARPT
 ;  SPNTYPE is either R,I or H. 
 ;  Report / Impression /  additional clinical history.
 ;       ;FIELDS R;0   200  REPORT TEXT
 ;           I;0   300  IMPRESSION TEXT
 ;           H;0   400  ADDITIONAL CLINICAL HISTORY
 ; 
 ;K SPNDATA,SPNLINE,SPNTEMP
 ;D GETS^DIQ(74,SPNRAIEN,"**","","SPNTEMP")
 ;S SPNTYP=$S(SPNTYPE="R":200,SPNTYPE="I":300,SPNTYPE="H":400,1:"0")
 ;S SPNRAIEN=""_SPNRAIEN_","
 ;S SPNLINE=0 F  S SPNLINE=$O(SPNTEMP(74,SPNRAIEN,SPNTYP,SPNLINE)) Q:(SPNLINE="")!('+SPNLINE)  D
 ;.S RESULTS(SPNLINE)=$G(SPNTEMP(74,SPNRAIEN,SPNTYP,SPNLINE))_U_"EOL999"
 N FIELD,I,IENS,SPNTEMP
 K RESULTS
 S FIELD=$S(SPNTYPE="R":200,SPNTYPE="I":300,SPNTYPE="H":400,1:0)
 Q:FIELD'>0
 S IENS=SPNRAIEN_","
 D GETS^DIQ(74,IENS,FIELD,,"SPNTEMP")
 S I=0
 F  S I=$O(SPNTEMP(74,IENS,FIELD,I))  Q:I'>0  D
 . S RESULTS(I)=SPNTEMP(74,IENS,FIELD,I)_U_"EOL999"
 Q
 ;NEW RESULTS
 ;IEN=1751
 ;TYPE=H
 ;RESULTS(1)="1.  Recent fx. s/p for crush injuries.  ^EOL999"
 ;RESULTS(2)=" ^EOL999"
 ;RESULTS(3)="2.  fx rt fifth MT bone.  ^EOL999"
 ;RESULTS(4)=" ^EOL999"
 ;RESULTS(5)="3.  Routine.  ^EOL999"
 ;
EXIT ;
 ;K SPNLINE,SPNTEMP,SPNRAIEN,SPNTYP
 Q
 ;OLD(RESULTS,RADEXAM,TYPE)      ;
 ;  Input:
 ;  radexam is the ien in ^RARPT
 ;  type is either R,I or H. 
 ;  Report / Impression /  additional clinical history.
 ;
 ;
 ;S LINE=0 F  S LINE=$O(^RARPT(RADEXAM,TYPE,LINE))  Q:(LINE="")!('+LINE)  D
 ;.S RESULTS(LINE)=$G(^RARPT(RADEXAM,TYPE,LINE,0))_U_"EOL999"
 ;Q
 ;OLD RESULTS BEFORE USING DBIA 12-19-2006
 ;THIS IS IN HERE JUST FOR EXAMPLE ONLY TO LOOK AT OLD AND NEW
 ;RESULTS(1)="1.  Recent fx. s/p for crush injuries.  ^EOL999"
 ;RESULTS(2)=" ^EOL999"
 ;RESULTS(3)="2.  fx rt fifth MT bone.  ^EOL999"
 ;RESULTS(4)=" ^EOL999"
 ;RESULTS(5)="3.  Routine.  ^EOL999"
