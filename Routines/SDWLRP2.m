SDWLRP2 ;;IOFO BAY PINES/TEH - WAITING LIST - RPC 2;06/28/2002 ; 20 Aug 2002  2:10 PM
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
OUTIN(SDWLOUT) ;List entries in INSTITUTION file (#4)
 ;
 ;  Output:
 ;     SDWLOUT - The return reference
 ;       
 ;         ^TMP("SDWLRP2",$J,INSTITUTION IEN)=ZERO NODE DATA
 ;
 N SDWL1,SDWL2,SDWL3
 K ^TMP("SDWLRP2",$J)
 S U="^",SDWL1="" F  S SDWL1=$O(^DIC(4,"B",SDWL1)) Q:SDWL1=""  D
 .S SDWL2="" F  S SDWL2=$O(^DIC(4,"B",SDWL1,SDWL2)) Q:SDWL2=""  D
 ..S SDWL3=$G(^DIC(4,SDWL2,0)),^TMP("SDWLRP2",$J,SDWL1,SDWL2)=SDWL1_U_SDWL3
 S SDWLOUT=$NA(^TMP("SDWLRP2",$J))
 Q
OUTSC0(SDWLOUT) ;List entries in CLINIC file (#409.32) - No Screen
 ;
 ;   Output:
 ;      SDWLOUT = ^TMP("DILIST",$J)
 ;      
 ;      IEN^
 ;
 N DIERR
 D LIST^DIC(409.32,,".01;","PS")
 I $G(DIERR) D CLEAN^DILF S RESULT=0 Q
 K SDWLOUT S SDWLOUT=$NA(^TMP("DILIST",$J))
 Q
OUTSC1(SDWLOUT,SDWLIN) ;List entries in CLINIC file (#409.32) - Screen with Institution
 ;
 ;   Output:
 ;      SDWLOUT = ^TMP("DILIST",$J)
 ;      
 ;      IEN^
 ;      
 N SDWLDA,SDWLIN,SDWLSCR,DIERR
 S SDWLSCR="I $P(^(0),U,6)=SDWLIN"
 S SDWLDA=0 F  S SDWLDA=$O(^SDWL(409.32,SDWLDA)) Q:SDWLDA<1  D
 .S SDWLDAX="`"_SDWLDA
 .D LIST^DIC(409.32,,".01;.02IE;1IE;2;3;4","PS",500,.SDWLDAX,,,.SDWLSCR)
 I $G(DIERR) D CLEAN^DILF S RESULT=0 Q
 K SDWLOUT,SDWLDA,SDWLIN,SDWLSCR S SDWLOUT="^TMP(""DILIST"","_$J_")"
 Q
OUTSC2(SDWLOUT) ;List entries in HOSPITAL LOCATION FILE (#44)
 ;
 ;   Output:
 ;      SDWLOUT = ^TMP("DILIST",$J)
 ;      
 ;      IEN^
 ;
 N DIERR
 S SDWLSCR="I $E($P(^DIC(4,+Y,0),U,1),1,2)'=""ZZ"""
 S SDWLDA=0 F  S SDWLDA=$O(^SC(SDWLDA)) Q:SDWLDA<1  D
 .S SDWLDAX="`"_SDWLDA
 .D LIST^DIC(44,,".01","PS",500,.SDWLDAX,,,.SDWLSCR)
 I $G(DIERR) D CLEAN^DILF S RESULT=0 Q
 K SDWLOUT,SDWLDA S SDWLOUT=$NA(^TMP("DILIST",$J))
 Q
OUTST(SDWLOUT) ;List entries in Team File (#404.51)
 ;
 ;   Output:
 ;      SCDWLOUT = ^TMP("DILIST",$J)
 ;      
 ;      IEN^NAME
 ;       1   2
 N DIERR
 D LIST^DIC(404.51,,".01;","PS")
 I $G(DIERR) D CLEAN^DILF S RESULT=0 Q
 K SDWLOUT,SDWLDA S SDWLOUT=$NA(^TMP("DILIST",$J))
 Q
OUTSP(SDWLOUT) ;List entries in TEAM POSITION FILE (#404.57)
 ;
 ;   Output:
 ;      SCDWLOUT = ^TMP("DILIST",$J)
 ;      
 ;      IEN^NAME
 ;       1   2
 N DIERR
 D LIST^DIC(404.57,,"@;.01;","PS")
 I $G(DIERR) D CLEAN^DILF S RESULT=0 Q
 K SDWLOUT,SDWLDA S SDWLOUT=$NA(^TMP("DILIST",$J))
 Q
OUTSS(SDWLOUT) ;List entries in WL SERVICE/SPECIALTY file (#409.31)
 ;
 ;   Output:
 ;      SCDWLOUT = ^TMP("DILIST",$J)
 ;      
 ;      IEN^NAME
 ;       1   2
 N DIERR
 D LIST^DIC(409.31,,"@;.01;","PS")
 I $G(DIERR) D CLEAN^DILF S RESULT=0 Q
 K SDWLOUT,SDWLDA S SDWLOUT=$NA(^TMP("DILIST",$J))
 Q
OUTPROV(SDWLOUT) ;List entries in NEW PERSON FILE (#200) - Screen by Class
 ;
 ;   Output:
 ;      SCDWLOUT = ^TMP("DILIST",$J)
 ;      
 ;      IEN^NAME
 ;       1   2
 ;       
 N SDWLDA,SDWLSCR,DIERR S SDWLSCR=""
 S SDWLDA=0 F  S SDWLDA=$O(^SCTM(404.51,SDWLDA)) Q:SDWLDA<1  D
 .S SDWLDAX="`"_SDWLDA
 .D LIST^DIC(404.51,,".01;","PS",,.SDWLDAX)
 I $G(DIERR) D CLEAN^DILF S RESULT=0 Q
 K SDWLOUT,SDWLDA S SDWLOUT=$NA(^TMP("DILIST",$J))
 Q
OUTSITE(SDWLOUT) ;return site name and number
 ;
 ;       Output
 ;         SDWLOUT = SITE NAME^IE
 S U="^"
 S SDWLOUT=$P(^DIC(4,+$G(^DD("SITE",0)),0),U)_U_$G(^DD("SITE",0))
 Q SDWLOUT
