SPNPSR21 ;HIRMFO/DAD,WAA-HUNT: STATE,COUNTY ;8/1/95  14:16
 ;;2.0;Spinal Cord Dysfunction;**2**;01/02/1997
 ;
EN1(D0,SPNSTAT,SPNCOUN) ; *** Search entry point
 ; Input:
 ;  ACTION,SEQUENCE = Search ACTION,SEQUENCE number
 ;  D0       = SCD (SPINAL CORD) REGISTRY file (#154) IEN
 ;  ^TMP($J,"SPNPRT",ACTION,SEQUENCE,"STATE",IEN) = State IEN ^ State
 ;  ^TMP($J,"SPNPRT",ACTION,SEQUENCE,"COUNTY",IEN) = County IEN ^ County
 ;    SPNCOUN = COUNTY IEN
 ;    SPNSTAT = STATE IEN
 ; Output:
 ;  $S( D0_Meets_Search_Criteria : 1 , 1 : 0 )
 ;
 N STATE,COUNTY,DFN,I,MEETSRCH,VA,VADM,VAERR
 S MEETSRCH=0
 S DFN=+$P($G(^SPNL(154,+D0,0)),U)
 D ADD^VADPT
 I 'VAERR D
 . S STATE=+$G(VAPA(5)) Q:'STATE
 . I STATE'=SPNSTAT Q
 . S COUNTY=+$G(VAPA(7)) Q:'COUNTY
 . I COUNTY'=SPNCOUN Q
 . S MEETSRCH=1
 . Q
 Q MEETSRCH
 ;
EN2(ACTION,SEQUENCE) ; *** Prompt entry point
 ; Input:
 ;  ACTION,SEQUENCE = Search ACTION,SEQUENCE number
 ; Output:
 ;  SPNLEXIT = $S( User_Abort/Timeout : 1 , 1 : 0 )
 ;  ^TMP($J,"SPNPRT",ACTION,SEQUENCE,"STATE",IEN) = State IEN ^ State
 ;  ^TMP($J,"SPNPRT",ACTION,SEQUENCE,"COUNTY",IEN) = County IEN ^ County
 ;  ^TMP($J, "SPNPRT",ACTION,SEQUENCE,0) = $$EN1^SPNPSR21(D0,STATE,COUNTY)
 ;
 ; Select the state
 N STATE,COUNTY,DTOUT,DUOUT
 S SPNLEXIT=0 D  Q:SPNLEXIT!(Y<1)
 .N DIC
 .S DIC="^DIC(5,",DIC(0)="AEMQ" D ^DIC
 .I $D(DTOUT)!($D(DUOUT)) S SPNLEXIT=1 Q
 .Q:Y<1
 .S STATE=Y
 .Q
 I '$D(STATE) W !,"You must select a STATE to sort by inorder to use this sort.",$C(7) Q
 I 'SPNLEXIT,Y'="" D  Q:SPNLEXIT
 .N DIC
 .S DIC="^DIC(5,"_+STATE_",1,",DIC(0)="AEQ" D ^DIC
 .I $D(DTOUT)!($D(DUOUT)) S SPNLEXIT=1 Q
 .Q:Y<1
 .S COUNTY=Y
 I '$D(COUNTY) W !,"You must select a county to sort by inorder to use this sort.",$C(7) Q
 I 'SPNLEXIT D
 .S ^TMP($J,"SPNPRT",ACTION,SEQUENCE,"STATE",+STATE)=STATE
 .S ^TMP($J,"SPNPRT",ACTION,SEQUENCE,"COUNTY",+COUNTY)=COUNTY
 .S ^TMP($J,"SPNPRT",ACTION,SEQUENCE,0)="$$EN1^SPNPSR21(D0,"_+STATE_","_+COUNTY_")"
 .Q
 Q
