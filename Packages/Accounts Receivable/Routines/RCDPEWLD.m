RCDPEWLD ;ALB/CLT - Continuation of routine RCDPEWL0 ;12 DEC 2007
 ;;4.5;Accounts Receivable;**252**;Mar 20, 1995;Build 63
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
PROV(RCSCR,RCSCR1,RCXM1,RC) ;Get prov data from ERA (FILE 344.4) and claim (FILE 399)
 N RCXXX,RCYYY,RCDPEPV,RCCLAIM,RCIEN,RCBILL,RCID,RCBLANK,RCNPI,DIC,X,Y
 N RCPROV,RCEXP,XUSNPI,RCRTN,RCBNM,RCCOM1,RCCOM2,RCWARN,RCYNODE3
 ;
 S RCBLANK="" F X=1:1:30 S RCBLANK=RCBLANK_" "
 S RC=RC+1 S RCXM1(RC-1)=RCBLANK
 S RCYNODE3=$G(^RCY(344.4,RCSCR,1,RCSCR1,3))
 ;
LKBOX ;Get provider data from ELECTRONIC REMITTANCE ADVICE file (#344.4)
 S RC=RC+1,RCXM1(RC-1)=$E("**EOB PROVIDER(S)/NPI"_$J(" ",39),1,39)_"CLAIM PROVIDER(S)/NPI**"  ;setting sub-header for worklist
 S RC=RC+1,RCXM1(RC-1)=$E("---------------------"_$J(" ",39),1,39)_"-----------------------"
 ;
 S RCPROV="BILLING",$P(RCYYY(RCPROV),U,3)=0        ; piece 3 initialize for error msgs
 I $P(RCYNODE3,U)'="" S RCYYY(RCPROV)="/"_$P(RCYNODE3,U)   ; Billing Prov NPI 
 ;
 S RCPROV="RENDERING"
 I $P(RCYNODE3,U,3)=2 S RCPROV="SERVICING"
 I $P(RCYNODE3,U,3)="",($P(RCYNODE3,U,4)'[","),($P(RCYNODE3,U,4)'="") S RCPROV="SERVICING"
 I $P(RCYNODE3,U,2)'=""!($P(RCYNODE3,U,4)'="") S RCYYY(RCPROV)=$E($P(RCYNODE3,U,4),1,20)_"/"_$P(RCYNODE3,U,2)
 S $P(RCYYY(RCPROV),U,3)=0                          ; initialize for error msgs
 D NPICHK        ; RCPROV has to be "RENDERING" or "SERVICING" when this tag is called !
 ;
CLAIM ;Retrieve provider data from the claim
 S RCCLAIM=$$GET1^DIQ(361.1,$P(^RCY(344.4,RCSCR,1,RCSCR1,0),U,2),.01) ;determine claim num based on entry in 344.4
 S DIC="^DGCR(399,",DIC(0)="",X=RCCLAIM D ^DIC S RCCLAIM=+Y      ;find ien for file 399
 D GETS^DIQ(399,RCCLAIM,"222*","IE","RCXXX")         ;retrieve prov information
 S RCBILL=$$GET1^DIQ(399,RCCLAIM,.22,"I")            ;retrieve default division
 S RCBNM=$$GET1^DIQ(4,$$GET1^DIQ(40.8,RCBILL,.07,"I"),.01)  ;get name from institution file
 S RCBILL=$$GET1^DIQ(4,$$GET1^DIQ(40.8,RCBILL,.07,"I"),41.99)  ;get NPI from institution file
 ;
 S $P(RCYYY("BILLING"),U,2)=RCBNM_"/"_RCBILL_"^"_0  ;NPI set into local array
 I $D(RCXXX) S RCPROV="" F  S RCPROV=$O(RCXXX(399.0222,RCPROV)) Q:RCPROV=""  D  ;loop through claim providers
 . S RCIEN=$P(RCXXX(399.0222,RCPROV,.02,"I"),";",1)
 . S RCID=$S($P(RCXXX(399.0222,RCPROV,.02,"I"),";",2)["VA(200":"Individual_ID",1:"Non_VA_Provider_ID")
 . S RCNPI=$$NPI^XUSNPI(RCID,RCIEN)                  ;retrieve provider NPI
 . S $P(RCYYY(RCXXX(399.0222,RCPROV,.01,"E")),U,2)=$E(RCXXX(399.0222,RCPROV,.02,"E"),1,20)_"/"_$S(+RCNPI=0:"No NPI on file",+RCNPI=-1:"Can't look up NPI",1:+RCNPI)
 . S:$P(RCYYY(RCXXX(399.0222,RCPROV,.01,"E")),U,3)="" $P(RCYYY(RCXXX(399.0222,RCPROV,.01,"E")),U,3)=0
LINESET ;SET THE PRINT LINES
 S (RCWARN,RCPROV)="" F  S RCPROV=$O(RCYYY(RCPROV)) Q:RCPROV=""  D  ;loop through the found provider types
 . S RC=RC+1                                          ;increment line counter
 . ; build display detail line
 . S RCXM1(RC-1)=RCPROV_": "_$P(RCYYY(RCPROV),U,1)
 . I $L(RCXM1(RC-1))>39 D
 .. S RCXM1(RC-1)=$E($P(RCXM1(RC-1),"/"),1,27)_"/"_$P(RCXM1(RC-1),"/",2)
 . S RCXM1(RC-1)=$E(RCXM1(RC-1)_RCBLANK,1,39)_$P(RCYYY(RCPROV),U,2)
 . I $P(RCYYY(RCPROV),U,3)'=0 S RCWARN=$P(RCYYY(RCPROV),U,3)
 I RCWARN'="" D
 . S RC=RC+1,RCXM1(RC-1)=" "                          ;Blank line for separation
 . S RC=RC+1,RCXM1(RC-1)="Rendering/Servicing Provider NPI Warning:"
 . S RC=RC+1,RCXM1(RC-1)=RCWARN
 S RC=RC+1,RCXM1(RC-1)=" "                            ;Blank line to separate from possible comments
 S RCCOM1=$P(RCYNODE3,U,5),RCCOM2=$P(RCYNODE3,U,6) D  ;Error in NPI format
 . I $G(RCCOM1)'="" S RC=RC+1,RCXM1(RC-1)=RCCOM1
 . I $G(RCCOM2)'="" S RC=RC+1,RCXM1(RC-1)=RCCOM2
 Q
 ;
NPICHK ;CHECK THAT THE NPI RETURNED MATCHES THE ENTITY TYPE QUALIFIER
 S RCEXP="" Q:$P(RCYNODE3,U,3)=""               ; ENTITY TYPE QUALIFIER
 ;
 S RCCOM2=$P(RCYNODE3,U,6) ; Ren/Serv comment
 S XUSNPI=$P(RCYNODE3,U,2)
 I RCCOM2="",(XUSNPI="") S RCEXP="**NO SERVICING/RENDERING NPI INCLUDED IN 835**" D EXPSET Q
 S RCRTN=$$QI^XUSNPI(XUSNPI)
 I $P(RCRTN,U,1)="Individual_ID" D  Q
 . I $P(RCYNODE3,U,3)'=1 S RCEXP="**NPI from 835 indicated organizational but is associated with an individual**" D EXPSET Q
 I $P(RCRTN,U,1)="Organization_ID" D  Q
 . I $P(RCYNODE3,U,3)'=2 S RCEXP="**NPI from 835 indicated individual but is associated with an organization**" D EXPSET Q
 I $E($P(RCRTN,U,1),1,3)="Non" D  Q
 . N RCIEN,RCTYPE S RCIEN=$P(RCRTN,U,2),RCTYPE=$$GET1^DIQ(355.93,RCIEN,.02,"I") Q:$G(RCTYPE)=""
 . I $P(RCYNODE3,U,3)=1,RCTYPE=1 S RCEXP="**NPI from 835 indicated individual but is associated with an organization**" D EXPSET Q
 . I $P(RCYNODE3,U,3)=2,RCTYPE=2 S RCEXP="**NPI from 835 indicated organizational but is associated with an individual**" D EXPSET Q
 I RCCOM2="",(+RCRTN=0) S RCEXP="**The NPI returned on the 835 is not associated with this VistA system**" D EXPSET Q
 Q
 ;
EXPSET ;SET THE PRINT LINE WITH THE ERROR AS DEFINED IN RCEXP
 S $P(RCYYY(RCPROV),U,3)=RCEXP
 Q
 ;
PARAMS(RCQUIT) ;PARAMETERS ENTRY CONTINUED FROM RCDPEWL0
 I $G(RCQUIT) K ^TMP("RCERA_PARAMS",$J)
PARMSQ ;
 Q
