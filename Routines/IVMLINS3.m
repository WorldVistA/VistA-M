IVMLINS3 ;ALB/KCL,TDM - IVM INSURANCE POLICY TRANSFER ; 3/9/09 2:01pm
 ;;2.0;INCOME VERIFICATION MATCH;**14,111,121**; 21-OCT-94;Build 45
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
TRANSFER(IVMAUTO) ; user has chosen to transfer insurance information,
 ; received from HEC, to the MCCR insurance buffer.  this routine
 ; will call $$ADDSTF^IBCNBES(3,DFN,IVMIBDAT) to place HEC's insurance
 ; information in the MCCR insurance buffer where authorized insurance
 ; personnel will either upload or reject the data.
 ;      3 indicates that source of information is IVM
 ;      IVMIBDAT = data, to be filed in the MCCR buffer, in an array
 ;                 subscripted by field number of the data field in
 ;                 the INSURANCE BUFFER file (#355.33) 
 ; INPUT: IVMAUTO = 1 if auto-filing directly from upload
 ;                  0 if using list manager interface to file
 ;        THE FOLLOWING ARE ASSUMED TO BE DEFINED:
 ;          IVMIN1 (ST/ST1 segment string nodes of file 301.5)
 ;          IVMADD (5th "^" piece of IVMIN1 for ins co address data)
 ;
 N IVMIB,IVMIBDAT,IVMNOI,IVMPRTI
 ;
 I '$G(IVMAUTO) W !!,"Transferring HEC'S insurance data to the MCCR insurance buffer",!
 S IVMNOI=$S($P(IVMIN1,HLFS,17)="v":$P($$PT^IVMUFNC4(DFN),"^"),1:$P(IVMIN1,HLFS,16))
 S IVMPRTI=$S($P(IVMIN1,HLFS,17)="v":"01",1:"02")
 ;
 S IVMIBDAT(20.01)=$E($P(IVMIN1,HLFS,4),1,30) ;ins co name
 S IVMIBDAT(20.02)=$E($P(IVMIN1,HLFS,7),1,20) ;phone number
 S IVMIBDAT(21.01)=$E($P(IVMADD,"~",1),1,35) ;street add [line 1]
 S IVMIBDAT(21.02)=$E($P(IVMADD,"~",2),1,30) ;street add [line 2]
 S IVMIBDAT(21.03)=$E($P(IVMADD,"~",8),1,30) ;street add [line 3]
 S IVMIBDAT(21.04)=$E($P(IVMADD,"~",3),1,25) ;city
 S IVMIBDAT(21.05)=$$STATE1^IVMUFNC4($P(IVMADD,"~",4)) ;state
 S IVMIBDAT(21.06)=$E($P(IVMADD,"~",5),1,20) ;zip
 S IVMIBDAT(40.02)=$E($P(IVMIN1,HLFS,9),1,20) ;group name
 S IVMIBDAT(40.03)=$E($P(IVMIN1,HLFS,8),1,17) ;group number
 S IVMIBDAT(40.05)=$S($P(IVMIN1,HLFS,28)=1:1,1:0) ;precertification required
 S IVMIBDAT(40.09)=$P(IVMIN1,HLFS,15) ;type of plan
 S IVMIBDAT(60.01)=DFN ;patient name
 S IVMIBDAT(60.02)=$$FMDATE^HLFNC($P(IVMIN1,HLFS,12)) ;effective date
 S IVMIBDAT(60.03)=$$FMDATE^HLFNC($P(IVMIN1,HLFS,13)) ;expiration date
 S IVMIBDAT(60.04)=$E($P(IVMIN1,HLFS,36),1,20) ;subcriber id
 S IVMIBDAT(60.05)=$P(IVMIN1,HLFS,17) ;whose insurance
 S IVMIBDAT(60.06)=IVMPRTI ;pt relationship to insured
 S IVMIBDAT(60.07)=IVMNOI ;name of insured
 ;
 S IVMIB=$$ADDSTF^IBCNBES(3,DFN,.IVMIBDAT)
 I 'IVMIB D  Q
 .Q:$G(IVMAUTO)
 .W !,"The following error occurred when transferring data:"
 .W !,$P(IVMIB,"^",2)
 .W !,"Please contact your IRM staff for help"
 ;
 N DA,DIE,DR
 S DA=IVMJ,DA(1)=IVMI
 ;
 ; - delete segment name (.02 field of 301.501 multiple) from IVM PATIENT
 ;   file to remove from ASEG cross-reference
 S DIE="^IVM(301.5,"_DA(1)_",""IN"",",DR=".02////@" D ^DIE
 ;
 I $G(IVMAUTO) G IVMQ
 ;
 W "completed.",!
 ;
 S DIR(0)="E",DIR("A")="Press RETURN to continue" D ^DIR K DIR
 ;
REMOVE ; - remove entry from the List Manager display after transferring
 K ^TMP("IVMIUPL",$J,IVMNAME,IVMI,IVMJ)
 ;
 ; - action completed
 S IVMDONE=1
 ;
IVMQ K DIRUT,DTOUT,DUOUT,IVMACT,IVMDA,IVMFLAG,IVMREPTR,X,Y
 Q
 ;
AUTO ; Auto-upload all Z04 entries pending in file 301.501
 ; Called by the patch IVM*2*111 post-install
 N DFN,IVMI,IVMJ,IVMIN1,IVMADD,IVM0NOD,HLFS
 S HLFS=U
 ;
 S IVMI=0 F  S IVMI=$O(^IVM(301.5,"ASEG","IN1",IVMI)) Q:'IVMI  D
 . S IVMJ=0 F  S IVMJ=$O(^IVM(301.5,"ASEG","IN1",IVMI,IVMJ)) Q:'IVMJ  D
 .. S IVM0NOD=$G(^IVM(301.5,IVMI,0)) I IVM0NOD']"" Q
 .. S DFN=+IVM0NOD
 .. I $G(^DPT(+DFN,0))']"" Q
 .. Q:$P($G(^IVM(301.5,IVMI,"IN",IVMJ,0)),U,2)'="IN1"
 .. S IVMIN1=$$GETIN1^IVMLINS1(IVMI,IVMJ)
 .. Q:IVMIN1=""
 .. S IVMADD=$P(IVMIN1,U,5)
 .. D TRANSFER(1)
 ;
 Q
 ;
