MAGGSCP ;WOIFO/GEK - Imaging RPC Broker call for CP.  
 ;;3.0;IMAGING;**7,8**;Sep 15, 2004
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 ;;
 Q
LIST(MAGRY,MAGDFN,PROC) ;RPC [MAG4 CP GET REQUESTS]
 ; Get list of CP Requests
 ; PROC = IEN FROM FILE 702.01 IF JUST ONE PROCEURE DESIRED, DEFAULTS TO ALL
 ; 
 ; The compressed listing, 4 columns  
 ; Not restructuring the output yet
 ;    "Date^Spec^Desc^Img Count^procedure info"
 N MAGX,I,ACT,NODE,TMP
 K ^TMP($J,"MAGCP")
 K ^TMP($J,"MAGCP1")
 S PROC=$G(PROC)
 ;S MAGRY=$NA(^TMP($J,"MAGCP1"))
 D CPLIST^GMRCCP(MAGDFN,PROC,$NA(^TMP($J,"MAGCP")))
 I '$D(^TMP($J,"MAGCP")) S MAGRY(0)="0^There are no Clinical Procedure Requests for Patient : "_$$GET1^DIQ(2,MAGDFN,.01) Q
 S ACT=1
 S I="" F  S I=$O(^TMP($J,"MAGCP",I)) Q:I=""  S NODE=^(I) D
 . ; screening out x - cancelled and 'dc' - discontinued 
 . I ",x,dc,"[(","_$P(NODE,U,4)_",") Q 
 . S X=$$INF(NODE)
 . S ACT=ACT+1
 . S MAGRY(ACT)=X ;S @MAGRY@(ACT)=X
 S MAGRY(1)="Date~S1^CP DEF nam^urgency^status" ;^cons #^CP DEF ien
 S MAGRY(0)=ACT-1_"^"_ACT-1_" Clinical Procedure Requests."
 Q
INF(NODE) ;
 N RY
 ; FOR NOW JUST SEND THE SAME DATA (TESTING)
 S RY=$P(NODE,U,1,4)_"|"_$P(NODE,U,5,99)
 S $P(RY,U)=$$EXTDT^MAGGSU1($P(RY,U))
 Q RY
 ;S RY=$$EXTDT^MAGGSU1($P(NODE,U,3))_U_"TIU"_U_$P(NODE,U,2)_U
 ;S RY=RY_$$IMGCT($P(NODE,U))_U_$P($P(NODE,U,5),";",2)_U
 ;S RY=RY_"|TIU^"_$P(NODE,U)
 Q RY
TIUDA(MAGRY,MAGDFN,MAGCONS,MAGVSTR,MAGCMP) ;RPC [MAG4 CP CONSULT TO TIUDA]
 ;
 K MAGRY S MAGVSTR=$G(MAGVSTR),MAGCMP=$G(MAGCMP,0)
 ; No longer sending CP the 'Complete' Flag 9/20/01 GEK
 ;D ITIU^MDAPI(.MAGRY,MAGDFN,MAGCONS,MAGVSTR,MAGCMP)
 ; CODE^DFN^MAGIEN^<computed time 'now'>^TEXT
 D ACTION^MAGGTAU("API^"_MAGDFN_"|ITIU-MDAPI Params: Cnslt#-"_MAGCONS_" vstr-"_MAGVSTR)
 D ITIU^MDAPI(.MAGRY,MAGDFN,MAGCONS,MAGVSTR)
 D ACTION^MAGGTAU("API^"_MAGDFN_"|ITIU-MDAPI Result: "_MAGRY(0))
 Q
VISITS(MAGRY,MAGDFN,MAGCONS) ;RPC [MAG4 CP GET VISITS]
 N I,MAGCT,MAGNODE,MAGI,MAGZ,MAGVISIT,DFN
 S DFN=MAGDFN
 S RESULTS="MAGVISIT"
 ; RESULTS and DFN variables are needed by MDRPCOP
 D GETVST^MDRPCOP
 I '$D(MAGVISIT(0)) S MAGRY(0)="0^ERROR: Listing visits." Q
 S I=0,MAGCT=1 F  S I=$O(MAGVISIT(I)) Q:'I  D
 . S MAGZ=MAGVISIT(I)
 . S $P(MAGNODE,"^")=$$EXTDT^MAGGSU1($P(MAGZ,"^",2)) ;Date
 . S $P(MAGNODE,"^",2,3)=$P(MAGZ,"^",3,4) ; Clinic, Status
 . S $P(MAGNODE,"|",2)=$P(MAGZ,"^",1) ; VSTRING;
 . S MAGCT=MAGCT+1,MAGRY(MAGCT)=MAGNODE
 I '$D(MAGRY) S MAGRY(0)="0^0 Visits for patient" Q
 S MAGRY(0)=$O(MAGRY(""),-1)-1_"^Visits for patient"
 S MAGRY(1)="Date~S1^Location^Status"
 Q
UPDCONS(MAGRY,MAGCONS,MAGTIU,MAGCMP) ;Update Consults;
 ; Update Consults with the Complete Flag. Consults will update
 ; it's status to 'pr' partial results.
 D ACTION^MAGGTAU("API|CPDOC-GMRCCP Params: Cnslt#-"_MAGCONS_" tiuda-"_MAGTIU_" cmpfl-"_MAGCMP)
 S MAGRY=$$CPDOC^GMRCCP(MAGCONS,MAGTIU,MAGCMP) ; MAGCMP IS 2
 Q
