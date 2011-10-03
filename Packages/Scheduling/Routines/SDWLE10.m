SDWLE10 ;;IOFO BAY PINES/TEH - WAITING LIST-ENTER/EDIT - RETREIVE DATA;06/12/2002 ; 20 Aug 2002  2:10 PM
 ;;5.3;scheduling;**263**;AUG 13 1993
 ;
 ;
 ;******************************************************************
 ;                             CHANGE LOG
 ;                                               
 ;   DATE                        PATCH                   DESCRIPTION
 ;   ----                        -----                   -----------
 ;   
 ;   
 ;   
 ;      
 ;
EN ;RETRIEVE DATA FOR EDITING
 ;
 S SDWLDATA=$G(^SDWL(409.3,SDWLDA,0))
 S SDWLIN=$P(SDWLDATA,U,3),SDWLCL=+$P(SDWLDATA,U,4),(SDWLTYE,SDWLTY)=$P(SDWLDATA,U,5),SDWLST=$P(SDWLDATA,U,6)
 S SDWLSP=$P(SDWLDATA,U,7),SDWLSS=$P(SDWLDATA,U,8),SDWLSC=$P(SDWLDATA,U,9),SDWLPRI=$P(SDWLDATA,U,10),SDWLRB=$P(SDWLDATA,U,11)
 S SDWLPROV=$P(SDWLDATA,U,13),SDWLDAPT=$P(SDWLDATA,U,16),SDWLTT=$P(SDWLDATA,U,17),SDWLCOM=$P(SDWLDATA,U,18),SDWLDUZ=DUZ,SDWLEDT=DT
 I $D(^SDWL(409.32,+SDWLSC,0)) S SDWLSCP=$P(^SDWL(409.32,+SDWLSC,0),U,1)
 Q
