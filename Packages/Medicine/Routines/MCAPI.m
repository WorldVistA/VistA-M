MCAPI ; CIOFO/MD - Print result from a medicine file
 ;;2.3;Medicine;**27**;09/13/1996
 ;;**DBIA #3042**
 ;
 ; RESULT= variable pointer to a medicine file entry
 ;         (e.g. "12;MCAR(691.5,") (required).
 ;
 ; MCFLG =1 if report to be headerless (optional)
 ;
EN(RESULT,MCFLG) ; Print result from a medicine file
 N XQY0,MCARGRTN,PR,DISTP,DILCT,NUM,NAME,PRE,TSUP2,TT,TY,HOSP,ORVP,DA,MCARGDA,OT,MCARPPS,MCPRO,DFN,RDATE,SCD
 S XQY0="",OT=$$SINGLE^MCAPI(RESULT)
 I OT="" W !,"***** BAD MEDICINE FILE POINTER  *****",! Q
 S (DA,MCARGDA)=$P(OT,U,2),MCARPPS=$P(OT,U,3,4),MCPRO=$P(OT,U,11),DFN=$P(OT,U,13),ORVP=DFN_"DPT("
 D MCPPROC^MCARP
 S MCARGRTN=$P(OT,U,5)
 D @MCARPPS
 K %I
 Q
SINGLE(RESULT) ;  Function to return info on single proceedure.
 ;
 ; RESULT = variable pointer to a medicine file
 ;          (e.g. "12;MCAR(691.5,") (required)
 ;
 N VALUE,ZNODE,S4,S5,S6,WH,DFN,J,K,L,LL,LL1,M,MCARCODE,MCARDT,MCARPROC,MCESKEY,MCESSEC,MCFILE,PR,S1,S2
 S S6=+$G(RESULT) ;ien from medicine file
 S S5=$P($P($G(RESULT),";",2),",") ;S5 is the root of the medicine file, no ^ or ,
 S ZNODE=$G(@("^"_S5_","_S6_",0)")) ;zero node from record S6 in file S5
 I $G(ZNODE)="" S VALUE="" G KILL
 D:'($G(ZNODE)="")
 . S S4=9999999.9999-($P(ZNODE,"^")) ;S4 is proceedure time/date
 . S DFN=$P(ZNODE,"^",2),WH=""
 . Q
 D CONT^MCARPS2,PR0^MCARPS2 ;return single ^TMP("MCAR",$J,"GMRC", node
 S ^TMP("MCAR",$J,"GMRC","OT",1)=$G(^TMP("OR",$J,"MCAR","OT",1)),VALUE=$S($G(^TMP("MCAR",$J,"GMRC","OT",1))'="":^TMP("MCAR",$J,"GMRC","OT",1)_"^"_DFN,1:"")
KILL K ^TMP("MCAR",$J,"GMRC"),^TMP("OR",$J,"MCAR")
 Q VALUE
